import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/font.dart';
import '../../../common/widgets/text_widgets.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              'https://imgs.search.brave.com/H18Uf8LvTehXwHq51SrFqdrx-e4pJiN-rVkJTC-2BcI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/c2hvcGFsZXhpcy5j/b20vY2RuL3Nob3Av/ZmlsZXMvRU5HTEFO/RF9EUkVTU19TQURE/TEVfRlJPTlQud2Vi/cD92PTE3MjYwMDQz/ODYmd2lkdGg9NTMz',
              fit: BoxFit.cover,
              width: 114,
              height: 166,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BodyText(
                      text: 'Ruffle Dotted Dress',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    BodyText(
                      text: '\$49',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                const BodyText(
                  text: 'Zara',
                  fontSize: 16,
                  color: Colors.black54,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset('assets/icons/ruler.svg'),
                    const SizedBox(width: 10),
                    const BodyText(
                      text: 'Size Guide',
                      color: Colors.black54,
                      fontSize: 10,
                    )
                  ],
                ),
                const SizedBox(height: 3),
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFD9D9D9)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      BodyText(
                        text: 'Size:',
                        fontSize: 14,
                        fontFamily: Font.gilroy,
                        fontWeight: FontWeight.w300,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: BodyText(
                            text: 'M',
                            fontSize: 14,
                            color: Colors.black.withValues(alpha:0.7),
                            fontFamily: Font.gilroy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: BodyText(
                        text: 'Qty:',
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFD9D9D9)),
                      child: const Center(
                        child: BodyText(
                          text: '1',
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
