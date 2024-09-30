Return-Path: <linux-ext4+bounces-4370-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A947B9898B0
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72341C210DE
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 00:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6903207;
	Mon, 30 Sep 2024 00:50:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFEC8E0
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657438; cv=none; b=aTzxkidOVUpREcvCF/LI76DoXU9IrgMummRLDMy4tnsykUZz0BgrxXRApPV3lwhGXpwrj8Axb9hlRDQopl0C+8gYegmhoPYiCiEff2a9X979SOXCo09oaty1UHQecE6RoOcrb5+6/Qa1aRbMpnQWmEedG1ccDifSqiOC17hCc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657438; c=relaxed/simple;
	bh=Tk7je2C1df1ElFG4kmixj/tnqLDFrwpD7e+EDlpxsms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9nKwMGlNpMd8njuLklzGP35P43ccjuwtybCPNzGuyW1u+L94xD1qVqqB3QlEC8DXNWDtJBDF4INHekQog6n+mviwNd2LiSxCt4r0moZ4Iwl3Dh+2As5GBouuHVIjTKN5U2K9I2oCLhD8HqXRE9wk5Vyxqin0CGOqZuuAU2lAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XH2Y43X0vz4f3kvq
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A3ECB1A0568
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnW9flmLxfsCg--.51013S7;
	Mon, 30 Sep 2024 08:50:33 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH v2 3/6] jbd2: refactor JBD2_COMMIT_BLOCK process in do_one_pass()
Date: Mon, 30 Sep 2024 08:59:39 +0800
Message-Id: <20240930005942.626942-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930005942.626942-1-yebin@huaweicloud.com>
References: <20240930005942.626942-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMnW9flmLxfsCg--.51013S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW5Aw1DAry3Gr4DWw1kuFg_yoW5Gw45pw
	s8CwnxKrWUJr1SvFs3Jr1UZFW5W3Wvya4UuFnFkwn7XasxKwnFgrs2qrySqry5AF93u34r
	uF15Awn0kw1xC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYFALUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

To make JBD2_COMMIT_BLOCK process more clean, no functional change.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c | 55 ++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 0adf0cb31a03..0d697979d83e 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -728,6 +728,11 @@ static int do_one_pass(journal_t *journal,
 			continue;
 
 		case JBD2_COMMIT_BLOCK:
+			if (pass != PASS_SCAN) {
+				next_commit_ID++;
+				continue;
+			}
+
 			/*     How to differentiate between interrupted commit
 			 *               and journal corruption ?
 			 *
@@ -790,8 +795,7 @@ static int do_one_pass(journal_t *journal,
 			 * much to do other than move on to the next sequence
 			 * number.
 			 */
-			if (pass == PASS_SCAN &&
-			    jbd2_has_feature_checksum(journal)) {
+			if (jbd2_has_feature_checksum(journal)) {
 				struct commit_header *cbh =
 					(struct commit_header *)bh->b_data;
 				unsigned found_chksum =
@@ -815,34 +819,33 @@ static int do_one_pass(journal_t *journal,
 					goto chksum_error;
 
 				crc32_sum = ~0;
+				goto chksum_ok;
 			}
-			if (pass == PASS_SCAN &&
-			    !jbd2_commit_block_csum_verify(journal,
-							   bh->b_data)) {
-				if (jbd2_commit_block_csum_verify_partial(
-								  journal,
-								  bh->b_data)) {
-					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
-						  next_commit_ID, next_log_block);
-					goto chksum_ok;
-				}
-			chksum_error:
-				if (commit_time < last_trans_commit_time)
-					goto ignore_crc_mismatch;
-				info->end_transaction = next_commit_ID;
-				info->head_block = head_block;
 
-				if (!jbd2_has_feature_async_commit(journal)) {
-					journal->j_failed_commit =
-						next_commit_ID;
-					break;
-				}
+			if (jbd2_commit_block_csum_verify(journal, bh->b_data))
+				goto chksum_ok;
+
+			if (jbd2_commit_block_csum_verify_partial(journal,
+								  bh->b_data)) {
+				pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
+					  next_commit_ID, next_log_block);
+				goto chksum_ok;
 			}
-			if (pass == PASS_SCAN) {
-			chksum_ok:
-				last_trans_commit_time = commit_time;
-				head_block = next_log_block;
+
+chksum_error:
+			if (commit_time < last_trans_commit_time)
+				goto ignore_crc_mismatch;
+			info->end_transaction = next_commit_ID;
+			info->head_block = head_block;
+
+			if (!jbd2_has_feature_async_commit(journal)) {
+				journal->j_failed_commit = next_commit_ID;
+				break;
 			}
+
+chksum_ok:
+			last_trans_commit_time = commit_time;
+			head_block = next_log_block;
 			next_commit_ID++;
 			continue;
 
-- 
2.31.1


