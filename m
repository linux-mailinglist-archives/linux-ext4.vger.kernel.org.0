Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD916FF93
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Feb 2020 14:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBZNEu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Feb 2020 08:04:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43273 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBZNEu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Feb 2020 08:04:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id e3so1935459lja.10;
        Wed, 26 Feb 2020 05:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O25EKQ/j7WjcsbpKkgnPuipDcLm308M3Qu8bOQqW64A=;
        b=ilKxL3+WgTagCjZB+A3/fi+owewEyGmO6tSxsdWl9xJkdj7Ke3DEtDuwx/9VC/RPeg
         ZGBvXcJHemljLzQtxT1+6NkxlbNIlH3Tr3BKXduLPEQi5B2vT3+nJ0TNoif9BT9oAVRq
         rptC753JSjuGIzjpUVscH24MgHRdLBcbwpq37sVIsj0WUMFZcxeL1wDdI6Xg/L498ZxC
         TSNSMTJSLUJqhcbXtWGkMRnHJMf3aLsAVyWbW1yebObQrr1/tOjLecAzHB9MACx+IaKy
         n2GiaHut4k96a1e8EB1hEplUCzLlxrYC8qhEF12aP5P/Hjn1ivCpuE0gthxb/Se4HEqg
         iNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O25EKQ/j7WjcsbpKkgnPuipDcLm308M3Qu8bOQqW64A=;
        b=GwEMaLPGhm4KbcgmYCSfk2IRnNdhf+lkPEYAnsJdaPAbaAxjSxFjI6brUBE50zfFIm
         FA+pEUWCAoa8FdGWZIY4sM4ruWv/MEnq0lYI1B9B6HDIF2vRFNVaXOsFRSzb3ulnXmBA
         c+FDgYLaq3Q6vERGrP+k9+TDvUFbnm/jlhPxyALhxL6vFOtpmALzzIqOqoLO5rNBmtDR
         lhGwbaK7bJmfomqIvXn+aDxUqZoslX8lk9GyMu9wA8xn2AOTGr/B5gGw3rcn72Bzzi3F
         D1UlI6SFysVU/HdJLvNJC/7KARarKrsWLgHkISKRyWw01IgeMYc4YeUypRRKV0TkYQgM
         luSA==
X-Gm-Message-State: APjAAAVnlGcCu17qdNASLaM07BlSoi3tNHm+c3uxDdHQNI1apblnWKVt
        fYLmW/xWIUjcnuCeTpH/wOk=
X-Google-Smtp-Source: APXvYqy+w3/Rihtqgl84Z/m0zDxtBGcbJLHw6UD8Tbza68FJyTLvbIZ90z1QtoGVXcysYEmWUrDugw==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr3043598ljg.144.1582722288157;
        Wed, 26 Feb 2020 05:04:48 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id f8sm1001149lfc.10.2020.02.26.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 05:04:47 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 26 Feb 2020 14:04:40 +0100
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
Message-ID: <20200226130440.GA30008@pc636>
References: <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
 <20200225185400.GA27919@pc636>
 <20200225224745.GX2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225224745.GX2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 25, 2020 at 02:47:45PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 25, 2020 at 07:54:00PM +0100, Uladzislau Rezki wrote:
> > > > > > I was thinking a 2 fold approach (just thinking out loud..):
> > > > > > 
> > > > > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > > > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > > > > queue that.
> > > > > > 
> > > > I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> > > > gets failed in atomic context? Or we can just consider it as out of
> > > > memory and another variant is to say that headless object can be called
> > > > from preemptible context only.
> > > 
> > > Yes that makes sense, and we can always put disclaimer in the API's comments
> > > saying if this object is expected to be freed a lot, then don't use the
> > > headless-API to be extra safe.
> > > 
> > Agree.
> > 
> > > BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
> > > the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
> > > there seems to be bigger problems in the system any way. I would say let us
> > > write a patch to allocate there and see what the -mm guys think.
> > > 
> > OK. It might be that they can offer something if they do not like our
> > approach. I will try to compose something and send the patch to see.
> > The tree.c implementation is almost done, whereas tiny one is on hold.
> > 
> > I think we should support batching as well as bulk interface there.
> > Another way is to workaround head-less object, just to attach the head
> > dynamically using kmalloc() and then call_rcu() but then it will not be
> > a fair headless support :)
> > 
> > What is your view?
> > 
> > > > > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > > > > synchronize_rcu() inline with it.
> > > > > > 
> > > > > >
> > > > What do you mean here, Joel? "grow an rcu_head on the stack"?
> > > 
> > > By "grow on the stack", use the compiler-allocated rcu_head on the
> > > kfree_rcu() caller's stack.
> > > 
> > > I meant here to say, if we are not in atomic context, then we use regular
> > > GFP_KERNEL allocation, and if that fails, then we just use the stack's
> > > rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
> > > the allocation failure would mean the need for RCU to free some memory is
> > > probably great.
> > > 
> > Ah, i got it. I thought you meant something like recursion and then
> > unwinding the stack back somehow :)
> > 
> > > > > > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > > > > > between the 2 cases.
> > > > > > 
> > > > If the current context is preemptable then we can inline synchronize_rcu()
> > > > together with freeing to handle such corner case, i mean when we are run
> > > > out of memory.
> > > 
> > > Ah yes, exactly what I mean.
> > > 
> > OK.
> > 
> > > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > > have a look at preempt_count of current process? If we have for example
> > > > nested rcu_read_locks:
> > > > 
> > > > <snip>
> > > > rcu_read_lock()
> > > >     rcu_read_lock()
> > > >         rcu_read_lock()
> > > > <snip>
> > > > 
> > > > the counter would be 3.
> > > 
> > > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > > reader sections can be preempted, they just cannot goto sleep in a reader
> > > section (unless the kernel is RT).
> > > 
> > So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
> > using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
> > then we skip it and consider as atomic. Something like:
> > 
> > <snip>
> > static bool is_current_in_atomic()
> > {
> > #ifdef CONFIG_PREEMPT_RCU
> 
> If possible: if (IS_ENABLED(CONFIG_PREEMPT_RCU))
> 
> Much nicer than #ifdef, and I -think- it should work in this case.
> 
OK. Thank you, Paul!

There is one point i would like to highlight it is about making caller
instead to be responsible for atomic or not decision. Like how kmalloc()
works, it does not really know the context it runs on, so it is up to
caller to inform.

The same way:

kvfree_rcu(p, atomic = true/false);

in this case we could cover !CONFIG_PREEMPT case also.

--
Vlad Rezki
