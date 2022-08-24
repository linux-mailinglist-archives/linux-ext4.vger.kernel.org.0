Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517059F745
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Aug 2022 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiHXKR2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Aug 2022 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXKR1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Aug 2022 06:17:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6888872ECD
        for <linux-ext4@vger.kernel.org>; Wed, 24 Aug 2022 03:17:26 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1aQN-1oTGHg06ax-0039LJ; Wed, 24 Aug 2022 12:17:15 +0200
Message-ID: <8e164532-c436-241f-33be-4b41f7f67235@i2se.com>
Date:   Wed, 24 Aug 2022 12:17:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] ext4: Fix performance regression with mballoc
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20220823134508.27854-1-jack@suse.cz>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220823134508.27854-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B+88sKu8vwBSHhXTsh+YS8MJpxlrP9CdhRsfu1s0gftiyLSUjcY
 BSi4GTpMCD375Vw8XY1iEJS6j2Cn+gKgiYY3o4NJUgnQo2clfWzIji8YjbFMEJSSt39dJyJ
 5AqkNTJZ+Rr+dNDYIyH5fSccE2kR4O/JDaBW3Frw2UcXwBfXQyrMNlA1Pek0042Hp5hn8HA
 f+r77iuWTlXQ2UHCUsNaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T+GMcMtuvy0=:LEuOgZ2CLUi2HZu3UP+UhX
 WBaYnxwa8xh2Wa9P2D637GjXXdzY9SgmdfdtTjUOedtMI/nLz9iMBl1aac/Rs9QtodGqJ7/2u
 ArxN4xnqz+eo32ZHzgWYWOSChuWv1W0yU3ImQFTEcJFWyqNGLzCNPG/+xjVo/W+jb5ZULKHVU
 urxu+lNLXPhFJJdyXaWaM2kRM7VN2gO64vaFBT1hihPo3XNgKNS0qQ8JCAMk584uL3jXmTLUs
 nox2rv0zg7Oc6qU2k4sF7YpbOWbUjNN1gTTyr/RZ3ynbjEu/J+OOKTsILA21t4Vhb9j/o9g2M
 9mbvzjexYrZaCIE5x6uVW4esPzK6TGoBlFTGk5I6hpR1GejSnb/+M4GyflpTN4iQ9Hv0dT2kb
 7vRLlzdFxRU+dzxm4541yLSRLODF6o9TvWUdmPR4qH/Pm7KQGuBJlT68K/lZeWje/XGtlSZhx
 hqYYRghtglWy8xTBVZIfqo97R/bLiDSAQvcYCu0eP9EgWSlFOveTGs3d8/hLqk+yHwd6qoge8
 X//JN6Y95pmpQ3pbauwxczzsBQ4mBp98x3mWFPTgQbP3A5qkRMWVM06BCS/Rcg8DEB1Dkzz3S
 bWqjDBI255eb+ESwpcndH4o+PaJNYITWs938ranuBD5lNi8Q+yytlxWV2PlQexGb5EA2AAIlw
 CwOpcZnlTJ2qrr2u5huL+uU8AAZi40MjXWGplqx4mOMJANgGU96klyTxphB7LV1bVPlk4wDdw
 xXA9FsUYMkCoBUrzJ92gxKirb8KEES/VoYK5zgmZvZp+cKE2rflLCMXwF3A=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Am 23.08.22 um 22:15 schrieb Jan Kara:
> Hello,
>
> So I have implemented mballoc improvements to avoid spreading allocations
> even with mb_optimize_scan=1. It fixes the performance regression I was able
> to reproduce with reaim on my test machine:
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
> Stefan, can you please test whether these patches fix the problem for you as
> well? Comments & review welcome.

i tested the whole series against 5.19 and 6.0.0-rc2. In both cases the 
update process succeed which is a improvement, but the download + unpack 
duration ( ~ 7 minutes ) is not as good as with mb_optimize_scan=0 ( ~ 1 
minute ).

Unfortuntately i don't have much time this week and next week i'm in 
holidays.

Just a question, my tests always had MBCACHE=y . Is it possible that the 
mb_optimize_scan is counterproductive for MBCACHE in this case?

I'm asking because before the download the update script removes the 
files from the previous update process which already cause a high load.

Best regards

>
> 								Honza
