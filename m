Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4667607E5
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 06:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGYEYc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 00:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGYEXY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 00:23:24 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 919462699;
        Mon, 24 Jul 2023 21:21:42 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id AAE436032EB66;
        Tue, 25 Jul 2023 12:21:39 +0800 (CST)
Message-ID: <d6ffea4c-52e5-b13d-ae28-a3751995364c@nfschina.com>
Date:   Tue, 25 Jul 2023 12:21:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ext4: mballoc: avoid garbage value from err
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     adilger.kernel@dilger.ca, nathan@kernel.org, trix@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <20230724205721.GA2504240@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2023/7/25 04:57, Theodore Ts'o wrote:
> On Mon, Jul 24, 2023 at 10:19:02AM -0700, Nick Desaulniers wrote:
>>> err is uninitialized and will be judged when it enters the
>>> loop first time and the condition "!ext4_sb_block_valid()"
>>> is true. Although this can't make problems now, it's better
>>> to correct it.
>>>
>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> Hi Su,
>> Thanks for the patch!  I see what the warning is getting at;
>>
>> If `len <= 0` then `err` is never initialized, then is used at line
>> 4178 (that is UB).
>>
>> Would you mind sending a v2 with the commit message updated to reflect
>> the above points?  I'd be happy to sign-off on that.
> Fortunately, as near as I can tell, ext4_mb_mark_bb() should never be
> called with len <= 0.  It might be possible to trick ext4 via a
> corrupted file system --- I'd have to take a closer look at that, but
> fortunately, in the case where len <= 0, bitmap_bh will be NULL, so
> regardless of whether err is 0, or some garbage non-zero value,
> brelse(NULL) is a no-op.
> So while it's good to avoid the clang warning, but the fact that it
> might be possible for err to be a "garbage value" shouldn't be causing
> any problem.
Maybe it can make the code more robust and clearer. I will send v2 patch 
soon.
Thanks for your reply!

Su Hui

>
> Cheers,
>
> 						- Ted
