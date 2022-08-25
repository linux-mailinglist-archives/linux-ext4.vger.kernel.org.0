Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8155D5A174D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Aug 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiHYQ5Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Aug 2022 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiHYQ5W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Aug 2022 12:57:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB28B028A
        for <linux-ext4@vger.kernel.org>; Thu, 25 Aug 2022 09:57:21 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrOq7-1pBa8Q24Rj-00oW0M; Thu, 25 Aug 2022 18:57:09 +0200
Message-ID: <0a01dfee-59bf-7a16-6272-683a886e1299@i2se.com>
Date:   Thu, 25 Aug 2022 18:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20220823134508.27854-1-jack@suse.cz>
 <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
 <20220824104010.4qvw46zmf42te53n@quack3>
 <743489b4-4f9d-3a4d-d87e-e6bf981027c4@i2se.com>
 <20220825091842.fybrfgdzd56xi53i@quack3>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220825091842.fybrfgdzd56xi53i@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FixAXPqKDvSoAQ+eJ0RZbsqImZgHDBbhTuxA5t9qrqkyTCduHBA
 YU0Mx3fubYVR1LUQ8kVZ2OdVKttOdUJ9hd1Lw9nw4Nt/2qZTrX+LZInxbiCNSzC+DtqIMyc
 WFab2zmoH7HwD2rP3j6JUm7ODChLw41F7XAaED5zZ8jAH1XJ4FwB0bobUlwAlCQ9sLEL9ys
 V2xmiX7f/5+EapeEgHxVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3FTU1Qt1qr8=:Hmal0FvZQuR+PnOtzSJ9//
 +/K3LZ4Shwc+6KrKXn1Sh5Usm/gujSmek4eX7sWuJ7S0BsmglEubruCsR1AkE3AqNorq92+m5
 +ovgPB5vxU8tlGah26RkAsM7mt3JhxnuOXt5g1X/noKx3yD8Mf+nKsXMv7RwNuEfcAJCtBMDZ
 jN57HiZwPasmqb0WmmwsN70HmtfRj6dzMSGQwwH1nWq32j+Zl8PIM272gs6x+tIzc9JofHzIE
 n56GqO7l07pDLVYswg5ztcXPW9cim+qDPa1sbWPC7Oqd1LWcsv4+0mWdaEqTYO/4nKiNe213v
 2fscp4K1VIrPfnukeM8L5NrGQbZrbIxXF7EYcZFlwOIJ3RgmC9iqvIJPWHsWd/vGn3/pK0UaZ
 LBUaB6QbR1XrtazY75v5dsFtZViFe2z6LtXa1UajrOdLLDzOx8gpn+5Kpx67efRa0Smk5gVYH
 qWVd7uBePBOpCmSnYWAIBO5XEtvSzQCK/2ShTjK2z67e5/Sg1TInx6p44G7tCAks5ZahSpwMl
 4Yzc9th6Ab1+nyP4jvlNRh8hGII5c0FyzrsOrt6uxZ/pl260LFlTwcpwHcOgPLX1S0TP2kJjX
 R4WRIopG3GwONcwtE059Cl/QzsRVxm5/nzk/z/aOsdAX/gOkPojUQIiv9NU7T3vG47jgoqRA8
 hwGtUNQWxQdJrxnyB1R9BtZsIv93KmOl/qT5xUKXgqtBp0Gr16tWIQNwQnXfFtTSb3SQvlBAV
 xS2KHv2Wq7DbHl0eEE/lGSKQS9V8Ttid8mEIMvzUgKLN7UX2jWZ73T3stUk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Am 25.08.22 um 11:18 schrieb Jan Kara:
> Hi Stefan!
>
> On Wed 24-08-22 23:24:43, Stefan Wahren wrote:
>> Am 24.08.22 um 12:40 schrieb Jan Kara:
>>> Hi Stefan!
>>>
>>> On Wed 24-08-22 12:17:14, Stefan Wahren wrote:
>>>> Am 23.08.22 um 22:15 schrieb Jan Kara:
>>>>> Hello,
>>>>>
>>>>> So I have implemented mballoc improvements to avoid spreading allocations
>>>>> even with mb_optimize_scan=1. It fixes the performance regression I was able
>>>>> to reproduce with reaim on my test machine:
>>>>>
>>>>>                         mb_optimize_scan=0     mb_optimize_scan=1     patched
>>>>> Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
>>>>> Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
>>>>> Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
>>>>> Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
>>>>> Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
>>>>> Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
>>>>> Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
>>>>> Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
>>>>> Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
>>>>>
>>>>> Stefan, can you please test whether these patches fix the problem for you as
>>>>> well? Comments & review welcome.
>>>> i tested the whole series against 5.19 and 6.0.0-rc2. In both cases the
>>>> update process succeed which is a improvement, but the download + unpack
>>>> duration ( ~ 7 minutes ) is not as good as with mb_optimize_scan=0 ( ~ 1
>>>> minute ).
>>> OK, thanks for testing! I'll try to check specifically untar whether I can
>>> still see some differences in the IO pattern on my test machine.
>> i made two iostat output logs during the complete download phase with 5.19
>> and your series applied. iostat was running via ssh connection and
>> rpi-update via serial console.
>>
>> First with mb_optimize_scan=0
>>
>> https://github.com/lategoodbye/mb_optimize_scan_regress/blob/main/5.19_SDCIT_patch_nooptimize_download_success.iostat.log
>>
>> Second with mb_optimize_scan=1
>>
>> https://github.com/lategoodbye/mb_optimize_scan_regress/blob/main/5.19_SDCIT_patch_optimize_download_success.iostat.log
>>
>> Maybe this helps
> Thanks for the data! So this is interesting. In both iostat logs, there is
> initial phase where no IO happens. I guess that's expected. It is
> significantly longer in the mb_optimize_scan=0 but I suppose that is just
> caused by a difference in when iostat was actually started. Then in
> mb_optimize_scan=0 there is 155 seconds where the eMMC card is 100%
> utilized and then iostat ends. During this time ~63MB is written
> altogether. Request sizes vary a lot, average is 60KB.
>
> In mb_optimize_scan=1 case there is 715 seconds recorded where eMMC card is
> 100% utilized. During this time ~133MB is written, average request size is
> 40KB. If I look just at first 155 seconds of the trace (assuming iostat was
> in both cases terminated before writing was fully done), we have written
> ~53MB and average request size is 56KB.
>
> So with mb_optimize_scan=1 we are indeed still somewhat slower but based on
> the trace it is not clear why the download+unpack should take 7 minutes
> instead of 1 minute. There must be some other effect we are missing.
>
> Perhaps if you just download the archive manually, call sync(1), and measure
> how long it takes to (untar the archive + sync) in mb_optimize_scan=0/1 we
> can see whether plain untar is indeed making the difference or there's
> something else influencing the result as well (I have checked and
> rpi-update does a lot of other deleting & copying as the part of the
> update)? Thanks.

mb_optimize_scan=0 -> almost 5 minutes

mb_optimize_scan=1 -> almost 18 minutes

https://github.com/lategoodbye/mb_optimize_scan_regress/commit/3f3fe8f87881687bb654051942923a6b78f16dec

>
> 								Honza
