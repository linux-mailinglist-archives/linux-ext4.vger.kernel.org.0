Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7017E657
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 19:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCISEz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 14:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgCISEz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Mar 2020 14:04:55 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C3E215A4;
        Mon,  9 Mar 2020 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583777094;
        bh=Ptre7CW0SKo87QNNsafIdExhNEvOolW6MbLzvP3uyuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3hLucMxbfoBCLqQDU1+xW61P2qX2lGqX11VEdovINh3xVOtqIJrrf2bhlSJAFlAP
         1xWj+LSgIOv4b6NVe3XcLHKSBQFxHqb/nBf9c0Xs5BmqXxDN1WfHn5hpQIUUsFBYOA
         FlPdmuqXttMJw9mM9IY/cY7l7hsGczQfbg2IOlfg=
Date:   Mon, 9 Mar 2020 11:04:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200309180452.GA1073@sol.localdomain>
References: <20200309010410.GA371527@sol.localdomain>
 <20200309043430.143206-1-ebiggers@kernel.org>
 <20200309162439.GB8045@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309162439.GB8045@magnolia>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 09, 2020 at 09:24:39AM -0700, Darrick J. Wong wrote:
> On Sun, Mar 08, 2020 at 09:34:30PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
> > during do_exit().  That can confuse things.  For example, if BSD process
> > accounting is enabled and the accounting file has FS_SYNC_FL set and is
> > located on an ext4 filesystem without a journal, then do_exit() ends up
> > calling ext4_write_inode().  That triggers the
> > WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
> > (appropriately) that inodes aren't written when allocating memory.
> > 
> > Fix this in xfsaild() by using the helper functions to save and restore
> > PF_MEMALLOC.
> > 
> > This can be reproduced as follows in the kvm-xfstests test appliance
> > modified to add the 'acct' Debian package, and with kvm-xfstests's
> > recommended kconfig modified to add CONFIG_BSD_PROCESS_ACCT=y:
> > 
> > 	mkfs.ext2 -F /dev/vdb
> > 	mount /vdb -t ext4
> > 	touch /vdb/file
> > 	chattr +S /vdb/file
> 
> Does this trip if the process accounting file is also on an xfs
> filesystem?
> 
> > 	accton /vdb/file
> > 	mkfs.xfs -f /dev/vdc
> > 	mount /vdc
> > 	umount /vdc
> 
> ...and if so, can this be turned into an fstests case, please?

I wasn't expecting it, but it turns out it does actually trip a similar warning
in iomap_do_writepage():

        mkfs.xfs -f /dev/vdb
        mount /vdb
        touch /vdb/file
        chattr +S /vdb/file
        accton /vdb/file
        mkfs.xfs -f /dev/vdc
        mount /vdc
        umount /vdc

causes...

	WARNING: CPU: 1 PID: 336 at fs/iomap/buffered-io.c:1534
	CPU: 1 PID: 336 Comm: xfsaild/vdc Not tainted 5.6.0-rc5 #3
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
	RIP: 0010:iomap_do_writepage+0x16b/0x1f0 fs/iomap/buffered-io.c:1534
	[...]
	Call Trace:
	 write_cache_pages+0x189/0x4d0 mm/page-writeback.c:2238
	 iomap_writepages+0x1c/0x33 fs/iomap/buffered-io.c:1642
	 xfs_vm_writepages+0x65/0x90 fs/xfs/xfs_aops.c:578
	 do_writepages+0x41/0xe0 mm/page-writeback.c:2344
	 __filemap_fdatawrite_range+0xd2/0x120 mm/filemap.c:421
	 file_write_and_wait_range+0x71/0xc0 mm/filemap.c:760
	 xfs_file_fsync+0x7a/0x2b0 fs/xfs/xfs_file.c:114
	 generic_write_sync include/linux/fs.h:2867 [inline]
	 xfs_file_buffered_aio_write+0x379/0x3b0 fs/xfs/xfs_file.c:691
	 call_write_iter include/linux/fs.h:1901 [inline]
	 new_sync_write+0x130/0x1d0 fs/read_write.c:483
	 __kernel_write+0x54/0xe0 fs/read_write.c:515
	 do_acct_process+0x122/0x170 kernel/acct.c:522
	 slow_acct_process kernel/acct.c:581 [inline]
	 acct_process+0x1d4/0x27c kernel/acct.c:607
	 do_exit+0x83d/0xbc0 kernel/exit.c:791
	 kthread+0xf1/0x140 kernel/kthread.c:257
	 ret_from_fork+0x27/0x50 arch/x86/entry/entry_64.S:352

So sure, since it's not necessarily a multi-filesystem thing, I can try to turn
it into an xfstest.  There's currently no way to enable BSD process accounting
in xfstests though, so we'll either need to make the test depend on the 'acct'
program or add a helper test program.

Also, do you want me to update the commit message again, to mention the above
case?

- Eric
