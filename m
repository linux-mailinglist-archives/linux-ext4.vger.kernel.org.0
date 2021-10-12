Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1922B42ACEB
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhJLTFk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 15:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhJLTFj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 15:05:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EF8C061745;
        Tue, 12 Oct 2021 12:03:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f194200eaffd58d18ef125f.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:4200:eaff:d58d:18ef:125f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D4C41EC047E;
        Tue, 12 Oct 2021 20:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634063993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8Sp+eleeSlkMveboN9yGLXRy3+zpBsRKI2ycgGcwO+c=;
        b=Dm89jgCV6WyVafkaKnSrbYeHME2ZlsVKpzn3pepunFErqUQj/DXUAmY733EhvfF85Z//tP
        RYfWJqiFoAUJ4IDFwSavTIVHKru40OpOvQ36Wi8K1yoSd6tJ6NKgpj6apo02zXgFEdR/eZ
        AtDinE3Ab/7tVUiJpMA/GUateh9TiqY=
Date:   Tue, 12 Oct 2021 20:39:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: kernel BUG at fs/ext4/inode.c:1721!
Message-ID: <YWXWdlut+IW9eh8B@zn.tnic>
References: <YWANK0HchPv9m6hA@zn.tnic>
 <20211008173305.GA28198@localhost.localdomain>
 <YWCL2OXaz8/OnBiF@zn.tnic>
 <20211011231124.GB17897@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211011231124.GB17897@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 11, 2021 at 07:11:24PM -0400, Eric Whitney wrote:
> I've tried numerous kernel builds with -rc4 and rerun the full set of xfstests
> we use when regressing ext4 each rc using a kernel that doesn't enable
> FS_ENCRYPTION (I normally run with that) without luck.  The code that caused
> the splat you saw is new and would run when an assertion is violated,
> suggesting that there may be an unsuspected bug elsewhere in ext4.

Hmm.

> Do you recall having seen any evidence of ENOMEM or ENOSPC conditions prior
> to the failure?

I don't see anything of the sorts in the dmesg I've saved.

> If you're willing to share, please send along your kernel config file and I'll
> try working with that as well.

Sure, I'll send you the config I used and the dmesg I caught privately -
you might see something I've missed. Stuff like this, for example:

[   10.254952] Adding 15721468k swap on /dev/nvme0n1p1.  Priority:-2 extents:1 across:15721468k SS
[   10.275365] EXT4-fs (nvme0n1p2): re-mounted. Opts: errors=remount-ro. Quota mode: disabled.
[   10.417820] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
[   10.595392] loop: module loaded
[   10.661742] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.
[   10.758774] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.
[   10.930331] r8169 0000:18:00.0 eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[   10.939298] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   13.306747] EXT4-fs (sdb1): recovery complete
[   13.325960] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.
[   13.353624] EXT4-fs (nvme1n1p1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.
[  191.896690] loop0: detected capacity change from 0 to 2048
[  191.941350] EXT4-fs (dm-0): mounting ext2 file system using the ext4 subsystem
[  191.948773] EXT4-fs (dm-0): mounted filesystem without journal. Opts: (null). Quota mode: disabled.
[  282.932355] fuse: init (API version 7.34)
[ 3159.620840] loop1: detected capacity change from 0 to 4194304
[ 3160.125963] EXT4-fs (dm-1): mounting ext3 file system using the ext4 subsystem
[ 3160.203143] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.

Dunno if using ext4 to mount ext2 and ext3 filesystems would be
relevant.

> In the meantime, should this bug get in your way, just revert the following
> patch and you should be able to run without further trouble:
> 
> 948ca5f30e1d "ext4: enforce buffer head state assertion in ext4_da_map_blocks"
> 
> I'll likely be posting a patch to revert this shortly, since it's going to
> take some time to sort out what's going on without a reproducer.

Gotcha.

> Thanks again for your help,

Thanks too for taking a look.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
