Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A54B1601
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 20:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbiBJTNH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 14:13:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343727AbiBJTM7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 14:12:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2550101C;
        Thu, 10 Feb 2022 11:12:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 845F71F399;
        Thu, 10 Feb 2022 19:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644520378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKOAp2jXT8jysY+hvn3O+c1AEmNJxMIGUyiP1y/9IdU=;
        b=FwHTiUN8CUXLrAWhQchp2Ec5RiMF4n/G+ucGZiv6NJd70nxmVMhzOzr1KFotknnihWXhi4
        uilq+8BzbWoxJtOgmSRe6vN0541hOHUurfDNYl7TNI3qcXCYEVIBChfEfrw92CuKdnGfa0
        ZfBEYOmAg0AfMu2jg0WmKJHPyMWnjM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644520378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKOAp2jXT8jysY+hvn3O+c1AEmNJxMIGUyiP1y/9IdU=;
        b=W1fNULM9xsFbn5L0d8YfNmBjjwwPwYUCx5Hp3ybYMKJsXIiUyooJazK/XT2RQE+yNVukpd
        SS0OKWeAR97D6wAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58EE4A3B83;
        Thu, 10 Feb 2022 19:12:58 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8F409A05BC; Thu, 10 Feb 2022 20:12:52 +0100 (CET)
Date:   Thu, 10 Feb 2022 20:12:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Qian Cai <quic_qiancai@quicinc.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <20220210191252.3cbe2sy3jmqul2mh@quack3.lan>
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
 <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <20220210091648.w5wie3llqri5kfw3@quack3.lan>
 <20220210145713.GK4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210145713.GK4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-02-22 06:57:13, Paul E. McKenney wrote:
> On Thu, Feb 10, 2022 at 10:16:48AM +0100, Jan Kara wrote:
> > On Wed 09-02-22 12:11:37, Paul E. McKenney wrote:
> > > On Wed, Feb 09, 2022 at 07:10:10PM +0100, Jan Kara wrote:
> > > > On Wed 09-02-22 11:57:42, Qian Cai wrote:
> > > > > Since the linux-next commit 120aa5e57479 (mm: Check for
> > > > > SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation), we will get a
> > > > > boot warning. Avoid it by calling synchronize_rcu() before the zeroing.
> > > > > 
> > > > > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> > > > 
> > > > No, the performance impact of this would be just horrible. Can you
> > > > ellaborate a bit why SLAB_TYPESAFE_BY_RCU + __GFP_ZERO is a problem and why
> > > > synchronize_rcu() would be needed here before the memset() please? I mean
> > > > how is zeroing here any different from the memory just being used?
> > > 
> > > Suppose a reader picks up a pointer to a memory block, then that memory
> > > is freed.  No problem, given that this is a SLAB_TYPESAFE_BY_RCU slab,
> > > so the memory won't be freed while the reader is accessing it.  But while
> > > the reader is in the process of validating the block, it is zeroed.
> > > 
> > > How does the validation step handle this in all cases?
> > > 
> > > If you have a way of handling this, I will of course drop the patch.
> > > And learn something new, which is always a good thing.  ;-)
> > 
> > So I maybe missed something when implementing the usage of journal_heads
> > under RCU but let's have a look. An example of RCU user of journal heads
> > is fs/jbd2/transaction.c:jbd2_write_access_granted(). It does:
> > 
> >         rcu_read_lock();
> > 
> > 	// This part fetches journal_head from buffer_head - not related to
> > 	// our slab RCU discussion
> > 
> >         if (!buffer_jbd(bh))
> >                 goto out;
> >         /* This should be bh2jh() but that doesn't work with inline functions */
> >         jh = READ_ONCE(bh->b_private);
> >         if (!jh)
> >                 goto out;
> > 
> > 	// The validation comes here
> > 
> >         /* For undo access buffer must have data copied */
> >         if (undo && !jh->b_committed_data)
> >                 goto out;
> 
> OK, so if *jh was freed and re-zallocated in the meantime, this test
> should fail.  One concern would be if the zeroing was not at least eight
> bytes at a time, maybe due to overly eager use of fancy SIMD hardware.
> Though perhaps you also do something about ->b_committed_data on
> the free path, the commit-done path, or whatever?  (I do see a
> "jh->b_committed_data = NULL" on what might well be the commit-done path.)
>
> >         if (READ_ONCE(jh->b_transaction) != handle->h_transaction &&
> >             READ_ONCE(jh->b_next_transaction) != handle->h_transaction)
> >                 goto out;
> 
> And same with these guys.

Yes, on commit-done path we zero out jh->b_transaction (or set
jh->b_transaction = jh->b_next_transaction; jh->b_next_transaction = NULL).
So these fields are actually guaranteed to be zero on free.

> > 	// Then some more checks unrelated to the slab itself.
> > 
> >         /*
> >          * There are two reasons for the barrier here:
> >          * 1) Make sure to fetch b_bh after we did previous checks so that we
> >          * detect when jh went through free, realloc, attach to transaction
> >          * while we were checking. Paired with implicit barrier in that path.
> >          * 2) So that access to bh done after jbd2_write_access_granted()
> >          * doesn't get reordered and see inconsistent state of concurrent
> >          * do_get_write_access().
> >          */
> >         smp_mb();
> >         if (unlikely(jh->b_bh != bh))
> >                 goto out;
> > 
> > 	// If all passed
> > 
> > 	rcu_read_unlock();
> > 	return true;
> > 
> > So if we are going to return true from the function, we know that 'jh' was
> > attached to handle->h_transaction at some point. And when 'jh' was attached
> > to handle->h_transaction, the transaction was holding reference to the 'jh'
> > and our 'handle' holds reference to the transaction so 'jh' could not be
> > freed since that moment. I.e., we are sure our reference to the handle keeps
> > 'jh' alive and we can safely use it.
> > 
> > I don't see how any amount of scribbling over 'jh' could break this
> > validation. But maybe it is just a lack of my imagination :).
> 
> Regardless of whether you are suffering a lack of imagination, you
> have clearly demonstrated that it is possible to correctly use the
> SLAB_TYPESAFE_BY_RCU flag in conjunction with kmem_cache_alloc(), thus
> demonstrating that I was suffering from a lack of imagination.  ;-)
> 
> I have therefore reverted my commit.  Please accept my apologies for
> the hassle!

No problem. Thanks for reverting the patch. I can imagine that jbd2's use
of SLAB_TYPESAFE_BY_RCU is an unusual one...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
