Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889BF6AFDDC
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCHEcN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCHEcM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:32:12 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6FF9F07F
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:32:09 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284Vd5a020749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678249901; bh=RGWp900Vv8zD7g2BiMd0+FWzx27JFxBB6jqBFBVJLeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FTRNm+ZYfbag/9ldQ59g9vFRiXuub5iM47i+J+fpxISzdAdvJnGyriUG/tmsY2fNF
         fK4vvRhokMU/Koh+papQg3HLp7kN9MTRNYjwlBMTweEbWvD4BDx+v3OR94FM5BNf8D
         kjKI8RvEp7QBtXCBJCYxVnn0rZuIQmWIdW2Pr0mf1RrNBkmi13/ZnT361EdwFMmZLc
         xi4PuQHYV2LW1a+rnoZXbZonsyUnzxM/ldXwQq5YWiQxeGjn7xT04V2Yx0f1aB5g93
         CHN+7hNg0ECe6wFgoSP+adSqTl/fDxujZH4u6wqmxMMtp41Le64wcxThkxBhyZ8cCW
         sSGRJhRCF9ktg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1616915C3441; Tue,  7 Mar 2023 23:31:39 -0500 (EST)
Date:   Tue, 7 Mar 2023 23:31:39 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: Fix WANRON caused by unconsistent boot loader
 inode's i_size and i_disksize
Message-ID: <20230308043139.GD860405@mit.edu>
References: <20230308032643.641113-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308032643.641113-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 08, 2023 at 11:26:43AM +0800, Zhihao Cheng wrote:
> Using corrupted ext4 image(non-zero i_size for boot loader inode) could
> trigger WARNON 'i_size_read(inode) < EXT4_I(inode)->i_disksize' in
> ext4_handle_inode_extension():
> 
>  WARNING: CPU: 0 PID: 2580 at fs/ext4/file.c:319
>  CPU: 0 PID: 2580 Comm: bb Not tainted 6.3.0-rc1-00004-g703695902cfa
>  RIP: 0010:ext4_file_write_iter+0xbc7/0xd10
>  Call Trace:
>   vfs_write+0x3b1/0x5c0
>   ksys_write+0x77/0x160
>   __x64_sys_write+0x22/0x30
>   do_syscall_64+0x39/0x80
> 
> Reproducer (See Link):
>  1. mount corrupted ext4 image with non-zero i_size for boot loader inode
>  2. ioctl(fd, EXT4_IOC_SWAP_BOOT)
>  3. write(fd)  // O_DIRECT
> 
> Fix it by setting i_disksize while first loading boot loader inode.

Thanks for reporting the bug, but this is not the correct fix.

We need to swap i_disksize when we swap i_size in swap_inode_data().
Otherwise, if we fail later in the swap_inode_boot_loader() function,
the change to i_datasize won't get undone, which will lead to further
problems.

The correct fix is here:

	https://lore.kernel.org/all/20230308041252.GC860405@mit.edu/

						- Ted

P.S.  Chrome refused to download the b.c attachment, claiming it was
"dangerous".  Perhaps it was because of the commands involving
system(3) which among other things, uses dd to overwrite /dev/sda with
the image file.

It's best if the reproducer program doesn't doesn't make assumption
about whether it's safe to randomly dd files to /dev/sda.  Of course,
I'm a paranoid s.o.b. so I'm not about to download, compile and
blindly run a random program that I get from the 'net.  :-)

But it's actually not all that convenient.  So I just deleted all of
the system(3) calls from your b.c program, and then used a simple
shell script:

     cp /vtmp/disk /vtmp/foo.img
     mount -o loop /vtmp/foo.img /mnt
     cd /mnt
     /vtmp/b

... where /vtmp in the guest VM is automatically setup if you are
using kvm-xfstests[1] to be a 9p file system passthrough of
/tmp/kvm-xfstests-$USER on the host.

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md


