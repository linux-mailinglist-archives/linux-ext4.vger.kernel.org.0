Return-Path: <linux-ext4+bounces-3515-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5594941095
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC9E1F2359C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E019ADA8;
	Tue, 30 Jul 2024 11:36:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E0199230;
	Tue, 30 Jul 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339377; cv=none; b=UjLn0RnpAtg0nKm8P7DIg4x+SQBK04ZVa4qgy0XPuDdXDrtfy5ACp0/EP75fzilIftk2utkjF/VNblfj1QN+EEtxu/fr+oQgTQ2ICKNTaTmbyQdkm5+wr65XLVhgwLobZn4e1/7ozy5rYERpsBK9+ECvsYMP2bt4HM3dfvHOH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339377; c=relaxed/simple;
	bh=yYxJ22SQbeRiW53xkrC3spUhsoJhj3TfioxXvQ12jZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EgruNjmvDRjg9wA8tkyTBhq6STTX1esKyf1+1GACt+vpBU9+m+q5j9BvuIStowiU3uK+MLO/qXY63eHDdR5a87stM7EObQRr0NpFIOiznDGxhHyCEGXVuUxVfmTa3mia/gHpmp1Ik0JgZ3XHdmfXlUyksrJgCruJ7Qf+jNe6I6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYCpq1z8cz4f3k6D;
	Tue, 30 Jul 2024 19:36:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DD31B1A14A5;
	Tue, 30 Jul 2024 19:36:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCH2kwq0Khmm+QUAQ--.5153S2;
	Tue, 30 Jul 2024 19:36:11 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Fix and cleanups to jbd2
Date: Tue, 30 Jul 2024 19:33:28 +0800
Message-Id: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH2kwq0Khmm+QUAQ--.5153S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4xJrWrJryrJF4UKr1rJFb_yoW3Zrc_XF
	WvgF98Xw4aqF17W3WxCF13GrZ5Ww4xWr1rKFn3Xw4DKrn2q3Z5Cw1DCr4UZrnrZFWvkrya
	qrn8K34vyw1kAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbOkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This series contains a fix and some random cleanups to jbd2. More
details can be found in respective patches. Thanks!

Kemeng Shi (7):
  jbd2: correctly compare tids with tid_geq function in
    jbd2_fc_begin_commit
  jbd2: remove dead check in journal_alloc_journal_head
  jbd2: remove unused return value of jbd2_fc_release_bufs
  jbd2: remove unneeded kmap for jh_in->b_frozen_data in
    jbd2_journal_write_metadata_buffer
  jbd2: remove unneeded done_copy_out variable in
    jbd2_journal_write_metadata_buffer
  jbd2: correct comment jbd2_mark_journal_empty
  jbd2: remove unneeded check of ret in jbd2_fc_get_buf

 fs/jbd2/journal.c    | 46 +++++++++++++++++---------------------------
 include/linux/jbd2.h |  2 +-
 2 files changed, 19 insertions(+), 29 deletions(-)

-- 
2.30.0


