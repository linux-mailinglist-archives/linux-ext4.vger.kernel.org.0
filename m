Return-Path: <linux-ext4+bounces-3563-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC541942A8F
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE3281EF8
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267461AC438;
	Wed, 31 Jul 2024 09:31:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684218C93B;
	Wed, 31 Jul 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418314; cv=none; b=R+P4yggT8mViOZ7jc8ktZQuK103AHr7MjWJqPpDcz2smUBFPFwLHJtuB7sOpd16mtOIdRKbXrTQsFMZ1armaOQr0F5Q9Ht068ISCcxUNzIsu3Wruavz7iwnFivPP1aYPTOW+Ky8q27IgrQnfsW4clQpO3fWx+NGTWaUIzN65Sjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418314; c=relaxed/simple;
	bh=Py8ou2K68+gmANUwBPx6Uulh9cO3lfgjfVdcnqkouLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pw2hOhmtCEhEhALvbo9oltr5Bw9Qo7k56NkcnhkdDgKEFAB8dRQNWdgMCr9Fm1lN6igZ8QbADWTotPzqVCRwYZbPj9ddA7XgUwt/PkCvFsty+l6xykXVuh77NHgzLjMLzxXclXoBK8TxRiUGYxWR3s7EIQloKstclMsWuCsFwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYn0k25Q7z4f3lWD;
	Wed, 31 Jul 2024 17:31:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3D7691A0568;
	Wed, 31 Jul 2024 17:31:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgC3oL+CBKpm5KxyAQ--.8660S2;
	Wed, 31 Jul 2024 17:31:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Fix and cleanups to jbd2
Date: Wed, 31 Jul 2024 17:29:02 +0800
Message-Id: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3oL+CBKpm5KxyAQ--.8660S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1fCF1kuF47Ar4kJFykAFb_yoWkJwc_ZF
	WvgF9rJwsxXF17Wa43Cr13WrWrWw48Jr18KF95Za1DKr1xJ3Z5Zw1UGF4UZrnxX3yvk3y5
	Kr4Yq3y8tw1kCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUboxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v2->v3:
-Improve patch "jbd2: remove unneeded check of ret in jbd2_fc_get_buf"
-Collect RVB from Yi.

v1->v2:
-Move escape handle to futher improve
jbd2_journal_write_metadata_buffer.
-Collect RVB from Jan

This series contains a fix and some random cleanups to jbd2. More
details can be found in respective patches. Thanks!

Kemeng Shi (8):
  jbd2: correctly compare tids with tid_geq function in
    jbd2_fc_begin_commit
  jbd2: remove dead check in journal_alloc_journal_head
  jbd2: remove unused return value of jbd2_fc_release_bufs
  jbd2: remove unneeded kmap for jh_in->b_frozen_data in
    jbd2_journal_write_metadata_buffer
  jbd2: remove unneeded done_copy_out variable in
    jbd2_journal_write_metadata_buffer
  ext4: move escape handle to futher improve
    jbd2_journal_write_metadata_buffer
  jbd2: correct comment jbd2_mark_journal_empty
  jbd2: remove unneeded check of ret in jbd2_fc_get_buf

 fs/jbd2/journal.c    | 95 +++++++++++++++++++-------------------------
 include/linux/jbd2.h |  2 +-
 2 files changed, 42 insertions(+), 55 deletions(-)

-- 
2.30.0


