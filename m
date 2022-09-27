Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCC5EB671
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 02:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiI0ArI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 20:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0ArF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 20:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7BD868B0
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 17:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE8960B2F
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 00:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D0BC433C1
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 00:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664239623;
        bh=P7zbxhoBojY0tWdmEkQKecz53gV9TRVaR357H16zOxM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eNmUA9LOofZ3TbW4MdM76wRiWcQjwfVpx/I5YnZL+7O8iBoYrpfXd+d+FUPOlamEv
         AtsF1kKsdWBw9sGI3LNAiivNh+B9uE4TTOOcT+Vq/hdUendnjl19ckN0Wor6g03yff
         WuID9AsHSQ+uC08xYpqKlVn9/SJaqYZXYTrSoAnNcWk6HXIpcQyTQqESIYKrM1pTaF
         szrfmD5CiUUxRzMVVjOWx4HlrIZ7HNTPLRHfopV3+VB7we30v5/8kQMfhjUDr/atjq
         wVy+K9JmgA1fBuQVI2qymUvCoSgDt+mgnzEs5gvLK10tb5K7My+cgXjbhOt4k/hv8H
         DUw2qKIiIsxVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0A2B9C433E7; Tue, 27 Sep 2022 00:47:03 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216529] [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Date:   Tue, 27 Sep 2022 00:47:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216529-13602-My2i8BoSN7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216529-13602@https.bugzilla.kernel.org/>
References: <bug-216529-13602@https.bugzilla.kernel.org/>
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

--- Comment #2 from Zorro Lang (zlang@redhat.com) ---
(In reply to Theodore Tso from comment #1)
> On Sun, Sep 25, 2022 at 11:55:29AM +0000, bugzilla-daemon@kernel.org wrot=
e:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D216529
> >=20
> >=20
> > Hit a panic on ppc64le, by running generic/048 with 1k block size:
>=20
> Hmm, does this reproduce reliably for you?  I test with a 1k block
> size on x86_64 as a proxy 4k block sizes on PPC64, where the blocksize
> < pagesize... and this isn't reproducing for me on x86, and I don't
> have access to a PPC64LE system.

Hi Ted,

Yes, it's reproducible for me, I just reproduced it again on another ppc64le
(P8) machine [1]. But it's not easy to reproduce by running generic/048 (ma=
ybe
there's a better way to reproduce it).

And this time the call trace is a little different, it might be a folio [mm]
related bug? Maybe I should cc linux-mm list to get more checking?

Thanks,
Zorro

[ 1254.857035] run fstests generic/048 at 2022-09-26 12:12:26=20
[ 1257.651002] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 1257.666754] EXT4-fs (sda3): shut down requested (1)=20
[ 1257.666773] Aborting journal on device sda3-8.=20
[ 1257.696046] EXT4-fs (sda3): unmounting filesystem.=20
[ 1259.216580] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 1273.042962] restraintd[2251]: *** Current Time: Mon Sep 26 12:12:45 2022=
=20
Localwatchdog at: Wed Sep 28 11:54:44 2022=20
[ 1333.319238] restraintd[2251]: *** Current Time: Mon Sep 26 12:13:45 2022=
=20
Localwatchdog at: Wed Sep 28 11:54:44 2022=20
[ 1394.828503] restraintd[2251]: *** Current Time: Mon Sep 26 12:14:47 2022=
=20
Localwatchdog at: Wed Sep 28 11:54:44 2022=20
[ 1403.799008] BUG: Kernel NULL pointer dereference at 0x00000062=20
[ 1403.799218] Faulting instruction address: 0xc00000000068edfc=20
[ 1403.799228] Oops: Kernel access of bad area, sig: 11 [#1]=20
[ 1403.799233] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSerie=
s=20
[ 1403.799241] Modules linked in: ext4 mbcache jbd2 bonding tls rfkill sunr=
pc
pseries_rng drm fuse drm_panel_orientation_quirks xfs libcrc32c sd_mod t10_=
pi
sg ibmvscsi ibmveth scsi_transport_srp vmx_crypto=20
[ 1403.799280] CPU: 4 PID: 82 Comm: kswapd0 Kdump: loaded Not tainted 6.0.0=
-rc7
#1=20
[ 1403.799293] NIP:  c00000000068edfc LR: c00000000068f2a8 CTR:
0000000000000000=20
[ 1403.799300] REGS: c00000000a44b560 TRAP: 0380   Not tainted  (6.0.0-rc7)=
=20
[ 1403.799308] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR:
28028244  XER: 00000001=20
[ 1403.799327] CFAR: c00000000068ede4 IRQMASK: 0=20=20
[ 1403.799327] GPR00: c00000000068f2a8 c00000000a44b800 c000000002cf1700
c00c0000001c0bc0=20=20
[ 1403.799327] GPR04: c00000000a44b860 0000000000000002 00000003fb290000
c000000002de7dc8=20=20
[ 1403.799327] GPR08: 0000000ae4f08f42 0000000000000000 c00c0000001c0bc0
0000000000008000=20=20
[ 1403.799327] GPR12: 00000003fb290000 c00000000ffcc080 c000000000194288
c0000003fff9c480=20=20
[ 1403.799327] GPR16: c000000069d30050 0000000000000007 0000000000000000
0000000000000000=20=20
[ 1403.799327] GPR20: 0000000000000001 c00000000a44b8f8 c00000000146bad8
5deadbeef0000100=20=20
[ 1403.799327] GPR24: 5deadbeef0000122 c000000069d30000 c00000000a44bc00
c00000000a44b8e8=20=20
[ 1403.799327] GPR28: c00000000a44b860 c00c0000001c0bc0 0000000000000002
0000000000000002=20=20
[ 1403.799413] NIP [c00000000068edfc] drop_buffers.constprop.0+0x4c/0x1c0=20
[ 1403.799423] LR [c00000000068f2a8] try_to_free_buffers+0x128/0x150=20
[ 1403.799431] Call Trace:=20
[ 1403.799434] [c00000000a44b840] [c00000000a44bc00] 0xc00000000a44bc00=20
[ 1403.799443] [c00000000a44b890] [c0000000004986f8]
filemap_release_folio+0x88/0xb0=20
[ 1403.799452] [c00000000a44b8b0] [c0000000004c51b0]
shrink_active_list+0x490/0x750=20
[ 1403.799462] [c00000000a44b9b0] [c0000000004c9f78] shrink_lruvec+0x3f8/0x=
430=20
[ 1403.799470] [c00000000a44baa0] [c0000000004ca1e4]
shrink_node_memcgs+0x234/0x290=20
[ 1403.799478] [c00000000a44bb10] [c0000000004ca3b4] shrink_node+0x174/0x6b=
0=20
[ 1403.799486] [c00000000a44bbc0] [c0000000004cace0] balance_pgdat+0x3f0/0x=
970=20
[ 1403.799494] [c00000000a44bd20] [c0000000004cb430] kswapd+0x1d0/0x450=20
[ 1403.799501] [c00000000a44bdc0] [c0000000001943c8] kthread+0x148/0x150=20
[ 1403.799510] [c00000000a44be10] [c00000000000cbe4]
ret_from_kernel_thread+0x5c/0x64=20
[ 1403.799520] Instruction dump:=20
[ 1403.799525] fbc1fff0 f821ffc1 7c7d1b78 7c9c2378 ebc30028 7fdff378 480000=
18
60000000=20=20
[ 1403.799540] 60000000 ebff0008 7c3ef840 41820048 <815f0060> e93f0000 5529=
077c
7d295378=20=20
[ 1403.799554] ---[ end trace 0000000000000000 ]---=20
[ 1403.806330]=20=20
[-- MARK -- Mon Sep 26 16:15:00 2022]=20
[ 1415.093395] EXT4-fs (sda3): shut down requested (2)=20
[ 1415.093410] Aborting journal on device sda3-8.=20
[ 1429.107188] EXT4-fs (sda3): unmounting filesystem.=20
[ 1429.926262] EXT4-fs (sda3): recovery complete=20
[ 1429.983938] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 1429.988189] EXT4-fs (sda3): unmounting filesystem.=20
[ 1430.166549] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 1453.015796] restraintd[2251]: *** Current Time: Mon Sep 26 12:15:45 2022=
=20
Localwatchdog at: Wed Sep 28 11:54:44 2022=20
[ 1454.708150] EXT4-fs (sda5): unmounting filesystem.=20
[ 1455.225112] EXT4-fs (sda3): unmounting filesystem.=20
[ 1456.128026] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 1456.139102] EXT4-fs (sda3): unmounting filesystem.=20
[ 1456.396367] EXT4-fs (sda5): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 1462.317449] EXT4-fs (sda3): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20
[ 1462.326680] EXT4-fs (sda3): unmounting filesystem.=20
[ 1462.427320] EXT4-fs (sda5): unmounting filesystem.=20
[ 1463.259690] EXT4-fs (sda5): mounted filesystem with ordered data mode. Q=
uota
mode: none.=20


>=20
> Ritesh, is this something you can take a look at it?  Thanks!
>=20
>                                      - Ted

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
