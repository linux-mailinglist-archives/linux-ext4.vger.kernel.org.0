Return-Path: <linux-ext4+bounces-3286-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08950932067
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2662C1C21229
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72B1C6A4;
	Tue, 16 Jul 2024 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGpRCm23"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5A1C68C
	for <linux-ext4@vger.kernel.org>; Tue, 16 Jul 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721110842; cv=none; b=TkyUHu0dQuYNuKioNxM8ljOYTUua8k9VGFGT/sRaT2osmAe1nUR0DOUNQmI9lB6Bu8UZCzZbCWSVqG2Scip+dDdYpavE0k+8UBTNgL/bvnVj/DX42mPH4kzT3AmfastFz5fbHQOLhmomVsG1Qku4z6W9KXGy/hqRRRE4XW1EbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721110842; c=relaxed/simple;
	bh=QfaOMRufHheKxqdfCeb33Wel5JFKO8YSMdcbcbxD+l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyNBnfYr/QSpB7pfJ3BPGnEXmcUdXT1Bu/jeuDWVHKE52XaYrVRdrFRKNMvFAYlhf1CU+Vh33e0AaU/o2+WsW96lf6sd9LqAc4UTg3v0TlJ313i1JPy3aPSxzB+77XYgJ9baUAdvWR4JWx+NaZqeRD38HjOzeqCQnQ3C/5F2p1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGpRCm23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721110839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dogBg/bKduhU9+2oCD7Q6OhvZoJoOf7bPJtgIEnEbEM=;
	b=fGpRCm23RoGLEeROfp6eTLYGxNAfT57CDUE2ODZgSEFPU0Bdm0u6vgtSACvYcfPVi79+Mg
	4VMIK9FJKm0XHPTbBQI5sNWGzqY4KtJf/16POm/1PC8YB0jc+2+LGD/giPw/ug7Z1MB0xE
	Z2rTM3QRbFEhuQVnXBAT9fgFG92nzDc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-74iQXHL0MU-B3WlgJQxHJQ-1; Tue, 16 Jul 2024 02:20:37 -0400
X-MC-Unique: 74iQXHL0MU-B3WlgJQxHJQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-70b1e0a2c59so5509045b3a.1
        for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 23:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721110836; x=1721715636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dogBg/bKduhU9+2oCD7Q6OhvZoJoOf7bPJtgIEnEbEM=;
        b=rnZkcqcZP+8RhBo/09vehT8Prq4hriyWGumr4ykbLzVMMI3e45jf60SoBQlavum7Vq
         IVdDBWWkNCY8eoKvVCZzoTYpE+TUKmjqlNXN6TsivmbFMwRYIavZ/CcDMhdRsG8a7mWf
         me1UBeRxnpWAyTW+G85QHnn9iOZ3Z+8swfTGTYRfaIUvRUObj7SMyavMOZMiQrH6mCnl
         9fjRXJSDYdrOpu6+Ik78ULWpUJreHaDRFSuGWh+54/qLUhoERLUQNmlcCuFLr2HTLyal
         djs+TDtgg6aX7s3imzoGwrwEAKbBsvMRYTSlVmnHFYlm6EOtrPYzKb9cLn8QQxHIE/+E
         iIiQ==
X-Gm-Message-State: AOJu0YwSfT2+QfFJs/d1Q5t2ht1IEwVzIjqG+RDfWXRNy6yUNRgCktA6
	x2pXU8e1323/oQyLi0KLBv2O5aIN3ScWNLVO+Zq8JqagUC3+FkEQbIlH5A5hCjAcQmpjqJoDxSo
	7YyJ+WNeamuu19q4b4hLEByL3VmyJ/PbtrWdqVI6rL3aSpkXqV8LZQgGd/tDICDj+blsa6g==
X-Received: by 2002:a05:6a00:2313:b0:706:aa4b:4 with SMTP id d2e1a72fcca58-70cd83e6db2mr1351639b3a.13.1721110835593;
        Mon, 15 Jul 2024 23:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRuD7kcZTtgwR59qGaxmClSlnR5BwBoOcAOBoch5erd1rZCmGGD84KCtrM9sQXSX/BHbMvlA==
X-Received: by 2002:a05:6a00:2313:b0:706:aa4b:4 with SMTP id d2e1a72fcca58-70cd83e6db2mr1351599b3a.13.1721110835037;
        Mon, 15 Jul 2024 23:20:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca7763sm5456304b3a.156.2024.07.15.23.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 23:20:34 -0700 (PDT)
Date: Tue, 16 Jul 2024 14:20:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL
 pointer dereference, address: 0000000000000000
Message-ID: <20240716062030.donbv4a6oytsco44@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240714034624.qz3l7f52pi6m27yx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240715042803.GM10452@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715042803.GM10452@mit.edu>

On Mon, Jul 15, 2024 at 12:28:03AM -0400, Theodore Ts'o wrote:
> On Sun, Jul 14, 2024 at 11:46:24AM +0800, Zorro Lang wrote:
> > 
> > A weird kernel panic on ext4 happened when I tried to test a
> > fstests patchset:
> > https://lore.kernel.org/fstests/20240712093341.ftesijixy2yrjlxx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/T/#med4b8d2fe14ef627519d84474b4cd1a25d386f75
> 
> I'm confused; this patch set:
> 
> Daniel Gomez (5):
>       common/config: fix RECREATE_TEST_DEV initialization
>       common/rc: add recreation support for tmpfs
>       common/config: enable section parsing when recreation
>       common/rc: read config section mount options for scratch devs
>       common/rc: print test mount options
> 
> seems to be mostly about how xfstest config section handling
> especially for tmpfs.  Is this realy the right patch set?  If so, I'm
> guessing that the reproducer would be very specific to the xfstests
> config.
> 
> My {kvm,gce}-xfstest setup doesn't use the config sections at
> all, but instead uses shell script fragments, since it predates config
> sections by three years --- and I need something that works well with
> sharding separate configs to run on separate cloud VM's.
> 
> So I'm not sure I'm going to be able to reprduce this easily using my
> test setup.  Can you translate the stack trace to source file names /
> line numbers?  Maybe that will give me a hint what's going on:
> 
> > [35346.372867] Call Trace:
> > [35346.375319]  <TASK>
> > [35346.377426]  ? __die+0x20/0x70
> > [35346.380493]  ? page_fault_oops+0x116/0x230
> > [35346.384602]  ? __pfx_page_fault_oops+0x10/0x10
> > [35346.389048]  ? _raw_spin_unlock+0x29/0x50
> > [35346.393072]  ? rcu_is_watching+0x11/0xb0
> > [35346.397006]  ? exc_page_fault+0x59/0xe0
> > [35346.400854]  ? asm_exc_page_fault+0x22/0x30
> > [35346.405049]  ? folio_mark_dirty+0x2a/0xf0
> > [35346.409072]  __ext4_block_zero_page_range+0x50c/0x7b0 [ext4]
> > [35346.414809]  ext4_truncate+0xcd3/0x1210 [ext4]
> 
> Getting line numbers for these two functions would be especially
> helpful.

Sure, Ted. I reproduced this bug and got below things[1] on mainline linux
which HEAD=528dd46d0fc35c0176257a13a27d41e44fcc6cb3

And if you need, I pushed a temporary branch "whatamess4extN" to fstests
repo, which contains the patches trigger this bug.

Thanks,
Zorro

[1]
# ./scripts/decode_stacktrace.sh vmlinux <~/calltrace.log 
[  912.644200] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131891 
[  912.645099] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=525225 
[  912.894856] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b0df-4682bd621d3f. 
[  912.947581] EXT4-fs (vda2): 1 truncate cleaned up 
[  912.947892] EXT4-fs (vda2): recovery complete 
[  912.950912] EXT4-fs (vda2): mounted filesystem b9690547-c193-4a82-b0df-4682bd621d3f r/w with ordered data mode. Quota mode: none. 
[  912.994565] EXT4-fs warning (device vda2): ext4_convert_unwritten_extents_endio:3720: Inode (525267) finished: extent logical block 161, len 120; IO logical block 222, len 19 
[  912.997878] EXT4-fs warning (device vda2): ext4_convert_unwritten_extents_endio:3720: Inode (525267) finished: extent logical block 241, len 40; IO logical block 241, len 9 
[  914.017223] restraintd[1427]: *** Current Time: Sat Jul 13 15:03:01 2024  Localwatchdog at: Mon Jul 15 14:51:00 2024 
[  915.003343] EXT4-fs (vda2): shut down requested (2) 
[  915.003671] Aborting journal on device vda2-8. 
[  915.663314] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b0df-4682bd621d3f. 
[  915.725813] EXT4-fs (vda2): INFO: recovery required on readonly filesystem 
[  915.726249] EXT4-fs (vda2): write access will be enabled during recovery 
[  916.035952] EXT4-fs (vda2): recovery complete 
[  916.038225] EXT4-fs (vda2): mounted filesystem b9690547-c193-4a82-b0df-4682bd621d3f ro with ordered data mode. Quota mode: none. 
[  916.059891] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b0df-4682bd621d3f. 
[  916.159613] EXT4-fs (vda2): mounted filesystem b9690547-c193-4a82-b0df-4682bd621d3f r/w with ordered data mode. Quota mode: none. 
[  916.199256] EXT4-fs (vda2): shut down requested (2) 
[  916.199659] Aborting journal on device vda2-8. 
[  916.200912] EXT4-fs warning (device vda2): ext4_evict_inode:253: couldn't mark inode dirty (err -5) 
[  916.203621] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=263200 
[  916.205150] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=525058 
[  916.205868] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=524568 
[  916.206610] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=656330 
[  916.207979] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131080 
[  916.208932] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=132089 
[  916.209218] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=656330 
[  916.210157] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=262970 
[  916.211213] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=263204 
[  916.211777] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=132089 
[  916.212301] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=132089 
[  916.214649] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131374 
[  916.214786] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=524568 
[  916.216375] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=132004 
[  916.216881] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=132004 
[  916.217401] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=132004 
[  916.219891] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131876 
[  916.221661] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=656082 
[  916.221743] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131875 
[  916.223237] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131875 
[  916.225723] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131875 
[  916.230093] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131860 
[  916.232398] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=525049 
[  916.233901] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131871 
[  916.235671] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131886 
[  916.238753] SELinux: inode_doinit_use_xattr:  getxattr returned 5 for dev=vda2 ino=131891 
[  916.489675] EXT4-fs (vda2): unmounting filesystem b9690547-c193-4a82-b0df-4682bd621d3f.
[  916.540454] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  916.540885] #PF: supervisor instruction fetch in kernel mode
[  916.541226] #PF: error_code(0x0010) - not-present page
[  916.541533] PGD 0 P4D 0
[  916.541694] Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
[  916.542451] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  916.542791] RIP: 0010:0x0
[ 916.542958] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[  916.543340] RSP: 0018:ffffc90008f0f648 EFLAGS: 00010246
[  916.543650] RAX: 0000000000000000 RBX: ffff88818c487820 RCX: ffffffff951a6fea
[  916.544069] RDX: 1ffffffff2ec8c6f RSI: ffffea0005130dc0 RDI: ffff88818c487a60
[  916.544486] RBP: ffffea0005130dc0 R08: 0000000000000000 R09: fffff94000a261b8
[  916.544903] R10: ffffea0005130dc7 R11: 0000000000000000 R12: 0000000000000216
[  916.545326] R13: ffff88818c6822d0 R14: 0000000000000000 R15: 0000000000000000
[  916.545743] FS:  00007ffa15285800(0000) GS:ffff8881f6600000(0000) knlGS:0000000000000000
[  916.546214] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  916.546556] CR2: ffffffffffffffd6 CR3: 000000013914c004 CR4: 00000000003706f0
[  916.546974] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  916.547393] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  916.547810] Call Trace:
[  916.547964]  <TASK>
[  916.548102] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
[  916.548298] ? page_fault_oops (arch/x86/mm/fault.c:715)
[  916.548547] ? __pfx_page_fault_oops (arch/x86/mm/fault.c:643)
[  916.548815] ? _raw_spin_unlock (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:143 kernel/locking/spinlock.c:186)
[  916.549069] ? rcu_is_watching (./include/linux/context_tracking.h:122 kernel/rcu/tree.c:724)
[  916.549310] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:67 ./arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[  916.549543] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
[  916.549797] ? folio_mark_dirty (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 ./include/linux/page-flggs.h:562 mm/page-writeback.c:2880)
[  916.550048] __ext4_block_zero_page_range (fs/ext4/inode.c:986 fs/ext4/inode.c:3679) ext4
[  916.550453] ext4_truncate (fs/ext4/inode.c:3744 fs/ext4/inode.c:4119) ext4
[  916.550779] ? ext4_process_orphan (fs/ext4/orphan.c:338 (discriminator 3)) ext4
[  916.551142] ? __pfx_ext4_truncate (fs/ext4/inode.c:4070) ext4
[  916.551490] ? __pfx_down_write (kernel/locking/rwsem.c:1577)
[  916.551732] ? ext4_inode_is_fast_symlink (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/asm-generic/bitops/instrumented-non-atomic.h:142 fs/ext4/ext4.h:1939 fs/ext4/ext4.h:3603 fs/ext4/inode.c:152 fs/ext4/inode.c:146) ext4
[  916.552128] ext4_process_orphan (fs/ext4/orphan.c:339 (discriminator 3)) ext4
[  916.552483] ext4_orphan_cleanup (fs/ext4/orphan.c:456) ext4
[  916.552839] ? __pfx_ext4_orphan_cleanup (fs/ext4/orphan.c:381) ext4
[  916.553220] ? is_module_address (./arch/x86/include/asm/preempt.h:103 kernel/module/main.c:3283)
[  916.553471] __ext4_fill_super (fs/ext4/ext4.h:1763 fs/ext4/super.c:5554) ext4
[  916.553828] ? __pfx___ext4_fill_super (fs/ext4/super.c:5181) ext4
[  916.554203] ? __kmalloc_large_node (mm/slub.c:4081)
[  916.554480] ? rcu_is_watching (./include/linux/context_tracking.h:122 kernel/rcu/tree.c:724)
[  916.554718] ext4_fill_super (fs/ext4/super.c:5677) ext4
[  916.555058] get_tree_bdev (fs/super.c:1624)
[  916.555290] ? __pfx_ext4_fill_super (fs/ext4/super.c:5657) ext4
[  916.555651] ? __pfx_get_tree_bdev (fs/super.c:1595)
[  916.555910] ? security_sb_eat_lsm_opts (security/security.c:1361 (discriminator 13))
[  916.556203] vfs_get_tree (fs/super.c:1789)
[  916.556423] do_new_mount (fs/namespace.c:3352)
[  916.556647] ? __pfx_do_new_mount (fs/namespace.c:3307)
[  916.556897] ? security_capable (security/security.c:1036 (discriminator 13))
[  916.557142] path_mount (fs/namespace.c:3679)
[  916.557362] ? __pfx_path_mount (fs/namespace.c:3606)
[  916.557602] ? user_path_at_empty (fs/namei.c:2933)
[  916.557854] __x64_sys_mount (fs/namespace.c:3693 fs/namespace.c:3898 fs/namespace.c:3875 fs/namespace.c:3875)
[  916.558093] ? __pfx___x64_sys_mount (fs/namespace.c:3875)
[  916.558364] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[  916.558587] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421) 
[  916.558854] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[  916.559090] ? from_kuid_munged (kernel/user_namespace.c:460) 
[  916.559338] ? rcu_is_watching (./include/linux/context_tracking.h:122 kernel/rcu/tree.c:724) 
[  916.559574] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[  916.559879] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[  916.560113] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421) 
[  916.560377] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[  916.560610] ? ktime_get_coarse_real_ts64 (./include/linux/seqlock.h:74 kernel/time/timekeeping.c:2264) 
[  916.560910] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421) 
[  916.561252] ? rcu_is_watching (./include/linux/context_tracking.h:122 kernel/rcu/tree.c:724) 
[  916.561494] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:4360) 
[  916.561802] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[  916.562040] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4421) 
[  916.562307] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[  916.562541] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
[  916.562774] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
[  916.563011] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  916.563314] RIP: 0033:0x7ffa1510f03e
[ 916.563535] Code: 48 8b 0d e5 ad 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b2 ad 0e 00 f7 d8 64 89 01 48
All code
========
   0:   48 8b 0d e5 ad 0e 00    mov    0xeade5(%rip),%rcx        # 0xeadec
   7:   f7 d8                   neg    %eax
   9:   64 89 01                mov    %eax,%fs:(%rcx)
   c:   48 83 c8 ff             or     $0xffffffffffffffff,%rax
  10:   c3                      retq   
  11:   66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
  18:   00 00 00 
  1b:   90                      nop
  1c:   f3 0f 1e fa             endbr64 
  20:   49 89 ca                mov    %rcx,%r10
  23:   b8 a5 00 00 00          mov    $0xa5,%eax
  28:   0f 05                   syscall 
  2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <-- trapping instruction
  30:   73 01                   jae    0x33
  32:   c3                      retq   
  33:   48 8b 0d b2 ad 0e 00    mov    0xeadb2(%rip),%rcx        # 0xeadec
  3a:   f7 d8                   neg    %eax
  3c:   64 89 01                mov    %eax,%fs:(%rcx)
  3f:   48                      rex.W

Code starting with the faulting instruction
===========================================
   0:   48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax
   6:   73 01                   jae    0x9
   8:   c3                      retq   
   9:   48 8b 0d b2 ad 0e 00    mov    0xeadb2(%rip),%rcx        # 0xeadc2
  10:   f7 d8                   neg    %eax
  12:   64 89 01                mov    %eax,%fs:(%rcx)
  15:   48                      rex.W
[  916.564607] RSP: 002b:00007ffc1e936e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  916.565054] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffa1510f03e
[  916.565473] RDX: 00005555d6678630 RSI: 00005555d66786b0 RDI: 00005555d6678690
[  916.565893] RBP: 00005555d6678400 R08: 00005555d6678650 R09: 00007ffc1e935b50
[  916.566314] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  916.566733] R13: 00005555d6678630 R14: 00005555d6678690 R15: 00005555d6678400
[  916.567160]  </TASK>
[  916.567301] Modules linked in: tls ext4 mbcache jbd2 rfkill snd_hda_codec_generic snd_hda_intel intel_rapl_msr snd_intel_dspcfg intel_rapl_common snd_intel_sdw_acpi snd_hda_codec snd_hda_core sunrpc intel_uncore_frequency_common snd_hwdep snd_seq intel_pmc_core snd_seq_device intel_vsec pmt_telemetry pmt_class snd_pcm qxl snd_timer pcspkr drm_ttm_helper ttm virtio_balloon snd soundcore drm_kms_helper i2c_piix4 joydev drm fuse xfs libcrc32c ata_generic virtio_net crct10dif_pclmul crc32_pclmul net_failover crc32c_intel failover ghash_clmulni_intel dimlib ata_piix virtio_console virtio_blk libata serio_raw
[  916.570389] CR2: 0000000000000000
[  916.570597] ---[ end trace 0000000000000000 ]---
[  916.570876] RIP: 0010:0x0
[ 916.571045] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[  916.571428] RSP: 0018:ffffc90008f0f648 EFLAGS: 00010246
[  916.571740] RAX: 0000000000000000 RBX: ffff88818c487820 RCX: ffffffff951a6fea
[  916.572163] RDX: 1ffffffff2ec8c6f RSI: ffffea0005130dc0 RDI: ffff88818c487a60
[  916.572583] RBP: ffffea0005130dc0 R08: 0000000000000000 R09: fffff94000a261b8
[  916.573005] R10: ffffea0005130dc7 R11: 0000000000000000 R12: 0000000000000216
[  916.573425] R13: ffff88818c6822d0 R14: 0000000000000000 R15: 0000000000000000
[  916.573848] FS:  00007ffa15285800(0000) GS:ffff8881f6600000(0000) knlGS:0000000000000000
[  916.574321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  916.574664] CR2: ffffffffffffffd6 CR3: 000000013914c004 CR4: 00000000003706f0
[  916.575087] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  916.575508] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  916.575928] note: mount[99339] exited with irqs disabled
[  916.638225] EXT4-fs (vda3): unmounting filesystem 92fe26f7-76ab-4251-bac6-305c3e2ef932.
[  916.816486] EXT4-fs (vda3): mounted filesystem 92fe26f7-76ab-4251-bac6-305c3e2ef932 r/w with ordered data mode. Quota mode: none.


> 
> Thanks,
> 
> 					- Ted
> 


