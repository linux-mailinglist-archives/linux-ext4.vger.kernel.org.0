Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39667443645
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Nov 2021 20:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKBTLA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Nov 2021 15:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhKBTKz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 2 Nov 2021 15:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CF10960F02
        for <linux-ext4@vger.kernel.org>; Tue,  2 Nov 2021 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635880099;
        bh=PZhGCgTeV/ORCw/ACJW5Vnon9m14il1TUKJTOAMtEYI=;
        h=From:To:Subject:Date:From;
        b=LCYBnPNNWprAtkrMFTqBu6Z0QT8uLbOEEuSaWr48FZ9q+ySlNYltRRP/INjCete3s
         5lB7629/rTwK3CTuSq/deG6B/J14W/7A4P4Uw3zOkaTrHDNFO9Ua73FXZKtzSoNX8P
         iF49mnnh6ENQ9Qabw+EziVXp/g0ENPshLTP4nbXuaRiMXZzoZ1pPMwDWqm7ytVP92c
         lETGnQA8F0gUcJ5qpv/guT5qOvpyKcbM9yGdQyMvodA9kgD1s6fJMAzllvp9fkpRXj
         uSWJ9Jw4aA5rEfXbmev/mh+MwEqyUpE0koUxLE7rINJzdiRPlPN+lHiiFy2hX5gvDZ
         Tq2LfczfsIoFA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id C453B60FC1; Tue,  2 Nov 2021 19:08:19 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214917] New: 5.15: kernel BUG at fs/ext4/inode.c:1721!
Date:   Tue, 02 Nov 2021 19:08:19 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gerbilsoft@gerbilsoft.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214917-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214917

            Bug ID: 214917
           Summary: 5.15: kernel BUG at fs/ext4/inode.c:1721!
           Product: File System
           Version: 2.5
    Kernel Version: 5.15.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: gerbilsoft@gerbilsoft.com
        Regression: No

Since upgrading from 5.14.12 to 5.15, I've been getting a number of kernel =
BUGs
at fs/ext4/inode.c:1721!. I'm using inline_data on my ext4 file systems, and
this code path seems to be hit most often when using Google Chrome.

The BUG_ON() being hit was introduced by this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D948ca5f30e1df0c11eb5b0f410b9ceb97fa77ad9

[  131.934142] ------------[ cut here ]------------
[  131.934148] kernel BUG at fs/ext4/inode.c:1721!
[  131.934155] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[  131.934162] CPU: 2 PID: 6307 Comm: ThreadPoolForeg Tainted: G           =
O=20=20=20
T 5.15.0-DEK-X230 #1
[  131.934167] Hardware name: LENOVO 2320HQU/2320HQU, BIOS G2ETB7WW (2.77 )
09/24/2019
[  131.934170] RIP: 0010:ext4_da_get_block_prep+0x422/0x460
[  131.934178] Code: ff f0 80 4b 01 01 e9 21 ff ff ff f0 80 0b 20 e9 0c ff =
ff
ff f0 80 0b 10 e9 de fe ff ff e8 36 89 fe ff 41 89 c4 e9 23 fe ff ff <0f> 0=
b 0f
0b 48 8b 7d 10 50 45 89 e1 48 c7 c1 30 10 d3 98 4c 8b 85
[  131.934182] RSP: 0018:ffffa9058ffafbb8 EFLAGS: 00010206
[  131.934185] RAX: 27ffffffffffffff RBX: ffffa0b6d40d3c98 RCX:
0000000000000000
[  131.934188] RDX: 0000000000000004 RSI: 0000000000000000 RDI:
0000000000000000
[  131.934191] RBP: ffffa0b6535fab00 R08: 0000000000000000 R09:
0000000000000000
[  131.934194] R10: 0000000000000000 R11: 0000000000001000 R12:
ffffa9058ffafc80
[  131.934197] R13: 0000000000000001 R14: ffffffffffff0000 R15:
ffffd265c7add0c0
[  131.934200] FS:  00007efc4ff3a640(0000) GS:ffffa0b8ce280000(0000)
knlGS:0000000000000000
[  131.934204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  131.934207] CR2: 0000156a01674000 CR3: 000000016da9e003 CR4:
00000000001706e0
[  131.934210] Call Trace:
[  131.934215]  __block_write_begin_int+0x14e/0x590
[  131.934223]  ? ext4_da_release_space+0x100/0x100
[  131.934228]  ext4_da_write_begin+0x11d/0x2c0
[  131.934232]  ? generic_write_end+0xe3/0x150
[  131.934237]  generic_perform_write+0xc4/0x220
[  131.934258]  ext4_buffered_write_iter+0xa2/0x180
[  131.934266]  new_sync_write+0x156/0x200
[  131.934273]  vfs_write+0x216/0x2b0
[  131.934278]  __x64_sys_pwrite64+0x94/0xc0
[  131.934284]  do_syscall_64+0x66/0xa0
[  131.934291]  ? do_syscall_64+0xe/0xa0
[  131.934295]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  131.934300] RIP: 0033:0x7efc57997217
[  131.934305] Code: 08 89 3c 24 48 89 4c 24 18 e8 05 bc f8 ff 4c 8b 54 24 =
18
41 89 c0 48 8b 54 24 10 b8 12 00 00 00 48 8b 74 24 08 8b 3c 24 0f 05 <48> 3=
d 00
f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 35 bc f8 ff 48 8b
[  131.934309] RSP: 002b:00007efc4ff38ff0 EFLAGS: 00000293 ORIG_RAX:
0000000000000012
[  131.934315] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007efc57997217
[  131.934318] RDX: 0000000000001b20 RSI: 000026fc07ab5c00 RDI:
000000000000012e
[  131.934321] RBP: 00007efc4ff39100 R08: 0000000000000000 R09:
0000000000000000
[  131.934324] R10: 000000000000006f R11: 0000000000000293 R12:
0000000000001b20
[  131.934327] R13: 000000000000006f R14: 000026fc07ab5c00 R15:
000026fc0e84dac0
[  131.934332] Modules linked in: fuse snd_seq_dummy snd_hrtimer snd_seq
snd_seq_device bnep bluetooth ecdh_generic ecc lz4 lz4_compress zram zsmall=
oc
squashfs lz4_decompress algif_skcipher vhost_net tun vhost vhost_iotlb tap
vboxnetadp(O) vboxnetflt(O) vboxdrv(O) vhba(O) drivetemp iwlmvm
snd_hda_codec_hdmi mac80211 x86_pkg_temp_thermal coretemp libarc4 snd_ctl_l=
ed
kvm_intel iwlwifi snd_hda_codec_realtek at24 sdhci_pci kvm regmap_i2c uvcvi=
deo
cqhci snd_hda_codec_generic cfg80211 irqbypass joydev videobuf2_vmalloc
ghash_clmulni_intel videobuf2_memops videobuf2_v4l2 sdhci i2c_i801
snd_hda_intel i2c_smbus videobuf2_common snd_intel_dspcfg lpc_ich mousedev
snd_hda_codec mmc_core videodev snd_hwdep snd_hda_core mc snd_pcm e1000e
snd_timer thinkpad_acpi tpm_tis ledtrig_audio platform_profile tpm_tis_core=
 snd
tpm soundcore
[  131.934455] ---[ end trace 07f79dcd9bd2996e ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
