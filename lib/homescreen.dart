import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mock_webflutter/services/api_services.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  ApiServices api = ApiServices();
  String result = "";
  final TextEditingController _controller = TextEditingController();

  //add the methods here
  Future<void> fetchStatus() async {
    try {
      final res = await api.getStatus();
      setState(() {
        result = res;
      });
    } catch (e) {
      setState(() {
        print("Error: $e");
      });
    }
  }

  //now ping response
  Future<void> fetchPing() async {
    try {
      final res = await api.pingResponse();
      setState(() {
        result = res;
      });
    } catch (e) {
      setState(() {
        print("Error : $e");
      });
    }
  }

  //now the echo function

  Future<void> fetchEcho() async {
    try {
      final res = await api.echoResponse(_controller.text);
      setState(() {
        result = res;
      });
    } catch (e) {
      setState(() {
        print("Error : $e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mock API", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchStatus,
              child: const Text("Get Status"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: fetchPing, child: const Text("Ping")),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter message for Echo",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: fetchEcho, child: const Text("Echo")),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
