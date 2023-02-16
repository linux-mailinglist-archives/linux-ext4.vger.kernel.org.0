Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6A699AAA
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBPQ5j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 11:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjBPQ5j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 11:57:39 -0500
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 08:57:38 PST
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50AFE2684F
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 08:57:38 -0800 (PST)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id A11F54DCA02;
        Thu, 16 Feb 2023 10:48:34 -0600 (CST)
Message-ID: <e21a53a9-10c5-a9da-02a6-338a78688c11@sandeen.net>
Date:   Thu, 16 Feb 2023 10:50:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Content-Language: en-US
To:     Reindl Harald <h.reindl@thelounge.net>, linux-ext4@vger.kernel.org
References: <1620c46d-efcf-aca6-341b-083ef593c612@thelounge.net>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: e4defrag don't work really well
In-Reply-To: <1620c46d-efcf-aca6-341b-083ef593c612@thelounge.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2/12/23 12:14 PM, Reindl Harald wrote:
> 
> what's wrong with e4defrag that it pretends it reduced th efragments of a file to 1 while in the next "e4defrag -c" (why does that only list 5 files at all) the same file is listed again with the same old frag count?

You might want to examine the actual allocation before and after with "filefrag -v"
which could offer some clues to whether anything was modified by e4defrag.

(I would also suggest that there is no need to defragment a 3-extent 2 megabyte
file, in general.)

-Eric

> ----------------------------
> 
> [root@srv-rhsoft:~]$ e4defrag -c /mnt/data/audio/
> e4defrag 1.46.5 (30-Dec-2021)
> <Fragmented files>                             now/best       size/ext
> 1. /mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3
>                                                  3/1           2389 KB
> 2. /mnt/data/audio/Ace Frehley/Second Sighting/Ace Frehley - Fallen Angel.mp3
>                                                  3/1           2389 KB
> 3. /mnt/data/audio/Mr. Big/Defying Gravity/Mr. Big - Mean To Me.mp3
>                                                  3/1           2389 KB
> 4. /mnt/data/audio/Juice Newton/Quiet Lies/Juice Newton - Im Gonna Be Strong.mp3
>                                                  3/1           2389 KB
> 5. /mnt/data/audio/Vicious Rumors/Something Burning/Vicious Rumors - Ballhog.mp3
>                                                  3/1           2389 KB
> 
> ----------------------------
> 
> [root@srv-rhsoft:~]$ e4defrag "/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3"
> e4defrag 1.46.5 (30-Dec-2021)
> ext4 defragmentation for /mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3
> [1/1]/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3:        100%    [ OK ]
>  Success:                       [1/1]
> 
> ----------------------------
> 
> [root@srv-rhsoft:~]$ e4defrag -c /mnt/data/audio/
> e4defrag 1.46.5 (30-Dec-2021)
> <Fragmented files>                             now/best       size/ext
> 1. /mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3
>                                                  3/1           2389 KB
> 2. /mnt/data/audio/Ace Frehley/Second Sighting/Ace Frehley - Fallen Angel.mp3
>                                                  3/1           2389 KB
> 3. /mnt/data/audio/Mr. Big/Defying Gravity/Mr. Big - Mean To Me.mp3
>                                                  3/1           2389 KB
> 4. /mnt/data/audio/Juice Newton/Quiet Lies/Juice Newton - Im Gonna Be Strong.mp3
>                                                  3/1           2389 KB
> 5. /mnt/data/audio/Vicious Rumors/Something Burning/Vicious Rumors - Ballhog.mp3
>                                                  3/1           2389 KB
> 
