import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:task_manager/features/todos/cubit/todos_cubit/todos_cubit.dart';
import 'package:task_manager/features/todos/cubit/todos_cubit/todos_state.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';

testTodosCubit() {
  group('TodosCubit', () {
    late TodosCubit todosCubit;

    setUp(() {
      todosCubit = getIt<TodosCubit>();
    });

    blocTest<TodosCubit, TodosState>(
      'emits [AuthState.loading, AuthState.loaded] when login succeeds',
      build: () => todosCubit,
      act: (cubit) {
        return cubit.getTodosList();
      },
      expect: () => [
        isA<Loading>(),
        isA<Loaded>(),
      ],
    );

    test('Add New Todo', () async {
      //Arrange
      TodoModel todo = TodoModel(
          id: 151,
          todo: 'Learn More About Unit Testing',
          userId: 1,
          completed: false);

      //Act
      await todosCubit.addTodo(todo: todo);

      //Assert
      expect(todosCubit.todosController.itemList?.contains(todo), true);
    });

    test('Delete Todo', () async {
      //Arrange
      TodoModel todo = TodoModel(id: 1);

      //Act
      await todosCubit.deleteTodo(todo: todo);

      //Assert
      expect(todosCubit.todosController.itemList?.contains(todo), false);
    });

    tearDown(() {
      todosCubit.close();
    });
  });
}
