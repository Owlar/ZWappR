import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zwappr/features/activity/models/chat_message.dart';
import 'package:zwappr/features/activity/ui/pages/favorite_page.dart';
import 'package:zwappr/features/activity/ui/widgets/chat_info_person.dart';
import 'package:zwappr/features/activity/ui/widgets/list_view_msg.dart';
import 'package:zwappr/features/profile/ui/widgets/back_btn_blue.dart';
import 'package:zwappr/features/things/models/thing_model.dart';

void main() {
  // Define a test. The TestWidgets function also provides a WidgetTester
  // to work with. The WidgetTester allows building and interacting
  // with widgets in the test environment.

  test('Counter value should be incremented', () {
    final thing = ThingModel(title: "title", description: "description", imageUrl: "imageUrl", exchangeValue: "exchangeValue", condition: "condition", category: "category", latitude: 1, longitude: 2);
    expect(thing.title, "title");
    expect(thing.description, "description");
    expect(thing.imageUrl, "imageUrl");
    expect(thing.exchangeValue, "exchangeValue");
    expect(thing.condition, "condition");
    expect(thing.category, "category");
    expect(thing.latitude, 1);
    expect(thing.longitude, 2);

  });

 /* testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(FavoritePage());
  });
  testWidgets('ChatMessage has a List of messages', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    ChatMessage message1 = new ChatMessage(messageContent: "messageContent", messageType: "messageType");
    await tester.pumpWidget(ListViewMsg(messages: [message1],));


  });

    testWidgets('ChatInfoPerson has a Name and Image', (WidgetTester tester) async {
      // Create the widget by telling the tester to build it.

      await tester.pumpWidget(ChatInfoPerson(name: "name", image: "image"));

    });

  testWidgets('BackBtnBlue ', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.

    await tester.pumpWidget(BackBtnBlue());

  });
  testWidgets('BackBtnBlue ', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.

    await tester.pumpWidget(IconButton(icon: Icon(Icons.insert_photo), onPressed: (){}));

  });
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
  });*/
}
class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}