import 'package:flutter/material.dart';
import 'package:test_app_webview/ui/mock/sport_food_mock/food_database.dart';
import 'package:test_app_webview/ui/mock/sport_food_mock/food_detail_screen.dart';

class Dishes extends StatefulWidget {
  const Dishes({super.key});

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> with AutomaticKeepAliveClientMixin {
  final FoodDatabase foodDatabase = FoodDatabase();
  final _searchController = TextEditingController();
  List<SearchFoodItem>? _foods;

  void _search() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      final foods = await foodDatabase.searchFood(query);
      setState(() {
        _foods = foods;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dishes"),
      ),
      body: Container(
        decoration: foodBackDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search food",
                ),
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _search,
                  child: const Text("Search"),
                ),
              ),
              const SizedBox(height: 16.0),
              if (_foods != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: _foods!.length,
                    itemBuilder: (context, index) {
                      final food = _foods![index];
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white30,
                        ),
                        margin: const EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(
                            food.name,
                            textScaleFactor: 1.1,
                          ),
                          subtitle: Text(food.brandName),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodDetailsScreen(
                                  foodDatabase: foodDatabase,
                                  id: food.id.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
