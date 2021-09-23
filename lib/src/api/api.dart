
import 'package:today/src/entity/event.dart';

abstract class TodayApi {
  EventApi get events;
}

abstract class EventApi {

  Future<List<Event>> list();

  Future<Event> insert(Event event);
}