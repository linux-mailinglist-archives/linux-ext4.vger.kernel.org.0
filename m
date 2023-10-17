Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C437CC6F4
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Oct 2023 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjJQPE3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjJQPEZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 11:04:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8472915C
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 07:59:00 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:361f:b50c:f05e:b4ff] (unknown [IPv6:2405:201:0:21ea:361f:b50c:f05e:b4ff])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BFD526600873;
        Tue, 17 Oct 2023 15:58:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554738;
        bh=BU8GFKhyn9Cx+jHDzSOLg8+88kdTePMu8NxieAweOj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NlMxK13/6DKb3EuCrsAydzXmnqXG+/sqSPy+BK3HiZQgT00b0yaLGIheIBMNfWT36
         bvEFwHb3Gy2N0niXnBrcDDqz78u4/C4RsZJctso6aSUtf8R7OtGH0hWGcsJsXwlGtk
         9CxePqeUlRIyBJdD8UIfRLvgRSxt49p6qLg9j/nvFr4NujZxZU88IlV9VuKQ2CE3G3
         LAUp53gU93BRlrq68T+SdmEvmoswykqdpEBk9IGw2BtFlWh24ateCrTmGU9Ebf5CTj
         UTw9nemcPM8CWvkrg5/kKfHMgowE04aCukVASvxcvkwtZxjf2K2/JPlefxdjEcF8qX
         CkKXXNoWNwE6Q==
Message-ID: <a05c68bf-715c-a447-77e1-e4b57974d031@collabora.com>
Date:   Tue, 17 Oct 2023 20:28:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [syzbot] INFO: task hung in ext4_fallocate
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Andres Freund <andres@anarazel.de>, linux-ext4@vger.kernel.org,
        =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        "gustavo.padovan@collabora.com" <gustavo.padovan@collabora.com>,
        groeck@google.com, zsm@google.com, garrick@google.com,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        gustavo.noronha@collabora.com
References: <d89989ef-e53b-050e-2916-a4f06433798b@collabora.com>
 <ZQjKOjrjDYsoXBXj@mit.edu>
 <20231003141138.owt6qwqyf4slgqgp@alap3.anarazel.de>
 <20231003232505.GA444157@mit.edu>
 <20231004004247.zkswbseowwwc6vvk@alap3.anarazel.de>
 <604bc623-a090-005b-cbfc-39805a8a7b20@collabora.com>
 <c9632187-bcbc-483f-8b18-1fa403b46ebb@leemhuis.info>
 <e6277feb-e444-4d47-8376-fa2909fbac96@collabora.com>
 <20231014015453.GE255452@mit.edu>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20231014015453.GE255452@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 14/10/23 07:24, Theodore Ts'o wrote:

Hi Ted,


> On Fri, Oct 13, 2023 at 02:28:52AM +0530, Shreeya Patel wrote:
>> Just to clarify, this issue is still seen on upstream 5.10 and earlier
>> kernels.
>> I can confirm that we did not see this issue being reproduced on mainline
>> kernel using #sys test feature.
> So I'm confused.  In the original post on this thread[1], it was stated:
>
>> When I tried to reproduce this issue on mainline linux kernel using the
>> reproducer provided by syzbot, I see an endless loop of following errors :-

I stated this because at that time we didn't know we could use #syz test 
feature on buganizer tickets as well.
I locally tested it using the reproducer and I was seeing an endless 
loops of errors which I thought
is something not an expected behaviour.

This was happening on mainline as well as 5.10 kernel.

> and
>
>> #regzbot introduced: v6.6-rc1..
> [1] https://lore.kernel.org/all/d89989ef-e53b-050e-2916-a4f06433798b@collabora.com/
>
> ... and now you're sayingg this *wasn't* reproduced upstream?  And of
> course, because this was a private syzbot instance, there was syzbot
> dashboard given, and the reproducer had the serial number filed off
> (there is a URL in the comments at the beginning of the reproducer for
> a *reason*), so *I* couldn't run "#syz test".
>
> Huh?
>
> Reading between the lines, it looks like the only similarity between
> what was happening in the 5.10 kernel and the mainline kernel was that
> it did not *hang* the kernel, but it was generating a stream of
> EXT4-fs error messages.  Well, if you take a deliberately corrupted
> kernel, and mount it with errors=continue, and then keep pounding it
> with lots of file system operations, of *course* it will continually
> spew ext4 errors message.  That is "Working As Intended" by
> *definition*.


This is what I actually wanted to understand if the loops of errors were 
something of concern or not.
I'm not an expert in the area of filesystem so I assumed loops of errors 
that I was seeing
shouldn't be an intented behaviour.


> And this is why I maintain that irresponsible use of syzbot is
> effectively a denial of service attack on upstream maintainers.
>
> At this point, just as upstream policy is that debugging ancient LTS
> kernels is not something upstream maintainers to do (and attempting to
> trick them to debug it by claiming it is found in mainline is *really*
> uncool), if there are bugs that are reported using private syzbot
> instances, or where there isn't a URL to a public syzbot dashboard,
> they should be treated as P4 priority or worse....


We never had the intention to trick you into debugging this issue. When 
I reported this issue,
I did it on the basis of what I saw after using the reproducer locally.
After some days when I came to know we could use #syz test in buganizer, 
I tested mainline and 5.10 kernel again through it
but I didn't see it getting reproduced on mainline kernel and hence I 
said it didn't reproduce upstream in my second email.

I should have given you more context when I said it doesn't happen in 
upstream kernel so I'm sorry for the misunderstanding.


Thanks,
Shreeya Patel


> 	      	     		       	  - Ted
>
