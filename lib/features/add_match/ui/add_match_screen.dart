import 'package:flutter/material.dart';

import '../../../core/themes/text_styles/bebas_text_styles.dart';
import '../../../core/utils/spacing.dart';
import 'widgets/add_match_app_bar.dart';
import 'widgets/add_match_bloc_consumer.dart';
import 'widgets/player_select_field/player_select_field.dart';
import 'widgets/score_input_field/score_count_field.dart';

class AddMatchScreen extends StatefulWidget {
  const AddMatchScreen({super.key});

  @override
  State<AddMatchScreen> createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  int winnerScore = 0;
  int loserScore = 0;
  String? winnerPlayer;
  String? loserPlayer;

  void _onWinnerScoreChanged(int score) {
    setState(() {
      winnerScore = score;
      if (loserScore > winnerScore) {
        loserScore = winnerScore;
      }
    });
  }

  void _onLoserScoreChanged(int score) {
    setState(() {
      loserScore = score;
    });
  }

  void _onWinnerPlayerChanged(String playerId) {
    setState(() {
      winnerPlayer = playerId;
    });
  }

  void _onLoserPlayerChanged(String playerId) {
    setState(() {
      loserPlayer = playerId;
    });
  }

  bool get _isAddButtonEnabled =>
      winnerScore > loserScore &&
      winnerPlayer != null &&
      loserPlayer != null &&
      winnerPlayer != loserPlayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AddMatchAppBar(),
          Expanded(
            child: Column(
              children: [
                verticalSpacing(20),
                Text(
                  'Select Players and Scores',
                  style: BebasTextStyles.whiteBold24.copyWith(
                    wordSpacing: 1.5,
                    color: Colors.grey.shade300,
                  ),
                ),
                verticalSpacing(20),
                PlayerSelectField(
                  hint: 'Select Winner',
                  onSelected: _onWinnerPlayerChanged,
                  excludedPlayer: loserPlayer,
                ),
                verticalSpacing(5),
                ScoreCountField(
                  accentColor: Colors.green,
                  initialScore: winnerScore,
                  onScoreChanged: _onWinnerScoreChanged,
                ),
                verticalSpacing(50),
                PlayerSelectField(
                  hint: 'Select Loser',
                  onSelected: _onLoserPlayerChanged,
                  excludedPlayer: winnerPlayer,
                ),
                verticalSpacing(5),
                ScoreCountField(
                  accentColor: Colors.red,
                  initialScore: loserScore,
                  onScoreChanged: _onLoserScoreChanged,
                  maxScore: winnerScore,
                ),
                verticalSpacing(50),
                AddMatchBlocConsumer(
                  isAddButtonEnabled: _isAddButtonEnabled,
                  winnerPlayer: winnerPlayer,
                  loserPlayer: loserPlayer,
                  winnerScore: winnerScore,
                  loserScore: loserScore,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
