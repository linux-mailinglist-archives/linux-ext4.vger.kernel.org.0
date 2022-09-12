Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9205B52AC
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 04:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiILCaT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Sep 2022 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiILCaS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Sep 2022 22:30:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8ED21E37
        for <linux-ext4@vger.kernel.org>; Sun, 11 Sep 2022 19:30:17 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MQr7c53z9zlVpZ;
        Mon, 12 Sep 2022 10:26:20 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 10:30:15 +0800
Subject: Re: [PATCH v2 07/13] ext4: factor out ext4_encoding_init()
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <lczerner@redhat.com>, <linux-ext4@vger.kernel.org>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-8-yanaijie@huawei.com>
 <20220908085625.r3xsfvdgn7ibykt2@riteshh-domain>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <2ef9347c-b7b8-d219-d6bb-3c9fa611506a@huawei.com>
Date:   Mon, 12 Sep 2022 10:30:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220908085625.r3xsfvdgn7ibykt2@riteshh-domain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2022/9/8 16:56, Ritesh Harjani (IBM) wrote:
> On 22/09/03 11:01AM, Jason Yan wrote:
>> Factor out ext4_encoding_init(). No functional change.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> ---
>>   fs/ext4/super.c | 80 +++++++++++++++++++++++++++----------------------
>>   1 file changed, 44 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index f8806226b796..67972b0218c0 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4521,6 +4521,48 @@ static int ext4_inode_info_init(struct super_block *sb,
>>   	return 0;
>>   }
>>   
>> +static int ext4_encoding_init(struct super_block *sb, struct ext4_super_block *es)
>> +{
>> +#if IS_ENABLED(CONFIG_UNICODE)
> 
> How about simplying it like below.
> 		if (!IS_ENABLED(CONFIG_UNICODE))
> 			return 0;
> 	
> 		<...>	
> 
> Then we don't need #ifdef CONFIG_UNICODE
> 

Nice idea. Will update.

Thanks
Jason
