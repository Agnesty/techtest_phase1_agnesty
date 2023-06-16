import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final email = box.read('email');
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 25,
            child: Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade300,
                  border: Border.all(color: Colors.white, width: 5)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Your Profile Card',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.amber),
                          child: const Icon(
                            Icons.person_3_rounded,
                            size: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Your Email :\n${email}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
