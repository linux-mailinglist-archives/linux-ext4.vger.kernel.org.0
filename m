Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7172EF8FF
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbhAHUXR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 15:23:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbhAHUXQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 8 Jan 2021 15:23:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3FC723AC2;
        Fri,  8 Jan 2021 20:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610137355;
        bh=eaVy/h1sqS72eojXpxZdrAkyp/2+sHG6P9GrVWKTzf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jDtcPFPT0sAh3JVCRwf39s1NaB8Sw80GSm3jJCWgg+Qiv8paW/ZpBb2arPhI2wrA2
         Z7aRP6OfCwaFuRJp0PxaG9pa8+mJt+zeJJlFZaTUU3vAursh8I1Bo7skbLBgQ3tdqs
         ubvSITIFfNJLZzEYTr7scbKMKnmtD9qJ9bM7udSotn/pIo2isSJH2kuQAWhTxgomVw
         3e5ZUeU7XzoTk/C7GXeQl5Z1Xtg6F33Qy9o+PktmY1po4X11WzEfHrjdYcwQaID5Ch
         Qpcwtq1RtGGb/NlZ2W4z7IHqbsuCBRUemTSMHvRvBBwYnWg37kxKsSmBJGa3w/n4lQ
         TTIIW5OFOuNtg==
Received: by mail-oi1-f170.google.com with SMTP id p5so12732154oif.7;
        Fri, 08 Jan 2021 12:22:35 -0800 (PST)
X-Gm-Message-State: AOAM5309mQGJFCtHtMvOihiPQfANNluwAi3kPo16x9Ddsinz8PDxo/iv
        OzD/jhdipklGv7j1hVFdfRr87ZCAAOOCG4QgDyo=
X-Google-Smtp-Source: ABdhPJwVTMd3FygXgJ3u5lYNHsXmgTpMPMS6Ohlq8w/Sp951W2jKYng2WW7Hs1gngp0AbUAXySzAfu0RQUSAdgliM64=
X-Received: by 2002:aca:e103:: with SMTP id y3mr3288783oig.11.1610137355049;
 Fri, 08 Jan 2021 12:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20210106115359.GB26994@C02TD0UTHF1T.local> <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck> <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk> <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net> <20210108092655.GA4031@willie-the-truck>
 <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
In-Reply-To: <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 8 Jan 2021 21:22:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2w2u8pcQJue3OveDckJNkGmwzVdfOM-VEXShQEw8EOzw@mail.gmail.com>
Message-ID: <CAK8P3a2w2u8pcQJue3OveDckJNkGmwzVdfOM-VEXShQEw8EOzw@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 8, 2021 at 9:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jan 8, 2021 at 1:27 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Fri, Jan 08, 2021 at 10:21:54AM +0100, Peter Zijlstra wrote:
> > > On Thu, Jan 07, 2021 at 10:20:38PM +0100, Arnd Bergmann wrote:
> > > > On Thu, Jan 7, 2021 at 2:37 PM Russell King - ARM Linux admin
>
> I appreciate Arnd pointing out "--std=gnu11", though. What are the
> actual relevant language improvements?
>
> Variable declarations in for-loops is the only one I can think of. I
> think that would clean up some code (and some macros), but might not
> be compelling on its own.

I think that was the main one, as most of --std=c11 is already part
of --std=gnu89 as a gnu extension. There were a few things that
came up with clang porting, as clang is somewhat closer to gnu11
than to gnu89, but I don't remember exactly what that was.

I would still like to improve READ_ONCE()/get_user()/cmpxchg()
further using __auto_type and _Generic where possible, but I think
that was already supported in gcc-4.9, and does not require gcc-5.

       Arnd
