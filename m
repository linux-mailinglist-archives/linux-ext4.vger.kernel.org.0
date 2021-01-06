Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A62EBE34
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 14:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhAFNCz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 08:02:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:59982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbhAFNCy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Jan 2021 08:02:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DE7AADCD;
        Wed,  6 Jan 2021 13:02:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA28B1E0812; Wed,  6 Jan 2021 14:02:11 +0100 (CET)
Date:   Wed, 6 Jan 2021 14:02:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yi Li <yili@winhong.com>
Cc:     tytso@mit.edu, yilikernel@gmail.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use IS_ERR instead of IS_ERR_OR_NULL and set inode null
 when IS_ERR.
Message-ID: <20210106130211.GB29271@quack2.suse.cz>
References: <20201230033827.3996064-1-yili@winhong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230033827.3996064-1-yili@winhong.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 30-12-20 11:38:27, Yi Li wrote:
> 1: ext4_iget/ext4_find_extent never returns NULL, use IS_ERR
> instead of IS_ERR_OR_NULL to fix this.
> 
> 2: ext4_fc_replay_inode should set the inode to NULL when IS_ERR.
> and go to call iput properly.
> 
> Signed-off-by: Yi Li <yili@winhong.com>

Thanks for the patch! It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 4fcc21c25e79..6b5489273c85 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1318,14 +1318,14 @@ static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
>  	entry.len = darg.dname_len;
>  	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
>  
> -	if (IS_ERR_OR_NULL(inode)) {
> +	if (IS_ERR(inode)) {
>  		jbd_debug(1, "Inode %d not found", darg.ino);
>  		return 0;
>  	}
>  
>  	old_parent = ext4_iget(sb, darg.parent_ino,
>  				EXT4_IGET_NORMAL);
> -	if (IS_ERR_OR_NULL(old_parent)) {
> +	if (IS_ERR(old_parent)) {
>  		jbd_debug(1, "Dir with inode  %d not found", darg.parent_ino);
>  		iput(inode);
>  		return 0;
> @@ -1410,7 +1410,7 @@ static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl)
>  			darg.parent_ino, darg.dname_len);
>  
>  	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
> -	if (IS_ERR_OR_NULL(inode)) {
> +	if (IS_ERR(inode)) {
>  		jbd_debug(1, "Inode not found.");
>  		return 0;
>  	}
> @@ -1466,10 +1466,11 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
>  	trace_ext4_fc_replay(sb, tag, ino, 0, 0);
>  
>  	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
> -	if (!IS_ERR_OR_NULL(inode)) {
> +	if (!IS_ERR(inode)) {
>  		ext4_ext_clear_bb(inode);
>  		iput(inode);
>  	}
> +	inode = NULL;
>  
>  	ext4_fc_record_modified_inode(sb, ino);
>  
> @@ -1512,7 +1513,7 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
>  
>  	/* Given that we just wrote the inode on disk, this SHOULD succeed. */
>  	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
> -	if (IS_ERR_OR_NULL(inode)) {
> +	if (IS_ERR(inode)) {
>  		jbd_debug(1, "Inode not found.");
>  		return -EFSCORRUPTED;
>  	}
> @@ -1564,7 +1565,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
>  		goto out;
>  
>  	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
> -	if (IS_ERR_OR_NULL(inode)) {
> +	if (IS_ERR(inode)) {
>  		jbd_debug(1, "inode %d not found.", darg.ino);
>  		inode = NULL;
>  		ret = -EINVAL;
> @@ -1577,7 +1578,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
>  		 * dot and dot dot dirents are setup properly.
>  		 */
>  		dir = ext4_iget(sb, darg.parent_ino, EXT4_IGET_NORMAL);
> -		if (IS_ERR_OR_NULL(dir)) {
> +		if (IS_ERR(dir)) {
>  			jbd_debug(1, "Dir %d not found.", darg.ino);
>  			goto out;
>  		}
> @@ -1653,7 +1654,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  
>  	inode = ext4_iget(sb, le32_to_cpu(fc_add_ex->fc_ino),
>  				EXT4_IGET_NORMAL);
> -	if (IS_ERR_OR_NULL(inode)) {
> +	if (IS_ERR(inode)) {
>  		jbd_debug(1, "Inode not found.");
>  		return 0;
>  	}
> @@ -1777,7 +1778,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
>  		le32_to_cpu(lrange->fc_ino), cur, remaining);
>  
>  	inode = ext4_iget(sb, le32_to_cpu(lrange->fc_ino), EXT4_IGET_NORMAL);
> -	if (IS_ERR_OR_NULL(inode)) {
> +	if (IS_ERR(inode)) {
>  		jbd_debug(1, "Inode %d not found", le32_to_cpu(lrange->fc_ino));
>  		return 0;
>  	}
> @@ -1832,7 +1833,7 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>  	for (i = 0; i < state->fc_modified_inodes_used; i++) {
>  		inode = ext4_iget(sb, state->fc_modified_inodes[i],
>  			EXT4_IGET_NORMAL);
> -		if (IS_ERR_OR_NULL(inode)) {
> +		if (IS_ERR(inode)) {
>  			jbd_debug(1, "Inode %d not found.",
>  				state->fc_modified_inodes[i]);
>  			continue;
> @@ -1849,7 +1850,7 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>  
>  			if (ret > 0) {
>  				path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> -				if (!IS_ERR_OR_NULL(path)) {
> +				if (!IS_ERR(path)) {
>  					for (j = 0; j < path->p_depth; j++)
>  						ext4_mb_mark_bb(inode->i_sb,
>  							path[j].p_block, 1, 1);
> -- 
> 2.25.3
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
