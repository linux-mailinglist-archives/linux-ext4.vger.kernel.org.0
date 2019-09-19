Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F297CB7E89
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391433AbfISPuk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Sep 2019 11:50:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37901 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390065AbfISPuj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Sep 2019 11:50:39 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so2749041lfc.5
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2019 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pbGb1qoXXUDgxhVKE46Fq3Mij1h8IprRiLVN+K9eok=;
        b=RlYVElkzZxzmaoHRiNt/mc8G0VCjQqhg85mVNX+abH6kPsJUyGjCV2fpFK0cYkiX1w
         eedA4nwrCbMa8ACbnmzOQncnPZirXX9cbUiShwZYI0vFKdBEzSeauRcMTqo/szlQ72dD
         bTkOFWTCzcNeLfaUSnLnWZyg/DB9Dumog6Okg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pbGb1qoXXUDgxhVKE46Fq3Mij1h8IprRiLVN+K9eok=;
        b=flUtW4V72uU4VoNTRDolacyPn3ejcW7B3EID7niGfD7j+segl6jOOqdVt+uqduoHbM
         5x8iAioDSA8VWfd7/dhwhbNcUaM/DoITSAegKbA8RXuSp7xeKmTvk3ONTABztv1GLFWb
         GIL14bRez+yTHk2tdGOKnigCHq5KsjTjV2R0U5JXU/C9Ib7iDoXwsI6RRfYyikUaX+5X
         4Vnzay0nUE0FAGPkqvVEAMYgBI5wm5nyeGgbzMTz5n6vDVK0UF37YIeNK/QebU7qfnJB
         viOEzRav3cMmpKwbFGi2rKbQ4/wM/DZEvSihOP/858WlqixcBOcz+hLVGNvoIyTxy6+0
         sMnw==
X-Gm-Message-State: APjAAAVjIbuDZhgfN3T/f1F7VHmftbZKQ8vHyICnIyRQ4XFmOgA4d/SD
        2wUgOx311Rh+Xqy7SYtBjDIGHppju7w=
X-Google-Smtp-Source: APXvYqw04psoK4/W4MmxoLtrC3nmml1UvmDIwteXolM7GCyiUPG/sfiVqfA4NGE+7+3/H2TvEiyOwQ==
X-Received: by 2002:a19:beca:: with SMTP id o193mr5562499lff.137.1568908236367;
        Thu, 19 Sep 2019 08:50:36 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r27sm1719456ljn.60.2019.09.19.08.50.32
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 08:50:33 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y127so2772888lfc.0
        for <linux-ext4@vger.kernel.org>; Thu, 19 Sep 2019 08:50:32 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr5291896lfn.52.1568908232463;
 Thu, 19 Sep 2019 08:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu> <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Sep 2019 08:50:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRUqH1dch2VCaYqNT+_vPj6LXGHcP4oW9-M3zdSfXrTg@mail.gmail.com>
Message-ID: <CAHk-=wiRUqH1dch2VCaYqNT+_vPj6LXGHcP4oW9-M3zdSfXrTg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e1bcec0592e9e9e6"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--000000000000e1bcec0592e9e9e6
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 19, 2019 at 8:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The silly "reset crng_init_cnt" does absolutely nothing to help that,
> but in fact what it does is to basically give the attacker a way to
> get an infinite stream of data without any reseeding (because that
> only happens after crng_read()), and able to extend that "block at
> boot" time indefinitely while doing so.

.. btw, instead of bad workarounds for a theoretical attack, here's
something that should add actual *practical* real value: use the time
of day (whether from an RTC device, or from ntp) to add noise to the
random pool.

If you let attackers in before you've set the clock on the device,
you're doing something seriously wrong.

And while this doesn't add much "serious" entropy, it does mean that
the whole "let's look for identical state" which is a _real_ attack,
goes out the window.

In other words, this is about real security, not academic papers.

Of course, attackers can still see possible bad random values from
before the clock was set (possibly from things like TCP sequence
numbers etc, orfrom  that AT_RANDOM of a very early process, which was
part of the Android the attack). But doing things like delaying
reseeding sure isn't helping, which is what the crng_count reset does.

                 Linus

--000000000000e1bcec0592e9e9e6
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k0qv4jl10>
X-Attachment-Id: f_k0qv4jl10

IGtlcm5lbC90aW1lL3RpbWVrZWVwaW5nLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpbWVrZWVwaW5nLmMgYi9rZXJu
ZWwvdGltZS90aW1la2VlcGluZy5jCmluZGV4IGNhNjkyOTBiZWUyYS4uNjdlNzRmN2Y0MTk4IDEw
MDY0NAotLS0gYS9rZXJuZWwvdGltZS90aW1la2VlcGluZy5jCisrKyBiL2tlcm5lbC90aW1lL3Rp
bWVrZWVwaW5nLmMKQEAgLTIyLDYgKzIyLDcgQEAKICNpbmNsdWRlIDxsaW51eC9wdmNsb2NrX2d0
b2QuaD4KICNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPgogI2luY2x1ZGUgPGxpbnV4L2F1ZGl0
Lmg+CisjaW5jbHVkZSA8bGludXgvcmFuZG9tLmg+CiAKICNpbmNsdWRlICJ0aWNrLWludGVybmFs
LmgiCiAjaW5jbHVkZSAibnRwX2ludGVybmFsLmgiCkBAIC0xMjU2LDYgKzEyNTcsNyBAQCBpbnQg
ZG9fc2V0dGltZW9mZGF5NjQoY29uc3Qgc3RydWN0IHRpbWVzcGVjNjQgKnRzKQogCiAJLyogc2ln
bmFsIGhydGltZXJzIGFib3V0IHRpbWUgY2hhbmdlICovCiAJY2xvY2tfd2FzX3NldCgpOworCWFk
ZF9kZXZpY2VfcmFuZG9tbmVzcyh0cywgc2l6ZW9mKCp0cykpOwogCiAJaWYgKCFyZXQpCiAJCWF1
ZGl0X3RrX2luam9mZnNldCh0c19kZWx0YSk7CkBAIC0xMzA0LDYgKzEzMDYsNyBAQCBzdGF0aWMg
aW50IHRpbWVrZWVwaW5nX2luamVjdF9vZmZzZXQoY29uc3Qgc3RydWN0IHRpbWVzcGVjNjQgKnRz
KQogCiAJLyogc2lnbmFsIGhydGltZXJzIGFib3V0IHRpbWUgY2hhbmdlICovCiAJY2xvY2tfd2Fz
X3NldCgpOworCWFkZF9kZXZpY2VfcmFuZG9tbmVzcyh0cywgc2l6ZW9mKCp0cykpOwogCiAJcmV0
dXJuIHJldDsKIH0K
--000000000000e1bcec0592e9e9e6--
