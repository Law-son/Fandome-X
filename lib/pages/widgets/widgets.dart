import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../superhero_api/hero_model.dart';
import '../details_page/details_page.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    Key? key,
    required this.item,
    required this.index,
    this.animation = 1,
  }) : super(key: key);

  final HeroInfo item;
  final int index;
  final double animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60.h,
          padding: EdgeInsets.only(
              left: 30 * animation,
              top: 150 * animation,
              right: 30 * animation),
          margin: EdgeInsets.fromLTRB(
              kPaddingSideCard * animation,
              220 * animation,
              kPaddingSideCard * animation,
              kPaddingSideCard * animation),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
                  color: const Color.fromRGBO(24, 26, 32, 1),
              boxShadow: [
                kShadowContainer,
              ],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30 * animation),
                  bottomRight: Radius.circular(30 * animation),
                  topLeft: Radius.circular(60 * animation),
                  topRight: Radius.circular(210 * animation))),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  item.name,
                  style: TextStyle(fontSize: 23.sp, color: kSearchColor),
                  minFontSize: 40,
                  stepGranularity: 1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 36.sp),
                    children: <InlineSpan>[
                      TextSpan(
                          text: 'Aliases ',
                          style: TextStyle(fontSize: 20.sp, color: kSearchColor)),
                      TextSpan(
                          text: item.biography.aliases[0] != '-'
                              ? '\n${item.biography.aliases.toString().replaceAll("[", "").replaceAll("]", "")}'
                              : '\nN/A',
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: kSearchColor,
                              fontStyle: FontStyle.italic)),
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.bottom,
                          child: SizedBox(height: 35)),
                      TextSpan(
                          text: '\nUniverse',
                          style: TextStyle(fontSize: 22.sp, color: kSearchColor)),
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.bottom,
                          child: SizedBox(height: 45)),
                    ],
                  ),
                ),
                item.biography.publisher == 'DC Comics'
                    ? Image.asset('lib/assets/images/dc.png')
                    : item.biography.publisher == 'Marvel Comics'
                        ? Image.asset('lib/assets/images/marvel.png')
                        : Container(padding: const EdgeInsets.only(top: 10, left: 25), height: 70,child: Image.asset('lib/assets/images/unknow.png', color: Colors.white,)),

              ],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.7, -0.40),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: HeroDetailsPage(item: item),
                    inheritTheme: true,
                    ctx: context),
              );
            },
            child: CircleAvatar(
              backgroundColor: kSearchColor,
              radius: kCircularAvatarSize.sp + 7,
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: item.images.lg,
                placeholder: (context, url) => const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: kCircularAvatarSize,
                  backgroundImage:
                      ExactAssetImage('lib/assets/images/loading.gif'),
                ),
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundImage: image,
                  radius: kCircularAvatarSize.sp,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.75, 0.70),
          child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: HeroDetailsPage(item: item),
                      inheritTheme: true,
                      ctx: context),
                );
              },
              icon: Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 20.sp)),
        )
      ],
    );
  }
}
