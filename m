Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACF4764B81
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 10:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjG0IP1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbjG0IOW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 04:14:22 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4EF526F
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:09:18 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686f6231bdeso112656b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445296; x=1691050096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAY9+N2BbVQBjCT3MmFWkPxUR/2vf6o4m+CtMBoAzag=;
        b=LFYvlia4velFDizk2hHXlBW7f/l7rbfbGMuqLFZUpWLlBrVWlN4fEmfbvc4omxzXDA
         GS62NEHVqB0PFgv0flEq3EjMDASyoMQLwnHtJ15RD867cmoYFSzpLBJze2MH0FTuVYWD
         NsiHc1gWK/drytRuk+pd4JkJ3rj2hRu9B8SocS/OtbfY5xFfSOGukZMVRW73BQpYmdrG
         /5Ymr320vt1GGeIXCFFSw58+k2f5zcvch0LSG0bHy5CbC3AFLqLQjQMF/E7WQcKZk1m8
         rvHs1btuYuzdVvuVmWOj+XioQ9BrFWnwjxo07/zHn9Dajw02v1LQ6Dr1U7VOL/6BCiXk
         S4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445296; x=1691050096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAY9+N2BbVQBjCT3MmFWkPxUR/2vf6o4m+CtMBoAzag=;
        b=AH/DsgS25jr138zR07WSWMhyz4bCUp1SZeamhm4M+MMtuUqhJz1I89UlEtJ8i3XZqX
         45yvB1ExVS5rc25fcwRKOSL4HjGQOClte9IJ/CCx+m7krxD0xVuVl9unMHwbaCHIPS7H
         CzXj1RJ6Z4ym2r6HR7l3ndpurm56SrZGa4FJAFJdf/EZUVlCT8OCixRZU8JFPmOAykEA
         7APjdHRKrE9i8HTLgnbZnOanHmNGD8mDTJocTDVZoCo4pqRFvpQzt8DoGjSHgC+e7bkv
         aeweMbAsfnCIEXTPDG4w9Pa6fXwH/d6lXat17WdGY16y83q9pW+ixW98ndHWBgm6Ft8R
         3+3A==
X-Gm-Message-State: ABy/qLZwcoJJTq2GYnpNRV60EqYfSew+fcdxv/v4FPAJTanB9OXPH2eZ
        ivKglKnqHe6E/86DhYs7shpNsg==
X-Google-Smtp-Source: APBJJlFXIDspBDKYt+edW+ekZSGIMkDEJizocNVTOvlzV7xMQBKW4TeDX8VYOaL7MgnXn0ggLAa8Tw==
X-Received: by 2002:a05:6a00:1586:b0:67f:8ef5:2643 with SMTP id u6-20020a056a00158600b0067f8ef52643mr5200829pfk.2.1690445296182;
        Thu, 27 Jul 2023 01:08:16 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:08:15 -0700 (PDT)
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
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 12/49] gfs2: dynamically allocate the gfs2-glock shrinker
Date:   Thu, 27 Jul 2023 16:04:25 +0800
Message-Id: <20230727080502.77895-13-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the gfs2-glock shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/gfs2/glock.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1438e7465e30..8d582ba7514f 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2046,11 +2046,7 @@ static unsigned long gfs2_glock_shrink_count(struct shrinker *shrink,
 	return vfs_pressure_ratio(atomic_read(&lru_count));
 }
 
-static struct shrinker glock_shrinker = {
-	.seeks = DEFAULT_SEEKS,
-	.count_objects = gfs2_glock_shrink_count,
-	.scan_objects = gfs2_glock_shrink_scan,
-};
+static struct shrinker *glock_shrinker;
 
 /**
  * glock_hash_walk - Call a function for glock in a hash bucket
@@ -2472,13 +2468,19 @@ int __init gfs2_glock_init(void)
 		return -ENOMEM;
 	}
 
-	ret = register_shrinker(&glock_shrinker, "gfs2-glock");
-	if (ret) {
+	glock_shrinker = shrinker_alloc(0, "gfs2-glock");
+	if (!glock_shrinker) {
 		destroy_workqueue(glock_workqueue);
 		rhashtable_destroy(&gl_hash_table);
-		return ret;
+		return -ENOMEM;
 	}
 
+	glock_shrinker->count_objects = gfs2_glock_shrink_count;
+	glock_shrinker->scan_objects = gfs2_glock_shrink_scan;
+	glock_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(glock_shrinker);
+
 	for (i = 0; i < GLOCK_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(glock_wait_table + i);
 
@@ -2487,7 +2489,7 @@ int __init gfs2_glock_init(void)
 
 void gfs2_glock_exit(void)
 {
-	unregister_shrinker(&glock_shrinker);
+	shrinker_free(glock_shrinker);
 	rhashtable_destroy(&gl_hash_table);
 	destroy_workqueue(glock_workqueue);
 }
-- 
2.30.2

