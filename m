Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A761F2E0
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiKGMWz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMWy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:22:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42062DF
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:22:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h14so10398897pjv.4
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c76ez1bFQDKYbcoz3xWef+fbR+qhw1r0UYUFuSqVoPo=;
        b=GFaxAb9XkY1c+KBmUpJ+pPUmmsouAFx+McR2BvbSGEDyUilRvu4yfc07Wzs5af0i8+
         7f5ueLIV5y/PKVH+nIRk65loaNR7KzZhmf6QJfcsox/5EbfGCshT8ugLC1uVY2xB7m/J
         f8H+Tx4Z2ImM6xARbPtpwP9k7HomkcpoWDceolajkZOqGk/ByBtLafVGWQJdjb3hxQt0
         e0JkPKLcCfYDzI4KSuR9JmaKci0Op24TIq1+/KwEyEf0WVTjxAQ3C6+9WGcFHJ+L9rNK
         jLFwvnbJ5/JmemyLYu3QrQrdHTM1q19pGoKZcMQ+t898DhP9EGKaCD/nNljuLrMQKS9C
         j7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c76ez1bFQDKYbcoz3xWef+fbR+qhw1r0UYUFuSqVoPo=;
        b=lWTcvUoDfD9kYw2IcqPmP2s/66W9QszHCGOnmiWFB6ktgNBBvyfzSeIftbEMxb+0lC
         36eZkGuKkWyY8XDj1r2DpU+DqxJMv++4qhnUo22Yyfx7f+69Beij0xgI4EaG04TM2Cl1
         aQAVDen5QJki825Xki+/BeHuDWh2dJxILG3as1/JCyZNiubxj3jn92A/QywjpHqt/zkH
         YcZb7a6mXcyuiYABQnzHTtcfMvD1Jqz258tanQlNViGFe6GqLfSjbwMgHFIBtUvIuGi3
         RTCoRddaseYQghYXE72qzg3UDTzul60FUQ10IDgtdq8PxRBOgVvBdsdQ7M+k7YICttOq
         97Jg==
X-Gm-Message-State: ACrzQf15MmbUKnbLhtpdbVTbpjShrKzQbLrTo47Tlr/9/fUxBrKNHuP4
        vax/btNk/v9+5q1de7efVSY=
X-Google-Smtp-Source: AMsMyM7m8YTC2akZlBM+r+U5VbWuYmjJzbVONQfIxbSBv0EpttW5UE9uUoa9ep6lrZebjKdmGVX04Q==
X-Received: by 2002:a17:903:1109:b0:179:d220:1f55 with SMTP id n9-20020a170903110900b00179d2201f55mr33147531plh.42.1667823773011;
        Mon, 07 Nov 2022 04:22:53 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id b17-20020a621b11000000b0053e4baecc14sm4365980pfb.108.2022.11.07.04.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:22:52 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 05/72] badblocks: Add badblocks merge logic
Date:   Mon,  7 Nov 2022 17:50:53 +0530
Message-Id: <01e72f626dcebdb8f0a78b53e4cd093357d82787.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Add badblocks merge logic

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/badblocks.c | 75 ++++++++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h    |  2 ++
 2 files changed, 77 insertions(+)

diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
index 345168e0..36794e69 100644
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
index 9cc994b1..18dddc2c 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -845,6 +845,8 @@ extern int ext2fs_badblocks_list_iterate(ext2_badblocks_iterate iter,
 extern void ext2fs_badblocks_list_iterate_end(ext2_badblocks_iterate iter);
 extern errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 				       ext2_badblocks_list *dest);
+extern errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
+                   ext2_badblocks_list dest);
 extern int ext2fs_badblocks_equal(ext2_badblocks_list bb1,
 				  ext2_badblocks_list bb2);
 extern int ext2fs_u32_list_count(ext2_u32_list bb);
-- 
2.37.3

