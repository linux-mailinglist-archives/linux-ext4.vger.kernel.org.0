Return-Path: <linux-ext4+bounces-9337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E5B21E8C
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 08:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9645B4E3633
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 06:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C421F4281;
	Tue, 12 Aug 2025 06:45:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26999DDC3;
	Tue, 12 Aug 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981143; cv=none; b=sTJ1pEsl6WPl6M3KtJEp2imzi1o2wa1abr806Rl+/2u0U5kZ1EVes7/WE0V8wVgOrI+RSi20N3Fh/TVoUwHVRie44s/qCckMw6AZbQIQDyADO6JyOXGSKRO2D68RZ2b9LoWDnCXCFs8e8mAohMBx7uz1WhVrKWmf4PoMhWC7PhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981143; c=relaxed/simple;
	bh=29ECu7mtTAeQD6TWYLdUNWx0I4czPhmreAg/gJJATfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B1pglXNI/oWrXodwPmgj3MF5QVHEEYIm+Fd43erWYk9LbfeYQnPMIcR1ACDJx8z4useOpH2BKZcuGlpvD2omie5IIcvf6NeDzM3KW7XwjHLLWcVkiXSoADT17vm8v0/rIMTNknfJuy5oLBVMhMRCJU7tDW68R5k2Ap9VwyBOkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1MTG227fzKHN1m;
	Tue, 12 Aug 2025 14:45:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7DF1F1A0C29;
	Tue, 12 Aug 2025 14:45:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHgxMP45po3vuiDQ--.42402S4;
	Tue, 12 Aug 2025 14:45:37 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH] jbd2: prevent softlockup in jbd2_log_do_checkpoint()
Date: Tue, 12 Aug 2025 14:37:52 +0800
Message-Id: <20250812063752.912130-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHgxMP45po3vuiDQ--.42402S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUWw4xuryxuFy5KFyfJFb_yoW5GFy5pF
	93u3yjqrWku34UZrsIvaykAr929a1kury7JrnY9F17Zw48JrsrKFW3t34jqryUArZ5A3yS
	yFWj9wnagrnFy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfU5R6zUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQASBWiZm3JUBAAAse

From: Baokun Li <libaokun1@huawei.com>

Both jbd2_log_do_checkpoint() and jbd2_journal_shrink_checkpoint_list()
periodically release j_list_lock after processing a batch of buffers to
avoid long hold times on the j_list_lock. However, since both functions
contend for j_list_lock, the combined time spent waiting and processing
can be significant.

jbd2_journal_shrink_checkpoint_list() explicitly calls cond_resched() when
need_resched() is true to avoid softlockups during prolonged operations.
But jbd2_log_do_checkpoint() only exits its loop when need_resched() is
true, relying on potentially sleeping functions like __flush_batch() or
wait_on_buffer() to trigger rescheduling. If those functions do not sleep,
the kernel may hit a softlockup.

watchdog: BUG: soft lockup - CPU#3 stuck for 156s! [kworker/u129:2:373]
CPU: 3 PID: 373 Comm: kworker/u129:2 Kdump: loaded Not tainted 6.6.0+ #10
Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.27 06/13/2017
Workqueue: writeback wb_workfn (flush-7:2)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : native_queued_spin_lock_slowpath+0x358/0x418
lr : jbd2_log_do_checkpoint+0x31c/0x438 [jbd2]
Call trace:
 native_queued_spin_lock_slowpath+0x358/0x418
 jbd2_log_do_checkpoint+0x31c/0x438 [jbd2]
 __jbd2_log_wait_for_space+0xfc/0x2f8 [jbd2]
 add_transaction_credits+0x3bc/0x418 [jbd2]
 start_this_handle+0xf8/0x560 [jbd2]
 jbd2__journal_start+0x118/0x228 [jbd2]
 __ext4_journal_start_sb+0x110/0x188 [ext4]
 ext4_do_writepages+0x3dc/0x740 [ext4]
 ext4_writepages+0xa4/0x190 [ext4]
 do_writepages+0x94/0x228
 __writeback_single_inode+0x48/0x318
 writeback_sb_inodes+0x204/0x590
 __writeback_inodes_wb+0x54/0xf8
 wb_writeback+0x2cc/0x3d8
 wb_do_writeback+0x2e0/0x2f8
 wb_workfn+0x80/0x2a8
 process_one_work+0x178/0x3e8
 worker_thread+0x234/0x3b8
 kthread+0xf0/0x108
 ret_from_fork+0x10/0x20

So explicitly call cond_resched() in jbd2_log_do_checkpoint() to avoid
softlockup.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/jbd2/checkpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index b3971e91e8eb..38861ca04899 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -285,6 +285,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		retry:
 			if (batch_count)
 				__flush_batch(journal, &batch_count);
+			cond_resched();
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 	}
-- 
2.39.2


