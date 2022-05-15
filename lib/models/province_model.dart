import 'package:flutter/cupertino.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModelProvince {
  final String imageUrl;
  final String label;

  ModelProvince({
    required this.imageUrl,
    required this.label,
  });
}

List<ModelProvince> modelProvinces(BuildContext context) => [
      ModelProvince(
        imageUrl: 'assets/images/home_screen/phnom_penh.jpg',
        label: AppLocalizations.of(context)!.pvPhnomPenh,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/siem_reap.jpg',
        label: AppLocalizations.of(context)!.pvSiemReap,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kampot.jpg',
        label: AppLocalizations.of(context)!.pvKampot,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/preah_sihanouk.jpg',
        label: AppLocalizations.of(context)!.pvPreahSihanouk,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/mondulkiri.jpg',
        label: AppLocalizations.of(context)!.pvMondulkiri,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/koh_kong.jpg',
        label: AppLocalizations.of(context)!.pvKohKong,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/rattanakiri.jpg',
        label: AppLocalizations.of(context)!.pvRattanakiri,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kep.jpg',
        label: AppLocalizations.of(context)!.pvKep,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/preah_vihear.jpg',
        label: AppLocalizations.of(context)!.pvPreahVihear,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kratie.jpg',
        label: AppLocalizations.of(context)!.pvKratie,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/battambang.jpg',
        label: AppLocalizations.of(context)!.pvBattambang,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/banteay_meanchey.jpg',
        label: AppLocalizations.of(context)!.pvBanteayMeanchey,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kampong_cham.jpg',
        label: AppLocalizations.of(context)!.pvKampongCham,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kandal.jpg',
        label: AppLocalizations.of(context)!.pvKandal,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/pursat.jpg',
        label: AppLocalizations.of(context)!.pvPursat,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/pailin.jpg',
        label: AppLocalizations.of(context)!.pvPailin,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kampong_chhnang.jpg',
        label: AppLocalizations.of(context)!.pvKampongChhnang,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kampong_speu.jpg',
        label: AppLocalizations.of(context)!.pvKampongSpeu,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/kampong_thom.jpg',
        label: AppLocalizations.of(context)!.pvKampongThom,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/prey_veng.jpg',
        label: AppLocalizations.of(context)!.pvPreyVeng,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/stung_treng.jpg',
        label: AppLocalizations.of(context)!.pvStungTreng,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/svay_rieng.jpg',
        label: AppLocalizations.of(context)!.pvSvayRieng,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/takeo.jpg',
        label: AppLocalizations.of(context)!.pvTakeo,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/oddar_meanchey.jpg',
        label: AppLocalizations.of(context)!.pvOddarMeanchey,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/tbong_khmum.jpg',
        label: AppLocalizations.of(context)!.pvTbongKhmum,
      ),
      ModelProvince(
        imageUrl: 'assets/images/home_screen/default.jpg',
        label: AppLocalizations.of(context)!.pvDefault,
      ),
    ];
