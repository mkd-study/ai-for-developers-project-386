import "@typespec/http";
import "../models/common.tsp";
import "../models/event-type.tsp";
import "../models/booking.tsp";
import "../models/slot.tsp";

using Http;

namespace Calendar;

@doc("Booking created successfully.")
model BookingCreated {
  @statusCode statusCode: 201;
  @body body: Booking;
}

@tag("Public")
@route("/event-types")
interface PublicEventTypes {
  @get
  @doc("List event types offered for booking; shows name, description and duration.")
  list(): EventType[];

  @get
  @route("/{id}")
  @doc("Fetch a single event type by id.")
  getById(@path id: Id): EventType | NotFoundError;

  @get
  @route("/{id}/slots")
  @doc("""
    Available slots for this event type within the 14-day window starting at the request moment.
    Slots are aligned to 30-minute boundaries in the owner's time zone, fall inside working hours
    (09:00–18:00 owner TZ), and exclude any slot overlapped by an existing booking of any event type.
    """)
  getSlots(@path id: Id): SlotsResponse | NotFoundError;

  @post
  @route("/{id}/bookings")
  @doc("""
    Create a booking on the chosen slot.
    The booking occupies [startAt, startAt + durationMinutes). Returns 409 if that interval
    overlaps any existing booking of any event type. Returns 400 if the slot is outside the
    14-day window or not aligned to a valid 30-minute step inside working hours.
    """)
  createBooking(
    @path id: Id,
    @body req: BookingCreate,
  ): BookingCreated | NotFoundError | ValidationError | ConflictError;
}
