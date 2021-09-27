part of '../shared/utils/api/utils/api_endpoint.dart';
/*
list host yang tersedia
untuk menambahkan host, gunakan format
http[s]://host/[bla]
dan jangan lupa tambahkan profile host
sesuai dengan urutan _host
*/

Map<ProfileHost, String> _hosts = {
  ProfileHost.development: "http://moc-api.kadoin.id/index.php",
  ProfileHost.production: "",
  ProfileHost.testing: ""
};
enum ProfileHost {
  development,
  production,
  testing,
}

//pilih host yang akan di pakai sesuai dengan profile
String _hostAktif = _hosts[ProfileHost.development]!;
