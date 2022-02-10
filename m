Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE904B1113
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 15:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbiBJO5O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 09:57:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbiBJO5O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 09:57:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714496;
        Thu, 10 Feb 2022 06:57:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5AAD61AEA;
        Thu, 10 Feb 2022 14:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288EBC004E1;
        Thu, 10 Feb 2022 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644505034;
        bh=DYAxKhfO1WMabdPDfP4WWBxwZceNtLPv6VgxeeFlY6o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I5V19VR2bvps0s4U0VS5tAlDhdst0iJNEVbBrb6HXsxsepFpZe5/lJPxjnVuJGPE5
         pgAVNc3svWvoZAlxrqNBw3FP9cknIHJ6MNzZTwSAY1gQKYiSFgOmPIwQebifqRcwQ2
         WOLx5EVl++mKN0dE6+CU79lru3lwD7LFaBlLRe2KYmBdzx0SwF391dMvK/mBhJnvqQ
         QBgOjYnwSm+a2aUoHRXobMh+P98MkLz0CJEA1BJX7wtHgMdPNesHgQmchMEvYNleIX
         ZmpdnPZUKmyOWIqcjNybhd46UqYHUp1jiyN9fFKGDF/4NV+ywZAlkcqTMIRy66AhLB
         RZobNCgKgZbyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF0825C0388; Thu, 10 Feb 2022 06:57:13 -0800 (PST)
Date:   Thu, 10 Feb 2022 06:57:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <20220210145713.GK4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
 <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <20220210091648.w5wie3llqri5kfw3@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210091648.w5wie3llqri5kfw3@quack3.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 10, 2022 at 10:16:48AM +0100, Jan Kara wrote:
> On Wed 09-02-22 12:11:37, Paul E. McKenney wrote:
> > On Wed, Feb 09, 2022 at 07:10:10PM +0100, Jan Kara wrote:
> > > On Wed 09-02-22 11:57:42, Qian Cai wrote:
> > > > Since the linux-next commit 120aa5e57479 (mm: Check for
> > > > SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation), we will get a
> > > > boot warning. Avoid it by calling synchronize_rcu() before the zeroing.
> > > > 
> > > > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
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
> So I maybe missed something when implementing the usage of journal_heads
> under RCU but let's have a look. An example of RCU user of journal heads
> is fs/jbd2/transaction.c:jbd2_write_access_granted(). It does:
> 
>         rcu_read_lock();
> 
> 	// This part fetches journal_head from buffer_head - not related to
> 	// our slab RCU discussion
> 
>         if (!buffer_jbd(bh))
>                 goto out;
>         /* This should be bh2jh() but that doesn't work with inline functions */
>         jh = READ_ONCE(bh->b_private);
>         if (!jh)
>                 goto out;
> 
> 	// The validation comes here
> 
>         /* For undo access buffer must have data copied */
>         if (undo && !jh->b_committed_data)
>                 goto out;

OK, so if *jh was freed and re-zallocated in the meantime, this test
should fail.  One concern would be if the zeroing was not at least eight
bytes at a time, maybe due to overly eager use of fancy SIMD hardware.
Though perhaps you also do something about ->b_committed_data on
the free path, the commit-done path, or whatever?  (I do see a
"jh->b_committed_data = NULL" on what might well be the commit-done path.)

>         if (READ_ONCE(jh->b_transaction) != handle->h_transaction &&
>             READ_ONCE(jh->b_next_transaction) != handle->h_transaction)
>                 goto out;

And same with these guys.

> 	// Then some more checks unrelated to the slab itself.
> 
>         /*
>          * There are two reasons for the barrier here:
>          * 1) Make sure to fetch b_bh after we did previous checks so that we
>          * detect when jh went through free, realloc, attach to transaction
>          * while we were checking. Paired with implicit barrier in that path.
>          * 2) So that access to bh done after jbd2_write_access_granted()
>          * doesn't get reordered and see inconsistent state of concurrent
>          * do_get_write_access().
>          */
>         smp_mb();
>         if (unlikely(jh->b_bh != bh))
>                 goto out;
> 
> 	// If all passed
> 
> 	rcu_read_unlock();
> 	return true;
> 
> So if we are going to return true from the function, we know that 'jh' was
> attached to handle->h_transaction at some point. And when 'jh' was attached
> to handle->h_transaction, the transaction was holding reference to the 'jh'
> and our 'handle' holds reference to the transaction so 'jh' could not be
> freed since that moment. I.e., we are sure our reference to the handle keeps
> 'jh' alive and we can safely use it.
> 
> I don't see how any amount of scribbling over 'jh' could break this
> validation. But maybe it is just a lack of my imagination :).

Regardless of whether you are suffering a lack of imagination, you
have clearly demonstrated that it is possible to correctly use the
SLAB_TYPESAFE_BY_RCU flag in conjunction with kmem_cache_alloc(), thus
demonstrating that I was suffering from a lack of imagination.  ;-)

I have therefore reverted my commit.  Please accept my apologies for
the hassle!

							Thanx, Paul
