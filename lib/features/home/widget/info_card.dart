import 'package:flutter/material.dart';
import 'package:oilab_task/utils/app_colors.dart';
import 'package:oilab_task/utils/healper.dart';

class InfoCard extends StatelessWidget {

  final imageUrl;
  final email;
  final firstName;
  final lastName;
  const InfoCard({Key? key, required this.imageUrl, required this.email, required this.firstName, required this.lastName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      elevation: 2,
      color: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                12.spaceX,
                Text('$firstName $lastName',style: Theme.of(context).textTheme.displayLarge),
              ],
            ),
            20.spaceY,
            Text(email,style: Theme.of(context).textTheme.displayMedium),


          ],
        ),
      ),
    );
  }
}
