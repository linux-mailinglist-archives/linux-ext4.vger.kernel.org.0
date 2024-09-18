Return-Path: <linux-ext4+bounces-4208-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFCC97BB9D
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E2A1F273E6
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D711891CF;
	Wed, 18 Sep 2024 11:26:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CB266D4
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658806; cv=none; b=XPSFJyz1dOJS5SCyckRZGg7Yz9v18am0MLvFb8MASsdI+TXoh2FcamrKxbV9PwwIZaF5wJokOJqzYkGl1+/A0ub0MrFwaBrtRCQ9diyjPpiZFyPRNOM5QX6CWEL9UMxsgsuRSsU1EIfwHxVLIIM+xOJlDYIxpUR77+/2bl/U+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658806; c=relaxed/simple;
	bh=3X5P+C9W25nt5C5oOL5qM3puZ87HZm4vmK5cgkqZeUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVogPhf5Vey3fw/LcFES1ELOUqOPbn1cVV4v9Cjk1XtKICq9NiuheWs8y5sluEDkczShRV6W1nCQSDm64f4eZVjR8hI1S3eDeKAYktDXiY8JbDyYJpkuOy1g1HwP+i1T4yoLrb3gj/dUpW6HWS7GQKrDtPq1BtlUWHYTVHymeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X7xDZ3FQHz4f3lVM
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0FEAD1A0359
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnsuOpmuiKqBg--.12650S7;
	Wed, 18 Sep 2024 19:26:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 3/5] jbd2: refactor JBD2_COMMIT_BLOCK process in do_one_pass()
Date: Wed, 18 Sep 2024 19:36:02 +0800
Message-Id: <20240918113604.660640-4-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMnsuOpmuiKqBg--.12650S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW5Aw1DAry3Gr4DWw1kuFg_yoW5GF4kpw
	s8CwnxKrWUJr1SvFs3Jr1UZFW5W3Wvya4UuFnFkwn7XasxKwnFgws2qrySqry5AF93u34r
	uF15Awn8Kw1xC37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	c4SoDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

To make JBD2_COMMIT_BLOCK process more clean, no functional change.

Signed-off-by: Ye Bin <yebin10@huawei.com>
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


