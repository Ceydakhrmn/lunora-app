// =============================================
// screens/social/social_screen.dart
// Social tab with two sub-tabs:
//   • Latest  — createdAt DESC
//   • Popular — current month, likeCount DESC
// Features: infinite scroll, pull-to-refresh, FAB → create post sheet,
// per-card actions (edit/delete/report), navigation to PostDetailScreen.
// =============================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../models/post.dart';
import '../../models/post_report.dart';
import '../../services/post_service.dart';
import 'create_post_sheet.dart';
import 'post_detail_screen.dart';
import 'widgets/post_card.dart';
import 'widgets/report_sheet.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sosyal'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'En Yeni'),
              Tab(text: 'Popüler'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _FeedList(mode: _FeedMode.latest),
            _FeedList(mode: _FeedMode.popularThisMonth),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () async {
            final created = await showCreatePostSheet(context);
            if (created == true) {
              // Feeds re-trigger via user action; nothing else needed.
            }
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

enum _FeedMode { latest, popularThisMonth }

class _FeedList extends StatefulWidget {
  const _FeedList({required this.mode});

  final _FeedMode mode;

  @override
  State<_FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<_FeedList>
    with AutomaticKeepAliveClientMixin {
  final _service = PostService();
  final _scrollCtrl = ScrollController();

  final List<Post> _posts = [];
  DocumentSnapshot<Map<String, dynamic>>? _lastDoc;
  bool _initialLoading = true;
  bool _loadingMore = false;
  bool _hasMore = true;
  String? _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
    _loadFirstPage();
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >
            _scrollCtrl.position.maxScrollExtent - 300 &&
        !_loadingMore &&
        _hasMore) {
      _loadMore();
    }
  }

  Future<PagedPosts> _fetch({DocumentSnapshot<Map<String, dynamic>>? after}) {
    switch (widget.mode) {
      case _FeedMode.latest:
        return _service.fetchLatest(startAfter: after);
      case _FeedMode.popularThisMonth:
        return _service.fetchPopularThisMonth(startAfter: after);
    }
  }

  Future<void> _loadFirstPage() async {
    setState(() {
      _initialLoading = true;
      _error = null;
    });
    try {
      final result = await _fetch();
      if (!mounted) return;
      setState(() {
        _posts
          ..clear()
          ..addAll(result.posts);
        _lastDoc = result.lastDoc;
        _hasMore = result.hasMore;
        _initialLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Yüklenemedi: $e';
        _initialLoading = false;
      });
    }
  }

  Future<void> _refresh() async {
    try {
      final result = await _fetch();
      if (!mounted) return;
      setState(() {
        _posts
          ..clear()
          ..addAll(result.posts);
        _lastDoc = result.lastDoc;
        _hasMore = result.hasMore;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Yenileme başarısız: $e');
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore || _lastDoc == null) return;
    setState(() => _loadingMore = true);
    try {
      final result = await _fetch(after: _lastDoc);
      if (!mounted) return;
      setState(() {
        _posts.addAll(result.posts);
        _lastDoc = result.lastDoc ?? _lastDoc;
        _hasMore = result.hasMore;
      });
    } catch (_) {
      // swallow — user can try again by scrolling
    } finally {
      if (mounted) setState(() => _loadingMore = false);
    }
  }

  Future<void> _handleDelete(Post post) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Postu Sil'),
        content: const Text('Bu paylaşımı silmek istediğine emin misin?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text(
              'Sil',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _service.deletePost(post.id);
      if (!mounted) return;
      setState(() => _posts.removeWhere((p) => p.id == post.id));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Silinemedi: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_initialLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null && _posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _loadFirstPage,
                child: const Text('Tekrar dene'),
              ),
            ],
          ),
        ),
      );
    }
    if (_posts.isEmpty) {
      return RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Center(child: Text('Henüz paylaşım yok')),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollCtrl,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 80, top: 4),
        itemCount: _posts.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _posts.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final post = _posts[index];
          return PostCard(
            post: post,
            postService: _service,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostDetailScreen(postId: post.id),
              ),
            ),
            onEdit: () async {
              final updated = await showCreatePostSheet(
                context,
                editPost: post,
              );
              if (updated == true) _refresh();
            },
            onDelete: () => _handleDelete(post),
            onReport: () => showReportSheet(
              context,
              target: ReportTarget.post,
              targetId: post.id,
            ),
          );
        },
      ),
    );
  }
}
