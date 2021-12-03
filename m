Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C98466F0E
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbhLCBWK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Dec 2021 20:22:10 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29148 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349900AbhLCBWJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Dec 2021 20:22:09 -0500
Received: from kwepemi100010.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J4vzx0hWzzXdTc;
        Fri,  3 Dec 2021 09:16:45 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100010.china.huawei.com (7.221.188.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 3 Dec 2021 09:18:45 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 3 Dec
 2021 09:18:44 +0800
Subject: Re: [PATCH 0/6] solve memory leak and check whether NULL pointer
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        zhanchengbin <zhanchengbin1@huawei.com>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>
References: <c96e1895-1b89-cdac-0239-a84b8a3ffc3e@huawei.com>
 <YajeBKHX3eZFz63z@mit.edu>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <4b608d9d-074d-9801-53fc-df9d62ab3e6f@huawei.com>
Date:   Fri, 3 Dec 2021 09:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YajeBKHX3eZFz63z@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry for that, we will resend the patch series.

On 2021/12/2 22:53, Theodore Y. Ts'o wrote:
> On Thu, Dec 02, 2021 at 07:26:25PM +0800, zhanchengbin wrote:
>> Solve the memory leak of the abnormal branch and the new null pointer check
>>
>> zhanchengbin (6):
>>   alloc_string : String structure consistency
>>   ss_execute_command : Check whether the pointer is not null before it
>>     is referenced.
>>   quota_set_sb_inum : Check whether the pointer is not null  before it
>>     is referenced.
>>   badblock_list memory leak
>>   ldesc Non-empty judgment
>>   io->name memory leak
> The cover letter for the patch series arrived, but none of the patches
> associated with it did.  Could you resend?
>
> Thanks,
>
> 					- Ted
>
> .

