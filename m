Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EADA93956F7
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhEaIa7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 May 2021 04:30:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3478 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEaIaj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 May 2021 04:30:39 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FtpKM4Ft1zYq8h;
        Mon, 31 May 2021 16:26:15 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 16:28:58 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 16:28:58 +0800
Subject: Re: [PATCH V2 00/12] e2fsprogs: some bugfixs and some code cleanups
To:     <tytso@mit.edu>
References: <YLRl/tFB4rakYJ7q@mit.edu>
 <e4df8d8a-a5b2-a3cf-7e0d-c5dceb3b39f9@huawei.com>
From:   Wu Guanghao <wuguanghao3@huawei.com>
CC:     <linux-ext4@vger.kernel.org>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
Message-ID: <57045838-ae1a-d1d9-23ef-8977a4accc17@huawei.com>
Date:   Mon, 31 May 2021 16:28:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <e4df8d8a-a5b2-a3cf-7e0d-c5dceb3b39f9@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ted,

Thank you for your advice, I will pay attention to it in the future.
Do I need to resend the series of patches
or continue to send the remaining patches this time?

Thanks,
Wu Guanghao

On Mon, 31 May 2021 00:28:46 -0400, Theodore Ts'o wrote:
> 
> 
> 
> On Mon, May 31, 2021 at 09:23:49AM +0800, Wu Guanghao wrote:
>> V1 -> V2:
>>
>> [PATCH V2 03/12] zap_sector: fix memory leak
>>     free and return operators placed in {} block
>>
>> [PATCH V2 04/12] ss_add_info_dir: fix memory leak and check whether,NULL pointer
>>     modified "=" to "=="
>>
>> [PATCH V2 06/12] append_pathname: check the value returned by realloc to avoid segfault
>> [PATCH V2 07/12] argv_parse: check return value of malloc in argv_parse()
>>     Fix typos
>>
>> [PATCH V2 10/12] hashmap: change return value type of, ext2fs_hashmap_add()
>>     remove "new_block = NULL;"
> 
> Did you only send the patches that you changed, and didn't resend the
> patches that didn't change between V1 and V2?
> 
> It's actually better if you resend the whole series in the future.
> 
> Thanks,
> 
>                     - Ted
> .
> .
