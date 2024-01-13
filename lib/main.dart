import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Future login() async {
    if (username.text == "" || password.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('錯誤'),
              content: Text('您有東西沒填到唷'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('確定')),
              ],
            );
          });
    } else {
      var url = Uri.parse("http://172.20.10.13/pet_project/login.php");
      var response = await http.post(url, body: {
        "username": username.text,
        "password": password.text,
      });
      var data = json.decode(response.body);

      if (data == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('成功'),
              content: Text('登入成功'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text('確認'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('錯誤'),
                content: Text('登入失敗'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('寵物照護系統'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: '帳號'),
            ),
            TextField(
              controller: password,
              obscureText: true, //隱藏帳號密碼
              decoration: InputDecoration(labelText: '密碼'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 在這裡檢查帳號密碼，然後導航到主頁面
                login();
              },
              child: Text('登入'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('註冊'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future register() async {
    if (name.text == "" ||
        gender.text == "" ||
        gmail.text == "" ||
        username.text == "" ||
        password.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('錯誤'),
              content: Text('您有東西沒填到唷'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('確定')),
              ],
            );
          });
    } else {
      var url = Uri.parse("http://172.20.10.13/pet_project/register.php");
      var response = await http.post(url, body: {
        "name": name.text,
        "gender": gender.text,
        "gmail": gmail.text,
        "username": username.text,
        "password": password.text,
      });
      var data = json.decode(response.body);

      if (data == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('錯誤'),
                content: Text('已經有帳號密碼了'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('註冊'),
      ),
      body: SingleChildScrollView(
        // 使用 SingleChildScrollView 包裹整個 Column
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(labelText: '名字'),
              ),
              TextField(
                controller: gender,
                decoration: InputDecoration(labelText: '性別'),
              ),
              TextField(
                controller: gmail,
                decoration: InputDecoration(labelText: '電子郵件'),
              ),
              TextField(
                controller: username,
                decoration: InputDecoration(labelText: '帳號'),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(labelText: '密碼'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  register();
                },
                child: Text('註冊'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('寵物照護系統'),
          bottom: TabBar(
            tabs: [
              Tab(text: '寵物資料'),
              Tab(text: '預約美容'),
              Tab(text: '餵食時間表'),
              Tab(text: '寵物日誌'),
              Tab(text: '查詢功能'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            pet(),
            BeautyAppointmentForm(),
            FeedingSchedule(),
            PetDiaryPage(),
            Search(),
          ],
        ),
      ),
    );
  }
}

class pet extends StatefulWidget {
  petState createState() => petState();
}

class petState extends State<pet> {
  final TextEditingController username = TextEditingController();
  final TextEditingController petname = TextEditingController();
  final TextEditingController species = TextEditingController();
  final TextEditingController birthdate = TextEditingController();

  Future petc() async {
    if (username.text == "" ||
        petname.text == "" ||
        species.text == "" ||
        birthdate.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('錯誤'),
              content: Text('您有東西沒填到唷'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('確定')),
              ],
            );
          });
    } else {
      var url = Uri.parse("http://172.20.10.13/pet_project/pet.php");
      var response = await http.post(url, body: {
        "username": username.text,
        "petname": petname.text,
        "species": species.text,
        "birthdate": birthdate.text,
      });
      var data = json.decode(response.body);

      if (data == "success") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('成功'),
                content: Text('上傳成功'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('錯誤'),
                content: Text('上傳失敗'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
              controller: username,
              decoration: InputDecoration(labelText: '主人')),
          TextField(
              controller: petname,
              decoration: InputDecoration(labelText: '寵物名')),
          TextField(
              controller: species,
              decoration: InputDecoration(labelText: '種類')),
          TextField(
              controller: birthdate,
              decoration: InputDecoration(labelText: '寵物生日')),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 在這裡處理健康追蹤的表單提交
              petc();
            },
            child: Text('提交寵物資料'),
          ),
        ],
      ),
    );
  }
}

class BeautyAppointmentForm extends StatefulWidget {
  BeautyAppointmentFormState createState() => BeautyAppointmentFormState();
}

class BeautyAppointmentFormState extends State<BeautyAppointmentForm> {
  final TextEditingController username = TextEditingController();
  final TextEditingController petname = TextEditingController();
  final TextEditingController appointmentdate = TextEditingController();
  final TextEditingController appointment_type = TextEditingController();

  void clearTextFields() {
    username.clear();
    petname.clear();
    appointmentdate.clear();
    appointment_type.clear();
  }

  Future upload() async {
    if (username.text == "" ||
        petname.text == "" ||
        appointmentdate.text == "" ||
        appointment_type.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('錯誤'),
              content: Text('您有東西沒填到唷'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        clearTextFields();
                      });
                    },
                    child: Text('確定')),
              ],
            );
          });
    } else {
      var url =
          Uri.parse("http://172.20.10.13/pet_project/beautyAppointments.php");

      var response = await http.post(url, body: {
        "username": username.text,
        "petname": petname.text,
        "appointmentdate": appointmentdate.text,
        "appointment_type": appointment_type.text,
      });
      var data = json.decode(response.body);

      if (data == "success") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('成功'),
                content: Text('記得要準時帶毛小孩來喲'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('錯誤'),
                content: Text('預約失敗'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                controller: username,
                decoration: InputDecoration(labelText: '主人名字')),
            TextField(
                controller: petname,
                decoration: InputDecoration(labelText: '寵物名字')),
            TextField(
                controller: appointmentdate,
                decoration: InputDecoration(labelText: '預約日期')),
            TextField(
                controller: appointment_type,
                decoration: InputDecoration(labelText: '預約內容')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 在這裡處理預約美容的表單提交
                upload();
              },
              child: Text('預約'),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedingSchedule extends StatefulWidget {
  @override
  _FeedingScheduleState createState() => _FeedingScheduleState();
}

class _FeedingScheduleState extends State<FeedingSchedule> {
  final TextEditingController username = TextEditingController();
  final TextEditingController petname = TextEditingController();
  final TextEditingController feed_time = TextEditingController();
  final TextEditingController meal_type = TextEditingController();
  Future feed() async {
    if (username.text == "" ||
        petname.text == "" ||
        feed_time.text == "" ||
        meal_type.text == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('錯誤'),
              content: Text('您有東西沒填到唷'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('確定')),
              ],
            );
          });
    } else {
      var url =
          Uri.parse("http://172.20.10.13/pet_project/feeding_schedules.php");
      var response = await http.post(url, body: {
        "username": username.text,
        "petname": petname.text,
        "feed_time": feed_time.text,
        "meal_type": meal_type.text,
      });
      var data = json.decode(response.body);

      if (data == "success") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('成功'),
                content: Text('已上傳餵食狀況'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('錯誤'),
                content: Text('上傳餵食狀況失敗'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('確認')),
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
              controller: username,
              decoration: InputDecoration(labelText: '主人名')),
          TextField(
              controller: petname,
              decoration: InputDecoration(labelText: '寵物名')),
          TextField(
              controller: feed_time,
              decoration: InputDecoration(labelText: '寵物餵食時間')),
          TextField(
              controller: meal_type,
              decoration: InputDecoration(labelText: '寵物餐別')),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              feed();
            },
            child: Text('提交餵食紀錄'),
          ),
        ],
      ),
    );
  }
}

class PetDiaryPage extends StatefulWidget {
  @override
  _PetDiaryPageState createState() => _PetDiaryPageState();
}

class _PetDiaryPageState extends State<PetDiaryPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController petname = TextEditingController();
  final TextEditingController diary_date = TextEditingController();
  final TextEditingController health_type = TextEditingController();
  final TextEditingController life_type = TextEditingController();

  Future<void> diary() async {
    if (username.text == "" ||
        petname.text == "" ||
        diary_date.text == "" ||
        health_type.text == "" ||
        life_type.text == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('錯誤'),
            content: Text('您有東西沒填到唷'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('確定'),
              ),
            ],
          );
        },
      );
    } else {
      var url = Uri.parse("http://172.20.10.13/pet_project/petDiaries.php");
      var response = await http.post(url, body: {
        "username": username.text,
        "petname": petname.text,
        "diary_date": diary_date.text,
        "health_type": health_type.text,
        "life_type": life_type.text,
      });
      var data = json.decode(response.body);

      if (data == "success") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('成功'),
              content: Text('已上傳日誌'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('確認'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('錯誤'),
              content: Text('上傳日誌失敗'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('確認'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: username,
              decoration: InputDecoration(labelText: '主人'),
            ),
            TextField(
              controller: petname,
              decoration: InputDecoration(labelText: '寵物'),
            ),
            TextField(
              controller: diary_date,
              decoration: InputDecoration(labelText: '日期'),
            ),
            TextField(
              controller: health_type,
              decoration: InputDecoration(labelText: '健康日誌'),
            ),
            TextField(
              controller: life_type,
              decoration: InputDecoration(labelText: '生活日誌'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                diary();
              },
              child: Text('提交寵物日誌'),
            ),
          ],
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _PetQueryPageState createState() => _PetQueryPageState();
}

class _PetQueryPageState extends State<Search> {
  TextEditingController ownerController = TextEditingController();
  List<Map<String, dynamic>> ownersAndPets = [];

  Future<void> fetchOwnersAndPets() async {
    try {
      final response = await http.get(Uri.parse(
          'http://172.20.10.13/pet_project/search.php?owner=${ownerController.text}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data != null && data.containsKey('ownersAndPets')) {
          setState(() {
            ownersAndPets =
                List<Map<String, dynamic>>.from(data['ownersAndPets']);
          });

          // 顯示查詢結果的對話框
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('查詢結果'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var ownerAndPet in ownersAndPets)
                      Text(
                        '${ownerAndPet['owner_name']} 有寵物 ${ownerAndPet['pet_name']}',
                        style: TextStyle(fontSize: 16),
                      ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('確定'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle unexpected JSON format
          print('Invalid JSON format');
        }
      } else {
        // Handle HTTP error
        print('HTTP request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查詢功能'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: ownerController,
              decoration: InputDecoration(labelText: '請輸入主人名稱'),
            ),
            ElevatedButton(
              onPressed: () {
                fetchOwnersAndPets();
              },
              child: Text('查詢'),
            ),
          ],
        ),
      ),
    );
  }
}
