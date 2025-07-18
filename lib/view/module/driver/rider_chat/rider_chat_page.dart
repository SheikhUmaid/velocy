import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocy_user_app/service/socket/chat_service.dart';
import 'package:velocy_user_app/utils/app_colors.dart';
import 'package:velocy_user_app/utils/svgImage.dart';
import 'package:velocy_user_app/utils/text_styles.dart';
import 'package:velocy_user_app/view/module/driver/rider_chat/component/recived_bubble.dart';
import 'package:velocy_user_app/view/module/driver/rider_chat/component/send_bubble.dart';

class RiderChatPage extends StatefulWidget {
  const RiderChatPage({super.key});

  @override
  State<RiderChatPage> createState() => _RiderChatPageState();
}

class _RiderChatPageState extends State<RiderChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late RideChatService _rideChatService;
  List<Map<String, String>> _messages = [];

  @override
  void initState() {
    _rideChatService = RideChatService();
    _rideChatService.connect(
      rideId: Get.arguments['rideId'],
      token: Get.arguments['token'],
    );
    _rideChatService.messages.listen((message) {
      setState(() {
        _messages.add(message);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _rideChatService.disconnect();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      _rideChatService.sendMessage(_messageController.text.trim());
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.appBlackColor,
                  size: 24,
                ),
              ),
              ClipOval(
                child: SvgPicture.asset(
                  SvgImage.profile.value,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Michael Rodriguez',
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                    ),
                  ),
                  Text(
                    'Arriving Soon',
                    style: AppTextStyle.small14SizeText.copyWith(
                      fontFamily: FontFamily.interRegular,
                      color: const Color.fromRGBO(115, 115, 115, 1),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(SvgImage.call.value, width: 16, height: 16),

              const SizedBox(width: 17),
              SvgPicture.asset(SvgImage.location.value, width: 16, height: 16),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ReceiverBubble(
                  message: 'I ll be there in about 5 minutes',
                  time: '10:23 AM',
                ),
                SendBubble(
                  message: "Great! I'm waiting near the coffee shop",
                  time: "10:24 AM",
                ),
                ReceiverBubble(
                  message: 'I ll be there in about 5 minutes',
                  time: '10:23 AM',
                ),
              ],
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            SvgPicture.asset(SvgImage.emojo.value, width: 20, height: 20),

            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(SvgImage.file.value, width: 20, height: 20),
            const SizedBox(width: 16),
            SvgPicture.asset(SvgImage.send.value, width: 20, height: 20),
          ],
        ),
      ),
    );
  }
}
