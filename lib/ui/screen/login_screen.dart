import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/helper/helper.dart';
import 'package:rayahhalekapp/helper/theme.dart';
import 'package:rayahhalekapp/provider/user_model.dart';
import 'package:rayahhalekapp/ui/widget/component/CustomProgressDialog.dart';
import 'package:rayahhalekapp/ui/widget/component/app_text.dart';
import 'package:rayahhalekapp/ui/widget/auth_bg.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/modal/forget_password.dart';
import 'package:rayahhalekapp/ui/widget/component/normal_btn.dart';
import 'package:rayahhalekapp/ui/widget/component/text_field.dart';
import 'package:rayahhalekapp/vm/login_vm.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginProtocol {
  final _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusNode _mobileFocusNode = new FocusNode();

  TextEditingController _mobile = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  CustomProgressDialog pr;

  LoginVM _loginVM;

  void initViewModel() {
    _loginVM = LoginVM(this);
  }

  @override
  void initState() {
    initViewModel();
    super.initState();
  }

  String screenName;

  @override
  Widget build(BuildContext context) {
    screenName = ModalRoute.of(context).settings.arguments ?? null;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AuthBg(
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsetsDirectional.only(
              start: 16,
              end: 16,
              top: MediaQuery.of(context).size.height * 0.16,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalization.of(context).translate("welcome"),
                      style: AppThemeData.largeTitle(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalization.of(context).translate("login_title"),
                      style: AppThemeData.subTitle(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        AppLocalization.of(context).translate("login"),
                        style: AppThemeData.formTitle(Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    AppTextField(
                      AppLocalization.of(context).translate("mobile_number"),
                      TextInputType.number,
                      _mobileFocusNode,
                      _passwordFocusNode,
                      _mobile,
                      AppLocalization.of(context)
                          .translate("mobile_num_required"),
                      onChange: (_) {
                        _formKey.currentState.validate();
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AppTextField(
                      AppLocalization.of(context).translate("password"),
                      TextInputType.text,
                      _passwordFocusNode,
                      null,
                      _password,
                      AppLocalization.of(context)
                          .translate("password_required"),
                      onChange: (_) {
                        _formKey.currentState.validate();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
//                        showModalBottomSheet(
//                          context: context,
//                          builder: (context) => ForgetPasswordWidget(),
//                          isScrollControlled: true,
//                          isDismissible: false,
//                        );
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            AppText(
                              AppLocalization.of(context)
                                  .translate("forget_password"),
                              FontWeight.w800,
                              13,
                              Colors.white.value,
                              TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    NormalButton(
                      AppLocalization.of(context).translate("enter"),
                      () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          pr = CustomProgressDialog(
                              context,
                              AppLocalization.of(context).translate("login..."),
                              () {});
                          pr.showDialog().then((value) {
                            _loginVM.login(_mobile.text, _password.text);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    GestureDetector(
                      onTap: () {
                        screenName == null
                            ? showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>  CupertinoActionSheet(
                                  title: Text(""),
                                  message: AppText(
                                    "اختر",
                                    FontWeight.w500,
                                    17,
                                    AppColors.purpleTextColor,
                                    TextAlign.center,
                                  ),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      child: AppText(
                                        "عميل",
                                        FontWeight.w500,
                                        17,
                                        AppColors.purpleTextColor,
                                        TextAlign.center,
                                      ),
                                      onPressed: () {
                                        Helper.isProvider = false;
                                        Navigator.of(context).pushNamed(
                                          "/register",
                                        );
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: AppText(
                                        "مزود خدمة",
                                        FontWeight.w500,
                                        17,
                                        AppColors.purpleTextColor,
                                        TextAlign.center,
                                      ),
                                      onPressed: () {
                                        Helper.isProvider = true;
                                        Navigator.of(context).pushNamed(
                                            "/register",
                                            arguments: screenName);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: AppText(
                                        "إلغاء",
                                        FontWeight.w500,
                                        17,
                                        AppColors.redColor2,
                                        TextAlign.center,
                                      ),
                                      onPressed: () {
                                        Helper.isProvider = true;
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )

                        ) : Navigator.of(context).pushNamed("/register",
                            arguments: screenName);
                      },
                      child: Center(
                        child: AppText(
                          AppLocalization.of(context).translate("no_account"),
                          FontWeight.w800,
                          15,
                          Colors.white.value,
                          TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didLoginFail(String message) {
    pr.hideDialog();
    AppDialog.showMe(context, message);
  }

  @override
  void didLoginSuccess() {
    pr.hideDialog();
    Provider.of<UserModel>(context,listen: false).changeUser(Helper.user);
    if (screenName != null) {
      Navigator.of(context).popUntil(ModalRoute.withName(screenName));
    } else
      Navigator.of(context).pushReplacementNamed("/main");
  }
}
