Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15F1F0BE7
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jun 2020 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFGO0f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgFGO0f (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Jun 2020 10:26:35 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B6C08C5C3;
        Sun,  7 Jun 2020 07:26:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49fzGK1H3yz9sRR;
        Mon,  8 Jun 2020 00:26:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591539993;
        bh=fBU38VASPvpTXqBHSAfc0fHBHWRr0IgmWg+cDVLfiiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iNvZZKbFzWyjNTxLGjeanGieBKVbn7NfRD1Z7HtMUxtrCHEijQD4s+PM3AAo+tv0x
         dl6Xevdx9m9t7s4V9fEyTvZJwlpFJYw8oXSDYDtowoSi5c2Q1eNxTL4pHaCTbmMue1
         1uMnCv4g1WF7mV/eCOD0qSv4ZH89BXUD10VBmrhffeIaHs5sOOqG34tdWTT7m/Urhc
         WXeSqTLSRo0FDxpeJOTweWH1nwOG3ZWLBl/EhZS4anAgT7VI+Euwq96M3GBfMwatN1
         yFuqVg686nWbM1Is0SOd7WqBTavvNZNm12nGULQSMrwIlu2yo8vncWtQ4B81tQWdKY
         sG1Ho3mZcKfeQ==
Date:   Mon, 8 Jun 2020 00:26:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+878f276b4892a4438f95@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: syz-fuzzer/6793
Message-ID: <20200608002632.392b79b1@canb.auug.org.au>
In-Reply-To: <000000000000872ad205a77c947c@google.com>
References: <000000000000872ad205a77c947c@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mclT.rawDJ0Wx4O+9TdoaCN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/mclT.rawDJ0Wx4O+9TdoaCN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Sun, 07 Jun 2020 04:13:13 -0700 syzbot <syzbot+878f276b4892a4438f95@syzk=
aller.appspotmail.com> wrote:
>
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    48f99181 Add linux-next specific files for 20200603
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1006bca6100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D365f706273eaf=
502
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D878f276b4892a44=
38f95
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+878f276b4892a4438f95@syzkaller.appspotmail.com
>=20
> BUG: using smp_processor_id() in preemptible [00000000] code: syz-fuzzer/=
6793
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 6793 Comm: syz-fuzzer Not tainted 5.7.0-next-20200603-syzkall=
er #0
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
> RIP: 0033:0x4b02a0
> Code: Bad RIP value.
> RSP: 002b:000000c00004f4b8 EFLAGS: 00000212 ORIG_RAX: 0000000000000102
> RAX: ffffffffffffffda RBX: 000000c00002c000 RCX: 00000000004b02a0
> RDX: 00000000000001c0 RSI: 000000c000026960 RDI: ffffffffffffff9c
> RBP: 000000c00004f510 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000212 R12: ffffffffffffffff
> R13: 000000000000004c R14: 000000000000004b R15: 0000000000000100
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

--Sig_/mclT.rawDJ0Wx4O+9TdoaCN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7c+RgACgkQAVBC80lX
0Gyokgf/aJqe1EULZ22lvRy+LkFe558CoxybDc3V5WlwcfxU0J+7so7eft4AfKKX
0rPnqV4FPpSmvRZVh8Wave4pSFATs9JreC0MkPHEyoYb2+bGUULGTwQtPhFNWYug
pFcFu3C0OsxojiMvQwG4CoXndLvy7PVEr1g7FjVphmTVzxajqpOGXQubZesplFIL
FdTI0in13Pb80DjTlfRyxPDr0vCxti6LxNbTO+SL49I2apMC+Gs5SxerFhvfgiZw
EXwrK056Ul6mY8l5F+mYFeO8y/Nnw7jq53+36pzY2B1vNbWcAFFdK6BwdVH1Zo5/
aTCN1MXTsRxrdTE/QR/j0CuoULBgYQ==
=6DUw
-----END PGP SIGNATURE-----

--Sig_/mclT.rawDJ0Wx4O+9TdoaCN--
