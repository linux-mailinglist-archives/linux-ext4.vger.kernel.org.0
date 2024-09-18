Return-Path: <linux-ext4+bounces-4206-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16B97BB9B
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D332887D5
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C93188CC5;
	Wed, 18 Sep 2024 11:26:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050017AE0C
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658804; cv=none; b=nn8IwCa/MParAINXOaj+bqJzyCLqyyAh5mF2xc8yU49nigLjPay/A3gkafvG3wzDO+fOXYqr7qRybLHNwlgb3ua8c5wIebhwcMaugj3PNbNfR8HLfHSQmFOiZoqQBzyKRDdDkUB1EzRSUQgVZ/NOYuEkkwu+651ABJiVcgh5gDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658804; c=relaxed/simple;
	bh=iejLb8zfehXtxpvrT+rrvSACP2cbpUxcD7JhHw1ftnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsbrkUheQTpbxoEJEZs2lhUJLmceQA5M8CblKmUGnCcgLL2zKLhqDLzzydn/tMigLo0JU+Xikfjv+QT/QK9oSGJaZIPQ9VaihDq2xmERGAhsH9GXD2WelUQgSuwgU8gHQpSbahqm/tTo5qRFkXpG0ddAO0YXNtBcQyJCCTUOsl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X7xDb5XCgz4f3jYK
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 95A6C1A0359
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnsuOpmuiKqBg--.12650S9;
	Wed, 18 Sep 2024 19:26:39 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 5/5] jbd2: remove useless 'block_error' variable
Date: Wed, 18 Sep 2024 19:36:04 +0800
Message-Id: <20240918113604.660640-6-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMnsuOpmuiKqBg--.12650S9
X-Coremail-Antispam: 1UD129KBjvJXoW7urWDJw1DAF1kGFWxKw1kuFg_yoW8WF4Dpr
	yUCwsrKryDC340qF9rJFWDXFyj93WjyFy8GF1qk3ZayFW5Gry2gr1Fgw13tFyUKF97uayU
	tFW8Z34rKw1Ik3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUwuWlUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

The judgement 'if (block_error && success == 0)' is never valid. Just
remove useless 'block_error' variable.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 05ea449b95c4..0bcbb58d634b 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -490,7 +490,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
 					  struct buffer_head *bh,
 					  unsigned long *next_log_block,
 					  unsigned int next_commit_ID,
-					  int *success, int *block_error)
+					  int *success)
 {
 	char *tagp;
 	int flags;
@@ -542,7 +542,6 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
 				*success = -EFSBADCRC;
 				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
 				      blocknr, io_block);
-				*block_error = 1;
 				goto skip_write;
 			}
 
@@ -596,7 +595,6 @@ static int do_one_pass(journal_t *journal,
 	unsigned int		sequence;
 	int			blocktype;
 	__u32			crc32_sum = ~0; /* Transactional Checksums */
-	int			block_error = 0;
 	bool			need_check_commit_time = false;
 	__u64			last_trans_commit_time = 0, commit_time;
 
@@ -721,8 +719,7 @@ static int do_one_pass(journal_t *journal,
 			 * done here!
 			 */
 			err = jbd2_do_replay(journal, info, bh, &next_log_block,
-					     next_commit_ID, &success,
-					     &block_error);
+					     next_commit_ID, &success);
 			if (err)
 				goto failed;
 
@@ -913,8 +910,6 @@ static int do_one_pass(journal_t *journal,
 			success = err;
 	}
 
-	if (block_error && success == 0)
-		success = -EIO;
 	return success;
 
  failed:
-- 
2.31.1


