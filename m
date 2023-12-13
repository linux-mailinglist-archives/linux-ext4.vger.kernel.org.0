Return-Path: <linux-ext4+bounces-419-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C0E8107DC
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 02:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF2D1C20E3E
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893915A4;
	Wed, 13 Dec 2023 01:51:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE068AD
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 17:51:24 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SqdJy53qhz29fyh;
	Wed, 13 Dec 2023 09:32:50 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id D61281A0192;
	Wed, 13 Dec 2023 09:33:57 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 09:33:57 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH v2 0/5] jbd2: Add errseq to detect writeback
Date: Wed, 13 Dec 2023 09:32:19 +0800
Message-ID: <20231213013224.2100050-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

According to discussions in [1], this patchset adds errseq in journal to
enable JDB2 detecting meatadata writeback error of fs dev. Then, orginal
checking mechanism could be removed.

[1] https://lore.kernel.org/all/20230908124317.2955345-1-chengzhihao1@huawei.com/T/

v1->v2:
  Fix some misspelling words.
  Patch 1: "fallen on" -> "written to"
  Patch 4: "can detects" -> "can detect"

Zhihao Cheng (5):
  jbd2: Add errseq to detect client fs's bdev writeback error
  jbd2: Replace journal state flag by checking errseq
  jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
  jbd2: Abort journal when detecting metadata writeback error of fs dev
  ext4: Move ext4_check_bdev_write_error() into nojournal mode

 fs/ext4/ext4_jbd2.c   |  5 ++---
 fs/jbd2/checkpoint.c  | 11 -----------
 fs/jbd2/journal.c     | 11 ++++++-----
 fs/jbd2/recovery.c    |  7 +------
 fs/jbd2/transaction.c | 14 ++++++++++++++
 include/linux/jbd2.h  | 37 ++++++++++++++++++++++++++-----------
 6 files changed, 49 insertions(+), 36 deletions(-)

-- 
2.39.2


