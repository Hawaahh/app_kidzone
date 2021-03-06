// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidzone_app/Parent/widgets/centers_item.dart';

class CentersGrid extends StatelessWidget {
  final String searchWord;

  const CentersGrid({Key key, this.searchWord}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final centersData = Provider.of<Centers>(context);
    //final centerss = centersData.items;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Centers")
            .where("state", isEqualTo: 'Active')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print(snapshot.data);
            return CircularProgressIndicator();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: searchWord == ''
                  ? snapshot.data.docs.length
                  : snapshot.data.docs
                  .where((element) => element.get('name').toString().contains(searchWord))
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                final cendoc =  searchWord == ''
                    ? snapshot.data.docs[index] : snapshot.data.docs
                    .where((element) => element.get('name').toString().contains(searchWord))
                    .toList()[index];
                print('----->    ${cendoc.get('name')}    <------');

                return CentersItem(cendoc);
                // itemCount: centerss.length,
                // itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                //value: centerss[i],
                //child: CentersItem(
                //Centerss[i].title,
                //Centerss[i].description,
                //Centerss[i].price,
                //Centerss[i].imageAssets,
                //       ),
                // ),
              });
        });
  }
}
