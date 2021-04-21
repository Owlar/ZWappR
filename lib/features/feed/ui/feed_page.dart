import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/features/feed/services/i_favorite_service.dart';
import 'package:zwappr/features/feed/providers/feedback_position_provider.dart';
import 'package:zwappr/features/feed/services/favorite_service.dart';
import 'package:zwappr/features/feed/services/feed_service.dart';
import 'package:zwappr/features/feed/services/i_feed_service.dart';
import 'package:zwappr/features/things/models/thing_model.dart';
import 'package:zwappr/utils/colors/color_theme.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final IFeedService _feedService = FeedService();
  final IFavoriteService _favoriteService = FavoriteService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<ThingModel> things = List();
  Future<void> _thingsFromService;

  final Set _savedPotentialOffers = Set();
  ThingModel _offerThing;

  Future<void> _getThingsFromService() async {
    final List<ThingModel> thingsFromService = (await _feedService.getAll());
    things = thingsFromService;
  }

  Future<List<ThingModel>> _getOwnThingsFromService() async {
    final List<ThingModel> thingsFromService = (await _feedService.getAllOfMyOwn());
    return thingsFromService;
  }

  @override
  void initState() {
    _thingsFromService = _getThingsFromService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
              children: [
                SizedBox(height: 22),
                SvgPicture.asset("assets/icons/zwappr_logo.svg", height: 100),
                SizedBox(height: 22),
                Container(
                    height: 100,
                    child: FutureBuilder(
                      future: _getOwnThingsFromService(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.data.isEmpty) {
                          return Center(child: Text("Ingen gjenstander å tilby", style: TextStyle(fontSize: 18)));
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return StatefulBuilder(builder: (BuildContext context, StateSetter newStateForCard) {
                                final thing = snapshot.data[index];
                                return buildOwnThingCard(thing, context, newStateForCard, index);
                              });

                            },
                          );
                        }
                      },
                    )
                ),
                Expanded(
                  child: FutureBuilder(
                      future: _thingsFromService,
                      builder: (context, snapshot) {
                        return Stack(children: things.map(_buildThing).toList());
                      }
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(child: _swipeBottomButtons()),
                SizedBox(height: 10),
              ]
          )
      ),
    );
  }

  Card buildOwnThingCard(ThingModel thing, BuildContext context, StateSetter newStateForCard, int index) {
    return Card(
        child: Container(
          child: CheckboxListTile(
            title: Text("${thing.exchangeValue} kr"),
            checkColor: zwapprWhite,
            activeColor: zwapprBlue,
            contentPadding: EdgeInsets.all(2.0),
            onChanged: (bool value) {
              newStateForCard(() {
                if (value == true) {
                  // Should only be able to select one item as offer
                  _savedPotentialOffers.clear();
                  _savedPotentialOffers.add(index);
                  _offerThing = thing;
                } else {
                  _savedPotentialOffers.remove(index);
                }
                setState(() {});
              });
            },
            value: _savedPotentialOffers.contains(index),
          ),
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(thing.imageUrl),
            ),
          ),
        )
    );
  }

  Widget _buildThing(ThingModel thing) {
    final thingIndex = things.indexOf(thing);
    final isThingInFocus = thingIndex == things.length -1;

    return Listener(
        onPointerMove: (pointerEvent) {
          final provider = Provider.of<FeedbackPositionProvider>(context, listen: false);
          provider.updatePosition(pointerEvent.localDelta.dx);
        },
        onPointerCancel: (_) {
          final provider = Provider.of<FeedbackPositionProvider>(context, listen: false);
          provider.resetPosition();
        },
        onPointerUp: (_) {
          final provider = Provider.of<FeedbackPositionProvider>(context, listen: false);
          provider.resetPosition();
        },
        child: Draggable(
          child: _thingSwipingCard(thing: thing, isThingInFocus: isThingInFocus),
          feedback: Material(
            type: MaterialType.transparency,
            child: _thingSwipingCard(thing: thing, isThingInFocus: isThingInFocus),
          ),
          childWhenDragging: Container(),
          onDragEnd: (details) => _onDragEnd(details, thing),
        )
    );
  }

  Widget _thingSwipingCard({ThingModel thing, bool isThingInFocus}) {
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    final size = MediaQuery.of(context).size;
    final imageUrl = thing.imageUrl;

    return Container(
        height: size.height * 0.6,
        width: size.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, spreadRadius: 0.1),
                ],
                gradient: LinearGradient(
                  colors: [Colors.black12, zwapprBlack],
                  begin: Alignment.center,
                  stops: [0.1, 2],
                  end: Alignment.bottomCenter,
                )
            ),
            child: Stack(
              children: [
                Positioned(
                    right: 8,
                    left: 8,
                    bottom: 12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildThingInformation(thing: thing),
                        )
                      ],
                    )
                ),
                if (isThingInFocus) _buildLikeBadge(swipingDirection),
              ],
            )
        )
    );
  }

  Widget _buildLikeBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final angle = isSwipingRight ? -0.5 : 0.5;
    final color = isSwipingRight ? zwapprGreen : zwapprRed;

    if (swipingDirection == SwipingDirection.none)
      return Container();
    else {
      return Positioned(
          top: 20,
          right: isSwipingRight ? null : 20,
          left: isSwipingRight ? 20 : null,
          child: Transform.rotate(
              angle: angle,
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: zwapprWhite,
                    boxShadow: [
                      BoxShadow(color: zwapprBlack, spreadRadius: 0.2),
                    ],
                    border: Border.all(color: color, width: 5),
                  ),
                  child: Text(
                      isSwipingRight ? "Ja!" : "Nei!",
                      style: TextStyle(
                        color: color,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      )

                  )
              )
          )
      );
    }
  }

  Widget _buildThingInformation({@required ThingModel thing}) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 4),
              Text(
                "${thing.title}",
                style: TextStyle(color: zwapprWhite, fontSize: 34),
              ),
              SizedBox(height: 4),
              Text(
                "${thing.description}",
                style: TextStyle(color: zwapprWhite, fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                "${thing.exchangeValue} kr",
                style: TextStyle(color: zwapprWhite, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Brukstilstand: ${thing.condition}",
                style: TextStyle(color: zwapprWhite, fontSize: 14),
              ),
              Text(
                "Kategori: ${thing.category}",
                style: TextStyle(color: zwapprWhite, fontSize: 14),
              ),
            ]
        )
    );
  }

  Widget _swipeBottomButtons() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(4),
            child: Icon(Icons.close, color: zwapprRed, size: 60),
            color: zwapprBlack,
            onPressed: () {
              final _currentThing = things.last;
              _currentThing.isSwipedOff = true;
              setState(() {
                things.remove(_currentThing);
                _feedService.seenItem(_currentThing.uid);
              });
            },
          ),
          RaisedButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(4),
            child: Icon(Icons.favorite, color: zwapprYellow, size: 60),
            color: zwapprBlack,
            onPressed: () {
              final _currentThing = things.last;
              _currentThing.isLiked = true;
              if (_offerThing == null) {
                _showDialog("Obs!", "Vennligst velg en av dine egne gjenstander som tilbud");
              } else {
                setState(() {
                  things.remove(_currentThing);
                  _feedService.seenItem(_currentThing.uid);
                  _feedService.offerItemInExchangeForLikedItem(_offerThing, _currentThing.uid);
                  _favoriteService.create(_currentThing.uid);
                });
              }
            },
          ),
          RaisedButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(4),
            child: Icon(Icons.check, color: zwapprGreen, size: 60),
            color: zwapprBlack,
            onPressed: () {
              final _currentThing = things.last;
              _currentThing.isLiked = true;
              if (_offerThing == null) {
                _showDialog("Obs!", "Vennligst velg en av dine egne gjenstander som tilbud");
              } else {
                setState(() {
                  things.remove(_currentThing);
                  _feedService.seenItem(_currentThing.uid);
                  _feedService.offerItemInExchangeForLikedItem(_offerThing, _currentThing.uid);
                });
              }
            },
          ),
        ]
    );
  }

  // Source: https://api.flutter.dev/flutter/material/AlertDialog-class.html
  Future<void> _showDialog(String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(description),
                  ],
                )
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Godta"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
        );
      }
    );
  }

  _onDragEnd(DraggableDetails details, ThingModel thing) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      thing.isLiked = true;
      if (_offerThing == null) {
        _showDialog("Obs!", "Vennligst velg en av dine egne gjenstander som tilbud");
      } else {
        setState(() {
          things.remove(thing);
          _feedService.seenItem(thing.uid);
          _feedService.offerItemInExchangeForLikedItem(_offerThing, thing.uid);
        });
      }
    } else if (details.offset.dx < -minimumDrag) {
      thing.isSwipedOff = true;
      setState(() {
        things.remove(thing);
        _feedService.seenItem(thing.uid);
      });
    }

  }
  // Source: https://github.com/JohannesMilke/tinder_ui_clone_example

}