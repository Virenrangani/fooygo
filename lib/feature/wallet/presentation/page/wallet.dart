import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodygo/feature/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:foodygo/feature/wallet/presentation/cubit/wallet_state.dart';
import 'package:get_it/get_it.dart';
import '../widget/amount_button.dart';
import '../widget/wallet_balance_card.dart';

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
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocConsumer<WalletCubit, WalletState>(
        listener: (context, state) {
          if (state is WalletUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.deepOrange,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                content: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      '\$${state.addedAmount} added to your wallet!',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is WalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          final balance = switch (state) {
            WalletLoaded()        => state.balance,
            WalletUpdating()      => state.balance,
            WalletUpdateSuccess() => state.balance,
            _                     => 0,
          };

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: sw,
                    padding: EdgeInsets.symmetric(
                      vertical: sh * 0.025,
                      horizontal: sw * 0.06,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'My Wallet',
                      style: TextStyle(
                        fontSize: sw * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (state is WalletLoading)
                    SizedBox(
                      height: sh * 0.2,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: Colors.deepOrange),
                      ),
                    )
                  else
                    WalletBalanceCard(balance: balance),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Money',
                          style: TextStyle(
                            fontSize: sw * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: sh * 0.015),

                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: sw * 0.04,
                          mainAxisSpacing: sh * 0.02,
                          childAspectRatio: 2.5,
                          children: WalletPage._amounts
                              .map(
                                (a) => AmountButton(
                              label: a['label'],
                              amount: a['amount'],
                              onTap: () => context
                                  .read<WalletCubit>()
                                  .addMoney(a['amount']),
                            ),
                          )
                              .toList(),
                        ),
                        SizedBox(height: sh * 0.03),

                        state is WalletUpdating
                            ? const Center(
                          child: CircularProgressIndicator(
                              color: Colors.deepOrange),
                        )
                            : SizedBox(
                          width: sw,
                          height: sh * 0.065,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                              ),
                              elevation: 4,
                            ),
                            onPressed: () => context
                                .read<WalletCubit>()
                                .addMoney(100),
                            child: Text(
                              'ADD MONEY',
                              style: TextStyle(
                                fontSize: sw * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: sh * 0.03),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}