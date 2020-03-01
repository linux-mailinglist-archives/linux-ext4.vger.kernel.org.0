Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010ED174CE7
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 12:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCALOA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Mar 2020 06:14:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40804 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCALOA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Mar 2020 06:14:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id e26so2370827wme.5;
        Sun, 01 Mar 2020 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfaHc5bk4c2YPoC3p3j9VapHbWmRPMiq8zu69bgaGBQ=;
        b=UbU308V3ZO/wy/AyBdkeYDz0p1rW14BBroCo8Gj+9ZYznVIQEGUx12BTl0mAW7xFnu
         S/+VeO2hADszI+oC7FAKO1xBR4rhvAlVo7dnDi55JJQUdaMr9hetMYNmTTRQDszBvOuD
         0vkH8RHtY45ZdAkMHOI2Z3O0/Ft76ukRyro+gmRX14Sw66dneNAV6UMbFimKRI55m8wp
         2KHeDyOUYj8g+9g7VZaURS5WQM4J0UrfMjhPIc9HNVMYZisSbEs/QmeJu3UCxT+JJVJO
         UJhpQtUxYIcFJPbdixPuJN7hWVeAcwOubhPwU8Z72l4b2kqCfJKjX/Up6+Dfc5u3QZT2
         vGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfaHc5bk4c2YPoC3p3j9VapHbWmRPMiq8zu69bgaGBQ=;
        b=ioPWp97v2J1l4Ih8T40h415fB6CuwsMkVWoAFg3vuxNTr9sajyKPHAVvnp+JAeRsQd
         zdmioze0w0uDmgHbBKkGUd8ldKPiinFDWQDZ7l6FlidqfD5uiSchOFBEkrNTesuQOzkx
         sngD4RwGeA4AQEm34E4GQbh4wIhnw0vdSX0RMlPsL/Y03NsmmnJMft1jbBD5PDlzOPhU
         /lNUYuKYKWJRLiQIK2lSHnbZMVzbN8shhcciQtc5oe8T6ar80pyH4SuwEipZ54dbpRhX
         /FWLHFvRwYxNZ9zNYYGwUKLOqrXHhk43HuKlCsQA6B8CRFyp5dac1NG/24xuqPLYEHQ3
         KRRw==
X-Gm-Message-State: ANhLgQ3VPZDOKcsZ05Tuh/LmGp6DnswfYrD1eZuspC2vB2zDq9ZpClWu
        0wzxJO28JOEOe7LFvSVadNw=
X-Google-Smtp-Source: ADFU+vsYW2HI83S/QDqearsxl1HX/RbUtxGsUdeeJ7OPB17341+LawtTJFCwMxVb25PmMyyoPjnHFg==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr5795232wmm.165.1583061236887;
        Sun, 01 Mar 2020 03:13:56 -0800 (PST)
Received: from pc636 ([80.122.78.78])
        by smtp.gmail.com with ESMTPSA id o9sm22615999wrw.20.2020.03.01.03.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 03:13:55 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 1 Mar 2020 12:13:53 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200301111353.GB8725@pc636>
References: <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
 <20200225185400.GA27919@pc636>
 <20200225224745.GX2935@paulmck-ThinkPad-P72>
 <20200226130440.GA30008@pc636>
 <20200226150656.GB2935@paulmck-ThinkPad-P72>
 <20200226155347.GA31097@pc636>
 <20200227140851.GD161459@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227140851.GD161459@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 27, 2020 at 09:08:51AM -0500, Joel Fernandes wrote:
> On Wed, Feb 26, 2020 at 04:53:47PM +0100, Uladzislau Rezki wrote:
> > On Wed, Feb 26, 2020 at 07:06:56AM -0800, Paul E. McKenney wrote:
> > > On Wed, Feb 26, 2020 at 02:04:40PM +0100, Uladzislau Rezki wrote:
> > > > On Tue, Feb 25, 2020 at 02:47:45PM -0800, Paul E. McKenney wrote:
> > > > > On Tue, Feb 25, 2020 at 07:54:00PM +0100, Uladzislau Rezki wrote:
> > > > > > > > > > I was thinking a 2 fold approach (just thinking out loud..):
> > > > > > > > > > 
> > > > > > > > > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > > > > > > > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > > > > > > > > queue that.
> > > > > > > > > > 
> > > > > > > > I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> > > > > > > > gets failed in atomic context? Or we can just consider it as out of
> > > > > > > > memory and another variant is to say that headless object can be called
> > > > > > > > from preemptible context only.
> > > > > > > 
> > > > > > > Yes that makes sense, and we can always put disclaimer in the API's comments
> > > > > > > saying if this object is expected to be freed a lot, then don't use the
> > > > > > > headless-API to be extra safe.
> > > > > > > 
> > > > > > Agree.
> > > > > > 
> > > > > > > BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
> > > > > > > the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
> > > > > > > there seems to be bigger problems in the system any way. I would say let us
> > > > > > > write a patch to allocate there and see what the -mm guys think.
> > > > > > > 
> > > > > > OK. It might be that they can offer something if they do not like our
> > > > > > approach. I will try to compose something and send the patch to see.
> > > > > > The tree.c implementation is almost done, whereas tiny one is on hold.
> > > > > > 
> > > > > > I think we should support batching as well as bulk interface there.
> > > > > > Another way is to workaround head-less object, just to attach the head
> > > > > > dynamically using kmalloc() and then call_rcu() but then it will not be
> > > > > > a fair headless support :)
> > > > > > 
> > > > > > What is your view?
> > > > > > 
> > > > > > > > > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > > > > > > > > synchronize_rcu() inline with it.
> > > > > > > > > > 
> > > > > > > > > >
> > > > > > > > What do you mean here, Joel? "grow an rcu_head on the stack"?
> > > > > > > 
> > > > > > > By "grow on the stack", use the compiler-allocated rcu_head on the
> > > > > > > kfree_rcu() caller's stack.
> > > > > > > 
> > > > > > > I meant here to say, if we are not in atomic context, then we use regular
> > > > > > > GFP_KERNEL allocation, and if that fails, then we just use the stack's
> > > > > > > rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
> > > > > > > the allocation failure would mean the need for RCU to free some memory is
> > > > > > > probably great.
> > > > > > > 
> > > > > > Ah, i got it. I thought you meant something like recursion and then
> > > > > > unwinding the stack back somehow :)
> > > > > > 
> > > > > > > > > > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > > > > > > > > > between the 2 cases.
> > > > > > > > > > 
> > > > > > > > If the current context is preemptable then we can inline synchronize_rcu()
> > > > > > > > together with freeing to handle such corner case, i mean when we are run
> > > > > > > > out of memory.
> > > > > > > 
> > > > > > > Ah yes, exactly what I mean.
> > > > > > > 
> > > > > > OK.
> > > > > > 
> > > > > > > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > > > > > > have a look at preempt_count of current process? If we have for example
> > > > > > > > nested rcu_read_locks:
> > > > > > > > 
> > > > > > > > <snip>
> > > > > > > > rcu_read_lock()
> > > > > > > >     rcu_read_lock()
> > > > > > > >         rcu_read_lock()
> > > > > > > > <snip>
> > > > > > > > 
> > > > > > > > the counter would be 3.
> > > > > > > 
> > > > > > > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > > > > > > reader sections can be preempted, they just cannot goto sleep in a reader
> > > > > > > section (unless the kernel is RT).
> > > > > > > 
> > > > > > So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
> > > > > > using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
> > > > > > then we skip it and consider as atomic. Something like:
> > > > > > 
> > > > > > <snip>
> > > > > > static bool is_current_in_atomic()
> > > > > > {
> > > > > > #ifdef CONFIG_PREEMPT_RCU
> > > > > 
> > > > > If possible: if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> > > > > 
> > > > > Much nicer than #ifdef, and I -think- it should work in this case.
> > > > > 
> > > > OK. Thank you, Paul!
> > > > 
> > > > There is one point i would like to highlight it is about making caller
> > > > instead to be responsible for atomic or not decision. Like how kmalloc()
> > > > works, it does not really know the context it runs on, so it is up to
> > > > caller to inform.
> > > > 
> > > > The same way:
> > > > 
> > > > kvfree_rcu(p, atomic = true/false);
> > > > 
> > > > in this case we could cover !CONFIG_PREEMPT case also.
> > > 
> > > Understood, but couldn't we instead use IS_ENABLED() to work out the
> > > actual situation at runtime and relieve the caller of this burden?
> > > Or am I missing a corner case?
> > > 
> > Yes we can do it in run-time, i mean to detect context type, atomic or not.
> > But only for CONFIG_PREEMPT kernel. In case of !CONFIG_PREEMPT configuration 
> > i do not see a straight forward way how to detect it. For example when caller 
> > holds "spinlock". Therefore for such configuration we can just consider it
> > as atomic. But in reality it could be not in atomic.
> > 
> > We need it for emergency/corner case and head-less objects. When we are run
> > of memory. So in this case we should attach the rcu_head dynamically and
> > queue the freed object to be processed later on, after GP.
> > 
> > If atomic context use GFP_ATOMIC flag if not use GFP_KERNEL. It is better 
> > to allocate with GFP_KERNEL flag(if possible) because it has much less
> > restrictions then GFP_ATOMIC one, i.e. GFP_KERNEL can sleep and wait until
> > the memory is reclaimed.
> > 
> > But that is a corner case and i agree that it would be good to avoid of
> > such passing of extra info by the caller.
> > 
> > Anyway i just share some extra info :)
> 
> Hmm, I can't see at the moment how you can use GFP_KERNEL here for
> !CONFIG_PREEMPT kernels since that sleeps and you can't detect easily if you
> are in an RCU reader on !CONFIG_PREEMPT unless lockdep is turned on (in which
> case you could have checked lockdep's map).
> 
Right. Therefore i proposed to pass bolean variable indicating atomic or not.
So a caller is responsible to say where it is. It would be much more easier  
+ we would cover CONFIG_PREEMPT=n case. Otherwise we have to consider it as
atomic or in an RCU reader section, i.e. can not use synchronize_rcu() or 
GFP_KERNEL flags.

>
> How about for !PREEMPT using first: GFP_NOWAIT and second GFP_ATOMIC if
> (NOWAIT fails)?  And for PREEMPT, use GFP_KERNEL, then GFP_ATOMIC (if
> GFP_KERNEL fails).  Thoughts?
> 
Yes, it makes sense to me :) 

--
Vlad Rezki
