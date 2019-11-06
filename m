Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF9F1A41
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfKFPmj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 10:42:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:57660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728289AbfKFPmj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Nov 2019 10:42:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 008E6B1B2;
        Wed,  6 Nov 2019 15:42:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6CF471E4353; Wed,  6 Nov 2019 16:42:36 +0100 (CET)
Date:   Wed, 6 Nov 2019 16:42:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/5] ext2: code cleanup by calling
 ext2_group_last_block_no()
Message-ID: <20191106154236.GB12685@quack2.suse.cz>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
 <20191104114036.9893-2-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20191104114036.9893-2-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 04-11-19 19:40:33, Chengguang Xu wrote:
> Call common helper ext2_group_last_block_no() to
> calculate group last block number.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks for the patch! I've applied it (as well as 1/5) and added attached
simplification on top.

								Honza

> ---
>  fs/ext2/balloc.c | 16 ++++++++--------
>  fs/ext2/super.c  |  8 +-------
>  2 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 19bce75d207b..994a1fd18e93 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -269,7 +269,7 @@ goal_in_my_reservation(struct ext2_reserve_window *rsv, ext2_grpblk_t grp_goal,
>  	ext2_fsblk_t group_first_block, group_last_block;
>  
>  	group_first_block = ext2_group_first_block_no(sb, group);
> -	group_last_block = group_first_block + EXT2_BLOCKS_PER_GROUP(sb) - 1;
> +	group_last_block = ext2_group_last_block_no(sb, group);
>  
>  	if ((rsv->_rsv_start > group_last_block) ||
>  	    (rsv->_rsv_end < group_first_block))
> @@ -666,22 +666,22 @@ ext2_try_to_allocate(struct super_block *sb, int group,
>  			unsigned long *count,
>  			struct ext2_reserve_window *my_rsv)
>  {
> -	ext2_fsblk_t group_first_block;
> +	ext2_fsblk_t group_first_block = ext2_group_first_block_no(sb, group);
> +	ext2_fsblk_t group_last_block = ext2_group_last_block_no(sb, group);
>         	ext2_grpblk_t start, end;
>  	unsigned long num = 0;
>  
>  	/* we do allocation within the reservation window if we have a window */
>  	if (my_rsv) {
> -		group_first_block = ext2_group_first_block_no(sb, group);
>  		if (my_rsv->_rsv_start >= group_first_block)
>  			start = my_rsv->_rsv_start - group_first_block;
>  		else
>  			/* reservation window cross group boundary */
>  			start = 0;
>  		end = my_rsv->_rsv_end - group_first_block + 1;
> -		if (end > EXT2_BLOCKS_PER_GROUP(sb))
> +		if (end > group_last_block - group_first_block + 1)
>  			/* reservation window crosses group boundary */
> -			end = EXT2_BLOCKS_PER_GROUP(sb);
> +			end = group_last_block - group_first_block + 1;
>  		if ((start <= grp_goal) && (grp_goal < end))
>  			start = grp_goal;
>  		else
> @@ -691,7 +691,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
>  			start = grp_goal;
>  		else
>  			start = 0;
> -		end = EXT2_BLOCKS_PER_GROUP(sb);
> +		end = group_last_block - group_first_block + 1;
>  	}
>  
>  	BUG_ON(start > EXT2_BLOCKS_PER_GROUP(sb));
> @@ -907,7 +907,7 @@ static int alloc_new_reservation(struct ext2_reserve_window_node *my_rsv,
>  	spinlock_t *rsv_lock = &EXT2_SB(sb)->s_rsv_window_lock;
>  
>  	group_first_block = ext2_group_first_block_no(sb, group);
> -	group_end_block = group_first_block + (EXT2_BLOCKS_PER_GROUP(sb) - 1);
> +	group_end_block = ext2_group_last_block_no(sb, group);
>  
>  	if (grp_goal < 0)
>  		start_block = group_first_block;
> @@ -1114,7 +1114,7 @@ ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group,
>  	 * first block is the block number of the first block in this group
>  	 */
>  	group_first_block = ext2_group_first_block_no(sb, group);
> -	group_last_block = group_first_block + (EXT2_BLOCKS_PER_GROUP(sb) - 1);
> +	group_last_block = ext2_group_last_block_no(sb, group);
>  
>  	/*
>  	 * Basically we will allocate a new block from inode's reservation
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 30c630d73f0f..4cd401a2f207 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -702,13 +702,7 @@ static int ext2_check_descriptors(struct super_block *sb)
>  	for (i = 0; i < sbi->s_groups_count; i++) {
>  		struct ext2_group_desc *gdp = ext2_get_group_desc(sb, i, NULL);
>  		ext2_fsblk_t first_block = ext2_group_first_block_no(sb, i);
> -		ext2_fsblk_t last_block;
> -
> -		if (i == sbi->s_groups_count - 1)
> -			last_block = le32_to_cpu(sbi->s_es->s_blocks_count) - 1;
> -		else
> -			last_block = first_block +
> -				(EXT2_BLOCKS_PER_GROUP(sb) - 1);
> +		ext2_fsblk_t last_block = ext2_group_last_block_no(sb, i);
>  
>  		if (le32_to_cpu(gdp->bg_block_bitmap) < first_block ||
>  		    le32_to_cpu(gdp->bg_block_bitmap) > last_block)
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--Nq2Wo0NMKNjxTN9z
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-ext2-Simplify-initialization-in-ext2_try_to_allocate.patch"

From 33229f6f844afe29a76584922a1c705ba5e88717 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 6 Nov 2019 16:39:26 +0100
Subject: [PATCH] ext2: Simplify initialization in ext2_try_to_allocate()

Somewhat simplify the logic initializing search start and end in
ext2_try_to_allocate(). No functional change.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/balloc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 994a1fd18e93..65df001f4cc2 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -671,29 +671,17 @@ ext2_try_to_allocate(struct super_block *sb, int group,
        	ext2_grpblk_t start, end;
 	unsigned long num = 0;
 
+	start = 0;
+	end = group_last_block - group_first_block + 1;
 	/* we do allocation within the reservation window if we have a window */
 	if (my_rsv) {
 		if (my_rsv->_rsv_start >= group_first_block)
 			start = my_rsv->_rsv_start - group_first_block;
-		else
-			/* reservation window cross group boundary */
-			start = 0;
-		end = my_rsv->_rsv_end - group_first_block + 1;
-		if (end > group_last_block - group_first_block + 1)
-			/* reservation window crosses group boundary */
-			end = group_last_block - group_first_block + 1;
-		if ((start <= grp_goal) && (grp_goal < end))
-			start = grp_goal;
-		else
+		if (my_rsv->_rsv_end < group_last_block)
+			end = my_rsv->_rsv_end - group_first_block + 1;
+		if (grp_goal < start || grp_goal > end)
 			grp_goal = -1;
-	} else {
-		if (grp_goal > 0)
-			start = grp_goal;
-		else
-			start = 0;
-		end = group_last_block - group_first_block + 1;
 	}
-
 	BUG_ON(start > EXT2_BLOCKS_PER_GROUP(sb));
 
 repeat:
-- 
2.16.4


--Nq2Wo0NMKNjxTN9z--
