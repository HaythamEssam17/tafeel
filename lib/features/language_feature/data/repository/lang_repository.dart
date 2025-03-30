import '../../domain/interface/lang_interface.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';

class LangRepository extends LangInterface {
  final LanguageLocalDataSourceInterface localDataSourceInterface;
  final LanguageRemoteDataSourceInterface remoteDataSourceInterface;

  LangRepository({required this.localDataSourceInterface, required this.remoteDataSourceInterface});

  @override
  Future<String?> getLang() {
    return localDataSourceInterface.getLang().then((value) {
      remoteDataSourceInterface.setLang(lang: value ?? "ar");
      return value;
    });
  }

  @override
  Future<bool> setLang({required String lang}) {
    return localDataSourceInterface.setLang(lang: lang).then((value) => remoteDataSourceInterface.setLang(lang: lang));
  }
}
