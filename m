Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC03F564E53
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 09:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiGDHIh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiGDHIQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 03:08:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B564B95BF
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 00:08:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b2so7789834plx.7
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 00:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osN1zLxDu8E/B6/6OijtO4BtJe1tGgZdZcrNyYXTrSg=;
        b=nQ7nVDFXzmU8ucbxuY2FsQFraO+zWATtR4+hQTsHYiKWBVvSsX5U36hlDQiNtslWtj
         ppjiiRbAifyp8jLAwIKIKfZYKbn8OG+IC1k+mwEHdpaCVGz54HFRS8JfR9euB+tCoq9t
         Uj+NkFGmkXTESsHPIkrViWLZN+oUWrOXmH+OaE6yT2ZrZRHqLk+VqDT4Ni+AkJtIZ/Yl
         hmS+BJg9Wnn0OjFQIlqpxvQHnWkshsH/+0IFU019TNkjgVjjUwh4da8GbuzJ7vkyCBmH
         PcEDq54X0ySidU6QVCTdvtaHtkafxFPLo2D0CHWWvFyB25Wg3anyzKsOVuW5szkIylo4
         aIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osN1zLxDu8E/B6/6OijtO4BtJe1tGgZdZcrNyYXTrSg=;
        b=7ZKxXsQsnCKtO1QHAXhtN0denBS/RFGra6tJhZh5zJFNt+DyjikP4OS5Ovwnhde7cf
         BdLNnvAjfvmZs4SI3MNK+jP+OGJkZOB2bu9OsVRbzslhcBbl4WF+rOFYMXXE4wjK7AQz
         iMM9OXSAffMysXiXHMlWH6tG/cjLzJInZYrUlD+RrfTeLFPjtA50tFeUGN+h41OstCBg
         KKe+BbccL/QpJF+kogaSDhgJWgrDNU6PQw/ksXZv9bA6NBsXZzXWydPH7IZcUf5E0o0i
         60GJMuZPEk4yycEMYlYagqxO9l8c5E7TkHnWjxMM56xBiYHTAreXbgUzt6f8n1ttn+/B
         wnzQ==
X-Gm-Message-State: AJIora/K3WjVi80up38gc02d0vMOj4UNo4ft0y9hrTPAm+NYlP5PukdS
        +ZMgoBucE2nFSXc2FoUt9KLuR2W8noU=
X-Google-Smtp-Source: AGRyM1vOPv+Ld95o8aujKwDbP/JhEyr/qN59DIN4g+HAUN5Kwe/tK5bVDINYOjblSOzGcC72RUZZxg==
X-Received: by 2002:a17:902:c94b:b0:16a:6427:ae5d with SMTP id i11-20020a170902c94b00b0016a6427ae5dmr34244375pla.127.1656918480427;
        Mon, 04 Jul 2022 00:08:00 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id x124-20020a626382000000b00525231e15ccsm20252107pfb.113.2022.07.04.00.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:08:00 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 09/13] badblocks: Add badblocks merge logic
Date:   Mon,  4 Jul 2022 12:36:58 +0530
Message-Id: <dc8dcaec0a7e11944308e77647ffc55a6cb565a4.1656912918.git.ritesh.list@gmail.com>
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

From: Wang Shilong <wshilong@ddn.com>

Add badblocks merge logic

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 lib/ext2fs/badblocks.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h    |  2 ++
 2 files changed, 77 insertions(+)

diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
index 0570b131..48968adc 100644
--- a/lib/ext2fs/badblocks.c
+++ b/lib/ext2fs/badblocks.c
@@ -56,6 +56,74 @@ static errcode_t make_u32_list(int size, int num, __u32 *list,
 	return 0;
 }
 
+static inline int insert_ok(blk_t *array, int cnt, blk_t new)
+{
+   return (cnt == 0 || array[cnt - 1] != new);
+}
+
+/*
+ * Merge list from src to dest
+ */
+static errcode_t merge_u32_list(ext2_u32_list src, ext2_u32_list dest)
+{
+   errcode_t    retval;
+   int      src_count = src->num;
+   int      dest_count = dest->num;
+   int      size = src_count + dest_count;
+   int      size_entry = sizeof(blk_t);
+   blk_t       *array;
+   blk_t       *src_array = src->list;
+   blk_t       *dest_array = dest->list;
+   int      src_index = 0;
+   int      dest_index = 0;
+   int      uniq_cnt = 0;
+
+   if (src->num == 0)
+       return 0;
+
+   retval = ext2fs_get_array(size, size_entry, &array);
+   if (retval)
+       return retval;
+
+   /*
+    * It is possible that src list and dest list could be
+    * duplicated when merging badblocks.
+    */
+   while (src_index < src_count || dest_index < dest_count) {
+       if (src_index >= src_count) {
+           for (; dest_index < dest_count; dest_index++)
+               if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
+                   array[uniq_cnt++] = dest_array[dest_index];
+           break;
+       }
+       if (dest_index >= dest_count) {
+           for (; src_index < src_count; src_index++)
+               if (insert_ok(array, uniq_cnt, src_array[src_index]))
+                   array[uniq_cnt++] = src_array[src_index];
+           break;
+       }
+       if (src_array[src_index] < dest_array[dest_index]) {
+           if (insert_ok(array, uniq_cnt, src_array[src_index]))
+               array[uniq_cnt++] = src_array[src_index];
+           src_index++;
+       } else if (src_array[src_index] > dest_array[dest_index]) {
+           if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
+               array[uniq_cnt++] = dest_array[dest_index];
+           dest_index++;
+       } else {
+           if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
+               array[uniq_cnt++] = dest_array[dest_index];
+           src_index++;
+           dest_index++;
+       }
+   }
+
+   ext2fs_free_mem(&dest->list);
+   dest->list = array;
+   dest->num = uniq_cnt;
+   dest->size = size;
+   return 0;
+}
 
 /*
  * This procedure creates an empty u32 list.
@@ -91,6 +159,13 @@ errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 			       (ext2_u32_list *) dest);
 }
 
+errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
+                ext2_badblocks_list dest)
+{
+   return merge_u32_list((ext2_u32_list) src,
+                 (ext2_u32_list) dest);
+}
+
 /*
  * This procedure frees a badblocks list.
  *
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index c18849d7..13404f3d 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -844,6 +844,8 @@ extern int ext2fs_badblocks_list_iterate(ext2_badblocks_iterate iter,
 extern void ext2fs_badblocks_list_iterate_end(ext2_badblocks_iterate iter);
 extern errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 				       ext2_badblocks_list *dest);
+extern errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
+                   ext2_badblocks_list dest);
 extern int ext2fs_badblocks_equal(ext2_badblocks_list bb1,
 				  ext2_badblocks_list bb2);
 extern int ext2fs_u32_list_count(ext2_u32_list bb);
-- 
2.35.3

