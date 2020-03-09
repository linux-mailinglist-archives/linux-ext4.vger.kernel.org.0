Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB217E4B7
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 17:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCIQYp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 12:24:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCIQYp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 12:24:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029GNNwD101380;
        Mon, 9 Mar 2020 16:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=IG8LvxfBY1OrePUu9eNqEJdMLNEqViWjxSiyKEsDlc8=;
 b=W6Q0SiZek17CEMk08wEXIEihM4/z+9h/6sIqwi2h0Us6Cxh3P43dAPaMu6rL/cvyRXAt
 Li4H3XeZTbQ1S5qbTJaIRsTNkWGpaXIEGQilezs8Lcn6WPh9fdcvwls9xCibCKFCzReP
 YiggLeibhnzuYlCo0L9z3hWb+r/Vm0PDGi6Ll0wUl4TfSNimQb5TYxrH2ws5F36vJmNF
 vHwVbKPacu/xEtG896Wtqqi7eEVwqI280WLy2JCCRsdk4i4mOa4t76nc8cQNaUB32XjE
 n+NL4yLpiIQcl1WqtkQEPxNZTYwZ+Y+JfD9b0O6yf2i9KTVT6SVwajkjRuzg2npRHbOm +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ym48sqya1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 16:24:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029GHI5O151727;
        Mon, 9 Mar 2020 16:24:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ymnb09uks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 16:24:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029GOeB6004199;
        Mon, 9 Mar 2020 16:24:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Mar 2020 09:24:40 -0700
Date:   Mon, 9 Mar 2020 09:24:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200309162439.GB8045@magnolia>
References: <20200309010410.GA371527@sol.localdomain>
 <20200309043430.143206-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309043430.143206-1-ebiggers@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090107
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Mar 08, 2020 at 09:34:30PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Leaving PF_MEMALLOC set when exiting a kthread causes it to remain set
> during do_exit().  That can confuse things.  For example, if BSD process
> accounting is enabled and the accounting file has FS_SYNC_FL set and is
> located on an ext4 filesystem without a journal, then do_exit() ends up
> calling ext4_write_inode().  That triggers the
> WARN_ON_ONCE(current->flags & PF_MEMALLOC) there, as it assumes
> (appropriately) that inodes aren't written when allocating memory.
> 
> Fix this in xfsaild() by using the helper functions to save and restore
> PF_MEMALLOC.
> 
> This can be reproduced as follows in the kvm-xfstests test appliance
> modified to add the 'acct' Debian package, and with kvm-xfstests's
> recommended kconfig modified to add CONFIG_BSD_PROCESS_ACCT=y:
> 
> 	mkfs.ext2 -F /dev/vdb
> 	mount /vdb -t ext4
> 	touch /vdb/file
> 	chattr +S /vdb/file

Does this trip if the process accounting file is also on an xfs
filesystem?

> 	accton /vdb/file
> 	mkfs.xfs -f /dev/vdc
> 	mount /vdc
> 	umount /vdc

...and if so, can this be turned into an fstests case, please?


> 
> It causes:
> 	WARNING: CPU: 0 PID: 332 at fs/ext4/inode.c:5097 ext4_write_inode+0x140/0x1a0
> 	CPU: 0 PID: 332 Comm: xfsaild/vdc Not tainted 5.6.0-rc5 #5
> 	[...]
> 	RIP: 0010:ext4_write_inode+0x140/0x1a0 fs/ext4/inode.c:5097
> 	[...]
> 	Call Trace:
> 	 write_inode fs/fs-writeback.c:1312 [inline]
> 	 __writeback_single_inode+0x465/0x5f0 fs/fs-writeback.c:1511
> 	 writeback_single_inode+0xad/0x120 fs/fs-writeback.c:1565
> 	 sync_inode fs/fs-writeback.c:2602 [inline]
> 	 sync_inode_metadata+0x3d/0x57 fs/fs-writeback.c:2622
> 	 ext4_fsync_nojournal fs/ext4/fsync.c:94 [inline]
> 	 ext4_sync_file+0x243/0x4b0 fs/ext4/fsync.c:172
> 	 generic_write_sync include/linux/fs.h:2867 [inline]
> 	 ext4_buffered_write_iter+0xe1/0x130 fs/ext4/file.c:277
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
> This case was originally reported by syzbot at
> https://lore.kernel.org/r/0000000000000e7156059f751d7b@google.com.
> 
> Reported-by: syzbot+1f9dc49e8de2582d90c2@syzkaller.appspotmail.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
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
