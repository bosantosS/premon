import 'package:flutter/material.dart';
// For Charts
import 'package:charts_flutter/flutter.dart' as charts;
// For new Icons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Pollution, String>> _seriesBarData;
  List<charts.Series<Sales, int>> _seriesLineData;

  //For Range Time Series
  List<charts.Series> seriesList;
  bool animate;
  DateTime _time;
  Map<String, num> _measures;
  // Listens to the underlying selection changes, and updates the information
  // relevant to building the primitive legend like information under the
  // chart.
  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.time;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.sales;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  void initState() {
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesBarData = List<charts.Series<Pollution, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    seriesList = _createSampleData();
    _generateData();
  }

  void _generateData() {
    // Pie
    var pieData = [
      new Task("Work", 35.8, Color(0xFF3366cc)),
      new Task("Work1", 35.8, Color(0xFF34a66cc)),
      new Task("Work2", 35.8, Color(0xFF22366cc)),
      new Task("Work3", 35.8, Color(0xFF34566cc)),
      new Task("Work4", 35.8, Color(0xFF33612c)),
      new Task("Work5", 35.8, Color(0xFF323f4c)),
    ];
    _seriesPieData.add(charts.Series(
      id: "daily Task",
      data: pieData,
      domainFn: (Task task, _) => task.task,
      measureFn: (Task task, _) => task.taskValue,
      colorFn: (Task task, _) =>
          charts.ColorUtil.fromDartColor(task.colorValue),
      labelAccessorFn: (Task row, _) => '${row.taskValue}',
    ));

    // Bars
    var data1 = [
      new Pollution("USA", 1980, 30),
      new Pollution("Asia", 1980, 40),
      new Pollution("Europa", 1980, 50),
    ];
    var data2 = [
      new Pollution("USA", 1980, 100),
      new Pollution("Asia", 1980, 140),
      new Pollution("Europa", 1980, 150),
    ];
    var data3 = [
      new Pollution("USA", 1980, 330),
      new Pollution("Asia", 1980, 240),
      new Pollution("Europa", 1980, 250),
    ];

    _seriesBarData.add(charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2021',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099))));
    _seriesBarData.add(charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2020',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffbb0129))));
    _seriesBarData.add(charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffaa00ff))));

    // Lines
    var lineSaleData1 = [
      new Sales(0, 45),
      new Sales(1, 41),
      new Sales(2, 53),
      new Sales(3, 53),
      new Sales(4, 41),
      new Sales(5, 35),
      new Sales(6, 45),
      new Sales(7, 15),
      new Sales(8, 45),
      new Sales(9, 55),
    ];
    var lineSaleData2 = [
      new Sales(0, 35),
      new Sales(1, 41),
      new Sales(2, 23),
      new Sales(3, 53),
      new Sales(4, 81),
      new Sales(5, 35),
      new Sales(6, 45),
      new Sales(7, 15),
      new Sales(8, 95),
      new Sales(9, 55),
    ];
    var lineSaleData3 = [
      new Sales(0, 145),
      new Sales(1, 41),
      new Sales(2, 53),
      new Sales(3, 53),
      new Sales(4, 141),
      new Sales(5, 35),
      new Sales(6, 45),
      new Sales(7, 15),
      new Sales(8, 45),
      new Sales(9, 155),
    ];

    _seriesLineData.add(charts.Series(
      id: 'Air Pollution',
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
      data: lineSaleData1,
      domainFn: (Sales sales, _) => sales.yearValue,
      measureFn: (Sales sales, _) => sales.salesValue,
    ));
    _seriesLineData.add(charts.Series(
      id: 'Air Pollution',
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff99ff77)),
      data: lineSaleData2,
      domainFn: (Sales sales, _) => sales.yearValue,
      measureFn: (Sales sales, _) => sales.salesValue,
    ));
    _seriesLineData.add(charts.Series(
      id: 'Air Pollution',
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff230044)),
      data: lineSaleData3,
      domainFn: (Sales sales, _) => sales.yearValue,
      measureFn: (Sales sales, _) => sales.salesValue,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var tSChart = charts.TimeSeriesChart(seriesList,
        animate: true,
        domainAxis: new charts.EndPointsTimeAxisSpec(),
        
        selectionModels: [
          new charts.SelectionModelConfig(
            type: charts.SelectionModelType.info,
            changedListener: _onSelectionChanged,
          )
        ],
        // Allow enough space in the left and right chart margins for the
        // annotations.
        layoutConfig: new charts.LayoutConfig(
            leftMarginSpec: new charts.MarginSpec.fixedPixel(60),
            topMarginSpec: new charts.MarginSpec.fixedPixel(20),
            rightMarginSpec: new charts.MarginSpec.fixedPixel(60),
            bottomMarginSpec: new charts.MarginSpec.fixedPixel(20)),
        behaviors: [
          // Define one domain and two measure annotations configured to render
          // labels in the chart margins.
          new charts.RangeAnnotation([
            new charts.RangeAnnotationSegment(
                new DateTime(2017, 10, 4),
                new DateTime(2017, 12, 15),
                charts.RangeAnnotationAxisType.domain,
                startLabel: '10/04',
                endLabel: '12/15',
                labelAnchor: charts.AnnotationLabelAnchor.end,
                color: charts.MaterialPalette.gray.shade200,
                // Override the default vertical direction for domain labels.
                labelDirection: charts.AnnotationLabelDirection.horizontal),
            // new charts.RangeAnnotationSegment(
            //     15, 20, charts.RangeAnnotationAxisType.measure,
            //     startLabel: 'M1 Start',
            //     endLabel: 'M1 End',
            //     labelAnchor: charts.AnnotationLabelAnchor.end,
            //     color: charts.MaterialPalette.gray.shade300),
            new charts.RangeAnnotationSegment(
                80, 120, charts.RangeAnnotationAxisType.measure,
                startLabel: 'Diastolic',
                endLabel: 'Systolic',
                labelAnchor: charts.AnnotationLabelAnchor.start,
                color: charts.MaterialPalette.gray.shade300),
          ], defaultLabelPosition: charts.AnnotationLabelPosition.margin),
        ]);

    List<Widget> layoutCenter = [
        Text(
          'Time Series Sales for the first year ',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: tSChart,
        )
      ];

    // The children consist of a Chart and Text widgets below to hold the info.
    final children = <Widget>[
      new SizedBox(
        height: 150.0,
        child: tSChart,
      ),
    ];

    // If there is a selection, then include the details.
    if (_time != null) {
      layoutCenter.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text(_time.toString())));
    }
    _measures?.forEach((String series, num value) {
      layoutCenter.add(new Text('$series: $value'));
    });

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Charts Home Page'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(FontAwesomeIcons.solidChartBar),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.chartPie),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.chartLine),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.checkSquare),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Time spent on daily tasks',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: charts.PieChart(
                          _seriesPieData,
                          animate: true,
                          animationDuration: Duration(seconds: 3),
                          behaviors: [
                            new charts.DatumLegend(
                                outsideJustification:
                                    charts.OutsideJustification.endDrawArea,
                                horizontalFirst: false,
                                desiredMaxRows: 2,
                                cellPadding: new EdgeInsets.only(
                                    right: 4.0, bottom: 4.0),
                                entryTextStyle: charts.TextStyleSpec(
                                  color: charts
                                      .MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11,
                                ))
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator(
                                    labelPosition:
                                        charts.ArcLabelPosition.inside)
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  child: Center(
                      child: Column(
                children: <Widget>[
                  Text(
                    'So2 emissions, by the world regions (in million tonnes)',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: charts.BarChart(
                    _seriesBarData,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    animationDuration: Duration(seconds: 3),
                  ))
                ],
              ))),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  child: Center(
                      child: Column(
                children: layoutCenter,
              ))),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  child: Center(
                      child: Column(
                children: <Widget>[
                  Text(
                    'Sales for the first year ',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: charts.LineChart(
                    _seriesLineData,
                    defaultRenderer: new charts.LineRendererConfig(
                        includeArea: true, stacked: true, includeLine: true),
                    animate: true,
                    animationDuration: Duration(seconds: 3),
                    behaviors: [
                      new charts.ChartTitle(
                        'Years',
                        behaviorPosition: charts.BehaviorPosition.bottom,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                      ),
                      new charts.ChartTitle(
                        'Sales',
                        behaviorPosition: charts.BehaviorPosition.start,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                      ),
                      new charts.ChartTitle(
                        'Departments',
                        behaviorPosition: charts.BehaviorPosition.end,
                        titleOutsideJustification:
                            charts.OutsideJustification.middleDrawArea,
                      ),
                    ],
                  ))
                ],
              ))),
            ),
          ],
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final dataSys = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 120),
      new TimeSeriesSales(new DateTime(2017, 9, 20), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 21), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 22), 96),
      new TimeSeriesSales(new DateTime(2017, 11, 2), 120),
      new TimeSeriesSales(new DateTime(2017, 11, 23), 130),
      new TimeSeriesSales(new DateTime(2017, 11, 24), 94),
      new TimeSeriesSales(new DateTime(2017, 11, 30), 99),
      new TimeSeriesSales(new DateTime(2017, 12, 19), 120),
      new TimeSeriesSales(new DateTime(2017, 12, 21), 111),
      new TimeSeriesSales(new DateTime(2017, 12, 23), 110),
      new TimeSeriesSales(new DateTime(2017, 12, 30), 91),
    ];

    final dataDya = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 80),
      new TimeSeriesSales(new DateTime(2017, 9, 20), 90),
      new TimeSeriesSales(new DateTime(2017, 10, 21), 70),
      new TimeSeriesSales(new DateTime(2017, 10, 22), 76),
      new TimeSeriesSales(new DateTime(2017, 11, 2), 80),
      new TimeSeriesSales(new DateTime(2017, 11, 23), 80),
      new TimeSeriesSales(new DateTime(2017, 11, 24), 94),
      new TimeSeriesSales(new DateTime(2017, 11, 30), 79),
      new TimeSeriesSales(new DateTime(2017, 12, 19), 90),
      new TimeSeriesSales(new DateTime(2017, 12, 21), 87),
      new TimeSeriesSales(new DateTime(2017, 12, 23), 80),
      new TimeSeriesSales(new DateTime(2017, 12, 30), 77),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Systolica',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: dataSys,
      ),
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Dyastolica',
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: dataDya,
      ),
    ];
  }
}

// Data Container
class Task {
  String task;
  double taskValue;
  Color colorValue;

  Task(this.task, this.taskValue, this.colorValue);
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.place, this.year, this.quantity);
}

class Sales {
  int yearValue;
  int salesValue;

  Sales(this.yearValue, this.salesValue);
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}




// https://www.raywenderlich.com/16628777-theming-a-flutter-app-getting-started#toc-anchor-002