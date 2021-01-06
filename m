Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9072EBD8A
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 13:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAFMOm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 07:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFMOl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jan 2021 07:14:41 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2370C06134C;
        Wed,  6 Jan 2021 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hhn7h2Bv5IBKyAJWpK9Kw7hvMBzJpqWTLg0WG7IEIbY=; b=V4EED74ZMcOIKaqROh+V+NCOo
        NwwOYY80vrFvIksNxYUMi1OmRAe9/7xVTMqbzOeb+Iw1V1A94gZILUjx5+UlFIz/9luNilVMFhys6
        AHqRHrYDRJy++nogeJ7irfyoR0QhDuI3F/FJlL/8MElw4tETKabP8KvuIcVS7Wh64j2MufVhwzm+9
        m/hg+ibuPhpgDYP64Qix35Ynrp0GqubLBGMeqB0/sgt/wEcva/clb//EQ7+k4ipTDYs/ivTxHAx9H
        Soxw1yKVutwF6v2+VhgASdTTpkor2ZlYS2tS+5Pg2cHtfnwwVkR0bH8Vlh3dsLxU3s5GnMPFKk5oM
        Anhb4zjCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45178)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kx7hO-0001aV-Q8; Wed, 06 Jan 2021 12:13:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kx7hO-0000Dw-2P; Wed, 06 Jan 2021 12:13:58 +0000
Date:   Wed, 6 Jan 2021 12:13:58 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210106121357.GI1551@shell.armlinux.org.uk>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106115359.GB26994@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 06, 2021 at 11:53:59AM +0000, Mark Rutland wrote:
> On Tue, Jan 05, 2021 at 03:47:26PM +0000, Russell King - ARM Linux admin wrote:
> > Hi,
> 
> Hi Russell,
> 
> > This is an update on where I am with this long standing issue at the
> > current time.
> > 
> > Since 5.4, I have been struggling with several of my ARM64 systems, of
> > different SoC vendors and differing filesystem media, were sporadically
> > reporting inode checksum failures on their root filesystems.  The time
> > taken to report this has been anything between a few hours and three
> > months of uptime, making the problem unrealistic to bisect.
> 
> > However, over the last couple of days, a way to reproduce it has been
> > found, at least for the LX2160A based system.  Power down, leave the
> > machine powered off for some time. Power up, log in and run:
> > 
> > while :; do sleep 5; find /var /usr /bin /sbin -type f -print0 | \
> > 	xargs -0 md5sum >/dev/null; done
> 
> I've just set this off on an Raspberry Pi 4 running a locally-built
> arm64 v5.10 defconfig. I'm using a SATA SSD mounted via a USB-SATA
> adapter. I'll try to give that a few reboots see if I can reproduce the
> issue.

Will, Arnd and myself have been working on this since yesterday - we
_think_ it might have something to do with the clustering of the CPUs.
The LX2160A has 8 clusters of two CPUs. The Armada 8040 has two clusters
of two CPUs. RPi doesn't have clustering.

I've been able to reproduce it on the LX2160A with CPUs 0 and 15, or
CPUs 0 and 4. I haven't been able to reproduce it with CPUs 0 and 1.
However, contary to that, I haven't yet been able to reproduce it with
CPUs 0 and 2.

> Just to check -- how is your ext4 fs mounted? Mine is mounted as:
> 
>  /dev/sda2 on / type ext4 (rw,relatime,errors=remount-ro)

I've tried just plain "rw,errors=remount-ro" and the above.

Another bit of information I have just discovered - it's not Will's
commit. I reverted Will's commit, booted it on the gt8k system
yesterday. This morning, while checking the mount options there, I
noticed the rootfs had gone read only... checking the kernel log...

[45625.530075] provided = 41746cdc calculated = fb8b1ca1
[45625.533858] inode(ffffff82889d5600)
[45625.536090] 00000000: ff a1 00 00 0c 00 00 00 02 ac f3 5f e6 0b 55 5e
[45625.541269] 00000010: 52 cb d1 5c 00 00 00 00 00 00 01 00 00 00 00 00
[45625.546443] 00000020: 00 00 00 00 01 00 00 00 6d 71 5f 73 65 6e 64 2e
[45625.551618] 00000030: 33 2e 67 7a 00 00 00 00 00 00 00 00 00 00 00 00
[45625.556791] 00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.561965] 00000050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.567137] 00000060: 00 00 00 00 60 70 be da 00 00 00 00 00 00 00 00
[45625.572316] 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 dc 6c 00 00
[45625.577503] 00000080: 20 00 74 41 34 8e f5 52 00 00 00 00 00 38 9c 1c
[45625.582717] 00000090: e6 0b 55 5e 34 8e f5 52 00 00 00 00 00 00 00 00
[45625.587905] 000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.593083] 000000b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.598255] 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.603430] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.608618] 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.613795] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[45625.618968] recalculated = fb8b1ca1
[45625.621179] EXT4-fs error (device mmcblk0p1): ext4_lookup:1707: inode #149495: comm mandb: iget: checksum invalid

debugfs:  stat <149495>
stat: Inode checksum does not match inode while reading inode 149495

Okay, so the data in memory is incorrect...

# dd if=/dev/mmcblk0p1 bs=4096 count=1 skip=525567 | hexdump -C |less
00000600  ff a1 00 00 0c 00 00 00  02 ac f3 5f e6 0b 55 5e  |..........._..U^|
00000610  52 cb d1 5c 00 00 00 00  00 00 01 00 00 00 00 00  |R..\............|
00000620  00 00 00 00 01 00 00 00  6d 71 5f 73 65 6e 64 2e  |........mq_send.|
00000630  33 2e 67 7a 00 00 00 00  00 00 00 00 00 00 00 00  |3.gz............|
00000640  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000660  00 00 00 00 60 70 be da  00 00 00 00 00 00 00 00  |....`p..........|
00000670  00 00 00 00 00 00 00 00  00 00 00 00 dc 6c 00 00  |.............l..|
00000680  20 00 74 41 34 8e f5 52  00 00 00 00 00 38 9c 1c  | .tA4..R.....8..|
00000690  e6 0b 55 5e 34 8e f5 52  00 00 00 00 00 00 00 00  |..U^4..R........|
000006a0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
# echo 1 > /proc/sys/vm/drop_caches
# debugfs /dev/mmcblk0p1
debugfs 1.44.5 (15-Dec-2018)
/dev/mmcblk0p1: Inode bitmap checksum does not match bitmap while reading allocation bitmaps
# e2fsck -n /dev/mmcblk0p1
e2fsck 1.44.5 (15-Dec-2018)
Warning: skipping journal recovery because doing a read-only filesystem
check.
/dev/mmcblk0p1 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Inode 149495 passes checks, but checksum does not match inode.  Fix? no

So in this case, it looks like the inode has been written back to media
with a bad checksum... which is new.

> ... and are you using defconfig or something else?

Definitely "something else".

> > It is possible that it could be compiler related, but I don't see that;
> > if the "dmb oshld" were strong enough, then it should mean that the
> > subsequent reads to checksum the inode data after the inode data has
> > been DMA'd into memory should be reading the correct values from memory
> > already - but they aren't. And if changing "dmb oshld" to "dsb ld" means
> > that the code can then read the right values, that to me points fairly
> > definitively to a hardware problem.
> 
> Just in case the compiler has some impact, can you way which compilers
> you've been using? On the rpi4 I'm using GCC 8.3.0 as packaged by Debian
> Buster (10.7).

I've used 4.9.2 and then switched to 4.9.4. Will has built a kernel
using 4.9.4 which I'm about to try on the lx2160a.

I do _not_ want to try a later compiler and have this problem "vanish".
We will not know whether the problem has been hidden by different code
generation, but still actually exists.

As I've said, my confidence level with Aarch64 as a viable archtecture
is at rock bottom right now, and a definitive explanation needs to be
found for this, otherwise I'm going to dispose of *all* my Aarch64
hardware - I have no confidence anymore that the architecture is
capable of operating safely with modern Linux kernels, and I'd rather
use x86 instead right now. Yes, it this is _that_ serious a problem
for me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
