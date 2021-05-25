Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EAC38F7FE
	for <lists+linux-ext4@lfdr.de>; Tue, 25 May 2021 04:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEYCSS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 May 2021 22:18:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5766 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhEYCSR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 May 2021 22:18:17 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpyKg6yGWzlY9D
        for <linux-ext4@vger.kernel.org>; Tue, 25 May 2021 10:13:11 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:16:46 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 10:16:45 +0800
Subject: Re: [PATCH 03/12] zap_sector: fix memory leak
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>
References: <266bc52e-e279-ce84-0e1f-1405b9bc6174@huawei.com>
 <8ea5c607-54cc-ccaf-3e4b-ee2af0160a0b@huawei.com>
 <E51F98C9-49F5-45B2-9B2C-4FC309B5C8AB@gmail.com>
From:   Wu Guanghao <wuguanghao3@huawei.com>
Message-ID: <1fe6c10b-9bc0-ebd6-e69f-8ad69797e780@huawei.com>
Date:   Tue, 25 May 2021 10:16:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <E51F98C9-49F5-45B2-9B2C-4FC309B5C8AB@gmail.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thank you for your comments, I will modify it in the v2 version.

Best regards
Wu Guanghao

ÔÚ 2021/5/24 22:40, §¢§Ý§Ñ§Ô§à§Õ§Ñ§â§Ö§ß§Ü§à §¡§â§ä§×§Þ Ð´µÀ:
> Hello Wu,
> 
> Thank you for the fixes.
> 
> It looks like free and return operators should be placed in {} block.
> 
> {
> 	free(buf);
>  	return;
> }
> 
> Now function returns any time block is read successfully.
> 
> Also, this patch can not be applied cleanly to the master HEAD because of wrong offsets. Please rebase.
> 
> Best regards,
> Artem Blagodarenko.
> 
>> On 24 May 2021, at 14:20, Wu Guanghao <wuguanghao3@huawei.com> wrote:
>>
>> In zap_sector(), need free buf before return,
>> otherwise it will cause memory leak.
>>
>> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> Reviewed-by: Wu Bo <wubo40@huawei.com>
>> ---
>> misc/mke2fs.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
>> index afbcf486..94f81da9 100644
>> --- a/misc/mke2fs.c
>> +++ b/misc/mke2fs.c
>> @@ -586,6 +586,7 @@ static void zap_sector(ext2_filsys fs, int sect, int nsect)
>> 			magic = (unsigned int *) (buf + BSD_LABEL_OFFSET);
>> 			if ((*magic == BSD_DISKMAGIC) ||
>> 				(*magic == BSD_MAGICDISK))
>> +				free(buf);
>> 				return;
>> 		}
>> 	}
>> -- 
> 
> .
> 
