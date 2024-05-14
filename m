Return-Path: <linux-ext4+bounces-2496-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902FD8C5276
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E5D1C21718
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30E13D53D;
	Tue, 14 May 2024 11:25:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B748CF2;
	Tue, 14 May 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685919; cv=none; b=PJ9MZId37JcbF/q0EAzrKJgNvvGRjwYXnkbjrDgxSsnUOWX0FDcamtDo5EDQ5Tsb70V9Gar4YF8+AjIExtz3iJDZHsEy7hjF/47usvnN4PZoN6JXYMgKDf4vQr3oD61fa3xYLLNLhH2KXiHVyGFD7sGIPW1jnON3kM8uxARhJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685919; c=relaxed/simple;
	bh=JZ8hPgZYNySm6liu5QHHuI3IvzBQOuIu23k6l/4xmM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hUpesLNQxw7RICwfcInU73t7Y9DyLt04oRM6WFo4dH20gkR3yPuWHJcsISTeNDZ5OGr0lNGf2vYqMH1A0rWf6+g8Wb2qZnafOWZqehtI/dHZbEDsgK1tJlA1/ej9QO3ejsfWakoQyK0MZSjD+4PqANoglAMaOrYMHc+Fx4/EVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdvCh5w4fz4f3jdL;
	Tue, 14 May 2024 19:25:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 70DE81A0FD2;
	Tue, 14 May 2024 19:25:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCHSKAXSkNm4rTMMQ--.61831S2;
	Tue, 14 May 2024 19:25:13 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] A fix and some cleanups to jbd2
Date: Tue, 14 May 2024 19:24:29 +0800
Message-Id: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHSKAXSkNm4rTMMQ--.61831S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryfAr1rAr47GF47Jr1kZrb_yoW8JFyUpF
	yfKa1Syryvvry2qrsxZF4UW3y5Gr10kry7GwnFkF18Aw1UAr17uF1qyF18AryUXFZ3Ka10
	qrykX3s5GF12kFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v1->v2:
-Collect RVB from Yi and Jan
-remove rename "flags" to "escape" in patch 2/9
-goto new copy_done tag in patch 4/9
-add more comment in patch 5/9

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
  jbd2: jump to new copy_done tag when b_frozen_data is created
    concurrently
  jbd2: remove unneeded kmap to do escape in
    jbd2_journal_write_metadata_buffer
  jbd2: use bh_in instead of jh2bh(jh_in) to simplify code
  jbd2: remove dead equality check of j_commit_[sequence/request] in
    kjournald2
  jbd2: remove dead check of JBD2_UNMOUNT in kjournald2
  jbd2: remove unnecessary "should_sleep" in kjournald2

 fs/jbd2/commit.c  | 10 ++++-----
 fs/jbd2/journal.c | 54 ++++++++++++++++++-----------------------------
 2 files changed, 25 insertions(+), 39 deletions(-)

-- 
2.30.0


