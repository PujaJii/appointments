import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  final String title;
  final DateTime date;

  Item({required this.title, required this.date});
}

class DateCategoryList extends StatefulWidget {
  final List<Item> items;

  DateCategoryList({required this.items});

  @override
  _DateCategoryListState createState() => _DateCategoryListState();
}

class _DateCategoryListState extends State<DateCategoryList> {
  @override
  Widget build(BuildContext context) {
    //widget.items.sort((a, b) => a.date.compareTo(b.date)); // sort items by date
    List<DateTime> dates = widget.items.map((item) => item.date).toSet().toList(); // get unique dates
    //List<DateTime> datesHistory = widget.items.map((item) => item.date).toSet().toList(); // get unique dates
    return Scaffold(
      body: ListView.separated(
        itemCount: dates.length,
        itemBuilder: (BuildContext context, int index) {
          List<Item> itemsForDate = widget.items.where((item) => item.date == dates[index]).toList(); // get items for current date
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${DateFormat('EEEE, MMMM d, y').format(dates[index])}'), // display date header
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: itemsForDate.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(itemsForDate[index].title),
                  );
                },
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}

/*

 */
