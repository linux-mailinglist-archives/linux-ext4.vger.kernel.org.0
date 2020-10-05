Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E88283D78
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Oct 2020 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgJERhf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 13:37:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43664 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgJERhB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 13:37:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095HPWp7014784;
        Mon, 5 Oct 2020 17:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=psvLZqk/j4m5yGr42ezZ4K3+sPsy2iAtavEdcNhY6q4=;
 b=jF+sfYqI6PM5jpWViwJQAyR9PICwLIl5u2NZ0wdXbdjz7phJGcrwdVGlwunwvSsbq/ym
 YDbbYfPfO0tjgpIgVWpbMk+eitllTkDD+1fPqTN9rM9MC3Jmnptdt5vTsuavWneQgvFI
 eUMYa1mLa3ntsmmhofe+Ya8opJ1N9kTI+dUMUewiBJHPZnfPJCgZdGC6NM+H9ZdbDema
 m3Pg5O6Zk7hVO4HNeRlr5T6Z5GP2UoCaAVBQNYQinlA0huLc5TvBiFQSuSIa1Ti6N7kk
 TmPsQ0tN7x8kKJ7TdhavlDbErgZq5g8h2gJuZiBMoRWQUIV9SnKOaXk/w6QU3prT8Pmt Nw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxmpshr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 05 Oct 2020 17:36:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095HOki1067487;
        Mon, 5 Oct 2020 17:36:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33y36ws3m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Oct 2020 17:36:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 095Haf3d024748;
        Mon, 5 Oct 2020 17:36:41 GMT
Received: from localhost (/10.159.154.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 10:36:40 -0700
Date:   Mon, 5 Oct 2020 10:36:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201005173639.GA2311765@magnolia>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005081454.GA493107@localhost>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=5 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=5 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050129
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 01:14:54AM -0700, Josh Triplett wrote:
> Ran into an ext4 regression when testing upgrades to 5.9-rc kernels:
> 
> Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> with intentionally overlapping bitmap blocks.
> 
> On an always-read-only filesystem explicitly marked with
> EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> point all the block and inode bitmaps to a single block

LOL, WHAT?

I didn't know shared blocks applied to fs metadata.  I thought that
"shared" only applied to file extent maps being able to share physical
blocks.

Could /somebody/ please document the ondisk format changes that are
associated with this feature?

> of all 1s,
> because a read-only filesystem will never allocate or free any blocks or
> inodes.

All 1s?  So the inode bitmap says that every inode table slot is in use,
even if the inode record itself says it isn't?  What does e2fsck -n
think about that kind of metadata inconsistency?

Hmm, let's try.

$ truncate -s 300m /tmp/a.img
$ mke2fs -T ext4 -O shared_blocks /tmp/a.img -d /tmp/ -F
mke2fs 1.46~WIP-2020-10-04 (4-Oct-2020)
Invalid filesystem option set: shared_blocks

Oookay.  So that's not how you create these shared block ext4s,
apparently...

$ mke2fs -T ext4 /tmp/a.img -F
mke2fs 1.46~WIP-2020-10-04 (4-Oct-2020)
Discarding device blocks: done
Creating filesystem with 76800 4k blocks and 19200 inodes
Filesystem UUID: 0a763191-89ca-49bc-9dc6-bf2986009ad9
Superblock backups stored on blocks:
        32768

Allocating group tables: done
Writing inode tables: done
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

$ debugfs -w /tmp/a.img
debugfs 1.45.6 (20-Mar-2020)
debugfs:  features shared_blocks
Filesystem features: has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum shared_blocks
debugfs:  set_bg 1 inode_bitmap 42
debugfs:  set_bg 1 block_bitmap 39
debugfs:  stats
 Group  0: block bitmap at 39, inode bitmap at 42, inode table at 45
           31517 free blocks, 6389 free inodes, 2 used directories, 6389 unused inodes
           [Checksum 0xda06]
 Group  1: block bitmap at 39, inode bitmap at 42, inode table at 445
           28633 free blocks, 6400 free inodes, 0 used directories, 6400 unused inodes
           [Inode not init, Checksum 0x2e69]
$ xfs_io -c "pwrite -S 0xFF $((39 * 4096)) 4096" /tmp/a.img
$ xfs_io -c "pwrite -S 0xFF $((42 * 4096)) 4096" /tmp/a.img

Ok, now we have a shared blocks fs where BG 0 and BG 1 share bitmaps,
and the bitmaps are set to 1.

$ e2fsck -n /tmp/a.img 
e2fsck 1.45.6 (20-Mar-2020)
ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
e2fsck: Group descriptors look bad... trying backup blocks...
/tmp/a.img was not cleanly unmounted, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(1251--32767)
Fix? no

Free blocks count wrong for group #0 (31517, counted=0).
Fix? no

Free blocks count wrong (71414, counted=39897).
Fix? no

Inode bitmap differences:  -(12--6400)
Fix? no

Free inodes count wrong for group #0 (6389, counted=0).
Fix? no

Free inodes count wrong (19189, counted=12800).
Fix? no

Padding at end of inode bitmap is not set. Fix? no

Inode bitmap differences: Group 0 inode bitmap does not match checksum.
IGNORED.
Group 1 inode bitmap does not match checksum.
IGNORED.
Group 2 inode bitmap does not match checksum.
IGNORED.
Block bitmap differences: Group 0 block bitmap does not match checksum.
IGNORED.

/tmp/a.img: ********** WARNING: Filesystem still has errors **********

/tmp/a.img: 11/19200 files (0.0% non-contiguous), 5386/76800 blocks

Sooooo... are you shipping ext4 images with an undocumented ondisk
format variation that looks like inconsistency to the standard tools?

--D

> 
> However, after that commit, the block validity check rejects such
> filesystems with -EUCLEAN and "failed to initialize system zone (-117)".
> This causes systems that previously worked correctly to fail when
> upgrading to v5.9-rc2 or later.
> 
> This was obviously a bugfix, and I'm not suggesting that it should be
> reverted; it looks like this effectively worked by accident before,
> because the block_validity check wasn't fully functional. However, this
> does break real systems, and I'd like to get some kind of regression fix
> in before 5.9 final if possible. I think it would suffice to make
> block_validity default to false if and only if
> EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is set.
> 
> Does that seem like a reasonable fix?
> 
> Here's a quick sketch of a patch, which I've tested and confirmed to
> work:
> 
> ----- 8< -----
> Subject: [PATCH] Fix ext4 regression in v5.9-rc2 on ro fs with overlapped bitmaps
> 
> Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> with intentionally overlapping bitmap blocks.
> 
> On an always-read-only filesystem explicitly marked with
> EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> point all the block and inode bitmaps to a single block of all 1s,
> because a read-only filesystem will never allocate or free any blocks or
> inodes.
> 
> However, after that commit, the block validity check rejects such
> filesystems with -EUCLEAN and "failed to initialize system zone (-117)".
> This causes systems that previously worked correctly to fail when
> upgrading to v5.9-rc2 or later.
> 
> Fix this by defaulting block_validity to off when
> EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS is set.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> Fixes: e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in ext4_setup_system_zone()")
> ---
>  fs/ext4/ext4.h  | 2 ++
>  fs/ext4/super.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 523e00d7b392..7874028fa864 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1834,6 +1834,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
>  #define EXT4_FEATURE_RO_COMPAT_METADATA_CSUM	0x0400
>  #define EXT4_FEATURE_RO_COMPAT_READONLY		0x1000
>  #define EXT4_FEATURE_RO_COMPAT_PROJECT		0x2000
> +#define EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS	0x4000
>  #define EXT4_FEATURE_RO_COMPAT_VERITY		0x8000
>  
>  #define EXT4_FEATURE_INCOMPAT_COMPRESSION	0x0001
> @@ -1930,6 +1931,7 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(bigalloc,		BIGALLOC)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,	METADATA_CSUM)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(readonly,		READONLY)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(project,		PROJECT)
> +EXT4_FEATURE_RO_COMPAT_FUNCS(shared_blocks,	SHARED_BLOCKS)
>  EXT4_FEATURE_RO_COMPAT_FUNCS(verity,		VERITY)
>  
>  EXT4_FEATURE_INCOMPAT_FUNCS(compression,	COMPRESSION)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ea425b49b345..f57a7e966e44 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3954,7 +3954,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  	else
>  		set_opt(sb, ERRORS_RO);
>  	/* block_validity enabled by default; disable with noblock_validity */
> -	set_opt(sb, BLOCK_VALIDITY);
> +	if (!ext4_has_feature_shared_blocks(sb))
> +		set_opt(sb, BLOCK_VALIDITY);
>  	if (def_mount_opts & EXT4_DEFM_DISCARD)
>  		set_opt(sb, DISCARD);
>  
