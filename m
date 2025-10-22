Return-Path: <linux-ext4+bounces-11021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A0BFB8FC
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CCF3A6237
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Oct 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F2A32BF22;
	Wed, 22 Oct 2025 11:12:02 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89811CA9;
	Wed, 22 Oct 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131522; cv=none; b=mub4VibXDcSx0iv7/D5ngsEZtYz+t+C8hOeVAj5WiCdqKgyZAR5j2/KXnVj6rP9FWc5DJH2SOJ4fGrx/2308mm00DwRqVDb1aKG9K//OzH+ZyKiWi0buemKsySUtSznf9rWs/ite1hynDYWdrKAwZyhWkPvmAzawXoTm4nTyuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131522; c=relaxed/simple;
	bh=5UpbW5vWG0sKkOVn393oZxy1cQ9r0yyAQQeqLNxH94M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmoVPhyT1SE57GjG9gDqUr8Q82MMEN3p2qlmRGbX01mSCRrLjvO8hT1ML0b14p8NnesC7TvJboC3eJDMjGdVLeBpdbgL4l9LK0D41NANi9oA8y+raAfP2fuJWUabhDLkP7NA459NjlcyyOUymQk2EWRt+pDapjcxdjzz+rVfWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59MBBceu083811;
	Wed, 22 Oct 2025 20:11:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59MBBc28083808
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Oct 2025 20:11:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <987110fc-5470-457a-a218-d286a09dd82f@I-love.SAKURA.ne.jp>
Date: Wed, 22 Oct 2025 20:11:37 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] jbd2: allocate lock_class_key for jbd2_handle dynamically
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
 <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
 <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
 <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3>
 <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp>
 <doq4csrkuhpha7v5lunesdrscmqmjvt3flids3iai2gvpbhp3j@mxldi4yvvymw>
 <a6fcc693-42f0-4d70-a1af-fc1bfb328eb7@I-love.SAKURA.ne.jp>
 <rajbaoxp7zvaiftmuip4mxdvrdxthhgvbjvtuq3zrwijtdab2j@ouligqrqxyth>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <rajbaoxp7zvaiftmuip4mxdvrdxthhgvbjvtuq3zrwijtdab2j@ouligqrqxyth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp

syzbot is reporting possibility of deadlock due to sharing lock_class_key
for jbd2_handle across ext4 and ocfs2. But this is a false positive, for
one disk partition can't have two filesystems at the same time.

Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
---
 fs/jbd2/journal.c    | 6 ++++--
 include/linux/jbd2.h | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..f43474002f50 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1521,7 +1521,6 @@ static journal_t *journal_init_common(struct block_device *bdev,
 			struct block_device *fs_dev,
 			unsigned long long start, int len, int blocksize)
 {
-	static struct lock_class_key jbd2_trans_commit_key;
 	journal_t *journal;
 	int err;
 	int n;
@@ -1530,6 +1529,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (!journal)
 		return ERR_PTR(-ENOMEM);
 
+	lockdep_register_key(&journal->jbd2_trans_commit_key);
 	journal->j_blocksize = blocksize;
 	journal->j_dev = bdev;
 	journal->j_fs_dev = fs_dev;
@@ -1560,7 +1560,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
 	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
+			 &journal->jbd2_trans_commit_key, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1611,6 +1611,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	kfree(journal->j_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	journal_fail_superblock(journal);
+	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
 	kfree(journal);
 	return ERR_PTR(err);
 }
@@ -2187,6 +2188,7 @@ int jbd2_journal_destroy(journal_t *journal)
 		jbd2_journal_destroy_revoke(journal);
 	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
+	lockdep_unregister_key(&journal->jbd2_trans_commit_key);
 	kfree(journal);
 
 	return err;
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..f5eaf76198f3 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1253,6 +1253,12 @@ struct journal_s
 	 */
 	struct lockdep_map	j_trans_commit_map;
 #endif
+	/**
+	 * @jbd2_trans_commit_key:
+	 *
+	 * "struct lock_class_key" for @j_trans_commit_map
+	 */
+	struct lock_class_key	jbd2_trans_commit_key;
 
 	/**
 	 * @j_fc_cleanup_callback:
-- 
2.47.3



