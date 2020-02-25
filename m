Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA4B16F2B2
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 23:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgBYWrr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 17:47:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728770AbgBYWrr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Feb 2020 17:47:47 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A3AE20732;
        Tue, 25 Feb 2020 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582670866;
        bh=j/zsh2xhsRGa0zSWKaKjIpm75QoCCLplBUQwSlomtug=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tGx0KQTZH7UfFQLGgJZhost0CK2B6Uo5wKuYcryvp33WJjMiK9DYzP8MkzNDdYL2H
         /YX7O0PF0rTqcHx4A1BFgB8Yps4acsL0hDhbPT4H1VEYxoqzP7VuAt81B3rjONOmP2
         RGRpFeRw5IFbhsR5sqJGons1B60ROHmZToV9H5Ts=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 292EF3521A51; Tue, 25 Feb 2020 14:47:45 -0800 (PST)
Date:   Tue, 25 Feb 2020 14:47:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200225224745.GX2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
 <20200225185400.GA27919@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225185400.GA27919@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 25, 2020 at 07:54:00PM +0100, Uladzislau Rezki wrote:
> > > > > I was thinking a 2 fold approach (just thinking out loud..):
> > > > > 
> > > > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > > > queue that.
> > > > > 
> > > I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> > > gets failed in atomic context? Or we can just consider it as out of
> > > memory and another variant is to say that headless object can be called
> > > from preemptible context only.
> > 
> > Yes that makes sense, and we can always put disclaimer in the API's comments
> > saying if this object is expected to be freed a lot, then don't use the
> > headless-API to be extra safe.
> > 
> Agree.
> 
> > BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
> > the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
> > there seems to be bigger problems in the system any way. I would say let us
> > write a patch to allocate there and see what the -mm guys think.
> > 
> OK. It might be that they can offer something if they do not like our
> approach. I will try to compose something and send the patch to see.
> The tree.c implementation is almost done, whereas tiny one is on hold.
> 
> I think we should support batching as well as bulk interface there.
> Another way is to workaround head-less object, just to attach the head
> dynamically using kmalloc() and then call_rcu() but then it will not be
> a fair headless support :)
> 
> What is your view?
> 
> > > > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > > > synchronize_rcu() inline with it.
> > > > > 
> > > > >
> > > What do you mean here, Joel? "grow an rcu_head on the stack"?
> > 
> > By "grow on the stack", use the compiler-allocated rcu_head on the
> > kfree_rcu() caller's stack.
> > 
> > I meant here to say, if we are not in atomic context, then we use regular
> > GFP_KERNEL allocation, and if that fails, then we just use the stack's
> > rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
> > the allocation failure would mean the need for RCU to free some memory is
> > probably great.
> > 
> Ah, i got it. I thought you meant something like recursion and then
> unwinding the stack back somehow :)
> 
> > > > > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > > > > between the 2 cases.
> > > > > 
> > > If the current context is preemptable then we can inline synchronize_rcu()
> > > together with freeing to handle such corner case, i mean when we are run
> > > out of memory.
> > 
> > Ah yes, exactly what I mean.
> > 
> OK.
> 
> > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > have a look at preempt_count of current process? If we have for example
> > > nested rcu_read_locks:
> > > 
> > > <snip>
> > > rcu_read_lock()
> > >     rcu_read_lock()
> > >         rcu_read_lock()
> > > <snip>
> > > 
> > > the counter would be 3.
> > 
> > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > reader sections can be preempted, they just cannot goto sleep in a reader
> > section (unless the kernel is RT).
> > 
> So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
> using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
> then we skip it and consider as atomic. Something like:
> 
> <snip>
> static bool is_current_in_atomic()
> {
> #ifdef CONFIG_PREEMPT_RCU

If possible: if (IS_ENABLED(CONFIG_PREEMPT_RCU))

Much nicer than #ifdef, and I -think- it should work in this case.

							Thanx, Paul

>     if (!rcu_preempt_depth() && !in_atomic())
>         return false;
> #endif
> 
>     return true;
> }
> <snip>
> 
> Thanks!
> 
> --
> Vlad Rezki
