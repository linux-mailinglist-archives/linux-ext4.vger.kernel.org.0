Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85913772287
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjHGLe7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjHGLeg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 07:34:36 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954CD4237
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 04:31:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a7065d0f32so482339b6e.1
        for <linux-ext4@vger.kernel.org>; Mon, 07 Aug 2023 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407833; x=1692012633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDu/4z0sff3MNLq2Hem41DvJLtW9HR7Ht2OY0+o3IBw=;
        b=buoh4B+QZT6UXzVqadSxHXv0ex3fZSYf8n5vB6ObN+Or7DKhEYfRrvcrxd8/N+8ptx
         Q5JEI7PhPJgPaVVEV9B+uta6ZLfMg8reiy/egF8ElcvNE9iY4gKyyiw3bkZGsDsQQLtS
         W/kIzKQzovjHLMrSlS7VUmNAn++eDQp5hYDYn2nqT43awZwhsCQ3HiWlgai78C9EoErL
         GlNBKulKQW35OHXL99kXv1hLd7RCTco4+30g0XOggh1hA7eMPiCSGuMQeYaoXMCYqsq8
         EY4s+pOls21oW1zrD7a0HjeT589ic7yBH5jntUTNHjd3tur6UvCUY0sEiTes1RuabGGN
         p4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407833; x=1692012633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDu/4z0sff3MNLq2Hem41DvJLtW9HR7Ht2OY0+o3IBw=;
        b=FCwuqb4fdms+GtRl2cHjmx1mti1wqMfXcRmAgvRH1h6QhSCcps4z95QgCaKYpJDcAp
         Vyj4ZBxiOmSudCSa7Y6mbluOw0YmfUkHQF8JJW2LcEe9WaXhc+ZP65Gvdjz25iYJMyp9
         weDu/7YU9ZQlDFsjkJcM2Tfha01E/TN4OZnArOOQu/lFfDzLeZMj7QYQd+sq61FHoTPf
         kHZJVLGkpTW+HjpWVCkC5ijsArBQiegr8F6U7PAhfFWepxCwMYmcRctZKqXdP8wsb7Rk
         mY8zjXJA/Nvlr8AQZrDRVKs51gdpgO0jPvOMiq4wIARsLmUXKkXbTW5QPfYDgUQrxPg7
         nxdQ==
X-Gm-Message-State: ABy/qLZOBZeYywhojLqRDzau+4eEFVI0efqRKIuyTZpkIA7H6Xh1LH3v
        hAHU0QPXNtzx0KiK5mNlxq4HvoN8rInDeONzHf0=
X-Google-Smtp-Source: APBJJlE+JUQU2KnCMqxKRhVbnyE7g/MjXwiwJL23ihCwbN9GtK/yS0Snkx/m2fq2fyEzRCC+VQ52VA==
X-Received: by 2002:a17:90a:1f83:b0:268:3dc6:f0c5 with SMTP id x3-20020a17090a1f8300b002683dc6f0c5mr25034377pja.0.1691406879873;
        Mon, 07 Aug 2023 04:14:39 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:14:39 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 22/48] mm: workingset: dynamically allocate the mm-shadow shrinker
Date:   Mon,  7 Aug 2023 19:09:10 +0800
Message-Id: <20230807110936.21819-23-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use new APIs to dynamically allocate the mm-shadow shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/workingset.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..3c53138903a7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -763,13 +763,6 @@ static unsigned long scan_shadow_nodes(struct shrinker *shrinker,
 					NULL);
 }
 
-static struct shrinker workingset_shadow_shrinker = {
-	.count_objects = count_shadow_nodes,
-	.scan_objects = scan_shadow_nodes,
-	.seeks = 0, /* ->count reports only fully expendable nodes */
-	.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
-};
-
 /*
  * Our list_lru->lock is IRQ-safe as it nests inside the IRQ-safe
  * i_pages lock.
@@ -778,9 +771,10 @@ static struct lock_class_key shadow_nodes_key;
 
 static int __init workingset_init(void)
 {
+	struct shrinker *workingset_shadow_shrinker;
 	unsigned int timestamp_bits;
 	unsigned int max_order;
-	int ret;
+	int ret = -ENOMEM;
 
 	BUILD_BUG_ON(BITS_PER_LONG < EVICTION_SHIFT);
 	/*
@@ -797,17 +791,24 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
-	if (ret)
+	workingset_shadow_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE |
+						    SHRINKER_MEMCG_AWARE,
+						    "mm-shadow");
+	if (!workingset_shadow_shrinker)
 		goto err;
+
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
-			      &workingset_shadow_shrinker);
+			      workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
-	register_shrinker_prepared(&workingset_shadow_shrinker);
+
+	workingset_shadow_shrinker->count_objects = count_shadow_nodes;
+	workingset_shadow_shrinker->scan_objects = scan_shadow_nodes;
+
+	shrinker_register(workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	free_prealloced_shrinker(&workingset_shadow_shrinker);
+	shrinker_free(workingset_shadow_shrinker);
 err:
 	return ret;
 }
-- 
2.30.2

