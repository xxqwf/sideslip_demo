import 'package:flutter/material.dart';

class CoverAppBarPage extends StatefulWidget {
  const CoverAppBarPage({Key? key}) : super(key: key);

  @override
  State<CoverAppBarPage> createState() => _CoverAppBarPageState();
}

class _CoverAppBarPageState extends State<CoverAppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            excludeHeaderSemantics: true,
            title: Text('title'),
            centerTitle: true,
            pinned: true,
            elevation: 0,
            bottom: CustomAppBar(100),
            floating: true,
            stretch: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black26,
              height: 100,
              width: 200,
            ),
          ),

          // SliverFlexibleHeader(
          //
          // )
        ];
      },
      body: contentWidget(),
    );
  }

  Widget contentWidget() {
    return ListView.separated(
      padding: EdgeInsets.only(top: 100),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text('$index'),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.black26,
        );
      },
      itemCount: 1000,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double width;

  const CustomAppBar(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black26,
      width: double.infinity,
    );
  }

  @override
  Size get preferredSize => Size(width, 100);
}

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black26,
      height: 100,
      width: 200,
    );
  }

  @override
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
