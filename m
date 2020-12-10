Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E222D6430
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391636AbgLJR5n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392987AbgLJR5X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:23 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF6C0613D6
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:39 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 11so4822933pfu.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZiVmqQOrVgEJyWBc4dZ1VPDv6H/5e61lpzqdMyTEXc=;
        b=nIgdCS/YbYRD1Y5We5goQes/MHjsDzXm4hgJfqsNTRCm7KlI3TCw+TC3/fy81lJqPF
         XUHRXibZ6nGkU8AcAx/3a7sJU97DUvp0GKuJ+TOHkgtI+pVglpl+o4Qn9updJ/nD11dR
         DWUHsHKOiHqyJ96Thj7nXVF38TaFker3KCbjjuSNU1D0NNYPhxb5GAiWoMV5u4iqGlIS
         g1+57AqrMSA2FQHTO+B43d2ieTeQiYoc03vakjXHMKYFbeTkhqxC8In/+EJ4q9UI7/I9
         qSiPJlTVPtCVoj3gWCIWBy1Z2UsdQd8KiZL8BW6OULIuKb/CiqFQGqL1LqlyD7f54vWT
         3pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZiVmqQOrVgEJyWBc4dZ1VPDv6H/5e61lpzqdMyTEXc=;
        b=d9a/ARQLMtG20RYz4TR7Dv8Sl2X9HVIkiIZpuv77NmC7vi6SLHN0sKIf2W6n7FJAv6
         lcQhWS8NrcJ566/yV98Sq4V193M6x+t5b29/N5lkVRN7sToJ0i960D1CmCKB1u7hi7rW
         kRP1134wz4wSGHQIVMLAxMmwTMVuOn19x2WNmswZquZ4zJQcXoDvfVJ3X9qBuAiUhHYr
         FQ9B5sl5smjoNW3Bx9r4B4+EGOCfAys/ATtvwjf4DrwrLT6io414x2BBd8EUVian0BmW
         6S0SwbuDkNv4ibwDoGb7LbsN8B5LM8+DqvpuGjIbipU0qNi2KK6cpxdCo1Ded0a2QHRU
         phOg==
X-Gm-Message-State: AOAM531fyFudDQFtXs0a7OuQBqAMbt3DEjkREP8f3/GuVickZYDe1AAy
        xEOeMSa9Gpc3Z3dEq0aKtWuu6nKL61E=
X-Google-Smtp-Source: ABdhPJx6i81o4j2O5kbCTGErdjgOcqIuZHBCupo6BjPJoZduZqW5jqFK6sszzOAjAy+YXHjNA9TOGQ==
X-Received: by 2002:a63:484d:: with SMTP id x13mr7743647pgk.301.1607622998963;
        Thu, 10 Dec 2020 09:56:38 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:37 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 02/15] e2fsck: add kernel endian-ness conversion macros
Date:   Thu, 10 Dec 2020 09:55:55 -0800
Message-Id: <20201210175608.3265541-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
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
2.29.2.576.ga3fc446d84-goog

