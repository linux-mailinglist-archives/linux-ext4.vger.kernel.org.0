Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F621701EB
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 16:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBZPG6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 10:06:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBZPG6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Feb 2020 10:06:58 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E122467D;
        Wed, 26 Feb 2020 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582729617;
        bh=QT6GUyLzIUdRMVSaNAxDiNdKzTo0kQ+EQU+2BK797Sw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FFkA0N8gusvWYmfVUiPUaZKzj8nUanEMpm09zuCMQphmDbzFDySX7V8AW8zC4dMbj
         L1pOu3+jZuFEldIfaMbsKANrPIeQxVLBfl9Ecsgqxre6DfLfwizpPveoN5KwIKCRWZ
         Sxr/hu+ZExeF+XTdQnCSJ2tk2GbIKQ4RDLecOr1w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D1D253521EAF; Wed, 26 Feb 2020 07:06:56 -0800 (PST)
Date:   Wed, 26 Feb 2020 07:06:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200226150656.GB2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
 <20200225185400.GA27919@pc636>
 <20200225224745.GX2935@paulmck-ThinkPad-P72>
 <20200226130440.GA30008@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226130440.GA30008@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 26, 2020 at 02:04:40PM +0100, Uladzislau Rezki wrote:
> On Tue, Feb 25, 2020 at 02:47:45PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 25, 2020 at 07:54:00PM +0100, Uladzislau Rezki wrote:
> > > > > > > I was thinking a 2 fold approach (just thinking out loud..):
> > > > > > > 
> > > > > > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > > > > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > > > > > queue that.
> > > > > > > 
> > > > > I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> > > > > gets failed in atomic context? Or we can just consider it as out of
> > > > > memory and another variant is to say that headless object can be called
> > > > > from preemptible context only.
> > > > 
> > > > Yes that makes sense, and we can always put disclaimer in the API's comments
> > > > saying if this object is expected to be freed a lot, then don't use the
> > > > headless-API to be extra safe.
> > > > 
> > > Agree.
> > > 
> > > > BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
> > > > the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
> > > > there seems to be bigger problems in the system any way. I would say let us
> > > > write a patch to allocate there and see what the -mm guys think.
> > > > 
> > > OK. It might be that they can offer something if they do not like our
> > > approach. I will try to compose something and send the patch to see.
> > > The tree.c implementation is almost done, whereas tiny one is on hold.
> > > 
> > > I think we should support batching as well as bulk interface there.
> > > Another way is to workaround head-less object, just to attach the head
> > > dynamically using kmalloc() and then call_rcu() but then it will not be
> > > a fair headless support :)
> > > 
> > > What is your view?
> > > 
> > > > > > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > > > > > synchronize_rcu() inline with it.
> > > > > > > 
> > > > > > >
> > > > > What do you mean here, Joel? "grow an rcu_head on the stack"?
> > > > 
> > > > By "grow on the stack", use the compiler-allocated rcu_head on the
> > > > kfree_rcu() caller's stack.
> > > > 
> > > > I meant here to say, if we are not in atomic context, then we use regular
> > > > GFP_KERNEL allocation, and if that fails, then we just use the stack's
> > > > rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
> > > > the allocation failure would mean the need for RCU to free some memory is
> > > > probably great.
> > > > 
> > > Ah, i got it. I thought you meant something like recursion and then
> > > unwinding the stack back somehow :)
> > > 
> > > > > > > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > > > > > > between the 2 cases.
> > > > > > > 
> > > > > If the current context is preemptable then we can inline synchronize_rcu()
> > > > > together with freeing to handle such corner case, i mean when we are run
> > > > > out of memory.
> > > > 
> > > > Ah yes, exactly what I mean.
> > > > 
> > > OK.
> > > 
> > > > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > > > have a look at preempt_count of current process? If we have for example
> > > > > nested rcu_read_locks:
> > > > > 
> > > > > <snip>
> > > > > rcu_read_lock()
> > > > >     rcu_read_lock()
> > > > >         rcu_read_lock()
> > > > > <snip>
> > > > > 
> > > > > the counter would be 3.
> > > > 
> > > > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > > > reader sections can be preempted, they just cannot goto sleep in a reader
> > > > section (unless the kernel is RT).
> > > > 
> > > So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
> > > using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
> > > then we skip it and consider as atomic. Something like:
> > > 
> > > <snip>
> > > static bool is_current_in_atomic()
> > > {
> > > #ifdef CONFIG_PREEMPT_RCU
> > 
> > If possible: if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> > 
> > Much nicer than #ifdef, and I -think- it should work in this case.
> > 
> OK. Thank you, Paul!
> 
> There is one point i would like to highlight it is about making caller
> instead to be responsible for atomic or not decision. Like how kmalloc()
> works, it does not really know the context it runs on, so it is up to
> caller to inform.
> 
> The same way:
> 
> kvfree_rcu(p, atomic = true/false);
> 
> in this case we could cover !CONFIG_PREEMPT case also.

Understood, but couldn't we instead use IS_ENABLED() to work out the
actual situation at runtime and relieve the caller of this burden?
Or am I missing a corner case?

							Thanx, Paul
