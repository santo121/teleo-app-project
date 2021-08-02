import 'package:flutter/material.dart';

class OrderedItemListingSection extends StatelessWidget {
  const OrderedItemListingSection({Key key,this.deliveryType,this.orderstatus,this.price,this.productName,this.ordertime,this.paymentType,this.quntity,this.unit,this.userid,this.image}) : super(key: key);
  final String productName,quntity,price,unit,ordertime,orderstatus,userid,deliveryType,paymentType,image;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.5, left: 10, right: 10, bottom: 2.5),
      
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [

          Padding( 
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              
              margin: EdgeInsets.only(top:8, bottom: 8,),
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.width * .2,
              decoration: BoxDecoration(
                image: DecorationImage(
                                      image: NetworkImage(
                                          image != null ? image : ""),
                                      fit: BoxFit.cover),
                
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName!=null?productName:"Name",style: TextStyle(fontSize: 16),),
                SizedBox(
            height:5,
          ),
                Text("qnt: $quntity $unit"),
                SizedBox(
            height: 5,
          ),
                Text("₹ $price",style: TextStyle(fontSize: 18)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
