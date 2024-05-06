Return-Path: <linux-ext4+bounces-2320-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31218BCFE8
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C571F231B5
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4A13D532;
	Mon,  6 May 2024 14:18:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEA13D242;
	Mon,  6 May 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005110; cv=none; b=SnDP5tjF82ueaO3wXE2RMvP239Y9kI1K1woPf0Fnsic85CIkqUVZQ9QOhyOvWstGzDHUWlpP7bgxwLdPqBJctuFS/+Fyha/p6EYhUjKdXUZ2hpc4NzxlYjKC00LXha8pHebbrmGhAaLsDJAxUOhGOQDVI1CaOJCK83O9isXn+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005110; c=relaxed/simple;
	bh=MClvf5fsRFeJSpyNo5rHADDgkDZjvkSoGtgTp/1/CtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L8rYhTPzlqQSzawjDkx9tRpSv9BGyQI0+gurMUbWlqCmfDmHkpWqD75SSXIjVKedV3E0t/EugS6qXh/3nE5MaK6X4IPazFK4kS3HpSzID0Ol9EqpT9Q6I0MG2bcEGVvDo45KcuaEZ/8SUfqLe0khRcBiBaFIzWU4LPmjWBLTYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VY3RC6QYQz4f3kFF;
	Mon,  6 May 2024 22:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1A8321A0572;
	Mon,  6 May 2024 22:18:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S2;
	Mon, 06 May 2024 22:18:23 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] A fix and some cleanups to jbd2
Date: Mon,  6 May 2024 22:17:52 +0800
Message-Id: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1fWFWrAFWkAw47WFy7GFg_yoWDtwc_ZF
	WkKF9rXwsxXFn8G3ZxCr1YgF95Jrs3XF1rtFn7AFsrJr17G3WfuwnrAF47Zr9xZa4vkrs0
	qw4Yq3y8Awn7CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s
	1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Patch 1 fixes memleak in jbd2_journal_write_metadata_buffer.
Patch 2-6 contain some cleanups to jbd2_journal_write_metadata_buffer().
Patch 7-9 contain some cleanups to kjournald2()
All tests in "kvm-xfstest smoke" survive. Please let me konw if more tests
should be ran. Thanks.

Kemeng Shi (9):
  jbd2: avoid memleak in jbd2_journal_write_metadata_buffer
  jbd2: remove unused return info from
    jbd2_journal_write_metadata_buffer
  jbd2: remove unnedded "need_copy_out" in
    jbd2_journal_write_metadata_buffer
  jbd2: move repeat tag around to remove a repeat check of b_frozen_data
  jbd2: remove unneeded kmap to do escape in
    jbd2_journal_write_metadata_buffer
  jbd2: use bh_in instead of jh2bh(jh_in) to simplify code
  jbd2: remove dead equality check of j_commit_[sequence/request] in
    kjournald2
  jbd2: remove dead check of JBD2_UNMOUNT in kjournald2
  jbd2: remove unnecessary "should_sleep" in kjournald2

 fs/jbd2/journal.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

-- 
2.30.0


