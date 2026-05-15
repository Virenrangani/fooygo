import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/home/presentation/cubit/home_cubit.dart';
import 'package:foodygo/feature/home/presentation/cubit/home_state.dart';
import 'package:lottie/lottie.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  static const List<Map<String, String>> _categories = [
    {'label': 'Pizza',     'asset': 'assets/lotties/Pizza.json',    'key': 'pizza'},
    {'label': 'Burger',    'asset': 'assets/lotties/Burger.json',   'key': 'burger'},
    {'label': 'Salad',     'asset': 'assets/lotties/salad.json',    'key': 'salad'},
    {'label': 'Ice Cream', 'asset': 'assets/lotties/Ice cream.json', 'key': 'ice-cream'},
  ];

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, curr) =>
      curr is HomeLoaded || curr is HomeLoading,
      builder: (context, state) {
        final selected =
        state is HomeLoaded ? state.selectedCategory : 'pizza';

        return SizedBox(
          height: sw * 0.28,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => SizedBox(width: sw * 0.03),
            itemBuilder: (context, i) {
              final cat = _categories[i];
              final isSelected = selected == cat['key'];

              return GestureDetector(
                onTap: () =>
                    context.read<HomeCubit>().loadCategory(cat['key']!),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.03,
                    vertical: sw * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.deepOrange : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        cat['asset']!,
                        height: sw * 0.20,
                        width: sw * 0.20,
                        repeat: isSelected,
                        animate: true,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: sw * 0.01),
                      Text(
                        cat['label']!,
                        style: TextStyle(
                          fontSize: sw * 0.03,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}