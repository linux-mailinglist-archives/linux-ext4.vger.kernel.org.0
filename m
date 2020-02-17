Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF51616FE
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2020 17:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgBQQIj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Feb 2020 11:08:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45729 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgBQQIj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Feb 2020 11:08:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so12238887lfa.12
        for <linux-ext4@vger.kernel.org>; Mon, 17 Feb 2020 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zpUtYYYKt6wzJhX3LmXRTbfSCKjGKcoBGWi5MqIx9/8=;
        b=dTILJvqb88Mv+kzD4eLuXI67qGD5SLWpy6H1HP55y9s6JH5m3w3TN++A5rp51dEU+5
         A80wUeUVvbiZh4TnFsrjcAp0XK82LY5Hi5lrnqvY+Pv55SC44mlCyD26pAlP1ReaoK79
         vj9O97rMZifJfCXO29Ej4O+kOEYHgyLvd52Ufpu2lNvpEoOWx4FSj5G7kS4Lusrb2Meb
         t0i+/IOaA5p65vzVM5jOnjW+VoSpBWBy2JMadEz+fg7aU7/EbxA2squxzA1HA1GD3RFw
         wJWL25lGnJ/WNZ9YSSsgXSVZtAnfikhslMFZXCQ2e+JbGBehRwtgDBWMGh2JpMAdiEpf
         nEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpUtYYYKt6wzJhX3LmXRTbfSCKjGKcoBGWi5MqIx9/8=;
        b=kYSWVq1cb3SJZDJ9LTipZV5NKEP2/3AG9ONJAJ0lfpBbyHKiZMZEZyM3MDGjJEzyXa
         6ni12XyETIsnVTHeiHP8p5y7k2U0q/p+payYrcA+z5s08NW+qtbiLbnpZPo+OtM+mpRI
         KWWpaHoKJOqM2sqIjVpCXKKE6zzjyS48UAzbh1U2Qw+7AdTBvkB2eRJrt9m2c4N0xDac
         3rY3hDlxYQg3fJrPRShRbPC5XTe+k0aVziuVGQZ8IJMH1tiqxDdhvXiv7ZXILwFBiJRr
         c9hiBe8HEeiZ9aa5cmpPtznTrgcA6ihUurKXGXg+dW/su222a7D7Xc8QFa2bgEtHrD8o
         eheg==
X-Gm-Message-State: APjAAAUW3aSN9MIdiawYJ4R2ra0JyoxMPnhvUR/ggTdlq+d171Q5iJ2B
        W2oyPekdeCsS5O9jdPKM0Fo=
X-Google-Smtp-Source: APXvYqw9fL4DIYIp9dOM84u4Q/cYkLjAX2nzbZbZcslXpFE8Ba3g5N/TaMDjAWKisMXv4XkzY1ahqw==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr8398784lfc.111.1581955716074;
        Mon, 17 Feb 2020 08:08:36 -0800 (PST)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id y7sm593496lfk.83.2020.02.17.08.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:08:35 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 17 Feb 2020 17:08:27 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200217160827.GA5685@pc636>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216121246.GG2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello, Joel, Paul, Ted. 

> 
> Good point!
> 
> Now that kfree_rcu() is on its way to being less of a hack deeply
> entangled into the bowels of RCU, this might be fairly easy to implement.
> It might well be simply a matter of a function pointer and a kvfree_rcu()
> API.  Adding Uladzislau Rezki and Joel Fernandez on CC for their thoughts.
> 
I think it makes sense. For example i see there is a similar demand in
the mm/list_lru.c too. As for implementation, it will not be hard, i think. 

The easiest way is to inject kvfree() support directly into existing kfree_call_rcu()
logic(probably will need to rename that function), i.e. to free vmalloc() allocations
only in "emergency path" by just calling kvfree(). So that function in its turn will
figure out if it is _vmalloc_ address or not and trigger corresponding "free" path.

Just an example:

<snip>
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 75a2eded7aa2..0c4af5d0e3f8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -806,6 +806,11 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
                kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
        } while (0)

+#define __kvfree_rcu(head, offset) \
+       do { \
+               kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+       } while (0)
+
 /**
  * kfree_rcu() - kfree an object after a grace period.
  * @ptr:       pointer to kfree
@@ -840,6 +845,14 @@ do {                                                                       \
                __kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)

+#define kvfree_rcu_my(ptr, rhf)                                                \
+do {                                                                   \
+       typeof (ptr) ___p = (ptr);                                      \
+                                                                       \
+       if (___p)                                                       \
+               __kvfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
+} while (0)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 394a83bd7ff4..1a05bb44951b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2783,11 +2783,10 @@ static void kfree_rcu_work(struct work_struct *work)
                rcu_lock_acquire(&rcu_callback_map);
                trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
-               if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-                       kfree((void *)head - offset);
+               kvfree((void *)head - offset);
 
-                rcu_lock_release(&rcu_callback_map);
-                cond_resched_tasks_rcu_qs();
+               rcu_lock_release(&rcu_callback_map);
+               cond_resched_tasks_rcu_qs();
        }
 }
 
@@ -2964,7 +2963,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
         * Under high memory pressure GFP_NOWAIT can fail,
         * in that case the emergency path is maintained.
         */
-       if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+       if (is_vmalloc_addr((void *) head - (unsigned long) func) ||
+                       unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
                head->func = func;
                head->next = krcp->head;
                krcp->head = head;
<snip>

How to use it:

<snip>
struct test_kvfree_rcu {
       unsigned char array[PAGE_SIZE * 2];
       struct rcu_head rcu;
};

struct test_kvfree_rcu *p;

p = vmalloc(sizeof(struct test_kvfree_rcu));
kvfree_rcu_my((struct test_kvfree_rcu *) p, rcu);
<snip>

Any thoughts?

Thank you!

--
Vlad Rezki
