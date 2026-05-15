import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:foodygo/feature/wallet/presentation/cubit/wallet_state.dart';
import 'package:get_it/get_it.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  static const List<Map<String, dynamic>> _amounts = [
    {'label': '\$100',  'amount': 100},
    {'label': '\$500',  'amount': 500},
    {'label': '\$1000', 'amount': 1000},
    {'label': '\$2000', 'amount': 2000},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<WalletCubit>()..loadWallet(),
      child: const _WalletView(),
    );
  }
}

class _WalletView extends StatelessWidget {
  const _WalletView();

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: BlocConsumer<WalletCubit, WalletState>(
        listener: (context, state) {
          if (state is WalletUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepOrange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                content: Row(
                  children: [
                    const Icon(Icons.wallet, color: Colors.white),
                    SizedBox(width: sw * 0.02),
                    Expanded(
                      child: Text(
                        '\$${state.addedAmount} added successfully',
                        style: TextStyle(
                          fontSize: sw * 0.038,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final balance = switch (state) {
            WalletLoaded() => state.balance,
            WalletUpdating() => state.balance,
            WalletUpdateSuccess() => state.balance,
            _ => 0,
          };

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [

              // ================= APP BAR =================

              SliverAppBar(
                expandedHeight: sh * 0.24,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.deepOrange,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(
                    left: sw * 0.05,
                    bottom: sh * 0.02,
                  ),
                  title: Text(
                    "My Wallet",
                    style: TextStyle(
                      fontSize: sw * 0.055,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [

                      // BACKGROUND GRADIENT
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF6A00),
                              Color(0xFFFF8E53),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),

                      // GLOW EFFECT
                      Positioned(
                        top: -40,
                        right: -20,
                        child: Container(
                          width: sw * 0.5,
                          height: sw * 0.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(sw * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ================= BALANCE CARD =================

                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0.8, end: 1),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutBack,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Container(
                          width: sw,
                          padding: EdgeInsets.all(sw * 0.06),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF1E1E1E),
                                Color(0xFF2B2B2B),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.18),
                                blurRadius: 25,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(sw * 0.025),
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius:
                                      BorderRadius.circular(14),
                                    ),
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.orange,
                                      size: sw * 0.08,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.more_horiz,
                                    color: Colors.white70,
                                    size: sw * 0.08,
                                  ),
                                ],
                              ),

                              SizedBox(height: sh * 0.03),

                              Text(
                                "Available Balance",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: sw * 0.04,
                                ),
                              ),

                              SizedBox(height: sh * 0.008),

                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0,
                                  end: balance.toDouble(),
                                ),
                                duration:
                                const Duration(milliseconds: 1200),
                                builder: (context, value, child) {
                                  return Text(
                                    "\$${value.toStringAsFixed(0)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: sw * 0.09,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: sh * 0.04),

                      // ================= TITLE =================

                      Text(
                        "Quick Add",
                        style: TextStyle(
                          fontSize: sw * 0.052,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: sh * 0.02),

                      // ================= AMOUNT GRID =================

                      GridView.builder(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        itemCount: WalletPage._amounts.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: sw * 0.04,
                          mainAxisSpacing: sh * 0.02,
                          childAspectRatio: 2.4,
                        ),
                        itemBuilder: (context, index) {
                          final item = WalletPage._amounts[index];

                          return InkWell(
                            borderRadius:
                            BorderRadius.circular(22),
                            onTap: () {
                              context
                                  .read<WalletCubit>()
                                  .addMoney(item['amount']);
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(22),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange.shade100,
                                    Colors.deepOrange.shade50,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange
                                        .withOpacity(0.15),
                                    blurRadius: 18,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  item['label'],
                                  style: TextStyle(
                                    fontSize: sw * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: sh * 0.04),

                      // ================= BUTTON =================

                      state is WalletUpdating
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepOrange,
                        ),
                      )
                          : SizedBox(
                        width: sw,
                        height: sh * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.deepOrange,
                            elevation: 10,
                            shadowColor: Colors.deepOrange
                                .withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(22),
                            ),
                          ),
                          onPressed: () {
                            context
                                .read<WalletCubit>()
                                .addMoney(100);
                          },
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle,
                                color: Colors.white,
                                size: sw * 0.06,
                              ),
                              SizedBox(width: sw * 0.025),
                              Text(
                                "ADD MONEY",
                                style: TextStyle(
                                  fontSize: sw * 0.045,
                                  fontWeight:
                                  FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: sh * 0.05),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}