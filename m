Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CE2B80F4
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgKRPmO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgKRPmJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:09 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA231C061A48
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:08 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id b191so1759924qkc.10
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aTfARycfPe5TMTx5lZg7EVRgT2qvCg6B5B2Q6/C3RLw=;
        b=ThZjbXk50/HkJw0Dg8BJQRrRhAjwDm8m7vW/Bl9MifeXkHxoGoPZb6v48Ldpfo2lL6
         tr9DImth9kDbSYpEaTPgAnQ4HmUdHYMneefd0DUlsd/3FJ75wiaLSSRYqeh0df2TtOY4
         15x4VqmFSAWj3wtDKcnzvUVrA/ksH/b+xGafQuK9maq3DCuS2nydh1abQl4/l4e5MUZ3
         q5M4PJH50cvISlxvI/3gQaO93O3X/tzPogwunG7j9AyIUJsfNLWTmZk8b0nlDd0M1+3B
         sPTnTP2qAfQIpIf/T1lIBvbJNZOrGsM4N56NDGkIkG6JBYdyqJZ6a2vgwwmKAehYFphB
         n3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aTfARycfPe5TMTx5lZg7EVRgT2qvCg6B5B2Q6/C3RLw=;
        b=BIpcH77oLrRxiXJvSGHrO4mIZJ+lgqFzyxJWEDA1pExmIuhNxEd0O9+oAOJSewHa9M
         w7t0DV4ateQRX6Zujxqd+8kKyMT/sfjvYWs6FceuHrTHxNRqRrvmQrpVPQK0xdu1ZhMG
         kY5rMvQn51ceELHri5WyU7UEw3VolgL/nlb/TwWueA+uRYxzDM2rnTfw0GZAJOOaAvEQ
         cfAax+zmXev/iaXXURxHKM4ccVSXLYxWAaeaxotfpznD3vKM7ef0vJ7gZfFYUlpuSmYN
         d1C5ppAfrVhG32kDSfOBEX0XJB1HJdvAwOgj+ZBrOgLQ2uXIQkv/cU56/nkblt1N4xg2
         E+ew==
X-Gm-Message-State: AOAM533NnRlQNy2UrFuEoWn9+0hUYsUd+yPkffez8h0o0u8NSSFmH34a
        B0ixr+DEpVo6RmQAYmiL/9jYzG6q5F/sKAuXHPN/u/ZZDuRurX5+uzeroOmRJn3O+eANaR1cuc1
        YCB0VkD18eJtgmsx3PgzUwXBGl62KJg26Q1ApzuFXsdL2eZsj4kWbPB7x9XB+1NXQfPoFu3yKxY
        8iUhJpcSo=
X-Google-Smtp-Source: ABdhPJy2DCkQug/vrHg4ddX/6ngLNGTdc38EEjCNGwDHXhZUEyIggF3FeIG8PGDvMEkslL195dUqGsNmHF47ZZc3EF0=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:f9c8:: with SMTP id
 j8mr5220496qvo.17.1605714127986; Wed, 18 Nov 2020 07:42:07 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:40 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-55-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 54/61] e2fsck: fix race in ext2fs_read_bitmaps()
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

During corruption testing hiting following segfault:

Multiple threads triggered to read bitmaps
Signal (11) SIGSEGV si_code=SEGV_MAPERR fault addr=0x200
./e2fsck[0x4382ae]
/lib64/libpthread.so.0(+0x14b20)[0x7f5854d2fb20]
./e2fsck(ext2fs_rb_insert_color+0xc)[0x46ac0c]
./e2fsck[0x467bb4]
./e2fsck[0x467e6d]
./e2fsck[0x45ba95]
./e2fsck[0x45c124]
/lib64/libpthread.so.0(+0x94e2)[0x7f5854d244e2]
/lib64/libc.so.6(clone+0x43)[0x7f5854beb6c3]

Problem is @block_map might be set NULL if one of
thread exit, move such kind of cleanup operation
to main thread after all threads exit.

Another potential problem is e2fsck_read_bitmap()
could be called during pass1, this need be serialized,
serialize it in the pass1.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c          |  2 +-
 lib/ext2fs/rw_bitmaps.c | 25 ++++++++-----------------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index e98cda9f..3899d710 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -4183,9 +4183,9 @@ report_problem:
 					}
 					continue;
 				}
+				e2fsck_pass1_fix_lock(ctx);
 				e2fsck_read_bitmaps(ctx);
 				pb->inode_modified = 1;
-				e2fsck_pass1_fix_lock(ctx);
 				pctx->errcode =
 					ext2fs_extent_delete(ehandle, 0);
 				e2fsck_pass1_fix_unlock(ctx);
diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
index 95de9b1c..eb791202 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -445,14 +445,6 @@ success_cleanup:
 	return 0;
 
 cleanup:
-	if (do_block) {
-		ext2fs_free_block_bitmap(fs->block_map);
-		fs->block_map = 0;
-	}
-	if (do_inode) {
-		ext2fs_free_inode_bitmap(fs->inode_map);
-		fs->inode_map = 0;
-	}
 	if (inode_bitmap)
 		ext2fs_free_mem(&inode_bitmap);
 	if (block_bitmap)
@@ -463,9 +455,12 @@ cleanup:
 
 }
 
-static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, int do_block)
+static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, int do_block,
+					errcode_t retval)
 {
-	errcode_t retval = 0;
+
+	if (retval)
+		goto cleanup;
 
 	/* Mark group blocks for any BLOCK_UNINIT groups */
 	if (do_block) {
@@ -474,7 +469,7 @@ static errcode_t read_bitmaps_range_end(ext2_filsys fs, int do_inode, int do_blo
 			goto cleanup;
 	}
 
-	return retval;
+	return 0;
 cleanup:
 	if (do_block) {
 		ext2fs_free_block_bitmap(fs->block_map);
@@ -497,10 +492,8 @@ static errcode_t read_bitmaps_range(ext2_filsys fs, int do_inode, int do_block,
 		return retval;
 
 	retval = read_bitmaps_range_start(fs, do_inode, do_block, start, end, NULL, NULL);
-	if (retval)
-		return retval;
 
-	return read_bitmaps_range_end(fs, do_inode, do_block);
+	return read_bitmaps_range_end(fs, do_inode, do_block, retval);
 }
 
 #ifdef CONFIG_PFSCK
@@ -636,9 +629,7 @@ out:
 	free(thread_infos);
 	free(thread_ids);
 
-	if (!retval)
-		retval = read_bitmaps_range_end(fs, do_inode, do_block);
-
+	retval = read_bitmaps_range_end(fs, do_inode, do_block, retval);
 	if (!retval) {
 		if (do_inode)
 			fs->flags &= ~EXT2_FLAG_IBITMAP_TAIL_PROBLEM;
-- 
2.29.2.299.gdc1121823c-goog

