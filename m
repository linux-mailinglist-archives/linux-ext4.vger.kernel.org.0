Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AE6F5A25
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjECOde (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjECOdX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:33:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05E6A75;
        Wed,  3 May 2023 07:32:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C0524203FE;
        Wed,  3 May 2023 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMtTeLqPhEiSrB0bc7XZf0/fV91Qtybapef6pBuHK24=;
        b=AHGKo6CKWxN0K8HOnWQMzDg/JpyDkbKwMiXZ4PxTO32AjsRIxFmIYi50AQpO2obH+B6QP1
        bEV4tp7f3/FzzgzuPjgZPf1s0nvVYwYIzYk/FfTouvAm6852mgamDdqLwFMIwPF3AgN5s3
        xfmPt2oVOy8kRnhGf/PEsMV3jpFkT4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMtTeLqPhEiSrB0bc7XZf0/fV91Qtybapef6pBuHK24=;
        b=3MKsG9ojjAPhxje6+UdU9PvTrakuC7vn8jFu2U8Pvq6ahnhzSC/ARzkJfctT1g/hG4LLBM
        VIL9QMHDEDEsRqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B06A51331F;
        Wed,  3 May 2023 14:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F+QPK5VwUmTcRgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:32:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2709DA0744; Wed,  3 May 2023 16:32:53 +0200 (CEST)
Date:   Wed, 3 May 2023 16:32:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 11/12] ext4: make ext4_es_insert_extent() return void
Message-ID: <20230503143253.6tf5a73ahj625r2y@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-12-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-12-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:45, Baokun Li wrote:
> Now ext4_es_insert_extent() never return error, so make it return void.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c        |  5 +++--
>  fs/ext4/extents_status.c | 14 ++++++--------
>  fs/ext4/extents_status.h |  6 +++---
>  fs/ext4/inode.c          | 21 ++++++---------------
>  4 files changed, 18 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e6695fec59af..d555ed924f37 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3136,8 +3136,9 @@ static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
>  	if (ee_len == 0)
>  		return 0;
>  
> -	return ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
> -				     EXTENT_STATUS_WRITTEN);
> +	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
> +			      EXTENT_STATUS_WRITTEN);
> +	return 0;
>  }
>  
>  /* FIXME!! we need to try to merge to left or right after zero-out  */
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index b12c5cfdf601..fcbfd2f26650 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -831,12 +831,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
>  /*
>   * ext4_es_insert_extent() adds information to an inode's extent
>   * status tree.
> - *
> - * Return 0 on success, error code on failure.
>   */
> -int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> -			  ext4_lblk_t len, ext4_fsblk_t pblk,
> -			  unsigned int status)
> +void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> +			   ext4_lblk_t len, ext4_fsblk_t pblk,
> +			   unsigned int status)
>  {
>  	struct extent_status newes;
>  	ext4_lblk_t end = lblk + len - 1;
> @@ -847,13 +845,13 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status *es2 = NULL;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> -		return 0;
> +		return;
>  
>  	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
>  		 lblk, len, pblk, status, inode->i_ino);
>  
>  	if (!len)
> -		return 0;
> +		return;
>  
>  	BUG_ON(end < lblk);
>  
> @@ -905,7 +903,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  		goto retry;
>  
>  	ext4_es_print_tree(inode);
> -	return 0;
> +	return;
>  }
>  
>  /*
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index c22edb931f1b..d9847a4a25db 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -127,9 +127,9 @@ extern int __init ext4_init_es(void);
>  extern void ext4_exit_es(void);
>  extern void ext4_es_init_tree(struct ext4_es_tree *tree);
>  
> -extern int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> -				 ext4_lblk_t len, ext4_fsblk_t pblk,
> -				 unsigned int status);
> +extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
> +				  ext4_lblk_t len, ext4_fsblk_t pblk,
> +				  unsigned int status);
>  extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  				 ext4_lblk_t len, ext4_fsblk_t pblk,
>  				 unsigned int status);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4221b2dafeb5..ffa40ce04c27 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -594,10 +594,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
>  				       map->m_lblk + map->m_len - 1))
>  			status |= EXTENT_STATUS_DELAYED;
> -		ret = ext4_es_insert_extent(inode, map->m_lblk,
> -					    map->m_len, map->m_pblk, status);
> -		if (ret < 0)
> -			retval = ret;
> +		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +				      map->m_pblk, status);
>  	}
>  	up_read((&EXT4_I(inode)->i_data_sem));
>  
> @@ -706,12 +704,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
>  				       map->m_lblk + map->m_len - 1))
>  			status |= EXTENT_STATUS_DELAYED;
> -		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -					    map->m_pblk, status);
> -		if (ret < 0) {
> -			retval = ret;
> -			goto out_sem;
> -		}
> +		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +				      map->m_pblk, status);
>  	}
>  
>  out_sem:
> @@ -1779,7 +1773,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  		set_buffer_new(bh);
>  		set_buffer_delay(bh);
>  	} else if (retval > 0) {
> -		int ret;
>  		unsigned int status;
>  
>  		if (unlikely(retval != map->m_len)) {
> @@ -1792,10 +1785,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  
>  		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -					    map->m_pblk, status);
> -		if (ret != 0)
> -			retval = ret;
> +		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +				      map->m_pblk, status);
>  	}
>  
>  out_unlock:
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
