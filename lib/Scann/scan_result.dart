import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:nearby_scan/Scann/Controller/scanner_controller.dart';

class ScannResultScreen extends StatefulWidget {
  const ScannResultScreen({super.key});

  @override
  State<ScannResultScreen> createState() => _ScannResultScreenState();
}

class _ScannResultScreenState extends State<ScannResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("BLE SCANNER"),),
        body: GetBuilder<BleController>(
          builder: (controller) {
            return Expanded(
              child: StreamBuilder<List<ScanResult>>(
                stream: controller.scanResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No devices found.');
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final device = snapshot.data![index].device;
                      return ListTile(
                        title: Text(device.name),
                        subtitle: Text(device.id.toString()),
                        onTap: () => controller.connectToDevice(device),
                      );
                    },
                  );
                },
              ),
            );
          }
        ),
    );
  }
}
