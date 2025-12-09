import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  late IO.Socket socket;

  var messages = <Map<String, dynamic>>[].obs;
  var messageController = "".obs;

  @override
  void onInit() {
    super.onInit();
    connectToSocket();
  }

  void connectToSocket() {
    socket = IO.io(
      "https://your-server-url.com", // YOUR BACKEND
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("Socket Connected");
    });

    socket.on("receive_message", (data) {
      messages.add(data);
    });
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    Map<String, dynamic> msg = {
      "senderId": "driver123",
      "receiverId": "user999",
      "message": text,
      "time": "${DateTime.now().hour}:${DateTime.now().minute}"
    };

    socket.emit("send_message", msg);
    messages.add(msg);
    messageController.value = "";
  }
}
