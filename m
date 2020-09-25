Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A67279255
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 22:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIYUir (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgIYUif (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Sep 2020 16:38:35 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3DDC0613DE
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 12:19:22 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q95so43702pja.0
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=c9CDfynf/KUxdFh8n3XOljSdCkgSvr8lNgdQYSCmCYk=;
        b=fl2TaMkw1JkltuSEzdvWcmFU9+d3U4yl5mjSBoCcGilxxYeoBy74RE52xS+Ln6YSrb
         xEy+4y7Pvmsv+LwnX76eQOdXe30Zv3CtkS1gl6iEVW5MN4l1N785IqZoKriNLCcNC9FH
         S6ibrfOLkK/rrw2nucf69VVUnqeUM5DO82RikP4ZH6i98QBEDjsRVRwnsKvdBMAVvYHv
         DhwgdImhtYWhDpVVoh5yX/JxpO7VW+ob3jvyRoDZ0/Lk1tvwArMtjiZtmef7yqZsuXkh
         nuhyhbn0O68fp167oKpymHn64S0FLQIdUGSCx8xSoq+lBpM5IcgZULlrvNq0/945p8Zx
         OOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c9CDfynf/KUxdFh8n3XOljSdCkgSvr8lNgdQYSCmCYk=;
        b=a4lD7aLgmw0HGotWzhWxl6VESzpsoFl4EbL9jOgMnNS2Z4C1kNZ1q1P5W5UrWy8nJI
         UYMwQ8+4K66iiwbkxqS+wrsycNH2bo9lri2JFFbzPyikIUCGlsEajv4vui4D23TxTyN/
         Jl6lc1m5Z37V2urrImGcX72khGJh22P5RMYiZMMRpi46FvnJCWxbLvAJWlfCVgRssS0z
         0MPW28c517xOsT7l3SmKii/P1evbYeqF51kuKVDQgZ3qSkuuPT5+sQ7wYTgeEAqF637O
         hLcZT+HmWIrf9K9xTLXi/eW46f5kGqfVTAFA1G7o+c5hj0MZlyWbrJjJZLgDhA16rVQe
         joQg==
X-Gm-Message-State: AOAM530FBsm7dRWKo2+53XmsoVIcYRhhZUM5OhJ4lh1/IUE/7wGx/KKu
        5Z06QwFDP6xGEsSvD1xH+SbAwuYFkArGXA==
X-Google-Smtp-Source: ABdhPJyLFbH0nTn+I3Lwc3lBcbpV1gXP2gky2AKFlBb1OO3GB1kXpbwWnmfIuyJwos/1CTeA/XwLjOz7K97s6w==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee8:36f0])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:4cc6:: with SMTP id
 k64mr62957pjh.103.1601061562249; Fri, 25 Sep 2020 12:19:22 -0700 (PDT)
Date:   Fri, 25 Sep 2020 12:19:02 -0700
In-Reply-To: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
Message-Id: <20200925191902.543953-1-shakeelb@google.com>
Mime-Version: 1.0
References: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 10:58 AM Shakeel Butt <shakeelb@google.com>
wrote:
>
[snip]
>
> I don't think you can ignore the flushing. The __free_once() in
> ___cache_free() assumes there is a space available.
>
> BTW do_drain() also have the same issue.
>
> Why not move slabs_destroy() after we update ac->avail and memmove()?

Ming, can you please try the following patch?


From: Shakeel Butt <shakeelb@google.com>

[PATCH] mm: slab: fix potential infinite recursion in ___cache_free

With the commit 10befea91b61 ("mm: memcg/slab: use a single set of
kmem_caches for all allocations"), it becomes possible to call kfree()
from the slabs_destroy(). However if slabs_destroy() is being called for
the array_cache of the local CPU then this opens the potential scenario
of infinite recursion because kfree() called from slabs_destroy() can
call slabs_destroy() with the same array_cache of the local CPU. Since
the array_cache of the local CPU is not updated before calling
slabs_destroy(), it will try to free the same pages.

To fix the issue, simply update the cache before calling
slabs_destroy().

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/slab.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 3160dff6fd76..f658e86ec8ce 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1632,6 +1632,10 @@ static void slab_destroy(struct kmem_cache *cachep, struct page *page)
 		kmem_cache_free(cachep->freelist_cache, freelist);
 }
 
+/*
+ * Update the size of the caches before calling slabs_destroy as it may
+ * recursively call kfree.
+ */
 static void slabs_destroy(struct kmem_cache *cachep, struct list_head *list)
 {
 	struct page *page, *n;
@@ -2153,8 +2157,8 @@ static void do_drain(void *arg)
 	spin_lock(&n->list_lock);
 	free_block(cachep, ac->entry, ac->avail, node, &list);
 	spin_unlock(&n->list_lock);
-	slabs_destroy(cachep, &list);
 	ac->avail = 0;
+	slabs_destroy(cachep, &list);
 }
 
 static void drain_cpu_caches(struct kmem_cache *cachep)
@@ -3402,9 +3406,9 @@ static void cache_flusharray(struct kmem_cache *cachep, struct array_cache *ac)
 	}
 #endif
 	spin_unlock(&n->list_lock);
-	slabs_destroy(cachep, &list);
 	ac->avail -= batchcount;
 	memmove(ac->entry, &(ac->entry[batchcount]), sizeof(void *)*ac->avail);
+	slabs_destroy(cachep, &list);
 }
 
 /*
-- 
2.28.0.681.g6f77f65b4e-goog

