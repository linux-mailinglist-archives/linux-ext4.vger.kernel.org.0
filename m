Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480CA58CB0E
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Aug 2022 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiHHPON (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Aug 2022 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbiHHPOL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Aug 2022 11:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08BC2DEB7
        for <linux-ext4@vger.kernel.org>; Mon,  8 Aug 2022 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659971649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWS5lr0dtSTOC1UPZzz4U7wmq6O5TUNS8THJlD5Vdho=;
        b=AQJLgfH8LtfxsRZvKdJB9GhCfx2rbo8JGhn9x5xbFjXIQcTK/VWSM9UuaGM4OJ+rEQV0jo
        RJfOufo5TfrncE5pOF3mItWtsDPUhRr7plBQuXErRpxrOpvJl4jrbHhqRskPTDjT57pUOF
        E1Cx4prq1Y40rKnyYAiuTNmRMQrk26A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-cs5cM1y4NjKXiWVHzSKe_w-1; Mon, 08 Aug 2022 11:14:08 -0400
X-MC-Unique: cs5cM1y4NjKXiWVHzSKe_w-1
Received: by mail-qt1-f197.google.com with SMTP id g22-20020ac85816000000b00342b02072ceso6407325qtg.0
        for <linux-ext4@vger.kernel.org>; Mon, 08 Aug 2022 08:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWS5lr0dtSTOC1UPZzz4U7wmq6O5TUNS8THJlD5Vdho=;
        b=ar8stpXKbknHFBc/FtZH8g7S3JItc4YOvTMF/3Llmva9WxnQW9YsmmbJHS42b1UNiZ
         V8ge5qbmXXQH9C/A32kPhhADzymPKQ3XdMZhHsJsTRL/Z87/gHir6U2qVV8UDWsWNN8R
         oXZvm5/Qbjh7/6aQXE/ldwxwG+qt6Mh+2dQu31NZM26yy6IcWSfqYHzzZ8JmRG8cSXop
         Eu/RsBY6unCijesEsZeqOUs9Yo+JHkYEgLjWc8NWAlCRWJuVHkcTp571jX0lB3pvmuB+
         jM4c5vXhhGQvbCFV/NJ43h5iWwGP6uGsd3JXQmO4ivsOy+NIAC4jgtUPic4Q4PlVV/tV
         V96w==
X-Gm-Message-State: ACgBeo0m1a9/T8THrhRPBnkMEHlxghpKp+RmdkLaeiOAumHkXAEjoaTd
        joPTPX98zgcLbglroBbXRIxgelqHB7rPC9YKv7m7wW13PfEetooR2glAb96Lj1r9IArp1odt82/
        EPdrlZTYRjzvhIuJeWW2Xyw==
X-Received: by 2002:a05:620a:414c:b0:6b5:cd90:6d27 with SMTP id k12-20020a05620a414c00b006b5cd906d27mr14552871qko.238.1659971647472;
        Mon, 08 Aug 2022 08:14:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR55mhsnYcUTBIV3q5mFdNhg2SA0THgd0xWf4Km0TyqR3lKgKIl7qgFlTWnvs97tWrMZHSaVRg==
X-Received: by 2002:a05:620a:414c:b0:6b5:cd90:6d27 with SMTP id k12-20020a05620a414c00b006b5cd906d27mr14552837qko.238.1659971647139;
        Mon, 08 Aug 2022 08:14:07 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a178d00b0031eeefd896esm8478355qtk.3.2022.08.08.08.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:14:06 -0700 (PDT)
Date:   Mon, 8 Aug 2022 23:13:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCHSET 0/3] fstests: refactor ext4-specific code
Message-ID: <20220808151359.4e3ydlznmdx4vmgn@zlang-mailbox>
References: <165950050051.198922.13423077997881086438.stgit@magnolia>
 <20220806143606.kd7ikbdjntugcpp4@zlang-mailbox>
 <Yu/opJBYTkgbiIPJ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu/opJBYTkgbiIPJ@magnolia>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Aug 07, 2022 at 09:30:28AM -0700, Darrick J. Wong wrote:
> On Sat, Aug 06, 2022 at 10:36:06PM +0800, Zorro Lang wrote:
> > On Tue, Aug 02, 2022 at 09:21:40PM -0700, Darrick J. Wong wrote:
> > > Hi all,
> > > 
> > > This series aims to make it so that fstests can install device mapper
> > > filters for external log devices.  Before we can do that, however, we
> > > need to change fstests to pass the device path of the jbd2 device to
> > > mount and mkfs.  Before we can do /that/, refactor all the ext4-specific
> > > code out of common/rc into a separate common/ext4 file.
> > > 
> > > If you're going to start using this mess, you probably ought to just
> > > pull from my git trees, which are linked below.
> > > 
> > > This is an extraordinary way to destroy everything.  Enjoy!
> > > Comments and questions are, as always, welcome.
> > > 
> > > --D
> > > 
> > > fstests git tree:
> > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-ext4-helpers
> > > ---
> > 
> > Hi Darrick,
> > 
> > There're 3 failures[1] if test ext4 with external logdev, after merging this
> > patchset.
> > The g/629 is always failed with or without this patchset, it fails if test
> > with external logdev.
> > The g/250 and g/252 fail due to _scratch_mkfs_sized doesn't use common ext4
> > mkfs helper, so can't deal with SCRATCH_LOGDEV well.
> 
> Totally different helper, but yes, I'll add that to my list if nothing
> else than to get this patchset moving.

Yes, just due to you try to help common/dmerror to support external logdev,
and these two eio test cases use _scratch_mkfs_sized, it's not compatible
with your new change on dmerror, but it's not regression :)

I think we can fix visible errors at first, then improve ext4 external logdev
supporting bit by bit.

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > [1]
> > SECTION       -- logdev
> > FSTYP         -- ext4
> > PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 5.19.0-0.rc2.21.fc37.x86_64+debug #1 SMP PREEMPT_DYNAMIC Mon Jun 13 14:55:18 UTC 2022
> > MKFS_OPTIONS  -- -F -J device=/dev/loop0 /dev/sda3
> > MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 -o journal_path=/dev/loop0 /dev/sda3 /mnt/scratch
> > 
> > generic/250 2s ... - output mismatch (see /root/git/xfstests/results//logdev/generic/250.out.bad)
> >     --- tests/generic/250.out   2022-04-29 23:07:23.262498285 +0800
> >     +++ /root/git/xfstests/results//logdev/generic/250.out.bad  2022-08-06 22:26:45.179294149 +0800
> >     @@ -1,9 +1,19 @@
> >      QA output created by 250
> >      Format and mount
> >     +umount: /mnt/scratch: not mounted.
> >     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/error-test, missing codepage or helper program, or other error.
> >     +       dmesg(1) may have more information after failed mount system call.
> >      Create the original files
> >     +umount: /mnt/scratch: not mounted.
> >     ...
> >     (Run 'diff -u /root/git/xfstests/tests/generic/250.out /root/git/xfstests/results//logdev/generic/250.out.bad'  to see the entire diff)
> > generic/252 2s ... - output mismatch (see /root/git/xfstests/results//logdev/generic/252.out.bad)
> >     --- tests/generic/252.out   2022-04-29 23:07:23.264498308 +0800
> >     +++ /root/git/xfstests/results//logdev/generic/252.out.bad  2022-08-06 22:26:48.495330525 +0800
> >     @@ -1,10 +1,19 @@
> >      QA output created by 252
> >      Format and mount
> >     +umount: /mnt/scratch: not mounted.
> >     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/error-test, missing codepage or helper program, or other error.
> >     +       dmesg(1) may have more information after failed mount system call.
> >      Create the original files
> >     +umount: /mnt/scratch: not mounted.
> >     ...
> >     (Run 'diff -u /root/git/xfstests/tests/generic/252.out /root/git/xfstests/results//logdev/generic/252.out.bad'  to see the entire diff)
> > generic/629 3s ... - output mismatch (see /root/git/xfstests/results//logdev/generic/629.out.bad)
> >     --- tests/generic/629.out   2022-04-29 23:07:23.545501491 +0800
> >     +++ /root/git/xfstests/results//logdev/generic/629.out.bad  2022-08-06 22:26:50.810355920 +0800
> >     @@ -1,4 +1,5 @@
> >      QA output created by 629
> >     +mke2fs 1.46.5 (30-Dec-2021)
> >      test o_sync write
> >      310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/0
> >      test unaligned copy range o_sync
> >     ...
> >     (Run 'diff -u /root/git/xfstests/tests/generic/629.out /root/git/xfstests/results//logdev/generic/629.out.bad'  to see the entire diff)
> > Ran: generic/250 generic/252 generic/629
> > Failures: generic/250 generic/252 generic/629
> > Failed 3 of 3 tests
> > 
> > 
> > >  common/config |    4 +
> > >  common/ext4   |  176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  common/rc     |  177 ++-------------------------------------------------------
> > >  common/xfs    |   23 +++++++
> > >  4 files changed, 208 insertions(+), 172 deletions(-)
> > >  create mode 100644 common/ext4
> > > 
> > 
> 

