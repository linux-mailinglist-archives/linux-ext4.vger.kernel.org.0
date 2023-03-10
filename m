Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7206B3856
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 09:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCJIR7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 03:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCJIR5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 03:17:57 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC010C1;
        Fri, 10 Mar 2023 00:17:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PXzSb0FQ0z4f3jJ2;
        Fri, 10 Mar 2023 16:17:51 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgC3Z6uR5wpkmoVgFA--.35999S2;
        Fri, 10 Mar 2023 16:17:52 +0800 (CST)
Subject: Re: [PATCH v3 00/20] Some bugfix and cleanup to mballoc
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <5e5691cd-3308-be3b-91d5-9fa1ab9ec98d@huaweicloud.com>
Date:   Fri, 10 Mar 2023 16:17:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgC3Z6uR5wpkmoVgFA--.35999S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXry8GrWrJr47Xw1kWr1rJFb_yoW5CF48pF
        43CrnxK34xXr12yFZIkw45Jw1fW3y8Gw45GFyIg348Ar13Ar9aqrnrKF95uFWUJrZ7X3Zx
        ZayavryUGw1kAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 3/4/2023 1:21 AM, Kemeng Shi wrote:
> Hi, this series contain some random cleanup patches and some bugfix
> patches to make EXT4_MB_HINT_GOAL_ONLY work properly, protect pa->pa_free
> from race and so on. More details can be found in git log.
> Thanks!
> 
> ---
> V3:
> -patch 01/20 "ext4: set goal start correctly in
> ext4_mb_normalize_request" correctly record goal in ac_g_ex instead of
> ac_f_ex, this also trigger another original bug that wanted goal maybe
> out of valid data block range. Add valid range check in patch 01/20
> to fully fix the bug.
> -run "kvm-xfstests smoke" and all tests are passed except generic/454.
> This test also failed in running kernel without this patchset, so
> it's unlikely caused by this patchset. I'm trying to figure out the
> reason but it may take a while as I'm not family with kvm-xfstests.
> Just send this series for early review and maybe some help to pass
> the failed test case.
I re-run "kvm-xfstests smoke" with newly root_fs.img and all tests pass.
It may be the early test which triggerred bug and corruptted the metadata
casues failure.
> ---
> V2:
> -Add signed-off from Ritesh and Ojaswin to patch 3/20 "ext4: get correct
> ext4_group_info in ext4_mb_prefetch_fini" as this is a duplicate of
> a patch under reviewing.
> -Split out original patch "ext4: avoid to use preallocated blocks if
> EXT4_MB_HINT_GOAL_ONLY is set" which will be resend after improved.
> -Improve log information of patch 20.
> -Collect Reviewed-by from Ojaswin and Ritesh. Now only patch 3, 12 and
> 20 need futher review.
> ---
> 
> 
> Kemeng Shi (20):
>   ext4: set goal start correctly in ext4_mb_normalize_request
>   ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
>   ext4: get correct ext4_group_info in ext4_mb_prefetch_fini
>   ext4: correct calculation of s_mb_preallocated
>   ext4: correct start of used group pa for debug in ext4_mb_use_group_pa
>   ext4: protect pa->pa_free in ext4_discard_allocated_blocks
>   ext4: add missed brelse in ext4_free_blocks_simple
>   ext4: remove unused return value of ext4_mb_try_best_found and
>     ext4_mb_free_metadata
>   ext4: Remove unnecessary release when memory allocation failed in
>     ext4_mb_init_cache
>   ext4: remove unnecessary e4b->bd_buddy_page check in
>     ext4_mb_load_buddy_gfp
>   ext4: remove unnecessary check in ext4_mb_new_blocks
>   ext4: remove dead check in mb_buddy_mark_free
>   ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in
>     ext4_mb_check_limits
>   ext4: use best found when complex scan of group finishs
>   ext4: remove unnecessary exit_meta_group_info tag
>   ext4: remove unnecessary count2 in ext4_free_data_in_buddy
>   ext4: remove unnecessary goto in ext4_mb_mark_diskspace_used
>   ext4: remove repeat assignment to ac_f_ex
>   ext4: remove comment code ext4_discard_preallocations
>   ext4: simplify calculation of blkoff in ext4_mb_new_blocks_simple
> 
>  fs/ext4/mballoc.c | 111 ++++++++++++++++++----------------------------
>  1 file changed, 43 insertions(+), 68 deletions(-)
> 

-- 
Best wishes
Kemeng Shi

