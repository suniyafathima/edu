
import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu/controller/cart_controller.dart';
import 'package:edu/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String timeAgo;
   final String price;
  final String oldPrice;
  final String rating;
  final String? badge;
  final bool showAddButton;
  final VoidCallback? onAddPressed;

  const CourseCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.timeAgo,
     required this.price,
    required this.oldPrice,
    required this.rating,
    this.badge,
    this.showAddButton = false,
    this.onAddPressed,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
     final cart = context.watch<CartController>();
    final item = cart.items[widget.title];
    final count = item?.quantity ?? 0;
    return Container(
      height: 126,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     offset: Offset(0, 1),
        //     blurRadius: 2,
        //   ),
     //   ],
      ),
      child: Row(
        children: [
          // Left Image
         ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              width: 144,
              height: 124,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 144,
                height: 124,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 144,
                height: 124,
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.red),
                ),
              ),
            ),
          ),
    
          const SizedBox(width: 12),
    
          // Right Column
          Expanded(
            child: Container(
              width: 172,
              height: 126,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 20 / 14,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
            
                  const SizedBox(height: 1),
                  // Author & Time
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        //width: showAddButton ? 95 : 172,
                        height: 20,
                        child: Text(
                          '${widget.author} · ${widget.timeAgo}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),
                      if(widget.showAddButton)
                        count==0
                        ? SizedBox(
                          height: 20,
                          width: 56,
                          child: ElevatedButton(
                            onPressed: (){
                            final price = double.tryParse(widget.price.replaceAll('\$', '')) ?? 0;
                                cart.addItem(CartItem(
                                  title: widget.title,
                                  image: widget.imageUrl,
                                  price: price,
                                ));
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE7D5FF),
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: Text(
                              'Add',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff1E293B),
                              ),
                            ),
                          ),
                        )
                        : Container(    // Counter
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF9F54F8),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              // Minus button
                              InkWell(
                                onTap: () => cart.decrementItem(widget.title),
                                
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.remove,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              // Count
                              Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                              // Plus button
                              InkWell(
                                onTap: () => cart.incrementItem(widget.title),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.add,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                   ],
                  ),
            
                  const SizedBox(height: 1),
            
                  // Line
                  Container(
                   // width: 172,
                    height: 1,
                    color: const Color(0xFFE2E8F0),
                  ),
                  const SizedBox(height: 1),
                   SizedBox(
                 // width: 172,
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Prices
                      Row(
                        children: [
                          // Current price
                          SizedBox(
                            width: 46,
                            height: 20,
                            child: Text(
                              widget.price,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 20 / 14,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                        
                          // Old price
                          SizedBox(
                            width: 23,
                            height: 20,
                            child: Text(
                              widget.oldPrice,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 20 / 12,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(width: 20),
                      // Star rating
                      Row(
                        children: [
                          SizedBox(
                            width: 12,
                            height: 12,
                            child: Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Rating text
                          Text(
                            widget.rating,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 20 / 12,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                   SizedBox(height: 6),
                   
                    if (widget.badge != null)
                   IntrinsicWidth (
                     child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          height: 20, 
                        
                          alignment: Alignment.center, 
                          decoration: BoxDecoration(
                            color:  (widget.badge?.toLowerCase() == 'students pick')
                    ? const Color(0xFFDCFCE7) 
                    : const Color(0xFFE7D5FF), 
                    borderRadius: BorderRadius.circular(4), 
                    boxShadow: const [
                      BoxShadow(
                      color: Color(0x0F000000), 
                      offset: Offset(0, 1), 
                      blurRadius: 2,
                      spreadRadius: 0,
                      
                      ),
                    BoxShadow(
                      color: Color(0x0F000000),
                      offset: Offset(0, -1),
                      blurRadius: 2,
                      spreadRadius: 0,
                      
                          ),
                        ],
                      ),
                      child: Text(
                        widget.badge ?? '',
                        style: GoogleFonts.inter(
                          fontSize: 12, // fits 20 height
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF1E293B),
                          height: 20/12, // line height
                        ),
                      ),
                    ),
                   ) ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

