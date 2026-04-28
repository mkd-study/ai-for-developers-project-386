import "@typespec/http";

using Http;

namespace Calendar;

@doc("UUID identifier.")
@format("uuid")
scalar Id extends string;

@doc("IANA time zone name, e.g. 'Europe/Moscow'.")
scalar Timezone extends string;

@doc("Calendar owner profile. Single pre-defined record, read-only.")
model OwnerProfile {
  @doc("Display name of the calendar owner.")
  name: string;

  @doc("Owner's IANA time zone; slots and working hours are interpreted in it.")
  timezone: Timezone;
}

@doc("RFC 7807 Problem Details payload.")
model ProblemDetails {
  @doc("Machine-readable error type slug, e.g. 'slot-conflict'.")
  type: string;

  @doc("Short human-readable summary.")
  title: string;

  @doc("HTTP status code echoed inside the body.")
  status: int32;

  @doc("Extended diagnostic message.")
  detail?: string;
}

@error
@doc("Resource was not found.")
model NotFoundError {
  @statusCode statusCode: 404;
  @body body: ProblemDetails;
}

@error
@doc("Request body failed validation.")
model ValidationError {
  @statusCode statusCode: 400;
  @body body: ProblemDetails;
}

@error
@doc("Slot conflicts with an existing booking or the requested change is not allowed in the current state.")
model ConflictError {
  @statusCode statusCode: 409;
  @body body: ProblemDetails;
}
