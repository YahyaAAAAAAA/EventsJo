import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading/global_loading_admin.dart';
import 'package:events_jo/features/admin/presentation/components/owners/admin_owner_summary.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20owner/admin_single_owner_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20owner/admin_single_owner_states.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOwnerDetailsPage extends StatefulWidget {
  final AppUser owner;

  const AdminOwnerDetailsPage({
    super.key,
    required this.owner,
  });

  @override
  State<AdminOwnerDetailsPage> createState() => _AdminOwnerDetailsPageState();
}

class _AdminOwnerDetailsPageState extends State<AdminOwnerDetailsPage> {
  //location cubit instance
  late final LocationCubit locationCubit;

  //location instance
  late final EjLocation ownerLocation;

  //owner stream
  late final AdminSingleOwnerCubit adminSingleOwnerCubit;

  @override
  void initState() {
    super.initState();

    adminSingleOwnerCubit = context.read<AdminSingleOwnerCubit>();

    locationCubit = context.read<LocationCubit>();

    //setup owner location values
    ownerLocation = EjLocation(
      lat: widget.owner.latitude,
      long: widget.owner.longitude,
      initLat: widget.owner.latitude,
      initLong: widget.owner.longitude,
    );

    adminSingleOwnerCubit.getOwnerStream(widget.owner.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(title: 'Owner Info'),
      body: Center(
        child: BlocConsumer<AdminSingleOwnerCubit, AdminSingleOwnerStates>(
          builder: (context, state) {
            //done
            if (state is AdminSingleOwnerLoaded) {
              return AdminOwnerSummary(
                name: state.owner!.name,
                email: state.owner!.email,
                id: state.owner!.uid,
                wasOwnerAndSwitched: state.owner!.wasOwnerAndNowUser,
                //todo should update location object
                showMap: () => locationCubit.showMapDialogPreview(context,
                    userLocation: ownerLocation,
                    gradient: GColors.adminGradient),
              );
            }
            //error
            if (state is AdminSingleOwnerError) {
              return Text(state.messege);
            }
            //loading...
            return const GlobalLoadingAdminBar(mainText: false);
          },
          listener: (context, state) {
            //change
            if (state is AdminSingleOwnerChanged) {
              GSnackBar.show(
                context: context,
                text: 'A change has occurred',
                color: GColors.cyanShade6,
                gradient: GColors.adminGradient,
              );
            }

            //error
            if (state is AdminSingleOwnerError) {
              GSnackBar.show(
                context: context,
                text: state.messege,
                gradient: GColors.adminGradient,
              );
            }
          },
        ),
      ),
    );
  }
}
