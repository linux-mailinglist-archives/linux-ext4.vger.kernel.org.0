Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7E1FF6AA
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgFRP2l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731491AbgFRP2h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93029C0613EE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v11so3053384pgb.6
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCPH0iJHZgsjo2Ep3LtINn0ssgSboz8j9EJcmMKNSTQ=;
        b=klgMu6BWGGBuwQyocplyZ/xWgOH+L382cvl+E4ii8aSjlRL/1ydBJiLMpPWUoaWvuq
         jLeD7YNPNOWVe9e8/Bxe6Suf5yKcwBr16NefDCXtItVFDl4hZ8w1VZiKubQl7sgBm8I9
         lcc0fB5aHyRq6V/A1/r08izL+QB1JuiJAmjMMb4okXRGJu5bHFrWaPDPYZdOwIw75ULf
         Uos/tiz56QKo8UxgwKBSwrUqqQnDzBBPbyR9lt0G5plgWI2Xhze6Ya7JSeRQd8YtboYC
         NjgNaT2a1cOzpefoGoB2qHflDoD1V9Sk1/KqpH4JLtDOUN1mxEwxEM984pzYNCAcKlCF
         HvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCPH0iJHZgsjo2Ep3LtINn0ssgSboz8j9EJcmMKNSTQ=;
        b=OCuMlcw4dU1b/agh1ICJYtZEtm4ov34R2t5yr75E07r8t6HUEM9Vqg64MLTZYyUHvW
         zgwJzultUxSsB98NgycUt4lQKnZS0Q4Fb/2lNkNgS9Nt/s+11X3lV7C5GExgHAup3Vzb
         9deqgcN0UIgDxVBAdabPJsag574eaW1bv8YoCYxC5Kk6jNv8PyvM29dsKfWkP4sMrzhW
         zcGNb0adbuDXJjyLxFvH9bdN0z1gq+X36Y/pvM9lCEz0087W85O9NfzWOVvPKLcqoppn
         8sKxRbrEWNjl+YxWtSf8QpcK5C5NHUG8Z1NpblpghmH6XDLE/MyQc164udIs8fgUq9T8
         9++w==
X-Gm-Message-State: AOAM533YVRRg2oNfLC93E3HAMgiB94Jy/eIMYak+AUy84rXT9acHJSw6
        ICnZu5mfP4NW7OplHje5ZIZ/I1LO6cI=
X-Google-Smtp-Source: ABdhPJweG0sXNbPUt3Ap+okVnspRUMTGVZVGnSoAnX1EPHeh46sGNAguJjPMWgadPb68mQWRDFkHZQ==
X-Received: by 2002:a62:fc86:: with SMTP id e128mr4201106pfh.133.1592494116805;
        Thu, 18 Jun 2020 08:28:36 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:36 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 10/51] e2fsck: copy badblocks when copying fs
Date:   Fri, 19 Jun 2020 00:27:13 +0900
Message-Id: <1592494074-28991-11-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch copies badblocks when the copying fs.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 55 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index b836e666..a1feb166 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2145,10 +2145,23 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 		src->dblist = NULL;
 	}
 
+	if (src->badblocks) {
+		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		if (retval)
+			goto out_dblist;
+
+		ext2fs_badblocks_list_free(src->badblocks);
+		src->badblocks = NULL;
+	}
 	return 0;
+
+out_dblist:
+	ext2fs_free_dblist(dest->dblist);
+	dest->dblist = NULL;
+	return retval;
 }
 
-static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 {
 	errcode_t	retval = 0;
 
@@ -2160,6 +2173,32 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	PASS1_COPY_FS_BITMAP(dest, src, inode_map);
 	PASS1_COPY_FS_BITMAP(dest, src, block_map);
 
+	if (src->dblist) {
+		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
+		if (retval)
+			return retval;
+		/* The ext2fs_copy_dblist() uses the src->fs as the fs */
+		dest->dblist->fs = dest;
+	}
+
+	if (src->badblocks) {
+		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		if (retval)
+			goto out_dblist;
+	}
+	return 0;
+out_dblist:
+	ext2fs_free_dblist(dest->dblist);
+	dest->dblist = NULL;
+	return retval;
+}
+
+static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
+{
+	errcode_t	retval;
+
+	retval = _e2fsck_pass1_merge_fs(dest, src);
+
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
@@ -2167,16 +2206,16 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	}
 	dest->icache = NULL;
 
-	if (dest->dblist) {
-		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
-		if (retval == 0) {
-			/* The ext2fs_copy_dblist() uses the src->fs as the fs */
-			dest->dblist->fs = dest;
-		}
-
+	if (src->dblist) {
 		ext2fs_free_dblist(src->dblist);
 		src->dblist = NULL;
 	}
+
+	if (src->badblocks) {
+		ext2fs_badblocks_list_free(src->badblocks);
+		src->badblocks = NULL;
+	}
+
 	return retval;
 }
 
-- 
2.25.4

