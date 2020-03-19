Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8418C3CA
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 00:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCSXe7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 19:34:59 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33995 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCSXe4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 19:34:56 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so2769402pje.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mj7OFZwrfhOXF3ByA18DmF1RCmQ9wJF/07djy/h3h1Q=;
        b=I1+zZDWAqpvc+rkNVeHFN1JBM8+b2YInpL63iJ0+GoTBFOcTddD8Eq944fIUpJAa73
         IBvi8sRZ9cC4lAaZN+KWPL5X2EY6PWNJ01vdFQ/oCLSWnVMkXKG1JUte9+5GeDVkV4Kj
         gOzcybZPBC6H0wjghI6ZLv7N3hATXeW6SmJ9T+StlUA4rzKdnYj9GwS9kNkDGPu0egv8
         uTd5g4a8Jg2jiIc2iTlvdUxZL388HDRRdMT5IvAt6NtyXOFol1UEoNb/besg+hpd6qJW
         WRpWi5+maOtoG9qiSxdwPjMf6uvVX5fpOipu7dxU/S77tsT/jG+qmbIoPI3i9+x2dmtX
         5YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mj7OFZwrfhOXF3ByA18DmF1RCmQ9wJF/07djy/h3h1Q=;
        b=dbgSWFGWEvI1FuDH5PlNRtCzOWC8jNp+3/Ika+v78RlyoVKRFomO6VzX6TNjvTy9YA
         qC/HTfDOeYz4Ztp4h0RI9nmX+MfLBb0aVUrY9eC2JqP7HY+GRyqsURjBFAngu6BRKK1D
         br4eDanULTsjwbNpiJBGNBMVz46ud1okvmPUgv5PN/+DMVEDQFj7VF3D0Bm5gnmiC7Jp
         maMSCNnKgDujfwU3nEI3LZTEdgNo7OYW3kIRc6QYSY7GDJwhL4lgrpYyIOcULawd7Ps7
         WnXTxinJ3p1368z48+n5f1b5yVgoh4BUhlQ6JWHkCsIEw1CAq11Dv1fJ3eo4x3gtRVbL
         SapQ==
X-Gm-Message-State: ANhLgQ0fMmRg6MJEi8JY4fhc1iLF+rzl3YEr37wuik2/goC/oVZW6xq4
        7GwBuYeSNPXda3WMB0HrbLIL1VES
X-Google-Smtp-Source: ADFU+vszUEItV5DCb/+ry6VN4Tj2mIqSzwGQyzP27HpkF/zCoFX0d+t5WP/GWOLnOneqHRMIyvTPZA==
X-Received: by 2002:a17:90a:4487:: with SMTP id t7mr6292807pjg.104.1584660894582;
        Thu, 19 Mar 2020 16:34:54 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id j17sm204353pga.18.2020.03.19.16.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:34:54 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 5/7] e2fsck/jbd2: fast commit recovery changes
Date:   Thu, 19 Mar 2020 16:34:31 -0700
Message-Id: <20200319233433.117144-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
References: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Backport changes from kernel/fs/jbd2 related to fast commit recovery
path. This just allows jbd2 machinery to call a file-system specific
replay handler.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/recovery.c       | 67 ++++++++++++++++++++++++++++++++++++++---
 lib/ext2fs/jfs_compat.h |  9 ++++++
 lib/ext2fs/kernel-jbd.h |  2 ++
 3 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 4750f9c1..18ad79d6 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -35,7 +35,6 @@ struct recovery_info
 	int		nr_revoke_hits;
 };
 
-enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
 static int scan_revoke_records(journal_t *, struct buffer_head *,
@@ -225,10 +224,63 @@ static int count_tags(journal_t *journal, struct buffer_head *bh)
 /* Make sure we wrap around the log correctly! */
 #define wrap(journal, var)						\
 do {									\
-	if (var >= (journal)->j_last)					\
-		var -= ((journal)->j_last - (journal)->j_first);	\
+	unsigned long _wrap_last =					\
+		jbd2_has_feature_fast_commit(journal) ?			\
+			(journal)->j_last_fc : (journal)->j_last;	\
+									\
+	if (var >= _wrap_last)						\
+		var -= (_wrap_last - (journal)->j_first);		\
 } while (0)
 
+static int fc_do_one_pass(journal_t *journal,
+			  struct recovery_info *info, enum passtype pass)
+{
+	unsigned int expected_commit_id = info->end_transaction;
+	unsigned long next_fc_block;
+	struct buffer_head *bh;
+	unsigned int seq;
+	journal_header_t *jhdr;
+	int err = 0;
+
+	next_fc_block = journal->j_first_fc;
+
+	while (next_fc_block <= journal->j_last_fc) {
+		jbd_debug(3, "Fast commit replay: next block %ld",
+			  next_fc_block);
+		err = jread(&bh, journal, next_fc_block);
+		if (err) {
+			jbd_debug(3, "Fast commit replay: read error");
+			break;
+		}
+
+		jhdr = (journal_header_t *)bh->b_data;
+		seq = be32_to_cpu(jhdr->h_sequence);
+		if (be32_to_cpu(jhdr->h_magic) != JBD2_MAGIC_NUMBER ||
+		    seq != expected_commit_id) {
+			jbd_debug(3, "Fast commit replay: magic / commitid error [%d / %d / %d]\n",
+				  be32_to_cpu(jhdr->h_magic), seq,
+				  expected_commit_id);
+			break;
+		}
+		jbd_debug(3, "Processing fast commit blk with seq %d",
+			  seq);
+		if (journal->j_fc_replay_callback) {
+			err = journal->j_fc_replay_callback(
+						journal, bh, pass,
+						next_fc_block -
+						journal->j_first_fc);
+			if (err)
+				break;
+		}
+		next_fc_block++;
+	}
+
+	if (err)
+		jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
+
+	return err;
+}
+
 /**
  * jbd2_journal_recover - recovers a on-disk journal
  * @journal: the journal to recover
@@ -470,7 +522,7 @@ static int do_one_pass(journal_t *journal,
 				break;
 
 		jbd_debug(2, "Scanning for sequence ID %u at %lu/%lu\n",
-			  next_commit_ID, next_log_block, journal->j_last);
+			  next_commit_ID, next_log_block, journal->j_last_fc);
 
 		/* Skip over each chunk of the transaction looking
 		 * either the next descriptor block or the final commit
@@ -765,6 +817,9 @@ static int do_one_pass(journal_t *journal,
 			if (err)
 				goto failed;
 			continue;
+		case JBD2_FC_BLOCK:
+			pr_warn("Unexpectedly found fast commit block.\n");
+			continue;
 
 		default:
 			jbd_debug(3, "Unrecognised magic %d, end of scan.\n",
@@ -796,6 +851,10 @@ static int do_one_pass(journal_t *journal,
 				success = -EIO;
 		}
 	}
+
+	if (jbd2_has_feature_fast_commit(journal) && pass != PASS_REVOKE)
+		success = fc_do_one_pass(journal, info, pass);
+
 	if (block_error && success == 0)
 		success = -EIO;
 	return success;
diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index 2bda521d..20c0785f 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -64,6 +64,8 @@ static inline __u32 jbd2_chksum(journal_t *j EXT2FS_ATTR((unused)),
 #define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))
 #define pr_emerg(fmt)
 
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
 struct journal_s
 {
 	unsigned long		j_flags;
@@ -73,6 +75,9 @@ struct journal_s
 	int			j_format_version;
 	unsigned long		j_head;
 	unsigned long		j_tail;
+	unsigned long		j_first_fc;
+	unsigned long		j_fc_off;
+	unsigned long		j_last_fc;
 	unsigned long		j_free;
 	unsigned long		j_first, j_last;
 	kdev_t			j_dev;
@@ -88,6 +93,10 @@ struct journal_s
 	struct jbd2_revoke_table_s *j_revoke_table[2];
 	tid_t			j_failed_commit;
 	__u32			j_csum_seed;
+	int (*j_fc_replay_callback)(struct journal_s *journal,
+				    struct buffer_head *bh,
+				    enum passtype pass, int off);
+
 };
 
 #define is_journal_abort(x) 0
diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
index 1250f5f0..2dcc5bcc 100644
--- a/lib/ext2fs/kernel-jbd.h
+++ b/lib/ext2fs/kernel-jbd.h
@@ -74,6 +74,7 @@ extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), 1)
 
 #define JBD2_MIN_JOURNAL_BLOCKS 1024
+#define JBD2_FAST_COMMIT_BLOCKS 128
 
 /*
  * Internal structures used by the logging mechanism:
@@ -94,6 +95,7 @@ extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
 #define JBD2_SUPERBLOCK_V1	3
 #define JBD2_SUPERBLOCK_V2	4
 #define JBD2_REVOKE_BLOCK	5
+#define JBD2_FC_BLOCK		6
 
 /*
  * Standard header for all descriptor blocks:
-- 
2.25.1.696.g5e7596f4ac-goog

