Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93E1A2B7B
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDHVzs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39251 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgDHVzr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id k15so3074881pfh.6
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6a9hHcVkp4224GllHFBq6W3vTwEZAExmZ8j+JbKkY7M=;
        b=d+WilaVcevP6z3hb7n9vci21GmtKIKlXtN1HC8Z0T7ver5Gfu8HhRKDToRaJZUMBqm
         9DdWBtC0dVeftlkWE59LJC/zVgiRfunGuFbC6js9ohCPb7jeVg3p8OhlVAvE+w0n2pQa
         3PvXYW/IbhcPJnltd2redMs/5HOUZqv3KzIU0jYY3R+S+bTcAUKo1dQzMTHLpAV18etB
         PygIneS9+x7fy4yukgMPH2YcQzv0Gvzj+I7RTrPtFaiRfTNU47evYehYctv+ByuaaJVy
         JeQZXzvWWftt+GX0DIUrGWL05KuMG07L8ZVNWvBWBBeEDExcSrpvTdeyBxHO1JGAWnbW
         gnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6a9hHcVkp4224GllHFBq6W3vTwEZAExmZ8j+JbKkY7M=;
        b=rPjsu7qt0RrKWwCV/xHwKTPxSqsgXacoUp2ECv0n3zJ0/ScdI15pJ/0s7oXdHZrYqg
         7nJ/rW6l9dfIGYiXPihxlYwzdfox9U4CxhtJwZ0Gcmur9w2TFWOQjJTTgOSnGD7A0M4d
         QM9FD9rcZs2sEeztSXcVecIxBFzzCo6LXI2E3yx+ANyGaUlAyQKgdLzPTXeKfbXKSBFt
         sZaBLz50Sl1iA0odbnH3Lb1eU9WYpSoC86J4rQb8n1BfIrBqL+9UxPhN88GJp/lJsy2L
         dFCMEClTr9sXVXjx0L7RCz3LVwe/EOYIs1nw4qbOArd6vgKElyuU1BhZt32kcg1uLZN5
         XoZQ==
X-Gm-Message-State: AGi0PubwsbeJh7qyn1Z/D9E8o9gf3Cr24d//L/MsEF2eOvcRjxmCKTm3
        ++APf6QTGDcYlLH8dEcTYPcmFeqe
X-Google-Smtp-Source: APiQypIX46WwhczoksCz77lvlBzxZijOhxX/reknlqElCEA0RVL5qPyX0qkPMTcGnf/SbFLgNzNpGg==
X-Received: by 2002:a63:2158:: with SMTP id s24mr3551071pgm.336.1586382946147;
        Wed, 08 Apr 2020 14:55:46 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:45 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 02/20] ext4: add handling for extended mount options
Date:   Wed,  8 Apr 2020 14:55:12 -0700
Message-Id: <20200408215530.25649-2-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

We are running out of mount option bits. Add handling for using
s_mount_opt2. Add ability to turn on / off the fast commit
feature and to turn on / off fast commit soft consistency option.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h  |  7 +++++++
 fs/ext4/super.c | 23 +++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..7c3d89007eca 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1172,6 +1172,13 @@ struct ext4_inode_info {
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
index 9728e7b0e84f..70aaea283a63 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1523,6 +1523,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+	Opt_no_fc, Opt_fc_soft_consistency
 };
 
 static const match_table_t tokens = {
@@ -1606,6 +1607,8 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_no_fc, "no_fc"},
+	{Opt_fc_soft_consistency, "fc_soft_consistency"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1728,6 +1731,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_NO_EXT3	0x0200
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
+#define MOPT_2		0x0800
 
 static const struct mount_opts {
 	int	token;
@@ -1820,6 +1824,10 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
+	{Opt_fc_soft_consistency, EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -2110,10 +2118,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
2.26.0.110.g2183baf09c-goog

