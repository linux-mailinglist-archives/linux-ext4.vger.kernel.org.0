Return-Path: <linux-ext4+bounces-14705-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALDKEU87rmn4AgIAu9opvQ
	(envelope-from <linux-ext4+bounces-14705-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 04:15:27 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E422337DB
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Mar 2026 04:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 003DE301938A
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2026 03:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0B287511;
	Mon,  9 Mar 2026 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHqFZgNE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A85287263
	for <linux-ext4@vger.kernel.org>; Mon,  9 Mar 2026 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773026113; cv=pass; b=Jw8/qjrK10FEZrWMgrkHXPA0L6Qj2f68LZrFc/M4dI2n/XjXyjIzitpgzbbKufUVCIa15/lHeD03Q18BDLfbsLmTM3Ov7It9kcHxnBfyugM6suKK1pKySCmazA1Hg3L52597ifp26P4H7HwdF8FS3DJWzOAJ2P2PxItr9gJJGIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773026113; c=relaxed/simple;
	bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bChZQ92dopnUTGtKShDXIx1SprSI1JTBRS1HXEnSxxIclp5RsTBviKhLtCG+6rzrnmz6BJvSWlBDeALPg5lCbA7/gVLXah/+bDlBBa+dxVWfvk0tRdAVipFVIHiuL7w2LqrqmJFnhefxYVZGyXk3Tvsro86FD7onBdoxLCd9/DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHqFZgNE; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41920so4132087b3a.2
        for <linux-ext4@vger.kernel.org>; Sun, 08 Mar 2026 20:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773026109; cv=none;
        d=google.com; s=arc-20240605;
        b=K3BiCbYhFuyxpX0e9dB96KJ1iD8XyZ48hQNBnoria0WqOzLycB8rh/0xJm7qUDSdGc
         Yp1L8wi3okRXy7CQMgwCq8uiFjUTdoim57yLy08Hjx9Ujv+A9Z1TYMo9bl8Py1N6LhxS
         rXe+k9HrbTpytfKH4qlglj/O2Rb9b211ZdMrR3JdmGcEGEV4ZeVAECSymxhP+ffW/9wP
         hrDkS7dIgpL7OCEGoIMeyFT8NlAMb4/Ee8oEG4Tc+M6HGmzoMRKS/BBLYvhTH34dqXgR
         M1/hm5MI6PT7gudafXy5F9UZcLlp55hPeCCniYx1oQwZt8CrHhttAWTJpiogc/ox7jW2
         czmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
        fh=TLRCVuseuHUHrWm/0vpcm0VW4DNQYKhS+kh5DpHwr9o=;
        b=Rekp9TOlPgD2fV1wtqY+wr1L+EDlXW2ytL81IdKz/oGaNOroakYT5HzMOLJKzyRF+8
         sqQcp0eSmfyDoK5hYhjT3gw/bJpLioepuUSPGOc6XVfxN8sDIdLB5ZXmWWS9L1uyqNgc
         0pIPu/n5TEZ3MvrF8416LWcMiIU8bEL3Bumfq+3/tkQ1w1+21bbS6+voRDtZU3oIinfe
         xLR753c/A73PwQKkaiDj0K37ZfmZvPr7s7MoCw2wi6Bt0gAbZ/8B0XwSC8BobmOi6ICY
         dL5ZVkgxn5zPHV16x1taJ1JyrFmIBUHlID/z6vSF/Fy0JpL13FPyT7OAhDc5muBIgv8W
         4QWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773026109; x=1773630909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
        b=dHqFZgNEQs5te4kW8xYyzm0XhoJQpWk0YW72SU2h9W4Cxi7BMjBin16+bRAcexVKWi
         FGU0c16KaFr3LcoxghkwkpoVBELD6evfUlBxD4LD2pejkQr20BQvvPiGrw5s8DFMKd6a
         Q6eTNEux5uD1WJz/MzqeOS7cNYGDQbCG82r1/9VgdMDT4WoZbBMU0RrDdlP+YyzknOXx
         GAh8+DhjSQ8JulYj5SMGHnvspUJ6jbRodm6iE6QFr5vJQvfPIovGDRrG9NPWv2G19DzJ
         28o5Rg8PH6GK+bXTrXqDXGLHBLJKpnTE3GG/lc4HkNQaSiXE95iJ2+hAh692r9P+8tO5
         9B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773026109; x=1773630909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZSiPj1NVyhvizWhUUC0wPEd9YxwtDfmbckRRyPoO0c=;
        b=SLhrEkqiH1bjOlklxgMy4NuIKc6UyW0+LeFcL7qVfS4aOg44PyQaw2mBy5BBKzw4md
         BG+eoFASOHSwdBdCB5LI8+ywjIFo8HFK+Lt0Q9nl8vZtScA02AwLcWxkLqQ64Fms1ar1
         ZESt8PcMn1QaG15LzrbaCoFhpnYvJS2LHm7I6GuT+eQ8b/eqGStRcgBjaktoIwoWhGPH
         BisX7Xb2gpeUVU7bAJFcIM2Q9sDOCvfao0KnR2pwmL+wp85AqWqOpO3U+FnNdoNgvUQs
         v1YspaJJyX2IKEWCrnc8tDqe89Kr0JlgNtX1Zg4sPMWRFtuUvWuxFiGeQ510Kn0YZCxq
         OVJw==
X-Forwarded-Encrypted: i=1; AJvYcCVfWbDxLO3yI//L38hnkOShFnh1Hamp1Zhyu54yVf6xO80qXZSMuciRjSCoUGsGLLbb3AQzOfYJ2B+H@vger.kernel.org
X-Gm-Message-State: AOJu0YzPle1zXVhpGItXhZSfbRp5UTz/EqKFBeOqwlHXqzKId1j/82Tt
	ZFmmJL9Ttxm11wr0kGl0999ynN2EpntRdFNnUn1p/6xWDAj4oMDRuQ/C/GutVr6O1Ric1L+kbRJ
	Hc4T/OrLNquQirON/3OaIwjnTjQYik9o=
X-Gm-Gg: ATEYQzzv6Ft3CPkVfR01B3vidkvdbKLvFUWuypdOVjpn9GnL1DQ0uDgM9klOWyhJrDX
	vcDE/Ti5jssMp9Wv1/YgNZxGab3Jb2gU5zUk3sb0BsMjgmF+SXPp/4YrFbU2EFA0MZ0DUXLSVA6
	eT6vHZd6T/HDruds04fV0E/489FMk8+LgJbw48MbJGVS9rRz2oBlyFzeGJa+8mkxDF6KT0CzVcI
	Zdo7R//SKSM/XbMPrfs+ZG04udRxmbnKZYNPPUNKQK4nP1fbrTxxAthSaIEizlvu2mstbCsMETt
	m+cWRdU=
X-Received: by 2002:a05:6300:492:b0:398:7d6e:27f1 with SMTP id
 adf61e73a8af0-3987d6e4e98mr3093477637.9.1773026108783; Sun, 08 Mar 2026
 20:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Mon, 9 Mar 2026 11:14:58 +0800
X-Gm-Features: AaiRm52UI71Zsv1DyyQfuTtqar8_kcar-WvI_WLGIKWrKj10BzZgSbMrapZjPpE
Message-ID: <CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com>
Subject: [BUG] WARNING in alloc_slab_obj_exts triggered by __d_alloc
To: Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B2E422337DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14705-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.837];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shicenci@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

I encountered a WARNING in alloc_slab_obj_exts() while running a
syzkaller-generated reproducer on Linux 7.0-rc2.

The warning is triggered during dentry allocation (__d_alloc) after
mounting a crafted ext4 filesystem image.

Kernel
git tree: torvalds/linux
commit=EF=BC=9A 0031c06807cfa8aa51a759ff8aa09e1aa48149af
kernel version:Linux 7.0.0-rc2-00057-g0031c06807cf
hardware: QEMU Ubuntu 24.10

I was able to reproduce this issue reliably using the attached
reproducer.

Reproducer=EF=BC=9A
C reproducer: https://pastebin.com/raw/eHjm2Aw6
console output: https://pastebin.com/raw/FQAhquTy
kernel config: pastebin.com/raw/CnHdTQNm

The warning originates from:

mm/slub.c:2189

Call trace:

WARNING: mm/slub.c:2189 at alloc_slab_obj_exts+0x132/0x180
CPU: 0 UID: 0 PID: 699 Comm: syz.0.118

Call Trace:
 <TASK>
 __memcg_slab_post_alloc_hook+0x130/0x460 mm/memcontrol.c:3234
 memcg_slab_post_alloc_hook mm/slub.c:2464 [inline]
 slab_post_alloc_hook.constprop.0+0x9c/0xf0 mm/slub.c:4526
 slab_alloc_node.constprop.0+0xaa/0x160 mm/slub.c:4844
 __do_kmalloc_node mm/slub.c:5237 [inline]
 __kmalloc_noprof+0x82/0x200 mm/slub.c:5250
 kmalloc_noprof include/linux/slab.h:954 [inline]
 __d_alloc+0x235/0x2f0 fs/dcache.c:1757
 d_alloc_pseudo+0x1d/0x70 fs/dcache.c:1871
 alloc_path_pseudo fs/file_table.c:364 [inline]
 alloc_file_pseudo+0x64/0x140 fs/file_table.c:380
 __shmem_file_setup+0x136/0x270 mm/shmem.c:5863
 memfd_alloc_file+0x81/0x240 mm/memfd.c:471
 __do_sys_memfd_create mm/memfd.c:522 [inline]
 __se_sys_memfd_create mm/memfd.c:505 [inline]
 __x64_sys_memfd_create+0x205/0x440 mm/memfd.c:505
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11d/0x5a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

The issue happens after mounting an ext4 filesystem image via a loop
device created from a compressed image in the reproducer.

Relevant kernel messages:

EXT4-fs (loop0): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal.
EXT4-fs (loop3): Delayed block allocation failed for inode 18 at
logical offset 768 with max blocks 2 with error 28
EXT4-fs (loop3): This should not happen!! Data will be lost

The WARNING occurs in alloc_slab_obj_exts(), which is related to slab
object extension allocation.

This may indicate a slab metadata inconsistency triggered by the
filesystem state.

Please let me know if additional debugging information would help.

Thanks.
Zw Tang

