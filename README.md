# filter-masquerade

OpenSMTPD filter to rewrite sender headers for subdomain masquerading.

## Description

Rewrites `From:`, `Sender:`, and `Reply-To:` headers to use a parent domain
when the original address is from a subdomain. This is useful for organizations
that want outgoing mail to appear from the main domain regardless of which
internal host sent it.

**Example:** With target domain `@example.com`:
- `user@mail.example.com` → `user@example.com` (subdomain - rewritten)
- `user@example.com` → `user@example.com` (exact match - unchanged)
- `user@other.org` → `user@other.org` (different domain - unchanged)

Only message headers are rewritten. For SMTP envelope (MAIL FROM) rewriting,
use OpenSMTPD's native `sender` action.

## Requirements

- OpenSMTPD 6.6 or later
- POSIX-compatible awk

## Installation

```sh
make install
```

Default installation path: `/usr/local/libexec/smtpd/filter-masquerade`

To install to a different location:
```sh
make PREFIX=/usr install
```

## Configuration

Add to `/etc/mail/smtpd.conf`:

```
filter "masquerade" proc-exec "/usr/local/libexec/smtpd/filter-masquerade @example.com"

listen on all filter "masquerade"
```

Replace `@example.com` with your target domain (must include the `@`).

### Combined with envelope rewriting

To also rewrite the SMTP envelope sender:

```
action "relay" relay host smtp://relay.example.com \
    mail-from "@example.com"

filter "masquerade" proc-exec "/usr/local/libexec/smtpd/filter-masquerade @example.com"

match from local action "relay" filter "masquerade"
```

## Testing

```sh
make test
```

## License

ISC License. See source file for details.
