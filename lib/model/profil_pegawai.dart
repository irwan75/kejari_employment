import 'dart:convert';

class ProfilPegawai {
  int id;
  String pathPicture;
  String nama;
  int nip;
  String pangkatGol;
  String pangkatTmt;
  String jabNama;
  String jabTmt;
  int maskerThn;
  int maskerBln;
  String latjaNama;
  String latjaWkt;
  int latjaJmlJam;
  String pendidikanNama;
  int pendidikanThnLls;
  String pendidikanIjazah;
  int usia;
  ProfilPegawai({
    this.id,
    this.pathPicture,
    this.nama,
    this.nip,
    this.pangkatGol,
    this.pangkatTmt,
    this.jabNama,
    this.jabTmt,
    this.maskerThn,
    this.maskerBln,
    this.latjaNama,
    this.latjaWkt,
    this.latjaJmlJam,
    this.pendidikanNama,
    this.pendidikanThnLls,
    this.pendidikanIjazah,
    this.usia,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pathPicture': pathPicture,
      'nama': nama,
      'nip': nip,
      'pangkatGol': pangkatGol,
      'pangkatTmt': pangkatTmt,
      'jabNama': jabNama,
      'jabTmt': jabTmt,
      'maskerThn': maskerThn,
      'maskerBln': maskerBln,
      'latjaNama': latjaNama,
      'latjaWkt': latjaWkt,
      'latjaJmlJam': latjaJmlJam,
      'pendidikanNama': pendidikanNama,
      'pendidikanThnLls': pendidikanThnLls,
      'pendidikanIjazah': pendidikanIjazah,
      'usia': usia,
    };
  }

  factory ProfilPegawai.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProfilPegawai(
      id: map['id'],
      pathPicture: map['pathPicture'],
      nama: map['nama'],
      nip: map['nip'],
      pangkatGol: map['pangkatGol'],
      pangkatTmt: map['pangkatTmt'],
      jabNama: map['jabNama'],
      jabTmt: map['jabTmt'],
      maskerThn: map['maskerThn'],
      maskerBln: map['maskerBln'],
      latjaNama: map['latjaNama'],
      latjaWkt: "${map['latjaWkt']}",
      latjaJmlJam: map['latjaJmlJam'],
      pendidikanNama: map['pendidikanNama'],
      pendidikanThnLls: map['pendidikanThnLls'],
      pendidikanIjazah: map['pendidikanIjazah'],
      usia: map['usia'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfilPegawai.fromJson(String source) =>
      ProfilPegawai.fromMap(json.decode(source));
}
