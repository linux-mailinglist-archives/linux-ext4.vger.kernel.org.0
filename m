Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E62FDDEB
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jan 2021 01:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393184AbhAUA3x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 19:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732729AbhATVbc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 16:31:32 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82295C0617A4
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j12so2992553pjy.5
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lNzPm//SZtLeN4eAjYSZAukTjwJcbPKxREuGSCv4z0=;
        b=bdG6/sxto/vqy2mGN2IZVrFnDdETD+V6BIPUWoSmxaQKOxkfdJAdfWONfPNhcYegbi
         UIon7YIB905qCDwV5gFOtAoNhHWumq8aEwJSqtjxA39kIdAdWev8HAFk7xM6imSCXPfh
         bmY0OJ0mCrbj3BdDXe8PhJ9Zw7kTs2iBGy7E8/9R3ztLFpWkfzyGuIsNYyzh8sv2Mkef
         CtwjzXZhoBoiC74hw8iSrq0ms7nnvHKlu8eivyVs5nhg/bYjqzqfoLLVAO3Y1GMNFYen
         lKO2blIDnSbR67aKjFeiM+oCUaWErArhICJItPuPsHkd2eYF9P1eVcvNt7IVgvfTlZQ/
         O6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lNzPm//SZtLeN4eAjYSZAukTjwJcbPKxREuGSCv4z0=;
        b=E3Ia+gepMqUKYewzxUmixyAPyEZHZjP6ql9lAjRHbtqSXlPJzKSCtpexivP4TyJShQ
         DM6ymgPhkeKhdiJ1njjszBTcoAf7PCT+P5VMZZHnRBgYs73BIQuetJRuoFC0W9Dv43jg
         BXnZj9DrSfdhn9uhx4dtq4uUgVjJceBDdNLKPAeuBjcDCy3NAqmXhtTlvdGMch0m+zlb
         nLWmZYFP+XJXDCGNxqExHkEIh60GGkCrFoBRQP+rnAozO7wWTDt63T/4+tinGSzm8syE
         Goa7XmzGIEvcGiWDMp4BA76z+/wrlptHpXdC+NFeWBn5O909RupRppAzM/lTeHEU3sVT
         zt+A==
X-Gm-Message-State: AOAM533/H21Zv1fMBJOG0ABG46GZuiEMK8KMUM+R3tK3tb4jjqOPZW/7
        +YAfCvlK1LVvkBsXuBPA2uwgZEr6du0=
X-Google-Smtp-Source: ABdhPJzXryKrW3e9p6oG6mqb7uBy4GhqRL7bPVthiFkMtIOJ60FPKVg/Gtdkl6Qgwoins3sompfp0w==
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr7599826pjb.41.1611178008606;
        Wed, 20 Jan 2021 13:26:48 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id w1sm3396758pjt.23.2021.01.20.13.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:47 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v3 02/15] e2fsck: add kernel endian-ness conversion macros
Date:   Wed, 20 Jan 2021 13:26:28 -0800
Message-Id: <20210120212641.526556-3-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
References: <20210120212641.526556-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

In order to make recovery.c identical with kernel, we need endianness
conversion macros (such as cpu_to_be32 and friends) defined in
e2fsprogs. This patch defines these macros and also fixes recovery.c
to use these. These macros are also needed for fast commit recovery
patches later in this series.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 e2fsck/recovery.c       | 42 ++++++++++-------------------------------
 lib/ext2fs/jfs_compat.h |  6 ++++++
 2 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 5df690ad..6c3b7bb4 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -121,27 +121,6 @@ failed:
 
 #endif /* __KERNEL__ */
 
-static inline __u32 get_be32(__be32 *p)
-{
-	unsigned char *cp = (unsigned char *) p;
-	__u32 ret;
-
-	ret = *cp++;
-	ret = (ret << 8) + *cp++;
-	ret = (ret << 8) + *cp++;
-	ret = (ret << 8) + *cp++;
-	return ret;
-}
-
-static inline __u16 get_be16(__be16 *p)
-{
-	unsigned char *cp = (unsigned char *) p;
-	__u16 ret;
-
-	ret = *cp++;
-	ret = (ret << 8) + *cp++;
-	return ret;
-}
 
 /*
  * Read a block from the journal
@@ -232,10 +211,10 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 
 		nr++;
 		tagp += tag_bytes;
-		if (!(get_be16(&tag->t_flags) & JBD2_FLAG_SAME_UUID))
+		if (!(tag->t_flags & cpu_to_be16(JBD2_FLAG_SAME_UUID)))
 			tagp += 16;
 
-		if (get_be16(&tag->t_flags) & JBD2_FLAG_LAST_TAG)
+		if (tag->t_flags & cpu_to_be16(JBD2_FLAG_LAST_TAG))
 			break;
 	}
 
@@ -358,9 +337,9 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 static inline unsigned long long read_tag_block(journal_t *journal,
 						journal_block_tag_t *tag)
 {
-	unsigned long long block = get_be32(&tag->t_blocknr);
+	unsigned long long block = be32_to_cpu(tag->t_blocknr);
 	if (jbd2_has_feature_64bit(journal))
-		block |= (u64)get_be32(&tag->t_blocknr_high) << 32;
+		block |= (u64)be32_to_cpu(tag->t_blocknr_high) << 32;
 	return block;
 }
 
@@ -429,9 +408,9 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 	csum32 = jbd2_chksum(j, csum32, buf, j->j_blocksize);
 
 	if (jbd2_has_feature_csum3(j))
-		return get_be32(&tag3->t_checksum) == csum32;
-
-	return get_be16(&tag->t_checksum) == (csum32 & 0xFFFF);
+		return tag3->t_checksum == cpu_to_be32(csum32);
+	else
+		return tag->t_checksum == cpu_to_be16(csum32);
 }
 
 static int do_one_pass(journal_t *journal,
@@ -579,7 +558,7 @@ static int do_one_pass(journal_t *journal,
 				unsigned long io_block;
 
 				tag = (journal_block_tag_t *) tagp;
-				flags = get_be16(&tag->t_flags);
+				flags = be16_to_cpu(tag->t_flags);
 
 				io_block = next_log_block++;
 				wrap(journal, next_log_block);
@@ -643,9 +622,8 @@ static int do_one_pass(journal_t *journal,
 					memcpy(nbh->b_data, obh->b_data,
 							journal->j_blocksize);
 					if (flags & JBD2_FLAG_ESCAPE) {
-						__be32 magic = cpu_to_be32(JBD2_MAGIC_NUMBER);
-						memcpy(nbh->b_data, &magic,
-						       sizeof(magic));
+						*((__be32 *)nbh->b_data) =
+						cpu_to_be32(JBD2_MAGIC_NUMBER);
 					}
 
 					BUFFER_TRACE(nbh, "marking dirty");
diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index 2bda521d..63ebef99 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -20,12 +20,18 @@
 #define REQ_OP_READ 0
 #define REQ_OP_WRITE 1
 
+#define cpu_to_le16(x)	ext2fs_cpu_to_le16(x)
 #define cpu_to_be16(x)	ext2fs_cpu_to_be16(x)
+#define cpu_to_le32(x)	ext2fs_cpu_to_le32(x)
 #define cpu_to_be32(x)	ext2fs_cpu_to_be32(x)
+#define cpu_to_le64(x)	ext2fs_cpu_to_le64(x)
 #define cpu_to_be64(x)	ext2fs_cpu_to_be64(x)
 
+#define le16_to_cpu(x)	ext2fs_le16_to_cpu(x)
 #define be16_to_cpu(x)	ext2fs_be16_to_cpu(x)
+#define le32_to_cpu(x)	ext2fs_le32_to_cpu(x)
 #define be32_to_cpu(x)	ext2fs_be32_to_cpu(x)
+#define le64_to_cpu(x)	ext2fs_le64_to_cpu(x)
 #define be64_to_cpu(x)	ext2fs_be64_to_cpu(x)
 
 typedef unsigned int tid_t;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

