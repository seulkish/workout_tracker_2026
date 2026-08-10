import 'package:flutter/material.dart';

class DuolingoHome extends StatelessWidget {
  const DuolingoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          // padding: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 위쪽 이미지·텍스트 영역
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 200),
                    // 이미지
                    Image.asset(
                      'assets/duolingo_1.png',
                      width: screenWidth,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 15),

                    // 로고 텍스트
                    Image.asset(
                      'assets/duolingo_logo.png',
                      width: 180,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 10),

                    // 설명 텍스트
                    const Text('Learn for free. Forever.',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF787677),
                          height: 25 / 18,
                          letterSpacing: 0,
                        )
                    ),
                    // const Spacer(),
                  ],
                  ),
                ),

              // 아래쪽 버튼 영역
              Column(
                children: [
                  // 시작 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF58CC02),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'GET STARTED',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 로그인 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child:
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE5E5E5), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'I ALREADY HAVE AN ACCOUNT',
                        style: TextStyle(
                          color: Color(0xFF58CC02),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
