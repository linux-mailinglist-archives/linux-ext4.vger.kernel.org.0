Return-Path: <linux-ext4+bounces-2905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95F90FD55
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 09:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327101C23E2D
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F842A9E;
	Thu, 20 Jun 2024 07:12:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8E4086A
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718867559; cv=none; b=N5hfLNJLV1iIp/nEPv4x7E/k2yeb29fYitMP6fh+3DhTfTXcW1eqP9gc85av3+jsieS4JYSBIcHzk93QxD9Ipm1KiI4pxQsydONi+6LxbTq/2jkZHj5MQskLECIvExqWB647NzimHDGaixDL8UHyCUJDMidviH882eqRxaxEJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718867559; c=relaxed/simple;
	bh=iA/UaKf354O1aAHKKv4lBaPYHkbDEceIAhveCqPaBI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NdRfSSgeF9VKsJbDTQ3pOGWkpo9A8EmpMcdgXj7Q8RwCx8lccVQaG3Mflbtuy710sf8SIkl8bHQpAOGdMNaWpXmqkGyN2WEn3Gid9D3IxKaZW8uzCdrMvG/xxOiBptYh+FZOc+qLUFE2gO5uUBpM3wLxeh5yVxAqAUTrKhbayMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W4Ws23ylPz4f3jd1
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 15:12:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 076FA1A058E
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 15:12:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgC3aghe1nNmQdfMAQ--.33564S4;
	Thu, 20 Jun 2024 15:12:32 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	Ye Bin <yebin10@huawei.com>
Subject: [PATCH v4] jbd2: avoid mount failed when commit block is partial submitted
Date: Thu, 20 Jun 2024 15:24:05 +0800
Message-Id: <20240620072405.3533701-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3aghe1nNmQdfMAQ--.33564S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCryxGrWxAr1fWFyUXF1DWrg_yoW5XrWDpw
	4Uu3Z8KFWq9r12vFn3Jr4DXFya9w1vyFyUWrsF9wn5ZasxGrZFgr97KFyaqryrtF93Aasa
	9F1YyrWqkw12k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
	Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
	daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

We encountered a problem that the file system could not be mounted in
the power-off scenario. The analysis of the file system mirror shows that
only part of the data is written to the last commit block.
The valid data of the commit block is concentrated in the first sector.
However, the data of the entire block is involved in the checksum calculation.
For different hardware, the minimum atomic unit may be different.
If the checksum of a committed block is incorrect, clear the data except the
'commit_header' and then calculate the checksum. If the checkusm is correct,
it is considered that the block is partially committed, Then continue to replay
journal.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..0d14b5f39be6 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -443,6 +443,27 @@ static int jbd2_commit_block_csum_verify(journal_t *j, void *buf)
 	return provided == cpu_to_be32(calculated);
 }
 
+static bool jbd2_commit_block_csum_verify_partial(journal_t *j, void *buf)
+{
+	struct commit_header *h;
+	__be32 provided;
+	__u32 calculated;
+	void *tmpbuf;
+
+	tmpbuf = kzalloc(j->j_blocksize, GFP_KERNEL);
+	if (!tmpbuf)
+		return false;
+
+	memcpy(tmpbuf, buf, sizeof(struct commit_header));
+	h = tmpbuf;
+	provided = h->h_chksum[0];
+	h->h_chksum[0] = 0;
+	calculated = jbd2_chksum(j, j->j_csum_seed, tmpbuf, j->j_blocksize);
+	kfree(tmpbuf);
+
+	return provided == cpu_to_be32(calculated);
+}
+
 static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 				      journal_block_tag3_t *tag3,
 				      void *buf, __u32 sequence)
@@ -810,6 +831,13 @@ static int do_one_pass(journal_t *journal,
 			if (pass == PASS_SCAN &&
 			    !jbd2_commit_block_csum_verify(journal,
 							   bh->b_data)) {
+				if (jbd2_commit_block_csum_verify_partial(
+								  journal,
+								  bh->b_data)) {
+					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
+						  next_commit_ID, next_log_block);
+					goto chksum_ok;
+				}
 			chksum_error:
 				if (commit_time < last_trans_commit_time)
 					goto ignore_crc_mismatch;
@@ -824,6 +852,7 @@ static int do_one_pass(journal_t *journal,
 				}
 			}
 			if (pass == PASS_SCAN) {
+			chksum_ok:
 				last_trans_commit_time = commit_time;
 				head_block = next_log_block;
 			}
@@ -843,6 +872,7 @@ static int do_one_pass(journal_t *journal,
 					  next_log_block);
 				need_check_commit_time = true;
 			}
+
 			/* If we aren't in the REVOKE pass, then we can
 			 * just skip over this block. */
 			if (pass != PASS_REVOKE) {
-- 
2.31.1


