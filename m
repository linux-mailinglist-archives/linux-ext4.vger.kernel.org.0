Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2278536F04
	for <lists+linux-ext4@lfdr.de>; Sun, 29 May 2022 03:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiE2BYp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 May 2022 21:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiE2BYo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 May 2022 21:24:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733B5C671
        for <linux-ext4@vger.kernel.org>; Sat, 28 May 2022 18:24:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24T1OVCo017225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 May 2022 21:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653787474; bh=zjVqq8Cdkij0X1sscXUKa1G/eL68ryEZdeo5hegW7Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TFhXWyEx7XRjyjmJGIvJ3W73bUKn8yVYcfhpicV3sebOx7k3BZJB6mb3dklCV7R4c
         azqCcS4lKzSrdvbUkxmW++S9hDuph3pxRRSgPC5kta0oetFk0QER8PwbGuQ5mlpjIs
         HZTqVKj2Enmb/Df097L727Y0lSKZAp9n+YMgQlZzDRx0ycr40/nvlhu5ZSeoXR8Jck
         R8/w8qWHhSQxJzpLQ2EhXA4hiYU4fsLmbsT8tY32krOtKDz4IcZ64N3BnUMgU2P8Os
         CXwtae96OWbi9u+A/9fJRDuTJyFXLoBzJKFta7aZabhboDrvC8dIe8gxJ8EUSSftPG
         ZeXepnjCx9Ciw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 018AD15C009C; Sat, 28 May 2022 21:24:30 -0400 (EDT)
Date:   Sat, 28 May 2022 21:24:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <YpLLTkje/QUYPP9z@mit.edu>
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 28, 2022 at 06:53:59PM -0400, Stephen E. Baker wrote:
> Hello,
> 
> I have a Samsung Chromebook Plus (rk3399-gru-kevin) which boots linux off
> an external ssd plugged into USB. The root filesystem is ext4 with unicode
> support, case folding is enabled only on some directories in my home
> directory.
> 
> Since 5.17 the system has been unbootable.

Can you boot using an older kernel and send me (a) the output of
dumpe2fs -h of your root file system, and (b) the output of running
dmesg immediately after the system is booted?

If you can capture the console output when trying to boot 5.17, that
would be helpful.  You may need to disable the graphical boot screen
depending on what distribution or how the bootloader is configured.
If you could to take a picture of the screen when it stops/hangs, that
would be helpful.

I don't see anything wrong with the commit, and I've tested booting
the root file system with casefold enabled, and it works just fine.
What I did was take the root_fs.img from kvm-xfstests[1], and did the
following:

% qemu-img convert -O raw test-appliance/root_fs.img /tmp/root_fs.raw
% tune2fs -O casefold /tmp/root_fs.raw
% qemu-img convert -f raw -O qcow2 /tmp/root_fs.raw /tmp/root_fs.img
% kvm-xfstests -I /tmp/root_fs.img shell

and 5.17 booted without any problems.

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Once in the kvm environment:

root@kvm-xfstests:~# uname -a
Linux kvm-xfstests 5.17.0-xfstests #644 SMP PREEMPT Sat May 28 21:06:37 EDT 2022 x86_64 GNU/Linux

root@kvm-xfstests:~# dmesg | grep EXT4-fs
[    0.690089] EXT4-fs (vda): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
[    0.690161] EXT4-fs (vda): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
[    0.690592] EXT4-fs (vda): mounted filesystem without journal. Quota mode: none.
[    0.846407] EXT4-fs (vda): re-mounted. Quota mode: none.
[    1.144539] EXT4-fs (vdg): mounted filesystem with ordered data mode. Quota mode: no

root@kvm-xfstests:~# dumpe2fs -h /dev/vda 2>/dev/null | grep -i features
Filesystem features:      ext_attr resize_inode dir_index filetype extent 64bit flex_bg casefold sparse_super large_file huge_file dir_nlink extra_isize metadata_csum

root@kvm-xfstests:~# dumpe2fs -h /dev/vda 2>/dev/null | grep -i encoding
Character encoding:       utf8-12.1

I'm not sure what is going on with your system, but I can't reproduce
it on my end.

Regards,

						- Ted
