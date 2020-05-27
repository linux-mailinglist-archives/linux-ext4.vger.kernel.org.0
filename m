Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1912A1E3D71
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgE0JTz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 05:19:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56561 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725879AbgE0JTz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 05:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590571192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FUx1E8198CpcHrSZb1OhDIPDSTe2CL6u687qK4xt+54=;
        b=Nj3HPNdzcOsULo7ZKpVdQcE/UolVJj1jA14OI8Y0dKVUUagq1FxLku0ay3o2FB9NZPSHwd
        Qv2sAFFJi4V1uqjr/6K9uNYKGMHcjDB2vaPxt5FLHYUBWij1heCqIWGPHhiZmKTBJtSmqr
        6fXfpm69hkCHlKol5jiJMPQTUVdEt2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-cbTHob6IO3SUs5voN8ADXQ-1; Wed, 27 May 2020 05:19:46 -0400
X-MC-Unique: cbTHob6IO3SUs5voN8ADXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF7181005510;
        Wed, 27 May 2020 09:19:44 +0000 (UTC)
Received: from work (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07FD21C921;
        Wed, 27 May 2020 09:19:42 +0000 (UTC)
Date:   Wed, 27 May 2020 11:19:38 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
Message-ID: <20200527091938.647363ekmnz7av7y@work>
References: <1590565130-23773-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590565130-23773-1-git-send-email-wangshilong1991@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 27, 2020 at 04:38:50PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
> remounted, fstrim need walk all block groups again, the problem with
> this is FSTRIM could be slow on very large LUN SSD based filesystem.
> 
> To avoid this kind of problem, we introduce a block group flag
> EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
> extra one block group dirty write after trimming block group.

Hi

that's fair enough, however once you make this persistent we also need
to have a way to clear the flag, or at least bypass it. Storage can be
changed and if it does we might want to re-run the fstrim.

We also need to set this flag in mke2fs and e2fsck if appropriate.

more below...

> 
> And When clearing TRIMMED flag, block group will be journalled
> anyway, so it won't introduce any overhead.
> 
> Cc: Shuichi Ihara <sihara@ddn.com>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Wang Shilong <wangshilong1991@gmail.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  fs/ext4/ext4.h      | 18 +++++++--------
>  fs/ext4/ext4_jbd2.h |  3 ++-
>  fs/ext4/mballoc.c   | 54 ++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index ad2dbf6e4924..23c2dc529a28 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -357,6 +357,7 @@ struct flex_groups {
>  #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
>  #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
>  #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
> +#define EXT4_BG_WAS_TRIMMED	0x0008 /* block group was trimmed */
>  
>  /*
>   * Macro-instructions used to manage group descriptors
> @@ -3112,9 +3113,8 @@ struct ext4_group_info {
>  };
>  
>  #define EXT4_GROUP_INFO_NEED_INIT_BIT		0
> -#define EXT4_GROUP_INFO_WAS_TRIMMED_BIT		1
> -#define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	2
> -#define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	3
> +#define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	1
> +#define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	2
>  #define EXT4_GROUP_INFO_BBITMAP_CORRUPT		\
>  	(1 << EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT)
>  #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
> @@ -3127,12 +3127,12 @@ struct ext4_group_info {
>  #define EXT4_MB_GRP_IBITMAP_CORRUPT(grp)	\
>  	(test_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, &((grp)->bb_state)))
>  
> -#define EXT4_MB_GRP_WAS_TRIMMED(grp)	\
> -	(test_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> -#define EXT4_MB_GRP_SET_TRIMMED(grp)	\
> -	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> -#define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
> -	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
> +#define EXT4_MB_GDP_WAS_TRIMMED(gdp)	\
> +	(gdp->bg_flags & cpu_to_le16(EXT4_BG_WAS_TRIMMED))
> +#define EXT4_MB_GDP_SET_TRIMMED(gdp)	\
> +	(gdp->bg_flags |= cpu_to_le16(EXT4_BG_WAS_TRIMMED))
> +#define EXT4_MB_GDP_CLEAR_TRIMMED(gdp)	\
> +	(gdp->bg_flags &= ~cpu_to_le16(EXT4_BG_WAS_TRIMMED))
>  
>  #define EXT4_MAX_CONTENTION		8
>  #define EXT4_CONTENTION_THRESHOLD	2
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 4b9002f0e84c..4094a5b247f7 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -123,7 +123,8 @@
>  #define EXT4_HT_MOVE_EXTENTS     9
>  #define EXT4_HT_XATTR           10
>  #define EXT4_HT_EXT_CONVERT     11
> -#define EXT4_HT_MAX             12
> +#define EXT4_HT_FS_TRIM		12
> +#define EXT4_HT_MAX             13
>  
>  /**
>   *   struct ext4_journal_cb_entry - Base structure for callback information.
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 30d5d97548c4..d25377948994 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2829,15 +2829,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
>  	rb_erase(&entry->efd_node, &(db->bb_free_root));
>  	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, entry->efd_count);
>  
> -	/*
> -	 * Clear the trimmed flag for the group so that the next
> -	 * ext4_trim_fs can trim it.
> -	 * If the volume is mounted with -o discard, online discard
> -	 * is supported and the free blocks will be trimmed online.
> -	 */
> -	if (!test_opt(sb, DISCARD))
> -		EXT4_MB_GRP_CLEAR_TRIMMED(db);
> -
>  	if (!db->bb_free_root.rb_node) {
>  		/* No more items in the per group rb tree
>  		 * balance refcounts from ext4_mb_free_metadata()
> @@ -4928,8 +4919,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  					 " group:%d block:%d count:%lu failed"
>  					 " with %d", block_group, bit, count,
>  					 err);
> -		} else
> -			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
> +		}
>  
>  		ext4_lock_group(sb, block_group);
>  		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
> @@ -4939,6 +4929,14 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
>  	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>  	ext4_free_group_clusters_set(sb, gdp, ret);
>  	ext4_block_bitmap_csum_set(sb, block_group, gdp, bitmap_bh);
> +	/*
> +	 * Clear the trimmed flag for the group so that the next
> +	 * ext4_trim_fs can trim it.
> +	 * If the volume is mounted with -o discard, online discard
> +	 * is supported and the free blocks will be trimmed online.
> +	 */
> +	if (!test_opt(sb, DISCARD))
> +		EXT4_MB_GDP_CLEAR_TRIMMED(gdp);
>  	ext4_group_desc_csum_set(sb, block_group, gdp);
>  	ext4_unlock_group(sb, block_group);
>  
> @@ -5192,8 +5190,15 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>  	ext4_grpblk_t next, count = 0, free_count = 0;
>  	struct ext4_buddy e4b;
>  	int ret = 0;
> +	struct ext4_group_desc *gdp;
> +	struct buffer_head *gdp_bh;
>  
>  	trace_ext4_trim_all_free(sb, group, start, max);
> +	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> +	if (!gdp) {
> +		ret = -EIO;
> +		return ret;
> +	}
>  
>  	ret = ext4_mb_load_buddy(sb, group, &e4b);
>  	if (ret) {
> @@ -5204,7 +5209,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>  	bitmap = e4b.bd_bitmap;
>  
>  	ext4_lock_group(sb, group);
> -	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
> +	if (EXT4_MB_GDP_WAS_TRIMMED(gdp) &&
>  	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
>  		goto out;
>  
> @@ -5245,12 +5250,35 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>  
>  	if (!ret) {
>  		ret = count;
> -		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> +		EXT4_MB_GDP_SET_TRIMMED(gdp);
> +		ext4_group_desc_csum_set(sb, group, gdp);
>  	}
>  out:
>  	ext4_unlock_group(sb, group);
>  	ext4_mb_unload_buddy(&e4b);
> +	if (ret > 0) {
> +		int err;
> +		handle_t *handle;
>  
> +		handle = ext4_journal_start_sb(sb, EXT4_HT_FS_TRIM, 1);
> +		if (IS_ERR(handle)) {
> +			ret = PTR_ERR(handle);
> +			goto out_return;
> +		}
> +		err = ext4_journal_get_write_access(handle, gdp_bh);
> +		if (err) {
> +			ret = err;
> +			goto out_journal;
> +		}

Don't we need to do this before we set the flag in gdp?

-Lukas

> +		err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
> +		if (err)
> +			ret = err;
> +out_journal:
> +		err = ext4_journal_stop(handle);
> +		if (err)
> +			ret = err;
> +	}
> +out_return:
>  	ext4_debug("trimmed %d blocks in the group %d\n",
>  		count, group);
>  
> -- 
> 2.25.4
> 

