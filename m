Return-Path: <linux-ext4+bounces-6216-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE6AA19F61
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEC2188C111
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 07:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D6320B807;
	Thu, 23 Jan 2025 07:53:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEC1C5D5F;
	Thu, 23 Jan 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618791; cv=none; b=Vl90IfAVpRNA2rQE4fzi19451Zi9840rvVydCHwgUiYse7EmSK+blar01WeKg0+WdqHg6o9BhlpBEnR0zHwQQm9B+BNECSvEUbm4jc8qLPYKQFr6nbgN3dg9/xGhIHw4iByV8uaG8Mi6bup0kABwJzp6vUUwn58Kq51FiJV6DxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618791; c=relaxed/simple;
	bh=Kb7DDGZ/VSKtUYWsBtLwQXfwb2qCG31/rFHXrLPwVBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dkHW0qrpT/trkCxiysnt92AYEZ5uoJaGLXH6beQwuvzhCd/NZm/ncgVKAipedHyKb5Jot59nkq9q/2djo37euw4Tyg1OCeL3SjL2qQ4/FLy6ZSUGTrI+zqnls3Mcb3Vk2QNv+eE4h1bzDcYyl4Uzbp9BgWA10RBX3xO6rrLwO/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdtTR3jYzz4f3lV7;
	Thu, 23 Jan 2025 15:52:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7085F1A0D0F;
	Thu, 23 Jan 2025 15:53:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnR8Jf9ZFnizDkBg--.43540S2;
	Thu, 23 Jan 2025 15:53:05 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Minor cleanups to jbd2
Date: Thu, 23 Jan 2025 23:50:08 +0800
Message-Id: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnR8Jf9ZFnizDkBg--.43540S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4ktr17tFyDtr15CF17ZFb_yoW3ZFg_Xa
	yqkFZ8CryUWFy3C3WI9w1FgF92kw48Wr1Yq3Z5t3yYyrn7Xan3Xw1DArs5Xr97Wa1qkry5
	Krn8WrW8Jrn3ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
	k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7sR_XdjtUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-Collect RVB from Jan and Yi.
-Remove more stale comment in patch 4/6 as Yi suggested.

This series contains some random minor cleanups to jbd2. No funtional
change is intended. More details can be found in respective patches.
Thanks.

Kemeng Shi (6):
  jbd2: remove unused h_jdata flag of handle
  jbd2: remove unused return value of jbd2_journal_cancel_revoke
  jbd2: remove unused return value of do_readahead
  jbd2: remove stale comment of update_t_max_wait
  jbd2: correct stale function name in comment
  jbd2: Correct stale comment of release_buffer_page

 fs/jbd2/commit.c      |  4 ++--
 fs/jbd2/recovery.c    | 11 +++--------
 fs/jbd2/revoke.c      | 13 +++++--------
 fs/jbd2/transaction.c |  5 +----
 include/linux/jbd2.h  |  4 +---
 5 files changed, 12 insertions(+), 25 deletions(-)

-- 
2.30.0


