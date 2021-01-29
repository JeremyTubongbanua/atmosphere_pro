import 'package:at_contact/at_contact.dart';
import 'package:atsign_atmosphere_pro/utils/text_strings.dart'
    as pro_text_strings;
import 'package:atsign_atmosphere_pro/screens/common_widgets/contact_initial.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/custom_button.dart';
import 'package:atsign_atmosphere_pro/screens/common_widgets/custom_circle_avatar.dart';
import 'package:atsign_atmosphere_pro/utils/text_styles.dart';
import 'package:atsign_atmosphere_pro/view_models/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:atsign_atmosphere_pro/services/size_config.dart';
import 'package:provider/provider.dart';

class RemoveTrustedContact extends StatefulWidget {
  final String image;
  final String name;
  final String atSign;
  final AtContact contact;

  const RemoveTrustedContact(
      {Key key, this.image, this.name, this.atSign, this.contact})
      : super(key: key);

  @override
  _RemoveTrustedContactState createState() => _RemoveTrustedContactState();
}

class _RemoveTrustedContactState extends State<RemoveTrustedContact> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.toWidth),
      ),
      titlePadding: EdgeInsets.all(20.toHeight),
      title: Row(
        children: [
          Expanded(
            child: Text(
              pro_text_strings.TextStrings().removeTrustedSender,
              style: CustomTextStyles.secondaryRegular16,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      content: Container(
        height: 280.toHeight,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (widget.contact.tags != null &&
                        widget.contact.tags['image'] != null)
                    ? CustomCircleAvatar(
                        byteImage: widget.contact.tags['image'],
                        nonAsset: true,
                      )
                    : ContactInitial(
                        initials: widget.contact.tags != null &&
                                widget.contact.tags['name'] != null
                            ? widget.contact.tags['name'].substring(0, 2)
                            : widget.contact.atSign.substring(1, 3),
                      )
              ],
            ),
            SizedBox(
              height: 20.toHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                      child: Text(
                    widget.contact.tags != null &&
                            widget.contact.tags['name'] != null
                        ? widget.contact.tags['name']
                        : widget.contact.atSign.substring(1),
                    style: CustomTextStyles.primaryBold16,
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 5.toHeight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.contact.atSign,
                      style: CustomTextStyles.secondaryRegular14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.toHeight,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (Provider.of<ContactProvider>(context)
                            .trustedContactOperation)
                        ? CircularProgressIndicator()
                        : CustomButton(
                            isOrange: true,
                            buttonText: 'Yes',
                            width: 200.toWidth,
                            onPressed: () async {
                              await Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .removeTrustedContacts(widget.contact);
                              await Provider.of<ContactProvider>(context,
                                      listen: false)
                                  .setTrustedContact();
                              await Navigator.pop(context);
                            },
                          ),
                  ],
                ),
                SizedBox(height: 10.toHeight),
                CustomButton(
                  buttonText: 'No',
                  isInverted: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
