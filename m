Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96B031A1EEF
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgDHKpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32961 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKpq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay1so2391653plb.0
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IaN541sTTl4RtV1K3SmEOOqaEpmyQ4q5okG6pQ5zcgs=;
        b=rBbeZo3PBvCNRxsJKq6je2xM774nCJoPnIi5z9o9LY0gmZA6ny2IksG9bHtECMX0sL
         eUsdSowETR67ZuaGOV7RTF8E5HzzdVqtrkJb/vgb0dnZE1C/LcAPhdki2A8gb9gA8oof
         WHBzNa+V4QcKWwrQYDGhvXhFJY8bHpYCj4k88zlNNlysdjoWv3ljYGaPwkXUfHss++1t
         HG4voZuZZxmXtACw4gfNho6vPT39dBEtIqdbavYmjkQG/9QqYxIi8uRxnkyJ+9aJkul/
         rk/FZ92LiHZgHUg5sZlNfT9NGzts2MZcun7Psz+V+SUKfSj2jyg94JjUphKpWJgWtTY3
         pGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IaN541sTTl4RtV1K3SmEOOqaEpmyQ4q5okG6pQ5zcgs=;
        b=DwbroFg4rF50u4JHgtbautFMYENBjMG0mVMNcphe4Ndl2Xj06CDuG0ZFvhJEFafwr9
         jtjgDRnbOB79wtD+qF3LQGKfWk7icF1EmLmSoX3Ap3MXoIvUNbvpOOpedanJqYzktDI9
         0q49GTGouQZd3HKgr0n5TLgYG8o/NCuRIw8COK2m/vAq3OIRFVpPE4Tm28ecRY7eBUOX
         3l45aaAX29zPygt0D9YAry0L+z5B/02hg2LEmaLNiQazj31OJs4Lkr8gGgEc6qO+dp+U
         KaLJCOehC+LwiNwijUaHXdsB45NxBRi0CxATlEb2+uQYypLg+rBeeJDqHVRANag/A6u3
         oWqQ==
X-Gm-Message-State: AGi0PuaLqrW0ulDw+qLrwPs96XRGYCy5v8NZqauV6/643JGNNp69hayj
        8NEvzLTW2C8j1UipJToUXcTPy31Mny8=
X-Google-Smtp-Source: APiQypJUFAlYasJDYwcDlgmOJD60eg2eo94O5MXF1PwOAPKl6vy5ajg0K+E6UEMY2JR+BFfDK7bFbA==
X-Received: by 2002:a17:902:a605:: with SMTP id u5mr6526439plq.175.1586342743719;
        Wed, 08 Apr 2020 03:45:43 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:43 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 05/46] e2fsck: copy dblist when using multi-thread fsck
Date:   Wed,  8 Apr 2020 19:44:33 +0900
Message-Id: <1586342714-12536-6-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch only copy the dblist of the fs to a new one when -m
is specified.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 2fcc466e..baf720ce 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2104,8 +2104,29 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
-static void e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
+static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 {
+	errcode_t	retval;
+
+	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+	if (dest->dblist) {
+		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
+		if (retval)
+			return retval;
+		/* The ext2fs_copy_dblist() uses the src->fs as the fs */
+		dest->dblist->fs = dest;
+	}
+	if (dest->inode_map)
+		dest->inode_map->fs = dest;
+	if (dest->block_map)
+		dest->block_map->fs = dest;
+	return 0;
+}
+
+static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+{
+	if (dest->dblist)
+		ext2fs_free_dblist(dest->dblist);
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	if (dest->dblist)
 		dest->dblist->fs = dest;
@@ -2136,12 +2157,18 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
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
@@ -2165,7 +2192,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 
-	e2fsck_pass1_copy_fs(global_fs, thread_fs);
+	e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
 
-- 
2.25.2

