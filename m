Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA02CD145
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 09:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbgLCI1M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 3 Dec 2020 03:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbgLCI1M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 03:27:12 -0500
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Dec 2020 00:26:32 PST
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06719C061A4D
        for <linux-ext4@vger.kernel.org>; Thu,  3 Dec 2020 00:26:32 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 17C5F1937FB;
        Thu,  3 Dec 2020 09:20:42 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Ext4 <linux-ext4@vger.kernel.org>
Cc:     lokesh jaliminche <lokesh.jaliminche@gmail.com>,
        Andrew Morton <akpm@linuxfoundation.org>
Subject: Re: improved performance in case of data journaling
Date:   Thu, 03 Dec 2020 09:20:41 +0100
Message-ID: <1870131.usQuhbGJ8B@merkaba>
In-Reply-To: <CAKJOkCoUGPctXEcJWZFo+d62CSBmYjxFr1D0j74OY2ijynMyUA@mail.gmail.com>
References: <CAKJOkCoUGPctXEcJWZFo+d62CSBmYjxFr1D0j74OY2ijynMyUA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

lokesh jaliminche - 03.12.20, 08:28:49 CET:
> I have been doing experiments to analyze the impact of data journaling
> on IO latencies. Theoretically, data journaling should show long
> latencies as compared to metadata journaling. However, I observed
> that when I enable data journaling I see improved performance. Is
> there any specific optimization for data journaling in the write
> path?

This has been discussed before as Andrew Morton found that data 
journalling would be surprisingly fast with interactive write workloads. 
I would need to look it up in my performance training slides or use 
internet search to find the reference to that discussion again.

AFAIR even Andrew had no explanation for that. So I thought why would I 
have one? However an idea came to my mind: The journal is a sequential 
area on the disk. This could help with harddisks I thought at least if 
if it I/O mostly to the same not too big location/file – as you did not 
post it, I don't know exactly what your fio job file is doing. However the 
latencies you posted as well as the device name certainly point to fast 
flash storage :).

Another idea that just came to my mind is: AFAIK ext4 uses quite some 
delayed logging and relogging. That means if a block in the journal is 
changed another time within a certain time frame Ext4 changes it in 
memory before the journal block is written out to disk. Thus if the same 
block if overwritten again and again in short time, at least some of the 
updates would only happen in RAM. That might help latencies even with 
NVMe flash as RAM usually still is faster.

Of course I bet that Ext4 maintainers have a more accurate or detailed 
explanation than I do. But that was at least my idea about this.

Best,
-- 
Martin


