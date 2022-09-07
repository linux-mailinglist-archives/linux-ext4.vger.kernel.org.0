Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF875B04F3
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Sep 2022 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIGNPZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Sep 2022 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIGNO6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Sep 2022 09:14:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B728F220F4;
        Wed,  7 Sep 2022 06:14:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 969DE33918;
        Wed,  7 Sep 2022 13:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662556473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20S04/GX8fywwekR2znBquPlrtRvUVSM48fzA8fN7X0=;
        b=s/NeutT0fE41mkTGWOyLceqk+H60xyNz1wa1P9x2ardCP6i1t618JoHZdrdQPeq5bknFwJ
        v9BvO9PHj9S6qSD3Ki3XXPxtfrcr5jqRV2fKPalLp6y16rgXf8rAeDAZStrZdGXO9eIu8o
        /46r3WEQFjXPO5YpXxDSzAvQJHKTE4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662556473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=20S04/GX8fywwekR2znBquPlrtRvUVSM48fzA8fN7X0=;
        b=NG/w5m6OvFBTgTihOwzRhyC23qEayQlUVP+qG3u8ScV6uuznfD5+S7UYAtwEVsFBdwAxsG
        qPVYtuY+JEblQeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7318013486;
        Wed,  7 Sep 2022 13:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TC62GzmZGGMAFwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 07 Sep 2022 13:14:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A4502A067E; Wed,  7 Sep 2022 15:14:32 +0200 (CEST)
Date:   Wed, 7 Sep 2022 15:14:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-ext4@vger.kernel.org
Subject: Re: 307af6c879377 "mbcache: automatically delete entries from cache
 on freeing" ==> PREEMPT_RT grumble
Message-ID: <20220907131432.4i3bh3xt6egesv7g@quack3>
References: <9f593b8ac1b731cbbf92dc1c7b497b668752b325.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f593b8ac1b731cbbf92dc1c7b497b668752b325.camel@gmx.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Mike!

[added ext4 list to CC]

On Tue 06-09-22 18:21:37, Mike Galbraith wrote:
> diff --git a/fs/mbcache.c b/fs/mbcache.c
> index d1ebb5df2856..96f1d49d30a5 100644
> --- a/fs/mbcache.c
> +++ b/fs/mbcache.c
> @ -106,21 +106,28 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
>  		}
>  	}
>  	hlist_bl_add_head(&entry->e_hash_list, head);
> -	hlist_bl_unlock(head);
> -
> +	/*
> +	 * Add entry to LRU list before it can be found by
> +	 * mb_cache_entry_delete() to avoid races
> +	 */
>  	spin_lock(&cache->c_list_lock);
>  	list_add_tail(&entry->e_list, &cache->c_list);
> -	/* Grab ref for LRU list */
> -	atomic_inc(&entry->e_refcnt);
>  	cache->c_entry_count++;
>  	spin_unlock(&cache->c_list_lock);
> +	hlist_bl_unlock(head);
> 
>  	return 0;
>  }
>  EXPORT_SYMBOL(mb_cache_entry_create);
> 
> The above movement of hlist_bl_unlock() is a problem for RT wrt both
> taking and releasing of ->c_list_lock, it becoming an rtmutex in RT and
> hlist_bl_unlock() taking a preemption blocking bit spinlock.
> 
> Is that scope increase necessary?  If so, looks like ->c_list_lock
> could probably become a raw_spinlock_t without anyone noticing.

Well, it was an easy solution but there's relatively simple workaround that
should remove the need of nesting. I'll send a patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
