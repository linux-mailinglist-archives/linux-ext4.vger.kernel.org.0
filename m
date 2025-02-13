Return-Path: <linux-ext4+bounces-6431-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42146A33DE5
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 12:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF332161AEF
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Feb 2025 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A242227E96;
	Thu, 13 Feb 2025 11:26:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F910227E85;
	Thu, 13 Feb 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445975; cv=none; b=bkDEGqzf4yVXyxVaS1POhKiGo6Sa4EUHa2vNYjzGS87hRaplsrBLmSrpAMYf8v559uctKMF3Y7LgRUodAEQGHQlTk/PI2KGAxWqKsA8MGnuOSRX165Slf/LR8fkP/8+X5/fGqSqbFHVZID6iA8g3yREDl/WbNDUQ6G3tWQVt+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445975; c=relaxed/simple;
	bh=d6iyyItJ3UXuj5zewdFS49nBRey4JJs4EZsMNEp0BWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BpM/tLuH9gD1OwWEnDXF/DrYVDtFYB8bR0Ins1gLg5+gxasX1vQB9oFinSOhgBpzs3Of9qfs27jjNUCYdXCjt/xwvw3whyY5H75oA/8dRH0SJ+KieLijbk4HKupAQrqQadZlqpqhMM9pIQGTueqaP2waTvTDRTbiPIM9Ch4gBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YttCg1r6jz4f3jsy;
	Thu, 13 Feb 2025 19:25:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 591DC1A08FE;
	Thu, 13 Feb 2025 19:26:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB321_N1q1nQbvpDg--.19969S4;
	Thu, 13 Feb 2025 19:26:07 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	bfoster@redhat.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH] ext4: goto right label 'out_mmap_sem' in ext4_setattr()
Date: Thu, 13 Feb 2025 19:22:47 +0800
Message-Id: <20250213112247.3168709-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB321_N1q1nQbvpDg--.19969S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF45ZFykGryDuryfWw4Uurg_yoW8Ww1Upr
	y3KFykKr4UWFZF9F40gr1FgFyjkan8C3yUWF92yry7ZF9xtr1aqF17tF1UZFW7GrWUXa4S
	qFn8Zr1xZry5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSLvNUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAQBWerBPsbNgACsL

From: Baokun Li <libaokun1@huawei.com>

Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
happen because filemap_invalidate_unlock() isn't called to unlock
mapping->invalidate_lock. Like this:

EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
INFO: task fsstress:374 blocked for more than 122 seconds.
      Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
                                  task_flags:0x440140 flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x2c9/0x7f0
 schedule+0x27/0xa0
 schedule_preempt_disabled+0x15/0x30
 rwsem_down_read_slowpath+0x278/0x4c0
 down_read+0x59/0xb0
 page_cache_ra_unbounded+0x65/0x1b0
 filemap_get_pages+0x124/0x3e0
 filemap_read+0x114/0x3d0
 vfs_read+0x297/0x360
 ksys_read+0x6c/0xe0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3cc8da6357aa..04ffd802dbde 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5452,7 +5452,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			    oldsize & (inode->i_sb->s_blocksize - 1)) {
 				error = ext4_inode_attach_jinode(inode);
 				if (error)
-					goto err_out;
+					goto out_mmap_sem;
 			}
 
 			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
-- 
2.39.2


