Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD01117032F
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 16:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgBZPx6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 10:53:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39631 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgBZPx6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Feb 2020 10:53:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so3664649ljg.6;
        Wed, 26 Feb 2020 07:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nRV/ZP4gHjtmZI58ArlgV50vbukG5a7XrSGzPw4XlO0=;
        b=D59yYChxABJVuiRSx3NvnkYsU3atQDD/8A4eIUwnEL0U6o+ezF8kcW9fFHkSeF9mlw
         Wxqhr7lpZBOtxnjee9PGbcSG8DNXg0G+hnijcT2t0V6BcjIgS86+kug1SQDLPQtTnMm0
         ZvwNv5OaIUss5PDhJKVQvNVizU/dYaueSJs+fWML+b+Li/Rj8f3eDtoAILkP//nqXG3M
         jv9RSPsNDzid28di/eUzLjG+BlhQF6TGtT7lYmnh4f6SKZawcNqMtVIetpSqJgUWqDYg
         8HkHEEBhutZH3E6sT+PqMO5FeE/l6VnxB1C5HN2m1Sj1Ct28FS50lpqjBUjFCwV6tQDJ
         AsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nRV/ZP4gHjtmZI58ArlgV50vbukG5a7XrSGzPw4XlO0=;
        b=DFdgQHefDMYVs6dlSTmkfLCw0VEJuEliHXotMCvSOqJszQel+eIgqLUFwjLv+5GM7l
         ooHGssz6xeUiotTaiBDk4D3y3l+z/I5tl1a07c4x3W3RM9AEScalROX99CgTpIcQSxEG
         H5hMzg3mZSHL6rtkNpVM0bc8I37oYNmGUNqg9CEMRRnNZVknzYlu2yr6GFmodZbwgKQz
         sd3bAE9XV+K3o5uCGkG7D7RaX6M7qrGk8uz0zx5z9kSJxX0xKiRUmmpasxeWwu0h+rz/
         kOCbQ2yLfdNwmVrUxY9TOJsIp+wTLSucgViffnZ1MWPeVag2vwEuK+dRVIBVWldv1MW8
         D1OA==
X-Gm-Message-State: ANhLgQ1MhSdLwbpaLgq9g0GwnHhr6Y7DwujhCDSHSK7HdVnLKISMoegs
        W6OnUfU13cgvmKYrCnZ/kb0=
X-Google-Smtp-Source: APXvYqwJzR534F4/1UlXIrbEygIJDJzO5mNQYN3rQ1JR+d6FXFFN7Jx5ejo5oMUyolsi57Evy1WkbA==
X-Received: by 2002:a2e:95c4:: with SMTP id y4mr3454093ljh.38.1582732435265;
        Wed, 26 Feb 2020 07:53:55 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id f21sm1407986ljc.30.2020.02.26.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:53:54 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 26 Feb 2020 16:53:47 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200226155347.GA31097@pc636>
References: <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
 <20200225185400.GA27919@pc636>
 <20200225224745.GX2935@paulmck-ThinkPad-P72>
 <20200226130440.GA30008@pc636>
 <20200226150656.GB2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226150656.GB2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 26, 2020 at 07:06:56AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 26, 2020 at 02:04:40PM +0100, Uladzislau Rezki wrote:
> > On Tue, Feb 25, 2020 at 02:47:45PM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 25, 2020 at 07:54:00PM +0100, Uladzislau Rezki wrote:
> > > > > > > > I was thinking a 2 fold approach (just thinking out loud..):
> > > > > > > > 
> > > > > > > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > > > > > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > > > > > > queue that.
> > > > > > > > 
> > > > > > I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> > > > > > gets failed in atomic context? Or we can just consider it as out of
> > > > > > memory and another variant is to say that headless object can be called
> > > > > > from preemptible context only.
> > > > > 
> > > > > Yes that makes sense, and we can always put disclaimer in the API's comments
> > > > > saying if this object is expected to be freed a lot, then don't use the
> > > > > headless-API to be extra safe.
> > > > > 
> > > > Agree.
> > > > 
> > > > > BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
> > > > > the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
> > > > > there seems to be bigger problems in the system any way. I would say let us
> > > > > write a patch to allocate there and see what the -mm guys think.
> > > > > 
> > > > OK. It might be that they can offer something if they do not like our
> > > > approach. I will try to compose something and send the patch to see.
> > > > The tree.c implementation is almost done, whereas tiny one is on hold.
> > > > 
> > > > I think we should support batching as well as bulk interface there.
> > > > Another way is to workaround head-less object, just to attach the head
> > > > dynamically using kmalloc() and then call_rcu() but then it will not be
> > > > a fair headless support :)
> > > > 
> > > > What is your view?
> > > > 
> > > > > > > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > > > > > > synchronize_rcu() inline with it.
> > > > > > > > 
> > > > > > > >
> > > > > > What do you mean here, Joel? "grow an rcu_head on the stack"?
> > > > > 
> > > > > By "grow on the stack", use the compiler-allocated rcu_head on the
> > > > > kfree_rcu() caller's stack.
> > > > > 
> > > > > I meant here to say, if we are not in atomic context, then we use regular
> > > > > GFP_KERNEL allocation, and if that fails, then we just use the stack's
> > > > > rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
> > > > > the allocation failure would mean the need for RCU to free some memory is
> > > > > probably great.
> > > > > 
> > > > Ah, i got it. I thought you meant something like recursion and then
> > > > unwinding the stack back somehow :)
> > > > 
> > > > > > > > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > > > > > > > between the 2 cases.
> > > > > > > > 
> > > > > > If the current context is preemptable then we can inline synchronize_rcu()
> > > > > > together with freeing to handle such corner case, i mean when we are run
> > > > > > out of memory.
> > > > > 
> > > > > Ah yes, exactly what I mean.
> > > > > 
> > > > OK.
> > > > 
> > > > > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > > > > have a look at preempt_count of current process? If we have for example
> > > > > > nested rcu_read_locks:
> > > > > > 
> > > > > > <snip>
> > > > > > rcu_read_lock()
> > > > > >     rcu_read_lock()
> > > > > >         rcu_read_lock()
> > > > > > <snip>
> > > > > > 
> > > > > > the counter would be 3.
> > > > > 
> > > > > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > > > > reader sections can be preempted, they just cannot goto sleep in a reader
> > > > > section (unless the kernel is RT).
> > > > > 
> > > > So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
> > > > using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
> > > > then we skip it and consider as atomic. Something like:
> > > > 
> > > > <snip>
> > > > static bool is_current_in_atomic()
> > > > {
> > > > #ifdef CONFIG_PREEMPT_RCU
> > > 
> > > If possible: if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> > > 
> > > Much nicer than #ifdef, and I -think- it should work in this case.
> > > 
> > OK. Thank you, Paul!
> > 
> > There is one point i would like to highlight it is about making caller
> > instead to be responsible for atomic or not decision. Like how kmalloc()
> > works, it does not really know the context it runs on, so it is up to
> > caller to inform.
> > 
> > The same way:
> > 
> > kvfree_rcu(p, atomic = true/false);
> > 
> > in this case we could cover !CONFIG_PREEMPT case also.
> 
> Understood, but couldn't we instead use IS_ENABLED() to work out the
> actual situation at runtime and relieve the caller of this burden?
> Or am I missing a corner case?
> 
Yes we can do it in run-time, i mean to detect context type, atomic or not.
But only for CONFIG_PREEMPT kernel. In case of !CONFIG_PREEMPT configuration 
i do not see a straight forward way how to detect it. For example when caller 
holds "spinlock". Therefore for such configuration we can just consider it
as atomic. But in reality it could be not in atomic.

We need it for emergency/corner case and head-less objects. When we are run
of memory. So in this case we should attach the rcu_head dynamically and
queue the freed object to be processed later on, after GP.

If atomic context use GFP_ATOMIC flag if not use GFP_KERNEL. It is better 
to allocate with GFP_KERNEL flag(if possible) because it has much less
restrictions then GFP_ATOMIC one, i.e. GFP_KERNEL can sleep and wait until
the memory is reclaimed.

But that is a corner case and i agree that it would be good to avoid of
such passing of extra info by the caller.

Anyway i just share some extra info :)

Thanks.

--
Vlad Rezki
