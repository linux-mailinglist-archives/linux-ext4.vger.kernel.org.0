Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7C8B6FD4
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 01:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfIRX6X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 19:58:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45240 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfIRX6W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 19:58:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so913996lff.12
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zErttcOaiKU1bP2k/DQvr6cT00SnNpVB86bxJYh7fI=;
        b=ZCb9HdLE7t/e9fqbLQFpz6Uww+S/LFf3srLnC/XjheclSssD7LwovbPnZbHp5S9/gZ
         zY083wpLiWYML9/7n95A16PCB8PF5WlLXFgwd7pM52zgYAlbkq6RZmPedBEUzHcjD3B9
         kpzOgKJHIwECOuvdXyRm7n5vhxWb2N4hfIA2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zErttcOaiKU1bP2k/DQvr6cT00SnNpVB86bxJYh7fI=;
        b=CVYOlgh2o32xT61tfacCYz1zePvHRncl7bzb7ahKwWB8XNi2WMjjexAAaWYQqUSRDt
         WDgEP9krws4phS0S7p7RI/ll0hAjr7uDUeax5hTofXPMXgnjER9bzJZhBBbSvajRAcKL
         z/okQd9QzqNGHKXy0rj8cyL1rCce7sCoYyD6ySuJSPlVALTyfNc49oTaeeXNRJrnZ9Pa
         3z3VBsglBQ8k/dqAW93borwzQJ6wmokx6r5sHHwssMu4xRHZSiGwQAHOnXwKKqACrTsN
         8am+iPaP15TJOex2CFUYH9gBQK/NajXAlWtPlucqzZKOInG3kGJQAfSs5KYMXxbJ46Od
         J4Ow==
X-Gm-Message-State: APjAAAVTMaPS/2B1VwG2cL4M7jUyl5dqh58MaxLscgMKdBUnL4mOMsWq
        Y/NhhL7vwRnzJLvJIi9C07WYBYa+9A4=
X-Google-Smtp-Source: APXvYqx0fOQcHfOxGBkwHMn9NqlwZix708XLc6H308ZC4m+DVZq460E22YnN5Yc2eqnTl6e1/CPKZw==
X-Received: by 2002:ac2:46f8:: with SMTP id q24mr3428334lfo.51.1568851098964;
        Wed, 18 Sep 2019 16:58:18 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o15sm1226919lff.22.2019.09.18.16.58.15
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 16:58:15 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 72so943889lfh.6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2019 16:58:15 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr3457443lfp.61.1568851095138;
 Wed, 18 Sep 2019 16:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
In-Reply-To: <20190918211713.GA2225@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 16:57:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
Message-ID: <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003b5ae10592dc9c8a"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000003b5ae10592dc9c8a
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 18, 2019 at 2:17 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> Since Linux v3.17, getrandom(2) has been created as a new and more
> secure interface for pseudorandom data requests.  It attempted to
> solve three problems, as compared to /dev/urandom:

I don't think your patch is really _wrong_, but I think it's silly to
introduce a new system call, when we have 30 bits left in the flags of
the old one, and the old system call checked them.

So it's much simpler and more straightforward to  just introduce a
single new bit #2 that says "I actually know what I'm doing, and I'm
explicitly asking for secure/insecure random data".

And then say that the existing bit #1 just means "I want to wait for entropy".

So then you end up with this:

    /*
     * Flags for getrandom(2)
     *
     * GRND_NONBLOCK    Don't block and return EAGAIN instead
     * GRND_WAIT_ENTROPY        Explicitly wait for entropy
     * GRND_EXPLICIT    Make it clear you know what you are doing
     */
    #define GRND_NONBLOCK               0x0001
    #define GRND_WAIT_ENTROPY   0x0002
    #define GRND_EXPLICIT               0x0004

    #define GRND_SECURE (GRND_EXPLICIT | GRND_WAIT_ENTROPY)
    #define GRND_INSECURE       (GRND_EXPLICIT | GRND_NONBLOCK)

    /* Nobody wants /dev/random behavior, nobody should use it */
    #define GRND_RANDOM 0x0002

which is actually fairly easy to understand. So now we have three
bits, and the values are:

 000  - ambiguous "secure or just lazy/ignorant"
 001 - -EAGAIN or secure
 010 - blocking /dev/random DO NOT USE
 011 - nonblocking /dev/random DO NOT USE
 100 - nonsense, returns -EINVAL
 101 - /dev/urandom without warnings
 110 - blocking secure
 111 - -EAGAIN or secure

and people would be encouraged to use one of these three:

 - GRND_INSECURE
 - GRND_SECURE
 - GRND_SECURE | GRND_NONBLOCK

all of which actually make sense, and none of which have any
ambiguity. And while "GRND_INSECURE | GRND_NONBLOCK" works, it's
exactly the same as just plain GRND_INSECURE - the point is that it
doesn't block for entropy anyway, so non-blocking makes no different.

NOTE! This patch looks bigger than it really is. I've changed the
if-statement in getrandom() to a switch-statement, and I did this:

-       if (count > INT_MAX)
-               count = INT_MAX;
+       count = min_t(size_t, count, INT_MAX >> (ENTROPY_SHIFT + 3));

to match what "urandom_read()" already did. That changes the semantics
a bit, but only for the /dev/random case, and only for insanity (the
limit we truncate to is now 32MB read, rather than 2GB - and we
already had that limit for urandom).

There is *one* other small semantic change: The old code did
urandom_read() which added warnings, but each warning also _reset_ the
crng_init_cnt. Until it decided not to warn any more, at which point
it also stops that resetting of crng_init_cnt.

And that reset of crng_init_cnt, btw, is some cray cray.

It's basically a "we used up entropy" thing, which is very
questionable to begin with as the whole discussion has shown, but
since it stops doing it after 10 cases, it's not even good security
assuming the "use up entropy" case makes sense in the first place.

So I didn't copy that insanity either. And I'm wondering if removing
it from /dev/urandom might also end up helping Ahmed's case of getting
entropy earlier, when we don't reset the counter.

But other than those two details, none of the existing semantics
changed, we just added the three actually _sane_ cases without any
ambiguity.

In particular, this still leaves the semantics of that nasty
"getrandom(0)" as the same "blocking urandom" that it currently is.
But now it's a separate case, and we can make that perhaps do the
timeout, or at least the warning.

And the new cases are defined to *not* warn. In particular,
GRND_INSECURE very much does *not* warn about early urandom access
when crng isn't ready. Because the whole point of that new mode is
that the user knows it isn't secure.

So that should make getrandom(GRND_INSECURE) palatable to the systemd
kind of use that wanted to avoid the pointless kernel warning.

And we could mark this for stable and try to get it backported so that
it will have better coverage, and encourage people to use the new sane
_explicit_ waiting (or not) for entropy.

Comments? Full patch as attachment.

                  Linus

--0000000000003b5ae10592dc9c8a
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k0px7z250>
X-Attachment-Id: f_k0px7z250

IGRyaXZlcnMvY2hhci9yYW5kb20uYyAgICAgICB8IDUwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLQogaW5jbHVkZS91YXBpL2xpbnV4L3JhbmRvbS5oIHwgMTIg
KysrKysrKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3JhbmRvbS5jIGIvZHJpdmVycy9jaGFy
L3JhbmRvbS5jCmluZGV4IDVkNWVhNGNlMTQ0Mi4uYzE0ZmE0NzgwMDY2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2NoYXIvcmFuZG9tLmMKKysrIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5jCkBAIC0yMTIz
LDIzICsyMTIzLDU3IEBAIFNZU0NBTExfREVGSU5FMyhnZXRyYW5kb20sIGNoYXIgX191c2VyICos
IGJ1Ziwgc2l6ZV90LCBjb3VudCwKIHsKIAlpbnQgcmV0OwogCi0JaWYgKGZsYWdzICYgfihHUk5E
X05PTkJMT0NLfEdSTkRfUkFORE9NKSkKKwlpZiAoZmxhZ3MgJiB+KEdSTkRfTk9OQkxPQ0t8R1JO
RF9XQUlUX0VOVFJPUFl8R1JORF9FWFBMSUNJVCkpCiAJCXJldHVybiAtRUlOVkFMOwogCi0JaWYg
KGNvdW50ID4gSU5UX01BWCkKLQkJY291bnQgPSBJTlRfTUFYOworCWNvdW50ID0gbWluX3Qoc2l6
ZV90LCBjb3VudCwgSU5UX01BWCA+PiAoRU5UUk9QWV9TSElGVCArIDMpKTsKIAotCWlmIChmbGFn
cyAmIEdSTkRfUkFORE9NKQorCXN3aXRjaCAoZmxhZ3MpIHsKKwljYXNlIEdSTkRfU0VDVVJFOgor
CQlyZXQgPSB3YWl0X2Zvcl9yYW5kb21fYnl0ZXMoKTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiBy
ZXQ7CisJCWJyZWFrOworCisJY2FzZSBHUk5EX1NFQ1VSRSB8IEdSTkRfTk9OQkxPQ0s6CisJCWlm
ICghY3JuZ19yZWFkeSgpKQorCQkJcmV0dXJuIC1FQUdBSU47CisJCWJyZWFrOworCisJY2FzZSBH
Uk5EX0lOU0VDVVJFOgorCQlicmVhazsKKworCWRlZmF1bHQ6CisJCXJldHVybiAtRUlOVkFMOwor
CisJLyogQkFELiBMZWdhY3kgZmxhZ3MuICovCisJY2FzZSBHUk5EX1JBTkRPTSB8IEdSTkRfTk9O
QkxPQ0s6CisJY2FzZSBHUk5EX1JBTkRPTToKIAkJcmV0dXJuIF9yYW5kb21fcmVhZChmbGFncyAm
IEdSTkRfTk9OQkxPQ0ssIGJ1ZiwgY291bnQpOwogCi0JaWYgKCFjcm5nX3JlYWR5KCkpIHsKLQkJ
aWYgKGZsYWdzICYgR1JORF9OT05CTE9DSykKKwljYXNlIEdSTkRfTk9OQkxPQ0s6CisJCWlmICgh
Y3JuZ19yZWFkeSgpKQogCQkJcmV0dXJuIC1FQUdBSU47CisJCWJyZWFrOworCisJLyoKKwkgKiBQ
ZW9wbGUgYXJlIHJlYWxseSBjb25mdXNlZCBhYm91dCB3aGV0aGVyCisJICogdGhpcyBpcyBzZWN1
cmUgb3IgaW5zZWN1cmUuIFRyYWRpdGlvbmFsCisJICogYmVoYXZpb3IgaXMgc2VjdXJlLCBidXQg
dGhlcmUgYXJlIHVzZXJzCisJICogd2hvIGNsZWFybHkgZGlkbid0IHdhbnQgdGhhdCwgYW5kIGp1
c3QKKwkgKiBuZXZlciB0aG91Z2h0IGFib3V0IGl0LgorCSAqLworCWNhc2UgMDoKIAkJcmV0ID0g
d2FpdF9mb3JfcmFuZG9tX2J5dGVzKCk7Ci0JCWlmICh1bmxpa2VseShyZXQpKQorCQlpZiAocmV0
KQogCQkJcmV0dXJuIHJldDsKKwkJYnJlYWs7CiAJfQotCXJldHVybiB1cmFuZG9tX3JlYWQoTlVM
TCwgYnVmLCBjb3VudCwgTlVMTCk7CisKKwkvKiBlcXVpdmFsZW50IHRvIHVyYW5kb21fcmVhZCgp
IHdpdGhvdXQgdGhlIGNyYXp5ICovCisJcmV0ID0gZXh0cmFjdF9jcm5nX3VzZXIoYnVmLCBjb3Vu
dCk7CisJdHJhY2VfdXJhbmRvbV9yZWFkKDggKiBjb3VudCwgMCwgRU5UUk9QWV9CSVRTKCZpbnB1
dF9wb29sKSk7CisJcmV0dXJuIHJldDsKIH0KIAogLyoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCmRpZmYgLS1naXQgYS9p
bmNsdWRlL3VhcGkvbGludXgvcmFuZG9tLmggYi9pbmNsdWRlL3VhcGkvbGludXgvcmFuZG9tLmgK
aW5kZXggMjZlZTkxMzAwZTNlLi5mOTMzZjJhODQzYzAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC9yYW5kb20uaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvcmFuZG9tLmgKQEAgLTQ4
LDkgKzQ4LDE3IEBAIHN0cnVjdCByYW5kX3Bvb2xfaW5mbyB7CiAgKiBGbGFncyBmb3IgZ2V0cmFu
ZG9tKDIpCiAgKgogICogR1JORF9OT05CTE9DSwlEb24ndCBibG9jayBhbmQgcmV0dXJuIEVBR0FJ
TiBpbnN0ZWFkCi0gKiBHUk5EX1JBTkRPTQkJVXNlIHRoZSAvZGV2L3JhbmRvbSBwb29sIGluc3Rl
YWQgb2YgL2Rldi91cmFuZG9tCisgKiBHUk5EX1dBSVRfRU5UUk9QWQlFeHBsaWNpdGx5IHdhaXQg
Zm9yIGVudHJvcHkKKyAqIEdSTkRfRVhQTElDSVQJTWFrZSBpdCBjbGVhciB5b3Uga25vdyB3aGF0
IHlvdSBhcmUgZG9pbmcKICAqLwotI2RlZmluZSBHUk5EX05PTkJMT0NLCTB4MDAwMQorI2RlZmlu
ZSBHUk5EX05PTkJMT0NLCQkweDAwMDEKKyNkZWZpbmUgR1JORF9XQUlUX0VOVFJPUFkJMHgwMDAy
CisjZGVmaW5lIEdSTkRfRVhQTElDSVQJCTB4MDAwNAorCisjZGVmaW5lIEdSTkRfU0VDVVJFCShH
Uk5EX0VYUExJQ0lUIHwgR1JORF9XQUlUX0VOVFJPUFkpCisjZGVmaW5lIEdSTkRfSU5TRUNVUkUJ
KEdSTkRfRVhQTElDSVQgfCBHUk5EX05PTkJMT0NLKQorCisvKiBOb2JvZHkgd2FudHMgL2Rldi9y
YW5kb20gYmVoYXZpb3IsIG5vYm9keSBzaG91bGQgdXNlIGl0ICovCiAjZGVmaW5lIEdSTkRfUkFO
RE9NCTB4MDAwMgogCiAjZW5kaWYgLyogX1VBUElfTElOVVhfUkFORE9NX0ggKi8K
--0000000000003b5ae10592dc9c8a--
