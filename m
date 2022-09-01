Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597085A90BE
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiIAHm5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 03:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiIAHms (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 03:42:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C5C1090AC
        for <linux-ext4@vger.kernel.org>; Thu,  1 Sep 2022 00:42:38 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJCZX0YNLzYcnx;
        Thu,  1 Sep 2022 15:38:12 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm500004.china.huawei.com (7.192.104.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 15:42:36 +0800
Subject: Re: [PATCH 02/13] ext4: remove cantfind_ext4 error handler
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
 <20220830120411.2371968-3-yanaijie@huawei.com>
 <20220831114155.6eilxulqisq7zg2j@quack3>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <aa39f223-cc1a-eaa0-34a9-29a3ec2491ef@huawei.com>
Date:   Thu, 1 Sep 2022 15:42:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220831114155.6eilxulqisq7zg2j@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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


On 2022/8/31 19:41, Jan Kara wrote:
> On Tue 30-08-22 20:04:00, Jason Yan wrote:
>> The 'cantfind_ext4' error handler is just a error msg print and then
>> goto failed_mount. This two level goto makes the code complex and not
>> easy to read. The only benefit is that is saves a little bit code.
>> However some branches can merge and some branches dot not even need it.
>> So do some refactor and remove it.
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> Yeah, probably makes sense. Just small style nits below. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> @@ -4798,8 +4800,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>   	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
>>   
>>   	sbi->s_inodes_per_block = blocksize / EXT4_INODE_SIZE(sb);
>> -	if (sbi->s_inodes_per_block == 0)
>> -		goto cantfind_ext4;
>> +	if (sbi->s_inodes_per_block == 0 || (EXT4_BLOCKS_PER_GROUP(sb) == 0)) {
> 
> I'd write this as:
> 
> 	if (sbi->s_inodes_per_block == 0 || sbi->s_blocks_per_group == 0) {
> 
> to avoid superfluous braces and make the code a bit more natural.
> 
> 									Honza


Good suggestion. Will update.

Thanks.

