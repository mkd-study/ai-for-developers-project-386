import "@typespec/http";
import "./common.tsp";

namespace Calendar;

@doc("A candidate booking slot expressed in UTC.")
model Slot {
  @doc("Slot start in UTC.")
  startAt: utcDateTime;

  @doc("Slot end in UTC = startAt + event type duration.")
  endAt: utcDateTime;
}

@doc("Free slots for a given event type inside the 14-day booking window.")
model SlotsResponse {
  @doc("Owner's IANA time zone; clients format `startAt/endAt` in it for display.")
  ownerTimezone: Timezone;

  @doc("Inclusive lower bound of the window (UTC) — the moment of the request, rounded up to the next 30-minute step.")
  windowStart: utcDateTime;

  @doc("Exclusive upper bound of the window (UTC) — windowStart + 14 days.")
  windowEnd: utcDateTime;

  @doc("Available 30-minute-aligned slots inside owner's working hours (09:00–18:00 owner TZ), excluding those overlapped by existing bookings.")
  slots: Slot[];
}
