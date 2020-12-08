Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC72D303A
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgLHQxF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 11:53:05 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36239 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730439AbgLHQxE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 11:53:04 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B8GqESk012309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Dec 2020 11:52:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6CDE7420136; Tue,  8 Dec 2020 11:52:14 -0500 (EST)
Date:   Tue, 8 Dec 2020 11:52:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Michael Walle <michael@walle.cc>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-ext4@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
Message-ID: <20201208165214.GD52960@mit.edu>
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
 <20201207183534.GA52960@mit.edu>
 <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc>
 <20201208024057.GC52960@mit.edu>
 <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com>
 <d7041bbb403698ac1097f7740f364467@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7041bbb403698ac1097f7740f364467@walle.cc>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 08, 2020 at 12:26:22PM +0100, Michael Walle wrote:
> Do we really need to map these functions? What if we don't have an
> actual discard, but just a slow erase (I'm now assuming that erase
> will likely be slow on sdcards)? Can't we just tell the user space
> there is no discard? Like on a normal HDD? I really don't know the
> implications, seems like mmc_erase() is just there for the linux
> discard feature.

So the potential gotcha here is that "discard" is important for
reducing write amplification, and thus improving the lifespan of
devices.  (See my reference to the Tesla engine controller story
earlier.)  So if a device doesn't have "discard" but has "erase", and
"erase" is fast, then skipping the discard could end up significantly
reducing the lifespan of your product, and we're back to the NHTSA
investigating whether they should stick Tesla for the $1500 engine
controller replacement when cards die early.

I guess the JEDEC spec does specify a way to query the card for how
long an erase takes, but I don't have the knowledge about how the
actual real-world implementations of these specs (and their many
variants over the years) actually behave.  Can the erase times that
they advertise actually be trusted to be accurate?  How many of them
actually supply erase times at all, no matter what the spec says?

> Coming from the user space side. Does mkfs.ext4 assumes its pre-discard
> is fast? I'd think so, right? I'd presume it was intented to tell the
> FTL of the block device, "hey these blocks are unused, you can do some
> wear leveling with them".

Yes, the assumption is that discard is fast.  Exactly how fast seems
to vary; this is one of the reasons why there are three different ways
to do discards on a file system after files are deleted.  One way is
to do them after the deleted definitely won't be unwound (i.e., after
the ext4 journal commit).  But on some devices, the discard command,
while fast, is slow enough that this will compete with the I/O
completion times of other read commands, thus degrading system
performance.  So you can also execute the trim commands out of cron,
using the fstrim command, which will run the discards in the
background, and the system administrator can adjust when fstrim is
executed during times wheno performance isn't critical.  (e.g., when
the phone is on a charger in the middle of the night, or at 4am local
time, etc.)  Finally, you can configure e2fsck to run the discards
after the file system consistency check is done.

The reason why we have to leave this up to the system administrators
is that we have essentially no guidance from the device how slow the
discard command might be, how it intereferes with other device
operations, and whether the discard might be more likely ignored if
the device is busy.  So it might be that the discard will more likely
improve write endurance when it is done when the device is idle.  All
of the speccs (SCSI, SATA, UFS, eMMC, SD) are remarkable unhelpful
because performance considerations is generally consider "out of
scope" of standards committees.  They want to leave that up to market
forces; which is why big companies (at handset vendors, hyperscale
cloud providers, systems integrators, etc.) have to spend as much
money doing certification testing before deciding which products to
buy; think of it as a full-employment act for storage engineers.  :-)

But yes, mke2fs assumes that discard is sufficiently fast that it
doing it at file system format time is extremely reasonable.  The
bigger concern is that we can't necessarily count on discard zero'ing
the inode table, and there are robustness reasons (especially if
before we had metadata checksums) where it makes file system repairs
much more robust if the inode table is zero'ed ahead of time.

> I'm just about finding some SD cards and looking how they behave timing
> wise and what they report they support (ie. erase or discard). Looks
> like other cards are doing better. But I'd have to find out if they
> support the discard (mine doesn't) and if they are slow too if I force
> them to use the normal erase.

The challenge is that this sort of thing gets rapidly out of date, and
it's not just SD cards but also eMMC devices which are built into
various embedded devices, high-end SDHC cards, etc., etc.  So doing
this gets very expensive.

That being said, both ext4 and f2fs do pre-discards as part of the
format step, since improving write endurance is important; customers
get cranky when their $1000 smart phones die an early death.  So an SD
card that behaves the way yours does would probably get disqualified
very early in the certification step if it were ever intended to be
used in an Android handset, since pretty much all Android devices, or
embedded devices for that matter, use either f2fs or ext4.  That's one
of the reasons why I was a bit surprised that your device had such an
"interesting" performance profile.  Maybe it was intended for use in
digital cameras, and digital camerase don't issue discards?  I don't
know....

> > I agree, these are the three levels that make sense to support.
> > 
> > Honestly I haven't been paying enough attention to discussions for the
> > generic block layer around discards. However, considering what you
> > just stated above, we seem to be missing one request operation, don't
> > we?

Yes, that's true.  We only have "discard" and "secure discard".  Part
of that is because that's the only levels which are available for
SSD's, for which I have the same general complaint vis-a-vis standards
committees and the general lack of usefulness for file system
engineers.

For example, pretty much everyone in the enterprise and hyperscale
cloud world assume that low-numbered LBA's have better performance
profiles, and are located physically at the outer diameter of HDD's,
compared to high-number'ed LBA's.  But that's nothing which is
specified by the standards committees, because "performance
considerations are out of scope".  Yet we still have to engineer
storage systems which assume this to be true, even though nothing in
the formal specs guarantees this.  We just have to trust that anyone
who tries to sell a HDD for which this isn't true, even if it is
"standards complaint", is going to have a bad time, and trust that
this is enough.  (Perhaps this is why when a certain HDD manufacturer
tried to sell HDD's containing drive-managed SMR for the NAS market,
without disclosing this fact to consumers, this generated a massive
backlash....  Simply being standards compliant is not enough.)

					- Ted
