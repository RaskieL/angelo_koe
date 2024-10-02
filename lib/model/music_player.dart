import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'dart:async';

import 'explorer.dart';

class MusicPlayer {
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  bool get _isPlaying => currentAudioState == PlayerState.playing;

  bool get _isPaused => currentAudioState == PlayerState.paused;

  String get _durationText => currentAudioDuration.toString().split('.').first;

  String get _positionText => currentAudioTimeStamp.toString().split('.').first;

  Duration currentAudioDuration;
  Duration currentAudioTimeStamp;
  String currentAudioName;
  PlayerState currentAudioState;

  List<File> audioSources = [];
  final player = AudioPlayer();

  MusicPlayer(
      {this.currentAudioState = PlayerState.stopped,
      this.currentAudioDuration = Duration.zero,
      this.currentAudioName = "",
      this.currentAudioTimeStamp = Duration.zero}) {
    player.setReleaseMode(ReleaseMode.stop);
    initPlayer();
  }

  Future<List<File>> getSources() async {
    audioSources = await findAudioFiles(root.dataType as Directory);
    return audioSources;
  }

  Future<List<File>> getSourcesFromDir(Directory dir) async {
    audioSources = await findAudioFiles(dir);
    return audioSources;
  }

  void loadSource(File file) {
    currentAudioState = PlayerState.paused;
    player.setSource(AssetSource(file.path));
  }

  Future<void> play() async {
    await player.resume();
    currentAudioState = PlayerState.playing;
  }

  Future<void> pause() async {
    await player.pause();
    currentAudioState = PlayerState.paused;
  }

  Future<void> stop() async {
    await player.stop();
    currentAudioState = PlayerState.stopped;
  }

  void initPlayer() {
    _durationSubscription = player.onDurationChanged
        .listen((duration) => currentAudioDuration = duration);

    _positionSubscription =
        player.onPositionChanged.listen((p) => currentAudioTimeStamp = p);

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      currentAudioState = PlayerState.stopped;
      currentAudioDuration = Duration.zero;
    });

    _playerStateChangeSubscription = player.onPlayerStateChanged
        .listen((state) => currentAudioState = state);
  }
}
