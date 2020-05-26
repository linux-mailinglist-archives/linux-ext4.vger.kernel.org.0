Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1456D1E19D1
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 05:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388636AbgEZDWo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 May 2020 23:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbgEZDWm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 May 2020 23:22:42 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CFAC061A0E
        for <linux-ext4@vger.kernel.org>; Mon, 25 May 2020 20:22:42 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l17so9181702ybk.1
        for <linux-ext4@vger.kernel.org>; Mon, 25 May 2020 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=TNViycCI4isfBPnclA8BZ32xOaH0tbATPeRDBvQBL2s=;
        b=JIkyMI+eD83S22X14th4uH341nvorwM7QVfl9WeNj9yn5AIt4EvEaDW5raujbJXs2H
         WZbB/NmnMs06qZWguK+9Cj/7CCMgub2MsA//0UZ01hXAmOMlfFWZAzjXtE80HKzTXkD8
         AZlEH1f1cPwVGY50ikqwq1D11dbZqX3C9WDVjdtrnvTJKD6vJSaytgjiNVpYHLJzxDmC
         5eLaxUKjDxLK1S52vw8Ea/GC2gKmnJHfQIgVjU7VP72EgKU7LEXlkPTXoacelOivPkiW
         t10pWJz+Bc1bIGd/o72Wp8gfeMvd+IL8XsrcikcvupAshsPMe17fFig1XDndRmaqQlWA
         UwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=TNViycCI4isfBPnclA8BZ32xOaH0tbATPeRDBvQBL2s=;
        b=QolG4/t69y9UTDgFs/JcWozkHoepMCRO6e59mirS8Vv7e/f5rcwDfEJLfnnmtjxx11
         UR9r+o2yi0TNncd1FDtH8GhnCLtbz5M7yKGMd+DFLyMytjfZuJG1Sj0UIViHCrCSmwRU
         maXttw08VmS7my5B0JoTPgs1Ujma09iUTjASFFe/hG8hLj0Qpbq/xpMS61yhHTQJrSna
         b67VZRjPQB4JskuF8tibi+DR2iSbh7GAKlHArh3erTIaaGw8C+k+UJPtgvRaJwNEI1KM
         JyDQbfi8OPyvNpiHn3xy9zNv9MjtYUcK+MyxkTKjZ4tVVMlwCRaVMaJBLiblUzKgS+h3
         +UXQ==
X-Gm-Message-State: AOAM532dI/GLF9mBYwwqLJ9l5TTL6y3Y3gnQeR0YMSVbF2I6cN/Ud4lN
        XUOfd/pbeA0whTyjlWD3YhP6axHzmPMR8XsT0keRSXMmza4=
X-Google-Smtp-Source: ABdhPJxi4Dc2HuZRCIbtI6IdymhzB27t57U8q/iqOHgGxMPeGQr53BLXeQkxshc3RsjE6KQQYV7Mp/YizybQngvNd90=
X-Received: by 2002:a25:9986:: with SMTP id p6mr44544412ybo.381.1590463361503;
 Mon, 25 May 2020 20:22:41 -0700 (PDT)
MIME-Version: 1.0
From:   Davis Roman <davis.roman84@gmail.com>
Date:   Mon, 25 May 2020 23:22:30 -0400
Message-ID: <CACfi_Z0WeUL=RhPbEjwRBnVgr_DAQCbqgpfX-fif+A_XrhAspA@mail.gmail.com>
Subject: trying to make sense out of kernel oops generated in ext4 subsystem
 while kernel was experiencing high memory pressure
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I got a kernel oops from what appears to be ext4 while my system was
very low on memory. I compiled my kernel with debug symbols and traced
it down to a BUG_ON statement in  fs/ext4/inode.c but I'm having a
hard time trying to figure it out from there.

Any help or insights would be appreciated,

Thank you,

Davis

internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
Modules linked in: cdc_mbim cdc_wdm cdc_ncm usbnet mii cdc_acm
xt_multiport nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter
ip6_tables iptable_nat nf_nat_ipv4 ipt_MASQUERADE
nf_nat_masquerade_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4
xt_state iptable_filter xt_conntrack nf_conntrack libcrc32c ip_tables
m25p80 gc2145_camera imx_sdma virt_dma ath9k ath9k_common ath9k_hw ath
g_ether usb_f_rndis u_ether libcomposite cryptodev(O) [last unloaded:
at25]
CPU: 0 PID: 33 Comm: kswapd0 Tainted:     4.14.154 #1
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: 8812d140 task.stack: 88af4000
PC is at ext4_writepage+0x564/0x774
LR is at shrink_page_list+0x7e4/0xde0
pc : [<802d7f6c>]    lr : [<801fea9c>]    psr: 000e0013
sp : 88af5ce0  ip : 00000000  fp : 88af5d98
r10: 88af5da8  r9 : 865f2978  r8 : 865f2a54
r7 : 00000000  r6 : 9fedebe0  r5 : 00000001  r4 : 00001000
r3 : 00000000  r2 : 00000125  r1 : 00000000  r0 : 000000ea
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: 147f4059  DAC: 00000051
Process kswapd0 (pid: 33, stack limit =3D 0x88af4210)
Stack: (0x88af5ce0 to 0x88af6000)
5ce0: 86425750 00064ea6 8642574c 801ec094 88e2c268 88e2c268 88e2c200 ffffff=
ff
5d00: 88af5d98 8042ad38 9fedebe0 88e2c200 00000000 80f03d88 865f2a54 9fedeb=
f4
5d20: 9fedebe0 00000000 88af5f34 865f2a54 00000000 88af5e14 88af5d98 801fea=
9c
5d40: 00000001 00000003 00000000 00000006 00000000 00000003 88af4000 000000=
00
5d60: 00000000 0000000f 80f821c0 00000000 00000000 88af5e1c 80fe9f8c 000000=
00
5d80: 00000000 80e59d74 88af5d40 00000001 00000003 0001ddac 9ff0e574 9ff14f=
f4
5da0: 9ff08234 9ff0e554 00000020 00000000 00000000 00000000 ffffffff 7fffff=
ff
5dc0: 00000000 00000008 00000000 80f03d88 80e5dccd 80f82e44 88af5f34 000000=
08
5de0: 00000020 80f82e40 00000000 80f821c0 00000002 801ff7e0 88af5e1c 000000=
00
5e00: 00000002 80f821c0 00000000 80f821c4 00000020 9ff082d4 9fc41c74 000000=
00
5e20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 80f03d=
88
5e40: 0000173d 00000002 00000152 00000037 88af5ec4 00000020 00000000 80f82e=
44
5e60: 88af5f34 80200178 88af5ecc 80f821c0 80f03ac0 0000171e 00000000 000002=
65
5e80: ffffffff ffffffff 51eb851f 80f82e44 000000ee 00000000 88af5f30 88af40=
00
5ea0: 00000001 88af5ea4 88af5ea4 88af5eac 88af5eac 88af5eb4 88af5eb4 000000=
00
5ec0: 00000000 00000152 00000295 0000027b 00000000 00000000 00000252 000003=
75
5ee0: 0000027b 80f03d88 00000000 00000000 00000000 000000ee 00000001 80f82e=
44
5f00: 00000000 80f821c0 80feb5a0 80200f78 80fe1d40 88af4000 88af5f10 801676=
94
5f20: ffffe000 80e59da0 80e59d9c 8812d140 00000000 00000265 014000c0 000000=
00
5f40: 00000000 00000000 00000002 00000000 00000007 000001b8 000000ee 80f03d=
88
5f60: ffffe000 88282e00 88282d40 00000000 88af4000 80f821c0 80200c54 88282e=
1c
5f80: 8803de74 8014da78 88af4000 88282d40 8014d954 00000000 00000000 000000=
00
5fa0: 00000000 00000000 00000000 80108928 00000000 00000000 00000000 000000=
00
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 000000=
00
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 000000=
00
[<802d7f6c>] (ext4_writepage) from [<801fea9c>] (shrink_page_list+0x7e4/0xd=
e0)
[<801fea9c>] (shrink_page_list) from [<801ff7e0>]
(shrink_inactive_list+0x1c4/0x3dc)
[<801ff7e0>] (shrink_inactive_list) from [<80200178>] (shrink_node+0x44c/0x=
8b0)
[<80200178>] (shrink_node) from [<80200f78>] (kswapd+0x324/0x668)
[<80200f78>] (kswapd) from [<8014da78>] (kthread+0x124/0x154)
[<8014da78>] (kthread) from [<80108928>] (ret_from_fork+0x14/0x2c)
Code: e519305c e3130b02 0afffefc eaffffc6 (e7f001f2)
---[ end trace 74cf38da7549a08d ]---
Kernel panic - not syncing: Fatal exception





$ arm-poky-linux-gnueabi-addr2line -fe vmlinux 802d7f6c

__ext4_journalled_writepage
/home/davis/linux-rezi/fs/ext4/inode.c:2026

$ bat -r 2019:2029 /home/davis/linux-rezi/fs/ext4/inode.c

2019   =E2=94=82     handle =3D ext4_journal_start(inode, EXT4_HT_WRITE_PAG=
E,
2020   =E2=94=82                     ext4_writepage_trans_blocks(inode));
2021   =E2=94=82     if (IS_ERR(handle)) {
2022   =E2=94=82         ret =3D PTR_ERR(handle);
2023   =E2=94=82         put_page(page);
2024   =E2=94=82         goto out_no_pagelock;
2025   =E2=94=82     }
2026   =E2=94=82     BUG_ON(!ext4_handle_valid(handle));   <~~~
2027   =E2=94=82
2028   =E2=94=82     lock_page(page);
2029   =E2=94=82     put_page(page);

davis@Precision-7920:~/linux-rezi$ ./scripts/decodecode < /tmp/oops.txt
Code: e519305c e3130b02 0afffefc eaffffc6 (e7f001f2)
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 5c                    pop    %rsp
   1: 30 19                xor    %bl,(%rcx)
   3: e5 02                in     $0x2,%eax
   5: 0b 13                or     (%rbx),%edx
   7: e3 fc                jrcxz  0x5
   9: fe                    (bad)
   a: ff 0a                decl   (%rdx)
   c: c6                    (bad)
   d: ff                    (bad)
   e: ff                    (bad)
   f: ea                    (bad)
  10:* f2 01 f0              repnz add %esi,%eax <-- trapping instruction
  13: e7                    .byte 0xe7

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: f2 01 f0              repnz add %esi,%eax
   3: e7                    .byte 0xe7
