import 'package:futurekids/data/models/book_model.dart';
import 'package:futurekids/utils/config.dart';
import 'package:futurekids/utils/custom_theme.dart';
import 'package:futurekids/widgets/box_border_gradient.dart';
import 'package:futurekids/widgets/stroke_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookWidget extends StatelessWidget {
  final List<BookModel> listBook;
  final Function(BookModel book) callback;
  const BookWidget({Key? key, required this.listBook, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BoxBorderGradient(
      constraints: BoxConstraints(
          maxWidth: kWidthMobile - 32, maxHeight: Get.height * 0.75),
      color: Colors.white.withOpacity(0.4),
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const StrokeText(
              text: 'Hãy chọn giáo trình để vào học nhé',
              fontSize: 18,
            ),
            ...listBook
                .map((element) => GestureDetector(
                      onTap: () => callback(element),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: BoxBorderGradient(
                          padding: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Image.network(
                                element.image,
                                width: 113,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text('${element.name}:',
                                      style: CustomTheme.semiBold(16)),
                                  Text('${element.description}',
                                      style: CustomTheme.semiBold(16))
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
