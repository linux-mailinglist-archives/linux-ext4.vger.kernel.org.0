Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B923FD0FA
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Sep 2021 04:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbhIACBB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Aug 2021 22:01:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9390 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhIACBB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Aug 2021 22:01:01 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GznFv2MyNz8x82;
        Wed,  1 Sep 2021 09:55:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 1 Sep
 2021 10:00:01 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v5 0/3] ext4: fix a inode checksum error
Date:   Wed, 1 Sep 2021 10:09:52 +0800
Message-ID: <20210901020955.1657340-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We find a checksum error and a inode corruption problem while doing
stress test, this 3 patches address to fix them. The first two patches
are prepare to do the fix, the last patch fix these two issue.

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

Changes since v4:
 - Drop first three already applied patches.
 - Remove 'in_mem' parameter passing __ext4_get_inode_loc() in the last
   patch.

Changes since v3:
 - Postpone initialization to ext4_do_update_inode() may cause zeroout
   newly set xattr entry. So switch to do initialization in
   __ext4_get_inode_loc().

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

Zhang Yi (3):
  ext4: factor out ext4_fill_raw_inode()
  ext4: move ext4_fill_raw_inode() related functions
  ext4: prevent getting empty inode buffer

 fs/ext4/inode.c | 316 +++++++++++++++++++++++++-----------------------
 1 file changed, 165 insertions(+), 151 deletions(-)

-- 
2.31.1

