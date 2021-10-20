Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386E94343AB
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 05:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTDHp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 23:07:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25298 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTDHo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 23:07:44 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYwNR3CQVzbglk;
        Wed, 20 Oct 2021 11:00:55 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 20
 Oct 2021 11:05:28 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v5 0/3] Fix some issues about mmp
Date:   Wed, 20 Oct 2021 11:17:59 +0800
Message-ID: <20211020031802.2312022-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I test mmp function as follow steps:
1. Inject delay 5s in ext4_multi_mount_protect function after
"skip:" label.
2. Share HostA block device(sda) with HostB(nbd0) by NBD.
3. Enable mmp feature when mkfs.ext4 sda.
4. Mount sda and nbd0 at the same time.

I found kmmpd never trigger detect multi-mount. Reason is as follow:
1. Kmmpd init seq with 0, if two host have same nodename, will lead to
detect confliction very slow, even never detect confliction.
2. When detect confliction in kmmpd, we get 'check_bh' is same with 'bh'.
so we compare data with itself.
3. We only trigger detect when ”diff > mmp_check_interval * HZ“,
'mmp_check_interval' is double of 'mmp_update_interval', 'diff' is
about 'mmp_update_interval'. So 'diff' is little than 'mmp_check_interval * HZ'
normaly. As Jan Kara explain as follows:
"I think the check is there only for the case where write_mmp_block() +
sleep took longer than mmp_check_interval. I agree that should rarely
happen but on a really busy system it is possible and in that case we would
miss updating mmp block for too long and so another node could have started
using the filesystem. "

v1->v2:
Fix 'last_check_time' not initialized before checking.

v2->v3:
1. drop commit "ext4: introduce last_check_time record previous check time"
As Ted explain as follows:
"I'd like Andreas to comment here.  My understanding is that MMP
originally intended as a safety mechanism which would be used as part
of a primary/backup high availability system, but not as the *primary*
system where you might try to have two servers simultaneously try to
mount the file system and use MMP as the "election" mechanism to
decide which server is going to be the primary system, and which would
be the backup system.

The cost of being able to handle this particular race is it would slow
down the mounts of cleanly unmounted systems.

There *are* better systems to implement leader elections[1] than using
MMP.  Most of these more efficient leader elections assume that you
have a working IP network, and so if you have a separate storage
network (including a shared SCSI bus) from your standard IP network,
then MMP is a useful failsafe in the face of a network partition of
your IP network.  The question is whether MMP should be useful for
more than that.  And if it isn't, then we should probably document
what MMP is and isn't good for, and give advice in the form of an
application note for how MMP should be used in the context of a larger
system."
2. drop commit "ext4: fix possible store wrong check interval value in disk when umount"
3. simplify read_mmp_block fucntion to avoid UAF

v3->v4:
1. drop commit "ext4: init 'seq' with the value which set in 'ext4_multi_mount_protect'"
2. merge "ext4: get buffer head before read_mmp_block" to
"ext4: simplify read_mmp_block fucntion"
3. rename "ext4: avoid to re-read mmp check data get from page cache" to
"ext4: remove useless bh_check variable"
4. reorder "ext4: remove useless bh_check variable" and
"ext4: simplify read_mmp_block fucntion"

v4->v5:
1. Fix follow warning:
>> fs/ext4/mmp.c:124:15: warning: variable 'mmp_block' set but not used [-Wunused-but-set-variable]
           ext4_fsblk_t mmp_block;
2. Fix incorrect judgement in 'ext4_multi_mount_protect'.

Ye Bin (3):
  ext4: compare to local seq and nodename when check conflict
  ext4: remove useless bh_check variable
  ext4: simplify read_mmp_block fucntion

 fs/ext4/ext4.h |  5 +++-
 fs/ext4/mmp.c  | 66 +++++++++++++++++++++-----------------------------
 2 files changed, 31 insertions(+), 40 deletions(-)

-- 
2.31.1

