Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C3D783828
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Aug 2023 04:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjHVCsM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Aug 2023 22:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjHVCsL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Aug 2023 22:48:11 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D711D;
        Mon, 21 Aug 2023 19:48:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RVDKt1027z4f3khv;
        Tue, 22 Aug 2023 10:48:02 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgD3ayjkIeRkV3HcBA--.4254S2;
        Tue, 22 Aug 2023 10:48:05 +0800 (CST)
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
 <797c2dff-1858-9e4b-bda7-d6106d5ff844@huaweicloud.com>
 <20230818165432.GB3515079@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <8fb18273-9d8a-835f-7745-c0c558fb5d41@huaweicloud.com>
Date:   Tue, 22 Aug 2023 10:48:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230818165432.GB3515079@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgD3ayjkIeRkV3HcBA--.4254S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1fAF4DKFW3CF15GryrCrg_yoW8CF1rpr
        s5Aa9xArZ8G348W3WkA3y0qrWkCw4rJw43Jr9rJry5u398Grnagr93CF1Fya4qgr4YyF1j
        vr45Z34UCryDCwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/19/2023 12:54 AM, Theodore Ts'o wrote:
> On Fri, Aug 18, 2023 at 03:09:35PM +0800, Kemeng Shi wrote:
>>> Is following comment looks good to you:
>>
>> When all reserved primary blocks are consumed, we create meta_bg group and
>> allocate new primary block at first block or block after backup superblock
>> (if exsiting) in first group of meta_bg group.
>> This function is only called when first group of meta_bg is added.
> 
> Well, it's possible to create a file system where all of the block
> group descriptors use meta_bg, and there are no "traditional" block
> group descriptors.  And so what happens is if there is no available
> space in the existing block group descriptors for the new block group,
> and there are no reserved block group descriptors (I'd remove
> "primary" as that's not something that we've used traditionally), then
> what happens is that the meta_bg feature will get enabled, and 
> es->s_first_meta_bg will get set to the first block group that is
> managed using meta_bg.  s_first_meta_bg must be a multiple of
> EXT4_DESC_PER_BLOCK(sb).
> 
> Some of this is documented in Documentation/filesystems/ext4/blockgroup.rst
> already.
>
As these information into comment of add_new_gdb_meta_bg could help to some
dgree. I summary the information to:

If there is no available space in the existing block group descriptors for
the new block group and there are no reserved block group descriptors, then
the meta_bg feature will get enabled, and es->s_first_meta_bg will get set
to the first block group that is managed using meta_bg and s_first_meta_bg
must be a multiple of EXT4_DESC_PER_BLOCK(sb).
This function will be called when first group of meta_bg is added to bring
new group descriptors block of new added meta_bg.

Or I will leave comments unchange in next version if it's redundant to you.
Thanks!
> Cheers,
> 
> 						- Ted
> 

