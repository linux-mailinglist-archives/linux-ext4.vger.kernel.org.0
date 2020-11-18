Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF82B80C1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKRPke (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgKRPke (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA186C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h9so2927396ybj.10
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/kmf5H9XnIJjHPuH6/aFSMDnGdzHvW6OhLldBrCbLGc=;
        b=bBMuZPIhvSZP9QHUyp4W871QKO8/iBD2+brUZldxms8ZGD3qjC0DW6unojV6HNzpfm
         SbEHovVv1dGDeQz8jIvONG4+d+zeAS7vvrnYrnmNuh01ue9a/ptVkXMIlAc912ko6qC/
         CwSdzkv0A5OreiEYYLMCdasSW8DB1LrBHcUulzqSYLZfCM0Rq4QCxBZneUpQwpCI+5Zm
         lh0u3VUJBwA+mJje6PrmaTRD5gOYr6eNKo8bW+P7FTsxyy7cs4UlmeNobUL5J2ih3smS
         v6X40BvveDioarZhDMjr0trnj/7+09Sc/MBgx7XVT/mELxPQwudOBLZKDZUc7y6YqlAx
         4mwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/kmf5H9XnIJjHPuH6/aFSMDnGdzHvW6OhLldBrCbLGc=;
        b=YcJUEIjEqPzikufRsvyxV402RsYVmYkEDMIHq3NudhWRCw9SM0tCooJybrGvU5tCAb
         eq4Pnp0egiSFQgGl+XNgWthQ0vI0R6A+MRqd0k5Tm5aJHWbqSgP48yRPjcNJJwzHdDFp
         Qf76YjCuVWobdaDN/VQ2HEvEuzn49eiRQKhM1dH9dW31MhpqCY8RKC5ECT2gm+INx4bf
         N0efSJ9ny6rXO0r74lyx11OjiPB97jjdfDOS8P+HM09FHtEr9AlLXSpFIcjub3ExQVrq
         ybgJ0Od3zlUSdQF+fUHFn8yJNMjf+bfQmuXf1xDk4Mi7dyvMsMM5E8wdp5JVKF7I+WoV
         jowA==
X-Gm-Message-State: AOAM532WC6KCMCwTmf/JiUT4SwD5kKewczE+Zj5MpkSkHdCbfLQloll/
        bzKAsbkiGuwxmj8yyWRDReRDdnTnRVE02wUxcbscukRf7vsEVEHXJ9XS1CIdMa8xN7gX5LxBMHS
        /fwm6FDb7zM9ulYsLIvo1JwvnKpUao/HR5Wqf5HydUZVxkJ09wCyVik4ZfGcvHolfS9/P8zd/lS
        XzHPVq/rs=
X-Google-Smtp-Source: ABdhPJyvR8HEK6d2H3GMXNnz+sZfgFYt+Z1uJ4A0eWOK1Sd6rM9GUNInoGR2LZo2AKuctM11eMIE5cvhJR6OQS32z60=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:cf56:: with SMTP id
 f83mr6056237ybg.54.1605714033080; Wed, 18 Nov 2020 07:40:33 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:50 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-5-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 04/61] e2fsck: clear icache when using multi-thread fsck
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

icache of fs will be rebuilt when needed, so after copying
fs, icache can be inited to NULL.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 5b4947b0..ba513d91 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2086,8 +2086,10 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
-static void e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
+static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 {
+	errcode_t	retval;
+
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	if (dest->dblist)
 		dest->dblist->fs = dest;
@@ -2095,6 +2097,29 @@ static void e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 		dest->inode_map->fs = dest;
 	if (dest->block_map)
 		dest->block_map->fs = dest;
+
+	/* icache will be rebuilt if needed, so do not copy from @src */
+	src->icache = NULL;
+	return 0;
+}
+
+static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+{
+	struct ext2_inode_cache *icache = dest->icache;
+
+	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+	if (dest->dblist)
+		dest->dblist->fs = dest;
+	if (dest->inode_map)
+		dest->inode_map->fs = dest;
+	if (dest->block_map)
+		dest->block_map->fs = dest;
+	dest->icache = icache;
+
+	if (src->icache) {
+		ext2fs_free_inode_cache(src->icache);
+		src->icache = NULL;
+	}
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
@@ -2118,12 +2143,18 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		goto out_context;
 	}
 
-	e2fsck_pass1_copy_fs(thread_fs, global_fs);
+	retval = e2fsck_pass1_copy_fs(thread_fs, global_fs);
+	if (retval) {
+		com_err(global_ctx->program_name, retval, "while copying fs");
+		goto out_fs;
+	}
 	thread_fs->priv_data = thread_context;
 
 	thread_context->fs = thread_fs;
 	*thread_ctx = thread_context;
 	return 0;
+out_fs:
+	ext2fs_free_mem(&thread_fs);
 out_context:
 	ext2fs_free_mem(&thread_context);
 	return retval;
@@ -2147,7 +2178,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 
-	e2fsck_pass1_copy_fs(global_fs, thread_fs);
+	e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
 
-- 
2.29.2.299.gdc1121823c-goog

