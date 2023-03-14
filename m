Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D357B6B8EFD
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCNJqI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCNJp4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 05:45:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749499C34
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 02:45:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r27so19153670lfe.10
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678787145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f6pcqMq7ehIa6i1rtDr3wgfvzTOrNwTy03OqMiZgNpI=;
        b=nXmm+uNaDPjCj0lX7JL+UbhoNrflVNvabuAFPSnzFyn68+uumCCA+TsBbI6hN6mqlP
         DKpQHaqDrU796ImWM9FqHXmmbxVJS97M5vbjvw4TV81cr90J6MfISNGxHnKe1xzrkNGC
         yQlZy8XMxuOiWkI/YLq4gbb5BakxLYLyv7idVohCB7uo4nn08axqxWjZkoY65WSb7vPV
         LQ+RG3TB1e4g5GwwrrgisoPp4qCKd7HmdtxffNARJ+MBuWbDgmm3ZGlEdiZiebKHq58I
         1nm3Ok53HBe//gIgo6jIHtEVNLBwcIxNvexx/V7MeEyFuN9mbJTWR9U4IbFikOTmCSRi
         H3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678787145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6pcqMq7ehIa6i1rtDr3wgfvzTOrNwTy03OqMiZgNpI=;
        b=ldfjq022Vsyb/g6ocyILVVFnF6ik2bK6cOAiOsOtyfwQyj4/QburDllrAhcLle/F2z
         7qI1ErPzQ0FTMFLd29rOB5+dmNLriNHqJzrWqkZC/dQNZlys5JrPYIK6KbJu5KxnGndX
         MBxYpCsFBSMUnTM1zi07+ASAz5L1cuYvcOAdP3yTfTK684pCOvDVZJ0GV41XgUCQftDT
         WR+b/GGWcOpjySYYi6mCzivLrhwLhFttOicPjQIQB5Xngh5FwP8kb1dJU2772Kxy3Bty
         mtvyZY3NcxJS6Nezruc+luT938RXqKn5JA8ImKYz5fX+rnRQEldOPMoq/R9P6j9C83Fy
         qJwA==
X-Gm-Message-State: AO0yUKVl4AA4+pWQ4/l9z62k4xaSBWm5hyX0kOhSGmcSetsAZ7+wkG29
        xZTepfuw/FYyzxMFVlIFytL2tbQd9VeePECczvPhFQ==
X-Google-Smtp-Source: AK7set8tToRs8Na1+lGjKxbLv779LnOQTM/dCJ4Z8OoF+9MU8pxhAeiex7h4PJ510k7hhOvFrUwul1sq+AH/MeOBkj4=
X-Received: by 2002:ac2:484f:0:b0:4e8:1706:65af with SMTP id
 15-20020ac2484f000000b004e8170665afmr532059lfy.6.1678787145083; Tue, 14 Mar
 2023 02:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ef6cf905f496e40b@google.com> <7e4a0f15-4d82-6026-c14b-59852ffab08e@linaro.org>
 <20230307103958.lo6ynoypgwreqmnq@quack3> <60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org>
 <976a7f24-0446-182f-c99e-98f3b98aef49@linaro.org> <20230313115728.2wxy2qj4mqpwgrx7@quack3>
 <CACT4Y+ZVWYX=NX4br=0MFTYxJGBE9gEQdx+YNYi1P4B1z8B0iw@mail.gmail.com> <20230314022649.GM860405@mit.edu>
In-Reply-To: <20230314022649.GM860405@mit.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Mar 2023 10:45:32 +0100
Message-ID: <CACT4Y+b1vGfe0Uvp6YmKahK4GfCfvdBLCh0SAQzGgWN1s6A+0Q@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_group_desc_csum
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Tudor Ambarus <tudor.ambarus@linaro.org>,
        syzbot <syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Lee Jones <joneslee@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 14 Mar 2023 at 03:26, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Mar 13, 2023 at 03:53:57PM +0100, Dmitry Vyukov wrote:
> > > Long-term we are moving ext4 in a direction where we can disallow block
> > > device modifications while the fs is mounted but we are not there yet. I've
> > > discussed some shorter-term solution to avoid such known problems with syzbot
> > > developers and what seems plausible would be a kconfig option to disallow
> > > writing to a block device when it is exclusively open by someone else.
> > > But so far I didn't get to trying whether this would reasonably work. Would
> > > you be interested in having a look into this?
> >
> > Does this affect only the loop device or also USB storage devices?
> > Say, if the USB device returns different contents during mount and on
> > subsequent reads?
>
> Modifying the block device while the file system is mounted is
> something that we have to allow for now because tune2fs uses it to
> modify the superblock.  It has historically also been used (rarely) by
> people who know what they are doing to do surgery on a mounted file
> system.  If we create a way for tune2fs to be able to update the
> superblock via some kind of ioctl, we could disallow modifying the
> block device while the file system is mounted.  Of course, it would
> require waiting at least 5-6 years since sometimes people will update
> the kernel without updating userspace.  We'd also need to check to
> make sure there aren't boot loader installer (such as grub-install)
> that depend on being able to modify the block device while the root
> file system is mounted, at least in some rare cases.
>
> The "how" to exclude mounted file systems is relatively easy.  The
> kernel already knows when the file system is mounted, and it is
> already a supported feature that a userspace application that wants to
> be careful can open a block device with O_EXCL, and if it is in use by
> the kernel --- mounted by a file system, being used by dm-thin, et. al
> -- the open(2) system call will fail.  From the open(2) man page.
>
>           In  general, the behavior of O_EXCL is undefined if it is used without
>           O_CREAT.  There is one exception: on Linux 2.6 and later,  O_EXCL  can
>           be  used without O_CREAT if pathname refers to a block device.  If the
>           block device is in use by the system  (e.g.,  mounted),  open()  fails
>           with the error EBUSY.
>
> Something which the syzbot could to do today is to simply use O_EXCL
> whenever trying to open a block device.  This would avoid a class of
> syzbot false positives, since normally it requires root privileges
> and/or an experienced sysadmin to try to modify a block device while
> it is mounted and/or in use by LVM.
>
>                                - Ted
>
> P.S.  Trivia note: Aproximately month after I started work at VA Linux
> Systems, a sysadmin intern which was given the root password to
> sourceforge.net, while trying to fix a disk-to-disk backup, ran
> mkfs.ext3 on /dev/hdXX, which was also being used as one-half of a
> RAID 0 setup on which open source code critical to the community
> (including, for example, OpenGL) was mounted and serving.  The intern
> got about 50% the way through zeroing the inode table on /dev/hdXX
> before the file system noticed and threw an error, at which point
> wiser heads stopped what the intern was doing and tried to clean up
> the mess.  Of course, there were no backups, since that was what the
> intern was trying to fix!
>
> There are a couple of things that we could learn from this incident.
> One was that giving the root password to an untrained intern not
> familiar with the setup on the serving system was... an unfortunate
> choice.  Another was that adding the above-mentioned O_EXCL feature
> and teaching mkfs to use it was an obvious post-mortem action item to
> prevent this kind of problem in the future...

I am struggling to make my mind re how to think about this case.

"root" is very overloaded, but generally it does not mean "randomly
corrupting memory". Normally it gives access to system-wide changes
but with the same protection/consistency guarantees as for
unprivileged system calls.

There are, of course, things like /dev/{mem,kmem}. But at the same
time there is also lockdown LSM and more distros today enable it.

Btw, should this "prohibit writes to mounted device" be part of
LOCKDOWN_INTEGRITY? It looks like it gives capabilities similar to
/dev/{mem,kmem}.

Disabling in testing something that's enabled in production is
generally not very useful.
So one option is to do nothing about this for now.
If it's a true recognized issue that is in the process of fixing,
syzbot will just show that it's still present. One of the goals of
syzbot is to show the current state of things in an objective manner.
If some kernel developers are aware of an issue, it does not mean that
most distros/users are aware.

It makes sense to disable in testing things that are also recommended
to be disabled in production settings.
And LOCKDOWN_INTEGRITY may play such a role: we include this
restriction into LOCKDOWN_INTEGRITY and enable it on syzbot.
Though, unfortunately, we still don't enable it because it prohibits
access to debugfs, which is required for fuzzing. Need to ask lockdown
maintainers what they think about
LOCKDOWN_TEST_ONLY_DONT_ENABLE_IN_PROD_INTEGRITY which would whitelist
debugfs.
