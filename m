Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A060D1FF6E7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbgFRPa0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731686AbgFRPaQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09435C0613EE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so2696289pju.3
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLCJ6I97JiPo/t9HsZdpYZmT0+udGJ9ueal4Vmm5Jng=;
        b=U7Of552rz80DtX0sH50ol1fsZdwzJTq9OZcYmyVxwXMmMMGQHZ1X7UVPBPk3YjoDVe
         vH6Tax0LSMynyeTMLgOa6wNeFhcZdJSXObb83trkhfSbvefPWnTfy0sou4jqjwaI5iiw
         m3A39cwRmfuebUza3heqlhxzuQ6RguQKe5bJcAqMrFek4FHyDqCGks/G2XT0NT/onDCF
         O6gjd5DdijDC+bK4GuVwfgK0wBMYEA0N+isT70SCMA/IY1FrOw//V3eyb60lCOQxb65N
         lHQpdVtb/K4kbEIg0HEDs7mOaNj5W4mnXGbTiwtX3MNNss+MEIZrMA7x+zVz+6CcedUn
         JyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eLCJ6I97JiPo/t9HsZdpYZmT0+udGJ9ueal4Vmm5Jng=;
        b=hzFVTFym3fD+fzw9CDuCURWGvoSA56j3a7OuJD8PfkCWeP7PJ9f6tT6ABYubvmdqDV
         1vHhw6G6pDxr8Wrg1Ig+VhnKzCpnQZXBBQ7DiJnkOQLtFOxamFeaqoLF1yaNDCRGE+sg
         yLPJVIA89VKcMScx55Vqa0eLNHeZIfOiBmjHVxQbTpt154r9w1SgeSmj/Rhpah6FzD8S
         bKfsy2/S251mm2NdPXPET5Tyw0rf9zBR7iF0yTPHCEV9Yr8xGPl+IouU8XOBVS6tr7LO
         uVyNFt9LnIUTkxEXRJr8ndBkBbPfJTLg3E646h7GWrYP1YXDrCz50dRLgY2RNUjtnfyM
         ZYaw==
X-Gm-Message-State: AOAM531lvUnY3Nheid+prgH8Tou+M0g5MEbYzioVv4ckKjgHKxcDUaER
        MNBboneXQCDXE/AGZlFWUIfZChtVcok=
X-Google-Smtp-Source: ABdhPJx4mIM4FXyzdJv0Kq2UTdzx6KtJRA/7zk+T/4llUD25ZbIGZ2XhCMI37svcNy+SisEepb91ew==
X-Received: by 2002:a17:902:9882:: with SMTP id s2mr4197115plp.112.1592494215248;
        Thu, 18 Jun 2020 08:30:15 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.30.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:30:14 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 51/51] e2fsck: fix to avoid too much memory allocation for pfsck
Date:   Fri, 19 Jun 2020 00:27:54 +0900
Message-Id: <1592494074-28991-52-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

e2fsck init memory according to filesystem inodes/dir numbers
recorded in the superblock, this should be aware of filesystem
number of threads, otherwise, oom happen.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c      | 1 +
 lib/ext2fs/dblist.c | 2 ++
 lib/ext2fs/ext2fs.h | 3 ++-
 lib/ext2fs/icount.c | 4 ++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 990e4b04..ca8d30c4 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1315,6 +1315,7 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 			num_threads = max_threads / times;
 	}
 	ctx->fs_num_threads = num_threads;
+	ctx->fs->fs_num_threads = num_threads;
 }
 
 static void init_ext2_max_sizes()
diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
index 046b1e68..55e58306 100644
--- a/lib/ext2fs/dblist.c
+++ b/lib/ext2fs/dblist.c
@@ -58,6 +58,8 @@ static errcode_t make_dblist(ext2_filsys fs, ext2_ino_t size,
 		if (retval)
 			goto cleanup;
 		dblist->size = (num_dirs * 2) + 12;
+		if (fs->fs_num_threads)
+			dblist->size /= fs->fs_num_threads;
 	}
 	len = (size_t) sizeof(struct ext2_db_entry2) * dblist->size;
 	dblist->count = count;
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 44e569e6..9e77f6d1 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -255,10 +255,11 @@ struct struct_ext2_filsys {
 	int				cluster_ratio_bits;
 	__u16				default_bitmap_type;
 	__u16				pad;
+	__u32				fs_num_threads;
 	/*
 	 * Reserved for future expansion
 	 */
-	__u32				reserved[5];
+	__u32				reserved[4];
 
 	/*
 	 * Reserved for the use of the calling application.
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 8fe6ff4e..25ec75c2 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -237,6 +237,8 @@ errcode_t ext2fs_create_icount_tdb(ext2_filsys fs EXT2FS_NO_TDB_UNUSED,
 	 * value.
 	 */
 	num_inodes = fs->super->s_inodes_count - fs->super->s_free_inodes_count;
+	if (fs->fs_num_threads)
+		num_inodes /= fs->fs_num_threads;
 
 	icount->tdb = tdb_open(fn, num_inodes, TDB_NOLOCK | TDB_NOSYNC,
 			       O_RDWR | O_CREAT | O_TRUNC, 0600);
@@ -288,6 +290,8 @@ errcode_t ext2fs_create_icount2(ext2_filsys fs, int flags, unsigned int size,
 		if (retval)
 			goto errout;
 		icount->size += fs->super->s_inodes_count / 50;
+		if (fs->fs_num_threads)
+			icount->size /= fs->fs_num_threads;
 	}
 
 	bytes = (size_t) (icount->size * sizeof(struct ext2_icount_el));
-- 
2.25.4

