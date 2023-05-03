Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA176F5A00
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjECO2m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjECO2l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:28:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277F710E7;
        Wed,  3 May 2023 07:28:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7786228E2;
        Wed,  3 May 2023 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLfZ5SGOBxMGr1OOefG31+NLkLh0UuwK3FQhM6ffc9U=;
        b=Ru3QQXap/+rKGJ7bBy+0HfH5rkRP/oBO6fk2jNd/x1BA8a8kH/R51KQWgxa5ksrQYImYTK
        OdKASuiU/Q1WY+VXFCeUod1l8VV/9dBXXswIhlVKuPy0pHkCRfrBzVLhiKP0Kbsor18wJR
        IjzBv08XIPFsDTBUp8Oa7mqmyuZ5J8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLfZ5SGOBxMGr1OOefG31+NLkLh0UuwK3FQhM6ffc9U=;
        b=FCnbsHtphG2e725EBT82NQhm45dCfahUwxT3rTeR5HwLxxIgCPbKoRlZttTTk2uFzgFv4i
        DI8s23wyjTww3JDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9B011331F;
        Wed,  3 May 2023 14:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kcdRLZZvUmRXRAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:28:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 603AFA0744; Wed,  3 May 2023 16:28:38 +0200 (CEST)
Date:   Wed, 3 May 2023 16:28:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 04/12] ext4: use pre-allocated es in
 __es_insert_extent()
Message-ID: <20230503142838.d4ijsruotb5l2xnp@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-5-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-5-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:38, Baokun Li wrote:
> Pass a extent_status pointer prealloc to __es_insert_extent(). If the
> pointer is non-null, it is used directly when a new extent_status is
> needed to avoid memory allocation failures.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 18665394392f..a6a62a744e83 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -144,7 +144,8 @@
>  static struct kmem_cache *ext4_es_cachep;
>  static struct kmem_cache *ext4_pending_cachep;
>  
> -static int __es_insert_extent(struct inode *inode, struct extent_status *newes);
> +static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
> +			      struct extent_status *prealloc);
>  static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  			      ext4_lblk_t end, int *reserved);
>  static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
> @@ -768,7 +769,8 @@ static inline void ext4_es_insert_extent_check(struct inode *inode,
>  }
>  #endif
>  
> -static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
> +static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
> +			      struct extent_status *prealloc)
>  {
>  	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
>  	struct rb_node **p = &tree->root.rb_node;
> @@ -808,7 +810,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
>  		}
>  	}
>  
> -	es = __es_alloc_extent(false);
> +	if (prealloc)
> +		es = prealloc;
> +	else
> +		es = __es_alloc_extent(false);
>  	if (!es)
>  		return -ENOMEM;
>  	ext4_es_init_extent(inode, es, newes->es_lblk, newes->es_len,
> @@ -868,7 +873,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (err != 0)
>  		goto error;
>  retry:
> -	err = __es_insert_extent(inode, &newes);
> +	err = __es_insert_extent(inode, &newes, NULL);
>  	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
>  					  128, EXT4_I(inode)))
>  		goto retry;
> @@ -918,7 +923,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
>  	if (!es || es->es_lblk > end)
> -		__es_insert_extent(inode, &newes);
> +		__es_insert_extent(inode, &newes, NULL);
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  }
>  
> @@ -1366,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  					orig_es.es_len - len2;
>  			ext4_es_store_pblock_status(&newes, block,
>  						    ext4_es_status(&orig_es));
> -			err = __es_insert_extent(inode, &newes);
> +			err = __es_insert_extent(inode, &newes, NULL);
>  			if (err) {
>  				es->es_lblk = orig_es.es_lblk;
>  				es->es_len = orig_es.es_len;
> @@ -2020,7 +2025,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  	if (err != 0)
>  		goto error;
>  retry:
> -	err = __es_insert_extent(inode, &newes);
> +	err = __es_insert_extent(inode, &newes, NULL);
>  	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
>  					  128, EXT4_I(inode)))
>  		goto retry;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
