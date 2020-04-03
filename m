Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3819D5C7
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Apr 2020 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403778AbgDCL0j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Apr 2020 07:26:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38227 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgDCL0i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Apr 2020 07:26:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so7523547qke.5
        for <linux-ext4@vger.kernel.org>; Fri, 03 Apr 2020 04:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/TVP1OakevJWybZ/F/0rcgxXTWBNwwWu838jW2raR2k=;
        b=O5NuPMgfaYhwWbm4sl1lW1mOhQ5tGiJzZ5qokibrxRreWvVzA7Fs5HfyVc3pV05U9q
         n0sOC0g0CNnYqqTHrGePtDisYm39X8xi8+3zYkf2C/A0aQVQVRPmDO7dS/k+3i/0Clr9
         SEP9UHgrEL1cAvtL8SNegC7RvEIUKqkwdZZF+SPiVG7nQzCpbJVZZpir1zWe0tphE2dT
         Fg+c4xhDCPmh5E1pSD9oQ6OhqCt5YjISpauoUgpbBayqEkajw2NOXPxrkFZarthg8B+J
         yf9LlEaGytRltjqSIUYdjQqO4wugE0WrezD319Wc2G5TKDtZDo/XMUNU6Fwi5c9UbObJ
         vOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/TVP1OakevJWybZ/F/0rcgxXTWBNwwWu838jW2raR2k=;
        b=PC/iNgDDrO92W0Tx12+OkeOlY55NFeRWFGba28SFK+3wJ3x8oFFaRt3VN0GOBYQiw+
         0+tEfBMJ44zkqv9akB/nVNdDrZHPk6q4s/a4lHepJJ8FaW61VbWbW+5RQNI6fgtsGn54
         k6f9LF0yONVwv1w63MgMQaXmeCOK/30Vv8mVfpJZo1hvM6tbW35UvWg9zkLYDtM2OscS
         GbqEK/AnL+Cmhox5kCIfh36ETF+Y+HBinlcVndlJXzVh8IdTnLXTpTPQICNPxVV0PnRV
         HEz0DavcCkrhHKPQDMejjqT4qNSp8LG1uQeFQtVtGmnejyAUGNJq+BJ4D7v3INJSM9bD
         o1ZA==
X-Gm-Message-State: AGi0PuZK1wXL010fVTCCqkJ1lwNl70vzH/5iF4QSgywymC9JB8lWy7sh
        Vp0QDODtwXRtLkeD6Hx1VmPf5w==
X-Google-Smtp-Source: APiQypJPpGylI88Z4Re/Fm637VPTh+jSjydoDcq8aVDoc6lbSrw8Uydcs3kjov67vZ9AtAYhc0fEww==
X-Received: by 2002:a37:66d0:: with SMTP id a199mr7873968qkc.239.1585913197425;
        Fri, 03 Apr 2020 04:26:37 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v1sm6213909qtc.30.2020.04.03.04.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 04:26:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: spontaneous crash with "ext4: move ext4 bmap to use iomap
 infrastructure"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <B97A26CF-3511-40D2-82B6-D8BCC7F2DE74@lca.pw>
Date:   Fri, 3 Apr 2020 07:26:35 -0400
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0024FD7B-D28A-4158-B9F8-76FDD6E6CF98@lca.pw>
References: <B97A26CF-3511-40D2-82B6-D8BCC7F2DE74@lca.pw>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Apr 1, 2020, at 8:38 AM, Qian Cai <cai@lca.pw> wrote:
>=20
> It is not always reproducible so far, but it start to show up on =
today=E2=80=99s linux-next. Look
> Trough the commits and noticed this recent one matched the new call =
traces,
>=20
> ac58e4fb03f9 (=E2=80=9Cext4: move ext4 bmap to use iomap =
infrastructure")
>=20
> Thought?

FYI, this starts to become more reproducible that happens again with =
today=E2=80=99s linux-next as well.

[  375.277947][T13110] LTP: starting fallocate04
[  375.892545][T27575] /dev/zero: Can't open blockdev
[  376.899021][T27575] EXT4-fs (loop0): mounting ext3 file system using =
the ext4 subsystem
[  376.905283][T27575] BUG: Unable to handle kernel instruction fetch =
(NULL pointer?)
[  376.905308][T27575] Faulting instruction address: 0x00000000
[  376.905333][T27575] Oops: Kernel access of bad area, sig: 11 [#1]
[  376.905346][T27575] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
[  376.905371][T27575] Modules linked in: ext4 crc16 mbcache jbd2 loop =
kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci tg3 mdio libahci =
libphy libata firmware_class dm_mirror dm_region_hash dm_log dm_mod
[  376.905419][T27575] CPU: 64 PID: 27575 Comm: fallocate04 Tainted: G   =
     W    L    5.6.0-next-20200403+ #347
[  376.905456][T27575] NIP:  0000000000000000 LR: c008000010b90048 CTR: =
0000000000000000
[  376.905479][T27575] REGS: c000200aaeb0f3b0 TRAP: 0400   Tainted: G    =
    W    L     (5.6.0-next-20200403+)
[  376.905513][T27575] MSR:  900000004280b033 =
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 42022228  XER: 20040000
[  376.905545][T27575] CFAR: c008000010bfc494 IRQMASK: 0=20
[  376.905545][T27575] GPR00: c0000000005af3b8 c000200aaeb0f640 =
c00000000165ce00 c000201aa7924ec0=20
[  376.905545][T27575] GPR04: 0000000000000000 0000000000000400 =
0000000000000000 0000000000000000=20
[  376.905545][T27575] GPR08: c000200aaeb0f678 c008000010b90040 =
000000007fffffff c00000000163c580=20
[  376.905545][T27575] GPR12: 0000000000000000 c000201fff7fb380 =
0000000000000000 0000000000000002=20
[  376.905545][T27575] GPR16: 0000000000000002 0000000000040001 =
c000201bd4ee4000 c000201bd4ee4548=20
[  376.905545][T27575] GPR20: c0000000015fbd18 c00000000168c654 =
c000200aaeb0f7a8 c0000000005b7bf0=20
[  376.905545][T27575] GPR24: 0000000000000000 c008000010c065b8 =
c000201aa7924ec0 0000000000000400=20
[  376.905545][T27575] GPR28: c00000000168c3a8 0000000000000000 =
0000000000000000 0000000000000000=20
[  376.905768][T27575] NIP [0000000000000000] 0x0
[  376.905798][T27575] LR [c008000010b90048] ext4_iomap_end+0x8/0x30 =
[ext4]
[  376.905820][T27575] Call Trace:
[  376.905844][T27575] [c000200aaeb0f640] [c0000000005af37c] =
iomap_apply+0x20c/0x920 (unreliable)
[  376.905870][T27575] [c000200aaeb0f780] [c0000000005b7abc] =
iomap_bmap+0xfc/0x160
[  376.905911][T27575] [c000200aaeb0f7e0] [c008000010b92c1c] =
ext4_bmap+0xa4/0x180 [ext4]
[  376.905937][T27575] [c000200aaeb0f820] [c0000000004fa22c] =
bmap+0x4c/0x80
[  376.905962][T27575] [c000200aaeb0f850] [c00800000fcf0acc] =
jbd2_journal_init_inode+0x44/0x1a0 [jbd2]
[  376.906005][T27575] [c000200aaeb0f8f0] [c008000010bec808] =
ext4_load_journal+0x440/0x860 [ext4]
[  376.906059][T27575] [c000200aaeb0f9c0] [c008000010bf2a14] =
ext4_fill_super+0x342c/0x3ab0 [ext4]
[  376.906086][T27575] [c000200aaeb0fb30] [c0000000004ce0ec] =
mount_bdev+0x25c/0x290
[  376.906107][T27575] [c000200aaeb0fbd0] [c008000010be0250] =
ext4_mount+0x28/0x50 [ext4]
[  376.906143][T27575] [c000200aaeb0fbf0] [c0000000005353cc] =
legacy_get_tree+0x4c/0xb0
[  376.906177][T27575] [c000200aaeb0fc20] [c0000000004cb67c] =
vfs_get_tree+0x4c/0x130
[  376.906213][T27575] [c000200aaeb0fc90] [c00000000050d1f8] =
do_mount+0xa18/0xc50
[  376.906257][T27575] [c000200aaeb0fd60] [c00000000050d9d8] =
sys_mount+0x158/0x180
[  376.906307][T27575] [c000200aaeb0fdb0] [c00000000003cc30] =
system_call_exception+0x110/0x1e0
[  376.906334][T27575] [c000200aaeb0fe20] [c00000000000c9f0] =
system_call_common+0xf0/0x278
[  376.906367][T27575] Instruction dump:
[  376.906387][T27575] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX=20
[  376.906434][T27575] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX=20
[  376.906472][T27575] ---[ end trace fa91408cebc70be1 ]---
[  377.389381][T27575]=20
[  378.389480][T27575] Kernel panic - not syncing: Fatal exception
[  379.824028][

>=20
> [  206.744625][T13224] LTP: starting fallocate04
> [  207.601583][T27684] /dev/zero: Can't open blockdev
> [  208.674301][T27684] EXT4-fs (loop0): mounting ext3 file system =
using the ext4 subsystem
> [  208.680347][T27684] BUG: Unable to handle kernel instruction fetch =
(NULL pointer?)
> [  208.680383][T27684] Faulting instruction address: 0x00000000
> [  208.680406][T27684] Oops: Kernel access of bad area, sig: 11 [#1]
> [  208.680439][T27684] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
> [  208.680474][T27684] Modules linked in: ext4 crc16 mbcache jbd2 loop =
kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio tg3 =
libata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [  208.680576][T27684] CPU: 117 PID: 27684 Comm: fallocate04 Tainted: =
G        W         5.6.0-next-20200401+ #288
> [  208.680614][T27684] NIP:  0000000000000000 LR: c0080000102c0048 =
CTR: 0000000000000000
> [  208.680657][T27684] REGS: c000200361def420 TRAP: 0400   Tainted: G  =
      W          (5.6.0-next-20200401+)
> [  208.680700][T27684] MSR:  900000004280b033 =
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 42022228  XER: 20040000
> [  208.680760][T27684] CFAR: c00800001032c494 IRQMASK: 0=20
> [  208.680760][T27684] GPR00: c0000000005ac3f8 c000200361def6b0 =
c00000000165c200 c00020107dae0bd0=20
> [  208.680760][T27684] GPR04: 0000000000000000 0000000000000400 =
0000000000000000 0000000000000000=20
> [  208.680760][T27684] GPR08: c000200361def6e8 c0080000102c0040 =
000000007fffffff c000000001614e80=20
> [  208.680760][T27684] GPR12: 0000000000000000 c000201fff671280 =
0000000000000000 0000000000000002=20
> [  208.680760][T27684] GPR16: 0000000000000002 0000000000040001 =
c00020030f5a1000 c00020030f5a1548=20
> [  208.680760][T27684] GPR20: c0000000015fbad8 c00000000168c654 =
c000200361def818 c0000000005b4c10=20
> [  208.680760][T27684] GPR24: 0000000000000000 c0080000103365b8 =
c00020107dae0bd0 0000000000000400=20
> [  208.680760][T27684] GPR28: c00000000168c3a8 0000000000000000 =
0000000000000000 0000000000000000=20
> [  208.681014][T27684] NIP [0000000000000000] 0x0
> [  208.681065][T27684] LR [c0080000102c0048] ext4_iomap_end+0x8/0x30 =
[ext4]
> [  208.681091][T27684] Call Trace:
> [  208.681129][T27684] [c000200361def6b0] [c0000000005ac3bc] =
iomap_apply+0x20c/0x920 (unreliable)
> iomap_apply at fs/iomap/apply.c:80 (discriminator 4)
> [  208.681173][T27684] [c000200361def7f0] [c0000000005b4adc] =
iomap_bmap+0xfc/0x160
> iomap_bmap at fs/iomap/fiemap.c:142
> [  208.681228][T27684] [c000200361def850] [c0080000102c2c1c] =
ext4_bmap+0xa4/0x180 [ext4]
> ext4_bmap at fs/ext4/inode.c:3213
> [  208.681260][T27684] [c000200361def890] [c0000000004f71fc] =
bmap+0x4c/0x80
> [  208.681281][T27684] [c000200361def8c0] [c00800000fdb0acc] =
jbd2_journal_init_inode+0x44/0x1a0 [jbd2]
> jbd2_journal_init_inode at fs/jbd2/journal.c:1255
> [  208.681326][T27684] [c000200361def960] [c00800001031c808] =
ext4_load_journal+0x440/0x860 [ext4]
> [  208.681371][T27684] [c000200361defa30] [c008000010322a14] =
ext4_fill_super+0x342c/0x3ab0 [ext4]
> [  208.681414][T27684] [c000200361defba0] [c0000000004cb0bc] =
mount_bdev+0x25c/0x290
> [  208.681478][T27684] [c000200361defc40] [c008000010310250] =
ext4_mount+0x28/0x50 [ext4]
> [  208.681520][T27684] [c000200361defc60] [c00000000053242c] =
legacy_get_tree+0x4c/0xb0
> [  208.681556][T27684] [c000200361defc90] [c0000000004c864c] =
vfs_get_tree+0x4c/0x130
> [  208.681593][T27684] [c000200361defd00] [c00000000050a1c8] =
do_mount+0xa18/0xc50
> [  208.681641][T27684] [c000200361defdd0] [c00000000050a9a8] =
sys_mount+0x158/0x180
> [  208.681679][T27684] [c000200361defe20] [c00000000000b3f8] =
system_call+0x5c/0x68
> [  208.681726][T27684] Instruction dump:
> [  208.681747][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX=20
> [  208.681797][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX=20
> [  208.681839][T27684] ---[ end trace 4e9e2bab7f1d4048 ]---
> [  208.802259][T27684]=20
> [  209.802373][T27684] Kernel panic - not syncing: Fatal exception

