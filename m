Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03560C23D
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Oct 2022 05:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJYD1G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Oct 2022 23:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJYD1F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Oct 2022 23:27:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CB58F258
        for <linux-ext4@vger.kernel.org>; Mon, 24 Oct 2022 20:27:04 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxHLB5G16zmVKY;
        Tue, 25 Oct 2022 11:22:10 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:27:01 +0800
Subject: Re: [PATCH] ext4: fix wrong return err in
 ext4_load_and_init_journal()
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
References: <20221022130739.2515834-1-yanaijie@huawei.com>
 <20221024152946.gafegxwrv5i5djvn@quack3>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <8b2e325c-057b-3287-c38e-0ca5b936d4db@huawei.com>
Date:   Tue, 25 Oct 2022 11:27:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221024152946.gafegxwrv5i5djvn@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2022/10/24 23:29, Jan Kara wrote:
> On Sat 22-10-22 21:07:39, Jason Yan wrote:
>> The return value is wrong in ext4_load_and_init_journal(). The local
>> variable 'err' need to be initialized before goto out. The original code
>> in __ext4_fill_super() is fine because it has two return values 'ret'
>> and 'err' and 'ret' is initialized as -EINVAL. After we factor out
>> ext4_load_and_init_journal(), this code is broken. So fix it by directly
>> returning -EINVAL in the error handler path.
>>
>> Fixes: 9c1dd22d7422 (ext4: factor out ext4_load_and_init_journal())
> 
> We format the tag usually as:
> 
> Fixes: 9c1dd22d7422 ("ext4: factor out ext4_load_and_init_journal()")
> 

Oh, sorry I didn't notice it. Thank you so much.

I generate this tag by the following script:

#cat .gitconfig
  [alias]
          fixes = log --abbrev=12 -1 --format='Fixes: %h ("%s")'


#git fixes 9c1dd22d742249cfae7bbf3680a7c188d194d3ce
Fixes: 9c1dd22d7422 (ext4: factor out ext4_load_and_init_journal())

This works fine before but it fails recently. I don't know what makes 
the behavior changed.

However if I directly call the whole command:
#git log --abbrev=12 -1 --format='Fixes: %h ("%s")' 9c1dd22d742249cfae
Fixes: 9c1dd22d7422 ("ext4: factor out ext4_load_and_init_journal()")

It works fine.

>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> Otherwise the patch looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Thanks.

> 								Honza
> 
>> ---
>>   fs/ext4/super.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 989365b878a6..89c6bad28a8a 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4885,7 +4885,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>>   	flush_work(&sbi->s_error_work);
>>   	jbd2_journal_destroy(sbi->s_journal);
>>   	sbi->s_journal = NULL;
>> -	return err;
>> +	return -EINVAL;
>>   }
>>   
>>   static int ext4_journal_data_mode_check(struct super_block *sb)
>> -- 
>> 2.31.1
>>
