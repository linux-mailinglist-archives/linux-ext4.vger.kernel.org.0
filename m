Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F711FF6E6
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgFRPa0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731685AbgFRPaO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7DC0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so2702679pjb.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kLJATsO6pA5bwy75WwMgMFLWnb9jfylgSQQSYokMOLI=;
        b=UxGGYyxIcrCiFfC+ZZU/kmo3DrnhxFxmTcJgMljtqN9KBlWcPeJLOhVNgqlubqxo3n
         u8doG2tgsOIiMFtyrqJmZTyq5UqSwEXE3xoJu8tmOPSL80GpgdZEVR1C0C6M9zcOIX1L
         1O3K0HUQIuqBhQDqyZ11qCm+2MdfsgTP4OthOMvk1aOYVfHAEwE3kFB/Urf5TIYwWVWj
         0TZy+ZBkO09pcYmGqVk0zy2VKV0/cgEMpPCAf4ySVp4ZTsMaaoW9Q4D333slBxD6NLna
         xL+aj+i1xLSHai8KcNOIMo+lJ5/8O1B4i1w/3nldYrDczT5Ung2GzQjTX9hANnpR8XA5
         wHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kLJATsO6pA5bwy75WwMgMFLWnb9jfylgSQQSYokMOLI=;
        b=QcCREOeYm+MNUBl/aWA9suqfUkEK8zDPcLY5is+hpNABmLBOFvyq6i2oqIm1yFe5gI
         KAwmD2VmRiMQsBpop+lvCtn2tBDJVSrw927w7JCCTzTRbxaOVNEWlyxMZfwpnZVpcdLv
         tcR+J3/OF0I13ZbLBrD1XsPSgwy230iRUFD0Tgm3SiQxMsfJ9IgYS2X+eY6LqYJx6STW
         m6a9yDHNqRi6/imnlZl2RDWoQxO4hVIrh2We2/GrV0fNamL3sURS9lFSU2jaJp3Dh8bL
         b7NJMX6QjRTwqAfxZE4GsnJaRJJj4Cku9I9Csoo4kUjfua+yHt/h1lOEGg8yQUQc6Dts
         ZSAA==
X-Gm-Message-State: AOAM533G/bzKeheLkJAK3U+Y+U60yEKCHMhSvRYpI3GVELW2LG5J5Qls
        U2HYidJtWYnQtYEaSOuguzCOC1EDvyA=
X-Google-Smtp-Source: ABdhPJxbBu20cB5UcksAH/xIWmoj7Yeq97wunj5hAzF8WpR8SST2VeNdJqtwbDW1ANbujOVV3XqD4A==
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr4863993pjb.57.1592494212850;
        Thu, 18 Jun 2020 08:30:12 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.30.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:30:12 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 50/51] e2fsck: fix to free icache leak
Date:   Fri, 19 Jun 2020 00:27:53 +0900
Message-Id: <1592494074-28991-51-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 52af4f13..990e4b04 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2513,6 +2513,7 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->inode_map = NULL;
 	dest->block_map = NULL;
+	dest->icache = NULL;
 
 	/*
 	 * PASS1_COPY_FS_BITMAP might return directly from this function,
@@ -2521,13 +2522,6 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
 	PASS1_COPY_FS_BITMAP(dest, src, inode_map);
 	PASS1_COPY_FS_BITMAP(dest, src, block_map);
 
-	/* icache will be rebuilt if needed, so do not copy from @src */
-	if (src->icache) {
-		ext2fs_free_inode_cache(src->icache);
-		src->icache = NULL;
-	}
-	dest->icache = NULL;
-
 	if (src->dblist) {
 		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
 		if (retval)
@@ -2593,6 +2587,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	ext2_dblist dblist;
 	int flags;
 	e2fsck_t dest_ctx = dest->priv_data;
+	struct ext2_inode_cache *icache = dest->icache;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
@@ -2610,6 +2605,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	dest->dblist = dblist;
 	dest->priv_data = dest_ctx;
 	dest->flags = src->flags | flags;
+	dest->icache = icache;
 	if (!(src->flags & EXT2_FLAG_VALID) || !(flags & EXT2_FLAG_VALID))
 		ext2fs_unmark_valid(dest);
 	/*
@@ -2654,17 +2650,15 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 
 	retval = _e2fsck_pass1_merge_fs(dest, src);
 
-	if (src->inode_map)
-		ext2fs_free_generic_bmap(src->inode_map);
-	if (src->block_map)
-		ext2fs_free_generic_bmap(src->block_map);
-
-	/* icache will be rebuilt if needed, so do not copy from @src */
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
 		src->icache = NULL;
 	}
-	dest->icache = NULL;
+
+	if (src->inode_map)
+		ext2fs_free_generic_bmap(src->inode_map);
+	if (src->block_map)
+		ext2fs_free_generic_bmap(src->block_map);
 
 	if (src->dblist) {
 		ext2fs_free_dblist(src->dblist);
-- 
2.25.4

