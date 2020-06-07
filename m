Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92A71F0BED
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jun 2020 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgFGO1i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 10:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgFGO1i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Jun 2020 10:27:38 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6E8C08C5C3;
        Sun,  7 Jun 2020 07:27:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49fzHX1vzxz9sRR;
        Mon,  8 Jun 2020 00:27:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591540056;
        bh=ozemjoQ+jyIL5Skqab22pLsAweolvWFNHsQUTkpkzcY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PcFILSxKMUW6V4EavkPGxAfXWjGnvEclP1O1lp9UP3c1BB5Fx1YDW5ThT+hTzifls
         I8PhHDTj7HvrrsS6DPXnV6YG+uUEhkqALGA8OYfNOyCJkC6n//ngGLtCm+1Kvf8ORD
         KNK4LMohkEMPLXIXQA8cpzU7eDjNIjqqH4mU5R4a1osyAfsAQqxDtdaa0ZDnv+McJX
         uMsQsh/rMsMDOajubb+TPlsambhmnXKew59CQ71C9CAFRO5SpwvM3KBjBu4sbS33Dq
         pES3ec6R6zF+FwBwbGe13Qcky8r/ws/7qUceUj7RuYXXxiJQfTUR8ztn5QjpqdgBmJ
         Dj0KgSzq0m7ww==
Date:   Mon, 8 Jun 2020 00:27:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+ca020d38a27ddc8e3cae@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: kworker/u4:LINE/198
Message-ID: <20200608002735.32311614@canb.auug.org.au>
In-Reply-To: <0000000000008e483f05a773388c@google.com>
References: <0000000000008e483f05a773388c@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5O_yLLI8gGPQJ26puuUp6h/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/5O_yLLI8gGPQJ26puuUp6h/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Sat, 06 Jun 2020 17:03:15 -0700 syzbot <syzbot+ca020d38a27ddc8e3cae@syzk=
aller.appspotmail.com> wrote:
>
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    0e21d462 Add linux-next specific files for 20200602
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D107072f2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Decc1aef35f550=
ee3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dca020d38a27ddc8=
e3cae
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ca020d38a27ddc8e3cae@syzkaller.appspotmail.com
>=20
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:=
4/198
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 198 Comm: kworker/u4:4 Not tainted 5.7.0-next-20200602-syzkal=
ler #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
> Workqueue: writeback wb_workfn (flush-8:0)
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
>  ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
>  ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
>  ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
>  mpage_map_one_extent fs/ext4/inode.c:2377 [inline]
>  mpage_map_and_submit_extent fs/ext4/inode.c:2430 [inline]
>  ext4_writepages+0x1ab5/0x3400 fs/ext4/inode.c:2782
>  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2338
>  __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1453
>  writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1717
>  __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1786
>  wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1895
>  wb_check_old_data_flush fs/fs-writeback.c:1997 [inline]
>  wb_do_writeback fs/fs-writeback.c:2050 [inline]
>  wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2079
>  process_one_work+0x965/0x1690 kernel/workqueue.c:2269
>  worker_thread+0x96/0xe10 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> tipc: TX() has been purged, node left!
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

--Sig_/5O_yLLI8gGPQJ26puuUp6h/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7c+VcACgkQAVBC80lX
0GxR1QgApf+7sM7t85Zy5Fef9wVS7Jq2k8MJGd+SE8DOYR4L1aC7KzNvG9Clcoem
TYronHepjNA3A9kvuB5E0Y8b/ZU2aRzYYJUOq4CdjAelS+tTgBE+ehbu/9FyFBvG
gi8D8LqC8zGQHeIiFgAW1r1r57DzKF+7BxWQrhM4uUGqlfwH0ZxJcHI1eMTEN8eB
eIGJK3oBAdtbz9uM/6nRhYB3OhjMAk9pEcq6CCUyAS4KxU10DmP9TDetsMwMaAs7
EudhykgtdL6TZwakuFZoh/N6VsH1taTBYaHfwBVOkgQ0aV4VpPEjIZP53m0IOpHP
dsx8HdCivlhlknCE9+546qPP0sIjmA==
=wO+N
-----END PGP SIGNATURE-----

--Sig_/5O_yLLI8gGPQJ26puuUp6h/--
