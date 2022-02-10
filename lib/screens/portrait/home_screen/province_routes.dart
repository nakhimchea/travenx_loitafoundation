import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor, kCardTileVPadding;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';

class ProvinceRoutes extends StatelessWidget {
  const ProvinceRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            brightness: Theme.of(context).colorScheme.brightness,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).iconTheme.color,
                size: 18.0,
              ),
            ),
            title: Text(
              'ខេត្ត/ក្រុងទាំងអស់',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.headline3,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                //TODO: Navigate user to Search screen
                //     ()=> Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => SearchSubscreen()),
                // ),
                icon: Icon(
                  CustomOutlinedIcons.search,
                  size: 28.0,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kHPadding - kCardTileVPadding / 2,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 8.12 +
                        kCardTileVPadding,
                    child: _ProvincesItem(
                      modelProvince: modelProvinces.elementAt(index),
                      vPadding: kCardTileVPadding,
                    ),
                  );
                },
                childCount: modelProvinces.length - 1,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 14.0)),
        ],
      ),
    );
  }
}

class _ProvincesItem extends StatelessWidget {
  final ModelProvince modelProvince;
  final double vPadding;

  const _ProvincesItem({
    Key? key,
    required this.modelProvince,
    required this.vPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _imageSize = MediaQuery.of(context).size.height / 8.12;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProvinceRoute(),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vPadding / 2),
        child: Row(
          children: [
            Container(
              height: _imageSize,
              width: _imageSize,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                child: Image(
                  image: AssetImage(modelProvince.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: _imageSize,
              width: MediaQuery.of(context).size.width -
                  2 * kHPadding -
                  _imageSize,
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelProvince.label,
                      textScaleFactor: textScaleFactor,
                      style: Theme.of(context).textTheme.headline2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    Row(
                      children: [
                        Text(
                          'ទីតាំងសរុប៖ ',
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.button,
                        ),
                        Text(
                          '153',
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvinceRoute extends StatefulWidget {
  const ProvinceRoute({Key? key}) : super(key: key);

  @override
  _ProvinceRouteState createState() => _ProvinceRouteState();
}

class _ProvinceRouteState extends State<ProvinceRoute> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
