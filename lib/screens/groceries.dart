import 'package:flutter/material.dart';

class GroceriesPage extends StatefulWidget {
  const GroceriesPage({super.key});

  @override
  _GroceriesPageState createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  int currentMonthIndex = 0; // 0 = current month, 1 = last month, etc.

  final List<Map<String, dynamic>> monthlyData = [
    {
      'month': 'August',
      'weeklyBudgets': [50, 40, 30, 30],
      'total': 150,
    },
    {
      'month': 'July',
      'weeklyBudgets': [45, 35, 50, 40],
      'total': 170,
    },
    {
      'month': 'June',
      'weeklyBudgets': [30, 20, 40, 60],
      'total': 150,
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
        title: const Text('Groceries'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBudgetBox('\$${currentData['total']}'), // Reusing the budget box with the groceries amount
            const SizedBox(height: 30),
            Text(
              'Insights',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 20),
            _buildChatBubble(
              'You are spending the same amount as you did last week.',
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
        gradient: LinearGradient(
          colors: [Colors.teal[200]!, Colors.teal[400]!],
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        budget,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildChatBubble(String text) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal[100]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble, color: Colors.teal, size: 24),
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
              icon: const Icon(Icons.arrow_back, color: Colors.teal),
            ),
            Text(
              data['month'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.teal[800],
              ),
            ),
            if (currentMonthIndex > 0) // Only show forward arrow if not at the latest month
              IconButton(
                onPressed: _goToNextMonth,
                icon: const Icon(Icons.arrow_forward, color: Colors.teal),
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
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
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
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 3),
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
              color: Colors.black,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
