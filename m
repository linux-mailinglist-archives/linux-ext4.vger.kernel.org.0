Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112C07A4CDA
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjIRPmT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjIRPmM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 11:42:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C8114
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 08:40:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5706021DE8;
        Mon, 18 Sep 2023 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695051380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRRq3QBzHoyyDabxX2fOpYWedZIBCX58hRDwD2SKGsE=;
        b=pC07D0ypNc14vp5vJ/bRR9zET7HFzxs0iYszAJW4Cprmkr6bLfUkBLNDx3XllZP5JS616H
        KiuGlN+HScGJYBzenuIimVtj07dN2DPcl4v+GVf/1trLB7DJIq5lLUFQUL6Ee6JI3iFbfd
        5Xc5cFHbFnDwtEmhtGfGXpImV5KcWp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695051380;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRRq3QBzHoyyDabxX2fOpYWedZIBCX58hRDwD2SKGsE=;
        b=2c/xj3OvFpCA+ZHbq9hrXP/OXx3rurEmR0hWCUtvL2WX0l7FCKKVLivrhswk34pCM42AsK
        jBkj9umR6DIUe4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B22A1358A;
        Mon, 18 Sep 2023 15:36:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oh1NEnRuCGUeYAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 15:36:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D0A3CA0759; Mon, 18 Sep 2023 17:36:19 +0200 (CEST)
Date:   Mon, 18 Sep 2023 17:36:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     linux-ext4@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] ext4/mballoc: No need to generate from free list
Message-ID: <20230918153619.tku6d4556os5tvzj@quack3>
References: <tencent_53CBCB1668358AE862684E453DF37B722008@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_53CBCB1668358AE862684E453DF37B722008@qq.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-08-23 23:56:31, Wang Jianjian wrote:
> Commit 7a2fcbf7f85('ext4: don't use blocks freed but
> not yet committed in buddy cache init) walk the rbtree of
> freed data and mark them free in buddy to avoid reuse them
> before journal committing them, However, it is unnecessary to
> do that, because we have extra page references to buddy and bitmap
> pages, they will be released iff journal has committed and after
> process freed data.

So do you mean that buddy bitmap cannot be freed until the transaction that
frees the blocks in it commits? Indeed ext4_mb_free_metadata() grabs buddy
page references and ext4_free_data_in_buddy() drops them. 

Perhaps I'd rephrase the changelog as:

Commit 7a2fcbf7f85 ("ext4: don't use blocks freed but not yet committed in
buddy cache init") added a code to mark as used blocks in the list of not yet
committed freed blocks during initialization of a buddy page. However
ext4_mb_free_metadata() makes sure buddy page is already loaded and takes a
reference to it so it cannot happen that ext4_mb_init_cache() is called
when efd list is non-empty. Just remove the
ext4_mb_generate_from_freelist() call.

> @@ -1274,7 +1272,6 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
>  
>  			/* mark all preallocated blks used in in-core bitmap */
>  			ext4_mb_generate_from_pa(sb, data, group);
> -			ext4_mb_generate_from_freelist(sb, data, group);

And just to be sure I'd add here:

			WARN_ON_ONCE(!RB_EMPTY_ROOT(&grp->bb_free_root));

								Honza


>  			ext4_unlock_group(sb, group);
>  
>  			/* set incore so that the buddy information can be
> @@ -4440,30 +4437,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>  	return false;
>  }
>  
> -/*
> - * the function goes through all block freed in the group
> - * but not yet committed and marks them used in in-core bitmap.
> - * buddy must be generated from this bitmap
> - * Need to be called with the ext4 group lock held
> - */
> -static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
> -						ext4_group_t group)
> -{
> -	struct rb_node *n;
> -	struct ext4_group_info *grp;
> -	struct ext4_free_data *entry;
> -
> -	grp = ext4_get_group_info(sb, group);
> -	n = rb_first(&(grp->bb_free_root));
> -
> -	while (n) {
> -		entry = rb_entry(n, struct ext4_free_data, efd_node);
> -		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
> -		n = rb_next(n);
> -	}
> -	return;
> -}
> -
>  /*
>   * the function goes through all preallocation in this group and marks them
>   * used in in-core bitmap. buddy must be generated from this bitmap
> -- 
> 2.34.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
