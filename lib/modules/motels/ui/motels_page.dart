import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:guia_moteis_app/modules/motels/ui/bloc/get_motels_bloc.dart';

import 'bloc/get_motels_event.dart';
import 'bloc/motels_state.dart';
import 'widgets/motel_card_widget.dart';

class MotelsPage extends StatefulWidget {
  const MotelsPage({super.key});

  @override
  State<MotelsPage> createState() => _MotelsPageState();
}

class _MotelsPageState extends State<MotelsPage> {
  final motelsBloc = GetIt.I.get<GetMotelsBloc>();

  @override
  void initState() {
    motelsBloc.add(FetchMotels());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Ir agora',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<GetMotelsBloc, ListMotelsState>(
        bloc: motelsBloc,
        builder: (context, state) {
          if (state is LoadingListMotelsState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoadedMotelsState) {
            return ListView.builder(
              key: Key('motels_list'),
              padding: EdgeInsets.all(24),
              itemCount: state.motel.moteis.length,
              itemBuilder: (_, index) {
                return MotelCardWidget(motel: state.motel.moteis[index]);
              },
            );
          }

          if (state is ErrorMotelsState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
