import 'package:flutter/material.dart';
import 'package:pets_app/presentation/widgets/custom_services_button.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
      
          children: [
      
            Container(
              width: double.infinity,
              height: 80,
              margin: const EdgeInsets.only(
                top: 47,
                left: 16,
                right: 16
              ),
              padding: const EdgeInsets.all( 16 ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all( Radius.circular( 16 ) ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
      
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.all( Radius.circular( 8 ) )
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                    ),
                  ),
      
                  const SizedBox(
                    width: 16,
                  ),
      
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
      
      
                        Text(
                          'Hi, Juan!',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                  
                        Text(
                          'Envigado, Colombia.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w200
                          ),
                        ),
                      ]
                    
                    ),
                  ),
      
                  
      
                  IconButton(
                    onPressed: (){}, 
                    icon: const Icon(
                      Icons.search
                    )
                  ),
      
                  IconButton(
                    onPressed: (){}, 
                    icon: const Icon(
                      Icons.notifications
                    )
                  ),
      
      
                ]
              )
            ),
      
      
      
            Container(
              width: double.infinity,
              height: 190,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all( 16 ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all( Radius.circular( 16 ) ),
              ),
      
              child: Column(
                
                children: [
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const Text(
                        'Your Pets',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
            
                      Container(
                        width: 58,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white
                        ),
                        child: const Center(
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            
                            ),
                          ),
                        ),
                      ),
            
                    ],
                  ),
      
                  const SizedBox( height:  16 ),
            
                  Row(
                    children: [
                      
                      Column(
                        children: [
      
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(
                              Icons.add_circle,
                              color: Colors.yellow[600],
                            ),
                          ),
      
                          const Text(
                            'Add Pet',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
      
                        ],
                      ),
      
                      const SizedBox( width: 16,),
      
                      Column(
                        children: [
      
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Icon(
                              Icons.adb,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
      
                          const Text(
                            'Pet 1',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          
                        ],
                      ),
      
                      
                      const SizedBox( width: 16,),
      
                      Column(
                        children: [
      
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Icon(
                              Icons.adb,
                              color: Colors.red,
                              size: 30
                            ),
                          ),
      
                          const Text(
                            'Pet 2',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          
                        ],
                      ),
      
                      
                      const SizedBox( width: 16,),
      
                      Column(
                        children: [
      
                          Container(
                            width: 60,
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Icon(
                              Icons.adb,
                              color: Colors.purple,
                              size: 30
                            ),
                          ),
      
                          const Text(
                            'Pet 3',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          
                        ],
                      ),
            
            
                    ],
                  ),
            
                ],
              ),
            ),
      
            
      
            Container(
              width: double.infinity,
              height: 340,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all( 16 ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all( Radius.circular( 16 ) ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const Text(
                        'Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
            
                      Container(
                        width: 58,
                        height: 34,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white
                        ),
                        child: const Center(
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            
                            ),
                          ),
                        ),
                      ),
            
                    ],
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      CustomServicesButton(),

                      CustomServicesButton(),

                    ],
                  ),

                  // SizedBox( height: 16,),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      CustomServicesButton(),

                      CustomServicesButton(),

                    ],
                  ),



                ],
              ),
            )
      
      
      
          ]
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home
            )
          ),

          // BottomNavigationBarItem(
          //   label: 'Network',
          //   icon: Icon(
          //     Icons.mark_chat_unread_sharp
          //   )
          // ),

          BottomNavigationBarItem(
            label: 'Store',
            icon: Icon(
              Icons.store_outlined
            )
          ),

          // BottomNavigationBarItem(
          //   label: 'Adopt',
          //   icon: Icon(
          //     Icons.open_with_rounded
          //   )
          // ),

          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              Icons.person_pin_rounded
            )
          ),

        ]
      ),
    );
  }
}