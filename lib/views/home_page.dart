import 'dart:math';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
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
        title: Text(
          'Pedra, Papel, Tesoura',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 34, 194),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScoreBoard(playerScore: playerScore, computerScore: computerScore),
          SizedBox(height: 20),
          MoveDisplay(playerMove: playerMove, computerMove: computerMove),
          SizedBox(height: 20),
          Text(
            resultMessage,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          MoveButtons(onMoveSelected: _playMove),
        ],
      ),
    );
  }
}

class ScoreBoard extends StatelessWidget {
  final int playerScore;
  final int computerScore;

  ScoreBoard({required this.playerScore, required this.computerScore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text('Você', style: TextStyle(fontSize: 18)),
            Text(playerScore.toString(), style: TextStyle(fontSize: 24)),
          ],
        ),
        Column(
          children: [
            Text('PC', style: TextStyle(fontSize: 18)),
            Text(computerScore.toString(), style: TextStyle(fontSize: 24)),
          ],
        ),
      ],
    );
  }
}

class MoveDisplay extends StatelessWidget {
  final String playerMove;
  final String computerMove;

  MoveDisplay({required this.playerMove, required this.computerMove});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Sua jogada: $playerMove'),
        SizedBox(height: 10),
        Text('Jogada do Computador: $computerMove'),
      ],
    );
  }
}

class MoveButtons extends StatelessWidget {
  final Function(String) onMoveSelected;

  MoveButtons({required this.onMoveSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => onMoveSelected('Pedra'),
          child: Text('Pedra'),
        ),
        ElevatedButton(
          onPressed: () => onMoveSelected('Papel'),
          child: Text('Papel'),
        ),
        ElevatedButton(
          onPressed: () => onMoveSelected('Tesoura'),
          child: Text('Tesoura'),
        ),
      ],
    );
  }
}