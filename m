Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5186ADCFC
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 12:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCGLMA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 06:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCGLK6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 06:10:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A0238B6F;
        Tue,  7 Mar 2023 03:09:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C243421A1E;
        Tue,  7 Mar 2023 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678187371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPVjtFEFoKeVCsnaWAPI5uWSAFfz/Zzh1EQp1JLp9fk=;
        b=qQ6ObUuhd7rF3cOg4I844zfAGLpOz6txqKPnHuQdX5YCwlw7UgNqNXdykX6FELj9F1qeyn
        ELPpfc3zNBJtLS0qMgLM1uj9GHqd7zK6SzpZa/6dGjSeh26R/uOJaqr4cgz3T6zyijHCkU
        czL57Ll0zSGEYloLB4OgGR7AcMmrh4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678187371;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPVjtFEFoKeVCsnaWAPI5uWSAFfz/Zzh1EQp1JLp9fk=;
        b=Chzlbi+GkyZbwgCupbZNEfPJ5GVMPqBt67DGS858+ZS54JWqmIvjSOHCE6siXEBqL1GM4w
        qvEMK0doEOwy8oBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B378913440;
        Tue,  7 Mar 2023 11:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JnvNK2sbB2T/ewAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 07 Mar 2023 11:09:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3B7F4A06F3; Tue,  7 Mar 2023 12:09:31 +0100 (CET)
Date:   Tue, 7 Mar 2023 12:09:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 4/4] ext4: remove unused group parameter in
 ext4_block_bitmap_csum_set
Message-ID: <20230307110931.xmkl7ns4kuwoqw2f@quack3>
References: <20230221203027.2359920-1-shikemeng@huaweicloud.com>
 <20230221203027.2359920-5-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221203027.2359920-5-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-02-23 04:30:27, Kemeng Shi wrote:
> Remove unused group parameter in ext4_block_bitmap_csum_set. After this,
> group parameter in ext4_set_bitmap_checksums is also not used, just
> remove it too.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/bitmap.c  |  2 +-
>  fs/ext4/ext4.h    |  2 +-
>  fs/ext4/ialloc.c  |  6 ++----
>  fs/ext4/mballoc.c | 10 +++++-----
>  fs/ext4/resize.c  |  5 ++---
>  5 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
> index 3b83d979a650..87c1c8ae9298 100644
> --- a/fs/ext4/bitmap.c
> +++ b/fs/ext4/bitmap.c
> @@ -80,7 +80,7 @@ int ext4_block_bitmap_csum_verify(struct super_block *sb,
>  	return 0;
>  }
>  
> -void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
> +void ext4_block_bitmap_csum_set(struct super_block *sb,
>  				struct ext4_group_desc *gdp,
>  				struct buffer_head *bh)
>  {
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 04447640b4f4..3051dc8584d8 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2682,7 +2682,7 @@ void ext4_inode_bitmap_csum_set(struct super_block *sb,
>  int ext4_inode_bitmap_csum_verify(struct super_block *sb,
>  				  struct ext4_group_desc *gdp,
>  				  struct buffer_head *bh, int sz);
> -void ext4_block_bitmap_csum_set(struct super_block *sb, ext4_group_t group,
> +void ext4_block_bitmap_csum_set(struct super_block *sb,
>  				struct ext4_group_desc *gdp,
>  				struct buffer_head *bh);
>  int ext4_block_bitmap_csum_verify(struct super_block *sb,
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index b86756c57c0b..e4bad4b5145c 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -813,8 +813,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
>  			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
>  			ext4_free_group_clusters_set(sb, gdp,
>  				ext4_free_clusters_after_init(sb, group, gdp));
> -			ext4_block_bitmap_csum_set(sb, group, gdp,
> -						   block_bitmap_bh);
> +			ext4_block_bitmap_csum_set(sb, gdp, block_bitmap_bh);
>  			ext4_group_desc_csum_set(sb, group, gdp);
>  		}
>  		ext4_unlock_group(sb, group);
> @@ -1165,8 +1164,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
>  			ext4_free_group_clusters_set(sb, gdp,
>  				ext4_free_clusters_after_init(sb, group, gdp));
> -			ext4_block_bitmap_csum_set(sb, group, gdp,
> -						   block_bitmap_bh);
> +			ext4_block_bitmap_csum_set(sb, gdp, block_bitmap_bh);
>  			ext4_group_desc_csum_set(sb, group, gdp);
>  		}
>  		ext4_unlock_group(sb, group);
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..0d69cd8c5fc3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3822,7 +3822,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
>  	}
>  	len = ext4_free_group_clusters(sb, gdp) - ac->ac_b_ex.fe_len;
>  	ext4_free_group_clusters_set(sb, gdp, len);
> -	ext4_block_bitmap_csum_set(sb, ac->ac_b_ex.fe_group, gdp, bitmap_bh);
> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>  	ext4_group_desc_csum_set(sb, ac->ac_b_ex.fe_group, gdp);
>  
>  	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);
> @@ -3929,7 +3929,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
>  
>  		ext4_free_group_clusters_set(sb, gdp, clen);
> -		ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
> +		ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>  		ext4_group_desc_csum_set(sb, group, gdp);
>  
>  		ext4_unlock_group(sb, group);
> @@ -5861,7 +5861,7 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  	ext4_free_group_clusters_set(
>  		sb, gdp, ext4_free_group_clusters(sb, gdp) +
>  		count - already_freed);
> -	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>  	ext4_group_desc_csum_set(sb, group, gdp);
>  	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
>  	sync_dirty_buffer(bitmap_bh);
> @@ -6023,7 +6023,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>  
>  	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>  	ext4_free_group_clusters_set(sb, gdp, ret);
> -	ext4_block_bitmap_csum_set(sb, block_group, gdp, bitmap_bh);
> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>  	ext4_group_desc_csum_set(sb, block_group, gdp);
>  	ext4_unlock_group(sb, block_group);
>  
> @@ -6280,7 +6280,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
>  	free_clusters_count = clusters_freed +
>  		ext4_free_group_clusters(sb, desc);
>  	ext4_free_group_clusters_set(sb, desc, free_clusters_count);
> -	ext4_block_bitmap_csum_set(sb, block_group, desc, bitmap_bh);
> +	ext4_block_bitmap_csum_set(sb, desc, bitmap_bh);
>  	ext4_group_desc_csum_set(sb, block_group, desc);
>  	ext4_unlock_group(sb, block_group);
>  	percpu_counter_add(&sbi->s_freeclusters_counter,
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index 607a1af00665..0361c20910de 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -1306,7 +1306,6 @@ static struct buffer_head *ext4_get_bitmap(struct super_block *sb, __u64 block)
>  }
>  
>  static int ext4_set_bitmap_checksums(struct super_block *sb,
> -				     ext4_group_t group,
>  				     struct ext4_group_desc *gdp,
>  				     struct ext4_new_group_data *group_data)
>  {
> @@ -1325,7 +1324,7 @@ static int ext4_set_bitmap_checksums(struct super_block *sb,
>  	bh = ext4_get_bitmap(sb, group_data->block_bitmap);
>  	if (!bh)
>  		return -EIO;
> -	ext4_block_bitmap_csum_set(sb, group, gdp, bh);
> +	ext4_block_bitmap_csum_set(sb, gdp, bh);
>  	brelse(bh);
>  
>  	return 0;
> @@ -1363,7 +1362,7 @@ static int ext4_setup_new_descs(handle_t *handle, struct super_block *sb,
>  		memset(gdp, 0, EXT4_DESC_SIZE(sb));
>  		ext4_block_bitmap_set(sb, gdp, group_data->block_bitmap);
>  		ext4_inode_bitmap_set(sb, gdp, group_data->inode_bitmap);
> -		err = ext4_set_bitmap_checksums(sb, group, gdp, group_data);
> +		err = ext4_set_bitmap_checksums(sb, gdp, group_data);
>  		if (err) {
>  			ext4_std_error(sb, err);
>  			break;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
