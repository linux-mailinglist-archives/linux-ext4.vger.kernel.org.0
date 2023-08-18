Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6307803CF
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 04:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357240AbjHRCaI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 22:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357250AbjHRCaB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 22:30:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FFB114;
        Thu, 17 Aug 2023 19:29:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RRm6q0sM4z4f3k6D;
        Fri, 18 Aug 2023 10:29:55 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDndqmg195kR9zkAw--.45216S2;
        Fri, 18 Aug 2023 10:29:54 +0800 (CST)
Subject: Re: [PATCH 11/13] ext4: correct gdblock calculation in
 add_new_gdb_meta_bg to support non first group
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-12-shikemeng@huaweicloud.com>
 <20230816034543.GS2247938@mit.edu>
 <29c9e94f-63b3-e757-9d6d-c9beaa0e0c19@huaweicloud.com>
 <20230817140328.GY2247938@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <e9215048-8a10-bb3e-93f7-0bf840997027@huaweicloud.com>
Date:   Fri, 18 Aug 2023 10:29:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230817140328.GY2247938@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDndqmg195kR9zkAw--.45216S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF47AF47ZF1xKry8ZF4Dtwb_yoW5KF1rpF
        WkJF93tFZ5JrW0k3Z2y3y0grZYkw48G3y5Xry5Gry8Cwn8Wwn3Krs2qFyFvF9xuF4fXr1Y
        qr45Z3srCr1UurDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/17/2023 10:03 PM, Theodore Ts'o wrote:
> On Thu, Aug 17, 2023 at 11:38:34AM +0800, Kemeng Shi wrote:
>>
>>
>> on 8/16/2023 11:45 AM, Theodore Ts'o wrote:
>>> On Thu, Jun 29, 2023 at 08:00:42PM +0800, Kemeng Shi wrote:
>>>> In add_new_gdb_meta_bg, we assume that group could be non first
>>>> group in meta block group as we call ext4_meta_bg_first_block_no
>>>> to get first block of meta block group rather than call
>>>> ext4_group_first_block_no for passed group directly. Then ext4_bg_has_super
>>>> should be called with first group in meta group rather than new added
>>>> group. Or we can call ext4_group_first_block_no instead of
>>>> ext4_meta_bg_first_block_no to assume only first group of
>>>> meta group will be passed.
>>>> Either way, ext4_meta_bg_first_block_no will be useless and
>>>> could be removed.
>>>
>>> Unfortunately, I spent more time trying to understand the commit
>>> description than the C code.  Perhaps this might be a better way of
>>> describing the situation?
>>>
>> Sorry for my poor language again, :( I will try to improve this.
>>> The ext4_new descs() function calls ext4_meta_bg_first_block_no() with
>>> the group paramter when the group is the first group of a meta_bg
>>> (e.g., when (group % EXT4_DESC_PER_BLOCK) is zero.  So we can simplify
>>> things a bit by removing ext4_meta_bg_first_block_no() and an open
>>> coding its logic.
>>>
>>> Does this make more sense to tou?
>>>
>> This patch tries to correct gdbblock calculation in add_new_gdb_meta_bg
>> in case group from caller is not the first group of meta_bg which is
>> supposed to be handled by add_new_gdb_meta_bg.
>> We should call ext4_bg_has_super with first group in meta_bg instead
>> of group which could be non first group in meta_bg to calculate gdb
>> of meta_bg.
>> Fortunately, the only caller ext4_add_new_descs always call
>> add_new_gdb_meta_bg with first group of meta_bg and no real issue
>> will happen.
> 
> To be clear, this doesn't have a functional change given how the code
> is going to be used, right?  It's really more of a cleanup with a goal
> of making the code easier to understand.  If so, we should make this
> explicit at the beginning of the commit description, as opposed to
> putting it at the end.
> 
Actually, there seems a functional change to add_new_gdb_meta_bg.
Assume 'group' is the new added group, 'first_group' is the first group
of meta_bg which contains 'group',
Original way to calculate gdbblock:
gdbblock = group_first_block('first_group') + bg_has_super(*'group'*)
New ay to calculate gdbblock
gdbblock = group_first_block('first_group') + bg_has_super(*'first_group'*)
If new added group is not the first group of meta_bg, add_new_gdb_meta_bg
get a wrong gdbblock.
Maybe it's more of a bugfix to as add_new_gdb_meta_bg treats group
as any group of meta_bg instead of first group of meta_bg. And it's
more of a cleanup as only first group is passed from caller.
> In journalism this is referred to as "burying the lede"[1], where the
> "lede" the most important/key piece of information.  In general, it is
> desirable not to "bury the lede".  That is, the most important
> information, including why people should care, and what this is doing,
> at the beginning of the commit description (or article in the case of
> journalsm).
> 
> [1] https://www.masterclass.com/articles/bury-the-lede-explained
> 
> 					- Ted
> 
Thanks for this information. But I'm little confused weather a cleanup
or a bugfix I should mention at the beginning. Any more advise is
appreciated!

