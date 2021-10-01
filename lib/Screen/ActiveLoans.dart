import 'dart:convert';

import 'package:creditscore/Apiservice/ApiserviceProvider.dart';
import 'package:creditscore/Apiservice/Responce/DisposementLoanResponce.dart';
import 'package:creditscore/Apiservice/Responce/GetLoanDetailsResponce.dart';
import 'package:creditscore/Common/Colors.dart';
import 'package:creditscore/Common/Constants.dart';
import 'package:creditscore/Common/FadeAnimation.dart';
import 'package:creditscore/Data/Keys.dart';
import 'package:creditscore/Data/PreferenceManager.dart';
import 'package:creditscore/Screen/AvailedLoanScreen2.dart';
import 'package:creditscore/Screen/repayment/Repayment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'AvailedLoanScreen1.dart';

class ActiveLoans extends StatefulWidget {
  @override
  _ActiveLoansState createState() => _ActiveLoansState();
}

class _ActiveLoansState extends State<ActiveLoans> {


  List<String> litems_amount = ["1000","2000","8000","40000","3000"];
  final List<int> loanid = <int>[101, 102, 103,104,105,];
  final List<int> loanamount = <int>[1000, 2000, 8000,40000,3000];
  List<String> litems_id = ["123Rffh56ku","1456htrfhjl","173Rffh56ku","153Rffh56ku","193Rffh56ku"];

  Future<GetDisposementLoan> loandetails;
  final value = new NumberFormat("#,##0", "en_US");

  @override
  void initState() {

    loandetails = getDetails();
    super.initState();
  }
  Future<GetDisposementLoan> getDetails() async {
    String token = await PreferenceManager.sharedInstance
        .getString(Keys.ACCESS_TOKEN.toString());
    String userId = await PreferenceManager.sharedInstance
        .getString(Keys.USER_ID.toString());
    var response = await http.get(Uri.parse(APIS.disposementLoan+userId),headers: {
      'Authorization':token,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    print(Uri.parse(APIS.availedLoan),);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        print(data);
        /*String data = response.body;

        var decodedData = jsonDecode(data);
        GetDashboardDetails registrationResponse = GetDashboardDetails.fromJson(decodedData);

        print(registrationResponse.amountApproved);*/
        return GetDisposementLoan.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      throw Exception('Failed to load ');
    }


  }


//Text("Loans Availed"),
  Future showAlert1(BuildContext context,int loanid) async {
    return await showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title:  Align(child:Image.asset(
                Constants.developerLogo,
                width: 50,
                height: 50,
              ),alignment: Alignment.center,),
              content: SingleChildScrollView(child: Container(height:250,child:
              Column(children: [
                Text("Loan ID   :${loanid}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
               /* FittedBox(child:Text("${loanid}",style: TextStyle(color: Colors.black,fontSize: 12)) ,
                  fit:BoxFit.contain,),*/
                FadeAnimation(1.6,
                    Text("Loan Approved", style: TextStyle(color: Rmlightblue, fontSize: 18, fontWeight: FontWeight.bold),)
                ),
                FadeAnimation(1.6,
                    Text("Awaiting", style: TextStyle(color: Rmlightblue, fontSize: 25, fontWeight: FontWeight.bold),)
                ),
                FadeAnimation(1.6,
                    Text("Disbursement", style: TextStyle(color: Rmlightblue, fontSize: 18, fontWeight: FontWeight.bold),)
                ),

              ],),),),
              actions: <Widget>[
                Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10,top: 10),
                  child: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(0.0),
                    color: Rmpick,
                    splashColor: Rmpick,
                    child: Ink(
                      decoration: BoxDecoration(
                        //color: Color(0xff0066ff),
                          gradient: LinearGradient(
                            colors: [
                              Rmlightblue,
                              Rmpick,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text(
                              "Close",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                            ),
                            Spacer(),
                            Card(
                              //color: Color(0xCDA3C5EC),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0)),
                              child: SizedBox(
                                width: 35.0,
                                height: 35.0,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Rmpick,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          );
        }
    );
  }
  Future showAlert(BuildContext context,int loanid,int amount) async {
    return await showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title:  Align(child:Image.asset(
                Constants.developerLogo,
                width: 50,
                height: 50,
              ),alignment: Alignment.center,),
              content: SingleChildScrollView(child: Container(height:250,child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Loan ID:",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  FittedBox(child:Text("${loanid}",style: TextStyle(color: Colors.black,fontSize: 12)) ,
                    fit:BoxFit.contain,),
                  SizedBox(height: 5,),
                  Text("Loan Date:",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  FittedBox(child:Text("31-08-2021",style: TextStyle(color: Colors.black,fontSize: 12)) ,
                    fit:BoxFit.contain,),
                  SizedBox(height: 5,),
                  Text("Amount:",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                  FittedBox(child:Text("RM ${amount}",style: TextStyle(color: Colors.black,fontSize: 12)) ,
                    fit:BoxFit.contain,),
                  SizedBox(height: 5,),
                  Text("Interest Rate:",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                  FittedBox(child:Text("2.5 %per month ",style: TextStyle(color: Colors.black,fontSize: 12)) ,
                    fit:BoxFit.contain,),
                  SizedBox(height: 5,),
                  Text("Fees:",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
                  FittedBox(child:Text("0.5%  of principal",style: TextStyle(color: Colors.black,fontSize: 12)) ,
                    fit:BoxFit.contain,),

                ],
              ),),),
              actions: <Widget>[
                Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 10,top: 10),
                  child: RaisedButton(
                    onPressed: () async {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(0.0),
                    color: Rmpick,
                    splashColor: Rmpick,
                    child: Ink(
                      decoration: BoxDecoration(
                        //color: Color(0xff0066ff),
                          gradient: LinearGradient(
                            colors: [
                              Rmlightblue,
                              Rmpick,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text(
                              "Close",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                            ),
                            Spacer(),
                            Card(
                              //color: Color(0xCDA3C5EC),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0)),
                              child: SizedBox(
                                width: 35.0,
                                height: 35.0,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Rmpick,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
               /* FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close")),*/
              ]
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Rmlightblue,
        child:SafeArea(
        child: Scaffold(
        /*appBar: AppBar(
        brightness: Brightness.light,
        leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Rmlightblue),
    onPressed: () => Navigator.of(context).pop(),
    ),
    title:  FadeAnimation(1.6,
    Text("Active Loans", style: TextStyle(color: Rmlightblue, fontSize: 18, fontWeight: FontWeight.bold),)
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,),*/
          body:Center(child: FutureBuilder<GetDisposementLoan>(
            future: loandetails,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(

                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  height:MediaQuery.of(context).size.height,child:ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width ,
                            height: MediaQuery.of(context).size.height/2.8,


                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Rmlightblue, //                   <--- border color
                                width: 1.0,
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),

                            ),
                            margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),


                            child: Stack(children: [ Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 10,),

                                ListTile(
                                  title: Text("Loan Id  ACS09090k"),
                                  subtitle:FittedBox(child:Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Loan Amount :",style: TextStyle(fontSize: 14),),
                                          Text("Rm500",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),
                                          Text("Loan Tenure :",style: TextStyle(fontSize: 14),),
                                          Text("4 months",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),
                                          Text("Product Type :",style: TextStyle(fontSize: 14),),
                                          Text("BNPL",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),
                                          Text("Late Payments:",style: TextStyle(fontSize: 14),),
                                          Text("Yes",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),
                                        ],),

                                      SizedBox(width: 50,),

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Loan Date :",style: TextStyle(fontSize: 14),),
                                          Text("21-09-2021",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),
                                          Text("ACS Score :",style: TextStyle(fontSize: 14),),
                                          Text("7/10",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),
                                          Text("Repayment Status:",style: TextStyle(fontSize: 14),),
                                          Text("2 of 4",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),
                                          Text("Defaults:",style: TextStyle(fontSize: 14),),
                                          Text("Yes",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black)),


                                        ],)
                                    ],),fit: BoxFit.contain,),
                                  /* leading: CircleAvatar(

                            backgroundColor: Colors.blue,
                            child: CircleAvatar( radius: 18,backgroundColor: Colors.white,child:Container(padding:EdgeInsets.all(5),child: Image.asset("assets/images/logo.png"),),),
                          ),*/),
                                //trailing: Text("31-07-2021")),


                                SizedBox(height: 10,),

                                Spacer(),
                                GestureDetector(child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,

                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Rmlightblue,
                                          Rmpick,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text("Pay",style: TextStyle(color: Colors.white,fontSize: 12),)
                                    ],),),onTap: (){

                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => Repayment(screen: true,)));

                                  /* Navigator.push(
                             context, MaterialPageRoute(builder: (context) => SelectAccountPage()));*/

                                },),
                              ],
                            ),
                              /*Align(child:IconButton(icon: Icon(Icons.info,color: Colors.black,), onPressed: (){

                  }) ,alignment: Alignment.topRight,)*/
                            ],),
                          ),



                        ],
                      );
                    }),);
              } else if (snapshot.hasError) {
                return Container(child: Center(child: Text("No Data found !!"),),);
              }
              return const CircularProgressIndicator();
            },
          ),)
      ),)
    );
  }
}