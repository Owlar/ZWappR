import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zwappr/features/feed/data/things.dart';
import 'package:zwappr/features/feed/models/thing.dart';
import 'package:zwappr/features/feed/services/feed_service.dart';
import 'package:zwappr/features/feed/services/i_feed_service.dart';
import 'package:zwappr/features/feed/providers/feedback_position_provider.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final IFeedService _feedService = FeedService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List<Thing> things = mockThings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background_screen.png"),
              fit: BoxFit.cover,
            ),*/
            padding: const EdgeInsets.all(8),
            child: Column(
                children: [
                  Stack(children: things.map(buildThing).toList()),
                  Expanded(child: Container())
                ]
            )
          ),
        );
  }

  Widget buildThing(Thing thing) {
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
        child: thingSwipingCard(thing: thing, isThingInFocus: isThingInFocus),
        feedback: Material(
          type: MaterialType.transparency,
          child: thingSwipingCard(thing: thing, isThingInFocus: isThingInFocus),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) => _onDragEnd(details, thing),
      )
    );
  }

  Widget thingSwipingCard({Thing thing, bool isThingInFocus}) {
    final provider = Provider.of<FeedbackPositionProvider>(context);
    final swipingDirection = provider.swipingDirection;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.6,
      width: size.width * 0.90,
      child: Container(
        child: Stack(
          children: [
            Positioned(
              right: 8,
              left: 8,
              bottom: 8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildThingInformation(thing: thing),
                ],
              )
            ),
            if (isThingInFocus) buildLikeBadge(swipingDirection),
          ],
        )
      )

    );
  }

  Widget buildLikeBadge(SwipingDirection swipingDirection) {
    final isSwipingRight = swipingDirection == SwipingDirection.right;
    final angle = isSwipingRight ? -0.6 : 0.6;

    if (swipingDirection == SwipingDirection.none) return Container();
    else {
      return Positioned(
        top: 10,
        right: isSwipingRight ? null : 20,
        left: isSwipingRight ? 20 : null,
        child: Transform.rotate(
          angle: angle,
          child: Container(
            padding: const EdgeInsets.all(8),
          )
        )
      );
    }
  }

  Widget buildThingInformation({Thing thing}) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${thing.title}",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Text(
              "${thing.description}",
              style: TextStyle(color: Colors.black, fontSize: 12),
            )
          ]
        )
    );
  }

  _onDragEnd(DraggableDetails details, Thing thing) {
    final minimumDrag = 100;
    if (details.offset.dx > minimumDrag) {
      thing.isSwipedOff = true;
    } else if (details.offset.dx < -minimumDrag) {
      thing.isLiked = true;
    }
    setState(() => things.remove(thing));
  }

// Source: https://github.com/Owlar/tinder_ui_clone_example/blob/master/lib/widget/user_card_widget.dart

}