// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************


class TbUser extends _TbUser with RealmEntity, RealmObject {
  TbUser(
      ObjectId idUserApp,
      String idUser,
      String idProfile,
      String name,
      String password,
      String email,
      String telephone,
      String dtLastAcess,
      String company,
      String referencePeriod,
      String cpf,
      String uf,
      ) {
    RealmObject.set(this, 'idUserApp', idUserApp);
    RealmObject.set(this, 'idUser', idUser);
    RealmObject.set(this, 'idProfile', idProfile);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'password', password);
    RealmObject.set(this, 'email', email);
    RealmObject.set(this, 'telephone', telephone);
    RealmObject.set(this, 'dtLastAcess', dtLastAcess);
    RealmObject.set(this, 'company', company);
    RealmObject.set(this, 'referencePeriod', referencePeriod);
    RealmObject.set(this, 'cpf', cpf);
    RealmObject.set(this, 'uf', uf);
  }

  TbUser._();

  @override
  ObjectId get idUserApp => RealmObject.get<ObjectId>(this, 'idUserApp') as ObjectId;
  @override
  set idUserApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idUser => RealmObject.get<String>(this, 'idUser') as String;
  @override
  set idUser(String value) => RealmObject.set(this, 'idUser', value);

  @override
  String get idProfile => RealmObject.get<String>(this, 'idProfile') as String;
  @override
  set idProfile(String value) => RealmObject.set(this, 'idProfile', value);

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  String get password => RealmObject.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObject.set(this, 'password', value);

  @override
  String get email => RealmObject.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObject.set(this, 'email', value);

  @override
  String get telephone => RealmObject.get<String>(this, 'telephone') as String;
  @override
  set telephone(String value) => RealmObject.set(this, 'telephone', value);

  @override
  String get dtLastAcess => RealmObject.get<String>(this, 'dtLastAcess') as String;
  @override
  set dtLastAcess(String value) => RealmObject.set(this, 'dtLastAcess', value);

  @override
  String get company => RealmObject.get<String>(this, 'company') as String;
  @override
  set company(String value) => RealmObject.set(this, 'company', value);

  @override
  String get referencePeriod => RealmObject.get<String>(this, 'referencePeriod') as String;
  @override
  set referencePeriod(String value) => RealmObject.set(this, 'referencePeriod', value);

  @override
  String get cpf => RealmObject.get<String>(this, 'cpf') as String;
  @override
  set cpf(String value) => RealmObject.set(this, 'cpf', value);

  @override
  String get uf => RealmObject.get<String>(this, 'uf') as String;
  @override
  set uf(String value) => RealmObject.set(this, 'uf', value);

  @override
  Stream<RealmObjectChanges<TbUser>> get changes => RealmObject.getChanges<TbUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(TbUser._);
    return const SchemaObject(TbUser, '_TbUser', [
      SchemaProperty('idUserApp', RealmPropertyType.objectid, mapTo: 'idUserApp', primaryKey: true),
      SchemaProperty('idUser', RealmPropertyType.string),
      SchemaProperty('idProfile', RealmPropertyType.string),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('telephone', RealmPropertyType.string),
      SchemaProperty('dtLastAcess', RealmPropertyType.string),
      SchemaProperty('company', RealmPropertyType.string),
      SchemaProperty('referencePeriod', RealmPropertyType.string),
      SchemaProperty('cpf', RealmPropertyType.string),
      SchemaProperty('uf', RealmPropertyType.string),
    ]);
  }
}
