Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBAC4B05AD
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 06:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiBJFpL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 00:45:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiBJFpE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 00:45:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D552667;
        Wed,  9 Feb 2022 21:43:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFC661BF7;
        Thu, 10 Feb 2022 05:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B0EC004E1;
        Thu, 10 Feb 2022 05:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644471838;
        bh=5o1x/547TaGwbfI6v0NLo1Bq2o5agvXBfe3m9FOdxgU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BRaVZU8dMzzxKrL7r1MysVLr/1UHFu/xZjFrZY7J/YNYbWKqt7BygoPFpZ5xU5Jpa
         nlmlEcnh8gIMuvT6h50CttBPnwNG6n4YRdu5dQiDhtTNfGpf2j2gxUTGdHmBKslCef
         Vy1ivJ38EiCMXEDETwHM2jv+Q7o9Z037erV4AUzBkByAbDPK2AHaXscY1tgls0JJ7G
         em/ahrPsb9Pz9KGPzNURztoaRzO05r5pYrFmK8a0Kcs1f/Alv364rARHTVnprDkJfb
         nAZos9lYJYF0VwQv7fQh2C6WlUmtso61fT2jhQcs2owN8qChnPKCtgRk1SGswfEzD8
         9hB86W07JBq7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A111E5C0440; Wed,  9 Feb 2022 21:43:57 -0800 (PST)
Date:   Wed, 9 Feb 2022 21:43:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Qian Cai <quic_qiancai@quicinc.com>,
        Jan Kara <jack@suse.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <20220210054357.GH4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
 <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <YgSdlew4B5FWY6Qm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgSdlew4B5FWY6Qm@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 10, 2022 at 12:07:33AM -0500, Theodore Ts'o wrote:
> On Wed, Feb 09, 2022 at 12:11:37PM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 09, 2022 at 07:10:10PM +0100, Jan Kara wrote:
> > > 
> > > No, the performance impact of this would be just horrible. Can you
> > > ellaborate a bit why SLAB_TYPESAFE_BY_RCU + __GFP_ZERO is a problem and why
> > > synchronize_rcu() would be needed here before the memset() please? I mean
> > > how is zeroing here any different from the memory just being used?
> > 
> > Suppose a reader picks up a pointer to a memory block, then that memory
> > is freed.  No problem, given that this is a SLAB_TYPESAFE_BY_RCU slab,
> > so the memory won't be freed while the reader is accessing it.  But while
> > the reader is in the process of validating the block, it is zeroed.
> > 
> > How does the validation step handle this in all cases?
> > 
> > If you have a way of handling this, I will of course drop the patch.
> > And learn something new, which is always a good thing.  ;-)
> 
> I must be missing something.  The change is on the allocation path,
> and why would kmem_cache_[z]alloc() return a memory chunk which could
> still be in use by a reader?  Shouldn't the allocator _not_ return a
> particular chunk until it is sure there aren't any readers left that
> would be discombobulated by that memory being used for some new use
> case?

From the allocator's viewpoint yes, but ...

> Otherwise we would have to add synchronize_rcu(); after every single
> kmem_cache allocation which might be using RCU, and that would be
> terrible, no?

... if ext4 is not freeing memory blocks that might still be referenced
by RCU readers, then the SLAB_TYPESAFE_BY_RCU should be removed.
This "might still be referenced" is from the viewpoint of the code using
the allocator, not from that of the allocator itself.

So the typical RCU approach (not involving SLAB_TYPESAFE_BY_RCU)
is to take the grace period at the time of the free.  This can be
done synchronously using synchronize_rcu(), but is often instead done
asynchronously using call_rcu() or kfree_rcu().  So in this case,
you don't need synchronize_rcu() on allocation because the required
grace period already happened at *free() time.

But there are a few situations where it makes sense to free blocks that
readers might still be referencing.  Readers must then add validity
checks to detect this case, and also prevent freeing, for example,
using a per-block spinlock for synchronization.  For example, a reader
might acquire a spinlock in the block to prevent changes, recheck the
lookup key, and if the key does not match, release the lock and pretend
not to have found the block.  If the key does match, anything attempting
to delete and free the block will be spinning on that same spinlock.

And so if you specify SLAB_TYPESAFE_BY_RCU, the slab allocator is
guaranteeing type safety to RCU readers instead of the usual existence
guarantee.  A memory block might be freed out from under an RCU reader,
but its type will remain the same.  This means that the grace period
happens internally to the slab allocator when a slab is returned to
the system.

So either the validation checks are quite novel, the kmem_cache_zalloc()
calls should be replaced by kmem_cache_alloc() plus validation checks,
or the SLAB_TYPESAFE_BY_RCU should be removed.

Just out of curiosity, what is your mental model of SLAB_TYPESAFE_BY_RCU?

And yes, I did just up the visibility of this topic in my upcoming
presentation...

							Thanx, Paul

> > > > ---
> > > >  fs/jbd2/journal.c | 9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > > > index c2cf74b01ddb..323112de5921 100644
> > > > --- a/fs/jbd2/journal.c
> > > > +++ b/fs/jbd2/journal.c
> > > > @@ -2861,15 +2861,18 @@ static struct journal_head *journal_alloc_journal_head(void)
> > > >  #ifdef CONFIG_JBD2_DEBUG
> > > >  	atomic_inc(&nr_journal_heads);
> > > >  #endif
> > > > -	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
> > > > +	ret = kmem_cache_alloc(jbd2_journal_head_cache, GFP_NOFS);
> > > >  	if (!ret) {
> > > >  		jbd_debug(1, "out of memory for journal_head\n");
> > > >  		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
> > > > -		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
> > > > +		ret = kmem_cache_alloc(jbd2_journal_head_cache,
> > > >  				GFP_NOFS | __GFP_NOFAIL);
> > > >  	}
> > > > -	if (ret)
> > > > +	if (ret) {
> > > > +		synchronize_rcu();
> > > > +		memset(ret, 0, sizeof(*ret));
> > > >  		spin_lock_init(&ret->b_state_lock);
> > > > +	}
> > > >  	return ret;
> > > >  }
> > > >  
> > > > -- 
> > > > 2.30.2
> > > > 
> > > -- 
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
