Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08806B96FD
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 20:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406265AbfITSM3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 14:12:29 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49225 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405041AbfITSM3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 14:12:29 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8KICGgZ001902;
        Fri, 20 Sep 2019 20:12:16 +0200
Date:   Fri, 20 Sep 2019 20:12:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190920181216.GA1889@1wt.eu>
References: <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc>
 <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andy,

On Fri, Sep 20, 2019 at 10:52:30AM -0700, Andy Lutomirski wrote:
> 2. Fix what is arguably a straight up kernel bug, not even an ABI
> issue: when a user program is blocking in getrandom(..., 0), the
> kernel happily sits there doing absolutely nothing and deadlocks the
> system as a result.  This IMO isn't an ABI issue -- it's an
> implementation problem.  How about we make getrandom() (probably
> actually wait_for_random_bytes()) do something useful to try to seed
> the RNG if the system is otherwise not doing IO.

I thought about it as well with my old MSDOS reflexes, but here I
doubt we can do a lot. It seems fishy to me to start to fiddle with
various drivers from within a getrandom() syscall, we could sometimes
even end up waiting even longer because one device is already locked,
and when we have access there there's not much we can do without
risking to cause some harm. On desktop systems you have a bit more
choice than on headless systems (blink keyboard leds and time the
interrupts, run some disk accesses when there's still a disk, get a
copy of the last buffer of the audio input and/or output, turn on
the microphone and/or webcam, and collect some data). Many of them
cannot always be used. We could do some more portable stuff like scan
and hash the totality of the RAM. But that's all quite bad and
unreliable and at this point it's better to tell userland "here's
what I could get for you, if you want better, do it yourself" and the
userland can then ask the user "dear user, I really need valid entropy
this time to generate your GPG key, please type frantically on this
keyboard". And it will be more reliable this way in my opinion.

My analysis of the problem precisely lies in the fact that we've
always considered that the kernel had to provide randoms for any
use case and had to cover the most difficult cases and imposed
their constraints on simplest ones. Better let the application
decide.

Willy
