Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ACD761822
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGYMUN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 08:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjGYMUD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 08:20:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0615A10FA
        for <linux-ext4@vger.kernel.org>; Tue, 25 Jul 2023 05:19:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6862d4a1376so1424916b3a.0
        for <linux-ext4@vger.kernel.org>; Tue, 25 Jul 2023 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690287577; x=1690892377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yNQyUWpKqujiuDir4oaTYo7Fl/zBhWbMm3iSCjEiis=;
        b=FJxcimPZz0coKE2hfhybpEHYW8zaByQ4x+TSFKhL2lG9hymITJ8r0a6O1gikTzQUsb
         axbK8N37qIhgwogY28jFeo1MX0z7W+//qHBw9E9iBaI0KViNXsLLA299Mbxp1/caM8k6
         aWCDnx2vCSo5RheoB7LrbrJAON59fnvGKUS5k6VuVZPgl69P/ilDLMxAZThuJgfzDgTN
         TP6sv1R2uI0Oq9MBz04snJsdqy/A2bRN0wmjpE+Ok2avYKkGkvnpC+ieYgXTO7TJwP40
         wuCpXBvkn8nsEk1PbTq88Hb/7o4M5Io5811l+8PPgOiRreND7IMI1AlXLoxNsL2G9YYI
         s76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690287577; x=1690892377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yNQyUWpKqujiuDir4oaTYo7Fl/zBhWbMm3iSCjEiis=;
        b=jZ1z+/7uUM3z/0gru1SYS8KCcHI/I2FPX4JHpOTffxuMsJBTG2Axb024L0Hv0QPfK0
         XWHgTA8OOMWOLPqNOLOUttaXYeOsuY9VtcBNaOuNgQiB0c/4JZa1cioLEpjv1T1fSRQ8
         JmSFPf+JCNJzoMJccLNoerrwRJh21UW5CqNTIJRASeXhCXZRwA2/tuRIvFH1JbZCmbeO
         QeSqfL7Imtp+5kX4vTbGoNHwf4YpXuSJB2BcueUj4Pcc9PdgEBjT3mjE9cT17PprdYfZ
         5AyleG+ofJ8mMX8Z/rdcTuv6FWAl5Mp4HGEWEssNsWAoXRs/C+zVeSqKCGrqa8J9rZ5K
         tLYA==
X-Gm-Message-State: ABy/qLZeLH6BhadXHfozLbe52J+eGDYDLLwC0OXYxEtxkDLJZCPBVylV
        oi69mhqwjFTJWWQAP4WtkKJfjw==
X-Google-Smtp-Source: APBJJlHE3K2aRlaQ1AP8kxsvh6HmxZAYerhqW8cizA10Fw3nV/nFKnbc0RJGxCdoEzLR+erDfhnBag==
X-Received: by 2002:a05:6a00:a29:b0:681:9fe0:b543 with SMTP id p41-20020a056a000a2900b006819fe0b543mr15318084pfh.2.1690287577403;
        Tue, 25 Jul 2023 05:19:37 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id p23-20020a637f57000000b0055adced9e13sm10550938pgn.0.2023.07.25.05.19.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Jul 2023 05:19:37 -0700 (PDT)
From:   Fengnan Chang <changfengnan@bytedance.com>
To:     adilger.kernel@dilger.ca, tytso@mit.edu, guoqing.jiang@linux.dev
Cc:     linux-ext4@vger.kernel.org,
        Fengnan Chang <changfengnan@bytedance.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v3] ext4: improve trim efficiency
Date:   Tue, 25 Jul 2023 20:18:48 +0800
Message-Id: <20230725121848.26865-1-changfengnan@bytedance.com>
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
In my test:
1. create 10 normal files, each file size is 10G.
2. deallocate file, punch a 16k holes every 32k.
3. trim all fs.

the time of fstrim fs reduce from 6.7s to 1.3s.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202307171455.ee68ef8b-oliver.sang@intel.com
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/ext4/mballoc.c | 49 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..b75ca1df0d30 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6790,7 +6790,8 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
  * be called with under the group lock.
  */
 static int ext4_trim_extent(struct super_block *sb,
-		int start, int count, struct ext4_buddy *e4b)
+		int start, int count, bool noalloc, struct ext4_buddy *e4b,
+		struct bio **biop, struct ext4_free_data **entryp)
 __releases(bitlock)
 __acquires(bitlock)
 {
@@ -6812,9 +6813,16 @@ __acquires(bitlock)
 	 */
 	mb_mark_used(e4b, &ex);
 	ext4_unlock_group(sb, group);
-	ret = ext4_issue_discard(sb, group, start, count, NULL);
+	ret = ext4_issue_discard(sb, group, start, count, biop);
+	if (!ret && !noalloc) {
+		struct ext4_free_data *entry = kmem_cache_alloc(ext4_free_data_cachep,
+				GFP_NOFS|__GFP_NOFAIL);
+		entry->efd_start_cluster = start;
+		entry->efd_count = count;
+		*entryp  = entry;
+	}
+
 	ext4_lock_group(sb, group);
-	mb_free_blocks(NULL, e4b, start, ex.fe_len);
 	return ret;
 }
 
@@ -6824,26 +6832,40 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count, free_count, bak;
 	void *bitmap;
+	struct ext4_free_data *entry = NULL, *fd, *nfd;
+	struct list_head discard_data_list;
+	struct bio *discard_bio = NULL;
+	struct blk_plug plug;
+	bool noalloc = false;
+
+	INIT_LIST_HEAD(&discard_data_list);
 
 	bitmap = e4b->bd_bitmap;
 	start = (e4b->bd_info->bb_first_free > start) ?
 		e4b->bd_info->bb_first_free : start;
 	count = 0;
 	free_count = 0;
+	bak = start;
 
+	blk_start_plug(&plug);
 	while (start <= max) {
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
 		if (start > max)
 			break;
 		next = mb_find_next_bit(bitmap, max + 1, start);
+		/* when only one segment, there is no need to alloc entry */
+		noalloc = (free_count == 0) && (next >= max);
 
 		if ((next - start) >= minblocks) {
-			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+			int ret = ext4_trim_extent(sb, start, next - start, noalloc, e4b,
+							&discard_bio, &entry);
 
-			if (ret && ret != -EOPNOTSUPP)
+			if (ret < 0)
 				break;
+			if (entry)
+				list_add_tail(&entry->efd_list, &discard_data_list);
 			count += next - start;
 		}
 		free_count += next - start;
@@ -6863,6 +6885,21 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
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
+	if (noalloc)
+		mb_free_blocks(NULL, e4b, bak, free_count);
+
+	list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
+		mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_count);
+		kmem_cache_free(ext4_free_data_cachep, fd);
+	}
 
 	return count;
 }
-- 
2.37.1 (Apple Git-137.1)

