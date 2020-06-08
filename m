Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB291F1C5D
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 17:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgFHPqk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgFHPqk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jun 2020 11:46:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE5C08C5C2;
        Mon,  8 Jun 2020 08:46:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i25so4534261iog.0;
        Mon, 08 Jun 2020 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vQBV2OGWeEkuH9PFA05n1bU07hONAYI2Z/GUVAZ9LWo=;
        b=uHaYbxMzvv8szPpU7iXscOnH+MXR0KEhpK7M/m604HBlbKuAU0RgNQe+oPs/wqOdEF
         ZZaErFkcsw3ugDJ9vm0ZDyMWbfBbvUYLRndCssTPm0Qu96RXNkusy8uYfe04aKRkW+az
         lEnMju2gdTDETGmiIad6YxRalTBz4VFndwmuj4unGgmoK9TInY0AvTRx77up1ASnyBdw
         pwJMUn1WdbgPX8mqnqGTb7uM9qOLPGKCzNSENdamyNJHubVNiPXaxsLhlhuPIdY91dch
         eKOko26o3mGLR5GNZK1zqoVoWL2/PoKhAwL5NzPQQRuG+/e867fMQhGUiBbS+Y6nS4Jn
         FrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vQBV2OGWeEkuH9PFA05n1bU07hONAYI2Z/GUVAZ9LWo=;
        b=gF+/aR5hXqxNW6YueFjY65ZXRwKa58tp9MHQnrFiO/aOTRAAHtPY9N0fK4PB6g3wEM
         YbZsUnNc+bBGYelBl7HojSHGZWxEtq5j83ljWeTI8x2nbnmYGKydDkS2Q6hqXP1pOlEo
         gKpW69fdL/bQ9qCd1r/Su4WgHEnLkL3pyKoIT4anVMOxQy8BLEhBOWfZUaVU1cNn/JwB
         XFWOGLc1jKzQinQSC9z2BXutd6Bol6NZk5I3Se4WAoHzcv+tqUFDYbhEN3ZSERI8o3bo
         OxzfouNY4pWd71vweEH/A/U3LwNrthMPDxJk4V8YU5TX4eAgt3Q2WlBzLPOq4N2kLvOc
         JDNA==
X-Gm-Message-State: AOAM532q99GKRMEdTKXm2738z32AR1D2N2OysMvth5IuGxzD8lItD3jn
        SwsPAywuhykkg9CNnI+NyUMmcj4mekEbOm1uc+U=
X-Google-Smtp-Source: ABdhPJyv+GgIU+PRCUZS00L/hbLl6Eupq+wJyLt4eLhI9666fB84CozMG8LiCW33U6Rkqic5uMzKlvyaIqlukgyiYJw=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr21792080iov.80.1591631199543;
 Mon, 08 Jun 2020 08:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWuds-wNr+NDVPDaxJ83cmCTPPTZ8qL8U5by2FC1uTHYw@mail.gmail.com>
In-Reply-To: <CA+icZUWuds-wNr+NDVPDaxJ83cmCTPPTZ8qL8U5by2FC1uTHYw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Jun 2020 17:46:28 +0200
Message-ID: <CA+icZUUuHpx4Cvq_dP_nVu0WS3r5yzZ8YJtZisdZ=axFmaqitg@mail.gmail.com>
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

On Mon, Jun 8, 2020 at 3:26 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> Hi,
>
> for a long time I did not try suspend + resume.
>
> So, with Linux v5.7.1 I tried it.
>
> As I upgraded my systemd to version 245.6-1 I suspected this change,
> see my report to Debian/systemd team.
>
> Second, as I saw read-only filesystem problems in the logs I changed
> in /etc/fstab:
>
> -UUID=<UUID-of-rootfs> /   ext4 errors=remount-ro 0 1
> +UUID=<UUID-of-rootfs> / ext4 defaults 0 1
>
> That did not help.
>
> I have one single / root-fs partition.
>
> What I still see after suspend (45 secs) and resume:
>
> Ext4: ... unable to read itable block ...
> Ext4: ... dx_probe:768 ... error read-only directory block ...
> Ext4: ... ext4_get_inode_loc ...
> systemd-journald: Failed to write entry - Read-only file system <---
> Also kded5 etc.
>
> The system is in an awful and unusable situation.
> Typing any command in konsole shows command not known/found.
> I have not found a way to debug this.
>
> What informations do you need?
> Any hints on how to debug this?
>
> Thanks.
>
> Regards,
> - Sedat -
>
> [1] https://alioth-lists.debian.net/pipermail/pkg-systemd-maintainers/2020-June/041057.html

I checked the health of /dev/sdc with:

root# badblocks -sv /dev/sdc2

No errors.

- Sedat -
