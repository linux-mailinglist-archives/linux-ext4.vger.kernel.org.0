Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAAD6B887E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 03:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCNC13 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 22:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCNC12 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 22:27:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001E65550A
        for <linux-ext4@vger.kernel.org>; Mon, 13 Mar 2023 19:27:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32E2QncK012949
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 22:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678760814; bh=8JqVxAMGDUDi2XIrrOmUQ1H1l2f992aiLDoCnA/d0IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=OebhAS4L6gGEEt5NLSSgaHmEBRj+hXV7nDJr1Lerw48ZJpFOj1TGJgv8tdeDtAwZ2
         m6aEMLV+yw4ykpNRZqj/0rsyTjbvxWcXWlBA0BHjWTvgsxQHqSlRIjxLH0XxynYSx5
         2ZQ6ApErlSs3+K8O0vgJWi3Ko3rzQAdYmzGggNlTRPXfA7ZLfpSbfRLK7654Kh2fsW
         6aoU/4s2sC7iGvyA064uLWmo8x0RybsyK6QJSR/RgyOdvgp43dkZ0XYclrWI/Bjkgh
         j/PztTs/p0dapsX272uw8MpN4OOHC4ZUb4gYbh0OdFQImzHhUydInD3NIJC+dtojdZ
         zlTb13p8vplJg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8C4FF15C5830; Mon, 13 Mar 2023 22:26:49 -0400 (EDT)
Date:   Mon, 13 Mar 2023 22:26:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jan Kara <jack@suse.cz>, Tudor Ambarus <tudor.ambarus@linaro.org>,
        syzbot <syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Lee Jones <joneslee@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in
 ext4_group_desc_csum
Message-ID: <20230314022649.GM860405@mit.edu>
References: <000000000000ef6cf905f496e40b@google.com>
 <7e4a0f15-4d82-6026-c14b-59852ffab08e@linaro.org>
 <20230307103958.lo6ynoypgwreqmnq@quack3>
 <60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org>
 <976a7f24-0446-182f-c99e-98f3b98aef49@linaro.org>
 <20230313115728.2wxy2qj4mqpwgrx7@quack3>
 <CACT4Y+ZVWYX=NX4br=0MFTYxJGBE9gEQdx+YNYi1P4B1z8B0iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZVWYX=NX4br=0MFTYxJGBE9gEQdx+YNYi1P4B1z8B0iw@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 13, 2023 at 03:53:57PM +0100, Dmitry Vyukov wrote:
> > Long-term we are moving ext4 in a direction where we can disallow block
> > device modifications while the fs is mounted but we are not there yet. I've
> > discussed some shorter-term solution to avoid such known problems with syzbot
> > developers and what seems plausible would be a kconfig option to disallow
> > writing to a block device when it is exclusively open by someone else.
> > But so far I didn't get to trying whether this would reasonably work. Would
> > you be interested in having a look into this?
> 
> Does this affect only the loop device or also USB storage devices?
> Say, if the USB device returns different contents during mount and on
> subsequent reads?

Modifying the block device while the file system is mounted is
something that we have to allow for now because tune2fs uses it to
modify the superblock.  It has historically also been used (rarely) by
people who know what they are doing to do surgery on a mounted file
system.  If we create a way for tune2fs to be able to update the
superblock via some kind of ioctl, we could disallow modifying the
block device while the file system is mounted.  Of course, it would
require waiting at least 5-6 years since sometimes people will update
the kernel without updating userspace.  We'd also need to check to
make sure there aren't boot loader installer (such as grub-install)
that depend on being able to modify the block device while the root
file system is mounted, at least in some rare cases.

The "how" to exclude mounted file systems is relatively easy.  The
kernel already knows when the file system is mounted, and it is
already a supported feature that a userspace application that wants to
be careful can open a block device with O_EXCL, and if it is in use by
the kernel --- mounted by a file system, being used by dm-thin, et. al
-- the open(2) system call will fail.  From the open(2) man page.

          In  general, the behavior of O_EXCL is undefined if it is used without
          O_CREAT.  There is one exception: on Linux 2.6 and later,  O_EXCL  can
          be  used without O_CREAT if pathname refers to a block device.  If the
          block device is in use by the system  (e.g.,  mounted),  open()  fails
          with the error EBUSY.

Something which the syzbot could to do today is to simply use O_EXCL
whenever trying to open a block device.  This would avoid a class of
syzbot false positives, since normally it requires root privileges
and/or an experienced sysadmin to try to modify a block device while
it is mounted and/or in use by LVM.

      	      	     	       - Ted

P.S.  Trivia note: Aproximately month after I started work at VA Linux
Systems, a sysadmin intern which was given the root password to
sourceforge.net, while trying to fix a disk-to-disk backup, ran
mkfs.ext3 on /dev/hdXX, which was also being used as one-half of a
RAID 0 setup on which open source code critical to the community
(including, for example, OpenGL) was mounted and serving.  The intern
got about 50% the way through zeroing the inode table on /dev/hdXX
before the file system noticed and threw an error, at which point
wiser heads stopped what the intern was doing and tried to clean up
the mess.  Of course, there were no backups, since that was what the
intern was trying to fix!

There are a couple of things that we could learn from this incident.
One was that giving the root password to an untrained intern not
familiar with the setup on the serving system was... an unfortunate
choice.  Another was that adding the above-mentioned O_EXCL feature
and teaching mkfs to use it was an obvious post-mortem action item to
prevent this kind of problem in the future...
