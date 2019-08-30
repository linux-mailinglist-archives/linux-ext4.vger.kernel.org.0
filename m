Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B900FA2D54
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2019 05:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfH3Ddc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Aug 2019 23:33:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727348AbfH3Ddc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Aug 2019 23:33:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CABCFE9D64C338F28E69;
        Fri, 30 Aug 2019 11:33:29 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 30 Aug 2019
 11:33:22 +0800
Subject: Re: [ext4] [confidence: ] 2f7f60cf9f:
 WARNING:at_lib/list_debug.c:#__list_add_valid
To:     kernel test robot <oliver.sang@intel.com>
References: <20190830031108.GZ22468@xsang-OptiPlex-9020>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yang Guo <guoyang2@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, <lkp@01.org>,
        <ltp@lists.linux.it>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <05df5668-d67f-6125-9786-3855626f495b@hisilicon.com>
Date:   Fri, 30 Aug 2019 11:33:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190830031108.GZ22468@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Oliver,

On 2019/8/30 11:11, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 2f7f60cf9fbcd80200edee8c29b9b35681c63c3e ("[PATCH] ext4: change the type of ext4 cache stats to percpu_counter to improve performance")

Thanks for the report.

This patch has been dropped and the updated patch has been sent to community.
https://lkml.org/lkml/2019/8/28/286

Thanks,
Shaokun

> url: https://github.com/0day-ci/linux/commits/Shaokun-Zhang/ext4-change-the-type-of-ext4-cache-stats-to-percpu_counter-to-improve-performance/20190825-123505
> 
> 
> in testcase: ltp
> with following parameters:
> 
> 	test: quickhit
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-----------------------------------------------------+------------+------------+
> |                                                     | e67095fd2f | 2f7f60cf9f |
> +-----------------------------------------------------+------------+------------+
> | boot_successes                                      | 25         | 12         |
> | boot_failures                                       | 0          | 17         |
> | WARNING:at_lib/list_debug.c:#__list_add_valid       | 0          | 17         |
> | RIP:__list_add_valid                                | 0          | 17         |
> | WARNING:at_lib/list_debug.c:#__list_del_entry_valid | 0          | 3          |
> | RIP:__list_del_entry_valid                          | 0          | 3          |
> +-----------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   62.458944] WARNING: CPU: 1 PID: 2533 at lib/list_debug.c:25 __list_add_valid+0x36/0x70
> [   62.460445] Modules linked in: fuse vfat fat btrfs xor zstd_decompress zstd_compress raid6_pq xfs libcrc32c ext4 mbcache jbd2 loop intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sr_mod bochs_drm cdrom drm_vram_helper sg ttm ppdev drm_kms_helper ata_generic pata_acpi syscopyarea sysfillrect sysimgblt snd_pcm fb_sys_fops drm snd_timer snd aesni_intel crypto_simd cryptd glue_helper soundcore pcspkr joydev serio_raw ata_piix libata i2c_piix4 floppy parport_pc parport ip_tables
> [   62.468134] CPU: 1 PID: 2533 Comm: fsync01 Not tainted 5.3.0-rc5-00283-g2f7f60cf9fbcd #1
> [   62.469707] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   62.471293] RIP: 0010:__list_add_valid+0x36/0x70
> [   62.472332] Code: 48 8b 10 4c 39 c2 75 27 48 39 f8 74 39 48 39 fa 74 34 b8 01 00 00 00 c3 48 89 d1 48 c7 c7 28 ce d2 82 48 89 c2 e8 ba 47 c2 ff <0f> 0b 31 c0 c3 48 89 c1 4c 89 c6 48 c7 c7 a0 ce d2 82 e8 a3 47 c2
> [   62.475779] RSP: 0018:ffffb815c0497cc0 EFLAGS: 00010082
> [   62.477028] RAX: 0000000000000000 RBX: ffff9ab02e61c418 RCX: 0000000000000006
> [   62.478540] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff9ab0bfd17770
> [   62.480096] RBP: ffff9ab02e61c428 R08: 0000000000000510 R09: 0000000000aaaaaa
> [   62.481707] R10: 0000000000000007 R11: ffff9ab097f6b8b0 R12: ffff9ab02e61c450
> [   62.483231] R13: ffffffff8314ce80 R14: 0000000000000202 R15: 0000000000000000
> [   62.484861] FS:  00007f8b236e0500(0000) GS:ffff9ab0bfd00000(0000) knlGS:0000000000000000
> [   62.486641] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   62.488103] CR2: 000055b3435d0a60 CR3: 000000019b8d2000 CR4: 00000000000406e0
> [   62.489798] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   62.491343] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   62.492925] Call Trace:
> [   62.494524]  __percpu_counter_init+0x64/0xa0
> [   62.495780]  ext4_es_register_shrinker+0x53/0x130 [ext4]
> [   62.497235]  ext4_fill_super+0x1cd4/0x3ad0 [ext4]
> [   62.498521]  ? ext4_calculate_overhead+0x4a0/0x4a0 [ext4]
> [   62.499946]  mount_bdev+0x173/0x1b0
> [   62.501120]  legacy_get_tree+0x27/0x40
> [   62.502315]  vfs_get_tree+0x25/0xf0
> [   62.503421]  do_mount+0x691/0x9c0
> [   62.504516]  ? memdup_user+0x4b/0x70
> [   62.505793]  ksys_mount+0x80/0xd0
> [   62.506858]  __x64_sys_mount+0x21/0x30
> [   62.507979]  do_syscall_64+0x5b/0x1f0
> [   62.509194]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   62.510491] RIP: 0033:0x7f8b2320f48a
> [   62.511589] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d de f9 2a 00 f7 d8 64 89 01 48
> [   62.515429] RSP: 002b:00007ffdcb5920e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> [   62.517274] RAX: ffffffffffffffda RBX: 00005564e2fd94d5 RCX: 00007f8b2320f48a
> [   62.518865] RDX: 00005564e2fd94d5 RSI: 00005564e2fd6b08 RDI: 00007ffdcb593edf
> [   62.520461] RBP: 00007ffdcb593edf R08: 0000000000000000 R09: 00005564e2fd94d5
> [   62.522183] R10: 0000000000000000 R11: 0000000000000206 R12: 00005564e2fd6b08
> [   62.523770] R13: 00005564e2fd6b67 R14: 00000000000002f5 R15: 0000000000000000
> [   62.525457] ---[ end trace 6c35045d811b284c ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.3.0-rc5-00283-g2f7f60cf9fbcd .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
> 	cd <mod-install-dir>
> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Oliver Sang
> 

