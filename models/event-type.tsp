import "@typespec/http";
import "./common.tsp";

namespace Calendar;

@doc("A kind of meeting the owner offers for booking.")
model EventType {
  @doc("Stable identifier of the event type.")
  id: Id;

  @doc("Short title shown to guests.")
  name: string;

  @doc("Longer description visible to guests.")
  description: string;

  @doc("Booking duration in minutes. Must be a positive multiple of 30.")
  @minValue(30)
  durationMinutes: int32;
}

@doc("Payload for creating a new event type. Server assigns the `id`.")
model EventTypeCreate {
  name: string;
  description: string;

  @minValue(30)
  durationMinutes: int32;
}

@doc("Partial payload for updating an event type. Only provided fields are changed.")
model EventTypePatch {
  name?: string;
  description?: string;

  @minValue(30)
  durationMinutes?: int32;
}

@doc("Compact event-type reference embedded in admin booking listings.")
model EventTypeRef {
  id: Id;
  name: string;
  durationMinutes: int32;
}
