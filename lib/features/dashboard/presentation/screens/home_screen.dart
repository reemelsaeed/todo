import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/Authentication/data/models/userModel.dart';
import 'package:todo_app/features/dashboard/logic/cubit/dashboard_cubit_cubit.dart';
import 'package:todo_app/features/dashboard/presentation/widgets/home_header_widget.dart';
import 'package:todo_app/features/dashboard/presentation/widgets/status_filter_widget.dart';
import 'package:todo_app/features/dashboard/presentation/widgets/task_card_widget.dart';

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
                child: BlocBuilder<DashboardCubitCubit, DashboardCubitState>(
                  builder: (context, state) {
                    if (state is DashboardCubitILoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is DashboardCubitFailuer) {
                      return Center(child: Text(state.message));
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

                    // الحالة الابتدائية (Initial) قبل أي حاجة تحصل
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF007AFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
