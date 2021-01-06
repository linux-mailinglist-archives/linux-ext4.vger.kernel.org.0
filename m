Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1492EC201
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 18:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbhAFRVT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 12:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbhAFRVT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Jan 2021 12:21:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7033123106;
        Wed,  6 Jan 2021 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953638;
        bh=tG483r6vSnH9q4KcPpc+fYsYrKAgLFenh4LOpI9MOeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrEv5AiFCg7oby6QMVQS2REt2mZxeBqgKabR3TufWYYR+rnHN/Y+pCL/etyHK8KY5
         yXuJIG8lSFwu9PDqysxCE0Wwv04s53xiA/21+EAN/EdrRfqpn2K/NcM0LPoevRC8YZ
         Zn6jf36KYBLxvLDfo8H+DlV1nsZpe6PLOqUj0eYM+DTTko+7JOUfd8CLw2+pvq7ZkG
         SDSEikynYeiOcdrodBp4lgEObuMnGCfEIHXpxuUUc6TTUIqV7A7Al7kps0BmLWZMWf
         Ca0nfbVxz3SaYqw/CaN8fBGbyRWZCeClW0NG7tJBRTH+ghblhrmqxCw4dDi2OBiljq
         YvohqFfz2gh3g==
Date:   Wed, 6 Jan 2021 17:20:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210106172033.GA2165@willie-the-truck>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106135253.GJ1551@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 06, 2021 at 01:52:53PM +0000, Russell King - ARM Linux admin wrote:
> On Wed, Jan 06, 2021 at 11:53:59AM +0000, Mark Rutland wrote:
> > ... and are you using defconfig or something else?
> 
> Not sure I replied to this. I'm not using the defconfig, I've my own
> .config
> 
> As I mentioned, Will has built a 5.10 kernel using Arnd's gcc 4.9.4
> and hasn't been able to reproduce it. He's sent me his kernel, which
> I've booted here, and haven't yet been able to provoke it.
> 
> Meanwhile, my 5.9 kernel continues to exhibit this problem, so I've
> sent Will my .config (which I'll include here.) There are differences
> in some of the block layer configuration. There's differences in the
> errata configuration, but we don't think that's a cause (they're not
> relevant for Cortex A72).
> 
> Our plan is:
> - Will is switching to 5.9, and using my config as a base for his
>   platform.
> - Will is going to send me his modified version of my config.
> - We are both going to build using the same kernel sources and same
>   config.
> - We are going to test our own kernels, and also swap kernel images
>   and test each others.
> 
> Watch this space for more news...

I've managed to reproduce the corruption on my AMD Seattle board (8x A57).
I haven't had a chance to dig deeper yet, but here's the recipe which works
for me:

1. I'm using GCC 4.9.4 simply to try to get as close as I can to rmk's
   setup. I don't know if this is necessary or not, but the toolchain is
   here:

   https://kernel.org/pub/tools/crosstool/files/bin/arm64/4.9.4/arm64-gcc-4.9.4-nolibc-aarch64-linux-gnu.tar.xz

   and I needed to pull down an old libmpfr to get cc1 to work:

   http://ports.ubuntu.com/pool/main/m/mpfr4/libmpfr4_3.1.2-1_arm64.deb

2. I build a 5.9 kernel with the config here:

   https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/bugs/rmk/config-5.9.0

   and the resulting Image is here:

   https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/bugs/rmk/Image-5.9.0

3. Using that kernel, I boot into a 64-bit Debian 10 filesystem and open a
   couple of terminals over SSH.

4. In one terminal, I run:

   $ while (true); do find /var /usr /bin /sbin -type f -print0 | xargs -0
     md5sum > /dev/null; echo 2 | sudo tee /proc/sys/vm/drop_caches; done

   (note that sudo will prompt you for a password on the first iteration)

5. In the other terminal, I run:

   $ while (true); do ./hackbench ; sleep 1; done

   where hackbench is built from:

   https://people.redhat.com/mingo/cfs-scheduler/tools/hackbench.c

   and compiled according to comment in the source code.

With that, I see the following after ten seconds or so:

  EXT4-fs error (device sda2): ext4_lookup:1707: inode #674497: comm md5sum: iget: checksum invalid

Russell, Mark -- does this recipe explode reliably for you too?

Will
