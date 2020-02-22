Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79016920B
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2020 23:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgBVWM4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Feb 2020 17:12:56 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36772 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVWMz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Feb 2020 17:12:55 -0500
Received: by mail-qv1-f68.google.com with SMTP id ff2so2620921qvb.3
        for <linux-ext4@vger.kernel.org>; Sat, 22 Feb 2020 14:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SlZWFeo/xeISosmrn1jsoTgJVZUqzfSk+kXXXeZ7TCI=;
        b=dgPuUSGbLZR58jkS1J1gV4iXGQkYyGJcq06IXmtvDYDvgZy/uycNkeFsibcG1QWRn/
         YWWf17LxF7QFaOCh8/Rec4tSOymouFIA0sKQg61ZllbMw1luINzPEVKELu+6swz4IlUI
         1kJdW7uFOiMCCeARwVRAzjkFQhN/mUiH4Sx18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SlZWFeo/xeISosmrn1jsoTgJVZUqzfSk+kXXXeZ7TCI=;
        b=XUdkFP/Jkm3RIyg3YrHmsCKepskZIVZpdmQyewCr51lwmxd5VfldS4BvF+qGZqogew
         6xJw/4j/7rwXtCjS9ptun53DBy8j+yRvsGfVyTGYu8RQpPyI1XR8V7OQ4oytkvq+V/dQ
         1ThfYY+cg+mh0ccOfyaAl64Z0dnXiMxnUFK7yGsefnNj7IopXIAqemkC0/TkNTKd46II
         DAYPGvZdMUU4K3Mi8hauxP+5T6EqXMQ0aa3DyD4Jv+uk4FvM9CobEtSMbBhC5tejPulZ
         dPunW9F+wBHEdSrqxASvJobo6VxPT2YgeGCjGGIyDRNvi0QCvLF3bixwS6KFy50435jF
         ZuPw==
X-Gm-Message-State: APjAAAWTUgnz/EO4t6MrQxzw3Ugxs2JzHlSa/FdVCH6GAtnm2K6zEVBO
        fT0bnTQwRJl/zVEdwIdEYBJBXQ==
X-Google-Smtp-Source: APXvYqyh7v0sVfuBPM9DJO3MPdrRbTBg+5GYxGIWr9+HNrNofK4qA3bIbGHhMZdtHTqgWwVeAyTlRw==
X-Received: by 2002:a0c:f9c7:: with SMTP id j7mr37411528qvo.222.1582409574447;
        Sat, 22 Feb 2020 14:12:54 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v7sm3772085qkg.103.2020.02.22.14.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:12:53 -0800 (PST)
Date:   Sat, 22 Feb 2020 17:12:53 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH RFC] ext4: fix potential race between online resizing and
 write operations
Message-ID: <20200222221253.GB191380@google.com>
References: <20200215233817.GA670792@mit.edu>
 <20200216121246.GG2935@paulmck-ThinkPad-P72>
 <20200217160827.GA5685@pc636>
 <20200217193314.GA12604@mit.edu>
 <20200218170857.GA28774@pc636>
 <20200221120618.GA194360@google.com>
 <20200221132817.GB194360@google.com>
 <20200221192152.GA6306@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221192152.GA6306@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 21, 2020 at 08:21:52PM +0100, Uladzislau Rezki wrote:
> > > 
> > > Overall this implementation is nice. You are basically avoiding allocating
> > > rcu_head like Ted did by using the array-of-pointers technique we used for
> > > the previous kfree_rcu() work.
> > > 
> > > One thing stands out, the path where we could not allocate a page for the new
> > > block node:
> > > 
> > > > @@ -3061,6 +3148,11 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >         if (krcp->initialized)
> > > >                 spin_unlock(&krcp->lock);
> > > >         local_irq_restore(flags);
> > > > +
> > > > +       if (!skip_call_rcu) {
> > > > +               synchronize_rcu();
> > > > +               kvfree(ptr_to_free);
> > > 
> > > We can't block, it has to be async otherwise everything else blocks, and I
> > > think this can also be used from interrupt handlers which would at least be
> > > an SWA violation. So perhaps it needs to allocate an rcu_head wrapper object
> > > itself for the 'emergeny case' and use the regular techniques.
> > > 
> > > Another thing that stands out is the code duplication, if we can make this
> > > reuse as much as of the previous code as possible, that'd be great. I'd like
> > > to avoid bvcached and bvhead if possible. Maybe we can store information
> > > about the fact that this is a 'special object' in some of the lower-order
> > > bits of the pointer. Then we can detect that it is 'special' and free it
> > > using kvfree() during the reclaim
> > 
> > Basically what I did different is:
> > 1. Use the existing kfree_rcu_bulk_data::records array to store the
> >    to-be-freed array.
> > 2. In case of emergency, allocate a new wrapper and tag the pointer.
> >    Read the tag later to figure its an array wrapper and do additional kvfree.
> >
> I see your point and agree that duplication is odd and we should avoid
> it as much as possible. Also, i like the idea of using the wrapper as
> one more chance to build a "head" for headless object.
> 
> I did not mix pointers because then you will need to understand what is what.

Well that's why I brought up the whole tagging idea. Then you don't need
separate pointers to manage either (edit: but maybe you do as you mentioned
vfree below..).

> It is OK for "emergency" path, because we simply can just serialize it by kvfree()
> call, it checks inside what the ptr address belong to:
> 
> <snip>
> void kvfree(const void *addr)
> {
>     if (is_vmalloc_addr(addr))
>         vfree(addr);
>     else
>         kfree(addr);
> }
> <snip>
> 
> whereas normal path, i mean "bulk one" where we store pointers into array
> would be broken. We can not call kfree_bulk(array, nr_entries) if the passed
> array contains "vmalloc" pointers, because it is different allocator. Therefore,
> i deliberately have made it as a special case.

Ok, it would be nice if you can verify that ptr_to_free passed to
kfree_call_rcu() is infact a vmalloc pointer.

> > Perhaps the synchronize_rcu() should be done from a workqueue handler
> > to prevent IRQ crapping out?
> >
> I think so. For example one approach would be:
> 
> <snip>
> struct free_deferred {
>  struct llist_head list;
>  struct work_struct wq;
> };
> static DEFINE_PER_CPU(struct free_deferred, free_deferred);
> 
> static void free_work(struct work_struct *w)
> {
>   struct free_deferred *p = container_of(w, struct free_deferred, wq);
>   struct llist_node *t, *llnode;
> 
>   synchronize_rcu();
> 
>   llist_for_each_safe(llnode, t, llist_del_all(&p->list))
>      vfree((void *)llnode, 1);
> }
> 
> static inline void free_deferred_common(void *ptr_to_free)
> {
>     struct free_deferred *p = raw_cpu_ptr(&free_deferred);
> 
>     if (llist_add((struct llist_node *)ptr_to_free, &p->list))

Would this not corrupt the ptr_to_free pointer which readers might still be
accessing since grace period has not yet ended?

We cannot touch the ptr_to_free pointer until after the grace period has
ended.

>         schedule_work(&p->wq);
> }
> <snip>
> 
> and it seems it should work. Because we know that KMALLOC_MIN_SIZE
> can not be less then machine word:
> 
> /*
>  * Kmalloc subsystem.
>  */
>  #ifndef KMALLOC_MIN_SIZE
>  #define KMALLOC_MIN_SIZE (1 << KMALLOC_SHIFT_LOW)
>  #endif
> 
> when it comes to vmalloc pointer it can not be less then one PAGE_SIZE :)
> 
> Another thing:
> 
> we are talking about "headless" variant that is special, therefore it
> implies to have some restrictions, since we need a dynamic memory to
> drive it. For example "headless" object can be freed from preemptible
> context only, because freeing can be inlined:
> 
> <snip>
> +   // NOT SURE if permitted due to IRQ. Maybe we
> +   // should try doing this from WQ?
> +   synchronize_rcu();
> +   kvfree(ptr);
> <snip>
> 
> Calling synchronize_rcu() from the IRQ context will screw the system up :)
> Because the current CPU will never pass the QS state if i do not miss something.

Yes are you right, calling synchronize_rcu() from IRQ context is a strict no-no.

I believe we could tap into the GFP_ATOMIC emergency memory pool for this
emergency situation. This pool is used for emergency cases. I think in
emergency we can grow an rcu_head on this pool.

> Also kvfree() itself can be called from the preemptible context only, excluding IRQ,
> there is a special path for it, otherwise vfree() can sleep. 

Ok that's good to know.

> > debug_objects bits wouldn't work obviously for the !emergency kvfree case,
> > not sure what we can do there.
> >
> Agree.
> 
> Thank you, Joel, for your comments!

No problem, I think we have a couple of ideas here.

What I also wanted to do was (may be after all this), see if we can create an
API for head-less kfree based on the same ideas. Not just for arrays for for
any object. Calling it, say, kfree_rcu_headless() and then use the bulk array
as we have been doing. That would save any users from having an rcu_head --
of course with all needed warnings about memory allocation failure. Vlad,
What do you think? Paul, any thoughts on this?

thanks,

 - Joel

