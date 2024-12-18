import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/admin/presentation/components/admin_app_bar.dart';
import 'package:events_jo/features/admin/presentation/components/menu_tab_bar.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/approve/admin_approve_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapprove/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/approved/admin_approved_venues.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/unapproved/admin_unapproved_venues.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPageForVenues extends StatefulWidget {
  const AdminPageForVenues({
    super.key,
  });

  @override
  State<AdminPageForVenues> createState() => _AdminPageForVenuesState();
}

class _AdminPageForVenuesState extends State<AdminPageForVenues>
    with SingleTickerProviderStateMixin {
  //user
  late final AppUser? user;

  late final AdminUnapproveCubit adminUnapproveCubit;
  late final AdminApproveCubit adminApproveCubit;

  late TabController tabController;

  @override
  void initState() {
    super.initState();

    user = context.read<AuthCubit>().currentUser;

    //get cubit
    adminUnapproveCubit = context.read<AdminUnapproveCubit>();
    adminApproveCubit = context.read<AdminApproveCubit>();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppBar(
        user: user,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: MenuTabBar(
            controller: tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          AdminUnapprovedVenues(
            adminUnapproveCubit: adminUnapproveCubit,
          ),
          AdminApprovedVenues(
            adminApproveCubit: adminApproveCubit,
          ),
        ],
      ),
      bottomNavigationBar: Divider(
        color: GColors.cyanShade6,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
      ),
    );
  }
}
