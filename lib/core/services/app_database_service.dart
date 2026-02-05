import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database_service.g.dart';

enum PartnerStatus { pending, accepted }

enum UserRole { user, partner }

mixin TableMixin on Table {
  late final UuidColumn id = customType(
    PgTypes.uuid,
  ).withDefault(genRandomUuid())();
  late final Column<PgDateTime> createdAt = customType(
    PgTypes.timestampWithTimezone,
  ).withDefault(now())();
}

class Cycles extends Table with TableMixin {
  UuidColumn get userId => customType(PgTypes.uuid).references(Profile, #id)();
  Column<PgDate> get startDate => customType(PgTypes.date)();
  Column<PgDate> get endDate => customType(PgTypes.date)();
}

class DailyLogs extends Table with TableMixin {
  UuidColumn get userId => customType(PgTypes.uuid).references(Profile, #id)();
  Column<PgDate> get date => customType(PgTypes.date)();
  JsonColumn get symptoms => customType(PgTypes.jsonb)();
  TextColumn get mood => text()();
  TextColumn get notes => text()();
  Column<PgDateTime> get updatedAt => customType(
    PgTypes.timestampWithTimezone,
  ).withDefault(now())();
}

class PartnerConnections extends Table with TableMixin {
  @ReferenceName('profiles')
  UuidColumn get userId => customType(
    PgTypes.uuid,
  ).references(Profile, #id)();
  @ReferenceName('partners')
  UuidColumn get partnerId => customType(
    PgTypes.uuid,
  ).references(Profile, #id)();
  TextColumn get inviteCode => text().nullable()();
  TextColumn get status => textEnum<PartnerStatus>()();
}

class Profile extends Table with TableMixin {
  TextColumn get displayName => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get role => textEnum<UserRole>()();
  Column<PgDateTime> get updatedAt => customType(
    PgTypes.timestampWithTimezone,
  ).withDefault(now())();
}

class ProfileDetails extends Table with TableMixin {
  Column<PgDate> get birthDate => customType(PgTypes.date).nullable()();
  IntColumn get weight => integer().nullable()();
  IntColumn get height => integer().nullable()();
  IntColumn get cycleAvgLength => integer().nullable()();
  IntColumn get periodAvgLength => integer().nullable()();
  Column<PgDate> get lastPeriodDateStart =>
      customType(PgTypes.date).nullable()();
  Column<PgDate> get lastPeriodDateEnd => customType(PgTypes.date).nullable()();
  Column<PgDateTime> get updatedAt => customType(
    PgTypes.timestampWithTimezone,
  ).withDefault(now())();
}

@DriftDatabase(
  tables: [Cycles, DailyLogs, PartnerConnections, Profile, ProfileDetails],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'period_app_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
