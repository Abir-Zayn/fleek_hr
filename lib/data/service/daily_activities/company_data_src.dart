import 'package:fleekhr/data/models/daily_activities/company_model.dart';

class CompanyDataSrc {
  static List<CompanyModel> get demoCompanies => [
        CompanyModel(
          contactEmail: 'info@technova.com.bd',
          id: '1',
          name: 'TechNova Solutions',
        ),
        CompanyModel(
          id: '2',
          name: 'InnovaSoft Inc.',
          contactEmail: 'support@innovasoft.com',
        ),
        CompanyModel(
          id: '3',
          name: 'GlobalTech Systems',
          contactEmail: 'support@gys.com',
        ),
      ];
}
