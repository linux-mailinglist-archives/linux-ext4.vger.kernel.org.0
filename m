Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD57728D43
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 03:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbjFIBsd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 21:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjFIBs3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 21:48:29 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620191BF0;
        Thu,  8 Jun 2023 18:48:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QckWD0zvSz4f3tP5;
        Fri,  9 Jun 2023 09:48:24 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP3 (Coremail) with SMTP id _Ch0CgAX_gvnhIJkq5urKQ--.41846S2;
        Fri, 09 Jun 2023 09:48:24 +0800 (CST)
Subject: Re: [PATCH] ext4: Fix traditional comparison using max/min method
To:     Lu Hongfei <luhongfei@vivo.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230529070930.37949-1-luhongfei@vivo.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <51be7b9a-726c-c232-146b-7785c50e875a@huaweicloud.com>
Date:   Fri, 9 Jun 2023 09:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230529070930.37949-1-luhongfei@vivo.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _Ch0CgAX_gvnhIJkq5urKQ--.41846S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtF1Uuw1ftF4xuw4DtFW8JFb_yoW8JryDpr
        42qFyfKr4Yqw18W3W7Cr1fKr45X3y7Gr4UJ3y5XF45XFyUJrykGasFkr95WFyxA3yfZF1U
        Za4qkFn8C392k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 5/29/2023 3:09 PM, Lu Hongfei wrote:
> It would be better to replace the traditional ternary conditional
> operator with max()/min()
> 
> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
> ---
>  fs/ext4/balloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>  mode change 100644 => 100755 fs/ext4/balloc.c
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c1edde817be8..82124045d187
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

Thanks for the improve, Looks good. Feel free to add:

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>

-- 
Best wishes
Kemeng Shi

