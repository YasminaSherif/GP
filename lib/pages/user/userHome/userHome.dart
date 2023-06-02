import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/mainUser/cubit.dart';
import '../../../services/methods/navigation.dart';
import '../Catalogs.dart';
import '../best_workers_of_category.dart';



class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  String search='';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<mainCubit, mainStates>(
          listener: ( context,state) {
            if(state is getWorkersSuccessState){
            navigateWithBack(context,const BestWorkersOfCategory());
          }
          // if(state is searchSuccessState){
          //   navigateWithBack(context,const BestWorkersOfCategory());
          // }
          // if(state is searchSuccessState){
          //   navigateWithBack(context,const BestWorkersOfCategory());
          // }
          
          if(state is searchFaillState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('عذرا هذه الفئه غير متوفره')));
          }
          },
          builder: ( context,  state){
            var cubit=mainCubit.get(context);
    return Container(
        color: Colors.grey[350],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: const Color.fromRGBO(217, 173, 48, 1),
                  ),
                  height: 127.0,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 20.0,
                        ),
                        child: Icon(
                          Icons.settings,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20.0,
                  top: 95.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[400],
                    ) ,
                    width: 320.0,
                    height: 90.0,
                    child: Row(
                      children:   [
                        Container(
                          width: 152.0,
                          color: Colors.transparent,
                          child: const Text('الحل الامثل لجميع صيانات منزلك',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              height: 1.0
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),

                        Container(
                          width: 158.0,
                          height: 85.0,
                          color: Colors.transparent,
                          child:  const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/disaster-or-mental-health-crisis.png',
                            ),
                          ),
                        ),

                        ]
                    ),
                  ),
                ),
              ],
            ),
            
           Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                  width: double.infinity,
                  height: 50,
                margin: const EdgeInsets.only(
                  top: 66.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding:   EdgeInsets.all(5.0),
                  child: TextField(
                    onChanged: (val){
                      search=val;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        hintText: 'البحث',
                        icon: IconButton(icon: const Icon(Icons.search),
                        onPressed: () { 
                          cubit.search(search);
                         },
                         ),
                        hintStyle: const TextStyle(color: Colors.black45),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 5.0,
                        right: 20.0,
                      ),
                      child: Text('فئاتنا الرئيسية',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){
                          cubit.getWorkers(1);
                          
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 110.0,
                                height: 100.0,
                                color: const Color.fromRGBO(104, 140, 40, 1),
                              ),

                              const Positioned(
                                left: 65.0,
                                child: Text('نجار',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),
                              
                              Positioned(
                                top: 30.0,
                                child: Container(
                                  width: 60.0,
                                  height: 80.0,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__22_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),
                              


                            ],
                          ),
                        ),

                        MaterialButton(onPressed: (){
                           cubit.getWorkers(3);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 110.0,
                                height: 100.0,
                                color: Colors.yellow,
                              ),

                              const Positioned(
                                left: 55.0,
                                child: Text('كهربائي',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 30.0,
                                child: Container(
                                  width: 60.0,
                                  height: 80.0,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__40_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){
                           cubit.getWorkers(2);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 110.0,
                                height: 100.0,
                                color: const Color.fromRGBO(47, 52, 76, 1),
                              ),

                              const Positioned(
                                left: 65.0,
                                child: Text('حداد',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 30.0,
                                child: Container(
                                  width: 60.0,
                                  height: 80.0,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__26_-removebg-preview (1).png',
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),

                        MaterialButton(onPressed: (){
                           cubit.getWorkers(5);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 110.0,
                                height: 100.0,
                                color: const Color.fromRGBO(50, 135, 140, 1),
                              ),

                              const Positioned(
                                left: 65.0,
                                child: Text('سباك',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 30.0,
                                child: Container(
                                  width: 60.0,
                                  height: 80.0,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__36_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(
                      height: 5.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){
                           cubit.getWorkers(4);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 110.0,
                                height: 100.0,
                                color: const Color.fromRGBO(140, 131, 50, 1),
                              ),

                              const Positioned(
                                left: 65.0,
                                child: Text('تعقيم',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 30.0,
                                child: Container(
                                  width: 60.0,
                                  height: 80.0,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__38_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),


                      ],
                    ),

                    Center(
                      child: TextButton(onPressed: (){
                        navigateWithBack(context, Catalogs());
                      },
                          child: const Text('المزيد من الفئات',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],


        ),

      );
          },
    );

  }
}
