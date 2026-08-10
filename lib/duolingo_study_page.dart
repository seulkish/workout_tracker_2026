import 'package:flutter/material.dart';

class DuolingoStudyPage extends StatelessWidget {
  const DuolingoStudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 33,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 닫기 버튼+프로세스 바
              SizedBox(
                height: 48,
                child: Row(
                  children: [

                    // 닫기 버튼
                    IconButton(
                      onPressed: (){},
                      padding: EdgeInsets.zero,
                      // constraints: const BoxConstraints(),
                      icon: Icon(
                        Icons.close,
                        size: 35,
                      ),
                    ),

                    const SizedBox(width: 14),

                    // 프로세스 바
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.1,
                        minHeight: 15,
                        borderRadius: BorderRadius.circular(10),
                        // backgroundColor: Colors.white70,
                        color: Color(0xFF58CC02),
                      ),
                    ),

                    const SizedBox(width: 14),

                  ],
                ),
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Image.asset('assets/duo_new_word.png'),
                  const SizedBox(width: 8),
                  Text('NEW WORD',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFCE82FF)
                      )
                  )
                ],
              ),

              const SizedBox(height: 18,),

              Text(
                'Select the correct image',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // 음성 버튼+단어
              Row(
                children: [
                  // 음성 버튼
                  Image.asset('assets/duo_speaker.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  // 단어
                  Text(
                    'un',
                    style: TextStyle(
                      fontSize: 17,
                      // fontWeight: FontWeight.,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // 이미지 선택 카드 4개
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: [
                  // 선택카드 1
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Image.asset(
                                  'assets/duolingo_2_1.png',
                                  // width: screenWidth,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Text('one',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      )
                  ),

                  // 선택카드 2
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/duolingo_2_2.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'the man',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),

                  // 선택카드 3
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/duolingo_2_3.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'the cat',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),

                  // 선택카드 4
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                'assets/duolingo_2_4.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'the boy',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 체크 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){},
                  child: Text(
                    'CHECK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF58CC02),
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
