import "@typespec/http";
import "../models/common.tsp";
import "../models/event-type.tsp";
import "../models/booking.tsp";

using Http;

namespace Calendar;

@doc("Event type created.")
model EventTypeCreated {
  @statusCode statusCode: 201;
  @body body: EventType;
}

@doc("Resource deleted; no content returned.")
model DeletedOk {
  @statusCode statusCode: 204;
}

@tag("Admin")
@route("/admin/owner")
interface AdminOwner {
  @get
  @doc("Read the calendar owner profile (name + IANA time zone).")
  get(): OwnerProfile;
}

@tag("Admin")
@route("/admin/event-types")
interface AdminEventTypes {
  @get
  @doc("List all event types.")
  list(): EventType[];

  @post
  @doc("Create a new event type. Server assigns the id.")
  create(@body req: EventTypeCreate): EventTypeCreated | ValidationError;

  @get
  @route("/{id}")
  @doc("Read a single event type.")
  getById(@path id: Id): EventType | NotFoundError;

  @patch(#{ implicitOptionality: true })
  @route("/{id}")
  @doc("Update mutable fields of an event type. Only provided fields change.")
  update(
    @path id: Id,
    @body req: EventTypePatch,
  ): EventType | NotFoundError | ValidationError;

  @delete
  @route("/{id}")
  @doc("Delete an event type. Returns 409 if future bookings exist for this type.")
  remove(@path id: Id): DeletedOk | NotFoundError | ConflictError;
}

@tag("Admin")
@route("/admin/bookings")
interface AdminBookings {
  @get
  @doc("List all upcoming bookings across all event types, sorted by startAt.")
  list(): BookingSummary[];

  @delete
  @route("/{id}")
  @doc("Cancel an upcoming booking.")
  cancel(@path id: Id): DeletedOk | NotFoundError;
}
