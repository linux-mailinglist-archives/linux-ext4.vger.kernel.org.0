Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC2167E8E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgBUN2U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 08:28:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40940 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgBUN2U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 08:28:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id v25so1225076qto.7
        for <linux-ext4@vger.kernel.org>; Fri, 21 Feb 2020 05:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ttw7zbAKUYQGYrdurjacYFEgGvhEz3TZgtMI5lpX0U4=;
        b=BVfIGLO/GnUrYvKVSHBfApZeSvJwQV+JVs0B7EPICFhsCTTYppnKxZWIQH358zEpDo
         m9nIHwfIINrGHkZWC2KQsxXKV6IESLPn96ZujfXajLv3in5e1n2zxunFvznSXn1myHWy
         asvVJAI5kaMIYsUdDmBBeu+ACKjcTymn+CfBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttw7zbAKUYQGYrdurjacYFEgGvhEz3TZgtMI5lpX0U4=;
        b=Jpm2Mu6buq3UUXv0o0Rrf0Y4uR951tQADbrNMIE1GX408j+WFTtOO6tf/KsSTAUNkX
         QlfoaQNsaNxp13XiIhITlejmGwj7wL7kMcNeMNUP8fJ/pc09dEk3i3JGwZEk0yiGQsfw
         QS/aLBmtysOFaziGvkiivCDbI9Bu4cemtFdyk0nz9HH8KUMusO5Tc7ax1BSsqSgqcmVQ
         CmZbxufVn1CW2K0luYTN78Ob03ppsuw2IPcHfFXHnPP6PQVjBHANFs2ZBCJYjWJDve1d
         NMG0sqg362v572kQOb8mIrA+GMkR2XzQRhTo7lAB1WYXWMV8KWDOiUE9gEaPMTl7r1k4
         nh4g==
X-Gm-Message-State: APjAAAVV5byrSw36zIOAYxArOTotd+hcHL78Ke8PexU1o1a/95LwfHmG
        F+kB306d0iE0HGJh0HFzzWsDjA==
X-Google-Smtp-Source: APXvYqxpLDn0bCSYatZg7Uqhj28dqOda+8wk8jeIA5o4UuOhP0FzZdpWO/o0xpLUi/UNbdJRyTmwtA==
X-Received: by 2002:ac8:554b:: with SMTP id o11mr31612397qtr.36.1582291698716;
        Fri, 21 Feb 2020 05:28:18 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k58sm1535726qtb.60.2020.02.21.05.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:28:18 -0800 (PST)
Date:   Fri, 21 Feb 2020 08:28:17 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200221132817.GB194360@google.com>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200221120618.GA194360@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221120618.GA194360@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 21, 2020 at 07:06:18AM -0500, Joel Fernandes wrote:
> On Tue, Feb 18, 2020 at 06:08:57PM +0100, Uladzislau Rezki wrote:
> > On Mon, Feb 17, 2020 at 02:33:14PM -0500, Theodore Y. Ts'o wrote:
> > > On Mon, Feb 17, 2020 at 05:08:27PM +0100, Uladzislau Rezki wrote:
> > > > Hello, Joel, Paul, Ted. 
> > > > 
> > > > > 
> > > > > Good point!
> > > > > 
> > > > > Now that kfree_rcu() is on its way to being less of a hack deeply
> > > > > entangled into the bowels of RCU, this might be fairly easy to implement.
> > > > > It might well be simply a matter of a function pointer and a kvfree_rcu()
> > > > > API.  Adding Uladzislau Rezki and Joel Fernandez on CC for their thoughts.
> > > > > 
> > > > I think it makes sense. For example i see there is a similar demand in
> > > > the mm/list_lru.c too. As for implementation, it will not be hard, i think. 
> > > > 
> > > > The easiest way is to inject kvfree() support directly into existing kfree_call_rcu()
> > > > logic(probably will need to rename that function), i.e. to free vmalloc() allocations
> > > > only in "emergency path" by just calling kvfree(). So that function in its turn will
> > > > figure out if it is _vmalloc_ address or not and trigger corresponding "free" path.
> > > 
> > > The other difference between ext4_kvfree_array_rcu() and kfree_rcu()
> > > is that kfree_rcu() is a magic macro which frees a structure, which
> > > has to contain a struct rcu_head.  In this case, I'm freeing a pointer
> > > to set of structures, or in another case, a set of buffer_heads, which
> > > do *not* have an rcu_head structure.
> > > 
> > We can implement kvfree_rcu() that will deal with pointer only, it is not
> > an issue. I mean without embedding rcu_head to the structure or whatever
> > else.
> > 
> > I tried to implement it with less number of changes to make it more clear
> > and readable. Please have a look:
> > 
> > <snip>
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> 
> Overall this implementation is nice. You are basically avoiding allocating
> rcu_head like Ted did by using the array-of-pointers technique we used for
> the previous kfree_rcu() work.
> 
> One thing stands out, the path where we could not allocate a page for the new
> block node:
> 
> > @@ -3061,6 +3148,11 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> >         if (krcp->initialized)
> >                 spin_unlock(&krcp->lock);
> >         local_irq_restore(flags);
> > +
> > +       if (!skip_call_rcu) {
> > +               synchronize_rcu();
> > +               kvfree(ptr_to_free);
> 
> We can't block, it has to be async otherwise everything else blocks, and I
> think this can also be used from interrupt handlers which would at least be
> an SWA violation. So perhaps it needs to allocate an rcu_head wrapper object
> itself for the 'emergeny case' and use the regular techniques.
> 
> Another thing that stands out is the code duplication, if we can make this
> reuse as much as of the previous code as possible, that'd be great. I'd like
> to avoid bvcached and bvhead if possible. Maybe we can store information
> about the fact that this is a 'special object' in some of the lower-order
> bits of the pointer. Then we can detect that it is 'special' and free it
> using kvfree() during the reclaim

I was thinking something like the following, only build-tested -- just to
show the idea. Perhaps the synchronize_rcu() should be done from a workqueue
handler to prevent IRQ crapping out?

Basically what I did different is:
1. Use the existing kfree_rcu_bulk_data::records array to store the
   to-be-freed array.
2. In case of emergency, allocate a new wrapper and tag the pointer.
   Read the tag later to figure its an array wrapper and do additional kvfree.

debug_objects bits wouldn't work obviously for the !emergency kvfree case,
not sure what we can do there.
---8<-----------------------

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2678a37c31696..19fd7c74ad532 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -805,7 +805,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 #define __kfree_rcu(head, offset) \
 	do { \
 		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
-		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset), NULL); \
 	} while (0)
 
 /**
@@ -842,6 +842,14 @@ do {									\
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
index 045c28b71f4f3..a12ecc1645fa9 100644
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
index 45f3f66bb04df..1e445b566c019 100644
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
index ec81139cc4c6a..7b6ab4160f080 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2814,6 +2814,15 @@ struct kfree_rcu_cpu {
 	bool initialized;
 };
 
+/*
+ * Used in a situation where array of pointers could
+ * not be put onto a kfree_bulk_data::records array.
+ */
+struct kfree_rcu_wrap_kvarray {
+	struct rcu_head head;
+	void *ptr;
+};
+
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
 static __always_inline void
@@ -2873,12 +2882,25 @@ static void kfree_rcu_work(struct work_struct *work)
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
+		bool is_array_ptr = false;
+
+		if (((unsigned long)head - offset) & BIT(0)) {
+			is_array_ptr = true;
+			offset = offset - 1;
+		}
 
 		next = head->next;
-		debug_rcu_head_unqueue(head);
+		if (!is_array_ptr)
+			debug_rcu_head_unqueue(head);
+
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
+		if (is_array_ptr) {
+			struct kfree_rcu_wrap_kvarray *kv = (void *)head - offset;
+			kvfree((void *)kv->ptr);
+		}
+
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
 			kfree((void *)head - offset);
 
@@ -2975,7 +2997,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 
 static inline bool
 kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
-	struct rcu_head *head, rcu_callback_t func)
+	struct rcu_head *head, rcu_callback_t func, void *ptr)
 {
 	struct kfree_rcu_bulk_data *bnode;
 
@@ -3009,14 +3031,20 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 	}
 
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-	head->func = func;
-	head->next = krcp->bhead->head_free_debug;
-	krcp->bhead->head_free_debug = head;
+	/* debug_objects doesn't work for kvfree */
+	if (!ptr) {
+		head->func = func;
+		head->next = krcp->bhead->head_free_debug;
+		krcp->bhead->head_free_debug = head;
+	}
 #endif
 
 	/* Finally insert. */
-	krcp->bhead->records[krcp->bhead->nr_records++] =
-		(void *) head - (unsigned long) func;
+	if (ptr)
+		krcp->bhead->records[krcp->bhead->nr_records++] = ptr;
+	else
+		krcp->bhead->records[krcp->bhead->nr_records++] =
+			(void *) head - (unsigned long) func;
 
 	return true;
 }
@@ -3033,10 +3061,11 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
  * be free'd in workqueue context. This allows us to: batch requests together to
  * reduce the number of grace periods during heavy kfree_rcu() load.
  */
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func, void *ptr)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	bool ret;
 
 	local_irq_save(flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
@@ -3044,7 +3073,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		spin_lock(&krcp->lock);
 
 	// Queue the object but don't yet schedule the batch.
-	if (debug_rcu_head_queue(head)) {
+	// NOTE: debug objects doesn't work for kvfree.
+	if (!ptr && debug_rcu_head_queue(head)) {
 		// Probable double kfree_rcu(), just leak.
 		WARN_ONCE(1, "%s(): Double-freed call. rcu_head %p\n",
 			  __func__, head);
@@ -3055,7 +3085,29 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	 * Under high memory pressure GFP_NOWAIT can fail,
 	 * in that case the emergency path is maintained.
 	 */
-	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+	ret = !kfree_call_rcu_add_ptr_to_bulk(krcp, head, func, ptr);
+	if (unlikely(!ret)) {
+		if (ptr) {
+			struct kfree_rcu_wrap_kvarray *kvwrap;
+
+			kvwrap = kzalloc(sizeof(*kvwrap), GFP_KERNEL);
+
+			// If memory is really low, just try inline-freeing.
+			if (!kvwrap) {
+				// NOT SURE if permitted due to IRQ. Maybe we
+				// should try doing this from WQ?
+				synchronize_rcu();
+				kvfree(ptr);
+			}
+
+			kvwrap->ptr = ptr;
+			ptr = NULL;
+			head = &(kvwrap->head);
+			func = offsetof(typeof(*kvwrap), head);
+			// Tag the array as wrapper
+			func = (rcu_callback_t)((unsigned long)func + 1);
+		}
+
 		head->func = func;
 		head->next = krcp->head;
 		krcp->head = head;
