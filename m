Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5239300B
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 15:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhE0Nsx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 09:48:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2318 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhE0Nsw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 May 2021 09:48:52 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FrTXL0DW8z1BFRc;
        Thu, 27 May 2021 21:42:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 21:47:16 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH v3 0/8] ext4, jbd2: fix 3 issues about bdev_try_to_free_page()
Date:   Thu, 27 May 2021 21:56:33 +0800
Message-ID: <20210527135641.420514-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Patch 1-3: fix a potential filesystem inconsistency problem.
Patch 4-8: add a shrinker to release journal_head and remove
           bdev_try_to_free_page() callback, and also do some cleanup.

Changes since v2:
 - Fix some comments and spelling mistakes on patch 2 and 3.
 - Give up the solution of add refcount on super_block and fix the
   use-after-free issue in bdev_try_to_free_page(), switch to introduce
   a shrinker to free checkpoint buffers' journal_head and remove the
   whole callback at all.

Thanks,
Yi.

---------

Changes since v1:
 - Do not use j_checkpoint_mutex to fix the filesystem inconsistency
   problem, introduce a new mark instead.
 - Fix superblock use-after-free issue in blkdev_releasepage().
 - Avoid race between bdev_try_to_free_page() and ext4_put_super().



Zhang Yi (8):
  jbd2: remove the out label in __jbd2_journal_remove_checkpoint()
  jbd2: ensure abort the journal if detect IO error when writing
    original buffer back
  jbd2: don't abort the journal when freeing buffers
  jbd2: remove redundant buffer io error checks
  jbd2,ext4: add a shrinker to release checkpointed buffers
  jbd2: simplify journal_clean_one_cp_list()
  ext4: remove bdev_try_to_free_page() callback
  fs: remove bdev_try_to_free_page callback

 fs/block_dev.c              |  15 ---
 fs/ext4/super.c             |  29 ++----
 fs/jbd2/checkpoint.c        | 200 ++++++++++++++++++++++++++++++------
 fs/jbd2/journal.c           | 101 ++++++++++++++++++
 fs/jbd2/transaction.c       |  17 ---
 include/linux/fs.h          |   1 -
 include/linux/jbd2.h        |  37 +++++++
 include/trace/events/jbd2.h | 101 ++++++++++++++++++
 8 files changed, 413 insertions(+), 88 deletions(-)

-- 
2.25.4

