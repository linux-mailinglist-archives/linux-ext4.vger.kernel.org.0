Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC83167D15
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 13:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgBUMGX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 07:06:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35655 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgBUMGX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 07:06:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id v2so1568080qkj.2
        for <linux-ext4@vger.kernel.org>; Fri, 21 Feb 2020 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rUrJscfe99zXbns0OXhbrROpIKiVy4N1rdzN23suJ+4=;
        b=tNbd8UQvcO7kpOSeGc3dpk1vUxHdh2rIN6JOTe0CLwm+xj059KO4rHvm5zwghJCtId
         8jshDL1gqd++w6AErmuG6YRz4kyIVrY7lcmQxHY3ExlxPLWgzUNeXTvF3zMTSV9C7Xl7
         zlozjorlZ/yUq1oieISOEu4cr18Bnzddfnp80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rUrJscfe99zXbns0OXhbrROpIKiVy4N1rdzN23suJ+4=;
        b=dgtqhHIUFigS0RXbm4vdDRvhEs0f7W/XGtLtRUEOC6FQt/BPzDSVcnHbEvwjwTXB38
         WCftkk+We9jYjgp7lBpAk3TPnQy7S1X1Swf+edGpIllBGyRTKjWeEvStZKUyYSddlSoO
         sUqET5uaBD7ZG0J2EZkW2/Vy1Vng+fuyYP/F08zonbVVDQ3cFu1gOR0/Vh+hE9wxvUpz
         iCqJu8zTB1vxsDYWJDlnFJ6hba43c/k4YHtqrO6v+vrMBcDqW7D6UqMGGDjXNguOExM8
         66aPn4QOc0CSmlKL5hGzQNox1WM45C40ccxVQ+pOPoykRORvMKJ7J+eBBez8KioIyZSJ
         /yLA==
X-Gm-Message-State: APjAAAXWDM1Bswv/tnuxgXL+SwSNYtm4JFVfokj4R5E6NFxrainHCcHL
        QtuUos9jl3zmuATfRSuMK4Lc4A==
X-Google-Smtp-Source: APXvYqxg48lU5TyFJz3rQKYKUXnGvwegUMsvHzkjXKRcQlxQdePMLLQVLYcg8hbHn9NsdpawKE7+3A==
X-Received: by 2002:a37:b285:: with SMTP id b127mr6140165qkf.413.1582286779893;
        Fri, 21 Feb 2020 04:06:19 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g62sm1361011qkd.25.2020.02.21.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 04:06:19 -0800 (PST)
Date:   Fri, 21 Feb 2020 07:06:18 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200221120618.GA194360@google.com>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218170857.GA28774@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> On Mon, Feb 17, 2020 at 02:33:14PM -0500, Theodore Y. Ts'o wrote:
> > On Mon, Feb 17, 2020 at 05:08:27PM +0100, Uladzislau Rezki wrote:
> > > Hello, Joel, Paul, Ted. 
> > > 
> > > > 
> > > > Good point!
> > > > 
> > > > Now that kfree_rcu() is on its way to being less of a hack deeply
> > > > entangled into the bowels of RCU, this might be fairly easy to implement.
> > > > It might well be simply a matter of a function pointer and a kvfree_rcu()
> > > > API.  Adding Uladzislau Rezki and Joel Fernandez on CC for their thoughts.
> > > > 
> > > I think it makes sense. For example i see there is a similar demand in
> > > the mm/list_lru.c too. As for implementation, it will not be hard, i think. 
> > > 
> > > The easiest way is to inject kvfree() support directly into existing kfree_call_rcu()
> > > logic(probably will need to rename that function), i.e. to free vmalloc() allocations
> > > only in "emergency path" by just calling kvfree(). So that function in its turn will
> > > figure out if it is _vmalloc_ address or not and trigger corresponding "free" path.
> > 
> > The other difference between ext4_kvfree_array_rcu() and kfree_rcu()
> > is that kfree_rcu() is a magic macro which frees a structure, which
> > has to contain a struct rcu_head.  In this case, I'm freeing a pointer
> > to set of structures, or in another case, a set of buffer_heads, which
> > do *not* have an rcu_head structure.
> > 
> We can implement kvfree_rcu() that will deal with pointer only, it is not
> an issue. I mean without embedding rcu_head to the structure or whatever
> else.
> 
> I tried to implement it with less number of changes to make it more clear
> and readable. Please have a look:
> 
> <snip>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h

Overall this implementation is nice. You are basically avoiding allocating
rcu_head like Ted did by using the array-of-pointers technique we used for
the previous kfree_rcu() work.

One thing stands out, the path where we could not allocate a page for the new
block node:

> @@ -3061,6 +3148,11 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>         if (krcp->initialized)
>                 spin_unlock(&krcp->lock);
>         local_irq_restore(flags);
> +
> +       if (!skip_call_rcu) {
> +               synchronize_rcu();
> +               kvfree(ptr_to_free);

We can't block, it has to be async otherwise everything else blocks, and I
think this can also be used from interrupt handlers which would at least be
an SWA violation. So perhaps it needs to allocate an rcu_head wrapper object
itself for the 'emergeny case' and use the regular techniques.

Another thing that stands out is the code duplication, if we can make this
reuse as much as of the previous code as possible, that'd be great. I'd like
to avoid bvcached and bvhead if possible. Maybe we can store information
about the fact that this is a 'special object' in some of the lower-order
bits of the pointer. Then we can detect that it is 'special' and free it
using kvfree() during the reclaim

Nice to know there would be a few users of it. thanks!

 - Joel



> index 2678a37c3169..9e75c15b53f9 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -805,7 +805,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  #define __kfree_rcu(head, offset) \
>         do { \  
>                 BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
> -               kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
> +               kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset), NULL); \
>         } while (0)
> 
>  /**
> @@ -842,6 +842,14 @@ do {                                                                       \
>                 __kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
>  } while (0)
> 
> +#define kvfree_rcu(ptr)                                                \
> +do {                                                                   \
> +       typeof (ptr) ___p = (ptr);                                      \
> +                                                                       \
> +       if (___p)                                                       \
> +               kfree_call_rcu(NULL, (rcu_callback_t)(unsigned long)(0), ___p); \
> +} while (0)
> +
>  /*
>   * Place this after a lock-acquisition primitive to guarantee that
>   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 045c28b71f4f..a12ecc1645fa 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
>         synchronize_rcu();
>  }
> 
> -static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr)
>  {
>         call_rcu(head, func);
>  }
> diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
> index 45f3f66bb04d..1e445b566c01 100644
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
>  }
>  
>  void synchronize_rcu_expedited(void);
> -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
> +void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr);
>  
>  void rcu_barrier(void);
>  bool rcu_eqs_special_set(int cpu);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4a885af2ff73..5f22f369cb98 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2746,6 +2746,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
>   * kfree_rcu_bulk_data structure becomes exactly one page.
>   */
>  #define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
> +#define KVFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 2)
>  
>  /**
>   * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
> @@ -2761,6 +2762,12 @@ struct kfree_rcu_bulk_data {
>         struct rcu_head *head_free_debug;
>  };
> +struct kvfree_rcu_bulk_data {
> +       unsigned long nr_records;
> +       void *records[KVFREE_BULK_MAX_ENTR];
> +       struct kvfree_rcu_bulk_data *next;
> +};
> +
>  /**
>   * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
>   * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
> @@ -2773,6 +2780,7 @@ struct kfree_rcu_cpu_work {
>         struct rcu_work rcu_work;
>         struct rcu_head *head_free;
>         struct kfree_rcu_bulk_data *bhead_free;
> +       struct kvfree_rcu_bulk_data *bvhead_free;
>         struct kfree_rcu_cpu *krcp;
>  };
>  
> @@ -2796,6 +2804,10 @@ struct kfree_rcu_cpu {
>         struct rcu_head *head;
>         struct kfree_rcu_bulk_data *bhead;
>         struct kfree_rcu_bulk_data *bcached;
> +       struct kvfree_rcu_bulk_data *bvhead;
> +       struct kvfree_rcu_bulk_data *bvcached;
> +
> +       /* rename to "free_rcu_cpu_work" */
>         struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
>         spinlock_t lock;
>         struct delayed_work monitor_work;
> @@ -2823,20 +2835,30 @@ static void kfree_rcu_work(struct work_struct *work)
>         unsigned long flags;
>         struct rcu_head *head, *next;
>         struct kfree_rcu_bulk_data *bhead, *bnext;
> +       struct kvfree_rcu_bulk_data *bvhead, *bvnext;
>         struct kfree_rcu_cpu *krcp;
>         struct kfree_rcu_cpu_work *krwp;
> +       int i;
>         krwp = container_of(to_rcu_work(work),
>                             struct kfree_rcu_cpu_work, rcu_work);
> +
>         krcp = krwp->krcp;
>         spin_lock_irqsave(&krcp->lock, flags);
> +       /* Channel 1. */
>         head = krwp->head_free;
>         krwp->head_free = NULL;
> +
> +       /* Channel 2. */
>         bhead = krwp->bhead_free;
>         krwp->bhead_free = NULL;
> +
> +       /* Channel 3. */
> +       bvhead = krwp->bvhead_free;
> +       krwp->bvhead_free = NULL;
>         spin_unlock_irqrestore(&krcp->lock, flags);
>  
> -       /* "bhead" is now private, so traverse locklessly. */
> +       /* kmalloc()/kfree_rcu() channel. */
>         for (; bhead; bhead = bnext) {
>                 bnext = bhead->next;
>  
> @@ -2855,6 +2877,21 @@ static void kfree_rcu_work(struct work_struct *work)
>                 cond_resched_tasks_rcu_qs();
>         }
>  
> +       /* kvmalloc()/kvfree_rcu() channel. */
> +       for (; bvhead; bvhead = bvnext) {
> +               bvnext = bvhead->next;
> +
> +               rcu_lock_acquire(&rcu_callback_map);
> +               for (i = 0; i < bvhead->nr_records; i++)
> +                       kvfree(bvhead->records[i]);
> +               rcu_lock_release(&rcu_callback_map);
> +
> +               if (cmpxchg(&krcp->bvcached, NULL, bvhead))
> +                       free_page((unsigned long) bvhead);
> +
> +               cond_resched_tasks_rcu_qs();
> +       }
> +
>         /*
>          * Emergency case only. It can happen under low memory
>          * condition when an allocation gets failed, so the "bulk"
> @@ -2901,7 +2938,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>                  * return false to tell caller to retry.
>                  */
>                 if ((krcp->bhead && !krwp->bhead_free) ||
> -                               (krcp->head && !krwp->head_free)) {
> +                               (krcp->head && !krwp->head_free) ||
> +                               (krcp->bvhead && !krwp->bvhead_free)) {
>                         /* Channel 1. */
>                         if (!krwp->bhead_free) {
>                                 krwp->bhead_free = krcp->bhead;
> @@ -2914,11 +2952,17 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
>                                 krcp->head = NULL;
>                         }
>  
> +                       /* Channel 3. */
> +                       if (!krwp->bvhead_free) {
> +                               krwp->bvhead_free = krcp->bvhead;
> +                               krcp->bvhead = NULL;
> +                       }
> +
>                         /*
> -                        * One work is per one batch, so there are two "free channels",
> -                        * "bhead_free" and "head_free" the batch can handle. It can be
> -                        * that the work is in the pending state when two channels have
> -                        * been detached following each other, one by one.
> +                        * One work is per one batch, so there are three "free channels",
> +                        * "bhead_free", "head_free" and "bvhead_free" the batch can handle.
> +                        * It can be that the work is in the pending state when two channels
> +                        * have been detached following each other, one by one.
>                          */
>                         queue_rcu_work(system_wq, &krwp->rcu_work);
>                         queued = true;
> @@ -3010,6 +3054,42 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>         return true;
>  }
>  
> +static inline bool
> +kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> +{
> +       struct kvfree_rcu_bulk_data *bnode;
> +
> +       if (unlikely(!krcp->initialized))
> +               return false;
> +
> +       lockdep_assert_held(&krcp->lock);
> +
> +       if (!krcp->bvhead ||
> +                       krcp->bvhead->nr_records == KVFREE_BULK_MAX_ENTR) {
> +               bnode = xchg(&krcp->bvcached, NULL);
> +               if (!bnode) {
> +                       WARN_ON_ONCE(sizeof(struct kvfree_rcu_bulk_data) > PAGE_SIZE);
> +
> +                       bnode = (struct kvfree_rcu_bulk_data *)
> +                               __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +               }
> +
> +               if (unlikely(!bnode))
> +                       return false;
> +
> +               /* Initialize the new block. */
> +               bnode->nr_records = 0;
> +               bnode->next = krcp->bvhead;
> +
> +               /* Attach it to the bvhead. */
> +               krcp->bvhead = bnode;
> +       }
> +
> +       /* Finally insert. */
> +       krcp->bvhead->records[krcp->bvhead->nr_records++] = ptr;
> +       return true;
> +}
> +
>  /*
>   * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
>   * period. Please note there are two paths are maintained, one is the main one
> @@ -3022,32 +3102,39 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>   * be free'd in workqueue context. This allows us to: batch requests together to
>   * reduce the number of grace periods during heavy kfree_rcu() load.
>   */
> -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr_to_free)
>  {
>         unsigned long flags;
>         struct kfree_rcu_cpu *krcp;
> +       bool skip_call_rcu = true;
>  
>         local_irq_save(flags);  // For safely calling this_cpu_ptr().
>         krcp = this_cpu_ptr(&krc);
>         if (krcp->initialized)
>                 spin_lock(&krcp->lock);
>  
> -       // Queue the object but don't yet schedule the batch.
> -       if (debug_rcu_head_queue(head)) {
> -               // Probable double kfree_rcu(), just leak.
> -               WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> -                         __func__, head);
> -               goto unlock_return;
> -       }
> +       if (ptr_to_free) {
> +               skip_call_rcu = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr_to_free);
> +               if (!skip_call_rcu)
> +                       goto unlock_return;
> +       } else {
> +               // Queue the object but don't yet schedule the batch.
> +               if (debug_rcu_head_queue(head)) {
> +                       // Probable double kfree_rcu(), just leak.
> +                       WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
> +                               __func__, head);
> +                       goto unlock_return;
> +               }
>  
> -       /*
> -        * Under high memory pressure GFP_NOWAIT can fail,
> -        * in that case the emergency path is maintained.
> -        */
> -       if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
> -               head->func = func;
> -               head->next = krcp->head;
> -               krcp->head = head;
> +               /*
> +                * Under high memory pressure GFP_NOWAIT can fail,
> +                * in that case the emergency path is maintained.
> +                */
> +               if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
> +                       head->func = func;
> +                       head->next = krcp->head;
> +                       krcp->head = head;
> +               }
>         }
>  
>         // Set timer to drain after KFREE_DRAIN_JIFFIES.
> @@ -3061,6 +3148,11 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>         if (krcp->initialized)
>                 spin_unlock(&krcp->lock);
>         local_irq_restore(flags);
> +
> +       if (!skip_call_rcu) {
> +               synchronize_rcu();
> +               kvfree(ptr_to_free);
> +       }
>  }
>  EXPORT_SYMBOL_GPL(kfree_call_rcu);
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0f1f6b06b7f3..0efb849b4f1f 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -390,14 +390,6 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
>         kvfree(memcg_lrus);
>  }
> 
> -static void kvfree_rcu(struct rcu_head *head)
> -{
> -       struct list_lru_memcg *mlru;
> -
> -       mlru = container_of(head, struct list_lru_memcg, rcu);
> -       kvfree(mlru);
> -}
> -
>  static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>                                       int old_size, int new_size)
>  {
> @@ -429,7 +421,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>         rcu_assign_pointer(nlru->memcg_lrus, new);
>         spin_unlock_irq(&nlru->lock);
> 
> -       call_rcu(&old->rcu, kvfree_rcu);
> +       kvfree_rcu(old);
>         return 0;
>  }
> <snip>
> 
> now it becomes possible to use it like: 
> 	...
> 	void *p = kvmalloc(PAGE_SIZE);
> 	kvfree_rcu(p);
> 	...
> also have a look at the example in the mm/list_lru.c diff.
> 
> I can send out the RFC/PATCH that implements kvfree_rcu() API without need
> of "rcu_head" structure. 
> 
> Paul, Joel what are your thoughts?
> 
> Thank you in advance!
> 
> --
> Vlad Rezki
