Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9110716EE6A
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 19:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgBYSyM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 13:54:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46870 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgBYSyM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Feb 2020 13:54:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id u2so7843939lfk.13;
        Tue, 25 Feb 2020 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I67NIEQPdsJxMgQqMIJkKCIxMoKM4fFB4eKacrRm7s4=;
        b=r6el0YHZXimCldwGeCQk+Dd7FALU/v4Te3AWinIu2hFCbOGEKkYcD5JX9MXA+POpue
         YcvjdilSxnGIBITFuRqv+J4Hifl1NxByKFQTK8dLVkP/LUpqYn6XxctTj5WY88ICG6Dd
         jnaoAEqJzoujyPr0TkmgU4HMpgBxqk3vLI9H8SDl3QX9534V+AmuTFhc+KqQ+cbY/RXL
         j5I3axLto9YUbOohHVF1MVwemFflXo3BL6XH07o5Ey4g/Wg6VdDNge4afsnB+e8bFtz4
         t6TrZo8YCRFbpMqaZ/T6K625JilZ2PNVrFQMRFE4Kl9kem8ViNIgo4EZQPb7ZcqH9M34
         YJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I67NIEQPdsJxMgQqMIJkKCIxMoKM4fFB4eKacrRm7s4=;
        b=h6pWV3zYQWlgcDs5RBMwrSINXJSS9YCb+8jzjFtJBNLtmTpe1IVCpsBu1bX6I2NFGS
         /CQ3N0sGDtYfWJkKGATev5Zi4AzD/8fjh4pjTj93hYee+YsWdy92TjNsTJz5bjyf80in
         VlrX0O/F12mRVuKwszDVjMrdMVPJrvSN8DymMyxYjEDwmeV0qOd1lBZXXdzs0Cl7T8qw
         r7JLeHyqaxYEz3/yBb0h3VMvtlPXhWXngLgUp15IbhxC0odUxqDdvHk7OnyGX+ByUw8P
         JnL+HYp5ZUfNFBlnrnXn+4QdpIfpAH1XTQQn3qsrixlIqxrvJKrqcGM0ssB0K15e9TCI
         DaHQ==
X-Gm-Message-State: APjAAAXoPhK6j3AViVjr86b0X5Es3tAWy8fkAAxlnRkrOWFRFxpjXgVK
        SDoXhcxKQc8E5qDGQHCLjcioFxpJpKoVpg==
X-Google-Smtp-Source: APXvYqze30JVzgeVtjHqBSnnMsTG0tjmfoa2n18VRYONPZJGVJre0pEhjI1W/PLbZFuyV5TPaf+fBA==
X-Received: by 2002:ac2:46c2:: with SMTP id p2mr118708lfo.139.1582656849336;
        Tue, 25 Feb 2020 10:54:09 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id y14sm8331861ljk.46.2020.02.25.10.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:54:08 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 25 Feb 2020 19:54:00 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200225185400.GA27919@pc636>
References: <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225020705.GA253171@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> > > > I was thinking a 2 fold approach (just thinking out loud..):
> > > > 
> > > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > > queue that.
> > > > 
> > I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> > gets failed in atomic context? Or we can just consider it as out of
> > memory and another variant is to say that headless object can be called
> > from preemptible context only.
> 
> Yes that makes sense, and we can always put disclaimer in the API's comments
> saying if this object is expected to be freed a lot, then don't use the
> headless-API to be extra safe.
> 
Agree.

> BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
> the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
> there seems to be bigger problems in the system any way. I would say let us
> write a patch to allocate there and see what the -mm guys think.
> 
OK. It might be that they can offer something if they do not like our
approach. I will try to compose something and send the patch to see.
The tree.c implementation is almost done, whereas tiny one is on hold.

I think we should support batching as well as bulk interface there.
Another way is to workaround head-less object, just to attach the head
dynamically using kmalloc() and then call_rcu() but then it will not be
a fair headless support :)

What is your view?

> > > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > > synchronize_rcu() inline with it.
> > > > 
> > > >
> > What do you mean here, Joel? "grow an rcu_head on the stack"?
> 
> By "grow on the stack", use the compiler-allocated rcu_head on the
> kfree_rcu() caller's stack.
> 
> I meant here to say, if we are not in atomic context, then we use regular
> GFP_KERNEL allocation, and if that fails, then we just use the stack's
> rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
> the allocation failure would mean the need for RCU to free some memory is
> probably great.
> 
Ah, i got it. I thought you meant something like recursion and then
unwinding the stack back somehow :)

> > > > Use preemptible() andr task_struct's rcu_read_lock_nesting to differentiate
> > > > between the 2 cases.
> > > > 
> > If the current context is preemptable then we can inline synchronize_rcu()
> > together with freeing to handle such corner case, i mean when we are run
> > out of memory.
> 
> Ah yes, exactly what I mean.
> 
OK.

> > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > have a look at preempt_count of current process? If we have for example
> > nested rcu_read_locks:
> > 
> > <snip>
> > rcu_read_lock()
> >     rcu_read_lock()
> >         rcu_read_lock()
> > <snip>
> > 
> > the counter would be 3.
> 
> No, because preempt_count is not incremented during rcu_read_lock(). RCU
> reader sections can be preempted, they just cannot goto sleep in a reader
> section (unless the kernel is RT).
> 
So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
then we skip it and consider as atomic. Something like:

<snip>
static bool is_current_in_atomic()
{
#ifdef CONFIG_PREEMPT_RCU
    if (!rcu_preempt_depth() && !in_atomic())
        return false;
#endif

    return true;
}
<snip>

Thanks!

--
Vlad Rezki
