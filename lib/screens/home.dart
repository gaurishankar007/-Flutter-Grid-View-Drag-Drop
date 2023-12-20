import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/button.dart';
import '../cubit/drag_drop_cubit.dart';
import '../injector.dart';
import '../widgets/add_section_dialog.dart';
import '../widgets/grid_container.dart';
import '../widgets/seat_type_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final DragDropCubit cubit;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<DragDropCubit>(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(milliseconds: 500));
      if (context.mounted) {
        cubit.setVehicleData(context);
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, size.pSH(40)),
        child: AppBar(),
      ),
      body: BlocBuilder<DragDropCubit, DragDropState?>(
        builder: (builder, state) {
          if (state is DragDropState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SeatTypeContainer(
                    crossAxisCount: state.crossAxisCount,
                    paddingH: state.paddingH,
                    gridGap: state.gridGap,
                    vWidth: state.vWidth,
                    height: state.seatTypeH,
                    angle: state.angle,
                    sTypes: state.sTypes,
                  ),
                  if (!loading)
                    SizedBox(
                      width: double.maxFinite,
                      height: state.gridHeight + state.gridTM,
                      child: SingleChildScrollView(
                        controller: state.sController,
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GridContainer(
                              sController: state.sController,
                              gridTM: state.gridTM,
                              paddingH: state.paddingH,
                              gridGap: state.gridGap,
                              crossAxisCount: state.crossAxisCount,
                              mainAxisCount: state.mainAxisCount,
                              angle: state.angle,
                              sections: state.sections,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () => addSection(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.add, size: 20),
                                    SizedBox(width: 10),
                                    Text(
                                      "Add Section",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (state.buttonH != 0 && !loading)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: state.buttonH / 6),
                      height: state.buttonH,
                      child: CusButton(
                        text: "Save Draft",
                        onTap: () {},
                      ),
                    )
                  else
                    SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
