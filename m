Return-Path: <linux-ext4+bounces-5846-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAFA9FBD48
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2477A066D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7F1C1F20;
	Tue, 24 Dec 2024 12:29:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AA71B6CF6;
	Tue, 24 Dec 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043357; cv=none; b=Zt906AqPB+xV9KjyqdqjM/d7wwapHYKIbCE10EhN0E1DFLdyresZDsJ+z7oVX2nps3BF0LL7GdT5Ds4/YIlZUszNeMXD+Mgv0Qux5Vkq2xStQ3bCuqe0zDaERbqyIZVwTriGXYSbGFnGA2IyHm2KH0p0tG5lZUAFA5VWHfup32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043357; c=relaxed/simple;
	bh=sl03qk5wmNGrYwSL8jjvJ+NBSErs41ttHRFZc7vUYRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IxStntRr5nO5dO7i9N5AuKTKeZSakPjiHdjVF5U5Cnvpuq3/ldrqC8fiE8SBgQFWAKJBO/GSopmsIrcn0bR3GYLWtYYbAoTdXLTSRVvA6XtJ5quyxUippXC1rjndPVAV8gLfTFz4CdshRTrskpcIOBUiQC4B6npcRuSiK9eVMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHZ1w1F4wz4f3jdG;
	Tue, 24 Dec 2024 20:28:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D59251A018D;
	Tue, 24 Dec 2024 20:29:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDXs8AWqWpnruNnFQ--.3177S3;
	Tue, 24 Dec 2024 20:29:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] jbd2: remove unused h_jdata flag of handle
Date: Wed, 25 Dec 2024 04:27:02 +0800
Message-Id: <20241224202707.1530558-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDXs8AWqWpnruNnFQ--.3177S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1UGFykJF1xXFWDZr15XFb_yoWftrX_Aw
	4vyrs7WrWxXFnxXw1fKFnrAFsxGay8Jr1UuFnYqr4qkryUZay5Ww4xAFs8ZrW7uFs3Cr43
	WF18WryxKrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_
	Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0a0PDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Flag h_jdata is not used, just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 include/linux/jbd2.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 50f7ea8714bf..c7fdb2b1b9a6 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -459,7 +459,6 @@ struct jbd2_revoke_table_s;
  * @h_ref: Reference count on this handle.
  * @h_err: Field for caller's use to track errors through large fs operations.
  * @h_sync: Flag for sync-on-close.
- * @h_jdata: Flag to force data journaling.
  * @h_reserved: Flag for handle for reserved credits.
  * @h_aborted: Flag indicating fatal error on handle.
  * @h_type: For handle statistics.
@@ -491,7 +490,6 @@ struct jbd2_journal_handle
 
 	/* Flags [no locking] */
 	unsigned int	h_sync:		1;
-	unsigned int	h_jdata:	1;
 	unsigned int	h_reserved:	1;
 	unsigned int	h_aborted:	1;
 	unsigned int	h_type:		8;
-- 
2.30.0


