Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8663A1F02E2
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jun 2020 00:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgFEW2g (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 18:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFEW2g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 18:28:36 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500C2C08C5C2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 15:28:36 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so3228574pjb.0
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILHo7yuysChHmoxEssr6QWh5nqZbeA6bUjdNwlaQ/Ns=;
        b=TGNhcemv+3f//xemRgJQQXdOIhB1TOK1OG5HzfZrFgY3ZVI3K2RbtXVC1e9fLDQA+m
         VVBZ/N9WfGmMfXgrvoYVZTJtQ7LGDXBew4n3h+bB0yAYAfG0ZAg3ElJ8SdHnOINdwgqM
         eXHGoKhccylagTyPCKt3FSCQehAlLzEzBIBpGwN25pyb3BTPh+Zl4mklqe4iHZCFxD4T
         QtshYYFW/ATB31yyyBqbIsL0enAeFLQkum3XZjjBN7dnGltUVphltLZhIlt4ZDTYVZX6
         y/VFYrFH0EWzhtrk7RxcvGUwXrUjjbe8dOSMf//wDN9sRKpI8KdCcq3lH0Nfp2a0kwUQ
         YycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILHo7yuysChHmoxEssr6QWh5nqZbeA6bUjdNwlaQ/Ns=;
        b=lRkn+z3AskOgshe3EB4wLUH7l9vB/BWoGKubIo7n5FEbiSUr41T0h83r9aUXMKFJfT
         I789ztuo71Gg3k14e0e+5Le0gziPfjpivvdnjYE7MLD9Mc5b5p15O2b/VivkV8ZOX0/J
         5vMk7iWP6U+1xRfS7H4Q6DJU39sTNiGp6UBtlh30WQOOJGQaq5f/N2iTTNw/DNqMY6Uy
         +A2LUz3ICqMeSMUzWTuQSijnxwmJXe7HfGKKwreqoc4kBU3s5gxjhmO0UA3/nt5a79+X
         34/0T/Lx9ZMnORYHeO2Ubt0PKQuyiKVxcGzG1oF2ZmFMojkAhXmwYcUenD1V4hgD2VBw
         LOUQ==
X-Gm-Message-State: AOAM530MieQf4x9memDSFjpH7KP3EifRgdf5XAHl0pyz0st7rhGswR7T
        pAM9MWneUmDBykUc5Kb5vUjjDHWF
X-Google-Smtp-Source: ABdhPJzQ9tARjtkLQ6sln0J5o5vZiaCxCsJeHVXy2KhRx5QNSK/QgPjgSlh4KgyZOPv7TGL2MlhC6w==
X-Received: by 2002:a17:90a:bf13:: with SMTP id c19mr4980755pjs.186.1591396115283;
        Fri, 05 Jun 2020 15:28:35 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z20sm8956809pjn.53.2020.06.05.15.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 15:28:34 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: issue aligned discards
Date:   Fri,  5 Jun 2020 15:28:19 -0700
Message-Id: <20200605222819.19762-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ext4 before this patch can issue discards without respecting block
device's discard alignment. Such a discard results in EIO and
kernel logs.

Verified that there were no regressions in xfstests smoke tests.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/mballoc.c      | 32 +++++++++++++++++++++-----------
 include/linux/blkdev.h |  7 +++++++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 30d5d97548c4..a591a3ab93d3 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2786,20 +2786,30 @@ static inline int ext4_issue_discard(struct super_block *sb,
 		ext4_group_t block_group, ext4_grpblk_t cluster, int count,
 		struct bio **biop)
 {
-	ext4_fsblk_t discard_block;
-
-	discard_block = (EXT4_C2B(EXT4_SB(sb), cluster) +
-			 ext4_group_first_block_no(sb, block_group));
-	count = EXT4_C2B(EXT4_SB(sb), count);
+	unsigned long long discard_start, discard_len, alignment, granularity,
+			aligned_discard_start;
+
+	granularity = max(bdev_discard_granularity(sb->s_bdev), 1 << 9);
+	alignment = max_t(int, bdev_logical_block_size(sb->s_bdev),
+			  bdev_discard_alignment(sb->s_bdev));
+	discard_start = (EXT4_C2B(EXT4_SB(sb), cluster) +
+			 ext4_group_first_block_no(sb, block_group)) <<
+			sb->s_blocksize_bits;
+	discard_len = EXT4_C2B(EXT4_SB(sb), count) << sb->s_blocksize_bits;
+	aligned_discard_start = round_up(discard_start, alignment);
+	discard_len -= min(discard_len, aligned_discard_start - discard_start);
+	discard_len = round_down(discard_len, granularity);
+	if (discard_len >> 9 == 0)
+		return 0;
 	trace_ext4_discard_blocks(sb,
-			(unsigned long long) discard_block, count);
-	if (biop) {
+				  aligned_discard_start >> sb->s_blocksize_bits,
+				  discard_len >> (sb->s_blocksize_bits));
+	if (biop)
 		return __blkdev_issue_discard(sb->s_bdev,
-			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
-			(sector_t)count << (sb->s_blocksize_bits - 9),
+			aligned_discard_start >> 9, discard_len >> 9,
 			GFP_NOFS, 0, biop);
-	} else
-		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
+	return sb_issue_discard(sb, aligned_discard_start, discard_len,
+				GFP_NOFS, 0);
 }
 
 static void ext4_free_data_in_buddy(struct super_block *sb,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..f448b3498336 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1431,6 +1431,13 @@ static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector
 	return offset << SECTOR_SHIFT;
 }
 
+static inline int bdev_discard_granularity(struct block_device *bdev)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return q ? q->limits.discard_granularity : 0;
+}
+
 static inline int bdev_discard_alignment(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.27.0.278.ge193c7cf3a9-goog

