import 'package:crypto_wallet/constants/colors.dart';
import 'package:crypto_wallet/widgets/text_style_custom.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class CryptoWidget extends StatelessWidget {
  String image;
  String price;
  String name;
  String symbol;
  Color color;
  CryptoWidget({
    super.key,
    required this.color,
    required this.image,
    required this.name,
    required this.price,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Image.asset(
            image,
            height: 40,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textStyleCustom(
                  fontSize: 15,
                  color: AppColors.white,
                ),
              ),
              Text(
                symbol,
                style: textStyleCustom(fontSize: 10, color: AppColors.grey),
              )
            ],
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          Text(
            price,
            style: textStyleCustom(fontSize: 18, color: color),
          )
        ],
      ),
    );
  }
}
