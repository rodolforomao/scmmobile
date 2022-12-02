// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tb_user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class TbUser extends _TbUser with RealmEntity, RealmObjectBase, RealmObject {
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
    RealmObjectBase.set(this, 'idUserApp', idUserApp);
    RealmObjectBase.set(this, 'idUser', idUser);
    RealmObjectBase.set(this, 'idProfile', idProfile);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'telephone', telephone);
    RealmObjectBase.set(this, 'dtLastAcess', dtLastAcess);
    RealmObjectBase.set(this, 'company', company);
    RealmObjectBase.set(this, 'referencePeriod', referencePeriod);
    RealmObjectBase.set(this, 'cpf', cpf);
    RealmObjectBase.set(this, 'uf', uf);
  }

  TbUser._();

  @override
  ObjectId get idUserApp => RealmObjectBase.get<ObjectId>(this, 'idUserApp') as ObjectId;
  @override
  set idUserApp(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get idUser => RealmObjectBase.get<String>(this, 'idUser') as String;
  @override
  set idUser(String value) => RealmObjectBase.set(this, 'idUser', value);

  @override
  String get idProfile => RealmObjectBase.get<String>(this, 'idProfile') as String;
  @override
  set idProfile(String value) => RealmObjectBase.set(this, 'idProfile', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get password => RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get telephone => RealmObjectBase.get<String>(this, 'telephone') as String;
  @override
  set telephone(String value) => RealmObjectBase.set(this, 'telephone', value);

  @override
  String get dtLastAcess => RealmObjectBase.get<String>(this, 'dtLastAcess') as String;
  @override
  set dtLastAcess(String value) => RealmObjectBase.set(this, 'dtLastAcess', value);

  @override
  String get company => RealmObjectBase.get<String>(this, 'company') as String;
  @override
  set company(String value) => RealmObjectBase.set(this, 'company', value);

  @override
  String get referencePeriod => RealmObjectBase.get<String>(this, 'referencePeriod') as String;
  @override
  set referencePeriod(String value) => RealmObjectBase.set(this, 'referencePeriod', value);

  @override
  String get cpf => RealmObjectBase.get<String>(this, 'cpf') as String;
  @override
  set cpf(String value) => RealmObjectBase.set(this, 'cpf', value);

  @override
  String get uf => RealmObjectBase.get<String>(this, 'uf') as String;
  @override
  set uf(String value) => RealmObjectBase.set(this, 'uf', value);

  @override
  Stream<RealmObjectChanges<TbUser>> get changes => RealmObjectBase.getChanges<TbUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(TbUser._);
    return const SchemaObject(ObjectType.realmObject,TbUser, '_TbUser', [
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
