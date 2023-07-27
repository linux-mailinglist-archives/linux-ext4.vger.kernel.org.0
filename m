Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DD764C1B
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jul 2023 10:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjG0IU7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jul 2023 04:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjG0ISK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jul 2023 04:18:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796622D56
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:10:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-66d6a9851f3so167941b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jul 2023 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445381; x=1691050181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSWsN00ewH1CUxuL2on0amogNZtYjpfZMPk3tXk1MLc=;
        b=Uigp99md2Rr3CXBoApAa/OORnqo8B1J7RivQ80kk84PuD/8/0U/wiHIiPqvPSjzBq+
         4mgkiCdsVsAk9/e2muldWgdoE75BspngFHkVey9mAlq6MnrgeN5Z2UVnZxuIj86jdS6R
         rAWjfbsFjXDEfm8YOidjdqca7DNptBkelH0HrT7nXcdFtSlvKmDtxqUQOqWjbYzyZulg
         AN7Mzxd848XhJE6ClueXrvuJZWX5X85+XT80LyTl5276AdX2DnTvKQaDsxfVQAKr1XxX
         WaB1fRqts+Skr4BpFNBdK0X00kCFzaVEUe4nziyxeBmy6RtpnTKoOQLFGVCxxQosoZyC
         4x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445381; x=1691050181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSWsN00ewH1CUxuL2on0amogNZtYjpfZMPk3tXk1MLc=;
        b=SeyPew++jRHlPXzAL7Ga2SeZMuD/fg+D1bT02jcVjklmDdeNbkQnLqOqxRibYiAMiZ
         6ox5BCO6XVUB9eO2ax1s8onVy1bh5SxXOikwWlhyk5XkA0hFGytnXcmT7hpws80kh2A7
         yA91+C02ivFaAhbp3r6b3ZqKxTQdOF7Ad+aoQj8cwlahMzG4j97OKk0gLPhhQNgnZOQo
         4wfFfebR23A4dDAC6vLyrQqWRXngnS16BclbbCqJVJ5LtkoA6em4L3G5++0tAOxeOBHn
         b4yr4+ASRDnBxl3j4jyPAm6SOY7S1nPt1NUsOersgArrRNNSyGeDOLBwfJkgKmmuBDbk
         UK6A==
X-Gm-Message-State: ABy/qLZWiR3ykNV4I/Tc7u3xdRWi/eM1yhVtq6YrAmdP4FEYhx5vkcS7
        4yL9H6Te0xFmqB5eR+1PvuZcUA==
X-Google-Smtp-Source: APBJJlHVjyqYSo1ak3Z7chV1yhtxMPzG2+b/e8BLYdWQhXdIbtZlkhi04HlfYJAG9z5TWY/X++2RBQ==
X-Received: by 2002:a05:6a20:729a:b0:100:b92b:e8be with SMTP id o26-20020a056a20729a00b00100b92be8bemr5576237pzk.2.1690445381598;
        Thu, 27 Jul 2023 01:09:41 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:09:41 -0700 (PDT)
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
Subject: [PATCH v3 19/49] rcu: dynamically allocate the rcu-lazy shrinker
Date:   Thu, 27 Jul 2023 16:04:32 +0800
Message-Id: <20230727080502.77895-20-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the rcu-lazy shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 kernel/rcu/tree_nocb.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 5598212d1f27..e1c59c33738a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1396,13 +1396,6 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 	return count ? count : SHRINK_STOP;
 }
-
-static struct shrinker lazy_rcu_shrinker = {
-	.count_objects = lazy_rcu_shrink_count,
-	.scan_objects = lazy_rcu_shrink_scan,
-	.batch = 0,
-	.seeks = DEFAULT_SEEKS,
-};
 #endif // #ifdef CONFIG_RCU_LAZY
 
 void __init rcu_init_nohz(void)
@@ -1410,6 +1403,7 @@ void __init rcu_init_nohz(void)
 	int cpu;
 	struct rcu_data *rdp;
 	const struct cpumask *cpumask = NULL;
+	struct shrinker * __maybe_unused lazy_rcu_shrinker;
 
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
@@ -1436,8 +1430,16 @@ void __init rcu_init_nohz(void)
 		return;
 
 #ifdef CONFIG_RCU_LAZY
-	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
-		pr_err("Failed to register lazy_rcu shrinker!\n");
+	lazy_rcu_shrinker = shrinker_alloc(0, "rcu-lazy");
+	if (!lazy_rcu_shrinker) {
+		pr_err("Failed to allocate lazy_rcu shrinker!\n");
+	} else {
+		lazy_rcu_shrinker->count_objects = lazy_rcu_shrink_count;
+		lazy_rcu_shrinker->scan_objects = lazy_rcu_shrink_scan;
+		lazy_rcu_shrinker->seeks = DEFAULT_SEEKS;
+
+		shrinker_register(lazy_rcu_shrinker);
+	}
 #endif // #ifdef CONFIG_RCU_LAZY
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-- 
2.30.2

