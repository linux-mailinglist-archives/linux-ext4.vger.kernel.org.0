Return-Path: <linux-ext4+bounces-6220-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7ACA19F69
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0626188C13D
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D82E20C46C;
	Thu, 23 Jan 2025 07:53:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340E1FF7B8;
	Thu, 23 Jan 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618792; cv=none; b=ifW2SVOdlNKbV4M441QfOM0d4boFlr+bKaY/4l8PvWdv2XwLJZ6bfHSe+Jyxy8RxpGQDWKt0z/vhSjq00AF9bo3xMBfol5DpNM2Hb9Frn8ZxRRnUIBiXrKsysMdvGXq6QVUYBcHoav/s6Pfdnh+Jqs70rUtTMRgn2MZ9LrdKZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618792; c=relaxed/simple;
	bh=fnmDo5FCMg/j+yZ47+lBDdyDrjxxZEtutR0XUo8rXmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dFGRwH8r1Z1/QbxH1XkP8GZV/0e+9CX8OB8No0vpp81jD/4jdbfMjNvN+MssdZ+pSTKM0RoRFoTW+Ckus5kFnArkwQg4P2pDe7h4OfATKWpYcOmIScBwUGKsOCsZYrXHqTpA7JhIOsYOPMeufnlt6BnrTtntng6G0kz+9F4OkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdtTZ1hX1z4f3jqC;
	Thu, 23 Jan 2025 15:52:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B03431A0D0F;
	Thu, 23 Jan 2025 15:53:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnR8Jf9ZFnizDkBg--.43540S3;
	Thu, 23 Jan 2025 15:53:05 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] jbd2: remove unused h_jdata flag of handle
Date: Thu, 23 Jan 2025 23:50:09 +0800
Message-Id: <20250123155014.2097920-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgCnR8Jf9ZFnizDkBg--.43540S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1UGFykJF1xXFWDZr15XFb_yoWDCFg_Aw
	4vyr4kWrWxXFnxXr1fKFnFyFsIkFW8Jr15uF1Fqr4kKryDZa98Ga1xtrs8ZrW7uFs7Cr43
	WF18WryxKrnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbk8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
	A2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2
	jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjTRua0BDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Flag h_jdata is not used, just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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


