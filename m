Return-Path: <linux-ext4+bounces-1820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A43A894E5A
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 11:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6C81C20D08
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07356B8E;
	Tue,  2 Apr 2024 09:09:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597CC1E525;
	Tue,  2 Apr 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048944; cv=none; b=t1n++FA2iWoV8IZak8xSEBPKAhpyGoBZi51FUEqG07YL6C2iASWFFaHJ+hOO6nYPtoXpeF8O2LdYkbOIJ0JSnWAc9Ver0h/oyrMFDw/4+DqTVlpWMCOOoYbKls6IBH8DB3xeNEFYE0e9Or3n8i0fIwhNUPB/9xLWfqaSAfgw7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048944; c=relaxed/simple;
	bh=y84DH1FpxfRn08U5oPYikSNOXDDr/iVJd9EcIchY8d8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W9tp1ylXVBANuweyyt2opn8344QW1s3s4+D2jC6CWtaV5XBcVbch1s+A7FNQCGeRrXVmFMxvWhcgS/k9daAiXA0go5fFtX0czWB7hiKowbe3kTHJY1MQrE2crif80aSoGO6tBmdDof3zg438SeKwSN0DH4u4mbtE09maHzMCEBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V826s3MxGz1R9bj;
	Tue,  2 Apr 2024 17:06:13 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A5BF18002D;
	Tue,  2 Apr 2024 17:08:58 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Apr
 2024 17:08:58 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>, Ye Bin
	<yebin10@huawei.com>
Subject: [PATCH] jbd2: avoid mount failed when commit block is partial submitted
Date: Tue, 2 Apr 2024 17:09:51 +0800
Message-ID: <20240402090951.527619-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)

We encountered a problem that the file system could not be mounted in
the power-off scenario. The analysis of the file system mirror shows that
only part of the data is written to the last commit block.
To solve above issue, if commit block checksum is incorrect, check the next
block if has valid magic and transaction ID. If next block hasn't valid
magic or transaction ID then just drop the last transaction ignore checksum
error. Theoretically, the transaction ID maybe occur loopback, which may cause
the mounting failure.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..0a09f1a5fd1e 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -463,6 +463,41 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
 		return tag->t_checksum == cpu_to_be16(csum32);
 }
 
+static int check_incomplete_commit(journal_t *journal, unsigned long next_block,
+				   unsigned int next_commit_ID)
+{
+	journal_header_t *tmp;
+	struct buffer_head *bh;
+	int err = 0;
+
+	err = jread(&bh, journal, next_block);
+	if (err)
+		return err;
+
+	tmp = (journal_header_t *)bh->b_data;
+	/*
+	 * If the next block does not contain consecutive transactions, it can
+	 * be considered that the checksum error of the current commit block
+	 * is caused by incomplete commit. Ignore the checksum error and drop
+	 * the last transaction.
+	 */
+	if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
+	    be32_to_cpu(tmp->h_sequence) != next_commit_ID) {
+		jbd2_debug("JBD2: will drop incomplete transaction %u commit block %lu\n",
+			   next_commit_ID - 1, next_block - 1);
+		goto out;
+	}
+
+	pr_err("JBD2: potential continuous transaction detected %u at %lu, "
+	       "likely invalid checksum in transaction %u\n",
+	       next_commit_ID,  next_block, next_commit_ID - 1);
+
+	err = -EFSBADCRC;
+out:
+	brelse(bh);
+	return err;
+}
+
 static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
@@ -810,6 +845,10 @@ static int do_one_pass(journal_t *journal,
 			if (pass == PASS_SCAN &&
 			    !jbd2_commit_block_csum_verify(journal,
 							   bh->b_data)) {
+				if (!check_incomplete_commit(journal,
+							     next_log_block,
+							     next_commit_ID + 1))
+					goto ignore_crc_mismatch;
 			chksum_error:
 				if (commit_time < last_trans_commit_time)
 					goto ignore_crc_mismatch;
-- 
2.31.1


