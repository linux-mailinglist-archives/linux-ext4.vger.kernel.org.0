Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE9116E23
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Dec 2019 14:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfLINql (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Dec 2019 08:46:41 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37274 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfLINql (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Dec 2019 08:46:41 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so15577839qtk.4
        for <linux-ext4@vger.kernel.org>; Mon, 09 Dec 2019 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rKY8nQ/36ZYIRL43SesLbBNstgqfPCGGmMTonTZ2il8=;
        b=hhCalqlm3yqxnVlbPMkN+bqjjPU1bLUwUu3cuuoLZLdYXudklunO0/Cy7XlY6y/hiO
         x4IgOw3ukPGPAyzgTOcs+D4SDsU4GHbqhhhPNtM/mnp1IGFP9VncVld5dJRpCCuvKXEO
         cCSQmfPxl0a6iker/1a+SnLv1Ke4zYEK4dOfZk0cPOldAgFySxnl62XwrgGhpo7d1DSI
         jNzpeaL9Nf/LdrrfoDm1iM3jrZYyniYmCF+HfzAFDILzUtqo+HYu5O7O8l4V/9HtJKAA
         65iHaf1v9+OA4h0TqaOwmx9K3TZdEN/riUkRfFD3fP0Q9CJnS0V4D40WXdHslPUASTU7
         PlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rKY8nQ/36ZYIRL43SesLbBNstgqfPCGGmMTonTZ2il8=;
        b=JHC6Ykdce9XoLnOExft2UgnqhlLXJYj7rsO6WxSKNpP8wNrRaxbGMwjTjbgFraRxCG
         /FKVHL0xr85kOaTR0iiHq7+XCFZ9BvSJyZ9j2GhLXRLasyBmo+q3ydEEgfrd6Dp/H4wY
         gmV0YCoxx4Mbv/t6aKz7cDxWLDqCS9295Vgac+AYy+rEox0VJXmoQ9MVm/bg5gOQflYy
         cdSeuQTIm1XsFkOcYQ5v7aGU2gG3MkTp+QYMGlk4EFqrtFHgZZw74XjcsaeukhSqKUJM
         KAmNJJ9NLaL1QW6GRemPzg4CtjMB3pcdYzmlwVlcP05wQmIvximv4dOOPGe+GDP24IoY
         MqNA==
X-Gm-Message-State: APjAAAUeyCsqvI3ZqKZ8Z4uk7yqHxosv8x2jb+XKjIwtB7TpE56BBUlv
        EZ8OQUnJxd98Sb8SzV4jRaejHAyXFK1V1Qrr02EEUQ==
X-Google-Smtp-Source: APXvYqwOoj3Iq7H9MPlRC6Alm7SDeJtbsGl5BNZVmlYeK7ddFNdnLC8TuI2UoS45aEwChxo5375NC80kUhkvzKtCHnw=
X-Received: by 2002:ac8:2489:: with SMTP id s9mr25022912qts.257.1575899199309;
 Mon, 09 Dec 2019 05:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20171219215906.GA12465@gmail.com> <20191209132914.907306-1-rafaeldtinoco@ubuntu.com>
In-Reply-To: <20191209132914.907306-1-rafaeldtinoco@ubuntu.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Dec 2019 14:46:27 +0100
Message-ID: <CACT4Y+YtpOZ1c0QV4-q_b-CrGMGRALwoFTNPgxZuUC9S9J3gfA@mail.gmail.com>
Subject: Re: ppc64el kernel access of bad area (ext4_htree_store_dirent->rb_insert_color)
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        syzbot 
        <bot+eb13811afcefe99cfe45081054e7883f569f949d@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 9, 2019 at 2:29 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> It looks like the same stacktrace that was reported in this thread. This =
has
> been reported to ppc64el AND we got a reproducer (ocfs2-tools autopkgtest=
s).
>
> [ 85.605850] Faulting instruction address: 0xc000000000e81168
> [ 85.605901] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 85.605970] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSerie=
s
> [ 85.606029] Modules linked in: ocfs2 quota_tree ocfs2_dlmfs ocfs2_stack_=
o2cb ocfs2_dlm ocfs2_nodemanager ocfs2_stackglue iptable_mangle xt_TCPMSS x=
t_tcpudp bpfilter dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua vmx_cr=
ypto crct10dif_vpmsum sch_fq_codel ip_tables x_tables autofs4 btrfs xor zst=
d_compress raid6_pq libcrc32c crc32c_vpmsum virtio_net virtio_blk net_failo=
ver failover
> [ 85.606291] CPU: 0 PID: 1 Comm: systemd Not tainted 5.3.0-18-generic #19=
-Ubuntu
> [ 85.606350] NIP: c000000000e81168 LR: c00000000054f240 CTR: 000000000000=
0000
> [ 85.606410] REGS: c00000005a3e3700 TRAP: 0300 Not tainted (5.3.0-18-gene=
ric)
> [ 85.606469] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 28024448 XE=
R: 00000000
> [ 85.606531] CFAR: 0000701f9806f638 DAR: 0000000001744098 DSISR: 40000000=
 IRQMASK: 0
> [ 85.606531] GPR00: 0000000000007374 c00000005a3e3990 c0000000019c9100 c0=
0000004fe462a8
> [ 85.606531] GPR04: c00000005856d840 000000000000000e 0000000074656772 c0=
0000004fe4a568
> [ 85.606531] GPR08: 0000000000000000 c000000058568004 0000000001744090 00=
00000000000000
> [ 85.606531] GPR12: 00000000e8086002 c000000001d60000 00007fffddd522d0 00=
00000000000000
> [ 85.606531] GPR16: 0000000000000000 0000000000000000 0000000000000000 c0=
0000000755e07c
> [ 85.606531] GPR20: c0000000598caca8 c00000005a3e3a58 0000000000000000 c0=
00000058292f00
> [ 85.606531] GPR24: c000000000eea710 0000000000000000 c00000005856d840 c0=
0000000755e074
> [ 85.606531] GPR28: 000000006518907d c00000005a3e3a68 c00000004fe4b160 00=
000000027c47b6
> [ 85.607079] NIP [c000000000e81168] rb_insert_color+0x18/0x1c0
> [ 85.607137] LR [c00000000054f240] ext4_htree_store_dirent+0x140/0x1c0
> [ 85.607186] Call Trace:
> [ 85.607208] [c00000005a3e3990] [c00000000054f158] ext4_htree_store_diren=
t+0x58/0x1c0 (unreliable)
> [ 85.607279] [c00000005a3e39e0] [c000000000594cd8] htree_dirblock_to_tree=
+0x1b8/0x380
> [ 85.607340] [c00000005a3e3b00] [c0000000005962c0] ext4_htree_fill_tree+0=
xc0/0x3f0
> [ 85.607401] [c00000005a3e3c00] [c00000000054ebe4] ext4_readdir+0x814/0xc=
e0
> [ 85.607459] [c00000005a3e3d40] [c000000000472d6c] iterate_dir+0x1fc/0x28=
0
> [ 85.607511] [c00000005a3e3d90] [c0000000004746f0] ksys_getdents64+0xa0/0=
x1f0
> [ 85.607572] [c00000005a3e3e00] [c000000000474868] sys_getdents64+0x28/0x=
130
> [ 85.607622] [c00000005a3e3e20] [c00000000000b388] system_call+0x5c/0x70
> [ 85.607672] Instruction dump:
> [ 85.607703] 4082ffe8 4e800020 38600000 4e800020 60000000 60000000 e92300=
00 2c290000
> [ 85.607764] 4182018c e9490000 71480001 4c820020 <e90a0008> 7c284840 2fa8=
0000 4182006c
> [ 85.607827] ---[ end trace cfc53af0f8d62cef ]---
> [ 85.610600]
> [ 86.611522] BUG: Unable to handle kernel data access at 0xc000030058567e=
ff
> [ 86.611604] Faulting instruction address: 0xc000000000403aa8
> [ 86.611656] Oops: Kernel access of bad area, sig: 11 [#2]
> [ 86.611697] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSerie=
s
> [ 86.611748] Modules linked in: ocfs2 quota_tr
>
> Thread from beginning 2018, so I guess this issue is pretty intermittent =
but
> might exist, and, perhaps, its related to specific arches/machines ?

FTR, here is the original thread/bug (at least my email client did not
thread them together):
https://groups.google.com/g/syzkaller-bugs/c/YBhhSkrImIM/m/3HMv_dFUCwAJ
https://syzkaller.appspot.com/bug?extid=3Deb13811afcefe99cfe45081054e7883f5=
69f949d
