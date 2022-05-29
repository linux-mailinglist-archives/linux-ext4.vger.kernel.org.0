Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDC5372D8
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 00:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiE2WtY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 May 2022 18:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiE2WtV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 May 2022 18:49:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12403666BE
        for <linux-ext4@vger.kernel.org>; Sun, 29 May 2022 15:49:17 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so6723068otr.3
        for <linux-ext4@vger.kernel.org>; Sun, 29 May 2022 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjKL2a/8NVc92/OwPh9gRhwNiBiBA6mTlOhIEka6HlQ=;
        b=oj1uS+YauwZK49fRm8PXL4DIch4K6uQzkcjS21/63Mjk2T0ANfBOaXC8B6R2SHRAY8
         1RBTOBhZK534NVFmin6CXieXWaDhiWmOa/0OtTL27rx6Wfmc3afrJZhSzKImkpWkIck9
         sU+UCd+HAv4HxhbT8LJMLI0v5sJXobWroHpqZTI2I/QwPyYJzOXQLzFPdbnSIL3JH+6Z
         Ff/nRKMuqHsO10twwaWinXQRcNHk2PdettyU/c9JucHOTKmXzfYclCuQwkN/mj+37HPp
         Uai19f7Gr28qO781gYAfDOWqwTBipN2hGyBHHykynL6gs29SxLe5rnceJFIUuHCfd9nj
         VOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjKL2a/8NVc92/OwPh9gRhwNiBiBA6mTlOhIEka6HlQ=;
        b=1C8RNp+3CEyLn1J0JnLahka6Hk5uDkdcPgidgAcQs1De7dOrSNJPSNuW2UH0LRFvWd
         d9by97FOizERx5NXZhpoaPgTRZa8AbqnaKaWzIRXrv5Tjy5+lxvDX9z7Fg2eLZ8zO5M+
         d3zIc1mjIycEYFDgnbOgfED/5whrKLF54828Z9KlnUaI8QuYOfGViOKANGCntlwkLzFL
         CLROuRA79+999cOZqhm6eaw2Tv62FVde9xYkitI0uLEebOM9pEE+kFfE07MblSFEoo2n
         iiMriYV9lbK0yR1pB+0bJcTG/3pkVLM3OfANSyHumqgn/oRYaYxYW/9EIMo0gC4Fh/Iv
         HS2A==
X-Gm-Message-State: AOAM530BdaowkzNNOzdDrH8W/ct7ToasOCAsSrPIBh4D6RelHs7N1CmX
        DLmqmgQqr0s9EJkEOkrgPJMYR4bjnkSJo/Qp6oJlhCZT3h4=
X-Google-Smtp-Source: ABdhPJwtIOVSTE4KR7L8UiTq7DqeXU9hTJHvxAnDMEn2yhNeJiY56TvDZwQpndh6bVwnlbtbjIn0UEBoXEPn0r2fUY4=
X-Received: by 2002:a9d:19e5:0:b0:606:d75:9239 with SMTP id
 k92-20020a9d19e5000000b006060d759239mr20813084otk.120.1653864555856; Sun, 29
 May 2022 15:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
 <YpLLTkje/QUYPP9z@mit.edu> <YpNk4bQlRKmgDw8E@mit.edu>
In-Reply-To: <YpNk4bQlRKmgDw8E@mit.edu>
From:   "Stephen E. Baker" <baker.stephen.e@gmail.com>
Date:   Sun, 29 May 2022 18:49:01 -0400
Message-ID: <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
Subject: Re: simplify ext4_sb_read_encoding regression
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, May 29, 2022 at 8:19 AM Theodore Ts'o <tytso@mit.edu> wrote:

I had misidentified the commit, but after being more careful with my bisect and
kernel config I ended up in the same patch set. The actual
first bad commit is 2b3d047870120bcd46d7cc257d19ff49328fd585
"unicode: Add utf8-data module"

For the below output I'm running the prior patch:
6ca99ce756c27852d1ea1e555045de1c920f30ed "unicode: cache the
normalization tables in struct unicode_map."

As explained previously I cannot see the early boot output. I understand that I
would have to attach a serial console to the device, but that's beyond
my current
capabilities. If there is anything else I can do to help (test
configuration options,
patches etc.) let me know.

dumpe2fs -h /dev/sda2
dumpe2fs 1.46.5 (30-Dec-2021)
Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          8b5e21f1-3d26-4340-8326-d5a3e54
f89fc
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_ino
de dir_index filetype needs_recovery extent 64bit flex_bg
casefold sparse_super large_file huge_file dir_nlink ext
ra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              30523392
Block count:              122087425
Reserved block count:     6104371
Overhead clusters:        2196820
Free blocks:              108429924
Free inodes:              29690633
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      1024
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Flex block group size:    16
Filesystem created:       Sun Apr 24 18:30:23 2022
Last mount time:          Sun May 29 16:27:16 2022
Last write time:          Sun May 29 16:27:16 2022
Mount count:              148
Maximum mount count:      -1
Last checked:             Sun Apr 24 18:30:23 2022
Check interval:           0 (<none>)
Lifetime writes:          100 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      4973c679-1148-4fa4-b450-2bd335c
ee42d
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0xef8454d0
Character encoding:       utf8-12.1
Journal features:         journal_incompat_revoke journal
_64bit journal_checksum_v3
Total journal size:       1024M
Total journal blocks:     262144
Max transaction length:   262144
Fast commit length:       0
Journal sequence:         0x00007b97
Journal start:            1
Journal checksum type:    crc32c
Journal checksum:         0x7fdadd2a

dmesg:
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.15.0-rc4-ARCH (family@food)
(aarch64-linux-gnu-gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38) #39
SMP Sun May 29 15:09:20 EDT 2022
[    0.000000] Machine model: Google Kevin
[    0.000000] efi: UEFI not found.
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000100000-0x00000000f7dfffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000f7dfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000100000-0x00000000f7dfffff]
[    0.000000] cma: Reserved 64 MiB at 0x00000000ef400000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 19 pages/cpu s37592 r8192 d32040 u77824
[    0.000000] pcpu-alloc: s37592 r8192 d32040 u77824 alloc=19*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 999180
[    0.000000] Kernel command line: cros_secure console=tty0
console=ttyS2,115200n8 earlyprintk=ttyS2,115200n8
console=ttyMSM0,115200n8 init=/sbin/init
root=PARTUUID=5078b3ce-3806-0c46-80b6-a1ea7ca166aa/PARTNROFF=1
rootwait rw noinitrd
[    0.000000] Unknown command line parameters: earlyprintk=ttyS2,115200n8
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 3894888K/4060160K available (11008K kernel
code, 1984K rwdata, 4732K rodata, 2624K init, 572K bss, 99736K
reserved, 65536K cma-reserved)
[    0.000000] random: get_random_u64 called from
cache_random_seq_create+0x54/0x150 with crng_init=0
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=6.
[    0.000000]     Trampoline variant of Tasks RCU enabled.
[    0.000000]     Rude variant of Tasks RCU enabled.
[    0.000000]     Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fef00000
[    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
[    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices @180000
(flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x0000000000140000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table
@0x0000000000150000
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] {
/cpus/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] {
/cpus/cpu@100[4] /cpus/cpu@101[5] }
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps
every 4398046511097ns
[    0.000871] Console: colour dummy device 80x25
[    0.001297] printk: console [tty0] enabled
[    0.001346] Calibrating delay loop (skipped), value calculated
using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.001368] pid_max: default: 32768 minimum: 301
[    0.001469] LSM: Security Framework initializing
[    0.001492] Yama: becoming mindful.
[    0.001600] Mount-cache hash table entries: 8192 (order: 4, 65536
bytes, linear)
[    0.001640] Mountpoint-cache hash table entries: 8192 (order: 4,
65536 bytes, linear)
[    0.003611] rcu: Hierarchical SRCU implementation.
[    0.004650] Platform MSI: interrupt-controller@fee20000 domain created
[    0.005074] PCI/MSI:
/interrupt-controller@fee00000/interrupt-controller@fee20000 domain
created
[    0.005509] EFI services will not be available.
[    0.006072] smp: Bringing up secondary CPUs ...
[    0.006615] Detected VIPT I-cache on CPU1
[    0.006652] GICv3: CPU1: found redistributor 1 region 0:0x00000000fef20000
[    0.006669] GICv3: CPU1: using allocated LPI pending table
@0x0000000000160000
[    0.006729] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.007285] Detected VIPT I-cache on CPU2
[    0.007310] GICv3: CPU2: found redistributor 2 region 0:0x00000000fef40000
[    0.007321] GICv3: CPU2: using allocated LPI pending table
@0x0000000000170000
[    0.007351] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.007841] Detected VIPT I-cache on CPU3
[    0.007866] GICv3: CPU3: found redistributor 3 region 0:0x00000000fef60000
[    0.007878] GICv3: CPU3: using allocated LPI pending table
@0x0000000001c00000
[    0.007905] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.008444] CPU features: detected: Spectre-v2
[    0.008462] CPU features: detected: Spectre-v4
[    0.008476] CPU features: detected: ARM errata 1165522, 1319367, or 1530923
[    0.008482] Detected PIPT I-cache on CPU4
[    0.008526] GICv3: CPU4: found redistributor 100 region 0:0x00000000fef80000
[    0.008548] GICv3: CPU4: using allocated LPI pending table
@0x0000000001c10000
[    0.008602] CPU4: Booted secondary processor 0x0000000100 [0x410fd082]
[    0.009213] Detected PIPT I-cache on CPU5
[    0.009256] GICv3: CPU5: found redistributor 101 region 0:0x00000000fefa0000
[    0.009275] GICv3: CPU5: using allocated LPI pending table
@0x0000000001c20000
[    0.009318] CPU5: Booted secondary processor 0x0000000101 [0x410fd082]
[    0.009466] smp: Brought up 1 node, 6 CPUs
[    0.009706] SMP: Total of 6 processors activated.
[    0.009717] CPU features: detected: 32-bit EL0 Support
[    0.009728] CPU features: detected: CRC32 instructions
[    0.011516] CPU: All CPU(s) started at EL2
[    0.011565] alternatives: patching kernel code
[    0.013501] devtmpfs: initialized
[    0.027951] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.028004] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.030550] pinctrl core: initialized pinctrl subsystem
[    0.031176] DMI not present or invalid.
[    0.031660] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.033856] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.034221] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for
atomic allocations
[    0.034532] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for
atomic allocations
[    0.034636] audit: initializing netlink subsys (disabled)
[    0.034819] audit: type=2000 audit(0.030:1): state=initialized
audit_enabled=0 res=1
[    0.035984] thermal_sys: Registered thermal governor 'fair_share'
[    0.035990] thermal_sys: Registered thermal governor 'bang_bang'
[    0.036003] thermal_sys: Registered thermal governor 'step_wise'
[    0.036015] thermal_sys: Registered thermal governor 'user_space'
[    0.036026] thermal_sys: Registered thermal governor 'power_allocator'
[    0.036648] cpuidle: using governor ladder
[    0.036683] cpuidle: using governor menu
[    0.036971] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.037156] ASID allocator initialised with 65536 entries
[    0.037305] Serial: AMBA PL011 UART driver
[    0.053818] platform ff770000.syscon:phy@f780: Fixing up cyclic
dependency with fe330000.mmc
[    0.055854] platform ff8f0000.vop: Fixing up cyclic dependency with
fec00000.dp
[    0.056556] platform ff900000.vop: Fixing up cyclic dependency with
fec00000.dp
[    0.057813] platform ff970000.edp: Fixing up cyclic dependency with
ff8f0000.vop
[    0.057878] platform ff970000.edp: Fixing up cyclic dependency with
ff900000.vop
[    0.063722] rockchip-gpio ff720000.gpio0: probed /pinctrl/gpio0@ff720000
[    0.064361] rockchip-gpio ff730000.gpio1: probed /pinctrl/gpio1@ff730000
[    0.064887] rockchip-gpio ff780000.gpio2: probed /pinctrl/gpio2@ff780000
[    0.065383] rockchip-gpio ff788000.gpio3: probed /pinctrl/gpio3@ff788000
[    0.065848] rockchip-gpio ff790000.gpio4: probed /pinctrl/gpio4@ff790000
[    0.074708] platform edp-panel: Fixing up cyclic dependency with ff970000.edp
[    0.083173] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.083210] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.083223] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.083237] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    1.096209] cryptd: max_cpu_qlen set to 1000
[    1.117216] ACPI: Interpreter disabled.
[    1.118012] pp1200_lpddr: supplied by ppvar_sys
[    1.118410] pp1800: supplied by ppvar_sys
[    1.118806] pp3300: supplied by ppvar_sys
[    1.119253] pp5000: supplied by ppvar_sys
[    1.119685] pp900_ap: supplied by ppvar_sys
[    1.120217] pp3000: supplied by ppvar_sys
[    1.120692] ppvar_logic: supplied by ppvar_sys
[    1.121172] pp1800_audio: supplied by pp1800
[    1.121809] pp1800_pcie: supplied by pp1800
[    1.122134] pp1500_ap_io: supplied by pp1800
[    1.122820] pp3300_disp: supplied by pp3300
[    1.123069] reg-fixed-voltage pp3300-wifi-bt: nonexclusive access
to GPIO for pp3300-wifi-bt
[    1.123264] pp3300_wifi_bt: supplied by pp3300
[    1.123747] wlan_pd_n: supplied by pp1800_pcie
[    1.124251] p3.3v_dig: supplied by pp3300
[    1.125495] iommu: Default domain type: Translated
[    1.125523] iommu: DMA domain TLB invalidation policy: strict mode
[    1.128881] vgaarb: loaded
[    1.129937] SCSI subsystem initialized
[    1.130124] libata version 3.00 loaded.
[    1.130446] usbcore: registered new interface driver usbfs
[    1.130517] usbcore: registered new interface driver hub
[    1.130578] usbcore: registered new device driver usb
[    1.131352] pps_core: LinuxPPS API ver. 1 registered
[    1.131373] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    1.131419] PTP clock support registered
[    1.131655] EDAC MC: Ver: 3.0.0
[    1.133253] Advanced Linux Sound Architecture Driver Initialized.
[    1.134023] NetLabel: Initializing
[    1.134043] NetLabel:  domain hash size = 128
[    1.134058] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.134144] NetLabel:  unlabeled traffic allowed by default
[    1.134653] clocksource: Switched to clocksource arch_sys_counter
[    1.134944] VFS: Disk quotas dquot_6.6.0
[    1.135033] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.135710] pnp: PnP ACPI: disabled
[    1.146084] NET: Registered PF_INET protocol family
[    1.146419] IP idents hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    1.149883] tcp_listen_portaddr_hash hash table entries: 2048
(order: 3, 32768 bytes, linear)
[    1.150017] TCP established hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    1.150225] TCP bind hash table entries: 32768 (order: 7, 524288
bytes, linear)
[    1.150519] TCP: Hash tables configured (established 32768 bind 32768)
[    1.150847] MPTCP token hash table entries: 4096 (order: 4, 98304
bytes, linear)
[    1.150979] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.151046] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.151323] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.151380] PCI: CLS 0 bytes, default 64
[    1.152653] hw perfevents: enabled with armv8_cortex_a53 PMU
driver, 7 counters available
[    1.153137] hw perfevents: enabled with armv8_cortex_a72 PMU
driver, 7 counters available
[    1.188866] Initialise system trusted keyrings
[    1.189047] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    1.197330] zbud: loaded
[    1.266549] NET: Registered PF_ALG protocol family
[    1.266596] Key type asymmetric registered
[    1.266607] Asymmetric key parser 'x509' registered
[    1.266618] Asymmetric key parser 'pkcs8' registered
[    1.266735] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 243)
[    1.266856] io scheduler mq-deadline registered
[    1.266869] io scheduler kyber registered
[    1.267064] io scheduler bfq registered
[    1.275439] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
[    1.275500] rockchip-pcie f8000000.pcie:      MEM
0x00fa000000..0x00fbdfffff -> 0x00fa000000
[    1.275524] rockchip-pcie f8000000.pcie:       IO
0x00fbe00000..0x00fbefffff -> 0x00fbe00000
[    1.275997] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
[    1.368495] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
[    1.368524] pci_bus 0000:00: root bus resource [bus 00-1f]
[    1.368540] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
[    1.368557] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
(bus address [0xfbe00000-0xfbefffff])
[    1.368612] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
[    1.368722] pci 0000:00:00.0: supports D1
[    1.368735] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    1.372609] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[    1.372851] pci 0000:01:00.0: [1b4b:2b42] type 00 class 0x020000
[    1.372944] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x000fffff
64bit pref]
[    1.373006] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff
64bit pref]
[    1.373117] pci 0000:01:00.0: Upstream bridge's Max Payload Size
set to 128 (was 256, max 256)
[    1.373145] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    1.373488] pci 0000:01:00.0: supports D1 D2
[    1.373501] pci 0000:01:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.373760] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000
Gb/s with 5.0 GT/s PCIe x1 link)
[    1.397995] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
[    1.398053] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa1fffff]
[    1.398076] pci 0000:01:00.0: BAR 0: assigned [mem
0xfa000000-0xfa0fffff 64bit pref]
[    1.398130] pci 0000:01:00.0: BAR 2: assigned [mem
0xfa100000-0xfa1fffff 64bit pref]
[    1.398183] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.398200] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa1fffff]
[    1.398407] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
[    1.398737] pcieport 0000:00:00.0: PME: Signaling with IRQ 79
[    1.399083] pcieport 0000:00:00.0: AER: enabled with IRQ 79
[    1.400312] IPMI message handler: version 39.2
[    1.402522] dma-pl330 ff6d0000.dma-controller: Loaded driver for
PL330 DMAC-241330
[    1.402555] dma-pl330 ff6d0000.dma-controller:     DBUFF-32x8bytes
Num_Chans-6 Num_Peri-12 Num_Events-12
[    1.403716] dma-pl330 ff6e0000.dma-controller: Loaded driver for
PL330 DMAC-241330
[    1.403737] dma-pl330 ff6e0000.dma-controller:     DBUFF-128x8bytes
Num_Chans-8 Num_Peri-20 Num_Events-16
[    1.406935] ppvar_bigcpu_pwm: supplied by ppvar_sys
[    1.407245] ppvar_litcpu_pwm: supplied by ppvar_sys
[    1.407494] ppvar_gpu_pwm: supplied by ppvar_sys
[    1.407772] ppvar_centerlogic_pwm: supplied by ppvar_sys
[    1.408572] ppvar_bigcpu: failed to get the current voltage: -EPROBE_DEFER
[    1.408600] ppvar_bigcpu: supplied by ppvar_bigcpu_pwm
[    1.409072] ppvar_litcpu: failed to get the current voltage: -EPROBE_DEFER
[    1.409094] ppvar_litcpu: supplied by ppvar_litcpu_pwm
[    1.409510] ppvar_gpu: failed to get the current voltage: -EPROBE_DEFER
[    1.409531] ppvar_gpu: supplied by ppvar_gpu_pwm
[    1.409967] ppvar_centerlogic: failed to get the current voltage:
-EPROBE_DEFER
[    1.409989] ppvar_centerlogic: supplied by ppvar_centerlogic_pwm
[    1.410669] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.412697] printk: console [ttyS2] disabled
[    1.412777] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 43,
base_baud = 1500000) is a 16550A
[    3.061712] printk: console [ttyS2] enabled
[    3.069200] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    3.079766] spi-nor spi0.0: gd25lq64c (8192 Kbytes)
[    3.090318] libphy: Fixed MDIO Bus: probed
[    3.097254] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.104609] ehci-pci: EHCI PCI platform driver
[    3.109669] ehci-platform: EHCI generic platform driver
[    3.117900] ehci-platform fe380000.usb: EHCI Host Controller
[    3.124384] ehci-platform fe380000.usb: new USB bus registered,
assigned bus number 1
[    3.133280] ehci-platform fe380000.usb: irq 33, io mem 0xfe380000
[    3.164664] ehci-platform fe380000.usb: USB 2.0 started, EHCI 1.00
[    3.171783] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.15
[    3.181045] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    3.189134] usb usb1: Product: EHCI Host Controller
[    3.194588] usb usb1: Manufacturer: Linux 5.15.0-rc4-ARCH ehci_hcd
[    3.201508] usb usb1: SerialNumber: fe380000.usb
[    3.207075] hub 1-0:1.0: USB hub found
[    3.211292] hub 1-0:1.0: 1 port detected
[    3.218315] ehci-platform fe3c0000.usb: EHCI Host Controller
[    3.224800] ehci-platform fe3c0000.usb: new USB bus registered,
assigned bus number 2
[    3.233685] ehci-platform fe3c0000.usb: irq 35, io mem 0xfe3c0000
[    3.264665] ehci-platform fe3c0000.usb: USB 2.0 started, EHCI 1.00
[    3.271762] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.15
[    3.281024] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    3.289104] usb usb2: Product: EHCI Host Controller
[    3.294550] usb usb2: Manufacturer: Linux 5.15.0-rc4-ARCH ehci_hcd
[    3.301470] usb usb2: SerialNumber: fe3c0000.usb
[    3.306997] hub 2-0:1.0: USB hub found
[    3.311203] hub 2-0:1.0: 1 port detected
[    3.316254] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.323179] ohci-pci: OHCI PCI platform driver
[    3.328222] ohci-platform: OHCI generic platform driver
[    3.334381] ohci-platform fe3a0000.usb: Generic Platform OHCI controller
[    3.342025] ohci-platform fe3a0000.usb: new USB bus registered,
assigned bus number 3
[    3.351633] ohci-platform fe3a0000.usb: irq 34, io mem 0xfe3a0000
[    3.428835] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0001, bcdDevice= 5.15
[    3.438095] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    3.446186] usb usb3: Product: Generic Platform OHCI controller
[    3.452806] usb usb3: Manufacturer: Linux 5.15.0-rc4-ARCH ohci_hcd
[    3.459717] usb usb3: SerialNumber: fe3a0000.usb
[    3.465248] hub 3-0:1.0: USB hub found
[    3.469466] hub 3-0:1.0: 1 port detected
[    3.474333] ohci-platform fe3e0000.usb: Generic Platform OHCI controller
[    3.481996] ohci-platform fe3e0000.usb: new USB bus registered,
assigned bus number 4
[    3.490960] ohci-platform fe3e0000.usb: irq 36, io mem 0xfe3e0000
[    3.504668] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    3.568831] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0001, bcdDevice= 5.15
[    3.578095] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    3.586183] usb usb4: Product: Generic Platform OHCI controller
[    3.592795] usb usb4: Manufacturer: Linux 5.15.0-rc4-ARCH ohci_hcd
[    3.599714] usb usb4: SerialNumber: fe3e0000.usb
[    3.605249] hub 4-0:1.0: USB hub found
[    3.609465] hub 4-0:1.0: 1 port detected
[    3.614476] uhci_hcd: USB Universal Host Controller Interface driver
[    3.622630] usbcore: registered new interface driver uas
[    3.628791] usbcore: registered new interface driver usb-storage
[    3.635550] usbcore: registered new interface driver ums-alauda
[    3.642191] usbcore: registered new interface driver ums-cypress
[    3.648940] usbcore: registered new interface driver ums-datafab
[    3.655704] usbcore: registered new interface driver ums_eneub6250
[    3.662643] usbcore: registered new interface driver ums-freecom
[    3.669392] usbcore: registered new interface driver ums-isd200
[    3.676045] usbcore: registered new interface driver ums-jumpshot
[    3.682879] usbcore: registered new interface driver ums-karma
[    3.689439] usbcore: registered new interface driver ums-onetouch
[    3.696295] usbcore: registered new interface driver ums-realtek
[    3.703039] usbcore: registered new interface driver ums-sddr09
[    3.709690] usbcore: registered new interface driver ums-sddr55
[    3.716344] usbcore: registered new interface driver ums-usbat
[    3.722934] usbcore: registered new interface driver usbserial_generic
[    3.724387] usb 1-1: New USB device found, idVendor=2232,
idProduct=1082, bcdDevice= 0.08
[    3.730262] usbserial: USB Serial support registered for generic
[    3.739395] usb 1-1: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    3.748051] mousedev: PS/2 mouse device common for all mice
[    3.754093] usb 1-1: Product: 720p HD Camera
[    3.754099] usb 1-1: Manufacturer: Namuga
[    3.763550] atmel_mxt_ts 3-004b: supply vdda not found, using dummy regulator
[    3.765119] usb 1-1: SerialNumber: 200901010001
[    3.782797] atmel_mxt_ts 3-004b: supply vdd not found, using dummy regulator
[    3.861646] atmel_mxt_ts 3-004b: Family: 164 Variant: 14 Firmware
V2.3.AA Objects: 40
[    3.870520] atmel_mxt_ts 3-004b: Direct firmware load for
maxtouch.cfg failed with error -2
[    3.873367] atmel_mxt_ts 5-004a: supply vdda not found, using dummy regulator
[    3.888077] atmel_mxt_ts 5-004a: supply vdd not found, using dummy regulator
[    3.896939] atmel_mxt_ts 3-004b: Touchscreen size X4095Y2729
[    3.903409] input: Atmel maXTouch Touchscreen as
/devices/platform/ff130000.i2c/i2c-3/3-004b/input/input0
[    3.970399] atmel_mxt_ts 5-004a: Family: 164 Variant: 17 Firmware
V2.0.AA Objects: 31
[    3.979271] atmel_mxt_ts 5-004a: Direct firmware load for
maxtouch.cfg failed with error -2
[    3.990962] tpm_i2c_infineon 0-0020: 1.2 TPM (device-id 0x1A)
[    3.991185] atmel_mxt_ts 5-004a: Touchscreen size X1920Y1080
[    4.003885] input: Atmel maXTouch Touchpad as
/devices/platform/ff140000.i2c/i2c-5/5-004a/input/input1
[    4.025473] random: fast init done
[    4.089020] device-mapper: uevent: version 1.0.3
[    4.094478] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22)
initialised: dm-devel@redhat.com
[    4.106395] cpu cpu0: EM: created perf domain
[    4.112217] cpu cpu4: EM: created perf domain
[    4.118785] sdhci: Secure Digital Host Controller Interface driver
[    4.125716] sdhci: Copyright(c) Pierre Ossman
[    4.131052] Synopsys Designware Multimedia Card Interface Driver
[    4.138267] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.145839] mmc1: CQHCI version 5.10
[    4.150073] ledtrig-cpu: registered to indicate activity on CPUs
[    4.157206] hid: raw HID events driver (C) Jiri Kosina
[    4.163019] usbcore: registered new interface driver usbhid
[    4.169259] usbhid: USB HID core driver
[    4.173707] spi_master spi2: will run message pump with realtime priority
[    4.176233] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
[    4.191518] cros-ec-rtc cros-ec-rtc.2.auto: registered as rtc0
[    4.198509] cros-ec-rtc cros-ec-rtc.2.auto: setting system clock to
2022-05-29T20:27:13 UTC (1653856033)
[    4.210504] cros-ec-pchg cros-ec-pchg.10.auto: Unable to get number
or ports (err:-95)
[    4.219385] cros-ec-pchg cros-ec-pchg.10.auto: No peripheral charge
ports (err:-95)
[    4.228793] input: cros_ec as
/devices/platform/ff200000.spi/spi_master/spi2/spi2.0/ff200000.spi:ec@0:keyboard-controller/input/input2
[    4.246216] input: cros_ec_buttons as
/devices/platform/ff200000.spi/spi_master/spi2/spi2.0/ff200000.spi:ec@0:keyboard-controller/input/input3
[    4.267397] cros-ec-spi spi2.0: Chrome EC device registered
[    4.289238] Initializing XFRM netlink socket
[    4.294259] NET: Registered PF_INET6 protocol family
[    4.305371] Segment Routing with IPv6
[    4.309496] In-situ OAM (IOAM) with IPv6
[    4.313915] mip6: Mobile IPv6
[    4.317240] NET: Registered PF_PACKET protocol family
[    4.323239] Key type dns_resolver registered
[    4.329014] registered taskstats version 1
[    4.333603] Loading compiled-in X.509 certificates
[    4.339175] zswap: loaded using pool lzo/zbud
[    4.344429] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    4.350119] mmc1: new HS400 Enhanced strobe MMC card at address 0001
[    4.354867] Key type ._fscrypt registered
[    4.362769] mmcblk1: mmc1:0001 500073 29.1 GiB
[    4.366383] Key type .fscrypt registered
[    4.366386] Key type fscrypt-provisioning registered
[    4.368914] Key type encrypted registered
[    4.376166] GPT:partition_entry_array_crc32 values don't match:
0x3ecea4c9 != 0x62b97360
[    4.394966] GPT:Primary header thinks Alt. header is not at the end
of the disk.
[    4.396887] pp3000_sd_slot: supplied by pp3000
[    4.403237] GPT:61070999 != 61071359
[    4.412208] GPT:Alternate GPT header not at the end of the disk.
[    4.415093] xhci-hcd xhci-hcd.14.auto: xHCI Host Controller
[    4.418970] GPT:61070999 != 61071359
[    4.425424] xhci-hcd xhci-hcd.14.auto: new USB bus registered,
assigned bus number 5
[    4.429167] GPT: Use GNU Parted to correct GPT errors.
[    4.437978] xhci-hcd xhci-hcd.14.auto: hcc params 0x0220fe64 hci
version 0x110 quirks 0x0000000002010010
[    4.443622]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[    4.454244] xhci-hcd xhci-hcd.14.auto: irq 83, io mem 0xfe800000
[    4.462563] mmcblk1boot0: mmc1:0001 500073 4.00 MiB
[    4.467473] xhci-hcd xhci-hcd.14.auto: xHCI Host Controller
[    4.474322] mmcblk1boot1: mmc1:0001 500073 4.00 MiB
[    4.479425] xhci-hcd xhci-hcd.14.auto: new USB bus registered,
assigned bus number 6
[    4.486096] mmcblk1rpmb: mmc1:0001 500073 4.00 MiB, chardev (239:0)
[    4.493318] xhci-hcd xhci-hcd.14.auto: Host supports USB 3.0 SuperSpeed
[    4.507822] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.15
[    4.517072] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.525149] usb usb5: Product: xHCI Host Controller
[    4.530596] usb usb5: Manufacturer: Linux 5.15.0-rc4-ARCH xhci-hcd
[    4.537505] usb usb5: SerialNumber: xhci-hcd.14.auto
[    4.543558] hub 5-0:1.0: USB hub found
[    4.547775] hub 5-0:1.0: 1 port detected
[    4.552340] usb usb6: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.561454] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.15
[    4.570700] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.578782] usb usb6: Product: xHCI Host Controller
[    4.584229] usb usb6: Manufacturer: Linux 5.15.0-rc4-ARCH xhci-hcd
[    4.591140] usb usb6: SerialNumber: xhci-hcd.14.auto
[    4.597153] hub 6-0:1.0: USB hub found
[    4.601355] hub 6-0:1.0: 1 port detected
[    4.611425] xhci-hcd xhci-hcd.15.auto: xHCI Host Controller
[    4.617899] xhci-hcd xhci-hcd.15.auto: new USB bus registered,
assigned bus number 7
[    4.626649] xhci-hcd xhci-hcd.15.auto: hcc params 0x0220fe64 hci
version 0x110 quirks 0x0000000002010010
[    4.637348] xhci-hcd xhci-hcd.15.auto: irq 84, io mem 0xfe900000
[    4.644135] xhci-hcd xhci-hcd.15.auto: xHCI Host Controller
[    4.650586] xhci-hcd xhci-hcd.15.auto: new USB bus registered,
assigned bus number 8
[    4.659257] xhci-hcd xhci-hcd.15.auto: Host supports USB 3.0 SuperSpeed
[    4.666732] usb usb7: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.15
[    4.675978] usb usb7: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.684049] usb usb7: Product: xHCI Host Controller
[    4.689502] usb usb7: Manufacturer: Linux 5.15.0-rc4-ARCH xhci-hcd
[    4.696410] usb usb7: SerialNumber: xhci-hcd.15.auto
[    4.702447] hub 7-0:1.0: USB hub found
[    4.706717] hub 7-0:1.0: 1 port detected
[    4.711415] usb usb8: We don't know the algorithms for LPM for this
host, disabling LPM.
[    4.720560] usb usb8: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.15
[    4.729806] usb usb8: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    4.737891] usb usb8: Product: xHCI Host Controller
[    4.743339] usb usb8: Manufacturer: Linux 5.15.0-rc4-ARCH xhci-hcd
[    4.750249] usb usb8: SerialNumber: xhci-hcd.15.auto
[    4.756562] hub 8-0:1.0: USB hub found
[    4.760778] hub 8-0:1.0: 1 port detected
[    4.766962] ALSA device list:
[    4.770287]   No soundcards found.
[    4.774231] dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address mode.
[    4.782191] dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
[    4.789598] dwmmc_rockchip fe320000.mmc: Version ID is 270a
[    4.795956] dwmmc_rockchip fe320000.mmc: DW MMC controller at irq
31,32 bit host data width,256 deep fifo
[    4.806961] dwmmc_rockchip fe320000.mmc: Got CD GPIO
[    4.824819] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req
400000Hz, actual 400000HZ div = 0)
[    4.848988] md: Waiting for all devices to be available before autodetect
[    4.856660] md: If you don't use raid, use raid=noautodetect
[    4.862992] md: Autodetecting RAID arrays.
[    4.867733] md: autorun ...
[    4.870866] md: ... autorun DONE.
[    4.874603] Waiting for root device
PARTUUID=5078b3ce-3806-0c46-80b6-a1ea7ca166aa/PARTNROFF=1...
[    5.685581] usb 6-1: new SuperSpeed USB device number 2 using xhci-hcd
[    5.727780] usb 6-1: New USB device found, idVendor=1de1,
idProduct=e101, bcdDevice=20.01
[    5.736949] usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.744927] usb 6-1: Product: AM8180
[    5.748917] usb 6-1: Manufacturer: AMicro
[    5.753392] usb 6-1: SerialNumber: 012345681825
[    6.534302] scsi host0: uas
[    6.540752] scsi 0:0:0:0: Direct-Access     AMicro   AM8180 NVME
  1.00 PQ: 0 ANSI: 6
[    6.557014] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.565317] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks:
(500 GB/466 GiB)
[    6.575131] sd 0:0:0:0: [sda] Write Protect is off
[    6.580499] sd 0:0:0:0: [sda] Mode Sense: 37 00 00 08
[    6.583112] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.595491] sd 0:0:0:0: [sda] Optimal transfer size 33553920 bytes
[    6.653352]  sda: sda1 sda2
[    6.720427] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.745854] EXT4-fs (sda2): Using encoding defined by superblock:
utf8-12.1.0 with flags 0x0
[    6.755864] EXT4-fs (sda2): Using encoding defined by superblock:
utf8-12.1.0 with flags 0x0
[    6.765571] EXT4-fs (sda2): Using encoding defined by superblock:
utf8-12.1.0 with flags 0x0
[    7.230214] EXT4-fs (sda2): recovery complete
[    7.236642] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: (null). Quota mode: none.
[    7.247104] VFS: Mounted root (ext4 filesystem) on device 8:2.
[    7.254477] devtmpfs: mounted
[    7.258732] Freeing unused kernel memory: 2624K
[    7.263870] Run /sbin/init as init process
[    7.268481]   with arguments:
[    7.268484]     /sbin/init
[    7.268487]   with environment:
[    7.268489]     HOME=/
[    7.268491]     TERM=linux
[    7.268493]     earlyprintk=ttyS2,115200n8
[    7.398046] systemd[1]: systemd 250.5-1-arch running in system mode
(+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS
+OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD
+LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2
+LZ4 +XZ +ZLIB +ZSTD -BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT
default-hierarchy=unified)
[    7.434056] systemd[1]: Detected architecture arm64.
[    7.441199] systemd[1]: Hostname set to <crosplus>.
[    7.887426] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
[    8.046743] systemd[1]: Queued start job for default target
Graphical Interface.
[    8.057130] systemd[1]: Created slice Slice /system/getty.
[    8.064296] systemd[1]: Created slice Slice /system/modprobe.
[    8.071829] systemd[1]: Created slice Slice /system/serial-getty.
[    8.079349] systemd[1]: Created slice User and Session Slice.
[    8.086097] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
[    8.095171] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    8.104077] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    8.114882] systemd[1]: Reached target Local Encrypted Volumes.
[    8.121608] systemd[1]: Reached target Local Integrity Protected Volumes.
[    8.129370] systemd[1]: Reached target Remote File Systems.
[    8.135695] systemd[1]: Reached target Slice Units.
[    8.141241] systemd[1]: Reached target Swaps.
[    8.146307] systemd[1]: Reached target Local Verity Protected Volumes.
[    8.153865] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    8.163515] systemd[1]: Listening on LVM2 poll daemon socket.
[    8.172638] systemd[1]: Listening on Process Core Dump Socket.
[    8.179708] systemd[1]: Listening on Journal Audit Socket.
[    8.186210] systemd[1]: Listening on Journal Socket (/dev/log).
[    8.193160] systemd[1]: Listening on Journal Socket.
[    8.199121] systemd[1]: Listening on Network Service Netlink Socket.
[    8.208016] systemd[1]: Listening on udev Control Socket.
[    8.214398] systemd[1]: Listening on udev Kernel Socket.
[    8.222667] systemd[1]: Mounting Huge Pages File System...
[    8.230879] systemd[1]: Mounting POSIX Message Queue File System...
[    8.240038] systemd[1]: Mounting Kernel Debug File System...
[    8.246770] systemd[1]: Kernel Trace File System was skipped
because of a failed condition check
(ConditionPathExists=/sys/kernel/tracing).
[    8.263466] systemd[1]: Mounting Temporary Directory /tmp...
[    8.272430] systemd[1]: Starting Create List of Static Device Nodes...
[    8.282073] systemd[1]: Starting Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling...
[    8.295973] systemd[1]: Starting Load Kernel Module configfs...
[    8.305592] systemd[1]: Starting Load Kernel Module drm...
[    8.310610] random: lvm: uninitialized urandom read (4 bytes read)
[    8.321537] systemd[1]: Starting Load Kernel Module fuse...
[    8.328246] systemd[1]: File System Check on Root Device was
skipped because of a failed condition check
(ConditionPathIsReadWrite=!/).
[    8.342913] fuse: init (API version 7.34)
[    8.345290] systemd[1]: Starting Load Kernel Modules...
[    8.355597] systemd[1]: Starting Remount Root and Kernel File Systems...
[    8.363392] systemd[1]: Repartition Root Disk was skipped because
all trigger condition checks failed.
[    8.376211] systemd[1]: Starting Coldplug All udev Devices...
[    8.386366] systemd[1]: Mounted Huge Pages File System.
[    8.392647] systemd[1]: Mounted POSIX Message Queue File System.
[    8.399753] systemd[1]: Mounted Kernel Debug File System.
[    8.406267] systemd[1]: Mounted Temporary Directory /tmp.
[    8.413080] systemd[1]: Finished Create List of Static Device Nodes.
[    8.421305] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    8.430254] systemd[1]: Finished Load Kernel Module configfs.
[    8.437616] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    8.445634] systemd[1]: Finished Load Kernel Module drm.
[    8.452492] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    8.460562] systemd[1]: Finished Load Kernel Module fuse.
[    8.467554] systemd[1]: Finished Load Kernel Modules.
[    8.477814] systemd[1]: Mounting FUSE Control File System...
[    8.486376] systemd[1]: Mounting Kernel Configuration File System...
[    8.495848] systemd[1]: Starting Apply Kernel Variables...
[    8.503620] systemd[1]: Mounted FUSE Control File System.
[    8.510263] systemd[1]: Mounted Kernel Configuration File System.
[    8.516616] EXT4-fs (sda2): re-mounted. Opts: (null). Quota mode: none.
[    8.526692] systemd[1]: Finished Apply Kernel Variables.
[    8.533724] systemd[1]: Finished Remount Root and Kernel File Systems.
[    8.542038] systemd[1]: First Boot Wizard was skipped because of a
failed condition check (ConditionFirstBoot=yes).
[    8.554668] systemd[1]: Rebuild Hardware Database was skipped
because all trigger condition checks failed.
[    8.567950] systemd[1]: Starting Load/Save Random Seed...
[    8.576709] systemd[1]: Starting Create System Users...
[    8.586787] systemd[1]: Finished Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling.
[    8.635448] systemd[1]: Finished Create System Users.
[    8.643902] systemd[1]: Starting Create Static Device Nodes in /dev...
[    8.663408] systemd[1]: Finished Coldplug All udev Devices.
[    8.724797] systemd[1]: Finished Create Static Device Nodes in /dev.
[    8.732276] systemd[1]: Reached target Preparation for Local File Systems.
[    8.740433] systemd[1]: Virtual Machine and Container Storage
(Compatibility) was skipped because of a failed condition check
(ConditionPathExists=/var/lib/machines.raw).
[    8.757518] systemd[1]: Reached target Local File Systems.
[    8.763788] systemd[1]: Entropy Daemon based on the HAVEGE
algorithm was skipped because of a failed condition check
(ConditionKernelVersion=<5.6).
[    8.780902] systemd[1]: Starting Rebuild Dynamic Linker Cache...
[    8.788894] systemd[1]: Set Up Additional Binary Formats was
skipped because all trigger condition checks failed.
[    8.804005] systemd[1]: Starting Journal Service...
[    8.813217] systemd[1]: Starting Rule-based Manager for Device
Events and Files...
[    8.924782] systemd[1]: Started Journal Service.
[    8.931323] audit: type=1130 audit(1653856038.220:2): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-journald
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[    9.078872] systemd-journald[338]: Received client request to flush
runtime journal.
[    9.145311] audit: type=1130 audit(1653856038.440:3): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[    9.169613] audit: type=1334 audit(1653856038.460:4): prog-id=9 op=LOAD
[    9.171314] random: crng init done
[    9.206531] audit: type=1130 audit(1653856038.500:5): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-random-seed
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[    9.412188] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    9.475741] audit: type=1130 audit(1653856038.770:6): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-journal-flush
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[    9.497619] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    9.751635] mc: Linux media interface: v0.10
[    9.758289] audit: type=1130 audit(1653856039.050:7): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-networkd
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[    9.782130] cros-usbpd-charger cros-usbpd-charger.4.auto: Could not
get charger port count
[    9.796678] dw_wdt ff848000.watchdog: No valid TOPs array specified
[    9.801544] da7219 8-001a: Using default DAI clk names:
da7219-dai-wclk, da7219-dai-bclk
[    9.804328] sbs-battery 9-000b: sbs-battery: battery gas gauge
device registered
[    9.819457] videodev: Linux video capture interface: v2.00
[    9.851412] sbs-battery 9-000b: Disabling PEC because of broken
Cros-EC implementation
[    9.865017] sbs-battery 9-000b: I2C adapter does not support
I2C_FUNC_SMBUS_READ_BLOCK_DATA.
               Fallback method does not support PEC.
[    9.883506] mwifiex_pcie 0000:01:00.0: no quirks enabled
[    9.890664] mwifiex_pcie 0000:01:00.0: enabling device (0000 -> 0002)
[    9.891755] panel-simple edp-panel: Specify missing connector_type
[    9.898532] mwifiex_pcie: PCI memory map Virt0: 000000008b23c76f
PCI memory map Virt2: 00000000b81133c7
[    9.916111] audit: type=1130 audit(1653856039.210:8): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[    9.962645] rockchip_vdec: module is from the staging directory,
the quality is unknown, you have been warned.
[    9.974017] audit: type=1334 audit(1653856039.260:9): prog-id=10 op=LOAD
[    9.989693] hantro_vpu: module is from the staging directory, the
quality is unknown, you have been warned.
[   10.013218] usb 1-1: Found UVC 1.00 device 720p HD Camera (2232:1082)
[   10.013343] hantro-vpu ff650000.video-codec: Adding to iommu group 0
[   10.013479] rockchip-rga ff680000.rga: HW Version: 0x03.02
[   10.013570] rockchip-rga: probe of ff680000.rga failed with error -12
[   10.014875] panfrost ff9a0000.gpu: clock rate = 500000000
[   10.045378] audit: type=1334 audit(1653856039.330:10): prog-id=11 op=LOAD
[   10.069504] rkvdec ff660000.video-codec: Adding to iommu group 1
[   10.069663] hantro-vpu ff650000.video-codec: registered
rockchip,rk3399-vpu-enc as /dev/video1
[   10.094225] input: 720p HD Camera: 720p HD Camera as
/devices/platform/fe380000.usb/usb1/1-1/1-1:1.0/input/input4
[   10.094937] hantro-vpu ff650000.video-codec: registered
rockchip,rk3399-vpu-dec as /dev/video4
[   10.101344] panfrost ff9a0000.gpu: mali-t860 id 0x860 major 0x2
minor 0x0 status 0x0
[   10.101361] panfrost ff9a0000.gpu: features: 00000000,100e77bf,
issues: 00000000,24040400
[   10.101368] panfrost ff9a0000.gpu: Features: L2:0x07120206
Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff
JS:0x7
[   10.101377] panfrost ff9a0000.gpu: shader_present=0xf l2_present=0x1
[   10.111047] [drm] Initialized panfrost 1.2.0 20180908 for
ff9a0000.gpu on minor 0
[   10.148474] usbcore: registered new interface driver uvcvideo
[   10.169016] audit: type=1130 audit(1653856039.460:11): pid=1 uid=0
auid=4294967295 ses=4294967295
msg='unit=systemd-journal-catalog-update comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   10.233715] ntc-thermistor thermistor-ppvar-bigcpu: Thermistor
type: ncp15wb473 successfully probed.
[   10.246903] ntc-thermistor thermistor-ppvar-litcpu: Thermistor
type: ncp15wb473 successfully probed.
[   10.255088] rockchip-vop ff8f0000.vop: Adding to iommu group 2
[   10.259925] input: gpio-keys as /devices/platform/gpio-keys/input/input5
[   10.264474] rockchip-vop ff900000.vop: Adding to iommu group 3
[   10.279475] rockchip-dp ff970000.edp: no DP phy configured
[   10.291506] rockchip-drm display-subsystem: bound ff8f0000.vop (ops
vop_component_ops [rockchipdrm])
[   10.301980] [drm] unsupported AFBC format[3231564e]
[   10.309119] rockchip-drm display-subsystem: bound ff900000.vop (ops
vop_component_ops [rockchipdrm])
[   10.328063] rockchip-drm display-subsystem: bound ff970000.edp (ops
rockchip_dp_component_ops [rockchipdrm])
[   10.339343] rockchip-drm display-subsystem: bound fec00000.dp (ops
cdn_dp_component_ops [rockchipdrm])
[   10.353067] cdn-dp fec00000.dp: [drm:cdn_dp_pd_event_work
[rockchipdrm]] Not connected. Disabling cdn
[   10.642410] Console: switching to colour frame buffer device 300x100
[   10.697720] rockchip-drm display-subsystem: [drm] fb0: rockchip
frame buffer device
[   10.775307] [drm] Initialized rockchip 1.0.0 20140818 for
display-subsystem on minor 1
[   10.823099] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: sink
widget Capture overwritten
[   10.833575] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: sink
widget Capture overwritten
[   10.867789] debugfs: File 'Capture' in directory 'dapm' already present!
[   10.879777] input: rk3399-gru-sound Headset Jack as
/devices/platform/sound/sound/card0/input6
[   11.053711] mwifiex_pcie 0000:01:00.0: info: FW download over, size
638992 bytes
[   11.894832] mwifiex_pcie 0000:01:00.0: WLAN FW is active
[   11.946169] mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION:
mwifiex 1.0 (16.68.10.p159)
[   11.955672] mwifiex_pcie 0000:01:00.0: driver_version = mwifiex 1.0
(16.68.10.p159)
[   12.054723] usb 2-1: new high-speed USB device number 2 using ehci-platform
[   12.270876] usb 2-1: New USB device found, idVendor=1286,
idProduct=204e, bcdDevice=32.01
[   12.280870] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   12.289103] usb 2-1: Product: Bluetooth and Wireless LAN Composite Device
[   12.296950] usb 2-1: Manufacturer: Marvell
[   12.301671] usb 2-1: SerialNumber: 0000000000000000
[   12.455880] Bluetooth: Core ver 2.22
[   12.460071] NET: Registered PF_BLUETOOTH protocol family
[   12.466058] Bluetooth: HCI device and connection manager initialized
[   12.473247] Bluetooth: HCI socket layer initialized
[   12.478784] Bluetooth: L2CAP socket layer initialized
[   12.484487] Bluetooth: SCO socket layer initialized
[   12.499509] usbcore: registered new interface driver btusb
[   12.503657] Bluetooth: hci0: unexpected event for opcode 0x0000
[   13.793228] alg: No test for hmac(md4) (hmac(md4-generic))
[   13.947228] kauditd_printk_skb: 18 callbacks suppressed
[   13.947246] audit: type=1130 audit(1653856043.240:30): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-user-sessions
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   13.977170] audit: type=1130 audit(1653856043.270:31): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=getty@tty1 comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   14.002473] audit: type=1130 audit(1653856043.290:32): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=serial-getty@ttyS2
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   14.049839] audit: type=1130 audit(1653856043.340:33): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=autorandr comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   14.073583] audit: type=1131 audit(1653856043.340:34): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=autorandr comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   14.097319] systemd-journald[338]: Time jumped backwards, rotating.
[   14.126711] audit: type=1130 audit(1653856043.020:35): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=hwtosysclock comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   14.150778] audit: type=1131 audit(1653856043.020:36): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=hwtosysclock comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   14.239919] audit: type=1130 audit(1653856043.130:37): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=colord comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   14.296879] mwifiex_pcie 0000:01:00.0: info: trying to associate to
bssid 78:24:af:7d:cb:34
[   14.324872] mwifiex_pcie 0000:01:00.0: info: associated to bssid
78:24:af:7d:cb:34 successfully
[   14.348689] audit: type=1130 audit(1653856043.240:38): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=cups comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   14.379159] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   17.527478] audit: type=1131 audit(1653856046.420:39): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=systemd-rfkill comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   24.077788] audit: type=1100 audit(1653856052.970:40): pid=499
uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication
grantors=? acct="stephen" exe="/usr/bin/login" hostname=crosplus
addr=? terminal=/dev/tty1 res=failed'
[   32.815580] audit: type=1100 audit(1653856061.710:41): pid=499
uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication
grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyring
acct="stephen" exe="/usr/bin/login" hostname=crosplus addr=?
terminal=/dev/tty1 res=success'
[   32.846182] audit: type=1101 audit(1653856061.710:42): pid=499
uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting
grantors=pam_access,pam_unix,pam_permit,pam_time acct="stephen"
exe="/usr/bin/login" hostname=crosplus addr=? terminal=/dev/tty1
res=success'
[   32.872481] audit: type=1103 audit(1653856061.710:43): pid=499
uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred
grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyring
acct="stephen" exe="/usr/bin/login" hostname=crosplus addr=?
terminal=/dev/tty1 res=success'
[   32.872493] audit: type=1006 audit(1653856061.710:44): pid=499
uid=0 old-auid=4294967295 auid=1001 tty=tty1 old-ses=4294967295 ses=1
res=1
[   32.872500] audit: type=1300 audit(1653856061.710:44):
arch=c00000b7 syscall=64 success=yes exit=4 a0=5 a1=fffffe6fefd0 a2=4
a3=ffffb417bc60 items=0 ppid=1 pid=499 auid=1001 uid=0 gid=0 euid=0
suid=0 fsuid=0 egid=0 sgid=1001 fsgid=0 tty=tty1 ses=1 comm="login"
exe="/usr/bin/login" key=(null)
[   32.872507] audit: type=1327 audit(1653856061.710:44):
proctitle=2F62696E2F6C6F67696E002D70002D2D
[   32.966782] audit: type=1130 audit(1653856061.860:45): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@1001
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success'
[   32.994521] audit: type=1101 audit(1653856061.880:46): pid=512
uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting
grantors=pam_access,pam_unix,pam_permit,pam_time acct="stephen"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   33.020420] audit: type=1103 audit(1653856061.890:47): pid=512
uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=?
acct="stephen" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=failed'
[   33.042238] audit: type=1006 audit(1653856061.890:48): pid=512
uid=0 old-auid=4294967295 auid=1001 tty=(none) old-ses=4294967295
ses=2 res=1
[   35.034933] p3.3v_dig: disabling
[   35.038579] ppvar_sd_card_io: disabling
[   35.042886] pp3000_sd_slot: disabling
[   38.280966] kauditd_printk_skb: 11 callbacks suppressed
[   38.280975] audit: type=1130 audit(1653856067.170:56): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=rtkit-daemon comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[   38.822219] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   38.833488] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.844996]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   38.850834] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.862414] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   38.873613] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.885116]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   38.891092] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.902679] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   38.913872] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.925353]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   38.931190] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.942692] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   38.953885] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.965367]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   38.971218] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   38.982734] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   38.993941] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.005423]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.011259] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.023273] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.034471] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.045949]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.051784] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.063287] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.074479] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.085958]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.091793] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.103313] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.114500] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.125979]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.131815] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.143313] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.154500] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.165977]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.171814] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.183322] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.194520] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.205996]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.211832] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.223814] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.235005] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.246487]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.252323] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.263891] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.275079] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.286555]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.292390] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.303988] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.315178] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.326655]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.332490] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.344052] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.355242] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.366725]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.372560] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.384148] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.395337] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.406811]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.412646] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.424677] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.435873] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.447351]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.453186] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.464796] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.475985] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.487460]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.493287] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.504932] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.516121] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.527596]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.533423] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.545028] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.556220] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.567704]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.573539] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.585167] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.596353] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.607829]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.613655] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_digital_mute on spdif-hifi: -19
[   39.625468] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.637630]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.644268] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.656302]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.662962] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.674467]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.680975] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.692476]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.698889] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.710661]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.717426] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.728970]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.735402] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.747143]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.753343] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.764921]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.771695] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.783403]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.790341] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.802078]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.809139] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.820813]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.827118] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.838778]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.845127] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.856801]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.863164] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.874653]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.881241] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.892725]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.899711] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.911382]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.917953] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.929619]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.936217] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.947878]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.954152] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.965814]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   39.972050] hdmi-audio-codec hdmi-audio-codec.16.auto: ASoC: error
at snd_soc_dai_hw_params on spdif-hifi: -19
[   39.983712]  DP: ASoC: soc_pcm_hw_params() failed (-19)
[   48.686903] systemd-journald[338]: Time jumped backwards, rotating.
[   74.715332] PDLOG 2022/05/29 19:07:22.024 P0 Disconnected
[   74.721946] PDLOG 2022/05/29 19:07:22.024 P1 Disconnected
[  137.548690] Purging 16777216 bytes
[  561.333966] audit: type=1334 audit(1653855522.547:57): prog-id=17 op=LOAD
[  561.341595] audit: type=1334 audit(1653855522.557:58): prog-id=18 op=LOAD
[  561.752116] audit: type=1130 audit(1653855522.967:59): pid=1 uid=0
auid=4294967295 ses=4294967295 msg='unit=upower comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success'
[  587.374714] audit: type=1100 audit(1653855548.587:60): pid=1318
uid=1001 auid=1001 ses=1 msg='op=PAM:authentication
grantors=pam_faillock,pam_permit,pam_faillock acct="stephen"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  587.399266] audit: type=1101 audit(1653855548.587:61): pid=1318
uid=1001 auid=1001 ses=1 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="stephen"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  587.422684] audit: type=1110 audit(1653855548.587:62): pid=1318
uid=1001 auid=1001 ses=1 msg='op=PAM:setcred
grantors=pam_faillock,pam_permit,pam_faillock acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  587.446287] audit: type=1105 audit(1653855548.597:63): pid=1318
uid=1001 auid=1001 ses=1 msg='op=PAM:session_open
grantors=pam_systemd_home,pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  587.471417] audit: type=1100 audit(1653855548.607:64): pid=1319
uid=0 auid=1001 ses=1 msg='op=PAM:authentication grantors=pam_rootok
acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/0
res=success'
[  587.492620] audit: type=1101 audit(1653855548.607:65): pid=1319
uid=0 auid=1001 ses=1 msg='op=PAM:accounting grantors=pam_unix
acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/0
res=success'
[  587.513242] audit: type=1103 audit(1653855548.607:66): pid=1319
uid=0 auid=1001 ses=1 msg='op=PAM:setcred grantors=pam_rootok
acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/0
res=success'
[  587.533756] audit: type=1105 audit(1653855548.607:67): pid=1319
uid=0 auid=1001 ses=1 msg='op=PAM:session_open grantors=pam_unix
acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/0
res=success'



>
> Note: the OP has since replied back to me via private-email, probably
> accidentally selecting "reply" instead of "reply-all".  So that other
> folks on the list know that they don't need to chase this down:
>
> > I have no backlight in early boot so I can't read console output.
> >
> > Since posting this I learned that I was mislead by my git bisect. The commit
> > on torvalds tree before this patch was merged
> > (79e06c4c4950be2abd8ca5d2428a8c915aa62c24) doesn't boot. What I
> > thought was the same issue in this patch was in fact only the result of the
> > backlight not turning on (the config option was different for my hardware in
> > 5.15 where this patch was based.) I'm still hunting the real issue,
> > but it likely
> > isn't the filesystem.
> >
> > Thank you very much for your effort. I'm very sorry I sent you on a wild goose
> > chase.
>
> Cheers,
>
>                                         - Ted
