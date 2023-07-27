Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF9764B21
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 10:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjG0IOJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjG0INo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 04:13:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D4D4683
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:08:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-767c5371ea3so11221185a.0
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445255; x=1691050055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQ2nJ797AaeiRC4tEbuFSwr/qroaEGD64TBkJX9gwcc=;
        b=hA1tLAWfG9E5lMYpiq31/rYnltLY2UCcKbUgiSnCT1E8X8kGoiYDuivuIXgGbNns6i
         rsO7OAKzrpoY/t3vXOZgk1fvXy/+glUW8j30sofzfP0QuNA4YNuHX0B3/wn/NlRfmmSp
         hK0N8lK0Vwhq0nUugZ8ycZKnaI5f1t5XqZDHcuhBMCyVGepXB3V/BSg7xy9+NSg2yF7l
         nvfFuhUDIV8bXN8mU/xg9a+bQYVrjpniBQXAE8i2q/rQWra4Kk9vlLOzfIzbvpxVTD4N
         dWfbnruA2iD8hNEqFED+TEFzL1fLXBGGAp+wY2U5Eafq/09DQVh/cuCBggDq6VzN1EVA
         wnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445255; x=1691050055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQ2nJ797AaeiRC4tEbuFSwr/qroaEGD64TBkJX9gwcc=;
        b=A5k7WqEYzRK9RHEb3Dy2HkbT2rrTJHWK9DofGJHePhSqjUmzhIvuYx49I+PHzKKuJO
         Ze4RpCEVOr8mQwQY3Mm0RZJqcGEusWJkVcBlGNEUXv6JUPhGHugIeJO7jopyDPdVaWUL
         BxDwGFqJPOTclzlrqqbq1INN1616tFOctjX5wl3/fMJ25Nr0cGR2ayVLnbknPewiefbk
         6eheCBAp4FPdE73Q8PTMZm/2CDXE25/8VBOBMPTT2g3o/8W7BP8KPxYwjFWwjndl5+So
         nG1lKZV4TBD93OpfOGsRdNsBvd/UkAX/w2eqZtCfMgAHqupP37865saT5Q5kkp77j8/E
         EFjg==
X-Gm-Message-State: ABy/qLbeWAILqeyLXwEQ8lGi7lVXwQ5XhwFc/iXhQETiYYNvKoeuqowY
        3loadl1/NHCRPjIDc2pSEdLvqy3axCJfZaaccng=
X-Google-Smtp-Source: APBJJlExJjCwBoW4B5netumBOqdfs5+SJLDXxiJ/1dno6haNjCE+wUan/A+nwEsop7KuM9iLlMTgjA==
X-Received: by 2002:a05:6a20:918e:b0:11a:dbb3:703b with SMTP id v14-20020a056a20918e00b0011adbb3703bmr5540739pzd.6.1690445233998;
        Thu, 27 Jul 2023 01:07:13 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:07:13 -0700 (PDT)
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
Subject: [PATCH v3 07/49] binder: dynamically allocate the android-binder shrinker
Date:   Thu, 27 Jul 2023 16:04:20 +0800
Message-Id: <20230727080502.77895-8-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the android-binder shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/android/binder_alloc.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e3db8297095a..62675cedd38e 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1053,11 +1053,7 @@ binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 			    NULL, sc->nr_to_scan);
 }
 
-static struct shrinker binder_shrinker = {
-	.count_objects = binder_shrink_count,
-	.scan_objects = binder_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *binder_shrinker;
 
 /**
  * binder_alloc_init() - called by binder_open() for per-proc initialization
@@ -1077,19 +1073,30 @@ void binder_alloc_init(struct binder_alloc *alloc)
 
 int binder_alloc_shrinker_init(void)
 {
-	int ret = list_lru_init(&binder_alloc_lru);
+	int ret;
 
-	if (ret == 0) {
-		ret = register_shrinker(&binder_shrinker, "android-binder");
-		if (ret)
-			list_lru_destroy(&binder_alloc_lru);
+	ret = list_lru_init(&binder_alloc_lru);
+	if (ret)
+		return ret;
+
+	binder_shrinker = shrinker_alloc(0, "android-binder");
+	if (!binder_shrinker) {
+		list_lru_destroy(&binder_alloc_lru);
+		return -ENOMEM;
 	}
-	return ret;
+
+	binder_shrinker->count_objects = binder_shrink_count;
+	binder_shrinker->scan_objects = binder_shrink_scan;
+	binder_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(binder_shrinker);
+
+	return 0;
 }
 
 void binder_alloc_shrinker_exit(void)
 {
-	unregister_shrinker(&binder_shrinker);
+	shrinker_free(binder_shrinker);
 	list_lru_destroy(&binder_alloc_lru);
 }
 
-- 
2.30.2

