Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA68CB52EC
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 18:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfIQQ2I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 12:28:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42110 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfIQQ2I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 12:28:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so3385562lfg.9
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbppCquzDPmdlrJOa+FeToM7VEugTw0SaSjlI4jjkR4=;
        b=iEabaA2QOPqJxq22zFag3TdicdXUTUWaxkXLmUo0VtEw24iQnuc7Ry8i7Eg6tej/5z
         UcAZMcBSCEslugNriE8LWVBH6yrElzqDGjNljDpxXA5LGb2H/1EVo9tm6bmKrkvU7IF+
         HplgpzdDDnqi6gOiqlM5hkQqJxVc5u+GXsj4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbppCquzDPmdlrJOa+FeToM7VEugTw0SaSjlI4jjkR4=;
        b=hUJT1id4b8MYKeXRVkp8cNpPsrsjieJtSGQ1JHMRSHeEmZp4MRR43YeOQmPnZuLGrx
         RHkS4RoMdrRPphmwxQFenC1XH4wYZq2yxDWXLZ4UDk3gbs/Sa3dbLqfAElgYuGGdZwb4
         gnr4g7Tb2bBeVXUySVC+tQOwOCyIRJI54Fwq+Dy2h5OCJMZ+b3KOPEZG9ZKU6OdNizcq
         IMRPRDsvUd/H6IGlhDpAraoHKikrrEiEpmyIUkGVyZA3QAA8nAsAItXwJJR6k3w0lD1L
         sG2+xchr0/RDqJhGystQtuXsJHWedIW1B84uZs8NpvHbPRE5Y+HzeXX7Gl1Ic6cMgEWP
         bmlw==
X-Gm-Message-State: APjAAAWPyFOoEetx5kWoad9N3zkWrqbSoVgRS+pHZjpoBZW8pc9dpcxP
        e6KU3hLdYOWVNLHpCr9Pi2X9b9Q1VYo=
X-Google-Smtp-Source: APXvYqyVhwWpafZ0xGnz9DElxNjdsE0Xuemc5yB/M1AClYlo8xPQoLNM54vMMAg8A8PoeilNEVjdTQ==
X-Received: by 2002:ac2:5181:: with SMTP id u1mr2754704lfi.114.1568737683149;
        Tue, 17 Sep 2019 09:28:03 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id c69sm525735ljf.32.2019.09.17.09.28.01
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:28:01 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id m7so3522402lji.2
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 09:28:01 -0700 (PDT)
X-Received: by 2002:a2e:9854:: with SMTP id e20mr2473591ljj.72.1568737681125;
 Tue, 17 Sep 2019 09:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
In-Reply-To: <2508489.jOnZlRuxVn@merkaba>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Sep 2019 09:27:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
Message-ID: <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Willy Tarreau <w@1wt.eu>, Matthew Garrett <mjg59@srcf.ucam.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003b46310592c23438"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000003b46310592c23438
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 17, 2019 at 12:33 AM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> So yes, that would it make it harder to abuse the API, but not
> impossible. Which may still be good, I don't know.

So the real problem is not people abusing the ABI per se. Yes, I was a
bit worried about that too, but it's not the cause of the immediate
issue.

The real problem is that "getrandom(0)" is really _convenient_ for
people who just want random numbers - and not at all the "secure"
kind.

And it's convenient, and during development and testing, it always
"just works", because it doesn't ever block in any normal situation.

And then you deploy it, and on some poor users machine it *does*
block, because the program now encounters the "oops, no entropy"
situation that it never ever encountered on the development machine,
because the testing there was mainly done not during booting, but the
developer also probably had a much more modern machine that had
rdrand, and that quite possibly also had more services enabled at
bootup etc so even without rdrand it got tons of entropy.

That's why

 (a) killing the process is _completely_ silly.  It misses the whole
point of the problem in the first place and only makes things much
worse.

 (b) we should just change getrandom() and add that GRND_SECURE flag
instead. Because the current API is fundamentally confusing. If you
want secure random numbers, you should really deeply _know_ about it,
and think about it, rather than have it be the "oh, don't even bother
passing any flags, it's secure by default".

 (c) the timeout approach isn't wonderful, but it at least helps with
the "this was never tested under those circumstances" kind of problem.

Note that the people who actually *thought* about getrandom() and use
it correctly should already handle error returns (even for the
blocking version), because getrandom() can already return EINTR. So
the argument that we should cater primarily to the secure key people
is not all that strong. We should be able to return EINTR, and the
people who *thought* about blocking and about entropy should be fine.

And gdm and other silly random users that never wanted entropy in the
first place, just "random" random numbers, wouldn't be in the
situation they are now.

That said - looking at some of the problematic traces that Ahmed
posted for his bootup problem, I actually think we can use *another*
heuristic to solve the problem. Namely just looking at how much
randomness the caller wants.

The processes that ask for randomness for an actual secure key have a
very fundamental constraint: they need enough randomness for the key
to be secure in the first place.

But look at what gnome-shell and gnome-session-b does:

    https://lore.kernel.org/linux-ext4/20190912034421.GA2085@darwi-home-pc/

and most of them already set GRND_NONBLOCK, but look at the
problematic one that actually causes the boot problem:

    gnome-session-b-327   4.400620: getrandom(16 bytes, flags = 0)

and here the big clue is: "Hey, it only asks for 128 bits of randomness".

Does anybody believe that 128 bits of randomness is a good basis for a
long-term secure key? Even if the key itself contains than that, if
you are generating a long-term secure key in this day and age, you had
better be asking for more than 128 bits of actual unpredictable base
data. So just based on the size of the request we can determine that
this is not hugely important.

Compare that to the case later on for something that seems to ask for
actual interesting randomness. and - just judging by the name -
probably even has a reason for it:

      gsd-smartcard-388   51.433924: getrandom(110 bytes, flags = 0)
      gsd-smartcard-388   51.433936: getrandom(256 bytes, flags = 0)

big difference.

End result: I would propose the attached patch.

Ahmed, can you just verify that it works for you (obviously with the
ext4 plugging reinstated)? It looks like it should "obviously" fix
things, but still...

                    Linus

--0000000000003b46310592c23438
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k0o1w7n40>
X-Attachment-Id: f_k0o1w7n40

IGRyaXZlcnMvY2hhci9yYW5kb20uYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMgYi9kcml2ZXJzL2NoYXIvcmFuZG9tLmMK
aW5kZXggNTY2OTIyZGY0YjdiLi43YmU3NzFlYWM5NjkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2hh
ci9yYW5kb20uYworKysgYi9kcml2ZXJzL2NoYXIvcmFuZG9tLmMKQEAgLTIxMTgsNiArMjExOCwz
NyBAQCBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHVyYW5kb21fZm9wcyA9IHsKIAkubGxz
ZWVrID0gbm9vcF9sbHNlZWssCiB9OwogCisvKgorICogSGFja3kgd29ya2Fyb3VuZCBmb3IgdGhl
IGZhY3QgdGhhdCBzb21lIHByb2Nlc3NlcworICogYXNrIGZvciB0cnVseSBzZWN1cmUgcmFuZG9t
IG51bWJlcnMgYW5kIGFic29sdXRlbHkgd2FudAorICogdG8gd2FpdCBmb3IgdGhlIGVudHJvcHkg
cG9vbCB0byBmaWxsLCBhbmQgb3RoZXJzIGp1c3QKKyAqIGRvICJnZXRyYW5kb20oMCkiIHRvIGdl
dCBzb21lIGFkLWhvYyByYW5kb20gbnVtYmVycy4KKyAqCisgKiBJZiB5b3UncmUgZ2VuZXJhdGlu
ZyBhIHNlY3VyZSBrZXksIHlvdSdkIGJldHRlciBhc2sgZm9yCisgKiBtb3JlIHRoYW4gMTI4IGJp
dHMgb2YgcmFuZG9tbmVzcy4gT3RoZXJ3aXNlIGl0J3Mgbm90CisgKiByZWFsbHkgYWxsIHRoYXQg
c2VjdXJlIGJ5IGRlZmluaXRpb24uCisgKgorICogV2Ugc2hvdWxkIGFkZCBhIEdSTkRfU0VDVVJF
IGZsYWcgc28gdGhhdCBwZW9wbGUgY2FuIHN0YXRlCisgKiB0aGlzICJJIHdhbnQgc2VjdXJlIHJh
bmRvbSBudW1iZXJzIiBleHBsaWNpdGx5LgorICovCitzdGF0aWMgaW50IHdhaXRfZm9yX2dldHJh
bmRvbShzaXplX3QgY291bnQpCit7CisJdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gTUFYX1NDSEVE
VUxFX1RJTUVPVVQ7CisJaW50IHJldDsKKworCS8qIFdlJ2xsIGdpdmUgZXZlbiBzbWFsbCByZXF1
ZXN0cyBfc29tZV8gdGltZSB0byBnZXQgbW9yZSBlbnRyb3B5ICovCisJaWYgKGNvdW50IDw9IDE2
KQorCQl0aW1lb3V0ID0gNSpIWjsKKworCXJldCA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90
aW1lb3V0KGNybmdfaW5pdF93YWl0LCBjcm5nX3JlYWR5KCksIHRpbWVvdXQpOworCWlmIChsaWtl
bHkocmV0KSkKKwkJcmV0dXJuIHJldCA+IDAgPyAwIDogcmV0OworCisJLyogVGltZWQgb3V0IC0g
d2UnbGwgcmV0dXJuIHVyYW5kb20gKi8KKwlwcl9ub3RpY2UoInJhbmRvbTogZmFsbGluZyBiYWNr
IHRvIHVyYW5kb20gZm9yIHNtYWxsIHJlcXVlc3Qgb2YgJXp1IGJ5dGVzIiwgY291bnQpOworCXJl
dHVybiAwOworfQorCiBTWVNDQUxMX0RFRklORTMoZ2V0cmFuZG9tLCBjaGFyIF9fdXNlciAqLCBi
dWYsIHNpemVfdCwgY291bnQsCiAJCXVuc2lnbmVkIGludCwgZmxhZ3MpCiB7CkBAIC0yMTM1LDcg
KzIxNjYsNyBAQCBTWVNDQUxMX0RFRklORTMoZ2V0cmFuZG9tLCBjaGFyIF9fdXNlciAqLCBidWYs
IHNpemVfdCwgY291bnQsCiAJaWYgKCFjcm5nX3JlYWR5KCkpIHsKIAkJaWYgKGZsYWdzICYgR1JO
RF9OT05CTE9DSykKIAkJCXJldHVybiAtRUFHQUlOOwotCQlyZXQgPSB3YWl0X2Zvcl9yYW5kb21f
Ynl0ZXMoKTsKKwkJcmV0ID0gd2FpdF9mb3JfZ2V0cmFuZG9tKGNvdW50KTsKIAkJaWYgKHVubGlr
ZWx5KHJldCkpCiAJCQlyZXR1cm4gcmV0OwogCX0K
--0000000000003b46310592c23438--
