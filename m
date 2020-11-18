Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8C2B80EC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgKRPlt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgKRPls (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A45C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u37so2942613ybi.15
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=daegGDDQsSr9sVYzcaRO/85KlGjSfsbj2sAdl0WiLTY=;
        b=tBWtD8N5li5rsBCylTS2dSvTQ+lGC48YGbh8WFYT8v02IUfRKgDvGYwHDUKBOb9vs/
         n+v8v7I/GqYbdPMEabzP7bpSg7We1ypuGNKT58BzOYwxOyQVSBMTnJu10wlBevmmXk+y
         1SMlzpbASL26LA92XImA/9JETytzCEzSpJPJuybUMSAifAyk+qnybr+H4mRXTt2mXgI0
         KLoHYslz4aMF+Gp5DaQ3Zo6y4KEHQDqiYbpw9bq/tmN+wHFgaGtjVOx0tfEMmrVuYGtk
         gSuJfkrK8hD/Q7dzWrgjRvSO7nMdPed1gpl1GY/XEFLTraZzAl3W67pZ3rHrbMxCBngf
         3oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=daegGDDQsSr9sVYzcaRO/85KlGjSfsbj2sAdl0WiLTY=;
        b=rw5bujHxau1Tvub47Fxy/u4derITxSsQ2u+f1skbRT23S7jjUh3WQmJ88G6daAcgCF
         ZzwgrVKIMp8eYHHM9D3vW0l3kewHPIRjB6nxL6K/n75y6+PupKJMc1x3IpkLmxepwBe8
         wrqxXwR/1JdTKREWsReWDzP4eaycL3B2Iof/GJCqu5ST50xSlqI/DUt/4bVb9oXG0ebn
         p7x1S23NkteEr/FlpP/jO7jskwB3EAvejM3EZa98spFwUIg5LQMKor7d2BY6hjOgG+F8
         mSOWOAuLBLosNIyMhU4UH4JBu0BgfKNV2Dd9SU1D8fZQSgpkxUNCIkLeKxViP2DduFKT
         kdAw==
X-Gm-Message-State: AOAM531ryfu9iEp+5RHOVv7Ju539T9crQg46il59SDKHLD6wELmbcq40
        QoYuteH+FkErAKWE3MuUl1IZOUKYwQgVBDJ7nG2leKyy2fgHCL8cQ8Ozss2HOWYm8C25yeMiu6R
        /nyxZj43kQ+foUESJTnUXyja2Fc47y9erpi9Dh3ug+k+VpNMJUvKUFyDUWd0NlQQ8vSPrmCKw5H
        whu8ny0Mg=
X-Google-Smtp-Source: ABdhPJzte+9gQXYKYhQqN17c8hEWXKzQ4n50den2dujlm/cpnSzVCPAt8EYL8HZ2wCZxQ2225/jZd278gYcTeAfakL4=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:2605:: with SMTP id
 m5mr6624866ybm.98.1605714107888; Wed, 18 Nov 2020 07:41:47 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:30 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-45-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 44/61] e2fsck: avoid too much memory allocation for pfsck
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

e2fsck init memory according to filesystem inodes/dir numbers
recorded in the superblock, this should be aware of filesystem
number of threads, otherwise, oom happen.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 lib/ext2fs/dblist.c | 2 ++
 lib/ext2fs/icount.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
index 1fdd8f43..c4e712fd 100644
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
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 766eccca..48665c7e 100644
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
2.29.2.299.gdc1121823c-goog

