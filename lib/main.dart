import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_login/halamanUtama.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(loginApp());
}

class loginApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: loginPage(title: 'Form Login'),
    );
  }
}

class loginPage extends StatefulWidget {
  loginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String _username;
  String _pass;
  bool _tampilpass = true;
  final mystyle = TextStyle(fontSize: 30 ,  color: Colors.indigo );
  final mytextinput = TextStyle(fontSize: 14 , color: Colors.black);
  final mycontroller = TextEditingController();

  FocusNode focus =FocusNode();

  @override
  void initState(){
    super.initState();
    mycontroller.addListener(_printLatesValue);
  }

  _printLatesValue(){
    print("Second text field : ${mycontroller.text}");
  }

  void dispose(){
    mycontroller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void tooglePass(){
    setState(() {
      _tampilpass= !_tampilpass;
    });
  }

  void _showAlert(BuildContext context,String status){
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text("STATUS LOGIN"),
          content: Text(status),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            color: Colors.lightBlue,
          child : SingleChildScrollView(
            //width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            //color: Colors.lightBlue,
            child : Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: Icon(Icons.person, size: 50, color: Colors.white,),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('FORM LOGIN',
                    style: GoogleFonts.lora(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 80,),
                  Column(
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(focus);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87)
                            ),
                            prefixIcon: Icon(Icons.person, size: 40,),
                            hintText: 'Masukkan username',
                            labelText: 'Username',
                            isDense: true,
                            suffixIcon: InkWell(
                              child: Icon(Icons.person, size :24),
                              onTap: (){},
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 2,
                              minHeight: 2,
                            ),
                            labelStyle: TextStyle(color: Colors.black87)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'username tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value) => _username=value,
                        controller: mycontroller,
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    obscureText: _tampilpass,
                    autofocus: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87)
                        ),
                        prefixIcon: Icon(Icons.lock, size: 40,),
                        hintText: 'Masukkan password',
                        labelText: 'Password',
                        suffixIcon: InkWell(
                            child: Icon( _tampilpass?Icons.visibility:
                                Icons.visibility_off,size: 24,
                            ),
                            onTap: tooglePass
                        ),
                        suffixIconConstraints: BoxConstraints(
                            minWidth:2,
                            minHeight:2
                        ),
                        labelStyle: TextStyle(color: Colors.black87)
                    ),
                      focusNode:focus,
                    onSaved: (value) => _pass=value,
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return 'password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 30,),
                  OutlinedButton(
                    child: Text ('LOGIN',
                      style: GoogleFonts.lora(
                        textStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                        print('proses data');
                        _formKey.currentState.save();
                        // simpan ke object user
                        // object ini kirim ke server untuk di cek
                        // klo berhasil
                        print('$_username');
                        final String apiUrl = "http://192.168.43.249/flutterapp/login.php";
                        //final response = await http.post(Uri.parse(apiUrl), body:{
                          //'user' : _username;
                          //'pass' : _pass;
                        //}
                        // if(response.statusCode == 200){
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) => halamanutama()),
                        //   );
                        //   return true;
                        // }
                        // else{
                        //   _showAlert(context, 'ERROR JARINGAN !');
                        //   throw Exception('Failed to load data');
                        // }
                        // pengecekan ke API data menggunakan http connection
                      }
                      else {
                        print('tidak valid');
                      }
                    },
                  ),
                  SizedBox(height: 130,),

                ],
              ),
            ),
          )


        ),
    );
  }
}
