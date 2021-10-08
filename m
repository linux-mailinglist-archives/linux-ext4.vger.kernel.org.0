Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465BD4270A7
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 20:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbhJHSWM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Oct 2021 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhJHSWI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Oct 2021 14:22:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64492C061570;
        Fri,  8 Oct 2021 11:20:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d56005271a08b055a2ed3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5600:5271:a08b:55a:2ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4E151EC04BF;
        Fri,  8 Oct 2021 20:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633717211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WZ2vyr0bBr+0bKupnx3Iy+0X8ZvgkkgNmebhnhZ/6g8=;
        b=Zs7KHzgscT85XNZEJxf7YDbb4ZZKjw8qP1ieDUC4ZZsFc0HQAhEU717wghNpamCsyi8Qhx
        xs2ghinI+EYufAtxpxtj62fVN5A7WMsNFdkvvuLpqEDpcta0Ern3YchCXKMNHP/jnk+KXP
        q/Y1t3MRmzFILb8mc5LIw3QmXB2ATu8=
Date:   Fri, 8 Oct 2021 20:20:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: kernel BUG at fs/ext4/inode.c:1721!
Message-ID: <YWCL2OXaz8/OnBiF@zn.tnic>
References: <YWANK0HchPv9m6hA@zn.tnic>
 <20211008173305.GA28198@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008173305.GA28198@localhost.localdomain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Eric,

On Fri, Oct 08, 2021 at 01:33:05PM -0400, Eric Whitney wrote:
> Hi, Boris - thanks very much for your report.

sure, np.

> Was your kernel configured with the CONFIG_FS_ENCRYPTION option?

$ grep CONFIG_FS_ENCRYPTION /boot/config-5.15.0-rc4+ 
# CONFIG_FS_ENCRYPTION is not set

> Could you please provide the output of the mount command for the affected
> file system?

Well, I can't figure out from dmesg - it's all I have from that run -
which fs it was. So lemme give you all ext4 ones:

$ mount | grep ext4
/dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)
/dev/sdc1 on /home type ext4 (rw,noatime)
/dev/sda1 on /mnt/oldhome type ext4 (rw,noatime)
/dev/sdb1 on /mnt/smr type ext4 (rw,noatime)
/dev/nvme1n1p1 on /mnt/kernel type ext4 (rw,nosuid,nodev,noatime,user)

> Do you recall what sort of code might have been running on this system at
> the time of failure (for example, kernel build, desktop apps, etc.)?

Good question. I'm not sure. Kernel build is likely as I do those on
that workstation constantly.

Unfortunately, I don't have an exact reproducer. And I can't debug stuff
on that box since it is my workstation and I've reverted it to 5.14.

What I can do is, I can slap 5.15-rc4 or whichever version you'd want me
to, on a test box and try running kernel builds or some other load to
see whether it would fire. I have a similar box to my workstation.

Or if you have a better idea...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
