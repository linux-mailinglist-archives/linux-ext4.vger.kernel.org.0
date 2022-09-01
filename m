Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0AA5A9160
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiIAH6X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 03:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiIAH6R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 03:58:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29971E9AB9
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 00:58:14 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJCwW3jRbzYcmw;
        Thu,  1 Sep 2022 15:53:47 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 15:58:11 +0800
Subject: Re: [PATCH 09/13] ext4: factor out ext4_compat_feature_check()
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-10-yanaijie@huawei.com>
 <20220831115517.qolsk27xh5djei7h@quack3>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <ed5fb099-cced-ad7e-aea3-6804e77cb67b@huawei.com>
Date:   Thu, 1 Sep 2022 15:58:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220831115517.qolsk27xh5djei7h@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2022/8/31 19:55, Jan Kara wrote:
> On Tue 30-08-22 20:04:07, Jason Yan wrote:
>> Factor out ext4_compat_feature_check(). No functional change.
>>
>> Signed-off-by: Jason Yan<yanaijie@huawei.com>
>> ---
>>   fs/ext4/super.c | 144 ++++++++++++++++++++++++++----------------------
>>   1 file changed, 77 insertions(+), 67 deletions(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 96cf23787bba..1e7d6eb6a3aa 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4607,6 +4607,82 @@ static int ext4_handle_csum(struct super_block *sb, struct ext4_super_block *es)
>>   	return 0;
>>   }
>>   
>> +static int ext4_compat_feature_check(struct super_block *sb,
>> +				     struct ext4_super_block *es,
>> +				     int silent)
> And here maybe ext4_check_feature_compatibility() might be a better name
> because "compat_feature" is a name of a specific subset of ext4 features so
> using it in function name is a bit confusing. Otherwise feel free to add:
> 

Indeed.

Thanks.

> Reviewed-by: Jan Kara<jack@suse.cz>
