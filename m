Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37D11F0BF0
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jun 2020 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgFGO17 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 10:27:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgFGO16 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 7 Jun 2020 10:27:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49fzHw4Tg7z9sRR;
        Mon,  8 Jun 2020 00:27:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591540076;
        bh=NRkr+5WCMmOW8df8XblzGRckJg9RS2z0CY6aVrnzX34=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TRp0DRmfBKe9O1NK4vLQvyKsTmUvqfMROtVm9Pl1MQOJswPMJUnXC6xSdFCiC39IQ
         Oa6DC+naGNAouHy+u42xwik2h+DEitP/MhuBNulT61yq1LvxcXpmXzI2LKLuH/GksI
         IzxoXvQrqin8IEi8/VOoY2qUKalf5ntAtGMGFqYhiPDgVJRwY+5OJ7+4RDTaFKFR8a
         FBsECFkJHw6+u1fvTRPmUgOoXfej+jNOJkBKd0FcCrYnsLwcxYIkC9o6CTKANJX/8W
         Nav6ujJqaH/Yq+fx9eHMRZ2kDXRoNqgC98HZMxU5wY9CQX3ttbSHNuvMvpIjVb9gR8
         H+upQQxtvzGkA==
Date:   Mon, 8 Jun 2020 00:27:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+c2a0ce95f0c47bcd4b37@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: systemd-rfkill/6910
Message-ID: <20200608002755.2e8c6a4d@canb.auug.org.au>
In-Reply-To: <00000000000088d87205a7733830@google.com>
References: <00000000000088d87205a7733830@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SkN/qdk_i4FbSniTIueImFv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/SkN/qdk_i4FbSniTIueImFv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Sat, 06 Jun 2020 17:03:15 -0700 syzbot <syzbot+c2a0ce95f0c47bcd4b37@syzk=
aller.appspotmail.com> wrote:
>
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    0e21d462 Add linux-next specific files for 20200602
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1461fcf2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Decc1aef35f550=
ee3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc2a0ce95f0c47bc=
d4b37
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c2a0ce95f0c47bcd4b37@syzkaller.appspotmail.com
>=20
> BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfk=
ill/6910
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 6910 Comm: systemd-rfkill Not tainted 5.7.0-next-20200602-syz=
kaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
>  ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
>  ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
>  ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
>  ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
>  ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
>  ext4_append+0x153/0x360 fs/ext4/namei.c:67
>  ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
>  ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
>  vfs_mkdir+0x419/0x690 fs/namei.c:3632
>  do_mkdirat+0x21e/0x280 fs/namei.c:3655
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7ff18513b687
> Code: Bad RIP value.
> RSP: 002b:00007ffcc5bd1218 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 0000560bebc67985 RCX: 00007ff18513b687
> RDX: 00007ffcc5bd10e0 RSI: 00000000000001ed RDI: 0000560bebc67985
> RBP: 00007ff18513b680 R08: 0000000000000100 R09: 0000000000000000
> R10: 0000560bebc67980 R11: 0000000000000246 R12: 00000000000001ed
> R13: 00007ffcc5bd13a0 R14: 0000000000000000 R15: 0000000000000000
>=20
>=20
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

#syz dup: linux-next test error: BUG: using smp_processor_id() in preemptib=
le  [ADDR] code: syz-fuzzer/6792

--=20
Cheers,
Stephen Rothwell

--Sig_/SkN/qdk_i4FbSniTIueImFv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7c+WwACgkQAVBC80lX
0Gw+rAf+NmJ/ln6YDvqXcodq6zl40zXbw+s+3USmJ/+7REO9Wufd35ws8TUrIGMp
JsK+TMlzfD/wjlj3GgwqfZNw5ILvQwpkQjGn7KAEQrDcLHZjiRgr9AdWg+N56Hex
JoyaBxuIdwdBGBk+KeVc22rWw37FuNslSmvGUtNPj4jgawS5aj27mxJ+61YCBv4E
Ay7qK8pLMuvcdSEH0QDruDUOH5cYWiNhZOPBStSRxUN7D2MwrYDeaoKxi4u8TWpx
qzmZknRbVcfYYvkbMgZS0L7w/HgdnJ9b9XuKjmAjY6zw/I8bMlVAFgZdKFL0hOid
+nKYRA8MB5kOac2Y5/AQV8eQwTgYVg==
=ysgr
-----END PGP SIGNATURE-----

--Sig_/SkN/qdk_i4FbSniTIueImFv--
