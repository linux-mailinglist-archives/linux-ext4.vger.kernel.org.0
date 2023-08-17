Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392E977EF9A
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 05:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbjHQDil (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 23:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347880AbjHQDil (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 23:38:41 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8512686;
        Wed, 16 Aug 2023 20:38:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RR9hT1Pq2z4f3jYR;
        Thu, 17 Aug 2023 11:38:33 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP4 (Coremail) with SMTP id gCh0CgCHZKc7lt1kEAiYAw--.48250S2;
        Thu, 17 Aug 2023 11:38:36 +0800 (CST)
Subject: Re: [PATCH 11/13] ext4: correct gdblock calculation in
 add_new_gdb_meta_bg to support non first group
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-12-shikemeng@huaweicloud.com>
 <20230816034543.GS2247938@mit.edu>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <29c9e94f-63b3-e757-9d6d-c9beaa0e0c19@huaweicloud.com>
Date:   Thu, 17 Aug 2023 11:38:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230816034543.GS2247938@mit.edu>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgCHZKc7lt1kEAiYAw--.48250S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUCw13ZrW7GFyUCr18uFg_yoW8AFy5pa
        ykAFyrKFykJrW093ZrA3y0grZ5Cw18J3yUJry3Cr18Cwn8Gr1fKrn7XFyFq3Wa9F4fXr1Y
        vr4rZ3srCr4kurDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 8/16/2023 11:45 AM, Theodore Ts'o wrote:
> On Thu, Jun 29, 2023 at 08:00:42PM +0800, Kemeng Shi wrote:
>> In add_new_gdb_meta_bg, we assume that group could be non first
>> group in meta block group as we call ext4_meta_bg_first_block_no
>> to get first block of meta block group rather than call
>> ext4_group_first_block_no for passed group directly. Then ext4_bg_has_super
>> should be called with first group in meta group rather than new added
>> group. Or we can call ext4_group_first_block_no instead of
>> ext4_meta_bg_first_block_no to assume only first group of
>> meta group will be passed.
>> Either way, ext4_meta_bg_first_block_no will be useless and
>> could be removed.
> 
> Unfortunately, I spent more time trying to understand the commit
> description than the C code.  Perhaps this might be a better way of
> describing the situation?
> 
Sorry for my poor language again, :( I will try to improve this.
> The ext4_new descs() function calls ext4_meta_bg_first_block_no() with
> the group paramter when the group is the first group of a meta_bg
> (e.g., when (group % EXT4_DESC_PER_BLOCK) is zero.  So we can simplify
> things a bit by removing ext4_meta_bg_first_block_no() and an open
> coding its logic.
> 
> Does this make more sense to tou?
> 
This patch tries to correct gdbblock calculation in add_new_gdb_meta_bg
in case group from caller is not the first group of meta_bg which is
supposed to be handled by add_new_gdb_meta_bg.
We should call ext4_bg_has_super with first group in meta_bg instead
of group which could be non first group in meta_bg to calculate gdb
of meta_bg.
Fortunately, the only caller ext4_add_new_descs always call
add_new_gdb_meta_bg with first group of meta_bg and no real issue
will happen.


> 					- Ted
> 

