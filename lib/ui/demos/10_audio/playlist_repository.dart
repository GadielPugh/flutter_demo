class PlaylistRepository {
  static const _prefix = 'https://www.soundhelix.com/examples/mp3';
  int _nextSongNumber = 4;

  Future<List<Map<String, String>>> fetchInitialPlaylist() async {
    return [_song(1), _song(2), _song(3)];
  }

  Future<Map<String, String>> fetchAnotherSong() async {
    final song = _song(_nextSongNumber);
    _nextSongNumber += 1;
    if (_nextSongNumber > 16) {
      _nextSongNumber = 1;
    }
    return song;
  }

  Map<String, String> _song(int number) {
    return {
      'id': '$number',
      'album': 'SoundHelix',
      'title': 'Song $number',
      'url': '$_prefix/SoundHelix-Song-$number.mp3',
    };
  }
}
