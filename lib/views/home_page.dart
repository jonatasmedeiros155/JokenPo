import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedra, Papel, Tesoura',
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int playerScore = 0;
  int computerScore = 0;
  String playerMove = '';
  String computerMove = '';
  String resultMessage = '';

  void _playMove(String move) {
    setState(() {
      playerMove = move;
      computerMove = _getRandomMove();
      resultMessage = _determineWinner(playerMove, computerMove);
    });
  }

  String _getRandomMove() {
    final moves = ['Pedra', 'Papel', 'Tesoura'];
    return moves[Random().nextInt(3)];
  }

  String _determineWinner(String player, String computer) {
    if (player == computer) {
      return 'Empate';
    } else if ((player == 'Pedra' && computer == 'Tesoura') ||
        (player == 'Tesoura' && computer == 'Papel') ||
        (player == 'Papel' && computer == 'Pedra')) {
      playerScore++;
      return 'Você Ganhou';
    } else {
      computerScore++;
      return 'Computador Ganhou';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedra, Papel, Tesoura',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 34, 194),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScoreBoard(playerScore: playerScore, computerScore: computerScore),
          const SizedBox(height: 20),
          MoveDisplay(playerMove: playerMove, computerMove: computerMove),
          const SizedBox(height: 20),
          Text(
            resultMessage,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          MoveButtons(onMoveSelected: _playMove),
        ],
      ),
    );
  }
}

class ScoreBoard extends StatelessWidget {
  final int playerScore;
  final int computerScore;

  const ScoreBoard({super.key, required this.playerScore, required this.computerScore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text('Você', style: TextStyle(fontSize: 18)),
            Text(playerScore.toString(), style: const TextStyle(fontSize: 24)),
          ],
        ),
        Column(
          children: [
            const Text('PC', style: TextStyle(fontSize: 18)),
            Text(computerScore.toString(), style: const TextStyle(fontSize: 24)),
          ],
        ),
      ],
    );
  }
}

class MoveDisplay extends StatelessWidget {
  final String playerMove;
  final String computerMove;

  const MoveDisplay({super.key, required this.playerMove, required this.computerMove});

  IconData _getIconForMove(String move) {
    switch (move) {
      case 'Pedra':
        return FontAwesomeIcons.handFist;
      case 'Papel':
        return FontAwesomeIcons.hand;
      case 'Tesoura':
        return FontAwesomeIcons.handScissors;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(_getIconForMove(playerMove), size: 50),
        const SizedBox(height: 10),
        Icon(_getIconForMove(computerMove), size: 50),
      ],
    );
  }
}

class MoveButtons extends StatelessWidget {
  final Function(String) onMoveSelected;

  const MoveButtons({super.key, required this.onMoveSelected});


 @override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          IconButton(
            icon: Icon(FontAwesomeIcons.handFist),
            onPressed: () => onMoveSelected('Pedra'),
            iconSize: 50,
          ),
          Text('Pedra'),
        ],
      ),
      Column(
        children: [
          IconButton(
            icon: Icon(FontAwesomeIcons.hand),
            onPressed: () => onMoveSelected('Papel'),
            iconSize: 50,
          ),
          Text('Papel'),
        ],
      ),
      Column(
        children: [
          IconButton(
            icon: Icon(FontAwesomeIcons.handScissors),
            onPressed: () => onMoveSelected('Tesoura'),
            iconSize: 50,
          ),
          Text('Tesoura'),
        ],
      ),
    ],
  );
}
}