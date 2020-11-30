import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayahhalekapp/api/app_api.dart';
import 'package:rayahhalekapp/helper/app_localization.dart';
import 'package:rayahhalekapp/helper/colors.dart';
import 'package:rayahhalekapp/model/service_data.dart';
import 'package:rayahhalekapp/ui/screen/address_detail_screen.dart';
import 'package:rayahhalekapp/ui/screen/provider_by_map_screen.dart';
import 'package:rayahhalekapp/ui/screen/provider_list_screen.dart';
import 'package:rayahhalekapp/ui/widget/barber_service_widget.dart';
import 'package:rayahhalekapp/ui/widget/car_wash_service_widget.dart';
import 'package:rayahhalekapp/ui/widget/component/error_dialog.dart';
import 'package:rayahhalekapp/ui/widget/fix_home_service_widget.dart';
import 'package:rayahhalekapp/ui/widget/general_service.dart';
import 'package:rayahhalekapp/ui/widget/modal/options_widget.dart';
import 'package:rayahhalekapp/ui/widget/modal/provider_order_option_widget.dart';

enum Service {
  FIX_HOME,
  CAR_WATCH,
  BARBER,
  JOKER,
}

class ServiceModel {
  static int getColor(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return AppColors.orange;
      case Service.CAR_WATCH:
        return AppColors.green;
      case Service.BARBER:
        return AppColors.boldBlue;
      case Service.JOKER:
        return AppColors.purple;
    }
    return -1;
  }

  static Service getService(String id) {
    switch (id) {
      case "1":
        return Service.FIX_HOME;
      case "3":
        return Service.CAR_WATCH;
      case "2":
        return Service.BARBER;
      case "4":
        return Service.JOKER;
    }
    return Service.FIX_HOME;
  }

  static int getId(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return 1;
      case Service.CAR_WATCH:
        return 3;
      case Service.BARBER:
        return 2;
      case Service.JOKER:
        return 4;
    }
    return 0;
  }

  static String getTitle(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return "fix_home";
      case Service.CAR_WATCH:
        return "car_clean";
      case Service.BARBER:
        return "barber";
      case Service.JOKER:
        return "Joker";
    }
    return "";
  }

  static String getImage(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return "home.png";
      case Service.CAR_WATCH:
        return "car_wash.png";
      case Service.BARBER:
        return "barber.png";
      case Service.JOKER:
        return "joker.png";
    }
    return "";
  }

  static String getImageBg(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return "";
      case Service.CAR_WATCH:
        return "car_bg.png";
      case Service.BARBER:
        return "barber_bg.png";
      case Service.JOKER:
        return "";
    }
    return "";
  }

  static List<int> getImageColors(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return [AppColors.boldOrangeColor, AppColors.lightOrangeColor];
      case Service.CAR_WATCH:
        return [AppColors.boldGreenColor, AppColors.lightGreenColor];
      case Service.BARBER:
        return [AppColors.boldBlueColor, AppColors.lightBlueColor];
      case Service.JOKER:
        return [AppColors.boldPurpleColor, AppColors.lightPurpleColor2];
    }
    return [];
  }

  static List<int> getButtonColors(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return [0xFFED2A22, 0xFFFEBF0E];
      case Service.CAR_WATCH:
        return [(0xFF386994), (0xFF6FC1BB)];
      case Service.BARBER:
        return [(0xFF2A3845), (0xFF3D4D63)];
      case Service.JOKER:
        return [(0xFF4D37E0), (0xFFB45BF0)];
    }
    return [];
  }

  static int getShadowColor(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return 0xFFED2A22;
      case Service.CAR_WATCH:
        return 0xFF386994;
      case Service.BARBER:
        return 0xFF2A3845;
      case Service.JOKER:
        return 0xFF4D37E0;
    }
    return -1;
  }

  static int getNumberOfGrid(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return 3;
      case Service.CAR_WATCH:
        return 1;
      case Service.BARBER:
        return 1;
      case Service.JOKER:
        return 0;
    }
    return -1;
  }

  static int spaceBeforeDisplayingService(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return 0;
      case Service.CAR_WATCH:
        return 16;
      case Service.BARBER:
        return 14;
      case Service.JOKER:
        return 0;
    }
    return -1;
  }

  static GeneralServiceWidget getGridWidget(Service service, bool isSelected,
      {ServiceData serviceData}) {
    switch (service) {
      case Service.FIX_HOME:
        return FixHomeServiceWidget(isSelected, serviceData);
      case Service.CAR_WATCH:
        return CarWashServiceWidget(isSelected, serviceData);
      case Service.BARBER:
        return BarberServiceWidget(isSelected, serviceData);
      case Service.JOKER:
        return null;
    }
    return null;
  }

  static double getAspectRatio(Service service, double width) {
    switch (service) {
      case Service.FIX_HOME:
        return 1;
      case Service.CAR_WATCH:
        return width / 102;
      case Service.BARBER:
        return width / 157;
      case Service.JOKER:
        return 1;
    }
    return -1;
  }

  static double getMainSpacing(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return 1;
      case Service.CAR_WATCH:
        return 16;
      case Service.BARBER:
        return 16;
      case Service.JOKER:
        return 0;
    }
    return -1;
  }

  static int getServiceCount(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return 9;
      case Service.CAR_WATCH:
        return 3;
      case Service.BARBER:
        return 2;
      case Service.JOKER:
        return 0;
    }
    return -1;
  }

  static int textColor(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return AppColors.lightOrangeTextColor;
      case Service.CAR_WATCH:
        return AppColors.green;
      case Service.BARBER:
        return AppColors.green;
      case Service.JOKER:
        return AppColors.purple;
    }
    return -1;
  }

  static int billColor(Service service) {
    switch (service) {
      case Service.FIX_HOME:
        return 0xFFFFC40D;
      case Service.CAR_WATCH:
        return 0xFF6FC1BB;
      case Service.BARBER:
        return 0xFF3D4D63;
      case Service.JOKER:
        return 0xFF4D37E0;
    }
    return 0xFF9004B7;
  }

  static Function() whatToDoAfterDetail(Service service, BuildContext context) {
    switch (service) {
      case Service.FIX_HOME:
        return () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => AddressDetailScreen(service)),
            ),
          );
        };
      case Service.JOKER:
        return () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => AddressDetailScreen(service)),
            ),
          );
        };
      case Service.BARBER:
        return () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => AddressDetailScreen(service)),
            ),
          );
        };
      case Service.CAR_WATCH:
        return () {
          showModalBottomSheet(
            context: context,
            builder: (context) =>
                OptionsWidget(
                  [
                    AppLocalization.of(context).translate("i_will_do"),
                    AppLocalization.of(context).translate("provider")
                  ],
                  textColor(service),
                  getButtonColors(service),
                  AppLocalization.of(context).translate("who_will_move_it"),
                      (index) {
                    if (index == -1) {
                      AppDialog.showMe(context,
                          AppLocalization.of(context).translate(
                              "transporter_err"));
                      return;
                    }
                    AppApi.orderClient.params["transporter"] =
                        (index + 1).toString();
                    index == 0 ? showModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            ProviderOrderOptionWidget(
                                service)) : Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (context) => AddressDetailScreen(service)
                    ,
                    )
                    ,
                    );
                  },
                ),
          );
        };
    }
    return () {};
  }
}
