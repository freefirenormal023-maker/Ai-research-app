import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_plus/share_plus.dart';
import '../services/api_service.dart';
import '../models/task_model.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final String taskId;
  const ResultScreen({super.key, required this.taskId});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final _fc = TextEditingController();
  bool _showFeedback = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (r) => false),
        ),
        title: const Text('✅ Report Ready',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700)),
        actions: [
          Consumer<ApiService>(builder: (_, api, __) {
            final t = api.currentTask;
            if (t == null) return const SizedBox();
            return Row(children: [
              IconButton(
                  icon: const Icon(Icons.copy, color: Colors.white),
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: t.reportContent ?? ''));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('📋 Copied!')));
                  }),
              IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () => Share.share(t.reportContent ?? '',
                      subject: 'Report: ${t.topic}')),
            ]);
          }),
        ],
      ),
      body: Consumer<ApiService>(
        builder: (context, api, _) {
          final task = api.currentTask;
          if (task == null) return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2563EB)));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _banner(task),
                const SizedBox(height: 14),
                _stats(task),
                const SizedBox(height: 14),
                _sources(task),
                const SizedBox(height: 14),
                _report(task),
                const SizedBox(height: 14),
                _feedback(api, task),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _banner(TaskModel task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF059669), Color(0xFF10B981)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('🎯', style: TextStyle(fontSize: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Research Complete!',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                Text(
                    'Quality: ${(task.qualityScore * 100).round()}% | 7 Agents Done',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stats(TaskModel task) {
    return Row(
      children: [
        _sc('${(task.qualityScore * 100).round()}%', 'Accuracy',
            const Color(0xFF10B981), '🎯'),
        const SizedBox(width: 10),
        _sc('${task.sources.length}', 'Sources',
            const Color(0xFF2563EB), '📚'),
        const SizedBox(width: 10),
        _sc('7/7', 'Agents', const Color(0xFF8B5CF6), '🤖'),
      ],
    );
  }

  Widget _sc(String v, String l, Color c, String e) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: c.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: c.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(e, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(v,
                style: TextStyle(
                    color: c,
                    fontWeight: FontWeight.w800,
                    fontSize: 16)),
            Text(l,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _sources(TaskModel task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📎 Sources Used',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15)),
          const SizedBox(height: 10),
          ...task.sources.asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                          child: Text('${e.key + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700))),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(e.value,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _report(TaskModel task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📄 Full Report',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15)),
          const Divider(color: Color(0xFF334155)),
          MarkdownBody(
            data: task.reportContent ?? '',
            styleSheet: MarkdownStyleSheet(
              h1: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
              h2: const TextStyle(
                  color: Color(0xFF60A5FA),
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
              h3: const TextStyle(
                  color: Color(0xFF93C5FD),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
              p: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  height: 1.7),
              strong: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _feedback(ApiService api, TaskModel task) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () =>
                    setState(() => _showFeedback = !_showFeedback),
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Revise'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF60A5FA),
                  side: const BorderSide(color: Color(0xFF2563EB)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Share.share(task.reportContent ?? ''),
                icon: const Icon(Icons.share, size: 16),
                label: const Text('Share'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
        if (_showFeedback) ...[
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💬 What to improve?',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Make shorter', 'More data',
                      'Simpler', 'More technical']
                      .map((s) => GestureDetector(
                            onTap: () =>
                                setState(() => _fc.text = s),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color(0xFF334155)),
                              ),
                              child: Text(s,
                                  style: TextStyle(
                                      color:
                                          Colors.white.withOpacity(0.7),
                                      fontSize: 12)),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _fc,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Type your feedback...',
                    hintStyle:
                        TextStyle(color: Colors.white.withOpacity(0.3)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFF334155))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFF334155))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFF2563EB))),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_fc.text.trim().isEmpty) return;
                      await api.submitFeedback(task.id, _fc.text);
                      setState(() {
                        _showFeedback = false;
                        _fc.clear();
                      });
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('✅ Report updated!')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C3AED),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('🔄 Revise Report'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
