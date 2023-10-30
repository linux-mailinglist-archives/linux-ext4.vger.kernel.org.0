Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA097DB4E2
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Oct 2023 09:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJ3IMj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Oct 2023 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjJ3IMi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Oct 2023 04:12:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38048C4
        for <linux-ext4@vger.kernel.org>; Mon, 30 Oct 2023 01:12:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E29EC433C8
        for <linux-ext4@vger.kernel.org>; Mon, 30 Oct 2023 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698653554;
        bh=Bj4k6RjeIx93wFk7YDgD4zrfNXcnmsqY5CoXbJr9X9o=;
        h=From:To:Subject:Date:From;
        b=MRXHztYLRm5yNXkp9osAHcXtBwptg0hcI05PBqBMCBFSHcmc/DYScw+qydqm9JmC8
         0ifhs/RQfx+Oo396UjBHnJNRyHsh0kFUZnc//dVKgA0rlEPMzLkR0hFqv5OmVRXYP0
         gptoGC6RLNgVlPmiCi0Zksr1+lzxwymdLNTgj270JrekI/C5fH/Jtc6wq8xKOhWQqV
         hsJnu7Mo3+1iqeosOro1iOd6t06yOobeqCs6xnuQTciHI3u/cEzZqGus+deEwP183c
         Ilq1NzJf/rO3cpU+Bo2pouL5L9r1XGFs2t9qNfTKLxVn77jDlqdaMS2JTX/6mJc3yn
         wkg30wbv9z6fA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0523AC53BCD; Mon, 30 Oct 2023 08:12:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 218087] New: ext4 hung on kernel 4.14.133
Date:   Mon, 30 Oct 2023 08:12:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: v.ngocdv4@vinfast.vn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218087-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218087

            Bug ID: 218087
           Summary: ext4 hung on kernel 4.14.133
           Product: File System
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: v.ngocdv4@vinfast.vn
        Regression: No

We are developing project on Android 9 which used kernel 4.14.133
version.
And while normal using device, we have a issue device freezing and
reboot after few minute.
I checked the log and saw kernel hung on filesystem as below:

10-02 20:34:17.585  2461  2461 I Kernel  : [15159.873020] sysrq: SysRq : Sh=
ow
Blocked State
10-02 20:34:17.586  2461  2461 I Kernel  : [15159.873071]   task=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
        PC stack   pid father
10-02 20:34:17.586  2461  2461 I Kernel  : [15159.873148] jbd2/xvda3-8    D=
=20=20=20
0  2085      2 0x00000020
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873157] Call trace:
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873177] [<000000005e1d80e=
5>]
__switch_to+0x94/0xd8
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873186] [<00000000a85c718=
4>]
__schedule+0x274/0x940
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873190] [<00000000c9c2c8f=
0>]
schedule+0x40/0xa8
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873197] [<00000000a97520e=
1>]
io_schedule+0x20/0x40
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873206] [<000000001d0a54c=
7>]
wait_on_page_bit+0x144/0x218
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873210] [<00000000a2541ef=
a>]
__filemap_fdatawait_range+0xd4/0x150
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873213] [<0000000035aea85=
4>]
filemap_fdatawait_keep_errors+0x28/0x58
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873223] [<0000000084ab312=
f>]
jbd2_journal_commit_transaction+0x6bc/0x1838
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873228] [<000000007e52cd0=
7>]
kjournald2+0xd8/0x268
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873234] [<00000000f46ec2f=
2>]
kthread+0x138/0x140
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873238] [<000000009e914ea=
4>]
ret_from_fork+0x10/0x1c
10-02 20:34:17.586  2461  2461 I Kernel  : [15159.873274] HwBinder:2156_3 D=
=20=20=20
0  4116      1 0x00000000
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873279] Call trace:
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873282] [<000000005e1d80e=
5>]
__switch_to+0x94/0xd8
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873286] [<00000000a85c718=
4>]
__schedule+0x274/0x940
10-02 20:34:17.586  2461  2461 W Kernel  : [15159.873288] [<00000000c9c2c8f=
0>]
schedule+0x40/0xa8
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873292] [<00000000228469b=
d>]
schedule_timeout+0x204/0x430
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873295] [<000000006c4e158=
8>]
wait_for_common+0xbc/0x178
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873298] [<0000000085ed017=
c>]
wait_for_completion+0x28/0x38
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873303] [<00000000ce130c9=
3>]
flush_work+0x134/0x220
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873309] [<00000000cd75762=
d>]
drm_mode_rmfb+0x130/0x1a8
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873317] [<000000002c2f9c4=
3>]
drm_ioctl_kernel+0x70/0xd0
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873320] [<000000005902551=
e>]
drm_ioctl+0x1e4/0x450
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873327] [<00000000d4238d5=
7>]
do_vfs_ioctl+0xc4/0xb40
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873330] [<0000000003b80d0=
6>]
SyS_ioctl+0x8c/0xa8
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873334] Exception
stack(0xffff00000fc13ec0 to 0xffff00000fc14000)
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873340] 3ec0:
0000000000000003 00000000c00464af 0000fe8cb41ee684 0000000000000001
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873344] 3ee0:
000000000000002c 0000fe8cb4c630c0 000000090000001e 0000000007800000
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873348] 3f00:
000000000000001d 0000fe8cb41ee5f8 0000fe8cb41ee5f8 0000fe8cb41ee640
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873352] 3f20:
000000000000000c 0000000000000001 0000000000000000 fffffffffffffff0
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873356] 3f40:
0000fe8cb5c6fd90 0000fe8cb51e90e0 0000fe8cb4c630c0 0000fe8cb41ef588
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873360] 3f60:
00000000c00464af 0000000000000003 0000fe8cb4446960 0000fe8cb41ee89c
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873364] 3f80:
0000c04ee2bd66c5 0000c04ee2bd74f3 00000000000000ff 00000000ffffffff
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873368] 3fa0:
0000fe8cb4c2b540 0000fe8cb41ee630 0000fe8cb51e916c 0000fe8cb41ee540
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873372] 3fc0:
0000fe8cb522f758 00000000a0000000 0000000000000003 000000000000001d
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873376] 3fe0:
0000000000000000 0000000000000000 0000000000000000 0000000000000000
10-02 20:34:17.587  2461  2461 W Kernel  : [15159.873381] [<000000008094bac=
4>]
el0_svc_naked+0x34/0x38
10-02 20:34:17.588  2461  2461 I Kernel  : [15159.873452] PackageManager  D=
=20=20=20
0  2657   2121 0x00000009
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873457] Call trace:
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873461] [<000000005e1d80e=
5>]
__switch_to+0x94/0xd8
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873464] [<00000000a85c718=
4>]
__schedule+0x274/0x940
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873467] [<00000000c9c2c8f=
0>]
schedule+0x40/0xa8
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873472] [<00000000d374050=
7>]
jbd2_log_wait_commit+0xc0/0x158
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873477] [<0000000036159c5=
c>]
jbd2_complete_transaction+0x90/0xc0
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873483] [<0000000019ee473=
a>]
ext4_sync_file+0x440/0x488
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873490] [<00000000665d0f6=
9>]
vfs_fsync_range+0x64/0xc0
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873493] [<0000000035c0b34=
8>]
do_fsync+0x48/0x88
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873496] [<000000006f18433=
e>]
SyS_fsync+0x24/0x38
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873499] Exception
stack(0xffff00000b01bec0 to 0xffff00000b01c000)
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873503] bec0:
00000000000000fb 0000e6a41540bb64 000000006f4c7d34 0000000000000000
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873507] bee0:
00000000137c08e4 000000000000216e 0000216e0000216e 000000000000216e
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873511] bf00:
0000000000000052 d4d524bf9be44442 0000000000430000 0000e6a42f7e0688
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873515] bf20:
0000000077ef52e8 0000000000000000 000000006f71f9d8 0000000000003f0d
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873519] bf40:
0000e6a429b23e30 0000e6a4b1eb2c00 0000000077ef52e8 00000000000000fb
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873523] bf60:
00000000ffffffff 00000000137c08d0 0000000000e60ce4 0000000000e60ce4
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873527] bf80:
00000000137c01e8 00000000137c03a8 00000000137c0850 00000000137c08e0
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873531] bfa0:
00000000137c2908 0000e6a41540bb20 0000e6a429b076b4 0000e6a41540bb10
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873535] bfc0:
0000e6a4b1eb2c08 0000000060000000 00000000000000fb 0000000000000052
10-02 20:34:17.588  2461  2461 W Kernel  : [15159.873539] bfe0:
0000000000000000 0000000000000000 0000000000000000 0000000000000000
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873542] [<000000008094bac=
4>]
el0_svc_naked+0x34/0x38
10-02 20:34:17.589  2461  2461 I Kernel  : [15159.873869] Thread-52       D=
=20=20=20
0  4475   2121 0x00000008
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873874] Call trace:
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873878] [<000000005e1d80e=
5>]
__switch_to+0x94/0xd8
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873882] [<00000000a85c718=
4>]
__schedule+0x274/0x940
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873885] [<00000000c9c2c8f=
0>]
schedule+0x40/0xa8
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873889] [<00000000d374050=
7>]
jbd2_log_wait_commit+0xc0/0x158
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873892] [<0000000036159c5=
c>]
jbd2_complete_transaction+0x90/0xc0
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873896] [<0000000019ee473=
a>]
ext4_sync_file+0x440/0x488
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873901] [<00000000665d0f6=
9>]
vfs_fsync_range+0x64/0xc0
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873903] [<0000000035c0b34=
8>]
do_fsync+0x48/0x88
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873906] [<000000006f18433=
e>]
SyS_fsync+0x24/0x38
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873909] Exception
stack(0xffff00002228bec0 to 0xffff00002228c000)
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873913] bec0:
000000000000001e 0000e6a404184824 000000006f4c7d34 0000000077f8f00c
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873918] bee0:
0000000000000002 00000000000000a9 0000e6a4b5237000 0000000000729bee
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873922] bf00:
0000000000000052 d4d524bf9be44442 0000000000430000 0000e6a42f7e0688
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873926] bf20:
0000000000000018 00000003e8000000 002e5f5680000000 0000474a00000000
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873930] bf40:
0000e6a429b23e30 0000e6a4b1eb2c00 0000000077f7e15e 000000000000001e
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873934] bf60:
00000000ffffffff 0000000013049b60 0000000013207c88 0000000013049ae0
10-02 20:34:17.589  2461  2461 W Kernel  : [15159.873938] bf80:
00000000000001b4 00000000000001b0 0000000013207d30 0000018af09743e6
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.873942] bfa0:
0000e6a42f70ac23 0000e6a4041847e0 0000e6a429b076b4 0000e6a4041847d0
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.873946] bfc0:
0000e6a4b1eb2c08 0000000060000000 000000000000001e 0000000000000052
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.873950] bfe0:
0000000000000000 0000000000000000 0000000000000000 0000000000000000
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.873952] [<000000008094bac=
4>]
el0_svc_naked+0x34/0x38
10-02 20:34:17.590  2461  2461 I Kernel  : [15159.874135] kworker/u12:3   D=
=20=20=20
0  9578      2 0x00000020
10-02 20:34:17.590  2461  2461 I Kernel  : [15159.874149] Workqueue: writeb=
ack
wb_workfn (flush-202:3)
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874154] Call trace:
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874157] [<000000005e1d80e=
5>]
__switch_to+0x94/0xd8
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874161] [<00000000a85c718=
4>]
__schedule+0x274/0x940
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874163] [<00000000c9c2c8f=
0>]
schedule+0x40/0xa8
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874167] [<00000000a97520e=
1>]
io_schedule+0x20/0x40
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874175] [<000000008d5c36d=
0>]
blk_mq_get_tag+0x194/0x340
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874178] [<00000000f97393c=
b>]
blk_mq_get_request+0x164/0x3b0
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874181] [<00000000e69c8e5=
8>]
blk_mq_make_request+0xc8/0x6f8
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874187] [<00000000e88e745=
3>]
generic_make_request+0xf4/0x288
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874190] [<0000000016cf2ad=
d>]
submit_bio+0x5c/0x1d0
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874196] [<0000000097be470=
8>]
ext4_io_submit+0x54/0x68
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874199] [<00000000e9c80f0=
0>]
ext4_bio_write_page+0x1b0/0x528
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874202] [<000000009bf94ba=
d>]
mpage_submit_page+0x60/0x90
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874205] [<00000000da1a958=
5>]
mpage_map_and_submit_buffers+0x138/0x238
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874208] [<00000000c84c3e1=
4>]
ext4_writepages+0x8dc/0xe08
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874214] [<000000007a345b1=
0>]
do_writepages+0x5c/0x108
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874217] [<00000000ef1a522=
d>]
__writeback_single_inode+0x48/0x4f8
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874220] [<00000000aeac1ba=
5>]
writeback_sb_inodes+0x1c0/0x470
10-02 20:34:17.590  2461  2461 W Kernel  : [15159.874223] [<00000000f7f818b=
4>]
__writeback_inodes_wb+0x78/0xc8
10-02 20:34:17.591  2461  2461 W Kernel  : [15159.874225] [<00000000ae30bb5=
6>]
wb_writeback+0x24c/0x3d8
10-02 20:34:17.591  2461  2461 W Kernel  : [15159.874228] [<00000000b489a91=
f>]
wb_workfn+0x1c4/0x490
10-02 20:34:17.591  2461  2461 W Kernel  : [15159.874233] [<000000004df896a=
9>]
process_one_work+0x1d8/0x498
10-02 20:34:17.591  2461  2461 W Kernel  : [15159.874236] [<00000000d7fa6dd=
7>]
worker_thread+0x4c/0x478
10-02 20:34:17.591  2461  2461 W Kernel  : [15159.874240] [<00000000f46ec2f=
2>]
kthread+0x138/0x140
10-02 20:34:17.591  2461  2461 W Kernel  : [15159.874243] [<000000009e914ea=
4>]
ret_from_fork+0x10/0x1c


The issue happen one time, And I can't reproduce it

Thank you

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
