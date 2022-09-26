Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDC5E9BC5
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 10:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiIZIQd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 04:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiIZIQb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 04:16:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C9C237D0;
        Mon, 26 Sep 2022 01:16:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C719E1FAE8;
        Mon, 26 Sep 2022 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664180181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7tJvJmeVgcwGQymiuNAEIFNJSiUVLM6tuOUeD+Tp9U=;
        b=Ob+3cySAgqComu24MU8tjAIwe9RmZUh/RPHDeeT3d+z4f99RG+f5FlItmpy/BqzT0XMm/7
        MGmnjeBH3CV8zhUXIJlbzo9kffD5ZjQmGJZ0lodQAeXsMvIt0L+M6gKDMKI0W5JLu4F10M
        jMVPaWi66rnbyd9U2H+o4FXoF5F7uc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664180181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7tJvJmeVgcwGQymiuNAEIFNJSiUVLM6tuOUeD+Tp9U=;
        b=4TDXTaxvqOcLewGFFypQ4cFCt5qEaS2l6bHg5WlB0WKJa4sWHRbTLvnVVsIDZsLiI6Lb8Q
        pTNzC2W7+zDCdWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE1FF13486;
        Mon, 26 Sep 2022 08:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sQp6KtVfMWPQUQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 26 Sep 2022 08:16:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5227AA0685; Mon, 26 Sep 2022 10:16:21 +0200 (CEST)
Date:   Mon, 26 Sep 2022 10:16:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 2/2] ext4: factor out ext4_free_ext_path()
Message-ID: <20220926081621.w4hmrqhykxke3qif@quack3>
References: <20220924021211.3831551-1-yebin10@huawei.com>
 <20220924021211.3831551-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924021211.3831551-3-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 24-09-22 10:12:11, Ye Bin wrote:
> Factor out ext4_free_ext_path() to free extent path. As after previous patch
> 'ext4_ext_drop_refs()' is only used in 'extents.c', so make it static.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h           |   2 +-
>  fs/ext4/extents.c        | 107 ++++++++++++++++-----------------------
>  fs/ext4/extents_status.c |   3 +-
>  fs/ext4/fast_commit.c    |   6 +--
>  fs/ext4/migrate.c        |   3 +-
>  fs/ext4/move_extent.c    |   9 ++--
>  fs/ext4/verity.c         |   6 +--
>  7 files changed, 54 insertions(+), 82 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index e6674504ca2a..648ea9ccf65e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3713,7 +3713,7 @@ extern int ext4_ext_insert_extent(handle_t *, struct inode *,
>  extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
>  					      struct ext4_ext_path **,
>  					      int flags);
> -extern void ext4_ext_drop_refs(struct ext4_ext_path *);
> +extern void ext4_free_ext_path(struct ext4_ext_path *);
>  extern int ext4_ext_check_inode(struct inode *inode);
>  extern ext4_lblk_t ext4_ext_next_allocated_block(struct ext4_ext_path *path);
>  extern int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c148bb97b527..4653acfa1723 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -106,6 +106,25 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>  	return 0;
>  }
>  
> +static void ext4_ext_drop_refs(struct ext4_ext_path *path)
> +{
> +	int depth, i;
> +
> +	if (!path)
> +		return;
> +	depth = path->p_depth;
> +	for (i = 0; i <= depth; i++, path++) {
> +		brelse(path->p_bh);
> +		path->p_bh = NULL;
> +	}
> +}
> +
> +void ext4_free_ext_path(struct ext4_ext_path *path)
> +{
> +	ext4_ext_drop_refs(path);
> +	kfree(path);
> +}
> +
>  /*
>   * Make sure 'handle' has at least 'check_cred' credits. If not, restart
>   * transaction with 'restart_cred' credits. The function drops i_data_sem
> @@ -632,8 +651,7 @@ int ext4_ext_precache(struct inode *inode)
>  	ext4_set_inode_state(inode, EXT4_STATE_EXT_PRECACHED);
>  out:
>  	up_read(&ei->i_data_sem);
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	return ret;
>  }
>  
> @@ -720,19 +738,6 @@ static void ext4_ext_show_move(struct inode *inode, struct ext4_ext_path *path,
>  #define ext4_ext_show_move(inode, path, newblock, level)
>  #endif
>  
> -void ext4_ext_drop_refs(struct ext4_ext_path *path)
> -{
> -	int depth, i;
> -
> -	if (!path)
> -		return;
> -	depth = path->p_depth;
> -	for (i = 0; i <= depth; i++, path++) {
> -		brelse(path->p_bh);
> -		path->p_bh = NULL;
> -	}
> -}
> -
>  /*
>   * ext4_ext_binsearch_idx:
>   * binary search for the closest index of the given block
> @@ -951,8 +956,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>  	return path;
>  
>  err:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	if (orig_path)
>  		*orig_path = NULL;
>  	return ERR_PTR(ret);
> @@ -2170,8 +2174,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
>  	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
>  
>  cleanup:
> -	ext4_ext_drop_refs(npath);
> -	kfree(npath);
> +	ext4_free_ext_path(npath);
>  	return err;
>  }
>  
> @@ -3057,8 +3060,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  		}
>  	}
>  out:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	path = NULL;
>  	if (err == -EAGAIN)
>  		goto again;
> @@ -4371,8 +4373,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	allocated = map->m_len;
>  	ext4_ext_show_leaf(inode, path);
>  out:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  
>  	trace_ext4_ext_map_blocks_exit(inode, flags, map,
>  				       err ? err : allocated);
> @@ -5241,8 +5242,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  			break;
>  	}
>  out:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	return ret;
>  }
>  
> @@ -5534,15 +5534,13 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
>  		}
>  
> -		ext4_ext_drop_refs(path);
> -		kfree(path);
> +		ext4_free_ext_path(path);
>  		if (ret < 0) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			goto out_stop;
>  		}
>  	} else {
> -		ext4_ext_drop_refs(path);
> -		kfree(path);
> +		ext4_free_ext_path(path);
>  	}
>  
>  	ret = ext4_es_remove_extent(inode, offset_lblk,
> @@ -5762,10 +5760,8 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		count -= len;
>  
>  	repeat:
> -		ext4_ext_drop_refs(path1);
> -		kfree(path1);
> -		ext4_ext_drop_refs(path2);
> -		kfree(path2);
> +		ext4_free_ext_path(path1);
> +		ext4_free_ext_path(path2);
>  		path1 = path2 = NULL;
>  	}
>  	return replaced_count;
> @@ -5844,8 +5840,7 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>  	}
>  
>  out:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  
>  	return err ? err : mapped;
>  }
> @@ -5912,8 +5907,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  	ret = ext4_ext_dirty(NULL, inode, &path[path->p_depth]);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  out:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	ext4_mark_inode_dirty(NULL, inode);
>  	return ret;
>  }
> @@ -5931,8 +5925,7 @@ void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end)
>  			return;
>  		ex = path[path->p_depth].p_ext;
>  		if (!ex) {
> -			ext4_ext_drop_refs(path);
> -			kfree(path);
> +			ext4_free_ext_path(path);
>  			ext4_mark_inode_dirty(NULL, inode);
>  			return;
>  		}
> @@ -5945,8 +5938,7 @@ void ext4_ext_replay_shrink_inode(struct inode *inode, ext4_lblk_t end)
>  		ext4_ext_dirty(NULL, inode, &path[path->p_depth]);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  		ext4_mark_inode_dirty(NULL, inode);
> -		ext4_ext_drop_refs(path);
> -		kfree(path);
> +		ext4_free_ext_path(path);
>  	}
>  }
>  
> @@ -5985,13 +5977,11 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  		return PTR_ERR(path);
>  	ex = path[path->p_depth].p_ext;
>  	if (!ex) {
> -		ext4_ext_drop_refs(path);
> -		kfree(path);
> +		ext4_free_ext_path(path);
>  		goto out;
>  	}
>  	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  
>  	/* Count the number of data blocks */
>  	cur = 0;
> @@ -6021,30 +6011,26 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  	if (IS_ERR(path))
>  		goto out;
>  	numblks += path->p_depth;
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	while (cur < end) {
>  		path = ext4_find_extent(inode, cur, NULL, 0);
>  		if (IS_ERR(path))
>  			break;
>  		ex = path[path->p_depth].p_ext;
>  		if (!ex) {
> -			ext4_ext_drop_refs(path);
> -			kfree(path);
> +			ext4_free_ext_path(path);
>  			return 0;
>  		}
>  		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
>  					ext4_ext_get_actual_len(ex));
>  		ret = skip_hole(inode, &cur);
>  		if (ret < 0) {
> -			ext4_ext_drop_refs(path);
> -			kfree(path);
> +			ext4_free_ext_path(path);
>  			break;
>  		}
>  		path2 = ext4_find_extent(inode, cur, NULL, 0);
>  		if (IS_ERR(path2)) {
> -			ext4_ext_drop_refs(path);
> -			kfree(path);
> +			ext4_free_ext_path(path);
>  			break;
>  		}
>  		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
> @@ -6058,10 +6044,8 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  			if (cmp1 != cmp2 && cmp2 != 0)
>  				numblks++;
>  		}
> -		ext4_ext_drop_refs(path);
> -		ext4_ext_drop_refs(path2);
> -		kfree(path);
> -		kfree(path2);
> +		ext4_free_ext_path(path);
> +		ext4_free_ext_path(path2);
>  	}
>  
>  out:
> @@ -6088,13 +6072,11 @@ int ext4_ext_clear_bb(struct inode *inode)
>  		return PTR_ERR(path);
>  	ex = path[path->p_depth].p_ext;
>  	if (!ex) {
> -		ext4_ext_drop_refs(path);
> -		kfree(path);
> +		ext4_free_ext_path(path);
>  		return 0;
>  	}
>  	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  
>  	cur = 0;
>  	while (cur < end) {
> @@ -6113,8 +6095,7 @@ int ext4_ext_clear_bb(struct inode *inode)
>  					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
>  							0, path[j].p_block, 1, 1);
>  				}
> -				ext4_ext_drop_refs(path);
> -				kfree(path);
> +				ext4_free_ext_path(path);
>  			}
>  			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
>  			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 23167efda95e..cd0a861853e3 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -667,8 +667,7 @@ static void ext4_es_insert_extent_ext_check(struct inode *inode,
>  		}
>  	}
>  out:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  }
>  
>  static void ext4_es_insert_extent_ind_check(struct inode *inode,
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 067969f342eb..085cca17d72f 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1776,8 +1776,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			ret = ext4_ext_insert_extent(
>  				NULL, inode, &path, &newex, 0);
>  			up_write((&EXT4_I(inode)->i_data_sem));
> -			ext4_ext_drop_refs(path);
> -			kfree(path);
> +			ext4_free_ext_path(path);
>  			if (ret)
>  				goto out;
>  			goto next;
> @@ -1932,8 +1931,7 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>  					for (j = 0; j < path->p_depth; j++)
>  						ext4_mb_mark_bb(inode->i_sb,
>  							path[j].p_block, 1, 1);
> -					ext4_ext_drop_refs(path);
> -					kfree(path);
> +					ext4_free_ext_path(path);
>  				}
>  				cur += ret;
>  				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 54e7d3c95fd7..0a220ec9862d 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -56,8 +56,7 @@ static int finish_range(handle_t *handle, struct inode *inode,
>  	retval = ext4_ext_insert_extent(handle, inode, &path, &newext, 0);
>  err_out:
>  	up_write((&EXT4_I(inode)->i_data_sem));
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	lb->first_pblock = 0;
>  	return retval;
>  }
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 782bbda2a717..1f314eb6917d 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -32,8 +32,7 @@ get_ext_path(struct inode *inode, ext4_lblk_t lblock,
>  	if (IS_ERR(path))
>  		return PTR_ERR(path);
>  	if (path[ext_depth(inode)].p_ext == NULL) {
> -		ext4_ext_drop_refs(path);
> -		kfree(path);
> +		ext4_free_ext_path(path);
>  		*ppath = NULL;
>  		return -ENODATA;
>  	}
> @@ -106,8 +105,7 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
>  	}
>  	ret = 1;
>  out:
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	return ret;
>  }
>  
> @@ -693,8 +691,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		ext4_discard_preallocations(donor_inode, 0);
>  	}
>  
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  	ext4_double_up_write_data_sem(orig_inode, donor_inode);
>  	unlock_two_nondirectories(orig_inode, donor_inode);
>  
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index b051d19b5c8a..20cadfb740dc 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -298,16 +298,14 @@ static int ext4_get_verity_descriptor_location(struct inode *inode,
>  	last_extent = path[path->p_depth].p_ext;
>  	if (!last_extent) {
>  		EXT4_ERROR_INODE(inode, "verity file has no extents");
> -		ext4_ext_drop_refs(path);
> -		kfree(path);
> +		ext4_free_ext_path(path);
>  		return -EFSCORRUPTED;
>  	}
>  
>  	end_lblk = le32_to_cpu(last_extent->ee_block) +
>  		   ext4_ext_get_actual_len(last_extent);
>  	desc_size_pos = (u64)end_lblk << inode->i_blkbits;
> -	ext4_ext_drop_refs(path);
> -	kfree(path);
> +	ext4_free_ext_path(path);
>  
>  	if (desc_size_pos < sizeof(desc_size_disk))
>  		goto bad;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
