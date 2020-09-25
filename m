Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C2278FF8
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIYR7E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 13:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIYR7E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Sep 2020 13:59:04 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4DC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:59:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y2so3741779lfy.10
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kefvEdlj7ax425quXuy8w7lDixQ/9oR1/8w2lyEDoxg=;
        b=a2q4z7Yr0bdROmjf/MrINA675Wl3B/OB6CVouLzBltplLpi8U3qWAwE4xbe3hCTaAM
         Eiktzce3ER+xeMDht2b1mb0VNU4dWNHbCXZlkqcFExAGLrAErQNLwpxPiJ5dAqYUnqdd
         3253Gs1ZKg73FBKHom7QQgvIgwLMj5kF4nO9NiUj8JoaErtWxam5dnRITfqvGUCqYdGk
         ZZPBtuOIa+QjyR7sQz1Gslczb765PWTkFAZFT0fDlUWRK2jyWu+covhjxAKWc0M4IkhT
         CNB0LeSKDP2SRsX7ZhMSfN6FmxwpbWk5AvebEu8EfM3c08Eut2pIZN5yjVA5JdO/3xJN
         0hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kefvEdlj7ax425quXuy8w7lDixQ/9oR1/8w2lyEDoxg=;
        b=Nh0NPzzqCV20NpzndLDz4hGXt9xYmgorsxYbso8MK/Q2xMUcNXaScq28bl7Kterdsp
         E3rX9KsXSxIHYuIVsisTIMN/4K02Snb/zgag3mvZfZXj7bsXaEhvWjVUeN+3k/HnHlMN
         PLGjlIKtgfq+OW3yUE2aFR7G5pH9iXt1u3mdB2hulcEUGqBrkE7b57Fh6WfAlcjceLxC
         S7/eFGIT5fXYVAPcD4cir9QfJmdGursK3xOqHYd7lJumoPWlRWXYws6Fn763xkn1WE6u
         Txmh9f6w2t+kLV2iOm4pzlYT1Lx9Jvp9L/uAv23NKHI4n+jsZoUvxizR9iJiLnCIkkpx
         IWgQ==
X-Gm-Message-State: AOAM533FP9uoHDPOigPWOoaSwEmhm4M73aWmfzKqJVl8UQiNCZVE4SXK
        meAY6Xew+5Sy8FYUnukVz5tVre1zIOuivinq1fnjPe1j7umO2A==
X-Google-Smtp-Source: ABdhPJxpHHte2JGUkx5xwJf3o11AU5UbVFEJVHEACHGiZE6J6+2/TExBzQ20x9ep2Ob/62Yb/p8IQ/rrhSlhbVtIpDs=
X-Received: by 2002:ac2:4315:: with SMTP id l21mr13992lfh.494.1601056741842;
 Fri, 25 Sep 2020 10:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200917022051.GA1004828@T590> <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590> <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu> <20200925073145.GC2388140@T590>
 <20200925161918.GD2388140@T590> <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
 <CALvZod4+ucJfr4gR60mM1gRoc7NKWydPY-JQ757q+n8hOdmrvA@mail.gmail.com>
 <CALvZod4Wc23o09KXb+s=VJGs6X+8juuDXWfyfJuMH5DCksLtAQ@mail.gmail.com> <20200925174740.GA2211131@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200925174740.GA2211131@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 25 Sep 2020 10:58:50 -0700
Message-ID: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Roman Gushchin <guro@fb.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 10:48 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Sep 25, 2020 at 10:35:03AM -0700, Shakeel Butt wrote:
> > On Fri, Sep 25, 2020 at 10:22 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Fri, Sep 25, 2020 at 10:17 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
> > > > >
> > > > > git bisect shows the first bad commit:
> > > > >
> > > > >         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
> > > > >                 kmem_caches for all allocations
> > > > >
> > > > > And I have double checked that the above commit is really the first bad
> > > > > commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> > > > > is LIST_POISON1 (dead000000000100)',
> > > >
> > > > Thet commit doesn't revert cleanly, but I think that's purely because
> > > > we'd also need to revert
> > > >
> > > >   849504809f86 ("mm: memcg/slab: remove unused argument by charge_slab_page()")
> > > >   74d555bed5d0 ("mm: slab: rename (un)charge_slab_page() to
> > > > (un)account_slab_page()")
> > > >
> > > > too.
> > > >
> > > > Can you verify that a
> > > >
> > > >     git revert 74d555bed5d0 849504809f86 10befea91b61
> > > >
> > > > on top of current -git makes things work for you again?
> > > >
> > > > I'm going to do an rc8 this release simply because we have another VM
> > > > issue that I hope to get fixed - but there we know what the problem
> > > > and the fix _is_, it just needs some care.
> > > >
> > > > So if Roman (or somebody else) can see what's wrong and we can fix
> > > > this quickly, we don't need to go down the revert path, but ..
> > > >
> > >
> > > I think I have a theory. The issue is happening due to the potential
> > > infinite recursion:
> > >
> > > [ 5060.124412]  ___cache_free+0x488/0x6b0
> > > *****Second recursion
> > > [ 5060.128666]  kfree+0xc9/0x1d0
> > > [ 5060.131947]  kmem_freepages+0xa0/0xf0
> > > [ 5060.135746]  slab_destroy+0x19/0x50
> > > [ 5060.139577]  slabs_destroy+0x6d/0x90
> > > [ 5060.143379]  ___cache_free+0x4a3/0x6b0
> > > *****First recursion
> > > [ 5060.147896]  kfree+0xc9/0x1d0
> > > [ 5060.151082]  kmem_freepages+0xa0/0xf0
> > > [ 5060.155121]  slab_destroy+0x19/0x50
> > > [ 5060.159028]  slabs_destroy+0x6d/0x90
> > > [ 5060.162920]  ___cache_free+0x4a3/0x6b0
> > > [ 5060.167097]  kfree+0xc9/0x1d0
> > >
> > > ___cache_free() is calling cache_flusharray() to flush the local cpu
> > > array_cache if the cache has more elements than the limit (ac->avail
> > > >= ac->limit).
> > >
> > > cache_flusharray() is removing batchcount number of element from local
> > > cpu array_cache and pass it slabs_destroy (if the node shared cache is
> > > also full).
> > >
> > > Note that we have not updated local cpu array_cache size yet and
> > > called slabs_destroy() which can call kfree() through
> > > unaccount_slab_page().
> > >
> > > We are on the same CPU and this recursive kfree again check the
> > > (ac->avail >= ac->limit) and call cache_flusharray() again and recurse
> > > indefinitely.
>
> It's a coll theory! And it explains why we haven't seen it with SLUB.
>
> >
> > I can see two possible fixes. We can either do async kfree of
> > page_obj_cgroups(page) or we can update the local cpu array_cache's
> > size before slabs_destroy().
>
> I wonder if something like this can fix the problem?
> (completely untested).
>
> --
>
> diff --git a/mm/slab.c b/mm/slab.c
> index 684ebe5b0c7a..c94b9ccfb803 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -186,6 +186,7 @@ struct array_cache {
>         unsigned int limit;
>         unsigned int batchcount;
>         unsigned int touched;
> +       bool flushing;
>         void *entry[];  /*
>                          * Must have this definition in here for the proper
>                          * alignment of array_cache. Also simplifies accessing
> @@ -526,6 +527,7 @@ static void init_arraycache(struct array_cache *ac, int limit, int batch)
>                 ac->limit = limit;
>                 ac->batchcount = batch;
>                 ac->touched = 0;
> +               ac->flushing = false;
>         }
>  }
>
> @@ -3368,6 +3370,11 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>         int node = numa_mem_id();
>         LIST_HEAD(list);
>
> +       if (ac->flushing)
> +               return;
> +
> +       ac->flushing = true;
> +
>         batchcount = ac->batchcount;
>
>         check_irq_off();
> @@ -3404,6 +3411,7 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>         spin_unlock(&n->list_lock);
>         slabs_destroy(cachep, &list);
>         ac->avail -= batchcount;
> +       ac->flushing = false;
>         memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
>  }
>

I don't think you can ignore the flushing. The __free_once() in
___cache_free() assumes there is a space available.

BTW do_drain() also have the same issue.

Why not move slabs_destroy() after we update ac->avail and memmove()?
