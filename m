Return-Path: <linux-ext4+bounces-3582-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E3944141
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD69B2BB06
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDC1AB516;
	Thu,  1 Aug 2024 01:41:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6131A6181;
	Thu,  1 Aug 2024 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476461; cv=none; b=j1E17pVcxCYwpDf2uSVc17KorYO80viIzaBEDT8CFjekncd3r26cvoWjSt8PLBwGnnytw5fcKhDnerUn9/VUybE5J2qUEri7JDW0ZgFCYFSmr/VQkbaHChFPiZBKseNpSmKApIJ2yUbPP/ou+K92oXguOqru3G/ACpnv9GwkbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476461; c=relaxed/simple;
	bh=hC8+as7Lz5WWVb+xXfqsNh0bDA79FvynXbpUv4XijqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gduajfIfse9r4PE7DDkllOKJQsmoAfSFJo7OrLjHUp2wARE7GaPByZrUvyULxutMMFLV2okBNYNpZNu8GxJrCPlMaCCp/Uw+9A9LelwUlvkQs3u7wbJU11EJCdto+520iZbHf7Pow+72jFXbyYmuao3hOL8NJtX4tHoPe0SJz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZBVw5Tk2z4f3kvN;
	Thu,  1 Aug 2024 09:40:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BC10B1A018D;
	Thu,  1 Aug 2024 09:40:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgBnnr2l56pmr3OyAQ--.24249S2;
	Thu, 01 Aug 2024 09:40:54 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] Fix and cleanups to jbd2
Date: Thu,  1 Aug 2024 09:38:07 +0800
Message-Id: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnnr2l56pmr3OyAQ--.24249S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKrW3Cry5uw48tr1fZrW3Awb_yoW8Jr15pF
	yfK3ySyr1vvry7AFZxZF4UZrW5Wr4kGry7Gw43WFykJw4UCrnFgFWDJrs7GFyjvr95Kan8
	Xr4UX3s5Gw1DKFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

v3->v4:
-Collect more RVB from Yi and Jan.
-Use correct subsystem name "jbd2" instead of "ext4" in patch title.

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
  jbd2: move escape handle to futher improve
    jbd2_journal_write_metadata_buffer
  jbd2: correct comment jbd2_mark_journal_empty
  jbd2: remove unneeded check of ret in jbd2_fc_get_buf

 fs/jbd2/journal.c    | 95 +++++++++++++++++++-------------------------
 include/linux/jbd2.h |  2 +-
 2 files changed, 42 insertions(+), 55 deletions(-)

-- 
2.30.0


