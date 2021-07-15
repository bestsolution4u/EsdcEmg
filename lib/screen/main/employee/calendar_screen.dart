import 'package:esdc_emg/config/style.dart';
import 'package:esdc_emg/widget/appbar/child_appbar.dart';
import 'package:esdc_emg/widget/appbar/child_image_appbar.dart';
import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/scrolling_years_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  List<DateTime> getHighlightedDates() {
    return List<DateTime>.generate(
      10,
          (int index) => DateTime.now().add(Duration(days: 10 * (index + 1))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: "Calendar screen loaded",
      child: Scaffold(
        backgroundColor: Styles.blue,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChildAppbar(
                title: 'holiday_pay_dates',
                titleColor: Colors.white,
              ),
              Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: ScrollingYearsCalendar(
                        // Required parameters
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(days: 5 * 365)),
                        lastDate: DateTime.now(),
                        currentDateColor: Colors.blue,
                        // Optional parameters
                        highlightedDates: getHighlightedDates(),
                        highlightedDateColor: Colors.deepOrange,
                        monthNames: const <String>[
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                          'Jul',
                          'Aug',
                          'Sep',
                          'Oct',
                          'Nov',
                          'Dec',
                        ],
                        onMonthTap: (int year, int month) => print('Tapped $month/$year'),
                        monthTitleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
