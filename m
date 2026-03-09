Return-Path: <linux-ext4+bounces-14706-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGSKDwBMrmn/BwIAu9opvQ
	(envelope-from <linux-ext4+bounces-14706-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 05:26:40 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7102233ACE
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 05:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF58B300E586
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2026 04:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB65280CE5;
	Mon,  9 Mar 2026 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU1sy2Kj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AF26E709
	for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030395; cv=none; b=FU5aZ1xzVR1OblweYR8SjM6nJKULdTx7SVnhueFOe8BWJF3htHZvIhLy2srf55pcmz2zmJJxhNjv7hE8qxm6xZfD+vpjmeHCdl5Ucmo2Z5r4QOv9vZO+y7fM5T65RvjHi0Mhih3bc+rJCjBfEy7kBcKS8m8l5UFiweX0XxOChaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030395; c=relaxed/simple;
	bh=vUAGm7B+aslPjSFKAr+lGzABcBKiM2/oDCr+lGbC++k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rOJoJzFqqdA+JZMgBYaXp+esq/fDegQZ2aQc9JIi8iXtZ74QBAc0s1A54mdZzQXQn3shngxCx1y9+/0qayzYYUjwjlM++vsecaH1/Gv9dm7S6BiuF7pAznoShk9JGLMaZgch7NV9TBJ4ri3SQiJzjoQ8Ac1w6rzhzFy7wKgejQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU1sy2Kj; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso7052543eec.0
        for <linux-ext4@vger.kernel.org>; Sun, 08 Mar 2026 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773030392; x=1773635192; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqUfzlOcYrDwoSvDO+g3MTOXoD/rKWuXFhJgHWnZviw=;
        b=fU1sy2KjO0v3C+AeRtdirjqeIWM+s3xLU6haQFqzl62PtMftLXT7VlQAjVNeuePwFA
         Zj4Rcn9G+4jDmdYewA6tzLXFzBe4rV8U41wZ/nLt7Sxida6z2fTYcRkZlFfjnc218Cgt
         iOqY/GEPWcxzvlDTcaROf+yy386HGBHgOaw4AJO671G30iSq1X9np4Krs3IceEVn+2xR
         Hskv2XTSgq+Jeylv+cpmEutEZF8a84vY8iVCKZVsUpjrs+n8/0UosZ3RP5j20hlGUOg4
         YvB4MlbFXkyBh/mNYqDP9lYqKKJA8vZIKpE5VtMB5k+HyT7Jps6Ue8U/QDruSTaNgpvD
         OCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773030392; x=1773635192;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqUfzlOcYrDwoSvDO+g3MTOXoD/rKWuXFhJgHWnZviw=;
        b=Mjf62FKMCDs2LSJi72T8W1zxIy4hC2Ng4iGSO1pid3CX6q3Y3zKhMxg+zHXKCo7xIo
         f+1TCwkDR8mxeTN1JW67FINXqWaGWcTD95d5eVOvf3KKtPb5p1WbfHY8yz2geMKUrCzP
         437EOzJzNPMGOAwFuAgPMKCh7wXJ0sHKrINLO+YM/Gfu4NO+0St/r8le7s7XORJUTGWU
         ksgyLNoUCaTVBFIBRc8I0utZ40kQ3/xnZVMlP65h5dOf/HnLwE0RDp9XRMiX+vz7x95e
         Ju1Bp7WsMEdDR8iFqYSv6ItsKLlGAmM1lM0BRMKLrlIUTvvzSxStJmI5Xb7nsFjG4hS+
         x1yA==
X-Gm-Message-State: AOJu0YxbYCHV2Hh4uwN3UX7VwUaZxo6xBXJB+7r/AiOmw/nyXKbTuc9c
	EjLt72Hosb3ZPnSNWl0eK5rW58bqJqw9E46if2+DhjA5zZLrVdUF8Rfb6MksWA==
X-Gm-Gg: ATEYQzyBUZnF9BkMDSKokHZs9KzVmZvWDnnPGhKH6CgqUCZLRSf+6m8lRsbJx/MSDkd
	CeakxmWT3XZuELkTAdRTzuzufk3N08l8T3+qkpJpZUFTmZiDuKiiVeq1Dia8wzEorKFVFDoc7hH
	3mgJj7AmX3Z3sh6O2cdfYeh7m6hF70G1Mk06SwRa80vF2IpLweBbnSDw41NoDcwOsAaUpLvl/0/
	P303gdoYyEHxqA8zMcFHSF82ix5SROUY6vsgvbpoWPdT9qjSxsHW9aKrT12rtgdhnjanokgzvya
	nB0Kr4Le6FpgeZzOFEvK1XemQo6wiSPLYbNc3Abr4EZMY2OxJ7/EKuJWLFaelsLFzJS7Ao98biZ
	QpQGMOju+KjNYV8Jj2JukXuDQsrj8KS/7KXNiXbcDef2zapwsHLBpJ/vixskmTcLhpTsbqtXDm+
	DGDeWM0yigMDQwmWI/m4XJnOxbc8qtSjUrneYe6mpgWDicNDXGzpDsIIyZBwmHYXxJVXm2EQ==
X-Received: by 2002:a05:7300:148a:b0:2ba:7046:b6b5 with SMTP id 5a478bee46e88-2be4e6d13c5mr3546634eec.15.1773030392350;
        Sun, 08 Mar 2026 21:26:32 -0700 (PDT)
Received: from ryzoh.168.0.127 ([2804:14c:5fc8:80a3:7751:e4ac:e76b:8489])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948565sm7343293eec.16.2026.03.08.21.26.31
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:26:31 -0700 (PDT)
Date: Mon, 9 Mar 2026 01:26:30 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: linux-ext4@vger.kernel.org
Subject: [BUG] Warning in ext4_check_map_extents_env
Message-ID: <3pawn6eh3odal2tnkrjlb7zebf2vvhy53ns5qt3qhdsoh7cgnq@zkiso6idb2tm>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: C7102233ACE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14706-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pedrodemargomes@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
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


