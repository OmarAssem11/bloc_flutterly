import 'package:bloc_fluttery/constants/enums.dart';
import 'package:bloc_fluttery/logic/cubit/counter_cubit.dart';
import 'package:bloc_fluttery/logic/cubit/counter_state.dart';
import 'package:bloc_fluttery/logic/cubit/internet_cubit.dart';
import 'package:bloc_fluttery/logic/cubit/internet_state.dart';
import 'package:bloc_fluttery/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;
  static const routeName = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    final blocProvider = BlocProvider.of<CounterCubit>(context);
    return BlocConsumer<InternetCubit, InternetState>(
      listener: (internetCubitListenerContext, state) {
        if (state is InternetConnectedState &&
            state.connectionType == ConnectionType.wifi) {
          blocProvider.increment();
        } else if (state is InternetConnectedState &&
            state.connectionType == ConnectionType.mobile) {
          blocProvider.decrement();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: widget.color,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<InternetCubit, InternetState>(
                builder: (internetCubitBuilderContext, state) {
                  if (state is InternetConnectedState &&
                      state.connectionType == ConnectionType.wifi) {
                    return const Text('Wifi');
                  } else if (state is InternetConnectedState &&
                      state.connectionType == ConnectionType.mobile) {
                    return const Text('Mobile');
                  } else if (state is InternetDisconnectedState) {
                    return const Text('Disconnected');
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const Text('You have pushed the button this many times: '),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Decremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  }
                },
                builder: (context, state) => Text(
                  '${state.counterValue}',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: widget.color,
                    tooltip: 'Decrement',
                    onPressed: blocProvider.decrement,
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    backgroundColor: widget.color,
                    tooltip: 'Increment',
                    onPressed: blocProvider.increment,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Builder(
                builder: (materialButtonContext) => MaterialButton(
                  color: Colors.redAccent,
                  onPressed: () => Navigator.of(materialButtonContext)
                      .pushNamed(SecondScreen.routeName),
                  child: const Text('Go to second screen'),
                ),
              ),
              MaterialButton(
                color: Colors.greenAccent,
                onPressed: () => Navigator.of(homeScreenContext)
                    .pushNamed(SecondScreen.routeName),
                child: const Text('Go to second screen'),
              ),
            ],
          ),
        );
      },
    );
  }
}
