Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A02EAF5A
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbhAEPs3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 10:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAEPs3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 10:48:29 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AB5C061793;
        Tue,  5 Jan 2021 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RFRsY6eYacOkuoBfCDxrzCNNPunDtJE052SSVHEGFv4=; b=rkuqa+ijBqIxqYg8vNP41CFJD
        rq3l3JT7T/mFkKlwCPk0y/DBeG9oXDhaCFgutY4E0kWdpRQsYJaU2BBQlZRUL2QeFATWKzQJGvlbS
        a6AyPxolGcIW3+RS4LtMfeAPgaQbXO8dGsubS+2yiLiDin2I4TLt/nZgOnslX5dZm9m4pnnyYUUbe
        jGPA/Z8MwwrnJabg0c55UYKHx583LU7BfPQgtDWkV8nQSxkycqzDWNl21fw3THGeMlY6cGz9SnuEW
        OUUxgnr81WXLA4dbveniAZvscYx7QvrN/BS2PQguefOe8k8yDjdpArt//otkL+SBXtfjmiQffx1fC
        MMUo27clg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45104)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kwoYT-0000tT-Ag; Tue, 05 Jan 2021 15:47:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kwoYQ-0007qC-97; Tue, 05 Jan 2021 15:47:26 +0000
Date:   Tue, 5 Jan 2021 15:47:26 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210105154726.GD1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This is an update on where I am with this long standing issue at the
current time.

Since 5.4, I have been struggling with several of my ARM64 systems, of
different SoC vendors and differing filesystem media, were sporadically
reporting inode checksum failures on their root filesystems.  The time
taken to report this has been anything between a few hours and three
months of uptime, making the problem unrealistic to bisect.

The issue was first seen on my SolidRun Clearfog CX LX2160A based
system, but was also subsequently noticed on my Armada 8040 based
systems running kernels 5.4 and later. Kernel 5.2 has proven stable
with 566 days of uptime with no issue.

It has taken a long time to get debugging in place to see what is going
on - and this is currently detailed on the front page of
www.armlinux.org.uk right now, which has formed a blog of this problem
- since almost no one has taken any interest in it.

However, over the last couple of days, a way to reproduce it has been
found, at least for the LX2160A based system.  Power down, leave the
machine powered off for some time. Power up, log in and run:

while :; do sleep 5; find /var /usr /bin /sbin -type f -print0 | \
	xargs -0 md5sum >/dev/null; done

Within a few minutes it seems to have spat out an inode checksum
failure if the problem exists. However, testing for the problem _not_
existing is quite difficult - just because it doesn't appear in the
first few minutes does not mean it has been solved - see above where it
can take three months.

However, evidence is currently pointing towards commit 22ec71615d82
("arm64: io: Relax implicit barriers in default I/O accessors") having
revealed this problem. Will is very certain that this change is
correct, and we feel that it may have exposed some other issue in the
Aarch64 code.

Further attempts seem to suggest that the problem is specifically the
barrier in __iormb(). Leaving __iowmb() untouched, and changing the
barrier in __iormb() from dma_rmb() to rmb() _appears_ to result in the
problem disappearing. "Appears" is stressed because further testing is
needed - and that is probably going to take many months before we know
for certain.

However, this suggests that there is a memory ordering bug with aarch64
somewhere. Will can follow up with his own thoughts to this email.

We don't know if it is:
- the kernel.
- the Cortex A72.
- the Cache coherent interconnect.

I don't think it's the CCI, as I believe the Armada 8040 uses Marvell's
own IP for that based around Aurora 2 (the functional spec doesn't make
it clear.) Remember, I'm seeing this problem on both Armada 8040 and
LX2160A. We don't know of any known errata for the A72 in this area.
So, we're down to something in the kernel.

It is possible that it could be compiler related, but I don't see that;
if the "dmb oshld" were strong enough, then it should mean that the
subsequent reads to checksum the inode data after the inode data has
been DMA'd into memory should be reading the correct values from memory
already - but they aren't. And if changing "dmb oshld" to "dsb ld" means
that the code can then read the right values, that to me points fairly
definitively to a hardware problem.

Now, ext4fs is pretty good at checksumming the metadata in the
filesystem - each inode is individually checksummed with CRC32C and two
16-bit halves are stored in each inode. Directories are also
checksummed. ext4fs validates the inode checksum on every ext4_iget()
call. Do other filesystems do similar?

Anyway, here is the patch I'm currently running, which _seems_ so far
to be the minimal fix for my problems. Will thinks that this is hiding
the real problem by adding barriers, but I don't see there's much
choice but to apply this - I don't see what other debugging could be
done without the use of expensive hardware simulation, or detailed
hardware level tracing - the kind of which a silicon vendor or ARM Ltd
would have.

I'm at the end of what I can do with this; I'm going to keep this patch
in my kernel, since it fixes it for me.

Will would like a reliable reproducer - yes, that would be ideal, but
I'm afraid that's a mamoth task in itself. It's taken a year to find
this method of reproducing it.

There's also the matter that in one case I've seen, the ext4 checksum
has been wrong. The subsequent hexdump has been correct, and the post-
hexdump checksum recalculation has remained incorrect - and the same
value as the first incorrect checksum. However, the inode with the
_same_ checksum has subsequently validated correctly by the kernel and
by e2fsck. I can not explain this.

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index ff50dd731852..be63c47aecc4 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -95,7 +95,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 ({									\
 	unsigned long tmp;						\
 									\
-	dma_rmb();								\
+	rmb();								\
 									\
 	/*								\
 	 * Create a dummy control dependency from the IO read to any	\

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
