import 'package:educube1/view/pages/profile/profile_screen.dart';
import 'package:educube1/view/widgets/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../const/app_colors.dart';
import '../../../const/app_images.dart';
import '../../../controller/profile/profile_controller.dart';
import '../../widgets/common_button.dart';

class ParentProfileScreen extends StatelessWidget {
  ParentProfileScreen({super.key});
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.kPrimaryColor,
        systemNavigationBarColor: Colors.transparent,
      ),
      child:


      CommonScaffold(
        title: "Parent's Info",
          showBack: true, onBack: () { Navigator.pop(context); },

          body: Obx(() {
          final user = profileController.userProfile.value;
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2.0),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                infoList([
                  {'key': 'Contact No:', 'value': user.fatherInfo?.contactNumber ?? '-'},
                  {'key': 'Occupation:', 'value': user.fatherInfo?.designationDetails?.value ?? '-'},
                  {'key': 'E-Mail ID:', 'value':  user.fatherInfo?.emailId ?? '-'},
                ],
                  header: _listHeader(
                    name: user.fatherInfo?.name ?? '',
                    context: context,
                    title: "Father's Details",
                    imagePath: user.fatherInfo?.imagePath
                  ),
                  valueAlign: TextAlign.right
                ),

                // buildParentCard(
                //   context,
                //   title: 'Father Details',
                //   name: user.fatherInfo?.name ?? '',
                //   contact: user.fatherInfo?.contactNumber ?? '',
                //   occupation: user.fatherInfo?.designationDetails?.value ?? '',
                //   email: user.fatherInfo?.emailId ?? '',
                //   imagePath: user.fatherInfo?.imagePath,
                // ),
                const SizedBox(height: 16),
                infoList([
                  {'key': 'Contact No:', 'value': user.motherInfo?.contactNumber ?? '-'},
                  {'key': 'Occupation:', 'value': user.motherInfo?.designationDetails?.value ?? '-'},
                  {'key': 'E-Mail ID:', 'value':  user.motherInfo?.emailId ?? '-'},
                ],
                    header: _listHeader(
                        name: user.motherInfo?.name ?? '',
                        context: context,
                        title: "Mother's Details",
                        imagePath: user.motherInfo?.imagePath
                    ),
                    valueAlign: TextAlign.right
                ),






                // buildParentCard(
                //   context,
                //   title: 'Mother Details',
                //   name: user.motherInfo?.name ?? '',
                //   contact: user.motherInfo?.contactNumber ?? '',
                //   occupation: user.motherInfo?.designationDetails?.value ?? '',
                //   email: user.motherInfo?.emailId ?? '',
                //   imagePath: user.motherInfo?.imagePath,
                // ),
                // const SizedBox(height: 24),
                // CommonButton(
                //   height: 40,
                //   margin: const EdgeInsets.symmetric(horizontal: 40),
                //   text: 'Change Password',
                //   onPressed: () => Get.toNamed('/change-password'),
                // ),
                // CommonButton(
                //   height: 40,
                //   margin: const EdgeInsets.fromLTRB(40, 12, 40, 24),
                //   text: 'LogOut',
                //   onPressed: () => profileController.logoutUser(),
                // ),
              ],
            ),
          );
        },
      )




      // Scaffold(
      //   backgroundColor: const Color(0xFFF4F9FF),
      //   appBar: AppBar(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     title: const Text(
      //       'Parent Info',
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 20,
      //       ),
      //
      //     ),
      //     centerTitle: true,
      //     leading: const Icon(Icons.menu, color: Colors.black),
      //     actions: [
      //       IconButton(
      //         icon: const Icon(Icons.notifications_none, color: Colors.black),
      //         onPressed: () {},
      //       ),
      //       const Padding(
      //         padding: EdgeInsets.only(right: 16),
      //         child: CircleAvatar(
      //           radius: 10,
      //           backgroundColor: Colors.grey,
      //         ),
      //       )
      //     ],
      //   ),
      //   body: Obx(() {
      //     final user = profileController.userProfile.value;
      //     if (user == null) {
      //       return const Center(
      //         child: CircularProgressIndicator(strokeWidth: 2.0),
      //       );
      //     }
      //
      //     return SingleChildScrollView(
      //       padding: const EdgeInsets.all(16),
      //       child: Column(
      //         children: [
      //           buildParentCard(
      //             context,
      //             title: 'Father Details',
      //             name: user.fatherInfo?.name ?? '',
      //             contact: user.fatherInfo?.contactNumber ?? '',
      //             occupation: user.fatherInfo?.designationDetails?.value ?? '',
      //             email: user.fatherInfo?.emailId ?? '',
      //             imagePath: user.fatherInfo?.imagePath,
      //           ),
      //           const SizedBox(height: 16),
      //           buildParentCard(
      //             context,
      //             title: 'Mother Details',
      //             name: user.motherInfo?.name ?? '',
      //             contact: user.motherInfo?.contactNumber ?? '',
      //             occupation: user.motherInfo?.designationDetails?.value ?? '',
      //             email: user.motherInfo?.emailId ?? '',
      //             imagePath: user.motherInfo?.imagePath,
      //           ),
      //           const SizedBox(height: 24),
      //           CommonButton(
      //             height: 40,
      //             margin: const EdgeInsets.symmetric(horizontal: 40),
      //             text: 'Change Password',
      //             onPressed: () => Get.toNamed('/change-password'),
      //           ),
      //           CommonButton(
      //             height: 40,
      //             margin: const EdgeInsets.fromLTRB(40, 12, 40, 24),
      //             text: 'LogOut',
      //             onPressed: () => profileController.logoutUser(),
      //           ),
      //         ],
      //       ),
      //     );
      //   }),
      // ),
    ));
  }

  Widget _listHeader({ required String title,
    required String name,String? imagePath,required BuildContext context}){
    return Padding(
     padding: EdgeInsets.symmetric(horizontal: 16) + EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imagePath == null || imagePath.isEmpty
                      ? Image.asset(AppImages.imgUserPlaceHolder, fit: BoxFit.cover)
                      : Image.network(imagePath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004AAD),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildParentCard(
      BuildContext context, {
        required String title,
        required String name,
        required String contact,
        required String occupation,
        required String email,
        String? imagePath,
      }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: imagePath == null || imagePath.isEmpty
                      ? Image.asset(AppImages.imgUserPlaceHolder, fit: BoxFit.cover)
                      : Image.network(imagePath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox()),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004AAD),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          buildInfoRow('Contact No.:', contact),
          buildInfoRow('Occupation:', occupation),
          buildInfoRow('E-Mail ID:', email),
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
