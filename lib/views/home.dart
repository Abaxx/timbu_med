import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timbu_med_hng/data/products_model.dart';
import 'package:timbu_med_hng/views/details.dart';

import '../data/api_service.dart';
import '../data/products_repo.dart';

class Home extends StatelessWidget{
  Home({super.key});
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
            SizedBox(
              child: Row(
                children: [
                  Icon(Icons.shopping_cart_outlined,size: 20,color: Colors.black,),
                  Icon(Icons.notification_important_outlined,size: 20,color: Colors.black,),
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'search for products...',
                suffixIcon: Icon(Icons.list_alt_sharp),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1,color: Color(0xff999999)),
                  borderRadius: BorderRadius.circular(10),

                )
              ),
            ),
            SizedBox(height: 15.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                Text('Wears',style: TextStyle(color: Color(0xffDC1250),fontSize: 20.sp,fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.calendar_view_month_sharp,size: 20,color: Colors.black,),
                Icon(Icons.menu_outlined,size: 20,color: Colors.black,),
              ],
            ),
            SizedBox(height: 10.h,),
            Expanded(
              child: FutureBuilder<List<ProductsModel>>(
                  future: productRepo.getProductsList(context),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasData){
                        return GridView.builder(
                          itemCount: snapshot.data!.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                                crossAxisSpacing: 2),
                            itemBuilder: (context,index){

                              // Extracting data from snapshot
                              final name = snapshot.data![index].productName;
                              final image = snapshot.data![index].productImage;
                              final price = snapshot.data![index].productPrice;
                              final id = snapshot.data![index].productId;

                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(productId: id,productPrice: price,)));
                                },
                                child: Card(
                                  color: Color(0xffF9FBFD),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 60.h,
                                              width: 60.w,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(image),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(name,style: TextStyle(color: Colors.black,fontSize:12.sp),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Niacin',style: TextStyle(color: Color(0xff999999),fontSize:10.sp),),
                                                SizedBox(width: 10.w,),
                                                Container(
                                                  width: 60,
                                                  color: Colors.white,
                                                  alignment: Alignment.center,
                                                  child: Text('1.8grams',style: TextStyle(fontSize:10.sp),),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                Icon(Icons.star,color: Colors.yellow,size: 15,),
                                                SizedBox(width: 10,),
                                                Text('(4.8 ratings)',style: TextStyle(color: Color(0xff999999),fontSize:10.sp),),
                                              ],
                                            ),
                                            SizedBox(height: 10.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('NGN$price',style: TextStyle(color: Color(0xffDC1250),fontSize: 15.sp),),
                                                Icon(Icons.shopping_cart_sharp,color: Color(0xffDC1250),)
                                              ],
                                            )
                                          ],
                                        ),
                                        const Positioned(
                                            right: 10,
                                            child: Icon(Icons.favorite_border_sharp)
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                        );
                      }else if(snapshot.hasError){
                        return Center(child: Text('${snapshot.error} occurred'),);
                      }else {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    }else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  }
              )
            )
          ],
        ),
      ),
    );
  }
}