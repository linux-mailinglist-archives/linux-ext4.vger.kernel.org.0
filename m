Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C56DFE0C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDLSxJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLSxI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 14:53:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D4448E;
        Wed, 12 Apr 2023 11:53:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14DFB1F897;
        Wed, 12 Apr 2023 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681325582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NoJuuPHusjWYqJpucbjWDE4VQjaPrsb2cW/zYaxPyHM=;
        b=25OuvUbRwWD7a5bc7mUsFCY+SHOKuZN9UsvkQm3K4p6UdX65wwh6DR700DehzJPg2kFmEo
        wAd/2KeRUSXuSkMHFym06xChmxQLNPqB2BCtwJI2N6cWDQorVQEnboocYM4yPDQ+Ferose
        iE62q/1WiEk9dUHakcFCXG6j6GKSH2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681325582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NoJuuPHusjWYqJpucbjWDE4VQjaPrsb2cW/zYaxPyHM=;
        b=DlUtwFCoJ7O0K95fezvY2B1XmyKVSA7fyS2DwhZtnP6ubvBhCq7j1ID6w8nc+MW0stQEki
        QSkBQDpTtZOSRhCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D191613498;
        Wed, 12 Apr 2023 18:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m5gTMw3+NmS4CgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 18:53:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D06FDA0732; Wed, 12 Apr 2023 20:53:00 +0200 (CEST)
Date:   Wed, 12 Apr 2023 20:53:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 2/8] ext4: add a new helper to check if es must be kept
Message-ID: <20230412185300.rpfwdlxeiptqaxes@quack3>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
 <20230412124126.2286716-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412124126.2286716-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 12-04-23 20:41:20, Baokun Li wrote:
> A helper function is added to help determine if the current extent can
> be dropped, although only ext4_es_is_delayed() extents cannot be dropped
> currently.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Just some small suggestions below...

> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 7bc221038c6c..f9dab2510bdc 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -448,6 +448,20 @@ static void ext4_es_list_del(struct inode *inode)
>  	spin_unlock(&sbi->s_es_lock);
>  }
>  
> +/*
> + * Returns 1 indicates that we cannot fail to allocate memory for this
> + * extent_status and cannot reclaim, clear, or free the extent until
> + * its status changes.
> + */
> +static inline int ext4_es_must_keep(struct extent_status *es)

Maybe we can return bool? Also I'd rephrase the comment as:

/*
 * Returns true if we cannot fail to allocate memory for this extent_status
 * entry and cannot reclaim it until its status changes.
 */

> +{
> +	/* filemap, bigalloc, and seek_data/hole need to use it. */
> +	if (ext4_es_is_delayed(es))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static struct extent_status *
>  ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
>  		     ext4_fsblk_t pblk)
> @@ -460,10 +474,8 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
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
> @@ -481,8 +493,8 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
>  	EXT4_I(inode)->i_es_all_nr--;
>  	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
>  
> -	/* Decrease the shrink counter when this es is not delayed */
> -	if (!ext4_es_is_delayed(es)) {
> +	/* Decrease the shrink counter when this es is not a must be kept */

Let's rephrase the comment as:
	/* Decrease the shrink counter when we can reclaim the extent */

> +	if (!ext4_es_must_keep(es)) {
>  		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
>  		if (!--EXT4_I(inode)->i_es_shk_nr)
>  			ext4_es_list_del(inode);
> @@ -853,7 +865,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
>  					  128, EXT4_I(inode)))
>  		goto retry;
> -	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
> +	if (err == -ENOMEM && !ext4_es_must_keep(&newes))
>  		err = 0;
>  
>  	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
> @@ -1706,11 +1718,8 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
>  
>  		(*nr_to_scan)--;
>  		node = rb_next(&es->rb_node);
> -		/*
> -		 * We can't reclaim delayed extent from status tree because
> -		 * fiemap, bigallic, and seek_data/hole need to use it.
> -		 */
> -		if (ext4_es_is_delayed(es))
> +		/* We can't reclaim a must be kept extent from status tree. */

I guess we can just drop this comment. The function name explains enough...

> +		if (ext4_es_must_keep(es))
>  			goto next;
>  		if (ext4_es_is_referenced(es)) {
>  			ext4_es_clear_referenced(es);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
