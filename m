Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8463F3925
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhHUGpK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Aug 2021 02:45:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8916 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhHUGpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Aug 2021 02:45:09 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gs85L2LqRz8snr;
        Sat, 21 Aug 2021 14:40:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 21
 Aug 2021 14:44:27 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v3 0/4] ext4: fix a inode checksum error
Date:   Sat, 21 Aug 2021 14:54:46 +0800
Message-ID: <20210821065450.1397451-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We find a checksum error and a inode corruption problem while doing
stress test, this 4 patches address to fix them. The first patch is
relate to the error simulation, and the second & third patch are
prepare to do the fix. The last patch fix these two issue.

 - Checksum error

    EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid

 - Inode corruption

    e2fsck 1.46.0 (29-Jan-2020)
    Pass 1: Checking inodes, blocks, and sizes
    Pass 2: Checking directory structure
    Entry 'foo' in / (2) has deleted/unused inode 17.  Clear<y>? yes
    Pass 3: Checking directory connectivity
    Pass 4: Checking reference counts
    Pass 5: Checking group summary information
    Inode bitmap differences:  -17
    Fix<y>? yes
    Free inodes count wrong for group #0 (32750, counted=32751).
    Fix<y>? yes
    Free inodes count wrong (32750, counted=32751).
    Fix<y>? yes


Changes since v2:
 - Instead of using WARN_ON_ONCE to prevent ext4_do_update_inode()
   return before filling the inode buffer, keep the error and postpone
   the report after the updating in the third patch.
 - Fix some language mistacks in the last patch.

Changes since v1:
 - Add a patch to prevent ext4_do_update_inode() return before filling
   the inode buffer.
 - Do not use BH_New flag to indicate the empty buffer, postpone the
   zero and uptodate logic into ext4_do_update_inode() before filling
   the inode buffer.

Thanks,
Yi.



Zhang Yi (4):
  ext4: move inode eio simulation behind io completeion
  ext4: remove an unnecessary if statement in __ext4_get_inode_loc()
  ext4: make the updating inode data procedure atomic
  ext4: prevent getting empty inode buffer

 fs/ext4/inode.c | 227 +++++++++++++++++++++++++++---------------------
 1 file changed, 126 insertions(+), 101 deletions(-)

-- 
2.31.1

