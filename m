Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C95AF632
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Sep 2022 22:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiIFUi1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Sep 2022 16:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIFUi0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Sep 2022 16:38:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCFA88DC3
        for <linux-ext4@vger.kernel.org>; Tue,  6 Sep 2022 13:38:24 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6LMN-1pSgtW1m5B-016gZr; Tue, 06 Sep 2022 22:38:11 +0200
Message-ID: <e4902794-9073-20eb-596a-5aa327adbabe@i2se.com>
Date:   Tue, 6 Sep 2022 22:38:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5 v2] ext4: Fix performance regression with mballoc
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ted Tso <tytso@mit.edu>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <20220906150803.375-1-jack@suse.cz>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220906150803.375-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nzdG9hcsrrJRkdCPkZ8+BkY1iH/kESMKcAjXiv7f/34owUH1dNu
 kLFPvly/w0ggIcbjWHhMLnL2APORpRKMEWhgRVSNGqXCZgVlU1OzAFaqkWM4mnF4Ir1netl
 sLodY4ovES1KqGGBvPaDWoijecj7/3ECa2RdT6gq/YTn//cExGThJ6xFuiYzqOZjQe2fFpU
 GtDp9p2dQf6B0sSBPnOfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XD9Dx0OoeCA=:+7T4om6Dt1qUJ9CwL7YtBX
 jCyS4NPVqNKMyTAfm9s7eJUstCKAhuJRsZmz+rWggdaz6yDIWy3uT1wFQc0u5dvgq5ei+884h
 mXBj+4WkPGg/VTC/FvhW1N1WxtI5Ww94XNhjNgmFyj1iHJ/umEOei9HnJTlwUlZoIdAtMmpg9
 UDO69x7CTlQFv7cGeRJUX0ITWmPCExiMJ5ergagWCSt9lpN4DN/iuWMIEV+ZSHqqZGIUm+T8o
 bIlbEZuVPgflEIdddfj1WdjCYAB2vDA8A3YNOs4U5M+R449k6IaxwRq+SoTxb1Degrso5n0Ta
 iRBxSpLDEunQmfP1GqCbdGPZNRf4fJukFKiahnkLJa+DkNnnZhA236oOhuVSH3tL1IoOqeLjv
 7dakv5W4QdrmMeCsDRhYlD9j55CMmYYkyG/QgPXgYT6KLVtxbJKHUwSoIDaS72S3vu/s9slVU
 dw19iLkzXEE6UBo5VTIDimeplXnmWeqHtjGwLgtaGROHXx6jMFuD9m5zaOUPQR5K+Exy4tXOh
 roLfXYuYW7k2XFEl6DaLaJsHXgO4CbLMRnmrx+jIjk5j7GjO0n0VfAnO24lft47O6BQ1VFdCO
 avyJmXiibfUvqwzZOZj9Ws0h8Kl5xmHvxxvA1646nrv+M+7Hfm+v5Cn8iJoWGx0VDa2fUd3Cf
 lTzzSE4pzR2+dVsvZaETTtDegRYylYS67zRmeq/exLnuANsJ97/tZIz5veDSNdLqAM1J5R139
 opeCRo1Lt5rE6pV2Zq5ICqsgmYVs1bXFt6AtdQakwLCUlj2ftsT8XAjR4bNeQhGRwjjc6rEMZ
 3VNJkbp
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Am 06.09.22 um 17:29 schrieb Jan Kara:
> Hello,
>
> Here is a second version of my mballoc improvements to avoid spreading
> allocations with mb_optimize_scan=1. The patches fix the performance
> regression I was able to reproduce with reaim on my test machine:
>
>                       mb_optimize_scan=0     mb_optimize_scan=1     patched
> Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
> Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
> Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
> Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
> Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
> Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
> Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
> Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
> Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
>
> The changes also significanly reduce spreading of allocations for small /
> moderately sized files. I'm not able to measure a performance difference
> resulting from this but on eMMC storage this seems to be the main culprit
> of reduced performance. Untarring of raspberry-pi archive touches following
> numbers of groups:
>
> 	mb_optimize_scan=0	mb_optimize_scan=1	patched
> groups	4			22			7
>
> To achieve this I have added two more changes on top of v1 - patches 4 and 5.
> Patch 4 makes sure we use locality group preallocation even for files that are
> not likely to grow anymore (previously we have disabled all preallocations for
> such files, however locality group preallocation still makes a lot of sense for
> such files). This patch reduced spread of a small file allocations but larger
> file allocations were still spread significantly because they avoid locality
> group preallocation and as they are not power-of-two in size, they also
> immediately start with cr=1 scan. To address that I've changed the data
> structure for looking up the best block group to allocate from (see patch 5
> for details).
>
> Stefan, can you please test whether these patches fix the problem for you as
> well? Comments & review welcome.

this looks amazing \o/

With this patch v2 applied the untar with mb_optimize_scan=1 is now 
faster than mb_optimize_scan=0.

mb_optimize_scan=0 -> almost 5 minutes

mb_optimize_scan=1 -> almost 1 minute

The original scenario (firmware download) with mb_optimize_scan=1 is now 
fast as mb_optimize_scan=0.

Here the iostat as usual:

https://github.com/lategoodbye/mb_optimize_scan_regress/commit/f4ad188e0feee60bffa23a8e1ad254544768c3bd

There is just one thing, but not sure this if this comes from these 
patches. If i call

cat /proc/fs/ext4/mmcblk1p2/mb_structs_summary

The kernel throw a NULL pointer derefence in 
ext4_mb_seq_structs_summary_show

Best regards

>
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20220823134508.27854-1-jack@suse.cz # v1
