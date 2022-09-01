Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556D5A987C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiIANUz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiIANT4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 09:19:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4CA457;
        Thu,  1 Sep 2022 06:19:07 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJM3c4bkfzkWK6;
        Thu,  1 Sep 2022 21:15:24 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:19:05 +0800
Subject: Re: [PATCH -next] ext4: ensure data forced to disk when rename
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220901062657.1192732-1-yebin10@huawei.com>
 <20220901083706.mjewb45dufzxcfdk@quack3>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <ce8666e2-c224-79f9-7770-f87b31d122e3@huawei.com>
Date:   Thu, 1 Sep 2022 21:19:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220901083706.mjewb45dufzxcfdk@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/9/1 16:37, Jan Kara wrote:
> On Thu 01-09-22 14:26:57, Ye Bin wrote:
>> There is issue that data lost when rename new file. Reason is dioread_nolock is
>> enabled default now, which map blocks will mark extent unwritten. But inode
>> size is changed after submit io. Then read file will return zero if extent is
>> unwritten.
>> To solve above isuue, wait all data force to disk before rename when enable
>> dioread_nolock and enable delay allocate.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> 
> Well, but it was always like that. We do not guarantee that the data is
> securely on disk before rename - userspace is responsible for that if it
> needs this guarantee. We just want to make the time window shorter and so
> start data writeback because lot of userspace is careless. But waiting for
> data writeback before rename will significantly slow down some workloads
> and IMHO without a good reason.
> 

Hi, Jan

Our case is modifing a no-empty file names "data.conf" through vim, it will
cp "data.conf" to ".data.conf.swp" firstly, overwrite rename ".data.conf.swp"
back to "data.conf" and fsync after modifying. If we power down between rename
and fsync, we may lose all data in the original "data.conf" and get a whole
zero file. Before we enable dioread_nolock by defalut, the newly appending data
may lost, but at least we will not lose the original data in the default
data=ordered and auto_da_alloc mode. It seems that dioread_nolock breaks the
guarantee provide by auto_da_alloc. Maybe we should add a fsync before rename
in vim ?

Thanks,
Yi.
