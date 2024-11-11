import 'package:flutter/material.dart';

class MybookScreen extends StatefulWidget {
  const MybookScreen({super.key});

  @override
  State<MybookScreen> createState() => _MybookScreenState();
}

class _MybookScreenState extends State<MybookScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allBooks = [
    'Game of Thrones',
    'A Clash of Kings',
    'A Storm of Swords'
  ]; // Example book data
  List<String> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _filteredBooks = List.from(_allBooks);
    _searchController.addListener(_filterBooks);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterBooks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBooks = _allBooks
          .where((book) => book.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEAECF0),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        title: const Center(
            child: Text(
          "My Books ",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )),
        bottom: TabBar(indicator: const BoxDecoration(
          color: Colors.white,
    
        ),
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Active borrows'),
            Tab(text: 'Returned'),
          ],
        ),
      ),
            body: Column(    
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
               padding: const EdgeInsets.symmetric(horizontal: 0),
              decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
              child: Row(
                children: [
                  Expanded( 
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        
                        ),
                        fillColor: const Color(0xFFF5F5F5)
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    
                    decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
                    
                    child: IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        // Implement filter functionality here
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BookListView(books: _filteredBooks),
                BookListView(books: _filteredBooks), // Replace with filtered data for "Active borrows"
                BookListView(books: _filteredBooks), // Replace with filtered data for "Returned"
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
  height: 101,
  child: BottomNavigationBar(
          //currentIndex: _selectedIndex,
          //onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'My Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,

        ),

      ),
    );
  }
}

class BookListView extends StatelessWidget {
    final List<String> books;
  
 const  BookListView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: BookCard(title: books[index]),
        );
      },
    );
  }
}

class BookCard extends StatelessWidget {
    final String title;
  const BookCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return   Card(
      color: Color(0xfffffffff),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 103,
              height: 153,
              color: Color(0xffF4DADA), // Placeholder for book image
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 17,),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                    color: Color(0xff000000)),
                  ),
                    SizedBox(height: 15,),
                  Text('George R.R. Martin'), // Placeholder for author name
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.star_border_outlined, color: Colors.black, size: 16),
                      SizedBox(width: 4),
                      Text('4.5,', style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                      ),),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '3 days left',
                    style: TextStyle(color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

