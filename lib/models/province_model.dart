import 'package:travenx_loitafoundation/models/post_object_model.dart';

class Province {
  final String imageUrl;
  final String label;
  final List<PostObject>? postList;

  Province({
    required this.imageUrl,
    required this.label,
    this.postList,
  });
}
