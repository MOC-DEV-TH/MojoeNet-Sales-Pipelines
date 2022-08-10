import 'package:get/get.dart';
import 'package:sales_pipeline/app/modules/BusinessDetail/bindings/business_detail_binding.dart';
import 'package:sales_pipeline/app/modules/BusinessDetail/views/business_detail_view.dart';
import 'package:sales_pipeline/app/modules/Contracted/bindings/contracted_binding.dart';
import 'package:sales_pipeline/app/modules/Contracted/views/contracted_view.dart';
import 'package:sales_pipeline/app/modules/ContractedDetail/bindings/contracted_detail_binding.dart';
import 'package:sales_pipeline/app/modules/ContractedDetail/views/contracted_detail_view.dart';
import 'package:sales_pipeline/app/modules/NLRStepFive/views/nrl_step_five_view.dart';
import 'package:sales_pipeline/app/modules/NLRStepOne/bindings/nlr_step_one_binding.dart';
import 'package:sales_pipeline/app/modules/NLRStepOne/views/nrl_step_one_view.dart';
import 'package:sales_pipeline/app/modules/NLRStepThree/views/nrl_step_three_view.dart';
import 'package:sales_pipeline/app/modules/NLRStepTwo/bindings/nlr_step_two_binding.dart';
import 'package:sales_pipeline/app/modules/NLRStepTwo/views/nrl_step_two_view.dart';
import 'package:sales_pipeline/app/modules/SME/bindings/sme_binding.dart';
import 'package:sales_pipeline/app/modules/SME/views/sme_view.dart';
import 'package:sales_pipeline/app/modules/SuccessLeadInfo/bindings/success_lead_info_binding.dart';
import 'package:sales_pipeline/app/modules/Target/bindings/target_binding.dart';
import 'package:sales_pipeline/app/modules/Target/views/target_view.dart';
import 'package:sales_pipeline/app/modules/TaskSelection/bindings/task_selection_binding.dart';
import 'package:sales_pipeline/app/modules/TaskSelection/views/task_selection_view.dart';
import 'package:sales_pipeline/app/modules/WebView/bindings/web_view_binding.dart';
import 'package:sales_pipeline/app/modules/WebView/views/web_view.dart';

import '../modules/Dashboard/bindings/dashboard_binding.dart';
import '../modules/Dashboard/views/dashboard_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/LeadListing/bindings/lead_listing_binding.dart';
import '../modules/LeadListing/views/lead_listing_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Logout/bindings/logout_binding.dart';
import '../modules/Logout/views/logout_view.dart';
import '../modules/NLRStepFive/bindings/nlr_step_five_binding.dart';
import '../modules/NLRStepFour/bindings/nlr_step_four_binding.dart';
import '../modules/NLRStepFour/views/nlr_step_four_view.dart';
import '../modules/NLRStepSix/bindings/nlr_step_six_binding.dart';
import '../modules/NLRStepSix/views/nrl_step_six_view.dart';
import '../modules/NLRStepThree/bindings/nlr_step_three_binding.dart';
import '../modules/NewLead/bindings/new_lead_binding.dart';
import '../modules/NewLead/views/new_lead_view.dart';
import '../modules/SuccessLeadInfo/views/success_lead_info_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL_LOGIN = Routes.LOGIN;
  static const INITIAL_TASK_SELECTION = Routes.TASK_SELECTION;
  static final routes = [
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LEAD_LISTING,
      page: () => LeadListingView(),
      binding: LeadListingBinding(),
    ),
    GetPage(
      name: _Paths.NEW_LEAD,
      page: () => NewLeadView(),
      binding: NewLeadBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGOUT,
      page: () => LogoutView(),
      binding: LogoutBinding(),
    ),
    GetPage(
      name: _Paths.TASK_SELECTION,
      page: () => TaskSelectionView(),
      binding: TaskSelectionBinding(),
    ),

    GetPage(
      name: _Paths.NLR_STEP_ONE,
      page: () => NLRStepOneView(),
      binding: NLRStepOneBinding(),
    ),
    GetPage(
      name: _Paths.NLR_STEP_TWO,
      page: () => NLRStepTwoView(),
      binding: NLRStepTwoBinding(),
    ),
    GetPage(
      name: _Paths.NLR_STEP_THREE,
      page: () => NLRStepThreeView(),
      binding: NLRStepThreeBinding(),
    ),
    GetPage(
      name: _Paths.NLR_STEP_FOUR,
      page: () => NLRStepFourView(),
      binding: NLRStepFourBinding(),
    ),
    GetPage(
      name: _Paths.NLR_STEP_FIVE,
      page: () => NLRStepFiveView(),
      binding: NLRStepFiveBinding(),
    ),
    GetPage(
      name: _Paths.NLR_STEP_SIX,
      page: () => NLRStepSixView(),
      binding: NLRStepSixBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS_LEAD_INFO,
      page: () => SuccessLeadInfoView(),
      binding: SuccessLeadInfoBinding(),
    ),
    GetPage(
      name: _Paths.SME,
      page: () => SMEView(),
      binding: SMEBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_DETAIL,
      page: () => BusinessDetailView(),
      binding: BusinessDetailBinding(),
    ),
    GetPage(
      name: _Paths.CONTRACTED,
      page: () => ContractedView(),
      binding: ContractedBinding(),
    ),
    GetPage(
      name: _Paths.TARGET,
      page: () => TargetView(),
      binding: TargetBinding(),
    ),
    GetPage(
      name: _Paths.CONTRACTED_DETAIL,
      page: () => ContractedDetailView(),
      binding: ContractedDetailBinding(),
    ),
    GetPage(
      name: _Paths.WEB_VIEW,
      page: () => WebViewView(),
      binding: WebViewBinding(),
    ),
  ];
}
