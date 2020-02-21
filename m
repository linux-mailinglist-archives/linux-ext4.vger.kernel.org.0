Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4716875E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 20:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgBUTWH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 14:22:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35962 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgBUTWH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 14:22:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so3348771ljg.3;
        Fri, 21 Feb 2020 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bDDD9QS51C8HABJX5Kswii4LZuMup2Q1KmKUNTg9WcI=;
        b=d1rNua/lZJ5hE0ZUd/ZtqyYz4uPoKdWgw7gFNQSOhnpmXpqoyRpxXPAZ3AzI6QHfu7
         uxZ/EjEufQ4uoqzIbMaUdH/+ZGiz/CU+TNxr3LOiB10oKqgdBmq1ULCWikJk9lQ424wM
         LG8stYBGhHincNDLy52LYL7GoRP9K4qz8itg0UOUMLauWe6VssqKqbGFJK5i/BB5Qtp9
         1ojRAi+TaPtTbeGuAlyS8JvJFQDrUCl88UEmQ24qaqPl69s4k2vqCib2w30EHqwOn9J8
         2DAmWCXisbBxYhE6WtCp1plmCo2OJOq3tlQumJ0ecMe7+KJoJgMOWEPvjE3+LVQaLsgt
         x1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDDD9QS51C8HABJX5Kswii4LZuMup2Q1KmKUNTg9WcI=;
        b=T5YHAkr9iYiZK0OWxjXe6z6wcqd05iZAlLBHtx/yMBxLPutndouFEqU9B9MSxQRaUv
         kgm1Sh7xvPMSDtTgsjnRBE9++4sF2rC5q+y72VmOJsbDk94+jdpBZySlIuqJizT51hhc
         tYc+dVbnH60IXWtIvi1GU2hpo2473PrMuIuws8HBHmSudarQ4HiyucgmkLTerZ21KF/b
         YoEMaT9bESTmtXWvCp6i7NRr6hCaqsdet3MiP/Jbv9mM4WhMHPdgX965papkwD5Npi8d
         PgS/KuEemeiWPOh7mfYSfZufrDFntbI2kr7AwIHVialVD74cG5C9aOYC5F9sQgOkfI4K
         ZDaA==
X-Gm-Message-State: APjAAAVSVMi1ENADO6aY6UctZWmA9RLipxGyB9PxQmFK7Rf8EVr6J9+a
        k5pvnMWq/1sA5gWXDpxAzDg=
X-Google-Smtp-Source: APXvYqxHnV+rlw73EGLCV62VYkWgaqa5e6zLDPiymU4n0efao/yzLRnKeAfa93oR0Qdc7K1A1L/pvQ==
X-Received: by 2002:a05:651c:314:: with SMTP id a20mr23125542ljp.91.1582312924151;
        Fri, 21 Feb 2020 11:22:04 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id n3sm2116680ljc.100.2020.02.21.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 11:22:03 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 21 Feb 2020 20:21:52 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200221192152.GA6306@pc636>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200221120618.GA194360@google.com>
 <20200221132817.GB194360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221132817.GB194360@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> > 
> > Overall this implementation is nice. You are basically avoiding allocating
> > rcu_head like Ted did by using the array-of-pointers technique we used for
> > the previous kfree_rcu() work.
> > 
> > One thing stands out, the path where we could not allocate a page for the new
> > block node:
> > 
> > > @@ -3061,6 +3148,11 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >         if (krcp->initialized)
> > >                 spin_unlock(&krcp->lock);
> > >         local_irq_restore(flags);
> > > +
> > > +       if (!skip_call_rcu) {
> > > +               synchronize_rcu();
> > > +               kvfree(ptr_to_free);
> > 
> > We can't block, it has to be async otherwise everything else blocks, and I
> > think this can also be used from interrupt handlers which would at least be
> > an SWA violation. So perhaps it needs to allocate an rcu_head wrapper object
> > itself for the 'emergeny case' and use the regular techniques.
> > 
> > Another thing that stands out is the code duplication, if we can make this
> > reuse as much as of the previous code as possible, that'd be great. I'd like
> > to avoid bvcached and bvhead if possible. Maybe we can store information
> > about the fact that this is a 'special object' in some of the lower-order
> > bits of the pointer. Then we can detect that it is 'special' and free it
> > using kvfree() during the reclaim
> 
> Basically what I did different is:
> 1. Use the existing kfree_rcu_bulk_data::records array to store the
>    to-be-freed array.
> 2. In case of emergency, allocate a new wrapper and tag the pointer.
>    Read the tag later to figure its an array wrapper and do additional kvfree.
>
I see your point and agree that duplication is odd and we should avoid
it as much as possible. Also, i like the idea of using the wrapper as
one more chance to build a "head" for headless object.

I did not mix pointers because then you will need to understand what is what.
It is OK for "emergency" path, because we simply can just serialize it by kvfree()
call, it checks inside what the ptr address belong to:

<snip>
void kvfree(const void *addr)
{
    if (is_vmalloc_addr(addr))
        vfree(addr);
    else
        kfree(addr);
}
<snip>

whereas normal path, i mean "bulk one" where we store pointers into array
would be broken. We can not call kfree_bulk(array, nr_entries) if the passed
array contains "vmalloc" pointers, because it is different allocator. Therefore,
i deliberately have made it as a special case.

> 
> Perhaps the synchronize_rcu() should be done from a workqueue handler
> to prevent IRQ crapping out?
>
I think so. For example one approach would be:

<snip>
struct free_deferred {
 struct llist_head list;
 struct work_struct wq;
};
static DEFINE_PER_CPU(struct free_deferred, free_deferred);

static void free_work(struct work_struct *w)
{
  struct free_deferred *p = container_of(w, struct free_deferred, wq);
  struct llist_node *t, *llnode;

  synchronize_rcu();

  llist_for_each_safe(llnode, t, llist_del_all(&p->list))
     vfree((void *)llnode, 1);
}

static inline void free_deferred_common(void *ptr_to_free)
{
    struct free_deferred *p = raw_cpu_ptr(&free_deferred);

    if (llist_add((struct llist_node *)ptr_to_free, &p->list))
        schedule_work(&p->wq);
}
<snip>

and it seems it should work. Because we know that KMALLOC_MIN_SIZE
can not be less then machine word:

/*
 * Kmalloc subsystem.
 */
 #ifndef KMALLOC_MIN_SIZE
 #define KMALLOC_MIN_SIZE (1 << KMALLOC_SHIFT_LOW)
 #endif

when it comes to vmalloc pointer it can not be less then one PAGE_SIZE :)

Another thing:

we are talking about "headless" variant that is special, therefore it
implies to have some restrictions, since we need a dynamic memory to
drive it. For example "headless" object can be freed from preemptible
context only, because freeing can be inlined:

<snip>
+   // NOT SURE if permitted due to IRQ. Maybe we
+   // should try doing this from WQ?
+   synchronize_rcu();
+   kvfree(ptr);
<snip>

Calling synchronize_rcu() from the IRQ context will screw the system up :)
Because the current CPU will never pass the QS state if i do not miss something.
Also kvfree() itself can be called from the preemptible context only, excluding IRQ,
there is a special path for it, otherwise vfree() can sleep. 

> 
> debug_objects bits wouldn't work obviously for the !emergency kvfree case,
> not sure what we can do there.
>
Agree.

Thank you, Joel, for your comments!

--
Vlad Rezki
