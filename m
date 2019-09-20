Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A034B9714
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406347AbfITSQe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 14:16:34 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49235 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404864AbfITSQd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 14:16:33 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8KIGNXG001910;
        Fri, 20 Sep 2019 20:16:23 +0200
Date:   Fri, 20 Sep 2019 20:16:23 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20190920181623.GB1889@1wt.eu>
References: <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190920134609.GA2113@pc>
 <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 11:09:53AM -0700, Linus Torvalds wrote:
(...)
> So:
> 
>  - GRND_INSECURE is (GRND_EXPLICIT | GRND_NONBLOCK)
> 
>    As in "I explicitly ask you not to just not ever block": urandom
> 
>  - GRND_SECURE_BLOCKING is (GRND_EXPLICIT | GRND_RANDOM)
> 
>    As in "I explicitly ask you for those secure random numbers"
> 
>  - GRND_SECURE_NONBLOCKING is (GRND_EXPLICIT | GRND_RANDOM | GRND_NONBLOCK)
> 
>    As in "I want explicitly secure random numbers, but return -EAGAIN
> if that would block".
> 
> Which are the three sane behaviors (that last one is useful for the "I
> can try to generate entropy if you don't have any" case. I'm not sure
> anybody will do it, but it definitely conceptually makes sense).
> 
> And I agree that your naming is better.
> 
> I had it as just "GRND_SECURE" for the blocking version, and
> "GRND_SECURE | GRND_NONBLOCK" for the "secure but return EAGAIN if you
> would need to block for entropy" version.
> 
> But explicitly stating the blockingness in the name makes it clearer
> to the people who just want GRND_INSECURE, and makes them realize that
> they don't want the blocking version.

I really like it this way. Explicit and full control for the application
plus reasonable backwards compatibility, it sounds pretty good.

Willy
