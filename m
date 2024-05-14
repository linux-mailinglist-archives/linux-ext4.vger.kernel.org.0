Return-Path: <linux-ext4+bounces-2497-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5508C5279
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968F0282B47
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87013D618;
	Tue, 14 May 2024 11:25:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B1613D50A;
	Tue, 14 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685919; cv=none; b=lYTTx/Qo40+FBu4hX8yDe+22HrvXEr6LPQ9vpGNaXWeRkX5y0QKUEeVn+cELiDJ8aqTrVres54pibSaYCorAYCFIKSVswrWZ0g2GgG2FU5QnWkoJDhxfC4KpSyqBkyfS4WeIhQhDDsJKKlko/RzyZbgnOo3B+20lz6Q0BHJ1fD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685919; c=relaxed/simple;
	bh=FlS9yVfZr/XsUVv8HFFqmZL+HWru05LCDhCJiRKghCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAhPmSg/6V8E9fqGWYxKqf3NGLPZtzmEP1ecoxtdIgogfT/fbuPFjT/52rwydC6O87jGDNZEqeNwE/XdV0MJ5MClxupzV5vtcZ0pB6TR9TqEDI1h/CRUvUhuYfoZP7XTMWjzkgyyGhbFNrYy2NjH6ht6EALprMnXOZUBus3Nr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdvCg6RgDz4f3n64;
	Tue, 14 May 2024 19:25:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0BBE01A1053;
	Tue, 14 May 2024 19:25:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCHSKAXSkNm4rTMMQ--.61831S4;
	Tue, 14 May 2024 19:25:13 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] jbd2: remove unused return info from jbd2_journal_write_metadata_buffer
Date: Tue, 14 May 2024 19:24:31 +0800
Message-Id: <20240514112438.1269037-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHSKAXSkNm4rTMMQ--.61831S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47XrW5ZF1kXrWxGw17ZFb_yoW8tFy5pF
	yrGa48Zryqvry8Zrn7XF4DJFWjgFW09Fyjkr1qk3Z5ta1UJws2gF4Iyr1agr4YyF93Ca48
	Ar1UC3yDGw4Yv3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb1v3UUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The done_copy_out info from jbd2_journal_write_metadata_buffer is not
used. Simply remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/commit.c  | 10 +++++-----
 fs/jbd2/journal.c |  9 +++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..67077308b56b 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -353,7 +353,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	struct buffer_head *descriptor;
 	struct buffer_head **wbuf = journal->j_wbuf;
 	int bufs;
-	int flags;
+	int escape;
 	int err;
 	unsigned long long blocknr;
 	ktime_t start_time;
@@ -661,10 +661,10 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		 */
 		set_bit(BH_JWrite, &jh2bh(jh)->b_state);
 		JBUFFER_TRACE(jh, "ph3: write metadata");
-		flags = jbd2_journal_write_metadata_buffer(commit_transaction,
+		escape = jbd2_journal_write_metadata_buffer(commit_transaction,
 						jh, &wbuf[bufs], blocknr);
-		if (flags < 0) {
-			jbd2_journal_abort(journal, flags);
+		if (escape < 0) {
+			jbd2_journal_abort(journal, escape);
 			continue;
 		}
 		jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
@@ -673,7 +673,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
                    buffer */
 
 		tag_flag = 0;
-		if (flags & 1)
+		if (escape)
 			tag_flag |= JBD2_FLAG_ESCAPE;
 		if (!first_tag)
 			tag_flag |= JBD2_FLAG_SAME_UUID;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 207b24e12ce9..2dca2f613a8e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -316,11 +316,8 @@ static void journal_kill_thread(journal_t *journal)
  *
  * Return value:
  *  <0: Error
- * >=0: Finished OK
- *
- * On success:
- * Bit 0 set == escape performed on the data
- * Bit 1 set == buffer copy-out performed (kfree the data after IO)
+ *  =0: Finished OK without escape
+ *  =1: Finished OK with escape
  */
 
 int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
@@ -455,7 +452,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	set_buffer_shadow(bh_in);
 	spin_unlock(&jh_in->b_state_lock);
 
-	return do_escape | (done_copy_out << 1);
+	return do_escape;
 }
 
 /*
-- 
2.30.0


