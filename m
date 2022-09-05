Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D255AD5A2
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Sep 2022 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiIEO7k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Sep 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiIEO7j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Sep 2022 10:59:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E5915FD8
        for <linux-ext4@vger.kernel.org>; Mon,  5 Sep 2022 07:59:36 -0700 (PDT)
Received: from letrec.thunk.org (guestnat-104-133-160-99.corp.google.com [104.133.160.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 285ExRdu022474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Sep 2022 10:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662389972; bh=UwsHZn1trNyS6AcH78fSQ9WX+c0KX/jmWK2SYfFJdD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=g7DQgMlZngE9ovkLvHaP0yaRXxdSewi+5nmvKtAhhmaNqJsgg4vQdH++txvwCwO6v
         luQHWgJwwZaqmkwvnqRHIhNUdMRFZ4n01Xm9VJhc8JMuADyjOYb6b3RpPlG9CRsuKB
         ls6aKLMEg93NzJIIka2ko1A267xh8S6zBb0xpXommpeOHTA3hCkJHIsO0xlCXAzOn0
         BzYT244Zr0wMgwyezOG3W/6uHoGsyY0KFn7/basMZRCw6VixpVwtA2Sb+KQDICkn+T
         HSUAYgKz8wQgFWD/Qpvf5htEumEog86DgeQjN/Nr/JTqoq7YwPOkbLEdIAzvtRnNBD
         ZebKudUO8Q3Ug==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 09A628C2B62; Mon,  5 Sep 2022 10:59:27 -0400 (EDT)
Date:   Mon, 5 Sep 2022 10:59:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: kvm-xfstests, adv test scenario, inode size-related failures
Message-ID: <YxYOzsbUw/TDGRsL@mit.edu>
References: <YxUGEewB0AdMPTfl@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxUGEewB0AdMPTfl@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 04, 2022 at 04:09:53PM -0400, Eric Whitney wrote:
> 
> I'm seeing a large number of test failures running 6.0-rc3 on the latest
> version of the test appliance in the adv test scenario.  All of these failures
> share a common feature - mke2fs fails to create a scratch file system using the
> inline option because the requested inode size is 128 bytes.  This didn't
> occur on the previous version of the test appliance.
> 
> It looks like /etc/mke2fs.conf contains an extra relation for the "small"
> stanza: "inode_size = 128".  This isn't present in mke2fs.conf in the
> previous version of the test appliance, nor does it appear to be in the latest
> master branch version of e2fsprogs (perhaps I'm looking in the wrong place)....

Whoops, thanks for reporting this.

What happened was that in the previous version of the test apppliance,
we were using a test version of e2fsprogs which was built from master
branch.  I built the kvm-xfstests images on a new build system, and it
was missing the bleedging-edge versions of e2fsprogs in the override
debs directory, so the image was using the Debian Stable (Bullseye)
version of e2fsprogs which is based on 1.46.2.  The Bullseyes/Backport
version of e2fsprogs is based on 1.46.5 and it would work fine.

Unfortunately, the package list for gce-xfstests and kvm-xfstests are
specified spearately, and while I had forced gce-xfstests to use the
backports version for e2fsprogs, I hadn't done so for kvm-xfstests.

> Deleting that line from /etc/mke2fs.conf on the latest version of the test
> appliance eliminates the failures (as does modifying ~/fs/ext4/conf/adv
> to specify a 256 byte inode size in the list of mkfs options).  The previous
> version of the test appliance applied the default mke2fs.conf value of 256
> for the inode size, so mke2fs didn't reject the request there.

I've fixed this in xfstests-bld:

commit 23020e266941c73928563554627a713d92462e70
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Mon Sep 5 09:10:46 2022 -0400

    test-appliance: install e2fsprogs from bullseye/backports in kvm-xfstests
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

But if you can just use the workaround of using "kvm-xfstests maint"
to edit the /etc/mke2fs.conf file, that's probably the best short-term
solution, since I hope to re-release new test appliances with the
latest e2fsprogs 1.46.0-rc0 shortly.  This will enable the "adv2" test
case, and ultimately, once we get 1.46.0 into bullseye/backports, I'll
probably change the adv test case to include the orphan_file feature
and make adv2 an alias for adv.

Cheers,

					- Ted
