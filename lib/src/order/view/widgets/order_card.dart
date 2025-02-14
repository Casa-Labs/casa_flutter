import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/font.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ruffle Dotted Dress',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      '\$49',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                Text(
                  'Zara',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset('assets/icons/ruler.svg'),
                    const SizedBox(width: 10),
                    Text(
                      'Size Guide',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black54,
                          ),
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
                      Text(
                        'Size:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontFamily: Font.gilroy,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'M',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontFamily: Font.gilroy,
                                    fontWeight: FontWeight.w600,
                                  ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Qty:',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                        )),
                    Container(
                      height: 24,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFD9D9D9)),
                      child: Center(
                          child: Text(
                        '1',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                      )),
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
