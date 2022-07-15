Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34835760D7
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiGOLsn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 07:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiGOLsm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 07:48:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1349F2BFC
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 04:48:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26FBmSlq021062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657885710; bh=t3GfqK3pUoxthXinheaph24n/I8XiqlaLJzOyOkqW+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UDi51M3ctM1ffd3iWAqSLtcxTurjUvzS39ISPfpKUxFdKnMZq4/ITdUMiJ57ZESF3
         GarM8E24ImWUxtGX7VlHjwyge/ZJeQXb2pxF/P9P2LcwBnU5DpWU44d4W4ONdmP4b5
         Kuhban5c91pmOu/c3hbW2OZxYASD7bnd1iOApDtZ7GCNmXoRL4nHwP3E1IidPsi0xb
         qTb8Y2lzCkNZltXuFd5aJpGoJD6TUQjIfxUI25mqcA/Ei16v3Y7amU/hCcPO1IOk56
         johzFI1heh6XARGnct+z0p0YIV/cBpC8df7uwFIzW0t4Lcei5eGOpOVOMlP8NWnkfG
         7b4CCwfnM4sDg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CC10D15C003C; Fri, 15 Jul 2022 07:48:28 -0400 (EDT)
Date:   Fri, 15 Jul 2022 07:48:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Kiselev, Oleg" <okiselev@amazon.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 2/2] ext4: avoid resizing to a partial cluster size
Message-ID: <YtFUDIk589glIHSf@mit.edu>
References: <9CDF7393-5645-4E8A-9D68-01CF7F4C4955@amazon.com>
 <20220714135231.aull3vo44yfa6azg@quack3>
 <0CC0FCE1-F8A2-4966-B848-AD2D9DF9A713@amazon.com>
 <20220715093518.tzl2upullc5pymo2@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220715093518.tzl2upullc5pymo2@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 15, 2022 at 11:35:18AM +0200, Jan Kara wrote:
> > available for the filesystem having an “odd” size.  Our preference is for
> > the utilities to silently fix the fs size down to the nearest “safe” size
> > rather than get sporadic errors.   I had submitted a patch for resize2fs
> > that rounds the fs target size down to the nearest cluster boundary.  In
> > principle it’s similar to the size-rounding that is done now for 4K
> > blocks.   Using updated e2fsprogs isn’t mandatory for using ext4 in the
> > newer kernels, so making the kernel safe(r) for bigalloc resizes seems
> > like a good idea.
> 
> I see. Honestly, doing automatic "fixups" of passed arguments to syscalls /
> ioctls has bitten us more than once in the past. That's why I'm cautious
> about that. It seems convenient initially but then when contraints change
> (e.g. you'd want to be rounding to a different number) you suddently find
> you have no way to extend the API without breaking some userspace. That's
> why I prefer to put these "rounding convenience" functions into userspace.
> 
> That being said I don't feel too strongly about this particular case so I
> guess I'll defer the final decision about the policy to Ted.

In this particular case, a file system whose size is not a multiple of
cluster size is never going to be valid, so having the resize ioctl
round down the requested size to largest valid size seems to be a safe
(and useful) thing to do.

						- Ted
