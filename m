Return-Path: <linux-ext4+bounces-11083-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4477CC08D5D
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6E91C83727
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 07:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D12E03F3;
	Sat, 25 Oct 2025 07:27:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258872DE71E
	for <linux-ext4@vger.kernel.org>; Sat, 25 Oct 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761377224; cv=none; b=VbAT6/DnMx7ZyTS/KoDKDYi55gCWxL9FuSKhiF1+QIkJbJ7fs2IWY/iCex6ij4XZyPTwh2Wj9AiuWISS0SQLFwN3Jo1igaJgruT88j1/HwUeHm9ZhfTSFpLlwz9PLtKjDvBazsmNaTSko0XOsXz74kHIlVdp0b/gN2L6wdtTenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761377224; c=relaxed/simple;
	bh=d4DZm83WB9oZb9WShHMahtgyrIIjkpDFA9GzluGLUis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nIR0Qtyb7dw2C8Gnmc3CHJoq+3JXaBEAhM51CDEoA9SgG5SefWJDSI5KOrAnbIPoQ1Hz1eqc9fDnB6dVu1tNKVpi4zJInZ365MUoUCmIDSzFpBzgzF15pM+PucIaPAlK4n2t9KNl7PpjGrQJ3rCCFQ3eTY2r7aQYtRFzV95kM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctrsg5Y5tzYQv2c
	for <linux-ext4@vger.kernel.org>; Sat, 25 Oct 2025 15:25:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AE8051A0D90
	for <linux-ext4@vger.kernel.org>; Sat, 25 Oct 2025 15:26:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP2 (Coremail) with SMTP id Syh0CgCHK0TBe_xocwsuBg--.29733S4;
	Sat, 25 Oct 2025 15:26:58 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [PATCH] jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
Date: Sat, 25 Oct 2025 15:26:57 +0800
Message-Id: <20251025072657.307851-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCHK0TBe_xocwsuBg--.29733S4
X-Coremail-Antispam: 1UD129KBjvJXoWxury5Kw1UtFWUJrWxtr43KFg_yoWrXF47pr
	WSkw4jkrW8tas8AF4xZr48XFW8Kan7Aa4UAryvvrn7Ja15GwnFvFZ7KrWSkr98tF4F93W2
	qF1UXr1DK3yjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's issue when file system corrupted:
------------[ cut here ]------------
kernel BUG at fs/jbd2/transaction.c:1289!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 5 UID: 0 PID: 2031 Comm: mkdir Not tainted 6.18.0-rc1-next
RIP: 0010:jbd2_journal_get_create_access+0x3b6/0x4d0
RSP: 0018:ffff888117aafa30 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff88811a86b000 RCX: ffffffff89a63534
RDX: 1ffff110200ec602 RSI: 0000000000000004 RDI: ffff888100763010
RBP: ffff888100763000 R08: 0000000000000001 R09: ffff888100763028
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88812c432000 R14: ffff88812c608000 R15: ffff888120bfc000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91d6970c99 CR3: 00000001159c4000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __ext4_journal_get_create_access+0x42/0x170
 ext4_getblk+0x319/0x6f0
 ext4_bread+0x11/0x100
 ext4_append+0x1e6/0x4a0
 ext4_init_new_dir+0x145/0x1d0
 ext4_mkdir+0x326/0x920
 vfs_mkdir+0x45c/0x740
 do_mkdirat+0x234/0x2f0
 __x64_sys_mkdir+0xd6/0x120
 do_syscall_64+0x5f/0xfa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The above issue occurs with us in errors=continue mode when accompanied by
storage failures. There have been many inconsistencies in the file system
data.
In the case of file system data inconsistency, for example, if the block
bitmap of a referenced block is not set, it can lead to the situation where
a block being committed is allocated and used again. As a result, the
following condition will not be satisfied then trigger BUG_ON. Of course,
it is entirely possible to construct a problematic image that can trigger
this BUG_ON through specific operations. In fact, I have constructed such
an image and easily reproduced this issue.
Therefore, J_ASSERT() holds true only under ideal conditions, but it may
not necessarily be satisfied in exceptional scenarios. Using J_ASSERT()
directly in abnormal situations would cause the system to crash, which is
clearly not what we want. So here we directly trigger a JBD abort instead
of immediately invoking BUG_ON.

Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/transaction.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3e510564de6e..9ce626ac947e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1284,14 +1284,23 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 	 * committing transaction's lists, but it HAS to be in Forget state in
 	 * that case: the transaction must have deleted the buffer for it to be
 	 * reused here.
+	 * In the case of file system data inconsistency, for example, if the
+	 * block bitmap of a referenced block is not set, it can lead to the
+	 * situation where a block being committed is allocated and used again.
+	 * As a result, the following condition will not be satisfied, so here
+	 * we directly trigger a JBD abort instead of immediately invoking
+	 * bugon.
 	 */
 	spin_lock(&jh->b_state_lock);
-	J_ASSERT_JH(jh, (jh->b_transaction == transaction ||
-		jh->b_transaction == NULL ||
-		(jh->b_transaction == journal->j_committing_transaction &&
-			  jh->b_jlist == BJ_Forget)));
+	if (!(jh->b_transaction == transaction || jh->b_transaction == NULL ||
+	      (jh->b_transaction == journal->j_committing_transaction &&
+	       jh->b_jlist == BJ_Forget)) || jh->b_next_transaction != NULL) {
+		err = -EROFS;
+		spin_unlock(&jh->b_state_lock);
+		jbd2_journal_abort(journal, err);
+		goto out;
+	}
 
-	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
 
 	if (jh->b_transaction == NULL) {
-- 
2.34.1


