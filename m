Return-Path: <linux-ext4+bounces-5849-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580F9FBD4E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F214162D15
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8981D6DAD;
	Tue, 24 Dec 2024 12:29:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB91B87CD;
	Tue, 24 Dec 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043358; cv=none; b=YcB8JudnXdIvpWgASvH2vrzmdT7oSHaDmohO+ePO2fdqjyqsHe22EuTLU+BDopQ+NHELUzai2iN9P++yXSldk1hE8FXHyoSOp4r9ILFtgcX07q+R5muHZqXdUrK9T4Lxx0OpFuJzDwmrjeusri3lVY94VOtdQeeei9rAuGjFoPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043358; c=relaxed/simple;
	bh=4NU4+a42K4/yEFEblXfTCu13CBN/9PLQ9TDxTpMrhWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lHIKNQ5u7N1OdVaHjcNMq1iwvVIrFtQ0mlh7FYKE5DD91GfqzWP86U3AJ+7Du2yjzEbu8FbQyeNUDrzs8iQN0EJ9EIepGR1PpQAOlnu0bmUxUKJ2zbH+ut9eUY7lGlvYY8ug9yNN9g/iNygPIz4Pu92t4lbx+hmrfXowvh3tGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHZ221m2Hz4f3jt5;
	Tue, 24 Dec 2024 20:28:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D72D31A0196;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDXs8AWqWpnruNnFQ--.3177S7;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] jbd2: correct stale function name in comment
Date: Wed, 25 Dec 2024 04:27:06 +0800
Message-Id: <20241224202707.1530558-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDXs8AWqWpnruNnFQ--.3177S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4DGF1DJr1xKr45try3twb_yoW8Zr4rpr
	9YkFy5ZrZ8Z34jyF1xWay5GrW7Ka4kZ3yUWFWv93Z7Ka15J3sIqr48try2qrWDKFn7K3yU
	AFWUCws5G3y09FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7Jw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jyYLPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Rename stale journal_clear_revoked_flag to jbd2_clear_buffer_revoked_flags.
Rename stale journal_switch_revoke to jbd2_journal_switch_revoke_table.
Rename stale __journal_file_buffer to __jbd2_journal_file_buffer.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/revoke.c      | 8 ++++----
 fs/jbd2/transaction.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index af0208ed3619..5b7350109c5a 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -474,7 +474,7 @@ void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
 }
 
 /*
- * journal_clear_revoked_flag clears revoked flag of buffers in
+ * jbd2_clear_buffer_revoked_flags clears revoked flag of buffers in
  * revoke table to reflect there is no revoked buffers in the next
  * transaction which is going to be started.
  */
@@ -503,9 +503,9 @@ void jbd2_clear_buffer_revoked_flags(journal_t *journal)
 	}
 }
 
-/* journal_switch_revoke table select j_revoke for next transaction
- * we do not want to suspend any processing until all revokes are
- * written -bzzz
+/* jbd2_journal_switch_revoke_table table select j_revoke for next
+ * transaction we do not want to suspend any processing until all
+ * revokes are written -bzzz
  */
 void jbd2_journal_switch_revoke_table(journal_t *journal)
 {
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e00b87635512..908baf73b188 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2191,7 +2191,7 @@ static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
 		/*
 		 * We don't want to write the buffer anymore, clear the
 		 * bit so that we don't confuse checks in
-		 * __journal_file_buffer
+		 * __jbd2_journal_file_buffer
 		 */
 		clear_buffer_dirty(bh);
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
-- 
2.30.0


