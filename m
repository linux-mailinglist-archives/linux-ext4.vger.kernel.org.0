Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD98B78DAB8
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Aug 2023 20:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbjH3Sg7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Aug 2023 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbjH3NZK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Aug 2023 09:25:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C61A3
        for <linux-ext4@vger.kernel.org>; Wed, 30 Aug 2023 06:25:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8381921854;
        Wed, 30 Aug 2023 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693401904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0gAwfdiz2ST9pjtu/IWBx8WGqoW7x+yOXF4e3ouAFg=;
        b=ohjNjO2v66QVOXMJBqI00to2KkolcKgGlbs4v0yInpSy4dO+uSuIK8GJvPv0c/AovLjs+6
        tfzIRmmPDCYPdcsStAKZ5wF7bv56J5+Lz/o+ZOextZhx5WZIV7geFI334GHzq8IcYbj28x
        3+bts6PYwRpePsm1gknVcFPrIYJJ3eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693401904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0gAwfdiz2ST9pjtu/IWBx8WGqoW7x+yOXF4e3ouAFg=;
        b=bQ3ORtDuVovO7BDCzcz7IJTPgo8KqpKjGTVWhMA9VQqp5soS+Q+cywZCZl/OikqZe7M4Nw
        1+5llbLsNJWTZKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75F3B13441;
        Wed, 30 Aug 2023 13:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /SzDHDBD72TQZwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 30 Aug 2023 13:25:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F4087A0774; Wed, 30 Aug 2023 15:25:03 +0200 (CEST)
Date:   Wed, 30 Aug 2023 15:25:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH 02/16] ext4: make sure allocate pending entry not fail
Message-ID: <20230830132503.6xxgb4g7xi7n6lbr@quack3>
References: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
 <20230824092619.1327976-3-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824092619.1327976-3-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-08-23 17:26:05, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> __insert_pending() allocate memory in atomic context, so the allocation
> could fail, but we are not handling that failure now. It could lead
> ext4_es_remove_extent() to get wrong reserved clusters, and the global
> data blocks reservation count will be incorrect. The same to
> extents_status entry preallocation, preallocate pending entry out of the
> i_es_lock with __GFP_NOFAIL, make sure __insert_pending() and
> __revise_pending() always succeeds.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 123 ++++++++++++++++++++++++++++-----------
>  1 file changed, 89 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 5e625ea4545d..f4b50652f0cc 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -152,8 +152,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
>  static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
>  		       struct ext4_inode_info *locked_ei);
> -static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
> -			     ext4_lblk_t len);
> +static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
> +			    ext4_lblk_t len,
> +			    struct pending_reservation **prealloc);
>  
>  int __init ext4_init_es(void)
>  {
> @@ -448,6 +449,19 @@ static void ext4_es_list_del(struct inode *inode)
>  	spin_unlock(&sbi->s_es_lock);
>  }
>  
> +static inline struct pending_reservation *__alloc_pending(bool nofail)
> +{
> +	if (!nofail)
> +		return kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
> +
> +	return kmem_cache_zalloc(ext4_pending_cachep, GFP_KERNEL | __GFP_NOFAIL);
> +}
> +
> +static inline void __free_pending(struct pending_reservation *pr)
> +{
> +	kmem_cache_free(ext4_pending_cachep, pr);
> +}
> +
>  /*
>   * Returns true if we cannot fail to allocate memory for this extent_status
>   * entry and cannot reclaim it until its status changes.
> @@ -836,11 +850,12 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  {
>  	struct extent_status newes;
>  	ext4_lblk_t end = lblk + len - 1;
> -	int err1 = 0;
> -	int err2 = 0;
> +	int err1 = 0, err2 = 0, err3 = 0;
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct extent_status *es1 = NULL;
>  	struct extent_status *es2 = NULL;
> +	struct pending_reservation *pr = NULL;
> +	bool revise_pending = false;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
> @@ -868,11 +883,17 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	ext4_es_insert_extent_check(inode, &newes);
>  
> +	revise_pending = sbi->s_cluster_ratio > 1 &&
> +			 test_opt(inode->i_sb, DELALLOC) &&
> +			 (status & (EXTENT_STATUS_WRITTEN |
> +				    EXTENT_STATUS_UNWRITTEN));
>  retry:
>  	if (err1 && !es1)
>  		es1 = __es_alloc_extent(true);
>  	if ((err1 || err2) && !es2)
>  		es2 = __es_alloc_extent(true);
> +	if ((err1 || err2 || err3) && revise_pending && !pr)
> +		pr = __alloc_pending(true);
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  
>  	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
> @@ -897,13 +918,18 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  		es2 = NULL;
>  	}
>  
> -	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
> -	    (status & EXTENT_STATUS_WRITTEN ||
> -	     status & EXTENT_STATUS_UNWRITTEN))
> -		__revise_pending(inode, lblk, len);
> +	if (revise_pending) {
> +		err3 = __revise_pending(inode, lblk, len, &pr);
> +		if (err3 != 0)
> +			goto error;
> +		if (pr) {
> +			__free_pending(pr);
> +			pr = NULL;
> +		}
> +	}
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> -	if (err1 || err2)
> +	if (err1 || err2 || err3)
>  		goto retry;
>  
>  	ext4_es_print_tree(inode);
> @@ -1311,7 +1337,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  				rc->ndelonly--;
>  				node = rb_next(&pr->rb_node);
>  				rb_erase(&pr->rb_node, &tree->root);
> -				kmem_cache_free(ext4_pending_cachep, pr);
> +				__free_pending(pr);
>  				if (!node)
>  					break;
>  				pr = rb_entry(node, struct pending_reservation,
> @@ -1907,11 +1933,13 @@ static struct pending_reservation *__get_pending(struct inode *inode,
>   *
>   * @inode - file containing the cluster
>   * @lblk - logical block in the cluster to be added
> + * @prealloc - preallocated pending entry
>   *
>   * Returns 0 on successful insertion and -ENOMEM on failure.  If the
>   * pending reservation is already in the set, returns successfully.
>   */
> -static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
> +static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
> +			    struct pending_reservation **prealloc)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
> @@ -1937,10 +1965,15 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
>  		}
>  	}
>  
> -	pr = kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
> -	if (pr == NULL) {
> -		ret = -ENOMEM;
> -		goto out;
> +	if (likely(*prealloc == NULL)) {
> +		pr = __alloc_pending(false);
> +		if (!pr) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +	} else {
> +		pr = *prealloc;
> +		*prealloc = NULL;
>  	}
>  	pr->lclu = lclu;
>  
> @@ -1970,7 +2003,7 @@ static void __remove_pending(struct inode *inode, ext4_lblk_t lblk)
>  	if (pr != NULL) {
>  		tree = &EXT4_I(inode)->i_pending_tree;
>  		rb_erase(&pr->rb_node, &tree->root);
> -		kmem_cache_free(ext4_pending_cachep, pr);
> +		__free_pending(pr);
>  	}
>  }
>  
> @@ -2029,10 +2062,10 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  				  bool allocated)
>  {
>  	struct extent_status newes;
> -	int err1 = 0;
> -	int err2 = 0;
> +	int err1 = 0, err2 = 0, err3 = 0;
>  	struct extent_status *es1 = NULL;
>  	struct extent_status *es2 = NULL;
> +	struct pending_reservation *pr = NULL;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
> @@ -2052,6 +2085,8 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  		es1 = __es_alloc_extent(true);
>  	if ((err1 || err2) && !es2)
>  		es2 = __es_alloc_extent(true);
> +	if ((err1 || err2 || err3) && allocated && !pr)
> +		pr = __alloc_pending(true);
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  
>  	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
> @@ -2074,11 +2109,18 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  		es2 = NULL;
>  	}
>  
> -	if (allocated)
> -		__insert_pending(inode, lblk);
> +	if (allocated) {
> +		err3 = __insert_pending(inode, lblk, &pr);
> +		if (err3 != 0)
> +			goto error;
> +		if (pr) {
> +			__free_pending(pr);
> +			pr = NULL;
> +		}
> +	}
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> -	if (err1 || err2)
> +	if (err1 || err2 || err3)
>  		goto retry;
>  
>  	ext4_es_print_tree(inode);
> @@ -2184,21 +2226,24 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
>   * @inode - file containing the range
>   * @lblk - logical block defining the start of range
>   * @len  - length of range in blocks
> + * @prealloc - preallocated pending entry
>   *
>   * Used after a newly allocated extent is added to the extents status tree.
>   * Requires that the extents in the range have either written or unwritten
>   * status.  Must be called while holding i_es_lock.
>   */
> -static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
> -			     ext4_lblk_t len)
> +static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
> +			    ext4_lblk_t len,
> +			    struct pending_reservation **prealloc)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	ext4_lblk_t end = lblk + len - 1;
>  	ext4_lblk_t first, last;
>  	bool f_del = false, l_del = false;
> +	int ret = 0;
>  
>  	if (len == 0)
> -		return;
> +		return 0;
>  
>  	/*
>  	 * Two cases - block range within single cluster and block range
> @@ -2219,7 +2264,9 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
>  						first, lblk - 1);
>  		if (f_del) {
> -			__insert_pending(inode, first);
> +			ret = __insert_pending(inode, first, prealloc);
> +			if (ret < 0)
> +				goto out;
>  		} else {
>  			last = EXT4_LBLK_CMASK(sbi, end) +
>  			       sbi->s_cluster_ratio - 1;
> @@ -2227,9 +2274,11 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  				l_del = __es_scan_range(inode,
>  							&ext4_es_is_delonly,
>  							end + 1, last);
> -			if (l_del)
> -				__insert_pending(inode, last);
> -			else
> +			if (l_del) {
> +				ret = __insert_pending(inode, last, prealloc);
> +				if (ret < 0)
> +					goto out;
> +			} else
>  				__remove_pending(inode, last);
>  		}
>  	} else {
> @@ -2237,18 +2286,24 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  		if (first != lblk)
>  			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
>  						first, lblk - 1);
> -		if (f_del)
> -			__insert_pending(inode, first);
> -		else
> +		if (f_del) {
> +			ret = __insert_pending(inode, first, prealloc);
> +			if (ret < 0)
> +				goto out;
> +		} else
>  			__remove_pending(inode, first);
>  
>  		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
>  		if (last != end)
>  			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
>  						end + 1, last);
> -		if (l_del)
> -			__insert_pending(inode, last);
> -		else
> +		if (l_del) {
> +			ret = __insert_pending(inode, last, prealloc);
> +			if (ret < 0)
> +				goto out;
> +		} else
>  			__remove_pending(inode, last);
>  	}
> +out:
> +	return ret;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
