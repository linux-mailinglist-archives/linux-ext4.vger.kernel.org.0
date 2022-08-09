Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F4858D1D0
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 03:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiHIBse (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Aug 2022 21:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHIBsd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Aug 2022 21:48:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484991147B;
        Mon,  8 Aug 2022 18:48:31 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2791m9BO007468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 Aug 2022 21:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660009691; bh=Nbh78y1/RmslzipSrPkQY+yfbzbI5/4Y4YzknIG1Mew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A1BjEIcei+oO+zkmuAGFcCWaarImCyXT6N9AkEdE6N4WK79b6IOS7/Er12/ZN3Whv
         OBWlWKg+H9Pi4M8/pdIshNBDFL0qABJkd3/iaW9SjpzFlR/N+j1btnjakRatSsZZ2J
         4QaY/KT0ntMD5LBqPqNgmkfE7LreUr3Sy3EgN/KeJLTamH/lUv9kBMfWtjsvitDa3k
         7mc/+ZeErfeBmqe1orbPD7Mt8yueaFENmrGxPdMWx88nLQ5PA+dvloAWbB+Vcw0EVP
         CO4mxUtO7M5IxB/41cgfOUo25cp7xdCiETBmcjgR8A+oeNPnrsqlzNfq9WkU3GCl5v
         /zpcGM+M5DHzw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id DAC688C2DED; Mon,  8 Aug 2022 21:48:08 -0400 (EDT)
Date:   Mon, 8 Aug 2022 21:48:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] possible deadlock in ext4_xattr_get
Message-ID: <YvG82FfLA4iI0ZAT@mit.edu>
References: <20220808133219.2248-1-hdanton@sina.com>
 <00000000000017bd2d05e5c47f10@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000017bd2d05e5c47f10@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 08, 2022 at 06:03:12PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-and-tested-by: syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         cb71b93c Add linux-next specific files for 20220628
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=12afd10e080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=badbc1adb2d582eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=62120febbd1ee3c3c860
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=104ed896080000
> 

Hi Hillf,

Thanks for looking at this.  For some reason, your e-mails with the
patch are available on the syzkaller-bugs google groups archive.  For
example:

https://groups.google.com/g/syzkaller-bugs/c/NgC9hA3GX_Q/m/vVqsx8KTBQAJ

But even though your messages appear to be cc'ed to linux-kernel, I'm
not seeing your messages on lore.kernel.org's mail archives.  (wWith
apologies to Lewis Caroll) "Curiouser and curiouser...."

This makes me worried that somehow some or all of your messages to
linux-ext4@ or linux-kernel@ on this matter are somehow getting lost.
We see syzkaller's reply to your messages, and anything that you've
cc'ed to syzkaller-bugs@googlegroups.com is available archived on
Google Groups.  However, if there were any other messages that you
have sent, they may have been unseed by anyone else.  :-(

If you could send a patch with a full description and the appropriate
Fixes: and CC: stable tags, could you make sure that you explicitly Cc
me, just in case something is funny going on with your e-mails to
mailing lists at vger.kernel.org?

Many thanks!

						- Ted
