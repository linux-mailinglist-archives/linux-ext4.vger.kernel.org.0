Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A52755C80
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jul 2023 09:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGQHNO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jul 2023 03:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGQHNL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jul 2023 03:13:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E2810D5;
        Mon, 17 Jul 2023 00:13:05 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H78Gei027682;
        Mon, 17 Jul 2023 07:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=HFwi5yEJG8MoqkCVp7HIaqGuYvKzqEoVRsfzJ82FKWg=;
 b=pYVX9hDb9KZIOj2JtjqyG4kYGaS0u85ZgMphwqdwqf4+SQhbLJjKCfYLxYVknP+rH0zW
 LNV6DHuTjE2t03k4TJy/mBAYNkMWNukyYXR7v86dF5HxnL2LpxutckUK1VXzMSzvzS94
 Kxdtd/pOgDaro6debAdPOh3fFp+I9GP1wZ/xUweQ/rcLQ3HGDaR0iNxjqpDTqe5okvHB
 xgRu8csJICl0RE+s+Bp5dEtEZlN+syBqHLRzvumjd6Hbb5suF94jNjigd8Dn1oG+DbNN
 mjFZwTOktdCRsUhcc3pK3Zs8bb/EMl0n+odyn8nj1FxzQrRZKgwsfKgj3zJeFR4go+3e 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw0rg0are-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 07:12:44 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36H78nL5029806;
        Mon, 17 Jul 2023 07:12:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw0rg0aqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 07:12:44 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H3RXot004455;
        Mon, 17 Jul 2023 07:12:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv8g0t61b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 07:12:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36H7Cf4o45810354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 07:12:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EFC720040;
        Mon, 17 Jul 2023 07:12:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5715920043;
        Mon, 17 Jul 2023 07:12:38 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 17 Jul 2023 07:12:38 +0000 (GMT)
Date:   Mon, 17 Jul 2023 12:42:35 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: next: kernel BUG at fs/ext4/mballoc.c:4369!
Message-ID: <ZLTp4xyWPkBrPBgF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com>
 <87o7kbnle9.fsf@doe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7kbnle9.fsf@doe.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NdJPSHYayp1k1NsUgp9-6QqeaDrT6-Wj
X-Proofpoint-GUID: CkA0nealNSmLagL9jQgZ-coDLNmPtlIo
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307170063
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 17, 2023 at 11:13:10AM +0530, Ritesh Harjani wrote:
> Naresh Kamboju <naresh.kamboju@linaro.org> writes:
> 
> > Following kernel BUG noticed while testing LTP fs testing on x86_64
> > arch x86_64 on the Linux next-20230716 built with clang toolchain.
> >
> > I see a similar crash log on arm64 Juno-r2. The logs are shared below.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > x86 log:
> > -------
> > tst_test.c:1634: TINFO: === Testing on ext2 ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > [ 1393.346989] EXT4-fs (loop0): mounting ext2 file system using the
> > ext4 subsystem
> 
> ext4 driver is used for ext2 filesystem here. It will be using indirect
> block mapping path.
> 
> > [ 1393.396754] EXT4-fs (loop0): mounted filesystem
> > 7ca8e239-bc8f-488c-af12-5e0ef12d17a5 r/w without journal. Quota mode:
> > none.
> > fs_fill.c:115: TINFO: Running 6 writer threads
> > tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread6/AOF\", iov,
> > 512): ENOSPC
> > tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread5/AOF\", iov,
> > 512): ENOSPC
> > ...
> > tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread6/AOF\", iov,
> > 512): ENOSPC
> > tst_fill_fs.c:109: TINFO: writev(\"mntpoint/subdir/thread3/AOF\", iov,
> > 512): ENOSPC
> > tst_fill_fs.c:109: TINF[ 1393.817197] ------------[ cut here ]------------
> > [ 1393.823305] kernel BUG at fs/ext4/mballoc.c:4369!
> 
> It's hard to trigger the race I guess. But here are some debugging
> information.
> 
> [  955.508751] EXT4-fs (loop1): mounting ext2 file system using the ext4 subsystem
> [  955.515527] EXT4-fs (loop1): mounted filesystem 57096378-d173-4bc5-ac06-9cd53c1dfa1c r/w without journal. Quota mode: none.
> [  959.289672] EXT4-fs (loop1): unmounting filesystem 57096378-d173-4bc5-ac06-9cd53c1dfa1c.
> [  959.490548] EXT4-fs (loop1): mounting ext3 file system using the ext4 subsystem
> [  959.503719] EXT4-fs (loop1): mounted filesystem 841c90bd-4d83-4bc5-be10-39452034e84b r/w with ordered data mode. Quota mode: none.
> [  960.553669] ext4_mb_pa_adjust_overlap: ==== This should not happend ==== left_pa=ffff8881471c7f50 deleted=0 lstart=6144 len=656 right_pa=0000000000000000
> [  960.557437] ext4_mb_pa_adjust_overlap: pa = ffff8881471c7540, deleted=1 lstart=5872 len=272 pstart=34560
> [  960.560659] ext4_mb_pa_adjust_overlap: pa = ffff8881471c7f50, deleted=0 lstart=6144 len=656 pstart=26848
> [  960.563855] ext4_mb_pa_adjust_overlap: pa = ffff8881471c7ee0, deleted=1 lstart=6623 len=2 pstart=45503
> 
> (This is the rbtree printed ^^^ )
> 
> (gdb) p ac->ac_o_ex
> $8 = {
>   fe_logical = 6625,
>   fe_start = 27328,
>   fe_group = 0,
>   fe_len = 1
> }
> (gdb) p new_start
> $9 = 6144
> (gdb) p new_end
> $10 = 8192
> (gdb) p left_pa_end
> $11 = 6800
> 
> 
> The bug one happens here -
> 
> 	if (left_pa) {
> 		left_pa_end =
> 			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
> 		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
> 	}
> 
> i.e. left_pa_end(6144 + 656 = 6800) > ac->ac_o_ex.fe_logical(6625)
> 
> Thought of sharing this info which can save time for others.

Hi Ritesh, 

Thanks for sharing the information. So it seems there's an overlapping
preallocation already present in which case the request should ideally
be satisfied by it and we shouldn't enter ext4_mb_normalize_request().

Further, the presence of deleted PAs can suggest a group discard is
ongoing which happens low storage scenarios.

I'll try to replicate it in my setup and update here.

Regards,
ojaswin
> 
> > O: writev(\"mntpo[ 1393.828041] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > [ 1393.834448] CPU: 3 PID: 8606 Comm: fs_fill Not tainted
> > 6.5.0-rc1-next-20230714 #1
> > [ 1393.841925] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.0b 07/27/2017
> > [ 1393.849396] RIP: 0010:ext4_mb_normalize_request+0x58f/0x5a0
> > int[/ s1u3b9d3i.r8ode: d7 b4 fc ff 80 4b 59 02 e9 b4 fa ff ff 48 8b 7b
> > 08 48 c7 c6 ba 35 7b 9a 48 c7 c2 75 26 83 9a e8 17 a9 02 00 0f 0b 0f
> > 0b 0f 0b <0f> 0b 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
> > 90 90
> > [ 1393.873879] RSP: 0018:ffffad2c03327708 EFLAGS: 00010212
> > [ 1393.879098] RAX: 0000000080000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [ 1393.886228] RDX: 0000000000000800 RSI: 000000000000c000 RDI: 000000000000c000
> > [ 1393.893353] RBP: ffffad2c03327770 R08: 00000000ffffffff R09: 000000000000bdac
> > [ 1393.900487] R10: ffffa28309e47098 R11: ffffffff991a03a0 R12: ffffa283232a3620
> > [ 1393.907611] R13: 0000000000000000 R14: ffffa283232a3658 R15: ffffa28309e47098
> > [ 1393.914733] FS:  00007f6963e80640(0000) GS:ffffa2865fd80000(0000)
> > knlGS:0000000000000000
> > [ 1393.922811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1393.928550] CR2: 00007f694c008ba8 CR3: 000000012cb72001 CR4: 00000000003706e0
> > [ 1393.935681] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 1393.942804] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 1393.949930] Call Trace:
> > [ 1393.952374]  <TASK>
> > [ 1393.954472]  ? __die_body+0x6c/0xc0
> > [ 1393.957964]  ? die+0xae/0xe0
> > [ 1393.960841]  ? do_trap+0x8d/0x160
> > [ 1393.964159]  ? ext4_mb_normalize_request+0x58f/0x5a0
> > [ 1393.969119]  ? handle_invalid_op+0x7f/0xd0
> > [ 1393.973218]  ? ext4_mb_normalize_request+0x58f/0x5a0
> > [ 1393.978183]  ? exc_invalid_op+0x36/0x50
> > [ 1393.982023]  ? asm_exc_invalid_op+0x1f/0x30
> > [ 1393.986210]  ? __pfx_ext4_dirty_inode+0x10/0x10
> > [ 1393.990740]  ? ext4_mb_normalize_request+0x58f/0x5a0
> > [ 1393.995698]  ? ext4_mb_normalize_request+0x311/0x5a0
> > [ 1394.000664]  ? _raw_read_unlock+0x20/0x40
> > [ 1394.004676]  ext4_mb_new_blocks+0x3c8/0xdf0
> > [ 1394.008864]  ? mark_buffer_dirty_inode+0x26/0xb0
> > [ 1394.013483]  ? __ext4_handle_dirty_metadata+0x7d/0x230
> > [ 1394.018620]  ext4_ind_map_blocks+0x74e/0xc30
> > [ 1394.022897]  ext4_map_blocks+0x2d6/0x640
> > [ 1394.026821]  _ext4_get_block+0x92/0x150
> > [ 1394.030659]  ext4_get_block+0x1b/0x30
> > [ 1394.034316]  __block_write_begin_int+0x193/0x670
> > [ 1394.038928]  ? __pfx_ext4_get_block+0x10/0x10
> > [ 1394.043277]  ? __ext4_journal_start_sb+0x9f/0x210
> > [ 1394.047974]  __block_write_begin+0x1f/0x50
> > [ 1394.052065]  ext4_write_begin+0x1fa/0x520
> > [ 1394.056072]  generic_perform_write+0xb7/0x260
> > [ 1394.060431]  ext4_buffered_write_iter+0xcd/0x150
> > [ 1394.065049]  ext4_file_write_iter+0x341/0x960
> > [ 1394.069407]  ? iovec_from_user+0x53/0x110
> > [ 1394.073420]  do_iter_write+0x202/0x320
> > [ 1394.077173]  vfs_writev+0x19c/0x280
> > [ 1394.080666]  do_writev+0x77/0x110
> > [ 1394.083978]  __x64_sys_writev+0x23/0x30
> > [ 1394.087816]  do_syscall_64+0x48/0xa0
> > [ 1394.091386]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [ 1394.096440] RIP: 0033:0x7f696678aa7d
> > [ 1394.100011] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 0a
> > 55 f8 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 14 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 5e 55 f8
> > ff 48
> > [ 1394.118756] RSP: 002b:00007f6963e7cdd0 EFLAGS: 00000293 ORIG_RAX:
> > 0000000000000014
> > [ 1394.126315] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f696678aa7d
> > [ 1394.133436] RDX: 0000000000000200 RSI: 00007f6963e7ce00 RDI: 0000000000000007
> > [ 1394.140562] RBP: 0000000000d4bbe8 R08: 0000000000000000 R09: 0000000000000180
> > [ 1394.147684] R10: 0000000000000180 R11: 0000000000000293 R12: 0000000000000007
> > [ 1394.154809] R13: 0000000000000003 R14: 00007f6963e805c0 R15: 0000000000200000
> > [ 1394.161933]  </TASK>
> > [ 1394.164118] Modules linked in: tun x86_pkg_temp_thermal
> > [ 1394.169352] ---[ end trace 0000000000000000 ]---
> >
> >
> > Links:
> >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230714/testrun/18306459/suite/log-parser-test/tests/
> >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230714/testrun/18306459/suite/log-parser-test/test/check-kernel-bug/log
> >  - https://lkft.validation.linaro.org/scheduler/job/6584529#L2195
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2SY3QjxEGsLoae4uGpfjPnZqwKC/
> >
> >
> > Juno-r2 log:
> > ------------
> >
> > tst_test.c:1634: TINFO: === Testing on ext3 ===
> > tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> > mke2fs 1.46.5 (30-Dec-2021)
> > [ 2086.751198] EXT4-fs (loop0): mounting ext3 file system using the
> > ext4 subsystem
> > [ 2086.802353] EXT4-fs (loop0): mounted filesystem
> > 0b1ac79e-51b8-47a0-b8c8-13ff4c4c2459 r/w with ordered data mode. Quota
> > mode: none.
> > [ 2092.630907] ==================================================================
> > [ 2092.638172] BUG: KASAN: slab-use-after-free in
> > copy_page_from_iter_atomic+0x778/0x8c8
> 
> This seems to be a different issue than above.
> 
> 
> > [ 2092.646046] Read of size 1024 at addr ffff000834540000 by task
> > kworker/u12:1/15943
> > [ 2092.653643]
> > [ 2092.655141] CPU: 2 PID: 15943 Comm: kworker/u12:1 Not tainted
> > 6.5.0-rc1-next-20230714 #1
> > [ 2092.663264] Hardware name: ARM Juno development board (r2) (DT)
> > [ 2092.669204] Workqueue: loop0 loop_rootcg_workfn
> > [ 2092.673773] Call trace:
> > [ 2092.676226]  dump_backtrace+0x9c/0x128
> > [ 2092.679997]  show_stack+0x20/0x38
> > [ 2092.683328]  dump_stack_lvl+0x60/0xb0
> > [ 2092.687009]  print_report+0xf4/0x5b0
> > [ 2092.690607]  kasan_report+0xa8/0x100
> > [ 2092.694204]  kasan_check_range+0xe8/0x190
> > [ 2092.698231]  memcpy+0x3c/0xa0
> > [ 2092.701213]  copy_page_from_iter_atomic+0x778/0x8c8
> > [ 2092.706113]  generic_perform_write+0x1b4/0x318
> > [ 2092.710576]  ext4_buffered_write_iter+0x98/0x1a8
> > [ 2092.715217]  ext4_file_write_iter+0xf0/0xb20
> > [ 2092.719507]  do_iter_readv_writev+0x134/0x200
> > [ 2092.723889]  do_iter_write+0xd8/0x390
> > [ 2092.727572]  vfs_iter_write+0x60/0x88
> > [ 2092.731256]  loop_process_work+0x8f0/0x1000
> > [ 2092.735463]  loop_rootcg_workfn+0x28/0x40
> > [ 2092.739495]  process_one_work+0x42c/0x888
> > [ 2092.743524]  worker_thread+0xa4/0x6a8
> > [ 2092.747203]  kthread+0x19c/0x1b0
> > [ 2092.750450]  ret_from_fork+0x10/0x20
> > [ 2092.754045]
> > [ 2092.755539] Allocated by task 15409:
> > [ 2092.759126]  kasan_save_stack+0x2c/0x58
> > [ 2092.762986]  kasan_set_track+0x2c/0x40
> > [ 2092.766756]  kasan_save_alloc_info+0x24/0x38
> > [ 2092.771044]  __kasan_slab_alloc+0xa8/0xb0
> > [ 2092.775075]  kmem_cache_alloc+0x130/0x330
> > [ 2092.779105]  jbd2_alloc+0x78/0x90
> > [ 2092.782437]  do_get_write_access+0x2b8/0x758
> > [ 2092.786728]  jbd2_journal_get_write_access+0xb0/0xf8
> > [ 2092.791715]  __ext4_journal_get_write_access+0xc4/0x250
> > [ 2092.796968]  ext4_reserve_inode_write+0xe0/0x138
> > [ 2092.801610]  __ext4_mark_inode_dirty+0xe4/0x3e8
> > [ 2092.806164]  ext4_dirty_inode+0x8c/0xb8
> > [ 2092.810021]  __mark_inode_dirty+0x84/0x618
> > [ 2092.814138]  generic_write_end+0x170/0x180
> > [ 2092.818253]  ext4_da_write_end+0x120/0x3d0
> > [ 2092.822372]  generic_perform_write+0x1ec/0x318
> > [ 2092.826835]  ext4_buffered_write_iter+0x98/0x1a8
> > [ 2092.831472]  ext4_file_write_iter+0xf0/0xb20
> > [ 2092.835760]  vfs_write+0x450/0x550
> > [ 2092.839176]  ksys_write+0xcc/0x178
> > [ 2092.842592]  __arm64_sys_write+0x4c/0x68
> > [ 2092.846530]  invoke_syscall+0x68/0x198
> > [ 2092.850303]  el0_svc_common.constprop.0+0x12c/0x168
> > [ 2092.855206]  do_el0_svc+0x4c/0xd8
> > [ 2092.858541]  el0_svc+0x30/0x70
> > [ 2092.861612]  el0t_64_sync_handler+0x13c/0x158
> > [ 2092.865990]  el0t_64_sync+0x190/0x198
> > [ 2092.869668]
> > [ 2092.871163] The buggy address belongs to the object at ffff000834540000
> > [ 2092.871163]  which belongs to the cache jbd2_1k of size 1024
> > [ 2092.883459] The buggy address is located 0 bytes inside of
> > [ 2092.883459]  freed 1024-byte region [ffff000834540000, ffff000834540400)
> > [ 2092.895670]
> > [ 2092.897164] The buggy address belongs to the physical page:
> > [ 2092.902751] page:0000000021bf671c refcount:1 mapcount:0
> > mapping:0000000000000000 index:0xffff000834540000 pfn:0x8b4540
> > [ 2092.913485] head:0000000021bf671c order:3 entire_mapcount:0
> > nr_pages_mapped:0 pincount:0
> > [ 2092.921602] flags:
> > 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff)
> > [ 2092.928944] page_type: 0xffffffff()
> > [ 2092.932452] raw: 0bfffc0000010200 ffff00082b6c4000 dead000000000122
> > 0000000000000000
> > [ 2092.940224] raw: ffff000834540000 000000008010000f 00000001ffffffff
> > 0000000000000000
> > [ 2092.947989] page dumped because: kasan: bad access detected
> > [ 2092.953576]
> > [ 2092.955070] Memory state around the buggy address:
> > [ 2092.959877]  ffff00083453ff00: ff ff ff ff ff ff ff ff ff ff ff ff
> > ff ff ff ff
> > [ 2092.967123]  ffff00083453ff80: ff ff ff ff ff ff ff ff ff ff ff ff
> > ff ff ff ff
> > [ 2092.974368] >ffff000834540000: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb
> > [ 2092.981610]                    ^
> > [ 2092.984849]  ffff000834540080: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb
> > [ 2092.992094]  ffff000834540100: fb fb fb fb fb fb fb fb fb fb fb fb
> > fb fb fb fb
> > [ 2092.999336] ==================================================================
> > [ 2093.006683] Disabling lock debugging due to kernel taint
> > [ 2099.278554] preadv203 (103227): drop_caches: 3
> > [ 2099.514899] preadv203 (103228): drop_caches: 3
> > [ 2099.552185] preadv203 (103228): drop_caches: 3
> > [ 2099.586917] preadv203 (103228): drop_caches: 3
> >
> > Links:
> >  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230714/testrun/18303379/suite/log-parser-test/tests/
> >  - https://lkft.validation.linaro.org/scheduler/job/6584681#L2640
> >  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2SY3ZSm0bzBoyQkWFQAYYZru1UJ/
> >
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> 
> -ritesh
