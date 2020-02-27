Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129EE1718DA
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2020 14:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgB0NhD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Feb 2020 08:37:03 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35114 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgB0NhD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Feb 2020 08:37:03 -0500
Received: by mail-qt1-f194.google.com with SMTP id 88so2268426qtc.2
        for <linux-ext4@vger.kernel.org>; Thu, 27 Feb 2020 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmWHrBJcN7ejSVHixLEQF5uOon7zKqN3Pq0dKTOIOQA=;
        b=gD5vZAG+DtDI6uMe7e6gbKLoJzGc2b1JzVCqh3ZCuKklMl9+mMaBsC2uvDhNJY4QjQ
         IJaO20Go8KeqL/nlH2dHYBVUfhu7h2hxlsVrq/WfdQfAXBmFPnQIi6D/eY1/4r4UhVSK
         tHXY6/fbJlg9NUptWERv9NHNOJzVxeFnvx/kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmWHrBJcN7ejSVHixLEQF5uOon7zKqN3Pq0dKTOIOQA=;
        b=CuLFkolCHOc2qe3tfUHdTdsXgZFOKvVeGXc2+nQfZquASKYlOHayPH6YaT5JemHo2f
         IwTWTpHSLTw8eHfX47BfLrnNOPZMDql5puGCKhIF5JS3kT1qkpfvvm0pfi3+v6bHd9ht
         t43W4FzvpiTtanMOMb20LeMnZC4bXCGSPs3+jRMleV9e+2+dTjTgysMxbG75KLgAbJPe
         C353e6CxcecePy8TAr5ddQare0KqV6F+wJkIW4ya77tLoR9diZYzwtQKAKa/iw5fW2Dv
         19XZRtT9DXiKUEjMS/ER7Usr8CIbzW0h0ncXWJ8UtP+sdCIlezqqM5rqMMLysuQaacxt
         3Xkw==
X-Gm-Message-State: APjAAAUFznx1FfeNLleZnZGsGGgxGqch6tkDtGAxxCYx1W8xdbLJ0jDh
        wZcsmVfKeKUY6Ao6JZVf3ePo78RDRf0=
X-Google-Smtp-Source: APXvYqwp18AbEZK2wRg/VcPpscOhe2m0EPo8Ss8nMji7xGvcuPlLImoWJj9VBdpsGs1q/H+5AZYlKA==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr5255681qtu.2.1582810621803;
        Thu, 27 Feb 2020 05:37:01 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 17sm600594qks.0.2020.02.27.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:37:01 -0800 (PST)
Date:   Thu, 27 Feb 2020 08:37:00 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200227133700.GC161459@google.com>
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
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry for slightly late reply.

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

This kind of "head" will require backpointers to the original object as well
right? And still wouldn't solve the "what if we run out of GFP_ATOMIC
reserves". But let me know in a code snippet if possible about what you mean.

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

Yeah something like that :) Use the compiler allocated space which you
wouldn't run out of unless stack overflows.

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

Would be good to change this to is_current_in_rcu_reader() since
rcu_preempt_depth() does not imply atomicity.

> {
> #ifdef CONFIG_PREEMPT_RCU
>     if (!rcu_preempt_depth() && !in_atomic())
>         return false;

I think use if (!rcu_preempt_depth() && preemptible()) here.

preemptible() checks for IRQ disabled section as well.

> #endif
> 
>     return true;

Otherwise LGTM.

thanks!

 - Joel

> }
> <snip>

