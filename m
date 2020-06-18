Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580CE1FF6A7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbgFRP2h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgFRP22 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151C9C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id m2so2831698pjv.2
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n49Nfoe9y2SSwegC2f3wD+tcXK+p5oMc1LwR0JmDtr0=;
        b=bZ/lOE38Zy2/68qRQuijiQZdkTzuAXpUF1O7TKd2N1DpSlW/sT1gzeeCorqkUWcM6c
         n0CSVsI2RZXcsvcrX48Z7uzbExDwj7TI+IKb+xNl5uV3tVqUf7bgBPKfH72AeCLFm2fj
         TWZmtSwQfZgdYhpe2ZhEhEHmRZiuGGFFkr3MQF9KBRKsZTiFF8/WUfDBb7I6rjdhz65+
         9WERPPA3zHRyDgd3sQu8Mx13LzQ7tI4cApcqhbfLR0lMUkTe5CxnJUwafmuV3TraZAEp
         HdWrUg2Y6LZbV096sJpvkko2z1mbaz7oJHUmgvFNmvbzzha9JuMhzLicGyBUKLnXOmA1
         S7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n49Nfoe9y2SSwegC2f3wD+tcXK+p5oMc1LwR0JmDtr0=;
        b=X0q8dyZIuhfy3dGoLANXjHOwl4DcZJng+/XFippXnusI+P8UCzwoMCxtPYp9PbBnlB
         QPm+iIpZ4HcFP/Bsin49Xw67tKGYo94L+RWrnEIuZj6RW2lhwRMm6uTJWay185ONftMH
         yp2oVLpoZK6bYrtMM05RmFGBtjUgnlFasqbOEGVr+r4nn+2KqvJ9bVwvpX+h7Ul8gLiW
         CZNUbmB7Z1iGc3wSsDb5aTmMP7vjxVXMj8MBDSSSCJ3wUlmuIlT3LBistNzRU9l6SU4z
         //8jCqunDqId3TiB6nAZkTkHz9DIovgljB2//GG05G+K+oMeXPPPYkSjUtFJmU2xXvBS
         8xCw==
X-Gm-Message-State: AOAM531ktUCTpTpVc8fJdzfHK6FCg8xJ2PDATrBnf4RyIPLVDp0O5Xqh
        zO0PV8dO31zBFbRd2ddSilenlF/C6MM=
X-Google-Smtp-Source: ABdhPJzhSi8B7BOA07huzcxxabcVQnr1JQs/UGUkaRNk3UmifKZx3xr3G0X+/fLXjlZJx2iR7XCE3A==
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr4956879pjq.228.1592494107180;
        Thu, 18 Jun 2020 08:28:27 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:26 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 06/51] e2fsck: copy dblist when using multi-thread fsck
Date:   Fri, 19 Jun 2020 00:27:09 +0900
Message-Id: <1592494074-28991-7-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
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
index c0df4330..b212cdde 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2086,8 +2086,29 @@ endit:
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
@@ -2118,12 +2139,18 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
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
@@ -2147,7 +2174,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
 
-	e2fsck_pass1_copy_fs(global_fs, thread_fs);
+	e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
 
-- 
2.25.4

