Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4411176DE51
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 04:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjHCCgx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 22:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjHCCgf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 22:36:35 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD05558B
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 19:34:49 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RGXw31PB1z1GDVG;
        Thu,  3 Aug 2023 10:33:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 10:34:40 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <louhongxiang@huawei.com>,
        <linfeilong@huawei.com>, <yi.zhang@huawei.com>,
        <yebin10@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [RFC PATCH v2 0/2] ext4: Fix the conflict between modifying the superblock in user mode and kernel mode
Date:   Thu, 3 Aug 2023 10:31:26 +0800
Message-ID: <20230803023128.35170-1-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Tune2fs does not recognize writes to filesystems in another namespace. Two
simultaneous write operations on a block will lead to file system
inconsistency, because there is no lock protection between userland and
kernelland.

The operation is as follows:
first terminal                                      second terminal
mkfs.ext4 /dev/sdb;
mount /dev/sdb /test-sdb;
dd if=/dev/zero of=/test-sdb/test1 bs=1M count=100;
                                                    unshare -m;
umount;
gdb tune2fs;
b io_channel_write_byte
r -e remount-ro /dev/sdb
c(Write a byte of old data into the cache)
                                                    exit;
(gdb finish)
tune2fs -l /dev/sdb;
tune2fs 1.46.4 (18-Aug-2021)
tune2fs: Superblock checksum does not match superblock while trying to
open /dev/sdb
Couldn't find valid filesystem superblock. 

Link: https://lore.kernel.org/linux-ext4/29f6134f-ba0a-d601-0a5a-ad2b5e9bbf1d@huawei.com/

After discussing with Tytso, I decided to use ioctl to solve the above
problems. These patches are an example I wrote to complete the modification
of the s_errors variable in the super block.

Finally, if you have any good ideas, welcome to communicate with me by
email.

Diff V2 vs V1:
1) Modify symbols of comment.
Link: https://lore.kernel.org/oe-kbuild-all/202308030412.jMcaYq0E-lkp@intel.com/
2) Add static symbols to functions.
Link: https://lore.kernel.org/oe-kbuild-all/202308021801.ieUVR2xl-lkp@intel.com/

zhanchengbin (2):
  ext4: ioctl adds a framework for modifying superblock parameters
  ext4: ioctl add EXT4_IOC_SUPERBLOCK_KEY_S_ERRORS

 fs/ext4/ext4.h            |  12 +++
 fs/ext4/ioctl.c           | 149 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ext4.h |  28 +++++++
 3 files changed, 189 insertions(+)

-- 
2.31.1

