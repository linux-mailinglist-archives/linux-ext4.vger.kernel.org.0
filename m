Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25B8278FB2
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 19:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbgIYRfR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYRfQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Sep 2020 13:35:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B60FC0613D4
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:35:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a22so3093699ljp.13
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qur/7fLUQQ7M8HcyXzGgRmzT/BT3EA18MOp9o+vXhw4=;
        b=m4O7tYfi+LCjjaX259cRmfSEkU9ANtBCnhcXbGdDSAkoly60jiLCi3EeKpG07gAcoW
         +Wto5sbywnY6Hd66eKnVr3ouoFUsth7BsWjZYIJTqVpk4I8cS2V1j/q86ygavcMJNQX3
         idQuds9V3xtHdlbaZYzJGZOujmPv3rLVOM7yFglYVXB+MepKm8MjBNp7GqumbzT0sPrJ
         OHe7/vkjySw4w2L+dMdYgr9lmY49rg1gOXR3EWsnNwU9hXQfzTuiJGcli65em57braNw
         qCFaNtwvdf0aS2TLIVDD4uaKRkr0qoBHQPspRmjgtvhgPKLiVBAHC4uV/xoDn64Yaa6e
         y7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qur/7fLUQQ7M8HcyXzGgRmzT/BT3EA18MOp9o+vXhw4=;
        b=Ny4dr0nii6O0dHIVXQ9+wtLHhCKt3T4Y2m+mZ9E4awtXP0hWgrwBsY6u9uQNu9jf8g
         iJHJL0r/mOZCyoWJ+t1PJsPILXsJelUGJ3klu4QTQsRNxCLUpJHcpN1HpWRm1iixI7km
         VB1W19IMAxjbVuH6ftODyc1mw39eKT1jcibOoPDBzgX6gqmcHBTi6tvt+YzhQXStdtZF
         l21zoYOG4N80b2cofti01lBXjZv3uuevexXsYsm2h/lSA593FV4ZSRS+2quR09lrtt4B
         qzg6FjKhhcDxGB2b+p6ZOrjTyDocub+GMk/3MaNDxL+4WjvvO65eSOmplsuOZUXDhZBk
         slkw==
X-Gm-Message-State: AOAM530k6beRxmBOAqKm62tnfD9Rmf4kfeyoDWkUAkB8l9CTF3nqfert
        HAZm8uW+htgUwOalkUeI6lbOIr/qmWjQS1OoaW1XCoT5289fzw==
X-Google-Smtp-Source: ABdhPJww9rGC7xLbm/a5AUCqZn+u7vM4jrVP8ohJ3SXGjFK55/Cin/pgBfqfgrAVY0ajf7iXLZcHF33PReQm1QIMLPc=
X-Received: by 2002:a2e:7c09:: with SMTP id x9mr1585757ljc.192.1601055314188;
 Fri, 25 Sep 2020 10:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200915073303.GA754106@T590> <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590> <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590> <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590> <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu> <20200925073145.GC2388140@T590>
 <20200925161918.GD2388140@T590> <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
 <CALvZod4+ucJfr4gR60mM1gRoc7NKWydPY-JQ757q+n8hOdmrvA@mail.gmail.com>
In-Reply-To: <CALvZod4+ucJfr4gR60mM1gRoc7NKWydPY-JQ757q+n8hOdmrvA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 25 Sep 2020 10:35:03 -0700
Message-ID: <CALvZod4Wc23o09KXb+s=VJGs6X+8juuDXWfyfJuMH5DCksLtAQ@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 10:22 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Sep 25, 2020 at 10:17 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
> > >
> > > git bisect shows the first bad commit:
> > >
> > >         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
> > >                 kmem_caches for all allocations
> > >
> > > And I have double checked that the above commit is really the first bad
> > > commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> > > is LIST_POISON1 (dead000000000100)',
> >
> > Thet commit doesn't revert cleanly, but I think that's purely because
> > we'd also need to revert
> >
> >   849504809f86 ("mm: memcg/slab: remove unused argument by charge_slab_page()")
> >   74d555bed5d0 ("mm: slab: rename (un)charge_slab_page() to
> > (un)account_slab_page()")
> >
> > too.
> >
> > Can you verify that a
> >
> >     git revert 74d555bed5d0 849504809f86 10befea91b61
> >
> > on top of current -git makes things work for you again?
> >
> > I'm going to do an rc8 this release simply because we have another VM
> > issue that I hope to get fixed - but there we know what the problem
> > and the fix _is_, it just needs some care.
> >
> > So if Roman (or somebody else) can see what's wrong and we can fix
> > this quickly, we don't need to go down the revert path, but ..
> >
>
> I think I have a theory. The issue is happening due to the potential
> infinite recursion:
>
> [ 5060.124412]  ___cache_free+0x488/0x6b0
> *****Second recursion
> [ 5060.128666]  kfree+0xc9/0x1d0
> [ 5060.131947]  kmem_freepages+0xa0/0xf0
> [ 5060.135746]  slab_destroy+0x19/0x50
> [ 5060.139577]  slabs_destroy+0x6d/0x90
> [ 5060.143379]  ___cache_free+0x4a3/0x6b0
> *****First recursion
> [ 5060.147896]  kfree+0xc9/0x1d0
> [ 5060.151082]  kmem_freepages+0xa0/0xf0
> [ 5060.155121]  slab_destroy+0x19/0x50
> [ 5060.159028]  slabs_destroy+0x6d/0x90
> [ 5060.162920]  ___cache_free+0x4a3/0x6b0
> [ 5060.167097]  kfree+0xc9/0x1d0
>
> ___cache_free() is calling cache_flusharray() to flush the local cpu
> array_cache if the cache has more elements than the limit (ac->avail
> >= ac->limit).
>
> cache_flusharray() is removing batchcount number of element from local
> cpu array_cache and pass it slabs_destroy (if the node shared cache is
> also full).
>
> Note that we have not updated local cpu array_cache size yet and
> called slabs_destroy() which can call kfree() through
> unaccount_slab_page().
>
> We are on the same CPU and this recursive kfree again check the
> (ac->avail >= ac->limit) and call cache_flusharray() again and recurse
> indefinitely.

I can see two possible fixes. We can either do async kfree of
page_obj_cgroups(page) or we can update the local cpu array_cache's
size before slabs_destroy().

Shakeel
