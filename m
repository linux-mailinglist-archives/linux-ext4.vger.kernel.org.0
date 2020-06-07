Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DB1F0BE4
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jun 2020 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFGOZl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgFGOZk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Jun 2020 10:25:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821BDC08C5C3;
        Sun,  7 Jun 2020 07:25:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49fzFD2TMQz9sRR;
        Mon,  8 Jun 2020 00:25:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591539936;
        bh=eFiG9U4AbBdPpGfUsg/cqDhmBVwh2ph/xp/yDGxCJTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bPSXfWB+Wr9rN31x5Yej+PgicL+Ft2f6GM+sHWMGl7k6nxVgIR6IWNRn3E+XzXxp2
         fZUNysWLLlVHTRazOeOfHnsFtawH6TQZ/mERBkIHoPxAuHuzQGpPl2b6fsSrXbk7h8
         Hnmu1jcXuA7dPioo28kmYf8dHSbG9dwE2sLdNkLXBQdh3nx1wzIVJyNWCqyiPp30+b
         dxF7D7D2YWfrW6G4YFvxS8YcyiNe0mZAYTJ2vsm3l8V4UmToznd6XYxSuVW/OoNPYb
         28g9h5fNp48Rfa7dRckegcqNdJgdPHOPcS2l3b7yl3PUuzRpZKkQ2GDyCF60Gn//eH
         G06PT12zCJT7A==
Date:   Mon, 8 Jun 2020 00:25:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+5c2f1b4ae8c49a698784@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: kworker/u4:LINE/4205
Message-ID: <20200608002535.65e82419@canb.auug.org.au>
In-Reply-To: <0000000000007f04d405a77c9485@google.com>
References: <0000000000007f04d405a77c9485@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3HgChcoBWK_Wt1GF2N+/k4H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/3HgChcoBWK_Wt1GF2N+/k4H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Sun, 07 Jun 2020 04:13:12 -0700 syzbot <syzbot+5c2f1b4ae8c49a698784@syzk=
aller.appspotmail.com> wrote:
>
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    48f99181 Add linux-next specific files for 20200603
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D148e22f2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D365f706273eaf=
502
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5c2f1b4ae8c49a6=
98784
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5c2f1b4ae8c49a698784@syzkaller.appspotmail.com
>=20
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:=
5/4205
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzka=
ller #0
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
>  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
>  __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
>  writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
>  __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
>  wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
>  wb_do_writeback fs/fs-writeback.c:2049 [inline]
>  wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
>  process_one_work+0x965/0x1690 kernel/workqueue.c:2269
>  worker_thread+0x96/0xe10 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:=
5/4205
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzka=
ller #0
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
>  __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
>  writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
>  __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
>  wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
>  wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
>  wb_do_writeback fs/fs-writeback.c:2049 [inline]
>  wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
>  process_one_work+0x965/0x1690 kernel/workqueue.c:2269
>  worker_thread+0x96/0xe10 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:=
5/4205
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzka=
ller #0
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
>  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
>  __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
>  writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
>  __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
>  wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
>  wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
>  wb_do_writeback fs/fs-writeback.c:2049 [inline]
>  wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
>  process_one_work+0x965/0x1690 kernel/workqueue.c:2269
>  worker_thread+0x96/0xe10 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:=
5/4205
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzka=
ller #0
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
>  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
>  __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
>  writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
>  __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
>  wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
>  wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
>  wb_do_writeback fs/fs-writeback.c:2049 [inline]
>  wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
>  process_one_work+0x965/0x1690 kernel/workqueue.c:2269
>  worker_thread+0x96/0xe10 kernel/workqueue.c:2415
>  kthread+0x3b5/0x4a0 kernel/kthread.c:291
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:=
5/4205
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 4205 Comm: kworker/u4:5 Not tainted 5.7.0-next-20200603-syzka=
ller #0
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
>  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2354
>  __writeback_single_inode+0x12a/0x13d0 fs/fs-writeback.c:1452
>  writeback_sb_inodes+0x515/0xdc0 fs/fs-writeback.c:1716
>  __writeback_inodes_wb+0xc3/0x250 fs/fs-writeback.c:1785
>  wb_writeback+0x8db/0xd50 fs/fs-writeback.c:1894
>  wb_check_old_data_flush fs/fs-writeback.c:1996 [inline]
>  wb_do_writeback fs/fs-writeback.c:2049 [inline]
>  wb_workfn+0xab3/0x1090 fs/fs-writeback.c:2078
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

--Sig_/3HgChcoBWK_Wt1GF2N+/k4H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7c+N8ACgkQAVBC80lX
0GxwRQf9Ew+nHbDc2t7C4oEHQnuETN9pYUAJ0VIUSgRKCepS/gxO1ibacVNS2+JZ
MlOlivp/5NvuJBbtIzy6ze/e6fgYVGlnQVFQSGrITyB//TgNH5ZYdhSXHvo8GEtD
FIF6tSHVpwA1ZhkhzkPpL1mit/hLr8QHkU/LuIhsPpTtjjIOEeKv9d3336lkCcfn
pDjICWh6DdcDPrDg4iyMhe5saE0GKQfNxiCU2RhC9ujfGxCWMATZ7ZFvC1slo6oH
uoeSMvGK3e/Ox5H0ofpTYsAh99RfO9kHi9jV6XfTiA9CJflzCdHL/doSaYoeEred
xCDUAUts3Tpyl8pjV+8HJpm1JXnPWg==
=abAM
-----END PGP SIGNATURE-----

--Sig_/3HgChcoBWK_Wt1GF2N+/k4H--
