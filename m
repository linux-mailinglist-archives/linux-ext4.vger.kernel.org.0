Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7916B789
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 03:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgBYCHJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 21:07:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34478 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgBYCHJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Feb 2020 21:07:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id 11so6521286qkd.1
        for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2020 18:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mznXbsbUvYPe8XJoSstKhdOEAESChOu2NvRTa96OnE=;
        b=ZiHhh13QsXN70Ie3m4A3k+ikWm/78R8O4lbb6ufEmPiNprHKas4nJapW16m4s7I3CU
         mj2KFCW2rDiqVgsFKSfWuO2FUK7IY0jOtPL5T4wNI1uel1sCEV4idiAq3FZ7S0xWhAY0
         j4SluSDH+xbyLZ3FNnHgmFO2/2eMNYASTTDd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mznXbsbUvYPe8XJoSstKhdOEAESChOu2NvRTa96OnE=;
        b=QC92lc6nH7lHlV0/XsWM1I6O4uuKGVydN+a2Mzl/BY2DsMRhgTUPnQnzTLqlWQSYs2
         +NQOCjf8pw9OGXBB82UsVtUTLV4mIg5B8D6YcJ1POXCuzi5iJDnRA2kqz0uQZUHJDL5b
         oxaRIRCXSuE/gdfZhEvGI39zUqxIybjoNKv8+5rgYGU9G1cM9XFFkFk2Rki561n62kKN
         wZ5Z4YeGUemuFWODCm3T60joueRDMUeGvOknjqlObQFCF2iaQ1x4A62ht4IDBviLwcQR
         RI1QjcaiCLqFKmw8pg4BUulr4uWdMVMwvydg5ZQwlz3d7FEApWbfqQ2sEpeMzgSKQkz/
         eAXw==
X-Gm-Message-State: APjAAAVQ0r92RHG2P8cv6n2ECXdCAWpj27tIXIkg3ZqcFTccJd1k2h9v
        k5tHi7FRqiq3RdB8wqGL22Ke6Q==
X-Google-Smtp-Source: APXvYqxXN2kGyj8r+eTUAi0jxwBVvuizCQ+ex4C8syV7lN0zNdne2k4oiZ5pVdfLyYXtocBcJDpgKA==
X-Received: by 2002:a05:620a:1037:: with SMTP id a23mr53404655qkk.82.1582596427646;
        Mon, 24 Feb 2020 18:07:07 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o127sm1850657qke.92.2020.02.24.18.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 18:07:06 -0800 (PST)
Date:   Mon, 24 Feb 2020 21:07:05 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200225020705.GA253171@google.com>
References: <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224174030.GA22138@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 24, 2020 at 06:40:30PM +0100, Uladzislau Rezki wrote:
> On Sat, Feb 22, 2020 at 05:10:18PM -0800, Paul E. McKenney wrote:
> > On Sat, Feb 22, 2020 at 05:24:15PM -0500, Joel Fernandes wrote:
> > > On Fri, Feb 21, 2020 at 12:22:50PM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 21, 2020 at 02:14:55PM +0100, Uladzislau Rezki wrote:
> > > > > On Thu, Feb 20, 2020 at 04:30:35PM -0800, Paul E. McKenney wrote:
> > > > > > On Wed, Feb 19, 2020 at 11:52:33PM -0500, Theodore Y. Ts'o wrote:
> > > > > > > On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> > > > > > > > now it becomes possible to use it like: 
> > > > > > > > 	...
> > > > > > > > 	void *p = kvmalloc(PAGE_SIZE);
> > > > > > > > 	kvfree_rcu(p);
> > > > > > > > 	...
> > > > > > > > also have a look at the example in the mm/list_lru.c diff.
> > > > > > > 
> > > > > > > I certainly like the interface, thanks!  I'm going to be pushing
> > > > > > > patches to fix this using ext4_kvfree_array_rcu() since there are a
> > > > > > > number of bugs in ext4's online resizing which appear to be hitting
> > > > > > > multiple cloud providers (with reports from both AWS and GCP) and I
> > > > > > > want something which can be easily backported to stable kernels.
> > > > > > > 
> > > > > > > But once kvfree_rcu() hits mainline, I'll switch ext4 to use it, since
> > > > > > > your kvfree_rcu() is definitely more efficient than my expedient
> > > > > > > jury-rig.
> > > > > > > 
> > > > > > > I don't feel entirely competent to review the implementation, but I do
> > > > > > > have one question.  It looks like the rcutiny implementation of
> > > > > > > kfree_call_rcu() isn't going to do the right thing with kvfree_rcu(p).
> > > > > > > Am I missing something?
> > > > > > 
> > > > > > Good catch!  I believe that rcu_reclaim_tiny() would need to do
> > > > > > kvfree() instead of its current kfree().
> > > > > > 
> > > > > > Vlad, anything I am missing here?
> > > > > >
> > > > > Yes something like that. There are some open questions about
> > > > > realization, when it comes to tiny RCU. Since we are talking
> > > > > about "headless" kvfree_rcu() interface, i mean we can not link
> > > > > freed "objects" between each other, instead we should place a
> > > > > pointer directly into array that will be drained later on.
> > > > > 
> > > > > It would be much more easier to achieve that if we were talking
> > > > > about the interface like: kvfree_rcu(p, rcu), but that is not our
> > > > > case :)
> > > > > 
> > > > > So, for CONFIG_TINY_RCU we should implement very similar what we
> > > > > have done for CONFIG_TREE_RCU or just simply do like Ted has done
> > > > > with his
> > > > > 
> > > > > void ext4_kvfree_array_rcu(void *to_free)
> > > > > 
> > > > > i mean:
> > > > > 
> > > > >    local_irq_save(flags);
> > > > >    struct foo *ptr = kzalloc(sizeof(*ptr), GFP_ATOMIC);
> > > > > 
> > > > >    if (ptr) {
> > > > >            ptr->ptr = to_free;
> > > > >            call_rcu(&ptr->rcu, kvfree_callback);
> > > > >    }
> > > > >    local_irq_restore(flags);
> > > > 
> > > > We really do still need the emergency case, in this case for when
> > > > kzalloc() returns NULL.  Which does indeed mean an rcu_head in the thing
> > > > being freed.  Otherwise, you end up with an out-of-memory deadlock where
> > > > you could free memory only if you had memor to allocate.
> > > 
> > > Can we rely on GFP_ATOMIC allocations for these? These have emergency memory
> > > pools which are reserved.
> > 
> > You can, at least until the emergency memory pools are exhausted.
> > 
> > > I was thinking a 2 fold approach (just thinking out loud..):
> > > 
> > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > queue that.
> > > 
> I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> gets failed in atomic context? Or we can just consider it as out of
> memory and another variant is to say that headless object can be called
> from preemptible context only.

Yes that makes sense, and we can always put disclaimer in the API's comments
saying if this object is expected to be freed a lot, then don't use the
headless-API to be extra safe.

BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
there seems to be bigger problems in the system any way. I would say let us
write a patch to allocate there and see what the -mm guys think.

> > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > synchronize_rcu() inline with it.
> > > 
> > >
> What do you mean here, Joel? "grow an rcu_head on the stack"?

By "grow on the stack", use the compiler-allocated rcu_head on the
kfree_rcu() caller's stack.

I meant here to say, if we are not in atomic context, then we use regular
GFP_KERNEL allocation, and if that fails, then we just use the stack's
rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
the allocation failure would mean the need for RCU to free some memory is
probably great.

> > > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > > between the 2 cases.
> > > 
> If the current context is preemptable then we can inline synchronize_rcu()
> together with freeing to handle such corner case, i mean when we are run
> out of memory.

Ah yes, exactly what I mean.

> As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> have a look at preempt_count of current process? If we have for example
> nested rcu_read_locks:
> 
> <snip>
> rcu_read_lock()
>     rcu_read_lock()
>         rcu_read_lock()
> <snip>
> 
> the counter would be 3.

No, because preempt_count is not incremented during rcu_read_lock(). RCU
reader sections can be preempted, they just cannot goto sleep in a reader
section (unless the kernel is RT).

thanks,

 - Joel

