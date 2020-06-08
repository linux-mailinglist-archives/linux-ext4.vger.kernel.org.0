Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D21F1E20
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 19:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbgFHRGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 13:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgFHRGF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jun 2020 13:06:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FF1C08C5C2;
        Mon,  8 Jun 2020 10:06:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k8so7179649iol.13;
        Mon, 08 Jun 2020 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hPmaeZVv4nqza7+ARnoawf5BTsFxhpS8IRJBipNOMfc=;
        b=JDSpqo6Thp5Q5WsEc75/KHk9xj0GbgKPV7UkvJspa0X+z+wl56ZNO/A+yD9SCadbsq
         jMke4O90eLF4gnbGtb1RrdlvwuS1I2kwRp8q1iOh4dAc2bcfwo0v18C7cn2A5XWBiEv4
         7UL/S9g1zytkCch62Iv5CAvJUaLvlpYrNkRHmIORAivUvYmM+bb9VP6Hggntr4bwQs/Y
         pC5Bm4Y9LKsPdEeLozsQKqJLBQyw2McdUosUnJNoUqeIk79kI9qWvRxPRYY4XlYmn+Yr
         wYEpFR1pB7a9Xjj00iOfgqcx3mIM1txntjJ92u2OUlun0PSze7j6vNu4RfVFM8jeWEcm
         mtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hPmaeZVv4nqza7+ARnoawf5BTsFxhpS8IRJBipNOMfc=;
        b=mLtJwAzlkBu8/p/u9yoY61cDVSVQWq8v5kQ4rUisweDn3WMru8TpBoMrtTiVQp9vpp
         zNreiG2OFdn1h8z5v0YAzFGWz3pGRPQ+Kipvo+gCHNsOxmQuzoeM5M7psA7fooKFASso
         Ib6+YeFSms8Wotrv6pJTJQTXskaXS3ZRDK6UfyzPWPU1bGo9uy6lwnh727RxmkOdxXPA
         1TLCdR0El+4AlkF5bXAh6aHuvekWNEcoeStf+aUO/pl5/0S4sHYflDC2VrzLr53R65hT
         jh0MArjRCbp0ei5Duu9wT3iYRv9anraSsk1wcSeiyH2MFguOpCNnI08kdNZ2O2+rImWl
         t+AQ==
X-Gm-Message-State: AOAM5319yLgoI3EZVqaYrqE6lwCuCCELfUei/PGyM6998ui7vC23jJGp
        z4TqeyRi4Oi6FfLqyv72pT7xg+ymHgy/Yha08IL5HwuNVv0=
X-Google-Smtp-Source: ABdhPJyKFIoIPg+wycCkaWa6xxlh0rUBU09de5aDJ/51Wsz9FPAjozsPtcoGcwOTy+6AU8Fz/ea6vW7rXxAABMUPf/E=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr22117460iov.80.1591635965208;
 Mon, 08 Jun 2020 10:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWuds-wNr+NDVPDaxJ83cmCTPPTZ8qL8U5by2FC1uTHYw@mail.gmail.com>
 <CA+icZUUuHpx4Cvq_dP_nVu0WS3r5yzZ8YJtZisdZ=axFmaqitg@mail.gmail.com>
In-Reply-To: <CA+icZUUuHpx4Cvq_dP_nVu0WS3r5yzZ8YJtZisdZ=axFmaqitg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Jun 2020 19:05:53 +0200
Message-ID: <CA+icZUVRQdRgrAbZ29YYB2_ANnzTXC+9vPEAmdt9bgkWS_iB3g@mail.gmail.com>
Subject: Re: Linux v5.7.1: Ext4-FS and systemd-journald errors after suspend + resume
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 8, 2020 at 5:46 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 3:26 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi,
> >
> > for a long time I did not try suspend + resume.
> >
> > So, with Linux v5.7.1 I tried it.
> >
> > As I upgraded my systemd to version 245.6-1 I suspected this change,
> > see my report to Debian/systemd team.
> >
> > Second, as I saw read-only filesystem problems in the logs I changed
> > in /etc/fstab:
> >
> > -UUID=<UUID-of-rootfs> /   ext4 errors=remount-ro 0 1
> > +UUID=<UUID-of-rootfs> / ext4 defaults 0 1
> >
> > That did not help.
> >
> > I have one single / root-fs partition.
> >
> > What I still see after suspend (45 secs) and resume:
> >
> > Ext4: ... unable to read itable block ...
> > Ext4: ... dx_probe:768 ... error read-only directory block ...
> > Ext4: ... ext4_get_inode_loc ...
> > systemd-journald: Failed to write entry - Read-only file system <---
> > Also kded5 etc.
> >
> > The system is in an awful and unusable situation.
> > Typing any command in konsole shows command not known/found.
> > I have not found a way to debug this.
> >
> > What informations do you need?
> > Any hints on how to debug this?
> >
> > Thanks.
> >
> > Regards,
> > - Sedat -
> >
> > [1] https://alioth-lists.debian.net/pipermail/pkg-systemd-maintainers/2020-June/041057.html
>
> I checked the health of /dev/sdc with:
>
> root# badblocks -sv /dev/sdc2
>
> No errors.
>

Just as an information:

The external /dev/sdc hdd is attached to an internal usb-3.0
controller from ASMedia.

- Sedat -
