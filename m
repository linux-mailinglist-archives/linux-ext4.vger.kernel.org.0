Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56EB786BF9
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbjHXJbJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbjHXJar (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 05:30:47 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE1E67
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 02:30:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RWd9W2wtHz4f41Gs
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 17:30:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHl6kzI+dkL1rbBQ--.46575S4;
        Thu, 24 Aug 2023 17:30:40 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [RFC PATCH 00/16] ext4: more accurate metadata reservaion for delalloc mount option
Date:   Thu, 24 Aug 2023 17:26:03 +0800
Message-Id: <20230824092619.1327976-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHl6kzI+dkL1rbBQ--.46575S4
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy7JF1xCryUZr4kJw1kKrg_yoW7Kw45pr
        y3JF1fXr1jgry8WFsrZw1UJr1rW3WxZF47Jr1aqr95uF1rCF1fWFsrtry0vFW3trZxJF1U
        XFy5Za48uFykAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Hello,

The delayed allocation method allocates blocks during page writeback in
ext4_writepages(), which cannot handle block allocation failures due to
e.g. ENOSPC if acquires more extent blocks. In order to deal with this,
commit '79f0be8d2e6e ("ext4: Switch to non delalloc mode when we are low
on free blocks count.")' introduce ext4_nonda_switch() to convert to no
delalloc mode if the space if the free blocks is less than 150% of dirty
blocks or the watermark. In the meantime, '27dd43854227 ("ext4:
introduce reserved space")' reserve some of the file system space (2% or
4096 clusters, whichever is smaller). Both of those to solutions can
make sure that space is not exhausted when mapping delalloc blocks in
most cases, but cannot guarantee work in all cases, which could lead to
infinite loop or data loss (please see patch 14 for details).

This patch set wants to reserve metadata space more accurate for
delalloc mount option. The metadata blocks reservation is very tricky
and is also related to the continuity of physical blocks, an effective
way is to reserve as the worst case, which means that every data block
is discontinuous and one data block costs an extent entry. Reserve
metadata space as the worst case can make sure enough blocks reserved
during data writeback, the unused reservaion space can be released after
mapping data blocks. After doing this, add a worker to submit delayed
allocations to prevent excessive reservations. Finally, we could
completely drop the policy of switching back to non-delayed allocation.

The patch set is based on the latest ext4 dev branch.
Patch 1-2:   Fix two reserved data blocks problems triggered when
             bigalloc feature is enabled.
Patch 3-6:   Move reserved data blocks updating from
             ext4_{ext|ind}_map_blocks() to ext4_es_insert_extent(),
             preparing for reserving metadata.
Patch 7-14:  Reserve metadata blocks for delayed allocation as the worst
             case, and update count after allocating or releasing.
Patch 15-16: In order to prevent too many reserved metadata blocks that
             could running false positive out of space (doesn't take
             that much after allocating data blocks), add a worker to
             submit IO if the reservation is too big.

About tests:
1. This patch set has passed 'kvm-xfstests -g auto' many times.
2. The performance looks not significantly affected after doing the
   following tests on my virtual machine with 4 CPU core and 32GB
   memory, which based on Kunpeng-920 arm64 CPU and 1.5TB nvme ssd.

 fio -directory=/test -direct=0 -iodepth=10 -fsync=$sync -rw=$rw \
     -numjobs=${numjobs} -bs=${bs}k -ioengine=libaio -size=10G \
     -ramp_time=10 -runtime=60 -norandommap=0 -group_reportin \
     -name=tests

 Disable bigalloc:
                               | Before           | After
 rw         fsync jobs  bs(kB) | iops   bw(MiB/s) | iops   bw(MiB/s)
 ------------------------------|------------------|-----------------
 write      0     1     4      | 27500  107       | 27100  106
 write      0     4     4      | 33900  132       | 35300  138
 write      0     1     1024   | 134    135       | 149    150
 write      0     4     1024   | 172    174       | 199    200
 write      1     1     4      | 1530   6.1       | 1651   6.6
 write      1     4     4      | 3139   12.3      | 3131   12.2
 write      1     1     1024   | 184    185       | 195    196
 write      1     4     1024   | 117    119       | 114    115
 randwrite  0     1     4      | 17900  69.7      | 17600  68.9
 randwrite  0     4     4      | 32700  128       | 34600  135
 randwrite  0     1     1024   | 145    146       | 155    155
 randwrite  0     4     1024   | 193    194       | 207    209
 randwrite  1     1     4      | 1335   5.3       | 1444   5.7
 randwrite  1     4     4      | 3364   13.1      | 3428   13.4
 randwrite  1     1     1024   | 180    180       | 171    172
 randwrite  1     4     1024   | 132    134       | 141    142

 Enable bigalloc:
                               | Before           | After
 rw         fsync jobs  bs(kB) | iops   bw(MiB/s) | iops   bw(MiB/s)
 ------------------------------|------------------|-----------------
 write      0     1     4      | 27500  107       | 30300  118
 write      0     4     4      | 28800  112       | 34000  137
 write      0     1     1024   | 141    142       | 162    162
 write      0     4     1024   | 172    173       | 195    196
 write      1     1     4      | 1410   5.6       | 1302   5.2
 write      1     4     4      | 3052   11.9      | 3002   11.7
 write      1     1     1024   | 153    153       | 163    164
 write      1     4     1024   | 113    114       | 110    111
 randwrite  0     1     4      | 17500  68.5      | 18400  72
 randwrite  0     4     4      | 26600  104       | 24800  96
 randwrite  0     1     1024   | 170    171       | 165    165
 randwrite  0     4     1024   | 168    169       | 152    153
 randwrite  1     1     4      | 1281   5.1       | 1335   5.3
 randwrite  1     4     4      | 3115   12.2      | 3315   12
 randwrite  1     1     1024   | 150    150       | 151    152
 randwrite  1     4     1024   | 134    135       | 132    133

 Tests on ramdisk:

 Disable bigalloc
                               | Before           | After
 rw         fsync jobs  bs(kB) | iops   bw(MiB/s) | iops   bw(MiB/s)
 ------------------------------|------------------|-----------------
 write      1     1     4      | 4699   18.4      | 4858   18
 write      1     1     1024   | 245    246       | 247    248

 Enable bigalloc 
                               | Before           | After
 rw         fsync jobs  bs(kB) | iops   bw(MiB/s) | iops   bw(MiB/s)
 ------------------------------|------------------|-----------------
 write      1     1     4      | 4634   18.1      | 5073   19.8
 write      1     1     1024   | 246    247       | 268    269

Thanks,
Yi.

Zhang Yi (16):
  ext4: correct the start block of counting reserved clusters
  ext4: make sure allocate pending entry not fail
  ext4: let __revise_pending() return the number of new inserts pendings
  ext4: count removed reserved blocks for delalloc only es entry
  ext4: pass real delayed status into ext4_es_insert_extent()
  ext4: move delalloc data reserve spcae updating into
    ext4_es_insert_extent()
  ext4: count inode's total delalloc data blocks into ext4_es_tree
  ext4: refactor delalloc space reservation
  ext4: count reserved metadata blocks for delalloc per inode
  ext4: reserve meta blocks in ext4_da_reserve_space()
  ext4: factor out common part of
    ext4_da_{release|update_reserve}_space()
  ext4: update reserved meta blocks in
    ext4_da_{release|update_reserve}_space()
  ext4: calculate the worst extent blocks needed of a delalloc es entry
  ext4: reserve extent blocks for delalloc
  ext4: flush delalloc blocks if no free space
  ext4: drop ext4_nonda_switch()

 fs/ext4/balloc.c            |  47 ++++-
 fs/ext4/ext4.h              |  14 +-
 fs/ext4/extents.c           |  65 +++----
 fs/ext4/extents_status.c    | 340 +++++++++++++++++++++---------------
 fs/ext4/extents_status.h    |   3 +-
 fs/ext4/indirect.c          |   7 -
 fs/ext4/inode.c             | 191 ++++++++++----------
 fs/ext4/super.c             |  22 ++-
 include/trace/events/ext4.h |  70 ++++++--
 9 files changed, 439 insertions(+), 320 deletions(-)

-- 
2.39.2

