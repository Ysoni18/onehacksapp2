import 'package:flutter/material.dart';

class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({super.key});

  @override
  _UtilitiesPageState createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends State<UtilitiesPage> {
  int currentMonthIndex = 0; // 0 = current month, 1 = last month, etc.

  final List<Map<String, dynamic>> monthlyData = [
    {
      'month': 'August',
      'weeklyBudgets': [100, 120, 110, 130],
      'total': 460,
    },
    {
      'month': 'July',
      'weeklyBudgets': [90, 110, 100, 120],
      'total': 420,
    },
    {
      'month': 'June',
      'weeklyBudgets': [80, 95, 100, 105],
      'total': 380,
    },
  ];

  void _goToPreviousMonth() {
    setState(() {
      if (currentMonthIndex < monthlyData.length - 1) {
        currentMonthIndex++;
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      if (currentMonthIndex > 0) {
        currentMonthIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentData = monthlyData[currentMonthIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Utilities'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBudgetBox('\$${currentData['total']}'), // Reusing the budget box with the utilities amount
            const SizedBox(height: 30),
            const Text(
              'Insights',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildChatBubble(
              'You are spending more on utilities than last month.',
            ),
            const SizedBox(height: 30),
            _buildPastBudgetsSection(currentData),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetBox(String budget) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        budget,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildChatBubble(String text) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble, color: Colors.lightBlueAccent, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastBudgetsSection(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: _goToPreviousMonth,
              icon: const Icon(Icons.arrow_back),
            ),
            Text(
              data['month'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (currentMonthIndex > 0) // Only show forward arrow if not at the latest month
              IconButton(
                onPressed: _goToNextMonth,
                icon: const Icon(Icons.arrow_forward),
              )
            else
              const SizedBox(width: 48), // Placeholder to maintain alignment
          ],
        ),
        const SizedBox(height: 20),
        for (int i = 0; i < data['weeklyBudgets'].length; i++) ...[
          _buildWeeklyBudgetItem('Week ${i + 1}', '\$${data['weeklyBudgets'][i]}'),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 20),
        Text(
          'Total Monthly Budget: \$${data['total']}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyBudgetItem(String week, String amount) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            week,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
