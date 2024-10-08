Return-Path: <linux-ext4+bounces-4529-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DD994BE0
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CDD6283350
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A31DE894;
	Tue,  8 Oct 2024 12:47:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEE1DC046
	for <linux-ext4@vger.kernel.org>; Tue,  8 Oct 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391669; cv=none; b=Tb3S2+uQ3WktGRjnxd28IBARB4R0ClCWK+geTtDR2p+Ngwelsx1Vpy5qjgr51ZZ2r0tcMyNBtufr9Bex1hg2u2ZwWNDEvwkyyOjEKUlgAfYxY+esPBuh+o2wM9ebW1oOvnd+6k5GtPd8de6pRy0mYO05OSR0IkBofhWIgxy/rj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391669; c=relaxed/simple;
	bh=wupc9Esg4erB+pPalsdzuWXr3aoUSXsMNNhGudHvH00=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGxUaOS/WmjIazBRyInkyS+if4FqUcJz2fsy8KjTxHM2k96u0Ov49oMZAnmZj2Ax1dRPEQL4GqPmYJsx2V2sBLtjx4x8UnD+/QBag0ewCV0rNvDERm8PIRPxE6nY+pshz9ikjAKwCvdaN75OMQM9+N2IfgDo3S+HL1ApqA/xw1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XNG0Q2V66z1HJ7T;
	Tue,  8 Oct 2024 20:43:34 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 18A621400D2;
	Tue,  8 Oct 2024 20:47:39 +0800 (CST)
Received: from localhost (10.175.127.227) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 8 Oct
 2024 20:47:38 +0800
Date: Tue, 8 Oct 2024 21:02:16 +0800
From: Long Li <leo.lilong@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: Fix race in buffer_head read fault injection
Message-ID: <20241008130216.GA661738@ceph-admin>
References: <20240906091746.510163-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240906091746.510163-1-leo.lilong@huawei.com>
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500017.china.huawei.com (7.185.36.126)

On Fri, Sep 06, 2024 at 05:17:46PM +0800, Long Li wrote:

Friendly Ping ...

> When I enabled ext4 debug for fault injection testing, I encountered the
> following warning:
> 
>   EXT4-fs error (device sda): ext4_read_inode_bitmap:201: comm fsstress:
>          Cannot read inode bitmap - block_group = 8, inode_bitmap = 1051
>   WARNING: CPU: 0 PID: 511 at fs/buffer.c:1181 mark_buffer_dirty+0x1b3/0x1d0
> 
> The root cause of the issue lies in the improper implementation of ext4's
> buffer_head read fault injection. The actual completion of buffer_head
> read and the buffer_head fault injection are not atomic, which can lead
> to the uptodate flag being cleared on normally used buffer_heads in race
> conditions.
> 
> [CPU0]           [CPU1]         [CPU2]
> ext4_read_inode_bitmap
>   ext4_read_bh()
>   <bh read complete>
>                  ext4_read_inode_bitmap
>                    if (buffer_uptodate(bh))
>                      return bh
>                                jbd2_journal_commit_transaction
>                                  __jbd2_journal_refile_buffer
>                                    __jbd2_journal_unfile_buffer
>                                      __jbd2_journal_temp_unlink_buffer
>   ext4_simulate_fail_bh()
>     clear_buffer_uptodate
>                                       mark_buffer_dirty
>                                         <report warning>
>                                         WARN_ON_ONCE(!buffer_uptodate(bh))
> 
> The best approach would be to perform fault injection in the IO completion
> callback function, rather than after IO completion. However, the IO
> completion callback function cannot get the fault injection code in sb.
> 
> Fix it by passing the result of fault injection into the bh read function,
> we simulate faults within the bh read function itself. This requires adding
> an extra parameter to the bh read functions that need fault injection.
> 
> Fixes: 46f870d690fe ("ext4: simulate various I/O and checksum errors when reading metadata")
> Signed-off-by: Long Li <leo.lilong@huawei.com>
> ---
>  fs/ext4/balloc.c      |  4 ++--
>  fs/ext4/ext4.h        | 12 ++----------
>  fs/ext4/extents.c     |  2 +-
>  fs/ext4/ialloc.c      |  5 +++--
>  fs/ext4/indirect.c    |  2 +-
>  fs/ext4/inode.c       |  4 ++--
>  fs/ext4/mmp.c         |  2 +-
>  fs/ext4/move_extent.c |  2 +-
>  fs/ext4/resize.c      |  2 +-
>  fs/ext4/super.c       | 23 +++++++++++++++--------
>  10 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 591fb3f710be..8042ad873808 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -550,7 +550,8 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
>  	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
>  	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO |
>  			    (ignore_locked ? REQ_RAHEAD : 0),
> -			    ext4_end_bitmap_read);
> +			    ext4_end_bitmap_read,
> +			    ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_EIO));
>  	return bh;
>  verify:
>  	err = ext4_validate_block_bitmap(sb, desc, block_group, bh);
> @@ -577,7 +578,6 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
>  	if (!desc)
>  		return -EFSCORRUPTED;
>  	wait_on_buffer(bh);
> -	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
>  	if (!buffer_uptodate(bh)) {
>  		ext4_error_err(sb, EIO, "Cannot read block bitmap - "
>  			       "block_group = %u, block_bitmap = %llu",
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 75a29b23d858..8083ff8e924c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1865,14 +1865,6 @@ static inline bool ext4_simulate_fail(struct super_block *sb,
>  	return false;
>  }
>  
> -static inline void ext4_simulate_fail_bh(struct super_block *sb,
> -					 struct buffer_head *bh,
> -					 unsigned long code)
> -{
> -	if (!IS_ERR(bh) && ext4_simulate_fail(sb, code))
> -		clear_buffer_uptodate(bh);
> -}
> -
>  /*
>   * Error number codes for s_{first,last}_error_errno
>   *
> @@ -3098,9 +3090,9 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
>  extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  						   sector_t block);
>  extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
> -				bh_end_io_t *end_io);
> +				bh_end_io_t *end_io, bool simu_fail);
>  extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> -			bh_end_io_t *end_io);
> +			bh_end_io_t *end_io, bool simu_fail);
>  extern int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
>  extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
>  extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 34e25eee6521..88f98dc44027 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -568,7 +568,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
>  
>  	if (!bh_uptodate_or_lock(bh)) {
>  		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
> -		err = ext4_read_bh(bh, 0, NULL);
> +		err = ext4_read_bh(bh, 0, NULL, false);
>  		if (err < 0)
>  			goto errout;
>  	}
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 7f1a5f90dbbd..21d228073d79 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -193,8 +193,9 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
>  	 * submit the buffer_head for reading
>  	 */
>  	trace_ext4_load_inode_bitmap(sb, block_group);
> -	ext4_read_bh(bh, REQ_META | REQ_PRIO, ext4_end_bitmap_read);
> -	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
> +	ext4_read_bh(bh, REQ_META | REQ_PRIO,
> +		     ext4_end_bitmap_read,
> +		     ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_EIO));
>  	if (!buffer_uptodate(bh)) {
>  		put_bh(bh);
>  		ext4_error_err(sb, EIO, "Cannot read inode bitmap - "
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index 7404f0935c90..7de327fa7b1c 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -170,7 +170,7 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
>  		}
>  
>  		if (!bh_uptodate_or_lock(bh)) {
> -			if (ext4_read_bh(bh, 0, NULL) < 0) {
> +			if (ext4_read_bh(bh, 0, NULL, false) < 0) {
>  				put_bh(bh);
>  				goto failure;
>  			}
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..99d09cd9c6a3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4497,10 +4497,10 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  	 * Read the block from disk.
>  	 */
>  	trace_ext4_load_inode(sb, ino);
> -	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
> +	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL,
> +			    ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO));
>  	blk_finish_plug(&plug);
>  	wait_on_buffer(bh);
> -	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
>  	if (!buffer_uptodate(bh)) {
>  		if (ret_block)
>  			*ret_block = block;
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index bd946d0c71b7..d64c04ed061a 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -94,7 +94,7 @@ static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
>  	}
>  
>  	lock_buffer(*bh);
> -	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL);
> +	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL, false);
>  	if (ret)
>  		goto warn_exit;
>  
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index b64661ea6e0e..898443e98efc 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -213,7 +213,7 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
>  			unlock_buffer(bh);
>  			continue;
>  		}
> -		ext4_read_bh_nowait(bh, 0, NULL);
> +		ext4_read_bh_nowait(bh, 0, NULL, false);
>  		nr++;
>  	} while (block++, (bh = bh->b_this_page) != head);
>  
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..1d9d14b9d33d 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1298,7 +1298,7 @@ static struct buffer_head *ext4_get_bitmap(struct super_block *sb, __u64 block)
>  	if (unlikely(!bh))
>  		return NULL;
>  	if (!bh_uptodate_or_lock(bh)) {
> -		if (ext4_read_bh(bh, 0, NULL) < 0) {
> +		if (ext4_read_bh(bh, 0, NULL, false) < 0) {
>  			brelse(bh);
>  			return NULL;
>  		}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b77acba4a719..acce6644c1fc 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -161,8 +161,14 @@ MODULE_ALIAS("ext3");
>  
>  
>  static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> -				  bh_end_io_t *end_io)
> +				  bh_end_io_t *end_io, bool simu_fail)
>  {
> +	if (simu_fail) {
> +		clear_buffer_uptodate(bh);
> +		unlock_buffer(bh);
> +		return;
> +	}
> +
>  	/*
>  	 * buffer's verified bit is no longer valid after reading from
>  	 * disk again due to write out error, clear it to make sure we
> @@ -176,7 +182,7 @@ static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
>  }
>  
>  void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
> -			 bh_end_io_t *end_io)
> +			 bh_end_io_t *end_io, bool simu_fail)
>  {
>  	BUG_ON(!buffer_locked(bh));
>  
> @@ -184,10 +190,11 @@ void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
>  		unlock_buffer(bh);
>  		return;
>  	}
> -	__ext4_read_bh(bh, op_flags, end_io);
> +	__ext4_read_bh(bh, op_flags, end_io, simu_fail);
>  }
>  
> -int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io)
> +int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> +		 bh_end_io_t *end_io, bool simu_fail)
>  {
>  	BUG_ON(!buffer_locked(bh));
>  
> @@ -196,7 +203,7 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io
>  		return 0;
>  	}
>  
> -	__ext4_read_bh(bh, op_flags, end_io);
> +	__ext4_read_bh(bh, op_flags, end_io, simu_fail);
>  
>  	wait_on_buffer(bh);
>  	if (buffer_uptodate(bh))
> @@ -208,10 +215,10 @@ int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
>  {
>  	lock_buffer(bh);
>  	if (!wait) {
> -		ext4_read_bh_nowait(bh, op_flags, NULL);
> +		ext4_read_bh_nowait(bh, op_flags, NULL, false);
>  		return 0;
>  	}
> -	return ext4_read_bh(bh, op_flags, NULL);
> +	return ext4_read_bh(bh, op_flags, NULL, false);
>  }
>  
>  /*
> @@ -266,7 +273,7 @@ void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
>  
>  	if (likely(bh)) {
>  		if (trylock_buffer(bh))
> -			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL);
> +			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL, false);
>  		brelse(bh);
>  	}
>  }
> -- 
> 2.39.2
> 

