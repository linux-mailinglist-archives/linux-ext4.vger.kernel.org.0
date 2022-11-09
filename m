Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E6622F59
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Nov 2022 16:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKIPuE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 10:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiKIPuD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 10:50:03 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5415821
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 07:50:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76BAD1FB6E;
        Wed,  9 Nov 2022 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668009000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mt4TWki8fvDSxvMZJOt0dqQ+aslhgxwy50UaI9c8P9o=;
        b=PISaHOhJPopKgRe1dsUKo3jAJNtk6e2ZdQhpojPESxvzOh/XywNeYldp64TRm10VQM6kOX
        Ix1f9DaojfV2LtgLFv2cjFo0JrkiVprG6/3wQRxxZofbJPEAu9r5bAepdIKD39E+ICCC0o
        EvVtGJUHSDSgcaA4RRA6ubdYe17msTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668009000;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mt4TWki8fvDSxvMZJOt0dqQ+aslhgxwy50UaI9c8P9o=;
        b=jQHaAO7GIQwVHWLMLp1KowI6QQph/KY30asd7WfXOZq8tnYwXYb9gNvS1CCxrVzFrp6pRR
        S5tKTotS3txkmxBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68A351331F;
        Wed,  9 Nov 2022 15:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aPd8GSjMa2PhWQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 15:50:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EC180A0704; Wed,  9 Nov 2022 16:49:59 +0100 (CET)
Date:   Wed, 9 Nov 2022 16:49:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] ext4: replace kmem_cache_create with KMEM_CACHE
Message-ID: <20221109154959.r7at3nrsq6ydaypg@quack3>
References: <20221109153822.80250-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109153822.80250-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 09-11-22 07:38:22, JunChao Sun wrote:
> Replace kmem_cache_create with KMEM_CACHE macro that
> guaranteed struct alignment
> 
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>

Yeah, nice cleanups. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/extents_status.c | 8 ++------
>  fs/ext4/readpage.c       | 5 ++---
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index cd0a861853e3..97eccc0028a1 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -155,9 +155,7 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  
>  int __init ext4_init_es(void)
>  {
> -	ext4_es_cachep = kmem_cache_create("ext4_extent_status",
> -					   sizeof(struct extent_status),
> -					   0, (SLAB_RECLAIM_ACCOUNT), NULL);
> +	ext4_es_cachep = KMEM_CACHE(extent_status, SLAB_RECLAIM_ACCOUNT);
>  	if (ext4_es_cachep == NULL)
>  		return -ENOMEM;
>  	return 0;
> @@ -1807,9 +1805,7 @@ static void ext4_print_pending_tree(struct inode *inode)
>  
>  int __init ext4_init_pending(void)
>  {
> -	ext4_pending_cachep = kmem_cache_create("ext4_pending_reservation",
> -					   sizeof(struct pending_reservation),
> -					   0, (SLAB_RECLAIM_ACCOUNT), NULL);
> +	ext4_pending_cachep = KMEM_CACHE(pending_reservation, SLAB_RECLAIM_ACCOUNT);
>  	if (ext4_pending_cachep == NULL)
>  		return -ENOMEM;
>  	return 0;
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 3d21eae267fc..773176e7f9f5 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -410,9 +410,8 @@ int ext4_mpage_readpages(struct inode *inode,
>  
>  int __init ext4_init_post_read_processing(void)
>  {
> -	bio_post_read_ctx_cache =
> -		kmem_cache_create("ext4_bio_post_read_ctx",
> -				  sizeof(struct bio_post_read_ctx), 0, 0, NULL);
> +	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, SLAB_RECLAIM_ACCOUNT);
> +
>  	if (!bio_post_read_ctx_cache)
>  		goto fail;
>  	bio_post_read_ctx_pool =
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
