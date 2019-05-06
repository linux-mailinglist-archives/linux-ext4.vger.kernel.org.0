Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E550D14730
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfEFJIH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 May 2019 05:08:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:39082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbfEFJIH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 May 2019 05:08:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 52CCFAC5A;
        Mon,  6 May 2019 09:08:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C43D81E15CD; Mon,  6 May 2019 11:08:04 +0200 (CEST)
Date:   Mon, 6 May 2019 11:08:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: Check and fix tails of all bitmaps
Message-ID: <20190506090804.GA13191@quack2.suse.cz>
References: <20190328164218.19265-1-jack@suse.cz>
 <20190505182103.GB10038@mit.edu>
 <20190505214835.GC10038@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505214835.GC10038@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted!

On Sun 05-05-19 17:48:35, Theodore Ts'o wrote:
> Here's my proposed approach to solving the problem you've identified.

Thanks for the patch! It looks good to me and it's indeed somewhat cleaner
that what I've suggested. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

And yes, I forgot about running make check. Sorry for that.

								Honza

> From 6d0b48896247dc70b16482a8ff4123d570285a2a Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Sun, 5 May 2019 16:43:33 -0400
> Subject: [PATCH] e2fsck: check and fix tails of all bitmap blocks
> 
> Currently, e2fsck effectively checks only tail of the last inode and
> block bitmap in the filesystem. Thus if some previous bitmap has unset
> bits it goes unnoticed.  Mostly these tail bits in the bitmap are
> ignored; however, if blocks_per_group are smaller than 8*blocksize,
> the multi-block allocator in the kernel can get confused when the tail
> bits are unset and return bogus free extent.
> 
> Add support to libext2fs to check these bitmap tails when loading
> bitmaps (as that's about the only place which has access to the bitmap
> tail bits) and make e2fsck use this functionality to detect buggy bitmap
> tails and fix them (by rewriting the bitmaps).
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  e2fsck/pass5.c                                | 40 ++++++++++++++++---
>  lib/ext2fs/ext2fs.h                           |  2 +
>  lib/ext2fs/rw_bitmaps.c                       | 26 +++++++++++-
>  tests/f_bitmaps/expect.1                      |  2 +
>  tests/f_dup/expect.1                          |  2 +
>  tests/f_dup2/expect.1                         |  2 +
>  tests/f_dup3/expect.1                         |  2 +
>  tests/f_end-bitmap/expect.1                   |  2 +
>  tests/f_illbbitmap/expect.1                   |  2 +
>  tests/f_illibitmap/expect.1                   |  2 +
>  tests/f_illitable_flexbg/expect.1             |  2 +
>  tests/f_lpf/expect.1                          |  2 +
>  tests/f_overfsblks/expect.1                   |  2 +
>  tests/f_super_bad_csum/expect.1               |  4 +-
>  tests/j_corrupt_ext_jnl_sb_csum/expect        |  2 +
>  tests/j_ext_long_trans/expect                 |  2 +
>  tests/j_long_trans/expect                     |  2 +
>  tests/j_long_trans_mcsum_32bit/expect         |  2 +
>  tests/j_long_trans_mcsum_64bit/expect         |  2 +
>  tests/j_recover_csum2_32bit/expect.1          |  2 +
>  tests/j_recover_csum2_64bit/expect.1          |  2 +
>  tests/j_short_trans/expect                    |  2 +
>  tests/j_short_trans_64bit/expect              |  2 +
>  tests/j_short_trans_mcsum_64bit/expect        |  2 +
>  tests/j_short_trans_old_csum/expect           |  2 +
>  tests/j_short_trans_open_recover/expect       |  2 +
>  tests/j_short_trans_recover/expect            |  2 +
>  .../j_short_trans_recover_mcsum_64bit/expect  |  2 +
>  tests/t_replay_and_set/expect                 |  2 +
>  29 files changed, 113 insertions(+), 9 deletions(-)
> 
> diff --git a/e2fsck/pass5.c b/e2fsck/pass5.c
> index 7803e8b80..810090970 100644
> --- a/e2fsck/pass5.c
> +++ b/e2fsck/pass5.c
> @@ -838,6 +838,7 @@ static void check_inode_end(e2fsck_t ctx)
>  	ext2_filsys fs = ctx->fs;
>  	ext2_ino_t	end, save_inodes_count, i;
>  	struct problem_context	pctx;
> +	int asked = 0;
>  
>  	clear_problem_context(&pctx);
>  
> @@ -851,11 +852,12 @@ static void check_inode_end(e2fsck_t ctx)
>  		return;
>  	}
>  	if (save_inodes_count == end)
> -		return;
> +		goto check_intra_bg_tail;
>  
>  	/* protect loop from wrap-around if end is maxed */
>  	for (i = save_inodes_count + 1; i <= end && i > save_inodes_count; i++) {
>  		if (!ext2fs_test_inode_bitmap(fs->inode_map, i)) {
> +			asked = 1;
>  			if (fix_problem(ctx, PR_5_INODE_BMAP_PADDING, &pctx)) {
>  				for (; i <= end; i++)
>  					ext2fs_mark_inode_bitmap(fs->inode_map,
> @@ -875,6 +877,20 @@ static void check_inode_end(e2fsck_t ctx)
>  		ctx->flags |= E2F_FLAG_ABORT; /* fatal */
>  		return;
>  	}
> +	/*
> +	 * If the number of inodes per block group != blocksize, we
> +	 * can also have a potential problem with the tail bits in
> +	 * each individual inode bitmap block.  If there is a problem,
> +	 * it would have been noticed when the bitmap was loaded.  And
> +	 * fixing this is easy; all we need to do force the bitmap to
> +	 * be written back to disk.
> +	 */
> +check_intra_bg_tail:
> +	if (!asked && fs->flags & EXT2_FLAG_IBITMAP_TAIL_PROBLEM)
> +		if (fix_problem(ctx, PR_5_INODE_BMAP_PADDING, &pctx))
> +			ext2fs_mark_ib_dirty(fs);
> +		else
> +			ext2fs_unmark_valid(fs);
>  }
>  
>  static void check_block_end(e2fsck_t ctx)
> @@ -882,6 +898,7 @@ static void check_block_end(e2fsck_t ctx)
>  	ext2_filsys fs = ctx->fs;
>  	blk64_t	end, save_blocks_count, i;
>  	struct problem_context	pctx;
> +	int asked = 0;
>  
>  	clear_problem_context(&pctx);
>  
> @@ -896,12 +913,13 @@ static void check_block_end(e2fsck_t ctx)
>  		return;
>  	}
>  	if (save_blocks_count == end)
> -		return;
> +		goto check_intra_bg_tail;
>  
>  	/* Protect loop from wrap-around if end is maxed */
>  	for (i = save_blocks_count + 1; i <= end && i > save_blocks_count; i++) {
>  		if (!ext2fs_test_block_bitmap2(fs->block_map,
>  					       EXT2FS_C2B(fs, i))) {
> +			asked = 1;
>  			if (fix_problem(ctx, PR_5_BLOCK_BMAP_PADDING, &pctx)) {
>  				for (; i <= end; i++)
>  					ext2fs_mark_block_bitmap2(fs->block_map,
> @@ -921,7 +939,19 @@ static void check_block_end(e2fsck_t ctx)
>  		ctx->flags |= E2F_FLAG_ABORT; /* fatal */
>  		return;
>  	}
> +	/*
> +	 * If the number of blocks per block group != blocksize, we
> +	 * can also have a potential problem with the tail bits in
> +	 * each individual block bitmap block.  If there is a problem,
> +	 * it would have been noticed when the bitmap was loaded.  And
> +	 * fixing this is easy; all we need to do force the bitmap to
> +	 * be written back to disk.
> +	 */
> +check_intra_bg_tail:
> +	if (!asked && fs->flags & EXT2_FLAG_BBITMAP_TAIL_PROBLEM) {
> +		if (fix_problem(ctx, PR_5_BLOCK_BMAP_PADDING, &pctx))
> +			ext2fs_mark_bb_dirty(fs);
> +		else
> +			ext2fs_unmark_valid(fs);
> +	}
>  }
> -
> -
> -
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 7d7c346df..59fd97426 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -204,6 +204,8 @@ typedef struct ext2_file *ext2_file_t;
>  #define EXT2_FLAG_IGNORE_CSUM_ERRORS	0x200000
>  #define EXT2_FLAG_SHARE_DUP		0x400000
>  #define EXT2_FLAG_IGNORE_SB_ERRORS	0x800000
> +#define EXT2_FLAG_BBITMAP_TAIL_PROBLEM	0x1000000
> +#define EXT2_FLAG_IBITMAP_TAIL_PROBLEM	0x2000000
>  
>  /*
>   * Special flag in the ext2 inode i_flag field that means that this is
> diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
> index e86bacd53..27c684d62 100644
> --- a/lib/ext2fs/rw_bitmaps.c
> +++ b/lib/ext2fs/rw_bitmaps.c
> @@ -195,6 +195,16 @@ static errcode_t mark_uninit_bg_group_blocks(ext2_filsys fs)
>  	return 0;
>  }
>  
> +static int bitmap_tail_verify(unsigned char *bitmap, int first, int last)
> +{
> +	int i;
> +
> +	for (i = first; i <= last; i++)
> +		if (bitmap[i] != 0xff)
> +			return 0;
> +	return 1;
> +}
> +
>  static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
>  {
>  	dgrp_t i;
> @@ -203,6 +213,7 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
>  	errcode_t retval;
>  	int block_nbytes = EXT2_CLUSTERS_PER_GROUP(fs->super) / 8;
>  	int inode_nbytes = EXT2_INODES_PER_GROUP(fs->super) / 8;
> +	int tail_flags = 0;
>  	int csum_flag;
>  	unsigned int	cnt;
>  	blk64_t	blk;
> @@ -315,6 +326,9 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
>  					EXT2_ET_BLOCK_BITMAP_CSUM_INVALID;
>  					goto cleanup;
>  				}
> +				if (!bitmap_tail_verify(block_bitmap,
> +							block_nbytes, fs->blocksize - 1))
> +					tail_flags |= EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
>  			} else
>  				memset(block_bitmap, 0, block_nbytes);
>  			cnt = block_nbytes << 3;
> @@ -347,6 +361,9 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
>  					EXT2_ET_INODE_BITMAP_CSUM_INVALID;
>  					goto cleanup;
>  				}
> +				if (!bitmap_tail_verify(inode_bitmap,
> +							inode_nbytes, fs->blocksize - 1))
> +					tail_flags |= EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
>  			} else
>  				memset(inode_bitmap, 0, inode_nbytes);
>  			cnt = inode_nbytes << 3;
> @@ -366,10 +383,15 @@ static errcode_t read_bitmaps(ext2_filsys fs, int do_inode, int do_block)
>  	}
>  
>  success_cleanup:
> -	if (inode_bitmap)
> +	if (inode_bitmap) {
>  		ext2fs_free_mem(&inode_bitmap);
> -	if (block_bitmap)
> +		fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
> +	}
> +	if (block_bitmap) {
>  		ext2fs_free_mem(&block_bitmap);
> +		fs->flags &= ~EXT2_FLAG_BBITMAP_TAIL_PROBLEM;
> +	}
> +	fs->flags |= tail_flags;
>  	return 0;
>  
>  cleanup:
> diff --git a/tests/f_bitmaps/expect.1 b/tests/f_bitmaps/expect.1
> index 715984d4d..2e91113db 100644
> --- a/tests/f_bitmaps/expect.1
> +++ b/tests/f_bitmaps/expect.1
> @@ -11,6 +11,8 @@ Fix? yes
>  Inode bitmap differences:  +11 -15
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/32 files (9.1% non-contiguous), 22/100 blocks
> diff --git a/tests/f_dup/expect.1 b/tests/f_dup/expect.1
> index 075e62c13..635a0dfc8 100644
> --- a/tests/f_dup/expect.1
> +++ b/tests/f_dup/expect.1
> @@ -30,6 +30,8 @@ Fix? yes
>  Free blocks count wrong (62, counted=60).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  Padding at end of block bitmap is not set. Fix? yes
>  
>  
> diff --git a/tests/f_dup2/expect.1 b/tests/f_dup2/expect.1
> index 69aa21b4b..04d7304b4 100644
> --- a/tests/f_dup2/expect.1
> +++ b/tests/f_dup2/expect.1
> @@ -37,6 +37,8 @@ Fix? yes
>  Free blocks count wrong (26, counted=22).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  Padding at end of block bitmap is not set. Fix? yes
>  
>  
> diff --git a/tests/f_dup3/expect.1 b/tests/f_dup3/expect.1
> index eab75a8dc..5f79cb891 100644
> --- a/tests/f_dup3/expect.1
> +++ b/tests/f_dup3/expect.1
> @@ -39,6 +39,8 @@ Fix? yes
>  Free blocks count wrong (20, counted=19).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 16/16 files (25.0% non-contiguous), 81/100 blocks
> diff --git a/tests/f_end-bitmap/expect.1 b/tests/f_end-bitmap/expect.1
> index 87e2fd647..85c7e67f4 100644
> --- a/tests/f_end-bitmap/expect.1
> +++ b/tests/f_end-bitmap/expect.1
> @@ -8,6 +8,8 @@ Pass 5: Checking group summary information
>  Free blocks count wrong for group #0 (44, counted=63).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  Padding at end of block bitmap is not set. Fix? yes
>  
>  
> diff --git a/tests/f_illbbitmap/expect.1 b/tests/f_illbbitmap/expect.1
> index 8746d23a5..40996cd61 100644
> --- a/tests/f_illbbitmap/expect.1
> +++ b/tests/f_illbbitmap/expect.1
> @@ -22,6 +22,8 @@ Fix? yes
>  Inode bitmap differences:  -(12--21)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/32 files (0.0% non-contiguous), 22/100 blocks
> diff --git a/tests/f_illibitmap/expect.1 b/tests/f_illibitmap/expect.1
> index 5bae25d14..bf21df7a7 100644
> --- a/tests/f_illibitmap/expect.1
> +++ b/tests/f_illibitmap/expect.1
> @@ -19,6 +19,8 @@ Pass 5: Checking group summary information
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/32 files (0.0% non-contiguous), 22/100 blocks
> diff --git a/tests/f_illitable_flexbg/expect.1 b/tests/f_illitable_flexbg/expect.1
> index fa42a0f8b..4ac124639 100644
> --- a/tests/f_illitable_flexbg/expect.1
> +++ b/tests/f_illitable_flexbg/expect.1
> @@ -18,6 +18,8 @@ Pass 5: Checking group summary information
>  Inode bitmap differences:  -(65--128)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 12/256 files (0.0% non-contiguous), 31163/32768 blocks
> diff --git a/tests/f_lpf/expect.1 b/tests/f_lpf/expect.1
> index 4f2853c5b..6ef996bb6 100644
> --- a/tests/f_lpf/expect.1
> +++ b/tests/f_lpf/expect.1
> @@ -42,6 +42,8 @@ Fix? yes
>  Free inodes count wrong (1, counted=0).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 16/16 files (12.5% non-contiguous), 67/100 blocks
> diff --git a/tests/f_overfsblks/expect.1 b/tests/f_overfsblks/expect.1
> index e5b93f0d5..bc8f2a879 100644
> --- a/tests/f_overfsblks/expect.1
> +++ b/tests/f_overfsblks/expect.1
> @@ -13,6 +13,8 @@ Pass 5: Checking group summary information
>  Inode bitmap differences:  -(12--21)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/32 files (0.0% non-contiguous), 22/100 blocks
> diff --git a/tests/f_super_bad_csum/expect.1 b/tests/f_super_bad_csum/expect.1
> index 25ced5c8a..12adee970 100644
> --- a/tests/f_super_bad_csum/expect.1
> +++ b/tests/f_super_bad_csum/expect.1
> @@ -5,8 +5,8 @@ Pass 2: Checking directory structure
>  Pass 3: Checking directory connectivity
>  Pass 4: Checking reference counts
>  Pass 5: Checking group summary information
> -Inode bitmap differences: Group 1 inode bitmap does not match checksum.
> -FIXED.
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/1024 files (0.0% non-contiguous), 1557/16384 blocks
> diff --git a/tests/j_corrupt_ext_jnl_sb_csum/expect b/tests/j_corrupt_ext_jnl_sb_csum/expect
> index 70a4fe721..4212a0007 100644
> --- a/tests/j_corrupt_ext_jnl_sb_csum/expect
> +++ b/tests/j_corrupt_ext_jnl_sb_csum/expect
> @@ -12,6 +12,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/128 files (0.0% non-contiguous), 66/2048 blocks
> diff --git a/tests/j_ext_long_trans/expect b/tests/j_ext_long_trans/expect
> index d379610e7..ea3c87fcb 100644
> --- a/tests/j_ext_long_trans/expect
> +++ b/tests/j_ext_long_trans/expect
> @@ -98,6 +98,8 @@ Fix? yes
>  Free inodes count wrong (16372, counted=16373).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/16384 files (0.0% non-contiguous), 6228/262144 blocks
> diff --git a/tests/j_long_trans/expect b/tests/j_long_trans/expect
> index 7a175414b..82b3caf17 100644
> --- a/tests/j_long_trans/expect
> +++ b/tests/j_long_trans/expect
> @@ -96,6 +96,8 @@ Fix? yes
>  Free inodes count wrong (16372, counted=16373).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  Recreate journal? yes
>  
>  Creating journal (8192 blocks):  Done.
> diff --git a/tests/j_long_trans_mcsum_32bit/expect b/tests/j_long_trans_mcsum_32bit/expect
> index a808d9f4d..ffae07a69 100644
> --- a/tests/j_long_trans_mcsum_32bit/expect
> +++ b/tests/j_long_trans_mcsum_32bit/expect
> @@ -135,6 +135,8 @@ Fix? yes
>  Free inodes count wrong (32756, counted=32757).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  Recreate journal? yes
>  
>  Creating journal (16384 blocks):  Done.
> diff --git a/tests/j_long_trans_mcsum_64bit/expect b/tests/j_long_trans_mcsum_64bit/expect
> index 76e109a42..e891def16 100644
> --- a/tests/j_long_trans_mcsum_64bit/expect
> +++ b/tests/j_long_trans_mcsum_64bit/expect
> @@ -134,6 +134,8 @@ Fix? yes
>  Free inodes count wrong (32756, counted=32757).
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  Recreate journal? yes
>  
>  Creating journal (16384 blocks):  Done.
> diff --git a/tests/j_recover_csum2_32bit/expect.1 b/tests/j_recover_csum2_32bit/expect.1
> index 491784a25..fdbda36e2 100644
> --- a/tests/j_recover_csum2_32bit/expect.1
> +++ b/tests/j_recover_csum2_32bit/expect.1
> @@ -10,6 +10,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/8192 files (0.0% non-contiguous), 7739/131072 blocks
> diff --git a/tests/j_recover_csum2_64bit/expect.1 b/tests/j_recover_csum2_64bit/expect.1
> index 491784a25..fdbda36e2 100644
> --- a/tests/j_recover_csum2_64bit/expect.1
> +++ b/tests/j_recover_csum2_64bit/expect.1
> @@ -10,6 +10,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/8192 files (0.0% non-contiguous), 7739/131072 blocks
> diff --git a/tests/j_short_trans/expect b/tests/j_short_trans/expect
> index bcc8fe82a..2bd0e5069 100644
> --- a/tests/j_short_trans/expect
> +++ b/tests/j_short_trans/expect
> @@ -32,6 +32,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/16384 files (0.0% non-contiguous), 5164/65536 blocks
> diff --git a/tests/j_short_trans_64bit/expect b/tests/j_short_trans_64bit/expect
> index f9971eba3..808dc61df 100644
> --- a/tests/j_short_trans_64bit/expect
> +++ b/tests/j_short_trans_64bit/expect
> @@ -34,6 +34,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/16384 files (0.0% non-contiguous), 5196/65536 blocks
> diff --git a/tests/j_short_trans_mcsum_64bit/expect b/tests/j_short_trans_mcsum_64bit/expect
> index d876ff095..d73e28297 100644
> --- a/tests/j_short_trans_mcsum_64bit/expect
> +++ b/tests/j_short_trans_mcsum_64bit/expect
> @@ -34,6 +34,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/32768 files (0.0% non-contiguous), 6353/131072 blocks
> diff --git a/tests/j_short_trans_old_csum/expect b/tests/j_short_trans_old_csum/expect
> index 29ac27fb3..6cf06d4a2 100644
> --- a/tests/j_short_trans_old_csum/expect
> +++ b/tests/j_short_trans_old_csum/expect
> @@ -34,6 +34,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/16384 files (0.0% non-contiguous), 5164/65536 blocks
> diff --git a/tests/j_short_trans_open_recover/expect b/tests/j_short_trans_open_recover/expect
> index be6e363dc..3e868197d 100644
> --- a/tests/j_short_trans_open_recover/expect
> +++ b/tests/j_short_trans_open_recover/expect
> @@ -37,6 +37,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/16384 files (0.0% non-contiguous), 5164/65536 blocks
> diff --git a/tests/j_short_trans_recover/expect b/tests/j_short_trans_recover/expect
> index 75867337f..508858c98 100644
> --- a/tests/j_short_trans_recover/expect
> +++ b/tests/j_short_trans_recover/expect
> @@ -34,6 +34,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/16384 files (0.0% non-contiguous), 5164/65536 blocks
> diff --git a/tests/j_short_trans_recover_mcsum_64bit/expect b/tests/j_short_trans_recover_mcsum_64bit/expect
> index 9cc330978..8c637f122 100644
> --- a/tests/j_short_trans_recover_mcsum_64bit/expect
> +++ b/tests/j_short_trans_recover_mcsum_64bit/expect
> @@ -36,6 +36,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/32768 files (0.0% non-contiguous), 6353/131072 blocks
> diff --git a/tests/t_replay_and_set/expect b/tests/t_replay_and_set/expect
> index f63a73af5..3e19d92e9 100644
> --- a/tests/t_replay_and_set/expect
> +++ b/tests/t_replay_and_set/expect
> @@ -30,6 +30,8 @@ Fix? yes
>  Inode bitmap differences:  +(1--11)
>  Fix? yes
>  
> +Padding at end of inode bitmap is not set. Fix? yes
> +
>  
>  test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
>  test_filesys: 11/16384 files (0.0% non-contiguous), 5164/65536 blocks
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
