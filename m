Return-Path: <linux-ext4+bounces-4207-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFDB97BB9C
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D306DB230B0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF231891C0;
	Wed, 18 Sep 2024 11:26:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049E176248
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658804; cv=none; b=KwfxtHfhILiUKU7SDxsmXj7s0+QF6uMTDI/ceD/08E1L9neGps1Jr7epm1MCaamltPh1R1bPwsrHhEpUKafOjLPv7Y+MOjj/nucVeCSs8rZQOrUyHDL+anGgqqk2pbli0hJK/k7B6Q8uEKz8USuQTCpEdodWVj40wjCSJMS1wOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658804; c=relaxed/simple;
	bh=/obPIjfdVBv/SJjBrv7LSuavUku33y9tZYJKNghP6Cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSjaEXe/szIWxYIQc+9CKYaTApDoKkIgLBy9TD7ESkWQQj5PAPRBobRjiN/znan0rdIFsN5fVY3KnTQDN0x7bWzrlEbiZnZOuCj5JIeSe113kFqb0a18ij5UhB6ctKKvDfZxNN7UlhE7ASRamAQ/UWd6ud2eVDuGHOAqe/MIJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X7xDb3WNFz4f3jYJ
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 531BD1A08DC
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnsuOpmuiKqBg--.12650S8;
	Wed, 18 Sep 2024 19:26:39 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 4/5] jbd2: factor out jbd2_do_replay()
Date: Wed, 18 Sep 2024 19:36:03 +0800
Message-Id: <20240918113604.660640-5-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMnsuOpmuiKqBg--.12650S8
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyfWF4UKw1xtr18AF47Jwb_yoWxur4DpF
	1Yk390gr909r1IvF1IqFn8XrWag3W2ya4UGF1DCwnaya90yr1ag3s2qr90qFyYyry2vas0
	gF4rAa4DGw10kr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUcD73DUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Factor out jbd2_do_replay() no funtional change.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 219 +++++++++++++++++++++++----------------------
 1 file changed, 110 insertions(+), 109 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 0d697979d83e..05ea449b95c4 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -485,6 +485,105 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 		return tag->t_checksum == cpu_to_be16(csum32);
 }
 
+static __always_inline int jbd2_do_replay(journal_t *journal,
+					  struct recovery_info *info,
+					  struct buffer_head *bh,
+					  unsigned long *next_log_block,
+					  unsigned int next_commit_ID,
+					  int *success, int *block_error)
+{
+	char *tagp;
+	int flags;
+	int err;
+	int tag_bytes = journal_tag_bytes(journal);
+	int descr_csum_size = 0;
+	unsigned long io_block;
+	journal_block_tag_t tag;
+	struct buffer_head *obh;
+	struct buffer_head *nbh;
+
+	if (jbd2_journal_has_csum_v2or3(journal))
+		descr_csum_size = sizeof(struct jbd2_journal_block_tail);
+
+	tagp = &bh->b_data[sizeof(journal_header_t)];
+	while ((tagp - bh->b_data + tag_bytes) <=
+	       journal->j_blocksize - descr_csum_size) {
+
+		memcpy(&tag, tagp, sizeof(tag));
+		flags = be16_to_cpu(tag.t_flags);
+
+		io_block = (*next_log_block)++;
+		wrap(journal, *next_log_block);
+		err = jread(&obh, journal, io_block);
+		if (err) {
+			/* Recover what we can, but report failure at the end. */
+			*success = err;
+			pr_err("JBD2: IO error %d recovering block %lu in log\n",
+			      err, io_block);
+		} else {
+			unsigned long long blocknr;
+
+			J_ASSERT(obh != NULL);
+			blocknr = read_tag_block(journal, &tag);
+
+			/* If the block has been revoked, then we're all done here. */
+			if (jbd2_journal_test_revoke(journal, blocknr,
+						     next_commit_ID)) {
+				brelse(obh);
+				++info->nr_revoke_hits;
+				goto skip_write;
+			}
+
+			/* Look for block corruption */
+			if (!jbd2_block_tag_csum_verify(journal, &tag,
+				(journal_block_tag3_t *)tagp, obh->b_data,
+				next_commit_ID)) {
+				brelse(obh);
+				*success = -EFSBADCRC;
+				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
+				      blocknr, io_block);
+				*block_error = 1;
+				goto skip_write;
+			}
+
+			/* Find a buffer for the new data being restored */
+			nbh = __getblk(journal->j_fs_dev, blocknr,
+				       journal->j_blocksize);
+			if (nbh == NULL) {
+				pr_err("JBD2: Out of memory during recovery.\n");
+				brelse(obh);
+				return -ENOMEM;
+			}
+
+			lock_buffer(nbh);
+			memcpy(nbh->b_data, obh->b_data, journal->j_blocksize);
+			if (flags & JBD2_FLAG_ESCAPE) {
+				*((__be32 *)nbh->b_data) =
+				cpu_to_be32(JBD2_MAGIC_NUMBER);
+			}
+
+			BUFFER_TRACE(nbh, "marking dirty");
+			set_buffer_uptodate(nbh);
+			mark_buffer_dirty(nbh);
+			BUFFER_TRACE(nbh, "marking uptodate");
+			++info->nr_replays;
+			unlock_buffer(nbh);
+			brelse(obh);
+			brelse(nbh);
+		}
+
+skip_write:
+		tagp += tag_bytes;
+		if (!(flags & JBD2_FLAG_SAME_UUID))
+			tagp += 16;
+
+		if (flags & JBD2_FLAG_LAST_TAG)
+			break;
+	}
+
+	return 0;
+}
+
 static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
@@ -496,9 +595,7 @@ static int do_one_pass(journal_t *journal,
 	struct buffer_head	*bh = NULL;
 	unsigned int		sequence;
 	int			blocktype;
-	int			tag_bytes = journal_tag_bytes(journal);
 	__u32			crc32_sum = ~0; /* Transactional Checksums */
-	int			descr_csum_size = 0;
 	int			block_error = 0;
 	bool			need_check_commit_time = false;
 	__u64			last_trans_commit_time = 0, commit_time;
@@ -528,12 +625,6 @@ static int do_one_pass(journal_t *journal,
 	 */
 
 	while (1) {
-		int			flags;
-		char *			tagp;
-		journal_block_tag_t	tag;
-		struct buffer_head *	obh;
-		struct buffer_head *	nbh;
-
 		cond_resched();
 
 		/* If we already know where to stop the log traversal,
@@ -587,11 +678,7 @@ static int do_one_pass(journal_t *journal,
 		switch(blocktype) {
 		case JBD2_DESCRIPTOR_BLOCK:
 			/* Verify checksum first */
-			if (jbd2_journal_has_csum_v2or3(journal))
-				descr_csum_size =
-					sizeof(struct jbd2_journal_block_tail);
-			if (descr_csum_size > 0 &&
-			    !jbd2_descriptor_block_csum_verify(journal,
+			if (!jbd2_descriptor_block_csum_verify(journal,
 							       bh->b_data)) {
 				/*
 				 * PASS_SCAN can see stale blocks due to lazy
@@ -628,102 +715,16 @@ static int do_one_pass(journal_t *journal,
 				continue;
 			}
 
-			/* A descriptor block: we can now write all of
-			 * the data blocks.  Yay, useful work is finally
-			 * getting done here! */
-
-			tagp = &bh->b_data[sizeof(journal_header_t)];
-			while ((tagp - bh->b_data + tag_bytes)
-			       <= journal->j_blocksize - descr_csum_size) {
-				unsigned long io_block;
-
-				memcpy(&tag, tagp, sizeof(tag));
-				flags = be16_to_cpu(tag.t_flags);
-
-				io_block = next_log_block++;
-				wrap(journal, next_log_block);
-				err = jread(&obh, journal, io_block);
-				if (err) {
-					/* Recover what we can, but
-					 * report failure at the end. */
-					success = err;
-					printk(KERN_ERR
-						"JBD2: IO error %d recovering "
-						"block %lu in log\n",
-						err, io_block);
-				} else {
-					unsigned long long blocknr;
-
-					J_ASSERT(obh != NULL);
-					blocknr = read_tag_block(journal,
-								 &tag);
-
-					/* If the block has been
-					 * revoked, then we're all done
-					 * here. */
-					if (jbd2_journal_test_revoke
-					    (journal, blocknr,
-					     next_commit_ID)) {
-						brelse(obh);
-						++info->nr_revoke_hits;
-						goto skip_write;
-					}
-
-					/* Look for block corruption */
-					if (!jbd2_block_tag_csum_verify(
-			journal, &tag, (journal_block_tag3_t *)tagp,
-			obh->b_data, be32_to_cpu(tmp->h_sequence))) {
-						brelse(obh);
-						success = -EFSBADCRC;
-						printk(KERN_ERR "JBD2: Invalid "
-						       "checksum recovering "
-						       "data block %llu in "
-						       "journal block %lu\n",
-						       blocknr, io_block);
-						block_error = 1;
-						goto skip_write;
-					}
-
-					/* Find a buffer for the new
-					 * data being restored */
-					nbh = __getblk(journal->j_fs_dev,
-							blocknr,
-							journal->j_blocksize);
-					if (nbh == NULL) {
-						printk(KERN_ERR
-						       "JBD2: Out of memory "
-						       "during recovery.\n");
-						err = -ENOMEM;
-						brelse(obh);
-						goto failed;
-					}
-
-					lock_buffer(nbh);
-					memcpy(nbh->b_data, obh->b_data,
-							journal->j_blocksize);
-					if (flags & JBD2_FLAG_ESCAPE) {
-						*((__be32 *)nbh->b_data) =
-						cpu_to_be32(JBD2_MAGIC_NUMBER);
-					}
-
-					BUFFER_TRACE(nbh, "marking dirty");
-					set_buffer_uptodate(nbh);
-					mark_buffer_dirty(nbh);
-					BUFFER_TRACE(nbh, "marking uptodate");
-					++info->nr_replays;
-					unlock_buffer(nbh);
-					brelse(obh);
-					brelse(nbh);
-				}
-
-			skip_write:
-				tagp += tag_bytes;
-				if (!(flags & JBD2_FLAG_SAME_UUID))
-					tagp += 16;
-
-				if (flags & JBD2_FLAG_LAST_TAG)
-					break;
-			}
+			/*
+			 * A descriptor block: we can now write all of the
+			 * data blocks. Yay, useful work is finally getting
+			 * done here!
+			 */
+			err = jbd2_do_replay(journal, info, bh, &next_log_block,
+					     next_commit_ID, &success,
+					     &block_error);
+			if (err)
+				goto failed;
 
 			continue;
 
-- 
2.31.1


