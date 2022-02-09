Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB14AF905
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 19:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiBISKN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 13:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiBISKN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 13:10:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D57C0613C9;
        Wed,  9 Feb 2022 10:10:15 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 549F41F395;
        Wed,  9 Feb 2022 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644430214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+QlHruA1VMM96Mcdhik82zAIxY8wzek2RoiBYk+ZHyg=;
        b=sEi+uC7WZVrXv4SGvq4AAVUxOmmsETE6xEb0U5GIJSL3ifI+uQmcRK6XW65LTp6jNHR7My
        Kpk6929V4xxrGHt7nNB3XqdUMEs+dwX9setLUQ8NWXjvH2LSM2ecrAFJyvAJoQ3QRT6Bz5
        keBK+THCgXiGUBzUmPG0lYrfpVuAh34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644430214;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+QlHruA1VMM96Mcdhik82zAIxY8wzek2RoiBYk+ZHyg=;
        b=lNxqalVGKwyzg9XoAIjeFFK6yGjOn/WUoE9eTX3XEavwg9kh1fAK+vdtiWdd9M4BgbbX6a
        SpIuRIHIRHjecACA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A1254A3B81;
        Wed,  9 Feb 2022 18:10:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F1AC4A05B5; Wed,  9 Feb 2022 19:10:10 +0100 (CET)
Date:   Wed, 9 Feb 2022 19:10:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <20220209181010.gfn66rvip56i54df@quack3.lan>
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209165742.5659-1-quic_qiancai@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 09-02-22 11:57:42, Qian Cai wrote:
> Since the linux-next commit 120aa5e57479 (mm: Check for
> SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation), we will get a
> boot warning. Avoid it by calling synchronize_rcu() before the zeroing.
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>

No, the performance impact of this would be just horrible. Can you
ellaborate a bit why SLAB_TYPESAFE_BY_RCU + __GFP_ZERO is a problem and why
synchronize_rcu() would be needed here before the memset() please? I mean
how is zeroing here any different from the memory just being used?

								Honza

> ---
>  fs/jbd2/journal.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index c2cf74b01ddb..323112de5921 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2861,15 +2861,18 @@ static struct journal_head *journal_alloc_journal_head(void)
>  #ifdef CONFIG_JBD2_DEBUG
>  	atomic_inc(&nr_journal_heads);
>  #endif
> -	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
> +	ret = kmem_cache_alloc(jbd2_journal_head_cache, GFP_NOFS);
>  	if (!ret) {
>  		jbd_debug(1, "out of memory for journal_head\n");
>  		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
> -		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
> +		ret = kmem_cache_alloc(jbd2_journal_head_cache,
>  				GFP_NOFS | __GFP_NOFAIL);
>  	}
> -	if (ret)
> +	if (ret) {
> +		synchronize_rcu();
> +		memset(ret, 0, sizeof(*ret));
>  		spin_lock_init(&ret->b_state_lock);
> +	}
>  	return ret;
>  }
>  
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
