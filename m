Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3468F7A6253
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjISMQV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjISMQT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:16:19 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFAF5;
        Tue, 19 Sep 2023 05:16:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RqgcM3MT9z4f3nq8;
        Tue, 19 Sep 2023 20:16:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S2;
        Tue, 19 Sep 2023 20:16:04 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/12] cleanups and unit test for mballoc
Date:   Wed, 20 Sep 2023 04:15:20 +0800
Message-Id: <20230919201532.310085-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4fKw4fGF4furyUZF15CFg_yoW3ur1kpF
        sFkrn8Kr1xJr1qvan3C347Ww1xKw48Aa1UWryfK34F9Fy3Wr97ZFs7KFWY9a4DKr4DZFyY
        qF15uFW5ua1vvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_
        Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0miiDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

v6->v7:
1. Remove struct ext4_mark_context and call ext4_mb_mark_context with all
needed arguments directly.
2. Add new patch to make state in ext4_mb_mark_bb bool and make state in
new-added function ext4_mb_mark_context bool.
3. Fix typos in git messages.
4. Keep on-disk bitmap marking code tight in patch separating on-disk
bitmap and buddy bitmap freeing.
5. Test 64k blocksize instead of 256k blocksize.
6. Remove RVB from Ojaswin in changed patches and collect updated RVB from
Ritesh.
7. As there is no much functional change to initial version, "kvm-xfstest smoke"
test and kunit test are ran and result is good.
8. Plan to add ext4_inode_block_valid in ext4_mb_mark_context in new
series!

v5->v6:
1. Separate block bitmap and buddy bitmap freeing in individual patch
and rewrite the descriptions.
2. Remove #ifdef around KUNIT_STATIC_STUB_REDIRECT which should be
only defined when CONFIG_KUNIT is enabled after fix [7] which was merged
into kunit-next/kunit
3. Use mbt prefix to distiguish test APIs from actual kernel APIs.
4. Add prepare function for ext4_mark_context and rename
ext4_mb_mark_group_bb to ext4_mb_mark_context
5. Support to run mballoc test with different layouts setting and
different block size is tested.

v4->v5:
1. WARN on free blocks to uninitialized group is removed as normal
fast commit route may triggers this, see [1] for details. The review
tag from Ojaswin of changed patch is also removed and a futher review
is needed.

v3->v4:
1. Collect Reviewed-by from Ojaswin
2. Do improve as Ojaswin kindly suggested: Fix typo in commit,
WARN if try to clear bit of uninitialized group and improve
refactoring of AGGRESSIVE_CHECK code.
3. Fix conflic on patch 16
4. Improve git log in patch 16,17

v2->v3:
1. Fix build warnings on "ext4: add some kunit stub for mballoc kunit
test" and "ext4: add first unit test for ext4_mb_new_blocks_simple in
mballoc"

This series is a new version of unmerged patches from [1]. The first 6
patches of this series factor out codes to mark blocks used or freed
which will update on disk block bitmap and group descriptor. Several
reasons to do this:
1. pair behavior of alloc/free bits. For example,
ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
2. remove repeat code to read from disk, update and write back to disk.
3. reduce future unit test mocks to avoid real IO to update structure
on disk.

The last 2 patches add a unit test for mballoc. Before more unit tests
are added, there are something should be discussed:
1. How to test static function in mballoc.c
Currently, include mballoc-test.c in mballoc.c to test static function
in mballoc.c from mballoc-test.c which is one way suggested in [2].
Not sure if there is any more elegant way to test static function without
touch mballoc.c.
2. How to add mocks to function in mballoc.c which may issue IO to disk
Currently, KUNIT_STATIC_STUB_REDIRECT is added to functions as suggested
in kunit document [3].
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

I run kvm-xfstest with config "ext4/all" and "-g auto" together with
patchset for resize, you can see detail report in [6].

Unit test result is as followings:
# ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig --raw_output
[02:56:14] Configuring KUnit Kernel ...
[02:56:14] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make ARCH=um O=.kunit --jobs=88
[02:56:19] Starting KUnit Kernel (1/1)...
KTAP version 1
1..2
    KTAP version 1
    # Subtest: ext4_mballoc_test
    1..1
        KTAP version 1
        # Subtest: test_new_blocks_simple
        ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
        ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_new_blocks_simple: pass:3 fail:0 skip:0 total:3
    ok 1 test_new_blocks_simple
# Totals: pass:3 fail:0 skip:0 total:3
ok 1 ext4_mballoc_test
    KTAP version 1
    # Subtest: ext4_inode_test
    1..1
        KTAP version 1
        # Subtest: inode_test_xtimestamp_decoding
        ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
        ok 2 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
        ok 3 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
        ok 4 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
        ok 5 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
        ok 6 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
        ok 7 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
        ok 8 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
        ok 9 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
        ok 10 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
        ok 11 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
        ok 12 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
        ok 13 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
        ok 14 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
        ok 15 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
        ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
    # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
    ok 1 inode_test_xtimestamp_decoding
# Totals: pass:16 fail:0 skip:0 total:16
ok 2 ext4_inode_test
[02:56:19] Elapsed time: 5.173s total, 0.001s configuring, 5.055s building, 0.074s running

[1]
https://lore.kernel.org/linux-ext4/20230603150327.3596033-1-shikemeng@huaweicloud.com/T/#m5ff8e3a058ce1cb272dfef3262cd3202ce6e4358
[2]
https://lore.kernel.org/linux-ext4/ZC3MoWn2UO6p+Swp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
[3]
https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
[4]
https://docs.kernel.org/dev-tools/kunit/api/functionredirection.html#c.KUNIT_STATIC_STUB_REDIRECT
[5]
https://lore.kernel.org/linux-ext4/20230317155047.GB3270589@mit.edu/
[6]
https://lore.kernel.org/linux-ext4/20230629120044.1261968-1-shikemeng@huaweicloud.com/T/#mcc8fb0697fd54d9267c02c027e1eb3468026ae56
[7]
https://lore.kernel.org/lkml/20230725172051.2142641-1-shikemeng@huaweicloud.com/


Kemeng Shi (12):
  ext4: make state in ext4_mb_mark_bb to be bool
  ext4: factor out codes to update block bitmap and group descriptor on
    disk from ext4_mb_mark_bb
  ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
  ext4: extend ext4_mb_mark_context to support allocation under journal
  ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
  ext4: Separate block bitmap and buddy bitmap freeing in
    ext4_mb_clear_bb()
  ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
  ext4: Separate block bitmap and buddy bitmap freeing in
    ext4_group_add_blocks()
  ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
  ext4: add some kunit stub for mballoc kunit test
  ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
  ext4: run mballoc test with different layouts setting

 fs/ext4/balloc.c       |  10 +
 fs/ext4/ext4.h         |   2 +-
 fs/ext4/fast_commit.c  |   8 +-
 fs/ext4/mballoc-test.c | 349 ++++++++++++++++++++++++++++
 fs/ext4/mballoc.c      | 512 +++++++++++++++--------------------------
 5 files changed, 550 insertions(+), 331 deletions(-)
 create mode 100644 fs/ext4/mballoc-test.c

-- 
2.30.0

