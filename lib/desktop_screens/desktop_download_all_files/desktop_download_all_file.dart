import 'dart:io';

import 'package:at_common_flutter/services/size_config.dart';
import 'package:atsign_atmosphere_pro/data_models/file_transfer.dart';
import 'package:atsign_atmosphere_pro/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:provider/provider.dart';

import '../../view_models/history_provider.dart';

class DesktopDownloadAllFiles extends StatefulWidget {
  @override
  _DesktopDownloadAllFilesState createState() =>
      _DesktopDownloadAllFilesState();
}

class _DesktopDownloadAllFilesState extends State<DesktopDownloadAllFiles> {
  String downloadFolder = Platform.pathSeparator;
  bool isDownloading = false, isDownloadComplete = false;
  double downloadProgress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(
              vertical: 100.toHeight, horizontal: 20.toWidth),
          child: Center(
            child: Column(
              children: [
                Text(
                  'All the files you have received will be downloaded in the folder you select.',
                  style: TextStyle(
                      fontSize: 20.toFont,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.greyText),
                ),
                SizedBox(height: 20.toHeight),
                Container(
                  padding: EdgeInsets.all(5.0),
                  color: Colors.green,
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Selected download folder: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: downloadFolder),
                      ])),
                ),
                SizedBox(height: 20.toHeight),
                TextButton(
                  onPressed: _setDownloadFolder,
                  child: const Text(
                    'Select download folder',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 10.toHeight),
                TextButton(
                  onPressed: _fetchFiles,
                  child: Text(
                    isDownloading
                        ? 'Downloading files...'
                        : 'Download all files',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                isDownloading
                    ? SizedBox(
                        width: 350.toWidth,
                        child: LinearProgressIndicator(
                          value: downloadProgress,
                          minHeight: 10,
                        ),
                      )
                    : SizedBox(),
                isDownloadComplete
                    ? SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            Text('Download complete',
                                style: TextStyle(color: Colors.green)),
                            Icon(
                              Icons.download_done,
                              color: Colors.green,
                            )
                          ],
                        ),
                      )
                    : SizedBox()
              ],
            ),
          )),
    );
  }

  _setDownloadFolder() async {
    String path = (await getSavePath()) ?? Platform.pathSeparator;
    if (mounted) {
      setState(() {
        downloadFolder = path;
        isDownloadComplete = false;
      });
    }
    await checkIfFolderExists(downloadFolder);
  }

  _fetchFiles() async {
    if (downloadFolder == Platform.pathSeparator) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Select folder to download')),
      );
      return;
    }

    if (isDownloading) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download in progress')),
      );
      return;
    }

    if (mounted) {
      setState(() {
        isDownloading = true;
        isDownloadComplete = false;
      });
    }

    var historyProvider = Provider.of<HistoryProvider>(context, listen: false);
    List<FileTransfer> fileTransfer = getValidFileTransfers();

    for (int i = 0; i < fileTransfer.length; i++) {
      var atsignDownloadPath =
          downloadFolder + Platform.pathSeparator + fileTransfer[i].sender!;

      await checkIfFolderExists(atsignDownloadPath);

      var res = await historyProvider.downloadFiles(
          fileTransfer[i].key!, fileTransfer[i].sender!, false,
          downloadPath: atsignDownloadPath);

      if (res is bool && !res) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'failed to download ${fileTransfer[i].files!.length} file(s) from ${fileTransfer[i].sender}'),
          ),
        );
      }

      // increasing progress indicator percentage.
      if (mounted) {
        setState(() {
          downloadProgress = ((i + 1) / fileTransfer.length);
        });
      }
    }

    if (mounted) {
      setState(() {
        isDownloading = false;
        isDownloadComplete = true;
        downloadProgress = 0;
      });
    }
  }

  List<FileTransfer> getValidFileTransfers() {
    var historyProvider = Provider.of<HistoryProvider>(context, listen: false);
    List<FileTransfer> fileTransfer = [];
    for (int i = 0; i < historyProvider.receivedHistoryLogs.length; i++) {
      var expiryDate = historyProvider.receivedHistoryLogs[i].date!.add(
        Duration(days: 6),
      );

      if (expiryDate.difference(DateTime.now()) < Duration(seconds: 0)) {
        continue;
      } else {
        fileTransfer.add(historyProvider.receivedHistoryLogs[i]);
      }
    }

    return fileTransfer;
  }

  checkIfFolderExists(String path) async {
    final directory = Directory(path);

    if (!(await directory.exists())) {
      await directory.create();
    }
  }
}