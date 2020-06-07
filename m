Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E901F0BE0
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jun 2020 16:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgFGOX5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 10:23:57 -0400
Received: from ozlabs.org ([203.11.71.1]:57835 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgFGOX5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 7 Jun 2020 10:23:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49fzCC53lKz9sRR;
        Mon,  8 Jun 2020 00:23:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1591539833;
        bh=sign7HCXhQks4EnxUBru8K2wgTWjPPDKEPvMkvEAujU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TaqYME+Lebx0Y6c8f9AWZFLpmXTHyuBY7newi4MN2a6czctKH3yRFAoeyajIOaV7Q
         J6cEuJ8KJ9/+JEtz6FRADwcVZXdyPLRLRTi3uHzhWF1FE3/gkEb35hxGnm1wfj0WFI
         A7F6jbXdP0y/MswHkPY1GNQJiKtYo00+at0/YrXvfygSpmxzYgh1D4dOLZuK521uOJ
         JmGI4mJINRxftyg7g1ULzPuB6IsWbEIVcjgPywuULn2gZRaZPXJBEeGzSYJ3YPP3VH
         q5XrrkOwiu155TLiJ/VvUWrOQpiwsesz3AfwuRKdyO19tuT8tJtSOFm/5sSJbqe4z5
         yeYo4FrC5KaAA==
Date:   Mon, 8 Jun 2020 00:23:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     syzbot <syzbot+9ce464e21fc2ab95dbf3@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: kworker/u4:LINE/41
Message-ID: <20200608002349.085eac93@canb.auug.org.au>
In-Reply-To: <00000000000082afe105a77c949d@google.com>
References: <00000000000082afe105a77c949d@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cLVs8J9Z/CEtitwu6A8qcPX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/cLVs8J9Z/CEtitwu6A8qcPX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi syzbot,

On Sun, 07 Jun 2020 04:13:12 -0700 syzbot <syzbot+9ce464e21fc2ab95dbf3@syzk=
aller.appspotmail.com> wrote:
>
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    48f99181 Add linux-next specific files for 20200603
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16a4c051100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D365f706273eaf=
502
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9ce464e21fc2ab9=
5dbf3
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9ce464e21fc2ab95dbf3@syzkaller.appspotmail.com
>=20
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u4:=
2/41
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkall=
er #0
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
2/41
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkall=
er #0
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
2/41
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkall=
er #0
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
2/41
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkall=
er #0
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
2/41
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 41 Comm: kworker/u4:2 Not tainted 5.7.0-next-20200603-syzkall=
er #0
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

--Sig_/cLVs8J9Z/CEtitwu6A8qcPX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7c+HUACgkQAVBC80lX
0GwD/wgApmcWzxjDflgE53BC0ZSSmA+VcLUgKTqd20wr+bUvZ9j+SJ7jdLkuFyWz
oVIehpEBBOPeOT2n4ayN/Uq4jk/u8UBtuB3MEh7BAGMjrWmHXwUfK+SjAm55PkvC
29ufi2nnvg0jjFydlhDwIyHjv9ukVYACEI0K+M+TFeFwFE+6KbDTpFwaKmibCN5v
3mk1EmXK7cBp9lm6kCYqRQJnAt6KIDSWxMepbj/y74fp8/WCJWXrd2+5aChuRXRe
9XnCYahi/3yifg/QUczC/aLxYfl1ZCixXq7sIjz98IfuF2FXNS1v52PCOLAkgeCO
dSxiuMVzL4M5PI6tmPObgucBkMxYQA==
=+hcp
-----END PGP SIGNATURE-----

--Sig_/cLVs8J9Z/CEtitwu6A8qcPX--
