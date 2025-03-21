import 'package:shared_preferences/shared_preferences.dart';

class XPService {
  int _currentXP = 0;
  List<int> _rewardsUnlocked = [];
  SharedPreferences? _prefs;

  XPService() {
    _loadXP();
  }

  int get currentXP => _currentXP;
  List<int> get rewardsUnlocked => _rewardsUnlocked;

  Future<void> _loadXP() async {
    _prefs = await SharedPreferences.getInstance();
    _currentXP = _prefs?.getInt('user_xp') ?? 0;
    _rewardsUnlocked = _prefs?.getStringList('rewards_unlocked')?.map(int.parse).toList() ?? [];
  }

  Future<void> addXP(int amount) async {
    _currentXP += amount;

    // Check for new reward milestones at every 100 XP
    int milestone = (_currentXP ~/ 100) * 100;

    if (!_rewardsUnlocked.contains(milestone) && milestone > 0) {
      _rewardsUnlocked.add(milestone);
      await _prefs?.setStringList('rewards_unlocked', _rewardsUnlocked.map((e) => e.toString()).toList());

      // Optional: print or notify reward unlock
      // ignore: avoid_print
      print("🎉 Reward Unlocked at $milestone XP!");
    }

    await _prefs?.setInt('user_xp', _currentXP);
  }

  bool hasUnlocked(int milestone) {
    return _rewardsUnlocked.contains(milestone);
  }
}
