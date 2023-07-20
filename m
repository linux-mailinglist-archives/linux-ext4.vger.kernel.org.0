Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D41275A852
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 09:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjGTHze (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 03:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGTHzd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 03:55:33 -0400
X-Greylist: delayed 91947 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 00:55:26 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A95269F;
        Thu, 20 Jul 2023 00:55:26 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 225317497FD;
        Thu, 20 Jul 2023 09:55:23 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Alan C. Assis" <acassis@gmail.com>,
        =?ISO-8859-1?Q?Bj=F8rn?= Forsman <bjorn.forsman@gmail.com>,
        Kai Tomerius <kai@tomerius.de>, linux-embedded@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Nobarrier mount option (was: Re: File system robustness)
Date:   Thu, 20 Jul 2023 09:55:22 +0200
Message-ID: <38426448.10thIPus4b@lichtvoll.de>
In-Reply-To: <20230720042034.GA5764@mit.edu>
References: <20230717075035.GA9549@tomerius.de> <4835096.GXAFRqVoOG@lichtvoll.de>
 <20230720042034.GA5764@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore Ts'o - 20.07.23, 06:20:34 CEST:
> On Wed, Jul 19, 2023 at 08:22:43AM +0200, Martin Steigerwald wrote:
> > Is "nobarrier" mount option still a thing? I thought those mount
> > options have been deprecated or even removed with the introduction
> > of cache flush handling in kernel 2.6.37?
> 
> Yes, it's a thing, and if your server has a UPS with a reliable power
> failure / low battery feedback, it's *possible* to engineer a reliable
> system.  Or, for example, if you have a phone with an integrated
> battery, so when you drop it the battery compartment won't open and
> the battery won't go flying out, *and* the baseboard management
> controller (BMC) will halt the CPU before the battery complete dies,
> and gives a chance for the flash storage device to commit everything
> before shutdown, *and* the BMC arranges to make sure the same thing
> happens when the user pushes and holds the power button for 30
> seconds, then it could be safe.

Thanks for clarification. I am aware that something like this can be 
done. But I did not think that is would be necessary to explicitly 
disable barriers, or should I more accurately write cache flushes, in 
such a case:

I thought that nowadays a cache flush would be (almost) a no-op in the 
case the storage receiving it is backed by such reliability measures. 
I.e. that the hardware just says "I am ready" when having the I/O 
request in stable storage whatever that would be, even in case that 
would be battery backed NVRAM and/or temporary flash.

At least that is what I thought was the background for not doing the 
"nobarrier" thing anymore: Let the storage below decide whether it is 
safe to basically ignore cache flushes by answering them (almost) 
immediately.

However, not sending the cache flushes in the first place would likely 
still be more efficient although as far as I am aware block layer does not 
return back a success / failure information to the upper layers anymore 
since kernel 2.6.37.

Seems I got to update my Linux Performance tuning slides about this once 
again.

> We also use nobarrier for a scratch file systems which by definition
> go away when the borg/kubernetes job dies, and which will *never*
> survive a reboot, let alone a power failure.  In such a situation,
> there's no point sending the cache flush, because the partition will
> be mkfs'ed on reboot.  Or, in if the iSCSI or Cloud Persistent Disk
> will *always* go away when the VM dies, because any persistent state
> is saved to some cluster or distributed file store (e.g., to the MySQL
> server, or Big Table, or Spanner, etc.  In these cases, you don't
> *want* the Cache Flush operation, since skipping it reduce I/O
> overhead.

Hmm, right.

> So if you know what you are doing, in certain specialized use cases,
> nobarrier can make sense, and it is used today at my $WORK's data
> center for production jobs *all* the time.  So we won't be making
> ext4's nobarrier mount option go away; it has users.  :-)

I now wonder why XFS people deprecated and even removed those mount 
options. But maybe I better ask them separately instead of adding their 
list in CC. Probably by forwarding this mail to the XFS mailing list 
later on.

Best,
-- 
Martin


