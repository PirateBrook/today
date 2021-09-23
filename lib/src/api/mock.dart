
import 'package:today/src/auth/auth.dart';
import 'package:today/src/entity/event.dart';

import 'api.dart';
import 'package:uuid/uuid.dart' as uuid;

class MockTodayApi implements TodayApi {

  @override
  EventApi events = MockEventsApi();

  MockTodayApi();

  Future<void> fillWithMockData() async {
    await events.insert(Event('Cooking'));
    await events.insert(Event('Reading'));
    await events.insert(Event('Take A Nap'));
  }

}

class MockEventsApi implements EventApi {
  final Map<String, Event> _storage = {};
  @override
  Future<List<Event>> list() async {
    return _storage
        .keys
        .map((k) => _storage[k])
        .toList();
  }

  @override
  Future<Event> insert(Event event) async {
    var id = uuid.Uuid().v4();
    _storage[id] = event;
    return event;
  }

}
