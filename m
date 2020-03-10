Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EB18024A
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Mar 2020 16:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCJPrH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Mar 2020 11:47:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47188 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCJPrH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Mar 2020 11:47:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AFV4EF045425;
        Tue, 10 Mar 2020 15:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=E+uMZnIg84WF7/AIVTmOQZkwnV32Fa5W9H+EdBj6650=;
 b=JDnp6Ib4bAs2/YTO+9cPgEPn+34hQ/oQ/Rmn9Iu1IXeDcqxch6P1wB7b3qGtzVp5sfIO
 RHSmlPhW1Zo4nGBF20GaAaL5KLXXtJI+iyV5XXEMKcDyR6gMXu4yik9ihmIb/bGiC8q3
 sm9Yc4OO64x6Keo4uuarWGY3YEoJIwMkn6XyqAmguzYBMCWqPzQMlFIsIPXx15Vp6nbu
 xB5EXYbbs5/hI8fMC05J3gOfuPhFcZTXxpmcsrSQfcIbktnpNV2ASrNPkDaerwKcTLYE
 lkbSWG59SeUIh/U/6C6GAD46N1zI7RlvwlhY4fM3yKzZs4J7vrlPwtaLhDt/MwFteemI +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yp9v61fmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 15:47:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AFXgLt104499;
        Tue, 10 Mar 2020 15:47:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yp8rjkx1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 15:47:02 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AFl2X7029901;
        Tue, 10 Mar 2020 15:47:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 08:47:01 -0700
Date:   Tue, 10 Mar 2020 08:47:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200310154701.GI8036@magnolia>
References: <20200309181332.GJ1752567@magnolia>
 <20200309185714.42850-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309185714.42850-1-ebiggers@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100100
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 09, 2020 at 11:57:14AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
> during do_exit().  That can confuse things.  In particular, if BSD
> process accounting is enabled, then do_exit() writes data to an
> accounting file.  If that file has FS_SYNC_FL set, then this write
> occurs synchronously and can misbehave if PF_MEMALLOC is set.
> 
> For example, if the accounting file is located on an XFS filesystem,
> then a WARN_ON_ONCE() in iomap_do_writepage() is triggered and the data
> doesn't get written when it should.  Or if the accounting file is
> located on an ext4 filesystem without a journal, then a WARN_ON_ONCE()
> in ext4_write_inode() is triggered and the inode doesn't get written.
> 
> Fix this in xfsaild() by using the helper functions to save and restore
> PF_MEMALLOC.
> 
> This can be reproduced as follows in the kvm-xfstests test appliance
> modified to add the 'acct' Debian package, and with kvm-xfstests's
> recommended kconfig modified to add CONFIG_BSD_PROCESS_ACCT=y:
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
> It causes:
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
> This bug was originally reported by syzbot at
> https://lore.kernel.org/r/0000000000000e7156059f751d7b@google.com.
> 
> Reported-by: syzbot+1f9dc49e8de2582d90c2@syzkaller.appspotmail.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Seems reasonable to me, will give it a spin...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> v3: updated commit message again, this time to take into account the bug
>     also being reproducible when the accounting file is located on XFS.
> 
> v2: include more details in the commit message.
> 
>  fs/xfs/xfs_trans_ail.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
> index 00cc5b8734be8..3bc570c90ad97 100644
> --- a/fs/xfs/xfs_trans_ail.c
> +++ b/fs/xfs/xfs_trans_ail.c
> @@ -529,8 +529,9 @@ xfsaild(
>  {
>  	struct xfs_ail	*ailp = data;
>  	long		tout = 0;	/* milliseconds */
> +	unsigned int	noreclaim_flag;
>  
> -	current->flags |= PF_MEMALLOC;
> +	noreclaim_flag = memalloc_noreclaim_save();
>  	set_freezable();
>  
>  	while (1) {
> @@ -601,6 +602,7 @@ xfsaild(
>  		tout = xfsaild_push(ailp);
>  	}
>  
> +	memalloc_noreclaim_restore(noreclaim_flag);
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 
