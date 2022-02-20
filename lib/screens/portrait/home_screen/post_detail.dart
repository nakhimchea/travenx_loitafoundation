import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/constant.dart'
    show kHPadding, kVPadding;
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/models/home_screen_models.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/custom_floating_action_button.dart';
import 'package:travenx_loitafoundation/widgets/portrait/home_screen/sub/post_detail_widgets.dart';

class PostDetail extends StatefulWidget {
  final PostObject post;
  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomFloatingActionButton(onTap: () => Navigator.pop(context)),
          CustomFloatingActionButton(
            onTap: () => print('Save Button Clicked ... '),
            //ToDo: change function when button save is clicked
            iconData: CustomFilledIcons.bookmark,
            iconColor: Theme.of(context).primaryColor,
            iconSize: 24.0,
          ),
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // SliverPadding(
          //   padding: EdgeInsets.only(top: 44.0),
          //   sliver: SliverToBoxAdapter(
          //     child: PostCover(imageUrls: widget.post.imageUrls),
          //   ),
          // ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: 25.0,
            ),
            sliver: SliverToBoxAdapter(
              child: PostHeader(
                title: widget.post.title,
                ratings: widget.post.ratings,
                views: widget.post.views,
                price: widget.post.price,
                state: widget.post.state,
                country: widget.post.country,
                openHours: widget.post.openHours,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: kHPadding,
              vertical: kVPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: Text('Mean ka ey dae bong?'),
            ),
          ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: kHPadding,
          //     vertical: kVPadding,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: AnnouncementCard(post: widget.post),
          //   ),
          // ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: kHPadding,
          //     vertical: kVPadding,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: BriefDescriptionCard(post: widget.post),
          //   ),
          // ),
          // SliverPadding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: kHPadding,
          //     vertical: kVPadding,
          //   ),
          //   sliver: SliverToBoxAdapter(
          //     child: PostDetails(post: widget.post),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: Policies(post: widget.post),
          // ),
          SliverPadding(padding: EdgeInsets.only(bottom: 20.0)),
        ],
      ),
    );
  }
}
