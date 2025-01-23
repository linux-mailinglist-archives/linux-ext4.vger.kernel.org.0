Return-Path: <linux-ext4+bounces-6219-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A09A19F66
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89152188BFED
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B44D20C02E;
	Thu, 23 Jan 2025 07:53:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB6920B213;
	Thu, 23 Jan 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618792; cv=none; b=J+3kj2PSGCTPQupjt//u2tccwMUjFICWSFz7NPisUt7SF4rsmxmvwdklms6uWIlIM57T/dpbn1GSFddao+1+2cjJsNQ4L6bs2ei5AbVN+bxx0p7/m3rLyQf0YJ+pf/11oq6vXkEqi0BM7h1+eAF2JNt38VUzzb9gF6OwWlUpWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618792; c=relaxed/simple;
	bh=34Zj4k6Rd1vfuXRp8RJV/mHALLDbfjDr61gLULEBpTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjK659x+NkGFEjqWDqxwjwA7OVEdYhEzb7j5RVUNCK2KUrIUbBiXRbpTHyKU4yleowydhT3NfxVEbljklA4hliuvGO+CDA3Ez9TxQqmUTpZFwuDSf1TnSoEpzvgERqH4DDkF14/QUte+uGwTLcogQbGR5j5ueZ68HdQF9G2zv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdtTV1kXzz4f3jY6;
	Thu, 23 Jan 2025 15:52:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DDEC41A018C;
	Thu, 23 Jan 2025 15:53:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnR8Jf9ZFnizDkBg--.43540S7;
	Thu, 23 Jan 2025 15:53:06 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] jbd2: correct stale function name in comment
Date: Thu, 23 Jan 2025 23:50:13 +0800
Message-Id: <20250123155014.2097920-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
References: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnR8Jf9ZFnizDkBg--.43540S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4DGF1rtw1UXw1DJF13Jwb_yoW8Zw13pr
	9Yka45ZrZ8u34jvF1fWay5G3y7Ka1DZ3yjgFWv93Z2ga15J3sIqr48try2qrWDKFn7K34U
	AFWUCws5G3y09FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7sREdgWtUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Rename stale journal_clear_revoked_flag to jbd2_clear_buffer_revoked_flags.
Rename stale journal_switch_revoke to jbd2_journal_switch_revoke_table.
Rename stale __journal_file_buffer to __jbd2_journal_file_buffer.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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
index cebf0859048f..3f48ae96fb6c 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2189,7 +2189,7 @@ static int __dispose_buffer(struct journal_head *jh, transaction_t *transaction)
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


