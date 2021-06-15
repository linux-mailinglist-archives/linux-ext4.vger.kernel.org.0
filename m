Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB13A7D1E
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jun 2021 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFOL3d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Jun 2021 07:29:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4915 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFOL3d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Jun 2021 07:29:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G45Yv0LnTz705r;
        Tue, 15 Jun 2021 19:24:19 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 19:27:27 +0800
Received: from [127.0.0.1] (10.174.177.249) by dggema765-chm.china.huawei.com
 (10.1.198.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 19:27:27 +0800
Subject: Re: [PATCH V2 00/12] e2fsprogs: some bugfixs and some code cleanups
To:     Theodore Ts'o <tytso@mit.edu>, Wu Guanghao <wuguanghao3@huawei.com>
CC:     <linux-ext4@vger.kernel.org>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, <linfeilong@huawei.com>
References: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
 <YLRl/tFB4rakYJ7q@mit.edu>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <c10ba297-c98c-5d9b-b022-5614a6986589@huawei.com>
Date:   Tue, 15 Jun 2021 19:27:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YLRl/tFB4rakYJ7q@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

friendly ping...

What is the current status of the patch set？


On 2021/5/31 12:28, Theodore Ts'o wrote:
> On Mon, May 31, 2021 at 09:23:49AM +0800, Wu Guanghao wrote:
>> V1 -> V2:
>>
>> [PATCH V2 03/12] zap_sector: fix memory leak
>> 	free and return operators placed in {} block
>>
>> [PATCH V2 04/12] ss_add_info_dir: fix memory leak and check whether,NULL pointer
>> 	modified "=" to "=="
>>
>> [PATCH V2 06/12] append_pathname: check the value returned by realloc to avoid segfault
>> [PATCH V2 07/12] argv_parse: check return value of malloc in argv_parse()
>> 	Fix typos
>>
>> [PATCH V2 10/12] hashmap: change return value type of, ext2fs_hashmap_add()
>> 	remove "new_block = NULL;"
> Did you only send the patches that you changed, and didn't resend the
> patches that didn't change between V1 and V2?
>
> It's actually better if you resend the whole series in the future.
>
> Thanks,
>
> 					- Ted
>
> .

