import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/appbar.dart';
import 'package:esdc_emg/widget/row/category_label.dart';
import 'package:esdc_emg/widget/row/item_selector_row.dart';
import 'package:flutter/material.dart';

class SocialMediaScreen extends StatefulWidget {
  @override
  _SocialMediaScreenState createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightGray,
      appBar: ESDCAppbar.generateMainAppbar(title: "Social media"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryLabel(label: 'FACEBOOK'),
            ItemSelectorRow(title: 'ESDC', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Accessible Canada', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Leaders Today', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Senior in Canada', assetImage: 'asset/image/chat.svg', onClick: () {},),
            CategoryLabel(label: 'TWITTER'),
            ItemSelectorRow(title: 'ESDC', assetImage: 'asset/image/twitter.svg', onClick: () {},),
            ItemSelectorRow(title: 'Service Canada', assetImage: 'asset/image/twitter.svg', onClick: () {},),
            ItemSelectorRow(title: 'Accessible Canada', assetImage: 'asset/image/twitter.svg', onClick: () {},),
            CategoryLabel(label: 'YOUTUBE'),
            ItemSelectorRow(title: 'ESDC', assetImage: 'asset/image/chat.svg', onClick: () {},),
            ItemSelectorRow(title: 'Service Canada', assetImage: 'asset/image/chat.svg', onClick: () {},),
            CategoryLabel(label: 'INSTAGRAM'),
            ItemSelectorRow(title: 'ESDCwebsite', assetImage: 'asset/image/chat.svg', onClick: () {},),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
