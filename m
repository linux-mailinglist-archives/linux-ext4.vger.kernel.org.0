Return-Path: <linux-ext4+bounces-14058-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKGAAKlZoGlPigQAu9opvQ
	(envelope-from <linux-ext4+bounces-14058-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:33:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2A1A7993
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4CAF3056C19
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED663B52FA;
	Thu, 26 Feb 2026 14:26:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A737417F
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116003; cv=none; b=isxbbh6sVrF2nHhouSyfZPYIdJgusL4IM3SC5+Vh9zpCO5IDat95p30I3+cGo1laZgLqUuIpvWd46j+SnGqQRnRq9/HTGarC2LwNGjZvsgFpYfDaJ8ObZibJZDF4L26wpgqSvba86cDUETe0yU0e5R/FNO2XJttv2Wi23iyONoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116003; c=relaxed/simple;
	bh=ygClmrni0YOiPnjkyUgCTlWaC1oF3Mi6hJM0XlO/H+k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kCivy2Qh6xA3tVahWCGWP4aywQbCntEHXl9mWXLmbGMzeQW0w5KVNGfjzXQfD0ghTMhVbznp6/f8L4riQFfDCazrF+xY2fUT37r3vq+aWBjGlKLdCfsUpaPYsbZdJEIkBV0Dgk++tZnbyiGKz8o8G6yCNsjUFvTM3hlIMx8v7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.31.7] (theinternet.molgen.mpg.de [141.14.31.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 341E44C443048B;
	Thu, 26 Feb 2026 15:26:31 +0100 (CET)
Message-ID: <16c3376d-2441-4acf-897d-ff0933ac07ff@molgen.mpg.de>
Date: Thu, 26 Feb 2026 15:26:30 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-ext4@vger.kernel.org
Cc: it+linux@molgen.mpg.de
From: Donald Buczek <buczek@molgen.mpg.de>
Subject: [BUG] kernel BUG at fs/ext4/inode.c:2731!
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14058-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[mpg.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4,linux];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[buczek@molgen.mpg.de,linux-ext4@vger.kernel.org];
	SUBJECT_ENDS_EXCLAIM(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,galah:email,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: 7DC2A1A7993
X-Rspamd-Action: no action

Hi all,

we've hit this with 5.15.112 :

[Feb25 13:42] ------------[ cut here ]------------
[  +0.005254] kernel BUG at fs/ext4/inode.c:2731!
[  +0.005088] invalid opcode: 0000 [#1] SMP NOPTI
[  +0.005063] CPU: 102 PID: 247399 Comm: kworker/u519:0 Not tainted 5.15.112.mx64.449 #1
[  +0.008449] Hardware name: Dell Inc. PowerEdge R7525/0T4KXC, BIOS 2.9.3 08/05/2022
[  +0.008120] Workqueue: writeback wb_workfn (flush-251:2)
[  +0.005894] RIP: 0010:ext4_writepages+0xd5a/0x1000 [ext4]
[  +0.005995] Code: 8d 94 24 d0 00 00 00 48 89 de e8 11 28 02 00 e9 3e f9 ff ff 0f 0b 8b 44 24 34 4c 8b 64 24 10 31 db 89 44 24 04 e9 9d fc ff ff <0f> 0b 89 44 24 04 e9 45 f6 ff ff 48 8d bc>
[  +0.019761] RSP: 0018:ffffc9003714f9d0 EFLAGS: 00010203
[  +0.005893] RAX: 000000c410000000 RBX: ffffc9003714fc98 RCX: 0000000000000001
[  +0.007820] RDX: ffff8940b1222900 RSI: 0000000000000aa6 RDI: 0000000000000000
[  +0.008025] RBP: ffff88c0ca4ab000 R08: 0000000000000000 R09: ffffffffa08ec1c0
[  +0.007946] R10: 0000000000000200 R11: 0000000000000199 R12: ffff88b32a5a1b78
[  +0.007843] R13: 0000000000000001 R14: ffff88b32a5a1a08 R15: ffffc9003714fc98
[  +0.007854] FS:  0000000000000000(0000) GS:ffff895fff780000(0000) knlGS:0000000000000000
[  +0.008823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.006500] CR2: 00007f98d2daaae0 CR3: 000000000240a003 CR4: 0000000000770ee0
[  +0.007903] PKRU: 55555554
[  +0.003483] Call Trace:
[  +0.003230]  <TASK>
[  +0.002882]  ? find_get_pages_range_tag+0x1b9/0x240
[  +0.005687]  ? pagecache_get_page+0x270/0x520
[  +0.005171]  ? __find_get_block+0xae/0x2e0
[  +0.004907]  ? __cond_resched+0x16/0x50
[  +0.004645]  ? __getblk_gfp+0x27/0x60
[  +0.004479]  ? __ext4_get_inode_loc+0x111/0x470 [ext4]
[  +0.005971]  do_writepages+0xc3/0x1f0
[  +0.004501]  ? __wb_calc_thresh+0x3a/0x120
[  +0.004940]  ? wb_calc_thresh+0x4f/0x70
[  +0.004999]  __writeback_single_inode+0x40/0x2b0
[  +0.005663]  writeback_sb_inodes+0x1f8/0x450
[  +0.005145]  __writeback_inodes_wb+0x4c/0xe0
[  +0.005156]  wb_writeback+0x1de/0x2a0
[  +0.004559]  wb_workfn+0x2dc/0x4c0
[  +0.004293]  ? psi_task_switch+0x74/0x310
[  +0.004895]  ? __switch_to_asm+0x3a/0x60
[  +0.004801]  ? __switch_to_asm+0x34/0x60
[  +0.004801]  process_one_work+0x1c8/0x3a0
[  +0.004897]  worker_thread+0x4d/0x3d0
[  +0.004558]  ? rescuer_thread+0x380/0x380
[  +0.004912]  kthread+0x127/0x150
[  +0.004128]  ? set_kthread_struct+0x50/0x50
[  +0.005080]  ret_from_fork+0x22/0x30
[  +0.004480]  </TASK>
[  +0.003094] Modules linked in: ipmi_devintf nfsv3 fuse overlay dm_zero ext4 mbcache jbd2 dm_mod rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi video ttm intel_gtt 8021q garp stp mrp llc tpm_crb >
[  +0.051170] ---[ end trace 11621178b6045557 ]---
[  +0.416794] RIP: 0010:ext4_writepages+0xd5a/0x1000 [ext4]
[  +0.006407] Code: 8d 94 24 d0 00 00 00 48 89 de e8 11 28 02 00 e9 3e f9 ff ff 0f 0b 8b 44 24 34 4c 8b 64 24 10 31 db 89 44 24 04 e9 9d fc ff ff <0f> 0b 89 44 24 04 e9 45 f6 ff ff 48 8d bc>
[  +0.019984] RSP: 0018:ffffc9003714f9d0 EFLAGS: 00010203
[  +0.005866] RAX: 000000c410000000 RBX: ffffc9003714fc98 RCX: 0000000000000001
[  +0.007767] RDX: ffff8940b1222900 RSI: 0000000000000aa6 RDI: 0000000000000000
[  +0.007765] RBP: ffff88c0ca4ab000 R08: 0000000000000000 R09: ffffffffa08ec1c0
[  +0.007756] R10: 0000000000000200 R11: 0000000000000199 R12: ffff88b32a5a1b78
[  +0.007759] R13: 0000000000000001 R14: ffff88b32a5a1a08 R15: ffffc9003714fc98
[  +0.007756] FS:  0000000000000000(0000) GS:ffff895fff780000(0000) knlGS:0000000000000000
[  +0.008717] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.006378] CR2: 00007f98d2daaae0 CR3: 000000c0a6616005 CR4: 0000000000770ee0
[  +0.007767] PKRU: 55555554
[  +0.003338] ------------[ cut here ]------------
[  +0.005243] WARNING: CPU: 102 PID: 247399 at kernel/exit.c:786 do_exit+0x47/0xa30
[  +0.008112] Modules linked in: ipmi_devintf nfsv3 fuse overlay dm_zero ext4 mbcache jbd2 dm_mod rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi video ttm intel_gtt 8021q garp stp mrp llc tpm_crb >
[  +0.049646] CPU: 102 PID: 247399 Comm: kworker/u519:0 Tainted: G      D           5.15.112.mx64.449 #1
[  +0.010007] Hardware name: Dell Inc. PowerEdge R7525/0T4KXC, BIOS 2.9.3 08/05/2022
[  +0.008277] Workqueue: writeback wb_workfn (flush-251:2)
[  +0.006024] RIP: 0010:do_exit+0x47/0xa30
[  +0.004626] Code: ec 28 65 48 8b 04 25 28 00 00 00 48 89 44 24 20 31 c0 48 8b 83 f8 07 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 26 04 00 00 <0f> 0b 65 8b 0d 30 4b fa 7e 89 c8 25 00 ff>
[  +0.019927] RSP: 0018:ffffc9003714fef0 EFLAGS: 00010212
[  +0.005955] RAX: ffffc9003714fd80 RBX: ffff8940b1222900 RCX: 0000000000000000
[  +0.008494] RDX: ffff88814fb00048 RSI: 0000000000002710 RDI: 000000000000000b
[  +0.007877] RBP: 000000000000000b R08: ffff899fffdedfe8 R09: 000000000004fffb
[  +0.007869] R10: 00000000ffff0000 R11: 3fffffffffffffff R12: 000000000000000b
[  +0.007880] R13: 0000000000000000 R14: ffff8940b1222900 R15: 0000000000000006
[  +0.007885] FS:  0000000000000000(0000) GS:ffff895fff780000(0000) knlGS:0000000000000000
[  +0.008842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.006509] CR2: 00007f98d2daaae0 CR3: 000000c0a6616005 CR4: 0000000000770ee0
[  +0.007997] PKRU: 55555554
[  +0.003637] Call Trace:
[  +0.003200]  <TASK>
[  +0.002852]  make_task_dead+0x2f/0x30
[  +0.004419]  rewind_stack_and_make_dead+0x17/0x20
[  +0.005468] RIP: 0000:0x0
[  +0.003382] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[  +0.007625] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
[  +0.008312] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  +0.007871] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  +0.007851] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  +0.007832] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  +0.007828] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  +0.007828]  </TASK>
[  +0.002865] ---[ end trace 11621178b6045558 ]---


Related user process:

root@galah:/scratch/local2/linux-5.15.112-449.x86_64/source# cat /proc/172601/stack 
[<0>] __inode_wait_for_writeback+0xaf/0xf0
[<0>] inode_wait_for_writeback+0x1d/0x30
[<0>] evict+0xa9/0x160
[<0>] do_unlinkat+0x1cb/0x2c0
[<0>] __x64_sys_unlink+0x3e/0x60
[<0>] do_syscall_64+0x43/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x61/0xcb


The filesystem is created and mounted with

   if fallocate -l ${MXQ_SIZE}G $filename; then
        if loopdevice=$(losetup --find --show $filename); then
            if dmsetup create $dmname --table "0 $((MXQ_SIZE*1024*1024*2)) linear $loopdevice 0"; then
                if mkfs.ext4 \
                        -q \
                        -m 0 \
                        -E nodiscard,mmp_update_interval=300,lazy_journal_init=1,root_owner=$MXQ_UID:0 \
                        -O '64bit,ext_attr,filetype,^has_journal,huge_file,inline_data,^mmp,^quota,sparse_super2' \
                        $dmdevice \
                        && mkdir -p $mountpoint && mount -Odata=writeback,barrier=0  $dmdevice $mountpoint; then
                    rmdir $mountpoint/lost+found
                    status=0
                else
                    dmsetup remove --force --deferred $dmname
                fi
            fi
            losetup -d $loopdevice
        fi
        rm $filename
    else
        test -e $filename && rm $filename
    fi
    exit $status

Which is kind of unusual but done a million times before (part of cluster job startup)

Any ideas?

Thanks

  Donald


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433


