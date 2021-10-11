Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC224299A7
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 01:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbhJKXN2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 19:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhJKXN2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Oct 2021 19:13:28 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D5C061570;
        Mon, 11 Oct 2021 16:11:27 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c7so17895228qka.2;
        Mon, 11 Oct 2021 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6MEGfH0hL9/oeXXsdllzYyVOfG604h9YDXxJhS4oZDM=;
        b=jo03eI7iVBVSZFo2Mys3hVqkELAk2ME9kTyxazmWWYFlzOWAqJxuAQT2cHYjC+9BiH
         reU2umZpV3lzTZNGA3BMHolh5GxnvlyOFwgCj8v6LFCvWXmthGj0CQJUCYzTCo52tyXN
         jRNpHJhsPIRPhQ5y6NpxBUbIhgQlkLcT2+bV5welOAm5G1eJ/7/5Olfgvhks9rcP9noZ
         HYXoS8WjCg/o7+0CXSf60pkAH5XGfESciyko40S582Y1beV8osvK4OiDU7RDgYCnBd4N
         CxT6Da+DC7GBPC8+Hvuezj8a9GVGKb9R7PxlWbb4v5xg+jJQp5UNR3hzVOtWbfvd1g2p
         dYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6MEGfH0hL9/oeXXsdllzYyVOfG604h9YDXxJhS4oZDM=;
        b=DtAlnmFXU1LJd81PtLT209rPYF3RcLK3RGbdQaotqzrN3QbAFtxaCbYmYOY8Mggau+
         Nc9HxeCbYRiFr2Pgt+h0ANIABbJFaVHKWoQbmEhb3fnjVd3QOl0dcGJWW4A4y+jzFd95
         HuxZDvJj41Uy2gI4oM2279SarQ3tzaSPFdsjXLFrZ/mutp6B9+ipwgkodfmtMzsI+S5t
         Tkx8kJDHsQSqFJUhm+oan7hfgo1FXGkrvkUElfHA+L15Sbrs0GAFE9eelbAqz9jaLETp
         DedNPou/qDem2p2TAkocW8m3qlYyapjicFEEDAUNDDTHCh/jEL6qSBltc/d+845AnYG5
         vVMg==
X-Gm-Message-State: AOAM531UN5vDSXehXELkKLiXwZO45f6x36FgaXbWyGEIi9n5mW6swfa+
        A1wffua8X/V/0FZUhs5WNTU=
X-Google-Smtp-Source: ABdhPJzOLQrBvZXH6sMBoOOsipKnP5T/uXVxwDVNFZaBqH7F4OlIWcRmuSuyiyefjpq0AGyBqooAXQ==
X-Received: by 2002:a37:9fc6:: with SMTP id i189mr17243267qke.467.1633993886997;
        Mon, 11 Oct 2021 16:11:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id v3sm4957667qkd.20.2021.10.11.16.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 16:11:26 -0700 (PDT)
Date:   Mon, 11 Oct 2021 19:11:24 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: kernel BUG at fs/ext4/inode.c:1721!
Message-ID: <20211011231124.GB17897@localhost.localdomain>
References: <YWANK0HchPv9m6hA@zn.tnic>
 <20211008173305.GA28198@localhost.localdomain>
 <YWCL2OXaz8/OnBiF@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWCL2OXaz8/OnBiF@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Borislav Petkov <bp@alien8.de>:
> Hi Eric,
> 
> On Fri, Oct 08, 2021 at 01:33:05PM -0400, Eric Whitney wrote:
> > Hi, Boris - thanks very much for your report.
> 
> sure, np.
> 
> > Was your kernel configured with the CONFIG_FS_ENCRYPTION option?
> 
> $ grep CONFIG_FS_ENCRYPTION /boot/config-5.15.0-rc4+ 
> # CONFIG_FS_ENCRYPTION is not set
> 
> > Could you please provide the output of the mount command for the affected
> > file system?
> 
> Well, I can't figure out from dmesg - it's all I have from that run -
> which fs it was. So lemme give you all ext4 ones:
> 
> $ mount | grep ext4
> /dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)
> /dev/sdc1 on /home type ext4 (rw,noatime)
> /dev/sda1 on /mnt/oldhome type ext4 (rw,noatime)
> /dev/sdb1 on /mnt/smr type ext4 (rw,noatime)
> /dev/nvme1n1p1 on /mnt/kernel type ext4 (rw,nosuid,nodev,noatime,user)
> 
> > Do you recall what sort of code might have been running on this system at
> > the time of failure (for example, kernel build, desktop apps, etc.)?
> 
> Good question. I'm not sure. Kernel build is likely as I do those on
> that workstation constantly.
> 
> Unfortunately, I don't have an exact reproducer. And I can't debug stuff
> on that box since it is my workstation and I've reverted it to 5.14.
> 
> What I can do is, I can slap 5.15-rc4 or whichever version you'd want me
> to, on a test box and try running kernel builds or some other load to
> see whether it would fire. I have a similar box to my workstation.
> 
> Or if you have a better idea...

Hi, Boris:

I've tried numerous kernel builds with -rc4 and rerun the full set of xfstests
we use when regressing ext4 each rc using a kernel that doesn't enable
FS_ENCRYPTION (I normally run with that) without luck.  The code that caused
the splat you saw is new and would run when an assertion is violated,
suggesting that there may be an unsuspected bug elsewhere in ext4.

Do you recall having seen any evidence of ENOMEM or ENOSPC conditions prior
to the failure?

If you're willing to share, please send along your kernel config file and I'll
try working with that as well.

In the meantime, should this bug get in your way, just revert the following
patch and you should be able to run without further trouble:

948ca5f30e1d "ext4: enforce buffer head state assertion in ext4_da_map_blocks"

I'll likely be posting a patch to revert this shortly, since it's going to
take some time to sort out what's going on without a reproducer.

Thanks again for your help,
Eric

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
