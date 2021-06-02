import 'dart:math';
import 'dart:typed_data';
import 'package:at_common_flutter/services/size_config.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/contact_initial.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/custom_circle_avatar.dart';
import 'package:atsign_atmosphere_pro/services/backend_service.dart';
import 'package:atsign_atmosphere_pro/services/common_functions.dart';
import 'package:atsign_atmosphere_pro/view_models/file_transfer_provider.dart';
import 'package:atsign_atmosphere_pro/view_models/welcome_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AtSignBottomSheet extends StatefulWidget {
  final List<String> atSignList;
  AtSignBottomSheet({Key key, this.atSignList}) : super(key: key);

  @override
  _AtSignBottomSheetState createState() => _AtSignBottomSheetState();
}

class _AtSignBottomSheetState extends State<AtSignBottomSheet> {
  BackendService backendService = BackendService.getInstance();
  bool isLoading = false;
  var atClientPrefernce;
  @override
  Widget build(BuildContext context) {
    backendService
        .getAtClientPreference()
        .then((value) => atClientPrefernce = value);
    Random r = Random();
    return Stack(
      children: [
        Positioned(
          child: BottomSheet(
            onClosing: () {},
            backgroundColor: Colors.transparent,
            builder: (context) => ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Container(
                height: 120.toHeight,
                width: SizeConfig().screenWidth,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.atSignList.length,
                      itemBuilder: (context, index) {
                        Uint8List image = CommonFunctions()
                            .getCachedContactImage(widget.atSignList[index]);
                        return GestureDetector(
                          onTap: isLoading
                              ? () {}
                              : () async {
                                  await backendService.checkToOnboard(
                                      atSign: widget.atSignList[index]);

                                  Provider.of<WelcomeScreenProvider>(context,
                                          listen: false)
                                      .selectedContacts = [];
                                  Provider.of<FileTransferProvider>(context,
                                          listen: false)
                                      .selectedFiles = [];
                                  Navigator.pop(context);
                                  // Navigator.pop(context);
                                },
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: Column(
                              children: [
                                Container(
                                  height: 40.toFont,
                                  width: 40.toFont,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, r.nextInt(255),
                                        r.nextInt(255), r.nextInt(255)),
                                    borderRadius:
                                        BorderRadius.circular(50.toWidth),
                                  ),
                                  child: Center(
                                    child: image != null
                                        ? CustomCircleAvatar(
                                            byteImage: image,
                                            nonAsset: true,
                                          )
                                        : ContactInitial(
                                            initials: widget.atSignList[index]),
                                  ),
                                ),
                                Text(widget.atSignList[index],
                                    style: TextStyle(fontSize: 15.toFont))
                              ],
                            ),
                          ),
                        );
                      },
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                          Navigator.pop(context);
                        });
                        await backendService.checkToOnboard(atSign: "");

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 40,
                        width: 40,
                        child: Icon(Icons.add_circle_outline_outlined,
                            color: Colors.orange, size: 25.toFont),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}