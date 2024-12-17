import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'csci410  ASSESSMENT',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Controllers for the TextFields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  
  // Gender selection
  String? _selectedGender;

  // Contact method selection (default is Email)
  String _preferredContactMethod = "Email";

  // Newsletter subscription checkbox
  bool _subscribeToNewsletter = false;

  String _result = "";

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
  }

  // Email validation
  bool isValidEmail(String email) {
    return email.contains("@") && email.contains(".");
  }

  // Update the result with the form values
  void handleSubmit() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty ||
        _selectedGender == null) {
      setState(() {
        _result = "Please fill out all fields.";
      });
    } else if (!isValidEmail(_emailController.text)) {
      setState(() {
        _result = "Please enter a valid email address.";
      });
    } else {
      setState(() {
        _result = "Submitted Information:\n"
            "Name: ${_nameController.text}\n"
            "Email: ${_emailController.text}\n"
            "Gender: $_selectedGender\n"
            "Preferred Contact Method: $_preferredContactMethod\n"
            "Subscribed to Newsletter: ${_subscribeToNewsletter ? "Yes" : "No"}";
      });
    }
  }

  // Clear all fields
  void clearFields() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
      _selectedGender = null;
      _preferredContactMethod = "Email";
      _subscribeToNewsletter = false;
      _result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A Simple Contact Form'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Name Input with label above
            const Text("Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(height: 10),
            
            // Email Input with label above
            const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 10),
            
            // Message Input with label above
            const Text("Message", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your message',
              ),
            ),
            const SizedBox(height: 10),
            
            // Gender Selection (Radio Buttons) with label above
            const Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: "Male",
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const Text("Male"),
                Radio<String>(
                  value: "Female",
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const Text("Female"),
                Radio<String>(
                  value: "Other",
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                const Text("Other"),
              ],
            ),
            const SizedBox(height: 10),
            
            // Preferred Contact Method (Dropdown) with label above
            const Text("Preferred Contact Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _preferredContactMethod,
              onChanged: (String? newValue) {
                setState(() {
                  _preferredContactMethod = newValue!;
                });
              },
              items: <String>['Email', 'Phone', 'SMS']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            
            // Subscribe to Newsletter Checkbox with label above
            Row(
              children: [
                Checkbox(
                  value: _subscribeToNewsletter,
                  onChanged: (bool? value) {
                    setState(() {
                      _subscribeToNewsletter = value!;
                    });
                  },
                ),
                const Text("Subscribe to newsletter"),
              ],
            ),
            const SizedBox(height: 20),
            
            // Submit and Clear Buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: handleSubmit,
                  child: const Text("Submit"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: clearFields,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text("Clear"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Display Submitted Information
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
