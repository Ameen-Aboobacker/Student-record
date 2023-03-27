
import 'package:flutter/material.dart';
import 'package:hive_sample/screens/screen_details.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class SearchScreen extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: ((context, studentList, _) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final studentInfo = StudentProvider.studentData[index];
            if (studentInfo.name.toLowerCase().contains(
                  query.toLowerCase(),
                )) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) {
                            return StudentDetails(data: studentInfo);
                          }),
                        ),
                      );
                    },
                    title: Text(studentInfo.name),
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: StudentProvider.studentData.length,
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: ((context, studentList, child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final studentInfo = StudentProvider.studentData[index];
            if (studentInfo.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) {
                            return StudentDetails(data: studentInfo);
                          }),
                        ),
                      );
                    },
                    title: Text(studentInfo.name),
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  const Divider()
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: StudentProvider.studentData.length,
        );
      }),
    );
  }
}