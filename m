Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA356CF960
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 05:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC3DAi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 23:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC3DAh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 23:00:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB32111
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 20:00:36 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pn7PT3jGHz17Pxv;
        Thu, 30 Mar 2023 10:57:17 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:00:33 +0800
Message-ID: <84290f85-9f93-0e24-c948-5b7e572a24e4@huawei.com>
Date:   Thu, 30 Mar 2023 11:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] e2fsck: add sync error handle to e2fsck.
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>,
        <liuzhiqiang26@huawei.com>
References: <20230325065652.2111384-1-zhanchengbin1@huawei.com>
 <20230325065652.2111384-3-zhanchengbin1@huawei.com>
 <20230325171318.GA16162@frogsfrogsfrogs>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230325171318.GA16162@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500014.china.huawei.com (7.185.36.63) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thank you for your advice. I will modify patches.
  - bin.

On 2023/3/26 1:13, Darrick J. Wong wrote:
> On Sat, Mar 25, 2023 at 02:56:52PM +0800, zhanchengbin wrote:
>> If fsync fails during fsck, it is silent and users will not perceive it, so
>> a function to handle fsync failure should be added to fsck.
>>
>> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>> ---
>>   e2fsck/ehandler.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/e2fsck/ehandler.c b/e2fsck/ehandler.c
>> index 71ca301c..ae35f3ef 100644
>> --- a/e2fsck/ehandler.c
>> +++ b/e2fsck/ehandler.c
>> @@ -118,6 +118,29 @@ static errcode_t e2fsck_handle_write_error(io_channel channel,
>>   	return error;
>>   }
>>   
>> +static errcode_t e2fsck_handle_sync_error(io_channel channel,
>> +                                            errcode_t error)
>> +{
>> +	ext2_filsys fs = (ext2_filsys) channel->app_data;
>> +	e2fsck_t ctx;
>> +
>> +	ctx = (e2fsck_t) fs->priv_data;
>> +	if (ctx->flags & E2F_FLAG_EXITING)
>> +		return 0;
>> +	
> 
> Nit: ^^^ unnecessary indentation
> 
>> +	if (operation)
>> +		printf(_("Error sync (%s) while %s.  "),
> 
> I think we should be more explicit that *fsync* failed:
> 
> "Error during fsync of dirty metadata while %s: %s",
> 	operation, error_message(...)?
> 
> 
>> +		       error_message(error), operation);
>> +	else
>> +		printf(_("Error sync (%s).  "),
>> +		       error_message(error));
>> +	preenhalt(ctx);
>> +	if (ask(ctx, _("Ignore error"), 1))
> 
> ask_yn()?
> 
> Not sure what we're asking about here, or what happens if you answer NO?
> Unless we're using a redo file, dirty metadata flush has failed so we
> might as well keep going, right?
> 
> --D
> 
>> +		return 0;
>> +
>> +	return error;
>> +}
>> +
>>   const char *ehandler_operation(const char *op)
>>   {
>>   	const char *ret = operation;
>> @@ -130,4 +153,5 @@ void ehandler_init(io_channel channel)
>>   {
>>   	channel->read_error = e2fsck_handle_read_error;
>>   	channel->write_error = e2fsck_handle_write_error;
>> +	channel->sync_error = e2fsck_handle_sync_error;
>>   }
>> -- 
>> 2.31.1
>>
> .
> 
