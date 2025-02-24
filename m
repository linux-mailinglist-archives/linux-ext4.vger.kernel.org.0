Return-Path: <linux-ext4+bounces-6537-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE2DA41479
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 05:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F47189298E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 04:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259E1A2391;
	Mon, 24 Feb 2025 04:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fR3sf9fk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC319D8A2
	for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2025 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740370838; cv=none; b=DBAV1vFW8h02d2qnfGQe3qzcd9bm80x8KraJXwXSgBmnDg28QY5pe0LvY7PBnfc6AP2aGBlHANVmGpT7h+A2YRUJiKeh8hgOogF6pWLh0ad75lTvs0LLhEzPeVCnXCxnBmjSqBxqHoK20UgZg7JGAHG7EJPUHt0n3Zf2jph/LfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740370838; c=relaxed/simple;
	bh=0yzOjpFgFSqaAZM7qv9f7WL2LPH671WErlXgqW84KAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyRoenN2SBgNF+gpsoKzZS2G2xCVFnu47YY5sotjauD5mgXEMHzS86x3JGaitW+/ynssLsr4fprGyHZa+f7vgkT19ew8lTDkUxrtZPq01hPRT62olK2Y0tohPVExEEuYsI3pEPHJcfmo0jAySTsSDSEWF73xpzZ5ppiDH+UlMWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fR3sf9fk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p/zeftyL/wdqjBjHUFASN1DfPVUhKmKWpHarfqFHElw=; b=fR3sf9fkLeXMePvTamBYV/OWPn
	0ND42bjwgKVuy0/NmPqENEdavsesqskHcmv8OLowyhu7PeqGA7vyalyDS6aMsN9DSJ2G66/PMRJ8X
	rzq0+D+ntgj9z/Qc9lpkgPutWOucTh3YHzLK8GglptI0aeeWWrK1M7noyKhHbR4TOQFgHruh/9NJG
	6XXS5i/ph/jziThjHOId0K+aFwBJnmLkB3P7K3VaHKIBqFOuDOOFaezs6E3k9WzTf97BcxeErhky+
	Xc6DhGZMRaSu8phUBZ2FasezkGWBlj1S14/MM7LCL28OjnKnjCu50OvMwiR13Rmhb+Y8fz8kgplFy
	kyVWCKfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmPxJ-00000005nej-2NuL;
	Mon, 24 Feb 2025 04:20:33 +0000
Date: Mon, 24 Feb 2025 04:20:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: ext4 crash on generic/437 on 6.14-rc3 on truncation
Message-ID: <Z7vzkS9LIZK5zWCr@casper.infradead.org>
References: <Z7vIBq-Zuo6Z7ihr@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7vIBq-Zuo6Z7ihr@bombadil.infradead.org>

On Sun, Feb 23, 2025 at 05:14:46PM -0800, Luis Chamberlain wrote:
> The full splat follows but the gist is a truncation leading to a
> CONFIG_DEBUG_VM VM_BUG_ON_FOLIO(folio_mapped(folio)) assert on
> filemap_unaccount_folio():

Known, reported, fix available.

> Feb 21 23:18:14 extra-ext4-4k unknown: run fstests generic/437 at 2025-02-21 23:18:14
> Feb 21 23:18:15 extra-ext4-4k kernel: BUG: Bad rss-counter state mm:000000004821c061 type:MM_FILEPAGES val:5

https://lore.kernel.org/linux-mm/?q=bad+rss-counter

will lead you to CONFIG_PT_RECLAIM=y being the problem.

https://lore.kernel.org/linux-mm/dda6b378-c344-4de6-9a55-8571df3149a7@bytedance.com/
is the fix, and that's now f39edcf6349a upstream.

> Feb 21 23:18:15 extra-ext4-4k kernel: BUG: Bad rss-counter state mm:000000004821c061 type:MM_ANONPAGES val:1
> Feb 21 23:18:16 extra-ext4-4k kernel: page: refcount:3 mapcount:1 mapping:00000000cf1f4692 index:0x1 pfn:0x15a582
> Feb 21 23:18:16 extra-ext4-4k kernel: memcg:ffff9cfcadd32800
> Feb 21 23:18:16 extra-ext4-4k kernel: aops:ext4_da_aops [ext4] ino:3b
> Feb 21 23:18:16 extra-ext4-4k kernel: flags: 0x17fffde0000022d(locked|referenced|uptodate|lru|workingset|node=0|zone=2|lastcpupid=0x1ffff)
> Feb 21 23:18:16 extra-ext4-4k kernel: raw: 017fffde0000022d ffffef76457ee008 ffffef7645770148 ffff9cfc40565428
> Feb 21 23:18:16 extra-ext4-4k kernel: raw: 0000000000000001 0000000000000000 0000000300000000 ffff9cfcadd32800
> Feb 21 23:18:16 extra-ext4-4k kernel: page dumped because: VM_BUG_ON_FOLIO(folio_mapped(folio))
> Feb 21 23:18:16 extra-ext4-4k kernel: ------------[ cut here ]------------
> Feb 21 23:18:16 extra-ext4-4k kernel: kernel BUG at mm/filemap.c:154!
> Feb 21 23:18:16 extra-ext4-4k kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> Feb 21 23:18:16 extra-ext4-4k kernel: CPU: 1 UID: 0 PID: 762896 Comm: umount Not tainted 6.14.0-rc3 #1
> Feb 21 23:18:16 extra-ext4-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
> Feb 21 23:18:16 extra-ext4-4k kernel: RIP: 0010:filemap_unaccount_folio+0x153/0x1f0
> Feb 21 23:18:16 extra-ext4-4k kernel: Code: b0 f0 00 00 00 e9 2d ef 00 00 48 c7 c6 80 e4 04 94 48 89 df e8 de 09 05 00 0f 0b 48 c7 c6 00 ae 06 94 48 89 df e8 cd 09 05 00 <0f> 0b 48 8b 06 a8 40 74 4c 8b 43 50 e9 ce fe ff ff 48 c7 c6 80 e4
> Feb 21 23:18:16 extra-ext4-4k kernel: RSP: 0018:ffffb7914536ba68 EFLAGS: 00010046
> Feb 21 23:18:16 extra-ext4-4k kernel: RAX: 0000000000000039 RBX: ffffef7645696080 RCX: 0000000000000000
> Feb 21 23:18:16 extra-ext4-4k kernel: RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
> Feb 21 23:18:16 extra-ext4-4k kernel: RBP: ffff9cfc40565428 R08: 0000000000000000 R09: ffffb7914536b908
> Feb 21 23:18:16 extra-ext4-4k kernel: R10: ffffffff9425ddc8 R11: 0000000000000003 R12: 0000000000000002
> Feb 21 23:18:16 extra-ext4-4k kernel: R13: ffffffffffffffff R14: ffffb7914536bb28 R15: ffff9cfc40565430
> Feb 21 23:18:16 extra-ext4-4k kernel: FS:  00007fbeda228800(0000) GS:ffff9cfcbbc40000(0000) knlGS:0000000000000000
> Feb 21 23:18:16 extra-ext4-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Feb 21 23:18:16 extra-ext4-4k kernel: CR2: 000055ed3e68a808 CR3: 000000010a186006 CR4: 0000000000772ef0
> Feb 21 23:18:16 extra-ext4-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Feb 21 23:18:16 extra-ext4-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Feb 21 23:18:16 extra-ext4-4k kernel: PKRU: 55555554
> Feb 21 23:18:16 extra-ext4-4k kernel: Call Trace:
> Feb 21 23:18:16 extra-ext4-4k kernel:  <TASK>
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? __die_body.cold+0x19/0x26
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? die+0x2a/0x50
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? do_trap+0xc6/0x110
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? do_error_trap+0x6a/0x90
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? filemap_unaccount_folio+0x153/0x1f0
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? exc_invalid_op+0x4c/0x60
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? filemap_unaccount_folio+0x153/0x1f0
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? asm_exc_invalid_op+0x16/0x20
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? filemap_unaccount_folio+0x153/0x1f0
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? filemap_unaccount_folio+0x153/0x1f0
> Feb 21 23:18:16 extra-ext4-4k kernel:  delete_from_page_cache_batch+0x91/0x3b0
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? up_read+0x37/0x70
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? unmap_mapping_folio+0x85/0x150
> Feb 21 23:18:16 extra-ext4-4k kernel:  truncate_inode_pages_range+0x108/0x540
> Feb 21 23:18:16 extra-ext4-4k kernel:  ext4_evict_inode+0x320/0x6e0 [ext4]
> Feb 21 23:18:16 extra-ext4-4k kernel:  evict+0x108/0x290
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? fsnotify_destroy_marks+0x26/0x1a0
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? list_lru_del+0xbd/0x150
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? __pfx_i_callback+0x10/0x10
> Feb 21 23:18:16 extra-ext4-4k kernel:  ? __call_rcu_common.constprop.0+0x104/0x220
> Feb 21 23:18:16 extra-ext4-4k kernel:  evict_inodes+0x198/0x240
> Feb 21 23:18:16 extra-ext4-4k kernel:  generic_shutdown_super+0x3e/0x100
> Feb 21 23:18:16 extra-ext4-4k kernel:  kill_block_super+0x16/0x40
> Feb 21 23:18:16 extra-ext4-4k kernel:  ext4_kill_sb+0x1e/0x40 [ext4]
> Feb 21 23:18:16 extra-ext4-4k kernel:  deactivate_locked_super+0x2c/0xb0
> Feb 21 23:18:16 extra-ext4-4k kernel:  cleanup_mnt+0xba/0x150
> Feb 21 23:18:16 extra-ext4-4k kernel:  task_work_run+0x55/0x90
> Feb 21 23:18:16 extra-ext4-4k kernel:  syscall_exit_to_user_mode+0x172/0x180
> Feb 21 23:18:16 extra-ext4-4k kernel:  do_syscall_64+0x57/0x110
> Feb 21 23:18:16 extra-ext4-4k kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Feb 21 23:18:16 extra-ext4-4k kernel: RIP: 0033:0x7fbeda4694f7
> Feb 21 23:18:16 extra-ext4-4k kernel: Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 f9 58 0d 00 f7 d8 64 89 02 b8
> Feb 21 23:18:16 extra-ext4-4k kernel: RSP: 002b:00007fff95bb1818 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> Feb 21 23:18:16 extra-ext4-4k kernel: RAX: 0000000000000000 RBX: 000055ed3e684b68 RCX: 00007fbeda4694f7
> Feb 21 23:18:16 extra-ext4-4k kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055ed3e68a810
> Feb 21 23:18:16 extra-ext4-4k kernel: RBP: 0000000000000000 R08: 00000000000000a0 R09: 00007fbeda53fb20
> Feb 21 23:18:16 extra-ext4-4k kernel: R10: 0000000000000008 R11: 0000000000000246 R12: 00007fbeda5c2244
> Feb 21 23:18:16 extra-ext4-4k kernel: R13: 000055ed3e68a810 R14: 000055ed3e684e70 R15: 000055ed3e684a60
> Feb 21 23:18:16 extra-ext4-4k kernel:  </TASK>
> Feb 21 23:18:16 extra-ext4-4k kernel: Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison sd_mod sg scsi_mod scsi_common xfs dm_flakey dm_snapshot dm_bufio dm_zero loop sunrpc 9p nls_iso8859_1 crc32c_generic nls_cp437 vfat fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd virtio_console 9pnet_virtio virtio_balloon joydev evdev button serio_raw dm_mod nvme_fabrics nvme_core drm nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring [last unloaded: scsi_debug]
> Feb 21 23:18:16 extra-ext4-4k kernel: ---[ end trace 0000000000000000 ]---
> Feb 21 23:18:16 extra-ext4-4k kernel: RIP: 0010:filemap_unaccount_folio+0x153/0x1f0
> Feb 21 23:18:16 extra-ext4-4k kernel: Code: b0 f0 00 00 00 e9 2d ef 00 00 48 c7 c6 80 e4 04 94 48 89 df e8 de 09 05 00 0f 0b 48 c7 c6 00 ae 06 94 48 89 df e8 cd 09 05 00 <0f> 0b 48 8b 06 a8 40 74 4c 8b 43 50 e9 ce fe ff ff 48 c7 c6 80 e4
> Feb 21 23:18:16 extra-ext4-4k kernel: RSP: 0018:ffffb7914536ba68 EFLAGS: 00010046
> Feb 21 23:18:16 extra-ext4-4k kernel: RAX: 0000000000000039 RBX: ffffef7645696080 RCX: 0000000000000000
> Feb 21 23:18:16 extra-ext4-4k kernel: RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
> Feb 21 23:18:16 extra-ext4-4k kernel: RBP: ffff9cfc40565428 R08: 0000000000000000 R09: ffffb7914536b908
> Feb 21 23:18:16 extra-ext4-4k kernel: R10: ffffffff9425ddc8 R11: 0000000000000003 R12: 0000000000000002
> Feb 21 23:18:16 extra-ext4-4k kernel: R13: ffffffffffffffff R14: ffffb7914536bb28 R15: ffff9cfc40565430
> Feb 21 23:18:16 extra-ext4-4k kernel: FS:  00007fbeda228800(0000) GS:ffff9cfcbbc40000(0000) knlGS:0000000000000000
> Feb 21 23:18:16 extra-ext4-4k kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> Feb 21 23:18:16 extra-ext4-4k kernel: CR2: 000055ed3e68a808 CR3: 000000010a186006 CR4: 0000000000772ef0
> Feb 21 23:18:16 extra-ext4-4k kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> Feb 21 23:18:16 extra-ext4-4k kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Feb 21 23:18:16 extra-ext4-4k kernel: PKRU: 55555554
> Feb 21 23:18:16 extra-ext4-4k kernel: note: umount[762896] exited with irqs disabled
> Feb 21 23:18:16 extra-ext4-4k kernel: note: umount[762896] exited with preempt_count 2
> Feb 22 06:14:17 extra-ext4-4k kernel: kauditd_printk_skb: 1 callbacks suppressed
> 
>   Luis
> 

