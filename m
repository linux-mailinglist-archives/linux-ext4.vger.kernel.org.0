Return-Path: <linux-ext4+bounces-4374-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124279898B4
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFD5283685
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 00:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F9BA53;
	Mon, 30 Sep 2024 00:50:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158611CA9
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657439; cv=none; b=sk4lHH1GPEBetaPppdHH/URYAY3UL49k7GX/iD8Ij6zI2gfNZPkWQNBXcrl6QN8dcl4S1TNJiHQsqjWK301jU8hwW+MGm+x4fBCXGru3XgJQs/Hh8Gt2gOEsLlzIYYQPI8mbncTHDV3oRFR5smdV3z4s7nt6drP9ZXni9weVKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657439; c=relaxed/simple;
	bh=tci3FGeCZiqaFUxWGW3NG70Kcf1Zm3NEi6O2zdLzfNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q+u1p8F0OSkA1Y9xZbVKb9YYpAv1C8P2IUED5cWfcBngY3b1Z5S3rVyGiBuF03z2MatkhX29+OEYimvLMO6+Waa5yTSYWzGqhYGj2j/aou/MdVAuNvXVACckkts5ZdQzCvG3CBOGqu+KiO+q/1I5g9TE5yVt9tceZWYJ66lK7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XH2YB5dc4z4f3jk3
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 35B671A092F
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnW9flmLxfsCg--.51013S9;
	Mon, 30 Sep 2024 08:50:34 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH v2 5/6] jbd2: remove useless 'block_error' variable
Date: Mon, 30 Sep 2024 08:59:41 +0800
Message-Id: <20240930005942.626942-6-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMnW9flmLxfsCg--.51013S9
X-Coremail-Antispam: 1UD129KBjvJXoW7urWDJw1DAF1kJFW8uw1fCrg_yoW8Ww48pr
	yUCws7KryDA340qasrJFWDXFWjga1jyryUWF1qk3ZxtFW5Gry2qr10gw13tFy8KF97uayU
	XF48Z34rKw1Ik3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM6wAUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

The judgement 'if (block_error && success == 0)' is never valid. Just
remove useless 'block_error' variable.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 046744d6239c..4f1e9ca34503 100644
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


