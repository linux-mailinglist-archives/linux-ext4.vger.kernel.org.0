Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7869C1E4540
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbgE0OJI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbgE0OJF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 10:09:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D4DC08C5C1
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 07:09:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so8803277pgg.12
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WMnlzBIzrloadjbjQNPdZUSWLPqow8bmYOKFr77Q5Dw=;
        b=DjpvyuU64Rum3FaEXB//a04RFK2RSBXu3I+4s8NFIYfn1669gIv/YXIpOzVZk4NA12
         BtW0WOw/XNtfJJpT/8hMDT4hkY+btYxFwONuCwP0vlUzXYIMycp5bUgOkbXzfUgeA3o+
         mYqKiOkHMF41GxwPeIsJ96ov0w7EEBNH8EtjHCiuDDSa5vTQ4LY72ZZ1DWOLr1yVcG0i
         xai4ziclp9pz3Kzf7k23tNPKDvPfgcEnDLMz7b795AlxlM+kKXxqaXtZhGL6msjgD65E
         LYVxkQ33/CYCU+vT37MSZpPDynByKsG0nf6EpC18yh0XXkj91RniOGff5cRh20lY0gvh
         puDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WMnlzBIzrloadjbjQNPdZUSWLPqow8bmYOKFr77Q5Dw=;
        b=SFc0bq8Anun/Mmw+Me9CL8pJ9fOPmdOg//A2bCuaycaHyhCalpCFgoxPU15rtx9lAJ
         9C/MgrxGww8yiCYQzJ/482zCLe7oKkJOrxfEc+nMq9JiclIVjh8eIZ155xySF3AS0eUR
         PAFp4lf6AbX9xmJU3yX1cQoEyzpvG18RJ9MipuKQ5Y5rrLDUHGi3ofhv5EHhzKKQRMzO
         Y0+5g4YDRAibqbidwiIbg5vo6M+hnQWumvGQfzgfCy1qCSc3FNb8E+Od/kWJ0hEVL5U/
         tp3dJR8gKYFETFU6kFLK+8Y/z6lW3qdAagMxmn9VUhZzxd7VEUxKz/zt3MjhgZH5EhnV
         0Khg==
X-Gm-Message-State: AOAM5301kdx+cZNtVPXZq3mItoDQoAZP1VUzUVTbOsObOX9L1uuup02V
        E0j0hUH9DVoWhrM+9aA/zrfZDAK6CzM=
X-Google-Smtp-Source: ABdhPJwx4AwdCmwG2An9aUNMJD4AFIP5jugEmOEQ5Sin8bcXpQNt+vi8WjKoFQ+G4N/fPAB8r66Z9A==
X-Received: by 2002:a63:3c11:: with SMTP id j17mr4300867pga.70.1590588544656;
        Wed, 27 May 2020 07:09:04 -0700 (PDT)
Received: from localhost.localdomain (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id q201sm2292580pfq.40.2020.05.27.07.09.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 07:09:04 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 2/2] tune2fs: add clear_was_trimmed option
Date:   Wed, 27 May 2020 23:08:44 +0900
Message-Id: <1590588525-29669-2-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590588525-29669-1-git-send-email-wangshilong1991@gmail.com>
References: <1590588525-29669-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

It might be possible that admin want an option for clear
existed WAS_TRIMMED flag to force fstrim next run time.

Cc: Shuichi Ihara <sihara@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Shilong <wangshilong1991@gmail.com>
Cc: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 misc/tune2fs.8.in |  5 +++++
 misc/tune2fs.c    | 30 +++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index 3cf1f5ed..b8025949 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -249,6 +249,11 @@ mounted using experimental kernel code, such as the ext4dev filesystem.
 .B ^test_fs
 Clear the test_fs flag, indicating the filesystem should only be mounted
 using production-level filesystem code.
+.TP
+.B clear_was_trimmed
+Clear block groups' WAS_TRIMMED flag, this will force fstrim to run every
+block group next time.
+.TP
 .RE
 .TP
 .B \-f
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 314cc0d0..3e9814e3 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -101,6 +101,7 @@ static int rewrite_checksums;
 static int feature_64bit;
 static int fsck_requested;
 static char *undo_file;
+static int clear_was_trimmed;
 
 int journal_size, journal_flags;
 char *journal_device;
@@ -949,6 +950,26 @@ static void rewrite_metadata_checksums(ext2_filsys fs, unsigned int flags)
 	ext2fs_mark_super_dirty(fs);
 }
 
+static void clear_bg_was_trimmed(ext2_filsys fs)
+{
+	dgrp_t i;
+	int dirty = 0;
+
+	for (i = 0; i < fs->group_desc_count; i++) {
+		if (ext2fs_bg_flags_test(fs, i, EXT2_BG_WAS_TRIMMED)) {
+			ext2fs_bg_flags_clear(fs, i, EXT2_BG_WAS_TRIMMED);
+			ext2fs_group_desc_csum_set(fs, i);
+			dirty = 1;
+		}
+	}
+
+	if (dirty) {
+		fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
+		ext2fs_mark_bb_dirty(fs);
+		ext2fs_mark_super_dirty(fs);
+	}
+}
+
 static void enable_uninit_bg(ext2_filsys fs)
 {
 	struct ext2_group_desc *gd;
@@ -2207,6 +2228,9 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				continue;
 			}
 			ext_mount_opts = strdup(arg);
+		}  else if (!strcmp(token, "clear_was_trimmed") ||
+			    !strcmp(token, "clear_was-trimmed")) {
+			clear_was_trimmed = 1;
 		} else
 			r_usage++;
 	}
@@ -2224,7 +2248,8 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 			"\tstripe_width=<RAID stride*data disks in blocks>\n"
 			"\tforce_fsck\n"
 			"\ttest_fs\n"
-			"\t^test_fs\n"));
+			"\t^test_fs\n"
+			"\tclear_was_trimmed\n"));
 		free(buf);
 		return 1;
 	}
@@ -3361,6 +3386,9 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		}
 	}
 
+	if (clear_was_trimmed)
+		clear_bg_was_trimmed(fs);
+
 	if (rewrite_checksums)
 		rewrite_metadata_checksums(fs, rewrite_checksums);
 
-- 
2.25.4

