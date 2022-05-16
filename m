Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3935287B2
	for <lists+linux-ext4@lfdr.de>; Mon, 16 May 2022 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiEPO5h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 May 2022 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiEPO5h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 May 2022 10:57:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2123638787
        for <linux-ext4@vger.kernel.org>; Mon, 16 May 2022 07:57:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24GEvVdf017348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 10:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652713052; bh=RVsjfk/2hlum0vsC/s2w1X8YErKUG5ADjffcOphVXC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=L1Ul4wQsHnX8NU+ciDRxrXDkKtUHuIHdWn0wnZCo07yZBnaWqAF20HQtydjXhN6Hz
         J4v93M2b8j2nHTA8g1pQ2FeTd91RuuSL/5BnIZaqt93e1vSEH8kZntTqi/q+U6ZkBU
         ZlPRhX/PppvGGDg2EwA15k9gsaW850VA1P4slXutRmrltz1vX/UK6cbCVQcThcyxbY
         agsIarKU4Sj415FN4YrttzkSm/mHnOgKNa4zwG9YUITkBo4shRO3fiiv89qCxd/XEz
         MjpbIBNJ41QoK3Gm+5d+Lvs8L8McmTlzCC2JErNdzjHWV2XjxX4/dJ/DCkI0Ea7soe
         aWivKRZXpOPDA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F0D9F15C3EC0; Mon, 16 May 2022 10:57:30 -0400 (EDT)
Date:   Mon, 16 May 2022 10:57:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Lakshmipathi.G" <lakshmipathi.g@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: fast_commit option not recognized/supported by e2fsck?
Message-ID: <YoJmWmN6UMnzxLpI@mit.edu>
References: <CAKuJGC-uO-ywctcRH-i0UUfvzX3Yvep0kpSVi+FQXJjWgYMtdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKuJGC-uO-ywctcRH-i0UUfvzX3Yvep0kpSVi+FQXJjWgYMtdA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 16, 2022 at 03:00:14PM +0530, Lakshmipathi.G wrote:
> e2fsck 1.46.4 (18-Aug-2021)
> Using EXT2FS Library version 1.46.4, 18-Aug-2021
> $ uname -a
> Linux db 5.13.0-1022-aws #24~20.04.1-Ubuntu SMP Thu Apr 7 22:14:11 UTC
> 2022 aarch64 aarch64 aarch64 GNU/Linux
> 
> Now I did a reboot and the system hangs. It shows the following error
> message. Any thoughts on what's going wrong here? thanks!
> 
> ```
> Begin: Will now check root file system ... fsck from util-linux 2.34
> [/usr/sbin/fsck.ext4 (1) -- /dev/nvme0n1p2] fsck.ext4 -a -C0 /dev/nvme0n1p2
> /dev/nvme0n1p2 has unsupported feature(s): fast_commit
> e2fsck: Get a newer version of e2fsck!

E2fsck 1.46.4 supports fast commit.  I'm guessing what's going on is
that the version of e2fsck in the initial ramdisk is pre-1.46 and so
it didn't support fast commit --- and the root file system is checked
before it is mounted using scripts and binaries in the initrd.


After installing e2fsprogs, you need to update / recreate the
initramfs.  How to do this is distro-dependent, but since you are
using Ubuntu, try this:

   sudo update-initramfs -u -k all

See the man page for update-initramfs and mkinitramfs for more
information.

Cheers,

					- Ted

P.S.  fast commit is a relatively new feature, and we are still fixing
bugs in fast commit.  So please be careful before using it in a
production system, especially if it is mission- or life- critical.  If
you really want to use it, you may want to be using newer kernels than
5.13.0, such as 5.15 LTS.
