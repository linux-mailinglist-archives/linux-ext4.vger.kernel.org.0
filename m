Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF22A5AC3BD
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Sep 2022 12:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiIDKBW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Sep 2022 06:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDKBV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Sep 2022 06:01:21 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C38140566
        for <linux-ext4@vger.kernel.org>; Sun,  4 Sep 2022 03:01:19 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M277h-1oXGLS2u53-002YNG; Sun, 04 Sep 2022 12:01:07 +0200
Message-ID: <c449eea8-87e4-3f74-5d11-d159eae28c0b@i2se.com>
Date:   Sun, 4 Sep 2022 12:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Content-Language: en-US
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <743489b4-4f9d-3a4d-d87e-e6bf981027c4@i2se.com>
 <20220825091842.fybrfgdzd56xi53i@quack3>
 <0a01dfee-59bf-7a16-6272-683a886e1299@i2se.com>
 <20220826101522.b552tn646qobrjdx@quack3>
 <Ywor0BFVnLYj2bxH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Ywor0BFVnLYj2bxH@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4NVdZeA6gUicw5YbbaVb1+TT67xR4JYw6wXAnP4MqoRi/9bcQnG
 7HbtTmB3ArGBNvBAh/IfcvupQnZDWsHtVm/1LW3XC4ByiGsTHzzZXLRbhNs8ImXbi4spRB5
 Ic/mXAq86ropIJHTU7Sa4OX6x8PombrHoCUnkpNjB9CuQVb+T/7wVPmW+beD4UfFg6jo4+u
 V+9YypEILEsFIotIBbW0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QNZMb3Qjfp4=:ZZPxQkZ0F8tV10BFljM0cz
 G5lS4c4m2l1QmZRIAuJlQs6DJtieByJbSkeKari3mSzPebBlAl1XTtxWUBPWR5UEVELF1CHQ+
 juQtkrmcUDZxxwMEbnmW2961WJJgvL2lMSOnNzk3+t04fxgFBlRg5f5jKJEgllyAYl21XP6VM
 95YF16JV1uAWx8+7GATwkskeV2QVOnWApOYPK77VcUnXS++rvL1/KikEm1PJrrrgmbnlXbUA0
 nzAstKLoUdbVu7DNdQSfp0DH1nwFKAAzvVBtQjRy/l4HFA8/TGXMl2hh7JMZzO1J/P9PZpkov
 xFHN0WHt4TUsgZthPBTarheZce6UPCMLyEN99h0CYSwZw2rx7z42EGirPoRinTYk7/QjMGZIi
 WenXv14D3JY6KP2M5yMwL33QqdDIshtvsmsVY8RFGrhUU+KFgpEc/UcKTL+HP9wPqBHbD2WDG
 Eh0LDwTnkxZf54fmJBfKlwAg4Y21cVhM9gVJARucW32+HiBNR2bkuH84hjLljkjGKPRsZVjl1
 coZ+L8xNo8TprKcv56a7SbXYPd+hhNOKL11INBPPU00U9Q5mqJAid3N//Q0vbKlFYOS/sk+DQ
 FKXBWY5OU7GnY5OiT2GzvL+3yGZcnzkFyfnCnA2eibPUCZ2Xc34pmqVbwsVi1VVRLtxk0sX79
 T1U0PfNRS9slW+jbHfQ9kovqahU2A9EEAXsJ9M8T5ND053iKWYQHP9KgJv1AhYlDCP4Tnrsg0
 ZH28H8nGxAaHNYMUeP6c1RsXO152nJzGYC0W2zUu711mh71miRkrNUWiA5GzT3iJ13i6g344b
 rX/axbp
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Am 27.08.22 um 16:36 schrieb Ojaswin Mujoo:
> On Fri, Aug 26, 2022 at 12:15:22PM +0200, Jan Kara wrote:
>> Hi Stefan,
>>
>> On Thu 25-08-22 18:57:08, Stefan Wahren wrote:
>>>> Perhaps if you just download the archive manually, call sync(1), and measure
>>>> how long it takes to (untar the archive + sync) in mb_optimize_scan=0/1 we
>>>> can see whether plain untar is indeed making the difference or there's
>>>> something else influencing the result as well (I have checked and
>>>> rpi-update does a lot of other deleting & copying as the part of the
>>>> update)? Thanks.
>>> mb_optimize_scan=0 -> almost 5 minutes
>>>
>>> mb_optimize_scan=1 -> almost 18 minutes
>>>
>>> https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f87881687bb654051942923a6b78f16dec
>> Thanks! So now the iostat data indeed looks substantially different.
>>
>> 			nooptimize	optimize
>> Total written		183.6 MB	190.5 MB
>> Time (recorded)		283 s		1040 s
>> Avg write request size	79 KB		41 KB
>>
>> So indeed with mb_optimize_scan=1 we do submit substantially smaller
>> requests on average. So far I'm not sure why that is. Since Ojaswin can
>> reproduce as well, let's see what he can see from block location info.
>> Thanks again for help with debugging this and enjoy your vacation!
>>
> Hi Jan and Stefan,
>
> Apologies for the delay, I was on leave yesterday and couldn't find time to get to this.
>
> So I was able to collect the block numbers using the method you suggested. I converted the
> blocks numbers to BG numbers and plotted that data to visualze the allocation spread. You can
> find them here:
>
> mb-opt=0, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-0-patched.png
> mb-opt=1, patched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-patched.png
> mb-opt=1, unpatched kernel: https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/mbopt-1-unpatched.png
>
> Observations:
> * Before the patched mb_optimize_scan=1 allocations were way more spread out in
>    40 different BGs.
> * With the patch, we still allocate in 36 different BGs but majority happen in
>    just 1 or 2 BGs.
> * With mb_optimize_scan=0, we only allocate in just 7 unique BGs, which could
>    explain why this is faster.

thanks this is very helpful for me to understand. So it seems to me that 
with disabled mb_optimized_scan we have a more sequential write behavior 
and with enabled mb_optimized_scan a more random write behavior.

 From my understanding writing small blocks at random addresses of the 
sd card flash causes a lot of overhead, because the sd card controller 
need to erase huge blocks (up to 1 MB) before it's able to program the 
flash pages. This would explain why this series doesn't fix the 
performance issue, the total amount of BGs is still much higher.

Is this new block allocation pattern a side effect of the optimization 
or desired?

> Also, one strange thing I'm seeing is that the perfs don't really show any
> particular function causing the regression, which is surprising considering
> mb_optimize_scan=1 almost takes 10 times more time.
>
> All the perfs can be found here (raw files and perf report/diff --stdio ):
> https://github.com/OjaswinM/mbopt-bug/tree/master/perfs
>
> Lastly, FWIW I'm not able to replicate the regression when using loop devices
> and mb_optmize_scan=1 performs similar to mb-opmtimize_scan=0 (without patches
> as well). Not sure if this is related to the issue or just some side effect of
> using loop devices.
The regression actually happen in the sd card, but it's triggered 
external by the different IO pattern. For a loop device there is no 
difference between sequential and random write.
>
> Will post here if I have any updates on this.
>
> Regards,
> Ojaswin
