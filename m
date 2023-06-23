Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B8973AF8C
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jun 2023 06:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFWErE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jun 2023 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWErD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jun 2023 00:47:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D559B
        for <linux-ext4@vger.kernel.org>; Thu, 22 Jun 2023 21:47:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-196.bstnma.fios.verizon.net [173.48.111.196])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35N4kBao028696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 00:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687495576; bh=OEyKCoUungp0u3TZdsQ1kTkqvt2C/vIWCgVVJqjpu8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=i4S4C4NoQoCxVg8tZZiZoUSZ0Dx8tEIDgAR61N4OW7H/tJCrmvxvqTtSLJUnTzhoh
         hiUahurRQtLKlqJJiyrIt0n/fSTHeOs+gkj9badQ71ADpxRzl4v0367juF0M3w8KDB
         mPd3DBXVw0C0ySkgJWBb/8dLZHVnY7aS5jw12BZ36IiEnLUW6Hv0erbvdoaOkE/uq5
         gKBV/ufV6fO4d3T5BMFrWGmBmnKW4zR6YZZ+lQBeNmvKJlwkypKogPmYo/ElxpWyv2
         CzkI173ev6S9xeSwiJ0gEqLUbkPHpKuWjfNRz29yZJLMOFhrnvtFIdk31bCb8TmiMf
         W4s7xPdHFfZ6A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6249015C027E; Fri, 23 Jun 2023 00:46:11 -0400 (EDT)
Date:   Fri, 23 Jun 2023 00:46:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Sean Greenslade <sean@seangreenslade.com>,
        linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: RO mount of ext4 filesystem causes writes
Message-ID: <20230623044611.GD34229@mit.edu>
References: <ZIauBR7YiV3rVAHL@glitch>
 <ZIa5P1HqE62rmzqu@debian.me>
 <ZJTv+it2x/glkmpp@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJTv+it2x/glkmpp@debian.me>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 23, 2023 at 08:06:02AM +0700, Bagas Sanjaya wrote:
> 
> No reply so far from the culprit author (Ye Bin) nor from Ted. Can
> you help in this case?

There's been no reply because I haven't been able to replicate it, and
I didn't have the time do enough work to convince myself the report
was bogus.  At this point, I have spent time trying to reproduce it,
and I've had no luck.

So, unless you can give me a simple set of reproduction instructions,
I'm going to have to treat this report is invalid.

Regards,

						- Ted

Note: this test was done using kvm-xfstests which can be found
https://github.com/tytso/xfstests-bld using the install-kconfig and
the kbuild script that can also be found in this report.  So if you
want to play along from home, feel free.  :-)


root@kvm-xfstests:~# mkfs.ext4 /dev/vdc
mke2fs 1.47.0 (5-Feb-2023)
Discarding device blocks: done                            
Creating filesystem with 1310720 4k blocks and 327680 inodes
Filesystem UUID: fe434060-6731-4b40-a94a-3a8517df0660
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 

root@kvm-xfstests:~# md5sum /dev/vdc
fd38f9f8476ad63a744d179846ee7e18  /dev/vdc
root@kvm-xfstests:~# mount -o ro /dev/vdc /mnt
[  472.893614] EXT4-fs (vdc): orphan cleanup on readonly fs
[  472.894022] EXT4-fs (vdc): mounted filesystem fe434060-6731-4b40-a94a-3a8517df0660 ro with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# umount /mnt
[  475.698053] EXT4-fs (vdc): unmounting filesystem fe434060-6731-4b40-a94a-3a8517df0660.
root@kvm-xfstests:~# md5sum /dev/vdc
fd38f9f8476ad63a744d179846ee7e18  /dev/vdc

Hmm.... OK, let's try it with LUKS, even though that *really*
shouldn't make a difference.  The cryptsetup lukeFormat and mkfs.ext4
steps are skipped here.  Also, note that I had to manually edit the
.config file to enable CONFIG_DM_CRYPT, since I dm_crypt is used by
xfstests, so my install-kconfig script doesn't enable CONFIG_DM_CRYPT.


root@kvm-xfstests:~# uname -a
Linux kvm-xfstests 6.4.0-rc6-xfstests-lockdep #200 SMP PREEMPT_DYNAMIC Fri Jun 23 00:33:39 EDT 2023 x86_64 GNU/Linux

root@kvm-xfstests:~# md5sum /dev/vdc
28b75cc094e1e2a62ac25a730fc1dfee  /dev/vdc
root@kvm-xfstests:~# cryptsetup luksOpen /dev/vdc test
Enter passphrase for /dev/vdc: 
root@kvm-xfstests:~# mount -o ro /dev/mapper/test /mnt
[  812.073771] EXT4-fs (dm-0): orphan cleanup on readonly fs
[  812.074306] EXT4-fs (dm-0): mounted filesystem ac3f76f1-da0a-426e-85b2-08526afb2224 ro with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# umount /mnt
[  814.383016] EXT4-fs (dm-0): unmounting filesystem ac3f76f1-da0a-426e-85b2-08526afb2224.
root@kvm-xfstests:~# cryptsetup luksClose /dev/mapper/test
[  830.001992] dm-0: detected capacity change from 10452992 to 0
root@kvm-xfstests:~# md5sum /dev/vdc
28b75cc094e1e2a62ac25a730fc1dfee  /dev/vdc


