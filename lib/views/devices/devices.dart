import 'dart:io';

import 'package:e_tablo/core/extensions.dart';
import 'package:e_tablo/views/bluetooth_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:image_picker/image_picker.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({super.key});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  XFile? selectedImage;
  bool _isConnected = false;
  final ImagePicker picker = ImagePicker();
  BluetoothConnection? _connection;
  BluetoothDevice? _bluetoothDevice;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isConnectedAnyDevice();
  }

  Future<void> isConnectedAnyDevice() async {
    var connections = await FlutterBluetoothSerial.instance.getBondedDevices();
    if (connections.isNotEmpty) {
      // İlk eşleştirilmiş cihazı varsayılan olarak seçiyoruz
      for (var device in connections) {
        if (device.name == "HC-05") {
          connectToDevice(device);
        }
      }
    } else {
      // Eğer eşleştirilmiş cihaz yoksa, kullanıcıyı bağlantı sayfasına yönlendir
      setState(() {
        _isConnected = false;
      });
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await BluetoothConnection.toAddress(device.address);
      _bluetoothDevice = device;
      setState(() {
        _isConnected = true;
      });
    } catch (e) {
      print("Cannot connect, exception occurred");
      print(e);
    }
  }

  Future<List<int>> fileToBytes(File file) async {
    return file.readAsBytes();
  }

  Future<void> sendToDevice(File file) async {
    if (_connection != null && _connection!.isConnected) {
      print("OKEY CONNECT");
      final convertImage = await fileToBytes(file);
      _connection!.output.add(Uint8List.fromList(convertImage));
      await _connection!.output.allSent;
      print("Image sent");
    } else {
      print("No device connected");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tip dönüşümü kullanarak ImageProvider<Object> türüne dönüştürme
    ImageProvider<Object> imageProvider = (selectedImage != null
        ? FileImage(File(selectedImage!.path))
        : const AssetImage("assets/images/frame/frame.png")) as ImageProvider<Object>;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: const BoxDecoration(
                      image:
                          DecorationImage(fit: BoxFit.cover, image: AssetImage("assets/images/frame/frame-background.jpg"))),
                ),
                Positioned(
                  top: 60,
                  child: Container(
                    height: 160,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            selectedImage == null
                ? GestureDetector(
                    onTap: () async {
                      await pickImage();
                    },
                    child: Column(
                      children: [
                        Text(
                          "Upload Image from Gallery",
                          style: context.texts.titleMedium,
                        ),
                        const Icon(
                          Icons.cloud_upload_outlined,
                          size: 50,
                        )
                      ],
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _isConnected
                          ? ElevatedButton(
                              onPressed: () async {
                                await sendToDevice(File(selectedImage!.path));
                              },
                              child: const Text("Show in Table"),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                _bluetoothDevice = await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => const ConnectBluetoothDevice()));
                                connectToDevice(_bluetoothDevice!);
                              },
                              child: const Text("Connect to Device"),
                            ),
                      TextButton(
                          onPressed: () {
                            setState(() => selectedImage = null);
                          },
                          child: const Text("Select a different image"))
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
