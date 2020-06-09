Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF971F32D9
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jun 2020 06:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFIEB0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Jun 2020 00:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIEBZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Jun 2020 00:01:25 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ABAC03E969;
        Mon,  8 Jun 2020 21:01:25 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g3so18938467ilq.10;
        Mon, 08 Jun 2020 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=phvb+cSaz7XBfGbbMFCim+/fUX9rqimwKTLikWgrpVU=;
        b=TL3ii6bMpSJ57cSS7RT0EdKX9NmiNTPnmvyy4tuRo0RuNL0DPBwYNDs1jTtH8T/JtJ
         tGaqS5kkNJTXJUaXSmWsSCpu3WDr4Nk/iTM5SPUSy8bTPpmytNe+gqgZJKfWu+w7GQZN
         EuqxAPb9Se/ll11LLZpVNWKxgyxel1vn2BzKKwZQTTxr5J8wP4135V8QZRIxAGw9c++5
         HZQ06QqQc7Alx6/mCqwKnQMfet0+6iY44xHohv87Fo97dco3ssnU1QWn98J9xXi+OPGB
         AzThjoIfsQ+4QLAWlrN8LlZET41jYkwztq2QhFfx3fuXWVO7vUn55jThHuT4RM7fU+mM
         g3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=phvb+cSaz7XBfGbbMFCim+/fUX9rqimwKTLikWgrpVU=;
        b=rbuo7xzeEqKpyOa1XALt4LVHpHCJArvZhL2OsuzS++RbP0U6Ah056sRdKshR7cKOpT
         KtVgxIbykQrzDDKCvHFw+nO8SwFEgBHGM3zI8pvbGuZu+xOibdXp8AnXd2exdI7i1qq1
         X9T/3FUCTtoZI1xAJWUI9CmrFGkeE1hzzUZFXAyKkR6/WDolOvNr5aaStsMOidI30DJY
         jVFLm7vN7VIh+HIFFcBz1Vvpx+t34skdooxRJmUXu+zRPu6qsT96+9eg32m38BIxIYqO
         1V42MjZStSPEss346oysyAzA7Ve2BUB0uGX6C+0eemPnrqxRHfo1GkMjI3Rpafdb+8Lf
         zEXw==
X-Gm-Message-State: AOAM531EnvDMOE13WCL6MOm16VupKvUXkcplJcIj7TwDD9SB9+L+D2dV
        pV5gbUkzq9oe1fEF7tTqz6bNie3q2EiW/z4GR8pSa+GVYb8=
X-Google-Smtp-Source: ABdhPJwaXO+Gh92Y+TcAIi04DF4gM7vzxxsObdIJGNDmogt0NLWnFxB0kWVh9hwGmZfwV4UCKO2MjfIHeIGBpoJ0AyE=
X-Received: by 2002:a92:498d:: with SMTP id k13mr25506757ilg.226.1591675284420;
 Mon, 08 Jun 2020 21:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWuds-wNr+NDVPDaxJ83cmCTPPTZ8qL8U5by2FC1uTHYw@mail.gmail.com>
 <20200608202115.GH1347934@mit.edu>
In-Reply-To: <20200608202115.GH1347934@mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 9 Jun 2020 06:01:12 +0200
Message-ID: <CA+icZUWEr2CWOMSDQ+7KNny_dMNf2LewMj6gA1LkLYePwbNxBw@mail.gmail.com>
Subject: Re: Linux v5.7.1: Ext4-FS and systemd-journald errors after suspend + resume
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 8, 2020 at 10:21 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jun 08, 2020 at 03:26:40PM +0200, Sedat Dilek wrote:
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
>

Hi Ted,

> If you didn't update Othe fstab in the initramfs, the root file system
> may still be being mounted with
.
>
> You can check the current status of a file system's mount options
> using /proc/mounts.  Or if you want the full set of changes, you can
> look at the file /proc/fs/ext4/<device>/options.
>

Cool.
I was using... cat /etc/mtab

# cat /proc/fs/ext4/sdc2/options
rw
bsddf
nogrpid
block_validity
dioread_nolock
nodiscard
delalloc
nowarn_on_error
journal_checksum
barrier
auto_da_alloc
user_xattr
acl
noquota
resuid=0
resgid=0
errors=continue
commit=5
min_batch_time=0
max_batch_time=15000
stripe=0
data=ordered
inode_readahead_blks=32
init_itable=10
max_dir_size_kb=0

> When was the last kernel version and systemd where suspend/resume
> worked for you?  If the things work fine until you do a
> suspend/resume, this could be either a hardware issue, a driver issue
> in the kernel, or systemd issue.  It's almost certainly not a file
> system issue, however.  It's likely that you'll need to do a
> disciplined set of debugging, where you find which versions of
> software work, and then try figuring out what was the first version of
> the kernel and/or/systemd where thigns stop working.
>

I *decided* to revert all changes as I really do not use
suspend+resume for ages.
I do my daily work and poweroff my machine.

Can you say your opinion to setting...

   errors=remount-ro VS. defaults

...for the Root-FS?

Last I used s+r was on Ubuntu/precise 12.04 LTS installed on an *internal* HDD.
I used precise for the period of LTS aka 5 years - until 2017.

As said I am 99% sure this is due my Root-FS is installed on an
*external* USB-3.0 HDD connected to an ASMedia USB-3.0 controller.

For a "disciplined" debugging I need to understand how the suspend and
resume works under Debian/testing.

BTW, this is a Samsung Ultrabook 2nd generation with SandyBridge
CPU/GPU with known "broken" ACPI and UEFI?
I am using BIOS-legacy not UEFI.

[    0.000000] DMI: SAMSUNG ELECTRONICS CO., LTD.
530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013

Booting yesterday ArchLinux ISO 2020.06.01 (UEFI) showed me I can use UEFI.
Yes, I like ArchLinux's chroot script and use the ISO to rescue my
Debian system :-).

I gasped over some cool hints in the ArchLinux wikis concerning
power-management and USB autosuspend/wakeup hacks (see [2], [3]).

The real history is I realized a powertop.service (systemd) and
contributed on how to the build+install dance on Debian/testing [4].
Yesterday, in my experiments I stopped and disabled powertop.service
as it triggers systemd-udev-trigger.service (see P.S.).

The most important thing to me was to use an intelligent
power-management while I am working at my notebook.

Thanks for your precious time and your feedback.

Regards,
- Sedat -

[1] http://ftp.halifax.rwth-aachen.de/archlinux/iso/2020.06.01/
[2] https://wiki.archlinux.org/index.php/Powertop
[3] https://wiki.archlinux.org/index.php/Power_management
[4] https://github.com/fenrus75/powertop/commit/a92d6b15600335f0004d2b7b93e21ab3a84e15f9

P.S.: powertop.service with powertop v2.13-rc1

# systemctl cat powertop.service
# /etc/systemd/system/powertop.service
[Unit]
Description=Powertop tunings

[Service]
Type=oneshot
##ExecStart=/usr/sbin/powertop --auto-tune
ExecStart=/opt/powertop/sbin/powertop --auto-tune

[Install]
WantedBy=multi-user.target

# /etc/systemd/system/powertop.service.d/override.conf
[Service]
# Reload /etc/udev/rules.d/50-usb-autosuspend.rules
ExecStart=/bin/systemctl restart systemd-udev-trigger.service

# cat /etc/udev/rules.d/50-usb-autosuspend.rules
# blacklist/whitelist for usb autosuspend
#
# blacklist Logitech, Inc. M-BJ58/M-BJ69 Optical Wheel Mouse
ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control",
ATTR{idVendor}=="046d", ATTR{idProduct}=="c00e",
ATTR{power/control}="on"

- EOT -
