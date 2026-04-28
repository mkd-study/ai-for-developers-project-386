import "@typespec/http";
import "@typespec/openapi3";
import "./models/common.tsp";
import "./models/event-type.tsp";
import "./models/booking.tsp";
import "./models/slot.tsp";
import "./routes/public.tsp";
import "./routes/admin.tsp";

using Http;

@service(#{ title: "Meeting Booking API" })
@server("http://localhost:3000", "Local development")
@doc("""
  Calendly-like booking service.

  Roles (no authentication):
  - Owner: single pre-defined profile served through `/admin/*` endpoints.
  - Guest: anonymous caller of `/event-types` and `/event-types/{id}/bookings`.

  Booking window: 14 days from the request moment, 30-minute-aligned slots inside owner's
  working hours (09:00–18:00 owner time zone). A booking for `[startAt, startAt + duration)`
  cannot overlap any other booking of any event type.
  """)
namespace Calendar;
