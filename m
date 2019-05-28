Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29BEB2BEE8
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 07:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfE1F6Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 May 2019 01:58:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55449 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfE1F6P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 May 2019 01:58:15 -0400
Received: by mail-it1-f195.google.com with SMTP id g24so2328794iti.5;
        Mon, 27 May 2019 22:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=odR3o6CMyRH3wObElyo5BKximj0lALrUbiN5mIFDiWM=;
        b=ktSRR/kzcbwIESnMhqdmv2FDSiujXQz3ez+OhDejezkWBn3GD/Z3VZxLoh11anoIzl
         OBjtzYJq35FPVqVB9AH+JaNW5T3VtISXvVtPVon4v4DunsD/m7326n0VfEIou8ZVjD6D
         JV4PS/3HFkew8CfuDSmKdCmNs/LpvzB9e9M6dCp7jdK7fgSguN/hSM7zPExBUxqwtTqM
         ROb5alazkJ+Yi8VsZY+aLteSXTKm/KHsl9Z74beaoWenfyiBePeZN2yPpuPSlQGrh1EH
         8kUjdoIFOMPX53IMKhZykE7QhO3zS2PnWFllKKR3NPknYKRwgw7lB6uWIh5lIP6c6Qjf
         VoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=odR3o6CMyRH3wObElyo5BKximj0lALrUbiN5mIFDiWM=;
        b=ByZHbj5s1YpmIiWqy8jsxyLsETJgyrvCAVeMB29QekGbtUGN3nivEb1oDpARAJA6ND
         SxmuS2HcX5wLuQqrlDLY1UI7WXy1+BoNxRLOG7Lcet+FCYWtxTiB8yvWdBovV9y6/Yy/
         txtz116VH3meRizwEwB44ZPgSOUThcrje5JVf6NXjfGlwzBf+BQpDXZHCvti9rTVsoHf
         t4oKmF8VVATNlHAvh71R0s2Tg4W6ztBhzn071tdUkdkjEYE29CgUsJ7puz3KdhFcWkBI
         7EyVTfrIEYx6m7ZvP6u+BYNwyyuqrtllDii4MmBgvXw13fesr/SSC0+1jWVI+xt7Z4bv
         719Q==
X-Gm-Message-State: APjAAAVUfldqtoh91ghPj3KbiBTt7VaCToUzBeDY6ZP2GQl8+cSCCZKs
        fRmS71D38/8E3wpkQx6kW6Fk1df2TVebtw7A1FiPKSKrlSE=
X-Google-Smtp-Source: APXvYqwBUNTDDSl/fu7eVxGiQw2CLUqCg3XeJOmgxVZ4RyS2IOjJ/bQ/1phmC+6OwaW9oh9IE2lppa+uNxqTI5ibFL4=
X-Received: by 2002:a24:5094:: with SMTP id m142mr1960400itb.96.1559023094144;
 Mon, 27 May 2019 22:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNPMSQgBjnFarYaxuQEGpA1G=U4U9OHqT0E53pNL2BK8g@mail.gmail.com>
 <CABXGCsNV6EQq0EG=iO8mWCCv9da__9iyLmwyzS3nGtjjvhShfg@mail.gmail.com> <CABXGCsNvYVL6SMO_0PXxiZwWJyBi3rD-jjxnmnY3KL0M7haJbA@mail.gmail.com>
In-Reply-To: <CABXGCsNvYVL6SMO_0PXxiZwWJyBi3rD-jjxnmnY3KL0M7haJbA@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 28 May 2019 10:58:03 +0500
Message-ID: <CABXGCsOvTyL5W1qm0DzTuS4juo6ya+XSxMESGsP2RqtSSzpdfg@mail.gmail.com>
Subject: Re: [bugreport] kernel 5.2 pblk bad header/extent: invalid extent entries
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 27 May 2019 at 21:16, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> I am bisected issue. I hope it help understand what is happened on my computer.
>
> $ git bisect log
> git bisect start
> # good: [e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd] Linux 5.1
> git bisect good e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd
> # bad: [7e9890a3500d95c01511a4c45b7e7192dfa47ae2] Merge tag
> 'ovl-update-5.2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs
> git bisect bad 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
> # good: [80f232121b69cc69a31ccb2b38c1665d770b0710] Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
> git bisect good 80f232121b69cc69a31ccb2b38c1665d770b0710
> # good: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag
> 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
> git bisect good a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
> # good: [ea5aee6d97fd2d4499b1eebc233861c1def70f06] Merge tag
> 'clk-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good ea5aee6d97fd2d4499b1eebc233861c1def70f06
> # good: [47782361aca21a32ad4198f1b72f1655a7c9f7e5] Merge tag
> 'tag-chrome-platform-for-v5.2' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux
> git bisect good 47782361aca21a32ad4198f1b72f1655a7c9f7e5
> # bad: [55472bae5331f33582d9f0e8919fed8bebcda0da] Merge tag
> 'linux-watchdog-5.2-rc1' of
> git://www.linux-watchdog.org/linux-watchdog
> git bisect bad 55472bae5331f33582d9f0e8919fed8bebcda0da
> # good: [4dbf09fea60d158e60a30c419e0cfa1ea138dd57] Merge tag
> 'mtd/for-5.2' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> git bisect good 4dbf09fea60d158e60a30c419e0cfa1ea138dd57
> # good: [44affc086e6d5ea868c1184cdc5e1159e90ffb71] watchdog:
> ts4800_wdt: Convert to use device managed functions and other
> improvements
> git bisect good 44affc086e6d5ea868c1184cdc5e1159e90ffb71
> # good: [5c09980d9f9de2dc6b255f4f0229aeff0eb2c723] watchdog:
> imx_sc_wdt: drop warning after calling watchdog_init_timeout
> git bisect good 5c09980d9f9de2dc6b255f4f0229aeff0eb2c723
> # good: [345f16251063bcef5828f17fe90aa7f7a5019aab] watchdog: Improve
> Kconfig entry ordering and dependencies
> git bisect good 345f16251063bcef5828f17fe90aa7f7a5019aab
> # good: [988bec41318f3fa897e2f8af271bd456936d6caf] ubifs: orphan:
> Handle xattrs like files
> git bisect good 988bec41318f3fa897e2f8af271bd456936d6caf
> # good: [a65d10f3ce657aa4542b5de78933053f6d1a9e97] ubifs: Drop
> unnecessary setting of zbr->znode
> git bisect good a65d10f3ce657aa4542b5de78933053f6d1a9e97
> # good: [a9f0bda567e32a2b44165b067adfc4a4f56d1815] watchdog: Enforce
> that at least one pretimeout governor is enabled
> git bisect good a9f0bda567e32a2b44165b067adfc4a4f56d1815
> # bad: [d7a02fa0a8f9ec1b81d57628ca9834563208ef33] Merge tag
> 'upstream-5.2-rc1' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
> git bisect bad d7a02fa0a8f9ec1b81d57628ca9834563208ef33
> # good: [04d37e5a8b1fad2d625727af3d738c6fd9491720] ubi: wl: Fix
> uninitialized variable
> git bisect good 04d37e5a8b1fad2d625727af3d738c6fd9491720
> # first bad commit: [d7a02fa0a8f9ec1b81d57628ca9834563208ef33] Merge
> tag 'upstream-5.2-rc1' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
>



Why no one answers?
Even if the problem is known and already fixed, I would be nice to
know that I spent 10 days for searching a problem commit not in vain
and someone reads my messages.


--
Best Regards,
Mike Gavrilov.
