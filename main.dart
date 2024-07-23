import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMenuScreen(),
    );
  }
}

class Project {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final double budget;

  Project({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.budget,
  });
}

class Task {
  final String name;
  final String assignedTo;
  final String status;
  final DateTime deadline;
  final String priority;

  Task({
    required this.name,
    required this.assignedTo,
    required this.status,
    required this.deadline,
    required this.priority,
  });
}

class Message {
  final String content;
  final String recipient;

  Message({
    required this.content,
    required this.recipient,
  });
}

class Report {
  final String content;

  Report({
    required this.content,
  });
}

class AppProvider with ChangeNotifier {
  final List<Project> _projects = [];
  final List<Task> _tasks = [];
  final List<Message> _messages = [];
  final List<Report> _reports = [];

  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;
  List<Message> get messages => _messages;
  List<Report> get reports => _reports;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void addReport(Report report) {
    _reports.add(report);
    notifyListeners();
  }
}

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Management App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageProjectsScreen()),
                );
              },
              child: Text('Manage Projects'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageTasksScreen()),
                );
              },
              child: Text('Manage Tasks'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewTimelineScreen()),
                );
              },
              child: Text('View Project Timeline'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunicateScreen()),
                );
              },
              child: Text('Communicate with Team'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateReportsScreen()),
                );
              },
              child: Text('Generate Reports'),
            ),
          ],
        ),
      ),
    );
  }
}

// Manage Projects
class ManageProjectsScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextField(controller: _nameController, labelText: 'Project Name'),
            _buildTextField(controller: _startDateController, labelText: 'Start Date (YYYY-MM-DD)', keyboardType: TextInputType.datetime),
            _buildTextField(controller: _endDateController, labelText: 'End Date (YYYY-MM-DD)', keyboardType: TextInputType.datetime),
            _buildTextField(controller: _budgetController, labelText: 'Budget', keyboardType: TextInputType.number),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                final name = _nameController.text;
                final startDate = DateTime.parse(_startDateController.text);
                final endDate = DateTime.parse(_endDateController.text);
                final budget = double.parse(_budgetController.text);

                final project = Project(
                  name: name,
                  startDate: startDate,
                  endDate: endDate,
                  budget: budget,
                );

                appProvider.addProject(project);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Project saved successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ).then((_) {
                  // Clear text fields after saving
                  _nameController.clear();
                  _startDateController.clear();
                  _endDateController.clear();
                  _budgetController.clear();
                });
              },
              child: Text('Save Project'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: appProvider.projects.length,
                itemBuilder: (context, index) {
                  final project = appProvider.projects[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(project.name, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'Start Date: ${project.startDate}\n'
                        'End Date: ${project.endDate}\n'
                        'Budget: \$${project.budget}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

// Manage Tasks
class ManageTasksScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _assignedToController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Tasks'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextField(controller: _nameController, labelText: 'Task Name'),
            _buildTextField(controller: _assignedToController, labelText: 'Assigned To'),
            _buildTextField(controller: _statusController, labelText: 'Status'),
            _buildTextField(controller: _deadlineController, labelText: 'Deadline (YYYY-MM-DD)', keyboardType: TextInputType.datetime),
            _buildTextField(controller: _priorityController, labelText: 'Priority'),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                final name = _nameController.text;
                final assignedTo = _assignedToController.text;
                final status = _statusController.text;
                final deadline = DateTime.parse(_deadlineController.text);
                final priority = _priorityController.text;

                final task = Task(
                  name: name,
                  assignedTo: assignedTo,
                  status: status,
                  deadline: deadline,
                  priority: priority,
                );

                appProvider.addTask(task);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Task saved successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ).then((_) {
                  // Clear text fields after saving
                  _nameController.clear();
                  _assignedToController.clear();
                  _statusController.clear();
                  _deadlineController.clear();
                  _priorityController.clear();
                });
              },
              child: Text('Save Task'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: appProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = appProvider.tasks[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(task.name, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'Assigned To: ${task.assignedTo}\n'
                        'Status: ${task.status}\n'
                        'Deadline: ${task.deadline}\n'
                        'Priority: ${task.priority}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

// View Project Timeline
class ViewTimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Project Timeline'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: appProvider.projects.length,
          itemBuilder: (context, index) {
            final project = appProvider.projects[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              child: ListTile(
                title: Text(project.name, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Start Date: ${project.startDate}\n'
                  'End Date: ${project.endDate}\n'
                  'Budget: \$${project.budget}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Communicate with Team
class CommunicateScreen extends StatelessWidget {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Communicate with Team'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextField(controller: _messageController, labelText: 'Message'),
            _buildTextField(controller: _recipientController, labelText: 'Recipient'),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                final content = _messageController.text;
                final recipient = _recipientController.text;

                final message = Message(
                  content: content,
                  recipient: recipient,
                );

                appProvider.addMessage(message);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Message sent successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ).then((_) {
                  // Clear text fields after saving
                  _messageController.clear();
                  _recipientController.clear();
                });
              },
              child: Text('Send Message'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: appProvider.messages.length,
                itemBuilder: (context, index) {
                  final message = appProvider.messages[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(message.content, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Recipient: ${message.recipient}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}

// Generate Reports
class GenerateReportsScreen extends StatelessWidget {
  final TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Reports'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextField(controller: _reportController, labelText: 'Report'),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                final content = _reportController.text;

                final report = Report(content: content);

                appProvider.addReport(report);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Success'),
                    content: Text('Report generated successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                ).then((_) {
                  // Clear text fields after saving
                  _reportController.clear();
                });
              },
              child: Text('Generate Report'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: appProvider.reports.length,
                itemBuilder: (context, index) {
                  final report = appProvider.reports[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      title: Text(report.content, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
