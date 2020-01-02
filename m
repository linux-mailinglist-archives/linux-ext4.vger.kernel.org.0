Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276F512E1E5
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2020 04:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgABDS3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 22:18:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55151 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABDS3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 22:18:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so4502406wmj.4
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jan 2020 19:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WLZSgbkWsADGlUVFzYqss9xp+6YGz9fIxPGdkJhXeLg=;
        b=rx4q7O/eMCy4GKMk/mBMaedthkavOlPRPynjFCrn2J4C5gLIhXqPooGbMnjML3yFNx
         YBO5c+VVFXMxGGJst3borDUBHuAd0eYr67QhqqzyCGMIV9ZczfBXcEQXp0KXc8LtoDjs
         3e2JWgoaObDmXT83auDRpdoKGRP4U6f2AU2/KyfYe5aL6phD8cf8iorONcRX/ir2Z2Ic
         3FYCyMaBBhADr0YefmKdm4GpsrHMEvbspZa+3bn3O7Bu652qoA6PMCn8lOS+HAhL7uve
         +gbX2qmuuB1y1IFR8c16YnYvafSMZuUWJPgqfgE6cyaAyi0m8x53QOR5e+3hXYCCbwsq
         nj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WLZSgbkWsADGlUVFzYqss9xp+6YGz9fIxPGdkJhXeLg=;
        b=dIVz1/m0FbY9hcUhsAz2Wsdyi/gA9fg4EIqDWhWz4OkKvsNQMUOVD0rnCumv+u0Lc/
         SjBm5iVdLPsx7LTQ+3sLBjFV/vvedbgQIfM7yn3EJlIkjNdRfk9R+wxk34VMKRW5n26O
         W7BIgbvA4+vTFK6vCfKtb+w47HSqctCKsQpAVfCJtLd+W3QQEv0eEo3L9auaIoG+ob+n
         YfYzJDCdEVsyAV0MG5W3k1zMet7j+jtpbjXF8812Wswd55rhpLzsHLrlbRVaCnxRKnuU
         1X0k2NMm5toiWyGGgNSWWovapNn3Uk7VDeLUnETU08kOVo63yNmyFEHesmeCmdqF9Tjq
         d4Ew==
X-Gm-Message-State: APjAAAXzKkRevU88TY90Ol7j4hg1WFsDDw+vgg07CGR8XMYDE+/yzuu3
        5xTz6SNkoDkDjHXFPvPNGKhcfdkxI1XEvZtQHKBOfg==
X-Google-Smtp-Source: APXvYqyYNge50GbrJgoKEKR702eMim/XYBRRHZkzRVtHMyfadKQWzoYwLyHjAsGxa+CRwgous7kA7oQcTQ3J/B1TurI=
X-Received: by 2002:a1c:f008:: with SMTP id a8mr11656223wmb.81.1577935105956;
 Wed, 01 Jan 2020 19:18:25 -0800 (PST)
MIME-Version: 1.0
References: <CAAJeciUWm9W-AyFwJdUqC3W6n4bBDHMrzBF=V2d_iMywDW2+uQ@mail.gmail.com>
 <20191226130935.GA3158@mit.edu> <CAAJeciX4oG9MU9tHEccF3ZTu+G4KFOdssa6bGRNgh6mNX+B5Lg@mail.gmail.com>
 <20191229143706.GA7177@mit.edu>
In-Reply-To: <20191229143706.GA7177@mit.edu>
From:   xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Date:   Thu, 2 Jan 2020 11:18:00 +0800
Message-ID: <CAAJeciXXOdqu8kschs+okriZ2O9n0Lf-=oqma1McKZyPiaBsNw@mail.gmail.com>
Subject: Re: the side effect of enlarger max mount count in ext4 superblock
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

thank you , ted.
many thanks to you.

I understand that i have to use offline fsck.
because it can save me a lot of time , and because e2scrub is not
really practical on my android storage application.
it may be useful in distributed storage system=E3=80=82

On Sun, Dec 29, 2019 at 10:37 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Dec 29, 2019 at 02:58:21PM +0800, xiaohui li wrote:
> >
> > shall the e2fsck tool can be divided into two parts ?
> > one part only do the full data consistency check work, focus on
> > checking if data has inconsistency just when ext4 filesystem has been
> > frozen or very few IO activities are going on.
> > and the other part can be doing the actual repair work if data
> > inconsistent  has encountered.
>
> Alas, that's not really practical.  In order to repair a particular
> part of the file system, you need to know what the correct value
> should be.  And calculating the correct value sometimes requires
> global knowledge of the entire file system state.
>
> For example, consider the inode field i_links_count.  For regular
> files, the value of this field is the number of references from
> directory entries (in other words, links) that point at a particular
> inode.  If the correct value is 2 (there are two directory entries
> which reference this inode), but it is incorrectly set to 1, then when
> the first directory entry is removed with an unlink system call, the
> i_links_count will go to zero, and the kernel will free the inode and
> its blocks, leaving those blocks to be used by other inodes.  But
> there still is a valid reference to that inode, and the potential
> result is that the one or more files will get corrupted, because
> blocks can end up being claimed by different inodes.
>
> So there are a couple of things to learn from this.  First, the
> determine whether or not the field is corrupted is 99.999% of the
> effort.  Once you know the correct value, the repair part is trivial.
> So separating the consistency check and repair efforts don't make much
> sense.
>
> Second, when we are considering the i_links_count for a particular
> inode, we have no idea where in the directory tree structure the
> directory entries which reference that inode might be located.  So we
> have to examine all of the blocks of all directories in order to
> determine the value of each inodes i_links_count.  And of course, if
> the contents of the directory blocks are changing while you are trying
> calculate the i_links_count for all of the inodes in the directory,
> this makes the job incredibly difficult.  Effectively, it also
> requires reading all of the metadata blocks, and making sure that they
> are consistent with each other and this requires a lot of memory and a
> lot of I/O bandwidth.
>
> > but i wonder if some problems will happen if doing the full data
> > consistency checking online, without ext4 filesystem umount.
> > so even if very few io activities are going on,  the data checking
> > can't be implemented. just because some file data may be in memory,
> > not in disk.
> > so the data consistency checking only can be started when ext4
> > filesystem has been frozen from my viewpoint, at least at this moment,
> > file data can be returned back to disk as much as possible.
>
> So we can do this already.  It's called e2scrub[1].  It requires using
> dm_snapshot, so we can create a frozen copy of the file system, and
> then we check that frozen file system.
>
> [1] https://manpages.debian.org/testing/e2fsprogs/e2scrub.8.en.html
>
> This has tradeoffs.  The first, and most important, is that if any
> problems are found, you need to unmount the file system, and then
> rerun e2fsck on the actual file system (as opposed to the frozen copy)
> to actually effectuate the repair.
>
> So if you have a large 100TB RAID array, which takes hours to run
> fsck, first of all, you need to reserve enough space in the snapshot
> partition to save an original copy of all blocks written to the file
> system while the e2fsck is running.  This could potentially be a large
> amount of storage.  Secondly, if a problem is found, now what?
> Current e2scrub sends an e-mail to the system administrator,
> requesting that the sysadmin schedule downtime so the system can be
> rebooted, and e2fsck run on the unmounted file system so it can be
> fixed.  If it took hours to detect that the file system was corrupted,
> it will take hours to repair the file system, and the system will be
> out of service during that time.
>
> I'm not convinced this would work terribly well on an Android device.
> E2scrub was designed for enterprise servers that might be running for
> years without a reboot, and the goal was to allow a periodic sanity
> check (say, every few months) to make sure there weren't any problems
> that had accumulated due to cosmic rays flipping bigs in the DRAM
> (although hopefully all enterprise servers are using ECC memory), etc.
>
> One thing that we could do to optimize things a bit is to enhance
> dm_snapshot so that it only makes copies of the original block if the
> I/O indicates that it is a metadata block.  This would reduce the
> amount of space needed to be reserved for the snapshot volume, and it
> would reduce the overhead of dm_snapshot while the fsck is running.
> This isn't something that has been done, because e2scrub is all that
> commonly used, and most uses of dm_snapshot want the snapshot to have
> the data blocks snapshotted as well as the metadata blocks.
>
> So if you are looking for a project, one thing you could perhaps do is
> to approach the device mapper developers at dm-devel@vger.kernel.org,
> and try to add this feature to dm_snapshot.  It might be, though, that
> getting your Android devices to use the latest kernels and using the
> highest quality flash might be a better approach in the long run.
>
> Cheers,
>
>                                         - Ted
