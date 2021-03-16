import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/features/feed/providers/feedback_position_provider.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<ThingModel> things = List();

  Future<void> _getThingsFromService() async {
    final List<ThingModel> thingsFromService = (await _feedService.getAll());
    things = thingsFromService;
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
                  Expanded(
                    child: FutureBuilder(
                      future: _getThingsFromService(),
                      builder: (context, snapshot) {
                        return Stack(children: things.map(_buildThing).toList());
                      }
                    ),
                  ),
                  SizedBox(child: _swipeBottomButtons()),
                  SizedBox(height: 22),
                ]
            )
          ),
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

    return Container(
      height: size.height * 0.5,
      width: size.width * 0.90,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: zwapprWhite,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 0.6),
          ],
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.white10],
            begin: Alignment.center,
            stops: [0.4, 1],
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
              border: Border.all(color: color, width: 3),
            ),
            child: Text(
              isSwipingRight ? "YES!" : "NO!",
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
            Center(
              child: Image.network(thing.imageUrl, height: 248),
            ),
            SizedBox(height: 10),
            Text(
              "${thing.title}",
              style: TextStyle(color: zwapprBlack, fontSize: 30),
            ),
            SizedBox(height: 10),
            Text(
              "${thing.description}",
              style: TextStyle(color: zwapprBlack, fontSize: 18),
            )
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
          child: Icon(Icons.close, color: zwapprRed, size: 70),
          color: zwapprBlack,
          onPressed: () {
          },
        ),
        SizedBox(width: 10),
        RaisedButton(
          shape: CircleBorder(),
          padding: const EdgeInsets.all(4),
          child: Icon(Icons.star, color: zwapprYellow, size: 70),
          color: zwapprBlack,
          onPressed: () {

          },
        ),
        SizedBox(width: 10),
        RaisedButton(
          shape: CircleBorder(),
          padding: const EdgeInsets.all(4),
          child: Icon(Icons.favorite, color: zwapprBlue, size: 70),
          color: zwapprBlack,
          onPressed: () {

          },
        ),
      ]
    );
  }

  _onDragEnd(DraggableDetails details, ThingModel thing) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      thing.isSwipedOff = true;
    } else if (details.offset.dx < -minimumDrag) {
      thing.isLiked = true;
    }
    setState(() {
      things.remove(thing);
      print(thing.uid);
      _feedService.delete(thing.uid);
    });
  }
  // Source: https://github.com/Owlar/tinder_ui_clone_example/blob/master/lib/widget/user_card_widget.dart

}