
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/api_service.dart';
import '../data/product_details_model.dart';
import '../data/products_repo.dart';

class ProductDetails extends StatelessWidget {
  final apiClient = ApiClient();
  final productId;
  final productPrice;

  ProductDetails({super.key,this.productId,this.productPrice});

  @override
  Widget build(BuildContext context) {
    final productRepo = ProductRepo(apiClient);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF6FAFF),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                      color: Color(0xffDC1250),
                      shape: BoxShape.circle
                  ),
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new_outlined,size: 15,color: Colors.white,))
              ),
              Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  ),
                  child: Icon(Icons.shopping_bag_outlined,size: 20,color: Colors.black,)
              ),
            ],
          ),
        ),
        body: FutureBuilder<ProductDetailModel>(
            future: productRepo.getProductDetail(productId,context),
            builder: (context,AsyncSnapshot<ProductDetailModel>snapshot){
              // checking if future is resolved
              if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  final productDetail = snapshot.data;
                  final name = productDetail!.productName;
                  final image = productDetail.productImage;
                  final available = productDetail.productAvailable;
                  final description = productDetail.productDescription;
                  final availableQuantity = productDetail.productAvailableQuantity.toInt();

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              color: Color(0xffF6FAFF),
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 200.h,
                                width: 200.w,
                                decoration:  BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 7.h,
                                          width: 7.w,
                                          decoration: const BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                        SizedBox(width: 5.w,),
                                        Container(
                                          height: 15.h,
                                          width: 15.w,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            shape: BoxShape.circle,
                                            border: Border.all(width: 3.w,color: Colors.white),
                                          ),
                                          child: Container(
                                            height: 7.h,
                                            width: 7.w,
                                            decoration: const BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5.w,),
                                        Container(
                                          height: 7.h,
                                          width: 7.w,
                                          decoration: const BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 100.w,),
                                  Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.favorite_outline_sharp,size: 20,color: Colors.black,)
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('$name for men',style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                            ElevatedButton(onPressed: (){}, child: Text('-  +  -',style: TextStyle(color: Colors.black),))
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Wears',style: TextStyle(fontSize: 10.sp,color: Color(0xff999999)),),
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,size: 15,),
                                    Icon(Icons.star,color: Colors.yellow,size: 15,),
                                    Icon(Icons.star,color: Colors.yellow,size: 15,),
                                    Icon(Icons.star,color: Colors.yellow,size: 15,),
                                    Icon(Icons.star,color: Colors.yellow,size: 15,),
                                    SizedBox(width: 10.w,),
                                    Text('(320 review)',style: TextStyle(color: Color(0xff999999),fontSize:10.sp),),
                                  ],
                                ),
                              ],
                            ),
                            Text('Available in stock',style: TextStyle(fontSize: 10.sp,color: Colors.black),)
                          ],
                        ),
                        SizedBox(height: 25.h,),
                        Text('Description',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10.h,),
                        Text(description,
                          style: TextStyle(color: Color(0xff999999)),),
                        SizedBox(height: 100.h,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total price',style: TextStyle(fontSize: 10.sp,color: Color(0xff999999)),),
                            Text('NGN$productPrice',style: TextStyle(fontSize: 20.sp,color: Colors.black,fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ],
                    ),
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
        floatingActionButton: FloatingActionButton.extended(onPressed: (){},
            backgroundColor: Color(0xffDC1250),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            label: Row(
              children: [
                Icon(Icons.shopping_bag,size: 20,color: Colors.white,),
                SizedBox(width: 10.w,),
                Text('Add to cart',style: TextStyle(color: Colors.white,fontSize: 15.sp),)
              ],)
        ),
      ),
    );
  }

}