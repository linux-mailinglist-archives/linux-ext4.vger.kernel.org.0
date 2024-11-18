Return-Path: <linux-ext4+bounces-5230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4109D0773
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 02:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515621F229ED
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2024 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0D282FE;
	Mon, 18 Nov 2024 01:14:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352BA95E;
	Mon, 18 Nov 2024 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892465; cv=none; b=HuJBHRiIrXYF667gv9Vg0FEr+BaAihXPKTMetjg9swK42fxHkCvnrjGnvc8ZeTlaV+kfowCszOnN56xitHODAd/PqWFlPl3VK+9nfu7uXAPtNFR2kHfKPumn6YaOsPyWC0IMWe8CqXB1as/8OAxRXT3xAaPKMyjVUF0I7fmQqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892465; c=relaxed/simple;
	bh=sdCLNbZ5/SFvjkI5HcJWuFifK0jwdyUtBEEoPfPHdOk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=i08HiJyCIfHBUPNXoh9mzDr47qNTRwzI/oantkPMlL9iSJ7uafdfYtQgNCFodrEo+T1DkZrjOiKEap+mzRX8qkil4nOF94CdLq1c3xZ8MndZP6ckHea+tbLDVFtWOSfI94hMadCkc7jE8D+ueSeQM6JsRGWxHYQnxmCT30YyrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xs8lr4BzLz4f3lW3;
	Mon, 18 Nov 2024 09:14:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DFD741A018D;
	Mon, 18 Nov 2024 09:14:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHY4fplDpns6tgCA--.47389S3;
	Mon, 18 Nov 2024 09:14:19 +0800 (CST)
Subject: Re: md-raid 6.11.8 page fault oops
To: Genes Lists <lists@sapience.com>, song@kernel.org,
 linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca
Cc: linux@leemhuis.info, "yukuai (C)" <yukuai3@huawei.com>,
 yi.zhang@huawei.com, "libaokun (A)" <libaokun1@huawei.com>, tytso@mit.edu,
 linux-ext4@vger.kernel.org
References: <0b579808e848171fc64e04f0629e24735d034d32.camel@sapience.com>
 <34333c67f5490cda041bc0cbe4336b94271d5b49.camel@sapience.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2a620925-1715-5fc6-86bb-783cf3cb6ebf@huaweicloud.com>
Date: Mon, 18 Nov 2024 09:14:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <34333c67f5490cda041bc0cbe4336b94271d5b49.camel@sapience.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHY4fplDpns6tgCA--.47389S3
X-Coremail-Antispam: 1UD129KBjvJXoW3uFWxXF1xXrWDKw17uFyDJrb_yoWkJw1UpF
	1UGr1UGr4rXr1UA3yxAr1UWw4UGa109F4DXr45Gry8A3W8Gw1DJr13XrWYgF98WF1Ygr42
	v3sxJwn5KFykJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

+CC ext4

在 2024/11/18 1:23, Genes Lists 写道:
> On Fri, 2024-11-15 at 07:12 -0500, Genes Lists wrote:
>>
>>
> Another page fault oops this time when 6.11.8 was shutting to boot
> 6.11.9.
> 
> This one is in ext4 -> rbtree and I don't see raid at all this time.
> (Soadding ext4 maintainers)
> 
> The previous oops occurred in clone_endio from dm_mod.
> 
> I note that 9 hours before the oops there was a an ext4 error - in case
> it's relevant.
> 
> This oops occurred in rb_first+0x13 invoked from
> ext4_discard_preallocations+0xc3.
> 
> journal summary below and full log attached.
> 
> gene
> 
> # --- line numbers -----
> 
> rbtree line:
>   (gdb) list *(rb_first+0x13)
>    0xffffffff81de1af3 is in rb_first (lib/rbtree.c:473).
>    468       struct rb_node  *n;
>    469
>    470       n = root->rb_node;
>    471       if (!n)
>    472           return NULL;
>    473       while (n->rb_left)
>    474           n = n->rb_left;
>    475       return n;
>    476   }
>    477   EXPORT_SYMBOL(rb_first);
> 
> ext4 line:
> (gdb) list *(ext4_discard_preallocations+0xc3)
>    0x372f3 is in ext4_discard_preallocations (fs/ext4/mballoc.c:5539).
>    5534              atomic_read(&ei->i_prealloc_active));
>    5535
>    5536  repeat:
>    5537      /* first, collect all pa's in the inode */
>    5538      write_lock(&ei->i_prealloc_lock);
>    5539      for (iter = rb_first(&ei->i_prealloc_node); iter;
>    5540           iter = rb_next(iter)) {
>    5541          pa = rb_entry(iter, struct ext4_prealloc_space,
>    5542                    pa_node.inode_node);
>    5543          BUG_ON(pa->pa_node_lock.inode_lock != &ei-
>> i_prealloc_lock);
> 
> 
> # ----------- journal -------
> 
> # This is  9 hours prior to oops
> [161780.846149]  EXT4-fs (dm-3): error count since last fsck: 2
> [161780.847081]  EXT4-fs (dm-3): initial error at time 1731742618:
> ext4_lookup:1813: inode 126161478
> [161780.847214]  EXT4-fs (dm-3): last error at time 1731742618:
> ext4_lookup:1813: inode 126161478
> 
> 
> [191322.007026]  EXT4-fs (sdg5): unmounting filesystem 3e25ed0e-ff2b-
> 4ad1-8227-6dc838055384.
> [191322.007093]  EXT4-fs (sdg4): unmounting filesystem 1b631410-216a-
> 4909-a02e-0362da57d241.
> [191322.011010]  EXT4-fs (nvme0n1p5): unmounting filesystem f6f66f4e-
> 1ed8-47fd-ac65-b91acd278d89.
> [191322.016010]  EXT4-fs (nvme0n1p2): unmounting filesystem bd94c712-
> f5f3-4f18-b1ed-b77ee42d4e0b.
> [191322.261047]  EXT4-fs (sdg2): unmounting filesystem 8f93166e-b18c-
> 4522-af8c-21fdc12ef3e2.
> [191331.777986]  BUG: unable to handle page fault for address:
> 0000000000200010
> [191331.778187]  #PF: supervisor read access in kernel mode
> [191331.781901]  #PF: error_code(0x0000) - not-present page
> [191331.781956]  PGD 0 P4D 0
> [191331.782037]  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [191331.782075]  CPU: 1 UID: 0 PID: 37604 Comm: umount Not tainted
> 6.11.8-stable-1 #21 1400000003000000474e5500ae13c727d476f9ab
> [191331.782093]  Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./Z370 Extreme4, BIOS P4.20 10/31/2019
> [191331.782105]  RIP: 0010:rb_first+0x13/0x30
> [191331.782120]  Code: 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07 48 85 c0 74 18 0f 1f 40 00 48
> 89 c2 <48> 8b 40 10 48 85 c0 75 f4 48 89 d0 c3 cc cc cc cc 31 d2 eb f4
> 0f
> [191331.782135]  RSP: 0018:ffffa95621d3f8d8 EFLAGS: 00010206
> [191331.782146]  RAX: 0000000000200000 RBX: ffffa95621d3f8f8 RCX:
> 0000000000000000
> [191331.782162]  RDX: 0000000000200000 RSI: 0000000000000000 RDI:
> ffff8f299ec75708
> [191331.782176]  RBP: ffffa95621d3f908 R08: 0000000000000001 R09:
> 000000000066001a
> [191331.782189]  R10: 000000000066001a R11: 0000000000000000 R12:
> ffff8f2585b77800
> [191331.782200]  R13: ffff8f299ec75468 R14: ffff8f299ec75710 R15:
> ffff8f297376c688
> [191331.782211]  FS:  00007f30f4a6db80(0000) GS:ffff8f2d1ec80000(0000)
> knlGS:0000000000000000
> [191331.782222]  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [191331.782234]  CR2: 0000000000200010 CR3: 000000011c868003 CR4:
> 00000000003706f0
> [191331.782252]  DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [191331.782283]  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [191331.782294]  Call Trace:
> [191331.782308]   <TASK>
> [191331.782320]   ? __die_body.cold+0x19/0x27
> [191331.782333]   ? page_fault_oops+0x15a/0x2d0
> [191331.782346]   ? exc_page_fault+0x7e/0x180
> [191331.782362]   ? asm_exc_page_fault+0x26/0x30
> [191331.782374]   ? rb_first+0x13/0x30
> [191331.782385]   ext4_discard_preallocations+0xc3/0x460 [ext4
> 1400000003000000474e5500fcb7142b958415b3]
> [191331.782401]   ext4_clear_inode+0x2a/0xb0 [ext4
> 1400000003000000474e5500fcb7142b958415b3]
> [191331.782414]   ext4_evict_inode+0xa1/0x6b0 [ext4
> 1400000003000000474e5500fcb7142b958415b3]
> [191331.782432]   evict+0x111/0x2c0
> [191331.782460]   ? fsnotify_destroy_marks+0x2a/0x1b0
> [191331.782470]   ? __call_rcu_common+0xc2/0x710
> [191331.782480]   evict_inodes+0x226/0x240
> [191331.782723]   generic_shutdown_super+0x3d/0x170
> [191331.782739]   kill_block_super+0x1a/0x40
> [191331.782753]   ext4_kill_sb+0x22/0x40 [ext4
> 1400000003000000474e5500fcb7142b958415b3]
> [191331.782766]   deactivate_locked_super+0x30/0xb0
> [191331.782776]   cleanup_mnt+0xba/0x150
> [191331.782786]   task_work_run+0x59/0x90
> [191331.782794]   syscall_exit_to_user_mode+0x1f4/0x200
> [191331.782805]   do_syscall_64+0x8e/0x160
> [191331.782815]   ? vfs_statx+0x8d/0x100
> [191331.782830]   ? vfs_fstatat+0x8a/0xb0
> [191331.782848]   ? __do_sys_newfstatat+0x3c/0x80
> [191331.782861]   ? syscall_exit_to_user_mode+0x10/0x200
> [191331.782805]   do_syscall_64+0x8e/0x160
> [191331.782815]   ? vfs_statx+0x8d/0x100
> [191331.782830]   ? vfs_fstatat+0x8a/0xb0
> [191331.782848]   ? __do_sys_newfstatat+0x3c/0x80
> [191331.782861]   ? syscall_exit_to_user_mode+0x10/0x200
> [191331.782871]   ? do_syscall_64+0x8e/0x160
> [191331.782884]   ? generic_permission+0x39/0x220
> [191331.782895]   ? mntput_no_expire+0x4a/0x260
> [191331.782907]   ? do_faccessat+0x1e1/0x2e0
> [191331.782916]   ? syscall_exit_to_user_mode+0x10/0x200
> [191331.782926]   ? do_syscall_64+0x8e/0x160
> [191331.782936]   ? do_user_addr_fault+0x36c/0x620
> [191331.782947]   ? exc_page_fault+0x7e/0x180
> [191331.782956]   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [191331.782969]  RIP: 0033:0x7f30f4bc21cb
> [191331.782981]  Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3
> 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00
> 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 11 cb 0c 00 f7
> d8
> [191331.782995]  RSP: 002b:00007fff6233d1e8 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a6
> [191331.783039]  RAX: 0000000000000000 RBX: 0000561542af84e0 RCX:
> 00007f30f4bc21cb
> [191331.783053]  RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000561542af9180
> [191331.783099]  RBP: 00007fff6233d2c0 R08: 0000561542af6010 R09:
> 0000000000000007
> [191331.783115]  R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000561542af85e8
> [191331.783126]  R13: 0000000000000000 R14: 0000561542af9180 R15:
> 0000561542af9570
> [191331.783143]   </TASK>
> [191331.783158]  Modules linked in: algif_hash af_alg nft_nat
> nft_chain_nat nf_nat nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> nf_tables rpcrdma rdma_cm iw_cm ib_cm wireguard curve25519_x86_64
> libchacha20poly1305 ib_core chacha_x86_64 poly1305_x86_64
> libcurve25519_generic libchacha ip6_udp_tunnel udp_tunnel nct6775
> nct6775_core hwmon_vid snd_hda_codec_hdmi snd_hda_codec_realtek
> snd_hda_codec_generic snd_hda_scodec_component dm_cache_smq dm_cache
> dm_persistent_data dm_bio_prison dm_bufio nls_iso8859_1 vfat fat
> intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common raid456 intel_tcc_cooling
> async_raid6_recov async_memcpy x86_pkg_temp_thermal async_pq
> snd_soc_avs async_xor intel_powerclamp async_tx snd_soc_hda_codec xor
> joydev coretemp snd_hda_ext_core raid6_pq libcrc32c snd_soc_core
> kvm_intel snd_compress i915 ac97_bus snd_pcm_dmaengine snd_hda_intel
> kvm snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core
> snd_hwdep rapl drm_buddy snd_pcm mei_hdcp mei_pxp i2c_algo_bit ee1004
> [191331.783217]   intel_cstate snd_timer ttm i2c_i801
> drm_display_helper snd mei_me i2c_smbus intel_uncore usbhid
> intel_wmi_thunderbolt pcspkr e1000e mxm_wmi i2c_mux soundcore cec mei
> intel_gtt intel_pmc_core intel_vsec md_mod pmt_telemetry pmt_class
> cfg80211 acpi_pad mac_hid rfkill nfsd auth_rpcgss nfs_acl lockd grace
> tcp_bbr loop dm_mod fuse sunrpc nfnetlink ip_tables x_tables ext4
> crc32c_generic crc16 mbcache jbd2 crct10dif_pclmul crc32_pclmul
> crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel
> sha512_ssse3 sha256_ssse3 sha1_ssse3 nvme aesni_intel gf128mul
> crypto_simd cryptd xhci_pci nvme_core xhci_pci_renesas video wmi
> usbip_host usbip_core pkcs8_key_parser sg crypto_user
> [191331.783245]  CR2: 0000000000200010
> [191331.783259]  ---[ end trace 0000000000000000 ]---
> [191331.783277]  RIP: 0010:rb_first+0x13/0x30
> [191331.783289]  Code: 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90
> 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07 48 85 c0 74 18 0f 1f 40 00 48
> 89 c2 <48> 8b 40 10 48 85 c0 75 f4 48 89 d0 c3 cc cc cc cc 31 d2 eb f4
> 0f
> [191331.783299]  RSP: 0018:ffffa95621d3f8d8 EFLAGS: 00010206
> [191331.783311]  RAX: 0000000000200000 RBX: ffffa95621d3f8f8 RCX:
> 0000000000000000
> [191331.783322]  RDX: 0000000000200000 RSI: 0000000000000000 RDI:
> ffff8f299ec75708
> [191331.783334]  RBP: ffffa95621d3f908 R08: 0000000000000001 R09:
> 000000000066001a
> [191331.783344]  R10: 000000000066001a R11: 0000000000000000 R12:
> ffff8f2585b77800
> [191331.783357]  R13: ffff8f299ec75468 R14: ffff8f299ec75710 R15:
> ffff8f297376c688
> [191331.783369]  FS:  00007f30f4a6db80(0000) GS:ffff8f2d1ec80000(0000)
> knlGS:0000000000000000
> [191331.783379]  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [191331.783389]  CR2: 0000000000200010 CR3: 000000011c868003 CR4:
> 00000000003706f0
> [191331.783399]  DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [191331.783407]  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [191331.783417]  note: umount[37604] exited with irqs disabled
> [191331.783430]  note: umount[37604] exited with preempt_count 1
> [191332.973053]  systemd-shutdown[1]: Syncing filesystems and block
> devices.
> [191362.979489]  systemd-shutdown[1]: Syncing filesystems and block
> devices - timed out, issuing SIGKILL to PID 37638.
> [191362.979558]  systemd-shutdown[1]: Sending SIGTERM to remaining
> processes...
> 
> 


