Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948086F5A22
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjECOdQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjECOcz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:32:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B40A6E87;
        Wed,  3 May 2023 07:32:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A24A203FE;
        Wed,  3 May 2023 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRbyu4BrypJ0fB+AyDEiUn8W2f56WbgYQJ4Mm/aa9Uc=;
        b=1RVsvzqCgH/u7qWCRjoNnfJb4xJY5CA5zBacaDk+7PPV8o1mSADALamNAPWV3NfceXoYCN
        SR0368Mm2U5c0ljgt70QGTTFBCM9L2omEHaSJP6se9c/77Donf2tmDcehzKElTlbRtxNWl
        SGbbs7Ch/KRYgLY5if6LDNco3sVbX9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRbyu4BrypJ0fB+AyDEiUn8W2f56WbgYQJ4Mm/aa9Uc=;
        b=bCwU0RWV0wHfDiLE8Jfih9bvqu16xJoR5QZVM8muMX9WGIQR0WTghx8GWBZT19dcRj9D4n
        wkcIuSsiZAso2zDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F01AB1331F;
        Wed,  3 May 2023 14:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6BacOohwUmTARgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:32:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 93367A0744; Wed,  3 May 2023 16:32:40 +0200 (CEST)
Date:   Wed, 3 May 2023 16:32:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 10/12] ext4: make ext4_es_insert_delayed_block()
 return void
Message-ID: <20230503143240.d6juyv7hbgz3kbm5@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-11-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-11-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:44, Baokun Li wrote:
> Now it never fails when inserting a delay extent, so the return value in
> ext4_es_insert_delayed_block is no longer necessary, let it return void.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 10 ++++------
>  fs/ext4/extents_status.h |  4 ++--
>  fs/ext4/inode.c          | 10 ++--------
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 2a394c40f4b7..b12c5cfdf601 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -2020,11 +2020,9 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
>   * @lblk - logical block to be added
>   * @allocated - indicates whether a physical cluster has been allocated for
>   *              the logical cluster that contains the block
> - *
> - * Returns 0 on success, negative error code on failure.
>   */
> -int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> -				 bool allocated)
> +void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> +				  bool allocated)
>  {
>  	struct extent_status newes;
>  	int err1 = 0;
> @@ -2033,7 +2031,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status *es2 = NULL;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> -		return 0;
> +		return;
>  
>  	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
>  		 lblk, inode->i_ino);
> @@ -2075,7 +2073,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  
>  	ext4_es_print_tree(inode);
>  	ext4_print_pending_tree(inode);
> -	return 0;
> +	return;
>  }
>  
>  /*
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 526a68890aa6..c22edb931f1b 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -249,8 +249,8 @@ extern void ext4_exit_pending(void);
>  extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
>  extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
>  extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
> -extern int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> -					bool allocated);
> +extern void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> +					 bool allocated);
>  extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
>  					ext4_lblk_t len);
>  extern void ext4_clear_inode_es(struct inode *inode);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a0bfe77d5537..4221b2dafeb5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1641,9 +1641,8 @@ static void ext4_print_free_blocks(struct inode *inode)
>  static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> -	int ret;
> +	int ret = 0;
>  	bool allocated = false;
> -	bool reserved = false;
>  
>  	/*
>  	 * If the cluster containing lblk is shared with a delayed,
> @@ -1660,7 +1659,6 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  		ret = ext4_da_reserve_space(inode);
>  		if (ret != 0)   /* ENOSPC */
>  			goto errout;
> -		reserved = true;
>  	} else {   /* bigalloc */
>  		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
>  			if (!ext4_es_scan_clu(inode,
> @@ -1673,7 +1671,6 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  					ret = ext4_da_reserve_space(inode);
>  					if (ret != 0)   /* ENOSPC */
>  						goto errout;
> -					reserved = true;
>  				} else {
>  					allocated = true;
>  				}
> @@ -1683,10 +1680,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  		}
>  	}
>  
> -	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
> -	if (ret && reserved)
> -		ext4_da_release_space(inode, 1);
> -
> +	ext4_es_insert_delayed_block(inode, lblk, allocated);
>  errout:
>  	return ret;
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
