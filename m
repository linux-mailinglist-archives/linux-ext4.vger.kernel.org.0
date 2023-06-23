Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB173B0A3
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jun 2023 08:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjFWGSO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jun 2023 02:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFWGSN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jun 2023 02:18:13 -0400
Received: from striker.routify.me (unknown [64.94.212.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9CE4B
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jun 2023 23:18:10 -0700 (PDT)
Received: from glitch (unknown [IPv6:2602:24c:b8f:cd90::8eb3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by striker.routify.me (Postfix) with ESMTPSA id 13E901639;
        Fri, 23 Jun 2023 06:17:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 striker.routify.me 13E901639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seangreenslade.com;
        s=striker-outgoing; t=1687501068;
        bh=kHwByngXCATF1lkNwacD8znlC4DBUO39C7FS8gXGYfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvkvmBVjtHyZbpHrKSYzk2Uk7duZ637CkLxvQnqf5wX05Bqk6DN3lH7KXoseIlRJS
         vwX4RMX8EELSp2cgOF7gmhB41pE5RZZ2rsl7xDE1t9bw8ZdJUrlpOTshDAeB5EmStj
         I8a2F62A/pVO2Rhfk9lfSlnyf9i9Uqhp4foH8DPM=
Date:   Thu, 22 Jun 2023 23:18:04 -0700
From:   Sean Greenslade <sean@seangreenslade.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-ext4@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <ZJU5HN3bmXR3FvzE@glitch>
References: <ZIauBR7YiV3rVAHL@glitch>
 <ZIa5P1HqE62rmzqu@debian.me>
 <ZJTv+it2x/glkmpp@debian.me>
 <20230623044611.GD34229@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623044611.GD34229@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 23, 2023 at 12:46:11AM -0400, Theodore Ts'o wrote:
> On Fri, Jun 23, 2023 at 08:06:02AM +0700, Bagas Sanjaya wrote:
> > 
> > No reply so far from the culprit author (Ye Bin) nor from Ted. Can
> > you help in this case?
> 
> There's been no reply because I haven't been able to replicate it, and
> I didn't have the time do enough work to convince myself the report
> was bogus.  At this point, I have spent time trying to reproduce it,
> and I've had no luck.
> 
> So, unless you can give me a simple set of reproduction instructions,
> I'm going to have to treat this report is invalid.
> 
> Regards,
> 
> 						- Ted
> 
> Note: this test was done using kvm-xfstests which can be found
> https://github.com/tytso/xfstests-bld using the install-kconfig and
> the kbuild script that can also be found in this report.  So if you
> want to play along from home, feel free.  :-)
> 
> 
> root@kvm-xfstests:~# mkfs.ext4 /dev/vdc
> mke2fs 1.47.0 (5-Feb-2023)
> Discarding device blocks: done                            
> Creating filesystem with 1310720 4k blocks and 327680 inodes
> Filesystem UUID: fe434060-6731-4b40-a94a-3a8517df0660
> Superblock backups stored on blocks: 
>         32768, 98304, 163840, 229376, 294912, 819200, 884736
> 
> Allocating group tables: done                            
> Writing inode tables: done                            
> Creating journal (16384 blocks): done
> Writing superblocks and filesystem accounting information: done 
> 
> root@kvm-xfstests:~# md5sum /dev/vdc
> fd38f9f8476ad63a744d179846ee7e18  /dev/vdc
> root@kvm-xfstests:~# mount -o ro /dev/vdc /mnt
> [  472.893614] EXT4-fs (vdc): orphan cleanup on readonly fs
> [  472.894022] EXT4-fs (vdc): mounted filesystem fe434060-6731-4b40-a94a-3a8517df0660 ro with ordered data mode. Quota mode: none.
> root@kvm-xfstests:~# umount /mnt
> [  475.698053] EXT4-fs (vdc): unmounting filesystem fe434060-6731-4b40-a94a-3a8517df0660.
> root@kvm-xfstests:~# md5sum /dev/vdc
> fd38f9f8476ad63a744d179846ee7e18  /dev/vdc
> 
> Hmm.... OK, let's try it with LUKS, even though that *really*
> shouldn't make a difference.  The cryptsetup lukeFormat and mkfs.ext4
> steps are skipped here.  Also, note that I had to manually edit the
> .config file to enable CONFIG_DM_CRYPT, since I dm_crypt is used by
> xfstests, so my install-kconfig script doesn't enable CONFIG_DM_CRYPT.
> 
> 
> root@kvm-xfstests:~# uname -a
> Linux kvm-xfstests 6.4.0-rc6-xfstests-lockdep #200 SMP PREEMPT_DYNAMIC Fri Jun 23 00:33:39 EDT 2023 x86_64 GNU/Linux
> 
> root@kvm-xfstests:~# md5sum /dev/vdc
> 28b75cc094e1e2a62ac25a730fc1dfee  /dev/vdc
> root@kvm-xfstests:~# cryptsetup luksOpen /dev/vdc test
> Enter passphrase for /dev/vdc: 
> root@kvm-xfstests:~# mount -o ro /dev/mapper/test /mnt
> [  812.073771] EXT4-fs (dm-0): orphan cleanup on readonly fs
> [  812.074306] EXT4-fs (dm-0): mounted filesystem ac3f76f1-da0a-426e-85b2-08526afb2224 ro with ordered data mode. Quota mode: none.
> root@kvm-xfstests:~# umount /mnt
> [  814.383016] EXT4-fs (dm-0): unmounting filesystem ac3f76f1-da0a-426e-85b2-08526afb2224.
> root@kvm-xfstests:~# cryptsetup luksClose /dev/mapper/test
> [  830.001992] dm-0: detected capacity change from 10452992 to 0
> root@kvm-xfstests:~# md5sum /dev/vdc
> 28b75cc094e1e2a62ac25a730fc1dfee  /dev/vdc

Hi, Ted. Thanks for taking the time to look into this.

I perhaps should have been more explicit in my report. The issue is not
that the image is any different after the mount; indeed, the md5sums are
identical before and after on my machine as well. The issue is that
something is issuing writes to the backing image, which bumps the mtime
of the backing image. When handling the images with rsync, a difference
in mtime causes the whole image to need to be read.

See this flow:

$ stat image.block | grep Modify
Modify: 2023-06-22 23:00:15.211379972 -0700

# cryptsetup luksOpen image.block t2 && mount -o ro /dev/mapper/t2 /mnt/t2
# umount /mnt/t2 && cryptsetup luksClose t2

$ stat image.block | grep Modify
Modify: 2023-06-22 23:03:56.141139649 -0700


The regression is the mtime bumping behavior, which doesn't happen prior
to the eee00237 commit.

Thanks,

--Sean

