import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/core/router/animate_navigation_route.dart';
import 'package:foodygo/feature/home/presentation/cubit/home_cubit.dart';
import 'package:foodygo/feature/home/presentation/cubit/home_state.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/storage/shared_pref/shared_pref_service.dart';
import '../../domain/food_entity/food_entity.dart';
import '../widget/category_chips.dart';
import '../widget/food_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userId;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    userId   = await SharedPrefService.getUserId();
    userName = await SharedPrefService.getUserName();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HomeCubit>()..loadCategory('pizza'),
      child: _HomeView(userId: userId, userName: userName),
    );
  }
}

class _HomeView extends StatelessWidget {
  final String? userId;
  final String? userName;

  const _HomeView({required this.userId, required this.userName});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.06,
                  vertical: sh * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${userName ?? 'Foodie'} 👋',
                              style: TextStyle(
                                fontSize: sw * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'What are you craving today?',
                              style: TextStyle(
                                fontSize: sw * 0.035,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(sw * 0.006),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child:
                          IconButton(
                            icon:Icon(Icons.shopping_bag_outlined,size: sw * 0.07),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(context, AnimateNavigationRoute.cartRoute());
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: sh * 0.025),

                    const CategoryChips(),
                    SizedBox(height: sh * 0.02),

                    Text(
                      'Popular Items',
                      style: TextStyle(
                        fontSize: sw * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: sh * 0.01),
                  ],
                ),
              ),
            ),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeInitial || state is HomeLoading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ),
                  );
                }

                if (state is HomeError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: Colors.red),
                          const SizedBox(height: 8),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is HomeLoaded && state.foods.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('No items found in this category.'),
                    ),
                  );
                }

                final foods =
                state is HomeLoaded ? state.foods : <FoodEntity>[];

                return SliverPadding(
                  padding:
                  EdgeInsets.symmetric(horizontal: sw * 0.06),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => FoodCard(
                        food: foods[index],
                        userId: userId,
                      ),
                      childCount: foods.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}