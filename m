Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5037C8097
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Oct 2023 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjJMIsK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Oct 2023 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjJMIsI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Oct 2023 04:48:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76586D8
        for <linux-ext4@vger.kernel.org>; Fri, 13 Oct 2023 01:48:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E77DBC433CA
        for <linux-ext4@vger.kernel.org>; Fri, 13 Oct 2023 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697186881;
        bh=PbOKrTO1O4Gk/N78ylUJsKt9p2TSSz7iE8nx1iKva6g=;
        h=From:To:Subject:Date:From;
        b=NHjAocsqjRxi5x8YSyMa7EQjaIfuAhJDNko1aA6gW25muYlcLsq5+LCPxjxnUhyTf
         aKzv87HGPqtDP9fdQFQDfh12caqAyJY3ZY+83+N6dC8hUbXCBTNRQz+2f5RuZfTdSZ
         PQHUVv1ljNKahzYC5Yb79fLDAulWOZiUTPpXSGJzQH1b7x/4O0sS1K6sw5+F+TDZYJ
         pE1n0hnEn676g2jnFpRReibEhbaE5s1vv38oLpdLshLkkDLDIQWj4jGczFmJPZBHXB
         hgSne3o8p4c4pdo8unixNRzhmWPWK0Uixf7wv8FIkaT1HB/u/+DESzzAiQEGkTxCyo
         IW8l07pR4Jd4g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CFB75C53BD0; Fri, 13 Oct 2023 08:48:01 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218006] New: [ext4] system panic when ext4_writepages:2918:
 Journal has aborted
Date:   Fri, 13 Oct 2023 08:48:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: fengchunguo@126.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218006-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218006

            Bug ID: 218006
           Summary: [ext4] system panic when ext4_writepages:2918: Journal
                    has aborted
           Product: File System
           Version: 2.5
          Hardware: ARM
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: fengchunguo@126.com
        Regression: No

Hi All,

This is the lowest probability issue. how to debug this issue now?
mmcblk0p44 was as userdata
mmcblk0p22 was located all logs.

console:/ $ [60086.159230] EXT4-fs error (device mmcblk0p22):
ext4_journal_check_start:61: Detected aborted journal
[2023-10-13 02:51:08]  [60086.171309] EXT4-fs (mmcblk0p22): Remounting
filesystem read-only
[2023-10-13 02:51:08]  [60086.185218] EXT4-fs (mmcblk0p22): ext4_writepages:
jbd2_start: 10240 pages, ino 16; err -30
[2023-10-13 02:51:08]  [60086.731357] EXT4-fs error (device mmcblk0p44) in
ext4_da_write_end:3210: IO failure
[2023-10-13 02:51:09]  [60086.739386] EXT4-fs (mmcblk0p44): Delayed block
allocation failed for inode 155757 at logical offset 438 with max blocks 25
with error 30
[2023-10-13 02:51:09]  [60086.739388] EXT4-fs (mmcblk0p44): This should not
happen!! Data will be lost
[2023-10-13 02:51:09]  [60086.739388]
[2023-10-13 02:51:09]  [60086.739399] EXT4-fs error (device mmcblk0p44) in
ext4_writepages:2918: Journal has aborted
[2023-10-13 02:51:09]  [60086.920057] EXT4-fs error (device mmcblk0p44):
ext4_journal_check_start:61: Detected aborted journal
[2023-10-13 02:51:09]  [60086.931781] EXT4-fs (mmcblk0p44): Remounting
filesystem read-only
[2023-10-13 02:51:09]  [60086.943848] EXT4-fs
[60086.943848] EXT4-fs (mmcblk0p44): ext4_writepages: jbd2_start: 1024 page=
s,
ino 24635; err -30
[2023-10-13 02:51:09]  [60089.823354] Kernel panic - not syncing: Attempted=
 to
kill init! exitcode=3D0x00000007
[2023-10-13 02:51:12]  [60089.823354]
[2023-10-13 02:51:12]  [60089.832522] CPU: 0 PID: 1 Comm: init Tainted: G=
=20=20=20=20=20=20
    O    4.14.61-00012-g23e8b99bce8b-dirty #136
[2023-10-13 02:51:12]  [60089.841754] Hardware name: X9 REF Board (DT)
[2023-10-13 02:51:12]  [60089.847510] Call trace:
[2023-10-13 02:51:12]  [60089.849983] [<ffff00000808a3cc>]
dump_backtrace+0x0/0x3c0
[2023-10-13 02:51:12]  [60089.855400] [<ffff00000808a7a0>] show_stack+0x14/=
0x1c
[2023-10-13 02:51:12]  [60089.859789] snd_afe_dai_trigger:1085 --
cmd(0)stream(0)name(subdevice #0),cpu_dai name 30600000.i2s
[2023-10-13 02:51:12]  [60089.861223] snd_afe_dai_trigger:1113 -----i2s
stop----------
console:/ $ [60086.159230] EXT4-fs error (device mmcblk0p22):
ext4_journal_check_start:61: Detected aborted journal
[2023-10-13 02:51:08]  [60086.171309] EXT4-fs (mmcblk0p22): Remounting
filesystem read-only
[2023-10-13 02:51:08]  [60086.185218] EXT4-fs (mmcblk0p22): ext4_writepages:
jbd2_start: 10240 pages, ino 16; err -30
[2023-10-13 02:51:08]  [60086.731357] EXT4-fs error (device mmcblk0p44) in
ext4_da_write_end:3210: IO failure
[2023-10-13 02:51:09]  [60086.739386] EXT4-fs (mmcblk0p44): Delayed block
allocation failed for inode 155757 at logical offset 438 with max blocks 25
with error 30
[2023-10-13 02:51:09]  [60086.739388] EXT4-fs (mmcblk0p44): This should not
happen!! Data will be lost
[2023-10-13 02:51:09]  [60086.739388]
[2023-10-13 02:51:09]  [60086.739399] EXT4-fs error (device mmcblk0p44) in
ext4_writepages:2918: Journal has aborted
[2023-10-13 02:51:09]  [60086.920057] EXT4-fs error (device mmcblk0p44):
ext4_journal_check_start:61: Detected aborted journal
[2023-10-13 02:51:09]  [60086.931781] EXT4-fs (mmcblk0p44): Remounting
filesystem read-only
[2023-10-13 02:51:09]  [60086.943848] EXT4-fs
[60086.943848] EXT4-fs (mmcblk0p44): ext4_writepages: jbd2_start: 1024 page=
s,
ino 24635; err -30
[2023-10-13 02:51:09]  [60089.823354] Kernel panic - not syncing: Attempted=
 to
kill init! exitcode=3D0x00000007
[2023-10-13 02:51:12]  [60089.823354]
[2023-10-13 02:51:12]  [60089.832522] CPU: 0 PID: 1 Comm: init Tainted: G=
=20=20=20=20=20=20
    O    4.14.61-00012-g23e8b99bce8b-dirty #136
[2023-10-13 02:51:12]  [60089.841754] Hardware name: Semidrive kunlun x9 REF
Board (DT)
[2023-10-13 02:51:12]  [60089.847510] Call trace:
[2023-10-13 02:51:12]  [60089.849983] [<ffff00000808a3cc>]
dump_backtrace+0x0/0x3c0
[2023-10-13 02:51:12]  [60089.855400] [<ffff00000808a7a0>] show_stack+0x14/=
0x1c
[2023-10-13 02:51:12]  [60089.920459] Exception stack(0xffff00000a293ec0 to
0xffff00000a294000)
[2023-10-13 02:51:12]  [60089.926920] 3ec0: 0000000000000007 0000aaaae2d753=
58
0000000000000028 0000000000000180
[2023-10-13 02:51:12]  [60089.934768] 3ee0: 0000aaaae2d76067 0000ffff868b05=
08
00000000706d742e 00000000706d742e
[2023-10-13 02:51:12]  [60089.942603] 3f00: 0000ffffe744a8c0 00000000000000=
18
0000000000000000 0000ffffe744a850
[2023-10-13 02:51:12]  [60089.950434] 3f20: 0000ffffe744a7d0 0000ffffe744a8=
08
0000000000000001 0000000000008000
[2023-10-13 02:51:12]  [60089.958264] 3f40: 0000ffff87976818 0000ffff8795b8=
2c
0000ffff88056000 0000ffffe744aaa0
[2023-10-13 02:51:12]  [60089.966094] 3f60: 0000ffff8917c188 00000000000000=
01
0000ffffe744a8d8 0000ffffe744a8d0
[2023-10-13 02:51:12]  [60089.973924] 3f80: 000000000000001e 0000aaaae2e113=
88
0000aaaae2e111d8 0000aaaae2e111b0
[2023-10-13 02:51:12]  [60089.981753] 3fa0: 0000aaaae2e11200 0000ffffe744a8=
40
0000ffff8906363c 0000ffffe74495f0
[2023-10-13 02:51:12]  [60089.989583] 3fc0: 0000aaaae2dcebe0 00000000200000=
00
00000000ffffff9c 00000000ffffffff
[2023-10-13 02:51:12]  [60089.997413] 3fe0: 0000000000000000 00000000000000=
00
0000000000000000 0000000000000000
[2023-10-13 02:51:12]  [60090.005244] [<ffff000008083964>]
work_pending+0x8/0x10
[2023-10-13 02:51:12]  [60090.010388] SMP: stopping secondary CPUs
[2023-10-13 02:51:12]  [60090.014314] SMP: stopping secondary CPUs
[2023-10-13 02:51:12]  [60091.018237] SMP: failed to stop secondary CPUs 0-3
[2023-10-13 02:51:30]  [60107.853608] Kernel Offset: disabled
[2023-10-13 02:51:30]  [60107.857098] CPU features: 0x0802210
[2023-10-13 02:51:30]  [60107.860585] Memory Limit: none
[2023-10-13 02:51:30]  [60107.866736] flush all cache
[2023-10-13 02:51:30]  [60107.869595] flush all cache done
[2023-10-13 02:51:30]  [60107.872829] ---[ end Kernel panic - not syncing:
Attempted to kill init! exitcode=3D0x00000007
[2023-10-13 02:51:30]  [60107.872829]
[2023-10-13 02:51:30]  [60107.884731] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:30]  [60107.891134] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:30]  [60107.897530] mmcblk0: error -110 sending status
command, aborting
[2023-10-13 02:51:30]  [60107.904353] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:30]  [60107.913487] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:30]  [60107.919932] mmc0: sdhci: Sys addr:  0x00000040 |
Version:  0x00000005
[2023-10-13 02:51:30]  [60107.926381] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:30]  [60107.932831] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:30]  [60107.939271] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:30]  [60107.945711] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:30]  [60107.952150] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:30]  [60107.958590] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:30]  [60107.965029] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:30]  [60107.971468] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:30]  [60107.977908] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:30]  [60107.984353] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:30]  [60107.990792] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:30]  [60107.997231] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:30]  [60108.003670] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:30]  [60108.008113] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:30]  [60108.015247] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:30]  [60108.021736] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:30]  [60108.028121] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:30]  [60108.037254] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:30]  [60108.043699] mmc0: sdhci: Sys addr:  0x00000040 |
Version:  0x00000005
[2023-10-13 02:51:30]  [60108.050147] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:30]  [60108.056597] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:30]  [60108.063037] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:30]  [60108.069478] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:30]  [60108.075917] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:30]  [60108.082357] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:30]  [60108.088796] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:30]  [60108.095236] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:30]  [60108.101676] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:30]  [60108.108120] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:30]  [60108.114560] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:30]  [60108.120999] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:30]  [60108.127438] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:30]  [60108.131881] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:30]  [60108.139014] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:30]  [60108.145494] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:30]  [60108.151880] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:30]  [60108.161013] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:30]  [60108.167458] mmc0: sdhci: Sys addr:  0x00000040 |
Version:  0x00000005
[2023-10-13 02:51:30]  [60108.173908] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:30]  [60108.180356] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:30]  [60108.186796] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:30]  [60108.193236] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:30]  [60108.199675] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:30]  [60108.206114] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:30]  [60108.212554] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:30]  [60108.218994] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:30]  [60108.225433] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:30]  [60108.231877] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:30]  [60108.238317] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:30]  [60108.244756] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:30]  [60108.251195] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:30]  [60108.255638] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60108.262771] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.269251] mmcblk0: error -110 sending status
command, aborting
[2023-10-13 02:51:31]  [60108.276055] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:31]  [60108.285187] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.291631] mmc0: sdhci: Sys addr:  0x00000008 |
Version:  0x00000005
[2023-10-13 02:51:31]  [60108.298080] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:31]  [60108.304529] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:31]  [60108.310968] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:31]  [60108.317407] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:31]  [60108.323847] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:31]  [60108.330287] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:31]  [60108.336726] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:31]  [60108.343166] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:31]  [60108.349606] mmc0: sdhci: Caps:
[60108.349606] mmc0: sdhci: Caps:      0x3d6dc881 | Caps_1:   0x08008077
[2023-10-13 02:51:31]  [60108.356050] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:31]  [60108.362490] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:31]  [60108.368930] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:31]  [60108.375369] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:31]  [60108.379812] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60108.386945] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.393418] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:31]  [60108.399807] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:31]  [60108.408941] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.415385] mmc0: sdhci: Sys addr:  0x00000008 |
Version:  0x00000005
[2023-10-13 02:51:31]  [60108.421834] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:31]  [60108.428282] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:31]  [60108.434722] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:31]  [60108.441162] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:31]  [60108.447600] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:31]  [60108.454040] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:31]  [60108.460479] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:31]  [60108.466919] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:31]  [60108.473358] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:31]  [60108.479802] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:31]  [60108.486242] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:31]  [60108.492682] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:31]  [60108.499121] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:31]  [60108.503564] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60108.510698] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.517175] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:31]  [60108.523607] mmcblk0: error -110 sending status
command, aborting
[2023-10-13 02:51:31]  [60108.530402] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:31]  [60108.539535] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.545979] mmc0: sdhci: Sys addr:  0x00000008 |
Version:  0x00000005
[2023-10-13 02:51:31]  [60108.552427] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:31]  [60108.558876] mmc0:
[60108.558876] mmc0: sdhci: Argument:  0x00010000 | Trn mode: 0x00000032
[2023-10-13 02:51:31]  [60108.565316] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:31]  [60108.571756] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:31]  [60108.578196] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:31]  [60108.584636] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:31]  [60108.591075] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:31]  [60108.597515] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:31]  [60108.603955] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:31]  [60108.610399] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:31]  [60108.616839] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:31]  [60108.623278] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:31]  [60108.629717] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:31]  [60108.634160] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60108.641293] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.647786] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:31]  [60108.654253] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:31]  [60108.663387] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.669831] mmc0: sdhci: Sys addr:  0x00000008 |
Version:  0x00000005
[2023-10-13 02:51:31]  [60108.676280] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:31]  [60108.682729] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:31]  [60108.689169] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:31]  [60108.695608] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:31]  [60108.702048] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:31]  [60108.708488] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:31]  [60108.714928] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:31]  [60108.721367] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:31]  [60108.727807] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:31]  [60108.734251] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:31]  [60108.740691] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:31]  [60108.747131] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:31]  [60108.753570] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:31]  [60108.758013] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60108.765146] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.771628] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:31]  [60108.778023] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:31]  [60108.787155] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.793599] mmc0: sdhci: Sys addr:  0x00000008 |
Version:  0x00000005
[2023-10-13 02:51:31]  [60108.800049] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:31]  [60108.806499] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:31]  [60108.812939] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:31]  [60108.819378] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:31]  [60108.825818] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:31]  [60108.832258] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:31]  [60108.838698] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:31]  [60108.845137] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:31]  [60108.851577] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:31]  [60108.858021] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:31]  [60108.864460] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:31]  [60108.870900] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:31]  [60108.877339] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:31]  [60108.881782] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60108.888915] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.895396] mmcblk0: error -110 sending status
command, aborting
[2023-10-13 02:51:31]  [60108.902196] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:31]  [60108.911330] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60108.917774] mmc0: sdhci: Sys addr:  0x00000008 |
Version:  0x00000005
[2023-10-13 02:51:31]  [60108.924224] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:31]  [60108.930674] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:31]  [60108.937113] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:31]  [60108.943553] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:31]  [60108.949992] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:31]  [60108.956432] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:31]  [60108.962871] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:31]  [60108.969311] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:31]  [60108.975751] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:31]  [60108.982195] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:31]  [60108.988635] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:31]  [60108.995074] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:31]  [60109.001513] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:31]  [60109.005956] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60109.013089] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60109.019575] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:31]  [60109.025960] mmc0: Got command interrupt 0x00000001
even though no command operation was in progress.
[2023-10-13 02:51:31]  [60109.035093] mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D SDHCI REGISTER
DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60109.041538] mmc0: sdhci: Sys addr:  0x00000008 |
Version:  0x00000005
[2023-10-13 02:51:31]  [60109.047986] mmc0: sdhci: Blk size:  0x00007200 | =
Blk
cnt:  0x00000000
[2023-10-13 02:51:31]  [60109.054435] mmc0: sdhci: Argument:  0x00010000 | =
Trn
mode: 0x00000032
[2023-10-13 02:51:31]  [60109.060875] mmc0: sdhci: Present:   0x03f700f0 | =
Host
ctl: 0x00000001
[2023-10-13 02:51:31]  [60109.067315] mmc0: sdhci: Power:     0x00000001 | =
Blk
gap:  0x00000000
[2023-10-13 02:51:31]  [60109.073753] mmc0: sdhci: Wake-up:   0x00000000 |
Clock:    0x0000000f
[2023-10-13 02:51:31]  [60109.080194] mmc0: sdhci: Timeout:   0x00000005 | =
Int
stat: 0x00000000
[2023-10-13 02:51:31]  [60109.086633] mmc0: sdhci: Int enab:  0x01ff1033 | =
Sig
enab: 0x01ff1033
[2023-10-13 02:51:31]  [60109.093072] mmc0: sdhci: ACmd stat: 0x00000000 | =
Slot
int: 0x00000000
[2023-10-13 02:51:31]  [60109.099512] mmc0: sdhci: Caps:      0x3d6dc881 |
Caps_1:   0x08008077
[2023-10-13 02:51:31]  [60109.105955] mmc0: sdhci: Cmd:       0x00000d1a | =
Max
curr: 0x00000000
[2023-10-13 02:51:31]  [60109.112394] mmc0: sdhci: Resp[0]:   0x40ff8080 |
Resp[1]:  0x00000000
[2023-10-13 02:51:31]  [60109.118834] mmc0: sdhci: Resp[2]:   0x00000000 |
Resp[3]:  0x00000000
[2023-10-13 02:51:31]  [60109.125274] mmc0: sdhci: Host ctl2: 0x00001808
[2023-10-13 02:51:31]  [60109.129716] mmc0: sdhci: ADMA Err:  0x00000000 | =
ADMA
Ptr: 0x0000000000000000
[2023-10-13 02:51:31]  [60109.136849] mmc0: sdhci:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[2023-10-13 02:51:31]  [60109.143355] mmcblk0: error -110 sending status
command, retrying
[2023-10-13 02:51:31]  [60109.149802] mmcblk0: error -110 sending status
command, aborting

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
