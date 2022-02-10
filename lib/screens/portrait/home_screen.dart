import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/helpers/post_translator.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirestoreService _firestoreService = FirestoreService();

  List<PostObject> promotions = [];
  List<Province> provinces = [
    Province(
      label: 'ភ្នំពេញ',
      imageUrl: 'assets/images/home_screen/phnom_penh.jpg',
      postList: [],
    ),
    Province(
      label: 'សៀមរាប',
      imageUrl: 'assets/images/home_screen/siem_reap.jpg',
      postList: [],
    ),
    Province(
      label: 'កំពត',
      imageUrl: 'assets/images/home_screen/kampot.jpg',
      postList: [],
    ),
    Province(
      label: 'ព្រះសីហនុ',
      imageUrl: 'assets/images/home_screen/preah_sihanouk.jpg',
      postList: [],
    ),
    Province(
      label: 'មណ្ឌលគិរី',
      imageUrl: 'assets/images/home_screen/mondulkiri.jpg',
      postList: [],
    ),
    Province(
      label: 'កោះកុង',
      imageUrl: 'assets/images/home_screen/koh_kong.jpg',
      postList: [],
    ),
    Province(
      label: 'រតនគិរី',
      imageUrl: 'assets/images/home_screen/rattanakiri.jpg',
      postList: [],
    ),
    Province(
      label: 'កែប',
      imageUrl: 'assets/images/home_screen/kep.jpg',
      postList: [],
    ),
    Province(
      label: 'ព្រះវិហារ',
      imageUrl: 'assets/images/home_screen/preah_vihear.jpg',
      postList: [],
    ),
    Province(
      label: 'ក្រចេះ',
      imageUrl: 'assets/images/home_screen/kratie.jpg',
      postList: [],
    ),
    Province(
      label: 'បាត់ដំបង',
      imageUrl: 'assets/images/home_screen/battambang.jpg',
      postList: [],
    ),
    Province(
      label: 'បន្ទាយមានជ័យ',
      imageUrl: 'assets/images/home_screen/banteay_meanchey.jpg',
      postList: [],
    ),
    Province(
      label: 'កំពង់ចាម',
      imageUrl: 'assets/images/home_screen/kampong_cham.jpg',
      postList: [],
    ),
    Province(
      label: 'កណ្តាល',
      imageUrl: 'assets/images/home_screen/kandal.jpg',
      postList: [],
    ),
    Province(
      label: 'ពោធិ៍សាត់',
      imageUrl: 'assets/images/home_screen/pursat.jpg',
      postList: [],
    ),
    Province(
      label: 'ប៉ៃលិន',
      imageUrl: 'assets/images/home_screen/pailin.jpg',
      postList: [],
    ),
    Province(
      label: 'កំពង់ឆ្នាំង',
      imageUrl: 'assets/images/home_screen/kampong_chhnang.jpg',
      postList: [],
    ),
    Province(
      label: 'កំពង់ស្ពឺ',
      imageUrl: 'assets/images/home_screen/kampong_speu.jpg',
      postList: [],
    ),
    Province(
      label: 'កំពង់ធំ',
      imageUrl: 'assets/images/home_screen/kampong_thom.jpg',
      postList: [],
    ),
    Province(
      label: 'ព្រៃវែង',
      imageUrl: 'assets/images/home_screen/prey_veng.jpg',
      postList: [],
    ),
    Province(
      label: 'ស្ទឹងត្រែង',
      imageUrl: 'assets/images/home_screen/stung_treng.jpg',
      postList: [],
    ),
    Province(
      label: 'ស្វាយរៀង',
      imageUrl: 'assets/images/home_screen/svay_rieng.jpg',
      postList: [],
    ),
    Province(
      label: 'តាកែវ',
      imageUrl: 'assets/images/home_screen/takeo.jpg',
      postList: [],
    ),
    Province(
      label: 'ឧត្តរមានជ័យ',
      imageUrl: 'assets/images/home_screen/oddar_meanchey.jpg',
      postList: [],
    ),
    Province(
      label: 'ត្បូងឃ្មុំ',
      imageUrl: 'assets/images/home_screen/tbong_khmum.jpg',
      postList: [],
    ),
  ];

  void assignPromotionData() async {
    promotions = postTranslator(await _firestoreService
        .getPromotionData()
        .then((snapshot) => snapshot.docs));
  }

  void assignProvinceData() async {}

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    //assignPromotionData();
    //assignProvinceData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0.7,
            shadowColor: Theme.of(context).disabledColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Travenx',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.headline6,
            ),
            centerTitle: false,
            floating: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: kHPadding),
                child: ChangeThemeButton(),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SearchBar(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding + 6.0,
            ),
            sliver: SliverToBoxAdapter(
              child: IconsMenu(),
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.only(
          //     top: 6.0,
          //     bottom: kVPadding,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: Promotions(promotions: promotions),
          //   ),
          // ),
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: kHPadding,
          //     vertical: kVPadding,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: Provinces(provinces: provinces),
          //   ),
          // ),
        ],
      ),
    );
  }
}
