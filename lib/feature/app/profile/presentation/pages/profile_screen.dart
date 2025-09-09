import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kaffo/core/app_colors/colors.dart';
import 'package:kaffo/core/di/di.dart';
import 'package:kaffo/core/utils/dialog_utils.dart';
import 'package:kaffo/core/utils/status.dart';
import 'package:kaffo/core/widgets/main_scaffold.dart';
import 'package:kaffo/feature/app/problems/data/models/cities/cities_model.dart';
import 'package:kaffo/feature/app/profile/data/model/edit_user_profile_request.dart';
import 'package:kaffo/feature/app/profile/data/model/update_user_address_request.dart';
import 'package:kaffo/feature/app/profile/presentation/cubit/profile_cubit.dart';
import 'package:kaffo/feature/app/profile/presentation/widget/profile_form_field.dart';
import 'package:kaffo/feature/auth/login/presentation/view/change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => getIt<ProfileCubit>()..getUserProfile(),

          child: Builder(
            builder: (context) {
              final profileCubit = context.read<ProfileCubit>();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_2_outlined),
                        SizedBox(width: 10),
                        Text(
                          "الملف الشخصي",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000).withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),

                    BlocConsumer<ProfileCubit, ProfileState>(
                      listenWhen: (prev, curr) => prev.editProfileState != curr.editProfileState,
                      listener: (context, state) {
                        if (state.editProfileState ==
                            Status.success) {
                          DialogUtils.showSuccess(
                            context,
                            "Success",
                          );
                        } else if (state.editProfileState ==
                            Status.error) {
                          DialogUtils.showError(
                            context,
                            state.editProfileError ?? "Errorr",
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.profileState == Status.loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          );
                        } else if (state.profileState == Status.error) {
                          return Center(
                            child: Text(state.profileError ?? 'problem error'),
                          );
                        } else if (state.profileState == Status.success) {
                          return Form(
                            key: profileCubit.formKey,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "البيانات الشخصية",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                      ),
                                    ),



                                       InkWell(
                                          onTap:state.isEnableToEdit?null: () {
                                            if (!state.isEdited) {
                                              context.read<ProfileCubit>().toggleMainEdit();
                                              print("ggg");
                                            } else {
                                              print(state.userId!);
                                              print("hghg");
                                              print(profileCubit.firstNameController.text);
                                              profileCubit.editUserProfile(
                                                state.userId!,
                                                EditUserProfileRequest(
                                                  firstName:
                                                  profileCubit.firstNameController.text,
                                                  lastName:
                                                  profileCubit.lastNameController.text,
                                                  email: profileCubit.emailController.text,
                                                  phone: profileCubit.phoneController.text,
                                                ),
                                              );
                                              context.read<ProfileCubit>().toggleMainEdit();
                                              //
                                              // profileCubit.isEdited = false;
                                              // profileCubit.isEnableToEdit = false;
                                            }
                                          },
                                          child:
                                          state.isEdited
                                              ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                size: 25,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                "حفظ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          )
                                              : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.edit_note_outlined,
                                                size: 25,
                                              ),
                                              Text(
                                                "تعديل",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),

                                    ),
                                  ],
                                ),
                                Row(
                                  children: [Expanded(
                                    child: ProfileFormField(
                                      title: "الاسم الاول",
                                      labelText: "أحمد",
                                      filedText:
                                      profileCubit.firstNameController,
                                      isEnable: state.isEdited,
                                    ),
                                  ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: ProfileFormField(
                                        title: "الكنية",
                                        labelText: "محمد",
                                        filedText:
                                        profileCubit.lastNameController,
                                        isEnable: state.isEdited,
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ProfileFormField(
                                        title: "رقم الهاتف",
                                        labelText: "09918556231",
                                        filedText: profileCubit.phoneController,
                                        isEnable: state.isEdited,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: ProfileFormField(
                                        title: "البريد الالكتروني",
                                        labelText: "ahmad@gmail.com",
                                        filedText: profileCubit.emailController,
                                        isEnable: state.isEdited,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 60,
                                    right: 10,
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        AppColors.black,
                                      ),
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.white,
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed:state.isEdited||state.isEnableToEdit?null: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return ChangePasswordScreen();
                                      },));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Spacer(flex: 2),
                                        Text("تغيير كلمة المرور"),
                                        Spacer(flex: 4),
                                        Icon(Icons.arrow_forward_ios),
                                        Spacer(flex: 1),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Divider(),
                                SizedBox(height: 40),
                                Row(
                                  children: [

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "المحافظة",

                                          ),
                                          const SizedBox(height: 8),
                                          if (state.citiesState == Status.loading)
                                            const CircularProgressIndicator()
                                          else if (state.citiesState == Status.error)
                                            Text(
                                              'حدث خطأ في جلب البيانات${profileCubit.state.citiesError}',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            )
                                          else
                                            DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                hintText:
                                                    profileCubit
                                                        .getArabicCityName(
                                                          state
                                                              .addressResponse!
                                                              .city??"ALEPPO",
                                                          state.citiesList,
                                                        ) ??
                                                    "",
                                              ),
                                              isExpanded: true,

                                              items:
                                                  state.citiesList
                                                      ?.map(
                                                        (city) =>
                                                            DropdownMenuItem(
                                                              value: city.value,
                                                              child: Text(
                                                                city.arabic ??
                                                                    '',
                                                              ),
                                                            ),
                                                      )
                                                      .toList(),
                                              onChanged:

                                              state.isEnableToEdit
                                                  ? (value) {
                                                profileCubit.addressIdController = value;
                                              }
                                                  : null,

                                              validator:
                                                  (value) =>
                                                      value == null
                                                          ? 'هذا الحقل مطلوب'
                                                          : null,
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: ProfileFormField(
                                        title: "العنوان",
                                        labelText: "الفرقان",
                                        filedText:
                                            profileCubit.cityController,
                                        isEnable: state.isEnableToEdit,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                // ProfileFormField(
                                //   title: "تاريخ الميلاد",
                                //   labelText: "20/7/2002",
                                //   filedText: profileCubit.dateOfBirthController,
                                //   isEnable: state.isEnableToEdit,
                                // ),
                                Text("تاريخ الميلاد"),

                        TextFormField(
                        controller: profileCubit.dateOfBirthController,
                        readOnly: true, // 🚫 يمنع الكتابة اليدوية
                        enabled: state.isEnableToEdit, // ✅ يفتح فقط بحالة تعديل
                        decoration: const InputDecoration(
                        hintText:  "20/7/2002",
                        suffixIcon: Icon(Icons.calendar_today), // أيقونة تقويم
                        ),
                        onTap: () async {
                        if (!state.isEnableToEdit) return; // يمنع لو الحقل مقفول

                        DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)), // افتراضياً قبل 20 سنة
                        firstDate: DateTime(1900), // أقدم تاريخ مسموح
                        lastDate: DateTime.now(),  // أحدث تاريخ هو اليوم
                        locale: const Locale("ar", "SY"), // 👈 للعرض بالعربي (اختياري)
                        );

                        if (pickedDate != null) {
                        String formattedDate =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        profileCubit.dateOfBirthController.text = formattedDate;
                        }
                        },
                        validator: (value) =>
                        (value == null || value.isEmpty) ? 'هذا الحقل مطلوب' : null,
                        ),

                                SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ProfileFormField(
                                        title: "الدراسة",
                                        labelText: "هندسة",
                                        filedText:
                                            profileCubit
                                                .collegeDegreeController,
                                        isEnable: state.isEnableToEdit,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: ProfileFormField(
                                        title: "العمل",
                                        labelText: "مبرمج",
                                        filedText: profileCubit.jobController,
                                        isEnable: state.isEnableToEdit,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                ProfileFormField(
                                  title: "وصف عنك",
                                  labelText: "......",
                                  filedText: profileCubit.descriptionController,
                                  isEnable: state.isEnableToEdit,
                                ),

                                SizedBox(height: 40),
                                Padding(
                                      padding: const EdgeInsets.only(
                                        left: 60,
                                        right: 10,
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                AppColors.black,
                                              ),
                                          foregroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        onPressed:state.isEdited?null: () {
                                          if (profileCubit
                                                  .firstNameController
                                                  .text
                                                  .isEmpty ||
                                              profileCubit
                                                  .lastNameController
                                                  .text
                                                  .isEmpty ||
                                              profileCubit
                                                  .emailController
                                                  .text
                                                  .isEmpty ||
                                              profileCubit
                                                  .phoneController
                                                  .text
                                                  .isEmpty) {
                                            DialogUtils.showError(
                                              context,
                                              state.editProfileError ??
                                                  "Errorr",
                                            );
                                          } else if (!state.isEnableToEdit) {
                                            context
                                                .read<ProfileCubit>()
                                                .toggleEdit();
                                          } else {
                                            profileCubit.editUserProfile(
                                              state.userId!,
                                              EditUserProfileRequest(
                                                firstName:
                                                    profileCubit
                                                        .firstNameController
                                                        .text,
                                                lastName:
                                                    profileCubit
                                                        .lastNameController
                                                        .text,
                                                email:
                                                    profileCubit
                                                        .emailController
                                                        .text,
                                                phone:
                                                    profileCubit
                                                        .phoneController
                                                        .text,
                                              ),
                                            );
                                            profileCubit.updateUser(state.userId??0,  EditUserProfileRequest(
                                              firstName:
                                              profileCubit
                                                  .firstNameController
                                                  .text,
                                              lastName:
                                              profileCubit
                                                  .lastNameController
                                                  .text,
                                              email:
                                              profileCubit
                                                  .emailController
                                                  .text,
                                              phone:
                                              profileCubit
                                                  .phoneController
                                                  .text,addressId: profileCubit.addressId,collegeDegree: profileCubit.collegeDegreeController.text,dateOfBirth: profileCubit.dateOfBirthController.text,description: profileCubit.descriptionController.text,job: profileCubit.jobController.text
                                            ), state.getUserProfileResponse?.addressId??state.userId!+1, UpdateUserAddressRequest(latitude: state.addressResponse?.latitude??0  , longitude: state.addressResponse?.longitude??0 , city: profileCubit.addressIdController??"ALEPPO",description: profileCubit.cityController.text));

                                            context
                                                .read<ProfileCubit>()
                                                .toggleEdit();
                                            //
                                            // profileCubit.isEdited = false;
                                            // profileCubit.isEnableToEdit = false;
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Spacer(flex: 2),      state.isEnableToEdit
                                                ? Text("تأكيد التعديل")
                                                : Text(
                                              "تعديل البيانات الثانوية",
                                            ),

                                            Spacer(flex: 4),
                                            state.isEnableToEdit
                                                ? Icon(
                                              Icons.check,
                                              size: 25,
                                              color: Colors.green,
                                            )
                                                : Icon(
                                              Icons.edit_note_outlined,
                                            ),
                                            Spacer(flex: 1),
                                          ],
                                        ),
                                      ),
                                    ),


                                SizedBox(height: 40),
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


}
