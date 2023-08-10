import 'search_screen.dart';
import 'package:project/const/import.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

int _currentIndex = 0;

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.people,
          color: brownColor,
        ),
        backgroundColor: lightGolden,
        title: const Text('Friend',
            style: TextStyle(fontFamily: semibold, color: brownColor)),
        actions: [
          TextButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              child: const Row(
                children: [Icon(Icons.search), Text('Search')],
              ))
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Friend requests', style: TextStyle(fontSize: 17)),
              TextButton(
                  onPressed: () {},
                  child: const Text('See all', style: TextStyle(fontSize: 17)))
            ],
          ),
          Card(
            color: textfieldGrey,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2)),
                  child: const ClipOval(
                      child: Image(
                    height: 90,
                    width: 90,
                    image: NetworkImage(
                        'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwebneel.com%2Fdaily%2Fsites%2Fdefault%2Ffiles%2Fimages%2Fdaily%2F07-2019%2F2-creative-photography-ideas-walled-brandon-woelfel.jpg&f=1&nofb=1&ipt=9fbe48993c17e34653c29a68d5d8f7ea10486a27f5300d200279ab2d80f98d6d&ipo=images'),
                    fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Raju Thapa',
                        style: TextStyle(fontFamily: bold, fontSize: 17)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                            height: 38,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Confirm'))),
                        const SizedBox(width: 25),
                        SizedBox(
                            height: 38,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text('Delete')))
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
