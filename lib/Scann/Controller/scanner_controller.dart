import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BleController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

  Future<void> requestPermissions() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      await Permission.locationWhenInUse.request();
    }
    var bluetoothScanStatus = await Permission.bluetoothScan.status;
    if (!bluetoothScanStatus.isGranted) {
      await Permission.bluetoothScan.request();
    }
    var bluetoothConnectStatus = await Permission.bluetoothConnect.status;
    if (!bluetoothConnectStatus.isGranted) {
      await Permission.bluetoothConnect.request();
    }
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      await Permission.storage.request();
    }
  }

  void startScan() async {
    await requestPermissions();
    ble.state.listen((state) {
      if (state == BluetoothState.on) {
        ble.startScan(timeout: Duration(seconds: 4));
      } else {
        print("Bluetooth is not enabled.");
      }
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(timeout: Duration(seconds: 15));
      device.state.listen((state) {
        if (state == BluetoothDeviceState.connecting) {
          print("Device connecting to: ${device.name}");
        } else if (state == BluetoothDeviceState.connected) {
          print("Device connected: ${device.name}");
        } else {
          print("Device Disconnected");
        }
      });
    } catch (e) {
      print("Failed to connect to device: $e");
    }
  }

  Stream<List<ScanResult>>? get scanResults => ble.scanResults;
}
