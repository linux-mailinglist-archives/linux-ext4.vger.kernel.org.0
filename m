Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1016ADC9
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2020 18:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBXRkn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 12:40:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33594 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgBXRkm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Feb 2020 12:40:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so11122690lji.0;
        Mon, 24 Feb 2020 09:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYSDYsVmOE1ofyKCdsVTaZRSTPTtkyk4gWDHGpw72g4=;
        b=BJ/3CloFdHRUl2DMdP2n77pbfp8FUHh1kbEOMNUsWeYgnnCyOn3Avbhp7BIiyfdWnC
         fOH6Jqm6Vsy9YNoBs38GKnkDrZVMClKoDTqHKtmZ+q6Ja4WT9LFim3w7SpnlbX3IqrAM
         BnSaEZY5MJgBaoSozWlwtlGXBGZyRVIj7nxe6TEqkGfqDcfNFQqEQifSBQGofwHKFQGd
         SOVj+cnJiidpSu08Ue3sQjBES0IUmRgszW+8yC9KNCgXZYZOrlMiYPz+oNYPn3E3HKjB
         ShwgaEGsnO4bkqYpWbnv46g0HXI6L+7mE6oTJjWx3OPcsEvX+6YJC90fKnyNt5cH3y5+
         3rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYSDYsVmOE1ofyKCdsVTaZRSTPTtkyk4gWDHGpw72g4=;
        b=osO28vCm+2acKMhUjxWO+SckYbfrgQL1JGm9+1JroS1izkEEQ6GzxAak+LsRvfA8UP
         JAM7FagkRtlOWvVpKV20nXgCXgOvA2QQZkTHWqp49N6MrJ7GQmNEMjoHcXHRpNIHc7jL
         QCeYJSxoEhzRjGE/l0PeXwaKivH/lI2tkM9IXzheOmtKiCg15bgOcw/K9si0qY9RraFp
         4Fxrjg9aqWh0Rvn+cbVFTPmXLwxMeFpC6VRYzovRTJZs/+d9E5pb1ytRIn5wy2Ucwkjb
         6dNsixhCc2WFKflivRk2rnASIiLNudeCqQuSrrvuyeyf2/Da6hQe69xDGCu+9CTTal4g
         U2LQ==
X-Gm-Message-State: APjAAAU8Unr6Zr9G0ZM5eSDbvgf9lnfNocJDc3X7xp536G+4Eog0E+m4
        nwLlmiy6PgfzOr89QwqDjvI=
X-Google-Smtp-Source: APXvYqwOzWPvbR9vHawikUu7D7pznrK2FlvMUTTyhV8xT5SOTaMbxzzTpG9ZMpzd5SSfXQPTSLkUTw==
X-Received: by 2002:a2e:9118:: with SMTP id m24mr31125400ljg.105.1582566039664;
        Mon, 24 Feb 2020 09:40:39 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id s17sm7913330ljo.18.2020.02.24.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 09:40:39 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 24 Feb 2020 18:40:30 +0100
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200224174030.GA22138@pc636>
References: <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223011018.GB2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 22, 2020 at 05:10:18PM -0800, Paul E. McKenney wrote:
> On Sat, Feb 22, 2020 at 05:24:15PM -0500, Joel Fernandes wrote:
> > On Fri, Feb 21, 2020 at 12:22:50PM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 21, 2020 at 02:14:55PM +0100, Uladzislau Rezki wrote:
> > > > On Thu, Feb 20, 2020 at 04:30:35PM -0800, Paul E. McKenney wrote:
> > > > > On Wed, Feb 19, 2020 at 11:52:33PM -0500, Theodore Y. Ts'o wrote:
> > > > > > On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> > > > > > > now it becomes possible to use it like: 
> > > > > > > 	...
> > > > > > > 	void *p = kvmalloc(PAGE_SIZE);
> > > > > > > 	kvfree_rcu(p);
> > > > > > > 	...
> > > > > > > also have a look at the example in the mm/list_lru.c diff.
> > > > > > 
> > > > > > I certainly like the interface, thanks!  I'm going to be pushing
> > > > > > patches to fix this using ext4_kvfree_array_rcu() since there are a
> > > > > > number of bugs in ext4's online resizing which appear to be hitting
> > > > > > multiple cloud providers (with reports from both AWS and GCP) and I
> > > > > > want something which can be easily backported to stable kernels.
> > > > > > 
> > > > > > But once kvfree_rcu() hits mainline, I'll switch ext4 to use it, since
> > > > > > your kvfree_rcu() is definitely more efficient than my expedient
> > > > > > jury-rig.
> > > > > > 
> > > > > > I don't feel entirely competent to review the implementation, but I do
> > > > > > have one question.  It looks like the rcutiny implementation of
> > > > > > kfree_call_rcu() isn't going to do the right thing with kvfree_rcu(p).
> > > > > > Am I missing something?
> > > > > 
> > > > > Good catch!  I believe that rcu_reclaim_tiny() would need to do
> > > > > kvfree() instead of its current kfree().
> > > > > 
> > > > > Vlad, anything I am missing here?
> > > > >
> > > > Yes something like that. There are some open questions about
> > > > realization, when it comes to tiny RCU. Since we are talking
> > > > about "headless" kvfree_rcu() interface, i mean we can not link
> > > > freed "objects" between each other, instead we should place a
> > > > pointer directly into array that will be drained later on.
> > > > 
> > > > It would be much more easier to achieve that if we were talking
> > > > about the interface like: kvfree_rcu(p, rcu), but that is not our
> > > > case :)
> > > > 
> > > > So, for CONFIG_TINY_RCU we should implement very similar what we
> > > > have done for CONFIG_TREE_RCU or just simply do like Ted has done
> > > > with his
> > > > 
> > > > void ext4_kvfree_array_rcu(void *to_free)
> > > > 
> > > > i mean:
> > > > 
> > > >    local_irq_save(flags);
> > > >    struct foo *ptr = kzalloc(sizeof(*ptr), GFP_ATOMIC);
> > > > 
> > > >    if (ptr) {
> > > >            ptr->ptr = to_free;
> > > >            call_rcu(&ptr->rcu, kvfree_callback);
> > > >    }
> > > >    local_irq_restore(flags);
> > > 
> > > We really do still need the emergency case, in this case for when
> > > kzalloc() returns NULL.  Which does indeed mean an rcu_head in the thing
> > > being freed.  Otherwise, you end up with an out-of-memory deadlock where
> > > you could free memory only if you had memor to allocate.
> > 
> > Can we rely on GFP_ATOMIC allocations for these? These have emergency memory
> > pools which are reserved.
> 
> You can, at least until the emergency memory pools are exhausted.
> 
> > I was thinking a 2 fold approach (just thinking out loud..):
> > 
> > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > queue that.
> > 
I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
gets failed in atomic context? Or we can just consider it as out of
memory and another variant is to say that headless object can be called
from preemptible context only.

> >
> > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > synchronize_rcu() inline with it.
> > 
> >
What do you mean here, Joel? "grow an rcu_head on the stack"?

> >
> > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > between the 2 cases.
> > 
If the current context is preemptable then we can inline synchronize_rcu()
together with freeing to handle such corner case, i mean when we are run
out of memory.

As for "task_struct's rcu_read_lock_nesting". Will it be enough just
have a look at preempt_count of current process? If we have for example
nested rcu_read_locks:

<snip>
rcu_read_lock()
    rcu_read_lock()
        rcu_read_lock()
<snip>

the counter would be 3.

> 
> How much are we really losing by having an rcu_head in the structure,
> either separately or unioned over other fields?
> 
> > > > Also there is one more open question what to do if GFP_ATOMIC
> > > > gets failed in case of having low memory condition. Probably
> > > > we can make use of "mempool interface" that allows to have
> > > > min_nr guaranteed pre-allocated pages. 
> > > 
> > > But we really do still need to handle the case where everything runs out,
> > > even the pre-allocated pages.
> > 
> > If *everything* runs out, you are pretty much going to OOM sooner or later
> > anyway :D. But I see what you mean. But the 'tradeoff' is RCU can free
> > head-less objects where possible.
> 
> Would you rather pay an rcu_head tax (in cases where it cannot share
> with other fields), or would you rather have states where you could free
> a lot of memory if only there was some memory to allocate to track the
> memory to be freed?
> 
> But yes, as you suggested above, there could be an API similar to the
> userspace RCU library's API that usually just queues the callback but
> sometimes sleeps for a full grace period.  If enough people want this,
> it should not be hard to set up.
> 

--
Vlad Rezki
