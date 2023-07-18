Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD59175873D
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jul 2023 23:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGRVci (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 17:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjGRVcf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 17:32:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478AF19B0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Jul 2023 14:32:31 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36ILWCmR016366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 17:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689715935; bh=60OkbbKeTbip62zLW81bcGNdcbyOjtefyk1+2g/3VaE=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=YHXOEGydXdG+I3F0VyUNF2MN5/PxUaZPy4Paf0QoCqgp76+4r2PMam19alPa0Yayu
         cEe6xRFB1x/ZOYUzCDshBQMRt8KOeHb5gt7YXH3vJ54PPhpqotd6HQoTn+zIcSru13
         qCoA+IMID7JVL2611GvDX4kuoaI/VcpHIVAIcATq7GpTE+laMHT+aescxDdpRWFAjq
         DxU7ruFUnMi1iRGN9e4xTBtvPbPVMeoFvjuFMSlazdJj0rFLiukQpOT5Mj7qtHGM3b
         60+kdhQpcH6iswdsxJ4Qx3zHCD5N4HHwcamnHhFgNU8bmgmJuldn2SAgEWCXlztYcY
         poBQVBGfuK6vQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5D34B15C026A; Tue, 18 Jul 2023 17:32:12 -0400 (EDT)
Date:   Tue, 18 Jul 2023 17:32:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Alan C. Assis" <acassis@gmail.com>
Cc:     =?iso-8859-1?Q?Bj=F8rn?= Forsman <bjorn.forsman@gmail.com>,
        Kai Tomerius <kai@tomerius.de>, linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: File system robustness
Message-ID: <20230718213212.GE3842864@mit.edu>
References: <20230717075035.GA9549@tomerius.de>
 <CAG4Y6eTU=WsTaSowjkKT-snuvZwqWqnH3cdgGoCkToH02qEkgg@mail.gmail.com>
 <20230718053017.GB6042@tomerius.de>
 <CAEYzJUGC8Yj1dQGsLADT+pB-mkac0TAC-typAORtX7SQ1kVt+g@mail.gmail.com>
 <CAG4Y6eTN1XbZ_jAdX+t2mkEN=KoNOqprrCqtX0BVfaH6AxkdtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG4Y6eTN1XbZ_jAdX+t2mkEN=KoNOqprrCqtX0BVfaH6AxkdtQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 18, 2023 at 10:04:55AM -0300, Alan C. Assis wrote:
> 
> You are right, for NAND there is an old (but gold) presentation here:
> 
> https://elinux.org/images/7/7e/ELC2009-FlashFS-Toshiba.pdf
> 
> UBIFS and YAFFS2 are the way to go.

This presentation is specifically talking about flash devices that do
not have a flash translation layer (that is, they are using the MTD
interface).

There are multiple kinds of flash devices, that can be exported via
different interfaces: MTD, USB Storage, eMMC, UFS, SATA, SCSI, NVMe,
etc.  There are also differences in terms of the sophistication of the
Flash Translation Layer in terms of how powerful is the
microcontroller, how much memory and persistant storage for flash
metadata is available to the FTL, etc.

F2FS is a good choice for "low end flash", especially those flash
devices that use a very simplistic mapping between LBA (block/sector
numbers) and the physical flash to be used, and may have a very
limited number of flash blocks that can be open for modification at a
time.  For more sophiscated flash storage devices (e.g., SSD's and
higher end flash devices), this consideration won't matter, and then
the best file system to use will be very dependant on your workload.

In answer to Kai's original question, the setup that was described
should be fine --- assuming high quality hardware.  There are some
flash devices that designed to handle power failures correctly; which
is to say, if power is cut suddenly, the data used by the Flash
Translation Layer can be corrupted, in which case data written months
or years ago (not just recent data) could be lost.  There have been
horror stories about wedding photographers who dropped their camera,
and the SD Card came shooting out, and *all* of the data that was shot
on some couple's special day was completely *gone*.

Assuming that you have valid, power drop safe hardware, running fsck
after a power cut is not necessary, at least as far as file system
consistency is concerned.  If you have badly written userspace
application code, then all bets can be off.  For example, consider the
following sequence of events:

1)  An application like Tuxracer truncates the top-ten score file
2)  It then writes a new top-ten score file
3)  <Fail to call fsync, or write the file to a foo.new and then
       rename on top of the old version of the file>
4)  Ut then closes the Open GL library, triggering a bug in the cruddy
    proprietary binary-only kernel module video driver,
    leading to an immediate system crash.
5)  Complain to the file system developers that users' top-ten score
    file was lost, and what are the file system developers going to
    do about it?
6)  File system developers start creating T-shirts saying that what userspace
    applications really are asking for is a new open(2) flag, O_PONIES[1]

[1] https://blahg.josefsipek.net/?p=364

So when you talk about overall system robustness, you need robust
hardware, you need a robust file aystem, you need to use the file
system correctly, and you have robust userspace applications.

If you get it all right, you'll be fine.  On the other hand, if you
have crappy hardware (such as might be found for cheap in the checkout
counter of the local Micro Center, or in a back alley vendor in
Shenzhen, China), or if you do something like misconfigure the file
system such as using the "nobarrier" mount option "to speed things
up", or if you have applications that update files in an unsafe
manner, then you will have problems.

Welcome to systems engineering.  :-)

						- Ted
