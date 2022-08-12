Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0B59119B
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Aug 2022 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbiHLNe5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Aug 2022 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238971AbiHLNe5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Aug 2022 09:34:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938D9F0DA;
        Fri, 12 Aug 2022 06:34:55 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M44MZ0zStzkWMq;
        Fri, 12 Aug 2022 21:31:38 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 21:34:52 +0800
Message-ID: <515c1447-9ca2-844c-0a89-a698157d14f6@huawei.com>
Date:   Fri, 12 Aug 2022 21:34:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] ext4: fix bug in extents parsing when eh_entries == 0
 and eh_depth > 0
Content-Language: en-US
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <wenqingliu0120@gmail.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, <yebin10@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20220812105347.2251-1-lhenriques@suse.de>
 <e32464ec-4c5b-dcad-cfe3-93727dab5f5b@huawei.com> <YvZTcxF2DdtVEybn@suse.de>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <YvZTcxF2DdtVEybn@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Luís,


On 8/12/2022 9:19 PM, Luís Henriques wrote:
> Hi Baokun!
>
> On Fri, Aug 12, 2022 at 08:50:34PM +0800, Baokun Li wrote:
>> Hi Luís,
> ...
>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>> index 53cfe2c681c4..a5457ac1999c 100644
>>> --- a/fs/ext4/extents.c
>>> +++ b/fs/ext4/extents.c
>>> @@ -460,6 +460,11 @@ static int __ext4_ext_check(const char *function, unsigned int line,
>>>    		error_msg = "invalid eh_entries";
>>>    		goto corrupted;
>>>    	}
>>> +	if (unlikely((le16_to_cpu(eh->eh_entries) == 0) &&
>>> +		     (le16_to_cpu(eh->eh_depth > 0)))) {

le16_to_cpu(eh->eh_depth > 0) It's the wrong position of the parentheses here.

>> The parentheses are misplaced,
> I'm not sure I understand what you mean.  I want to have
>
> 	if (unlikely((CONDITION A) && (CONDITION B))) {
> 		/* ... */
> 	}
>
> so they look correct.  Or is that a matter of style/alignment?  (Which
> checkpatch.pl doesn't complains about, by the way.)
>
>> and le16_to_cpu is not needed here.
> OK, I guess that, since both conditions do a comparison against '0', the
> le16_to_cpu() can be dropped.  And, if the parentheses problem you
> mentioned above is a style problem, dropping it will also solve it because
> that statement will become
>
> 	if (unlikely((eh->eh_entries == 0) && (eh->eh_depth > 0))) {
> 		/* ... */
> 	}

Yeah, but it could be more streamlined here.

The earlier judgment has guaranteed "depth == eh->eh_depth"

> And once again, thanks for your review!
>
> Cheers,

-- 
With Best Regards,
Baokun Li

