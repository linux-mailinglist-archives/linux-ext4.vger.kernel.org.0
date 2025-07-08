Return-Path: <linux-ext4+bounces-8890-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6639DAFC980
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 13:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106E54830C4
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jul 2025 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE22DAFDB;
	Tue,  8 Jul 2025 11:20:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8392D97AC;
	Tue,  8 Jul 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973643; cv=none; b=e5TgUPt5gzYhxYLLcYlO++4gZRf4y0KEDzzONR9yVJ9KLkbu9PiNMTVOT1iNP1YcMwp013sg1RaIPp9sm4begbVlWh9pO0xwBXJhwK9ESSNCIizhzrWG1IM2FXMUTrVmVJ5Gp/g0MabHHR9/8euTmkIiXYvmanRlzHd1Shia2EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973643; c=relaxed/simple;
	bh=305n4In7Fy1IyVGZjSNfCUKCZGbyPEWr2dh2B2kljX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mo2DSZwrNtvts9CRkBAg+40sCLVaUTxmPGDRj3kqIJ9B3rwEQYX53fKi2Q6nFUy4dwqHIxFZGzxzlrjiWrQV+iZrlEyYhco9/BAWg+jljCd7Wdcl5v18ioCIos145tZMQnnMfBUrxl+6xohygMnlS1a/Fz5Y1vO3CB+UzCuu1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bbzDk6wvMzKHN08;
	Tue,  8 Jul 2025 19:20:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6D5C71A0A01;
	Tue,  8 Jul 2025 19:20:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgCHNCID_2xoRA8sBA--.1438S4;
	Tue, 08 Jul 2025 19:20:37 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com
Subject: [PATCH] ext4: fix inode use after free in ext4_end_io_rsv_work()
Date: Tue,  8 Jul 2025 19:15:04 +0800
Message-Id: <20250708111504.3208660-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHNCID_2xoRA8sBA--.1438S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rtr1DZw4DJF4rGr47twb_yoW5Wr47pF
	yY9FWjkF47Zwn2grs8Jr4DXrs2qayxtF47W347WFy2v393JFs8t3W8tF15JF1UCrWfZF47
	ZF4rKwn8ZF45trDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgASBWhlEHNZ8QAEsX

From: Baokun Li <libaokun1@huawei.com>

In ext4_io_end_defer_completion(), check if io_end->list_vec is empty to
avoid adding an io_end that requires no conversion to the
i_rsv_conversion_list, which in turn prevents starting an unnecessary
worker. An ext4_emergency_state() check is also added to avoid attempting
to abort the journal in an emergency state.

Additionally, ext4_put_io_end_defer() is refactored to call
ext4_io_end_defer_completion() directly instead of being open-coded.
This also prevents starting an unnecessary worker when EXT4_IO_END_FAILED
is set but data_err=abort is not enabled.

This ensures that the check in ext4_put_io_end_defer() is consistent with
the check in ext4_end_bio(). Otherwise, we might add an io_end to the
i_rsv_conversion_list and then call ext4_finish_bio(), after which the
inode could be freed before ext4_end_io_rsv_work() is called, triggering
a use-after-free issue.

Fixes: ce51afb8cc5e ("ext4: abort journal on data writeback failure if in data_err=abort mode")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/page-io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 179e54f3a3b6..3d8b0f6d2dea 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -236,10 +236,12 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
 
 static bool ext4_io_end_defer_completion(ext4_io_end_t *io_end)
 {
-	if (io_end->flag & EXT4_IO_END_UNWRITTEN)
+	if (io_end->flag & EXT4_IO_END_UNWRITTEN &&
+	    !list_empty(&io_end->list_vec))
 		return true;
 	if (test_opt(io_end->inode->i_sb, DATA_ERR_ABORT) &&
-	    io_end->flag & EXT4_IO_END_FAILED)
+	    io_end->flag & EXT4_IO_END_FAILED &&
+	    !ext4_emergency_state(io_end->inode->i_sb))
 		return true;
 	return false;
 }
@@ -256,6 +258,7 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
 	WARN_ON(!(io_end->flag & EXT4_IO_END_DEFER_COMPLETION));
 	WARN_ON(io_end->flag & EXT4_IO_END_UNWRITTEN &&
 		!io_end->handle && sbi->s_journal);
+	WARN_ON(!io_end->bio);
 
 	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
 	wq = sbi->rsv_conversion_wq;
@@ -318,12 +321,9 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
 void ext4_put_io_end_defer(ext4_io_end_t *io_end)
 {
 	if (refcount_dec_and_test(&io_end->count)) {
-		if (io_end->flag & EXT4_IO_END_FAILED ||
-		    (io_end->flag & EXT4_IO_END_UNWRITTEN &&
-		     !list_empty(&io_end->list_vec))) {
-			ext4_add_complete_io(io_end);
-			return;
-		}
+		if (ext4_io_end_defer_completion(io_end))
+			return ext4_add_complete_io(io_end);
+
 		ext4_release_io_end(io_end);
 	}
 }
-- 
2.46.1


