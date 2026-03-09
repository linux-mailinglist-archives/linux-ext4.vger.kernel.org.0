Return-Path: <linux-ext4+bounces-14714-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IMWEBrOrmnEIwIAu9opvQ
	(envelope-from <linux-ext4+bounces-14714-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 14:41:46 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C781B239E60
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9CAD302C332
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2026 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E13BE165;
	Mon,  9 Mar 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXoV9f1F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E838E102
	for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2026 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063683; cv=none; b=TxjmkORn2Xew936ovQVMdttT38Wauu3Arm5sy6yK5Nd0K5VsU6+/4mSbUzKWSGj8SgYJzd7C3cJn2FqlAunRNzLxNg6WElT9UUkRci97xMZpgl6wZRDfQILsU547fn7Ur/dpygWRIT4dEDmhEppEWKarGYrowauR229P8yb9wsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063683; c=relaxed/simple;
	bh=vUAGm7B+aslPjSFKAr+lGzABcBKiM2/oDCr+lGbC++k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OTcRf4ZcihnFfUbLVzKFhsaiV/QDLozHBDp6piiLuDqFnQCAE7CrsvxwLIIfWLoljYs+s0fFSC4Yxc2bYn6z8apM6Xy0pru5y5zWxW91wbshcPm3rJ3ae+5JuZU7W4mm7LNsNmQgTmp85ECJveJoO+obbPyz5Lr+t5l78euk4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXoV9f1F; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso9722547eec.0
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2026 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773063679; x=1773668479; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqUfzlOcYrDwoSvDO+g3MTOXoD/rKWuXFhJgHWnZviw=;
        b=KXoV9f1FRDsgiZhJ0nSDbhn8ztGlz2KGol8Ln3SKNZ6F+ZkrpJivektcQurGzQXxmw
         USEDASlMGpuVAwkg2yM2fDNplVQ/O2Ayu5LQyYuJGtMzdwUOe9aZm1uf8dV/8BdqrDbv
         2GMlWmrqrApUAsxOli3EoyG6f+qPA3SXwKBo3/dP+IuFclIct+ClyqW2ff+pNkRjfckJ
         bOJVPjPHBj6A7TYUYtHO4bKpPF6QpYOF3rATGZlicf2l7UASRFAhT4eNAjY5Z+BJBTqg
         VGEU6fG4a+T8XIlSnFtXMHFAihg9GUoqmepJOVL62V7ucUZrlZqFwIG3oUUC0ZgCvSUP
         yG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063679; x=1773668479;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqUfzlOcYrDwoSvDO+g3MTOXoD/rKWuXFhJgHWnZviw=;
        b=IKIWctCO+NTJ5YdrcjQjPOZe6aqQZTNfnUiZVPbB1rMsaykeCMlC1Gnw971otClS2W
         u4XVGZD8vpuxou+tnoVct4qyS6sKfCvIgLqd9aXPhjoWg/tdvLW3RCPyJT1NlmZjhiCA
         WgAXJ48yJs6ksf16lXhGb394dhk5sd5LXUUJ1t1ORYugL/UWTOr7mzTG0VjQ8+QnYIOE
         pVzeaOA+aopr/fUO/MfnYSCIPCuv0ArIQ4qwU0IYmzK49huoqazIZvjPcXV48Gf+bwXh
         94FbAGzrWpkJmZNQJxg+1c2Kx0t4wZUjqLSqq/sqGSrVQAuUVys0XKJMmRi6N0anNIb4
         z5fA==
X-Gm-Message-State: AOJu0YxFIUCtu/XQKqvbi3chZwoo8WQbLNQro1sng+9QsBJwOEHdn+Ra
	0g6Do/DyuHnk/zqepSBg0lbl9V/tiMYvdCCJISm/0mMUIib9DPcJoTdrdSgNvA==
X-Gm-Gg: ATEYQzwQBHfgMBUxV5uyw4lFt6DkM8teBw9rf/FxDxRFjVZrP9CmcOHClvNq4eMvDHP
	N9+TKE6BMyrmaMznZSAq6evfFfJbivBux7YyyiXwbwQOfrPkKGxJzH58VbLZH8fNJmprCwyXY+L
	9w1T93DjzBx5ylj1ibneQvI3bm09hnX+NsXF81sUhTqtLfD7BJdDdig++x+Pb5QYMgzB99qk6sg
	y2R+4D2ihU06DQYlhbDj2pmwfNgAMrbmCB+GbLqW09o+9u8LBQPqFK4W3ZljJKrCSBdpKZ/fxNS
	sZfAYRszOvOTHzenBd816qnhWxGO8geQ9vSqxZlVFwPf9yxMeCT71HiNc7lXObvnNUJbltNE3Fh
	6FhmDb7MAXRauZHDsiz1/9T92PPuQ4NOYTkVxhP14wqiRAMzR6vnRV76fEnZKdp5hWcF1/j1kYD
	ZRlJXc8TwXXutfUxnH17l93xylLkc5AZGkGPUqsJCTdjHeTaeBmkeZQ3UBML8=
X-Received: by 2002:a05:693c:2c0e:b0:2be:6b70:da06 with SMTP id 5a478bee46e88-2be6b70ddc4mr1439913eec.25.1773063678537;
        Mon, 09 Mar 2026 06:41:18 -0700 (PDT)
Received: from fedora ([2804:30c:2764:a200:5385:27ed:62fd:1204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be56d73a20sm9368658eec.8.2026.03.09.06.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:41:18 -0700 (PDT)
Date: Mon, 9 Mar 2026 10:41:13 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Subject: [BUG] Warning in ext4_check_map_extents_env
Message-ID: <aa7Ms0MzyPKggFGo@fedora>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: C781B239E60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14714-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pedrodemargomes@gmail.com,linux-ext4@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.900];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

The warning below occurs when running selftests/mm/merge on a kernel built
with CONFIG_EXT4_DEBUG=y.

syzkaller login: [   29.277674] ------------[ cut here ]------------
[   29.279636] WARNING: fs/ext4/inode.c:436 at ext4_check_map_extents_env+0x389/0x440, CPU#1: merge/365
[   29.282459] Modules linked in:
[   29.283497] CPU: 1 UID: 0 PID: 365 Comm: merge Not tainted 7.0.0-rc3 #59 PREEMPT(full)
[   29.285999] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   29.288850] RIP: 0010:ext4_check_map_extents_env+0x389/0x440
[   29.290653] Code: ff 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 87 00 00 00 48 8b 45 18 48 85 c0 0f 85 2e fd ff ff 90 <0f> 0b 90 e9 25 fd ff ff e8 8a 2e ca ff e9 e4 fc ff ff 48 89 df e8
[   29.296623] RSP: 0018:ffff88811876f2a8 EFLAGS: 00010246
[   29.298288] RAX: 0000000000000000 RBX: ffff888106c66798 RCX: ffffffff81e8ad60
[   29.300529] RDX: 1ffff11020d8ccf3 RSI: 0000000000000008 RDI: ffff888106c66798
[   29.302748] RBP: ffff888106c66780 R08: 0000000000000000 R09: ffffed1020d8ccf3
[   29.305009] R10: ffff888106c6679f R11: 0000000000000001 R12: 00000000001e0c26
[   29.307226] R13: ffff88811876f494 R14: ffff88811876f498 R15: ffff88811876f488
[   29.309477] FS:  00007fbe82723780(0000) GS:ffff8883c38aa000(0000) knlGS:0000000000000000
[   29.312085] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.313749] CR2: 00007fbe82790915 CR3: 000000011880e000 CR4: 00000000000006f0
[   29.315643] Call Trace:
[   29.316170]  <TASK>
[   29.316539]  ext4_map_blocks+0x602/0xb40
[   29.317204]  ? __pfx_ext4_map_blocks+0x10/0x10
[   29.317971]  ? __pfx_stack_trace_save+0x10/0x10
[   29.318719]  ? __filemap_add_folio+0x66f/0xb30
[   29.319500]  ext4_mpage_readpages.constprop.0.isra.0+0x918/0xe20
[   29.320501]  ? __pfx_ext4_mpage_readpages.constprop.0.isra.0+0x10/0x10
[   29.321602]  ? filemap_add_folio+0x11e/0x2c0
[   29.322325]  ? __pfx_ext4_read_folio+0x10/0x10
[   29.323107]  ext4_read_folio+0xd9/0x230
[   29.323762]  ? __pfx_ext4_read_folio+0x10/0x10
[   29.324552]  ? __pfx_ext4_read_folio+0x10/0x10
[   29.325321]  filemap_read_folio+0x43/0x150
[   29.326041]  do_read_cache_folio+0x1b1/0x320
[   29.326759]  read_cache_page+0x46/0x120
[   29.327426]  install_breakpoint+0x27d/0x810
[   29.328123]  uprobe_mmap+0x439/0xeb0
[   29.328715]  ? __pfx_uprobe_mmap+0x10/0x10
[   29.329391]  __mmap_region+0x8af/0x2290
[   29.330074]  ? __pfx___mmap_region+0x10/0x10
[   29.330793]  ? unwind_get_return_address+0x59/0xa0
[   29.331630]  ? event_sched_in+0x33f/0xaf0
[   29.332308]  ? perf_event_groups_next+0x9a/0x200
[   29.333667]  ? mm_get_unmapped_area_vmflags+0x6c/0xe0
[   29.335295]  ? mmap_region+0xd3/0x2b0
[   29.336171]  do_mmap+0x98a/0xec0
[   29.336713]  ? ipe_mmap_file+0xcf/0xe0
[   29.337340]  ? __pfx_do_mmap+0x10/0x10
[   29.337977]  ? __pfx_down_write_killable+0x10/0x10
[   29.338757]  ? __pfx_mutex_unlock+0x10/0x10
[   29.339477]  vm_mmap_pgoff+0x1b2/0x310
[   29.340114]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[   29.340819]  ? __pfx___do_sys_perf_event_open+0x10/0x10
[   29.341688]  ? fget+0x189/0x230
[   29.342223]  ksys_mmap_pgoff+0x2b1/0x5b0
[   29.342868]  ? __pfx_ksys_mmap_pgoff+0x10/0x10
[   29.343618]  do_syscall_64+0xe2/0x560
[   29.344246]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   29.345105] RIP: 0033:0x7fbe82832de2
[   29.345707] Code: 00 00 00 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 3b 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 5b 5d c3 0f 1f 00 48 8b 05 f9 8f 0d 00 64
[   29.348851] RSP: 002b:00007ffd535f3b38 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
[   29.350309] RAX: ffffffffffffffda RBX: 00007fbe826f9000 RCX: 00007fbe82832de2
[   29.351526] RDX: 0000000000000004 RSI: 000000000000a000 RDI: 00007fbe826f9000
[   29.352865] RBP: 0000000000000012 R08: 000000000000000b R09: 0000000000000000
[   29.354136] R10: 0000000000000012 R11: 0000000000000206 R12: 00007ffd535f4120
[   29.355357] R13: 0000000000000000 R14: 000000000000000b R15: 0000000000001000
[   29.356684]  </TASK>
[   29.357119] ---[ end trace 0000000000000000 ]---

The warning is triggered by TEST_F(merge, handle_uprobe_upon_merged_vma) in
selftests/mm/merge.c. It occurs during the first mmap() following the
__NR_perf_event_open syscall, as shown in the excerpt below:

TEST_F(merge, handle_uprobe_upon_merged_vma)
{
	const size_t attr_sz = sizeof(struct perf_event_attr);
	unsigned int page_size = self->page_size;
	const char *probe_file = "./foo";
	char *carveout = self->carveout;
	struct perf_event_attr attr;
	unsigned long type;
	void *ptr1, *ptr2;
	int fd;

	fd = open(probe_file, O_RDWR|O_CREAT, 0600);
	ASSERT_GE(fd, 0);

	ASSERT_EQ(ftruncate(fd, page_size), 0);
	if (read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) != 0) {
		SKIP(goto out, "Failed to read uprobe sysfs file, skipping");
	}

	memset(&attr, 0, attr_sz);
	attr.size = attr_sz;
	attr.type = type;
	attr.config1 = (__u64)(long)probe_file;
	attr.config2 = 0x0;

	ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);

	ptr1 = mmap(&carveout[page_size], 10 * page_size, PROT_EXEC,
		    MAP_PRIVATE | MAP_FIXED, fd, 0); < WARNING!!!
	ASSERT_NE(ptr1, MAP_FAILED);

	getchar();

	ptr2 = mremap(ptr1, page_size, 2 * page_size,
		      MREMAP_MAYMOVE | MREMAP_FIXED, ptr1 + 5 * page_size);
	ASSERT_NE(ptr2, MAP_FAILED);

	ASSERT_NE(mremap(ptr2, page_size, page_size,
			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);

out:
	close(fd);
	remove(probe_file);
}

The issue originates from the following call chain:
	prepare_uprobe
	  -> copy_insn
	       -> __copy_insn
		    -> read_mapping_page() or shmem_read_mapping_page()

Both read_mapping_page() and shmem_read_mapping_page() are invoked
without holding i_rwsem or invalidate_lock. When CONFIG_EXT4_DEBUG
is enabled, this triggers the warning in ext4_check_map_extents_env().


