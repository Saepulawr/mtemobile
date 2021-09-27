# mtelektrik.id


---
### Halo developer, tolong diperhatikan
- Project ini menggunakan flutter (sound null safety).
- Upgrade selalu sdk flutter ke versi terbaru.
- Update selalu dependency yang di pakai.
- Usahakan untuk meminimalisir dependency.
- Diharapkan untuk selalu menggunakan Code Generator untuk membuat module baru dan lainnya.
- Apabila ada tambahan module atau code part yang effort nya lumayan besar,diharapkan untuk selalu membuat branch baru dengan format 'username-modulename'.
- State management menggunakan GetX.
- Local storage menggunakan SharedPreferences.
- Tolong jangan hapus file "assets/language/id.json" karena untuk kebutuhan multi bahasa, file tersebut adalah file master dan akan menjadi acuan untuk translate bahasa lainnya.
- Harap diperhatikan untuk file assets. tolong jangan simpan file di sembarang folder, harus sesuai dengan type file nya.
- Bugtrap menggunakan 'catcher' https://pub.dev/packages/catcher
- Untuk respons json dari api server, tolong convert kedalam bentuk model data, dengan cara membuat model baru menggunakan code generator.
- Untuk release app, harus melewati tahap uji kelayakan terlebih dahulu.
- Dan untuk penomoran versi gunakan format V0.0.1-beta.12, V0.0.1-pre.12, 1.0.0-build.12 dan V1.0.0 (untuk release). Major number untuk update sekala besar.
- Push notification menggunakan 'flutter_local_notification' https://pub.dev/packages/flutter_local_notification
---
## File Config
| Path | Keterangan  |
| ------------ | ------------ |
| lib/config/api.dart | Konfigurasi host atau alamat server yang akan dipakai |
| lib/config/const.dart | Menyimpan public constanta variable |
| lib/config/language.dart | Konfigurasi bahasa apa saja yang digunakan dalam project ini |
| lib/config/routes.dart | Konfigurasi routes management, disarankan untuk tidak mengubah file ini |
| lib/config/routing_callback.dart | Konfigurasi callback saat routes tertentu terpanggil. (Middleware routes callback) |

## Keterangan folder
| Path | Keterangan  |
| ------------ | ------------ |
| assets | Berisi beberapa file asset yang dibutuhkan |
| lib/config | Berisi file konfigurasi |
| lib/modules | Berisi beberapa module yang dibuat |
| lib/modules/module_name/api | Folder untuk beberapa file function api pada module ini |
| lib/modules/module_name/controller | Folder untuk menempatkan beberapa file controller GetX pada module ini |
| lib/modules/module_name/models | Folder untuk menempatkan beberapa file model data pada module ini |
| lib/modules/module_name/view | Folder untuk menempatkan main class dan layout widget pada  module ini |
| lib/modules/module_name/view/layout | Folder untuk menempatkan beberapa layout yang dipakai oleh main class pada module ini |
| lib/modules/module_name/view/widget | Folder untuk menempatkan beberapa widget yang dipakai pada module ini |
| lib/shared | Berisi beberapa file public |
| lib/shared/enum | Untuk menempatkan beberapa file enumeration |
| lib/shared/extensions | Untuk menempatkan beberapa file extension |
| lib/shared/themes | Untuk menempatkan beberapa file theme untuk app |
| lib/shared/utils | Untuk menematkan beberapa file utility |
| lib/shared/widgets | Untuk menempatkan beberapa widget public |

# CODE GENERATOR (code-gen.dart ~dev version)
Pastikan anda memiliki akses untuk 'write' pada folder dalam project ini.

    dart run code-gen.dart [options]
| [options]  | Keterangan  |
| ------------ | ------------ |
|  help | untuk menampilkan petunjuk ini.  |
| add [help;module;language]  | untuk menambah beberapa kebutuhan tententu. jalankan perintah 'dart run code-gen.dart add help' untuk menampilkan petunjuk penggunaan.  |

### MEMBUAT MODULE BARU
jalankan perintah dibawah ini pada terminal

    dart run code-gen.dart add module

dan ikuti petunjuk selanjutnya.


### MENAMBAHKAN KALIMAT BARU UNTUK FILE TRANSLATE

Pada fitur ini, generator akan menambahkan kalimat baru kedalam file bahasa indonesia (assets/language/id.json) sebagai default dari bahasa
yang di pakai di aplikasi ini dengan mereferensikan 'key' kedalam model bahasa yang akan memudahkan developer
untuk menggunakan kalimat tersebut.

jalankan perintah dibawah ini pada terminal

    dart run code-gen.dart add language
dan ikuti petunjuk selanjutnya.

### File & Folder code generator
- code-gen.dart (file)
- tools (folder)
