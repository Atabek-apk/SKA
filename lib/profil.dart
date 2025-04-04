import 'package:flutter/material.dart';
import 'package:proje1/girisekrani.dart';
import 'package:proje1/kelime.dart';
import 'package:proje1/kelimelerdao.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconsax/iconsax.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> goster() async {

    var liste = await Kelimelerdao().tumkelimeler();

    for(Kelime k in liste){
      print("kelime adı : ${k.kelime}");



    }


  }



  String? spKullaniciAdi;
  String? spSifre;

  // SharedPreferences'den verileri okuma
  Future<void> oturumoku() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spKullaniciAdi = sp.getString("kullaniciadi") ?? "kullanici adi yok";
      spSifre = sp.getString("seviye") ?? "sifre yok";
    });

    // Bu sadece verilerin doğru şekilde yüklendiğini kontrol etmek için
    print("Kullanıcı Adı: $spKullaniciAdi, Şifre: $spSifre");
  }
  Future<void> verisil() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      sp.remove("kullaniciadi");
      sp.remove("seviye");
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>girisekrani()));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Veriler Silindi"),
        duration: Duration(seconds: 2), // 2 saniye gösterilecek
      ),
    );


    // Bu sadece verilerin doğru şekilde yüklendiğini kontrol etmek için
    print("Kullanıcı Adı: $spKullaniciAdi, Şifre: $spSifre");
  }
  

  @override
  void initState() {
    super.initState();
    oturumoku(); // Ekran ilk açıldığında SharedPreferences'ı oku
    goster();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [

        ListTile(
          leading: SizedBox(height:25,child: Image.asset("resimler/profil.png")),
          title: Row(
            children: [
              Text(spKullaniciAdi ?? "Yükleniyor...", style: TextStyle(color: Colors.white,)),
              Text("-",style: TextStyle(color: Colors.white),),

              Text(spSifre ?? "Yükleniyor...", style: TextStyle(color: Colors.white,)),
            ],
          ),

          onTap: () {
            print("tıklandı");
          },
        ),
        ListTile(
          leading: Icon(Iconsax.setting_45, color: Colors.white),
          title: Text("Ayarlar", style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_right, color: Colors.white),
          onTap: () {
            print("tıklandı");
          },
        ),
        ListTile(
          leading: Icon(Icons.sunny, color: Colors.white),
          title: Text("Açık Tema", style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_right, color: Colors.white),
          onTap: () {
            print("tıklandı");
          },
        ),
        ListTile(
          leading: Icon(Icons.delete, color: Colors.white),
          title: Text("Verileri Sil", style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_right, color: Colors.white),
          onTap: () {

            verisil();

            
            
            
            print("tıklandı");
          },
        ),

      ],
    );
  }
}
