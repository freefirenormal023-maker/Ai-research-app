import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/task_model.dart';

class ApiService extends ChangeNotifier {
  TaskModel? currentTask;
  bool isLoading = false;

  Future<String?> createTask({required String topic}) async {
    isLoading = true;
    notifyListeners();

    final taskId = 'demo_${DateTime.now().millisecondsSinceEpoch}';
    currentTask = TaskModel(
      id: taskId,
      topic: topic,
      status: 'queued',
      progress: 0,
    );

    isLoading = false;
    notifyListeners();
    _startSimulation(taskId, topic);
    return taskId;
  }

  void _startSimulation(String taskId, String topic) {
    final agents = [
      {'name': 'orchestrator', 'msg': 'Task plan ready', 'sec': 2},
      {'name': 'query_planner', 'msg': '12 queries generated', 'sec': 3},
      {'name': 'research', 'msg': '24 sources found', 'sec': 5},
      {'name': 'fact_checker', 'msg': '18 facts verified', 'sec': 4},
      {'name': 'synthesis', 'msg': 'Draft created', 'sec': 4},
      {'name': 'style', 'msg': 'Language polished', 'sec': 2},
      {'name': 'validation', 'msg': 'Score: 91%', 'sec': 2},
    ];

    int elapsed = 0;
    List<AgentStep> steps = [];
    int total = agents.fold(0, (s, a) => s + (a['sec'] as int));

    for (int i = 0; i < agents.length; i++) {
      final a = agents[i];
      final delay = elapsed;
      elapsed += (a['sec'] as int);

      Future.delayed(Duration(seconds: delay), () {
        steps = [
          ...steps,
          AgentStep(
            agentName: a['name'] as String,
            status: 'completed',
            message: a['msg'] as String,
          ),
        ];
        currentTask = TaskModel(
          id: taskId,
          topic: topic,
          status: 'processing',
          progress: ((elapsed / total) * 100).round().clamp(0, 95),
          currentAgent: a['name'] as String,
          agentSteps: List.from(steps),
        );
        notifyListeners();
      });
    }

    Future.delayed(Duration(seconds: elapsed), () {
      currentTask = TaskModel(
        id: taskId,
        topic: topic,
        status: 'completed',
        progress: 100,
        currentAgent: 'validation',
        qualityScore: 0.91,
        reportContent: _buildReport(topic),
        sources: [
          'Nature.com - Research 2024',
          'Harvard Business Review',
          'MIT Technology Review',
          'Stanford AI Lab Paper',
          'WHO Global Report 2024',
          'Google Scholar Articles',
        ],
        agentSteps: agents
            .map((a) => AgentStep(
                  agentName: a['name'] as String,
                  status: 'completed',
                  message: a['msg'] as String,
                ))
            .toList(),
      );
      notifyListeners();
    });
  }

  Future<void> submitFeedback(String taskId, String feedback) async {
    await Future.delayed(const Duration(seconds: 2));
    final old = currentTask?.reportContent ?? '';
    currentTask = TaskModel(
      id: taskId,
      topic: currentTask?.topic ?? '',
      status: 'completed',
      progress: 100,
      qualityScore: 0.94,
      reportContent: old + '\n\n---\n*Revised based on: $feedback*',
      sources: currentTask?.sources ?? [],
      agentSteps: currentTask?.agentSteps ?? [],
    );
    notifyListeners();
  }

  String _buildReport(String topic) {
    return '''
# Research Report: $topic

## Executive Summary

This report on **$topic** analyzes findings from 24 verified sources with a quality score of 91%.

---

## Key Findings

### 1. Current State
The field of $topic has seen **47% growth** in the last 3 years, driven by technological innovation and increasing demand.

**Major trends:**
- Rapid adoption across industries
- Cost reduction by 35% year-over-year  
- Increased regulatory support globally

### 2. Challenges
- Implementation complexity (68% of organizations report this)
- Skill gap in workforce
- Data privacy concerns
- Integration with legacy systems

### 3. Opportunities
- Market expected to reach **\$2.4 trillion by 2030**
- CAGR of 23.4% projected
- Emerging markets showing fastest growth

---

## Expert Analysis

Leading researchers highlight:

> "This represents one of the most significant transformations in modern history"
> — Stanford Research Institute, 2024

Key recommendations from 8 industry reports align on three priorities:
1. Strategic planning and roadmap development
2. Capability building and talent acquisition  
3. Ethical framework and governance

---

## Recommendations

### Immediate (0-6 months)
1. Conduct internal capability assessment
2. Identify pilot use cases
3. Begin stakeholder education

### Short-term (6-18 months)
1. Launch 2-3 pilot projects
2. Build strategic partnerships
3. Establish metrics framework

### Long-term (18+ months)
1. Scale successful pilots
2. Develop center of excellence
3. Contribute to industry standards

---

## Conclusion

$topic presents significant opportunities for organizations willing to invest strategically. Evidence strongly supports early action to capture competitive advantages.

---
*AI Research Assistant | 24 Sources | Quality: 91% | 7 Agents*
''';
  }
}
