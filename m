Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57C17E6AE
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 19:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCISTS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 14:19:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57444 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgCISTR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 14:19:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029IEKrl100776;
        Mon, 9 Mar 2020 18:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xPy123V3RIz8bxbouiJ3n3qPl+LjqJRf+kLqlw4C0B8=;
 b=sfGPJzrZzR8mXMroGoYe1fP7QadhC3yJQqSPxoLmAtCltAiwYm9MmrgvmY4XhLHaYEr3
 bjw42tY2EH6lqbpAwrmySHAvz79VBwZbZ6EhMez9eag3DNNOJzz3M+FzSZ/LL4Kg1guM
 WGslN8wBq4n6RygI43eJqZHWJ6sVesq+jf8FK70Nc/khYMx51U3+0nvLPGcEsX/WItU6
 D36J8nAcjTHDNVHoUFvtkPM3OeUUmPp74hAiz14FjLU2uiWTh3QAz2aiQSxsBXUlZKis
 YGewl8nBjAxI2oPOqwjvPoR50f1fPYCQpZ4cRuvhwVCxEwGsepaA4Qys8yQa9jB2ohLb 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ym3jqgswy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 18:19:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029IGm8O095657;
        Mon, 9 Mar 2020 18:17:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ymn3gf9g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 18:17:12 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029IDW01004007;
        Mon, 9 Mar 2020 18:13:32 GMT
Received: from localhost (/10.159.248.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Mar 2020 11:13:32 -0700
Date:   Mon, 9 Mar 2020 11:13:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200309181332.GJ1752567@magnolia>
References: <20200309010410.GA371527@sol.localdomain>
 <20200309043430.143206-1-ebiggers@kernel.org>
 <20200309162439.GB8045@magnolia>
 <20200309180452.GA1073@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309180452.GA1073@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=716 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=777 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090112
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 09, 2020 at 11:04:52AM -0700, Eric Biggers wrote:
> On Mon, Mar 09, 2020 at 09:24:39AM -0700, Darrick J. Wong wrote:
> > On Sun, Mar 08, 2020 at 09:34:30PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
> > > during do_exit().  That can confuse things.  For example, if BSD process
> > > accounting is enabled and the accounting file has FS_SYNC_FL set and is
> > > located on an ext4 filesystem without a journal, then do_exit() ends up
> > > calling ext4_write_inode().  That triggers the
> > > WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
> > > (appropriately) that inodes aren't written when allocating memory.
> > > 
> > > Fix this in xfsaild() by using the helper functions to save and restore
> > > PF_MEMALLOC.
> > > 
> > > This can be reproduced as follows in the kvm-xfstests test appliance
> > > modified to add the 'acct' Debian package, and with kvm-xfstests's
> > > recommended kconfig modified to add CONFIG_BSD_PROCESS_ACCT=y:
> > > 
> > > 	mkfs.ext2 -F /dev/vdb
> > > 	mount /vdb -t ext4
> > > 	touch /vdb/file
> > > 	chattr +S /vdb/file
> > 
> > Does this trip if the process accounting file is also on an xfs
> > filesystem?
> > 
> > > 	accton /vdb/file
> > > 	mkfs.xfs -f /dev/vdc
> > > 	mount /vdc
> > > 	umount /vdc
> > 
> > ...and if so, can this be turned into an fstests case, please?
> 
> I wasn't expecting it, but it turns out it does actually trip a similar warning
> in iomap_do_writepage():
> 
>         mkfs.xfs -f /dev/vdb
>         mount /vdb
>         touch /vdb/file
>         chattr +S /vdb/file
>         accton /vdb/file
>         mkfs.xfs -f /dev/vdc
>         mount /vdc
>         umount /vdc
> 
> causes...
> 
> 	WARNING: CPU: 1 PID: 336 at fs/iomap/buffered-io.c:1534
> 	CPU: 1 PID: 336 Comm: xfsaild/vdc Not tainted 5.6.0-rc5 #3
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
> 	RIP: 0010:iomap_do_writepage+0x16b/0x1f0 fs/iomap/buffered-io.c:1534
> 	[...]
> 	Call Trace:
> 	 write_cache_pages+0x189/0x4d0 mm/page-writeback.c:2238
> 	 iomap_writepages+0x1c/0x33 fs/iomap/buffered-io.c:1642
> 	 xfs_vm_writepages+0x65/0x90 fs/xfs/xfs_aops.c:578
> 	 do_writepages+0x41/0xe0 mm/page-writeback.c:2344
> 	 __filemap_fdatawrite_range+0xd2/0x120 mm/filemap.c:421
> 	 file_write_and_wait_range+0x71/0xc0 mm/filemap.c:760
> 	 xfs_file_fsync+0x7a/0x2b0 fs/xfs/xfs_file.c:114
> 	 generic_write_sync include/linux/fs.h:2867 [inline]
> 	 xfs_file_buffered_aio_write+0x379/0x3b0 fs/xfs/xfs_file.c:691
> 	 call_write_iter include/linux/fs.h:1901 [inline]
> 	 new_sync_write+0x130/0x1d0 fs/read_write.c:483
> 	 __kernel_write+0x54/0xe0 fs/read_write.c:515
> 	 do_acct_process+0x122/0x170 kernel/acct.c:522
> 	 slow_acct_process kernel/acct.c:581 [inline]
> 	 acct_process+0x1d4/0x27c kernel/acct.c:607
> 	 do_exit+0x83d/0xbc0 kernel/exit.c:791
> 	 kthread+0xf1/0x140 kernel/kthread.c:257
> 	 ret_from_fork+0x27/0x50 arch/x86/entry/entry_64.S:352
> 
> So sure, since it's not necessarily a multi-filesystem thing, I can try to turn
> it into an xfstest.  There's currently no way to enable BSD process accounting
> in xfstests though, so we'll either need to make the test depend on the 'acct'
> program or add a helper test program.
> 
> Also, do you want me to update the commit message again, to mention the above
> case?

I think it's worth mentioning that this is a general problem that
applies any time the process accounting file has that sync flag set,
since this problem isn't specific to ext4 + xfs.

(and now I wonder how many other places in the kernel suffer from these
kinds of file write surprises...)

--D

> - Eric
