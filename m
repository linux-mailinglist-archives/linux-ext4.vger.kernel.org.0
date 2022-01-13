Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42BD48D88B
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jan 2022 14:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiAMNMx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jan 2022 08:12:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232585AbiAMNMw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Jan 2022 08:12:52 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DCs5qG020163;
        Thu, 13 Jan 2022 13:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=0MVUufEO/NIOFK22TVrnOAFJOFRSJIYKs9jQ54kksPE=;
 b=ebJHQzzfWEpZBpF4L+HTnxUQM6qMfIl8tWAc+6kjW2mT4k/7ybXAw2/5Ya4ZB5aiQlCD
 FkZZKAFx2TCDqhYUj30/V2bfBhgD4qRSTriMMjbwUOxMStXURVA/JYF3YXq+O4LgeZhR
 p708n5Su3EKYAag64JSLvIe4xGsMshNblFI7TZW4k9C7bpO7rm0+70jQ/rKdpCuWy7OG
 My5pAgnHnUvTvvgA6AOBU5YNlMioXm2v3ZJJ+8pBuwlb6e1d3FEYv2MNkNi6NxFR2UzW
 pveEfhoFDwVhU18BCWrKKOzh5YyovKioc30Tei8TsyXRIL1rtGvnH5gODl/muiYZp4aW 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djjprtpt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 13:12:35 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DD88ve017320;
        Thu, 13 Jan 2022 13:12:35 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djjprtpse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 13:12:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DD7M5G001875;
        Thu, 13 Jan 2022 13:12:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3df289mpg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 13:12:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DDCU3M36569372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 13:12:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F998AE055;
        Thu, 13 Jan 2022 13:12:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00031AE045;
        Thu, 13 Jan 2022 13:12:29 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 13:12:29 +0000 (GMT)
Date:   Thu, 13 Jan 2022 18:42:28 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/2] ext4: fast commit may not fallback
 for ineligible commit
Message-ID: <20220113131228.ycyyytp6b6nkbe42@riteshh-domain>
References: <20220107121215.1912-2-yinxin.x@bytedance.com>
 <202201091544.W5HHEXAp-lkp@intel.com>
 <CAK896s74jBKAhruo-v8rJGWDOgTKF6GKNWg5Qj0B+Zb=VAtJdA@mail.gmail.com>
 <CAD+ocbwyE=h3jFnanQRqkh+AemCv8aP2W9J92C4OoV047TZS7Q@mail.gmail.com>
 <CAK896s7kbDtieyHregY2U-Y_nZBixmNAa6pAyoenb_fy_sD_3w@mail.gmail.com>
 <20220113085939.es3eboxmbiocz6kf@riteshh-domain>
 <CAK896s4joD9+M_8Qb_oaMpVOZFup=g1Re5YL42z+nR-mEh9P4g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK896s4joD9+M_8Qb_oaMpVOZFup=g1Re5YL42z+nR-mEh9P4g@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xy0VsODpm6xd3fSZ-FqjiTlGRmzEMSZ_
X-Proofpoint-GUID: pSUJ9pXQXzQR0E_mvSeV-DHVmKylMYHg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_04,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130079
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/01/13 05:26PM, Xin Yin wrote:
> On Thu, Jan 13, 2022 at 4:59 PM riteshh <riteshh@linux.ibm.com> wrote:
> >
> > On 22/01/13 02:53PM, Xin Yin wrote:
> > > On Thu, Jan 13, 2022 at 12:18 PM harshad shirwadkar
> > > <harshadshirwadkar@gmail.com> wrote:
> > > >
> > > > On Mon, Jan 10, 2022 at 7:13 PM Xin Yin <yinxin.x@bytedance.com> wrote:
> > > > >
> > > > > Hi Dan,
> > > > >
> > > > > Thanks for spotting this, and I think it is not only an
> > > > > 'uninitialized' issue , we can not use 'handle' after
> > > > > ext4_journal_stop,  it may cause a use-after-free.
> > > > > So maybe we should use 'transaction tid' as input instead of 'handle',
> > > > > then it will be like this ext4_fc_mark_ineligible(struct super_block
> > > > > *sb, int reason, tid_t tid). or we should move all
> > > > > ext4_fc_mark_ineligible() between ext4_journal_start/ext4_journal_stop
> > > > > if we need 'handle' param.
> > > > This is a case where the inode is still in the fast commit list and we
> > > > reached the "no_delete" case in ext4_evict_inode. Note that we reach
> > > > here even when we are not able to start the journal handle. So, the
> > > > second option that you suggested (to move ext4_fc_mark_ineligible()
> > > > between ext4_journal_start() and ext4_journal_stop()) would not work
> > > > for the case when we are not able to start the handle at all. Also,
> > > > passing handle to ext4_fc_mark_ineligible() is pretty clean so I'd
> > > > like to stay with that instead of passing "tid".
> > > Understood, thanks for the explanations.
> > >
> > > >
> > > > How about adding a new variant of ext4_fc_mark_ineligible() that
> > > > doesn't take handle and only takes sb and reason? In that function we
> > > > can mark the currently running transaction as ineligible. So basically
> > > > it would derive tid as journal->j_running_transaction->t_tid. We can
> > > Yes , this makes sense , thanks.
> > >
> > > > name that function as something like "ext4_fc_mark_txn_ineligible()".
> > > In this case , I think we can just set "hendle" as NULL , then
> > > ext4_fc_mark_ineligible() use tid as
> > > journal->j_running_transaction->t_tid. And we do not need to add a new
> > > API. How about this?
> >
> > I was about to comment the same that why two different APIs for the same work.
> > Above does sounds a better solution to me. But I will let Harshad
> > comment on it too.
> >
> > Also please note in function ext4_xattr_set(), with fstests, I could easily
> > reproduce a use-after-free issue with your v2 patches too.
> Thanks , this is the same reason as the issue reported by Dan , I will
> fix this in the next version. could you share the fstests command to
> reproduce this issue?

Here are the details, hope it helps.

This is with your v2 patches applied. I also have KASAN enabled on my setup.
This is with fstest generic/388

[  585.335989] run fstests generic/388 at 2022-01-13 18:29:23
[  588.175384] EXT4-fs (loop2): mounted filesystem with ordered data mode. Quota mode: none.
[  590.603966] EXT4-fs (loop3): mounted filesystem with ordered data mode. Quota mode: none.
[  590.635835] EXT4-fs (loop3): shut down requested (1)
[  590.637402] Aborting journal on device loop3-8.
[  592.606238] EXT4-fs (loop3): mounted filesystem with ordered data mode. Quota mode: none.
[  592.770245] ==================================================================
[  592.772479] BUG: KASAN: use-after-free in ext4_fc_mark_ineligible+0x97/0xf0
[  592.774466] Read of size 8 at addr ffff8880734574d0 by task fsstress/20440
[  592.776497]
[  592.776958] CPU: 23 PID: 20440 Comm: fsstress Not tainted 5.16.0-rc4+ #183
[  592.778800] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[  592.781369] Call Trace:
[  592.782081]  <TASK>
[  592.782691]  dump_stack_lvl+0x5b/0x82
[  592.783780]  print_address_description.constprop.0+0x48/0x70
[  592.785363]  ? ext4_fc_mark_ineligible+0x97/0xf0
[  592.786638]  kasan_report.cold+0x82/0xdb
[  592.788023]  ? ext4_fc_mark_ineligible+0x97/0xf0
[  592.789324]  __asan_load8+0x69/0x90
[  592.790296]  ext4_fc_mark_ineligible+0x97/0xf0
[  592.791529]  ext4_xattr_set+0x28c/0x2a0
[  592.792639]  ? ext4_xattr_set_credits+0x90/0x90
[  592.794166]  ? inode_has_perm+0xa6/0xc0
[  592.795318]  ext4_xattr_user_set+0x64/0x80
[  592.796482]  __vfs_removexattr+0xc2/0x100
[  592.797622]  ? __vfs_getxattr+0x100/0x100
[  592.798795]  __vfs_removexattr_locked+0x134/0x240
[  592.800134]  vfs_removexattr+0xc2/0x1d0
[  592.801423]  ? __vfs_removexattr_locked+0x240/0x240
[  592.802778]  ? __kasan_check_write+0x14/0x20
[  592.803955]  ? strncpy_from_user+0x1c3/0x200
[  592.805210]  removexattr+0xaf/0x100
[  592.806186]  ? vfs_removexattr+0x1d0/0x1d0
[  592.807413]  ? rcu_read_lock_bh_held+0xb0/0xb0
[  592.808871]  ? __this_cpu_preempt_check+0x13/0x20
[  592.810207]  ? __this_cpu_preempt_check+0x13/0x20
[  592.811534]  ? rcu_read_lock_any_held+0xd2/0x100
[  592.812816]  ? rcu_read_lock_held+0xb0/0xb0
[  592.813967]  ? preempt_count_sub+0x18/0xc0
[  592.815293]  ? __mnt_want_write+0xaa/0x100
[  592.816473]  ? mnt_want_write+0xc8/0x220
[  592.817585]  path_removexattr+0x12c/0x150
[  592.818709]  ? removexattr+0x100/0x100
[  592.819748]  ? syscall_enter_from_user_mode+0x21/0x60
[  592.821142]  ? __this_cpu_preempt_check+0x13/0x20
[  592.822432]  ? lockdep_hardirqs_on+0xc4/0x140
[  592.823810]  ? syscall_enter_from_user_mode+0x21/0x60
[  592.825226]  __x64_sys_removexattr+0x36/0x40
[  592.826414]  do_syscall_64+0x3b/0x90
[  592.827411]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  592.828815] RIP: 0033:0x7ffff7eb50db
[  592.829817] Code: f0 ff ff 73 01 c3 48 8b 0d b2 ad 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 008
[  592.834916] RSP: 002b:00007fffffff9aa8 EFLAGS: 00000202 ORIG_RAX: 00000000000000c5
[  592.836977] RAX: ffffffffffffffda RBX: 00007fffffff9ad0 RCX: 00007ffff7eb50db
[  592.839019] RDX: 0000000000000000 RSI: 00007fffffff9ad0 RDI: 000055555556d440
[  592.840935] RBP: 000000000007a120 R08: 0000000000000000 R09: 00007fffffff9940
[  592.842832] R10: 00005555555640da R11: 0000000000000202 R12: 0000000000000014
[  592.844869] R13: 8f5c28f5c28f5c29 R14: 0000555555559b60 R15: 0000000000000014
[  592.846981]  </TASK>
[  592.847709]
[  592.848162] Allocated by task 20440:
[  592.849169]  kasan_save_stack+0x26/0x60
[  592.850231]  __kasan_slab_alloc+0x6d/0x90
[  592.851538]  kmem_cache_alloc+0x107/0x360
[  592.852823]  jbd2__journal_start+0xd3/0x3d0
[  592.854044]  __ext4_journal_start_sb+0x207/0x250
[  592.855480]  ext4_xattr_set+0x164/0x2a0
[  592.856638]  ext4_xattr_user_set+0x64/0x80
[  592.857877]  __vfs_removexattr+0xc2/0x100
[  592.859043]  __vfs_removexattr_locked+0x134/0x240
[  592.860524]  vfs_removexattr+0xc2/0x1d0
[  592.861691]  removexattr+0xaf/0x100
[  592.862846]  path_removexattr+0x12c/0x150
[  592.864022]  __x64_sys_removexattr+0x36/0x40
[  592.865251]  do_syscall_64+0x3b/0x90
[  592.866408]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  592.867900]
[  592.868357] Freed by task 20440:
[  592.869313]  kasan_save_stack+0x26/0x60
[  592.870432]  kasan_set_track+0x25/0x30
[  592.871533]  kasan_set_free_info+0x24/0x40
[  592.872883]  __kasan_slab_free+0xf2/0x130
[  592.874047]  kmem_cache_free+0xc3/0x390
[  592.875181]  jbd2_journal_stop+0x3a5/0x790
[  592.876387]  __ext4_journal_stop+0x6d/0xf0
[  592.877707]  ext4_xattr_set+0x1b7/0x2a0
[  592.878834]  ext4_xattr_user_set+0x64/0x80
[  592.880040]  __vfs_removexattr+0xc2/0x100
[  592.881198]  __vfs_removexattr_locked+0x134/0x240
[  592.882542]  vfs_removexattr+0xc2/0x1d0
[  592.883833]  removexattr+0xaf/0x100
[  592.884873]  path_removexattr+0x12c/0x150
[  592.886026]  __x64_sys_removexattr+0x36/0x40
[  592.887254]  do_syscall_64+0x3b/0x90
[  592.888321]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  592.889965]
[  592.890410] The buggy address belongs to the object at ffff8880734574d0
[  592.890410]  which belongs to the cache jbd2_journal_handle of size 56
[  592.894137] The buggy address is located 0 bytes inside of
[  592.894137]  56-byte region [ffff8880734574d0, ffff888073457508)
[  592.897465] The buggy address belongs to the page:
[  592.898893] page:ffffea0001cd15c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888073457b30 p7
[  592.902061] flags: 0x80000000000200(slab|node=0|zone=1)
[  592.903566] raw: 0080000000000200 ffffea0001cd1448 ffff8881098f2ad0 ffff8881098f1a40
[  592.905851] raw: ffff888073457b30 00000000000a0007 00000001ffffffff 0000000000000000
[  592.908165] page dumped because: kasan: bad access detected
[  592.909798]
[  592.910397] Memory state around the buggy address:
[  592.911816]  ffff888073457380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  592.913875]  ffff888073457400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  592.916439] >ffff888073457480: fc fc fc fc fc fc fc fc fc fc fa fb fb fb fb fb
[  592.918483]                                                  ^
[  592.920189]  ffff888073457500: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  592.922563]  ffff888073457580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  592.924890] ==================================================================
[  592.926953] Disabling lock debugging due to kernel taint
[  592.928593] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  592.930699] #PF: supervisor read access in kernel mode
[  592.932140] #PF: error_code(0x0000) - not-present page
[  592.933565] PGD 0 P4D 0
[  592.934320] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN PTI
[  592.936155] CPU: 23 PID: 20440 Comm: fsstress Tainted: G    B             5.16.0-rc4+ #183
[  592.938441] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014
[  592.940946] RIP: 0010:ext4_fc_mark_ineligible+0xa4/0xf0
[  592.942389] Code: 89 f7 e8 cf 94 7b 01 4d 85 ed 74 35 49 81 fd 00 f0 ff ff 77 2c 4c 89 ef e8 e9 bd dc ff 4d0
[  592.947494] RSP: 0018:ffff88803e2b79d0 EFLAGS: 00010286
[  592.948904] RAX: 0000000000000000 RBX: ffff88802b385000 RCX: ffffffff816c3394
[  592.950793] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000008
[  592.961655] RBP: ffff88803e2b79f0 R08: ffffffff816c3394 R09: 0000000000000000
[  592.963559] R10: ffffffff84535983 R11: fffffbfff08a6b30 R12: 0000000000000000
[  592.965600] R13: 0000000000000000 R14: ffff88802b385e50 R15: ffff8880734574d0
[  592.967505] FS:  00007ffff7d92740(0000) GS:ffff888118600000(0000) knlGS:0000000000000000
[  592.969768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  592.971315] CR2: 0000000000000008 CR3: 000000000ae3c000 CR4: 00000000000006e0
[  592.973227] Call Trace:
[  592.973899]  <TASK>
[  592.974493]  ext4_xattr_set+0x28c/0x2a0
[  592.975687]  ? ext4_xattr_set_credits+0x90/0x90
[  592.976938]  ? inode_has_perm+0xa6/0xc0
[  592.977991]  ext4_xattr_user_set+0x64/0x80
[  592.979107]  __vfs_removexattr+0xc2/0x100
[  592.980198]  ? __vfs_getxattr+0x100/0x100
[  592.981299]  __vfs_removexattr_locked+0x134/0x240
[  592.982629]  vfs_removexattr+0xc2/0x1d0
[  592.983664]  ? __vfs_removexattr_locked+0x240/0x240
[  592.984994]  ? __kasan_check_write+0x14/0x20
[  592.986147]  ? strncpy_from_user+0x1c3/0x200
[  592.987313]  removexattr+0xaf/0x100
[  592.988267]  ? vfs_removexattr+0x1d0/0x1d0
[  592.989486]  ? rcu_read_lock_bh_held+0xb0/0xb0
[  592.990696]  ? __this_cpu_preempt_check+0x13/0x20
[  592.991967]  ? __this_cpu_preempt_check+0x13/0x20
[  592.993255]  ? rcu_read_lock_any_held+0xd2/0x100
[  592.994500]  ? rcu_read_lock_held+0xb0/0xb0
[  592.995635]  ? preempt_count_sub+0x18/0xc0
[  592.996876]  ? __mnt_want_write+0xaa/0x100
[  592.997985]  ? mnt_want_write+0xc8/0x220
[  592.999059]  path_removexattr+0x12c/0x150
[  593.000155]  ? removexattr+0x100/0x100
[  593.001288]  ? syscall_enter_from_user_mode+0x21/0x60
[  593.002659]  ? __this_cpu_preempt_check+0x13/0x20
[  593.003922]  ? lockdep_hardirqs_on+0xc4/0x140
[  593.005108]  ? syscall_enter_from_user_mode+0x21/0x60
[  593.006482]  __x64_sys_removexattr+0x36/0x40
[  593.007642]  do_syscall_64+0x3b/0x90
[  593.008705]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  593.010066] RIP: 0033:0x7ffff7eb50db
[  593.011046] Code: f0 ff ff 73 01 c3 48 8b 0d b2 ad 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 008
[  593.016065] RSP: 002b:00007fffffff9aa8 EFLAGS: 00000202 ORIG_RAX: 00000000000000c5
[  593.018080] RAX: ffffffffffffffda RBX: 00007fffffff9ad0 RCX: 00007ffff7eb50db
[  593.019972] RDX: 0000000000000000 RSI: 00007fffffff9ad0 RDI: 000055555556d440
[  593.021962] RBP: 000000000007a120 R08: 0000000000000000 R09: 00007fffffff9940
[  593.023857] R10: 00005555555640da R11: 0000000000000202 R12: 0000000000000014
[  593.025762] R13: 8f5c28f5c28f5c29 R14: 0000555555559b60 R15: 0000000000000014
[  593.027838]  </TASK>
[  593.028466] Modules linked in:
[  593.029386] CR2: 0000000000000008
[  593.030367] ---[ end trace 0ad9df144b556115 ]---
[  593.031704] RIP: 0010:ext4_fc_mark_ineligible+0xa4/0xf0
[  593.033243] Code: 89 f7 e8 cf 94 7b 01 4d 85 ed 74 35 49 81 fd 00 f0 ff ff 77 2c 4c 89 ef e8 e9 bd dc ff 4d0
[  593.038371] RSP: 0018:ffff88803e2b79d0 EFLAGS: 00010286
[  593.039860] RAX: 0000000000000000 RBX: ffff88802b385000 RCX: ffffffff816c3394
[  593.041857] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000008
[  593.043856] RBP: ffff88803e2b79f0 R08: ffffffff816c3394 R09: 0000000000000000
[  593.045929] R10: ffffffff84535983 R11: fffffbfff08a6b30 R12: 0000000000000000
[  593.047903] R13: 0000000000000000 R14: ffff88802b385e50 R15: ffff8880734574d0
[  593.050009] FS:  00007ffff7d92740(0000) GS:ffff888118600000(0000) knlGS:0000000000000000
[  593.052350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  593.053968] CR2: 0000000000000008 CR3: 000000000ae3c000 CR4: 00000000000006e0
[  593.056027] note: fsstress[20440] exited with preempt_count 1
[  593.721992] EXT4-fs (loop3): shut down requested (2)

SECTION       -- ext4_4k_fc
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 qemu 5.16.0-rc4+ #183 SMP PREEMPT Thu Jan 13 18:17:40 IST 2022
MKFS_OPTIONS  -- -I 256 -O fast_commit,64bit -F -b 4096 /dev/loop3
MOUNT_OPTIONS -- -o data=ordered /dev/loop3 /mnt1/scratch


-ritesh


>
> Thanks,
> Xin Yin
> >
> >
> > -ritesh
> >
> >
> >
> > >
> > > > >
> > > > > Hi Harshad, could you give some advice?  it seems you also need to
> > > > > change this part in your following patches.
> > > > >
> > > > > Thanks,
> > > > > Xin Yin
> > > > >
> > > > > On Mon, Jan 10, 2022 at 5:23 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > > >
> > > > > > Hi Xin,
> > > > > >
> > > > > > url:    https://github.com/0day-ci/linux/commits/Xin-Yin/ext4-fix-issues-when-fast-commit-work-with-jbd/20220107-201314
> > > > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> > > > > > config: x86_64-randconfig-m001-20220107 (https://download.01.org/0day-ci/archive/20220109/202201091544.W5HHEXAp-lkp@intel.com/config)
> > > > > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > > > >
> > > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > >
> > > > > > New smatch warnings:
> > > > > > fs/ext4/inode.c:340 ext4_evict_inode() error: uninitialized symbol 'handle'.
> > > > > >
> > > > > > vim +/handle +340 fs/ext4/inode.c
> > > > > >
> > > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  167  void ext4_evict_inode(struct inode *inode)
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  168  {
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  169       handle_t *handle;
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  170       int err;
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  171       /*
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  172        * Credits for final inode cleanup and freeing:
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  173        * sb + inode (ext4_orphan_del()), block bitmap, group descriptor
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  174        * (xattr block freeing), bitmap, group descriptor (inode freeing)
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  175        */
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  176       int extra_credits = 6;
> > > > > > 0421a189bc8cde Tahsin Erdogan     2017-06-22  177       struct ext4_xattr_inode_array *ea_inode_array = NULL;
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  178       bool freeze_protected = false;
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  179
> > > > > > 7ff9c073dd4d72 Theodore Ts'o      2010-11-08  180       trace_ext4_evict_inode(inode);
> > > > > > 2581fdc810889f Jiaying Zhang      2011-08-13  181
> > > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  182       if (inode->i_nlink) {
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  183               /*
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  184                * When journalling data dirty buffers are tracked only in the
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  185                * journal. So although mm thinks everything is clean and
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  186                * ready for reaping the inode might still have some pages to
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  187                * write in the running transaction or waiting to be
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  188                * checkpointed. Thus calling jbd2_journal_invalidatepage()
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  189                * (via truncate_inode_pages()) to discard these buffers can
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  190                * cause data loss. Also even if we did not discard these
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  191                * buffers, we would have no way to find them after the inode
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  192                * is reaped and thus user could see stale data if he tries to
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  193                * read them before the transaction is checkpointed. So be
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  194                * careful and force everything to disk here... We use
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  195                * ei->i_datasync_tid to store the newest transaction
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  196                * containing inode's data.
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  197                *
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  198                * Note that directories do not have this problem because they
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  199                * don't use page cache.
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  200                */
> > > > > > 6a7fd522a7c94c Vegard Nossum      2016-07-04  201               if (inode->i_ino != EXT4_JOURNAL_INO &&
> > > > > > 6a7fd522a7c94c Vegard Nossum      2016-07-04  202                   ext4_should_journal_data(inode) &&
> > > > > > 3abb1a0fc2871f Jan Kara           2017-06-22  203                   (S_ISLNK(inode->i_mode) || S_ISREG(inode->i_mode)) &&
> > > > > > 3abb1a0fc2871f Jan Kara           2017-06-22  204                   inode->i_data.nrpages) {
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  205                       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  206                       tid_t commit_tid = EXT4_I(inode)->i_datasync_tid;
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  207
> > > > > > d76a3a77113db0 Theodore Ts'o      2013-04-03  208                       jbd2_complete_transaction(journal, commit_tid);
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  209                       filemap_write_and_wait(&inode->i_data);
> > > > > > 2d859db3e4a82a Jan Kara           2011-07-26  210               }
> > > > > > 91b0abe36a7b2b Johannes Weiner    2014-04-03  211               truncate_inode_pages_final(&inode->i_data);
> > > > > > 5dc23bdd5f846e Jan Kara           2013-06-04  212
> > > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  213               goto no_delete;
> > > > > >
> > > > > > Assume we hit this goto
> > > > > >
> > > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  214       }
> > > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  215
> > > > > > e2bfb088fac03c Theodore Ts'o      2014-10-05  216       if (is_bad_inode(inode))
> > > > > > e2bfb088fac03c Theodore Ts'o      2014-10-05  217               goto no_delete;
> > > > > > 871a293155a245 Christoph Hellwig  2010-03-03  218       dquot_initialize(inode);
> > > > > > 907f4554e2521c Christoph Hellwig  2010-03-03  219
> > > > > > 678aaf481496b0 Jan Kara           2008-07-11  220       if (ext4_should_order_data(inode))
> > > > > > 678aaf481496b0 Jan Kara           2008-07-11  221               ext4_begin_ordered_truncate(inode, 0);
> > > > > > 91b0abe36a7b2b Johannes Weiner    2014-04-03  222       truncate_inode_pages_final(&inode->i_data);
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  223
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  224       /*
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  225        * For inodes with journalled data, transaction commit could have
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  226        * dirtied the inode. Flush worker is ignoring it because of I_FREEING
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  227        * flag but we still need to remove the inode from the writeback lists.
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  228        */
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  229       if (!list_empty_careful(&inode->i_io_list)) {
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  230               WARN_ON_ONCE(!ext4_should_journal_data(inode));
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  231               inode_io_list_del(inode);
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  232       }
> > > > > > ceff86fddae874 Jan Kara           2020-04-21  233
> > > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  234       /*
> > > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  235        * Protect us against freezing - iput() caller didn't have to have any
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  236        * protection against it. When we are in a running transaction though,
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  237        * we are already protected against freezing and we cannot grab further
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  238        * protection due to lock ordering constraints.
> > > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  239        */
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  240       if (!ext4_journal_current_handle()) {
> > > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  241               sb_start_intwrite(inode->i_sb);
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  242               freeze_protected = true;
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  243       }
> > > > > > e50e5129f384ae Andreas Dilger     2017-06-21  244
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  245       if (!IS_NOQUOTA(inode))
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  246               extra_credits += EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb);
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  247
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  248       /*
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  249        * Block bitmap, group descriptor, and inode are accounted in both
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  250        * ext4_blocks_for_truncate() and extra_credits. So subtract 3.
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  251        */
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  252       handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE,
> > > > > > 65db869c754e7c Jan Kara           2019-11-05  253                        ext4_blocks_for_truncate(inode) + extra_credits - 3);
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  254       if (IS_ERR(handle)) {
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  255               ext4_std_error(inode->i_sb, PTR_ERR(handle));
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  256               /*
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  257                * If we're going to skip the normal cleanup, we still need to
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  258                * make sure that the in-core orphan linked list is properly
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  259                * cleaned up.
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  260                */
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  261               ext4_orphan_del(NULL, inode);
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  262               if (freeze_protected)
> > > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  263                       sb_end_intwrite(inode->i_sb);
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  264               goto no_delete;
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  265       }
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  266
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  267       if (IS_SYNC(inode))
> > > > > > 0390131ba84fd3 Frank Mayhar       2009-01-07  268               ext4_handle_sync(handle);
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  269
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  270       /*
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  271        * Set inode->i_size to 0 before calling ext4_truncate(). We need
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  272        * special handling of symlinks here because i_size is used to
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  273        * determine whether ext4_inode_info->i_data contains symlink data or
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  274        * block mappings. Setting i_size to 0 will remove its fast symlink
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  275        * status. Erase i_data so that it becomes a valid empty block map.
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  276        */
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  277       if (ext4_inode_is_fast_symlink(inode))
> > > > > > 407cd7fb83c0eb Tahsin Erdogan     2017-07-04  278               memset(EXT4_I(inode)->i_data, 0, sizeof(EXT4_I(inode)->i_data));
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  279       inode->i_size = 0;
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  280       err = ext4_mark_inode_dirty(handle, inode);
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  281       if (err) {
> > > > > > 12062dddda4509 Eric Sandeen       2010-02-15  282               ext4_warning(inode->i_sb,
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  283                            "couldn't mark inode dirty (err %d)", err);
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  284               goto stop_handle;
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  285       }
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  286       if (inode->i_blocks) {
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  287               err = ext4_truncate(inode);
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  288               if (err) {
> > > > > > 54d3adbc29f0c7 Theodore Ts'o      2020-03-28  289                       ext4_error_err(inode->i_sb, -err,
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  290                                      "couldn't truncate inode %lu (err %d)",
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  291                                      inode->i_ino, err);
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  292                       goto stop_handle;
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  293               }
> > > > > > 2c98eb5ea24976 Theodore Ts'o      2016-11-13  294       }
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  295
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  296       /* Remove xattr references. */
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  297       err = ext4_xattr_delete_inode(handle, inode, &ea_inode_array,
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  298                                     extra_credits);
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  299       if (err) {
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  300               ext4_warning(inode->i_sb, "xattr delete (err %d)", err);
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  301  stop_handle:
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  302               ext4_journal_stop(handle);
> > > > > > 4538821993f448 Theodore Ts'o      2010-07-29  303               ext4_orphan_del(NULL, inode);
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  304               if (freeze_protected)
> > > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  305                       sb_end_intwrite(inode->i_sb);
> > > > > > 30a7eb970c3aae Tahsin Erdogan     2017-06-22  306               ext4_xattr_inode_array_free(ea_inode_array);
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  307               goto no_delete;
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  308       }
> > > > > > bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  309
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  310       /*
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  311        * Kill off the orphan record which ext4_truncate created.
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  312        * AKPM: I think this can be inside the above `if'.
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  313        * Note that ext4_orphan_del() has to be able to cope with the
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  314        * deletion of a non-existent orphan - this is because we don't
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  315        * know if ext4_truncate() actually created an orphan record.
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  316        * (Well, we could do this if we need to, but heck - it works)
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  317        */
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  318       ext4_orphan_del(handle, inode);
> > > > > > 5ffff834322281 Arnd Bergmann      2018-07-29  319       EXT4_I(inode)->i_dtime  = (__u32)ktime_get_real_seconds();
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  320
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  321       /*
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  322        * One subtle ordering requirement: if anything has gone wrong
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  323        * (transaction abort, IO errors, whatever), then we can still
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  324        * do these next steps (the fs will already have been marked as
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  325        * having errors), but we can't free the inode if the mark_dirty
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  326        * fails.
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  327        */
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  328       if (ext4_mark_inode_dirty(handle, inode))
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  329               /* If that failed, just do the required in-core inode clear. */
> > > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  330               ext4_clear_inode(inode);
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  331       else
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  332               ext4_free_inode(handle, inode);
> > > > > > 617ba13b31fbf5 Mingming Cao       2006-10-11  333       ext4_journal_stop(handle);
> > > > > > 46e294efc355c4 Jan Kara           2020-11-27  334       if (freeze_protected)
> > > > > > 8e8ad8a57c75f3 Jan Kara           2012-06-12  335               sb_end_intwrite(inode->i_sb);
> > > > > > 0421a189bc8cde Tahsin Erdogan     2017-06-22  336       ext4_xattr_inode_array_free(ea_inode_array);
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  337       return;
> > > > > > ac27a0ec112a08 Dave Kleikamp      2006-10-11  338  no_delete:
> > > > > > b21ebf143af219 Harshad Shirwadkar 2020-11-05  339       if (!list_empty(&EXT4_I(inode)->i_fc_list))
> > > > > >
> > > > > > It's not clear without more context where this ->i_fc_list list is
> > > > > > modified.
> > > > > >
> > > > > > db40129f85538a Xin Yin            2022-01-07 @340               ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, handle);
> > > > > >
> > > > > > "handle" might be uninitialized?
> > > > > >
> > > > > > 0930fcc1ee2f0a Al Viro            2010-06-07  341       ext4_clear_inode(inode);        /* We must guarantee clearing of inode... */
> > > > > > 9d0be50230b333 Theodore Ts'o      2010-01-01  342  }
> > > > > >
> > > > > > ---
> > > > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > > > >
