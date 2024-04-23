Return-Path: <linux-ext4+bounces-2157-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE98AE675
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 14:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A330B1F2212D
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Apr 2024 12:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECF912F386;
	Tue, 23 Apr 2024 12:40:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4412DDA6;
	Tue, 23 Apr 2024 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876054; cv=none; b=FJUjLwqfEdYcnOdzGQdlphiKwiUGPIHjgsq2ncNqjhRZofVLLRHZPYH8cf6j351F+8ZWS7x84YeNYn6WWoFRYuo/f+f/XR8fOlmusax989hiCSEsf28J9yrMn9I5IjUL1rkJAcntm50sm116Ybg37hO+4Gda4oV0rIm+xGM2RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876054; c=relaxed/simple;
	bh=bM/5/UZz7y7Dir5YzA9mx/Rw5dJrHRBstIGYZNdtt/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMVxouWece1Lz9DygmcgH95xqgPzHmc8TWdJa+0Dv83u6DGVUZeWLPCxwYL98pZvsRhhriHj/PTdLxWn4qtCgnaE3LUw3iLFuORAz+bpgudHzvB6mpRMb8hCWvIhwXiIck1Nkm9hSbbI7MaBFFtYb1rSmFdR5l/jyMGrvxpK8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VP1tg2DQqz4f3kkQ;
	Tue, 23 Apr 2024 20:40:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 23F7A1A0175;
	Tue, 23 Apr 2024 20:40:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3VQ5OrCdm2gAAKw--.9734S2;
	Tue, 23 Apr 2024 20:40:47 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com
Subject: [PATCH v2 0/5] Minor improvements and cleanups to ext4 mballoc
Date: Tue, 23 Apr 2024 20:40:41 +0800
Message-Id: <20240423124046.974134-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3VQ5OrCdm2gAAKw--.9734S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4Uur1xGF47uFyfWw1rJFb_yoWDKrX_Ga
	yvqa4kJr43XF97GFyIkr1rtrykKa1Iyrs8XasYq3yYqFWxXrs3X3WDCrWfur1UWF1ayFyU
	JF13ZryrAr42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbr8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
	0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

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
 fs/ext4/mballoc-test.c | 52 ++++++++++++++++++++++++++
 fs/ext4/mballoc.c      | 84 ++++++++++++++++++++++--------------------
 fs/ext4/mballoc.h      |  4 +-
 4 files changed, 105 insertions(+), 44 deletions(-)

-- 
2.30.0


