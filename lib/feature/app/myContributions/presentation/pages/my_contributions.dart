import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/main_scaffold.dart';

class MyContributionsScreen extends StatelessWidget {
  const MyContributionsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Widget content = Scaffold(
      backgroundColor: Colors.grey[50],
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'إحصائيات الأنشطة الخاصة بك',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.bar_chart,
                    color: Colors.grey[700],
                    size: 24,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                'إحصائيات عام 2025',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 24.0),

              _buildSummaryCardsSection(),
              const SizedBox(height: 32.0),

              _buildLineChartCard(
                title: 'الشكاوي المقدمة من قبلك خلال السنة',
                chartColor: Colors.red,
                chartData: const [
                  FlSpot(0, 60), // Jan
                  FlSpot(1, 90), // Feb
                  FlSpot(2, 70), // Mar
                  FlSpot(3, 30), // Apr
                  FlSpot(4, 70), // May
                  FlSpot(5, 60), // Jun
                  FlSpot(6, 65), // Jul
                  FlSpot(7, 60), // Aug
                  FlSpot(8, 20), // Sep
                  FlSpot(9, 50), // Oct
                  FlSpot(10, 65), // Nov
                  FlSpot(11, 80), // Dec
                ],
                tooltipTitle: 'issues',
              ),
              const SizedBox(height: 24.0),
              _buildLineChartCard(
                title: 'الأنشطة التطوعية خلال السنة',
                chartColor: Colors.blue,
                chartData: const [
                  FlSpot(0, 40), FlSpot(1, 60), FlSpot(2, 50), FlSpot(3, 70),
                  FlSpot(4, 55), FlSpot(5, 45), FlSpot(6, 40), FlSpot(7, 60),
                  FlSpot(8, 30), FlSpot(9, 80), FlSpot(10, 95), FlSpot(11, 50),
                ],
                tooltipTitle: 'Volunteering',
              ),
              const SizedBox(height: 24.0),
              _buildLineChartCard(
                title: 'المساهمات التي قمت بها خلال السنة',
                chartColor: Colors.green,
                chartData: const [
                  FlSpot(0, 70), FlSpot(1, 30), FlSpot(2, 25), FlSpot(3, 50),
                  FlSpot(4, 80), FlSpot(5, 85), FlSpot(6, 82), FlSpot(7, 88),
                  FlSpot(8, 70), FlSpot(9, 50), FlSpot(10, 30), FlSpot(11, 20),
                ],
                tooltipTitle: 'Contributions',
              ),
              const SizedBox(height: 24.0),
              _buildLineChartCard(
                title: 'التبرعات التي قمت بها خلال السنة',
                chartColor: Colors.purple,
                chartData: const [
                  FlSpot(0, 10), FlSpot(1, 50), FlSpot(2, 70), FlSpot(3, 70),
                  FlSpot(4, 40), FlSpot(5, 55), FlSpot(6, 40), FlSpot(7, 65),
                  FlSpot(8, 75), FlSpot(9, 45), FlSpot(10, 30), FlSpot(11, 20),
                ],
                tooltipTitle: 'Donations',
              ),
              const SizedBox(height: 32.0),

              _buildPieChartCard(),
            ],
          ),
        ),
      ),
    );


    try {
      return MainScaffold(body: content);
    } catch (e) {
      return content;
    }
  }

  Widget _buildSummaryCardsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSummaryCard(title: 'الشكاوي', count: '25+'),
        const SizedBox(width: 16.0),
        _buildSummaryCard(title: 'الأنشطة التطوعية', count: '25+'),
        const SizedBox(width: 16.0),
        _buildSummaryCard(title: 'المساهمات', count: '25+'),
        const SizedBox(width: 16.0),
        _buildSummaryCard(title: 'التبرعات', count: '25+'),
      ],
    );
  }

  Widget _buildSummaryCard({required String title, required String count}) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChartCard({
    required String title,
    required Color chartColor,
    required List<FlSpot> chartData,
    required String tooltipTitle,
  }) {
    final List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 16,
                height: 16,
                color: chartColor,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 100,
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < monthNames.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              monthNames[index],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                        );
                      },
                      interval: 20,
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: chartData,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [chartColor.withOpacity(0.8), chartColor],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: chartColor,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: false,
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        return LineTooltipItem(
                          '$tooltipTitle\n${touchedSpot.y.toInt()}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        );
                      }).toList();
                    },
                    tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipColor: (touchedSpot) => Colors.black.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChartCard() {
    final double complaintsValue = 10;
    final double volunteeringValue = 8;
    final double contributionsValue = 7;
    final double donationsValue = 5;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نسبة توزيعات الأنشطة التي قمت بها خلال شهر',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
                height: 150,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          // يمكنك التعامل مع أحداث اللمس هنا إذا لزم الأمر
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 50,
                        sections: [
                          PieChartSectionData(
                            color: Colors.red,
                            value: complaintsValue,
                            title: '',
                            radius: 25,
                          ),
                          PieChartSectionData(
                            color: Colors.blue,
                            value: volunteeringValue,
                            title: '',
                            radius: 25,
                            // لا يوجد معامل showTitles هنا
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            value: contributionsValue,
                            title: '',
                            radius: 25,
                            // لا يوجد معامل showTitles هنا
                          ),
                          PieChartSectionData(
                            color: Colors.purple,
                            value: donationsValue,
                            title: '',
                            radius: 25,
                            // لا يوجد معامل showTitles هنا
                          ),
                        ],
                        // تم إزالة centerSpaceBuilder هنا واستبداله بـ Stack
                      ),
                    ),
                    Center( // وضع النص في منتصف Stack
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '30', // العدد الإجمالي
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'العدد الإجمالي',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24.0),
              // وسيلة الإيضاح (Legend) للرسم البياني الدائري
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem(color: Colors.red, text: 'الشكاوي'),
                  _buildLegendItem(color: Colors.blue, text: 'الأنشطة التطوعية'),
                  _buildLegendItem(color: Colors.green, text: 'المساهمات'),
                  _buildLegendItem(color: Colors.purple, text: 'التبرعات'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// دالة مساعدة لإنشاء عنصر وسيلة الإيضاح للرسم البياني الدائري.
  Widget _buildLegendItem({required Color color, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}