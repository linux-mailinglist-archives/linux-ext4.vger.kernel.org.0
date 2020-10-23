Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9002970EB
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750150AbgJWNyS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 09:54:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33474 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750121AbgJWNyS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 09:54:18 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09NDsBYJ018748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Oct 2020 09:54:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F15C1420107; Fri, 23 Oct 2020 09:54:10 -0400 (EDT)
Date:   Fri, 23 Oct 2020 09:54:10 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: ext4 and dd of emmc
Message-ID: <20201023135410.GR181507@mit.edu>
References: <CAJJtKouWTz2bZC8nUr4G8v=7Hh4-AbYg7Ea3yKk4Mk2gSRuP1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJJtKouWTz2bZC8nUr4G8v=7Hh4-AbYg7Ea3yKk4Mk2gSRuP1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 22, 2020 at 10:46:18AM -0700, Radivoje Jovanovic wrote:
> Hello,
> I am creating empty  4GB ext4 partition on emmc with parted like this:
> parted -s -a optimal /dev/emmcblk0 mkpart data ext4 1024 5120
> mkfs.ext4 /dev/mmcblk0p7 (this is the partition that was created in
> the previous step)
> 
> I do not mount this partition before I do dd of the emmc.
> dd of the emmc is done like this:
> dd if=/dev/emmcblk0 | gzip -c | dd of=./image.bin
> 
> after this I write back the emmc with the same binary file:
> dd if=./image.bin | gunzip -c | dd of=. /dev/emmcblk0

Is the root file system (or any file system mounted read/write)
located on /dev/emmcblk0?  You seem to imply that /dev/emmcblk0p7 was
mounted read write, so that would appear to be the case.  If so,
that's a bad idea.  Don't do that.   It's not safe.

> at the boot the kernel reports:
> EXT4-fs (mmcblk0p7): warning: mounting fs with errors, running e2fsck
> is recommended

That's probably because of the fact that mmcblk0p7 was moounted
read/write at the time when you tried to save and restore img.bin.
*Never* mess with a block device containing a mounted file system like
this.

> Buffer I/O error on dev mmcblk0p7, logical block 0, lost sync page write
> EXT4-fs (mmcblk0p7): I/O error while writing superblock

That implies that an I/O error from the eMMC device.  That's a
hardware issue, *probably* not related to the fact that partition was
not mounted, but rather by lousy hardware Quality Assurance along the
way.  If the hardware device is throwing I/O errors, you need to root
cause that issue first before worrying about any file system
complaints.

Cheers,

						- Ted
