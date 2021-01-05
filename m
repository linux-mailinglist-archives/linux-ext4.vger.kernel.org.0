Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356B72EB3A6
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 20:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbhAETuw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 14:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbhAETuw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 14:50:52 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5986C061574;
        Tue,  5 Jan 2021 11:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2SA4On2cMEQmGU3kQif37fkiQENV5j3AnGco184NuZA=; b=fr7FIGSzKDbNyTcjkot1pHw5j
        OAnTLPUbM4YHI1cNriv9I5CHeaTWMQ/fD/NaMButt5fI6KE0aVmXOpYLwp5BiwnstJFbEBqFXM6fn
        1SGbjpe33dnJzvCypv9BcEjPd5gtGlXYQG4xbJGk76HzxYyN29b3oHGFNbs9gSyHsL/+vVOf4FrmD
        4h1SMOj85/9jyH9TVKe4OZuZMxGewidIS0PgqkmtspZ1jKqYjI2eCArKVbaAUUXrL3+ZUiu2vpLIQ
        DT6LCWc0SrFZLoxqCNF3HOF+Nowup4hMDCpX+MFCf/zA3zT+biSLJL6zjphX9zEzzhwQY0h9jcaFS
        psZKeAeuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45156)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kwsLH-00014k-Ra; Tue, 05 Jan 2021 19:50:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kwsLE-0007zN-UF; Tue, 05 Jan 2021 19:50:04 +0000
Date:   Tue, 5 Jan 2021 19:50:04 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210105195004.GF1551@shell.armlinux.org.uk>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210105182728.GG6908@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105182728.GG6908@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 05, 2021 at 10:27:28AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 05, 2021 at 03:47:26PM +0000, Russell King - ARM Linux admin wrote:
> > Hi,
> > 
> > This is an update on where I am with this long standing issue at the
> > current time.
> > 
> > Since 5.4, I have been struggling with several of my ARM64 systems, of
> > different SoC vendors and differing filesystem media, were sporadically
> > reporting inode checksum failures on their root filesystems.  The time
> > taken to report this has been anything between a few hours and three
> > months of uptime, making the problem unrealistic to bisect.
> 
> Aha, I was wondering what happened to this bug report. :)

Yes... it's continued causing me grief!

> > The issue was first seen on my SolidRun Clearfog CX LX2160A based
> > system, but was also subsequently noticed on my Armada 8040 based
> > systems running kernels 5.4 and later. Kernel 5.2 has proven stable
> > with 566 days of uptime with no issue.
> > 
> > It has taken a long time to get debugging in place to see what is going
> > on - and this is currently detailed on the front page of
> > www.armlinux.org.uk right now, which has formed a blog of this problem
> > - since almost no one has taken any interest in it.
> > 
> > However, over the last couple of days, a way to reproduce it has been
> > found, at least for the LX2160A based system.  Power down, leave the
> > machine powered off for some time. Power up, log in and run:
> > 
> > while :; do sleep 5; find /var /usr /bin /sbin -type f -print0 | \
> > 	xargs -0 md5sum >/dev/null; done
> 
> Does that fill up the page cache enough to push memory reclaim?

No - I have around 30GB of memory available on the LX2160A system, and
around 3GB that the above is crunching through.

> > Within a few minutes it seems to have spat out an inode checksum
> > failure if the problem exists. However, testing for the problem _not_
> > existing is quite difficult - just because it doesn't appear in the
> > first few minutes does not mean it has been solved - see above where it
> > can take three months.
> > 
> > However, evidence is currently pointing towards commit 22ec71615d82
> > ("arm64: io: Relax implicit barriers in default I/O accessors") having
> > revealed this problem. Will is very certain that this change is
> > correct, and we feel that it may have exposed some other issue in the
> > Aarch64 code.
> > 
> > Further attempts seem to suggest that the problem is specifically the
> > barrier in __iormb(). Leaving __iowmb() untouched, and changing the
> > barrier in __iormb() from dma_rmb() to rmb() _appears_ to result in the
> > problem disappearing. "Appears" is stressed because further testing is
> > needed - and that is probably going to take many months before we know
> > for certain.
> > 
> > However, this suggests that there is a memory ordering bug with aarch64
> > somewhere. Will can follow up with his own thoughts to this email.
> > 
> > We don't know if it is:
> > - the kernel.
> > - the Cortex A72.
> > - the Cache coherent interconnect.
> > 
> > I don't think it's the CCI, as I believe the Armada 8040 uses Marvell's
> > own IP for that based around Aurora 2 (the functional spec doesn't make
> > it clear.) Remember, I'm seeing this problem on both Armada 8040 and
> > LX2160A. We don't know of any known errata for the A72 in this area.
> > So, we're down to something in the kernel.
> > 
> > It is possible that it could be compiler related, but I don't see that;
> > if the "dmb oshld" were strong enough, then it should mean that the
> > subsequent reads to checksum the inode data after the inode data has
> > been DMA'd into memory should be reading the correct values from memory
> > already - but they aren't. And if changing "dmb oshld" to "dsb ld" means
> > that the code can then read the right values, that to me points fairly
> > definitively to a hardware problem.
> > 
> > Now, ext4fs is pretty good at checksumming the metadata in the
> > filesystem - each inode is individually checksummed with CRC32C and two
> > 16-bit halves are stored in each inode. Directories are also
> > checksummed. ext4fs validates the inode checksum on every ext4_iget()
> > call. Do other filesystems do similar?
> 
> XFS and ext4 both validate the ondisk csum when constructing their
> incore inodes, and set them when flushing the incore inode back to disk.
> 
> I vaguely wonder if there's something else going on here, like ... a
> background memory reclaim thread running on one cpu writes out an inode
> core with new checksum (because reading the file bumped the atime), and
> then another cpu comes along and has to reconstitute the (just
> reclaimed) incore inode, but for whatever reason doesn't get the version
> that the other cpu just wrote?
> 
> That's like 130% speculative though, and note that I have no idea what
> the "outer shareable" domain[1] is.
> 
> [1] https://developer.arm.com/docs/ddi0597/h/base-instructions-alphabetic-order/dmb-data-memory-barrier

In some of these cases I have observed, the inode appears not to have
changed for quite a long time - it seems to be "media read due to
iget -> checksum failure", although I can't say that definitively.

Given that most of the instances I've been able to provoke over the last
two days have been on the LX2160A, and have been a case of "power on
from cold, boot, login, run the above command, it fails on the first
iteration", it's unlikely that there's much in the way of inode
modification going on.

I've had a few instances now where, for example:

provided = 4b98d7c4 calculated = 5cec3c81
inode(ffffffa6d4dd9c00)
00000000: a4 81 00 00 41 0a 00 00 03 57 f3 5f 25 18 fd 5d
00000010: 70 57 fe 5a 00 00 00 00 00 00 01 00 08 00 00 00
00000020: 00 00 08 00 01 00 00 00 0a f3 01 00 04 00 00 00
00000030: 00 00 00 00 00 00 00 00 01 00 00 00 36 14 11 00
00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000060: 00 00 00 00 1a f4 40 7c 00 00 00 00 00 00 00 00
00000070: 00 00 00 00 00 00 00 00 00 00 00 00 c4 d7 00 00
00000080: 20 00 98 4b a8 c9 54 61 00 00 00 00 40 58 34 9f
00000090: 25 18 fd 5d a8 c9 54 61 00 00 00 00 00 00 00 00
000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
recalculated = 5cec3c81
EXT4-fs error (device nvme0n1p2): ext4_lookup:1707: inode #270077: comm md5sum: iget: checksum invalid

The reason this is interesting is that the hexdump is _correct_ for
the stored checksum (which is 0x4b98d7c4 - stored at hex offsets +83,
+82, +7d, +7c). However, the initial calculation when validating the
inode was incorrect, and the recalculation after dumping the data was
_also_ incorrect.

As mentioned on my writeup on www.armlinux.org.uk (please read it,
there's lots of information there about the history of this and what
has been tried, including the patch for the above output, and I don't
want to keep having to repeat it in emails as different people ask
the same question!) I've already tried disabling the ARM64 accelerated
CRC32 code, and that has made no difference to this problem.

One thing I have recently been trying is to disable preemption within
ext4_inode_csum_verify() - that _seems_ to make it much harder to
reproduce the problem. I've managed it only once despite trying
multiple times. Unfortunately, the filesystem was not mounted
errors=remount-ro, so I couldn't verify the hexdump.

I'm also trying booting with maxcpus=2, so that the kernel is limited
to a single CPU cluster. So far, I haven't been able to provoke the
problem. However, this means absolutely nothing, as past experience
has shown it may take up to three months to occur.

> > Anyway, here is the patch I'm currently running, which _seems_ so far
> > to be the minimal fix for my problems. Will thinks that this is hiding
> > the real problem by adding barriers, but I don't see there's much
> > choice but to apply this - I don't see what other debugging could be
> > done without the use of expensive hardware simulation, or detailed
> > hardware level tracing - the kind of which a silicon vendor or ARM Ltd
> > would have.
> 
> (FWIW I haven't seen checksum errors on xfs or ext4 on arm64, though
> most of my testing is relegated to beating on a raspberry pi very
> slowly...)

There's a thought that this problem could have something to do with
migrating across CPUs in different clusters (hence why trying
maxcpus=2). The LX2160A has 16 CPUs - 8 clusters of 2 CPUs. The Armada
8040 has 2 clusters of 2 CPUs. As I understand it, the bcm2711 has four
CPUs which aren't separated into clusters.

This may explain why, /if/ ext4_inode_csum_verify() migrating between
the clusters is important to trigger this, it hasn't been seen on any
Raspberry Pis (I'm also told that Raspbian defaults to 32-bit kernels
which may be another factor why there haven't been people reporting
this.)

> > I'm at the end of what I can do with this; I'm going to keep this patch
> > in my kernel, since it fixes it for me.
> 
> Well if you've managed to hit this on multiple different machines after
> a long soak time, I wonder how many other people will trip over this too.
> It wouldn't be the first time a fs stunts performance to avoid
> corruption. ;)

Well, replacing the __iormb() barrier with a dsb appears to either solve
the problem or make it much less likely to happen - although Will Deacon
feels that this is plastering over the problem, and it will come back to
bite in the future.

However, I have put a kernel on one of the affected systems (which is a
long-running system) that revert's Will's 22ec71615d82 commit I mention
above. This /was/ the situation before 5.4-rc1, and it seems to allow
these platforms to work. If that proves to be stable in six months time,
and there has been no other progress on this bug, then as far as I'm
concerned, that is quite simply the required fix for this.

Quite simply, I've given up with Aarch64 over the last year over this;
it doesn't interest me at the moment - not even for development of
other stuff - as fundamentally I have had my trust in it totally
shattered.  ARM32 is clearly the superior architecture! :)

> > Will would like a reliable reproducer - yes, that would be ideal, but
> > I'm afraid that's a mamoth task in itself. It's taken a year to find
> > this method of reproducing it.
> > 
> > There's also the matter that in one case I've seen, the ext4 checksum
> > has been wrong. The subsequent hexdump has been correct, and the post-
> > hexdump checksum recalculation has remained incorrect - and the same
> > value as the first incorrect checksum. However, the inode with the
> > _same_ checksum has subsequently validated correctly by the kernel and
> > by e2fsck. I can not explain this.
> 
> Strange.  You're just using the same ext4_inode_csum() that everything
> else uses, right?

Yes, except for the patch to dump out a hexdump of the inode on
checksum failure and to then recalculate it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
