import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white)),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

bool toggleBool(bool oui) {
  return !oui;
}

String message = '';
int indexFond = 0;
bool menuPrincipal = true;
bool blanc = false;
int couleur = 0xFFFFC107;
int couleurTexte = 0xFF000000;
List<int> hexCouleurs = [
  0xFFE91E63,
  0xFFF44336,
  0xFFFF5722,
  0xFFFF9800,
  0xFFFFC107,
  0xFFFFEB3B,
  0xFFCDDC39,
  0xFF8BC34A,
  0xFF4CAF50,
  0xFF009688,
  0xFF00BCD4,
  0xFF03A9F4,
  0xFF2196F3,
  0xFF3F51B5,
  0xFF9C27B0,
  0xFF673AB7,
  0xFF607D8B,
  0xFF795548,
  0xFF9E9E9E,
  0xFFFFFFFF,
  0xFF000000
];

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Couleur', Icons.color_lens),
  Destination('Animation', Icons.wb_incandescent),
];

class _DestinationViewState extends State<DestinationView> {
  String message(int _index) {
    String res = 'Il y a un problème quelque part';
    switch (_index) {
      case 0:
        res = 'Voulez-vous utiliser un fond uni ?';
        break;
      case 1:
        res = 'Voulez-vous utiliser un fond animé ?';
        break;
      default:
        res = 'Il y a un problème quelque part';
    }
    return res;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(32.0),
            alignment: Alignment.center,
            child: Text(
              message(indexFond),
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            alignment: Alignment.center,
            child: OutlineButton(
              borderSide: BorderSide(
                color: Colors.amber[800],
                style: BorderStyle.solid,
              ),
              highlightedBorderColor: Colors.amber[800],
              child: Text(
                'Oui',
                style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.amber[800],
                ),
              ),
              onPressed: () {
                SystemChrome.setEnabledSystemUIOverlays([]);
                setState(() {
                  couleur = 0xFFFFC107;
                });
                switch (indexFond) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Uni()),
                    );
                    break;
                  case 1:
                    couleur = hexCouleurs[19];
                    blanc = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Message()),
                    );
                    break;
                  default:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Error()),
                    );
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UniState extends State<Uni> {
  List<Widget> listeCouleurs() {
    List<Widget> res = new List<Widget>();
    for (int i = 0; i <= 20; i++) {
      res.add(
        Container(
          padding: const EdgeInsets.all(8),
          color: Color(hexCouleurs[i]),
          child: IconButton(
            icon: Icon(Icons.check),
            color: Color(0x00000000),
            onPressed: () {
              if (i == 19) {
                blanc = true;
              } else {
                blanc = false;
              }
              setState(() {
                couleur = hexCouleurs[i];
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Message()),
              );
            },
            alignment: Alignment.center,
          ),
        ),
      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choisissez la couleur du fond',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            blanc = false;
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: listeCouleurs(),
      ),
    );
  }
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choisissez un message',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            blanc = false;
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Theme(
            data: ThemeData(
              primaryColor: Color(blanc ? hexCouleurs[20] : couleur),
            ),
            child: Container(
              padding: const EdgeInsets.all(32.0),
              alignment: Alignment.center,
              child: TextField(
                onChanged: (String value) {
                  message = value;
                },
                decoration: InputDecoration(
                  labelText: 'Entrez votre message',
                  labelStyle: TextStyle(
                    color: Color(blanc ? hexCouleurs[20] : couleur),
                  ),
                ),
                cursorColor: Color(blanc ? hexCouleurs[20] : couleur),
                onSubmitted: (String value) {
                  message = value;
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            alignment: Alignment.center,
            child: OutlineButton(
              borderSide: BorderSide(
                color: Color(blanc ? hexCouleurs[20] : couleur),
                style: BorderStyle.solid,
              ),
              highlightedBorderColor: Color(blanc ? hexCouleurs[20] : couleur),
              child: Text(
                'Suivant',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(blanc ? hexCouleurs[20] : couleur),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          indexFond == 0 ? CouleurMessage() : AffichageAnime()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CouleurMessageState extends State<CouleurMessage> {
  List<Widget> listeCouleursTextes() {
    List<Widget> res = new List<Widget>();
    for (int i = 0; i <= 20; i++) {
      res.add(
        Center(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5.0),
            child: FlatButton(
              color: Color(couleur),
              textColor: Color(hexCouleurs[i]),
              child: Text('$message'),
              onPressed: () {
                couleurTexte = hexCouleurs[i];
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AffichageUni()),
                );
              },
            ),
          ),
        ),
      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Choisissez la couleur du texte',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: listeCouleursTextes(),
        ),
      ),
    );
  }
}

class _AffichageUniState extends State<AffichageUni> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(couleur),
        child: Center(
          child: Text(
            '$message',
            style: TextStyle(
              fontSize: 35.0,
              color: Color(couleurTexte),
            ),
          ),
        ),
      ),
    );
  }
}

class _AffichageAnimeState extends State<AffichageAnime>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.red,
        end: Colors.green,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.green,
        end: Colors.blue,
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Colors.blue,
        end: Colors.red,
      ),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: background.evaluate(
              AlwaysStoppedAnimation(_controller.value),
            ),
            child: Center(
              child: Text(
                '$message',
                style: TextStyle(fontSize: 35.0, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Erreur',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          'C\'est cassé',
          style: TextStyle(fontSize: 50.0, color: Colors.red),
        ),
      ),
    );
  }
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: indexFond,
          children: allDestinations.map<Widget>((Destination destination) {
            return DestinationView(destination: destination);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[300],
        currentIndex: indexFond,
        onTap: (int index) {
          setState(() {
            indexFond = index;
          });
        },
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon), title: Text(destination.title));
        }).toList(),
      ),
    );
  }
}

class DestinationView extends StatefulWidget {
  const DestinationView({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class Uni extends StatefulWidget {
  @override
  _UniState createState() => _UniState();
}

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class CouleurMessage extends StatefulWidget {
  @override
  _CouleurMessageState createState() => _CouleurMessageState();
}

class AffichageUni extends StatefulWidget {
  @override
  _AffichageUniState createState() => _AffichageUniState();
}

class AffichageAnime extends StatefulWidget {
  AffichageAnime({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AffichageAnimeState createState() => _AffichageAnimeState();
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
