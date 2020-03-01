Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D5174CE5
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 12:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCALI4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Mar 2020 06:08:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39607 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCALIz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Mar 2020 06:08:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so8858642wrn.6;
        Sun, 01 Mar 2020 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZfbP0qBSHSAHVKydAS1NsEpS5FpyxvjvWsYg4Q4s5M=;
        b=mnBnTNNGj0z8nn/KLroR/8/jIABGWFda/cHXBUapX92/uuXy6qEJqmLClYQIO9nwwZ
         N8GI/cxe/dcwgZ8rfPpyghzwAJf8c1CG82IMnNVQJ7gqO0GdNEiJNgeHpjQhuZ/v/o3H
         Ru/Zx1562d6zvHyhBkVNEb5CyDmBQDbNL1G04ihLSmvCBiSbOKNlnIJYOHwG1LrdcqiZ
         bV4DFI+RzoGzGyH+UlNW+sOvIPG0eVTnP/pvLLffPmK+341t03crZ2ONJwEc9S3aQMLm
         ljacf1VCaN8BbhZfpIKqQ/OUJ9+42sSTPaNET7EWD94PqBFlZmE1TlJwJr5nvsqQkY6y
         sK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZfbP0qBSHSAHVKydAS1NsEpS5FpyxvjvWsYg4Q4s5M=;
        b=TcZ8O1GybM+D5nLU4WQ2ZCrtmZEnr12616MSdfAmi8tX/f+A3S3NUt/LBOw8o1ok7c
         BKhzU4HSCRp4/7WiXnSzTAMogko9+GIC08GdtADn3VrNYHfHFsorkga/0kQlUGo5EkuY
         XvRf3sEYM6avYynQxRFlEIIWXXcoekf7CG4qEo5lawVAjlIBhjsBZpJPEHDta/704b/I
         MAIYJYSXMC7+xB6riJa373bqY/QKm7JAIisrVEVNec403bPi2Bx/Irk2AJXEZZvUk4gy
         nDnQPMgnt9Fu0gY6qjSUPNNfRdnZ7CuHztx26NUwO2tVT1m8rLnwZhX+PgcfgZgFoHla
         Q5Xw==
X-Gm-Message-State: APjAAAWAUhR25Pb9v5qr4AxOizhCuwfjOzvBJJF+uyMdxG8oRI5YCx8X
        g78vyHzMtqS1Pxnd/2aFdeY=
X-Google-Smtp-Source: APXvYqzSOg9gGdLNhI1HB7CCr1xFm7j8WmfXg+bNPU+dr0IXr1xnTuVgkgiHWk7kLz+FZqGSdKsseQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr15423531wrn.377.1583060932175;
        Sun, 01 Mar 2020 03:08:52 -0800 (PST)
Received: from pc636 ([80.122.78.78])
        by smtp.gmail.com with ESMTPSA id e11sm21092487wrm.80.2020.03.01.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 03:08:51 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 1 Mar 2020 12:08:43 +0100
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200301110843.GA8725@pc636>
References: <20200220045233.GC476845@mit.edu>
 <20200221003035.GC2935@paulmck-ThinkPad-P72>
 <20200221131455.GA4904@pc636>
 <20200221202250.GK2935@paulmck-ThinkPad-P72>
 <20200222222415.GC191380@google.com>
 <20200223011018.GB2935@paulmck-ThinkPad-P72>
 <20200224174030.GA22138@pc636>
 <20200225020705.GA253171@google.com>
 <20200225185400.GA27919@pc636>
 <20200227133700.GC161459@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227133700.GC161459@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

>
> Sorry for slightly late reply.
> 
The same, i am on the vacation since last Thursday and the whole
next week. Therefore will be delays due to restricted access
to my emails :)

> On Tue, Feb 25, 2020 at 07:54:00PM +0100, Uladzislau Rezki wrote:
> > > > > > I was thinking a 2 fold approach (just thinking out loud..):
> > > > > > 
> > > > > > If kfree_call_rcu() is called in atomic context or in any rcu reader, then
> > > > > > use GFP_ATOMIC to grow an rcu_head wrapper on the atomic memory pool and
> > > > > > queue that.
> > > > > > 
> > > > I am not sure if that is acceptable, i mean what to do when GFP_ATOMIC
> > > > gets failed in atomic context? Or we can just consider it as out of
> > > > memory and another variant is to say that headless object can be called
> > > > from preemptible context only.
> > > 
> > > Yes that makes sense, and we can always put disclaimer in the API's comments
> > > saying if this object is expected to be freed a lot, then don't use the
> > > headless-API to be extra safe.
> > > 
> > Agree.
> > 
> > > BTW, GFP_ATOMIC the documentation says if GFP_ATOMIC reserves are depleted,
> > > the kernel can even panic some times, so if GFP_ATOMIC allocation fails, then
> > > there seems to be bigger problems in the system any way. I would say let us
> > > write a patch to allocate there and see what the -mm guys think.
> > > 
> > OK. It might be that they can offer something if they do not like our
> > approach. I will try to compose something and send the patch to see.
> > The tree.c implementation is almost done, whereas tiny one is on hold.
> > 
> > I think we should support batching as well as bulk interface there.
> > Another way is to workaround head-less object, just to attach the head
> > dynamically using kmalloc() and then call_rcu() but then it will not be
> > a fair headless support :)
> > 
> > What is your view?
> 
> This kind of "head" will require backpointers to the original object as well
> right? And still wouldn't solve the "what if we run out of GFP_ATOMIC
> reserves". But let me know in a code snippet if possible about what you mean.
> 
Just to summarize. We would like to support head-less kvfree_rcu() interface.
It implies that we have only pure pointer that is passed and that is it. Therefore
we should maintain the dynamic arrays and place it there. Like we do for "bulk"
logic, building arrays chains. Or just attach the head for tiny version. I prefer
first variant because that is fair and will be aligned with tree RCU version.

If we can not maintain the array path, i mean under low memory condition, it makes
sense to try to attach a head(for array we allocate one page), i.e. to make an object
with rcu_head the same as ww would free regular object that contains rcu_head filed
in it: 

<snip>
static inline struct rcu_head *
attach_rcu_head_to_object(void *obj, gfp_t gfp)
{
    unsigned long *ptr;

    ptr = kmalloc(sizeof(unsigned long *) +
        sizeof(struct rcu_head), gfp);
    if (!ptr)
        return NULL;

    ptr[0] = (unsigned long) obj;
    return ((struct rcu_head *) ++ptr);
}
...
void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
...
    if (head == NULL && is_vmalloc_addr((void *) func)) {
        if (!vfree_call_rcu_add_ptr_to_bulk(krcp, (void *) func)) {
            head = attach_rcu_head_to_object((void *) func, GFP_ATOMIC);
            if (head) {
                /* Set the offset and tag the headless object. */
                func = (rcu_callback_t) (sizeof(unsigned long *) + 1);

                head->func = func;
                head->next = krcp->head;
                krcp->head = head;
   }

later on when freeing the headless object to witch we attached the head:

for (; head; head = next) {
...
  /* We tag the headless object, so check it. */
  if (!(((unsigned long) head - offset) & BIT(0))) {
   debug_rcu_head_unqueue(head);
  } else {
   offset -= 1;
   headless_ptr = (void *) head - offset;
  }
...
if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
   /*
    * here we kvfree() head-less object. The head was attached
    * due to low memory condition.
    */
   if (headless_ptr)
    kvfree((void *) *headless_ptr);

   kfree((void *)head - offset);
  }
<snip>

>
> And still wouldn't solve the "what if we run out of GFP_ATOMIC reserves".
>
It will not solve corner case. But it makes sense anyway to do because the
page allocator can say: no page, sorry, whereas slab can still serve our
request because we need only sizeof(rcu_head) + sizeof(unsigned long *)
bytes and not whole page.

Also when we detect low memory condition we should add force flag to schedule
the "monitor work" right away:

<snip>
 if (force)
     schedule_delayed_work(&krcp->monitor_work, 0);
<snip>

> > > > > > Otherwise, grow an rcu_head on the stack of kfree_call_rcu() and call
> > > > > > synchronize_rcu() inline with it.
> > > > > > 
> > > > > >
> > > > What do you mean here, Joel? "grow an rcu_head on the stack"?
> > > 
> > > By "grow on the stack", use the compiler-allocated rcu_head on the
> > > kfree_rcu() caller's stack.
> > > 
> > > I meant here to say, if we are not in atomic context, then we use regular
> > > GFP_KERNEL allocation, and if that fails, then we just use the stack's
> > > rcu_head and call synchronize_rcu() or even synchronize_rcu_expedited since
> > > the allocation failure would mean the need for RCU to free some memory is
> > > probably great.
> > > 
> > Ah, i got it. I thought you meant something like recursion and then
> > unwinding the stack back somehow :)
> 
> Yeah something like that :) Use the compiler allocated space which you
> wouldn't run out of unless stack overflows.
> 
Hmm... Please show it here, because i am a bit confused how to do that :)

> > > > As for "task_struct's rcu_read_lock_nesting". Will it be enough just
> > > > have a look at preempt_count of current process? If we have for example
> > > > nested rcu_read_locks:
> > > > 
> > > > <snip>
> > > > rcu_read_lock()
> > > >     rcu_read_lock()
> > > >         rcu_read_lock()
> > > > <snip>
> > > > 
> > > > the counter would be 3.
> > > 
> > > No, because preempt_count is not incremented during rcu_read_lock(). RCU
> > > reader sections can be preempted, they just cannot goto sleep in a reader
> > > section (unless the kernel is RT).
> > > 
> > So in CONFIG_PREEMPT kernel we can identify if we are in atomic or not by
> > using rcu_preempt_depth() and in_atomic(). When it comes to !CONFIG_PREEMPT
> > then we skip it and consider as atomic. Something like:
> > 
> > <snip>
> > static bool is_current_in_atomic()
> 
> Would be good to change this to is_current_in_rcu_reader() since
> rcu_preempt_depth() does not imply atomicity.
>
can_current_synchronize_rcu()? If can we just call:

<snip>
    synchronize_rcu() or synchronize_rcu_expedited();
    kvfree();
<snip>

> > {
> > #ifdef CONFIG_PREEMPT_RCU
> >     if (!rcu_preempt_depth() && !in_atomic())
> >         return false;
> 
> I think use if (!rcu_preempt_depth() && preemptible()) here.
> 
> preemptible() checks for IRQ disabled section as well.
> 
Yes but in_atomic() does it as well, it also checks other atomic
contexts like softirq handlers and NMI ones. So calling there
synchronize_rcu() is not allowed.

Thank you, Joel :)

--
Vlad Rezki
