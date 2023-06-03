import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/pages/worker/craft_profile_editing/pastWorkItem.dart';
import 'package:fortestpages/pages/worker/craft_profile_editing/work_image_item.dart';

import '../../../bloc/workerData/cubit.dart';
import '../../../customized/FormButton.dart';
import '../../user/craft_profile/ratingItem.dart';
import 'craft_bio_editing.dart';
import 'craft_work_images_editing.dart';

class CraftProfileEditing extends StatelessWidget {
  const CraftProfileEditing({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<workerDataCubit, workerDataStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
         late double _minTextAdapt = 0.0;
        var cubit=workerDataCubit.get(context);
        
       
    return Scaffold(
      body:  (cubit.workerResponse == null)
      ? const Center(child: CircularProgressIndicator())
      :Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.arrow_back_sharp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 140.0,
                    top: 85.0,
                    child: Column(
                      children:  [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children:  [
                             CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: 35.0,
  child: CircleAvatar(
      
    backgroundImage: cubit.workerResponse![0].image != null
        ? MemoryImage(base64Decode(cubit.workerResponse![0].image!))
        : null,
    radius: 35.0,
    backgroundColor: Colors.grey,
  ),
),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:
                                   GestureDetector(
                                     onTap: () {},
                                     child: const Icon(
                                      Icons.camera_alt,
                                      size: 12,
                                      color: Colors.white,
                                  ),
                                   ),

                              ),
                            ),
                          ],
                        ),

                         Text(cubit.workerResponse![0].firstName +' '+ cubit.workerResponse![0].lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                         Text(cubit.workerResponse![0].cate!.name!,
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1.0,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [

                            Icon(Icons.star_rate,
                              color: Colors.amber,
                              size:20.0 ,
                            ),
                             Text(cubit.workerResponse![0].rating.toString(),
                              style: TextStyle(
                                height: 1.0,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 85.0,
                ),
                color: Colors.white,
                height: 80.0,
                child: Column(
                  children:  [
                    Row(
                      children:  [
                        IconButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CraftInfoEditing(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit,
                            color: Colors.grey,
                            size:16.0,
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text('عني',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 65.0,
                            right: 10.0,
                          ),
                          child: Column(
                            children: [
                              Text(cubit.workerResponse![0].bio??"لم يتم اضافة تفاصيل بعد",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.grey,
                                  height: 1.1,
fontSize: _minTextAdapt != 0.0 ? _minTextAdapt : MediaQuery.of(context).size.width * 0.045,                                  fontWeight: FontWeight.w700,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              Container(
                color: Colors.white,
                height: 135.0,
                width: double.infinity,
                child: Column(
                  children:  [
                    Row(
                      children:  [
                        IconButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  CraftWorkImagesEditing(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.drive_folder_upload,
                            color: Colors.grey,
                            size:16.0,
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text('اعمالي',

                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (cubit.workerResponse![0].pastWorkImages== null)
                     const Center(
                        child: Text(
                          "لا يوجد",
                          style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ))
                    
                else Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Container(
                        height: 85.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context, index)=> WorkImageItem(image:cubit.workerResponse![0].pastWorkImages![index]),
                          separatorBuilder:(context, index)=> const SizedBox(width: 8.0) ,
                          itemCount: cubit.workerResponse![0].pastWorkImages!.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              Container(
                color: Colors.white,
                height: 130.0,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:   [
                    const Padding(
                      padding: EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: Text('التقييمات و التعليقات',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  if (cubit.workerResponse![0].review== null)
                     const Center(
                        child: Text(
                          "لا يوجد",
                          style: TextStyle(
                            color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ))
                    
                else Expanded(
                      child: MediaQuery.removePadding(
                        removeTop:true ,
                        context: context,
                        child: ListView.separated(
                          itemBuilder:(context, index)=> ratingItem(review:cubit.workerResponse![0].review![index]),
                          separatorBuilder:(context, index)=> const Divider(height: 15) ,
                          itemCount: cubit.workerResponse![0].review!.length,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color.fromRGBO(217, 173, 48, 1),

                  ),
                
                ),
              )
            ],


          ),
        ),

      ),



    );
      });
  }
}