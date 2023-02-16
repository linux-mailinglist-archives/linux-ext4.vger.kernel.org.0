Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0384699DD2
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 21:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjBPUfK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 15:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBPUfJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 15:35:09 -0500
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFF3199DF
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 12:35:08 -0800 (PST)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4PHmsQ61WtzXPW
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 21:35:06 +0100 (CET)
Message-ID: <54d20603-34f6-9832-7897-aaf8d5f5a89f@thelounge.net>
Date:   Thu, 16 Feb 2023 21:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: e4defrag don't work really well
Content-Language: en-US
To:     linux-ext4@vger.kernel.org
References: <1620c46d-efcf-aca6-341b-083ef593c612@thelounge.net>
 <e21a53a9-10c5-a9da-02a6-338a78688c11@sandeen.net>
 <95b1df7e-3eb9-484c-d655-c42501ce7429@thelounge.net>
 <abcc1ec6-a1d6-28a2-d0f5-29baac0722b8@sandeen.net>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
In-Reply-To: <abcc1ec6-a1d6-28a2-d0f5-29baac0722b8@sandeen.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Am 16.02.23 um 20:56 schrieb Eric Sandeen:
> On 2/16/23 12:21 PM, Reindl Harald wrote:
>>
>> Am 16.02.23 um 17:50 schrieb Eric Sandeen:
>>> On 2/12/23 12:14 PM, Reindl Harald wrote:
>>>>
>>>> what's wrong with e4defrag that it pretends it reduced th efragments of a file to 1 while in the next "e4defrag -c" (why does that only list 5 files at all) the same file is listed again with the same old frag count?
>>>
>>> You might want to examine the actual allocation before and after with "filefrag -v"
>>> which could offer some clues to whether anything was modified by e4defrag.
>>>
>>> (I would also suggest that there is no need to defragment a 3-extent 2 megabyte
>>> file, in general.)
>>
>> it's not a question if it's needed
>>
>> the point is it pretends "Success: [1/1]" but a following "e4defrag -c" still says "now/best 3/1"
> 
> I understand. It seems that your irritation at my parenthetical caused you
> to skip over the request for more information from filefrag, though

wehn you call e4defrag *multiple* times it seems to have the expected 
result - erratic operations like this are terrible

also why it's operating over files with already only 1 xtend is also a 
mircale for me - it takes ages to run it over a folder with some hundret 
MB and seems to rewrite each and every file

-----------------

BTW: it's a bad idea that your personal address forwards to gmail - 
google is rejecting any forwarded mail from a proper configured domain 
using SPF

[root@srv-rhsoft:~]$ filefrag "/mnt/data/audio/Smokie/Solid 
Ground/Smokie - Little Town Flirt.mp3"
/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3: 3 
extents found

[root@srv-rhsoft:~]$ e4defrag "/mnt/data/audio/Smokie/Solid 
Ground/Smokie - Little Town Flirt.mp3"
e4defrag 1.46.5 (30-Dec-2021)
ext4 defragmentation for /mnt/data/audio/Smokie/Solid Ground/Smokie - 
Little Town Flirt.mp3
[1/1]/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3: 
        100%    [ OK ]
  Success:                       [1/1]

[root@srv-rhsoft:~]$ filefrag "/mnt/data/audio/Smokie/Solid 
Ground/Smokie - Little Town Flirt.mp3"
/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3: 2 
extents found

[root@srv-rhsoft:~]$ e4defrag "/mnt/data/audio/Smokie/Solid 
Ground/Smokie - Little Town Flirt.mp3"
e4defrag 1.46.5 (30-Dec-2021)
ext4 defragmentation for /mnt/data/audio/Smokie/Solid Ground/Smokie - 
Little Town Flirt.mp3
[1/1]/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3: 
        100%    [ OK ]
  Success:                       [1/1]

[root@srv-rhsoft:~]$ filefrag "/mnt/data/audio/Smokie/Solid 
Ground/Smokie - Little Town Flirt.mp3"
/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3: 1 
extent found
