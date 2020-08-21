Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4605F24C9BD
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUB4B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgHUBzm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A884C061344
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:41 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q93so251169pjq.0
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qk1QyQp/EHlAlgUoyVynmKWx6LwkC5t8DoDAHkTggKk=;
        b=G8WryVUCMb0evTZIvRRF3+KizEvxY98nsa1N/K7B6PrZ+RJZkIWqI5z6aFFJ03DsoZ
         LigoJcH3q46xF9rBno52wzRbcMC0fczL9y1iKFIqWdoVZ3uZ93Z7t9jzjBPYxja8k9K8
         yE0D3naqed4eO0pjOHhuMTuRxbgORsEcsYDPpz8cEQd3sLIzzAj5QDxJpR2mvK1uwqKp
         ZV9Q3hpVBI3aAffLRDbkec5abyIbDYtIRLCBaPkJnXllKoDU0A8U/+xYA18iFGg2CO9D
         5FtPVCDX/B981hXpZ55xU2MPMWlDaLIqge1HFBTP1CBPHDgVkbZnkbq9vXRFgSG2uNIC
         g0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qk1QyQp/EHlAlgUoyVynmKWx6LwkC5t8DoDAHkTggKk=;
        b=BW75bC52grsVNdefMpmIrZ3bqJx6UkeI39RZKS5MJlkQynVwAcre/8YkURN1aROg7i
         q6O8UeEX6ygyxS6TqGIDdVPBQMB1MCezGLoX1m4e4eUTu+Q2+fiy/jACekbtv2s0e3hF
         H2ANPtMGgDPbBAPyKKY6PLIc6EiihbJweaeP6TJieE75vWOqX2JAtuj26VS+oTlK+89h
         8SNYeZiPXs7oTNDjv1b5eKCTatgW4z3ezqhdYeggJCmSIdQZOOwqt7eyGPoBaRHohE7g
         mI41hCxu/H6c2VgNooNotNrnyPOSNn0PyDgBp3iUt7IxGg0HBlYHpiBINMqjx5hp9/51
         H5RA==
X-Gm-Message-State: AOAM5322DN08RBzHhgBtQf5ThGobJUyZ6q7n0biYeY6kFWxz7Fp08h/6
        NECuHjR+9s+ps2mxhlCS8rIhxxNTJvo=
X-Google-Smtp-Source: ABdhPJyWtNYCibeEvG8mm6AAAQ+S3Mh7ck020M+f8GCfWj7CQOkPD+6TNYWVwH/u4vXP5TX9n4+fGg==
X-Received: by 2002:a17:90a:ce94:: with SMTP id g20mr505845pju.61.1597974940594;
        Thu, 20 Aug 2020 18:55:40 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:39 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v2 9/9] ext4: add freespace trees documentation in code
Date:   Thu, 20 Aug 2020 18:55:23 -0700
Message-Id: <20200821015523.1698374-10-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821015523.1698374-1-harshads@google.com>
References: <20200821015523.1698374-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch adds a comment in mballoc.c describing the design and flow
of free-space trees.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/mballoc.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index eb99e2fb9a68..b5d55a52daff 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -330,6 +330,122 @@
  *        object
  *
  */
+
+/*
+ * The freespace tree allocator
+ * -----------------------------
+ *
+ * High Level Design
+ * =================
+ * This allocator maintains the free space information about the file system in
+ * per-flexible block group level trees. For every flexible block group, we
+ * maintain individual freespace nodes in two trees, one sorted by flex-bg
+ * offset and other sorted by length. This gives us two benefits: i) In
+ * allocation path, our search time complexity is O(Log(Number of freespace
+ * regions in the flex-bg)). ii) In free path, in the same time complexity we
+ * can merge the adjacent nodes thereby reducing the size of the tree
+ * efficiently.
+ *
+ * Along with flexible block group level trees, we also introduce a top level
+ * meta-tree which consists of individual trees. This tree is sorted by length
+ * of largest extents found in flex-bgs. The key advantage that this tree gives
+ * us is this: During an allocation request, the allocator is now able to
+ * consult this tree and directly (in O(Log(Number of Flex BGs)) jump to a
+ * flexible block group which definitely has at least one (the largest) extent
+ * that can satisfy this request. If no flexible block group exists which can
+ * satisfy this request, the allocator can now immediately drop the CR level.
+ *
+ * In order to preseve the parallel allocation / free performance, the allocator
+ * only *tries* to consult this tree. It does so by calling read_trylock()
+ * function and if the meta-tree is busy, the allocator continues its linear
+ * search until it is able to grab a read-lock on this tree.
+ *
+ * Memory Footprint
+ * ================
+ *
+ * In a less fragmented file system, the memory footprint of the new allocator
+ * is significantly lower than buddy bitmaps. However, as the fragmentation
+ * level increases, the memory footprint of this allocator increases
+ * significantly. The memory usage of the freespace tree allocator can be
+ * controlled using sysfs tunable /sys/fs/ext4/<dev>/mb_frsp_max_mem. The
+ * default value of this is max(memory needed for buddy, maximum memory needed
+ * for one tree in the worst case). Accounting for max memory needed for one
+ * tree allows us to keep at least one tree in memory even in the worst
+ * case. This avoids thrashing. Once the memory threshold is reached, the
+ * allocator starts evicting trees from memory in LRU fashion. However, we don't
+ * remove tree's entry from the meta-tree. This allows the allocator to
+ * efficiently reconstruct only relevant trees from on-disk bitmaps. In our
+ * evaluations, we found that freespace tree allocator still manages to
+ * outperform buddy allocator in memory crunch situation.
+ *
+ * LRU
+ * ===
+ *
+ * We maintain two lists - an active list and an inactive list of trees. Trees
+ * in active list stay in it until evicted. In order to reduce contention on the
+ * active list lock, once a tree is in active list it is not moved inside the
+ * list. Also, a tree moves from inactive list to active list only if it is
+ * accessed twice in a EXT4_MB_FRSP_ACTIVE_THRESHOLD_JIFFIES window.
+ *
+ *
+ * Caching Tree Metadata
+ * =====================
+ * As noted in our experiments, we find caching tree metadata (the largest
+ * available extent in a tree) in the meta-tree significantly boosts allocation
+ * performance. However, if the allocator waits for the cache to fill up before
+ * starting to serve allocation requests, that may severely degrade allocation
+ * performance on large disks. Thus, it is important to tune the tree caching
+ * behavior according to the underlying block device. This patchset provides
+ * four cache aggression levels. Cache aggression level can be specified as a
+ * mount time parametere "frsp_cache_aggression". Here is the meaning of these
+ * different levels:
+ *
+ * Cache Aggression 0: Try to serve request only cached trees
+ * Cache Aggression 1 (Default): Try to serve request from only cached trees
+ *	at CR 0. At all other CRs, try to use an uncached tree for every
+ *	alternate request.
+ * Cache Aggression 2: Try to use an uncached tree for every alternate request
+ *	at all CR levels.
+ * Cache Aggression 3: Try to use uncached trees for every request.
+ *
+ * Moreover, if file system is mounted with "prefetch_block_bitmaps", tree
+ * caching starts at mount time.
+ *
+ * Locking Order
+ * =============
+ *
+ * - Tree lock
+ * - Meta tree lock (sbi->s_mb_frsp_lock)
+ * - LRU lock
+ *
+ * Critical sections of meta-tree lock and LRU locks are kept as small as
+ * possible and you shouldn't need to take meta-tree lock and lru-lock
+ * simultaneously.
+ *
+ * High Level Algorithm
+ * ====================
+ * - Consult meta-tree asking which flex-bg should the allocator look at
+ *   - One of the following things can happen
+ *     - Meta tree may find a suitable flex-bg for the request
+ *        - In this case we start searching in that tree
+ *     - Meta tree may realize that there's no suitable flex-bg
+ *        - In this case we increase CR and restart
+ *     - Based on the caching mode, meta tree may redirect us to an
+ *       uncached tree
+ *     - Meta tree is busy
+ *       - In this case, we dont wait for meta-tree to become available,
+ *         instead, we continue our search linearly.
+ * - Pick a tree (either based on what meta-tree told us or linearly from the
+ *   last one)
+ * - Manage LRU structure (ext4_mb_frsp_maintain_lru())
+ *   - Move tree to active list if needed
+ *   - Move trees from active list to inactive lists if needed
+ * - Perform search by length and pick matching extents.
+ * - Repeat until best found
+ * - Perform memory-crunch check and evict trees in LRU fashion if needed
+ *   (ext4_mb_unload_allocator()))
+ */
+
 static struct kmem_cache *ext4_pspace_cachep;
 static struct kmem_cache *ext4_ac_cachep;
 static struct kmem_cache *ext4_free_data_cachep;
-- 
2.28.0.297.g1956fa8f8d-goog

