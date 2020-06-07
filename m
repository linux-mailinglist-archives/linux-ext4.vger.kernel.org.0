Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5089F1F0BE9
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jun 2020 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgFGO1H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 10:27:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgFGO1G (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 7 Jun 2020 10:27:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49fzGv4cbCz9sRR;
        Mon,  8 Jun 2020 00:27:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591540023;
        bh=WeWHD0je37Pand0YRqlmwzDUBbtmVeuudOxT1LL9BDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GRQ3aF8YMoHszwxsfKeJ5VI5OmzdXkAsnI7i6fS1TFWBPWZPfgMZEea85kAn430eD
         49YDB1jpDqJW/QdMxO0RxeZtWpbfZ01R/gxyxTDQE1pBouaRCJqIslIKf/MPuiJF3S
         K6MK1vEIYFWlaqT75W0VZ5cIElQuevNT8SVUEXB20cx5x7encBmuZb939Ln52B2sQM
         14Y7/19VD7RBPVUGzwlS0o8N/DzD0+SDVCeu8zisL1vrrpkSIa//hlU1GqZAsWaZPp
         IuDpQqlcrNrsa1G/wIDzUzILa3RQ1U7LDNMWCe453DFPqRFBZ7VcRvUk/DHJc3O4rE
         mOjxtgWPhhh5A==
Date:   Mon, 8 Jun 2020 00:27:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+f72682b02970a74a7858@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible code in ext4_mb_new_blocks
Message-ID: <20200608002702.5e61bb78@canb.auug.org.au>
In-Reply-To: <000000000000a1595c05a77d47c4@google.com>
References: <000000000000a1595c05a77d47c4@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lnK4wtlfddxdsbcihf3Y_NS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/lnK4wtlfddxdsbcihf3Y_NS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Sun, 07 Jun 2020 05:03:18 -0700 syzbot <syzbot+f72682b02970a74a7858@syzk=
aller.appspotmail.com> wrote:
>
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    af30725c Add linux-next specific files for 20200605
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D126f99a6100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D579d800cf0c74=
ef
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Df72682b02970a74=
a7858
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f72682b02970a74a7858@syzkaller.appspotmail.com
>=20
> BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfk=
ill/6769
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 6769 Comm: systemd-rfkill Not tainted 5.7.0-next-20200605-syz=
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
> RIP: 0033:0x7f6d60012687
> Code: Bad RIP value.
> RSP: 002b:00007ffd286d9ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 000055f82bd8d985 RCX: 00007f6d60012687
> RDX: 00007ffd286d9b70 RSI: 00000000000001ed RDI: 000055f82bd8d985
> RBP: 00007f6d60012680 R08: 0000000000000100 R09: 0000000000000000
> R10: 000055f82bd8d980 R11: 0000000000000246 R12: 00000000000001ed
> R13: 00007ffd286d9e30 R14: 0000000000000000 R15: 0000000000000000
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

--Sig_/lnK4wtlfddxdsbcihf3Y_NS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7c+TYACgkQAVBC80lX
0GxdDQf+IdYsg5RotlKkrpj3JgE1Hbyve9ShBeWwJoVdxS6Tm9a+rBF2MtOYX/od
2Q2QzXxoJkyrBnf0nHXOPP+o1jgV5DDm5MUb/Ry5nG4oR3SWrMwEKYoThFB1kFtG
eU255co4ouhZ0fDJGMLY2xpcuoTlnGuayyu+xRfMiBo463b4Ww2pxUZw+x6t0CRN
13d07FzCt82LR0fTR6h7Wy1KWBFzOwAnnbbKyrNooIKYJdsqVGdy5ZpNoOpOtPWR
lQD/fZlDvAakLg4dOiHKGjoqlgymMhBEq2qrzt/OsS/FmK1KD7td6qk1wA56zRl7
Hd/iaFOe5sECT7sHtmSKOkU9i4wHqg==
=gj8R
-----END PGP SIGNATURE-----

--Sig_/lnK4wtlfddxdsbcihf3Y_NS--
