Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F72EB2A2
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbhAESan (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 13:30:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57354 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbhAESam (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 13:30:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105IMPPB017456;
        Tue, 5 Jan 2021 18:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zleZhLDJdlixTgQ8PwGfwy0XN/UPjFt/4pghSoy56Qc=;
 b=pWbkeA4AbyU5DAYZ6oi9cCS1sVIuc/0pjPFZj/8pzed31x4EhwSzClnMe3K0rEr5TdLj
 WcsFBmjYYxyVQIo1qezrnkGwmJdTCa75njypoy6h436wxzNZzmMhL8Pb3c9DAu2UJZv6
 u8IYbtGoUJSxwLRfCxf5yYm5p3lmkTjAy/0A8TuT97UWKM/H7KabJLULv8HlDc0nY7af
 1QYdTouXwQtoga/oxE1EDmDB+sSkn5uJ2p/FC1Xl+zSwfuvzRapYVuVNMqO47+4xwjZI
 VN3oj5ZsTuZ8MAInU8akB8TjpuWjse9ClOucf/imiy9MpKnyTEkwwHr+kSsrn0Z6nX/C YA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35tg8r25vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 18:29:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105IEl2n045646;
        Tue, 5 Jan 2021 18:27:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35v1f8wvcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 18:27:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 105IRTPb015020;
        Tue, 5 Jan 2021 18:27:29 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 18:27:29 +0000
Date:   Tue, 5 Jan 2021 10:27:28 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210105182728.GG6908@magnolia>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105154726.GD1551@shell.armlinux.org.uk>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050107
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 05, 2021 at 03:47:26PM +0000, Russell King - ARM Linux admin wrote:
> Hi,
> 
> This is an update on where I am with this long standing issue at the
> current time.
> 
> Since 5.4, I have been struggling with several of my ARM64 systems, of
> different SoC vendors and differing filesystem media, were sporadically
> reporting inode checksum failures on their root filesystems.  The time
> taken to report this has been anything between a few hours and three
> months of uptime, making the problem unrealistic to bisect.

Aha, I was wondering what happened to this bug report. :)

> The issue was first seen on my SolidRun Clearfog CX LX2160A based
> system, but was also subsequently noticed on my Armada 8040 based
> systems running kernels 5.4 and later. Kernel 5.2 has proven stable
> with 566 days of uptime with no issue.
> 
> It has taken a long time to get debugging in place to see what is going
> on - and this is currently detailed on the front page of
> www.armlinux.org.uk right now, which has formed a blog of this problem
> - since almost no one has taken any interest in it.
> 
> However, over the last couple of days, a way to reproduce it has been
> found, at least for the LX2160A based system.  Power down, leave the
> machine powered off for some time. Power up, log in and run:
> 
> while :; do sleep 5; find /var /usr /bin /sbin -type f -print0 | \
> 	xargs -0 md5sum >/dev/null; done

Does that fill up the page cache enough to push memory reclaim?

> Within a few minutes it seems to have spat out an inode checksum
> failure if the problem exists. However, testing for the problem _not_
> existing is quite difficult - just because it doesn't appear in the
> first few minutes does not mean it has been solved - see above where it
> can take three months.
> 
> However, evidence is currently pointing towards commit 22ec71615d82
> ("arm64: io: Relax implicit barriers in default I/O accessors") having
> revealed this problem. Will is very certain that this change is
> correct, and we feel that it may have exposed some other issue in the
> Aarch64 code.
> 
> Further attempts seem to suggest that the problem is specifically the
> barrier in __iormb(). Leaving __iowmb() untouched, and changing the
> barrier in __iormb() from dma_rmb() to rmb() _appears_ to result in the
> problem disappearing. "Appears" is stressed because further testing is
> needed - and that is probably going to take many months before we know
> for certain.
> 
> However, this suggests that there is a memory ordering bug with aarch64
> somewhere. Will can follow up with his own thoughts to this email.
> 
> We don't know if it is:
> - the kernel.
> - the Cortex A72.
> - the Cache coherent interconnect.
> 
> I don't think it's the CCI, as I believe the Armada 8040 uses Marvell's
> own IP for that based around Aurora 2 (the functional spec doesn't make
> it clear.) Remember, I'm seeing this problem on both Armada 8040 and
> LX2160A. We don't know of any known errata for the A72 in this area.
> So, we're down to something in the kernel.
> 
> It is possible that it could be compiler related, but I don't see that;
> if the "dmb oshld" were strong enough, then it should mean that the
> subsequent reads to checksum the inode data after the inode data has
> been DMA'd into memory should be reading the correct values from memory
> already - but they aren't. And if changing "dmb oshld" to "dsb ld" means
> that the code can then read the right values, that to me points fairly
> definitively to a hardware problem.
> 
> Now, ext4fs is pretty good at checksumming the metadata in the
> filesystem - each inode is individually checksummed with CRC32C and two
> 16-bit halves are stored in each inode. Directories are also
> checksummed. ext4fs validates the inode checksum on every ext4_iget()
> call. Do other filesystems do similar?

XFS and ext4 both validate the ondisk csum when constructing their
incore inodes, and set them when flushing the incore inode back to disk.

I vaguely wonder if there's something else going on here, like ... a
background memory reclaim thread running on one cpu writes out an inode
core with new checksum (because reading the file bumped the atime), and
then another cpu comes along and has to reconstitute the (just
reclaimed) incore inode, but for whatever reason doesn't get the version
that the other cpu just wrote?

That's like 130% speculative though, and note that I have no idea what
the "outer shareable" domain[1] is.

[1] https://developer.arm.com/docs/ddi0597/h/base-instructions-alphabetic-order/dmb-data-memory-barrier

> Anyway, here is the patch I'm currently running, which _seems_ so far
> to be the minimal fix for my problems. Will thinks that this is hiding
> the real problem by adding barriers, but I don't see there's much
> choice but to apply this - I don't see what other debugging could be
> done without the use of expensive hardware simulation, or detailed
> hardware level tracing - the kind of which a silicon vendor or ARM Ltd
> would have.

(FWIW I haven't seen checksum errors on xfs or ext4 on arm64, though
most of my testing is relegated to beating on a raspberry pi very
slowly...)

> I'm at the end of what I can do with this; I'm going to keep this patch
> in my kernel, since it fixes it for me.

Well if you've managed to hit this on multiple different machines after
a long soak time, I wonder how many other people will trip over this too.
It wouldn't be the first time a fs stunts performance to avoid
corruption. ;)

> Will would like a reliable reproducer - yes, that would be ideal, but
> I'm afraid that's a mamoth task in itself. It's taken a year to find
> this method of reproducing it.
> 
> There's also the matter that in one case I've seen, the ext4 checksum
> has been wrong. The subsequent hexdump has been correct, and the post-
> hexdump checksum recalculation has remained incorrect - and the same
> value as the first incorrect checksum. However, the inode with the
> _same_ checksum has subsequently validated correctly by the kernel and
> by e2fsck. I can not explain this.

Strange.  You're just using the same ext4_inode_csum() that everything
else uses, right?

--D

> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index ff50dd731852..be63c47aecc4 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -95,7 +95,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  ({									\
>  	unsigned long tmp;						\
>  									\
> -	dma_rmb();								\
> +	rmb();								\
>  									\
>  	/*								\
>  	 * Create a dummy control dependency from the IO read to any	\
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
