Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1776F585E
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjECM5Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjECM5W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 08:57:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB7440C4;
        Wed,  3 May 2023 05:57:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE7CB20370;
        Wed,  3 May 2023 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683118639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ywZW4KA66YanRzZlOjPAJk9IhT4ZoYG26yXIiVdKhUs=;
        b=jaMiw9i0/oM07slayRClD4SiGt05oIekEDsRTk+Exb6AP+DJj3q9vH8tDAIvtNXkibi6x7
        vqFAQBfUq+0GuXNhsdd6/rThgNpC9EOYFJIVFF3NbI28IlcvmEsJw1YxX7rVebp1exLy09
        lq9Xns5VGbZzUPhmpYlPPANDiweYXjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683118639;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ywZW4KA66YanRzZlOjPAJk9IhT4ZoYG26yXIiVdKhUs=;
        b=jJ8uQ1l+jXx2CXw0zEB0+FvZkm2FVb3PETBvR4ySEXg3vABWR6w4u53RNhD5mbpLbVUMcU
        TVyho9hI9j0jDzDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C09C713584;
        Wed,  3 May 2023 12:57:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WRAZLy9aUmRlDwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 12:57:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4CE6DA0744; Wed,  3 May 2023 14:57:19 +0200 (CEST)
Date:   Wed, 3 May 2023 14:57:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 02/12] ext4: add a new helper to check if es must be
 kept
Message-ID: <20230503125719.yu3cyfeg4ighaomd@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:36, Baokun Li wrote:
> In the extent status tree, we have extents which we can just drop without
> issues and extents we must not drop - this depends on the extent's status
> - currently ext4_es_is_delayed() extents must stay, others may be dropped.
> 
> A helper function is added to help determine if the current extent can
> be dropped, although only ext4_es_is_delayed() extents cannot be dropped
> currently.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 7bc221038c6c..573723b23d19 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -448,6 +448,19 @@ static void ext4_es_list_del(struct inode *inode)
>  	spin_unlock(&sbi->s_es_lock);
>  }
>  
> +/*
> + * Returns true if we cannot fail to allocate memory for this extent_status
> + * entry and cannot reclaim it until its status changes.
> + */
> +static inline bool ext4_es_must_keep(struct extent_status *es)
> +{
> +	/* fiemap, bigalloc, and seek_data/hole need to use it. */
> +	if (ext4_es_is_delayed(es))
> +		return true;
> +
> +	return false;
> +}
> +
>  static struct extent_status *
>  ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
>  		     ext4_fsblk_t pblk)
> @@ -460,10 +473,8 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
>  	es->es_len = len;
>  	es->es_pblk = pblk;
>  
> -	/*
> -	 * We don't count delayed extent because we never try to reclaim them
> -	 */
> -	if (!ext4_es_is_delayed(es)) {
> +	/* We never try to reclaim a must kept extent, so we don't count it. */
> +	if (!ext4_es_must_keep(es)) {
>  		if (!EXT4_I(inode)->i_es_shk_nr++)
>  			ext4_es_list_add(inode);
>  		percpu_counter_inc(&EXT4_SB(inode->i_sb)->
> @@ -481,8 +492,8 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
>  	EXT4_I(inode)->i_es_all_nr--;
>  	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
>  
> -	/* Decrease the shrink counter when this es is not delayed */
> -	if (!ext4_es_is_delayed(es)) {
> +	/* Decrease the shrink counter when we can reclaim the extent. */
> +	if (!ext4_es_must_keep(es)) {
>  		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
>  		if (!--EXT4_I(inode)->i_es_shk_nr)
>  			ext4_es_list_del(inode);
> @@ -853,7 +864,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
>  					  128, EXT4_I(inode)))
>  		goto retry;
> -	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
> +	if (err == -ENOMEM && !ext4_es_must_keep(&newes))
>  		err = 0;
>  
>  	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
> @@ -1706,11 +1717,8 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
>  
>  		(*nr_to_scan)--;
>  		node = rb_next(&es->rb_node);
> -		/*
> -		 * We can't reclaim delayed extent from status tree because
> -		 * fiemap, bigallic, and seek_data/hole need to use it.
> -		 */
> -		if (ext4_es_is_delayed(es))
> +
> +		if (ext4_es_must_keep(es))
>  			goto next;
>  		if (ext4_es_is_referenced(es)) {
>  			ext4_es_clear_referenced(es);
> @@ -1774,7 +1782,7 @@ void ext4_clear_inode_es(struct inode *inode)
>  	while (node) {
>  		es = rb_entry(node, struct extent_status, rb_node);
>  		node = rb_next(node);
> -		if (!ext4_es_is_delayed(es)) {
> +		if (!ext4_es_must_keep(es)) {
>  			rb_erase(&es->rb_node, &tree->root);
>  			ext4_es_free_extent(inode, es);
>  		}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
