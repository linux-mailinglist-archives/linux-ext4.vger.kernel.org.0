Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822383581B7
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhDHL2T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 07:28:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16834 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHL2S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 07:28:18 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FGJq63Pprz7txY;
        Thu,  8 Apr 2021 19:25:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:27:59 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 0/3] ext4: fix two issue about bdev_try_to_free_page()
Date:   Thu, 8 Apr 2021 19:36:15 +0800
Message-ID: <20210408113618.1033785-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This first patch fix a potential filesystem inconsistency problem and
other two fix a use after free problem.

Zhang Yi (3):
  jbd2: protect buffers release with j_checkpoint_mutex
  jbd2: do not free buffers in jbd2_journal_try_to_free_buffers()
  ext4: add rcu to prevent use after free when umount filesystem

 fs/ext4/inode.c       |  6 ++++--
 fs/ext4/super.c       | 41 +++++++++++++++++++++++++++++------------
 fs/jbd2/journal.c     | 30 +++++++++++++++++++++++++++---
 fs/jbd2/transaction.c | 20 ++++++++++----------
 include/linux/jbd2.h  | 11 ++++++++++-
 5 files changed, 80 insertions(+), 28 deletions(-)

-- 
2.25.4

