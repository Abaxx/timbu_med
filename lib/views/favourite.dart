
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/api_service.dart';

class Favourite extends StatelessWidget {
  final apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  Icon(Icons.list_outlined,size: 30,color: Colors.black,),
                  RichText(text: TextSpan(text: 'Timbu',style: TextStyle(color: Color(0xffDC1250),fontSize: 20.sp,fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: 'Wears',style: TextStyle(color: Color(0xff999999),fontSize: 20.sp))
                      ]
                  )
                  ),
                ],
              ),
            ),
            Icon(Icons.notification_important_outlined,size: 20,color: Colors.black,),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Text('Favourite',style: TextStyle(fontSize: 20.sp,color: Colors.black),),
                SizedBox(height: 20.h),
                Align(alignment: Alignment.topLeft,child: Text('favourite Items',style: TextStyle(fontSize: 15.sp,color: Colors.black),),),
                SizedBox(height: 10.h)
              ],
            ),
          ),
          SizedBox(height: 150.h,),
          Text('Favourite items',style: TextStyle(color: Colors.black,fontSize: 30.sp),),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));
      },
          backgroundColor: Color(0xffDC1250),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Text('Favourite',style: TextStyle(color: Colors.white,fontSize: 15.sp),),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}