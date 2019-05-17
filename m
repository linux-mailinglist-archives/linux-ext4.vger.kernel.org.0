Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919BE21634
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfEQJXo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 05:23:44 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:37101 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfEQJXo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 May 2019 05:23:44 -0400
Received: by mail-vs1-f50.google.com with SMTP id o5so4203077vsq.4;
        Fri, 17 May 2019 02:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dBZe0GhTJDosRRgHuciwby6XIBrRrD/9ldTdjrtfLqE=;
        b=j2Xp+ikEcutYQYfeTKzVgiD0tMfjb8IiKWK7Thy8kbzqDdzAD6kXgzDTOy/UYImREH
         yYElunRlNeXlIobzU3Q+Kz0A18iEyIBqKlCioFJxHMhhBThoDiocz+HiL8fT5jVCK6bo
         S2yMxvdkQ6AOY79r9kBMlkl4bNkgcc+26oFGXQFziEVpAF41m7LDXA78W3snfXXR41El
         mu/xD6x9eEG/OPiRW7vfc01oU7qjoxiXy1YBb+UACaU+9+WR1eCZnmJgeq4mjxqXrswm
         yTmnAjvNB/gaAzX66f2l6UVsvGn484QUkujYGZ6aPFPJBZPY5byg7YjGrlkHg1ZhcL6t
         gkLg==
X-Gm-Message-State: APjAAAUSY7ffwC8i59PVEHwSn+nj37WMA0AcdihuRdBKC0eFmPbyGR5T
        j4B1ehfllDqeFPCLraSvNBwes7r+MSCgIgwbIaBb8TVS
X-Google-Smtp-Source: APXvYqyDW2dGLUYFe8TuVccjD8H4FxnSJSk++tWNOrMv2kXMZqXexag5/ShWcGn/j3eC42hCvyvQt60NbOANBxa0a5k=
X-Received: by 2002:a67:7c93:: with SMTP id x141mr18356348vsc.96.1558085022896;
 Fri, 17 May 2019 02:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net>
 <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com> <20190511220659.GB8507@mit.edu>
In-Reply-To: <20190511220659.GB8507@mit.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 May 2019 11:23:31 +0200
Message-ID: <CAMuHMdWH4Q6YoE1yV8_KhW4ChK+8RMuAqW25o1pg47Yz5f9nYg@mail.gmail.com>
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Sun, May 12, 2019 at 12:07 AM Theodore Ts'o <tytso@mit.edu> wrote:
> On Sat, May 11, 2019 at 02:43:16PM +0200, Richard Weinberger wrote:
> > [CC'in linux-ext4]
> >
> > On Sat, May 11, 2019 at 1:47 PM Arthur Marsh
> > <arthur.marsh@internode.on.net> wrote:
> > >
> > >
> > > The filesystem with the kernel source tree is the root file system, ext3, mounted as:
> > >
> > > /dev/sdb7 on / type ext3 (rw,relatime,errors=remount-ro)
> > >
> > > After the "Compressing objects" stage, the following appears in dmesg:
> > >
> > > [  848.968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode #8: block 30343695: comm jbd2/sdb7-8: invalid block
> > > [  849.077426] Aborting journal on device sdb7-8.
> > > [  849.100963] EXT4-fs (sdb7): Remounting filesystem read-only
> > > [  849.100976] jbd2_journal_bmap: journal block not found at offset 989 on sdb7-8
>
> This indicates that the extent tree blocks for the journal was found
> to be corrupt; so the journal couldn't be found.
>
> > > # fsck -yv
> > > fsck from util-linux 2.33.1
> > > e2fsck 1.45.0 (6-Mar-2019)
> > > /dev/sdb7: recovering journal
> > > /dev/sdb7 contains a file system with errors, check forced.
>
> But e2fsck had no problem finding the journal.
>
> > > Pass 1: Checking inodes, blocks, and sizes
> > > Pass 2: Checking directory structure
> > > Pass 3: Checking directory connectivity
> > > Pass 4: Checking reference counts
> > > Pass 5: Checking group summary information
> > > Free blocks count wrong (4619656, counted=4619444).
> > > Fix? yes
> > >
> > > Free inodes count wrong (15884075, counted=15884058).
> > > Fix? yes
>
> And no other significant problems were found.  (Ext4 never updates or
> relies on the summary number of free blocks and free inodes, since
> updating it is a scalability bottleneck and these values can be
> calculated from the per block group free block/inodes count.  So the
> fact that e2fsck needed to update them is not an issue.)
>
> So that implies that we got one set of values when we read the journal
> inode when attempting to mount the file system, and a *different* set
> of values when e2fsck was run.  Which makes means that we need
> consider the possibility that the problem is below the file system
> layer (e.g., the block layer, device drivers, etc.).
>
>
> > > /dev/sdb7: ***** FILE SYSTEM WAS MODIFIED *****
> > >
> > > Other times, I have gotten:
> > >
> > > "Inodes that were part of a corrupted orphan linked list found."
> > > "Block bitmap differences:"
> > > "Free blocks sound wrong for group"
> > >
>
> This variety of issues also implies that the issue may be in the data
> read by the file system, as opposed to an issue in the file system.
>
> Arthur, can you give us the full details of your hardware
> configuration and your kernel config file?  Also, what kernel git
> commit ID were you testing?

I'm seeing similar things running post v5.1 on ARAnyM (Atari emulator):

    EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
    ...
    EXT4-fs error (device sda1): ext4_get_branch:171: inode #1980:
block 27550: comm jbd2/sda1-1980: invalid block

and userspace hung somewhere during initial system startup, so I had to
kill the instance.

-----

    EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
    EXT4-fs (sda1): INFO: recovery required on readonly filesystem
    EXT4-fs (sda1): write access will be enabled during recovery
    EXT4-fs warning (device sda1): ext4_clear_journal_err:5078:
Filesystem error recorded from previous mount: IO failure
    EXT4-fs warning (device sda1): ext4_clear_journal_err:5079:
Marking fs in need of filesystem check.
    EXT4-fs (sda1): recovery complete
    EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
    VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
    ...
    Run /sbin/init as init process
    random: fast init done
    EXT4-fs (sda1): re-mounted. Opts:
    random: crng init done
    EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
    EXT4-fs (sda1): error count since last fsck: 1
    EXT4-fs (sda1): initial error at time 1557931133:
ext4_get_branch:171: inode 1980: block 27550
    EXT4-fs (sda1): last error at time 1557931133:
ext4_get_branch:171: inode 1980: block 27550

-----

    EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
    EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
    VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
    ...
    Run /sbin/init as init process
    random: fast init done
    EXT4-fs (sda1): re-mounted. Opts:
    EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
    random: crng init done
    EXT4-fs error (device sda1): ext4_get_branch:171: inode #1980:
block 27550: comm jbd2/sda1-1980: invalid block
    Aborting journal on device sda1-1980.
    EXT4-fs (sda1): Remounting filesystem read-only
    jbd2_journal_bmap: journal block not found at offset 426 on sda1-1980
    EXT4-fs error (device sda1): ext4_journal_check_start:61: Detected
aborted journal
    EXT4-fs (sda1): error count since last fsck: 3
    EXT4-fs (sda1): initial error at time 1557931133:
ext4_get_branch:171: inode 1980: block 27550
    EXT4-fs (sda1): last error at time 1558083596:
ext4_journal_check_start:61: inode 1980: block 27550
    EXT4-fs error (device sda1): ext4_remount:5328: Abort forced by user

---

    EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
    EXT4-fs (sda1): INFO: recovery required on readonly filesystem
    EXT4-fs (sda1): write access will be enabled during recovery
    random: fast init done
    EXT4-fs warning (device sda1): ext4_clear_journal_err:5078:
Filesystem error recorded from previous mount: IO failure
    EXT4-fs warning (device sda1): ext4_clear_journal_err:5079:
Marking fs in need of filesystem check.
    EXT4-fs (sda1): recovery complete
    EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
    ...
    Run /sbin/init as init process
    random: crng init done
    EXT4-fs (sda1): re-mounted. Opts:
    EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
    EXT4-fs (sda1): error count since last fsck: 4
    EXT4-fs (sda1): initial error at time 1557931133:
ext4_get_branch:171: inode 1980: block 27550
    EXT4-fs (sda1): last error at time 1558083665: ext4_remount:5328:
inode 1980: block 27550

Notes:
  - It's always the same block,
  - Block device is an image file, accessed using
    arch/m68k/emu/nfblock.c, which did not receive any recent (bvec)
    updates.
  - There are no reported errors for the device containing the image
    file on the host,
  - Given Arthur sees the issue on a different class of machines, it's
    unlikely the issue is related to a problem with the block device
    (driver). It may still be an issue with the block layer, though,
  - Both Arthur and I are mounting an ext3 file system using the ext4
    subsystem.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
