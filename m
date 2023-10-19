Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D877CF819
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjJSMEw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 08:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjJSMEd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 08:04:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2BB19A9;
        Thu, 19 Oct 2023 05:03:43 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SB5s42P5Sz15N5Z;
        Thu, 19 Oct 2023 20:00:56 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 20:03:40 +0800
Message-ID: <4dcff9fa-af8e-52bb-536a-26a2c6fa8bbf@huawei.com>
Date:   Thu, 19 Oct 2023 20:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/4] ext4: reduce unnecessary memory allocation in
 alloc_flex_gd()
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20231018114221.441526-1-libaokun1@huawei.com>
 <20231018114221.441526-5-libaokun1@huawei.com>
 <20231019115719.54wd6q6dxanaodid@quack3>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231019115719.54wd6q6dxanaodid@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/10/19 19:57, Jan Kara wrote:
> On Wed 18-10-23 19:42:21, Baokun Li wrote:
>> When a large flex_bg file system is resized, the number of groups to be
>> added may be small, and a large amount of memory that will not be used will
>> be allocated. Therefore, resize_bg can be set to the size after the number
>> of new_group_data to be used is aligned upwards to the power of 2. This
>> does not affect the disk layout after online resize and saves some memory.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Looks good, just one small comment below. Feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>
>> @@ -248,6 +250,14 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size)
>>   	else
>>   		flex_gd->resize_bg = flexbg_size;
>>   
>> +	/* Avoid allocating new groups that will not be used. */
> Perhaps make the comment more understandable like:
> 	/* Avoid allocating large 'groups' array if not needed */
>
> 									Honza
Thank you very much for your careful review!
I'll change the comment to this more understandable one in the next version.

Cheers!
-- 
With Best Regards,
Baokun Li
.
