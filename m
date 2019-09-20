Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E04A1B98A9
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 22:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfITUvw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 16:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387598AbfITUvw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 16:51:52 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FCB21971
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 20:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569012711;
        bh=xg2vlVd+lUwNBRO5ewZnZq4NbIRw0nw27U11uZH30fk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ja/HOdXighvrnJiFLrz4+KK+jUExurZERXM/s9E9gYXmBROOvr2pFDqFILFyC2OWE
         9WE/Sxa1j7kQq2UZ9XGCw7M8tv8wlhUKChtrC39CVes45zIqidsR1DyWei3GQR5w5I
         NXNEmgCZY5E7YJX/nIXRHu7kQOw2KxnAWjdOCfvc=
Received: by mail-wm1-f52.google.com with SMTP id f16so3472577wmb.2
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 13:51:50 -0700 (PDT)
X-Gm-Message-State: APjAAAV0imFR1LGulvGPvQU/Ru6dLDoB+cK4vLklTmH68WSh2/8RePay
        vjzoMTXBjJJVGYtZzk1aCcAzyrlOP4lRllEJMcgU5A==
X-Google-Smtp-Source: APXvYqywYkJ/O57lEsQ+jvss3/ohzrMA8/uB8+mxAxzS3Bfy8j/rWUdJ5qoeAdvcjylTbdAKIxJ5AvFG9fnkwNFUq8U=
X-Received: by 2002:a1c:1bcf:: with SMTP id b198mr5091632wmb.0.1569012709337;
 Fri, 20 Sep 2019 13:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190912034421.GA2085@darwi-home-pc> <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc> <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu> <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc> <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
 <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com> <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
In-Reply-To: <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 13:51:37 -0700
X-Gmail-Original-Message-ID: <CALCETrXMp3dJaKDm+RQijQEUuPNPmpKWr8Ljf+RqycXChGnKrw@mail.gmail.com>
Message-ID: <CALCETrXMp3dJaKDm+RQijQEUuPNPmpKWr8Ljf+RqycXChGnKrw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 12:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > And the only real question is how to map existing users to these
> > semantics.  I see two sensible choices:
> >
> > 1. 0 means "secure, blocking". I think this is not what we'd do if we
> > could go back in time and chage the ABI from day 1, but I think it's
> > actually good enough.  As long as this mode won't deadlock, it's not
> > *that* bad if programs are using it when they wanted "insecure".
>
> It's exactly that "as long as it won't deadlock" that is our current problem.
>
> It *does* deadlock.
>
> So it can't mean "blocking" in any long-term meaning.
>
> It can mean "blocks for up to 15 seconds" or something like that. I'd
> honestly prefer a smaller number, but I think 15 seconds is an
> acceptable "your user space is buggy, but we won't make you think the
> machine hung".

To be clear, when I say "blocking", I mean "blocks until we're ready,
but we make sure we're ready in a moderately timely manner".

Rather than answering everything point by point, here's a updated
mini-proposal and some thoughts.  There are two families of security
people that I think we care about.  One is the FIPS or CC or PCI
crowd, and they might, quite reasonably, demand actual hardware RNGs.
We should make the hwrng API stop sucking and they should be happy.
(This means expose an hwrng device node per physical device, IMO.)
The other is the one who wants getrandom(), etc to be convincingly
secure and is willing to do some actual analysis.  And I think we can
make them quite happy like this:

In the kernel, we have two types of requests for random numbers: a
request for "secure" bytes and a request for "insecure" bytes.
Requests for "secure" bytes can block or return -EAGAIN.  Requests for
"insecure" bytes succeed without waiting.  In addition, we have a
jitter entropy mechanism (maybe the one mjg59 referenced, maybe
Alexander's -- doesn't really matter) and we *guarantee* that jitter
entropy, by itself, is enough to get the "secure" generator working
after, say, 5s of effort.  By this, I mean that, on an idle system, it
finishes in 5s and, on a fully loaded system, it's allowed to take a
little while longer but not too much longer.

In other words, I want GRND_SECURE_BLOCKING and /dev/random reads to
genuinely always work and to genuinely never take much longer than 5s.
I don't want a special case where they fail.

The exposed user APIs are, subject to bikeshedding that can happen
later over the actual values, etc:

GRND_SECURE_BLOCKING: returns "secure" output and blocks until it's
ready.  This never fails, but it also never blocks forever.

GRND_SECURE_NONBLOCKING: same but returns -EAGAIN instead of blocking.

GRND_INSECURE: returns "insecure" output immediately.  I think we do
need this -- the "secure" mode may take a little while at early boot,
and libraries that initialize themselves with some randomness really
do want a way to get some numbers without any delay whatsoever.

0: either the same as GRND_SECURE_BLOCKING plus a warning or the
"accelerated" version.  The "accelerated" version means wait up to 2s
for secure numbers and, if there still aren't any, fall back to
"insecure".

GRND_RANDOM: either the same as 0 or the same as GRND_SECURE_BLOCKING
but with a warning.  I don't particularly care either way.

I'm okay with a well-defined semantic like I proposed for an
accelerated mode.  I don't really want to try to define what a
secure-but-not-as-secure mode means as a separate complication that
the underlying RNG needs to support forever.  I don't think the
security folks would like that either.

How does this sound?
