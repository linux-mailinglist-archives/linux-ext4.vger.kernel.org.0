Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADDF276AD4
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgIXHcy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 03:32:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgIXHcu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 03:32:50 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B2E732A820566377812;
        Thu, 24 Sep 2020 15:32:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 15:32:37 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 0/7] ext4: fix a memory corrupt problem
Date:   Thu, 24 Sep 2020 15:33:30 +0800
Message-ID: <20200924073337.861472-1-yi.zhang@huawei.com>
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

This patch set fix a memory corruption problem caused by read stale
extent block from disk in ext4_ext_split()->memset(). The root cause is
we do not clear buffer's verified bit before read metadata block from
disk again if it has been failed to write out to disk, if the block is
mew allocated, we may propably get stale data from disk and lead to
out-of-bounds access when we use this stale data.

The first patch is the same to my v1 iteration, just clear buffer
verified bit before read, this patch can fix this problem.

The remaining patches remove all open codes that read metadata blocks
in ext4 and introduce common read helpers as Jan suggested. I have test
them on my xfstests and there is no degeneration.

Thanks,
Yi.

zhangyi (F) (7):
  ext4: clear buffer verified flag if read meta block from disk
  ext4: introduce new metadata buffer read helpers
  ext4: use common helpers in all places reading metadata buffers
  ext4: use ext4_buffer_uptodate() in __ext4_get_inode_loc()
  ext4: introduce ext4_sb_breadahead_unmovable() to replace
    sb_breadahead_unmovable()
  ext4: use ext4_sb_bread() instead of sb_bread()
  ext4: introduce ext4_sb_bread_unmovable() to replace
    sb_bread_unmovable()

 fs/ext4/balloc.c      |   7 +--
 fs/ext4/ext4.h        |   8 +++
 fs/ext4/extents.c     |   2 +-
 fs/ext4/ialloc.c      |   5 +-
 fs/ext4/indirect.c    |   8 +--
 fs/ext4/inode.c       |  43 +++++---------
 fs/ext4/mmp.c         |  10 +---
 fs/ext4/move_extent.c |   2 +-
 fs/ext4/resize.c      |  10 ++--
 fs/ext4/super.c       | 131 ++++++++++++++++++++++++++++++++++++------
 10 files changed, 153 insertions(+), 73 deletions(-)

-- 
2.25.4

