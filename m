Return-Path: <linux-ext4+bounces-6681-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86300A542DA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 07:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60E43AEA05
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04191A0711;
	Thu,  6 Mar 2025 06:37:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59119CC08;
	Thu,  6 Mar 2025 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243047; cv=none; b=LsffZxzvIA3bWLMZriRuAWmiGciLRmsaXgsAPPF9ZmbdxYaR8q/2dStbxL0cV/LIZLjWb/jxzqdf85+TQS5L0MezOvq1/5DlVF8lQn/oSOHPxX0vwZzS1mv+ZBG7x3P5AYuy0aHOdt4CKsKD1zBBOROK9A2A/kbdy8OYmZrI1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243047; c=relaxed/simple;
	bh=HFoHSfplOgZCiqY8zDKCWgwmxCt1FJB6aWfOeBanAsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvi181rX7JFzjnn4GuCN3eiCFwfpSok5tcD3Md/o8n929z1vIYm4jWfeVdW4NBirhYbIypMHAIPufRAM+4P05Nc2tBMSKsNveCR0Cqa6aTYUB7XS83r3R3sTTBURxpf5Aiw7KnUT73odTrqO3r7g8/F7IaOPEGQE+VgcCX5NpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z7fpX00NBz4f3jJK;
	Thu,  6 Mar 2025 14:36:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 25C091A179F;
	Thu,  6 Mar 2025 14:37:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGCYQslneN7AFg--.9515S4;
	Thu, 06 Mar 2025 14:37:13 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH] jbd2: remove jbd2_journal_unfile_buffer()
Date: Thu,  6 Mar 2025 14:32:40 +0800
Message-Id: <20250306063240.157884-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGCYQslneN7AFg--.9515S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxKF1rGF1Duw18Zw4rAFb_yoW8CFWrpF
	9Ik348Zr9YvrW8Zr1kWF45AFWjga1q9ryUGrWv93Z7ta1Ut3saq34Utr129F98tFWIg34U
	Xr1UG3yDC34jqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgATBWfIBf5ODAAAsC

From: Baokun Li <libaokun1@huawei.com>

Since the function jbd2_journal_unfile_buffer() is no longer called
anywhere after commit e5a120aeb57f ("jbd2: remove journal_head from
descriptor buffers"), so let's remove it.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/jbd2/transaction.c | 15 ---------------
 include/linux/jbd2.h  |  1 -
 2 files changed, 16 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 9fe17e290c21..2bc14291a0fb 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2078,21 +2078,6 @@ static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
 	jh->b_transaction = NULL;
 }
 
-void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
-{
-	struct buffer_head *bh = jh2bh(jh);
-
-	/* Get reference so that buffer cannot be freed before we unlock it */
-	get_bh(bh);
-	spin_lock(&jh->b_state_lock);
-	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_unfile_buffer(jh);
-	spin_unlock(&journal->j_list_lock);
-	spin_unlock(&jh->b_state_lock);
-	jbd2_journal_put_journal_head(jh);
-	__brelse(bh);
-}
-
 /**
  * jbd2_journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 82ef232935c0..2205c99beff4 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1401,7 +1401,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
  */
 
 /* Filing buffers */
-extern void jbd2_journal_unfile_buffer(journal_t *, struct journal_head *);
 extern bool __jbd2_journal_refile_buffer(struct journal_head *);
 extern void jbd2_journal_refile_buffer(journal_t *, struct journal_head *);
 extern void __jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
-- 
2.46.1


