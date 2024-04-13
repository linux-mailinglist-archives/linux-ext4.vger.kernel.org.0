Return-Path: <linux-ext4+bounces-2072-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B5A8A3A21
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Apr 2024 03:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA191F22C13
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Apr 2024 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96720FBEA;
	Sat, 13 Apr 2024 01:30:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A034C97;
	Sat, 13 Apr 2024 01:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712971829; cv=none; b=kX24NzR4fn61zW9qFw3L/EvK3IIhi9Dtp4SLnYO3bttovQ8YaSnQyUezD/pS1kvwSmTMwy/PQvXQ3qA4f32/LuTpq2iqAgAl4ydfpsMWGX0MrY8+akaQjUCnpNZZ2KIHqN9ZyOjmbtt5dZWh5jjBTtiAPAh8RnKB6oxT8k9LKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712971829; c=relaxed/simple;
	bh=uAF58WQTwC70AQ4e42dMPhlqM+08OPyMWwp4j46ePBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f1va6SUpX6V+FNKDT/KzBJ5OT5krpVaGH4XjnpyOOjf+SSTlp+cv4J54AZv6s1SuzrWBt/IdGEpdHa21LB/Jv+Av6syAbHQ4GHhm9MdLufz+QkaA32NEqOzHr7zrnKG69Tsmlw1jYmCwhB+v0U5eZkgoyqzzKOxYoVTPR46TqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VGbQK4bmKz1hwV8;
	Sat, 13 Apr 2024 09:27:21 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id A60D31A0172;
	Sat, 13 Apr 2024 09:30:15 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 13 Apr
 2024 09:30:15 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>, Ye Bin
	<yebin10@huawei.com>
Subject: [PATCH v2] jbd2: avoid mount failed when commit block is partial submitted
Date: Sat, 13 Apr 2024 09:30:56 +0800
Message-ID: <20240413013056.1830515-1-yebin10@huawei.com>
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
The valid data of the commit block is concentrated in the first sector.
However, the data of the entire block is involved in the checksum calculation.
For different hardware, the minimum atomic unit may be different.
If the checksum of a committed block is incorrect, clear the data except the
'commit_header' and then calculate the checksum. If the checkusm is correct,
it is considered that the block is partially committed. However, if there are
valid description/revoke blocks, it is considered that the data is abnormal
and the log replay is stopped.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 1f7664984d6e..eb0e026f3109 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -443,6 +443,27 @@ static int jbd2_commit_block_csum_verify(journal_t *j, void *buf)
 	return provided == cpu_to_be32(calculated);
 }
 
+static bool jbd2_commit_block_csum_partial_verify(journal_t *j, void *buf)
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
@@ -479,6 +500,7 @@ static int do_one_pass(journal_t *journal,
 	int			descr_csum_size = 0;
 	int			block_error = 0;
 	bool			need_check_commit_time = false;
+	bool                    has_partial_commit = false;
 	__u64			last_trans_commit_time = 0, commit_time;
 
 	/*
@@ -590,6 +612,14 @@ static int do_one_pass(journal_t *journal,
 					next_log_block);
 			}
 
+			if (pass == PASS_SCAN && has_partial_commit) {
+				pr_err("JBD2: Detect validate descriptor block %lu after incomplete commit block\n",
+				       next_log_block);
+				err = -EFSBADCRC;
+				brelse(bh);
+				goto failed;
+			}
+
 			/* If it is a valid descriptor block, replay it
 			 * in pass REPLAY; if journal_checksums enabled, then
 			 * calculate checksums in PASS_SCAN, otherwise,
@@ -810,6 +840,14 @@ static int do_one_pass(journal_t *journal,
 			if (pass == PASS_SCAN &&
 			    !jbd2_commit_block_csum_verify(journal,
 							   bh->b_data)) {
+				if (jbd2_commit_block_csum_partial_verify(
+								  journal,
+								  bh->b_data)) {
+					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
+						  next_commit_ID, next_log_block);
+					has_partial_commit = true;
+					goto chksum_ok;
+				}
 			chksum_error:
 				if (commit_time < last_trans_commit_time)
 					goto ignore_crc_mismatch;
@@ -824,6 +862,7 @@ static int do_one_pass(journal_t *journal,
 				}
 			}
 			if (pass == PASS_SCAN) {
+			chksum_ok:
 				last_trans_commit_time = commit_time;
 				head_block = next_log_block;
 			}
@@ -843,6 +882,15 @@ static int do_one_pass(journal_t *journal,
 					  next_log_block);
 				need_check_commit_time = true;
 			}
+
+			if (pass == PASS_SCAN && has_partial_commit) {
+				pr_err("JBD2: Detect validate revoke block %lu after incomplete commit block\n",
+				       next_log_block);
+				err = -EFSBADCRC;
+				brelse(bh);
+				goto failed;
+			}
+
 			/* If we aren't in the REVOKE pass, then we can
 			 * just skip over this block. */
 			if (pass != PASS_REVOKE) {
-- 
2.31.1


