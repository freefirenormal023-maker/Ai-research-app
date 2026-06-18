import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/task_model.dart';
import 'result_screen.dart';

class ProgressScreen extends StatelessWidget {
  final String taskId;
  const ProgressScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text('🤖 AI Agents Working',
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      body: Consumer<ApiService>(
        builder: (context, api, _) {
          final task = api.currentTask;
          if (task == null) {
            return const Center(
                child: CircularProgressIndicator(
                    color: Color(0xFF2563EB)));
          }

          if (task.status == 'completed') {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResultScreen(taskId: taskId)));
            });
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildProgress(task),
                const SizedBox(height: 20),
                _buildTimeline(task),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgress(TaskModel task) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: CircularProgressIndicator(
                  value: task.progress / 100,
                  strokeWidth: 10,
                  backgroundColor: const Color(0xFF334155),
                  valueColor:
                      const AlwaysStoppedAnimation(Color(0xFF2563EB)),
                ),
              ),
              Column(
                children: [
                  Text('${task.progress}%',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800)),
                  Text('Complete',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('📋 ${task.topic}',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.7), fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildTimeline(TaskModel task) {
    final all = [
      'orchestrator', 'query_planner', 'research',
      'fact_checker', 'synthesis', 'style', 'validation'
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Agent Pipeline',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          const SizedBox(height: 16),
          ...all.asMap().entries.map((e) {
            final name = e.value;
            final done =
                task.agentSteps.any((s) => s.agentName == name);
            final active = task.currentAgent == name;
            final step = task.agentSteps.firstWhere(
                (s) => s.agentName == name,
                orElse: () => AgentStep(
                    agentName: name,
                    status: 'pending',
                    message: ''));

            return _row(
              AgentStep(
                  agentName: name,
                  status: done
                      ? 'completed'
                      : active
                          ? 'running'
                          : 'pending',
                  message: step.message),
              isLast: e.key == all.length - 1,
            );
          }),
        ],
      ),
    );
  }

  Widget _row(AgentStep step, {bool isLast = false}) {
    Color color;
    Widget icon;

    if (step.status == 'completed') {
      color = const Color(0xFF10B981);
      icon = const Icon(Icons.check_circle,
          color: Color(0xFF10B981), size: 22);
    } else if (step.status == 'running') {
      color = const Color(0xFF2563EB);
      icon = const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor:
                  AlwaysStoppedAnimation(Color(0xFF2563EB))));
    } else {
      color = const Color(0xFF334155);
      icon = Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: const Color(0xFF334155), width: 2)));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            icon,
            if (!isLast)
              Container(
                  width: 2,
                  height: 38,
                  color: color.withOpacity(0.3)),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    AgentStep(
                            agentName: step.agentName,
                            status: '',
                            message: '')
                        .displayName,
                    style: TextStyle(
                        color: step.status == 'pending'
                            ? Colors.white38
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                if (step.message.isNotEmpty)
                  Text(step.message,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
