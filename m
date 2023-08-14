Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5377B702
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Aug 2023 12:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHNKqA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjHNKpu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 06:45:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE139D2;
        Mon, 14 Aug 2023 03:45:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85EA121983;
        Mon, 14 Aug 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692009947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SEvFlfURKPeX91uVKJ/YjGiS8OtY7OV2NakQ6oQmBA=;
        b=xNbNWoIx36iaGBYyT/c+jfd/jJBTba3rhjqwdX6D83IU79So7BERj1rwh0yNdcIzbCAlhv
        FvzuMe1n6csZx7derfxaY13kCIPtIdZ7x9vz4huU0YGYVg46D5fJiJQBvo5XD7p8uQSJXJ
        IsbkpsfgjsAQhqhLC+bkibLvmi3EfrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692009947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SEvFlfURKPeX91uVKJ/YjGiS8OtY7OV2NakQ6oQmBA=;
        b=/at3qJL4Zq93iAbTmqIEMQdbo/NheFunTuKeMmanZqsKI9Q/ESz/7uTdLCPVv027pKAuZa
        tMR9ZjHxWg/L51Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70D42138E2;
        Mon, 14 Aug 2023 10:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SnGDG9sF2mTdEQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 14 Aug 2023 10:45:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D69DBA0769; Mon, 14 Aug 2023 12:45:46 +0200 (CEST)
Date:   Mon, 14 Aug 2023 12:45:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com,
        Yikebaer Aizezi <yikebaer61@gmail.com>
Subject: Re: [PATCH] ext4: fix slab-use-after-free in ext4_es_insert_extent()
Message-ID: <20230814104546.xtjuoxu7jn3bysk3@quack3>
References: <20230814074351.96741-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814074351.96741-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 14-08-23 15:43:51, Baokun Li wrote:
> Yikebaer reported an issue:
> ==================================================================
> BUG: KASAN: slab-use-after-free in ext4_es_insert_extent+0xc68/0xcb0
> fs/ext4/extents_status.c:894
> Read of size 4 at addr ffff888112ecc1a4 by task syz-executor/8438
> 
> CPU: 1 PID: 8438 Comm: syz-executor Not tainted 6.5.0-rc5 #1
> Call Trace:
>  [...]
>  kasan_report+0xba/0xf0 mm/kasan/report.c:588
>  ext4_es_insert_extent+0xc68/0xcb0 fs/ext4/extents_status.c:894
>  ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
>  ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
>  ext4_zero_range fs/ext4/extents.c:4622 [inline]
>  ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
>  [...]
> 
> Allocated by task 8438:
>  [...]
>  kmem_cache_zalloc include/linux/slab.h:693 [inline]
>  __es_alloc_extent fs/ext4/extents_status.c:469 [inline]
>  ext4_es_insert_extent+0x672/0xcb0 fs/ext4/extents_status.c:873
>  ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
>  ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
>  ext4_zero_range fs/ext4/extents.c:4622 [inline]
>  ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
>  [...]
> 
> Freed by task 8438:
>  [...]
>  kmem_cache_free+0xec/0x490 mm/slub.c:3823
>  ext4_es_try_to_merge_right fs/ext4/extents_status.c:593 [inline]
>  __es_insert_extent+0x9f4/0x1440 fs/ext4/extents_status.c:802
>  ext4_es_insert_extent+0x2ca/0xcb0 fs/ext4/extents_status.c:882
>  ext4_map_blocks+0x92a/0x16f0 fs/ext4/inode.c:680
>  ext4_alloc_file_blocks.isra.0+0x2df/0xb70 fs/ext4/extents.c:4462
>  ext4_zero_range fs/ext4/extents.c:4622 [inline]
>  ext4_fallocate+0x251c/0x3ce0 fs/ext4/extents.c:4721
>  [...]
> ==================================================================
> 
> The flow of issue triggering is as follows:
> 1. remove es
>       raw es               es  removed  es1
> |-------------------| -> |----|.......|------|
> 
> 2. insert es
>   es   insert   es1      merge with es  es1     merge with es and free es1
> |----|.......|------| -> |------------|------| -> |-------------------|
> 
> es merges with newes, then merges with es1, frees es1, then determines
> if es1->es_len is 0 and triggers a UAF.
> 
> The code flow is as follows:
> ext4_es_insert_extent
>   es1 = __es_alloc_extent(true);
>   es2 = __es_alloc_extent(true);
>   __es_remove_extent(inode, lblk, end, NULL, es1)
>     __es_insert_extent(inode, &newes, es1) ---> insert es1 to es tree
>   __es_insert_extent(inode, &newes, es2)
>     ext4_es_try_to_merge_right
>       ext4_es_free_extent(inode, es1) --->  es1 is freed
>   if (es1 && !es1->es_len)
>     // Trigger UAF by determining if es1 is used.
> 
> We determine whether es1 or es2 is used immediately after calling
> __es_remove_extent() or __es_insert_extent() to avoid triggering a
> UAF if es1 or es2 is freed.
> 
> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>
> Closes: https://lore.kernel.org/lkml/CALcu4raD4h9coiyEBL4Bm0zjDwxC2CyPiTwsP3zFuhot6y9Beg@mail.gmail.com
> Fixes: 2a69c450083d ("ext4: using nofail preallocation in ext4_es_insert_extent()")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Good spotting!

> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 9b5b8951afb4..cceac517265f 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -878,23 +878,21 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
>  	if (err1 != 0)
>  		goto error;
> +	if (es1 && !es1->es_len)
> +		__es_free_extent(es1);

I'd prefer if you also set es1 to NULL after freeing es1. Something like:

	/* Free preallocated extent if it didn't get used. */
	if (es1) {
		if (!es1->es_len)
			__es_free_extent(es1);
		es1 = NULL;
	}

Currently I don't think there's a realistic case how we could trigger the
retry loop after we've once decided to preallocate entries but it just
makes the code more obvously correct. Similarly below for es2 and for the
cases in ext4_es_insert_delayed_block(). Thanks!

								Honza

>  
>  	err2 = __es_insert_extent(inode, &newes, es2);
>  	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
>  		err2 = 0;
>  	if (err2 != 0)
>  		goto error;
> +	if (es2 && !es2->es_len)
> +		__es_free_extent(es2);
>  
>  	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
>  	    (status & EXTENT_STATUS_WRITTEN ||
>  	     status & EXTENT_STATUS_UNWRITTEN))
>  		__revise_pending(inode, lblk, len);
> -
> -	/* es is pre-allocated but not used, free it. */
> -	if (es1 && !es1->es_len)
> -		__es_free_extent(es1);
> -	if (es2 && !es2->es_len)
> -		__es_free_extent(es2);
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  	if (err1 || err2)
> @@ -2047,19 +2045,17 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
>  	if (err1 != 0)
>  		goto error;
> +	if (es1 && !es1->es_len)
> +		__es_free_extent(es1);

The same 

>  
>  	err2 = __es_insert_extent(inode, &newes, es2);
>  	if (err2 != 0)
>  		goto error;
> +	if (es2 && !es2->es_len)
> +		__es_free_extent(es2);
>  
>  	if (allocated)
>  		__insert_pending(inode, lblk);
> -
> -	/* es is pre-allocated but not used, free it. */
> -	if (es1 && !es1->es_len)
> -		__es_free_extent(es1);
> -	if (es2 && !es2->es_len)
> -		__es_free_extent(es2);
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  	if (err1 || err2)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
