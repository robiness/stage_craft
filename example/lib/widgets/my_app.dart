import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.maxContentWidth,
  });

  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key});

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1440,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: const PageContent(),
          ),
        ),
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  const PageContent({super.key});

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  int _selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 700) {
          return Row(
            children: [
              SizedBox(
                width: 500,
                child: ItemList(
                  onItemSelected: (int selectedItem) {
                    setState(() {
                      _selectedItem = selectedItem;
                    });
                  },
                ),
              ),
              DetailView(id: _selectedItem),
            ],
          );
        }
        return ItemList(
          onItemSelected: (int selectedItem) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DetailView(id: selectedItem);
                },
              ),
            );
          },
        );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.onItemSelected,
  });

  final void Function(int selectedItem) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 30,
        itemBuilder: (context, index) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                onItemSelected(index);
              },
              child: Container(
                height: 100,
                color: Colors.blue,
                child: Text('Item $index'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Detail $id'),
    );
  }
}
