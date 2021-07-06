Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C553B3BDD5F
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 20:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhGFSmA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 14:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhGFSmA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 14:42:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1FCC061574;
        Tue,  6 Jul 2021 11:39:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a8so125278wrp.5;
        Tue, 06 Jul 2021 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZygdRG5lOGdhKqDY3RES1mhFCEqtnLdVPOLrQOh1yM=;
        b=K/Bulb5ONddpCHRZK/W+o3DGCXImq6RDtFgL81OwT1TCdKPWTvHMOC4F8XSIrVVAfb
         k+11Hv0IhTdB+kUitTafNUxbZ+9EuQBa0h+soR+Z97JIQcht5NTjGVPUrmW+6rqU0f0O
         JrKT5nFwfkN2HQHryd+Qw4J2PFDXma2CSLdv1ITjeJYToHoUsZYG9b42glFqL1ONBme7
         KUemwBWAp5tL5T7YeX0XIKIe5J8fl9WwssOmOCWwJ+y5uofMz1zRvQySt8wHCa1mVqnC
         IKFIyEzMzrv9Fbp79uq9fIE2JIUiTpP/K8WCYu0EH8cT9EVSCkJm+gGMYJY8JTJ4X2FA
         1vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZygdRG5lOGdhKqDY3RES1mhFCEqtnLdVPOLrQOh1yM=;
        b=A54AUwqxT3zOsGVs7VN722lM541cm4rTvbLydi5E0sl3NYdZvB1g5ZkTn85n6pI+jm
         sCPI6vR7+u/TBI1lF1t7lBijbUpg3FwoEpevFFgmrlxbpF8emVeaqHM6xhsVp901KPDt
         WR9G8Y2QW5VCqOVqPzVzY4bupA0ByLGBM250O6Rca9cyEfCjKRKvf8F9rVgpnr3dE2tE
         wubny025tYUDS8WqMr6guiQJsXPGs6ZYXbf5330DbR0Mn5Vxf4qY6I81F5TMPx6TaXJq
         5hyEAhTngWHQYfwtzmzkKH8GgXVajp3Kc4ocwS4lq/HyNQIJtl9WzuGhB+pk4n+EC5OZ
         XGQA==
X-Gm-Message-State: AOAM533Lai+nLJTKg6NMPsZgsg6hOVuq115OE1t40i3rHScmtzgRD4gN
        5POi1TCVTVJsu1hVA9gZDXk=
X-Google-Smtp-Source: ABdhPJyuIH0ftt1lsdtv23hX+S3CXtgmR9VbgexxAFyxYVK3mVU67OibVgQQ4QhUNsRGKdWWlHMr1w==
X-Received: by 2002:a5d:6484:: with SMTP id o4mr12077046wri.89.1625596758738;
        Tue, 06 Jul 2021 11:39:18 -0700 (PDT)
Received: from uhost.fritz.box (p508df717.dip0.t-ipconnect.de. [80.141.247.23])
        by smtp.gmail.com with ESMTPSA id w8sm17423543wre.70.2021.07.06.11.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 11:39:18 -0700 (PDT)
From:   Jan Gruber <j4n6ru@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     trivial@kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Gruber <j4n6ru@gmail.com>
Subject: [PATCH] ext4: Fix comments and spaces to follow coding style
Date:   Tue,  6 Jul 2021 20:39:00 +0200
Message-Id: <20210706183900.310975-1-j4n6ru@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This commit addresses two whitespace issues as well as
instances of the following coding style issue regarding
block comments, which were identified by checkpatch.pl:

"WARNING: Block comments use a trailing */ on a separate line"

The changes aim at making the code more pleasant to read
and to eliminate warnings

Signed-off-by: Jan Gruber <j4n6ru@gmail.com>
---
 fs/ext4/super.c | 55 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9b2e8fc86346..5250c7debbad 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -514,7 +514,7 @@ static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 		.nr_to_write = LONG_MAX,
 		.range_start = jinode->i_dirty_start,
 		.range_end = jinode->i_dirty_end,
-        };
+	};
 
 	return write_cache_pages(mapping, &wbc,
 				 ext4_journalled_writepage_callback,
@@ -850,9 +850,11 @@ const char *ext4_decode_error(struct super_block *sb, int errno,
 			errstr = "Readonly filesystem";
 		break;
 	default:
-		/* If the caller passed in an extra buffer for unknown
+		/*
+		 * If the caller passed in an extra buffer for unknown
 		 * errors, textualise them now.  Else we just return
-		 * NULL. */
+		 * NULL.
+		 */
 		if (nbuf) {
 			/* Check for truncated error codes... */
 			if (snprintf(nbuf, 16, "error %d", -errno) >= 0)
@@ -864,8 +866,10 @@ const char *ext4_decode_error(struct super_block *sb, int errno,
 	return errstr;
 }
 
-/* __ext4_std_error decodes expected errors from journaling functions
- * automatically and invokes the appropriate error response.  */
+/*
+ * __ext4_std_error decodes expected errors from journaling functions
+ * automatically and invokes the appropriate error response.
+ */
 
 void __ext4_std_error(struct super_block *sb, const char *function,
 		      unsigned int line, int errno)
@@ -876,9 +880,11 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
 		return;
 
-	/* Special case: if the error is EROFS, and we're not already
+	/*
+	 * Special case: if the error is EROFS, and we're not already
 	 * inside a transaction, then there's really no point in logging
-	 * an error. */
+	 * an error.
+	 */
 	if (errno == -EROFS && journal_current_handle() == NULL && sb_rdonly(sb))
 		return;
 
@@ -1219,10 +1225,12 @@ static void ext4_put_super(struct super_block *sb)
 		kfree(get_qf_name(sb, sbi, i));
 #endif
 
-	/* Debugging code just in case the in-memory inode orphan list
+	/*
+	 * Debugging code just in case the in-memory inode orphan list
 	 * isn't empty.  The on-disk one can be non-empty if we've
 	 * detected an error and taken the fs readonly, but the
-	 * in-memory list had better be clean by this point. */
+	 * in-memory list had better be clean by this point.
+	 */
 	if (!list_empty(&sbi->s_orphan))
 		dump_orphan_list(sb, sbi);
 	ASSERT(list_empty(&sbi->s_orphan));
@@ -4311,7 +4319,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 				 encoding_flags);
 			goto failed_mount;
 		}
-		ext4_msg(sb, KERN_INFO,"Using encoding defined by superblock: "
+		ext4_msg(sb, KERN_INFO, "Using encoding defined by superblock: "
 			 "%s-%s with flags 0x%hx", encoding_info->name,
 			 encoding_info->version?:"\b", encoding_flags);
 
@@ -4839,11 +4847,14 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount_wq;
 	}
 
-	/* We have now updated the journal if required, so we can
-	 * validate the data journaling mode. */
+	/*
+	 * We have now updated the journal if required, so we can
+	 * validate the data journaling mode.
+	 */
 	switch (test_opt(sb, DATA_FLAGS)) {
 	case 0:
-		/* No mode set, assume a default based on the journal
+		/*
+		 * No mode set, assume a default based on the journal
 		 * capabilities: ORDERED_DATA if the journal can
 		 * cope, else JOURNAL_DATA
 		 */
@@ -6485,8 +6496,10 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	handle_t *handle;
 	int err;
 
-	/* Force all delayed allocation blocks to be allocated.
-	 * Caller already holds s_umount sem */
+	/*
+	 * Force all delayed allocation blocks to be allocated.
+	 * Caller already holds s_umount sem
+	 */
 	if (test_opt(sb, DELALLOC))
 		sync_filesystem(sb);
 
@@ -6523,10 +6536,12 @@ static int ext4_quota_off(struct super_block *sb, int type)
 	return dquot_quota_off(sb, type);
 }
 
-/* Read data from quotafile - avoid pagecache and such because we cannot afford
+/*
+ * Read data from quotafile - avoid pagecache and such because we cannot afford
  * acquiring the locks... As quota files are never truncated and quota code
  * itself serializes the operations (and no one else should touch the files)
- * we don't have to be afraid of races */
+ * we don't have to be afraid of races
+ */
 static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
 			       size_t len, loff_t off)
 {
@@ -6562,8 +6577,10 @@ static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
 	return len;
 }
 
-/* Write to quotafile (we know the transaction is already started and has
- * enough credits) */
+/*
+ * Write to quotafile, we know, that the transaction was already started
+ * and has enough credits.
+ */
 static ssize_t ext4_quota_write(struct super_block *sb, int type,
 				const char *data, size_t len, loff_t off)
 {
-- 
2.25.1

