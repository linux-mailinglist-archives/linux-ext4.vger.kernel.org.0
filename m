Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53B767555
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2019 21:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGLTTH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jul 2019 15:19:07 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:49165 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfGLTTG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jul 2019 15:19:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 45ljQd5rLZz7t8y;
        Fri, 12 Jul 2019 19:19:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GjnLjQ2Ivb1b; Fri, 12 Jul 2019 19:19:05 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 45ljQd4sMNz3wZ5;
        Fri, 12 Jul 2019 19:19:05 +0000 (GMT)
Received: from EXMBDFT10.ad.twosigma.com (172.23.127.159) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Fri, 12 Jul 2019 19:19:05 +0000
Received: from exmbdft6.ad.twosigma.com (172.22.1.5) by
 EXMBDFT10.ad.twosigma.com (172.23.127.159) with Microsoft SMTP Server (TLS)
 id 15.0.1365.1; Fri, 12 Jul 2019 19:19:05 +0000
Received: from twosigma.com (192.168.147.188) by exmbdft6.ad.twosigma.com
 (172.22.1.5) with Microsoft SMTP Server (TLS) id 15.0.1365.1 via Frontend
 Transport; Fri, 12 Jul 2019 19:19:05 +0000
Date:   Fri, 12 Jul 2019 15:19:03 -0400
From:   Thomas Walker <Thomas.Walker@twosigma.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>,
        'Jan Kara' <jack@suse.cz>,
        "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Message-ID: <20190712191903.GP2772@twosigma.com>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com> <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
 <20190711171046.GA13966@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190711171046.GA13966@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 11, 2019 at 01:10:46PM -0400, Theodore Ts'o wrote:
> Can you try using "df -i" when the file system looks full, and then
> reboot, and look at the results of "df -i" afterwards?

inode usage doesn't change appreciably between the state with "lost" space, after the remount workaround, or after a reboot.

> Also interesting would be to grab a metadata-only snapshot of the file
> system when it is in its mysteriously full state, writing that
> snapshot on some other file system *other* than on /dev/sda3:
> 
>      e2image -r /dev/sda3 /mnt/sda3.e2i
> 
> Then run e2fsck on it:
> 
> e2fsck -fy /mnt/sda3.e2i
> 
> What I'm curious about is how many "orphaned inodes" are reported, and
> how much space they are taking up.  That will look like this:

<..>
Clearing orphaned inode 2360177 (uid=0, gid=0, mode=0100644, size=1035390)
Clearing orphaned inode 2360181 (uid=0, gid=0, mode=0100644, size=185522)
Clearing orphaned inode 2360176 (uid=0, gid=0, mode=0100644, size=1924512)
Clearing orphaned inode 2360180 (uid=0, gid=0, mode=0100644, size=3621978)
Clearing orphaned inode 1048838 (uid=0, gid=4, mode=0100640, size=39006841856)
release_inode_blocks: Corrupt extent header while calling ext2fs_block_iterate for inode 1048838
<..>

Of particular note, ino 1048838 matches the size of the space that we "lost".
A few months ago I was poking at this with kprobes to try to understand what was happening with the attempt to remount read-only and noticed that it triggered hundreds of:

           <...>-78273 [000] .... 5186888.917840: ext4_remove_blocks: dev 8,3 ino 2889535 extent [0(11384832), 2048]from 0 to 2047 partial_cluster 0
           <...>-78273 [000] .... 5186888.917841: <stack trace>
 => ext4_ext_truncate
 => ext4_truncate
 => ext4_evict_inode
 => evict
 => iput
 => dentry_unlink_inode
 => __dentry_kill
 => dput.part.23
 => dput
 => SyS_rename
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

With all the same inode numbers whose sizes added up to the same amount of space that we had "lost" and got back.  But the inode didn't map to any file or open filehandle though.
Obviously the inode numbers match here and, if I total up all of the ext4_remove_blocks lines, the number of blocks match both what fsck reports and what we "lost"

> 
> ...
> 
> It's been theorized the bug is in overlayfs, where it's holding inodes
> open so the space isn't released.  IIRC somewhat had reported a
> similar problem with overlayfs on top of xfs.  (BTW, are you using
> overlayfs or aufs with your Docker setup?)
> 

Yes, we are using overlayfs and had also heard similar reports.  But the ext4 fs here is the root filesystem,
while all of the overlays are using a separate partition using XFS.  The only interplay between our root fs and
the docker containers is the occasional ro bind mount from root into the container.

Unfortunately, we've not been able to reproduce this outside of our production plant running real workload with real data.  I did capture a metadata dump (with dirents scrambled) as Jan asked, but I suspect it will take some work to get past our security team.  I can certainly do that if we think there is anything valuable though.


Thanks,
Tom.
