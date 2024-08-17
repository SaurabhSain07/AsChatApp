import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class ZegoCloudRecording {
  final String appID = 'Your ZEGOCLOUD AppID';
  final String appSecret = 'Your ZEGOCLOUD AppSecret';
  final String awsAccessKeyId = 'Your AWS_ACCESS_KEY_ID';
  final String awsSecretAccessKey = 'Your AWS_SECRET_ACCESS_KEY';
  final String bucketName = 'Your S3 Bucket Name';
  final String region = 'Your S3 Bucket Region';

  String generateSignature(int timestamp) {
    final data = utf8.encode('$appID$timestamp');
    final key = utf8.encode(appSecret);
    final hmacSha1 = Hmac(sha1, key);
    final digest = hmacSha1.convert(data);
    return digest.toString();
  }

  Future<void> startCloudRecording(String userId, String roomId) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final signature = generateSignature(timestamp);

    final url = Uri.parse('https://api.zegocloud.com/v1/app/$appID/recording/start');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Signature': signature,
        'Timestamp': timestamp.toString(),
      },
      body: jsonEncode({
        'user_id': userId,
        'room_id': roomId,
        'output_dir': 's3://$bucketName/recordings/',
        'aws_access_key_id': awsAccessKeyId,
        'aws_secret_access_key': awsSecretAccessKey,
        'aws_region': region,
      }),
    );

    if (response.statusCode == 200) {
      print('Cloud recording started successfully');
      print('Response: ${response.body}');
    } else {
      print('Failed to start cloud recording');
      print('Response: ${response.statusCode} - ${response.body}');
    }
  }
}

void main() async {
  final zegoRecording = ZegoCloudRecording();

  // Replace with actual UserID and RoomID
  final userId = 'UserID';
  final roomId = 'RoomID';

  await zegoRecording.startCloudRecording(userId, roomId);
}
