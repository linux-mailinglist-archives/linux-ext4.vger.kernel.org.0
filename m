Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881EA2EC2AF
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 18:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbhAFRqu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 12:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbhAFRqu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jan 2021 12:46:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB8C06134C;
        Wed,  6 Jan 2021 09:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yg/yc1gkRipPRCPATrDmoHEixH/ByfJCw5yp10C32Mw=; b=iLVcD3MNntOoNsrc0twA4vn/2
        dcdOulHlRF7RTJYqGc7d5mZGg13191U1JDHaH1aIqf0pRRtwAn4Pg1OGDHAYNhOHfFFmLH+amL9ms
        4EiYNSBK6NJmg8NG9un8MeQv/3HgXzySX/tEQV9F7Knv5+ubCrSEHJk7TY8P22yr5hw67KlcwBlgc
        9vGwVl8roCskmgHfp670zsadJr6CNkw6tlfM2hEjxpx3i4UHkNRhIRFC2hccL84FAeYy5mrY4OM/l
        W/qZ5Y43ELnfV5RDxklcOm8Ml/c/S0qL1u7UtdrDffTeQHle9+ErM3cLTUW6jHHcUawXNmjh7xYbY
        4ZtL9/bmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45192)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kxCso-0001rk-Pm; Wed, 06 Jan 2021 17:46:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kxCsn-0000QR-Qs; Wed, 06 Jan 2021 17:46:05 +0000
Date:   Wed, 6 Jan 2021 17:46:05 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210106174605.GL1551@shell.armlinux.org.uk>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106172033.GA2165@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 06, 2021 at 05:20:34PM +0000, Will Deacon wrote:
> I've managed to reproduce the corruption on my AMD Seattle board (8x A57).
> I haven't had a chance to dig deeper yet, but here's the recipe which works
> for me:
> 
> 1. I'm using GCC 4.9.4 simply to try to get as close as I can to rmk's
>    setup. I don't know if this is necessary or not, but the toolchain is
>    here:
> 
>    https://kernel.org/pub/tools/crosstool/files/bin/arm64/4.9.4/arm64-gcc-4.9.4-nolibc-aarch64-linux-gnu.tar.xz
> 
>    and I needed to pull down an old libmpfr to get cc1 to work:
> 
>    http://ports.ubuntu.com/pool/main/m/mpfr4/libmpfr4_3.1.2-1_arm64.deb
> 
> 2. I build a 5.9 kernel with the config here:
> 
>    https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/bugs/rmk/config-5.9.0
> 
>    and the resulting Image is here:
> 
>    https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/bugs/rmk/Image-5.9.0
> 
> 3. Using that kernel, I boot into a 64-bit Debian 10 filesystem and open a
>    couple of terminals over SSH.
> 
> 4. In one terminal, I run:
> 
>    $ while (true); do find /var /usr /bin /sbin -type f -print0 | xargs -0
>      md5sum > /dev/null; echo 2 | sudo tee /proc/sys/vm/drop_caches; done
> 
>    (note that sudo will prompt you for a password on the first iteration)
> 
> 5. In the other terminal, I run:
> 
>    $ while (true); do ./hackbench ; sleep 1; done
> 
>    where hackbench is built from:
> 
>    https://people.redhat.com/mingo/cfs-scheduler/tools/hackbench.c
> 
>    and compiled according to comment in the source code.
> 
> With that, I see the following after ten seconds or so:
> 
>   EXT4-fs error (device sda2): ext4_lookup:1707: inode #674497: comm md5sum: iget: checksum invalid
> 
> Russell, Mark -- does this recipe explode reliably for you too?

It took a couple of iterations of the find loop (4) here on a kernel
where I'd dropped BLK_WBT=y from my .config... whereas I wasn't able
to provoke it before. So running hackbench in parallel seems to
increase the probability.

I rebooted, set it going again, and on the first iteration it exploded
with ext4 inode checksum failure. And again on the following reboot.
So yes, it looks like you've found a way to more reliably reproduce
it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
