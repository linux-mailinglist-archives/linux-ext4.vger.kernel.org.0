Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD575F283
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 12:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjGXKQF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 06:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjGXKPw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 06:15:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EFA46B9
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 03:07:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6748a616e17so1152895b3a.1
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 03:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690193251; x=1690798051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPgx5tx5pugTz0d6jibfzfGw2xSKE+ix47CgP1Qw/g4=;
        b=IuTWU48sZ3Vdk58peKD18ScPmFy4INqw1l2SIbXqKwHV78G79g0V5MJeIfs+wTZ8bV
         VExXj4TMdD/kyrtgBbNaqb9KDXSwpnGsvJMhVPrYl0p2g8xjY+bNG/N14y/3vJ/3PepM
         LB6gVZvgech3gpXUesCrHVlv5hYc3rZlHvEvajZbnWHjaFQspMMA36RIyVY4Y4V3TLyi
         17Rfhf8gfIi3nNeL4olDOH5jnRhHCg4JoWOuUDcShwpQZqaubyBT+LTCkX7efqqL05TC
         NvsUDNFOhnmxQmFo9/hlA2tqO+K+epgBeT/OzaOmniRjcoN3GLMxAqSQz0wV3fO6ElFF
         Xt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193251; x=1690798051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPgx5tx5pugTz0d6jibfzfGw2xSKE+ix47CgP1Qw/g4=;
        b=JaFYoifzkyqCfbKRXIkr//r6RS5VynXg95EppuQBQHZH9b9xfNMN2AMFL0W/Z1jVcl
         oWPCZl4jgzOkuiFd5JArjV531AH/rUcaN3kEqLK0CJExzpoJcWDKUZyoxbmcgkHiSxOn
         Q3XHJ/fD46f/Mq7UnN3gg7UO7XK0HvPurunZUab1mldrBKkvNn9Ak8ECieOZ4IHsSFoL
         8v8d91WFc5/ZLufjD7aA5SplyS+VwqTQdl5qZtQcrnsG3KMLw/rD4dejVJZ95T60p4Ut
         5KahZVKWY5j9XOVoPgQdeOjO6Uedn/b2DclMUjOLxK+yz/RJc1JRjanLfsEPR1DF4u9u
         qMWg==
X-Gm-Message-State: ABy/qLZppxVduMXMDJY37n/15rOYNACXSGHZmFVoU1EZUXrcqjYByP1A
        UA2XiyB+A5OnvZwOwoOa/TKeEA==
X-Google-Smtp-Source: APBJJlHNherDqZFzA7p7tcMEc26kiZZ4z0G58iklJcv127ghy/RIpJQTR76k3+Vr6OIbO3Et5X/b8Q==
X-Received: by 2002:a17:903:2305:b0:1b8:b0c4:2e3d with SMTP id d5-20020a170903230500b001b8b0c42e3dmr12244115plh.4.1690192182555;
        Mon, 24 Jul 2023 02:49:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:49:42 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
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
Subject: [PATCH v2 23/47] drm/msm: dynamically allocate the drm-msm_gem shrinker
Date:   Mon, 24 Jul 2023 17:43:30 +0800
Message-Id: <20230724094354.90817-24-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the drm-msm_gem shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct msm_drm_private.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/gpu/drm/msm/msm_drv.c          |  4 ++-
 drivers/gpu/drm/msm/msm_drv.h          |  4 +--
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 36 ++++++++++++++++----------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 891eff8433a9..7f6933be703f 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -461,7 +461,9 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	if (ret)
 		goto err_msm_uninit;
 
-	msm_gem_shrinker_init(ddev);
+	ret = msm_gem_shrinker_init(ddev);
+	if (ret)
+		goto err_msm_uninit;
 
 	if (priv->kms_init) {
 		ret = priv->kms_init(ddev);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index e13a8cbd61c9..84523d4a1e58 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -217,7 +217,7 @@ struct msm_drm_private {
 	} vram;
 
 	struct notifier_block vmap_notifier;
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 
 	struct drm_atomic_state *pm_state;
 
@@ -279,7 +279,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 unsigned long msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_to_scan);
 #endif
 
-void msm_gem_shrinker_init(struct drm_device *dev);
+int msm_gem_shrinker_init(struct drm_device *dev);
 void msm_gem_shrinker_cleanup(struct drm_device *dev);
 
 int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index f38296ad8743..7daab1298c11 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -34,8 +34,7 @@ static bool can_block(struct shrink_control *sc)
 static unsigned long
 msm_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct msm_drm_private *priv =
-		container_of(shrinker, struct msm_drm_private, shrinker);
+	struct msm_drm_private *priv = shrinker->private_data;
 	unsigned count = priv->lru.dontneed.count;
 
 	if (can_swap())
@@ -100,8 +99,7 @@ active_evict(struct drm_gem_object *obj)
 static unsigned long
 msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
-	struct msm_drm_private *priv =
-		container_of(shrinker, struct msm_drm_private, shrinker);
+	struct msm_drm_private *priv = shrinker->private_data;
 	struct {
 		struct drm_gem_lru *lru;
 		bool (*shrink)(struct drm_gem_object *obj);
@@ -148,10 +146,11 @@ msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_to_scan)
 	struct shrink_control sc = {
 		.nr_to_scan = nr_to_scan,
 	};
-	int ret;
+	unsigned long ret = SHRINK_STOP;
 
 	fs_reclaim_acquire(GFP_KERNEL);
-	ret = msm_gem_shrinker_scan(&priv->shrinker, &sc);
+	if (priv->shrinker)
+		ret = msm_gem_shrinker_scan(priv->shrinker, &sc);
 	fs_reclaim_release(GFP_KERNEL);
 
 	return ret;
@@ -210,16 +209,27 @@ msm_gem_shrinker_vmap(struct notifier_block *nb, unsigned long event, void *ptr)
  *
  * This function registers and sets up the msm shrinker.
  */
-void msm_gem_shrinker_init(struct drm_device *dev)
+int msm_gem_shrinker_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
-	priv->shrinker.count_objects = msm_gem_shrinker_count;
-	priv->shrinker.scan_objects = msm_gem_shrinker_scan;
-	priv->shrinker.seeks = DEFAULT_SEEKS;
-	WARN_ON(register_shrinker(&priv->shrinker, "drm-msm_gem"));
+
+	priv->shrinker = shrinker_alloc(0, "drm-msm_gem");
+	if (!priv->shrinker) {
+		WARN_ON(1);
+		return -ENOMEM;
+	}
+
+	priv->shrinker->count_objects = msm_gem_shrinker_count;
+	priv->shrinker->scan_objects = msm_gem_shrinker_scan;
+	priv->shrinker->seeks = DEFAULT_SEEKS;
+	priv->shrinker->private_data = priv;
+
+	shrinker_register(priv->shrinker);
 
 	priv->vmap_notifier.notifier_call = msm_gem_shrinker_vmap;
 	WARN_ON(register_vmap_purge_notifier(&priv->vmap_notifier));
+
+	return 0;
 }
 
 /**
@@ -232,8 +242,8 @@ void msm_gem_shrinker_cleanup(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 
-	if (priv->shrinker.nr_deferred) {
+	if (priv->shrinker) {
 		WARN_ON(unregister_vmap_purge_notifier(&priv->vmap_notifier));
-		unregister_shrinker(&priv->shrinker);
+		shrinker_unregister(priv->shrinker);
 	}
 }
-- 
2.30.2

