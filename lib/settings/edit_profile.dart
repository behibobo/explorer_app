import 'package:explorer/models/user.dart';
import 'package:explorer/providers/auth.dart';
import 'package:explorer/providers/city_repo.dart';
import 'package:explorer/splash.dart';
import 'package:flutter/material.dart';
import 'package:persian_datepicker/persian_datepicker.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile(this.user);
  @override
  _EditProfileState createState() => new _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController textEditingController = TextEditingController();
  PersianDatePickerWidget persianDatePicker;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int gender = -1;
  String firstName;
  String lastName;
  String dob;

  List<String> _states = ["Choose a state"];
  List<String> _cities = ["Choose .."];
  String _selectedState = "Choose a state";
  String _selectedCity = "Choose ..";
  CityRepo repo = CityRepo();
  @override
  void initState() {
    persianDatePicker = PersianDatePicker(
            controller: textEditingController, datetime: widget.user.dob)
        .init();
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
    this.gender = widget.user.gender;
  }

  void _handleRadioValueChanged(int value) {
    setState(() {
      this.gender = value;
    });
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedCity = "Choose ..";
      _cities = ["Choose .."];
      _selectedState = value;
      _cities = List.from(_cities)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedCity(String value) {
    setState(() => _selectedCity = value);
  }

  Future<void> _update() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      AuthProvider prov = new AuthProvider();
      bool res = await prov.update(firstName, lastName,
       dob, gender, _selectedState, _selectedCity);
      if (res) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: Text(
          'اطلاعات با موفقیت ذخیره شد',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: "Vazir",
            fontSize: 12,
          ),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),

          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "ویرایش اطلاعات",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Vazir",
              fontSize: 14,
            ),
          ),
          centerTitle: true,
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.blue,
          //     ),
          //     onPressed: () {},
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.05), BlendMode.dstATop),
                  image: AssetImage('images/map.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: new Text(
                            "نام",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkBlue,
                              fontFamily: 'Vazir',
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 0.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: darkBlue,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            obscureText: false,
                            style: TextStyle(fontFamily: "Vazir", fontSize: 12),
                            initialValue: widget.user.firstName,
                            textAlign: TextAlign.right,
                            validator: (value) {
                              firstName = value.trim();
                              if (value.isEmpty) {
                                return 'نام را وارد کنید';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: new Text(
                            "نام خانوادگی",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                                fontSize: 12.0,
                                fontFamily: 'Vazir'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 0.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: darkBlue,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            obscureText: false,
                            style: TextStyle(fontFamily: "Vazir", fontSize: 12),
                            initialValue: widget.user.lastName,
                            textAlign: TextAlign.right,
                            validator: (value) {
                              lastName = value.trim();
                              if (value.isEmpty) {
                                return 'نام خانوادگی را وارد کنید';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: new Text(
                            "جنسیت",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                                fontSize: 12.0,
                                fontFamily: 'Vazir'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 0.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(),
                      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Radio(
                              value: 0,
                              groupValue: gender,
                              onChanged: _handleRadioValueChanged),
                          Text(
                            "آقا",
                            style: new TextStyle(
                                fontSize: 12.0, fontFamily: "Vazir"),
                          ),
                          Radio(
                              value: 1,
                              groupValue: gender,
                              onChanged: _handleRadioValueChanged),
                          Text(
                            "خانم",
                            style: new TextStyle(
                                fontSize: 12.0, fontFamily: "Vazir"),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(
                          left: 40.0, right: 40.0, top: 0.0),
                      alignment: Alignment.center,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: _states.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (value) => _onSelectedState(value),
                        value: _selectedState,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 0.0),
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      items: _cities.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      // onChanged: (value) => print(value),
                      onChanged: (value) => _onSelectedCity(value),
                      value: _selectedCity,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: new Text(
                            "تاریخ تولد",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: darkBlue,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 40.0, right: 40.0, top: 0.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: darkBlue,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Expanded(
                          child: TextFormField(
                            validator: (value) {
                              dob = value.trim();
                              if (value.isEmpty) {
                                return 'تاریخ تولد را وارد کنید';
                              }
                              return null;
                            },
                            enableInteractiveSelection:
                                false, // *** this is important to prevent user interactive selection ***
                            onTap: () {
                              FocusScope.of(context).requestFocus(
                                  new FocusNode()); // to prevent opening default keyboard
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return persianDatePicker;
                                  });
                            },
                            controller: textEditingController,
                          ),
                        )
                      ],
                    ),
                  ),
                  // new Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 20.0),
                  //       child: new FlatButton(
                  //         child: new Text(
                  //           "حساب کاربری دارم",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: darkBlue,
                  //               fontSize: 12.0,
                  //               fontFamily: 'Vazir'),
                  //           textAlign: TextAlign.end,
                  //         ),
                  //         onPressed: () => {},
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    alignment: Alignment.center,
                    child: new Row(
                      children: <Widget>[
                        new Expanded(
                          child: new FlatButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: darkBlue,
                            onPressed: _update,
                            child: new Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Expanded(
                                    child: Text(
                                      "ویرایش اطلاعات",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Vazir',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
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
                ],
              ),
            ))));
  }
}
