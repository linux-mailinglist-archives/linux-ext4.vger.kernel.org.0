Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2F78CC9B
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Aug 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbjH2TDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Aug 2023 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbjH2TDD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Aug 2023 15:03:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676A9193;
        Tue, 29 Aug 2023 12:03:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso2556588a91.0;
        Tue, 29 Aug 2023 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693335779; x=1693940579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oqc4/vptUd03VpYEFEx8OFMd41p+aBdp3gPXUMHyvwc=;
        b=omqoBmZ3v+Vmw5V5av49Az7q+rmaj81dTufDYO8PYzCCakEVN4y5N0zxgxjjrXQL3g
         MHj7A0hYi8Tv9UWydaeIFkzIoU5ZzSLiUuxol3KP+YFeiXQgT69cVRZzg3P+kCCqgarZ
         +lKuaEqij6EiRO2YTwmhUK8hGg7XNdP0d8mGQrAtkWvygnR2ho9VRSCVw+l4fma1fmoD
         4396g2a6ZY2dQDa9gMlAb7Ac1WUMTrdSSw4ngAbxd+pvdig9+D7YAz+Ev6BWvsq9TsAD
         /A9FMzLRZbsrBI3UdIyFM9d84wq206OpICkJKY+4gkG1wa7wrQkxOPv2MB2PY5P1DWUI
         oQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335779; x=1693940579;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqc4/vptUd03VpYEFEx8OFMd41p+aBdp3gPXUMHyvwc=;
        b=M2AG11sn+pnVQ5Lze8W/Y/gzJ7hR7bnoQQ9KxMJUhPxbPwNytmUpN5tGcYoNcEvct9
         UKFJqUNVrwV2RKN4xnAWNHgCCbr+QzUNVZ01QM6fU+a6XV5xJ0eEE60FQ4A1pkfd364M
         xp1oJaY4CT8wabasscnT+TaDXLBLWQiasr38CPRsQGxJgfEX29Afiv2r2Tt451iTcRmt
         Iw0e2bi86o0xT3yEyZVMrk9R7yWrVZ1WHIZkPWPs+ueCUX83piAlwI9i6+xz2LNkIkj0
         rGeBn4hhoaYjnHfDF5HnGcXJ5Oed5ik/MWt77nEasgtwcoNzSesURaI+Yz0256lR3ohU
         LUvQ==
X-Gm-Message-State: AOJu0Yx6wmVuyWAwOum8KhhYClnqwqNr/dcpq7wiL6y+rm9a/m617DKx
        w+ODaK/DK5aNXKnEa1ihv/B/5103LIw=
X-Google-Smtp-Source: AGHT+IFKmEf60QztWXpohFHSbZuymjRRbpX4aJHuWhk6DY8pYT2apzzLRAEOFUqYqRv0AKD/6FyDoQ==
X-Received: by 2002:a17:90a:5913:b0:26f:4685:5b6b with SMTP id k19-20020a17090a591300b0026f46855b6bmr108962pji.21.1693335779064;
        Tue, 29 Aug 2023 12:02:59 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a2a8f00b00262ca945cecsm11838677pjd.54.2023.08.29.12.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:02:58 -0700 (PDT)
Date:   Wed, 30 Aug 2023 00:32:49 +0530
Message-Id: <87v8cx8yee.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/11] cleanups and unit test for mballoc
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> v5-v6:
>

Hi Kemeng,

Sorry for the delay in getting started on this. I am going through the
series now.

> 1. Separate block bitmap and buddy bitmap freeing in individual patch
> and rewrite the descriptions.
> 2. Remove #ifdef around KUNIT_STATIC_STUB_REDIRECT which should be
> only defined when CONFIG_KUNIT is enabled after fix [7] which was merged
> into kunit-next/kunit
> 3. Use mbt prefix to distiguish test APIs from actual kernel APIs.
> 4. Add prepare function for ext4_mark_context and rename
> ext4_mb_mark_group_bb to ext4_mb_mark_context
> 5. Support to run mballoc test with different layouts setting and
> different block size is tested.
>
> v4->v5:
> 1. WARN on free blocks to uninitialized group is removed as normal
> fast commit route may triggers this, see [1] for details. The review
> tag from Ojaswin of changed patch is also removed and a futher review
> is needed.
>
> v3->v4:
> 1. Collect Reviewed-by from Ojaswin
> 2. Do improve as Ojaswin kindly suggested: Fix typo in commit,
> WARN if try to clear bit of uninitialized group and improve
> refactoring of AGGRESSIVE_CHECK code.
> 3. Fix conflic on patch 16
> 4. Improve git log in patch 16,17
>
> v2->v3:
> 1. Fix build warnings on "ext4: add some kunit stub for mballoc kunit
> test" and "ext4: add first unit test for ext4_mb_new_blocks_simple in
> mballoc"
>
> This series is a new version of unmerged patches from [1]. The first 6
> patches of this series factor out codes to mark blocks used or freed
> which will update on disk block bitmap and group descriptor. Several
> reasons to do this:
> 1. pair behavior of alloc/free bits. For example,
> ext4_mb_new_blocks_simple will update free_clusters in struct flex_groups
> in ext4_mb_mark_bb while ext4_free_blocks_simple forgets this.
> 2. remove repeat code to read from disk, update and write back to disk.
> 3. reduce future unit test mocks to avoid real IO to update structure
> on disk.
>
> The last 2 patches add a unit test for mballoc. Before more unit tests
> are added, there are something should be discussed:
> 1. How to test static function in mballoc.c
> Currently, include mballoc-test.c in mballoc.c to test static function
> in mballoc.c from mballoc-test.c which is one way suggested in [2].
> Not sure if there is any more elegant way to test static function without
> touch mballoc.c.
> 2. How to add mocks to function in mballoc.c which may issue IO to disk
> Currently, KUNIT_STATIC_STUB_REDIRECT is added to functions as suggested
> in kunit document [3].

I will get back to this, after reviwing some of the initial few
refactoring patches.

But FYI - I noticed some compilation errors, when building w/o
CONFIG_KUNIT.

../fs/ext4/balloc.c: In function ‘ext4_get_group_desc’:
../fs/ext4/balloc.c:278:2: error: implicit declaration of function ‘KUNIT_STATIC_STUB_REDIRECT’ [-Werror=implicit-function-declaration]
  278 |  KUNIT_STATIC_STUB_REDIRECT(ext4_get_group_desc,
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~

-ritesh

> 3. How to simulate a block bitmap.
> Currently, a fake buffer_head with bitmap data is returned, then no
> futher change is needed.
> If we simulate a block bitmap with an array of data structure like:
> struct test_bitmap {
>        unsigned int	start;
>        unsigned int	len;
> }
> which is suggested by Theodore in [4], then we need to add mocks to
> function which expected bitmap from bitmap_bh->b_data, like
> mb_find_next_bit, mb_find_next_zero_bit and maybe more.
>
> Would like to hear any suggestion! Thanks!
>
> I run kvm-xfstest with config "ext4/all" and "-g auto" together with
> patchset for resize, you can see detail report in [6].
>
> Unit test result is as followings:
> # ./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig --raw_output
> [18:23:36] Configuring KUnit Kernel ...
> [18:23:36] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=um O=.kunit olddefconfig
> Building with:
> $ make ARCH=um O=.kunit --jobs=88
> [18:23:40] Starting KUnit Kernel (1/1)...
> KTAP version 1
> 1..2
>     KTAP version 1
>     # Subtest: ext4_mballoc_test
>     1..1
>         KTAP version 1
>         # Subtest: test_new_blocks_simple
>         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>         ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>         ok 3 block_bits=18 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>     # test_new_blocks_simple: pass:3 fail:0 skip:0 total:3
>     ok 1 test_new_blocks_simple
> # Totals: pass:3 fail:0 skip:0 total:3
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
> [18:23:41] Elapsed time: 4.960s total, 0.001s configuring, 4.842s building, 0.072s running
>
> [1]
> https://lore.kernel.org/linux-ext4/20230603150327.3596033-1-shikemeng@huaweicloud.com/T/#m5ff8e3a058ce1cb272dfef3262cd3202ce6e4358
> [2]
> https://lore.kernel.org/linux-ext4/ZC3MoWn2UO6p+Swp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/
> [3]
> https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
> [4]
> https://docs.kernel.org/dev-tools/kunit/api/functionredirection.html#c.KUNIT_STATIC_STUB_REDIRECT
> [5]
> https://lore.kernel.org/linux-ext4/20230317155047.GB3270589@mit.edu/
> [6]
> https://lore.kernel.org/linux-ext4/20230629120044.1261968-1-shikemeng@huaweicloud.com/T/#mcc8fb0697fd54d9267c02c027e1eb3468026ae56
> [7]
> https://lore.kernel.org/lkml/20230725172051.2142641-1-shikemeng@huaweicloud.com/
>
> Kemeng Shi (11):
>   ext4: factor out codes to update block bitmap and group descriptor on
>     disk from ext4_mb_mark_bb
>   ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
>   ext4: extent ext4_mb_mark_context to support allocation under journal
>   ext4: call ext4_mb_mark_context in ext4_mb_mark_diskspace_used
>   ext4: Separate block bitmap and buddy bitmap freeing in
>     ext4_mb_clear_bb()
>   ext4: call ext4_mb_mark_context in ext4_mb_clear_bb
>   ext4: Separate block bitmap and buddy bitmap freeing in
>     ext4_group_add_blocks()
>   ext4: call ext4_mb_mark_context in ext4_group_add_blocks()
>   ext4: add some kunit stub for mballoc kunit test
>   ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
>   ext4: run mballoc test with different layouts setting
>
>  fs/ext4/balloc.c       |  10 +
>  fs/ext4/mballoc-test.c | 351 ++++++++++++++++++++++++++++
>  fs/ext4/mballoc.c      | 505 ++++++++++++++++-------------------------
>  3 files changed, 557 insertions(+), 309 deletions(-)
>  create mode 100644 fs/ext4/mballoc-test.c
>
> -- 
> 2.30.0
