Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80B25A161C
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Aug 2022 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiHYPss (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Aug 2022 11:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbiHYPsq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Aug 2022 11:48:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C49B69FC
        for <linux-ext4@vger.kernel.org>; Thu, 25 Aug 2022 08:48:45 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdNTy-1p0InR20My-00ZNb7; Thu, 25 Aug 2022 17:48:33 +0200
Message-ID: <596afc6f-4c54-3269-ac84-36bc266cc898@i2se.com>
Date:   Thu, 25 Aug 2022 17:48:32 +0200
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
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e57VonK/wigfgHprU+z/kMIDLoBGnbfkE+ZnCkBUqa4zSAaufWi
 tW1ZMUXCqmXpzZhMvj8tmHEEx20HzFoto3xeJy95MDOEIO0iaLInEtMDm4MDJacBr84vywn
 bxQB7Qc/N+v6s+rbpaFR0DYcuTQlbt6RohMD6x50ehxTc+VQ0ymE6tE7vvYbgZscvj8WlRt
 5Qieob9mSuwT4LcUELgKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OjaCrHXfCF4=:PvpLYVCLTH+TqYvEUIhubX
 BejOhVVRUuzZ76b74FiyEKoeZ8wGb1ACqWrHJfcSEd00QgH5DMG6PhDZnK2erhI8kvWFFnTDg
 /HXBI5vpDo5m6KCkD8kQ5eZvFdUWsNIOPm98njdnU5Vu272mDiO1P6q7FIwgYAwnTgb9C3r1O
 JxR2UU071ZfpySImuDIM8gRQRyu4pySUdLiZ7UL2lZSPPt32q61pWIrZN4B6EUXUItitYqFlJ
 udcUoqIpNpeaMluCKlISZ1DvRn3OAyU0WZbEkTPybgNHoxwXjtMASVGoLHL/2rRkoPIfFplLj
 cui037pqbb4MvBQbsPNm8OBedKKVc2CCVeodqfGzR9pSxHGcM8sQwaNerO4QFCl+4HukcU5tq
 5YVA9jLHiMhBSdqh5tym5eNgUQReMGDrStkRBQzapSXg+m777LD2NWFSxBqyr5uh8gVi9LyaA
 1AanIQC++ATH9LzOiLQSnlhGepuns729AcwkED9J6wYyPlxFQTdlQiydU9Hz6Dko0b+ZmreOb
 W4Eb2hBp6QrWmx4XlaAODGrYErhM30GX8qAV2EEbI16J9TMdp6ikaOLf+Weqv7UagFQoPh3H+
 j59yqu6VJDaTxOlYLvhcxs+8/nU5pNsw1vyDYm4wIEYFxjoeDkvBOs6qjp+lOH5CGZOE/TIyS
 Ri8bQYXBepfaQoT4Gqa9JOAVBG+HTc0PI4FmVxjv75P9keNHsMV+SjlFh3PV/URlzsbq/yMQI
 EL9Wci2B6T407DJ0zC3pKPDlDRFm2SKiB/wI6KDGt0aq93JYAIQBEwAGItg=
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

I will provide those iostats.

Btw i untar the firmware archive (mb_optimized_scan=1 and your patch) 
and got following:

cat /proc/fs/ext4/mmcblk1p2/mb_structs_summary


optimize_scan: 1
max_free_order_lists:
         list_order_0_groups: 5
         list_order_1_groups: 0
         list_order_2_groups: 0
         list_order_3_groups: 0
         list_order_4_groups: 1
         list_order_5_groups: 0
         list_order_6_groups: 1
         list_order_7_groups: 1
         list_order_8_groups: 10
         list_order_9_groups: 1
         list_order_10_groups: 2
         list_order_11_groups: 0
         list_order_12_groups: 2
         list_order_13_groups: 55
fragment_size_tree:
         tree_min: 1
         tree_max: 31249

         tree_nodes: 79

Is this expected?

>
> 								Honza
