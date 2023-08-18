Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72692780625
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 09:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352426AbjHRHKJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 03:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237838AbjHRHJm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 03:09:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641330D1;
        Fri, 18 Aug 2023 00:09:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RRtKW6vpQz4f3lVf;
        Fri, 18 Aug 2023 15:09:35 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgCnF2wvGd9kaMTsAw--.41833S2;
        Fri, 18 Aug 2023 15:09:37 +0800 (CST)
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
 <e9215048-8a10-bb3e-93f7-0bf840997027@huaweicloud.com>
 <20230818040751.GF3464136@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <797c2dff-1858-9e4b-bda7-d6106d5ff844@huaweicloud.com>
Date:   Fri, 18 Aug 2023 15:09:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230818040751.GF3464136@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgCnF2wvGd9kaMTsAw--.41833S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWrZrWrCw1rtryxGryrtFb_yoW8Kr4fpF
        s5Kr95trWDGry5Xas7A3yIgrWrCw4rJ3y8AryUJryUC3sxWFnagrZ2yF1fta47uFs3t34j
        qFy5Zr9rC3Z8ZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/18/2023 12:07 PM, Theodore Ts'o wrote:
> On Fri, Aug 18, 2023 at 10:29:52AM +0800, Kemeng Shi wrote:
>> Actually, there seems a functional change to add_new_gdb_meta_bg.
>> Assume 'group' is the new added group, 'first_group' is the first group
>> of meta_bg which contains 'group',
>> Original way to calculate gdbblock:
>> gdbblock = group_first_block('first_group') + bg_has_super(*'group'*)
>> New ay to calculate gdbblock
>> gdbblock = group_first_block('first_group') + bg_has_super(*'first_group'*)
>> If new added group is not the first group of meta_bg, add_new_gdb_meta_bg
>> get a wrong gdbblock.
> 
> If you look at the ext4_add_new_descs() function,
> add_new_gdb_meta_bg() is only called when the group is a multiple of
> EXT4_DESC_PER_BLOCK --- that is, when group % EXT4_DESC_PER_BLOCK == 0.
>
> As such, it is only called when with group is the first group in the
> meta_bg.  So there is no bug here.  The code is bit confusing, I agree
> --- I myself got confused because it's been years since I last looked
> at the code, and it's not particularly commented well, which is my fault.
> 
Yes, add_new_gdb_meta_bg is only called with first group of mebg and no real
bug here.
> This also makes the commit description "... to support non-first
> group" incorrect, since it never gets called as with a "non-first
> group".
> 
Ah, what I want to say is "support non-frist group in fulture". And if there
is definely no need in fulture, it's more intuitive just treat group from caller
as first group in meta_bg.
> The patch makes things a little simpler, but the commit description
> would confuse anyone who looked at it while doing code archeology.
> The change is fine, although at this point, given how we both
> misunderstood how the code worked without doing some deep mind-melds
> with the C code in question, it's clear that we need some better
> comments in the code.
> 
> For example, the comment "add_new_gdb_meta_bg is the sister of
> add_new_gdb" is clearly insufficient.
> Is following comment looks good to you:
When all reserved primary blocks are consumed, we create meta_bg group and
allocate new primary block at first block or block after backup superblock
(if exsiting) in first group of meta_bg group.
This function is only called when first group of meta_bg is added.
> 						- Ted
> 

