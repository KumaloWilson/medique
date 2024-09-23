import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/color_constants.dart';
import '../../models/vitals.dart';

class VitalsCard extends StatelessWidget {
  final Vitals vitals;

  const VitalsCard({
    super.key,
    required this.vitals,
  });


  @override
  Widget build(BuildContext context) {


    List<String> dateAndTime = vitals.createdAt.toString().split(' ');


    String date = dateAndTime[0];
    String time = dateAndTime[1];

    // Split the time to get hours and minutes
    List<String> timeParts = time.split(':');
    String hours = timeParts[0];
    String minutes = timeParts[1];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Pallete.primaryColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date: $date',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),

              Text(
                'Time: $hours:$minutes',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ],
          ),

          const Divider(
            color: Colors.white,
          ),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white24
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Blood\nPressure',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.heartPulse,
                                color: Colors.white,
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Text(
                            vitals.bloodPressure,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25
                            ),
                          ),
                          const Text(
                            'mm/Gh',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.white24
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pulse',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.heartPulse,
                                color: Colors.white,
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Text(
                            '${vitals.heartRate}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25
                            ),
                          ),
                          const Text(
                            'BPM',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12
                            ),
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(
                width: 8,
              ),

              Expanded(
                flex: 3,
                child: Column(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.white24
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Health\nScore',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Icon(
                                  FontAwesomeIcons.stethoscope,
                                  size: 60,
                                  color: Colors.white,
                                ),

                                SizedBox(
                                  height: 14,
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 8,
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '78%',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Colors.white24
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'R.R',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.lungs,
                                      color: Colors.white,

                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  '${vitals.respiratoryRate}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                                const Text(
                                  'BPM',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 8
                                  ),
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Colors.white24
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Temp',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.thermometer,
                                      color: Colors.white,

                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  '${vitals.temperature}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                                const Text(
                                  '*C',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 8
                                  ),
                                ),

                                const SizedBox(
                                  height: 16,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white24
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Weight',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.weightScale,
                            color: Colors.white,
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Text(
                        '${vitals.weight}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                      const Text(
                        'Kg',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white24
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Height',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.tape,
                            color: Colors.white,
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Text(
                        '${vitals.height}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                      const Text(
                        'CM',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white24
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BMI',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.weightScale,
                            color: Colors.white,
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Text(
                        vitals.bmi.toStringAsFixed(2),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                      const Text(
                        'BMI',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
