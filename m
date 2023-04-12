Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36D46DF048
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDLJ0X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjDLJ0N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 05:26:13 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA95E7D86;
        Wed, 12 Apr 2023 02:26:10 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PxHQ53JP1z4f3nwX;
        Wed, 12 Apr 2023 17:26:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDHL7MpeTZkL5_1HA--.3769S2;
        Wed, 12 Apr 2023 17:26:03 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 00/19] Fixes, cleanups and unit test for mballoc
Date:   Thu, 13 Apr 2023 01:28:14 +0800
Message-Id: <20230412172833.2317696-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDHL7MpeTZkL5_1HA--.3769S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy5XrWfJFyxtryfWrWrGrg_yoWruF18pr
        s8Cr1rKw1fJr1DZFZxu3yaq3WfWw48Cr17JryfWry8ZFW3JryxZFs7Ka1rZa12yrZxZFnI
        vFnIyrW8Gr10y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRE
        SoGDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are three parts in this patchset:
Part1: Patch 1-7 is v2 of sent series
v1->v2:
1. collect reviewed-by from Ojaswin. Only "ext4: add
EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated" needs futher
review. See [1] for previous comments.
2. drop "ext4: fix wrong unit use in ext4_mb_new_inode_pa" which is
already done in [2].

Part2: Patch 8-17 are more fixes and cleanups to mballoc
Some patches in this part will be conflict with patches in part1, so
append new patches in this series instead of creating a new one.
Patch 8-11 are some random fixes and cleanups, see respective log
message for detail.
Patch 12-17 factor out codes to mark bit in group is used or free
which will update on disk block bitmap and group descriptor. Several
reasons to do this:
1. pair behavior of alloc/free bits. For example,
ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
2. remove repeat code to read from disk, update and write back to disk.
3. reduce future unit test mocks to avoid real IO to update structure
on disk.

Part3: Patch 18-19 add one unit test for mballoc
Patch 18 add mocks to functions which will issue IO to disk.
Patch 19 add unit test for ext4_mb_new_blocks_simple in mballoc.
Details can be found in respective log message.

Before add more unit test, there are something should be discussed:
1. How to test static function in mballoc.c
Currently, include mballoc-test.c in mballoc.c to test static function
in mballoc.c from mballoc-test.c.Not sure if there is any more elegant
way to test static function without touch mballoc.c.
2. How add mocks to function in mballoc.c which may issue IO to disk
Currently, KUNIT_STATIC_STUB_REDIRECT is added to functions as suggested
in kunit document [3]. However, this will trigger warnning "ISO C90
forbids mixed declarations and code".
3. How to simulate a block bitmap.
Currently, a fake buffer_head with bitmap data is returned, then no
futher change is needed.
If we simulate a block bitmap with an array of data structure like:
struct test_bitmap {
       unsigned int	start;
       unsigned int	len;
}
which is suggested by Theodore in [4], then we need to add mocks to
function which expected bitmap from bitmap_bh->b_data, like
mb_find_next_bit, mb_find_next_zero_bit and maybe more.

Would like to hear any suggestion! Thanks!

[1]
https://lore.kernel.org/linux-ext4/ZC3MoWn2UO6p+Swp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
[2]
https://lore.kernel.org/linux-ext4/9b35f3955a1d7b66bbd713eca1e63026e01f78c1.1679731817.git.ojaswin@linux.ibm.com
[3]
https://docs.kernel.org/dev-tools/kunit/api/functionredirection.html#c.KUNIT_STATIC_STUB_REDIRECT
[4]
https://lore.kernel.org/linux-ext4/20230317155047.GB3270589@mit.edu/

By the way, the "xfstest somke" passes. Please let me know if any more
test is needed.

Kemeng Shi (19):
  ext4: fix wrong unit use in ext4_mb_normalize_request
  ext4: fix unit mismatch in ext4_mb_new_blocks_simple
  ext4: fix wrong unit use in ext4_mb_find_by_goal
  ext4: treat stripe in block unit
  ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
  ext4: remove ext4_block_group and ext4_block_group_offset declaration
  ext4: try all groups in ext4_mb_new_blocks_simple
  ext4: get block from bh before pass it to ext4_free_blocks_simple
    in ext4_free_blocks
  ext4: remove unsed parameter and unnecessary forward declaration of
    ext4_mb_new_blocks_simple
  ext4: fix wrong unit use in ext4_mb_clear_bb
  ext4: fix wrong unit use in ext4_mb_new_blocks
  ext4: factor out codes to update block bitmap and group descriptor on
    disk from ext4_mb_mark_bb
  ext4: call ext4_mb_mark_group_bb in ext4_free_blocks_simple
  ext4: extent ext4_mb_mark_group_bb to support allocation under journal
  ext4: call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used
  ext4: call ext4_mb_mark_group_bb in ext4_mb_clear_bb
  ext4: call ext4_mb_mark_group_bb in ext4_group_add_blocks
  ext4: add some kunit stub for mballoc kunit test
  ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc

 fs/ext4/balloc.c       |  13 +
 fs/ext4/ext4.h         |   4 -
 fs/ext4/mballoc-test.c | 319 +++++++++++++++++++
 fs/ext4/mballoc.c      | 703 +++++++++++++++++++----------------------
 fs/ext4/super.c        |  13 +
 5 files changed, 663 insertions(+), 389 deletions(-)
 create mode 100644 fs/ext4/mballoc-test.c

-- 
2.30.0

