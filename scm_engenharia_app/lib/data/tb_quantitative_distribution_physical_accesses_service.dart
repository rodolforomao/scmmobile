import 'package:realm/realm.dart';
part 'tb_quantitative_distribution_physical_accesses_service.g.dart';


@RealmModel()
class _TbQuantitativeDistributionPhysicalAccessesService {
  @PrimaryKey()
  @MapTo('idQuantitativeDistributionPhysicalAccessesServiceApp')
  late ObjectId idQuantitativeDistributionPhysicalAccessesServiceApp;
  late String idTechnology;
  late String technology;
}
