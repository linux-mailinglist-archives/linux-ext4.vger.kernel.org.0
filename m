Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E616B4F2
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 00:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgBXXOw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 18:14:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgBXXOv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Feb 2020 18:14:51 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [163.114.132.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393592051A;
        Mon, 24 Feb 2020 23:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582586090;
        bh=C9/oTP4B7JB25f5LZxwiUeI7VtguZDG9CwTqtdqeInM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0inq5WFAv4bmRdaNWcvS06rGNsoxwslMU3m0Ka8IB9cwUs9+kJYCFud7jpfCvwLyv
         wiUoyiGD8T/muQZd5eUuWD+AINyzkWadg7Hi/ItPQX7gkqDWPWHiWQOkEDNJSl1pEH
         /M+m7vtwe/x5Gmpl+40pEYXTWIYGY7EH9Gdg/v4A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1A5FE35226D4; Mon, 24 Feb 2020 15:14:49 -0800 (PST)
Date:   Mon, 24 Feb 2020 15:14:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200224231449.GS2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200221120618.GA194360@google.com>
 <20200221132817.GB194360@google.com>
 <20200221192152.GA6306@pc636>
 <20200222221253.GB191380@google.com>
 <20200224170219.GA21229@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224170219.GA21229@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 24, 2020 at 06:02:19PM +0100, Uladzislau Rezki wrote:
> > > > > 
> > > > > Overall this implementation is nice. You are basically avoiding allocating
> > > > > rcu_head like Ted did by using the array-of-pointers technique we used for
> > > > > the previous kfree_rcu() work.
> > > > > 
> > > > > One thing stands out, the path where we could not allocate a page for the new
> > > > > block node:
> > > > > 
> > > > > > @@ -3061,6 +3148,11 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > > >         if (krcp->initialized)
> > > > > >                 spin_unlock(&krcp->lock);
> > > > > >         local_irq_restore(flags);
> > > > > > +
> > > > > > +       if (!skip_call_rcu) {
> > > > > > +               synchronize_rcu();
> > > > > > +               kvfree(ptr_to_free);
> > > > > 
> > > > > We can't block, it has to be async otherwise everything else blocks, and I
> > > > > think this can also be used from interrupt handlers which would at least be
> > > > > an SWA violation. So perhaps it needs to allocate an rcu_head wrapper object
> > > > > itself for the 'emergeny case' and use the regular techniques.
> > > > > 
> > > > > Another thing that stands out is the code duplication, if we can make this
> > > > > reuse as much as of the previous code as possible, that'd be great. I'd like
> > > > > to avoid bvcached and bvhead if possible. Maybe we can store information
> > > > > about the fact that this is a 'special object' in some of the lower-order
> > > > > bits of the pointer. Then we can detect that it is 'special' and free it
> > > > > using kvfree() during the reclaim
> > > > 
> > > > Basically what I did different is:
> > > > 1. Use the existing kfree_rcu_bulk_data::records array to store the
> > > >    to-be-freed array.
> > > > 2. In case of emergency, allocate a new wrapper and tag the pointer.
> > > >    Read the tag later to figure its an array wrapper and do additional kvfree.
> > > >
> > > I see your point and agree that duplication is odd and we should avoid
> > > it as much as possible. Also, i like the idea of using the wrapper as
> > > one more chance to build a "head" for headless object.
> > > 
> > > I did not mix pointers because then you will need to understand what is what.
> > 
> > Well that's why I brought up the whole tagging idea. Then you don't need
> > separate pointers to manage either (edit: but maybe you do as you mentioned
> > vfree below..).
> > 
> Right. We can use tagging idea to separate kmalloc/vmalloc pointers to
> place them into different arrays. Because kvmalloc() can return either
> SLAB pointer or vmalloc one.
> 
> > > It is OK for "emergency" path, because we simply can just serialize it by kvfree()
> > > call, it checks inside what the ptr address belong to:
> > > 
> > > <snip>
> > > void kvfree(const void *addr)
> > > {
> > >     if (is_vmalloc_addr(addr))
> > >         vfree(addr);
> > >     else
> > >         kfree(addr);
> > > }
> > > <snip>
> > > 
> > > whereas normal path, i mean "bulk one" where we store pointers into array
> > > would be broken. We can not call kfree_bulk(array, nr_entries) if the passed
> > > array contains "vmalloc" pointers, because it is different allocator. Therefore,
> > > i deliberately have made it as a special case.
> > 
> > Ok, it would be nice if you can verify that ptr_to_free passed to
> > kfree_call_rcu() is infact a vmalloc pointer.
> > 
> We can do that. We can check it by calling is_vmalloc_addr() on ptr. 
> So it is possible to differentiate.
> 
> > > > Perhaps the synchronize_rcu() should be done from a workqueue handler
> > > > to prevent IRQ crapping out?
> > > >
> > > I think so. For example one approach would be:
> > > 
> > > <snip>
> > > struct free_deferred {
> > >  struct llist_head list;
> > >  struct work_struct wq;
> > > };
> > > static DEFINE_PER_CPU(struct free_deferred, free_deferred);
> > > 
> > > static void free_work(struct work_struct *w)
> > > {
> > >   struct free_deferred *p = container_of(w, struct free_deferred, wq);
> > >   struct llist_node *t, *llnode;
> > > 
> > >   synchronize_rcu();
> > > 
> > >   llist_for_each_safe(llnode, t, llist_del_all(&p->list))
> > >      vfree((void *)llnode, 1);
> > > }
> > > 
> > > static inline void free_deferred_common(void *ptr_to_free)
> > > {
> > >     struct free_deferred *p = raw_cpu_ptr(&free_deferred);
> > > 
> > >     if (llist_add((struct llist_node *)ptr_to_free, &p->list))
> > 
> > Would this not corrupt the ptr_to_free pointer which readers might still be
> > accessing since grace period has not yet ended?
> > 
> > We cannot touch the ptr_to_free pointer until after the grace period has
> > ended.
> > 
> Right you are. We can do that only after grace period is passed, 
> after synchronize_rcu(). Good point :)
> 
> > > }
> > > <snip>
> > > 
> > > and it seems it should work. Because we know that KMALLOC_MIN_SIZE
> > > can not be less then machine word:
> > > 
> > > /*
> > >  * Kmalloc subsystem.
> > >  */
> > >  #ifndef KMALLOC_MIN_SIZE
> > >  #define KMALLOC_MIN_SIZE (1 << KMALLOC_SHIFT_LOW)
> > >  #endif
> > > 
> > > when it comes to vmalloc pointer it can not be less then one PAGE_SIZE :)
> > > 
> > > Another thing:
> > > 
> > > we are talking about "headless" variant that is special, therefore it
> > > implies to have some restrictions, since we need a dynamic memory to
> > > drive it. For example "headless" object can be freed from preemptible
> > > context only, because freeing can be inlined:
> > > 
> > > <snip>
> > > +   // NOT SURE if permitted due to IRQ. Maybe we
> > > +   // should try doing this from WQ?
> > > +   synchronize_rcu();
> > > +   kvfree(ptr);
> > > <snip>
> > > 
> > > Calling synchronize_rcu() from the IRQ context will screw the system up :)
> > > Because the current CPU will never pass the QS state if i do not miss something.
> > 
> > Yes are you right, calling synchronize_rcu() from IRQ context is a strict no-no.
> > 
> > I believe we could tap into the GFP_ATOMIC emergency memory pool for this
> > emergency situation. This pool is used for emergency cases. I think in
> > emergency we can grow an rcu_head on this pool.
> > 
> > > Also kvfree() itself can be called from the preemptible context only, excluding IRQ,
> > > there is a special path for it, otherwise vfree() can sleep. 
> > 
> > Ok that's good to know.
> > 
> > > > debug_objects bits wouldn't work obviously for the !emergency kvfree case,
> > > > not sure what we can do there.
> > > >
> > > Agree.
> > > 
> > > Thank you, Joel, for your comments!
> > 
> > No problem, I think we have a couple of ideas here.
> > 
> > What I also wanted to do was (may be after all this), see if we can create an
> > API for head-less kfree based on the same ideas. Not just for arrays for for
> > any object. Calling it, say, kfree_rcu_headless() and then use the bulk array
> > as we have been doing. That would save any users from having an rcu_head --
> > of course with all needed warnings about memory allocation failure. Vlad,
> > What do you think? Paul, any thoughts on this?
> > 
> I like it. It would be more clean interface. Also there are places where
> people do not embed the rcu_head into their stuctures for some reason
> and do like:
> 
> 
> <snip>
>     synchronize_rcu();
>     kfree(p);
> <snip>
> 
> <snip>
> urezki@pc636:~/data/ssd/coding/linux-rcu$ find ./ -name "*.c" | xargs grep -C 1 -rn "synchronize_rcu" | grep kfree
> ./arch/x86/mm/mmio-mod.c-314-           kfree(found_trace);
> ./kernel/module.c-3910- kfree(mod->args);
> ./kernel/trace/ftrace.c-5078-                   kfree(direct);
> ./kernel/trace/ftrace.c-5155-                   kfree(direct);
> ./kernel/trace/trace_probe.c-1087-      kfree(link);
> ./fs/nfs/sysfs.c-113-           kfree(old);
> ./fs/ext4/super.c-1701- kfree(old_qname);
> ./net/ipv4/gre.mod.c-36-        { 0xfc3fcca2, "kfree_skb" },
> ./net/core/sysctl_net_core.c-143-                               kfree(cur);
> ./drivers/crypto/nx/nx-842-pseries.c-1010-      kfree(old_devdata);
> ./drivers/misc/vmw_vmci/vmci_context.c-692-             kfree(notifier);
> ./drivers/misc/vmw_vmci/vmci_event.c-213-       kfree(s);
> ./drivers/infiniband/core/device.c:2162:                         * synchronize_rcu before the netdev is kfreed, so we
> ./drivers/infiniband/hw/hfi1/sdma.c-1337-       kfree(dd->per_sdma);
> ./drivers/net/ethernet/myricom/myri10ge/myri10ge.c-3582-        kfree(mgp->ss);
> ./drivers/net/ethernet/myricom/myri10ge/myri10ge.mod.c-156-     { 0x37a0cba, "kfree" },
> ./drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c:286:       synchronize_rcu(); /* before kfree(flow) */
> ./drivers/net/ethernet/mellanox/mlxsw/core.c-1504-      kfree(rxl_item);
> ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6648- kfree(adapter->mbox_log);
> ./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6650- kfree(adapter);
> ./drivers/block/drbd/drbd_receiver.c-3804-      kfree(old_net_conf);
> ./drivers/block/drbd/drbd_receiver.c-4176-                      kfree(old_disk_conf);
> ./drivers/block/drbd/drbd_state.c-2074-         kfree(old_conf);
> ./drivers/block/drbd/drbd_nl.c-1689-    kfree(old_disk_conf);
> ./drivers/block/drbd/drbd_nl.c-2522-    kfree(old_net_conf);
> ./drivers/block/drbd/drbd_nl.c-2935-            kfree(old_disk_conf);
> ./drivers/mfd/dln2.c-178-               kfree(i);
> ./drivers/staging/fwserial/fwserial.c-2122-     kfree(peer);
> <snip>

That certainly is enough use cases to justify a new API.  And given that
they are already calling synchronize_rcu(), having a function that only
sometimes calls synchronize_rcu() should be OK from a latency viewpoint.

The trick will be verifying that the existing calls to synchronize_rcu()
aren't providing some other guarantee...  But submitting the patch and
seeing if the maintainers are willing to ack is not without merit.

Plus, the cases where both the synchronize_rcu() and the kfree() are
under some "if" should be easier to verify as safe.

							Thanx, Paul
