import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'Project Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainMenuScreen(),
      ),
    );
  }
}

class AppProvider with ChangeNotifier {
  List<Project> _projects = [];
  List<Task> _tasks = [];
  List<Message> _messages = [];

  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;
  List<Message> get messages => _messages;

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
}

class Project {
  String name;
  DateTime startDate;
  DateTime endDate;
  double budget;

  Project({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.budget,
  });
}

class Task {
  String name;
  String assignedTo;
  String status;
  DateTime deadline;
  String priority;

  Task({
    required this.name,
    required this.assignedTo,
    required this.status,
    required this.deadline,
    required this.priority,
  });
}

class Message {
  String content;
  String recipient;

  Message({
    required this.content,
    required this.recipient,
  });
}

// Main Menu
class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Management App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: <Widget>[
            MenuButton(
              text: 'Manage Projects',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageProjectsScreen()),
                );
              },
            ),
            MenuButton(
              text: 'Manage Tasks',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageTasksScreen()),
                );
              },
            ),
            MenuButton(
              text: 'View Project Timeline',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewTimelineScreen()),
                );
              },
            ),
            MenuButton(
              text: 'Communicate with Team',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunicateScreen()),
                );
              },
            ),
            MenuButton(
              text: 'Generate Reports',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateReportsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Menu Button Widget
class MenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  MenuButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 20),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

// Manage Projects
class ManageProjectsScreen extends StatefulWidget {
  @override
  _ManageProjectsScreenState createState() => _ManageProjectsScreenState();
}

class _ManageProjectsScreenState extends State<ManageProjectsScreen> {
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
            _buildTextField(
              controller: _nameController,
              labelText: 'Project Name',
            ),
            _buildTextField(
              controller: _startDateController,
              labelText: 'Start Date (YYYY-MM-DD)',
              keyboardType: TextInputType.datetime,
            ),
            _buildTextField(
              controller: _endDateController,
              labelText: 'End Date (YYYY-MM-DD)',
              keyboardType: TextInputType.datetime,
            ),
            _buildTextField(
              controller: _budgetController,
              labelText: 'Budget',
              keyboardType: TextInputType.number,
            ),
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
                Navigator.pop(context);
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
                        'Start: ${project.startDate}\n'
                        'End: ${project.endDate}\n'
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
class ManageTasksScreen extends StatefulWidget {
  @override
  _ManageTasksScreenState createState() => _ManageTasksScreenState();
}

class _ManageTasksScreenState extends State<ManageTasksScreen> {
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
            _buildTextField(
              controller: _nameController,
              labelText: 'Task Name',
            ),
            _buildTextField(
              controller: _assignedToController,
              labelText: 'Assigned To',
            ),
            _buildTextField(
              controller: _statusController,
              labelText: 'Status',
            ),
            _buildTextField(
              controller: _deadlineController,
              labelText: 'Deadline (YYYY-MM-DD)',
              keyboardType: TextInputType.datetime,
            ),
            _buildTextField(
              controller: _priorityController,
              labelText: 'Priority',
            ),
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
                Navigator.pop(context);
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
    final projects = appProvider.projects;

    return Scaffold(
      appBar: AppBar(
        title: Text('Project Timeline'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              child: ListTile(
                title: Text(
                  project.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
class CommunicateScreen extends StatefulWidget {
  @override
  _CommunicateScreenState createState() => _CommunicateScreenState();
}

class _CommunicateScreenState extends State<CommunicateScreen> {
  final TextEditingController _messageController = TextEditingController();

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
            TextField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
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
                final message = Message(
                  content: _messageController.text,
                  recipient: 'Team', // Placeholder for recipient
                );

                appProvider.addMessage(message);
                _messageController.clear();
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
                      title: Text(
                        message.recipient,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(message.content),
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
}

// Generate Reports
class GenerateReportsScreen extends StatelessWidget {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                final projects = appProvider.projects;
                final reportContent = projects.map((p) =>
                  'Project: ${p.name}\n'
                  'Start Date: ${p.startDate}\n'
                  'End Date: ${p.endDate}\n'
                  'Budget: \$${p.budget}\n'
                ).join('\n');

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Generated Report'),
                    content: SingleChildScrollView(
                      child: Text(reportContent),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Generate Project Report'),
            ),
            SizedBox(height: 20),
            // Add more report generation options here as needed
          ],
        ),
      ),
    );
  }
}
