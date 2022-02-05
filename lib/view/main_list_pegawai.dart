import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kejari_employment/controller/main_list_controller.dart';
import 'package:kejari_employment/model/profil_pegawai.dart';
import 'package:kejari_employment/resources/colors.dart';
import 'package:kejari_employment/services/delete_db.dart';
import 'package:kejari_employment/services/get_db.dart';
import 'package:kejari_employment/view/features/add_pegawai.dart';
import 'package:kejari_employment/view/features/lihat_pegawai.dart';

class MainListPegawai extends StatelessWidget {
  bool isSelected = false;

  List<int> selectedItems = [];

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainListController>(
      id: 'mainListDisplay',
      init: MainListController(),
      builder: (controller) {
        print("siapp");
        return Scaffold(
          appBar: AppBar(
            title: Text("List Data Pegawai"),
            centerTitle: true,
            backgroundColor: primaryColor,
          ),
          body: Container(
            width: Get.width,
            height: Get.height,
            child: RefreshIndicator(
              onRefresh: refreshList,
              child: FutureBuilder<List<ProfilPegawai>>(
                future: GetDb().getProfilEmployees(),
                builder: (context, snapshot) {
                  print("tampil");
                  if (snapshot.hasData) {
                    var hasil = snapshot.data;
                    return ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      physics: const AlwaysScrollableScrollPhysics(),

                      // physics: const BouncingScrollPhysics(
                      // parent: AlwaysScrollableScrollPhysics()),
                      itemCount: hasil.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Material(
                            color: (selectedItems.contains(hasil[index].id))
                                ? Colors.red
                                : Colors.white,
                            child: InkWell(
                              onLongPress: () {
                                selectedItems.add(hasil[index].id);
                                controller.setMainList();
                                isSelected = true;
                              },
                              splashColor: Colors.grey,
                              onTap: () {
                                if (isSelected) {
                                  if (!selectedItems
                                      .contains(hasil[index].id)) {
                                    selectedItems.add(hasil[index].id);
                                    controller.setMainList();
                                  } else {
                                    selectedItems.removeWhere((element) =>
                                        element == hasil[index].id);
                                    controller.setMainList();
                                    if (selectedItems.length == 0) {
                                      isSelected = false;
                                    }
                                  }
                                } else {
                                  Get.to(
                                    LihatPegawai(
                                      hasil: hasil[index],
                                      nip: "${hasil[index].nip}",
                                    ),
                                  );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 58,
                                            height: 58,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(150),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: Offset(1.5, 1.5),
                                          child: Center(
                                            child: ClipOval(
                                              child: Image.file(
                                                File(hasil[index].pathPicture),
                                                width: 55,
                                                height: 55,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Container(
                                    //   width: 45,
                                    //   height: 45,
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.green,
                                    //     borderRadius:
                                    //         BorderRadius.circular(50),
                                    //   ),
                                    // ),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${hasil[index].nama}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.5,
                                          ),
                                        ),
                                        Text(
                                          "${hasil[index].jabNama} ${hasil[index].pangkatGol}",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (!isSelected) {
                Get.to(AddPegawai());
              } else {
                var nilai = await DeleteDb().deleteEmployee(selectedItems);
                if (nilai == 1) {
                  selectedItems = [];
                  isSelected = false;
                  controller.setMainList();
                }
              }
            },
            backgroundColor: (!isSelected) ? primaryColor : Colors.red,
            child:
                (!isSelected) ? Icon(Icons.add, size: 35) : Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
