Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC45E92DC
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Sep 2022 13:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiIYLzi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Sep 2022 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIYLzf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Sep 2022 07:55:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CF220EA
        for <linux-ext4@vger.kernel.org>; Sun, 25 Sep 2022 04:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9E88B80DED
        for <linux-ext4@vger.kernel.org>; Sun, 25 Sep 2022 11:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 524DFC433D7
        for <linux-ext4@vger.kernel.org>; Sun, 25 Sep 2022 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664106930;
        bh=VuuMBzdXNKoUMDBqHFEemQswx0tpIu17sNvPCIqfWWQ=;
        h=From:To:Subject:Date:From;
        b=Nmc8gI+O2ZP/ixiRIemBEQht7qTPZjOBiG/raNyvM9AuIVYV2poDawaxKnIkDagW9
         HSk4VQ/VzhpvaEcJgUvwH+kLW5dpL5OaRHew2jErODpTlySS7TzfeVi+jf5ffE+QV8
         qwzQCAHOOPnmnI8R/CuyATd3iq8AGmojt+S1TRl/2FlEU172RefjaHLoV8ae58Fz7v
         SnBl4bNgSwRbuScXMSbc5zlocXtApWaUuBrIaWVfsrhZszg6Tsxnd8f9jaDEICyHkw
         kenIC3haernRfUoxQPd9pW7u59Sq28IcctyJd2W6l3XcYCZMVfcJefOKu4enOlG0DQ
         5YejGvj42aaxQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1A0D3C433E4; Sun, 25 Sep 2022 11:55:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216529] New: [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Date:   Sun, 25 Sep 2022 11:55:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: zlang@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216529-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216529

            Bug ID: 216529
           Summary: [fstests generic/048] BUG: Kernel NULL pointer
                    dereference at 0x00000069,
                    filemap_release_folio+0x88/0xb0
           Product: File System
           Version: 2.5
    Kernel Version: 6.0.0-rc6+
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: zlang@redhat.com
        Regression: No

Hit a panic on ppc64le, by running generic/048 with 1k block size:

[ 4638.919160] run fstests generic/048 at 2022-09-23 21:00:41=20
[ 4641.700564] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 4641.710999] EXT4-fs (sda3): shut down requested (1)=20
[ 4641.718544] Aborting journal on device sda3-8.=20
[ 4641.740342] EXT4-fs (sda3): unmounting filesystem.=20
[ 4643.000415] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 4681.230907] BUG: Kernel NULL pointer dereference at 0x00000069=20
[ 4681.230922] Faulting instruction address: 0xc00000000068ee0c=20
[ 4681.230929] Oops: Kernel access of bad area, sig: 11 [#1]=20
[ 4681.230934] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSerie=
s=20
[ 4681.230942] Modules linked in: dm_flakey ext2 dm_snapshot dm_bufio dm_ze=
ro
dm_mod loop ext4 mbcache jbd2 bonding rfkill tls sunrpc pseries_rng drm fuse
drm_panel_orientation_quirks xfs libcrc32c sd_mod t10_pi sg ibmvscsi ibmveth
scsi_transport_srp vmx_crypto=20
[ 4681.230991] CPU: 0 PID: 82 Comm: kswapd0 Kdump: loaded Not tainted
6.0.0-rc6+ #1=20
[ 4681.230999] NIP:  c00000000068ee0c LR: c00000000068f2b8 CTR:
0000000000000000=20
[ 4681.238525] REGS: c000000006c0b560 TRAP: 0380   Not tainted  (6.0.0-rc6+=
)=20
[ 4681.238532] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR:
24028242  XER: 00000000=20
[ 4681.238556] CFAR: c00000000068edf4 IRQMASK: 0=20=20
[ 4681.238556] GPR00: c00000000068f2b8 c000000006c0b800 c000000002cf1700
c00c00000042f1c0=20=20
[ 4681.238556] GPR04: c000000006c0b860 0000000000000000 0000000000000002
0000000000000000=20=20
[ 4681.238556] GPR08: c000000002d404b0 0000000000000000 c00c00000042f1c0
0000000000000000=20=20
[ 4681.238556] GPR12: c0000000001cf080 c000000005100000 c000000000194298
c0000001fff9c480=20=20
[ 4681.238556] GPR16: c000000048cdb850 0000000000000007 0000000000000000
0000000000000000=20=20
[ 4681.238556] GPR20: 0000000000000001 c000000006c0b8f8 c00000000146b9d8
5deadbeef0000100=20=20
[ 4681.238556] GPR24: 5deadbeef0000122 c000000048cdb800 c000000006c0bc00
c000000006c0b8e8=20=20
[ 4681.238556] GPR28: c000000006c0b860 c00c00000042f1c0 0000000000000009
0000000000000009=20=20
[ 4681.238634] NIP [c00000000068ee0c] drop_buffers.constprop.0+0x4c/0x1c0=20
[ 4681.238643] LR [c00000000068f2b8] try_to_free_buffers+0x128/0x150=20
[ 4681.238650] Call Trace:=20
[ 4681.238654] [c000000006c0b800] [c000000006c0b880] 0xc000000006c0b880
(unreliable)=20
[ 4681.238663] [c000000006c0b840] [c000000006c0bc00] 0xc000000006c0bc00=20
[ 4681.238670] [c000000006c0b890] [c000000000498708]
filemap_release_folio+0x88/0xb0=20
[ 4681.238679] [c000000006c0b8b0] [c0000000004c51c0]
shrink_active_list+0x490/0x750=20
[ 4681.238688] [c000000006c0b9b0] [c0000000004c9f88] shrink_lruvec+0x3f8/0x=
430=20
[ 4681.238697] [c000000006c0baa0] [c0000000004ca1f4]
shrink_node_memcgs+0x234/0x290=20
[ 4681.238704] [c000000006c0bb10] [c0000000004ca3c4] shrink_node+0x174/0x6b=
0=20
[ 4681.238711] [c000000006c0bbc0] [c0000000004cacf0] balance_pgdat+0x3f0/0x=
970=20
[ 4681.238718] [c000000006c0bd20] [c0000000004cb440] kswapd+0x1d0/0x450=20
[ 4681.238726] [c000000006c0bdc0] [c0000000001943d8] kthread+0x148/0x150=20
[ 4681.238735] [c000000006c0be10] [c00000000000cbe4]
ret_from_kernel_thread+0x5c/0x64=20
[ 4681.238745] Instruction dump:=20
[ 4681.238749] fbc1fff0 f821ffc1 7c7d1b78 7c9c2378 ebc30028 7fdff378 480000=
18
60000000=20=20
[ 4681.238765] 60000000 ebff0008 7c3ef840 41820048 <815f0060> e93f0000 5529=
077c
7d295378=20=20
[ 4681.238782] ---[ end trace 0000000000000000 ]---=20
[ 4681.270607]=20=20
[ 4681.337460] Kernel attempted to read user page (6a) - exploit attempt? (=
uid:
0)=20
[ 4681.337469] BUG: Kernel NULL pointer dereference on read at 0x0000006a=20
[ 4681.337474] Faulting instruction address: 0xc00000000068ee0c=20
[ 4681.337478] Oops: Kernel access of bad area, sig: 11 [#2]=20
[ 4681.337481] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSerie=
s=20
[ 4681.337486] Modules linked in: dm_flakey ext2 dm_snapshot dm_bufio dm_ze=
ro
dm_mod loop ext4 mbcache jbd2 bonding rfkill tls sunrpc pseries_rng drm fuse
drm_panel_orientation_quirks xfs libcrc32c sd_mod t10_pi sg ibmvscsi ibmveth
scsi_transport_srp vmx_crypto=20
[ 4681.337517] CPU: 2 PID: 704157 Comm: xfs_io Kdump: loaded Tainted: G    =
  D=20
          6.0.0-rc6+ #1=20
[ 4681.337523] NIP:  c00000000068ee0c LR: c00000000068f2b8 CTR:
0000000000000000=20
[ 4681.337527] REGS: c000000036006ef0 TRAP: 0300   Tainted: G      D=20=20=
=20=20=20=20=20=20=20=20=20
 (6.0.0-rc6+)=20
[ 4681.337532] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR:
28428242  XER: 00000001=20
[ 4681.337546] CFAR: c00000000000c80c DAR: 000000000000006a DSISR: 40000000
IRQMASK: 0=20=20
[ 4681.337546] GPR00: c00000000068f2b8 c000000036007190 c000000002cf1700
c00c000000424740=20=20
[ 4681.337546] GPR04: c0000000360071f0 0000000000000000 0000000000000002
0000000000000000=20=20
[ 4681.337546] GPR08: c000000002d404b0 0000000000000000 c00c000000424740
0000000000000002=20=20
[ 4681.337546] GPR12: 0000000000000000 c00000000ffce400 0000000000000000
c0000001fff9c480=20=20
[ 4681.337546] GPR16: c00000004960e050 0000000000000007 0000000000000000
0000000000000000=20=20
[ 4681.337546] GPR20: 0000000000000001 c000000036007288 c00000000146b9d8
5deadbeef0000100=20=20
[ 4681.337546] GPR24: 5deadbeef0000122 c00000004960e000 c000000036007678
c000000036007278=20=20
[ 4681.337546] GPR28: c0000000360071f0 c00c000000424740 000000000000000a
000000000000000a=20=20
[ 4681.337602] NIP [c00000000068ee0c] drop_buffers.constprop.0+0x4c/0x1c0=20
[ 4681.337608] LR [c00000000068f2b8] try_to_free_buffers+0x128/0x150=20
[ 4681.337613] Call Trace:=20
[ 4681.337616] [c000000036007190] [c000000036007210] 0xc000000036007210
(unreliable)=20
[ 4681.337622] [c0000000360071d0] [c000000036007678] 0xc000000036007678=20
[ 4681.337627] [c000000036007220] [c000000000498708]
filemap_release_folio+0x88/0xb0=20
[ 4681.337633] [c000000036007240] [c0000000004c51c0]
shrink_active_list+0x490/0x750=20
[ 4681.337640] [c000000036007340] [c0000000004c9f88] shrink_lruvec+0x3f8/0x=
430=20
[ 4681.337645] [c000000036007430] [c0000000004ca1f4]
shrink_node_memcgs+0x234/0x290=20
[ 4681.337651] [c0000000360074a0] [c0000000004ca3c4] shrink_node+0x174/0x6b=
0=20
[ 4681.337656] [c000000036007550] [c0000000004cbd34]
shrink_zones.constprop.0+0xd4/0x3e0=20
[ 4681.337661] [c0000000360075d0] [c0000000004cc158]
do_try_to_free_pages+0x118/0x470=20
[ 4681.337667] [c000000036007650] [c0000000004cd084]
try_to_free_pages+0x194/0x4c0=20
[ 4681.337673] [c000000036007720] [c00000000054cca4]
__alloc_pages_slowpath.constprop.0+0x4f4/0xd80=20
[ 4681.337680] [c000000036007880] [c00000000054d95c] __alloc_pages+0x42c/0x=
580=20
[ 4681.337686] [c000000036007910] [c000000000587d88] alloc_pages+0xd8/0x1d0=
=20
[ 4681.337692] [c000000036007960] [c000000000587eb4] folio_alloc+0x34/0x90=
=20
[ 4681.337698] [c000000036007990] [c000000000498bc0]
filemap_alloc_folio+0x40/0x60=20
[ 4681.337703] [c0000000360079b0] [c0000000004a0f54]
__filemap_get_folio+0x224/0x790=20
[ 4681.337709] [c000000036007ab0] [c0000000004b4830]
pagecache_get_page+0x30/0xb0=20
[ 4681.337715] [c000000036007ae0] [c008000003a9e4dc]
ext4_da_write_begin+0x1a4/0x4f0 [ext4]=20
[ 4681.337742] [c000000036007b70] [c000000000498e54]
generic_perform_write+0xf4/0x2b0=20
[ 4681.337748] [c000000036007c20] [c008000003a7d190]
ext4_buffered_write_iter+0xa8/0x1a0 [ext4]=20
[ 4681.337770] [c000000036007c70] [c000000000615fc8] vfs_write+0x358/0x4b0=
=20
[ 4681.337776] [c000000036007d40] [c0000000006161f4] sys_pwrite64+0xd4/0x12=
0=20
[ 4681.337782] [c000000036007da0] [c0000000000318d0]
system_call_exception+0x180/0x430=20
[ 4681.337788] [c000000036007e10] [c00000000000be68]
system_call_vectored_common+0xe8/0x278=20
[ 4681.337795] --- interrupt: 3000 at 0x7fff95651da4=20
[ 4681.337799] NIP:  00007fff95651da4 LR: 0000000000000000 CTR:
0000000000000000=20
[ 4681.337803] REGS: c000000036007e80 TRAP: 3000   Tainted: G      D=20=20=
=20=20=20=20=20=20=20=20=20
 (6.0.0-rc6+)=20
[ 4681.337807] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> =
 CR:
48082402  XER: 00000000=20
[ 4681.337822] IRQMASK: 0=20=20
[ 4681.337822] GPR00: 00000000000000b4 00007ffffaa52530 00007fff95767200
0000000000000003=20=20
[ 4681.337822] GPR04: 0000010031ac0000 0000000000010000 0000000000490000
00007fff9581a5a0=20=20
[ 4681.337822] GPR08: 00007fff95812e68 0000000000000000 0000000000000000
0000000000000000=20=20
[ 4681.337822] GPR12: 0000000000000000 00007fff9581a5a0 0000000000a00000
ffffffffffffffff=20=20
[ 4681.337822] GPR16: 0000000000000000 0000000000000000 0000000000000000
0000000000000000=20=20
[ 4681.337822] GPR20: 0000000000000000 0000000000000000 0000000000000000
0000000000490000=20=20
[ 4681.337822] GPR24: 0000000000000049 0000000000000000 0000000000000000
0000000000010000=20=20
[ 4681.337822] GPR28: 0000010031ac0000 0000000000000003 0000000000000000
0000000000490000=20=20
[ 4681.337875] NIP [00007fff95651da4] 0x7fff95651da4=20
[ 4681.337878] LR [0000000000000000] 0x0=20
[ 4681.337881] --- interrupt: 3000=20
[ 4681.337884] Instruction dump:=20
[ 4681.337887] fbc1fff0 f821ffc1 7c7d1b78 7c9c2378 ebc30028 7fdff378 480000=
18
60000000=20=20
[ 4681.337897] 60000000 ebff0008 7c3ef840 41820048 <815f0060> e93f0000 5529=
077c
7d295378=20=20
[ 4681.337908] ---[ end trace 0000000000000000 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
