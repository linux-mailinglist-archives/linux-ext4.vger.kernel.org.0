Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8466EC797
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjDXIG5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Apr 2023 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjDXIG4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Apr 2023 04:06:56 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7010E7;
        Mon, 24 Apr 2023 01:06:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q4d53291Qz4f3jHn;
        Mon, 24 Apr 2023 16:06:47 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgC3Iy6COEZkIzs8Hg--.48872S2;
        Mon, 24 Apr 2023 16:06:47 +0800 (CST)
Subject: Re: [PATCH v3 00/19] Fixes, cleanups and unit test for mballoc
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <70123070-4901-1e00-298f-80ea2df18096@huaweicloud.com>
Date:   Mon, 24 Apr 2023 16:06:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgC3Iy6COEZkIzs8Hg--.48872S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrykJFykXr1kCrWUKw4fuFg_yoWxtFW7pr
        sFkrn8Kr1xJr1qya93C3y3W3WxCw48A3W7GrySg348uFy3Jr92yFn7KayY9asrGr4DZFya
        vF1UCFWrCF4v9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Friendly ping...

on 4/17/2023 7:05 PM, Kemeng Shi wrote:
> v2->v3:
> 1. Make patches on new branch head and fix conflic on "ext4: add
> EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated"
> 2. Fix build warnings on "ext4: add some kunit stub for mballoc kunit
> test" and "ext4: add first unit test for ext4_mb_new_blocks_simple in
> mballoc"
> 
> There are three parts in this patchset:
> Part1: Patch 1-7 is v2 of sent series
> v1->v2:
> 1. collect reviewed-by from Ojaswin. Only "ext4: add
> EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated" needs futher
> review. See [1] for previous comments.
> 2. drop "ext4: fix wrong unit use in ext4_mb_new_inode_pa" which is
> already done in [2].
> 
> Part2: Patch 8-17 are more fixes and cleanups to mballoc
> Some patches in this part will be conflict with patches in part1, so
> append new patches in this series instead of creating a new one.
> Patch 8-11 are some random fixes and cleanups, see respective log
> message for detail.
> Patch 12-17 factor out codes to mark bit in group is used or free
> which will update on disk block bitmap and group descriptor. Several
> reasons to do this:
> 1. pair behavior of alloc/free bits. For example,
> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
> 2. remove repeat code to read from disk, update and write back to disk.
> 3. reduce future unit test mocks to avoid real IO to update structure
> on disk.
> 
> Part3: Patch 18-19 add one unit test for mballoc
> Patch 18 add mocks to functions which will issue IO to disk.
> Patch 19 add unit test for ext4_mb_new_blocks_simple in mballoc.
> Details can be found in respective log message.
> 
> Before add more unit tests, there are something should be discussed:
> 1. How to test static function in mballoc.c
> Currently, include mballoc-test.c in mballoc.c to test static function
> in mballoc.c from mballoc-test.c which is one way suggested in [3].
> Not sure if there is any more elegant way to test static function without
> touch mballoc.c.
> 2. How to add mocks to function in mballoc.c which may issue IO to disk
> Currently, KUNIT_STATIC_STUB_REDIRECT is added to functions as suggested
> in kunit document [4].
> 3. How to simulate a block bitmap.
> Currently, a fake buffer_head with bitmap data is returned, then no
> futher change is needed.
> If we simulate a block bitmap with an array of data structure like:
> struct test_bitmap {
>        unsigned int	start;
>        unsigned int	len;
> }
> which is suggested by Theodore in [5], then we need to add mocks to
> function which expected bitmap from bitmap_bh->b_data, like
> mb_find_next_bit, mb_find_next_zero_bit and maybe more.
> 
> Would like to hear any suggestion! Thanks!
> 
> [1]
> https://lore.kernel.org/linux-ext4/ZC3MoWn2UO6p+Swp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
> [2]
> https://lore.kernel.org/linux-ext4/9b35f3955a1d7b66bbd713eca1e63026e01f78c1.1679731817.git.ojaswin@linux.ibm.com
> [3]
> https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
> [4]
> https://docs.kernel.org/dev-tools/kunit/api/functionredirection.html#c.KUNIT_STATIC_STUB_REDIRECT
> [5]
> https://lore.kernel.org/linux-ext4/20230317155047.GB3270589@mit.edu/
> 
> By the way, the "xfstest somke" passes. Please let me know if any more
> test is needed.
> Unit test result is as followings:
> # ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig --raw_output
> [18:44:39] Configuring KUnit Kernel ...
> [18:44:39] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=um O=.kunit olddefconfig
> Building with:
> $ make ARCH=um O=.kunit --jobs=88
> [18:44:47] Starting KUnit Kernel (1/1)...
> KTAP version 1
> 1..2
>     KTAP version 1
>     # Subtest: ext4_mballoc_test
>     1..1
>     ok 1 test_new_blocks_simple
> ok 1 ext4_mballoc_test
>     KTAP version 1
>     # Subtest: ext4_inode_test
>     1..1
>         KTAP version 1
>         # Subtest: inode_test_xtimestamp_decoding
>         ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
>         ok 2 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
>         ok 3 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
>         ok 4 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
>         ok 5 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
>         ok 6 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
>         ok 7 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
>         ok 8 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
>         ok 9 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
>         ok 10 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
>         ok 11 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
>         ok 12 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
>         ok 13 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
>         ok 14 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
>         ok 15 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
>         ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
>     # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
>     ok 1 inode_test_xtimestamp_decoding
> # Totals: pass:16 fail:0 skip:0 total:16
> ok 2 ext4_inode_test
> [18:44:48] Elapsed time: 8.602s total, 0.001s configuring, 8.483s building, 0.072s running
> 
> 
> Kemeng Shi (19):
>   ext4: fix wrong unit use in ext4_mb_normalize_request
>   ext4: fix unit mismatch in ext4_mb_new_blocks_simple
>   ext4: fix wrong unit use in ext4_mb_find_by_goal
>   ext4: treat stripe in block unit
>   ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
>   ext4: remove ext4_block_group and ext4_block_group_offset declaration
>   ext4: try all groups in ext4_mb_new_blocks_simple
>   ext4: get block from bh before pass it to ext4_free_blocks_simple in
>     ext4_free_blocks
>   ext4: remove unsed parameter and unnecessary forward declaration of
>     ext4_mb_new_blocks_simple
>   ext4: fix wrong unit use in ext4_mb_clear_bb
>   ext4: fix wrong unit use in ext4_mb_new_blocks
>   ext4: factor out codes to update block bitmap and group descriptor on
>     disk from ext4_mb_mark_bb
>   ext4: call ext4_mb_mark_group_bb in ext4_free_blocks_simple
>   ext4: extent ext4_mb_mark_group_bb to support allocation under journal
>   ext4: call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used
>   ext4: call ext4_mb_mark_group_bb in ext4_mb_clear_bb
>   ext4: call ext4_mb_mark_group_bb in ext4_group_add_blocks
>   ext4: add some kunit stub for mballoc kunit test
>   ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
> 
>  fs/ext4/balloc.c       |  16 +
>  fs/ext4/ext4.h         |   4 -
>  fs/ext4/mballoc-test.c | 323 +++++++++++++++++++
>  fs/ext4/mballoc.c      | 704 +++++++++++++++++++----------------------
>  fs/ext4/super.c        |  13 +
>  5 files changed, 671 insertions(+), 389 deletions(-)
>  create mode 100644 fs/ext4/mballoc-test.c
> 

-- 
Best wishes
Kemeng Shi

