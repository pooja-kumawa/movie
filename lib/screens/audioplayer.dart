import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayButtonScreen extends StatefulWidget {
  @override
  _PlayButtonScreenState createState() => _PlayButtonScreenState();
}

class _PlayButtonScreenState extends State<PlayButtonScreen> {
  // Create an AudioCache instance for playing audio
  final AudioCache _audioCache = AudioCache();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  // Method to toggle play/pause
  void _toggleAudio() async {
    if (isPlaying) {
      // Pause the audio
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
      print("Audio paused");
    } else {
      // Play the audio
      await _audioPlayer.play(AssetSource('audio/welcome.mp3'));
      setState(() {
        isPlaying = true;
      });
      print("Audio playing...");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose(); // Properly dispose of the AudioPlayer instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play Button Screen'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: IconButton(
          onPressed: _toggleAudio, // Toggle play/pause when pressed
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow, // Switch icon based on playing state
            size: 100,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}
