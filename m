Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1FA3259D
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 01:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFBXSl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 2 Jun 2019 19:18:41 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38830 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfFBXSk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 2 Jun 2019 19:18:40 -0400
Received: by mail-yb1-f195.google.com with SMTP id x7so3404436ybg.5;
        Sun, 02 Jun 2019 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ldwIwvPo/ZsJBFE5IYIbOzrH4aPsDsSqzA+e7DVNyM=;
        b=iDZZmSrKYO4VS5Jhy8U04FpBqWow5Sz+ouQ+hMw2fsr81T67nd7O5RfHWUn3jUBXuZ
         KUV4VLknSXr0+kkerK/7ltQl4H6y1rDJUCMnlj3lyuGXHK333pXjfSgnjzw8S5CG96Cm
         BYTR1QeoCEXG37f4GOQiywLxw2uHCzLLPJuQ08ebVbdDMP0WdbYzyQIz2H62CNgPXs9b
         HeV8K3X8ztSuO8V4895u6aRmOxhdtloRsbfgEyDiWeM5LWzpl8PqJ1xEumMkgTMMR6TT
         +PAemwKB4DM/xcfCbSZdA/3/DLg6b4KZ2WgsjclWbmj3azFfCIWV2MUjV2fvFl5zz5wy
         HYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ldwIwvPo/ZsJBFE5IYIbOzrH4aPsDsSqzA+e7DVNyM=;
        b=FKgOuqqBgRED1L3176sOlyXH1n+4BcFpM0D6gySO1mQm5h2mLEclHj8FtpIWDltmfY
         mD7sAC2zJC/TgEEUaMU6BjPHJAeQJamFGkNAtC8k36nd/3ZZYxtZXGTgMQ2+oz4esspY
         oKb6AuTULUZxlb6qKgyuasZKBKJmunwXQE8PWCW36E1NMGOpvuXxHDPCQMM29+nroJg7
         I6wkupNbld5zqw19mwmPePK6mXkw+Xq5xpBiYTRcKeZDWgYTDijqninY7UlUysL/fGiG
         7WQLb9BB2+i1W6VJPbDhj91V2xPSHrb3CKMgYD/Ve4thn6KmJWtlyiIVk4C3nTuEwMcm
         nBng==
X-Gm-Message-State: APjAAAV/Uk0gNacxoa24xq7K6HXUTE+99ojpwljs3E0AXtzDKa3T7FF9
        WpAoPrX0lBKeL/hjOsZEFmAmrfYvyGPV2FToKJo=
X-Google-Smtp-Source: APXvYqzr2J/6lfD+FkzRVvuHirVtNX9mAetJi66OVfbG9Jaau0FlvzPdibYncwFTE3Iv41vihiklFA7lgPIowlTnN7s=
X-Received: by 2002:a25:d946:: with SMTP id q67mr10448201ybg.126.1559517519473;
 Sun, 02 Jun 2019 16:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2+hP4Q3i4LdKL2Cz=1uWq0+JSD1RnzcdmicDtCeqEUqLo+hg@mail.gmail.com>
 <CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com> <20190602180057.GA4865@mit.edu>
In-Reply-To: <20190602180057.GA4865@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 3 Jun 2019 02:18:25 +0300
Message-ID: <CAOQ4uxhbSc0nZ69ffJVfNgVnr=ahg+HetiXcZKMXA2nXKCabqA@mail.gmail.com>
Subject: Re: which lower filesystems are actually supported?
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Marco Nelissen <marco.nelissen@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 2, 2019 at 9:01 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Jun 02, 2019 at 09:42:54AM +0300, Amir Goldstein wrote:
> > [+cc ext4] Heads up on bug reports "Overlayfs fails to mount with ext4"
> >
> > On Sat, Jun 1, 2019 at 11:02 PM Marco Nelissen <marco.nelissen@gmail.com> wrote:
> > >
> > > According to the documentation, "The lower filesystem can be any filesystem
> > > supported by Linux", however this appears to not actually be the case, since
> > > using a vfat filesystem results in the mount command printing "mount:
> > > wrong fs type, bad option, bad superblock on overlay, missing codepage or
> > > helper program, or other error", with dmesg saying "overlayfs: filesystem on
> > > '/boot' not supported".
> > > (that's from ovl_mount_dir_noesc(), when ovl_dentry_weird() returns nonzero)
> >
> > Specifically for vfat it is weird because of
> > dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE)
> > because it is case insensitive.
>
[...]
> >
> > I am guessing when people start using case insensitive enabled ext4,
> > this problem
> > is going to surface, because the same ext4 (e.g. root fs) could be
> > used for samba
> > export (case insensitive) and docker storage (overlayfs).
>
[...]
>
> We *might* be able to only set the dentry functions on directory
> entries belonging to directories which have the casefold flag set,
> instead of simply setting it on all ext4 dentry entries.  But still
> won't change the fact that overlayfs is going to have case
> insensitivity support if we want the combination of overlayfs &&
> casefold to be supported.
>

My intention was not that overlayfs should support casefold, just that
an isolated casefold subdir in an ext4 fs shouldn't make the entire fs
not usable with overlayfs.

Incidentally, we already ran into a similar issue with ext4 encryption.
Issue was reported by OpenWRT developers and fixed by:
d456a33f041a fscrypt: only set dentry_operations on ciphertext dentries

I recon casefold is taking a similar direction to the fs/crypto library, so
solution should be similar as well.

BTW, is casefold feature mutually exclusive with encryption feature?
Because if it isn't, d_set_d_op() in __fscrypt_prepare_lookup() is
going to WARN_ON dentry already has ext4_dentry_ops.

Thanks,
Amir.
