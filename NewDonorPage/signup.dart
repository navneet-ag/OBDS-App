import 'package:flutter/material.dart';
import 'dart:async';
import 'mysql1.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}
class BloodGroup {
  int id;
  String group;
 
  BloodGroup(this.id, this.group);
 
  static List<BloodGroup> getgroups() {
    return <BloodGroup>[
      BloodGroup(1, 'A+'),
      BloodGroup(2, 'A-'),
      BloodGroup(3, 'B+'),
      BloodGroup(4, 'B-'),
      BloodGroup(5, 'O+'),
      BloodGroup(6, 'O-'),
      BloodGroup(7, 'AB+'),
      BloodGroup(8, 'AB-'),
      BloodGroup(9,'Not sure')

    ];
  }
}

class Organ {
  int id;
  String group;
 
  Organ(this.id, this.group);
 
  static List<Organ> getorgans() {
    return <Organ>[
      Organ(1, 'Cornea'),
      Organ(2, 'Heart'),
      Organ(3, 'Heart'),
      Organ(4, 'Kidney'),
      Organ(5, 'Lung'),
      Organ(6, 'Pancreas'),
      Organ(7,'None')
    ];
  }
}
class _SignupPageState extends State<SignupPage> {

  String alertTitle="Error",alertContent="";

  createAlertDialog(BuildContext context)
  {
    print(alertTitle);
    return showDialog(context: context ,builder:(context){
    return AlertDialog(
      title: Text(alertTitle,     style: TextStyle(fontFamily: 'Montserrat'),),
      content: Text(alertContent,     style: TextStyle(fontFamily: 'Montserrat'),),
      actions: <Widget>[MaterialButton (
                                        elevation:5,
                                        child :Text("Go Back",style: TextStyle(fontFamily: 'Montserrat')),  
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                          })],
    );

    });

      }
      bool isNumeric(String s) {
          if(s == null) {
              return false;
            }
          return double.parse(s, (e) => null) != null;
        }
  
   var db = new Mysql();
  
      void _getCustomer() {
    db.getConnection().then((conn) {
      // String sql = 'insert into New_Donor(Age,DON_id,Name,Address,Contact,Blood_Group,Pincode,Organ) values ("19","3","A","12312312","123213213","+","231001","Kidney");';
      // conn.query(sql);
      // .then((results) {
      //   for(var row in results){
      //       print(row);
      //   }
      // }); 
      conn.close();
    });
  }


  
    List<BloodGroup> _groups = BloodGroup.getgroups();
    List<DropdownMenuItem<BloodGroup>> _dropdownMenuItems;
    List<Organ> _organs = Organ.getorgans();
    List<DropdownMenuItem<Organ>> _dropdownMenuorgans;

    Organ _selectedOrgan;
    BloodGroup _selectedBloodGroup;
    bool BloodDonorCheckBox=false;
    bool OrganDonorCheckBox=false;
    final NameController=new TextEditingController();
    final AgeController=new TextEditingController();
    final AddressController=new TextEditingController();
    final PinController=new TextEditingController();
    final PhoneController=new TextEditingController();
    String Name,Age,Address,Pincode,Phone;

  List<DropdownMenuItem<BloodGroup>> buildDropdownMenuItems(List groups) {
    List<DropdownMenuItem<BloodGroup>> items = List();
    for (BloodGroup BloodGroup1 in groups) {
      items.add(
        DropdownMenuItem(
          value: BloodGroup1,
          child: Text(BloodGroup1.group),
        ),
      );
    }
    return items;
  }
  onChangeDropdownItem(BloodGroup selectedBloodGroup) {
  setState(() {
    _selectedBloodGroup = selectedBloodGroup;
    print(_selectedBloodGroup.group);
  });
  }

  List<DropdownMenuItem<Organ>> buildOrganDropdownMenuItems(List groups) {
    List<DropdownMenuItem<Organ>> items = List();
    for (Organ Organ1 in groups) {
      items.add(
        DropdownMenuItem(
          value: Organ1,
          child: Text(Organ1.group),
        ),
      );
    }
    return items;
  }
  onChangeOrganDropdownItem(Organ selectedOrgan) {
  setState(() {
    _selectedOrgan = selectedOrgan;
    print(_selectedOrgan.group);
  });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
              padding: EdgeInsets.only(top: 4.0, left: 20.0, right: 20.0),
                  child: Text(
                    'Signup',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: NameController,
                    decoration: InputDecoration(
                      hintText: 'Please Enter both First and Last Name',
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: AgeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'You must be atleast 18 years old',
                        labelText: 'Age ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: AddressController,
                    decoration: InputDecoration(
                        hintText: 'House number,Street Name, City,State',

                        labelText: 'Address',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),     
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(
                                child:TextField(
                                  controller: PinController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration( contentPadding: EdgeInsets.all(10),
                                  hintText: 'XXXXXX',
                                  labelText: 'Pin Code',
                                  labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                                )
                              ),
                              SizedBox(width: 5.0),              
                              new Flexible(
                              child: TextField(
                                controller: PhoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration( 
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: 'Phone Number',
                                  hintText: 'XXXXXXXXXX',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green)
                                    )
                                  ),
                              )  )          ]
                                        ),
                                  
                  SizedBox(height: 10.0),
                  // TextField(
                  //   decoration: InputDecoration(
                  //       labelText: 'Blood Group',
                  //       labelStyle: TextStyle(
                  //           fontFamily: 'Montserrat',
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.grey),
                  //       focusedBorder: UnderlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.green))),
                  // ),
                              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Blood Group',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.0),              
                DropdownButton(
                  value: _selectedBloodGroup,
                items: buildDropdownMenuItems(_groups),
                
                onChanged: onChangeDropdownItem,
                 underline: Container(
                      height: 2,
                       color: Colors.greenAccent,
                      ))]
              ),
                              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                        Text(
                            'Do you want to be a Blood Donor?',
                            style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5.0),              
                                          Checkbox(value:BloodDonorCheckBox,
                            onChanged: (bool value )
                            {setState(() {
                              BloodDonorCheckBox=value;
                            });})
                           ,]
                        ),
                            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                        Text(
                            'Do you want to be a Organ Donor?',
                            style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5.0),              
                                          Checkbox(value:OrganDonorCheckBox,
                            onChanged: (bool value )
                            {setState(() {
                              OrganDonorCheckBox=value;
                            });})
                           ,]
                        ),
                                         Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Organ To Donate',
                  style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5.0),              
                DropdownButton(
                  value: _selectedOrgan,
                items: buildOrganDropdownMenuItems(_organs),
                
                onChanged: onChangeOrganDropdownItem,
                 underline: Container(
                      height: 2,
                       color: Colors.greenAccent,
                      ))]
              ),

                 SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: new RaisedButton(
                        // borderRadius: BorderRadius.circular(20.0),
                        // shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        // child: GestureDetector(
                          onPressed: () {
                            // _getCustomer();
                            print("hello");
                            setState(() {
                              Name=NameController.text;
                              Age=AgeController.text;
                              Address=AddressController.text;
                              Pincode=PinController.text;
                              Phone=PhoneController.text;
                              if(Name.length==0)
                              {    
                                                                print("hello14");

                                alertContent="Name Field cannot be Empty";
                                createAlertDialog(context);
                              }
                              else if(Age.length==0)
                              {
                                                                print("hello13");

                                alertContent="Age Field cannot be Empty";
                                createAlertDialog(context);
                              }
                              else if(!isNumeric(Age))
                              {
                                                                print("hello12");

                                alertContent="Enter your age in Numeric form like \'20\'";
                                createAlertDialog(context);
                              }
                              else if(Address.length==0)
                              {
                                                                print("hello10");

                                alertContent="Address Field cannot be Empty";
                                createAlertDialog(context);

                              }

                              else if(Pincode.length==0)
                              {
                                                                print("hello9");

                                alertContent="Pincode Field cannot be Empty";
                                createAlertDialog(context);
                              }
                              else if(!isNumeric(Pincode))
                              {
                                                                print("hello8");

                                alertContent="Pincode should be Numeric of the form XXXXXX \n e.g: 243122";
                                createAlertDialog(context);
                              }
                              else if(Phone.length==0)
                              {
                                alertContent="Phone Field cannot be Empty";
                                createAlertDialog(context);
                              }
                              else if(!isNumeric(Phone))
                              {
                                                                print("hello5");

                                alertContent="PHone number should contain digits onlu.";
                                createAlertDialog(context);
                              }
                              else if(_selectedBloodGroup==null)
                              {
                                print("hello3");

                                alertContent="Please Select a Blood Group \n Choose \"Not Sure\" if you are not sure";
                                createAlertDialog(context);
                              }
                              else if(isNumeric(Age))
                              {
                                print("hello11");
                                var age=int.parse(Age);
                                if(age<17)
                                {
                                  alertContent="Minimum age can be 18";
                                  createAlertDialog(context);
                                }
                              }
                              else if(isNumeric(Pincode))
                              {
                                if(Pincode.length!=6)
                                {
                                                                  print("hello7");

                                alertContent="Not a valid Pincode";
                                createAlertDialog(context);
                                }
                                else
                                {
                                  var pin=int.parse(Pincode);
                                  if(pin>929999 ||pin <110000)
                                  {
                                                                    print("hello6");

                                    alertContent="NOt a valid Pincode";
                                    createAlertDialog(context);
                                  }
                                }
                              }

                              else if(isNumeric(Phone))
                              {
                                if(Phone.length!=10)
                                {
                                                                  print("hello4");

                                alertContent="Please Enter a valid mobile number";
                                createAlertDialog(context);
                                }
                              }


                              else{
                                print("hello2");
                             print(Name); 
                              print(Age); 
                              print(Address); 
                              print(Pincode); 
                              print(Phone); 
                              print(OrganDonorCheckBox);
                              print(BloodDonorCheckBox);
                              print(_selectedBloodGroup.group);
                              print(_selectedOrgan.group);
                              NameController.text="";
                              AgeController.text="";
                              AddressController.text="";
                              PinController.text="";
                              PhoneController.text="";
                              OrganDonorCheckBox=false;
                              BloodDonorCheckBox=false;
                              _selectedBloodGroup=null;
                              _selectedOrgan=null;
 
                              }
                            });
                          },
                          child: Center(
                            
                            child: Text(
                              'SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        // ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: 
                            Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                        
                        
                      ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}