Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF12F74208B
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 08:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjF2Gjh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 02:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjF2GjW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Jun 2023 02:39:22 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C62705;
        Wed, 28 Jun 2023 23:39:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qs81S4SjBz4f449G;
        Thu, 29 Jun 2023 14:39:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnUy4LJ51kJfVfMA--.3175S2;
        Thu, 29 Jun 2023 14:39:08 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v5 0/8] cleanups and unit test for mballoc
Date:   Thu, 29 Jun 2023 22:39:59 +0800
Message-Id: <20230629144007.1263510-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnUy4LJ51kJfVfMA--.3175S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW5KFy5GF1UAryfGw4fAFb_yoW7KF4Dpr
        sFkFn8Kr1xJr1qva1fC3y7Wr1xKw4xAa1UWryfK34xuFW3urn7u3Z7KFWY9a4DGr4DZFyY
        9F1UCr45CFn29aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9q14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ec7CjxVAajcxG14
        v26r1j6r4UMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY
        c2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026x
        CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
        JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
        1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
        WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjTRC38nUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

v4->v5
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
[18:44:39] Configuring KUnit Kernel ...
[18:44:39] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=.kunit olddefconfig
Building with:
$ make ARCH=um O=.kunit --jobs=88
[18:44:47] Starting KUnit Kernel (1/1)...
KTAP version 1
1..2
    KTAP version 1
    # Subtest: ext4_mballoc_test
    1..1
    ok 1 test_new_blocks_simple
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
[18:44:48] Elapsed time: 8.602s total, 0.001s configuring, 8.483s building, 0.072s running

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

Kemeng Shi (8):
  ext4: factor out codes to update block bitmap and group descriptor on
    disk from ext4_mb_mark_bb
  ext4: call ext4_mb_mark_group_bb in ext4_free_blocks_simple
  ext4: extent ext4_mb_mark_group_bb to support allocation under journal
  ext4: call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used
  ext4: call ext4_mb_mark_group_bb in ext4_mb_clear_bb
  ext4: call ext4_mb_mark_group_bb in ext4_group_add_blocks
  ext4: add some kunit stub for mballoc kunit test
  ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc

 fs/ext4/balloc.c       |  16 ++
 fs/ext4/mballoc-test.c | 323 ++++++++++++++++++++++++++
 fs/ext4/mballoc.c      | 506 ++++++++++++++++-------------------------
 3 files changed, 535 insertions(+), 310 deletions(-)
 create mode 100644 fs/ext4/mballoc-test.c

-- 
2.30.0

