Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9347F17D984
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCIHF7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:05:59 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39587 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHF7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:05:59 -0400
Received: by mail-pj1-f65.google.com with SMTP id d8so4013040pje.4
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvtZxmExdmF/gPXl4ZlDulXPko4L69xFXtA8++E9dCc=;
        b=VnM7MqIk9JV0UPGjr46YFnL0Me1hCNnxYpoob4TWRItkZ7CedY1hguaUQK1S+fus7g
         KyEEtD0lELd1Up5JVtmjSY6shS7U3rQ8sB0wFhcRoAkd38QOp/i5uoBCsicGVCId/9D1
         RDu+EZEg3fG+zwY1/7yltpqD0FOph/y8AhuHZVtgDNbkIciFxdyWBdOYOWyunByD+vG5
         9jGzyOUPwfU/pzqr1UUk7snA8245QRmA2wb6TFv4LryRYuZPTFaB7NMHJM/BVt5ccuIv
         YiKd7otANWrj4G47h2d2l/iiD6nDhQVHsT3e4puxk9PpnCsx+PwjzjH5SDAR+7+zOJJm
         jVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvtZxmExdmF/gPXl4ZlDulXPko4L69xFXtA8++E9dCc=;
        b=JM8IDF9IUerWtdEj82UVqfzFYIcFJ1Z7UJdqb5El8zt/pTIS485U77uWejdY35pjGW
         NCS3ogIi0ONqPCOKuaURo/r4gXKoVwhIJ/SE2N30+DAHXnsSjdEbLbCqRDDNrBXOhIzE
         1sv04vKqIu3eYiX8Humd+1RPTlsu5OACgNxCFHzaI5wV4NXHzTOfe/uJ7MCSXMDioPul
         kC9Axv2MQUDCpgRRpQvxBHzoRI1vRr2LgTPsLmAIkDfDuMgPbvzQSHTZsA3jgk/84xGZ
         pvs2SPI1OT4DOAtIdalgLOKYnBVlX0ehuvfMsNB6Fscxi+GaIm8XR47Gi7hsm7lDZmZW
         woIQ==
X-Gm-Message-State: ANhLgQ0x83wtl9EjOKBeam+ipdRtfKwg4vN3nrhJM6RbnC2SLivFw9kM
        E23/QFisdWUQ5sDAp/Lel/MOL1wO
X-Google-Smtp-Source: ADFU+vtcVMN/FHyZYHwnieU50Dp2Gj9jc0+gnfkH0t5XbPULl2jWvbaJDtGuFIycNtW9AW5hBUgX8w==
X-Received: by 2002:a17:902:d703:: with SMTP id w3mr14382321ply.264.1583737557600;
        Mon, 09 Mar 2020 00:05:57 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:05:57 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 02/20] ext4: add handling for extended mount options
Date:   Mon,  9 Mar 2020 00:05:08 -0700
Message-Id: <20200309070526.218202-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
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
index 61b37a052052..f96a672232a1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1173,6 +1173,13 @@ struct ext4_inode_info {
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
index ff1b764b0c0e..00571de3390b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1526,6 +1526,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+	Opt_no_fc, Opt_fc_soft_consistency
 };
 
 static const match_table_t tokens = {
@@ -1609,6 +1610,8 @@ static const match_table_t tokens = {
 	{Opt_init_itable, "init_itable=%u"},
 	{Opt_init_itable, "init_itable"},
 	{Opt_noinit_itable, "noinit_itable"},
+	{Opt_no_fc, "no_fc"},
+	{Opt_fc_soft_consistency, "fc_soft_consistency"},
 	{Opt_max_dir_size_kb, "max_dir_size_kb=%u"},
 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
 	{Opt_nombcache, "nombcache"},
@@ -1731,6 +1734,7 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 #define MOPT_NO_EXT3	0x0200
 #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
 #define MOPT_STRING	0x0400
+#define MOPT_2		0x0800
 
 static const struct mount_opts {
 	int	token;
@@ -1823,6 +1827,10 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_no_fc, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
+	 MOPT_CLEAR | MOPT_2 | MOPT_EXT4_ONLY},
+	{Opt_fc_soft_consistency, EXT4_MOUNT2_JOURNAL_FC_SOFT_CONSISTENCY,
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 	{Opt_err, 0, 0}
 };
 
@@ -2113,10 +2121,17 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
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
2.25.1.481.gfbce0eb801-goog

