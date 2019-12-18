Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258C91244C2
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2019 11:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLRKgJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Dec 2019 05:36:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36692 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRKgJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Dec 2019 05:36:09 -0500
Received: by mail-io1-f66.google.com with SMTP id r13so1460693ioa.3
        for <linux-ext4@vger.kernel.org>; Wed, 18 Dec 2019 02:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U3jEGHtb3w50W6Jn+xdIwX2l6lLYn/EUOtJFexkl8oQ=;
        b=qzycaesUT+R8xyjL4SxqFdJ08QmazN7hLtpYgoC5qAHUgeohppV9x7IqsU6nSwDUcT
         UoYrqpQGod9cit8mEAkF92XE50tLkZe7oGEALdL3uaiAjRoq5MWU+5ppUzqkNnAJwHXm
         pqgAQR8a2LZSPpJ0c1phtz/h87lB9/PHCxOaGv5dmbyypEd1JL/tHBcHqR8ovD+t2pdF
         idA3a/EoqfEeYVRWS0Ch+9SIMGVj+liWUlFGKQ5e2oE46I45Yvf7jpeT3+ipFvRfPvRA
         3eiTRVH82hULKVYE5Lr6EEfcEmvK+6vR1sEWLFtc6xm1l5Lz1Hg8UZbXE5//PSyEu5nK
         aZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U3jEGHtb3w50W6Jn+xdIwX2l6lLYn/EUOtJFexkl8oQ=;
        b=dH7J3rOT6LqSOBhcR2mHgfzfiBgZOyOWj4/OQ1ivDbYWK81GW4mhYx2QOhoX2aegZX
         4ITeN1EPsq7fulhQ28KUu5RcLWBbWEzMSqG9XxgHJpoybdE0PADbyoIuH5IBEAbM3nkp
         6EUkegD1U/lhk6/PvKUnSljFCuaQ4JeMYeSMC2p+n8Vm8JoE9SV2ETvUkc6MhDQr5+My
         7oSPQKgVyPUPssVsELKtHWichMIufOTTKImz8u23bGYChJgg/+pFjb5k3G8Z3vl/bocp
         Hm2ogD4nmLMSj1IUWJba0e/Dqn3Y5ekNuP5XutCYSD0q1SEGXaY+UfjT9qVx8eTH6/95
         u8DA==
X-Gm-Message-State: APjAAAWoDxRkest1AgHNypA3Dzhuw1JOr5Z3wKk7gv9OQ2WiMpZuObDH
        e2TuGWomB4vQWgpN8jfPGAP5P7HDzcFCcb3JVTjcBDkQ/64=
X-Google-Smtp-Source: APXvYqw3KfKtVJFt8JWOshGyOBhTa1PGh49YzyxXZBhzrSWoRq4hpGvJBNMFegOiH/Ak+8+qFfWtMKV3sJTz3cuOxhs=
X-Received: by 2002:a05:6602:101:: with SMTP id s1mr1066346iot.262.1576665367782;
 Wed, 18 Dec 2019 02:36:07 -0800 (PST)
MIME-Version: 1.0
References: <CAMoswejffB4ys=2C5zL_j9SBrdka8MJWV3hpwber9cggo=1GQQ@mail.gmail.com>
 <20191213155912.GH15474@quack2.suse.cz> <CAMoswegmo08i-7TMpbM7x=RHiRsu-g40Vq2wmPzYsx7=gCi5MA@mail.gmail.com>
 <20191218083301.GA4083@quack2.suse.cz>
In-Reply-To: <20191218083301.GA4083@quack2.suse.cz>
From:   Paul Richards <paul.richards@gmail.com>
Date:   Wed, 18 Dec 2019 10:35:56 +0000
Message-ID: <CAMoswejK1bySFnT42aEA8e-MphktZzGLzr9WK0kkxBmg=3+Kng@mail.gmail.com>
Subject: Re: Query about ext4 commit interval vs dirty_expire_centisecs
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I found it here:
https://www.kernel.org/doc/Documentation/filesystems/ext4.txt

I think this might be the source, but I'm not sure:
https://github.com/torvalds/linux/blame/master/Documentation/admin-guide/ex=
t4.rst#L185-L187

While searching for this I also found a copy of the same `commit`
documentation here:
https://github.com/torvalds/linux/blob/master/Documentation/filesystems/ocf=
s2.txt
I don't know if the same correction should be made for ocfs2 or not.



On Wed, 18 Dec 2019 at 08:33, Jan Kara <jack@suse.cz> wrote:
>
> On Tue 17-12-19 14:42:48, Paul Richards wrote:
> > On Fri, 13 Dec 2019 at 15:59, Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello!
> > >
> > > On Tue 19-11-19 08:47:31, Paul Richards wrote:
> > > > I'm trying to understand the interaction between the ext4 `commit`
> > > > interval option, and the `vm.dirty_expire_centisecs` tuneable.
> > > >
> > > > The ext4 `commit` documentation says:
> > > >
> > > > > Ext4 can be told to sync all its data and metadata every 'nrsec' =
seconds. The default value is 5 seconds. This means that if you lose your p=
ower, you will lose as much as the latest 5 seconds of work (your filesyste=
m will not be damaged though, thanks to the journaling).
> > > >
> > > > The `dirty_expire_centisecs` documentation says:
> > > >
> > > > > This tunable is used to define when dirty data is old enough to b=
e eligible for writeout by the kernel flusher threads. It is expressed in 1=
00'ths of a second. Data which has been dirty in-memory for longer than thi=
s interval will be written out next time a flusher thread wakes up.
> > > >
> > > >
> > > > Superficially these sound like they have a very similar effect.  Th=
ey
> > > > periodically flush out data that hasn't been explicitly fsync'd by =
the
> > > > application.  I'd like to understand a bit more the interaction
> > > > between these.
> > >
> > > Yes, the effect is rather similar but not quite the same. The first t=
hing
> > > to observe is kind of obvious fact that ext4 commit interval influenc=
es
> > > just the particular filesystem while dirty_expire_centisecs influence=
s
> > > behavior of global writeback over all filesystems.
> > >
> > > Secondly, commit interval is really the maximum age of ext4 transatio=
n.  So
> > > if there is metadata change pending in the journal, it will become
> > > persistent at latest after this time. So for say 'mkdir' that will be
> > > persistent at latest after this time. For data operations things are =
more
> > > complex. E.g. when delayed allocation is used (which is the default),=
 the
> > > change gets logged in the journal only during writeback. So it can ta=
ke up
> > > to dirty_expire_centisecs for data to be written back from page cache=
, that
> > > results in filesystem journalling block allocations etc. and then it =
can
> > > take upto commit interval for these changes to become persistent. So =
in
> > > this case the intervals add up. There are also other special cases
> > > somewhere in between but generally it is reasonable to assume that da=
ta gets
> > > automatically persistent in dirty_expire_centisecs + commit_interval =
time.
> > > Note both these times are actually times when writeback is triggered =
so
> > > if the disk gets too busy, the actual time when data is completely on=
 disk
> > > may be much higher.
> > >
> >
> > Thanks for taking the time to reply!
> >
> > Since automatic persisting of data occurs only after
> > dirty_expire_centisecs + commit_interval,
> > should the ext4 docs be corrected?  They currently state (for the
> > commit interval option):
> >
> > "The default value is 5 seconds. This means that if you lose
> > your power, you will lose as much as the latest 5 seconds of work"
>
> Yes, probably that should be clarified. Where did you find this wording?
> Because my ext4 manpage just states:
>
>         commit=3Dnrsec
>               Start  a  journal commit every nrsec seconds.  The default =
value
>               is 5 seconds.  Zero means default.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
