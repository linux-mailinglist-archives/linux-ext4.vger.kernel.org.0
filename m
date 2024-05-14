Return-Path: <linux-ext4+bounces-2504-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD648C5287
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48757282F3F
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E05D43AD6;
	Tue, 14 May 2024 11:25:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960613D533;
	Tue, 14 May 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685921; cv=none; b=DmTw58Yods1f9afG3V5+50+efV9vGmbGH70V2m6bQtmtAfc4NkZTs1KF0a33ZML1TSuBT0QaiiafeKOu/MjO1ZP6+29Xxk2ySeIT+5GSt5/Q867L4iAxW4VP7obTG/z7+1OuI/oSbWpazMsOgDSIJo7dMdLs/eccboLumZ1991k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685921; c=relaxed/simple;
	bh=El3vc94f/RnMLA66AkaVfl+4fBsQbfGJ7QeOm0Dhk0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVapQIjvBWF7LJxKagT5pWR/4mfvvBmk7IErduiDG4uLIDXWpQzMVvs1Q0dvRvgaruJFzpzah3fUqlQpB5Cmr5kbDPrGa6hgqk4a1lkPW5oxx1ZnDGFgYtkYA30kDx/dg05inf+IcCZWSICwMsEC/MkjDtO8/soEII/g60zAs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdvCl4W9pz4f3jdT;
	Tue, 14 May 2024 19:25:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3FF951A016E;
	Tue, 14 May 2024 19:25:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCHSKAXSkNm4rTMMQ--.61831S11;
	Tue, 14 May 2024 19:25:16 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] jbd2: remove unnecessary "should_sleep" in kjournald2
Date: Tue, 14 May 2024 19:24:38 +0800
Message-Id: <20240514112438.1269037-10-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgCHSKAXSkNm4rTMMQ--.61831S11
X-Coremail-Antispam: 1UD129KBjvdXoWrKFy3Jr1xKr4UZF47tFyrWFg_yoWDuFg_XF
	WIvFnrZrZxGr13JrZakw4Dur1Fvrs7XF1UZ3Z2y3yUKr1Ut3Z2ya1DXFZrA3s8Wan5trW3
	ua1xG3W8Kr9FqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTxFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We only need to sleep if no running transaction is expired. Simply remove
unnecessary "should_sleep".

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 59bff0b75ce7..bf3a425dc057 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -220,15 +220,12 @@ static int kjournald2(void *arg)
 		 * so we don't sleep
 		 */
 		DEFINE_WAIT(wait);
-		int should_sleep = 1;
 
 		prepare_to_wait(&journal->j_wait_commit, &wait,
 				TASK_INTERRUPTIBLE);
 		transaction = journal->j_running_transaction;
-		if (transaction && time_after_eq(jiffies,
-						transaction->t_expires))
-			should_sleep = 0;
-		if (should_sleep) {
+		if (transaction == NULL ||
+		    time_before(jiffies, transaction->t_expires)) {
 			write_unlock(&journal->j_state_lock);
 			schedule();
 			write_lock(&journal->j_state_lock);
-- 
2.30.0


