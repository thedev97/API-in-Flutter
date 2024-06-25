import 'package:flutter/material.dart';
import 'api_service/api_service.dart';
import 'model/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
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
  List<User>? users;

  Future<void> fetchUsers() async {
    try {
      final fetchedUsers = await ApiService.fetchUsersInfo();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
     debugPrint('Error $e');
    }
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: users == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${users![index].firstName} ${users![index].lastName}'),
          );
        },
      ),
    );
  }
}
