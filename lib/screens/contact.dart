import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_app_name/contact_model.dart';
import 'package:your_app_name/contact_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactController = Provider.of<ContactController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Contacts'),
      ),
      body: contactController.contacts.isEmpty
          ? Center(
              child: Text('No contacts yet. Add some!'),
            )
          : ListView.builder(
              itemCount: contactController.contacts.length,
              itemBuilder: (context, index) {
                final contact = contactController.contacts[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(contact.name[0]),
                    ),
                    title: Text(contact.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.phoneNumber),
                        if (contact.email != null && contact.email!.isNotEmpty)
                          Text(contact.email!),
                        if (contact.address != null && contact.address!.isNotEmpty)
                          Text(contact.address!),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Show a confirmation dialog before deleting
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Contact'),
                              content: Text('Are you sure you want to delete ${contact.name}?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Dismiss dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    contactController.deleteContact(index);
                                    Navigator.of(context).pop(); // Dismiss dialog
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetailScreen(contact: contact, index: index),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditContactScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;
  final int index;

  ContactDetailScreen({required this.contact, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditContactScreen(contact: contact, index: index),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${contact.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Phone: ${contact.phoneNumber}',
              style: TextStyle(fontSize: 16),
            ),
            if (contact.email != null && contact.email!.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                'Email: ${contact.email}',
                style: TextStyle(fontSize: 16),
              ),
            ],
            if (contact.address != null && contact.address!.isNotEmpty) ...[
              SizedBox(height: 8),
              Text(
                'Address: ${contact.address}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact; // For editing existing contact
  final int? index; // Index of the contact being edited

  AddEditContactScreen({this.contact, this.index});

  @override
  _AddEditContactScreenState createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneNumberController = TextEditingController(text: widget.contact?.phoneNumber ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _addressController = TextEditingController(text: widget.contact?.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final newContact = Contact(
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        email: _emailController.text.isNotEmpty ? _emailController.text : null,
        address: _addressController.text.isNotEmpty ? _addressController.text : null,
      );

      final contactController = Provider.of<ContactController>(context, listen: false);

      if (widget.contact == null) {
        // Adding new contact
        contactController.addContact(newContact);
      } else {
        // Updating existing contact
        contactController.updateContact(widget.index!, newContact);
      }
      Navigator.pop(context); // Go back to the contact list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email (Optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveContact,
                child: Text(widget.contact == null ? 'Add Contact' : 'Update Contact'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}