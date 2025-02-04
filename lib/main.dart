import 'package:flutter/material.dart';
import 'decrypt.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  String _encryptData = "";
  String _decryptData = "";
  String _aesKey = "";
  String _aesIV = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Explore Encrypt & Decrypt"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _textEditingController),
            TextButton(
              onPressed: () async {
                String result = await MyEncryptionDecryption()
                    .encryptt(data: _textEditingController.text);
                setState(() {
                  _encryptData = result;
                  _aesKey = MyEncryptionDecryption().aesKey;
                  _aesIV = MyEncryptionDecryption().ivUsedForEncryption.base64;
                });
              },
              child: const Text("Encrypt"),
            ),
            Text("Encrypted Text: $_encryptData"),
            if (_aesKey.isNotEmpty) Text("AES Key: $_aesKey"),
            if (_aesIV.isNotEmpty) Text("AES IV: $_aesIV"),
            TextButton(
              onPressed: _encryptData.isEmpty ? null : () async {
                String decryptedData = await MyEncryptionDecryption()
                    .decryptt(data: _encryptData);
                setState(() {
                  _decryptData = decryptedData;
                });
              },
              child: const Text("Decrypt"),
            ),
            Text("Decrypted Text: $_decryptData"),
          ],
        ),
      ),
    );
  }
}
