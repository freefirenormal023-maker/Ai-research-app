import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Research Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const HomeScreen(),
    );
  }
}

// ============== HOME SCREEN ==============
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF0F172A)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text('🤖', style: TextStyle(fontSize: 28)),
                    ),
                    const SizedBox(width: 14),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI Research',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                        Text('Assistant',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF60A5FA))),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '7 AI Agents\nWorking For You',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Professional research reports in minutes.',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.85)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _chip('91%', 'Accuracy'),
                          const SizedBox(width: 10),
                          _chip('24+', 'Sources'),
                          const SizedBox(width: 10),
                          _chip('5 min', 'Time'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Text('AI Agent Pipeline',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 14),
                _agentRow('🧠', 'Orchestrator', const Color(0xFF3B82F6)),
                _agentRow('🔍', 'Query Planner', const Color(0xFF8B5CF6)),
                _agentRow('📚', 'Researcher', const Color(0xFF10B981)),
                _agentRow('✅', 'Fact Checker', const Color(0xFFF59E0B)),
                _agentRow('✍️', 'Synthesis', const Color(0xFFEF4444)),
                _agentRow('🎨', 'Style Agent', const Color(0xFFEC4899)),
                _agentRow('🛡️', 'Validator', const Color(0xFF06B6D4)),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GenerateScreen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🚀', style: TextStyle(fontSize: 22)),
                        SizedBox(width: 10),
                        Text('Start Research',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String val, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(val,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16)),
          Text(label,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8), fontSize: 11)),
        ],
      ),
    );
  }

  Widget _agentRow(String icon, String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 14),
          Text(name,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 15)),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,
              size: 14, color: color.withOpacity(0.5)),
        ],
      ),
    );
  }
}

// ============== GENERATE SCREEN ==============
class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final _controller = TextEditingController();

  final _suggestions = [
    '🏥 AI in Healthcare',
    '🌍 Climate Change',
    '💰 Crypto Future',
    '🚀 Space Tech 2025',
    '🤖 Machine Learning',
    '📱 5G Impact',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('New Research',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Research Topic',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: const Color(0xFF2563EB).withOpacity(0.3)),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter your research topic...',
                  hintStyle:
                      TextStyle(color: Colors.white.withOpacity(0.3)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Quick Topics:',
                style: TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _suggestions
                  .map((s) => GestureDetector(
                        onTap: () => setState(() {
                          _controller.text =
                              s.replaceAll(RegExp(r'^[^\s]+\s'), '');
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xFF334155)),
                          ),
                          child: Text(s,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a topic')),
                    );
                    return;
                  }
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ProgressScreen(topic: _controller.text)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('🚀  Generate Report',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============== PROGRESS SCREEN ==============
class ProgressScreen extends StatefulWidget {
  final String topic;
  const ProgressScreen({super.key, required this.topic});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int currentStep = 0;
  int progress = 0;

  final agents = [
    {'icon': '🧠', 'name': 'Orchestrator', 'msg': 'Task plan ready'},
    {'icon': '🔍', 'name': 'Query Planner', 'msg': '12 queries generated'},
    {'icon': '📚', 'name': 'Research Agent', 'msg': '24 sources found'},
    {'icon': '✅', 'name': 'Fact Checker', 'msg': '18 facts verified'},
    {'icon': '✍️', 'name': 'Synthesis', 'msg': 'Draft created'},
    {'icon': '🎨', 'name': 'Style Agent', 'msg': 'Language polished'},
    {'icon': '🛡️', 'name': 'Validator', 'msg': 'Score: 91%'},
  ];

  @override
  void initState() {
    super.initState();
    _runSimulation();
  }

  void _runSimulation() async {
    for (int i = 0; i < agents.length; i++) {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          currentStep = i + 1;
          progress = ((i + 1) / agents.length * 100).round();
        });
      }
    }
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(topic: widget.topic)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const Text('🤖 AI Agents Working',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
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
                          value: progress / 100,
                          strokeWidth: 10,
                          backgroundColor: const Color(0xFF334155),
                          valueColor: const AlwaysStoppedAnimation(
                              Color(0xFF2563EB)),
                        ),
                      ),
                      Column(
                        children: [
                          Text('$progress%',
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
                  Text('📋 ${widget.topic}',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
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
                  ...agents.asMap().entries.map((e) {
                    final i = e.key;
                    final a = e.value;
                    final done = i < currentStep;
                    final active = i == currentStep;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          done
                              ? const Icon(Icons.check_circle,
                                  color: Color(0xFF10B981), size: 24)
                              : active
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          valueColor: AlwaysStoppedAnimation(
                                              Color(0xFF2563EB))))
                                  : Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: const Color(0xFF334155),
                                              width: 2))),
                          const SizedBox(width: 14),
                          Text(a['icon']!,
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(a['name']!,
                                    style: TextStyle(
                                        color: done || active
                                            ? Colors.white
                                            : Colors.white38,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                                if (done)
                                  Text(a['msg']!,
                                      style: TextStyle(
                            
