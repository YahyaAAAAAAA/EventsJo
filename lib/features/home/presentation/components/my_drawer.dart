import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/my_drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              // const SizedBox(
              //   height: 50,
              // ),

              //logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              //divider
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),

              //home tile
              MyDrawerTile(
                icon: Icons.home,
                onTap: () => Navigator.of(context).pop(),
                title: 'H O M E',
              ),

              //profile tile

              //search tile
              MyDrawerTile(
                icon: Icons.search,
                onTap: () {},
                title: 'S E A R C H',
              ),

              //settings tile
              MyDrawerTile(
                icon: Icons.settings,
                onTap: () {},
                title: 'S E T T I N G S',
              ),

              const Spacer(),

              //logout tile
              MyDrawerTile(
                icon: Icons.logout,
                onTap: () => context.read<AuthCubit>().logout(),
                title: 'L O G O U T',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
