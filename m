Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE061325B37
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 02:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBZBTw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 20:19:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12208 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBZBTs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 20:19:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmsFR5r6LzlPM1;
        Fri, 26 Feb 2021 09:16:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.117) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Feb 2021
 09:18:54 +0800
Subject: Re: [PATCH] debugfs: fix memory leak problem in read_list()
To:     Theodore Ts'o <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>,
        "lijinlin (A)" <lijinlin3@huawei.com>
References: <c6fb0951-a472-dbb4-1970-fe9cece5d182@huawei.com>
 <CAD+ocbwkQ4rMYhiOm4msnBH65vh6Pm25ZkPsC2pD0sFy68bPgA@mail.gmail.com>
 <YDfYC+xUal5EdibL@mit.edu>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <7a877f93-2500-b2f4-cf8e-971503ba54c6@huawei.com>
Date:   Fri, 26 Feb 2021 09:18:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YDfYC+xUal5EdibL@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thank you and harshad shirwadkar.

On 2021/2/26 1:02, Theodore Ts'o wrote:
> On Thu, Feb 25, 2021 at 07:51:09AM -0800, harshad shirwadkar wrote:
>> On Sat, Feb 20, 2021 at 12:41 AM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
>>>
>>>
>>> In read_list func, if strtoull() fails in while loop,
>>> we will return the error code directly. Then, memory of
>>> variable lst will be leaked without setting to *list.
>>>
>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>> Signed-off-by: linfeilong <linfeilong@huawei.com>
>>> ---
>>>  debugfs/util.c | 12 ++++++++----
>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/debugfs/util.c b/debugfs/util.c
>>> index be6b550e..9e880548 100644
>>> --- a/debugfs/util.c
>>> +++ b/debugfs/util.c
>>> @@ -530,12 +530,16 @@ errcode_t read_list(char *str, blk64_t **list, size_t *len)
>>>
>>>                 errno = 0;
>>>                 y = x = strtoull(tok, &e, 0);
>>> -               if (errno)
>>> -                       return errno;
>>> +               if (errno) {
>>> +                       retval = errno;
>>> +                       break;
>>> +               }
>> Shouldn't we have `goto err;` here instead of break? strtoull failure
>> here indicates that no valid value was found, so instead of returning
>> the allocated memory, we should just free the memory and return error.
> 
> As of commit 462c424500a5 ("debugfs: fix memory allocation failures
> when parsing journal_write arguments") there is no longer the err:
> goto target.  The goal is to move to a model where the caller is
> exclusively responsible for freeing any allocated memory, since if
> realloc() has gotten into the act, the memory pointed to in *list
> would have been freed by realloc().  The fix is to make sure *list is
> updated before we return.  This also allows the caller to have access
> to the list of numbers parsed before we ran into an error.
> 
> So the Zhiqiang's patch is correc, and I will apply it.
> 
>        		  	   	       	 - Ted
> 
> .
> 

