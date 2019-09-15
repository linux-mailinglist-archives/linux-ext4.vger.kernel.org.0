Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA96B312D
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfIORcj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 13:32:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35526 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfIORcj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 13:32:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1so92237ljc.2
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMvYCEPcbJQk6uvHg/uZleqaQ0GLtqeaowrky7QhAac=;
        b=SQ3SJZHA20v7FW42MRvShirFBRekszCXF96ECgcq+9WaPqiijSKYutTTfwgdrr6FsE
         wFZs2V4Wn+lNeUF5+rv38fAB/zZTGSYQr0Q3p8oQcrmREZW6K1bUACKBxqUIj8LLs5mC
         nBxcb+jXtvmMgfVNdNQ0XXUEAVg7FT0LXsw2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMvYCEPcbJQk6uvHg/uZleqaQ0GLtqeaowrky7QhAac=;
        b=FlGk8q177T6dLn7q/JWBFZbgL0SDEusiMcOydQ47wXOj0H2j3ImVJvs41hjRHDawoK
         57wb3mzH3uGC1JxkUML20wK6BOeSwMLLuflau6+JpGn4yt9hBM/mGejx0NZkfSmO4K0r
         Crs5HiBUVtF8GWDKF7iPa37SHtzWg9vtMlGIexB1i8pZyLuFh0bu+jjoCa+ikTJcngVB
         kPpnSrdYrW3ZyXJxOke+M9TxpQmr3eoN+Ore6lXVVAdO44kCu5KXbdyNl8mGFXDEll5B
         0h8VECD5QpjRDiVe066T40TdvEnNlUloCiKWscBgvFMtyeIuvhWbFqNreLqGnJU467qy
         vP1Q==
X-Gm-Message-State: APjAAAWsYP6RlASr6XkneRFsbk4ja7j6hF6SUyaz6ZhcBUeImPCxDi7k
        Jsk9MVcTNdFsXRwyTzeUAhKoIv1rPIA=
X-Google-Smtp-Source: APXvYqyKCdUH/OniEZNCdRCGdTg37atbxVpqS9JEIHkkJ/tzx4BewNnnAp1L9hSXP4gnJPN9I9vWQA==
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr28405027ljj.153.1568568755083;
        Sun, 15 Sep 2019 10:32:35 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 21sm845967ljq.15.2019.09.15.10.32.31
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 10:32:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y127so2418941lfc.0
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 10:32:31 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr11144104lfn.52.1568568751509;
 Sun, 15 Sep 2019 10:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjo6qDvh_fUnd2HdDb63YbWN09kE0FJPgCW+nBaWMCNAQ@mail.gmail.com>
 <20190911160729.GF2740@mit.edu> <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
In-Reply-To: <20190915052242.GG19710@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 10:32:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
Message-ID: <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2] random: optionally block in getrandom(2) when the
 CRNG is uninitialized
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Content-Type: multipart/mixed; boundary="0000000000003d7eca05929adfe4"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000003d7eca05929adfe4
Content-Type: text/plain; charset="UTF-8"

[ Added Lennart, who was active in the other thread ]

On Sat, Sep 14, 2019 at 10:22 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Thus, add an optional configuration option which stops getrandom(2)
> from blocking, but instead returns "best efforts" randomness, which
> might not be random or secure at all.

So I hate having a config option for something like this.

How about this attached patch instead? It only changes the waiting
logic, and I'll quote the comment in full, because I think that
explains not only the rationale, it explains every part of the patch
(and is most of the patch anyway):

 * We refuse to wait very long for a blocking getrandom().
 *
 * The crng may not be ready during boot, but if you ask for
 * blocking random numbers very early, there is no guarantee
 * that you'll ever get any timely entropy.
 *
 * If you are sure you need entropy and that you can generate
 * it, you need to ask for non-blocking random state, and then
 * if that fails you must actively _do_something_ that causes
 * enough system activity, perhaps asking the user to type
 * something on the keyboard.
 *
 * Just asking for blocking random numbers is completely and
 * fundamentally wrong, and the kernel will not play that game.
 *
 * We will block for at most 15 seconds at a time, and if called
 * sequentially will decrease the blocking amount so that we'll
 * block for at most 30s total - and if people continue to ask
 * for blocking, at that point we'll just return whatever random
 * state we have acquired.
 *
 * This will also complain loudly if the timeout happens, to let
 * the distribution or system admin know about the problem.
 *
 * The process that gets the -EAGAIN will hopefully also log the
 * error, to raise awareness that there may be use of random
 * numbers without sufficient entropy.

Hmm? No strange behavior. No odd config variables. A bounded total
boot-time wait of 30s (which is a completely random number, but I
claimed it as the "big red button" time).

And if you only do it once and fall back to something else it will
only wait for 15s, and you'll have your error value so that you can
log it properly.

Yes, a single boot-time wait of 15s at boot is still "darn annoying",
but it likely

 (a) isn't so long that people consider it a boot failure and give up
(but hopefully annoying enough that they'll report it)

 (b) long enough that *if* the thing that is waiting is not actually
blocking the boot sequence, the non-blocked part of the boot sequence
should have time to do sufficient IO to get better randomness.

So (a) is the "the system is still usable" part. While (b) is the
"give it a chance, and even if it fails and you fall back on urandom
or whatever, you'll actually be getting good randomness even if we
can't perhaps _guarantee_ entropy".

Also, if you have some user that wants to do the old-timey ssh-keygen
thing with user input etc, we now have a documented way to do that:
just do the nonblocking thing, and then make really really sure that
you actually have something that generates more entropy if that
nonblocking thing returns EAGAIN. But it's also very clear that at
that point the program that wants this entropy guarantee has to _work_
for it.

Because just being lazy and say "block" without any entropy will
return EAGAIN for a (continually decreasing) while, but then at some
point stop and say "you're broken", and just give you the urandom
data.

Because if you really do nothing at all, and there is no activity
what-so-ever for 15s because you blocked the boot, then I claim that
it's better to return an error than to wait forever. And if you ignore
the error and just retry, eventually we'll do the fallback for you.

Of course, if you have something like rdrand, and told us you trust
it, none of this matters at all, since we'll have initialized the pool
long before.

So this is unconditional, but it's basically "unconditionally somewhat
flexibly reasonable". It should only ever trigger for the case where
the boot sequence was fundamentally broken. And it will complain
loudly (both at a kernel level, and hopefully at a systemd journal
level too) if it ever triggers.

And hey, if some distro wants to then revert this because they feel
uncomfortable with this, that's now _their_ problem, not the problem
of the upstream kernel. The upstream kernel tries to do something that
I think is arguably fairly reasonable in all situations.

                 Linus

--0000000000003d7eca05929adfe4
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k0l8lgqd0>
X-Attachment-Id: f_k0l8lgqd0

IGRyaXZlcnMvY2hhci9yYW5kb20uYyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3JhbmRvbS5jIGIvZHJp
dmVycy9jaGFyL3JhbmRvbS5jCmluZGV4IDVkNWVhNGNlMTQ0Mi4uMGQ3ZGM4NmUwZjYwIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMKKysrIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5j
CkBAIC0yMTE4LDYgKzIxMTgsNTUgQEAgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyB1cmFu
ZG9tX2ZvcHMgPSB7CiAJLmxsc2VlayA9IG5vb3BfbGxzZWVrLAogfTsKIAorLyoKKyAqIFdlIHJl
ZnVzZSB0byB3YWl0IHZlcnkgbG9uZyBmb3IgYSBibG9ja2luZyBnZXRyYW5kb20oKS4KKyAqCisg
KiBUaGUgY3JuZyBtYXkgbm90IGJlIHJlYWR5IGR1cmluZyBib290LCBidXQgaWYgeW91IGFzayBm
b3IKKyAqIGJsb2NraW5nIHJhbmRvbSBudW1iZXJzIHZlcnkgZWFybHksIHRoZXJlIGlzIG5vIGd1
YXJhbnRlZQorICogdGhhdCB5b3UnbGwgZXZlciBnZXQgYW55IHRpbWVseSBlbnRyb3B5LgorICoK
KyAqIElmIHlvdSBhcmUgc3VyZSB5b3UgbmVlZCBlbnRyb3B5IGFuZCB0aGF0IHlvdSBjYW4gZ2Vu
ZXJhdGUKKyAqIGl0LCB5b3UgbmVlZCB0byBhc2sgZm9yIG5vbi1ibG9ja2luZyByYW5kb20gc3Rh
dGUsIGFuZCB0aGVuCisgKiBpZiB0aGF0IGZhaWxzIHlvdSBtdXN0IGFjdGl2ZWx5IF9kb19zb21l
dGhpbmdfIHRoYXQgY2F1c2VzCisgKiBlbm91Z2ggc3lzdGVtIGFjdGl2aXR5LCBwZXJoYXBzIGFz
a2luZyB0aGUgdXNlciB0byB0eXBlCisgKiBzb21ldGhpbmcgb24gdGhlIGtleWJvYXJkLgorICoK
KyAqIEp1c3QgYXNraW5nIGZvciBibG9ja2luZyByYW5kb20gbnVtYmVycyBpcyBjb21wbGV0ZWx5
IGFuZAorICogZnVuZGFtZW50YWxseSB3cm9uZywgYW5kIHRoZSBrZXJuZWwgd2lsbCBub3QgcGxh
eSB0aGF0IGdhbWUuCisgKgorICogV2Ugd2lsbCBibG9jayBmb3IgYXQgbW9zdCAxNSBzZWNvbmRz
IGF0IGEgdGltZSwgYW5kIGlmIGNhbGxlZAorICogc2VxdWVudGlhbGx5IHdpbGwgZGVjcmVhc2Ug
dGhlIGJsb2NraW5nIGFtb3VudCBzbyB0aGF0IHdlJ2xsCisgKiBibG9jayBmb3IgYXQgbW9zdCAz
MHMgdG90YWwgLSBhbmQgaWYgcGVvcGxlIGNvbnRpbnVlIHRvIGFzaworICogZm9yIGJsb2NraW5n
LCBhdCB0aGF0IHBvaW50IHdlJ2xsIGp1c3QgcmV0dXJuIHdoYXRldmVyIHJhbmRvbQorICogc3Rh
dGUgd2UgaGF2ZSBhY3F1aXJlZC4KKyAqCisgKiBUaGlzIHdpbGwgYWxzbyBjb21wbGFpbiBsb3Vk
bHkgaWYgdGhlIHRpbWVvdXQgaGFwcGVucywgdG8gbGV0CisgKiB0aGUgZGlzdHJpYnV0aW9uIG9y
IHN5c3RlbSBhZG1pbiBrbm93IGFib3V0IHRoZSBwcm9ibGVtLgorICoKKyAqIFRoZSBwcm9jZXNz
IHRoYXQgZ2V0cyB0aGUgLUVBR0FJTiB3aWxsIGhvcGVmdWxseSBhbHNvIGxvZyB0aGUKKyAqIGVy
cm9yLCB0byByYWlzZSBhd2FyZW5lc3MgdGhhdCB0aGVyZSBtYXkgYmUgdXNlIG9mIHJhbmRvbQor
ICogbnVtYmVycyB3aXRob3V0IHN1ZmZpY2llbnQgZW50cm9weS4KKyAqLworc3RhdGljIGludCBn
ZXRyYW5kb21fd2FpdCh2b2lkKQoreworCXN0YXRpYyB1bnNpZ25lZCBpbnQgZ2V0cmFuZG9tX3Rp
bWVvdXQgPSAxNSpIWjsKKwl1bnNpZ25lZCBpbnQgdGltZW91dCA9IFJFQURfT05DRShnZXRyYW5k
b21fdGltZW91dCk7CisJaW50IHJldDsKKworCS8qICJBdCBzb21lIHBvaW50IHlvdSBqdXN0IGhh
dmUgdG8gZ2l2ZSB1cCBvbiBicm9rZW4gYm9vdCBzY3JpcHRzIiAqLworCWlmICghdGltZW91dCkK
KwkJcmV0dXJuIDA7CisKKwlyZXQgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dChj
cm5nX2luaXRfd2FpdCwgY3JuZ19yZWFkeSgpLCB0aW1lb3V0KTsKKwkvKiBTdWNjZXNzICg+MCkg
b3IgaW50ZXJydXB0ZWQgKDwwKT8gKi8KKwlpZiAobGlrZWx5KHJldCkpCisJCXJldHVybiByZXQg
PiAwID8gMCA6IHJldDsKKworCVdSSVRFX09OQ0UoZ2V0cmFuZG9tX3RpbWVvdXQsIHRpbWVvdXQg
Pj4gMSk7CisJV0FSTl9PTkNFKDEsICJnZXRyYW5kb20oKSB0aW1lZCBvdXQgd2l0aCBubyBlbnRy
b3B5Iik7CisJcmV0dXJuIC1FQUdBSU47Cit9CisKIFNZU0NBTExfREVGSU5FMyhnZXRyYW5kb20s
IGNoYXIgX191c2VyICosIGJ1Ziwgc2l6ZV90LCBjb3VudCwKIAkJdW5zaWduZWQgaW50LCBmbGFn
cykKIHsKQEAgLTIxMzIsMTEgKzIxODEsMTEgQEAgU1lTQ0FMTF9ERUZJTkUzKGdldHJhbmRvbSwg
Y2hhciBfX3VzZXIgKiwgYnVmLCBzaXplX3QsIGNvdW50LAogCWlmIChmbGFncyAmIEdSTkRfUkFO
RE9NKQogCQlyZXR1cm4gX3JhbmRvbV9yZWFkKGZsYWdzICYgR1JORF9OT05CTE9DSywgYnVmLCBj
b3VudCk7CiAKLQlpZiAoIWNybmdfcmVhZHkoKSkgeworCWlmICh1bmxpa2VseSghY3JuZ19yZWFk
eSgpKSkgewogCQlpZiAoZmxhZ3MgJiBHUk5EX05PTkJMT0NLKQogCQkJcmV0dXJuIC1FQUdBSU47
Ci0JCXJldCA9IHdhaXRfZm9yX3JhbmRvbV9ieXRlcygpOwotCQlpZiAodW5saWtlbHkocmV0KSkK
KwkJcmV0ID0gZ2V0cmFuZG9tX3dhaXQoKTsKKwkJaWYgKHJldCkKIAkJCXJldHVybiByZXQ7CiAJ
fQogCXJldHVybiB1cmFuZG9tX3JlYWQoTlVMTCwgYnVmLCBjb3VudCwgTlVMTCk7Cg==
--0000000000003d7eca05929adfe4--
