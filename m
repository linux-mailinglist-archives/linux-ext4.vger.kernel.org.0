Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438C929FA84
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 02:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgJ3BXo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 21:23:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6708 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJ3BXo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Oct 2020 21:23:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMl2738Gnzkc7m;
        Fri, 30 Oct 2020 09:23:43 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 30 Oct 2020 09:23:38 +0800
Subject: Re: [PATCH] ext4: do not use extent after put_bh
To:     Ritesh Harjani <riteshh@linux.ibm.com>, <adilger@dilger.ca>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>
References: <20201028055617.2569255-1-yangerkun@huawei.com>
 <93d5b1bf-0cf9-a483-ff5d-40a6a9c4b92b@linux.ibm.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <a77ce068-aa0f-77f3-abc4-58c0224757b0@huawei.com>
Date:   Fri, 30 Oct 2020 09:23:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <93d5b1bf-0cf9-a483-ff5d-40a6a9c4b92b@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2020/10/30 0:08, Ritesh Harjani 写道:
> 
> 
> On 10/28/20 11:26 AM, yangerkun wrote:
>> ext4_ext_search_right will read more extent block and call put_bh after
>> we get the information we need. However ret_ex will break this and may
>> cause use-after-free once pagecache has been freed. Fix it by dup the
>> extent we need.
> 
> 
> It would be good if we have a test case to reproduce it. Do you?
> Ideally it should go in fstests, if you have some way to forcefully
> reproduce it/simulate it. Let me know, if needed, I can as well help to
> get those into fstests.

Sorry for that. I found this bug while reading source code. Not with a 
testcase.

And time leave for drop pagecache is so small(time between 
get_implied_cluster_alloc and ext4_ext_search_right in 
ext4_ext_map_blocks, other caller for ext4_ext_search_right won't use 
@ret_ex). It may difficult to reproduce it expect a delay injection.

Thanks,
Kun.

> 
> -ritesh
> .
