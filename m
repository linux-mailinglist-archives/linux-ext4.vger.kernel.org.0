Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4F74703B
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjGDL4x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjGDL4r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 07:56:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F147E73
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 04:56:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-682a5465e9eso62386b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 04 Jul 2023 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688471781; x=1691063781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v9XpOd+7rX3A7E7XOtSLpGIg+uj7qtI5iQZrcmN3xuQ=;
        b=KJXF3hgXB1nS0JLzN1UlQR4HlT5D98UAqEUes+Uys8mMEKKVZh3OcaVLCjT24ABLnY
         WubxhEEzMr2xiqX+lBbHrOURxY+G5BRHHXeaC+4aTFu9HDc6U9BiX8+uDcbhUvTwHKe9
         4EL063Gx7nA/pqc1bbDlXpPlMbwraRZ1MovXaXACPUADoMyCrvprem5Pyx+tTtmeE+PE
         rX4jEY5lXf9/pxcV9BUPQ/7loEuIKuuPkmsk2vQGCAbt8L+JxUm1x+Pio8lFkAYspWeZ
         kztFge7myV2q2KpBuzDlo8bIA9u0wkgQZ7LUxz4IbGAV4WshuojzFXGux79PN+zuXASy
         6Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688471781; x=1691063781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9XpOd+7rX3A7E7XOtSLpGIg+uj7qtI5iQZrcmN3xuQ=;
        b=bqI0RauD3Nbz0ux2wtf9Yrp9qbvEoo1N6TGUmo8tXjnSvFrpDF0twTjENwX8v7NAgb
         ubydanhMkznT27c2NSH2iEDWL//6cB8PDQgkd07/1XnlKzVABZIHIEiDtRRbLsv+uPJz
         v43JAIehPF39//YovmrIe45ir+CLoqazaeHXikKFYdy2TUaP/6AcRFdPXuPuvKuVm5Gj
         7nJuYdabFsAihQoF6T+41lvSzHsRUV2l+cEL2G+TTs4DPzVphlFiGC9cicJX9DBDICJm
         M4Vz7qDtou2sIOp+T8t7L58z7bfgW8r+64ma3JLaf8oYhNBOBuJtkKHSj+C4DWTKLXcz
         xmSA==
X-Gm-Message-State: ABy/qLYLeHu6B6Wqkx2T9tyszvhjapvyvFnxFhMALtaex6NX/a8iONiO
        fgONod5GS8prB0ufFw6dx14owg==
X-Google-Smtp-Source: APBJJlGkcr3z6G7yhEO5d2esfmRdK28LY2jomoI41bGWm8eI62iNMEjW2hPYmTfvfMi9EK/ImMJVXQ==
X-Received: by 2002:a05:6a00:1d05:b0:67d:308b:97ef with SMTP id a5-20020a056a001d0500b0067d308b97efmr14279878pfx.2.1688471780710;
        Tue, 04 Jul 2023 04:56:20 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b006827c26f147sm4777779pfn.138.2023.07.04.04.56.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Jul 2023 04:56:20 -0700 (PDT)
From:   Fengnan Chang <changfengnan@bytedance.com>
To:     wangjianchao@kuaishou.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH] ext4: improve discard efficiency
Date:   Tue,  4 Jul 2023 19:56:13 +0800
Message-Id: <20230704115613.88313-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In commit a015434480dc("ext4: send parallel discards on commit
completions"), issue all discard commands in parallel make all
bios could merged into one request, so lowlevel drive can issue
multi segments in one time which is more efficiency, but commit
55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
seems broke this way, let's fix it.
In my test, the time of fstrim fs with multi big sparse file
reduce from 6.7s to 1.3s.

Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/ext4/mballoc.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..e8fbc5f7d541 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6790,7 +6790,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * be called with under the group lock.
  */
 static int ext4_trim_extent(struct super_block *sb,
-		int start, int count, struct ext4_buddy *e4b)
+		int start, int count, struct ext4_buddy *e4b, struct bio **biop)
 __releases(bitlock)
 __acquires(bitlock)
 {
@@ -6812,9 +6812,8 @@ __acquires(bitlock)
 	 */
 	mb_mark_used(e4b, &ex);
 	ext4_unlock_group(sb, group);
-	ret = ext4_issue_discard(sb, group, start, count, NULL);
+	ret = ext4_issue_discard(sb, group, start, count, biop);
 	ext4_lock_group(sb, group);
-	mb_free_blocks(NULL, e4b, start, ex.fe_len);
 	return ret;
 }
 
@@ -6826,6 +6825,12 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
 	void *bitmap;
+	struct ext4_free_data *entry = NULL, *fd, *nfd;
+	struct list_head discard_data_list;
+	struct bio *discard_bio = NULL;
+	struct blk_plug plug;
+
+	INIT_LIST_HEAD(&discard_data_list);
 
 	bitmap = e4b->bd_bitmap;
 	start = (e4b->bd_info->bb_first_free > start) ?
@@ -6833,6 +6838,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 	count = 0;
 	free_count = 0;
 
+	blk_start_plug(&plug);
 	while (start <= max) {
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
@@ -6840,10 +6846,15 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+			int ret = ext4_trim_extent(sb, start, next - start, e4b, &discard_bio);
 
 			if (ret && ret != -EOPNOTSUPP)
 				break;
+			entry = kmem_cache_alloc(ext4_free_data_cachep,
+				GFP_NOFS|__GFP_NOFAIL);
+			entry->efd_start_cluster = start;
+			entry->efd_count = next - start;
+			list_add_tail(&entry->efd_list, &discard_data_list);
 			count += next - start;
 		}
 		free_count += next - start;
@@ -6863,6 +6874,18 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		if ((e4b->bd_info->bb_free - free_count) < minblocks)
 			break;
 	}
+	if (discard_bio) {
+		ext4_unlock_group(sb, e4b->bd_group);
+		submit_bio_wait(discard_bio);
+		bio_put(discard_bio);
+		ext4_lock_group(sb, e4b->bd_group);
+	}
+	blk_finish_plug(&plug);
+
+	list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
+		mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_count);
+		kmem_cache_free(ext4_free_data_cachep, fd);
+	}
 
 	return count;
 }
-- 
2.37.1 (Apple Git-137.1)

