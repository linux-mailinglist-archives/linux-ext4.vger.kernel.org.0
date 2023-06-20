Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3762073617F
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jun 2023 04:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjFTCWn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Jun 2023 22:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFTCWm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Jun 2023 22:22:42 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C29C3;
        Mon, 19 Jun 2023 19:22:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QlVlc2vghz4f42RM;
        Tue, 20 Jun 2023 10:22:36 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgCX8RtpDZFkIrnELQ--.23772S2;
        Tue, 20 Jun 2023 10:22:34 +0800 (CST)
Subject: Re: [PATCH] fs: ext4: Fix traditional comparison using max/min method
To:     Li Dong <lidong@vivo.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230619134503.1277-1-lidong@vivo.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c4d1822c-1c4d-376a-1a35-80ddb990a9a4@huaweicloud.com>
Date:   Tue, 20 Jun 2023 10:22:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230619134503.1277-1-lidong@vivo.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgCX8RtpDZFkIrnELQ--.23772S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKw1UCr4kCFy5tw4rGrWxWFg_yoW8JrWUpF
        47XF1rKr4Yvw1vg3W7CryfKr45X34xGr48J3y5Xa15XF9rXFyDWa4qkrn5ZFyxA3yxXFyj
        va4qkFn8G39Fk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 6/19/2023 9:44 PM, Li Dong wrote:
> It would be better to replace the traditional ternary conditional operator with max()/min()
Hi Li, thanks for the patch, but this is a duplicate of [1] :)

[1] https://lore.kernel.org/linux-ext4/51be7b9a-726c-c232-146b-7785c50e875a@huaweicloud.com/
> Signed-off-by: Li Dong <lidong@vivo.com>
> ---
>  fs/ext4/balloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 1f72f977c6db..90ff655ddddb 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -111,10 +111,8 @@ static unsigned ext4_num_overhead_clusters(struct super_block *sb,
>  	itbl_blk_start = ext4_inode_table(sb, gdp);
>  	itbl_blk_end = itbl_blk_start + sbi->s_itb_per_group - 1;
>  	if (itbl_blk_start <= end && itbl_blk_end >= start) {
> -		itbl_blk_start = itbl_blk_start >= start ?
> -			itbl_blk_start : start;
> -		itbl_blk_end = itbl_blk_end <= end ?
> -			itbl_blk_end : end;
> +		itbl_blk_start = max(itbl_blk_start, start);
> +		itbl_blk_end = min(itbl_blk_end, end);
>  
>  		itbl_cluster_start = EXT4_B2C(sbi, itbl_blk_start - start);
>  		itbl_cluster_end = EXT4_B2C(sbi, itbl_blk_end - start);
> 

-- 
Best wishes
Kemeng Shi

