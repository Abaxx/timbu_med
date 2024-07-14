
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/api_service.dart';
import '../data/products_model.dart';
import '../data/products_repo.dart';

class Cart extends StatelessWidget {
  final apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    final productRepo = ProductRepo(apiClient);
    return Scaffold(
      appBar: AppBar(
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
                Text('Cart Summary',style: TextStyle(fontSize: 20.sp,color: Colors.black),),
                SizedBox(height: 20.h),
                Align(child: Text('Medix pharmacy',style: TextStyle(fontSize: 10.sp,color: Color(0xff696363)),),alignment: Alignment.topLeft,),
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
                                    child: Row(
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
                                            SizedBox(child: Text('$name for men',style: TextStyle(color: Colors.black,fontSize: 15.h),)),
                                            SizedBox(height: 5.h),
                                            Text('millions & millions',style: TextStyle(color: Color(0xffA9A9A9),fontSize: 10.sp),),
                                            SizedBox(height: 5.h,),
                                            Text('NGN $price',style: TextStyle(color: Color(0xffDC1250),fontSize: 15.sp),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const Positioned(
                                      top: 15,
                                      right: 20,
                                      child: Icon(Icons.favorite_outline_sharp,))
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
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Checkout()));
      },
          backgroundColor: Color(0xffDC1250),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Text('Checkout',style: TextStyle(color: Colors.white,fontSize: 15.sp),),
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}