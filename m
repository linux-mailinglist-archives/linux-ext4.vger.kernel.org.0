Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FF5297349
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 18:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373762AbgJWQNi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 12:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373717AbgJWQNh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 12:13:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D6C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 09:13:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so2155458ljo.6
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00MtloA4epAgbkDjmipSVtmQY2Z7CvZ+2H9mxbgSdAk=;
        b=EfOjCbh/KoyYQZm6AAXQ46QMQGUjW+TjaPGrPIUmnxJrIcjVVBiNWQ6lgn0+nsyBxU
         NiC7RT2SK66b7dooNOPEA9xVahK5kynWwXHAjzVcEMHBQ9az84rW1EyTvXEqNvcBUZgL
         A/i6uC8lhmDUaHwe3OYsjwfMNXp6/RLWxKJn4CCIwlSs9khxZ3mECulHNqaJV9jgAz3s
         mw93nDMRTXm8owh05URbJ/EU/G5MI9PzpH42Y0iCC2qxqgNAcLmFxrAS2hkcOnzwY74v
         a8FaVrhGNa/Ue9J7SfAAKYmVl/d89XFvLV7cNEdD/30uWMfvyL0oMh/FW5lZy2Hppgzv
         f/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00MtloA4epAgbkDjmipSVtmQY2Z7CvZ+2H9mxbgSdAk=;
        b=K7Ff9W7w2E/h2aAilZcyQicWx/HrS0kqhFUeIdnN10qRTHXasjhvsL/KYnADAlEFX+
         S6XwTGgR4Va20HeOSPskwTQsNAWAlKnF/28CqqTqNk+teEZsXTMV+iMcmGhp6KrLUKOB
         z/YewN9z7rTSgsrh33xH26ACqU24W1LoyePFRNhh47zIYr56LBktfy5L10uKgtPWeozE
         yibMeZfMxHcngoDZ8kIseX1qG17MJFCYX5qqB8T6SLI1l2jxo2C1xATqBxKBXTH2nzQW
         RexuJeCk/HoUpItLdcVUK9VINj3fUWTCwVVUniPZwYAZDXDkG7/K2dF8YsmvVjmUmdH1
         7OrA==
X-Gm-Message-State: AOAM531wyCoamrII0ipso0CnuIfV578YATjWzkvpnsZuAED8RoNuIZM3
        wnirBDzhBI3qxTJ9RLCg0/Q3cHscWS35eS/ygzXfP4b3clQ=
X-Google-Smtp-Source: ABdhPJyDH+3f5/MRyMRgj50T+GDp2CK2t9+KL01MXHu2rdfiy67qqnOajOGvQ8oXV2rB6xtbnBbcjRthCHhStq/UhoU=
X-Received: by 2002:a2e:a310:: with SMTP id l16mr1166452lje.36.1603469615720;
 Fri, 23 Oct 2020 09:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJJtKouWTz2bZC8nUr4G8v=7Hh4-AbYg7Ea3yKk4Mk2gSRuP1g@mail.gmail.com>
 <20201023135410.GR181507@mit.edu>
In-Reply-To: <20201023135410.GR181507@mit.edu>
From:   Radivoje Jovanovic <radivojejovanovic@gmail.com>
Date:   Fri, 23 Oct 2020 09:13:24 -0700
Message-ID: <CAJJtKotk+9N=A=9gSuKaKumTeSupW0fkoG2ZWKsmyHW2ckO+vQ@mail.gmail.com>
Subject: Re: ext4 and dd of emmc
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thank you for responding Theodore,
My answers inline below.

On Fri, Oct 23, 2020 at 6:54 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Oct 22, 2020 at 10:46:18AM -0700, Radivoje Jovanovic wrote:
> > Hello,
> > I am creating empty  4GB ext4 partition on emmc with parted like this:
> > parted -s -a optimal /dev/emmcblk0 mkpart data ext4 1024 5120
> > mkfs.ext4 /dev/mmcblk0p7 (this is the partition that was created in
> > the previous step)
> >
> > I do not mount this partition before I do dd of the emmc.
> > dd of the emmc is done like this:
> > dd if=/dev/emmcblk0 | gzip -c | dd of=./image.bin
> >
> > after this I write back the emmc with the same binary file:
> > dd if=./image.bin | gunzip -c | dd of=. /dev/emmcblk0
>
> Is the root file system (or any file system mounted read/write)
> located on /dev/emmcblk0?  You seem to imply that /dev/emmcblk0p7 was
> mounted read write, so that would appear to be the case.  If so,
> that's a bad idea.  Don't do that.   It's not safe.

No emmc partitions are mounted ever before binary copy takes place.
The partitions are mounted only after the binary copy is fully completed.
>
> > at the boot the kernel reports:
> > EXT4-fs (mmcblk0p7): warning: mounting fs with errors, running e2fsck
> > is recommended
>
> That's probably because of the fact that mmcblk0p7 was moounted
> read/write at the time when you tried to save and restore img.bin.
> *Never* mess with a block device containing a mounted file system like
> this.
>
Again, the partitions were not mounted before dd was performed.

> > Buffer I/O error on dev mmcblk0p7, logical block 0, lost sync page write
> > EXT4-fs (mmcblk0p7): I/O error while writing superblock
>
> That implies that an I/O error from the eMMC device.  That's a
> hardware issue, *probably* not related to the fact that partition was
> not mounted, but rather by lousy hardware Quality Assurance along the
> way.  If the hardware device is throwing I/O errors, you need to root
> cause that issue first before worrying about any file system
> complaints.
>
Yes this message does look like a HW failure. However, I am able to
reproduce this
on two different emmc models and over 10 different emmc chips across 2
different plarforms,
so I would not think it is really a HW issue.

Thanks.,
Ogi

> Cheers,
>
>                                                 - Ted
Thanks
Ogi
