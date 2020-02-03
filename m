Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20655150805
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Feb 2020 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgBCOGQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Feb 2020 09:06:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727577AbgBCOGP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Feb 2020 09:06:15 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 10EF7DDEEB4248775E91;
        Mon,  3 Feb 2020 22:06:12 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 3 Feb 2020
 22:06:01 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <jack@suse.cz>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>,
        <luoshijie1@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 0/2] jbd2: fix an oops problem
Date:   Mon, 3 Feb 2020 22:04:56 +0800
Message-ID: <20200203140458.37397-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Ted and Jan
We encountered a jbd2 oops problem on an aarch64 machine with 4K block
size and 64K page size when doing stress tests.

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
 ...
 user pgtable: 64k pages, 42-bit VAs, pgdp = (____ptrval____)
 ...
 pc : jbd2_journal_put_journal_head+0x7c/0x284
 lr : jbd2_journal_put_journal_head+0x3c/0x284
 ...
 Call trace:
  jbd2_journal_put_journal_head+0x7c/0x284
  __jbd2_journal_refile_buffer+0x164/0x188
  jbd2_journal_commit_transaction+0x12a0/0x1a50
  kjournald2+0xd0/0x260
  kthread+0x134/0x138
  ret_from_fork+0x10/0x1c
 Code: 51000400 b9000ac0 35000760 f9402274 (b9400a80)
 ---[ end trace 8fa99273d06aeb63 ]---

These patch set can fix this issue, the first patch is just a cleanup
patch, and the second one describe the root cause and fix it, please
review.

Thanks,
Yi.

zhangyi (F) (2):
  jbd2: move the clearing of b_modified flag to the
    journal_unmap_buffer()
  jbd2: do not clear the BH_Mapped flag when forgetting a metadata
    buffer

 fs/jbd2/commit.c      | 36 +++++++++++++-----------------------
 fs/jbd2/transaction.c | 25 ++++++++++++-------------
 include/linux/jbd2.h  |  2 ++
 3 files changed, 27 insertions(+), 36 deletions(-)

-- 
2.17.2

