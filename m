Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D521D5B1A15
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiIHKg0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 06:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIHKgZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 06:36:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5452B9D105
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 03:36:23 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.23]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MYNW6-1oslzN1DHe-00VReT; Thu, 08 Sep 2022 12:36:11 +0200
Message-ID: <4826b1af-1264-3b3a-e71c-38937c75641c@i2se.com>
Date:   Thu, 8 Sep 2022 12:36:10 +0200
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
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220908091301.147-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ts8T1ViXZARE54Ba9rnvEpCQ70Ei8YyYLJ2c5WfBh0T9NkGdVaX
 keqXFq1ST2HAkYs7J0MaKQGcNa4Q+Y0aUTp482Aif0357WU5QWH0tWpOaGCQ3FvBHRRpznS
 oYPPljxpZdmQ62EKTowI8ZpmdBbEtIEdVd4MnJ3RA6HKfwu2LtK8J2NO5Xfm5hxNehJJAsS
 aN9+/NyH5OgZ8x/PVEHdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mbK1tYhJX9Y=:YrNHR3vCnznWHEdSPAMO4A
 1j8yNDWO14/h95KzFpA9UW1dY93n/oG3J356SK0P2Pu3ZzMclU0TMHxd7s1LYVgCUD+6C5xMB
 erb0RJfXD9BDLsiIjcKXEtUe+Ymt8fupROsmnrLhFZxn0mgxHKTWlbWAjDbbIB7ua7/szHrUH
 6EtbP3K10gbWgkq0EhLq06HSfFLSpAw+1qQ+29cgjEMFOXyoKyNbRUl9rxsG0O3GOKGl+SnpV
 +UTVbTBfV3uiFGSsWC3/iXEIciWqaWwd7CLp3S9bFkW4oDWeoQ8kEA1AFz4PdX8KUyHqDPFl0
 D6iFeLPuTG48Pg096n+FBh4OWjLNeFJqNwjzYurnm09HggQZcxCTz0rXZdl5zS4IYig0aypib
 yWQlBzd+4gl7Uc0PkwLlRjjG6tu+/c1E9SbfSzeZ/EGwPrIWhHzNgWULI5X08HDMBVaJlnMJP
 tAoD1liiI8tBaz9ctzmb661wkhK0bhfhlhi9BoQEt40C7hQCMngnb+3HbdB/eDwK3XkcV6vKH
 dtRkb2Q5S5tZ6C7HDBx4ygnD2A/fIL4ofhKrYBYxjYFOcm9aAOtY7P6GMaIeNrF8jZw8subh2
 vKutGwI3mdM7RxOuOxeCAYW8bui4Ga0YuuUBQ8FNHR+rz0jQLuyMfVol2sSknGNroyxhFkQBh
 UKU4cRLUXnWHzL3ooikFrWmuOeKMqyLcXzl0rnH8VuhfxCDF9AelrtMuOUqpEH9GmNiUqT0TS
 n19lwPHC3RopbyjjQC+vI0i9bOz8YXguoVPvo6R8wKUKRg6i1oFaN6/ptQSUBU1+iXFj1L07C
 10aDzE0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Am 08.09.22 um 11:21 schrieb Jan Kara:
> Hello,
>
> Here is the third version of my mballoc improvements to avoid spreading
> allocations with mb_optimize_scan=1. Since v2 there are only small changes and
> fixes found during review and testing. Overall the series looks mostly ready to
> go, I just didn't see any comments regarding patch 3 - a fix of metabg handling
> in the Orlov allocator which is kind of independent, I've just found it when
> reading the code. Also patch 5 needs final review after all the fixes.
>
> Changes since v1:
> - reworked data structure for CR 1 scan
> - make small closed files use locality group preallocation
> - fix metabg handling in the Orlov allocator
>
> Changes since v2:
> - whitespace fixes
> - fix outdated comment
> - fix handling of mb_structs_summary procfs file
> - fix bad unlock on error recovery path

unfortunately the real patches doesn't have v3 which leads to confusion.

Just a note: in case this series cannot be applied for stable (5.15), we 
need a second solution to fix the regression there.

