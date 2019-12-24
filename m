Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE293129ED3
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLXIOx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36266 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLXIOx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id x184so10426094pfb.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDN+O68OdAR7Z2ZIT49tFx0BJkPb3zPXIY6VJ9uOlmQ=;
        b=EtqCN9FW7wQL5IXFx4aJnhaZ0pT4a6MRrMp0aGwF3w7L+Rh/0qAbQozBFGZvdtrbX2
         7EjK5AqlTMjbLo/Blh70FS07a+Yd6HL1E6FTrXznGbQdeAvvN/QpKLD80uJMcMy0qZbc
         Z1IjET8Q+wDDZnYbcRkU1dxzWHSz9x6C5+blwGwT/A6vIUeOzYH14S09c3EMYqOL82xv
         0MX1tzmynMUg3gYtnHZeafg6EF8eVPeTN6QuJ87jx7av6/hhTifsrZUtGdvzeM87lnCt
         0h83J+SzMVu9eO7fgmdiBHyTn6jp8rAjGpeu6RVYD5ocYiY4ZuQRyo1vp8cFbPUMwCCI
         m58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDN+O68OdAR7Z2ZIT49tFx0BJkPb3zPXIY6VJ9uOlmQ=;
        b=oUumOmV98aV6T16Bh2k/JdVEFOEobXOzvOcUpI7YDf9fehYTr4OBulWCDaY3NvI6g3
         LTWVD0dZtH5+zJt0w7Y+//613qBmLm149HOiDtkgLGTSnj/D0dpYR6MitzvsjJbYrCFt
         ll7E6PV0kmLfROWueB3971eAJFdInTXtSefwzziiCWkG0ZQ/rmXn7ucn5BkiXE5J1qkH
         k0HASZEUAiVKH/2td52VYag8p8Uk1qLVl9ylPrN+v7WktP8/gFX+ZiKoXXTkaRdTVmwF
         DX/4Dr8NgsNOBMjfVq7BSL2yczh/veFeFGNmwvKUzeiNZ4+V6mky2rkZcMXGUJewRuSR
         f98Q==
X-Gm-Message-State: APjAAAUQC0KLlvL56jbj71rsFACYaFIlo3Gl1y/t0q80zI2DGN2qX5CI
        WZ1Qxehrs+BgI+a8GOpVuS2ulia2
X-Google-Smtp-Source: APXvYqwzy5yHQpTQP+mMRixr+EdE40LW05rpDwEVDrTyPPNCmCi5EuYh3m2JSq6LT3bCV3sB92a5Dg==
X-Received: by 2002:a62:14c4:: with SMTP id 187mr35051787pfu.96.1577175291670;
        Tue, 24 Dec 2019 00:14:51 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:51 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 02/20] ext4: add handling for extended mount options
Date:   Tue, 24 Dec 2019 00:13:06 -0800
Message-Id: <20191224081324.95807-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We are running out of mount option bits. Add handling for using
s_mount_opt2. Add ability to turn on / off the fast commit
feature and to turn on / off fast commit soft consistency option.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h  |  7 +++++++
 fs/ext4/super.c | 23 +++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676c..9339eb6bf9b0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1170,6 +1170,13 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM	0x00000008 /* User explicitly
 						specified journal checksum */
 
+#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal fast commit */
+
+#define EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY	0x00000020 /* Soft consistency
+							    * mode for fast
+							    * commits
+							    */
+
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
 #define set_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt |= \
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..d635040f21b9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1459,6 +1459,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+	Opt_no_fc, Opt_fc_soft_consistency
 };
 
 static const match_table_t tokens = {
@@ -1541,6 +1542,8 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_no_fc, "no_fc"},
+	{Opt_fc_soft_consistency, "fc_soft_consistency"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1663,6 +1666,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_NO_EXT3	0x0200
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
+#define MOPT_2		0x0800
 
 static const struct mount_opts {
 	int	token;
@@ -1755,6 +1759,10 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
+	{Opt_fc_soft_consistency, EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -2038,10 +2046,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 			WARN_ON(1);
 			return -1;
 		}
-		if (arg != 0)
-			sbi->s_mount_opt |= m->mount_opt;
-		else
-			sbi->s_mount_opt &= ~m->mount_opt;
+		if (m->flags & MOPT_2) {
+			if (arg != 0)
+				sbi->s_mount_opt2 |= m->mount_opt;
+			else
+				sbi->s_mount_opt2 &= ~m->mount_opt;
+		} else {
+			if (arg != 0)
+				sbi->s_mount_opt |= m->mount_opt;
+			else
+				sbi->s_mount_opt &= ~m->mount_opt;
+		}
 	}
 	return 1;
 }
-- 
2.24.1.735.g03f4e72817-goog

