import 'package:futurekids/data/models/category_model.dart';
import 'package:futurekids/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import 'article_controller.dart';

class ArticleView extends StatelessWidget {
  late final ArticleController controller;

  ArticleView({Key? key, required CategoryModel category}) : super(key: key) {
    controller = Get.put(ArticleController(category: category), tag: category.categoryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.listArticle.isEmpty ?
    const Center(child: CircularProgressIndicator(color: kAccentColor,),) :
    Padding(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
      child: HtmlWidget(controller.listArticle[0]["content"], renderMode: RenderMode.listView,),
    ));
  }
}
