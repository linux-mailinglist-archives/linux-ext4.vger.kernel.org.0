Return-Path: <linux-ext4+bounces-11812-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECB5C51B95
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 11:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400A4423CDB
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB930649C;
	Wed, 12 Nov 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aSGtT9v7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819D305064;
	Wed, 12 Nov 2025 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943385; cv=none; b=eMOzD9GRc3JTBloZnKuDIMDvtuT1ZRLDcmaG9uTcx22nopNxyQB7jRoVTfW7lMOnOMbgwfagh4dLaNVajYKrGPdvGiLLNn2aI9oyjzGU8RBBVJL7rcMgew0AXazJ1iZD6dM3XMfQBjcsUOr0dtqpJpqGQkrEf86qLVxHXO90SnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943385; c=relaxed/simple;
	bh=TJd5V9MUQeMHamfGlgeoq+tBalAsGviUfxDlgF8mZx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8s/kMmO6Rie7BFxgYYFap6wbKRo/xBCGl924EGo8VYZr6q6mbMSR2Z8cqLQMOzXY6trTcUgzlqpUpDkriWHqi3dEc1qWqJa0MOVbykER11lSFx4hlGUf8t61pK9/80GDMEML66JMhf1AZP7pv9comlytiHVt93bUnYz3GazwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aSGtT9v7; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VQ
	WosS9RLWijh15dE492CYJzsMUG7IR2qZHcga/J3Hc=; b=aSGtT9v7MZLYzPlfu1
	0a/lzciWdLCtb6gUr6sACJ+JEu7YJvFljEvU485di7f3wfxmbVgZ0f98w8D4Cygy
	Q/I2n0OO2rXSPvTQ1A1BPg8Xhc513aifwSmElreeJRk0HwlqBzMlfIeKBIamAk7A
	+A0gyiBAC6rHtaNwpDyOoMhBc=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAX9K99YRRpGDnzCg--.90S2;
	Wed, 12 Nov 2025 18:29:20 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] jbd2: use J_ASSERT instead of BUG_ON for checkpoint mutex
Date: Wed, 12 Nov 2025 18:29:14 +0800
Message-Id: <20251112102914.82278-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX9K99YRRpGDnzCg--.90S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW5tw13GryDCF17Cr1kAFb_yoW8Wry8pw
	15Gr1xCrWvvr48XF1FgFZ7JFW0qa4j9FWUGrZ09F1vva15tw12qw10yrn8GF409F93Ga15
	JFW7u3y7Wa4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPpnLUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiJhgDymkTRL26DgABsB

From: Baolin Liu <liubaolin@kylinos.cn>

Replace BUG_ON with J_ASSERT to write the assertion in a positive form.

No functional change.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/jbd2/journal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..c858ade1f7f3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1058,7 +1058,7 @@ int __jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block)
 	unsigned long freed;
 	int ret;
 
-	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
+	J_ASSERT(mutex_is_locked(&journal->j_checkpoint_mutex));
 
 	/*
 	 * We cannot afford for write to remain in drive's caches since as
@@ -1863,7 +1863,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 		return -EIO;
 	}
 
-	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
+	J_ASSERT(mutex_is_locked(&journal->j_checkpoint_mutex));
 	jbd2_debug(1, "JBD2: updating superblock (start %lu, seq %u)\n",
 		  tail_block, tail_tid);
 
@@ -1897,7 +1897,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
 	journal_superblock_t *sb = journal->j_superblock;
 	bool had_fast_commit = false;
 
-	BUG_ON(!mutex_is_locked(&journal->j_checkpoint_mutex));
+	J_ASSERT(mutex_is_locked(&journal->j_checkpoint_mutex));
 	lock_buffer(journal->j_sb_buffer);
 	if (sb->s_start == 0) {		/* Is it already empty? */
 		unlock_buffer(journal->j_sb_buffer);
-- 
2.39.2


