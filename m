Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC94F63C0
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Apr 2022 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiDFPk3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Apr 2022 11:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiDFPkU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Apr 2022 11:40:20 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F05713C702
        for <linux-ext4@vger.kernel.org>; Wed,  6 Apr 2022 05:55:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 236CmZRl002521
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Apr 2022 08:48:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5539815C3EC0; Wed,  6 Apr 2022 08:48:35 -0400 (EDT)
Date:   Wed, 6 Apr 2022 08:48:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Kiselev, Oleg" <okiselev@amazon.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: e2fsprogs builds and installs obsolete version of blkid
Message-ID: <Yk2MI/UNYWDNFVx+@mit.edu>
References: <4EF2E5CC-E4E7-4463-893C-274EA9535EC1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EF2E5CC-E4E7-4463-893C-274EA9535EC1@amazon.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_05,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 05, 2022 at 11:15:22PM +0000, Kiselev, Oleg wrote:
> The e2fsprogs contains a version 1.0.0 of `blkid`.  This version
> does not support flags that the current kernel install scripts pass
> to `blkid`.  By building and installing e2fsprogs I ended up
> replacing blkid 2.30.2 with 1.0.0, which broke kernel packaging.
> This is easily fixed by doing `yum reinstall util-linux`, which
> reinstalls the correct version blkid.
> 
> This mess could be avoided if e2fsprogs either included a more
> modern version of blkid, or perhaps did not include blkid at all,
> since a more current version of this utility is maintained and
> installed through other packages.
> 
> (Finding https://forums.centos.org/viewtopic.php?t=69655 helped a lot in figuring out why my kernel build started failing all of a sudden)

The blkid and uuid libraries were moved from e2fsprogs from util-linux
on most Linux distributions.  However, these libraries are still
needed to compile e2fsprogs, and they are needed for non-Linux
operating systems, including FreeBSD, Illumos, etc., and some Linux
systems, such as Android.  That's why they haven't been removed.

If you install the RHEL/Fedora packages libblkid-devel and
libuuid-devel before you run run e2fsprogs's configure script, then it
will use the system versions of libblkid and libuuid, which will do
the right thing.

(For Debian / Ubuntu the packages names are libblkid-dev and uuid-dev,
but for these distributions it's better to just run
"dpkg-buildpackage" since that will automatically build the Debian
packages with all of the correct configure options via the
debian/rules file, and the Build-Depends: declaration in
debian/control will automatically enforce that you have all of the
correct build prerequites installed.)

If you hand done the simple thing that most novice users do, which is
to just run "./configure ; make", then the binaries will statically
link the old versions of blkid and uuid and that will work as well.
You just ran into the case where (a) you knew enough to enable ELF
share libraries, but (b) didn't know enough to install the system
libraries instead, and (c) then did a "make install" instead of using
a package manager to mediate installation of the programs.

I'm sorry that happened to you, but it's a relatively rare
combination, and the fact remains that there are other users of
e2fsprogs besides Linux, and unfortunately, many open source packages,
including util-linux and systemd, suffer from the "All The World Runs
Linux" disease, which seems to be an updated form of the disease, "All
the World's a Vax"[1].  (This is also why it would take more work than
it's worth to try to backport newer versions of blkid into e2fsprogs.)

Cheers,

      	   	       	    	      - Ted

[1] From: https://www.lysator.liu.se/c/ten-commandments.html

    Commandment #10:
       Thou shalt foreswear, renounce, and abjure the vile heresy which
       claimeth that ``All the world's a VAX'', and have no commerce with
       the benighted heathens who cling to this barbarous belief, that
       the days of thy program may be long even though the days of thy
       current machine be short.
    
    This particular heresy bids fair to be replaced by ``All the
    world's a Sun'' or ``All the world's a 386'' (this latter being a
    particularly revolting invention of Satan), but the words apply to
    all such without limitation. Beware, in particular, of the subtle
    and terrible ``All the world's a 32-bit machine'', which is almost
    true today but shall cease to be so before thy resume grows too
    much longer.

