import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:test/constant/loder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    localpath;
    super.initState();
  }

  List<FileSystemEntity>? files;
  List<FileSystemEntity> pdfList = [];

  get localpath async {
    // Directory dirList = Directory("storage/emulated/0/download");
    Directory? dirList = await getExternalStorageDirectory();
    String pdfFile = "${dirList?.path.replaceAll("/files", "/files/pdf")}";
    print("pdfFile :: ${pdfFile}");

    files = dirList?.listSync(recursive: true, followLinks: false);
    if (files != null) {
      for (FileSystemEntity entity in files!) {
        String path = entity.path;
        if (entity.path.endsWith(".pdf")) pdfList.add(entity);
        print("entitys : ${entity.path}");
      }
    } else {
      return commanLoder(context);
    }

    print("pdfList $pdfList");

    print(pdfList.length);
    return dirList?.path;
  }

  @override
  Widget build(BuildContext context) {
    if (pdfList.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: pdfList.length,
            itemBuilder: (context, index) {
              var nData = pdfList[index];
              return Center(
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(nData.path),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViwerPage(
                              pdfPath: nData.path,
                            ),
                          ),
                        );
                      },
                    ),
                    Divider()
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Text(
            "No file founds",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
      );
    }
  }
}

class PdfViwerPage extends StatelessWidget {
  const PdfViwerPage({Key? key, required this.pdfPath}) : super(key: key);
  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pdfPath),
            SizedBox(
              height: 400,
              child: SfPdfViewer.file(File(pdfPath)),
            ),
          ],
        ),
      ),
    );
  }
}
