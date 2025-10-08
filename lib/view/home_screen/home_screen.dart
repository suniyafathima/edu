import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu/controller/banner_controller.dart';
import 'package:edu/controller/cart_controller.dart';
import 'package:edu/controller/courses_controller.dart';
import 'package:edu/controller/material_controller.dart';
import 'package:edu/controller/subject_controller.dart';
import 'package:edu/global_widget/course_card.dart';
import 'package:edu/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String token;
   const HomeScreen({super.key,required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   bool isSelected = false;   
  @override
  void initState() {
    super.initState();
    final controller = context.read<SubjectController>();
    controller.fetchSubjects(context, widget.token); 
    
     final bannerController = context.read<BannerController>();
  bannerController.fetchBanner(widget.token); 
  
   final coursesController = context.read<CoursesController>();
  coursesController.fetchCourses(widget.token);
  
  final materialController = context.read<MaterialsController>();
  materialController.fetchMaterials(widget.token);
  }
// final List<Map<String, dynamic>> subjects = [
//   {
//     'title': 'Mathematics',
//     'icon': Icons.calculate_rounded,
//     'gradientColors': [Color(0xFFFF6773), Color(0xFFFE8B6E)],
//   },
//   {
//     'title': 'Physics',
//     'icon': Icons.science_rounded,
//     'gradientColors': [Color(0xFF9F54F8), Color(0xFFC77DFF)],
//   },
//   {
//     'title': 'English',
//     'icon': Icons.book_rounded,
//     'gradientColors': [Color(0xFF4AC6FF), Color(0xFF007BFF)],
//   },
//   // Add more subjects here
// ];

// final List<Map<String, String>> courses = [
//   {
//     'image': 'https://via.placeholder.com/150',
//     'title': 'JavaScript for Modern Web Development',
//     'author': 'Robert Fox',
//     'time': '3 hr',
//     'price': '\$10.99',
//     'oldprice': '\$32',
//     'rating': '4.5 (2,980)',
//     'badge': 'Top Author',
//   },
//   {
//     'image': 'https://via.placeholder.com/150',
//     'title': 'Flutter for Beginners',
//     'author': 'Jane Doe',
//     'time': '2 hr',
//     'price': '\$8.99',
//     'oldprice': '\$20',
//     'rating': '4.7 (3,210)',
//     'badge': 'Top Author',
//   },
//   {
//     'image': 'https://via.placeholder.com/150',
//     'title': 'Python Data Science',
//     'author': 'John Smith',
//     'time': '5 hr',
//     'price': '\$12.50',
//     'oldprice': '\$35',
//     'rating': '4.9 (4,120)',
//     'badge': 'Top Author',
//   },
// ];

// final List<Map<String, String>> buyMaterials = [
//   {
//     'image': 'https://via.placeholder.com/150',
//     'title': 'Mathematics Workbook',
//     'author': 'Seller A',
//     'time': 'New',
//     'price': '\$5.99',
//     'oldprice': '\$12',
//     'rating': '4.7 (120)',
//     'badge': 'Top Choice',
//   },
//   {
//     'image': 'https://via.placeholder.com/150',
//     'title': 'Physics Lab Manual',
//     'author': 'Seller B',
//     'time': 'New',
//     'price': '\$8.99',
//     'oldprice': '\$15',

//     'rating': '4.8 (85)',
//     'badge': 'Top Rated',
//   },
//   {
//     'image': 'https://via.placeholder.com/150',
//     'title': 'English Grammar Guide',
//     'author': 'Seller C',
//     'time': 'New',
//     'price': '\$4.99',
//     'oldprice': '\$10',
//     'rating': '4.6 (200)',
//     'badge': 'Students Pick',
//   },
// ];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SubjectController>();
    final bannerController = context.watch<BannerController>();
    final coursesController = context.watch<CoursesController>();
    final materialController = context.watch<MaterialsController>();
  
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Icon(Icons.menu,size: 24,color: Color(0xff0F172A),),
        ),
        actions: [
         Padding(
           padding: const EdgeInsets.only(right: 24),
           child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                   // Notification Bell
            buildNotification(),
          
            const SizedBox(width: 10),
                  // Cart
            buildCartBadge(context),
                 ],
               ),
         )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24,right: 24),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                   Center(
                     child: Container(
                height: 40,
                width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
              color: const Color(0xFFCBD5E1),
              width: 1,
                  ),
                  boxShadow: [
              BoxShadow(
                color: const Color(0x14344054), 
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
                  ],
                ),
                child: buldSearch(),
              ),),
                   SizedBox(height: 12,),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
              'Subject Tutoring',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600, 
                height: 24 / 16, 
                color: const Color(0xFF0F172A),
                ),
              ),
              
                  Row(
              children: [
                Text(
                  'All Subjects',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 20 / 12, 
                    color: const Color(0xFF9F54F8),
                  ),
                ),  
                 const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xFF9F54F8),
                ),],
                  ),
                ],
              ),
                  
              SizedBox(height: 8,),
              if (controller.isLoading)
               const Center(child: CircularProgressIndicator())
              else
              buildSubjectlist(controller),
                SizedBox(height: 20,),
              buildBanner(bannerController),

            SizedBox(height: 8,),
            Text(
              'All Courses',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600, 
                height: 24 / 16, 
                color: const Color(0xFF0F172A),
              ),
            ),
              SizedBox(height: 16,),
              coursesController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : buildCourseslist(coursesController),
                 SizedBox(height: 8,),
                  Text(
                  'Buy Materials',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600, 
                    height: 24 / 16, 
                    color: const Color(0xFF0F172A),
                  ),
                      ),
                  SizedBox(height: 16,),
                  
                  buildBuyMaterial(materialController), 
                ], ),
            ),
            
            Positioned(
              bottom: 0,
              child: Container(
                height: 15, 
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.withAlpha(2), 
                      Colors.blueGrey.withAlpha(50), 
                    ],
                  ),
                ),
              ),
            ),
         ],
        ),
      ),
   );
 }

  Container buildNotification() {
    return Container(
  width: 40,
  height: 40,
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color:  const Color(0xFFCBD5E1),
      width: 1,
    ),
  ),
  child: Center(
    child: Icon(
      Icons.notifications_none_rounded,
      size: 20,
      color: const Color(0xFF0F172A),
      weight: 1.5, // ensures stroke consistency
    ),
  ),
         );
  }


  SizedBox buildBuyMaterial(MaterialsController materialController) {
    return SizedBox(
                  //   width: 328,
              height: 410, 
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount:materialController.materials.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                    
              return CourseCard(
                imageUrl: materialController.materials[index].image!,
                title: materialController.materials[index].title!,
                author: materialController.materials[index].brand!,
                timeAgo: materialController.materials[index].time!, 
                price: materialController.materials[index].price!, 
                oldPrice: materialController.materials[index].originalPrice!, 
                rating: "${materialController.materials[index].rating} (${materialController.materials[index].reviews})",
                badge: materialController.materials[index].tag,
                showAddButton: true,
                 onAddPressed: () {
                    final cart = context.read<CartController>();
                    cart.addItem(
                      CartItem(
                        title:  materialController.materials[index].title ?? '',
                        image: materialController.materials[index].image ?? '',
                        price: double.tryParse(materialController.materials[index].price ?? '0') ?? 0,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${materialController.materials[index].title} added to cart')),
                    );
                  },
                );
                  },
                ),
                      );
  }

  SizedBox buildCourseslist(CoursesController coursesController) {
    return SizedBox(
          height: 268, 
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero, 
            itemCount: coursesController.courses.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final course = coursesController.courses[index];
              return CourseCard(
                imageUrl: course.image ?? '',
                  title: course.title ?? '',
                  author: course.author ?? '',
                  timeAgo: course.duration ?? '',
                  price: course.price ?? '',
                  oldPrice: course.originalPrice ?? '',
                  rating: "${course.rating} (${course.reviews})",
                  badge: course.tag,
                  showAddButton: false,
                      );
                    },
                  ),
               );
  }

  Container buildBanner(BannerController bannerController) {
    return Container(
          width: double.infinity,
          height: 140+10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: bannerController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : bannerController.bannerUrl != null
                    ? CachedNetworkImage(
                        imageUrl: bannerController.bannerUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: Icon(Icons.image_outlined, size: 40, color: Colors.grey),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.broken_image, size: 40, color: Colors.red),
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.broken_image, size: 40, color: Colors.red),
                      ),
          ),
        );
  }

  SizedBox buildSubjectlist(SubjectController controller) {
    return SizedBox(
            height: 80, 
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: controller.subjects.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12), 
              itemBuilder: (context, index) {
          final subject = controller.subjects[index];
          return Container(
            width: 159, 
            height: 80, 
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8), 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                 colors: [
                  Color(int.parse(subject.mainColor!.replaceFirst('#', '0xff'))),
                  Color(int.parse(subject.gradientColor!.replaceFirst('#', '0xff'))),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(
                   width: 32, 
                   height: 32,
                   child: Image.network(subject.icon ?? '',fit: BoxFit.cover),
                   ),
                const SizedBox(height: 14), 
                Expanded(
                  child: Text(
                     subject.subject ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 20 / 14,
                    ),
                  ),
                ),
              ],
            ),
          );
              },
            ),
          );
  }

  Row buldSearch() {
    return Row(
                children: [
            // Search field
            Expanded(
              child: TextField(
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 20 / 15, 
                  color: const Color(0xFF64748B),
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10), 
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    color: const Color(0xFF94A3B8),
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 15,
                    color: Color(0xFF64748B),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
              ),
            ),
            
            //Filter button
            Container(
              width: 44,
              height: 40,
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Color(0xFFCBD5E1),
                    width: 1,
                  ),
                ),
              ),
              child: const Icon(
                Icons.filter_list_outlined,
                size: 20,
                color: Color(0xFF64748B),
              ),
            ),
                ],
              );
  }

  InkWell buildCartBadge(BuildContext context) {
    return InkWell(
        onTap: () {
        showCartBottomSheet(context);
        setState(() {
        isSelected = !isSelected;
      }) ; 
    },
    child: Stack(
    clipBehavior: Clip.none, 
    children: [
      Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF8932EB)
                : const Color(0xFFCBD5E1),
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 20,
            color: Color(0xFF0F172A),
          ),
        ),
      ),

      // Badge
   
         Consumer<CartController>(
          builder: (_, cart, __) {
          if (cart.totalCount == 0) return const SizedBox.shrink();
       return Positioned(
          top: -2, 
          right: -2, 
          child: Container(
            width: 16,
            height: 16,
            padding: const EdgeInsets.fromLTRB(1, 3.5, 1, 3.5),
            decoration: BoxDecoration(
              color: Color(0xFF8932EB), 
              shape: BoxShape.circle,
            ),
            child: Center(       
              child: Text(
               ' ${cart.totalCount}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 11/ 20, 
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }),
    ],
   )
  );
  }
}



void showCartBottomSheet(BuildContext context) {
 showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    backgroundColor: Colors.transparent, 
    isScrollControlled: true,
    builder: (context) {
      final cart = context.watch<CartController>();
      return Padding(
        padding: const EdgeInsets.only(bottom: 56),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Container(
            width: double.infinity,
            height: 288.93,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF7F1FF),
                  Color(0xFFF6F0FF),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                SizedBox(height: 20),
                SizedBox(
                  width: 234,
                  height: 26,
                  child: Center(
                    child: Text(
                      'Your cart details',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 26 / 18,
                        color: Color(0xFF8932EB),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                 ListView.builder(
                   physics: BouncingScrollPhysics(),
                   padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: cart.items.length,
                  shrinkWrap: true,
                    itemBuilder: (context, index) { 
                   final item = cart.items.values.elementAt(index);
                   return Padding(
                     padding: const EdgeInsets.only(bottom: 12),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: item.image, 
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          ),
                        
                        ),
                     
                        const SizedBox(width: 12), 
                     
                             //Text Content
                             Container(
                               width: 171,
                               height: 40,
                               padding: const EdgeInsets.only(right: 2.83),
                               alignment: Alignment.centerLeft,
                               child: Text(
                                  item.title,
                                 style: const TextStyle(
                                   fontFamily: 'Inter',
                                   fontWeight: FontWeight.w500,
                                   fontSize: 14,
                                   height: 20 / 14, 
                                   color: Color(0xFF0F172A),
                                 ),
                                 textAlign: TextAlign.start,
                               ),
                             ),
                           ]
                         ),
                   );  },
                 ),
                 SizedBox(height: 20),
               ElevatedButton(
            onPressed: () { },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF60B246), 
              fixedSize: const Size(327+16+16, 30.93), 
              padding: const EdgeInsets.fromLTRB(16, 8, 41.73, 5.99), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), 
              ),
              elevation: 0,
            ),
            child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 3 Item
                  SizedBox(
                    width: 41,
                    height: 17,
                    child: Text(
                      "${cart.totalCount} Item",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500, 
                        fontSize: 14,
                        height: 16.94 / 14,
                        letterSpacing: -0.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
          
                  const SizedBox(width: 1.67),
    
                  SizedBox(
                    width: 3,
                    height: 17,
                    child: Text(
                      "|",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300, 
                        fontSize: 14,
                        height: 16.94 / 14,
                        letterSpacing: -0.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
          
                  const SizedBox(width: 8.33),
    
                  SizedBox(
                    width: 10,
                    height: 20,
                    child: Text(
                      "\$",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 20 / 14,
                        letterSpacing: 0,
                        color: Colors.white,
                      ),
                    ),
                  ),
          
                  // Price 
                  SizedBox(
                    width: 35,
                    height: 17,
                    child: Text(
                      cart.totalPrice.toStringAsFixed(2),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 16.94 / 14,
                        letterSpacing: -0.3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
           ),
      SizedBox(height: 20),
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Outlined Button
        Container(
          width: 157+16,
          height: 44,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEEE0FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF9F54F8), width: 1),
          ),
          child: Center(
            child: Text(
                    "Close",
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF9F54F8),
                    ),
                  ),
                ),
              ),
          
             const SizedBox(width: 12), 
           //Gradient Button
          SizedBox(
          width: 158+16,
          height: 44,
          child: Stack(
            children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8932EB),
                  Color(0xFF8932EB),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000), 
                  offset: Offset(0, 1),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          
          // White overlay gradient 
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.4),
                  Color.fromRGBO(255, 255, 255, 0.0),
                ],
              ),
            ),
          ),
          
          //Gradient border
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.transparent, 
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 0.36),
                      Color.fromRGBO(255, 255, 255, 0.0),
                    ],
                  ).createShader(Rect.fromLTWH(0, 0, rect.width, rect.height));
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          
          //Button content
          Center(
            child: Text(
              "Checkout",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
                  ],
                ),
              )
                ],
              )
          
              ],
            ),
          ),
        ),
      );
    },
  );
}
