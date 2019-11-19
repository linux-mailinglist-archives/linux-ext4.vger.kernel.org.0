Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6C102DB0
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 21:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfKSUnr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Nov 2019 15:43:47 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:52065 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726711AbfKSUnr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 19 Nov 2019 15:43:47 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2216E43F136;
        Wed, 20 Nov 2019 07:43:41 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iXALc-0007gT-7X; Wed, 20 Nov 2019 07:43:40 +1100
Date:   Wed, 20 Nov 2019 07:43:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        darrick.wong@oracle.com, jaegeuk@kernel.org, chao@kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [RFC PATCH 3/3] xfs: show prjquota info on statfs for a file
Message-ID: <20191119204340.GZ4614@dread.disaster.area>
References: <20191118050949.15629-1-cgxu519@mykernel.net>
 <20191118050949.15629-3-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191118050949.15629-3-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=MeAgGD-zjQ4A:10
        a=aKLo6qE4AAAA:8 a=7-415B0cAAAA:8 a=2IXG0JadBsM__kedw_oA:9
        a=wPNLvfGTeEIA:10 a=O0NXIRw7_9tMP-H1FTy7:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 18, 2019 at 01:09:49PM +0800, Chengguang Xu wrote:
> Currently we replace filesystem statistics using prjquota info
> on statfs when specified directory has project id inherit flag.
> However, statfs on a file(accurately non-dir) which is under the
> project quota dir(with inherit flag) still shows whole filesystem
> statistics. In container use case, it will give container user
> inconsistent experience and cause confusion about available free
> space.
> 
> Detail info like below:
> We use project quota to limit disk space usage for a container
> and run df command inside container.
> 
> Run df on a directory:
> 
> [root /]# df -h /etc/
> Filesystem      Size  Used Avail Use% Mounted on
> kataShared      1.0G   13M 1012M   2% /
> 
> Run df on a file:
> 
> [root /]# df -h /etc/exports
> Filesystem      Size  Used Avail Use% Mounted on
> kataShared      1.5T  778M  1.5T   1% /
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/xfs/xfs_super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 8d1df9f8be07..9f4d9e86572a 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1125,7 +1125,8 @@ xfs_fs_statfs(
>  	statp->f_ffree = max_t(int64_t, ffree, 0);
>  
>  
> -	if ((ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT) &&
> +	if (((ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT) ||
> +	     !S_ISDIR(dentry->d_inode->i_mode)) &&
>  	    ((mp->m_qflags & (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))) ==
>  			      (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))
>  		xfs_qm_statvfs(ip, statp);

So this also changes statfs() for non-directory quota uses. It will
now *always* report project quota info for a file, whether directory
quotas are in use or not. This is going to confuse users who see the
full filesystem info when they statfs a directory, then see project
quota limits when they statfs a file.

i.e. all this patch does is move the inconsistency in reporting to
non-directory based project quota users.

So from that perspective, this is not a viable solution.

What is a viable solution is to add an explicit dirquota mount
option (which we've recently discussed) that explicitly presents all
directory quota specific behaviours to userspace without tying them
to the internal project quota-based on-disk implementation. This is
the only sane way to solve this problem as it tells the filesysetm
exactly what behaviour set it should be exposing to userspace.

IOWs, the statfs code should probably end up looking like this:

-	if ((ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT) &&
+	if ((mp->m_flags & XFS_MOUNT_DIRQUOTA) &&
 	    ((mp->m_qflags & (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))) ==
 			      (XFS_PQUOTA_ACCT|XFS_PQUOTA_ENFD))
 		xfs_qm_statvfs(ip, statp);

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
