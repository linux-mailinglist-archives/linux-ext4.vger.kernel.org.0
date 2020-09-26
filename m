Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC15279603
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Sep 2020 03:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgIZBno (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 21:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728967AbgIZBno (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Sep 2020 21:43:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601084623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anuXvW7DT2NGfM0wi3fUi3pbzDhxv6S3wuJYHpV9+T8=;
        b=EU0gZ+3ei23xvRE7eIJx8jJLkutPGQzDWfKK8ztmlTz/BzdzHeeEC9IEkKos0yu83pzWuH
        tJ+sPTC9aU8EuPzj1ASm+6/JlARwwntNZUWNRavavyz/Bv/Us20Q6ZxhHSx5ubVHGHGDHb
        2eqgGgrIlsIsa6hwz7SoGFZijsvnjPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-3ub8DGkqMci6FOxNU-m3_g-1; Fri, 25 Sep 2020 21:43:41 -0400
X-MC-Unique: 3ub8DGkqMci6FOxNU-m3_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFBE910066FC;
        Sat, 26 Sep 2020 01:43:38 +0000 (UTC)
Received: from T590 (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E771373662;
        Sat, 26 Sep 2020 01:43:29 +0000 (UTC)
Date:   Sat, 26 Sep 2020 09:43:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200926014325.GA2516054@T590>
References: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
 <20200925191902.543953-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925191902.543953-1-shakeelb@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 12:19:02PM -0700, Shakeel Butt wrote:
> On Fri, Sep 25, 2020 at 10:58 AM Shakeel Butt <shakeelb@google.com>
> wrote:
> >
> [snip]
> >
> > I don't think you can ignore the flushing. The __free_once() in
> > ___cache_free() assumes there is a space available.
> >
> > BTW do_drain() also have the same issue.
> >
> > Why not move slabs_destroy() after we update ac->avail and memmove()?
> 
> Ming, can you please try the following patch?
> 
> 
> From: Shakeel Butt <shakeelb@google.com>
> 
> [PATCH] mm: slab: fix potential infinite recursion in ___cache_free
> 
> With the commit 10befea91b61 ("mm: memcg/slab: use a single set of
> kmem_caches for all allocations"), it becomes possible to call kfree()
> from the slabs_destroy(). However if slabs_destroy() is being called for
> the array_cache of the local CPU then this opens the potential scenario
> of infinite recursion because kfree() called from slabs_destroy() can
> call slabs_destroy() with the same array_cache of the local CPU. Since
> the array_cache of the local CPU is not updated before calling
> slabs_destroy(), it will try to free the same pages.
> 
> To fix the issue, simply update the cache before calling
> slabs_destroy().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/slab.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 3160dff6fd76..f658e86ec8ce 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1632,6 +1632,10 @@ static void slab_destroy(struct kmem_cache *cachep, struct page *page)
>  		kmem_cache_free(cachep->freelist_cache, freelist);
>  }
>  
> +/*
> + * Update the size of the caches before calling slabs_destroy as it may
> + * recursively call kfree.
> + */
>  static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list)
>  {
>  	struct page *page, *n;
> @@ -2153,8 +2157,8 @@ static void do_drain(void *arg)
>  	spin_lock(&n->list_lock);
>  	free_block(cachep, ac->entry, ac->avail, node, &list);
>  	spin_unlock(&n->list_lock);
> -	slabs_destroy(cachep, &list);
>  	ac->avail = 0;
> +	slabs_destroy(cachep, &list);
>  }
>  
>  static void drain_cpu_caches(struct kmem_cache *cachep)
> @@ -3402,9 +3406,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
>  	}
>  #endif
>  	spin_unlock(&n->list_lock);
> -	slabs_destroy(cachep, &list);
>  	ac->avail -= batchcount;
>  	memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
> +	slabs_destroy(cachep, &list);
>  }

The issue can't be reproduced after applying this patch:

Tested-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

