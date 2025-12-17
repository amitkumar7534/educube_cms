import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:educube1/const/app_colors.dart';
import 'package:educube1/const/app_images.dart';
import 'package:educube1/controller/profile/profile_controller.dart';
import 'package:educube1/utils/prefrence_manager.dart';
import 'package:educube1/view/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import '../../../route/app_routes.dart';
import 'package:upgrader/upgrader.dart';
import '../../widgets/common_scaffold.dart';




class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.getProfile("2025");
    profileController.refreshProfile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => profileController.showExitAlert1(),

      child: UpgradeAlert(
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: AppColors.kPrimaryColor,
              systemNavigationBarColor: Colors.transparent),
          child: CommonScaffold(
            title: 'My Profile'.tr,
            body :Obx(
                () => profileController.userProfile.value == null
                    ? profileShimmer(context)
                    : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 106,
                          width: 106,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              shape: BoxShape.circle),
                          child: Obx(
                                () => ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.network(
                                profileController.userProfile.value?.imagePath ?? '',
                                errorBuilder: (_, __, ___) => Image.asset(AppImages.imgUserImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                          () => Text(
                        profileController.userProfile.value?.firstName ?? '-',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.colorBlue,
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notifications:", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                        Obx(()=> CustomSwitchExample(
                            onTap: () => profileController.toggleState(),
                            state: profileController.toggleValue.value,
                          ),
                        ),



                        // Obx(() => Switch(
                        //   value: profileController.toggleValue.value,
                        //   onChanged: (val) => profileController.toggleState(),
                        //   activeColor: AppColors.btColor,
                        //   padding: EdgeInsets.zero,
                        //   inactiveThumbColor: Colors.white,
                        //   inactiveTrackColor: AppColors.colorBlue,
                        //   trackOutlineColor: ,
                        //
                        // ))
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(child: Text("Academic Year:", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w500))),
                        Obx(() => Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          width: 180,
                          height: 35,
                          child:
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              isDense: true,
                              buttonStyleData: ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 8, ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                  )
                              ),
                              hint: Text(


                                      profileController.selectedYear.value.isEmpty
                                          ? '2024-2025'
                                          : profileController.selectedYear.value,



                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontSize: 16),
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontSize: 16),
                              items: profileController.academicYear
                                  .map(
                                    (item) => DropdownMenuItem(
                                  value: item.yearValue,
                                  child: Text(item.yearValue.toString(),
                                      style: const TextStyle(fontSize: 12,color: Colors.black)),
                                ),
                              )
                                  .toList(),
                                  value: profileController.selectedValue.value.isEmpty
                                      ? null
                                      : profileController.selectedValue.value,
                                  onChanged: (val) =>
                                      profileController.setSelectedValue(val!),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  color: Colors.white, // ← dropdown background color
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              iconStyleData: IconStyleData(
                                  icon: Icon(Icons.keyboard_arrow_down, color: AppColors.colorBlackText,)
                              ),
                            ),
                          )
                        ))
                      ],
                    ),
                    const SizedBox(height: 20),

                    infoList([
                      {'key': 'Campus:', 'value': profileController.userProfile.value?.schoolName ?? '-'},
                      {'key': 'Class:', 'value': '${profileController.userProfile.value?.standard ?? ''} ${profileController.userProfile.value?.section ?? ''}'},
                      {'key': 'GR No.:', 'value': profileController.userProfile.value?.grNumber ?? '-'},
                      {'key': 'House:', 'value': profileController.userProfile.value?.houseName ?? '-'},
                      {'key': 'Address:', 'value':  '${profileController.userProfile.value?.houseNo ?? ''},\n${profileController.userProfile.value?.city ?? ''} ${profileController.userProfile.value?.zip ?? ''}'},
                    ]),
                    const SizedBox(height: 24),
                    CommonButton(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      text: 'Next',
                      onPressed: () => Get.toNamed(AppRoutes.routeParentProfile),
                    ),
                    const SizedBox(height: 24),
                    Visibility(
                      visible: PreferenceManager.getPref("login_type")=="username"/*&& PreferenceManager.user?.username==PreferenceManager.getPref("user_name")*/,
                      child: CommonButton(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        text: 'Change Password',
                        textStyle: TextStyle(fontSize: 18,color: AppColors.white),
                        onPressed: () => Get.toNamed(AppRoutes.routeChangePassword),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    )
    ;
  }




}


Widget profileShimmer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        SizedBox(height: 24),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20,
            width: 120,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 24),
        ...List.generate(5, (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 16,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        )),
        SizedBox(height: 32),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    ),
  );
}



Widget infoList(List<Map<String,String>> list, {Widget? header, TextAlign valueAlign = TextAlign.left}){
  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          header ?? SizedBox.shrink(),
          ListView.separated(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => infoRow(list[index]['key']!,list[index]['value']!,valueAlign),
              separatorBuilder: (context, index) => DashedLine(),
              itemCount: list.length
          ),
        ],
      )
  );
}

Widget infoRow(String label, String value, TextAlign valueAlign) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 5,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final textPainter = TextPainter(
                text: TextSpan(text: value, style: DefaultTextStyle.of(context).style),
                maxLines: 1,
                textDirection: TextDirection.ltr,
              )..layout(maxWidth: constraints.maxWidth);

              // If text is wider than available space -> marquee
              if (textPainter.didExceedMaxLines) {
                return SizedBox(
                  height: 20,
                  child: Marquee(
                    text: value,
                    style: DefaultTextStyle.of(context).style,
                    velocity: 30,
                    blankSpace: 40,
                    pauseAfterRound: Duration(seconds: 1),
                  ),
                );
              } else {
                return Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  textAlign: valueAlign,
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}



class DashedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpacing;

  const DashedLine({
    Key? key,
    this.height = 1,
    this.color = Colors.grey,
    this.dashWidth = 3,
    this.dashSpacing = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: LayoutBuilder(builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (dashWidth + dashSpacing)).floor();

        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      }),
    );
  }
}




class CustomSwitchExample extends StatefulWidget {
  final bool state;
  final Function() onTap;
  const CustomSwitchExample({required this.state, required this.onTap});

  @override
  _CustomSwitchExampleState createState() => _CustomSwitchExampleState();
}

class _CustomSwitchExampleState extends State<CustomSwitchExample> {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterSwitch(
        width: 48.0,
        height: 18.0,
        toggleSize: 18.0,
        value: widget.state,
        borderRadius: 30.0,
        padding: 0.0,
        activeColor: Color(0xFF166AB4), // blue background
        inactiveColor: Color(0xFF166AB4),
        toggleColor: Colors.white, // white knob
        onToggle: (value)=>widget.onTap(),
      ),
    );
  }





}


