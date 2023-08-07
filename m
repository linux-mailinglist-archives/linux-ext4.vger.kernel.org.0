Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F4772183
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjHGLWm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjHGLWT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 07:22:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8D849CF
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 04:19:47 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-760dff4b701so48618139f.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Aug 2023 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407130; x=1692011930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPvD0YF4yF0E/V3NMttF7YVdRMfLZcl9Qmy2whUD9jE=;
        b=Yg6a4S6mehHXIhA/E3Q0PULlhTuWFJSC8SWG/ILCbhPqbGJ8U3cHU65QLviP2uhCSR
         ke987jNZWT+a3VbYt/P1DUgM9FD1wtLVWjs4YqGi7wL9UN969N//fjHu7Rkuacu1ZEbO
         sFeuYSBirj1vU6Aez3+cRli6rr3FzSuKOsTGD5nakrWuQB36WrjrtJxQeYSa4UmVVrMq
         tEjrzN2rUSVI2KnkxDKKadqug/diUuotXTrmPvHlIfn7KMnJ2N4ofpYCVZnDktG3/MfP
         H/JiYp2ayTwMbJS4oFbWPQmVfg6fAwDGd0yXBB9tmAfXes07FpCOwOtAU5/rDHZG4Tu+
         oWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407130; x=1692011930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPvD0YF4yF0E/V3NMttF7YVdRMfLZcl9Qmy2whUD9jE=;
        b=Y7H+AJrBcs1k3e2M/qAYuGKtv93XlK+Ro0Fb1Mof0eN/E/mlUfQqoAotDLG24MwBo6
         MXTrctMHEiEhQAxMA7JMDE6/LTWcqQetg9DKANGwhtJudfVLLn0FhE9EG1h/tJmjIGlm
         wrub5h3ItfT5GjC9zO5+Rr864xww66DNIc+j2Rt/7yxiQwp/jHwMrxft4APYKhao4MjQ
         guFOsoGTpn4J5QZhWF3iUFXcOJNib1Kl/lD4UE57/buWgj+WvJ+owoS1h7gdw+iNm/N9
         7QaXPqvuVSbf73z2eaVFCukLtyBByr+Wd0XLZvUzVeCJPjCelJqt1BjgoH1ZHZR+S9/r
         U8OA==
X-Gm-Message-State: AOJu0Yy65DMGhQ+mRRGWcXjSYxTHX3Tf4qKPbKfjeketKwPBfW+QjbmW
        4zyXOPD4/hS3XpyylAI15tdD/51uf3OqzkwQItg=
X-Google-Smtp-Source: APBJJlFnoOazdp9TvNa1Sdutczsv0h+KjLn+q+TQByEK163E+9f/k1cC7rmChP+7R75WsTDRsF4HxQ==
X-Received: by 2002:a17:90a:901:b0:268:3a31:3e4d with SMTP id n1-20020a17090a090100b002683a313e4dmr23078917pjn.2.1691407109946;
        Mon, 07 Aug 2023 04:18:29 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:18:29 -0700 (PDT)
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 40/48] zsmalloc: dynamically allocate the mm-zspool shrinker
Date:   Mon,  7 Aug 2023 19:09:28 +0800
Message-Id: <20230807110936.21819-41-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the mm-zspool shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct zs_pool.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/zsmalloc.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b58f957429f0..1909234bb345 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -229,7 +229,7 @@ struct zs_pool {
 	struct zs_pool_stats stats;
 
 	/* Compact classes */
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
@@ -2086,8 +2086,7 @@ static unsigned long zs_shrinker_scan(struct shrinker *shrinker,
 		struct shrink_control *sc)
 {
 	unsigned long pages_freed;
-	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
-			shrinker);
+	struct zs_pool *pool = shrinker->private_data;
 
 	/*
 	 * Compact classes and calculate compaction delta.
@@ -2105,8 +2104,7 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 	int i;
 	struct size_class *class;
 	unsigned long pages_to_free = 0;
-	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
-			shrinker);
+	struct zs_pool *pool = shrinker->private_data;
 
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
@@ -2121,18 +2119,24 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 
 static void zs_unregister_shrinker(struct zs_pool *pool)
 {
-	unregister_shrinker(&pool->shrinker);
+	shrinker_free(pool->shrinker);
 }
 
 static int zs_register_shrinker(struct zs_pool *pool)
 {
-	pool->shrinker.scan_objects = zs_shrinker_scan;
-	pool->shrinker.count_objects = zs_shrinker_count;
-	pool->shrinker.batch = 0;
-	pool->shrinker.seeks = DEFAULT_SEEKS;
+	pool->shrinker = shrinker_alloc(0, "mm-zspool:%s", pool->name);
+	if (!pool->shrinker)
+		return -ENOMEM;
+
+	pool->shrinker->scan_objects = zs_shrinker_scan;
+	pool->shrinker->count_objects = zs_shrinker_count;
+	pool->shrinker->batch = 0;
+	pool->shrinker->seeks = DEFAULT_SEEKS;
+	pool->shrinker->private_data = pool;
 
-	return register_shrinker(&pool->shrinker, "mm-zspool:%s",
-				 pool->name);
+	shrinker_register(pool->shrinker);
+
+	return 0;
 }
 
 static int calculate_zspage_chain_size(int class_size)
-- 
2.30.2

