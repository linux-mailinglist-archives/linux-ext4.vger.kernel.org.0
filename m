Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4554761F2E5
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiKGMX1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKGMX0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:26 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73070E7E
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:24 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h193so10280039pgc.10
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtwaF0H7hgt2Q37P05Dj3KxwH8awOYacDLb4m7drUn4=;
        b=J2bSlmaG0k+Xf8UMmNJzKcT4kn2LlJB5mxhKJMBt8XAhcPMaejl9DL2WFIsXo4lzlX
         SiHFjVExOiV2qZA5KJtzWnplQqZ7eWGq+VYE2v45VNHYrLTUFiXLvsN2/+fPjFmA904a
         P+iMz5nYuZ8ZMlqSJQi/Zqvi5K5ftAeyC31mPB9myfSMn4BRyjjNeh+6ek6vrY64Tzpe
         Wd8qkJo1ti8jZ2ajF04yAsjX92z5vtw5HO6Rdupz+vwuFU7RTvNj7h86AqKPmsdaKjr5
         dvT1LGnR5vShfuoHlZAiLHI1iSZoRBmVjLE6bgYjjQc99Ew2lMmXvdKKG+w3uMQ6vlMX
         tOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtwaF0H7hgt2Q37P05Dj3KxwH8awOYacDLb4m7drUn4=;
        b=ZLOUvCai6sPP32oQaetsI7AJWry5zPeuuTayY//VElrw6Yigjx/tbTG6+dFwwcNYCa
         bDar0Xa5tdiEUYy3m4gcpIUp6D8qvW9vUs10/lzQyaxRVbWCYGqJltrVSAmQcASUtn0U
         UJqGj/aYGkyGkUZy6ZB/5uaxWsod9o50LAHsk/gJXRVhAXu9zLv0KAYCYhE2iBsHIYS7
         qQyhX7bf9vrMTnv7jmAT/tf/R2MDzfXHPBLCXAenQ/5R64cGsNFU0+WwAbxFwKq2sEBz
         XvDgcY7A+smED8Pur5hRX5uPbp1j43P1ODKa1+THyRWhrNw7AaDzNW/3aEtkTTdDdvR2
         t7Jg==
X-Gm-Message-State: ANoB5pkO/bNw+sKeU8vZhRCpAjljpGhePwjaIhZPGHS1MB3I+ZSwArzL
        RU1Qqo0TiqAuCihPp7A1hz0=
X-Google-Smtp-Source: AA0mqf5BnQh3CROdu4Et5Cgbq3JygdUnh3V0bWL+vCJHKZ2i3WAqqpkLqfuKJxrdvBkTZzh+kWw5vw==
X-Received: by 2002:a05:6a00:168b:b0:56e:d7f4:3aaf with SMTP id k11-20020a056a00168b00b0056ed7f43aafmr10849337pfc.81.1667823803974;
        Mon, 07 Nov 2022 04:23:23 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id v4-20020a622f04000000b0056c6e59fb69sm4352877pfv.83.2022.11.07.04.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:23 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 10/72] libext2fs: merge icounts after thread finishes
Date:   Mon,  7 Nov 2022 17:50:58 +0530
Message-Id: <817a806b1c7ed161cb76da5f163a9aade60c8dfd.1667822611.git.ritesh.list@gmail.com>
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

Merge inode_count and inode_link_info properly after
threads finish.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
[Note: splitted the patch to seperate libext2fs changes from e2fsck]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/ext2fs.h |   1 +
 lib/ext2fs/icount.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 54aed5d1..139a25fc 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1546,6 +1546,7 @@ extern errcode_t ext2fs_icount_decrement(ext2_icount_t icount, ext2_ino_t ino,
 					 __u16 *ret);
 extern errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
 				     __u16 count);
+extern errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest);
 extern ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount);
 errcode_t ext2fs_icount_validate(ext2_icount_t icount, FILE *);
 
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 888a90b2..766eccca 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -13,6 +13,7 @@
 #if HAVE_UNISTD_H
 #include <unistd.h>
 #endif
+#include <assert.h>
 #include <string.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -701,6 +702,108 @@ errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
 	return 0;
 }
 
+errcode_t ext2fs_icount_merge_full_map(ext2_icount_t src, ext2_icount_t dest)
+{
+	/* TODO: add the support for full map */
+	return EOPNOTSUPP;
+}
+
+errcode_t ext2fs_icount_merge_el(ext2_icount_t src, ext2_icount_t dest)
+{
+	int			 src_count = src->count;
+	int			 dest_count = dest->count;
+	int			 size = src_count + dest_count;
+	int			 size_entry = sizeof(struct ext2_icount_el);
+	struct ext2_icount_el	*array;
+	struct ext2_icount_el	*array_ptr;
+	struct ext2_icount_el	*src_array = src->list;
+	struct ext2_icount_el	*dest_array = dest->list;
+	int			 src_index = 0;
+	int			 dest_index = 0;
+	errcode_t		 retval;
+
+	if (src_count == 0)
+		return 0;
+
+	retval = ext2fs_get_array(size, size_entry, &array);
+	if (retval)
+		return retval;
+
+	array_ptr = array;
+	/*
+	 * This can be improved by binary search and memcpy, but codes
+	 * would be more complex. And if number of bad blocks is small,
+	 * the optimization won't improve performance a lot.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			memcpy(array_ptr, &dest_array[dest_index],
+			       (dest_count - dest_index) * size_entry);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_entry);
+			break;
+		}
+		if (src_array[src_index].ino < dest_array[dest_index].ino) {
+			*array_ptr = src_array[src_index];
+			src_index++;
+		} else {
+			assert(src_array[src_index].ino >
+			       dest_array[dest_index].ino);
+			*array_ptr = dest_array[dest_index];
+			dest_index++;
+		}
+		array_ptr++;
+	}
+
+	ext2fs_free_mem(&dest->list);
+	dest->list = array;
+	dest->count = src_count + dest_count;
+	dest->size = size;
+	dest->last_lookup = NULL;
+	return 0;
+}
+
+errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest)
+{
+	errcode_t	retval;
+
+	if (src->fullmap && !dest->fullmap)
+		return EINVAL;
+
+	if (!src->fullmap && dest->fullmap)
+		return EINVAL;
+
+	if (src->multiple && !dest->multiple)
+		return EINVAL;
+
+	if (!src->multiple && dest->multiple)
+		return EINVAL;
+
+	if (src->fullmap)
+		return ext2fs_icount_merge_full_map(src, dest);
+
+	retval = ext2fs_merge_bitmap(src->single, dest->single, NULL,
+				     NULL);
+	if (retval)
+		return retval;
+
+	if (src->multiple) {
+		retval = ext2fs_merge_bitmap(src->multiple, dest->multiple,
+					     NULL, NULL);
+		if (retval)
+			return retval;
+	}
+
+	retval = ext2fs_icount_merge_el(src, dest);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
 ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount)
 {
 	if (!icount || icount->magic != EXT2_ET_MAGIC_ICOUNT)
-- 
2.37.3

