Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930D319EC7D
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Apr 2020 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgDEQLb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Apr 2020 12:11:31 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:46043 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgDEQLb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Apr 2020 12:11:31 -0400
Received: by mail-yb1-f173.google.com with SMTP id g6so7347597ybh.12
        for <linux-ext4@vger.kernel.org>; Sun, 05 Apr 2020 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NUVGV+TLG6vb8CwG2gNLrYkHexyQX0aLHdJl9XZNUoE=;
        b=GL7B37mmDkGdplwMP8G+hJcgfzo8z40EGVP/aWsO+CsVwoiiUolehaMJZnjqQX6Q4+
         h8YYbTtNV3Y0i72iXsFMKZJJ8YTi+gy33ne7rivQJFOMN4WjJprNo6+rSX7HsqWNg3It
         hufzB7o3OpWPHj8SzvPBClSEkHtonF+ZuN73imViVYBj59nGh9O3EcVNQbS9a5xLwNQs
         jcrRKW/HNAZG6OYSF0NOGh18+20tqQ4biCPgV2DeVLrBxUjKg9KWGn0fjIVYLwvYTccu
         y46BItE9+9l2eMoEUNgEwk4lffwOQN01/LZ8F4KpmINa877NY1tmGSMmvNdPeLFzcFOD
         fVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NUVGV+TLG6vb8CwG2gNLrYkHexyQX0aLHdJl9XZNUoE=;
        b=RkzJIxzlrX8xNJBMM9lQm5Hb/CsbA04QzpLCTE/Wpj9YvA57C7W+TUJ37XJ6sv0GG4
         T5b2wZTKXN95JnQJ88k4k9R+1r4vEDtYdIBoU8Kcd8ca6c1l2vTPyMCBhJJbzry28W3u
         EIiWPUW58y1fcWrG9fCAt5twwKxOpARwA9SnCgMK3PsO0e1Atuig/2DnXRbXVBItEtSE
         BmE+V6ifTgX4mgwAUJ01kyYxMvedTHxq+bjAhQnkKi5cWyTe2QSz5u6LVSpPD8UjQdfp
         b2j6hea+DoYgEWiNjpjA3eSVS23zhWIYiMnZl7j5V9PcOQbtLMFftdBikLPoFKTzwoZg
         KTZw==
X-Gm-Message-State: AGi0PubVH7sBndBy60SzorO1sMwYQqA26ZYtU/PdhF99NGAuR2NJXK9E
        fB93j+71VY/tAEZHo6F4qQhu+RJ1ynokPNsU+okinw==
X-Google-Smtp-Source: APiQypIWKlOnH2PxPhnsBru/fdmEbkTcd6jMTUvrnu758FezfKhUKkZkmzl556YxWf3gyfnpmZ7J0RKD1ipo8ijrEQE=
X-Received: by 2002:a25:308a:: with SMTP id w132mr30398535ybw.496.1586103088526;
 Sun, 05 Apr 2020 09:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAMvbhGeRv1ipkUjauArjX8r03SCZnmb+aPtrtCEu4g6W8Cqcw@mail.gmail.com>
 <1E3CE46B-2B81-42C0-A50A-02216CC6D8D1@dilger.ca>
In-Reply-To: <1E3CE46B-2B81-42C0-A50A-02216CC6D8D1@dilger.ca>
From:   James Courtier-Dutton <james.dutton@gmail.com>
Date:   Sun, 5 Apr 2020 17:10:52 +0100
Message-ID: <CAAMvbhGrZRVxGfhe6e=zeTGwAP-CcTgDC6nPeMkjg9adv_hAwg@mail.gmail.com>
Subject: Re: ext4 recovery
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

HI,

Just an update. I managed to recover all the data I needed to. Many
thanks to everyone who responded.
Ext4 is the greatest file system!!!

Kind Regards

James



On Tue, 21 Jan 2020 at 02:20, Andreas Dilger <adilger@dilger.ca> wrote:
>
> You can use "filefrag -k" to get units of KB instead of blocks for the ph=
ysical offsets of the files, and "lvdisplay -m /dev/XXX" to show the mappin=
g of LVs to disks (not sure if you can get it to print different units, or =
just LE number and you gave to multiply by the LE size).  Hopefully the LV =
was layer out linearly and is just a matter of computing "> X and < Y" to d=
etermine the affected range.
>
> Note that it is likely that some files which were on the second disk will=
 not show anything from filefrag since the inodes were zeroed out by dd_res=
cue. Some files on the second disk that _do_ show blocks that were allocate=
d on that disk may just have zeroes for the data.
>
> Cheers, Andreas
>
> > On Jan 20, 2020, at 15:07, James Courtier-Dutton <james.dutton@gmail.co=
m> wrote:
> >
> > =EF=BB=BFOn Tue, 14 Jan 2020 at 21:25, Theodore Y. Ts'o <tytso@mit.edu>=
 wrote:
> >>
> >>> On Tue, Jan 14, 2020 at 04:03:53PM +0000, James Courtier-Dutton wrote=
:
> >>>
> >>> Say I started with 1 disk using LVM with an ext4 partition.
> >>> I then added another disk. Added it to the LVM group, expanded the
> >>> ext4 partition to then fill 2 disks.
> >>> I then added another disk. Added it to the LVM group, expanded the
> >>> ext4 partition to then fill 3 disks.
> >>
> >> Where you using RAID 0, or some more advanced RAID level?
> >>
> >>> One of the disk has now failed.
> >>
> >> How has it failed?  It is dead dead dead?  Or are there a large number
> >> of sector errors?
> >>
> >>> Are there any tools available for ext4 that could help recover this?
> >>> Note, I am a single user, not a company, so there is no money to give
> >>> to a data recovery company, so I wish to try myself.
> >>
> >> How valuable is your data?  The first thing I would recommend, if your
> >> data is worth it (and only you can make that decision) is to create a
> >> new RAID set (using larger disks if that helps reduce the price) so
> >> you can make an block-level image backup using the dd_rescue program.
> >>
> >> If you can, then run e2fsck on the backup copy, and then see what you
> >> can recover from that image set.  This will save time (how much is
> >> your time worth?) and perhaps increase the amount of data you can
> >> recover (how much is your data worth?).
> >>
> >>                                        - Ted
> >
> > Hi,
> >
> > Thank you all for the help.
> > I have made some progress.
> > Disk 1 is 100% OK.
> > Disk 2 did dd_rescue and recovered about 30% of the sectors.
> > Disk 3 is 100% OK.
> >
> > I have made images of all of that. LVM worked out what order they went
> > in, and ext4 even let me mount the LVM volume.
> > I have managed to recover a lot of the data, so thank you for the hints=
.
> > What I would like to do now is find out which files were on Disk 2.
> > I have found the fiemap  IOCTL that gives me the logical sectors for
> > the file itself.
> > How do I convert the value from the IOCTL into a physical sector, or
> > at least an offset into the LVM volume?
> > I can then work at that sector 0 to A is on Disk 1,  A to B is on Disk
> > 2, and B to C is on Disk 3.
> >
> > For example, this is how it is done on btrfs. What is the equivalent on=
 ext4?
> >
> > $ sudo filefrag -v UEFI_Spec_2_8_final.pdf
> > Filesystem type is: 9123683e
> > File size of UEFI_Spec_2_8_final.pdf is 18586279 (4538 blocks of 4096 b=
ytes)
> > ext:     logical_offset:        physical_offset: length:   expected: fl=
ags:
> >   0:        0..    4537:    9798022..   9802559:   4538:             la=
st,eof
> > UEFI_Spec_2_8_final.pdf: 1 extent found
> > $ sudo btrfs-map-logical -l $[9798022*4096] /dev/nvme0n1p7
> > mirror 1 logical 40132698112 physical 31475654656 device /dev/nvme0n1p7
> > $ sudo dd if=3D/dev/nvme0n1p7 bs=3D1
> > skip=3D31475654656 count=3D64 2>/dev/null | hexdump -C
> > 00000000  25 50 44 46 2d 31 2e 36  0d 25 e2 e3 cf d3 0d 0a  |%PDF-1.6.%=
......|
> > 00000010  33 30 35 35 31 39 20 30  20 6f 62 6a 0d 3c 3c 2f  |305519 0 o=
bj.<</|
> > 00000020  46 69 6c 74 65 72 2f 46  6c 61 74 65 44 65 63 6f  |Filter/Fla=
teDeco|
> > 00000030  64 65 2f 46 69 72 73 74  20 31 31 37 39 2f 4c 65  |de/First 1=
179/Le|
> > 00000040
> >
> >
> > Kind Regards
> >
> > James
