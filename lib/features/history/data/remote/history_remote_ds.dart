import 'package:im_legends/core/error/types/error_handler.dart';
import 'package:im_legends/features/history/data/models/match_history_card_model.dart';

import '../../../../core/networking/supabase_service.dart';

class HistoryRemoteDs {
  final SupabaseService supabaseService;

  HistoryRemoteDs({required this.supabaseService});

  Future<List<MatchHistoryCardModel>> fetchAllMatches() async {
    try {
      final response = await supabaseService.client
          .from('matches')
          .select('''
        id,
        winner_score,
        loser_score,
        created_at,
        winner:users!matches_winner_fkey (
          id,
          name,
          profile_image
        ),
        loser:users!matches_loser_fkey (
          id,
          name,
          profile_image
        )
      ''')
          .order('created_at', ascending: false);

      return (response as List)
          .map((final json) => MatchHistoryCardModel.fromJson(json))
          .toList();
    } catch (e) {
      ErrorHandler.handle(e);
    }
  }
}
