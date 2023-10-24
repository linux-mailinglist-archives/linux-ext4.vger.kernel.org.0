Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DC7D4599
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Oct 2023 04:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjJXCgE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Oct 2023 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJXCf6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Oct 2023 22:35:58 -0400
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0210D5;
        Mon, 23 Oct 2023 19:35:48 -0700 (PDT)
X-QQ-mid: bizesmtp73t1698114915tkuo0ka1
Received: from [10.7.13.54] ( [125.76.217.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 24 Oct 2023 10:35:14 +0800 (CST)
X-QQ-SSF: 01400000000000D0H000000A0000000
X-QQ-FEAT: qOAV9bwDT/nXIhLNlbreDjkXisHowUo93uM1zLloz1/5xKJL9qlE3NGpd0W78
        A/s9YfCC86SmwPdYzQN2MslwSfeV182xY0AeA7cT17jBY/g12N44CUoytNVmRXQTPl9OBhQ
        M6yIPEtkgpvVpJusF345wvhtz8BPHv0kj1nB4hnx6yDB28HyHFR2Bz8lPUIRZtIa/GIphrg
        cCLfhsuTC8XL7tb9tKitQDxuiAtywvsQiLfK3TkYMzINpHO5OY0pxTXi/IRy6POvClmBe1v
        OO9tBWakXA4RQxuZobacA5pqu8hpSDo1KByTCabd+1rFJCI3baHnGGuvRPP8BuvXgkL+75H
        Fp4ADB+DLD8icPq2kkPlpsH8vCMWdgphzfkP/XCFHAMfhb7GgiDopy7aYreeAsdw+PtckOc
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6538827013053437973
Message-ID: <4CEE0B491E07CA77+c77a8b3d-095b-b33c-0091-dcb55fd40d28@uniontech.com>
Date:   Tue, 24 Oct 2023 10:35:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ext4: delete redundant calculations in
 ext4_mb_get_buddy_page_lock()
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        gouhaojake@163.com
References: <20231023013416.17246-1-gouhao@uniontech.com>
 <20231023114447.crn3bt4qdmkxkrxi@quack3>
Content-Language: en-US
Reply-To: 20231023114447.crn3bt4qdmkxkrxi@quack3
From:   Gou Hao <gouhao@uniontech.com>
In-Reply-To: <20231023114447.crn3bt4qdmkxkrxi@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 10/23/23 19:44, Jan Kara wrote:

> On Mon 23-10-23 09:34:16, Gou Hao wrote:
>> 'blocks_per_page' is always 1 after 'if (blocks_per_page >= 2)',
>> 'pnum' and 'block' is equal in this case.
>>
>> Signed-off-by: Gou Hao <gouhao@uniontech.com>
>> Signed-off-by: Gou Hao <gouhaojake@163.com>
> No need for two signed-off-by here. Any one from you is enough :)
ok
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 454d5612641e..8442f5474b25 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1456,9 +1456,7 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
>>   		return 0;
>>   	}
>>   
>> -	block++;
>> -	pnum = block / blocks_per_page;
>> -	page = find_or_create_page(inode->i_mapping, pnum, gfp);
>> +	page = find_or_create_page(inode->i_mapping, ++block, gfp);
> 						     ^^^ perhaps just
> "block + 1" here? Maybe also add a comment before this call like:

Yes, 'block +1' is better here, i will add a comment.

Thanks for your review.

> 	/* blocks_per_page == 1, hence we need another page for the buddy */
>
> Otherwise the patch looks good!
>
> 								Honza
>
-- 
thanks,
Gou Hao <gouhao@uniontech.com>

