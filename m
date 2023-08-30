Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872E778DAB2
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Aug 2023 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbjH3Sgy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Aug 2023 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbjH3HWx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Aug 2023 03:22:53 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1FB1BB;
        Wed, 30 Aug 2023 00:22:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RbG373tXHz4f3nq2;
        Wed, 30 Aug 2023 15:22:43 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgCHYaRB7u5ktJa1Bw--.25701S2;
        Wed, 30 Aug 2023 15:22:43 +0800 (CST)
Subject: Re: [PATCH v6 00/11] cleanups and unit test for mballoc
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87v8cx8yee.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c92574b5-1441-645c-4824-723545e45845@huaweicloud.com>
Date:   Wed, 30 Aug 2023 15:22:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87v8cx8yee.fsf@doe.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHYaRB7u5ktJa1Bw--.25701S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr47Gry8CF48KF4fXF1xAFb_yoWfGrW8pr
        Z2kF4DKr1xJr1qvan3C347ur1xKw4xta17GF1fK34xuFy3Wr97CFsrKFWY9a4DKr4DZFyY
        vF15CFy5uw1v9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/30/2023 3:02 AM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> v5-v6:
>>
> 
> Hi Kemeng,
> 
> Sorry for the delay in getting started on this. I am going through the
> series now.
> 
>> 1. Separate block bitmap and buddy bitmap freeing in individual patch
>> and rewrite the descriptions.
>> 2. Remove #ifdef around KUNIT_STATIC_STUB_REDIRECT which should be
>> only defined when CONFIG_KUNIT is enabled after fix [7] which was merged
>> into kunit-next/kunit
Hi ritesh, thanks for feedback. I think the compilation problem below is
relevant to this change which relie on fix [7]. I'm not sure if I need to
include fix [7] in this set to fix the compilation error. Would like to
hear any advise!

>> 3. Use mbt prefix to distiguish test APIs from actual kernel APIs.
>> 4. Add prepare function for ext4_mark_context and rename
>> ext4_mb_mark_group_bb to ext4_mb_mark_context
>> 5. Support to run mballoc test with different layouts setting and
>> different block size is tested.
>>
>> v4->v5:
>> 1. WARN on free blocks to uninitialized group is removed as normal
>> fast commit route may triggers this, see [1] for details. The review
>> tag from Ojaswin of changed patch is also removed and a futher review
>> is needed.
>>
>> v3->v4:
>> 1. Collect Reviewed-by from Ojaswin
>> 2. Do improve as Ojaswin kindly suggested: Fix typo in commit,
>> WARN if try to clear bit of uninitialized group and improve
>> refactoring of AGGRESSIVE_CHECK code.
>> 3. Fix conflic on patch 16
>> 4. Improve git log in patch 16,17
>>
>> v2->v3:
>> 1. Fix build warnings on "ext4: add some kunit stub for mballoc kunit
>> test" and "ext4: add first unit test for ext4_mb_new_blocks_simple in
>> mballoc"
>>
>> This series is a new version of unmerged patches from [1]. The first 6
>> patches of this series factor out codes to mark blocks used or freed
>> which will update on disk block bitmap and group descriptor. Several
>> reasons to do this:
>> 1. pair behavior of alloc/free bits. For example,
>> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
>> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
>> 2. remove repeat code to read from disk, update and write back to disk.
>> 3. reduce future unit test mocks to avoid real IO to update structure
>> on disk.
>>
>> The last 2 patches add a unit test for mballoc. Before more unit tests
>> are added, there are something should be discussed:
>> 1. How to test static function in mballoc.c
>> Currently, include mballoc-test.c in mballoc.c to test static function
>> in mballoc.c from mballoc-test.c which is one way suggested in [2].
>> Not sure if there is any more elegant way to test static function without
>> touch mballoc.c.
>> 2. How to add mocks to function in mballoc.c which may issue IO to disk
>> Currently, KUNIT_STATIC_STUB_REDIRECT is added to functions as suggested
>> in kunit document [3].
> 
> I will get back to this, after reviwing some of the initial few
> refactoring patches.
> 
> But FYI - I noticed some compilation errors, when building w/o
> CONFIG_KUNIT.
> 
> ../fs/ext4/balloc.c: In function ‘ext4_get_group_desc’:
> ../fs/ext4/balloc.c:278:2: error: implicit declaration of function ‘KUNIT_STATIC_STUB_REDIRECT’ [-Werror=implicit-function-declaration]
>   278 |  KUNIT_STATIC_STUB_REDIRECT(ext4_get_group_desc,
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> -ritesh
> 
>> 3. How to simulate a block bitmap.
>> Currently, a fake buffer_head with bitmap data is returned, then no
>> futher change is needed.
>> If we simulate a block bitmap with an array of data structure like:
>> struct test_bitmap {
>>        unsigned int	start;
>>        unsigned int	len;
>> }
>> which is suggested by Theodore in [4], then we need to add mocks to
>> function which expected bitmap from bitmap_bh->b_data, like
>> mb_find_next_bit, mb_find_next_zero_bit and maybe more.
>>
>> Would like to hear any suggestion! Thanks!
>>
>> I run kvm-xfstest with config "ext4/all" and "-g auto" together with
>> patchset for resize, you can see detail report in [6].
>>
>> Unit test result is as followings:
>> # ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig --raw_output
>> [18:23:36] Configuring KUnit Kernel ...
>> [18:23:36] Building KUnit Kernel ...
>> Populating config with:
>> $ make ARCH=um O=.kunit olddefconfig
>> Building with:
>> $ make ARCH=um O=.kunit --jobs=88
>> [18:23:40] Starting KUnit Kernel (1/1)...
>> KTAP version 1
>> 1..2
>>     KTAP version 1
>>     # Subtest: ext4_mballoc_test
>>     1..1
>>         KTAP version 1
>>         # Subtest: test_new_blocks_simple
>>         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>>         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>>         ok 3 block_bits=18 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>>     # test_new_blocks_simple: pass:3 fail:0 skip:0 total:3
>>     ok 1 test_new_blocks_simple
>> # Totals: pass:3 fail:0 skip:0 total:3
>> ok 1 ext4_mballoc_test
>>     KTAP version 1
>>     # Subtest: ext4_inode_test
>>     1..1
>>         KTAP version 1
>>         # Subtest: inode_test_xtimestamp_decoding
>>         ok 1 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
>>         ok 2 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
>>         ok 3 1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits
>>         ok 4 2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits
>>         ok 5 2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on
>>         ok 6 2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on
>>         ok 7 2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on
>>         ok 8 2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on
>>         ok 9 2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on
>>         ok 10 2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on
>>         ok 11 2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on
>>         ok 12 2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on
>>         ok 13 2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns
>>         ok 14 2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns
>>         ok 15 2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on
>>         ok 16 2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on
>>     # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16
>>     ok 1 inode_test_xtimestamp_decoding
>> # Totals: pass:16 fail:0 skip:0 total:16
>> ok 2 ext4_inode_test
>> [18:23:41] Elapsed time: 4.960s total, 0.001s configuring, 4.842s building, 0.072s running
>>
>> [1]
>> https://lore.kernel.org/linux-ext4/20230603150327.3596033-1-shikemeng@huaweicloud.com/T/#m5ff8e3a058ce1cb272dfef3262cd3202ce6e4358
>> [2]
>> https://lore.kernel.org/linux-ext4/ZC3MoWn2UO6p+Swp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
>> [3]
>> https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
>> [4]
>> https://docs.kernel.org/dev-tools/kunit/api/functionredirection.html#c.KUNIT_STATIC_STUB_REDIRECT
>> [5]
>> https://lore.kernel.org/linux-ext4/20230317155047.GB3270589@mit.edu/
>> [6]
>> https://lore.kernel.org/linux-ext4/20230629120044.1261968-1-shikemeng@huaweicloud.com/T/#mcc8fb0697fd54d9267c02c027e1eb3468026ae56
>> [7]
>> https://lore.kernel.org/lkml/20230725172051.2142641-1-shikemeng@huaweicloud.com/
>>
>> Kemeng Shi (11):
>>   ext4: factor out codes to update block bitmap and group descriptor on
>>     disk from ext4_mb_mark_bb
>>   ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
>>   ext4: extent ext4_mb_mark_context to support allocation under journal
>>   ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
>>   ext4: Separate block bitmap and buddy bitmap freeing in
>>     ext4_mb_clear_bb()
>>   ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
>>   ext4: Separate block bitmap and buddy bitmap freeing in
>>     ext4_group_add_blocks()
>>   ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
>>   ext4: add some kunit stub for mballoc kunit test
>>   ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
>>   ext4: run mballoc test with different layouts setting
>>
>>  fs/ext4/balloc.c       |  10 +
>>  fs/ext4/mballoc-test.c | 351 ++++++++++++++++++++++++++++
>>  fs/ext4/mballoc.c      | 505 ++++++++++++++++-------------------------
>>  3 files changed, 557 insertions(+), 309 deletions(-)
>>  create mode 100644 fs/ext4/mballoc-test.c
>>
>> -- 
>> 2.30.0
> 

