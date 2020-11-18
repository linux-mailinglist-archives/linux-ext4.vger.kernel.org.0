Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3772B80D2
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKRPlC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgKRPlC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CAC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w8so2988243ybq.4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=10bpX5rRWogqd3Hep7qofcUq6bra1TcXdYCBBOqTGFA=;
        b=IYGLMcdr82B909aHQUgP1DikCdLzITSkL1Ta6hMij8+TFM5g0Dbbd1ugPKIZiAaccI
         zeHws99Y5lxxxwIDECcvlNkqPHotRrvduA2RUoBV5jaoKTbfJ/mQFb7jQrzudZSIBnwY
         gjQBatP66OTVZhjMSqpYiaaxdmnTeM6odGljZkmC/zXFn+Ivacr0dkSW99HYO0AWzEMa
         1ukDvmrtCAXpMkw+Az9MFU9TtmXdLN3hhrPsHhok5ugVEinjW9xk/VELPInGpvw9gdkb
         HKCSJGG4T1JeppZXUXJNepHZcirwF2/5qfvBG8YAwgB9Vk7D2vGV93IvNgNDHajCzoB/
         DHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=10bpX5rRWogqd3Hep7qofcUq6bra1TcXdYCBBOqTGFA=;
        b=JwhLPZped+rhPRGAJG9CsWLR96IZPd+MMd2Ws9rUwLKdW0KShj0MVrli/4mU84F992
         areAosXy9lKhMJXuYtHmG9A58EtjqcrYPtmfSDgApOKS0LoCd6Sxrv58P9aHtXL7oHMA
         AI3t1s8jx1RREb8MBK0U2bntGWeJbmuAvm52KCDauGx1OsQVQZYVX7FTmVdMMHnJjAF+
         qQOP2TO72F2nKWyvJkH2QPAU0lhP42TNFBvsp/U6ux+RfPMKnWjfRSfhoHfJqR9efxea
         NYTz6gigS540vknBcUxqgUrkkmCdSNVUYdstTZGK7fnvE4WJ8ODXDv+eE2ZZX858Dmn5
         ttlw==
X-Gm-Message-State: AOAM532QradKBv1LHdLJjccynqDy4BB+qdnVZgUqKeGzNjI2tO65DxEe
        +Bfjnh+Mb10gC9i6KgcQmD078cW6jQNh34V5v8B1uLTxR62EU5g/pSQMpmNmRI15ZYRdFkSdJbz
        Y96e0hNfuQYpScwFQkSB1IOFqy7Dfpy8uR/wBSFXY+iOrR7xH3QdVc+NzrYZCbgPwDfQD/bgAx6
        SvAdU1ZSg=
X-Google-Smtp-Source: ABdhPJzR0WcpK43bjdNWjQ/wBO0d14w931pa5w+K+/T0T5pdvPhPLRIp9m6nr/7Wo1VrFCbY9PpeY0+HCdNGAiqFa4c=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:c782:: with SMTP id
 w124mr8654009ybe.267.1605714061246; Wed, 18 Nov 2020 07:41:01 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:05 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-20-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 19/61] e2fsck: merge badblocks after thread finishes
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Li Xi <lixi@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Badblocks should be merged properly after threads finish.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c         | 19 +++++++---
 lib/ext2fs/badblocks.c | 85 ++++++++++++++++++++++++++++++++++++++----
 lib/ext2fs/ext2fs.h    |  2 +
 lib/ext2fs/ext2fsP.h   |  1 -
 4 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 2147f64b..da42323d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2180,6 +2180,7 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->inode_map = NULL;
 	dest->block_map = NULL;
+	dest->badblocks = NULL;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
 	if (src->block_map) {
@@ -2196,7 +2197,8 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
 	}
 
 	if (src->badblocks) {
-		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		retval = ext2fs_badblocks_copy(src->badblocks,
+					       &dest->badblocks);
 		if (retval)
 			return retval;
 	}
@@ -2241,11 +2243,13 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	io_channel dest_image_io;
 	ext2fs_inode_bitmap inode_map;
 	ext2fs_block_bitmap block_map;
+	ext2_badblocks_list badblocks;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
 	inode_map = dest->inode_map;
 	block_map = dest->block_map;
+	badblocks = dest->badblocks;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
@@ -2253,6 +2257,7 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	dest->icache = icache;
 	dest->inode_map = inode_map;
 	dest->block_map = block_map;
+	dest->badblocks = badblocks;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
 
@@ -2272,10 +2277,12 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		goto out;
 
 	if (src->badblocks) {
-		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
-
-		ext2fs_badblocks_list_free(src->badblocks);
-		src->badblocks = NULL;
+		if (dest->badblocks == NULL)
+			retval = ext2fs_badblocks_copy(src->badblocks,
+						       &dest->badblocks);
+		else
+			retval = ext2fs_badblocks_merge(src->badblocks,
+							dest->badblocks);
 	}
 out:
 	io_channel_close(src->io);
@@ -2283,6 +2290,8 @@ out:
 		ext2fs_free_generic_bmap(src->inode_map);
 	if (src->block_map)
 		ext2fs_free_generic_bmap(src->block_map);
+	if (src->badblocks)
+		ext2fs_badblocks_list_free(src->badblocks);
 	return retval;
 }
 
diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
index 0f23983b..3c9a608b 100644
--- a/lib/ext2fs/badblocks.c
+++ b/lib/ext2fs/badblocks.c
@@ -11,6 +11,7 @@
 
 #include "config.h"
 #include <stdio.h>
+#include <assert.h>
 #include <string.h>
 #if HAVE_UNISTD_H
 #include <unistd.h>
@@ -56,6 +57,75 @@ static errcode_t make_u32_list(int size, int num, __u32 *list,
 	return 0;
 }
 
+static inline int insert_ok(blk_t *array, int cnt, blk_t new)
+{
+	return (cnt == 0 || array[cnt - 1] != new);
+}
+
+/*
+ * Merge list from src to dest
+ */
+static errcode_t merge_u32_list(ext2_u32_list src, ext2_u32_list dest)
+{
+	errcode_t	 retval;
+	int		 src_count = src->num;
+	int		 dest_count = dest->num;
+	int		 size = src_count + dest_count;
+	int		 size_entry = sizeof(blk_t);
+	blk_t		*array;
+	blk_t		*src_array = src->list;
+	blk_t		*dest_array = dest->list;
+	int		 src_index = 0;
+	int		 dest_index = 0;
+	int		 uniq_cnt = 0;
+
+	if (src->num == 0)
+		return 0;
+
+	retval = ext2fs_get_array(size, size_entry, &array);
+	if (retval)
+		return retval;
+
+	/*
+	 * It is possible that src list and dest list could be
+	 * duplicated when merging badblocks.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			for (; dest_index < dest_count; dest_index++)
+				if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
+					array[uniq_cnt++] = dest_array[dest_index];
+			break;
+		}
+		if (dest_index >= dest_count) {
+			for (; src_index < src_count; src_index++)
+				if (insert_ok(array, uniq_cnt, src_array[src_index]))
+					array[uniq_cnt++] = src_array[src_index];
+			break;
+		}
+		if (src_array[src_index] < dest_array[dest_index]) {
+			if (insert_ok(array, uniq_cnt, src_array[src_index]))
+				array[uniq_cnt++] = src_array[src_index];
+			src_index++;
+		} else if (src_array[src_index] > dest_array[dest_index]) {
+			if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
+				array[uniq_cnt++] = dest_array[dest_index];
+			dest_index++;
+		} else {
+			if (insert_ok(array, uniq_cnt, dest_array[dest_index]))
+				array[uniq_cnt++] = dest_array[dest_index];
+			src_index++;
+			dest_index++;
+		}
+	}
+
+	ext2fs_free_mem(&dest->list);
+	dest->list = array;
+	dest->num = uniq_cnt;
+	dest->size = size;
+	return 0;
+}
+
 
 /*
  * This procedure creates an empty u32 list.
@@ -79,13 +149,7 @@ errcode_t ext2fs_badblocks_list_create(ext2_badblocks_list *ret, int size)
  */
 errcode_t ext2fs_u32_copy(ext2_u32_list src, ext2_u32_list *dest)
 {
-	errcode_t	retval;
-
-	retval = make_u32_list(src->size, src->num, src->list, dest);
-	if (retval)
-		return retval;
-	(*dest)->badblocks_flags = src->badblocks_flags;
-	return 0;
+	return make_u32_list(src->size, src->num, src->list, dest);
 }
 
 errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
@@ -95,6 +159,13 @@ errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 			       (ext2_u32_list *) dest);
 }
 
+errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
+				 ext2_badblocks_list dest)
+{
+	return merge_u32_list((ext2_u32_list) src,
+			      (ext2_u32_list) dest);
+}
+
 /*
  * This procedure frees a badblocks list.
  *
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 0aa1d94e..ac548311 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -814,6 +814,8 @@ extern int ext2fs_badblocks_list_iterate(ext2_badblocks_iterate iter,
 extern void ext2fs_badblocks_list_iterate_end(ext2_badblocks_iterate iter);
 extern errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 				       ext2_badblocks_list *dest);
+extern errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
+					ext2_badblocks_list dest);
 extern int ext2fs_badblocks_equal(ext2_badblocks_list bb1,
 				  ext2_badblocks_list bb2);
 extern int ext2fs_u32_list_count(ext2_u32_list bb);
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index ad8b7d52..02df759a 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -34,7 +34,6 @@ struct ext2_struct_u32_list {
 	int	num;
 	int	size;
 	__u32	*list;
-	int	badblocks_flags;
 };
 
 struct ext2_struct_u32_iterate {
-- 
2.29.2.299.gdc1121823c-goog

