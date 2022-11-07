Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBC561F2E1
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiKGMXB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKGMXA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D1633D
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:22:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so10121364pjl.3
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4wVAqt8eOXFjCWV8thKlgvNZ26hyT3uO6MwWqI24NA=;
        b=VHnxedjwPZv1GI0Wgl40+f3O/4PJn8vc2zKbiqdic5jC3UCpxjMk8JF9HaNjUUMTWl
         UHLsBiThTwBtJrlIw4/krc1RVu3SZNqssFbT8q62DEXvPwjo9jgkqFU/BEeK0jnTAZ4Q
         pp464XtXMsvi+9vfcQbDXXdnzVrTFgIx2mgTm7iB0qeleKW1AkQ9PTiJapk5okWK4MrB
         0hmT0SzPGeYLEOPM3HBZLXrqmoYnf/q5cUVOXhFLk2wOJCHoAkAZ8AUGp3tkdqvjamX/
         h9gNEZ86KwonSKrZhl0Tt92JNPIkFxIVJAgqelUsPAETDrEpd4VmxusbWyqEuEztLWH9
         vOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4wVAqt8eOXFjCWV8thKlgvNZ26hyT3uO6MwWqI24NA=;
        b=Tjobm/GsRSKJ+vwE4IcpBe5ZnA98U4CCv/ynJSUKX3vlBnCl0sF48cdjSbk4geeiBt
         fkFOZjluKTN3JAPmch5ySG6URkWdS+ifafa5G8o/rToA4AQmbHH03ePTXZVDb85o3M44
         tHbtUx0UzhpscobM897fjSThgbpfcJf6hrFglTmo5jXXjc0OTHSSejk9uNpqNGDn0NbK
         wb6HmmvJawzzr3MeUQPrFmZfbl3Fq4qTRu3G8MK+kn4rRB1KgXy1++Ahx2tP4Uxq2Qpe
         u929vzUUXJ9ZogvWnr1FBWRUZ1kqApf4GTu6c7uTPS+97iamymDcGrIgWwWcoOJY5w/o
         wimQ==
X-Gm-Message-State: ACrzQf1ZaLbUZnaRfF0fC/jbnqm5nyr51eOLKnY34WqrOpwq3ZaCr+hq
        cVCLEGp6oYkq0TD2l3eZaMidzRgNh2o=
X-Google-Smtp-Source: AMsMyM5khg5zdqQlbQ1ind3anwN6NIoBKoUzFN36VXzDIWRlVgbX/VwG/MxsLLBD5nvzBWkfBzJ0cw==
X-Received: by 2002:a17:90b:3901:b0:213:dfd5:a75f with SMTP id ob1-20020a17090b390100b00213dfd5a75fmr42776009pjb.233.1667823779318;
        Mon, 07 Nov 2022 04:22:59 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id y15-20020a62ce0f000000b0056d2e716e01sm4369131pfg.139.2022.11.07.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:22:58 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 06/72] dblist: add dblist merge logic
Date:   Mon,  7 Nov 2022 17:50:54 +0530
Message-Id: <99ecce2af8609cc7bbe79de273472dcb42cca8f5.1667822611.git.ritesh.list@gmail.com>
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

From: Li Xi <lixi@ddn.com>

This adds dblist merge logic.

TODO: Add a unit test for core operations of dblist. Currently there is
no such test for this.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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
index 18dddc2c..443f93d2 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1143,6 +1143,7 @@ extern errcode_t ext2fs_add_dir_block(ext2_dblist dblist, ext2_ino_t ino,
 				      blk_t blk, int blockcnt);
 extern errcode_t ext2fs_add_dir_block2(ext2_dblist dblist, ext2_ino_t ino,
 				       blk64_t blk, e2_blkcnt_t blockcnt);
+extern errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest);
 extern void ext2fs_dblist_sort(ext2_dblist dblist,
 			       EXT2_QSORT_TYPE (*sortfunc)(const void *,
 							   const void *));
-- 
2.37.3

