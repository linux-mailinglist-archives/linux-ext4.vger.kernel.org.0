Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6EE6B5879
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Mar 2023 06:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCKFRA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Mar 2023 00:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCKFQ7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 Mar 2023 00:16:59 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96613E099
        for <linux-ext4@vger.kernel.org>; Fri, 10 Mar 2023 21:16:54 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32B5GDTQ001604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Mar 2023 00:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678511777; bh=SS52Xzz5bwd6jrm6cbVS0S269ALZLJ/7KmthouJjEwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YV1mgqWjAmFOygxxsB8WmBMXg6N93/ePszfhQLuMYYCBpjjDF7NExcT/YBKecRqqQ
         5JsSKo60lHzNd8yEQdMLQOC4/kWzMp5AJJQV5rbrBQrpf5wLoPF4zza37CqJdQsEeG
         CUzvPsgk5W3bVchnG43ZxGthkysJXhJUEvePBCKQzj4aYa/5+dE99F4zKLUpmWEiDV
         1JvJdnzAuchc/EcsvwBtNr/Zbn7JkHLp2BFWaDXXWsvatiMuuP3qbfDC89xp3oYqkS
         d/0fGmY3Wo1Wn2dFOZ78+Y9xOZ/eYL0kWVbYMj9btD9mGuq/iLGnYdjIkUU1iSopn9
         7QRBx0bqUmvWg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A4D8315C42F6; Sat, 11 Mar 2023 00:16:13 -0500 (EST)
Date:   Sat, 11 Mar 2023 00:16:13 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: Fix WANRON caused by unconsistent boot loader
 inode's i_size and i_disksize
Message-ID: <20230311051613.GG860405@mit.edu>
References: <20230308032643.641113-1-chengzhihao1@huawei.com>
 <20230308043139.GD860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308043139.GD860405@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Actually, after looking more closely at swap_boot_loader_inode(), your
patch is better one.  I've dropped mine and applied yours, with commit
message clarified a bit:

    ext4: zero i_disksize when initializing the bootloader inode
    
    If the boot loader inode has never been used before, the
    EXT4_IOC_SWAP_BOOT inode will initialize it, including setting the
    i_size to 0.  However, if the "never before used" boot loader has a
    non-zero i_size, then i_disksize will be non-zero, and the
    inconsistency between i_size and i_disksize can trigger a kernel
    warning:
    
     WARNING: CPU: 0 PID: 2580 at fs/ext4/file.c:319
     CPU: 0 PID: 2580 Comm: bb Not tainted 6.3.0-rc1-00004-g703695902cfa
     RIP: 0010:ext4_file_write_iter+0xbc7/0xd10
     Call Trace:
      vfs_write+0x3b1/0x5c0
      ksys_write+0x77/0x160
      __x64_sys_write+0x22/0x30
      do_syscall_64+0x39/0x80
    
    Reproducer:
     1. create corrupted image and mount it:
           mke2fs -t ext4 /tmp/foo.img 200
           debugfs -wR "sif <5> size 25700" /tmp/foo.img
           mount -t ext4 /tmp/foo.img /mnt
           cd /mnt
           echo 123 > file
     2. Run the reproducer program:
           posix_memalign(&buf, 1024, 1024)
           fd = open("file", O_RDWR | O_DIRECT);
           ioctl(fd, EXT4_IOC_SWAP_BOOT);
           write(fd, buf, 1024);
    
    Fix this by setting i_disksize as well as i_size to zero when
    initiaizing the boot loader inode.
    
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=217159
    Cc: stable@kernel.org
    Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
    Link: https://lore.kernel.org/r/20230308032643.641113-1-chengzhihao1@huawei.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

