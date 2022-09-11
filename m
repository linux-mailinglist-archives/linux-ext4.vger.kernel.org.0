Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69A45B4ECB
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Sep 2022 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIKMdB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Sep 2022 08:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiIKMdA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Sep 2022 08:33:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16003DF04
        for <linux-ext4@vger.kernel.org>; Sun, 11 Sep 2022 05:32:58 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqatE-1pApkk1U5A-00mZ0h; Sun, 11 Sep 2022 14:32:46 +0200
Message-ID: <2eff8cbd-2d9c-0fb8-cfdb-31ce3534e466@i2se.com>
Date:   Sun, 11 Sep 2022 14:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5 v3] ext4: Fix performance regression with mballoc
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ted Tso <tytso@mit.edu>
References: <20220908091301.147-1-jack@suse.cz>
 <4826b1af-1264-3b3a-e71c-38937c75641c@i2se.com>
 <20220909104014.xgzdlzem3f7mbccd@quack3>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220909104014.xgzdlzem3f7mbccd@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DAtqdQOrf2R6VUVNAmS2z6QAru755n5u3lUgf8Jp6DvscHKK270
 q6wQSnwozKJAec/4Ft6//hVqrmsdUnK7pXdrbAQ0X5P0C5ocRwbeqopO8u4loSPppW9nN4L
 jghLrHpBQef5RgAGFQg0RZ/lvW/QM4ZtCdUbP0jUBEPkKoFFfIeiyldBiqCS/t/ak2dk/CH
 s2flBvKMeSiqO1FSbiD1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5o4Kz0j7QX4=:PWr3bx+/ZTePuptzRHi79y
 KmFzmm2xJOgK+9Y+W+XC53SGsgVm9sNLgxdTcZv60CZ8ykme76wQJe4NqXGp5snCmvfAW5VSQ
 LjvW2PWnovTlH42DtAdoOUHDtQZw3OpPx51OvfHEk5MUmix9NWoNaGvOnieidWz19N0sR20da
 HtzmK6XlEbpcwnFqBGNZlLDhwM0sVS3gJkiWHNaTiPWo3E58CqBhA7v912CAgbf7YKhpHNekz
 Fbw2a1ZjpExBRJoPABLocBShRgg2HpAJHiw1hXMHdO9P2Aq/3lRyDRHGzIlzZ0WPdcuEW5YmO
 V8d6eYm+vfnEwvgpx+sC9fzbYXaq1p7aMKpf4VnS8w0hBdDqYuc9moWk3ylkWuxGdbXWHUnso
 6ZvwSqF1IXEqWR4CJjy3fuyoKMo/8DXlqAlprN4O2kKIoWado/WhVR4Th3Le+SLWFXFhdcTfE
 84JCxagJHOcCOhaSYC1oYUP/i9OKvOktMM9aNy9qxfTZoWWsBVdSJP728ebVzSAr974MEMFNV
 AhpwANfvd/LGv1UvhIsVbjcaepr9KtCL+RpM41p2xf6xch7KdgI3Ul0drKJ6wwIM1+uU8X2KO
 Z/XFr2Z7dlIb4W5mLMWmTGf+YDC/YXHGP+X7fLLNyfHySW+xOnlyLGx98YdSDnC7cv3vuR/v3
 xs6dGHIpuidwpXIdqHMUZ6U3DuT7c14lBW88AZ7ODpyflCliOFsin08QFJQNx7k/pW4dHU3MB
 P0idaH10JBAevzSRPvB7zcqU0My04b7G4tkUad5G7/Hq4PSXljpjVHlajBflnpjJzkwXf32pt
 tuWqTV0
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Am 09.09.22 um 12:40 schrieb Jan Kara:
> On Thu 08-09-22 12:36:10, Stefan Wahren wrote:
>> Hi Jan,
>>
>> Am 08.09.22 um 11:21 schrieb Jan Kara:
>>> Hello,
>>>
>>> Here is the third version of my mballoc improvements to avoid spreading
>>> allocations with mb_optimize_scan=1. Since v2 there are only small changes and
>>> fixes found during review and testing. Overall the series looks mostly ready to
>>> go, I just didn't see any comments regarding patch 3 - a fix of metabg handling
>>> in the Orlov allocator which is kind of independent, I've just found it when
>>> reading the code. Also patch 5 needs final review after all the fixes.
>>>
>>> Changes since v1:
>>> - reworked data structure for CR 1 scan
>>> - make small closed files use locality group preallocation
>>> - fix metabg handling in the Orlov allocator
>>>
>>> Changes since v2:
>>> - whitespace fixes
>>> - fix outdated comment
>>> - fix handling of mb_structs_summary procfs file
>>> - fix bad unlock on error recovery path
>> unfortunately the real patches doesn't have v3 which leads to confusion.
> Yeah, OK, I've updated my scripting for posting patches to include version
> in each posted patch :)
>
>> Just a note: in case this series cannot be applied for stable (5.15), we
>> need a second solution to fix the regression there.
> My plan is to backport the current series. It is not that invasive so it
> should be doable...

This would be great.

Btw i retested this version and i can confirm the procfs crash is fixed.

>
> 								Honza
