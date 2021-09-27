part of '../../code-gen.dart';

//======= HELP FILE ============================================================
void printHelp() {
  print("""

dart run $namaFile [options]
--------------------------------------------------------------------------------
[options]                       | Keterangan
--------------------------------------------------------------------------------
help                            | untuk menampilkan petunjuk ini.
--------------------------------------------------------------------------------
add [help|module|language|model]      | untuk menambah beberapa kebutuhan tententu.
                                | jalankan perintah 'dart run $namaFile add help'
                                | untuk menampilkan petunjuk penggunaan.
--------------------------------------------------------------------------------
remove [help|module|language]   | untuk menghapus beberapa kebutuhan tententu.
                                | jalankan perintah 'dart run $namaFile remove help'
                                | untuk menampilkan petunjuk penggunaan.
--------------------------------------------------------------------------------
  """);
}

void printHelpAdd() {
  print("""
  
dart run $namaFile add [arguments]
--------------------------------------------------------------------------------
[arguments]                       | Keterangan
--------------------------------------------------------------------------------
help                              | untuk menampilkan petunjuk ini.
--------------------------------------------------------------------------------
module                            | untuk menambah module baru pada project ini.
--------------------------------------------------------------------------------
language [help|<key><translated>] | untuk menambahkan kalimat translater untuk server.
                                  | jalankan perintah 'dart run $namaFile add help'
                                  | untuk menampilkan petunjuk penggunaan.
--------------------------------------------------------------------------------
model                             | untuk menambah model baru untuk module yang di
                                  | pilih.
--------------------------------------------------------------------------------
  """);
}

void printHelpRemove() {
  print("""
  
dart run $namaFile remove [arguments]
--------------------------------------------------------------------------------
[arguments]                       | Keterangan
--------------------------------------------------------------------------------
help                              | untuk menampilkan petunjuk ini.
--------------------------------------------------------------------------------
module                            | untuk menghapus module pada project ini.
--------------------------------------------------------------------------------
language [help|<key><translated>] | untuk menghapus kalimat translater untuk server.
                                  | jalankan perintah 'dart run $namaFile remove help'
                                  | untuk menampilkan petunjuk penggunaan.
--------------------------------------------------------------------------------
  """);
}
