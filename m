Return-Path: <linux-ext4+bounces-4376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F39898B7
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196C11F21455
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 00:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE950171C9;
	Mon, 30 Sep 2024 00:50:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66E15E8B
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657439; cv=none; b=YgOzLK9gxprgDfayZzC3u7DVF6fArzvOBdgMoqUJQ/321Mu/Ie3LnFmVDiB9JxTxFrTO1+UvESIRStU4EbT1eBW9yvGIDTL4zSNJz45nFFBq9jngq0bh66w4yCzxHmWSsfZEHw92ssHOdwvg3a6FzyPEDiF9qIPq5EJiFINJVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657439; c=relaxed/simple;
	bh=eVcD7v7xFjJmFT+JA8uBM2mN7BO3hOT5IvQQg9AhAYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nv+Rl1fJtWdMhuJUQIb3WsN4C6Sx087fzZjvskiRBEhjTnygXyTeNA7Ky1RSXQGrY2mKKKFZT+BXgRT6BR68Uk1+TLe/AoHOodhtNzvZva0hnFZxECEEbtlprfCrheWu38gqHnGYk6vfX3E23IdV3Amf+AAu8WGb/DfKHOyOB9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XH2Y601zxz4f3jrt
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7693B1A06D7
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnW9flmLxfsCg--.51013S10;
	Mon, 30 Sep 2024 08:50:34 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH v2 6/6] jbd2: remove the 'success' parameter from the jbd2_do_replay() function
Date: Mon, 30 Sep 2024 08:59:42 +0800
Message-Id: <20240930005942.626942-7-yebin@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMnW9flmLxfsCg--.51013S10
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1rZw45Ww4rXFWkWFW5trb_yoW8KF1Dp3
	W5C39rKFyqvF18WF93XFWkXry2gw1ayFyUWr1q93Z2yay5trWjv34Sg343tFyYkryv9ayr
	JFWjy345Kwnakw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwuWlUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Keep 'success' internally to track if any error happened and then
return it at the end in do_one_pass(). If jbd2_do_replay() return
-ENOMEM then stop replay journal.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 4f1e9ca34503..9192be7c19d8 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -489,12 +489,11 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
 					  struct recovery_info *info,
 					  struct buffer_head *bh,
 					  unsigned long *next_log_block,
-					  unsigned int next_commit_ID,
-					  int *success)
+					  unsigned int next_commit_ID)
 {
 	char *tagp;
 	int flags;
-	int err;
+	int ret = 0;
 	int tag_bytes = journal_tag_bytes(journal);
 	int descr_csum_size = 0;
 	unsigned long io_block;
@@ -508,6 +507,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
 	tagp = &bh->b_data[sizeof(journal_header_t)];
 	while (tagp - bh->b_data + tag_bytes <=
 	       journal->j_blocksize - descr_csum_size) {
+		int err;
 
 		memcpy(&tag, tagp, sizeof(tag));
 		flags = be16_to_cpu(tag.t_flags);
@@ -517,7 +517,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
 		err = jread(&obh, journal, io_block);
 		if (err) {
 			/* Recover what we can, but report failure at the end. */
-			*success = err;
+			ret = err;
 			pr_err("JBD2: IO error %d recovering block %lu in log\n",
 			      err, io_block);
 		} else {
@@ -539,7 +539,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
 					(journal_block_tag3_t *)tagp,
 					obh->b_data, next_commit_ID)) {
 				brelse(obh);
-				*success = -EFSBADCRC;
+				ret = -EFSBADCRC;
 				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
 				      blocknr, io_block);
 				goto skip_write;
@@ -580,7 +580,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
 			break;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int do_one_pass(journal_t *journal,
@@ -719,9 +719,12 @@ static int do_one_pass(journal_t *journal,
 			 * done here!
 			 */
 			err = jbd2_do_replay(journal, info, bh, &next_log_block,
-					     next_commit_ID, &success);
-			if (err)
-				goto failed;
+					     next_commit_ID);
+			if (err) {
+				if (err == -ENOMEM)
+					goto failed;
+				success = err;
+			}
 
 			continue;
 
-- 
2.31.1


