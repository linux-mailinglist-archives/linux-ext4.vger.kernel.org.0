Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5969395E
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Feb 2023 19:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBLSdq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Feb 2023 13:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLSdp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Feb 2023 13:33:45 -0500
X-Greylist: delayed 1147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 10:33:43 PST
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0C71026F
        for <linux-ext4@vger.kernel.org>; Sun, 12 Feb 2023 10:33:43 -0800 (PST)
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4PFFx10Hd4zXKn
        for <linux-ext4@vger.kernel.org>; Sun, 12 Feb 2023 19:14:24 +0100 (CET)
Message-ID: <1620c46d-efcf-aca6-341b-083ef593c612@thelounge.net>
Date:   Sun, 12 Feb 2023 19:14:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     linux-ext4@vger.kernel.org
Content-Language: en-US
From:   Reindl Harald <h.reindl@thelounge.net>
Subject: e4defrag don't work really well
Organization: the lounge interactive design
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


what's wrong with e4defrag that it pretends it reduced th efragments of 
a file to 1 while in the next "e4defrag -c" (why does that only list 5 
files at all) the same file is listed again with the same old frag count?

----------------------------

[root@srv-rhsoft:~]$ e4defrag -c /mnt/data/audio/
e4defrag 1.46.5 (30-Dec-2021)
<Fragmented files>                             now/best       size/ext
1. /mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3
                                                  3/1           2389 KB
2. /mnt/data/audio/Ace Frehley/Second Sighting/Ace Frehley - Fallen 
Angel.mp3
                                                  3/1           2389 KB
3. /mnt/data/audio/Mr. Big/Defying Gravity/Mr. Big - Mean To Me.mp3
                                                  3/1           2389 KB
4. /mnt/data/audio/Juice Newton/Quiet Lies/Juice Newton - Im Gonna Be 
Strong.mp3
                                                  3/1           2389 KB
5. /mnt/data/audio/Vicious Rumors/Something Burning/Vicious Rumors - 
Ballhog.mp3
                                                  3/1           2389 KB

----------------------------

[root@srv-rhsoft:~]$ e4defrag "/mnt/data/audio/Smokie/Solid 
Ground/Smokie - Little Town Flirt.mp3"
e4defrag 1.46.5 (30-Dec-2021)
ext4 defragmentation for /mnt/data/audio/Smokie/Solid Ground/Smokie - 
Little Town Flirt.mp3
[1/1]/mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3: 
        100%    [ OK ]
  Success:                       [1/1]

----------------------------

[root@srv-rhsoft:~]$ e4defrag -c /mnt/data/audio/
e4defrag 1.46.5 (30-Dec-2021)
<Fragmented files>                             now/best       size/ext
1. /mnt/data/audio/Smokie/Solid Ground/Smokie - Little Town Flirt.mp3
                                                  3/1           2389 KB
2. /mnt/data/audio/Ace Frehley/Second Sighting/Ace Frehley - Fallen 
Angel.mp3
                                                  3/1           2389 KB
3. /mnt/data/audio/Mr. Big/Defying Gravity/Mr. Big - Mean To Me.mp3
                                                  3/1           2389 KB
4. /mnt/data/audio/Juice Newton/Quiet Lies/Juice Newton - Im Gonna Be 
Strong.mp3
                                                  3/1           2389 KB
5. /mnt/data/audio/Vicious Rumors/Something Burning/Vicious Rumors - 
Ballhog.mp3
                                                  3/1           2389 KB

