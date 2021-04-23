Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF46369626
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Apr 2021 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhDWP2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 23 Apr 2021 11:28:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhDWP2U (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 23 Apr 2021 11:28:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFC3FB14E;
        Fri, 23 Apr 2021 15:27:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 92FF71E37A2; Fri, 23 Apr 2021 17:27:42 +0200 (CEST)
Date:   Fri, 23 Apr 2021 17:27:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Aloni <alonid@gmail.com>
Cc:     linux-ext4@vger.kernel.org, jforbes@fedoraproject.org,
        Jan Kara <jack@suse.cz>
Subject: Re: BUG at fs/ext4/inode.c:2200 (mpage_process_page_bufs)
Message-ID: <20210423152742.GD8755@quack2.suse.cz>
References: <20210423064255.r32fgqipb52k5tpg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210423064255.r32fgqipb52k5tpg@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Fri 23-04-21 09:42:55, Dan Aloni wrote:
> The following [2] has occurred just upon boot to Fedora's 5.11.15 kernel [1].
> No pertinent patches around MM or FS subsystems as far as I see.

Thanks for report. This is:

                BUG_ON(buffer_locked(bh));

in mpage_process_page_bufs(). Indeed weird since we have the page locked so
nobody should be messing with its buffers. Is this reproducible? Also can
you please attach contents of your /proc/mounts and also output of
'dumpe2fs /dev/dm-1'? Thanks!

								Honza

> 
> [1] https://src.fedoraproject.org/rpms/kernel/tree/a6ae349436c5bc66640eb6aeed211c5068dc71f4
> 
> [2]
> [   29.120268] ------------[ cut here ]------------
> [   29.120294] kernel BUG at fs/ext4/inode.c:2200!
> [   29.120306] invalid opcode: 0000 [#1] SMP NOPTI
> [   29.120314] CPU: 19 PID: 382 Comm: kworker/u256:1 Tainted: G        W         5.11.15-100.fc32.x86_64 #1
> [   29.120321] Hardware name: System manufacturer System Product Name/PRIME TRX40-PRO, BIOS 1201 08/04/2020
> [   29.120328] Workqueue: writeback wb_workfn (flush-253:1)
> [   29.120338] RIP: 0010:mpage_process_page_bufs+0xb9/0x120
> [   29.120346] Code: 00 00 89 45 38 48 8b 52 08 83 c3 01 48 39 f2 75 9f 8b 45 34 85 c0 74 5f b8 01 00 00 00 44 39 e3 72 ae 80 4d 60 02 31 c0 eb a6 <0f> 0b 3d ff 07 00 00 77 9b 8b 4d 30 01 c1 39 cb 75 92 48 8b 0a 8b
> [   29.120355] RSP: 0018:ffffb379c9a23970 EFLAGS: 00010202
> [   29.120361] RAX: ddb800010099b804 RBX: 0000000000013543 RCX: 000000000000000c
> [   29.120367] RDX: ffff902be16d1e38 RSI: ffff902be16d1e38 RDI: 000000005e2a3e3f
> [   29.120373] RBP: ffffb379c9a23b00 R08: 0000000000000000 R09: 0000000000000000
> [   29.120378] R10: 0000000000000002 R11: 0000000000000238 R12: 000000000005e2a4
> [   29.120384] R13: ffff902a7ff1c818 R14: ffffb379c9a23b00 R15: ffffed63483b7100
> [   29.120390] FS:  0000000000000000(0000) GS:ffff90683d4c0000(0000) knlGS:0000000000000000
> [   29.120396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.120402] CR2: 000055fa49f54b50 CR3: 0000000de0a10000 CR4: 0000000000350ee0
> [   29.120408] Call Trace:
> [   29.120414]  mpage_prepare_extent_to_map+0x1b1/0x260
> [   29.120421]  ext4_writepages+0x314/0xfa0
> [   29.120428]  do_writepages+0x28/0xa0
> [   29.120434]  __writeback_single_inode+0x39/0x2a0
> [   29.120440]  writeback_sb_inodes+0x1d8/0x440
> [   29.120447]  wb_writeback+0xab/0x270
> [   29.120453]  wb_workfn+0xc5/0x4b0
> [   29.120459]  ? __switch_to+0x114/0x450
> [   29.120466]  process_one_work+0x1ec/0x380
> [   29.120472]  worker_thread+0x53/0x3e0
> [   29.120478]  ? process_one_work+0x380/0x380
> [   29.120483]  kthread+0x11b/0x140
> [   29.120489]  ? __kthread_bind_mask+0x60/0x60
> [   29.120496]  ret_from_fork+0x1f/0x30
> [   29.120503] Modules linked in: overlay xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nouveau nf_nat_tftp nf_conntrack_tftp drm_ttm_helper ttm drm_kms_helper cec tun netconsole nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle bridge stp llc iptable_raw iptable_security ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ppdev parport_pc parport vmw_vsock_vmci_transport vsock vmw_vmci cmac bnep vfat fat rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ucsi_ccg typec_ucsi ib_cm intel_rapl_msr typec snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg soundwire_intel
> [   29.120542]  intel_rapl_common soundwire_generic_allocation snd_soc_core snd_compress edac_mce_amd snd_pcm_dmaengine amd_energy uvcvideo soundwire_cadence kvm_amd videobuf2_vmalloc snd_hda_codec btusb btrtl videobuf2_memops kvm snd_usb_audio snd_hda_core btbcm videobuf2_v4l2 snd_usbmidi_lib btintel mlx5_ib ac97_bus irqbypass videobuf2_common snd_hwdep eeepc_wmi snd_seq bluetooth snd_rawmidi asus_wmi videodev ib_uverbs rapl snd_seq_device sparse_keymap video pcspkr wmi_bmof joydev ib_core ecdh_generic snd_pcm mc rfkill ecc snd_timer sp5100_tco snd soundcore i2c_nvidia_gpu i2c_piix4 k10temp acpi_cpufreq binfmt_misc nfsd auth_rpcgss nfs_acl lockd grace drm sunrpc nfs_ssc ip_tables hid_logitech_hidpp hid_logitech_dj igb dca mlx5_core i2c_algo_bit crct10dif_pclmul crc32_pclmul crc32c_intel mlxfw ghash_clmulni_intel pci_hyperv_intf ccp mxm_wmi wmi pinctrl_amd fuse
> [   29.120633] ---[ end trace de9b9adeaba2eda5 ]---
> [   29.120638] RIP: 0010:mpage_process_page_bufs+0xb9/0x120
> [   29.120644] Code: 00 00 89 45 38 48 8b 52 08 83 c3 01 48 39 f2 75 9f 8b 45 34 85 c0 74 5f b8 01 00 00 00 44 39 e3 72 ae 80 4d 60 02 31 c0 eb a6 <0f> 0b 3d ff 07 00 00 77 9b 8b 4d 30 01 c1 39 cb 75 92 48 8b 0a 8b
> [   29.120653] RSP: 0018:ffffb379c9a23970 EFLAGS: 00010202
> [   29.120658] RAX: ddb800010099b804 RBX: 0000000000013543 RCX: 000000000000000c
> [   29.120664] RDX: ffff902be16d1e38 RSI: ffff902be16d1e38 RDI: 000000005e2a3e3f
> [   29.120669] RBP: ffffb379c9a23b00 R08: 0000000000000000 R09: 0000000000000000
> [   29.120674] R10: 0000000000000002 R11: 0000000000000238 R12: 000000000005e2a4
> [   29.120679] R13: ffff902a7ff1c818 R14: ffffb379c9a23b00 R15: ffffed63483b7100
> [   29.120685] FS:  0000000000000000(0000) GS:ffff90683d4c0000(0000) knlGS:0000000000000000
> [   29.120690] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.120701] CR2: 000055fa49f54b50 CR3: 0000000de0a10000 CR4: 0000000000350ee0
> [   29.120708] ------------[ cut here ]------------
> [   29.120713] WARNING: CPU: 19 PID: 382 at kernel/exit.c:739 do_exit+0x37/0xac0
> [   29.120721] Modules linked in: overlay xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nouveau nf_nat_tftp nf_conntrack_tftp drm_ttm_helper ttm drm_kms_helper cec tun netconsole nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle bridge stp llc iptable_raw iptable_security ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ppdev parport_pc parport vmw_vsock_vmci_transport vsock vmw_vmci cmac bnep vfat fat rpcrdma rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ucsi_ccg typec_ucsi ib_cm intel_rapl_msr typec snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg soundwire_intel
> [   29.120744]  intel_rapl_common soundwire_generic_allocation snd_soc_core snd_compress edac_mce_amd snd_pcm_dmaengine amd_energy uvcvideo soundwire_cadence kvm_amd videobuf2_vmalloc snd_hda_codec btusb btrtl videobuf2_memops kvm snd_usb_audio snd_hda_core btbcm videobuf2_v4l2 snd_usbmidi_lib btintel mlx5_ib ac97_bus irqbypass videobuf2_common snd_hwdep eeepc_wmi snd_seq bluetooth snd_rawmidi asus_wmi videodev ib_uverbs rapl snd_seq_device sparse_keymap video pcspkr wmi_bmof joydev ib_core ecdh_generic snd_pcm mc rfkill ecc snd_timer sp5100_tco snd soundcore i2c_nvidia_gpu i2c_piix4 k10temp acpi_cpufreq binfmt_misc nfsd auth_rpcgss nfs_acl lockd grace drm sunrpc nfs_ssc ip_tables hid_logitech_hidpp hid_logitech_dj igb dca mlx5_core i2c_algo_bit crct10dif_pclmul crc32_pclmul crc32c_intel mlxfw ghash_clmulni_intel pci_hyperv_intf ccp mxm_wmi wmi pinctrl_amd fuse
> [   29.122420] CPU: 19 PID: 382 Comm: kworker/u256:1 Tainted: G      D W         5.11.15-100.fc32.x86_64 #1
> [   29.123239] Hardware name: System manufacturer System Product Name/PRIME TRX40-PRO, BIOS 1201 08/04/2020
> [   29.124071] Workqueue: writeback wb_workfn (flush-253:1)
> [   29.124903] RIP: 0010:do_exit+0x37/0xac0
> [   29.125722] Code: 55 48 89 fd 53 65 48 8b 1c 25 c0 7b 01 00 48 83 ec 38 48 8b 83 70 0c 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 72 04 00 00 <0f> 0b 65 8b 0d d0 85 f3 68 89 c8 25 00 ff ff 00 89 44 24 0c 0f 85
> [   29.126593] RSP: 0018:ffffb379c9a23ee8 EFLAGS: 00010212
> [   29.127518] RAX: ffffb379c9a23d80 RBX: ffff902a042a2780 RCX: ffff90683d4d8ac8
> [   29.128435] RDX: ffff902a0e6c9048 RSI: 0000000000000027 RDI: 000000000000000b
> [   29.129354] RBP: 000000000000000b R08: 0000000000000000 R09: ffffb379c9a235b8
> [   29.130272] R10: ffffb379c9a235b0 R11: ffff90683cffffe8 R12: 000000000000000b
> [   29.131193] R13: 0000000000000000 R14: ffff902a042a2780 R15: 0000000000000006
> [   29.132117] FS:  0000000000000000(0000) GS:ffff90683d4c0000(0000) knlGS:0000000000000000
> [   29.133031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   29.133960] CR2: 000055fa49f54b50 CR3: 0000000de0a10000 CR4: 0000000000350ee0
> [   29.134891] Call Trace:
> [   29.135820]  ? kthread+0x11b/0x140
> [   29.136753]  rewind_stack_do_exit+0x17/0x20
> [   29.137681] RIP: 0000:0x0
> [   29.138616] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
> [   29.139550] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
> [   29.140478] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [   29.141407] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [   29.142334] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [   29.143259] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   29.144177] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   29.145097] ---[ end trace de9b9adeaba2eda6 ]---
> 
> -- 
> Dan Aloni
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
