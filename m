Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74958D608
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 11:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiHIJMZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHIJMY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 05:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54A3B21824
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660036342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SMQ1Ei+/hDQmBKvfwsybng+Ctmf5UFfgmb880HNlduc=;
        b=QOgnI5gB+tdMyc+DKApcED4tyT1yM8Pigjhn3G8H0dtT4o1DcjyK7Zm71tlaQSiC2NllNH
        g9LoqbbkZpxGBtkJRcO54/Fyelb7zBosEdoNb31nFPBdMS0gdSSIORHCviUHPCGJnn+SW9
        jdb9AFf2CXYvXj7pGkcjfrDho3lWmLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-s1taKWlRM5qHasf1P95U_A-1; Tue, 09 Aug 2022 05:12:17 -0400
X-MC-Unique: s1taKWlRM5qHasf1P95U_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8686F8117B0;
        Tue,  9 Aug 2022 09:12:16 +0000 (UTC)
Received: from fedora (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C55834010E36;
        Tue,  9 Aug 2022 09:12:14 +0000 (UTC)
Date:   Tue, 9 Aug 2022 11:12:12 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jan Kara <jack@suse.com>, Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <20220809091212.mgreambnhgso5hzw@fedora>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 09, 2022 at 08:03:11AM +0200, Jiri Slaby wrote:
> Hi,
> 
> On 31. 07. 22, 23:43, Linus Torvalds wrote:
> > So here we are, one week late, and 5.19 is tagged and pushed out.
> > 
> > The full shortlog (just from rc8, obviously not all of 5.19) is below,
> > but I can happily report that there is nothing really interesting in
> > there. A lot of random small stuff.
> 
> Note: I originally reported this downstream for tracking at:
> https://bugzilla.suse.com/show_bug.cgi?id=1202203
> 
> 5.19 behaves pretty weird in openSUSE's openQA (opposing to 5.18, or
> 5.18.15). It's all qemu-kvm "HW"¹⁾:
> https://openqa.opensuse.org/tests/2502148
> loop2: detected capacity change from 0 to 72264
> EXT4-fs warning (device zram0): ext4_end_bio:343: I/O error 10 writing to
> inode 57375 starting block 137216)
> Buffer I/O error on device zram0, logical block 137216
> Buffer I/O error on device zram0, logical block 137217
> ...
> SQUASHFS error: xz decompression failed, data probably corrupt
> SQUASHFS error: Failed to read block 0x2e41680: -5
> SQUASHFS error: xz decompression failed, data probably corrupt
> SQUASHFS error: Failed to read block 0x2e41680: -5
> Bus error
> 
> 
> 
> https://openqa.opensuse.org/tests/2502145
> FS-Cache: Loaded
> begin 644 ldconfig.core.pid_2094.sig_7.time_1659859442
> 
> 
> 
> https://openqa.opensuse.org/tests/2502146
> FS-Cache: Loaded
> begin 644 Xorg.bin.core.pid_3733.sig_6.time_1659858784
> 
> 
> 
> https://openqa.opensuse.org/tests/2502148
> EXT4-fs warning (device zram0): ext4_end_bio:343: I/O error 10 writing to
> inode 57375 starting block 137216)
> Buffer I/O error on device zram0, logical block 137216
> Buffer I/O error on device zram0, logical block 137217
> 
> 
> 
> https://openqa.opensuse.org/tests/2502154
> [   13.158090][  T634] FS-Cache: Loaded
> ...
> [  525.627024][    C0] sysrq: Show State
> 
> 
> 
> Those are various failures -- crashes of ldconfig, Xorg; I/O failures on
> zram; the last one is a lockup likely, something invoked sysrq after 500s
> stall.
> 
> Interestingly, I've also hit this twice locally:
> > init[1]: segfault at 18 ip 00007fb6154b4c81 sp 00007ffc243ed600 error 6 in
> libc.so.6[7fb61543f000+185000]
> > Code: 41 5f c3 66 0f 1f 44 00 00 42 f6 44 10 08 01 0f 84 04 01 00 00 48 83
> e1 fe 48 89 48 08 49 8b 47 70 49 89 5f 70 66 48 0f 6e c0 <48> 89 58 18 0f 16
> 44 24 08 48 81 fd ff 03 00 00 76 08 66 0f ef c9
> > ***  signal 11 ***
> > malloc(): unsorted double linked list corrupted
> > traps: init[1] general protection fault ip:7fb61543f8b9 sp:7ffc243ebf40
> error:0 in libc.so.6[7fb61543f000+185000]
> > Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > CPU: 0 PID: 1 Comm: init Not tainted 5.19.0-1-default #1 openSUSE
> Tumbleweed e1df13166a33f423514290c702e43cfbb2b5b575
> 
> KASAN is not helpful either, so it's unlikely a memory corruption (unless it
> is "HW" related; should I try to turn on IOMMU in qemu?):
> > kasan: KernelAddressSanitizer initialized
> > ...
> > zram: module verification failed: signature and/or required key missing - tainting kernel
> > zram: Added device: zram0
> > zram0: detected capacity change from 0 to 2097152
> > EXT4-fs (zram0): mounting ext2 file system using the ext4 subsystem
> > EXT4-fs (zram0): mounted filesystem without journal. Quota mode: none.
> > EXT4-fs warning (device zram0): ext4_end_bio:343: I/O error 10 writing to inode 16386 starting block 159744)
> > Buffer I/O error on device zram0, logical block 159744
> > Buffer I/O error on device zram0, logical block 159745
> 
> 
> 
> They all occur to me like a zram failure. The installer apparently creates
> an ext2 FS and after it mounts it using ext4 module, the issue starts
> occurring.
> 
> Any tests I/you could run on 5.19 to exercise zram and ext2? Otherwise I am
> unable to reproduce easily, except using the openSUSE installer :/.

Hi Jiri,

I've tried a quick xfstests run on ext2 on zram and I can't see any
issues like this so far. I will run a full test and report back in case
there is anything obvious.

-Lukas

> 
> Any other ideas? Or is this known already?
> 
> ¹⁾ main are uefi boot and virtio-blk (it likely happens with virtio-scsi
> too). The cmdline _I_ use: qemu-kvm -device intel-hda -device hda-duplex
> -drive file=/tmp/pokus.qcow2,if=none,id=hd -device virtio-blk-pci,drive=hd
> -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/qemu/ovmf-x86_64-opensuse-code.bin
> -drive if=pflash,format=raw,unit=1,file=/tmp/vars.bin -cdrom /tmp/cd1.iso
> -m 1G -smp 1 -net user -net nic,model=virtio -serial pty -device
> virtio-rng-pci -device qemu-xhci,p2=4,p3=4 -usbdevice tablet
> 
> 
> thanks,
> -- 
> js
> suse labs
> 

