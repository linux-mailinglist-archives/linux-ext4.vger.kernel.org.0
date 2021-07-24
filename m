Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB83D4610
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jul 2021 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhGXHCa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Jul 2021 03:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhGXHC2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Jul 2021 03:02:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F35C061575;
        Sat, 24 Jul 2021 00:42:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id hg12-20020a17090b300cb02901736d9d2218so6878173pjb.1;
        Sat, 24 Jul 2021 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+8jOKRZmQMCdrfOlpXrFMEMD9tZL0fkRvum4Z+ZZ28=;
        b=Rla2j14K2jgFE8weYvlRRimJ/kzmEoz3nje0dPDyeM769uP63jftRcDN9U/ifiQTFC
         cvThEQulX0CGbGd/VgviK8O+1OrE/2eaeXhFtWH5lry+P3rDxq5Sf0HzWQUXiUPzwohE
         LmrMLp0t7UlUvux7P/fx31+aA5WsohmJzIirXNssTNrkCamzQUUo3ZXUaAwjXBntLskk
         PZyaHbnw4+I4720J1WYWqiw4/Fn32CRQrHsqJGVPFMP2bsYovBJxMlLo0L1vhvWzOW0d
         3FOgT25yhQh6WOdaVlJ3djRoCYN4F9mk6ZEVg/VgIaDzSsF7M666IGISTUoKQ2E0eef8
         9b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+8jOKRZmQMCdrfOlpXrFMEMD9tZL0fkRvum4Z+ZZ28=;
        b=XdpU3qhDhKocXNSe2xPumXYykJzKb6Q7YQYXXd27Nto9PtvBY7KnknepPQUWetDNUh
         UmYN0lfetnwZ6sS7YF/35fGQA+kzG7AGrRnFdrNytjeV6TqSE6zNs2T/Pvk23tYYgLqd
         +gAUiIqqz7CKyN/EEL7zfS9W3fTCSrYOf4ARhqCCJCfRLSf3eG4yCO0NIGo2MCFQe6N/
         CTjpCfilkjyON8QVGAMOiYS//aKZEFoFQaO5tqIDzgFg8rTbxyfQy2fioJNyLX2If0R7
         Lsbyvabj/uyg9ZeLgqOARtDjmzhC9keN3EuSrbyCEiKNnfnMMBopV8jFuMDIFd+ZHLVK
         HDmg==
X-Gm-Message-State: AOAM531zGW6Tmr9narultuPG79AecMKLzWrm3LnrW2KpnFHdWanPSu21
        k9Tr4QIOtzITbFRpighDPtvcLC2SP+CHCQ==
X-Google-Smtp-Source: ABdhPJxMTew83suCeIJRy6nziKgUDRU3sBThLfm983msd7EG2fpiCjcQrUyXzcc67wJ/vrhjVh2xRA==
X-Received: by 2002:a17:90a:728d:: with SMTP id e13mr8103943pjg.181.1627112579062;
        Sat, 24 Jul 2021 00:42:59 -0700 (PDT)
Received: from localhost.localdomain ([154.86.159.244])
        by smtp.gmail.com with ESMTPSA id v31sm33002342pgl.49.2021.07.24.00.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 00:42:58 -0700 (PDT)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Subject: [PATCH V3 2/5] ext4: add new helper interface ext4_try_to_trim_range()
Date:   Sat, 24 Jul 2021 15:41:21 +0800
Message-Id: <20210724074124.25731-3-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210724074124.25731-1-jianchao.wan9@gmail.com>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

There is no functional change in this patch but just split the
codes, which serachs free block and does trim, into a new function
ext4_try_to_trim_range. This is preparing for the following async
backgroup discard.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 fs/ext4/mballoc.c | 102 ++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 018d5d3c6eeb..e3844152a643 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6218,6 +6218,54 @@ __acquires(bitlock)
 	return ret;
 }
 
+static int ext4_try_to_trim_range(struct super_block *sb,
+		struct ext4_buddy *e4b, ext4_grpblk_t start,
+		ext4_grpblk_t max, ext4_grpblk_t minblocks)
+{
+	ext4_grpblk_t next, count, free_count;
+	void *bitmap;
+	int ret = 0;
+
+	bitmap = e4b->bd_bitmap;
+	start = (e4b->bd_info->bb_first_free > start) ?
+		e4b->bd_info->bb_first_free : start;
+	count = 0;
+	free_count = 0;
+
+	while (start <= max) {
+		start = mb_find_next_zero_bit(bitmap, max + 1, start);
+		if (start > max)
+			break;
+		next = mb_find_next_bit(bitmap, max + 1, start);
+
+		if ((next - start) >= minblocks) {
+			ret = ext4_trim_extent(sb, start, next - start, e4b);
+			if (ret && ret != -EOPNOTSUPP)
+				break;
+			ret = 0;
+			count += next - start;
+		}
+		free_count += next - start;
+		start = next + 1;
+
+		if (fatal_signal_pending(current)) {
+			count = -ERESTARTSYS;
+			break;
+		}
+
+		if (need_resched()) {
+			ext4_unlock_group(sb, e4b->bd_group);
+			cond_resched();
+			ext4_lock_group(sb, e4b->bd_group);
+		}
+
+		if ((e4b->bd_info->bb_free - free_count) < minblocks)
+			break;
+	}
+
+	return count;
+}
+
 /**
  * ext4_trim_all_free -- function to trim all free space in alloc. group
  * @sb:			super block for file system
@@ -6241,10 +6289,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
 		   ext4_grpblk_t minblocks)
 {
-	void *bitmap;
-	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
@@ -6254,57 +6300,23 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 			     ret, group);
 		return ret;
 	}
-	bitmap = e4b.bd_bitmap;
 
 	ext4_lock_group(sb, group);
-	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
-	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
-		goto out;
-
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
 
-	while (start <= max) {
-		start = mb_find_next_zero_bit(bitmap, max + 1, start);
-		if (start > max)
-			break;
-		next = mb_find_next_bit(bitmap, max + 1, start);
-
-		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start, next - start, &e4b);
-			if (ret && ret != -EOPNOTSUPP)
-				break;
-			ret = 0;
-			count += next - start;
-		}
-		free_count += next - start;
-		start = next + 1;
-
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
-
-		if (need_resched()) {
-			ext4_unlock_group(sb, group);
-			cond_resched();
-			ext4_lock_group(sb, group);
-		}
-
-		if ((e4b.bd_info->bb_free - free_count) < minblocks)
-			break;
+	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
+		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
+		if (ret >= 0)
+			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
+	} else {
+		ret = 0;
 	}
 
-	if (!ret) {
-		ret = count;
-		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	}
-out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
 	ext4_debug("trimmed %d blocks in the group %d\n",
-		count, group);
+		ret, group);
 
 	return ret;
 }
-- 
2.17.1

