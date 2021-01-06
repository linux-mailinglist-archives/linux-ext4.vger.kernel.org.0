Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955D62EBD56
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 12:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbhAFLyu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 06:54:50 -0500
Received: from foss.arm.com ([217.140.110.172]:39960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAFLyu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Jan 2021 06:54:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5546BD6E;
        Wed,  6 Jan 2021 03:54:04 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75E0C3F70D;
        Wed,  6 Jan 2021 03:54:02 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:53:59 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210106115359.GB26994@C02TD0UTHF1T.local>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105154726.GD1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 05, 2021 at 03:47:26PM +0000, Russell King - ARM Linux admin wrote:
> Hi,

Hi Russell,

> This is an update on where I am with this long standing issue at the
> current time.
> 
> Since 5.4, I have been struggling with several of my ARM64 systems, of
> different SoC vendors and differing filesystem media, were sporadically
> reporting inode checksum failures on their root filesystems.  The time
> taken to report this has been anything between a few hours and three
> months of uptime, making the problem unrealistic to bisect.

> However, over the last couple of days, a way to reproduce it has been
> found, at least for the LX2160A based system.  Power down, leave the
> machine powered off for some time. Power up, log in and run:
> 
> while :; do sleep 5; find /var /usr /bin /sbin -type f -print0 | \
> 	xargs -0 md5sum >/dev/null; done

I've just set this off on an Raspberry Pi 4 running a locally-built
arm64 v5.10 defconfig. I'm using a SATA SSD mounted via a USB-SATA
adapter. I'll try to give that a few reboots see if I can reproduce the
issue.

Just to check -- how is your ext4 fs mounted? Mine is mounted as:

 /dev/sda2 on / type ext4 (rw,relatime,errors=remount-ro)

... and are you using defconfig or something else?

[...]

> It is possible that it could be compiler related, but I don't see that;
> if the "dmb oshld" were strong enough, then it should mean that the
> subsequent reads to checksum the inode data after the inode data has
> been DMA'd into memory should be reading the correct values from memory
> already - but they aren't. And if changing "dmb oshld" to "dsb ld" means
> that the code can then read the right values, that to me points fairly
> definitively to a hardware problem.

Just in case the compiler has some impact, can you way which compilers
you've been using? On the rpi4 I'm using GCC 8.3.0 as packaged by Debian
Buster (10.7).

Thanks,
Mark.
