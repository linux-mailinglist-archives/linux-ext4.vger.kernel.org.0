Return-Path: <linux-ext4+bounces-2165-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D858B01A4
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 08:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C012C1F23485
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10ED156C73;
	Wed, 24 Apr 2024 06:19:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43215687B;
	Wed, 24 Apr 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939552; cv=none; b=nrQPDD+jno9sdWZ8Djyp9SB5NaLCOFfnaI3inuT52BAU2sq2oaJcmwZ1u5LdrwYvVv9SdmbDUNxu4zQzhy2OFFHY5+0ikhgcihN07G1IPYqsnENpzQEUosz3UC8Yq2FKE8L8Y/4pZMKQp0UPZjCOmrBw7PAIHnoRX3k30bocyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939552; c=relaxed/simple;
	bh=fPYGLT/iGvmGeGpksQKf2pRgnwDfjQ8ejYI6arqFQSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iYS+jVZ+e4ackeu87mPwxQXYHAauhfXTJxGq2q99VB6BHaoN+CVOh2gJQ7SCKIcpmFOoEqP9AUxiwlPDFnnnEaRS7nzq/abyJRkz6/gPi8GU+EWiWxzITquW3Z0Fjtd6sM8TMdXzgFBPqhbi9UlnFUviJvHWMSfhjRn1t9aOubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPTMk0TgTz4f3lWF;
	Wed, 24 Apr 2024 14:18:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4412E1A058D;
	Wed, 24 Apr 2024 14:19:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBHGRJZpChmpfZBKw--.32510S2;
	Wed, 24 Apr 2024 14:19:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v3 0/5] Minor improvements and cleanups to ext4 mballoc
Date: Wed, 24 Apr 2024 14:18:59 +0800
Message-Id: <20240424061904.987525-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGRJZpChmpfZBKw--.32510S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4UJr4fuw4ruw4fWr17Wrg_yoWkCrb_Ga
	ykZa4kJr45XF97GFy2kr1rtryvga1Iyr45Xa4Fq3yFqFWxXwsxX3WDCrWfZr15WF13tFyU
	JFnxZryrAr42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUboAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v2->v3:
-Coleect RVB from Jan
-Remove more unneeded "cr =" in comment

v1->v2:
-Collect RVB from Jan and Ojaswin
-Rewrite changelog of "ext4: call ext4_mb_mark_free_simple to free
continuous bits in found chunk"
-Remove "cr =" in comment of criteria name as criteria name has CR_
prfefix now.
-Only open codeing repeated checks in next_linear_group

This series contains some minor improvements and cleanups to ext4
mballoc. No failure is found in "kvm-xfstests smoke" test and unit
test. More details can be found in respective patches. Thanks!

Kemeng Shi (5):
  ext4: keep "prefetch_grp" and "nr" consistent
  ext4: add test_mb_mark_used_cost to estimate cost of mb_mark_used
  ext4: call ext4_mb_mark_free_simple to free continuous bits in found
    chunk
  ext4: use correct criteria name instead stale integer number in
    comment
  ext4: open coding repeated check in next_linear_group

 fs/ext4/ext4.h         |  9 +++--
 fs/ext4/mballoc-test.c | 52 +++++++++++++++++++++++++
 fs/ext4/mballoc.c      | 86 ++++++++++++++++++++++--------------------
 fs/ext4/mballoc.h      |  4 +-
 4 files changed, 106 insertions(+), 45 deletions(-)

-- 
2.30.0


