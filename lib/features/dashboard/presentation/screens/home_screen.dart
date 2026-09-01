import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/Authentication/data/models/userModel.dart';
import 'package:todo_app/features/dashboard/logic/cubit/dashboard_cubit_cubit.dart';
import 'package:todo_app/features/dashboard/presentation/widgets/home_header_widget.dart';
import 'package:todo_app/features/dashboard/presentation/widgets/task_card_widget.dart';
import 'package:todo_app/features/tasks/presentation/screens/addTask_screen.dart';

class DashboardScreen extends StatefulWidget {
  final Usermodel user;

  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubitCubit>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              HomeHeader(user: widget.user, pendingCount: 2),
              //const SizedBox(height: 24),
              // const StatusFilterChips(),
              const SizedBox(height: 20),
              Expanded(
                child: BlocConsumer<DashboardCubitCubit, DashboardCubitState>(
                  listener: (context, state) {
                    if (state is DashboardCubitFailuer) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is DashboardCubitILoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DashboardCubitFailuer) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                              size: 40,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () => context
                                  .read<DashboardCubitCubit>()
                                  .getTasks(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is DashboardCubitSuccess) {
                      if (state.tasks.isEmpty) {
                        return const Center(child: Text('No Tasks '));
                      }
                      return ListView.separated(
                        itemCount: state.tasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          return TaskCard(task: state.tasks[index]);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddtaskScreen()),
          );

          if (newTask != null) {
            context.read<DashboardCubitCubit>().createTask(newTask);
          }
        },
        backgroundColor: const Color(0xFF007AFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
