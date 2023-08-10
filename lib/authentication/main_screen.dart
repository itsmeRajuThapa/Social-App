import 'package:project/const/import.dart';

List<UserModel> usersData = [];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final items = const [
    Icon(Icons.home, size: 30, color: brownColor),
    Icon(Icons.add, size: 30, color: brownColor),
    Icon(Icons.store, size: 30, color: brownColor),
    Icon(Icons.person, size: 30, color: brownColor)
  ];
  int index = 0;

  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          usersData = decodedData.map((e) => UserModel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      usersData = [];
    }
    return [];
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: lightGolden,
        items: items,
        index: index,
        onTap: (selctedIndex) {
          setState(() {
            index = selctedIndex;
          });
        },
        height: 70,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 500),
        // animationCurve: ,
      ),
      body: Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = HomeScreen(usersData: usersData);
        break;
      case 1:
        widget = const FriendScreen();
        break;
      case 2:
        widget = const MarketScreen();
        break;
      default:
        widget = const ProfileScreen();
        break;
    }
    return widget;
  }
}
