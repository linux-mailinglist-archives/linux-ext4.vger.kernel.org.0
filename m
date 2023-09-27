Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA14E7AFB5F
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjI0Gvf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Sep 2023 02:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Gve (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Sep 2023 02:51:34 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72593D6;
        Tue, 26 Sep 2023 23:51:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RwS2573rxz4f3jXp;
        Wed, 27 Sep 2023 14:51:25 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgBXYQbx0BNl30H1BQ--.45561S2;
        Wed, 27 Sep 2023 14:51:30 +0800 (CST)
Subject: Re: [PATCH v7 01/12] ext4: make state in ext4_mb_mark_bb to be bool
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <874jjggn8l.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <ec8aca6c-1e8c-3fe9-81d7-d18876cc40cb@huaweicloud.com>
Date:   Wed, 27 Sep 2023 14:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <874jjggn8l.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBXYQbx0BNl30H1BQ--.45561S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF1kZF47KF1rJw1xAw1DZFb_yoW8JryfpF
        nxGF4rWr1vvw1q9wsrCa45XF1UK3s7KF42v3yfuw4ruFZ7t34IqFnxtF1Uu3Z8trZ7A3Wr
        Xa1a9r95Gr4fGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 9/27/2023 2:10 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> As state could only be either 0 or 1, just make it bool.
> 
> Sure.
> 
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/ext4.h        | 2 +-
>>  fs/ext4/fast_commit.c | 8 ++++----
>>  fs/ext4/mballoc.c     | 2 +-
>>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> But why not convert at all places?
Sorry for this. Will convert at all places in next version. Thanks.
> 
> git grep "ext4_mb_mark_bb" .
> fs/ext4/ext4.h:extern void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> fs/ext4/extents.c:                                      ext4_mb_mark_bb(inode->i_sb,
> fs/ext4/extents.c:                      ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> fs/ext4/fast_commit.c:                  ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> fs/ext4/fast_commit.c:                  ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> fs/ext4/fast_commit.c:                                          ext4_mb_mark_bb(inode->i_sb,
> fs/ext4/fast_commit.c:                          ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
> fs/ext4/mballoc.c:void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
> fs/ext4/mballoc.c:      ext4_mb_mark_bb(sb, block, 1, 1);
> 
> -ritesh
> 

