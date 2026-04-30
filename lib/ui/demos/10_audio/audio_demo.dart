import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/demos/10_audio/notifiers/play_button_notifier.dart';
import 'package:flutter_demo/ui/demos/10_audio/notifiers/progress_notifier.dart';
import 'package:flutter_demo/ui/demos/10_audio/notifiers/repeat_button_notifier.dart';
import 'package:flutter_demo/ui/demos/10_audio/page_manager.dart';

final PageManager _pageManager = PageManager();

class AudioApp extends StatelessWidget {
  const AudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            CurrentSongTitle(),
            Playlist(),
            AddRemoveSongButtons(),
            AudioProgressBar(),
            AudioControlButtons(),
          ],
        ),
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager.currentSongTitleNotifier,
      builder: (context, title, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: const TextStyle(fontSize: 40)),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _pageManager.playlistNotifier,
        builder: (context, playlistTitles, child) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(playlistTitles[index]));
            },
          );
        },
      ),
    );
  }
}

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _pageManager.add,
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _pageManager.remove,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (context, value, child) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: _pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = const Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = const Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(Icons.repeat);
            break;
        }
        return IconButton(icon: icon, onPressed: _pageManager.repeat);
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isFirstSongNotifier,
      builder: (context, isFirst, child) {
        return IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: isFirst ? null : _pageManager.previous,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.playButtonNotifier,
      builder: (context, value, child) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: const EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: const CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: const Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: const Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isLastSongNotifier,
      builder: (context, isLast, child) {
        return IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: isLast ? null : _pageManager.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: isEnabled
              ? const Icon(Icons.shuffle)
              : const Icon(Icons.shuffle, color: Colors.grey),
          onPressed: _pageManager.shuffle,
        );
      },
    );
  }
}
