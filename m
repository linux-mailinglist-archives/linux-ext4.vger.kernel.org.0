Return-Path: <linux-ext4+bounces-4203-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E94297BB98
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D3D1F268FA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455F183CDB;
	Wed, 18 Sep 2024 11:26:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E173266D4
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658803; cv=none; b=Cu5Ya3OERdsNna6Qj/gS8Pr7k3Z4naaw4AQ1T+i2dVgr90exOg+XSS2hgpP9P4q4Ai4jstCdh6vX/PvFJ4g8aGFZ//vS31abzFH0xUxgy3CqUjTk8b/jhIutclzbOQOtLxnyzMMJfKbCRpxFvgj0VIiKB3h0+9qF3TwJF/u6pBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658803; c=relaxed/simple;
	bh=h8c11Y5XLAzibBI5SiBMt1Vxragi6MmO1DZBrxIOSic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsVlMg5JmQK7LHwekuKHBD1bH1JUnWfZ+kSHWQofnN91UcOconbadJAlSy/Z8i/EJgu07cDx7u927YcJ2cM8SFVUcUBlqxYg8z5kxhXGDOv3Hpm1rlAUkcFXH0XF9yuNOmhkEA1+lZKrkYA5CCmlxoFq/vwEOP2HMLSxuTWBwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X7xDZ1Bs2z4f3lV7
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BE2731A0C23
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnsuOpmuiKqBg--.12650S6;
	Wed, 18 Sep 2024 19:26:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 2/5] jbd2: unified release of buffer_head in do_one_pass()
Date: Wed, 18 Sep 2024 19:36:01 +0800
Message-Id: <20240918113604.660640-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240918113604.660640-1-yebin@huaweicloud.com>
References: <20240918113604.660640-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMnsuOpmuiKqBg--.12650S6
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8Gr18tr4kWrWkJryxKrg_yoWrCrWUpw
	sxGrWkuFyqvw1ayas7tFZ8XrWjvF4jyFyUWF1q93Zayw43trnrt34Iqr1ftFW5JFWfZas5
	XF4rAw1qkw1rKa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	7PfHUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Now buffer_head free is very fragmented in do_one_pass(), unified release
of buffer_head in do_one_pass()

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 5efbca6a98c4..0adf0cb31a03 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -493,7 +493,7 @@ static int do_one_pass(journal_t *journal,
 	int			err, success = 0;
 	journal_superblock_t *	sb;
 	journal_header_t *	tmp;
-	struct buffer_head *	bh;
+	struct buffer_head	*bh = NULL;
 	unsigned int		sequence;
 	int			blocktype;
 	int			tag_bytes = journal_tag_bytes(journal);
@@ -552,6 +552,8 @@ static int do_one_pass(journal_t *journal,
 		 * record. */
 
 		jbd2_debug(3, "JBD2: checking block %ld\n", next_log_block);
+		brelse(bh);
+		bh = NULL;
 		err = jread(&bh, journal, next_log_block);
 		if (err)
 			goto failed;
@@ -567,20 +569,16 @@ static int do_one_pass(journal_t *journal,
 
 		tmp = (journal_header_t *)bh->b_data;
 
-		if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER)) {
-			brelse(bh);
+		if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER))
 			break;
-		}
 
 		blocktype = be32_to_cpu(tmp->h_blocktype);
 		sequence = be32_to_cpu(tmp->h_sequence);
 		jbd2_debug(3, "Found magic %d, sequence %d\n",
 			  blocktype, sequence);
 
-		if (sequence != next_commit_ID) {
-			brelse(bh);
+		if (sequence != next_commit_ID)
 			break;
-		}
 
 		/* OK, we have a valid descriptor block which matches
 		 * all of the sequence number checks.  What are we going
@@ -603,7 +601,6 @@ static int do_one_pass(journal_t *journal,
 					pr_err("JBD2: Invalid checksum recovering block %lu in log\n",
 					       next_log_block);
 					err = -EFSBADCRC;
-					brelse(bh);
 					goto failed;
 				}
 				need_check_commit_time = true;
@@ -622,16 +619,12 @@ static int do_one_pass(journal_t *journal,
 				    !info->end_transaction) {
 					if (calc_chksums(journal, bh,
 							&next_log_block,
-							&crc32_sum)) {
-						put_bh(bh);
+							&crc32_sum))
 						break;
-					}
-					put_bh(bh);
 					continue;
 				}
 				next_log_block += count_tags(journal, bh);
 				wrap(journal, next_log_block);
-				put_bh(bh);
 				continue;
 			}
 
@@ -701,7 +694,6 @@ static int do_one_pass(journal_t *journal,
 						       "JBD2: Out of memory "
 						       "during recovery.\n");
 						err = -ENOMEM;
-						brelse(bh);
 						brelse(obh);
 						goto failed;
 					}
@@ -733,7 +725,6 @@ static int do_one_pass(journal_t *journal,
 					break;
 			}
 
-			brelse(bh);
 			continue;
 
 		case JBD2_COMMIT_BLOCK:
@@ -781,7 +772,6 @@ static int do_one_pass(journal_t *journal,
 					pr_err("JBD2: Invalid checksum found in transaction %u\n",
 					       next_commit_ID);
 					err = -EFSBADCRC;
-					brelse(bh);
 					goto failed;
 				}
 			ignore_crc_mismatch:
@@ -791,7 +781,6 @@ static int do_one_pass(journal_t *journal,
 				 */
 				jbd2_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
 					  next_commit_ID);
-				brelse(bh);
 				goto done;
 			}
 
@@ -811,7 +800,6 @@ static int do_one_pass(journal_t *journal,
 				if (info->end_transaction) {
 					journal->j_failed_commit =
 						info->end_transaction;
-					brelse(bh);
 					break;
 				}
 
@@ -847,7 +835,6 @@ static int do_one_pass(journal_t *journal,
 				if (!jbd2_has_feature_async_commit(journal)) {
 					journal->j_failed_commit =
 						next_commit_ID;
-					brelse(bh);
 					break;
 				}
 			}
@@ -856,7 +843,6 @@ static int do_one_pass(journal_t *journal,
 				last_trans_commit_time = commit_time;
 				head_block = next_log_block;
 			}
-			brelse(bh);
 			next_commit_ID++;
 			continue;
 
@@ -875,14 +861,11 @@ static int do_one_pass(journal_t *journal,
 
 			/* If we aren't in the REVOKE pass, then we can
 			 * just skip over this block. */
-			if (pass != PASS_REVOKE) {
-				brelse(bh);
+			if (pass != PASS_REVOKE)
 				continue;
-			}
 
 			err = scan_revoke_records(journal, bh,
 						  next_commit_ID, info);
-			brelse(bh);
 			if (err)
 				goto failed;
 			continue;
@@ -890,12 +873,12 @@ static int do_one_pass(journal_t *journal,
 		default:
 			jbd2_debug(3, "Unrecognised magic %d, end of scan.\n",
 				  blocktype);
-			brelse(bh);
 			goto done;
 		}
 	}
 
  done:
+	brelse(bh);
 	/*
 	 * We broke out of the log scan loop: either we came to the
 	 * known end of the log or we found an unexpected block in the
@@ -931,6 +914,7 @@ static int do_one_pass(journal_t *journal,
 	return success;
 
  failed:
+	brelse(bh);
 	return err;
 }
 
-- 
2.31.1


