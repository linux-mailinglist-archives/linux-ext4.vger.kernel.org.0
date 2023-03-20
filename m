Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138D56C1320
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 14:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCTNUN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjCTNTu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 09:19:50 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6A924134;
        Mon, 20 Mar 2023 06:19:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PgFh93yN6z4f3jQb;
        Mon, 20 Mar 2023 21:19:37 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgDHeq5pXRhkOUPvFg--.63166S2;
        Mon, 20 Mar 2023 21:19:39 +0800 (CST)
Subject: Re: [PATCH 7/7] ext4: improve inode table blocks counting in
 ext4_num_overhead_clusters
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230221115919.1918161-1-shikemeng@huaweicloud.com>
 <20230221115919.1918161-8-shikemeng@huaweicloud.com>
 <20230320124444.kkp4es2wyke7vqgx@quack3>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <afde9290-39d4-0273-40de-153a53f60e31@huaweicloud.com>
Date:   Mon, 20 Mar 2023 21:19:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230320124444.kkp4es2wyke7vqgx@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHeq5pXRhkOUPvFg--.63166S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWfJrW7Ww4kCw15Cw18uFg_yoW8Xr4rpr
        4xta45tr45urWqgr4SyF9rXrWFga15Kr47Ja13Gr13GayDuws2gr9xtrs0vF12gw47Aw1q
        qFW3C3yUu3sxA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 3/20/2023 8:44 PM, Jan Kara wrote:
> On Tue 21-02-23 19:59:19, Kemeng Shi wrote:
>> As inode table blocks are contiguous, inode table blocks inside the
>> block_group can be represented as range [itbl_cluster_start,
>> itbl_cluster_last]. Then we can simply account inode table cluters and
>> check cluster overlap with [itbl_cluster_start, itbl_cluster_last] instead
>> of traverse each block of inode table.
>> By the way, this patch fixes code style problem of comment for
>> ext4_num_overhead_clusters.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> FWIW this is triggering Coverity warning:
> 
> *** CID 1536792:  Uninitialized variables  (UNINIT)
> /fs/ext4/balloc.c: 153 in ext4_num_overhead_clusters()
> 147                     inode_cluster = EXT4_B2C(sbi,
> 148                                              ext4_inode_bitmap(sb, gdp) - st
> 149                     /*
> 150                      * Additional check if inode bitmap is in just accounted
> 151                      * block_cluster
> 152                      */
>>>>     CID 1536792:  Uninitialized variables  (UNINIT)
>>>>     Using uninitialized value "block_cluster".
> 153                     if (inode_cluster != block_cluster &&
> 154                         inode_cluster >= base_clusters &&
> 155                         (inode_cluster < itbl_cluster_start ||
> 156                         inode_cluster > itbl_cluster_end))
> 157                             num_clusters++;
> 158             }
> 
> which actually looks valid AFAICT.
Yes, there is a risk to access uninitialized block_cluster if block bitmap block
and inode bitmap block are in different groups. Patch to fix is just sent. Thanks!

-- 
Best wishes
Kemeng Shi

