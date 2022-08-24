Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF96D5A0347
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Aug 2022 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiHXVZG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Aug 2022 17:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiHXVZC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Aug 2022 17:25:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4AA654F
        for <linux-ext4@vger.kernel.org>; Wed, 24 Aug 2022 14:24:56 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MBUuP-1oacmR2YiF-00CvRz; Wed, 24 Aug 2022 23:24:44 +0200
Message-ID: <743489b4-4f9d-3a4d-d87e-e6bf981027c4@i2se.com>
Date:   Wed, 24 Aug 2022 23:24:43 +0200
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
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220824104010.4qvw46zmf42te53n@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dwJA5vJXaei6pSgfxRo6KS6mplk2oiIeVjkvqP758xD/9sHt9Dc
 4MYM5i9Gt0dGLPfH87lPqQ+E+mKT/vdWO24i9KPOPTS4cCtI57I9l/cCYMl6GRRiqWktUcd
 wT7Iz7CQp0wDEaQZM4OPDxEvwX+40iy2G1zy5c8akm0C0zcY6hp+NRFlYjX1w+HtPK6waEf
 D+MN/nc/99+7j0rdkY2HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6PGHvSEJpE=:mN8PnTSFN8Y+Y0nvWHVEPt
 HGML+lOEn+7qiFQ5QqV9sch7yRO5ZZxLbUkwWSLmEHGbh57QwGURJ/yB+HjwmLVIisbyG755N
 uroXxU6jITe4JAJeiAYB/KSpl7QWikvoOhY3Qyj6Bjr4dWT3b99J4Q8O7kIANpA/DFEeH4Fsm
 /vOQwN9R23tLbZM0D9JwOe8jCPvTRvTkl5/PlFq/07K+9Wrr1E7xyipMG2z3CHLTBdioAJKO5
 f+J4ahV12cknoLjPsK+bw1Ntx3Si2ZwzH4FqObQSztshWe95gKsEQno1xBkHFUKq+ZYTSmbrK
 aqJkLVVpv0hQxNoR0zoxE5vokYLHoO7D4iFYg8Yq0A8/kNpFLu5rGo/u54huD3hIPF8fGi+aE
 KFVbt7A6eoxCidlQVLWIEp8Hc+6iPmqsjv+ntOprRgAkCb8B6Ko+JwTdIGpG9CM1+SsuOhJO0
 RmHatKd8xyOe+U2riVyfPCia5vDQZ9lILehvpnWnvO0CT/w06IFihIJFG7UYO9zWLtKMtGFDP
 kbX279lryKMIVFB4FNF6D733gH3bKcEEJfmPAyucmjUV6rrYh4NWcZ4/IyYgpdSWd2hLJIDdq
 iE3Vodp379kv5WvWQa+JPz74wZJlDSjZuJV3hT5RwiSxVrFLh3SViMPIkWQrqaMt8KT1Gh5aM
 cKQSv9KyoUdFkfNtR8j+AXOqyjCM7iytgjcgHLsV5FvnxijARbBh3N0M3PxQHlhYgrfv5I+CP
 YYM+h4s/n4FDCONfwm4wCt54cHz9YBu6DKvZNJxEtF7U5M1vr3fU5zvuMNc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Am 24.08.22 um 12:40 schrieb Jan Kara:
> Hi Stefan!
>
> On Wed 24-08-22 12:17:14, Stefan Wahren wrote:
>> Am 23.08.22 um 22:15 schrieb Jan Kara:
>>> Hello,
>>>
>>> So I have implemented mballoc improvements to avoid spreading allocations
>>> even with mb_optimize_scan=1. It fixes the performance regression I was able
>>> to reproduce with reaim on my test machine:
>>>
>>>                        mb_optimize_scan=0     mb_optimize_scan=1     patched
>>> Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
>>> Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
>>> Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
>>> Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
>>> Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
>>> Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
>>> Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
>>> Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
>>> Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
>>>
>>> Stefan, can you please test whether these patches fix the problem for you as
>>> well? Comments & review welcome.
>> i tested the whole series against 5.19 and 6.0.0-rc2. In both cases the
>> update process succeed which is a improvement, but the download + unpack
>> duration ( ~ 7 minutes ) is not as good as with mb_optimize_scan=0 ( ~ 1
>> minute ).
> OK, thanks for testing! I'll try to check specifically untar whether I can
> still see some differences in the IO pattern on my test machine.

i made two iostat output logs during the complete download phase with 
5.19 and your series applied. iostat was running via ssh connection and 
rpi-update via serial console.

First with mb_optimize_scan=0

https://github.com/lategoodbye/mb_optimize_scan_regress/blob/main/5.19_SDCIT_patch_nooptimize_download_success.iostat.log

Second with mb_optimize_scan=1

https://github.com/lategoodbye/mb_optimize_scan_regress/blob/main/5.19_SDCIT_patch_optimize_download_success.iostat.log

Maybe this helps

>
>> Unfortuntately i don't have much time this week and next week i'm in
>> holidays.
> No problem.
>
>> Just a question, my tests always had MBCACHE=y . Is it possible that the
>> mb_optimize_scan is counterproductive for MBCACHE in this case?
> MBCACHE (despite similar name) is actually related to extended attributes
> so it likely has no impact on your workload.
>
>> I'm asking because before the download the update script removes the files
>> from the previous update process which already cause a high load.
> Do you mean already the removal step is noticeably slower with
> mb_optimize_scan=1? The removal will be modifying directory blocks, inode
> table blocks, block & inode bitmaps, and group descriptors. So if block
> allocations are more spread (due to mb_optimize_scan=1 used during the
> untar), the removal may also take somewhat longer.
Not sure about this, maybe we should concentrate on download / untar phase.
> 								Honza
