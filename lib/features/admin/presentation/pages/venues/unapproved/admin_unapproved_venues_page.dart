import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/admin/presentation/components/admin_events_card.dart';
import 'package:events_jo/features/admin/presentation/components/admin_event_list_loading_card.dart';
import 'package:events_jo/features/admin/presentation/components/empty_list.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapproved/admin_unapprove_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/venues/unapproved/admin_unapprove_states.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/unapproved/admin_unapproved_venue_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminUnapprovedVenuesPage extends StatefulWidget {
  const AdminUnapprovedVenuesPage({
    super.key,
  });

  @override
  State<AdminUnapprovedVenuesPage> createState() =>
      _AdminUnapprovedVenuesPageState();
}

class _AdminUnapprovedVenuesPageState extends State<AdminUnapprovedVenuesPage> {
  late final AdminUnapproveCubit adminUnapproveCubit;

  @override
  void initState() {
    super.initState();

    adminUnapproveCubit = context.read<AdminUnapproveCubit>();

    //start listening to unapproved venues stream
    adminUnapproveCubit.getUnapprovedWeddingVenuesStream();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminUnapproveCubit, AdminUnapproveStates>(
      builder: (context, state) {
        //done
        if (state is AdminUnapproveLoaded) {
          final venues = state.venues;

          if (venues.isEmpty) {
            return const EmptyList(
              icon: CustomIcons.grin_beam,
              text: 'No Requests for Wedding Venues left',
            );
          }

          return ListView.builder(
            itemCount: venues.length,
            shrinkWrap: false,
            itemBuilder: (context, index) {
              return AdminEventsCard(
                name: venues[index].name,
                owner: venues[index].ownerName,
                index: index,
                isApproved: venues[index].isApproved,
                isBeingApproved: venues[index].isBeingApproved,
                isLoading: false,
                //navigate to venue details
                onPressed: () => context.push(
                  AdminUnapprovedVenueDetailsPage(
                    adminUnapproveCubit: adminUnapproveCubit,
                    weddingVenue: venues[index],
                  ),
                ),
              );
            },
          );
        }
        //error
        if (state is AdminUnapproveError) {
          return Text(state.message);
        }
        //loading...
        else {
          return const AdminEventListLoadingCard();
        }
      },
      listener: (context, state) {
        //error
        if (state is AdminUnapproveError) {
          GSnackBar.show(
            context: context,
            text: state.message,
            gradient: GColors.adminGradient,
          );
        }

        //approval loading dialog
        if (state is AdminApproveActionLoading) {
          adminUnapproveCubit.showAdminActionsDialog(
            context,
            text: 'Approving the venue please wait...',
            animation: 'assets/animations/approve.json',
            color: GColors.approveColor,
          );
        }

        if (state is AdminApproveActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Venue Approved Successfully',
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }

        //denial loading dialog
        if (state is AdminDenyActionLoading) {
          adminUnapproveCubit.showAdminActionsDialog(
            context,
            text: 'Denying the venue please wait...',
            animation: 'assets/animations/delete.json',
            color: GColors.denyColor,
          );
        }

        if (state is AdminDenyActionLoaded) {
          Navigator.of(context).pop();
          GSnackBar.show(
            context: context,
            text: 'Venue Denyed Successfully',
            color: GColors.cyanShade6,
            gradient: GColors.adminGradient,
          );
        }
      },
    );
  }
}
