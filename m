Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D23B16920F
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2020 23:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBVWYU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Feb 2020 17:24:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34125 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgBVWYU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Feb 2020 17:24:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id 11so1349278qkd.1
        for <linux-ext4@vger.kernel.org>; Sat, 22 Feb 2020 14:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZF9LbUNZg5HlajZQndFknXuW2sz/slubs7EATboatLA=;
        b=dEXWUbD6RYJ9OeB2s6SqbDbV9IsIykjUvTeBQ+8D09VaaLNHpNmCPjDZ7SLrC7ZNTL
         BsVMVjMBAZvZ4cuhBJv/F02F5tdf9om9ft9OVbXKl7GjwlcaHChmyiMxO5VyzWTkDKQH
         o0sZQn/G8pT5DZKmJvyT8osZyABADSEPWBxXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZF9LbUNZg5HlajZQndFknXuW2sz/slubs7EATboatLA=;
        b=Tj8WNOIfd7Ji4a7IKFo4MCz1eED+HaQFCAl+A9lZSlFApDR9wKDBdNn1hmNifLHUtF
         pcv0dgpOm8LnMSs+nC6MZAw86yijKoeEl7gZXG7rpPfDmmdoLyTnad1mGLoojMoAuiJf
         nV/1ZTyKu2lnnwiIDffEwif4NZ0+9FVt6lehpEgePfLv/0xTt6vxbbXAUospkLkKZ2kG
         3V3Tz4kbwe3UNP+QZpUIarmiSXCvIokbVV1n61ht8D+9JYeXrSiBMw9diRmdor+v0v14
         CGTD8YhuoE0t4/1BEA1C/QOf2drvNcQVcOs+7eBo7K424cCf6Rzn8O1XaNsLTtMf5qnx
         7pcg==
X-Gm-Message-State: APjAAAUSU71NbEpV6d//ecFsIgXKtRLA2Jf3FYTDhvkkrRCZQtCXPdc0
        8iLi71Qu4Buh2DdJoTbjAUb8Gw==
X-Google-Smtp-Source: APXvYqyOsXBY1YbzemprzZGG5Ktxb3rWaCylOgFYfn9KQOs4tv5YJWSM1yFrYwqIkSHTPCk0y6n3Bw==
X-Received: by 2002:a05:620a:1583:: with SMTP id d3mr41344906qkk.290.1582410256964;
        Sat, 22 Feb 2020 14:24:16 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e20sm3808033qka.39.2020.02.22.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:24:16 -0800 (PST)
Date:   Sat, 22 Feb 2020 17:24:15 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200222222415.GC191380@google.com>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221202250.GK2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 21, 2020 at 12:22:50PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 21, 2020 at 02:14:55PM +0100, Uladzislau Rezki wrote:
> > On Thu, Feb 20, 2020 at 04:30:35PM -0800, Paul E. McKenney wrote:
> > > On Wed, Feb 19, 2020 at 11:52:33PM -0500, Theodore Y. Ts'o wrote:
> > > > On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> > > > > now it becomes possible to use it like: 
> > > > > 	...
> > > > > 	void *p = kvmalloc(PAGE_SIZE);
> > > > > 	kvfree_rcu(p);
> > > > > 	...
> > > > > also have a look at the example in the mm/list_lru.c diff.
> > > > 
> > > > I certainly like the interface, thanks!  I'm going to be pushing
> > > > patches to fix this using ext4_kvfree_array_rcu() since there are a
> > > > number of bugs in ext4's online resizing which appear to be hitting
> > > > multiple cloud providers (with reports from both AWS and GCP) and I
> > > > want something which can be easily backported to stable kernels.
> > > > 
> > > > But once kvfree_rcu() hits mainline, I'll switch ext4 to use it, since
> > > > your kvfree_rcu() is definitely more efficient than my expedient
> > > > jury-rig.
> > > > 
> > > > I don't feel entirely competent to review the implementation, but I do
> > > > have one question.  It looks like the rcutiny implementation of
> > > > kfree_call_rcu() isn't going to do the right thing with kvfree_rcu(p).
> > > > Am I missing something?
> > > 
> > > Good catch!  I believe that rcu_reclaim_tiny() would need to do
> > > kvfree() instead of its current kfree().
> > > 
> > > Vlad, anything I am missing here?
> > >
> > Yes something like that. There are some open questions about
> > realization, when it comes to tiny RCU. Since we are talking
> > about "headless" kvfree_rcu() interface, i mean we can not link
> > freed "objects" between each other, instead we should place a
> > pointer directly into array that will be drained later on.
> > 
> > It would be much more easier to achieve that if we were talking
> > about the interface like: kvfree_rcu(p, rcu), but that is not our
> > case :)
> > 
> > So, for CONFIG_TINY_RCU we should implement very similar what we
> > have done for CONFIG_TREE_RCU or just simply do like Ted has done
> > with his
> > 
> > void ext4_kvfree_array_rcu(void *to_free)
> > 
> > i mean:
> > 
> >    local_irq_save(flags);
> >    struct foo *ptr = kzalloc(sizeof(*ptr), GFP_ATOMIC);
> > 
> >    if (ptr) {
> >            ptr->ptr = to_free;
> >            call_rcu(&ptr->rcu, kvfree_callback);
> >    }
> >    local_irq_restore(flags);
> 
> We really do still need the emergency case, in this case for when
> kzalloc() returns NULL.  Which does indeed mean an rcu_head in the thing
> being freed.  Otherwise, you end up with an out-of-memory deadlock where
> you could free memory only if you had memor to allocate.

Can we rely on GFP_ATOMIC allocations for these? These have emergency memory
pools which are reserved.

I was thinking a 2 fold approach (just thinking out loud..):

If kfree_call_rcu() is called in atomic context or in any rcu reader, then
use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
queue that.

Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
synchronize_rcu() inline with it.

Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
between the 2 cases.

Thoughts?

> > Also there is one more open question what to do if GFP_ATOMIC
> > gets failed in case of having low memory condition. Probably
> > we can make use of "mempool interface" that allows to have
> > min_nr guaranteed pre-allocated pages. 
> 
> But we really do still need to handle the case where everything runs out,
> even the pre-allocated pages.

If *everything* runs out, you are pretty much going to OOM sooner or later
anyway :D. But I see what you mean. But the 'tradeoff' is RCU can free
head-less objects where possible.

thanks,

 - Joel

