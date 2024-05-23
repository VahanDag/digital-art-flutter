import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ConnectBluetoothDevice extends StatefulWidget {
  const ConnectBluetoothDevice({super.key});

  @override
  Connect_BluetoothStateDevice createState() => Connect_BluetoothStateDevice();
}

class Connect_BluetoothStateDevice extends State<ConnectBluetoothDevice> {
  final List<BluetoothDiscoveryResult> _devices = [];
  late bool _isDiscovering;

  @override
  void initState() {
    super.initState();
    _isDiscovering = true;
    _startDiscovery();
  }

  void _startDiscovery() {
    _devices.clear();

    FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      print("IS HERE $r");
      setState(() {
        _devices.add(r);
      });
    }).onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  Future<void> _connect(BluetoothDevice device) async {
    try {
      await FlutterBluetoothSerial.instance.bondDeviceAtAddress(device.address);
      BluetoothConnection connection = await BluetoothConnection.toAddress(device.address);
      print('Connected to the device');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cihaza Bağlandı: ${device.name}")));

      Navigator.pop(context, device);
    } catch (exception) {
      print('Cannot connect, exception occurred');
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Bluetooth Devices'),
        actions: [
          (_isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: _startDiscovery,
                ))
        ],
      ),
      body: ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          BluetoothDiscoveryResult result = _devices[index];
          return BluetoothDeviceListEntry(
            device: result.device,
            rssi: result.rssi,
            onPressed: () => _connect(result.device),
          );
        },
      ),
    );
  }
}

class BluetoothDeviceListEntry extends ListTile {
  BluetoothDeviceListEntry({super.key, BluetoothDevice? device, int? rssi, void Function()? onPressed})
      : super(
          title: Text(device?.name ?? "Bilinmeyen cihaz"),
          subtitle: Text(device?.address.toString() ?? "BOŞ"),
          onTap: onPressed,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(rssi.toString()),
              const Icon(Icons.signal_cellular_4_bar),
            ],
          ),
        );
}
