import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/category_repo.dart';
import 'package:todolist/provider/icons_provider.dart';
import 'package:todolist/widgets/add_category.dart';
import 'package:todolist/widgets/category.dart';
import 'package:todolist/widgets/update_category.dart';

class ToDoCategoryScreen extends StatelessWidget {
  const ToDoCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<ToDoCategoriesRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do Category'),
        backgroundColor: Colors.purple[200],
      ),
      backgroundColor: Colors.purple[50],

      body: ListView.builder(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        itemCount: repo.categories.length,
        itemBuilder: (context, index) {
          final category = repo.categories[index];

          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Slidable(
              key: ValueKey(category.key),

              startActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      final controller = TextEditingController(
                        text: category.name,
                      );
                      showDialog(
                        context: context,
                        builder: (_) => UpdateCategoryWidget(
                          addName: 'category',
                          newName: controller,
                          initialIcon: category.iconName,
                          onUpdate: (newName, newIcon) {
                            context
                                .read<ToDoCategoriesRepository>()
                                .renameCategory(category, newName, newIcon);
                          },
                        ),
                      );
                    },
                    icon: Icons.edit,
                    backgroundColor: const Color.fromARGB(255, 143, 244, 153),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ],
              ),

              endActionPane: ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.25,
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      context.read<ToDoCategoriesRepository>().deleteCategory(
                        category,
                      );
                    },
                    icon: Icons.delete_outline,
                    backgroundColor: const Color.fromARGB(255, 252, 102, 91),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ],
              ),

              child: GestureDetector(
                onTap: () => repo.openCategory(context, category),
                child: Consumer<ToDoCategoriesRepository>(
                  builder: (_, repo, __) {
                    return CategoryWidgets(
                      category: category,
                      nameIcon: category.iconName,
                      countTask: repo.countForCategory(category.name),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 188, 60, 211),
        child: const Icon(Icons.add),
        onPressed: () {
          final controller = TextEditingController();
          showDialog(
            context: context,
            builder: (_) => AddCategoryElement(
              categoryNameController: controller,
              onAdd: (text, icon) {
                context.read<ToDoCategoriesRepository>().addCategory(
                  text,
                  icon,
                );
              },
              iconsProvider: context.read<IconsProvider>(),
            ),
          );
        },
      ),
    );
  }
}
