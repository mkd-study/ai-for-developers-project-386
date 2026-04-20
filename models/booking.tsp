import "@typespec/http";
import "./common.tsp";
import "./event-type.tsp";

namespace Calendar;

@doc("A booking made by a guest against a specific event type.")
model Booking {
  @doc("Stable booking identifier.")
  id: Id;

  @doc("Event type this booking belongs to.")
  eventTypeId: Id;

  @doc("Booking start time in UTC.")
  startAt: utcDateTime;

  @doc("Booking end time in UTC = startAt + event type duration.")
  endAt: utcDateTime;

  @doc("Guest-provided display name.")
  guestName: string;

  @doc("Server-assigned creation timestamp in UTC.")
  createdAt: utcDateTime;
}

@doc("Guest-submitted payload for creating a booking.")
model BookingCreate {
  @doc("Chosen slot start in UTC. Must be a free 30-minute-aligned slot inside the 14-day window.")
  startAt: utcDateTime;

  @doc("Guest's display name.")
  guestName: string;
}

@doc("Entry of the admin's upcoming-bookings list; includes the embedded event type for convenience.")
model BookingSummary {
  id: Id;
  startAt: utcDateTime;
  endAt: utcDateTime;
  guestName: string;
  eventType: EventTypeRef;
}
