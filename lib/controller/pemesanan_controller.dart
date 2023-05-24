import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/adapters.dart';
import '../model/pemesanan_hotel.dart';
import '../view/pemesanan.dart';

class PemesananController {
  static void pesan(Pesanan data) async {
    List<dynamic> listData = [];
    // Inisialisasi Hive
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(157)) {
      // Register Hive Adapter
      Hive.registerAdapter(PesananAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      // Register Hive Adapter
      Hive.registerAdapter(TODAdapter()); // Add parentheses here
    }

    // Buka Hive Box
    final box = await Hive.openBox('hotels');
    // Simpan objek Hotel ke Hive Box
    if (box.get('pesanan') == null) {
      listData.add(data);
      box.put('pesanan', listData);
      if (box.containsKey("pesanan")) {
        print("ada pesanan");
      } else {
        print("gak ada pesanan");
      }
    } else {
      List<dynamic> sendata = box.get('pesanan');
      sendata.add(data);
      box.put('pesanan', sendata);
      if (box.containsKey("pesanan")) {
        print("ada pesanan");
      } else {
        print("gak ada pesanan");
      }
    }

    // Tutup Hive Box dan Hapus direktori Hive
  }
}
