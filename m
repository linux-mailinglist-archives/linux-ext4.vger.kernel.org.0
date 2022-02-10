Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0F04B1222
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243824AbiBJPzG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 10:55:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbiBJPzG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 10:55:06 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9626C2D;
        Thu, 10 Feb 2022 07:55:06 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21AFsWxL026635
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 10:54:33 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 97AF715C0040; Thu, 10 Feb 2022 10:54:32 -0500 (EST)
Date:   Thu, 10 Feb 2022 10:54:32 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Qian Cai <quic_qiancai@quicinc.com>,
        Jan Kara <jack@suse.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <YgU1ONDsn9xgs/CG@mit.edu>
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
 <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <YgSdlew4B5FWY6Qm@mit.edu>
 <20220210054357.GH4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210054357.GH4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 09:43:57PM -0800, Paul E. McKenney wrote:
> So the typical RCU approach (not involving SLAB_TYPESAFE_BY_RCU)
> is to take the grace period at the time of the free.  This can be
> done synchronously using synchronize_rcu(), but is often instead done
> asynchronously using call_rcu() or kfree_rcu().  So in this case,
> you don't need synchronize_rcu() on allocation because the required
> grace period already happened at *free() time.
> 
> But there are a few situations where it makes sense to free blocks that
> readers might still be referencing.  Readers must then add validity
> checks to detect this case, and also prevent freeing, for example,
> using a per-block spinlock for synchronization.  For example, a reader
> might acquire a spinlock in the block to prevent changes, recheck the
> lookup key, and if the key does not match, release the lock and pretend
> not to have found the block.  If the key does match, anything attempting
> to delete and free the block will be spinning on that same spinlock.
> 
> And so if you specify SLAB_TYPESAFE_BY_RCU, the slab allocator is
> guaranteeing type safety to RCU readers instead of the usual existence
> guarantee.  A memory block might be freed out from under an RCU reader,
> but its type will remain the same.  This means that the grace period
> happens internally to the slab allocator when a slab is returned to
> the system.
> 
> So either the validation checks are quite novel, the kmem_cache_zalloc()
> calls should be replaced by kmem_cache_alloc() plus validation checks,
> or the SLAB_TYPESAFE_BY_RCU should be removed.
> 
> Just out of curiosity, what is your mental model of SLAB_TYPESAFE_BY_RCU?

Hmm, so the code in question the flag was called SLAB_DESTROY_BY_RCU
in June 205 by commit de92c8caf16c ("jbd2: speedup
jbd2_journal_get_[write|undo]_access()"), and it was written by Jan.
I don't see anything to make sure the jh doesn't get freed until after
the grace period, and so that looks like a problem unless I'm missing
something.   Jan, what do you think?

					- Ted
