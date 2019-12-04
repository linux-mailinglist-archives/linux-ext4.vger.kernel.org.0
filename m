Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04B112B71
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2019 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfLDMZ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Dec 2019 07:25:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbfLDMZ1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Dec 2019 07:25:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3CE9D4B517082CBB2919;
        Wed,  4 Dec 2019 20:25:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 20:25:16 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH v3 0/4] ext4, jbd2: improve aborting progress
Date:   Wed, 4 Dec 2019 20:46:10 +0800
Message-ID: <20191204124614.45424-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This series originally aim to fix ext4_handle_error() and ext4_abort()
cannot panic because of we invoke __jbd2_journal_abort_hard() when we
failed to submit commit record without setting JBD2_REC_ERR flag.

I add patch 1 and patch 4 to switch to use jbd2_journal_abort() and do
some cleanup job at this iteration as Jan suggested. I also add patch 3
to fix missing updating ESHUTDOWN problem in commit 818d276ceb8 "ext4:
Add the journal checksum feature", please revirew this series and give
some suggestions.

Changes since v2:
 - Fix spelling mistakes in the first patch.
 - Keep JBD2_REC_ERR and remove the last place that invoke
   jbd2_journal_abort() with 0 errno and the corresponding logic in
   __journal_abort_soft().
 - Fix missing updating errno in the jbd2 sb after jbd2 shutdown abort.

Thanks,
Yi.

zhangyi (F) (4):
  jbd2: switch to use jbd2_journal_abort() when failed to submit the
    commit record
  ext4, jbd2: ensure panic when aborting with zero errno
  jbd2: make sure ESHUTDOWN to be recorded in the journal superblock
  jbd2: clean __jbd2_journal_abort_hard() and __journal_abort_soft()

 fs/jbd2/checkpoint.c |   2 +-
 fs/jbd2/commit.c     |   4 +-
 fs/jbd2/journal.c    | 111 ++++++++++++++++---------------------------
 include/linux/jbd2.h |   1 -
 4 files changed, 45 insertions(+), 73 deletions(-)

-- 
2.17.2

