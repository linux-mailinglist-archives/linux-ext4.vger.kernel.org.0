Return-Path: <linux-ext4+bounces-5848-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9029FBD49
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BA31881B65
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4F01C3F0A;
	Tue, 24 Dec 2024 12:29:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D151B87F5;
	Tue, 24 Dec 2024 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043357; cv=none; b=g381LA3baUKXxuvjndjg8fTY/lRHRFpV71J/Kh0l4zE1O1cwp1nlr+X3Y+PpZmUTYqnDoq05I3J25Qt6Rv7JzUKlZ0KEcK+zI1Ps48RuATd4A/lgdz3UDHH/zcVGxDh16l/qjIiWnLu50/t3vMOS36Mlk5KOXxjl17g4ruRPmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043357; c=relaxed/simple;
	bh=x2gbgwG4mO7RRAp389DxcxYM8zppio1NYhZ5+gcVBF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QStmwCZdZzYIjMpKDb4h6wfv5zRmGPBIE5GQ/rbYb3IP/6TF4kZhY1cd0OZ9RbWLeEftHY+TGWgzL3C1eS4k193ZzD7DGXBzQQWPvpcrouruT3CXowlOQL7PRGnWyMwQZtu0owPfINfOpZ8IOhC+hQQYXKI0Ne9eHX1zjBirGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHZ2208X1z4f3jt3;
	Tue, 24 Dec 2024 20:28:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9CE061A018D;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDXs8AWqWpnruNnFQ--.3177S6;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] jbd2: remove stale comment of update_t_max_wait
Date: Wed, 25 Dec 2024 04:27:05 +0800
Message-Id: <20241224202707.1530558-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDXs8AWqWpnruNnFQ--.3177S6
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4fZF13uF4kXr4xXF1fWFg_yoWfKFg_Xr
	4xCrsxXwnIqr42y3yfCw1fWrn5Wr1UZr1DZ3Zaya1jkr1jyanrur4vvrn5Wwnxua9Igr1a
	qw4kX340grnIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
	M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnr9NDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Commit 2d44292058828 "jbd2: remove CONFIG_JBD2_DEBUG to update t_max_wait"
removed jbd2_journal_enable_debug, just remove stale comment about
jbd2_journal_enable_debug.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/transaction.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 66513c18ca29..e00b87635512 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -119,7 +119,6 @@ static void jbd2_get_transaction(journal_t *journal,
  * t_max_wait is carefully updated here with use of atomic compare exchange.
  * Note that there could be multiplre threads trying to do this simultaneously
  * hence using cmpxchg to avoid any use of locks in this case.
- * With this t_max_wait can be updated w/o enabling jbd2_journal_enable_debug.
  */
 static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
-- 
2.30.0


