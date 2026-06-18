import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'generate_screen.dart';

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
                _buildHeader(),
                const SizedBox(height: 32),
                _buildHeroCard(context),
                const SizedBox(height: 28),
                _buildAgentsSection(),
                const SizedBox(height: 28),
                _buildStartButton(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
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
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
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
    ).animate().fadeIn(delay: 200.ms, duration: 600.ms);
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

  Widget _buildAgentsSection() {
    final agents = [
      {'icon': '🧠', 'name': 'Orchestrator', 'color': Color(0xFF3B82F6)},
      {'icon': '🔍', 'name': 'Query Planner', 'color': Color(0xFF8B5CF6)},
      {'icon': '📚', 'name': 'Researcher', 'color': Color(0xFF10B981)},
      {'icon': '✅', 'name': 'Fact Checker', 'color': Color(0xFFF59E0B)},
      {'icon': '✍️', 'name': 'Synthesis', 'color': Color(0xFFEF4444)},
      {'icon': '🎨', 'name': 'Style Agent', 'color': Color(0xFFEC4899)},
      {'icon': '🛡️', 'name': 'Validator', 'color': Color(0xFF06B6D4)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AI Agent Pipeline',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        ...agents.asMap().entries.map((e) {
          final agent = e.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: (agent['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: (agent['color'] as Color).withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Text(agent['icon'] as String,
                    style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 14),
                Text(agent['name'] as String,
                    style: TextStyle(
                        color: agent['color'] as Color,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                const Spacer(),
                Icon(Icons.arrow_forward_ios,
                    size: 14,
                    color: (agent['color'] as Color).withOpacity(0.5)),
              ],
            ),
          ).animate().fadeIn(
              delay: Duration(milliseconds: 300 + e.key * 80),
              duration: 400.ms);
        }),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const GenerateScreen())),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2563EB),
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          shadowColor: const Color(0xFF2563EB).withOpacity(0.5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🚀', style: TextStyle(fontSize: 22)),
            SizedBox(width: 10),
            Text('Start Research',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 500.ms);
  }
}
