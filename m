Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE3162B99
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 18:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgBRRJL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 12:09:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36108 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgBRRJL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 12:09:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so23836652ljg.3;
        Tue, 18 Feb 2020 09:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fnGYIJoqW+7Uo4kRyCUlaXPeyB46pwVY5SkUWWq9P+M=;
        b=kZZVbuAst5XmdGOKtcppNCrwKidpd04b7lP5H+ehEGV7J/FqpdoAI7AGfEWUBnuUmj
         Dzmx1+DqGKbjQB6AFOcWTnPaOmt+C+6+IlNz/L/02f66+r5V9Tc6mTsczhNkmZpnIOrP
         LnRgtgC+4n2aFdj5O9OPX5PD/h2DOvTKRqZrrir6tB+M1VTvqi9Uem+o0yUWVumraDAJ
         9Lbxdfr1kaYIXRkLWfk5KyW9nfW/wWri0gYTGhOtxfSX9vQS+3l4TkErMBDFS1mW/3a/
         92jfkgh0Iu2BFOrHmFdKi+m79gd/vCXbW2SA1v6C42iQOA5iraWG7BKw0vEgv4VEdgPh
         AUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnGYIJoqW+7Uo4kRyCUlaXPeyB46pwVY5SkUWWq9P+M=;
        b=EZ8Jqxm6hlJKXwOj9IFUjijoDWMlYvs+cIJv/TaDPMNIxi1ZS+yK3Nl6YfveulfEo4
         iVJORyFcVJbBawy3Jsl7fW9qZXO4bxw6Lroet0MQ8szhmWIAzFAYx5NymF7KgF2e3jei
         eQAFwBZ0Xd9/7jr2E9J8TeuUKmu4am4GUZK7PlJqBZKKNvstdVG0ziKGQF1WWLWOpIZh
         v659RgkQTq9CL4XSXh0PntbK4M/eR5HRPKHtGNYv2U7ea9+qPYfSh63oeF4DFb3GZJpf
         nB2QitxOcNwTIiRXa5wJX+IT4JtIM7UrUrKXl3BzgMHVU2+Yz3VRvR+TA1WpRjFBmMl8
         hQBQ==
X-Gm-Message-State: APjAAAUfQT7t1t/ln+e9D2yjRWPKXA8z7UPAtxuIXjxyeg93XK1CvpiU
        pTuwLoItA/BkM/TSk8UVv84=
X-Google-Smtp-Source: APXvYqyVZnYLFd6MMbQADQ8/orf5Sc8RxYi2udhc++3FYTc13PQ1aWHUwR54/jqhlmf+UfV7TrvCcg==
X-Received: by 2002:a2e:3a0c:: with SMTP id h12mr13671202lja.200.1582045746268;
        Tue, 18 Feb 2020 09:09:06 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id p26sm2617919lfh.64.2020.02.18.09.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 09:09:05 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 18 Feb 2020 18:08:57 +0100
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200218170857.GA28774@pc636>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217193314.GA12604@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 17, 2020 at 02:33:14PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Feb 17, 2020 at 05:08:27PM +0100, Uladzislau Rezki wrote:
> > Hello, Joel, Paul, Ted. 
> > 
> > > 
> > > Good point!
> > > 
> > > Now that kfree_rcu() is on its way to being less of a hack deeply
> > > entangled into the bowels of RCU, this might be fairly easy to implement.
> > > It might well be simply a matter of a function pointer and a kvfree_rcu()
> > > API.  Adding Uladzislau Rezki and Joel Fernandez on CC for their thoughts.
> > > 
> > I think it makes sense. For example i see there is a similar demand in
> > the mm/list_lru.c too. As for implementation, it will not be hard, i think. 
> > 
> > The easiest way is to inject kvfree() support directly into existing kfree_call_rcu()
> > logic(probably will need to rename that function), i.e. to free vmalloc() allocations
> > only in "emergency path" by just calling kvfree(). So that function in its turn will
> > figure out if it is _vmalloc_ address or not and trigger corresponding "free" path.
> 
> The other difference between ext4_kvfree_array_rcu() and kfree_rcu()
> is that kfree_rcu() is a magic macro which frees a structure, which
> has to contain a struct rcu_head.  In this case, I'm freeing a pointer
> to set of structures, or in another case, a set of buffer_heads, which
> do *not* have an rcu_head structure.
> 
We can implement kvfree_rcu() that will deal with pointer only, it is not
an issue. I mean without embedding rcu_head to the structure or whatever
else.

I tried to implement it with less number of changes to make it more clear
and readable. Please have a look:

<snip>
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2678a37c3169..9e75c15b53f9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -805,7 +805,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define __kfree_rcu(head, offset) \
        do { \  
                BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
-               kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+               kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset), NULL); \
        } while (0)

 /**
@@ -842,6 +842,14 @@ do {                                                                       \
                __kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)

+#define kvfree_rcu(ptr)                                                \
+do {                                                                   \
+       typeof (ptr) ___p = (ptr);                                      \
+                                                                       \
+       if (___p)                                                       \
+               kfree_call_rcu(NULL, (rcu_callback_t)(unsigned long)(0), ___p); \
+} while (0)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 045c28b71f4f..a12ecc1645fa 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,7 +34,7 @@ static inline void synchronize_rcu_expedited(void)
        synchronize_rcu();
 }

-static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr)
 {
        call_rcu(head, func);
 }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 45f3f66bb04d..1e445b566c01 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -33,7 +33,7 @@ static inline void rcu_virt_note_context_switch(int cpu)
 }
 
 void synchronize_rcu_expedited(void);
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr);
 
 void rcu_barrier(void);
 bool rcu_eqs_special_set(int cpu);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4a885af2ff73..5f22f369cb98 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2746,6 +2746,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
  * kfree_rcu_bulk_data structure becomes exactly one page.
  */
 #define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
+#define KVFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 2)
 
 /**
  * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
@@ -2761,6 +2762,12 @@ struct kfree_rcu_bulk_data {
        struct rcu_head *head_free_debug;
 };
+struct kvfree_rcu_bulk_data {
+       unsigned long nr_records;
+       void *records[KVFREE_BULK_MAX_ENTR];
+       struct kvfree_rcu_bulk_data *next;
+};
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
@@ -2773,6 +2780,7 @@ struct kfree_rcu_cpu_work {
        struct rcu_work rcu_work;
        struct rcu_head *head_free;
        struct kfree_rcu_bulk_data *bhead_free;
+       struct kvfree_rcu_bulk_data *bvhead_free;
        struct kfree_rcu_cpu *krcp;
 };
 
@@ -2796,6 +2804,10 @@ struct kfree_rcu_cpu {
        struct rcu_head *head;
        struct kfree_rcu_bulk_data *bhead;
        struct kfree_rcu_bulk_data *bcached;
+       struct kvfree_rcu_bulk_data *bvhead;
+       struct kvfree_rcu_bulk_data *bvcached;
+
+       /* rename to "free_rcu_cpu_work" */
        struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
        spinlock_t lock;
        struct delayed_work monitor_work;
@@ -2823,20 +2835,30 @@ static void kfree_rcu_work(struct work_struct *work)
        unsigned long flags;
        struct rcu_head *head, *next;
        struct kfree_rcu_bulk_data *bhead, *bnext;
+       struct kvfree_rcu_bulk_data *bvhead, *bvnext;
        struct kfree_rcu_cpu *krcp;
        struct kfree_rcu_cpu_work *krwp;
+       int i;
        krwp = container_of(to_rcu_work(work),
                            struct kfree_rcu_cpu_work, rcu_work);
+
        krcp = krwp->krcp;
        spin_lock_irqsave(&krcp->lock, flags);
+       /* Channel 1. */
        head = krwp->head_free;
        krwp->head_free = NULL;
+
+       /* Channel 2. */
        bhead = krwp->bhead_free;
        krwp->bhead_free = NULL;
+
+       /* Channel 3. */
+       bvhead = krwp->bvhead_free;
+       krwp->bvhead_free = NULL;
        spin_unlock_irqrestore(&krcp->lock, flags);
 
-       /* "bhead" is now private, so traverse locklessly. */
+       /* kmalloc()/kfree_rcu() channel. */
        for (; bhead; bhead = bnext) {
                bnext = bhead->next;
 
@@ -2855,6 +2877,21 @@ static void kfree_rcu_work(struct work_struct *work)
                cond_resched_tasks_rcu_qs();
        }
 
+       /* kvmalloc()/kvfree_rcu() channel. */
+       for (; bvhead; bvhead = bvnext) {
+               bvnext = bvhead->next;
+
+               rcu_lock_acquire(&rcu_callback_map);
+               for (i = 0; i < bvhead->nr_records; i++)
+                       kvfree(bvhead->records[i]);
+               rcu_lock_release(&rcu_callback_map);
+
+               if (cmpxchg(&krcp->bvcached, NULL, bvhead))
+                       free_page((unsigned long) bvhead);
+
+               cond_resched_tasks_rcu_qs();
+       }
+
        /*
         * Emergency case only. It can happen under low memory
         * condition when an allocation gets failed, so the "bulk"
@@ -2901,7 +2938,8 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
                 * return false to tell caller to retry.
                 */
                if ((krcp->bhead && !krwp->bhead_free) ||
-                               (krcp->head && !krwp->head_free)) {
+                               (krcp->head && !krwp->head_free) ||
+                               (krcp->bvhead && !krwp->bvhead_free)) {
                        /* Channel 1. */
                        if (!krwp->bhead_free) {
                                krwp->bhead_free = krcp->bhead;
@@ -2914,11 +2952,17 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
                                krcp->head = NULL;
                        }
 
+                       /* Channel 3. */
+                       if (!krwp->bvhead_free) {
+                               krwp->bvhead_free = krcp->bvhead;
+                               krcp->bvhead = NULL;
+                       }
+
                        /*
-                        * One work is per one batch, so there are two "free channels",
-                        * "bhead_free" and "head_free" the batch can handle. It can be
-                        * that the work is in the pending state when two channels have
-                        * been detached following each other, one by one.
+                        * One work is per one batch, so there are three "free channels",
+                        * "bhead_free", "head_free" and "bvhead_free" the batch can handle.
+                        * It can be that the work is in the pending state when two channels
+                        * have been detached following each other, one by one.
                         */
                        queue_rcu_work(system_wq, &krwp->rcu_work);
                        queued = true;
@@ -3010,6 +3054,42 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
        return true;
 }
 
+static inline bool
+kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+{
+       struct kvfree_rcu_bulk_data *bnode;
+
+       if (unlikely(!krcp->initialized))
+               return false;
+
+       lockdep_assert_held(&krcp->lock);
+
+       if (!krcp->bvhead ||
+                       krcp->bvhead->nr_records == KVFREE_BULK_MAX_ENTR) {
+               bnode = xchg(&krcp->bvcached, NULL);
+               if (!bnode) {
+                       WARN_ON_ONCE(sizeof(struct kvfree_rcu_bulk_data) > PAGE_SIZE);
+
+                       bnode = (struct kvfree_rcu_bulk_data *)
+                               __get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+               }
+
+               if (unlikely(!bnode))
+                       return false;
+
+               /* Initialize the new block. */
+               bnode->nr_records = 0;
+               bnode->next = krcp->bvhead;
+
+               /* Attach it to the bvhead. */
+               krcp->bvhead = bnode;
+       }
+
+       /* Finally insert. */
+       krcp->bvhead->records[krcp->bvhead->nr_records++] = ptr;
+       return true;
+}
+
 /*
  * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
  * period. Please note there are two paths are maintained, one is the main one
@@ -3022,32 +3102,39 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
  * be free'd in workqueue context. This allows us to: batch requests together to
  * reduce the number of grace periods during heavy kfree_rcu() load.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr_to_free)
 {
        unsigned long flags;
        struct kfree_rcu_cpu *krcp;
+       bool skip_call_rcu = true;
 
        local_irq_save(flags);  // For safely calling this_cpu_ptr().
        krcp = this_cpu_ptr(&krc);
        if (krcp->initialized)
                spin_lock(&krcp->lock);
 
-       // Queue the object but don't yet schedule the batch.
-       if (debug_rcu_head_queue(head)) {
-               // Probable double kfree_rcu(), just leak.
-               WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
-                         __func__, head);
-               goto unlock_return;
-       }
+       if (ptr_to_free) {
+               skip_call_rcu = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr_to_free);
+               if (!skip_call_rcu)
+                       goto unlock_return;
+       } else {
+               // Queue the object but don't yet schedule the batch.
+               if (debug_rcu_head_queue(head)) {
+                       // Probable double kfree_rcu(), just leak.
+                       WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
+                               __func__, head);
+                       goto unlock_return;
+               }
 
-       /*
-        * Under high memory pressure GFP_NOWAIT can fail,
-        * in that case the emergency path is maintained.
-        */
-       if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
-               head->func = func;
-               head->next = krcp->head;
-               krcp->head = head;
+               /*
+                * Under high memory pressure GFP_NOWAIT can fail,
+                * in that case the emergency path is maintained.
+                */
+               if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+                       head->func = func;
+                       head->next = krcp->head;
+                       krcp->head = head;
+               }
        }
 
        // Set timer to drain after KFREE_DRAIN_JIFFIES.
@@ -3061,6 +3148,11 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
        if (krcp->initialized)
                spin_unlock(&krcp->lock);
        local_irq_restore(flags);
+
+       if (!skip_call_rcu) {
+               synchronize_rcu();
+               kvfree(ptr_to_free);
+       }
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 0f1f6b06b7f3..0efb849b4f1f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -390,14 +390,6 @@ static void memcg_destroy_list_lru_node(struct list_lru_node *nlru)
        kvfree(memcg_lrus);
 }

-static void kvfree_rcu(struct rcu_head *head)
-{
-       struct list_lru_memcg *mlru;
-
-       mlru = container_of(head, struct list_lru_memcg, rcu);
-       kvfree(mlru);
-}
-
 static int memcg_update_list_lru_node(struct list_lru_node *nlru,
                                      int old_size, int new_size)
 {
@@ -429,7 +421,7 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
        rcu_assign_pointer(nlru->memcg_lrus, new);
        spin_unlock_irq(&nlru->lock);

-       call_rcu(&old->rcu, kvfree_rcu);
+       kvfree_rcu(old);
        return 0;
 }
<snip>

now it becomes possible to use it like: 
	...
	void *p = kvmalloc(PAGE_SIZE);
	kvfree_rcu(p);
	...
also have a look at the example in the mm/list_lru.c diff.

I can send out the RFC/PATCH that implements kvfree_rcu() API without need
of "rcu_head" structure. 

Paul, Joel what are your thoughts?

Thank you in advance!

--
Vlad Rezki
