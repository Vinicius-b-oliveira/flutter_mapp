import 'package:flutter/material.dart';
import 'package:flutter_course/data/classes/activity_class.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final List<Activity> _activities = [];
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchActivity() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final url = Uri.https('bored-api.appbrewery.com', '/random');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          _activities.insert(0, Activity.fromJson(jsonResponse));
        });
      } else {
        setState(() {
          _errorMessage =
              'Failed to load activity. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching activity: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _clearActivities() {
    setState(() {
      _activities.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchActivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bored API Demo'),
        actions: [
          if (_activities.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _clearActivities,
              tooltip: 'Clear all activities',
            ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchActivity,
        tooltip: 'Add new activity',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _activities.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && _activities.isEmpty) {
      return Center(child: Text(_errorMessage!));
    }

    if (_activities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No activities available'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchActivity,
              child: const Text('Get First Activity'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchActivity,
      child: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          return _buildActivityItem(_activities[index]);
        },
      ),
    );
  }

  Widget _buildActivityItem(Activity activity) {
    return InkWell(
      onTap: () => _showActivityDetails(context, activity),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.activity,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Chip(label: Text(activity.type)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildDetailChip('👥 ${activity.participants}'),
                  _buildDetailChip('💲 ${activity.price.toStringAsFixed(2)}'),
                  if (activity.kidFriendly == true)
                    _buildDetailChip('👶 Kid Friendly'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip(String label) {
    return Chip(
      label: Text(label),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  void _showActivityDetails(BuildContext context, Activity activity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      activity.activity,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Type', activity.type),
              _buildDetailRow('Participants', activity.participants.toString()),
              _buildDetailRow(
                'Price',
                '\$${activity.price.toStringAsFixed(2)}',
              ),
              _buildDetailRow(
                'Accessibility',
                '${(activity.accessibility * 100).toStringAsFixed(0)}%',
              ),
              if (activity.duration != null)
                _buildDetailRow('Duration', activity.duration!),
              if (activity.link != null)
                _buildDetailRow('Link', activity.link!),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
