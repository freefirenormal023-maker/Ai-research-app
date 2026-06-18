class TaskModel {
  final String id;
  final String topic;
  String status;
  int progress;
  String currentAgent;
  double qualityScore;
  String? reportContent;
  List<String> sources;
  List<AgentStep> agentSteps;

  TaskModel({
    required this.id,
    required this.topic,
    this.status = 'queued',
    this.progress = 0,
    this.currentAgent = '',
    this.qualityScore = 0.0,
    this.reportContent,
    this.sources = const [],
    this.agentSteps = const [],
  });
}

class AgentStep {
  final String agentName;
  final String status;
  final String message;

  AgentStep({
    required this.agentName,
    required this.status,
    required this.message,
  });

  String get displayName {
    const names = {
      'orchestrator': '🧠 Orchestrator',
      'query_planner': '🔍 Query Planner',
      'research': '📚 Research Agent',
      'fact_checker': '✅ Fact Checker',
      'synthesis': '✍️ Synthesis Agent',
      'style': '🎨 Style Agent',
      'validation': '🛡️ Validation',
    };
    return names[agentName] ?? agentName;
  }
}
