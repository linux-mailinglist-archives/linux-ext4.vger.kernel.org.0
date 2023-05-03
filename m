Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23EB6F59FD
	for <lists+linux-ext4@lfdr.de>; Wed,  3 May 2023 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjECO2R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 May 2023 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjECO2N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 May 2023 10:28:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284565B84;
        Wed,  3 May 2023 07:28:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDCED222BF;
        Wed,  3 May 2023 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683124087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fu6b60Mx6ne7WksquAbUTz6ocKGQcg8fnknY3iq59bg=;
        b=O8vn2FHlLit91rT3YjW2FENQMuHFRb8UxrbgtmZ8Ho2Vu+K9eJDUJKQI6D+B54QWR9sM7e
        gNs5UwzFWjmqdqkxR/pnr1eVTD8aUJc4kmoW93OCYTO0sO6wqO3ZUSba7xhLonKlJaDzhO
        /fdLy/iB2NRuvRCPMRxLkNq7+eAgmuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683124087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fu6b60Mx6ne7WksquAbUTz6ocKGQcg8fnknY3iq59bg=;
        b=9juQGp475N3bw1k6SUuPRTBRQBPfshZX3rJ5AdW2AvtUg7IrVEoYVZVNF3Zfy2KE3c3uYL
        +SupOw9MLZbvzKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEF7B1331F;
        Wed,  3 May 2023 14:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +zGVLndvUmQERAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 03 May 2023 14:28:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4AB41A0744; Wed,  3 May 2023 16:28:07 +0200 (CEST)
Date:   Wed, 3 May 2023 16:28:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 03/12] ext4: factor out __es_alloc_extent() and
 __es_free_extent()
Message-ID: <20230503142807.uzp4d3apt2abbpmg@quack3>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-4-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424033846.4732-4-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 24-04-23 11:38:37, Baokun Li wrote:
> Factor out __es_alloc_extent() and __es_free_extent(), which only allocate
> and free extent_status in these two helpers.
> 
> The ext4_es_alloc_extent() function is split into __es_alloc_extent()
> and ext4_es_init_extent(). In __es_alloc_extent() we allocate memory using
> GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO if the memory allocation cannot
> fail, otherwise we use GFP_ATOMIC. and the ext4_es_init_extent() is used to
> initialize extent_status and update related variables after a successful
> allocation.
> 
> This is to prepare for the use of pre-allocated extent_status later.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 573723b23d19..18665394392f 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -461,14 +461,17 @@ static inline bool ext4_es_must_keep(struct extent_status *es)
>  	return false;
>  }
>  
> -static struct extent_status *
> -ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
> -		     ext4_fsblk_t pblk)
> +static inline struct extent_status *__es_alloc_extent(bool nofail)
> +{
> +	if (!nofail)
> +		return kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
> +
> +	return kmem_cache_zalloc(ext4_es_cachep, GFP_KERNEL | __GFP_NOFAIL);
> +}
> +
> +static void ext4_es_init_extent(struct inode *inode, struct extent_status *es,
> +		ext4_lblk_t lblk, ext4_lblk_t len, ext4_fsblk_t pblk)
>  {
> -	struct extent_status *es;
> -	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
> -	if (es == NULL)
> -		return NULL;
>  	es->es_lblk = lblk;
>  	es->es_len = len;
>  	es->es_pblk = pblk;
> @@ -483,8 +486,11 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
>  
>  	EXT4_I(inode)->i_es_all_nr++;
>  	percpu_counter_inc(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
> +}
>  
> -	return es;
> +static inline void __es_free_extent(struct extent_status *es)
> +{
> +	kmem_cache_free(ext4_es_cachep, es);
>  }
>  
>  static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
> @@ -501,7 +507,7 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
>  					s_es_stats.es_stats_shk_cnt);
>  	}
>  
> -	kmem_cache_free(ext4_es_cachep, es);
> +	__es_free_extent(es);
>  }
>  
>  /*
> @@ -802,10 +808,12 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
>  		}
>  	}
>  
> -	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
> -				  newes->es_pblk);
> +	es = __es_alloc_extent(false);
>  	if (!es)
>  		return -ENOMEM;
> +	ext4_es_init_extent(inode, es, newes->es_lblk, newes->es_len,
> +			    newes->es_pblk);
> +
>  	rb_link_node(&es->rb_node, parent, p);
>  	rb_insert_color(&es->rb_node, &tree->root);
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
