Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6534B094A
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 10:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiBJJQy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 04:16:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiBJJQy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 04:16:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038BD94;
        Thu, 10 Feb 2022 01:16:53 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 209F01F391;
        Thu, 10 Feb 2022 09:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644484612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f7gjGLzCcS+dkKB2LjGxdCXQVS6KGJXLTYsZFU0/hOo=;
        b=jKnfpg5tL+Xo5HCdCLh3mQSmaHKsDRFLMIpyfYfC0pV3P/CO4KF1v0cPaa1OnuKpPpkhiQ
        l9jt5PPc+0r4uy193DSqIbPCGOMckfaYkSz+8wk07jMGiLv/AXAj4RyES9ZYV/4KJHe2eF
        ztcXs1tVIcUDqw4JWtLth2QPTxHuoWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644484612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f7gjGLzCcS+dkKB2LjGxdCXQVS6KGJXLTYsZFU0/hOo=;
        b=DE8G87xZnZbTvDbaSkCuOMTmoqD+OgDSA8NvmDz9ICPbbr0h6sKcDh5e/tFSMR9J+l8tP+
        ZJtYB52aKP8t7dBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 09AE4A3B81;
        Thu, 10 Feb 2022 09:16:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B15E3A05BC; Thu, 10 Feb 2022 10:16:48 +0100 (CET)
Date:   Thu, 10 Feb 2022 10:16:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Qian Cai <quic_qiancai@quicinc.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-ext4@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <20220210091648.w5wie3llqri5kfw3@quack3.lan>
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
 <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209201137.GY4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 09-02-22 12:11:37, Paul E. McKenney wrote:
> On Wed, Feb 09, 2022 at 07:10:10PM +0100, Jan Kara wrote:
> > On Wed 09-02-22 11:57:42, Qian Cai wrote:
> > > Since the linux-next commit 120aa5e57479 (mm: Check for
> > > SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation), we will get a
> > > boot warning. Avoid it by calling synchronize_rcu() before the zeroing.
> > > 
> > > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
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

So I maybe missed something when implementing the usage of journal_heads
under RCU but let's have a look. An example of RCU user of journal heads
is fs/jbd2/transaction.c:jbd2_write_access_granted(). It does:

        rcu_read_lock();

	// This part fetches journal_head from buffer_head - not related to
	// our slab RCU discussion

        if (!buffer_jbd(bh))
                goto out;
        /* This should be bh2jh() but that doesn't work with inline functions */
        jh = READ_ONCE(bh->b_private);
        if (!jh)
                goto out;

	// The validation comes here

        /* For undo access buffer must have data copied */
        if (undo && !jh->b_committed_data)
                goto out;
        if (READ_ONCE(jh->b_transaction) != handle->h_transaction &&
            READ_ONCE(jh->b_next_transaction) != handle->h_transaction)
                goto out;
	
	// Then some more checks unrelated to the slab itself.

        /*
         * There are two reasons for the barrier here:
         * 1) Make sure to fetch b_bh after we did previous checks so that we
         * detect when jh went through free, realloc, attach to transaction
         * while we were checking. Paired with implicit barrier in that path.
         * 2) So that access to bh done after jbd2_write_access_granted()
         * doesn't get reordered and see inconsistent state of concurrent
         * do_get_write_access().
         */
        smp_mb();
        if (unlikely(jh->b_bh != bh))
                goto out;

	// If all passed

	rcu_read_unlock();
	return true;

So if we are going to return true from the function, we know that 'jh' was
attached to handle->h_transaction at some point. And when 'jh' was attached
to handle->h_transaction, the transaction was holding reference to the 'jh'
and our 'handle' holds reference to the transaction so 'jh' could not be
freed since that moment. I.e., we are sure our reference to the handle keeps
'jh' alive and we can safely use it.

I don't see how any amount of scribbling over 'jh' could break this
validation. But maybe it is just a lack of my imagination :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
