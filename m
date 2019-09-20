Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E285DB9AB6
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2019 01:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405066AbfITXaf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 19:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404967AbfITXaf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 19:30:35 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1B221882
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569022234;
        bh=WnMayVa2/XDvHL1e+7jmVvQ/LflCEEfThR3A/O6WAe0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MDD97AOK7h1yXKTkH80poLtBNE96X2T5kJ98AMCn2EJoMnuaKS+R8hY1QSnwRhIw6
         n8/ucSaPzuQvrsD9Uz3Oo9KrMF4/WwiIGoBzcPKEcrHGmFD/tw6nOOADNtLx9N982o
         YldrD65lYj0eN1ent3+i64cVSojAaqSDLXJqAZaU=
Received: by mail-wr1-f53.google.com with SMTP id i1so8333378wro.4
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 16:30:33 -0700 (PDT)
X-Gm-Message-State: APjAAAWfPr/mB1FslgoeZruUBekGYz5GpaeY3T+PuD5cd+IAmtv520pk
        7Zf2QaO9/NGycWzmNMGR206Cj4TYErpzwX/ls+DktQ==
X-Google-Smtp-Source: APXvYqzX4CwBJfqfTYtsfZiWbwOGIEcas93ymXw8ez4QvH3rwZ04YTXpTAYLf/0PldtRhMHifaqzsBGLqgFhr6R4V4Q=
X-Received: by 2002:a5d:4c92:: with SMTP id z18mr12974870wrs.111.1569022232290;
 Fri, 20 Sep 2019 16:30:32 -0700 (PDT)
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
 <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
 <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
 <CALCETrXMp3dJaKDm+RQijQEUuPNPmpKWr8Ljf+RqycXChGnKrw@mail.gmail.com> <CAHk-=whz7Okts01ygAP6GZWBvCV7s==CKjghmOp+r+LWketBYQ@mail.gmail.com>
In-Reply-To: <CAHk-=whz7Okts01ygAP6GZWBvCV7s==CKjghmOp+r+LWketBYQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Sep 2019 16:30:20 -0700
X-Gmail-Original-Message-ID: <CALCETrWCjGHKnKikj+YVw22Ufpmnh1TCdGPjG2RL-qzsF=wisA@mail.gmail.com>
Message-ID: <CALCETrWCjGHKnKikj+YVw22Ufpmnh1TCdGPjG2RL-qzsF=wisA@mail.gmail.com>
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

On Fri, Sep 20, 2019 at 3:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 20, 2019 at 1:51 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > To be clear, when I say "blocking", I mean "blocks until we're ready,
> > but we make sure we're ready in a moderately timely manner".
>
> .. an I want a pony.
>
> The problem is that you start from an assumption that we simply can't
> seem to do.

Eh, fair enough, I wasn't thinking about platforms without fast clocks.

I'm very nervous about allowing getrandom(..., 0) to fail with
-EAGAIN, though.  On a very, very brief search, I didn't find any
programs that would incorrectly assume it worked, but I can easily
imagine programs crashing, and that might be bad, too.  At the end of
the day, most user programmers who call getrandom() really did notice
that we flubbed the ABI, and either they were too lazy to fall back to
/dev/urandom, or they didn't want to for some reason, or they
genuinely want the blocking behavior.  And people who work with little
embedded systems without good clocks that basically can't generate
random numbers already know this, and they have little scripts to help
out.

So I think that just improving the
getrandom()-is-blocking-on-x86-and-arm behavior, adding GRND_INSECURE
and GRND_SECURE_BLOCKING, and adding the warning if 0 is passed is
good enough.  I suppose we could also have separate
GRND_SECURE_BLOCKING and GRND_SECURE_BLOCK_FOREVER.  We could also say
that, if you want to block forever, you should poll() on /dev/random
(with my patches applied, where this actually does what users would
want).

--Andy
