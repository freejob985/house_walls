import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': 'assets/images/book.png', 'title': 'القرآن الكريم'},
    {'icon': 'assets/images/pray.png', 'title': 'الأدعية'},
    {'icon': 'assets/images/praying.png', 'title': 'الأحاديث'},
    {'icon': 'assets/images/tasbih.png', 'title': 'الاستغفار'},
    {'icon': 'assets/images/ruku.png', 'title': 'أذكار المنزل'},
    {'icon': 'assets/images/salah.png', 'title': 'صلاتي'},
    {'icon': 'assets/images/prayer (1).png', 'title': 'الأذان'},
    {'icon': 'assets/images/prayer (2).png', 'title': 'مواقيت الصلاة'},
    // {'icon': 'assets/images/quran.png', 'title': 'قراءتي'}, // افتراضنا أن هناك أيقونة للقراءة
    // {'icon': 'assets/images/sisters.png', 'title': 'الأخوات'}, // افتراضنا أن هناك أيقونة للأخوات
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('الصفحة الرئيسية', 
            style: GoogleFonts.alexandria(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
          elevation: 0,
        ),
        drawer: _buildDrawer(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.teal.shade50, Colors.white],
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(constraints),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) => _buildCard(
                  menuItems[index]['icon'],
                  menuItems[index]['title'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 1200) {
      return 5;
    } else if (constraints.maxWidth > 800) {
      return 4;
    } else if (constraints.maxWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            child: Text(
              'القائمة',
              style: GoogleFonts.alexandria(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          ...menuItems.map((item) => ListTile(
                leading: Image.asset(item['icon'], width: 24, height: 24),
                title: Text(item['title'], style: GoogleFonts.alexandria()),
                onTap: () {
                  // التنقل إلى الصفحة المناسبة
                },
              )).toList(),
        ],
      ),
    );
  }

  Widget _buildCard(String iconPath, String title) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: const Color.fromARGB(255, 224, 224, 224), width: 1),
      ),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // يمكنك إضافة وظيفة هنا عند النقر على البطاقة
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(iconPath, width: 60, height: 60)
                .animate()
                .fade(duration: 500.ms)
                .scale(delay: 200.ms),
            SizedBox(height: 8.0),
            Text(
              title,
              style: GoogleFonts.alexandria(fontSize: 16.0, color: Colors.teal.shade700),
              textAlign: TextAlign.center,
            ).animate()
                .fadeIn(delay: 300.ms)
                .moveY(begin: 10, end: 0),
          ],
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(duration: 1500.ms, color: const Color.fromARGB(255, 231, 231, 231).withOpacity(0.2))
        .animate()
        .scale(
          begin: Offset(1, 1),
          end: Offset(1.03, 1.03),
          duration: 200.ms,
          curve: Curves.easeInOut,
        )
        .then(delay: 200.ms)
        .scale(
          begin: Offset(1.03, 1.03),
          end: Offset(1, 1),
          curve: Curves.easeInOut,
        );
  }




}