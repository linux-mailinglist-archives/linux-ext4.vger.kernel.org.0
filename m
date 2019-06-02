Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A532258
	for <lists+linux-ext4@lfdr.de>; Sun,  2 Jun 2019 09:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFBHIy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 2 Jun 2019 03:08:54 -0400
Received: from mail-yw1-f42.google.com ([209.85.161.42]:37425 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBHIy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 2 Jun 2019 03:08:54 -0400
Received: by mail-yw1-f42.google.com with SMTP id 186so6036514ywo.4;
        Sun, 02 Jun 2019 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X84XQkIIhbzI/1DrC38YNb+tCYYcuI5s2GMEjO0K2to=;
        b=OxNu1MMI2QkEm+n3L6Rbku4wAiO2MmO64eCgYg81FhnHH/YrXNPeP2g/U5UjYP8ffD
         sxO3+I8wVG1Up1X/yvP0tXl0kK21lQIYxtspWDCVgOlgNd+6i8mft1A3d5CeLOz6ZHH3
         TdGWpP+FvpTBtoeFPRYLPk/FUTJ3mFPvMD/E1zRnssiooScmuumrV0nTxyUHi1d0mM4P
         MjmWvDRfD8Zsnaym5+bzrjN+YP09IPdwGU5Se/IEdoAi0KnRZd0h5CkSz+c2ih9i8FuZ
         0Om86L5wMFq+adq6ZO2HwfaPmIHDbV3E040eOSrsPwoxpF4LEh4d8MqKo71vdM0329B7
         egCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X84XQkIIhbzI/1DrC38YNb+tCYYcuI5s2GMEjO0K2to=;
        b=h3Kr4WoeFD6ycf3PLHYG9T9R6x9WWK2ouxsBelEtMxkYJCHXdR01rbo5tvA5XbgTRx
         8jqyMKG6VVpVuic299EwLpcSkbqV9ETWFGeLDtW6BNFLleQjEs4NCBBYcnIaLX33CipM
         negRY8TSTpKBH1HM+sMuweIxyXXoI6mMEqicVs4/QdqIQRreBWbRfxFcefiEjP7hS6uk
         kgDwFpzvnWvBLvgfkXaeENxuuUMKmB7ANT54PqICpbCQ1+TwYJ9AaJL2+NoL16TPb9nq
         1Fj0GFw+009OjncIEx3IBuo7sxncJLCSiI97jptmZgbj5xOPhM4L0aQGkcHM7gN7+mLk
         d6Pg==
X-Gm-Message-State: APjAAAUVJ14zEXsKtMRohkmJ6d+5WK6jG1A1CNN/MOAra6OPF1zbFAOD
        Qav+/8VxnGMLTpdgr1mGt0kVceQavOnIlY6wVzk=
X-Google-Smtp-Source: APXvYqxc5K/+oFNG6Dgba9/QmX9G0xdErSwsOyQfQGXHLb2n5OaNmAowf5jl/7CUMBNGLhJ90VbKp2NUAoQEm05wySk=
X-Received: by 2002:a81:3956:: with SMTP id g83mr10411312ywa.183.1559457785607;
 Sat, 01 Jun 2019 23:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2+hP4Q3i4LdKL2Cz=1uWq0+JSD1RnzcdmicDtCeqEUqLo+hg@mail.gmail.com>
In-Reply-To: <CAH2+hP4Q3i4LdKL2Cz=1uWq0+JSD1RnzcdmicDtCeqEUqLo+hg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 2 Jun 2019 09:42:54 +0300
Message-ID: <CAOQ4uxgPXBazE-g2v=T_vOvnr_f0ZHyKYZ4wvn7A3ePatZrhnQ@mail.gmail.com>
Subject: Re: which lower filesystems are actually supported?
To:     Marco Nelissen <marco.nelissen@gmail.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[+cc ext4] Heads up on bug reports "Overlayfs fails to mount with ext4"

On Sat, Jun 1, 2019 at 11:02 PM Marco Nelissen <marco.nelissen@gmail.com> wrote:
>
> According to the documentation, "The lower filesystem can be any filesystem
> supported by Linux", however this appears to not actually be the case, since
> using a vfat filesystem results in the mount command printing "mount:
> wrong fs type, bad option, bad superblock on overlay, missing codepage or
> helper program, or other error", with dmesg saying "overlayfs: filesystem on
> '/boot' not supported".
> (that's from ovl_mount_dir_noesc(), when ovl_dentry_weird() returns nonzero)

Specifically for vfat it is weird because of
dentry->d_flags & (DCACHE_OP_HASH | DCACHE_OP_COMPARE)
because it is case insensitive.

>
> Should vfat be supported, or is the documentation wrong? If the documentation

Documentation is wrong.

> is wrong, what other filesystems are (not) supported?

There are some special cases like /proc/sys and auto mount points,
but the most common reason for unsupported lower is case insensitive filesystems
and filesystems that support unicode character folding.
Those filesystems MAY be case insensitive/unicode, depending on
mkfs/mount options:
 adfs affs cifs efivarfs fat hfs hfsplus hpfs isofs isofs jfs xfs(*) ext4(**)

(*) xfs case insensitive-ness feature is hidden from dcache (dcache is
disabled), so
overlayfs mount won't fail, but it may have unexpected behaviors.

(**) ext4 supports per directory case insensitive and unicode folding
since v5.2-rc1,
if the filesystem was configured that way with mkfs/tune2fs. In this
case, regardless of
whether the lower dir is case insensitive or not, overlayfs mount will fail.

I am guessing when people start using case insensitive enabled ext4,
this problem
is going to surface, because the same ext4 (e.g. root fs) could be
used for samba
export (case insensitive) and docker storage (overlayfs).

I can think of some solutions for the private case of same case
insensitive fs used
for upper and lower, but let's see that the problem is real before
discussing a solution.

Ted, Gabriel,

I didn't see that xfstests-bld was updated with case folding configs for ext4,
nor that xfstests has any new case folding tests (saw some posted), so I guess
that is still in the works (?).

Did you happen to try out overlayfs/docker over a case insensitive enabled fs?

I wonder if you could spare a few extra GCE instances per pre-release tests
to run an overlay over ext4 config?
I was nagging Darrick about this for a while and now I think the
overlay/xfs config
is being tested regularly.

Beyond the fact that there are vast number of users using docker with overlay
over ext4, overlayfs tends to find rare filesystem bugs because of its special
use patterns (e.g. acd1d71598f7 "xfs: preserve i_rdev when recycling...").

Thanks,
Amir.
