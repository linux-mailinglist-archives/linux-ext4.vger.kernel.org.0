Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB2451433A9
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jan 2020 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgATWH2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jan 2020 17:07:28 -0500
Received: from mail-yb1-f178.google.com ([209.85.219.178]:46039 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWH2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Jan 2020 17:07:28 -0500
Received: by mail-yb1-f178.google.com with SMTP id x191so427086ybg.12
        for <linux-ext4@vger.kernel.org>; Mon, 20 Jan 2020 14:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpBXP/w+8SIEYoxVwGXwuaoPYITn2ikOLrYsRB74gYo=;
        b=lRYAxgbXdJfCnS1cZcU0E/B0aqctC9YcWvrmomcSDc5MUqnMiK0XXZgv5YeAvl+zQ2
         pSU+89j2zd7oweNxdgREa3EXg/iqJMqU2WHB+6Nrh++oG1DOEZZ+lE18gFPr8AjkoO7v
         KAactp80I1jsLVQOpuBE+19g6CWRP6c9q2SZn5KlAb0vIjye8BOlcUZV/MwjMZ36scKy
         ZgskvsPUYH858VYJ4o8kOboofwt5I4ptqVhZVz0JPm0difW1mfvmKdymF0Bb6Xce4U1R
         cmfuYOgcZKgoek/14OApDoCqFx3JFU2kNVVqf5vm2vSEzYxhSy1A04cUktfI+ytk3L58
         hPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpBXP/w+8SIEYoxVwGXwuaoPYITn2ikOLrYsRB74gYo=;
        b=RGP9Xs/fwtCsnawgiItJRoZtEqwLtoIOykLplUrFqQE8uDEVGbGLaqfuNxH4EWBz5j
         4gh+4poSrbm3n1rUKt5DJ1dYYj5QHy6J5zpPZmlZYDqlXT4sQQwipfkfrh4Up9IcsDYZ
         XUnb+dg+kAcEe5lg/SdXJPTHXW5zwfR8CAnIIMYLAZsWIivvdZHqjeeyf2TeAQmBy7Y0
         e3+rkccfgKtmcVeOKUYfOEqykwgi2tNFWgzTasVJhcoH0CSOQKtnQPoyFZzkh2GfAJXJ
         NJAWd5MNOCE3MrrDt8i883JB6I2fImm8rENTxdCQ2/Fy6KjYLHeazJ1Pe4Prfl/KYzrY
         IwGA==
X-Gm-Message-State: APjAAAUKXVYTlCRnM6tluZzky66WiMKVIT8udPdUtYbRWGhU2yoZKm2c
        koqqdEzHZhHX59uoaaS1L6LXpkayDf0BwGLn5d2wJrMU
X-Google-Smtp-Source: APXvYqzQlhQG2Pljur5SWmOVyDQ4BrgHtZkl+HGX55znYh4YQI5slsy6OwYWarQEA7UgjlWM6G2Fuh59rvjSvmcKnAM=
X-Received: by 2002:a25:be0c:: with SMTP id h12mr1436640ybk.251.1579558047258;
 Mon, 20 Jan 2020 14:07:27 -0800 (PST)
MIME-Version: 1.0
References: <CAAMvbhFjLCLiLKhu5s7QtLdUY29h8eZ2pHd120o94gDduo+BLw@mail.gmail.com>
 <20200114212551.GE140865@mit.edu>
In-Reply-To: <20200114212551.GE140865@mit.edu>
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Mon, 20 Jan 2020 22:06:50 +0000
Message-ID: <CAAMvbhGeRv1ipkUjauArjX8r03SCZnmb+aPtrtCEu4g6W8Cqcw@mail.gmail.com>
Subject: Re: ext4 recovery
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 14 Jan 2020 at 21:25, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Jan 14, 2020 at 04:03:53PM +0000, James Courtier-Dutton wrote:
> >
> > Say I started with 1 disk using LVM with an ext4 partition.
> > I then added another disk. Added it to the LVM group, expanded the
> > ext4 partition to then fill 2 disks.
> > I then added another disk. Added it to the LVM group, expanded the
> > ext4 partition to then fill 3 disks.
>
> Where you using RAID 0, or some more advanced RAID level?
>
> > One of the disk has now failed.
>
> How has it failed?  It is dead dead dead?  Or are there a large number
> of sector errors?
>
> > Are there any tools available for ext4 that could help recover this?
> > Note, I am a single user, not a company, so there is no money to give
> > to a data recovery company, so I wish to try myself.
>
> How valuable is your data?  The first thing I would recommend, if your
> data is worth it (and only you can make that decision) is to create a
> new RAID set (using larger disks if that helps reduce the price) so
> you can make an block-level image backup using the dd_rescue program.
>
> If you can, then run e2fsck on the backup copy, and then see what you
> can recover from that image set.  This will save time (how much is
> your time worth?) and perhaps increase the amount of data you can
> recover (how much is your data worth?).
>
>                                         - Ted

Hi,

Thank you all for the help.
I have made some progress.
Disk 1 is 100% OK.
Disk 2 did dd_rescue and recovered about 30% of the sectors.
Disk 3 is 100% OK.

I have made images of all of that. LVM worked out what order they went
in, and ext4 even let me mount the LVM volume.
I have managed to recover a lot of the data, so thank you for the hints.
What I would like to do now is find out which files were on Disk 2.
I have found the fiemap  IOCTL that gives me the logical sectors for
the file itself.
How do I convert the value from the IOCTL into a physical sector, or
at least an offset into the LVM volume?
I can then work at that sector 0 to A is on Disk 1,  A to B is on Disk
2, and B to C is on Disk 3.

For example, this is how it is done on btrfs. What is the equivalent on ext4?

$ sudo filefrag -v UEFI_Spec_2_8_final.pdf
Filesystem type is: 9123683e
File size of UEFI_Spec_2_8_final.pdf is 18586279 (4538 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    4537:    9798022..   9802559:   4538:             last,eof
UEFI_Spec_2_8_final.pdf: 1 extent found
$ sudo btrfs-map-logical -l $[9798022*4096] /dev/nvme0n1p7
mirror 1 logical 40132698112 physical 31475654656 device /dev/nvme0n1p7
$ sudo dd if=/dev/nvme0n1p7 bs=1
skip=31475654656 count=64 2>/dev/null | hexdump -C
00000000  25 50 44 46 2d 31 2e 36  0d 25 e2 e3 cf d3 0d 0a  |%PDF-1.6.%......|
00000010  33 30 35 35 31 39 20 30  20 6f 62 6a 0d 3c 3c 2f  |305519 0 obj.<</|
00000020  46 69 6c 74 65 72 2f 46  6c 61 74 65 44 65 63 6f  |Filter/FlateDeco|
00000030  64 65 2f 46 69 72 73 74  20 31 31 37 39 2f 4c 65  |de/First 1179/Le|
00000040


Kind Regards

James
