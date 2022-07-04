Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8D564E56
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiGDHJA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiGDHI0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:08:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5A7767E
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:08:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q82so973603pgq.6
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61QF0rV6HZH/llIqxkdA82tHg1T06f5jzZhwYMeFmUM=;
        b=TXiw0LZqjFYLpgewN43Yk3pF+fp5dRlA10fKCmYDdnzEaTyVmbDDktN6PES1plqtv5
         yQHpfHrgkVuEDjAmEnffnRhxkP6PxbNFbIHXOrd0bw6RqECeKZpflYhZw/2bUoQl8lml
         NeGk1Ietu0m55x6in8/qvG9uHEaUtHomy3kOFN/H3qG5uFmtKWkO/Bs/V90nyIn7UO/2
         TFmumAXGi+DHAMea3FnG/xB/I1u/AWosLjG0FdAwV0fCU7/FiG/hlKNiwiPVaXAveuRS
         eVX50b6hfFaOWy5ijpC1+04Ymaeb4qoIc1KTgRqzTdzOZ2Doyjr5HpNyRynZQitraUEB
         UF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61QF0rV6HZH/llIqxkdA82tHg1T06f5jzZhwYMeFmUM=;
        b=gbHuVa6h6TflC3I6foB+DTrPddHmeAbGSL4Up8n97oBoG6CD2lfMUr45Wy74Oixq3D
         t2HJAFKd/FQILlbjDf7ALi74m8xmAR+VPfkXxgq5112IqcySHxTGsJlD6pIahQGUCVy7
         RPmOfyLLN5ECE0K5JG//XcbHsKAy/q0a/fog7FiX6LSMm0Yp2jiiGrfAEmXUA+ftn0o3
         N8YX792CrPTpfvMuhcHrUX/xDBmGdPIcEsCXuj7eK058TdFZVajsdpqOhEhHcXY/q4e4
         r8XaYolxiqGFXWIqpIUC9jKaiug/Zk1hoBRMqvadfGbsuILxPtMIZnbiqaOkczuny0Nw
         VPKA==
X-Gm-Message-State: AJIora8O/K46a2AkO5Mj8rOqzchIQcTggFrOzHBqHpxWhVH9rndy+ybE
        U0y6hiXsOFPQkGfYu++8o8o=
X-Google-Smtp-Source: AGRyM1tKtLeAdJQNjATP/lmK1MsxXij9mJ0MFiwDuGqstOpIx9fuGFyf3x92dvzjvLJRYhq9wB8miw==
X-Received: by 2002:a63:8b42:0:b0:40d:a82d:49da with SMTP id j63-20020a638b42000000b0040da82d49damr23171138pge.186.1656918490119;
        Mon, 04 Jul 2022 00:08:10 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id lp11-20020a17090b4a8b00b001ef82d23125sm2430879pjb.25.2022.07.04.00.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:08:09 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Li Xi <lixi@ddn.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 11/13] dblist: add dblist merge logic
Date:   Mon,  4 Jul 2022 12:37:00 +0530
Message-Id: <6150cdbeaeb1bb94a8cda5f138b6206362958d94.1656912918.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656912918.git.ritesh.list@gmail.com>
References: <cover.1656912918.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This adds dblist merge logic.

TODO: Add a unit test for core operations of dblist. Currently there is
no such test for this.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/dblist.c | 36 ++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
index bbdb221d..5568b8ec 100644
--- a/lib/ext2fs/dblist.c
+++ b/lib/ext2fs/dblist.c
@@ -119,6 +119,42 @@ errcode_t ext2fs_copy_dblist(ext2_dblist src, ext2_dblist *dest)
 	return 0;
 }
 
+/*
+ * Merge a directory block list @src to @dest
+ */
+errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest)
+{
+   unsigned long long src_count = src->count;
+   unsigned long long dest_count = dest->count;
+   unsigned long long size = src_count + dest_count;
+   size_t size_entry = sizeof(struct ext2_db_entry2);
+   struct ext2_db_entry2 *array, *array2;
+   errcode_t retval;
+
+   if (src_count == 0)
+       return 0;
+
+   if (src->sorted || (dest->sorted && dest_count != 0))
+       return EINVAL;
+
+   retval = ext2fs_get_array(size, size_entry, &array);
+   if (retval)
+       return retval;
+
+   array2 = array;
+   memcpy(array, src->list, src_count * size_entry);
+   array += src_count;
+   memcpy(array, dest->list, dest_count * size_entry);
+   ext2fs_free_mem(&dest->list);
+
+   dest->list = array2;
+   dest->count = src_count + dest_count;
+   dest->size = size;
+   dest->sorted = 0;
+
+   return 0;
+}
+
 /*
  * Close a directory block list
  *
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 13404f3d..29e7be9f 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1146,6 +1146,7 @@ extern errcode_t ext2fs_add_dir_block(ext2_dblist dblist, ext2_ino_t ino,
 				      blk_t blk, int blockcnt);
 extern errcode_t ext2fs_add_dir_block2(ext2_dblist dblist, ext2_ino_t ino,
 				       blk64_t blk, e2_blkcnt_t blockcnt);
+extern errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest);
 extern void ext2fs_dblist_sort(ext2_dblist dblist,
 			       EXT2_QSORT_TYPE (*sortfunc)(const void *,
 							   const void *));
-- 
2.35.3

