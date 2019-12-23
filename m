Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE11290BF
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Dec 2019 02:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLWBo2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Dec 2019 20:44:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfLWBo2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Dec 2019 20:44:28 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 19DACDF0720E361061CF;
        Mon, 23 Dec 2019 09:44:25 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Dec 2019
 09:44:23 +0800
Subject: Re: [PATCH v3 3/4] jbd2: make sure ESHUTDOWN to be recorded in the
 journal superblock
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>
CC:     Jan Kara <jack@suse.cz>, <jack@suse.com>,
        <adilger.kernel@dilger.ca>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
 <20191204124614.45424-4-yi.zhang@huawei.com>
 <20191204170528.GH8206@quack2.suse.cz>
 <1f8eb86e-53c0-a547-a1e5-b7411d36ac3e@huawei.com>
Message-ID: <fd16226f-d759-8998-6de7-4b4a7f1a6596@huawei.com>
Date:   Mon, 23 Dec 2019 09:44:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1f8eb86e-53c0-a547-a1e5-b7411d36ac3e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/12/5 9:23, zhangyi (F) wrote:
> On 2019/12/5 1:05, Jan Kara wrote:
>> On Wed 04-12-19 20:46:13, zhangyi (F) wrote:
>>> Commit fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer") want
>>> to allow jbd2 layer to distinguish shutdown journal abort from other
>>> error cases. So the ESHUTDOWN should be taken precedence over any other
>>> errno which has already been recoded after EXT4_FLAGS_SHUTDOWN is set,
>>> but it only update errno in the journal suoerblock now if the old errno
>>> is 0.
>>>
>>> Fixes: fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer")
>>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>>
>> Yeah, I think this is correct if I understand the logic correctly but I'd
>> like Ted to have a look at this. Anyway, feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
> 
> Thanks for review.
> 
> Hi Ted, do you have time to look at this patch?
> 

Genteel ping.

Thanks,
Yi.

