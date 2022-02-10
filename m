Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15D24B04BD
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 06:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiBJFIC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 00:08:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBJFIA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 00:08:00 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551628C;
        Wed,  9 Feb 2022 21:08:00 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21A57X4O005422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 00:07:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 96ED815C0040; Thu, 10 Feb 2022 00:07:33 -0500 (EST)
Date:   Thu, 10 Feb 2022 00:07:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Qian Cai <quic_qiancai@quicinc.com>,
        Jan Kara <jack@suse.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <YgSdlew4B5FWY6Qm@mit.edu>
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
 <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 12:11:37PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 09, 2022 at 07:10:10PM +0100, Jan Kara wrote:
> > 
> > No, the performance impact of this would be just horrible. Can you
> > ellaborate a bit why SLAB_TYPESAFE_BY_RCU + __GFP_ZERO is a problem and why
> > synchronize_rcu() would be needed here before the memset() please? I mean
> > how is zeroing here any different from the memory just being used?
> 
> Suppose a reader picks up a pointer to a memory block, then that memory
> is freed.  No problem, given that this is a SLAB_TYPESAFE_BY_RCU slab,
> so the memory won't be freed while the reader is accessing it.  But while
> the reader is in the process of validating the block, it is zeroed.
> 
> How does the validation step handle this in all cases?
> 
> If you have a way of handling this, I will of course drop the patch.
> And learn something new, which is always a good thing.  ;-)

I must be missing something.  The change is on the allocation path,
and why would kmem_cache_[z]alloc() return a memory chunk which could
still be in use by a reader?  Shouldn't the allocator _not_ return a
particular chunk until it is sure there aren't any readers left that
would be discombobulated by that memory being used for some new use
case?

Otherwise we would have to add synchronize_rcu(); after every single
kmem_cache allocation which might be using RCU, and that would be
terrible, no?

					- Ted


> > > ---
> > >  fs/jbd2/journal.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > > index c2cf74b01ddb..323112de5921 100644
> > > --- a/fs/jbd2/journal.c
> > > +++ b/fs/jbd2/journal.c
> > > @@ -2861,15 +2861,18 @@ static struct journal_head *journal_alloc_journal_head(void)
> > >  #ifdef CONFIG_JBD2_DEBUG
> > >  	atomic_inc(&nr_journal_heads);
> > >  #endif
> > > -	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
> > > +	ret = kmem_cache_alloc(jbd2_journal_head_cache, GFP_NOFS);
> > >  	if (!ret) {
> > >  		jbd_debug(1, "out of memory for journal_head\n");
> > >  		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
> > > -		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
> > > +		ret = kmem_cache_alloc(jbd2_journal_head_cache,
> > >  				GFP_NOFS | __GFP_NOFAIL);
> > >  	}
> > > -	if (ret)
> > > +	if (ret) {
> > > +		synchronize_rcu();
> > > +		memset(ret, 0, sizeof(*ret));
> > >  		spin_lock_init(&ret->b_state_lock);
> > > +	}
> > >  	return ret;
> > >  }
> > >  
> > > -- 
> > > 2.30.2
> > > 
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
