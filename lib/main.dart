import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color white = Colors.white;
  static const Color black = Color(0xff000000);
  static const Color grey = Colors.grey;
  static const Color deepPurple = Colors.deepPurple;
  static const Color lightGrey = Color(0xffF7F7F7);
  static const Color soldOutGrey = Color(0xff716D6D);
  static const Color brandPurple = Color(0xff6E68D6);
  static const Color priceGreen = Color(0xff0AA051);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(), // ✅ Google Fonts here
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final List<String> sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<String> soldOutSizes = ['L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.white,
        title: Image.asset('assets/fyva_logo_png.png'),
        centerTitle: true,
        leading: Image.asset('assets/drawerpng.png', height: 10),
        actions: [
          SvgPicture.asset('assets/search.svg'),
          const SizedBox(width: 30),
          SvgPicture.asset('assets/cart.svg'),
          const SizedBox(width: 22),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProductImage(),
            _buildModelInfo(),
            _buildProductDetails(),
            _buildDivider(),
            _buildSizeSelector(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AspectRatio(
          aspectRatio: 0.75,
          child: Image.asset('assets/imagepng.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildModelInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 27,
      width: double.infinity,
      alignment: Alignment.center,
      color: const Color(0xffF3F3FF),
      child: const Text(
        'Our Model is (5’6” tall) and is wearing a size S',
        style: TextStyle(fontSize: 12, color: Color(0xff1A1919)),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            "Women Slim Fit Knitted Round Neck Blue Sweater",
            style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Brand :'),
                  Text('  SMUKK', style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
              Text(
                'View Brand',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          Row(
            children: [
              const Text('₹929', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(width: 4),
              const Text('MRP ₹3,999', style: TextStyle(color: Color(0xff6F6E6E))),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.priceGreen,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Text('Save ₹1599', style: TextStyle(fontSize: 12, color: AppColors.white)),
              ),
            ],
          ),
          const Text(
            'Inclusive of all taxes',
            style: TextStyle(fontSize: 12, color: Color(0xff6F6E6E)),
          ),
          const SizedBox(height: 19),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 7, color: AppColors.lightGrey);
  }

  Widget _buildSizeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Text('Size Guide', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.brandPurple)),
            ],
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sizes.map((size) {
              if (soldOutSizes.contains(size)) {
                return SizeOptionWithSoldOut(label: size);
              } else {
                if(size == 'M'){
                  return SizeOption(label: size, isSelected: true,);
                }
                return SizeOption(label: size);
              }
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class SizeOption extends StatelessWidget {
  final String label;
  final bool isSelected;

  const SizeOption({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 47,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black12.withOpacity(0.09) : AppColors.white,
        borderRadius: BorderRadius.circular(80),
        border: Border.all(
          width: 1,
          color: isSelected ? AppColors.black : AppColors.grey.withOpacity(0.5),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class SizeOptionWithSoldOut extends StatelessWidget {
  final String label;

  const SizeOptionWithSoldOut({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizeOption(label: label),
        const SizedBox(height: 2),
        const Text(
          'sold out',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.soldOutGrey),
        ),
      ],
    );
  }
}
