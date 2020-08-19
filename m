Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D424249780
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHSHbw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHSHba (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Aug 2020 03:31:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC65C061347
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c10so792215pjn.1
        for <linux-ext4@vger.kernel.org>; Wed, 19 Aug 2020 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73oeTFMOiyS//4pFDHN5uXIQNvxmtlBh7uXWl0z1oKU=;
        b=O5LbfLtviKsdyMGGQuD6Uot3f6exAlYyo2kSrKg4RJmQGMzV4zfil2bcAVxp1HLEeA
         PtAs2ssL+G5SRRp5BZCvKj4zLc2Iwakhu5Z0VjkPxljrTktqPVaJwlUTx+DvfpcEBWjr
         R9OMXW0E/jgT22PtLKw4IGwj//kHIQ3O32LQKmFKtVLoxh2/DS0CnbBzcuHO2piJgACw
         /NfuO5g+Q9C8PczATrVXzZy2PC7xwB6QSLtMHOCcHrD97ov/hAbsZpniEwz6G9RSG7/c
         x9HXX7tXfRMK7Qn75BfYh4XGZtlDU2cRcvuMrSBuWoPZmPU9rhRKoCsBAl2Hu1lr3jq+
         i15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73oeTFMOiyS//4pFDHN5uXIQNvxmtlBh7uXWl0z1oKU=;
        b=sZaLG1AM02M/A20Up9WemRjmVa7PmxIA+E/4SRpLKYY+qjjsLj7YDs7mGBFjvEl1Ki
         cNsZQY1KiiCaUuwV1sKJz+qvDsznpgzo/N/cop2fcWhf8beU0jzlGbzs/U/vnKlcN/B+
         NTg1KJEESTcHx8fLmBAuIxE5yIhAz9yBzP3yaVfvFTKeJRgIrWDPhoK7cKZqOjUDXA2l
         wWA9tjHnWRAfcPIdIMOQPwFSCtYdEq/tLtxnUcWHr2zugio74YUFeAUQmmGguVGE1J2P
         ytJYL21FIkZCq7tx8Wa6oIRfZvNYrZBMeu4WC3sv1P359jFCqOdYGV2Y//dN/2denozV
         V7fg==
X-Gm-Message-State: AOAM532IDh5vttf06uCtT+Tp1n54pzj9MqdjFkkSZnvFYC/aul4BclhW
        /xy9jpDeZjvVM5OK9hNBV7pDbljuXVE=
X-Google-Smtp-Source: ABdhPJxtIaZOsRH4CvDq9rhrYJXdp3HDI2pcfzW5JBj77zqZIDRqBln0dmLyWbykXI/P7oZJgpZ43w==
X-Received: by 2002:a17:902:8d8d:: with SMTP id v13mr3827859plo.110.1597822288173;
        Wed, 19 Aug 2020 00:31:28 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id q6sm2040019pjr.20.2020.08.19.00.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:31:26 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 9/9] ext4: add freespace trees documentation in code
Date:   Wed, 19 Aug 2020 00:31:04 -0700
Message-Id: <20200819073104.1141705-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
References: <20200819073104.1141705-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds a comment in mballoc.c describing the design and flow
of free-space trees.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/mballoc.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b9a833341b98..644df0bf61ee 100644
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
2.28.0.220.ged08abb693-goog

