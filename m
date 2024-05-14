Return-Path: <linux-ext4+bounces-2498-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C28C527C
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4171282E62
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3D13D636;
	Tue, 14 May 2024 11:25:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5B13D51A;
	Tue, 14 May 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685919; cv=none; b=OfZVmCmmCZ7I83+r9UH3LyMd+h+2tcMMkZdPmLlMXgI02N+xt50udtJ8bLN6wCiBYZgQs5d1NBwQA1/f4MeQfzioTv+rx0HpK4SsOIU+SpZYVw+9AxUelqTBGfxfeIZID8fqMQDFQgGkwI3k1tW5/Kz+ZLrkI2VHrWwT4Acurhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685919; c=relaxed/simple;
	bh=nKvQgVlt5oqtiml97r/Oz2DrUff+3B8pWePr2n+l/gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSRlJ9Szo+FSM8txkqvTE+7fAZRR6wtmcIaysNIn0t3ayvOaPr5TG8GboWRecyjauobJkAxpXv0+wylxpLb+rCa2yZBnVIFFBuzgfQcRBskAJvhXDj7HTdcfraGE0J3MNY2+6FwW7zcsB8G+BF5GR32A/9UtOEDpcAaUGFdrWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdvCm1r8dz4f3kJr;
	Tue, 14 May 2024 19:25:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C13201A0181;
	Tue, 14 May 2024 19:25:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCHSKAXSkNm4rTMMQ--.61831S3;
	Tue, 14 May 2024 19:25:13 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
Date: Tue, 14 May 2024 19:24:30 +0800
Message-Id: <20240514112438.1269037-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgCHSKAXSkNm4rTMMQ--.61831S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1UuFyrKr1fCFyUtr4kXrb_yoW3JFc_WF
	Wvvr4xZwsxXFn7A3Z5u3429rnYkrs5Gr1kuw1ftw13Kr1Ut3yfJFnrJrn09r9ruan2gr4Y
	kwn2kFWftr9xJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
	ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
	62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
	AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
	4UYxBIdaVFxhVjvjDU0xZFpf9x0JUHHq7UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The new_bh is from alloc_buffer_head, we should call free_buffer_head to
free it in error case.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b6c114c11b97..207b24e12ce9 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -399,6 +399,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		spin_lock(&jh_in->b_state_lock);
-- 
2.30.0


