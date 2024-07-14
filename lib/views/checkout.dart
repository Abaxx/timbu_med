import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timbu_med_hng/views/cart.dart';
import 'package:timbu_med_hng/views/favourite.dart';

import '../data/api_service.dart';
import '../data/products_model.dart';
import '../data/products_repo.dart';

class Checkout extends StatelessWidget {
  final apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    final productRepo = ProductRepo(apiClient);
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
                Text('Order Confirmation',style: TextStyle(fontSize: 20.sp,color: Colors.black),),
                SizedBox(height: 20.h),
                Align(child: Text('Order Summary',style: TextStyle(fontSize: 15.sp,color: Colors.black),),alignment: Alignment.topLeft,),
                SizedBox(height: 10.h)
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<ProductsModel>>(
                future: productRepo.getProductsList(context),
                builder: (context,AsyncSnapshot<List<ProductsModel>>snapshot){
                  // checking if future is resolved
                  if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasData){
                      return ListView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext ctx,int index){

                            // Extracting data from snapshot
                            final name = snapshot.data![index].productName;
                            final image = snapshot.data![index].productImage;
                            final price = snapshot.data![index].productPrice;
                            final id = snapshot.data![index].productId;

                            return Stack(
                              children: [
                                Card(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 100.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(image),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 15.h),
                                              SizedBox(child: Text('$name for men',style: TextStyle(color: Colors.black,fontSize: 15.h),)),
                                              SizedBox(height: 2.h),
                                              Text('millions & millions',style: TextStyle(color: Color(0xffA9A9A9),fontSize: 10.sp),),
                                              SizedBox(height: 2.h),
                                              RichText(text: TextSpan(text: 'Vendor: ',style: TextStyle(color: Colors.black,fontSize: 10.sp,fontWeight: FontWeight.bold),
                                                  children: [
                                                    TextSpan(text: 'D prince',style: TextStyle(color: Color(0xff999999),fontSize: 8.sp))
                                                  ]
                                              )
                                              ),
                                              SizedBox(height: 15.h,),
                                              Text('NGN $price',style: TextStyle(color: Color(0xffDC1250),fontSize: 15.sp),),
                                              Text('In stock',style: TextStyle(color: Colors.yellow,fontSize: 10.sp),),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: (){},
                                              child: const Row(children: [Icon(Icons.delete_sharp,color: Color(0xff9D99AC),size: 20,),
                                                Text('Remove',style: TextStyle(color: Colors.black,fontSize: 15),)
                                              ],)
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0,bottom: 15),
                                            child: ElevatedButton(onPressed: (){}, child: Text('-  +  -',style: TextStyle(color: Colors.black),)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const Positioned(
                                    top: 15,
                                    right: 20,
                                    child: Icon(Icons.circle_outlined,color: Color(0xffDC1250),))
                              ],
                            );
                          }
                      );
                    }else if (snapshot.hasError){
                      return const Center(child: Text('Error occurred'),);
                    }else {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  }else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()));
      },
          backgroundColor: Color(0xffDC1250),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Text('Pay Now',style: TextStyle(color: Colors.white,fontSize: 15.sp),),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}