Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70FE4AFE0A
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 21:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiBIULh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 15:11:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiBIULg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 15:11:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A690E0918DC;
        Wed,  9 Feb 2022 12:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43ECA61AB2;
        Wed,  9 Feb 2022 20:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E70C340E7;
        Wed,  9 Feb 2022 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644437497;
        bh=zOp2gUWewyoep3PgpK5NGqgBJCUg+nncwwjeYsUzoFU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sf9wnonBO85hj+/La/zqX9PVOmY1Zdkdw/QxjYzJQupMZr3kiZYcZk5CuD5hnFSjn
         qdIjN6YGrYHL2Sqsv6Ij7e1e/qBWmDayXc+5m5ovlFEyR7zipSK+YQ3FtjWXWarHzU
         3WXaYXrdrEE+zGaRxubyFd8pFEvkOJxdqKmSbIYf9bFciLGKnIEejQvSAkZP96Vcyc
         V/pgLUegGjlMhk3kxBWDmeA4DEk25UV+IRyJlfHTmstDpllLfUQO03JeKrpr9t+LML
         jt8DygIzA5GSUOedCiZ6bvOIMGyjid6vwCNg6XWIudp60W01nFu9yV/B0RVQqjxWSn
         0T7x/VN1zFQEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F4DE5C03C6; Wed,  9 Feb 2022 12:11:37 -0800 (PST)
Date:   Wed, 9 Feb 2022 12:11:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209181010.gfn66rvip56i54df@quack3.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 07:10:10PM +0100, Jan Kara wrote:
> On Wed 09-02-22 11:57:42, Qian Cai wrote:
> > Since the linux-next commit 120aa5e57479 (mm: Check for
> > SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation), we will get a
> > boot warning. Avoid it by calling synchronize_rcu() before the zeroing.
> > 
> > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> 
> No, the performance impact of this would be just horrible. Can you
> ellaborate a bit why SLAB_TYPESAFE_BY_RCU + __GFP_ZERO is a problem and why
> synchronize_rcu() would be needed here before the memset() please? I mean
> how is zeroing here any different from the memory just being used?

Suppose a reader picks up a pointer to a memory block, then that memory
is freed.  No problem, given that this is a SLAB_TYPESAFE_BY_RCU slab,
so the memory won't be freed while the reader is accessing it.  But while
the reader is in the process of validating the block, it is zeroed.

How does the validation step handle this in all cases?

If you have a way of handling this, I will of course drop the patch.
And learn something new, which is always a good thing.  ;-)

							Thanx, Paul

> > ---
> >  fs/jbd2/journal.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index c2cf74b01ddb..323112de5921 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -2861,15 +2861,18 @@ static struct journal_head *journal_alloc_journal_head(void)
> >  #ifdef CONFIG_JBD2_DEBUG
> >  	atomic_inc(&nr_journal_heads);
> >  #endif
> > -	ret = kmem_cache_zalloc(jbd2_journal_head_cache, GFP_NOFS);
> > +	ret = kmem_cache_alloc(jbd2_journal_head_cache, GFP_NOFS);
> >  	if (!ret) {
> >  		jbd_debug(1, "out of memory for journal_head\n");
> >  		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
> > -		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
> > +		ret = kmem_cache_alloc(jbd2_journal_head_cache,
> >  				GFP_NOFS | __GFP_NOFAIL);
> >  	}
> > -	if (ret)
> > +	if (ret) {
> > +		synchronize_rcu();
> > +		memset(ret, 0, sizeof(*ret));
> >  		spin_lock_init(&ret->b_state_lock);
> > +	}
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.30.2
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
