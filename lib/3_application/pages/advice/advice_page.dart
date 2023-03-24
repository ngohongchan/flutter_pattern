import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pattern/3_application/core/services/theme_service.dart';
// import 'package:flutter_pattern/3_application/pages/advice/bloc/bloc/advice_bloc.dart';
import 'package:flutter_pattern/3_application/pages/advice/bloc/cubit/cubit/advicer_cubit.dart';
import 'package:flutter_pattern/3_application/pages/advice/widgets/advice.dart';
import 'package:flutter_pattern/3_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter_pattern/3_application/pages/advice/widgets/error_message.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerCubit>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = Provider.of<ThemeService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advicer',
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) => provider.toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdvicerCubit, AdvicerCubitState>(
                  builder: (context, state) {
                    if (state is AdviceInitial) {
                      return Text(
                        'Your Advice is waiting for you!',
                        style: themeData.textTheme.displayLarge,
                      );
                    } else if (state is AdvicerStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdvicerStateLoaded) {
                      return AdviceField(
                        advice: state.advice,
                      );
                    } else if (state is AdvicerStateError) {
                      return ErrorMessage(
                        message: state.message,
                      );
                    }
                    return const SizedBox(
                      height: 20,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(
                  onTap: () =>
                      BlocProvider.of<AdvicerCubit>(context).adviceRequested(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
