import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:task_manager/core/views/widgets/loader_widget.dart';
import 'package:task_manager/core/views/widgets/shimmer_placeholder.dart';
import 'package:task_manager/features/todos/views/widgets/title_widget.dart';
import 'package:task_manager/features/todos/cubit/todos_cubit/todos_cubit.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
import 'package:task_manager/features/todos/views/widgets/todo_sheet.dart';
import 'package:task_manager/features/todos/views/widgets/todo_widget.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  late TodosCubit _todosCubit;

  @override
  void initState() {
    super.initState();
    _todosCubit = getIt<TodosCubit>();
    _getData();
  }

  void _getData() {
    _todosCubit.initController();
  }

  void _refreshData() {
    try {
      _todosCubit.todosController?.refresh();
    } catch (e) {
      debugPrint('onRefresh: error-> $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddTodoWidget(
          onAdd: showTodoSheet,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              _refreshData();
              return Future.delayed(const Duration(seconds: 1));
            },
            child: PagedListView<int, TodoModel>(
              pagingController: _todosCubit.todosController!,
              builderDelegate: PagedChildBuilderDelegate<TodoModel>(
                animateTransitions: false,
                firstPageProgressIndicatorBuilder: (_) =>
                    CustomShimmer.todosListShimmer(context),
                newPageProgressIndicatorBuilder: (_) => const LoaderWidget(),
                firstPageErrorIndicatorBuilder: (_) => Center(
                    child: Text(
                        _todosCubit.todosController?.error.toString() ?? '')),
                itemBuilder: (context, item, index) {
                  return TodoWidget(
                    onPressed: () {
                      showTodoSheet(todo: item);
                    },
                    todo: item,
                    index: index,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  showTodoSheet({TodoModel? todo}) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) => TodoSheet(
              todo: todo,
              onDelete: (){},
              onSave: (todo) {
                if(todo.id!=null){
                  _todosCubit.updateTodo(todo: todo);
                }else{
                _todosCubit.addTodo(todo: todo);}
              },
            ),
        isScrollControlled: true);
  }

  @override
  void dispose() {
    super.dispose();
    _todosCubit.clear();
  }
}
