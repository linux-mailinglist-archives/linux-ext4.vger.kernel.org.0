Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783E418C3C5
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 00:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCSXez (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 19:34:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38557 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSXey (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 19:34:54 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so1681364pje.3
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 16:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fG/K9Cjw0HryEc/nJ3z/N7pH4b8SVAzXaGVlh9dZlf0=;
        b=lE3OTSFhCLDAz0UrfwkVuflfqva2ksgAmU+aNUJywlGvCVdA2j31ZMNv7ICj0EV+sX
         VKynPTKg4dymJceJ2ubbsTuYRHmH2n1zYVNkxmDogpRyZT74YU2T4jVejOcXp4SULDxK
         1J8IkUXYXqZRye3EzCP2/64XOwwlUDNwY6OpSx3h31JKuXly8KPg/Bq9jjCELNjpUKN4
         g4bFoOuvVraQksoKnrmIoCZ4i5TLJqSm5eZqSLfm2d2Ah9Iwl6akiIcf1jKxZ09IxTaF
         joHkeB/XfoQhdBzwA5rXtVc/Znzm5k+uCM8Z3eemSGR7/7Qhwngo/JDDweAyKTHaNTC/
         mSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fG/K9Cjw0HryEc/nJ3z/N7pH4b8SVAzXaGVlh9dZlf0=;
        b=i4vEe0mBOFle+EAmaffcOFekjH8LTn1bwZKi2zJJCsBVNiC5eWYPfPcMUOOftj4pd/
         53fYzuqpU8ffblHtE4uPl+BJku3ZE/sJNFzSS8cjjxlgnVpNeijemsMtzbP94YIh7Vrr
         aiAlhtnXSeTxWbwHpFYdhhMMKOVZCjVmD84Db+oCidOfipW/1KPdJNC5Fd9unL2KnUtA
         Nnxhkd/tTbx/B99UWk4jd3g3gX5y011HwMT9G+6snYJvDGpl23v/z1b3CQRMEy20d0Hj
         XCwG7dnLFgvvVXt9G3pLxsRwBiOngCEVBYrGC6auewyFCJV7bcH/S2xqXg35sZ2DgpfX
         C5kg==
X-Gm-Message-State: ANhLgQ2hOpc7d4OTZ/n4andUH7741/4fKRIS7D05eK8VMTuRBVK9sHGr
        VaIoIiv3CmNKuO1VzkLHgsOh1ayh
X-Google-Smtp-Source: ADFU+vvAHUO8UMiQ10xZMXvg/nrGuh2+tstWUkC4Q0qI0BHRdQxxi4/9rvcTAu3WJ/JA4S+oCutecg==
X-Received: by 2002:a17:90b:311:: with SMTP id ay17mr6436542pjb.27.1584660891686;
        Thu, 19 Mar 2020 16:34:51 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id j17sm204353pga.18.2020.03.19.16.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:34:51 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/7] e2fsck: make recovery.c identical with kernel
Date:   Thu, 19 Mar 2020 16:34:27 -0700
Message-Id: <20200319233433.117144-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
References: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add endianness conversion macros identical to Kernel and fix differences
between Kernel's and e2fsprogs's recovery.c to make them identical.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/jfs_user.h |  9 +++++++++
 e2fsck/recovery.c | 46 ++++++++++++----------------------------------
 2 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/e2fsck/jfs_user.h b/e2fsck/jfs_user.h
index a97fcc18..62a3e8a8 100644
--- a/e2fsck/jfs_user.h
+++ b/e2fsck/jfs_user.h
@@ -267,4 +267,13 @@ extern int	jbd2_journal_set_revoke(journal_t *, unsigned long long, tid_t);
 extern int	jbd2_journal_test_revoke(journal_t *, unsigned long long, tid_t);
 extern void	jbd2_journal_clear_revoke(journal_t *);
 
+/* Macros for kernel compatibility */
+#define be32_to_cpu(x)		ext2fs_be32_to_cpu(x)
+#define cpu_to_be32(x)		ext2fs_cpu_to_be32(x)
+#define cpu_to_be16(x)		ext2fs_cpu_to_be16(x)
+#define le16_to_cpu(x)		ext2fs_le16_to_cpu(x)
+#define le32_to_cpu(x)		ext2fs_le32_to_cpu(x)
+
+#define pr_warn(...)
+
 #endif /* _JFS_USER_H */
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 5df690ad..4750f9c1 100644
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
@@ -201,7 +180,7 @@ static int jbd2_descriptor_block_csum_verify(journal_t *j, void *buf)
 	if (!jbd2_journal_has_csum_v2or3(j))
 		return 1;
 
-	tail = (struct jbd2_journal_block_tail *)((char *)buf + j->j_blocksize -
+	tail = (struct jbd2_journal_block_tail *)(buf + j->j_blocksize -
 			sizeof(struct jbd2_journal_block_tail));
 	provided = tail->t_checksum;
 	tail->t_checksum = 0;
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
@@ -833,7 +811,7 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 {
 	jbd2_journal_revoke_header_t *header;
 	int offset, max;
-	unsigned csum_size = 0;
+	int csum_size = 0;
 	__u32 rcount;
 	int record_len = 4;
 
-- 
2.25.1.696.g5e7596f4ac-goog

