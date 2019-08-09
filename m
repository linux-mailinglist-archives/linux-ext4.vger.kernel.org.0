Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2BB8780C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 13:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405954AbfHILBQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 07:01:16 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:37785 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfHILBQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 07:01:16 -0400
Received: by mail-yb1-f172.google.com with SMTP id t5so2029233ybt.4
        for <linux-ext4@vger.kernel.org>; Fri, 09 Aug 2019 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oNJcrRXO6dvn3mxMEzBC05MZsfpfTkVuV/BgddKCBgg=;
        b=pTkiyQwvczm4P8hJpKinsvpOIVCZqIF6FogYvmH0kUldf3TrXTM8PHcqICC2+WvWVp
         18TR1G/iNs+DUvgNaDS4sLsrMU9iXyWm4NuGsmTgpVL2NmYuML9aT3ew13D+Oik0oeW5
         /p9VEEU7yFc39eDngMW27kmQ89gkeA/UgZMUJeIWD+B5AuKFV9SB/ZPVcwZCDA58R+kP
         A/B5Id3zsxnsyMyr6CDkMh6Th2q7WJvsMNX0b6n3aZ/5bvX5nEE16Axym7ElHcm5yg90
         X1NGz3akMQtawzQJr4zCezXag18k61AHanMh5GcFpXTTLpPUlw1v4ntn4mBCPaaw9KT0
         QsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oNJcrRXO6dvn3mxMEzBC05MZsfpfTkVuV/BgddKCBgg=;
        b=lG4Gioa/l8zG/zrIzpD1LDnYnPrc+bbnw7aHPH+ScreqqJhOZ2aeX5NfGzguMyeVWQ
         Bg80NQYlIGQ8FqQbSwZxU2wOEXIh9LKjF6dns5I2eikoAbQWfb2vX+sMLirCjZSZ9o1k
         vQ/20veL0BSdB+QX5S3P/hw6A2ReI7pl2eEs3WITF8iJOThjfmjBMDhy42+UNUvOUcO9
         TaKsMbeIPqP1MBjHtZGULxKIXTpDI9hs0rpcsCLM1epWiY3xRd7jQ+VVc9OejNUdT8e0
         sYqFV9Iz2y9wALFMScRtlEH+U3GFz3Txy464ioGgrcd85HUYXEkANBN6SQEXhy2DSMG1
         Tv2w==
X-Gm-Message-State: APjAAAX3czBKxsfT6gpyf4qrEzGl1CPq6ZvIf0Dm5MoY9CSU7YbKPHHl
        vGUvg5/5L5kMHju8RGjwQTy5zh2L7KX05zo2eqMr+0bp0Bc=
X-Google-Smtp-Source: APXvYqx+sesqKcY75BmOXtb6Jt4RyPvX8NYSZ1Ob7VqDMJziWyJwP4uq0hXCpmOYtqUHlK1qo1LcBHNpPZA25MTV6yU=
X-Received: by 2002:a25:900c:: with SMTP id s12mr13047304ybl.244.1565348475201;
 Fri, 09 Aug 2019 04:01:15 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Fri, 9 Aug 2019 12:01:03 +0100
Message-ID: <CAMU1PDjZNXr6Y26EUtCSZFnjJfx7MgCLWNWNRgBb9dSN1pdK_g@mail.gmail.com>
Subject: Is it supported to change an ext2/3/4 label while mounted?
To:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

For Btrfs and more recently XFS they explicitly support changing the
label while mounted.  Documentation is available saying it can be done
and stracing shows it is using a file system specific ioctl() to make
the change.

However for ext2/3/4 file systems I can't find anything explicitly
documented, and stracing "tune2fs -L" shows that it writes directly to
the block device while the file system is mounted.  That seems unsafe as
I presume the kernel would be expecting to have exclusive access to the
block device while the file system is mounted.  However it always seems
to work.  I am wondering if it is safe and supported to change an
ext2/3/4 file system label while it is mounted?

(I have a old GParted enhancement request for this, hence the question.
https://bugzilla.gnome.org/show_bug.cgi?id=600496)

Thanks,
Mike


# mkfs.btrfs /dev/sdb1
# mount /dev/db1 /mnt/1
# strace btrfs filesystem label /mnt/1 btrfs_label
...
open("/mnt/1", O_RDONLY|O_NOATIME)      = 3
ioctl(3, BTRFS_IOC_SET_FSLABEL, "btrfs_label") = 0


# mkfs.xfs /dev/sdb2
# mount /dev/sdb2 /mnt/2
# strace  xfs_io -c "label -s xfs_label" /mnt/2
...
open("/mnt/2", O_RDONLY)                = 3
...
ioctl(3, BTRFS_IOC_SET_FSLABEL, "xfs_label") = 0


# mkfs.ext2 /dev/sdb3
# mount /dev/sdb3 /mnt/3
# strace tune2fs -L ext2_label /dev/sdb3
...
open("/dev/sdb3", O_RDWR)               = 3
...
lseek(3, 134217728, SEEK_SET)           = 134217728
write(3, "\0\200\0\0\0\0\2\0\231\31\0\0\217\367\1\0\365\177\0\0\0\0\0\0\2\0\0\0\2\0\0\0"...,
1024) = 1024
lseek(3, 402653184, SEEK_SET)           = 402653184
write(3, "\0\200\0\0\0\0\2\0\231\31\0\0\217\367\1\0\365\177\0\0\0\0\0\0\2\0\0\0\2\0\0\0"...,
1024) = 1024
fsync(3)                                = 0
lseek(3, 1072, SEEK_SET)                = 1072
write(3, "\vM", 2)                      = 2
lseek(3, 1144, SEEK_SET)                = 1144
write(3, "ext2_label", 10)              = 10
fsync(3)                                = 0
close(3)
