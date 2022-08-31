Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F475A7AFF
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Aug 2022 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiHaKJQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Aug 2022 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiHaKJP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 Aug 2022 06:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAD1CE456
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 03:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA131615F0
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 10:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3563CC433D6
        for <linux-ext4@vger.kernel.org>; Wed, 31 Aug 2022 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661940553;
        bh=GpGunMKx4PLqCAPpizKQCuZwOwF/z7cLoWGtWxAO5FE=;
        h=From:To:Subject:Date:From;
        b=ciLfxsl4lsN0bvlu2/VHGtY2C0VqkTtuoW44vnS1LqI7vuAoUrURZzfa9kXM/sHLM
         lQxn44oDawFMa0EDErS8GR43Xzb73Tk2DEdk0tvybOxkChktYGQ5IdjK3eDM5S71VS
         ZPEEJG/UxsH4EUQ5rVMC45FvNvPRPjH0mH38iF54VoI4GuiRgtapoIMi3DGL9E/16c
         kT7n9BMfm0NL5LYf1Y0qJOq317YBz0d/J069oRysQ9ZH01O+XNiVMTWrNoXUPZr/y2
         Ae9lnrXcYL48YIVKmXHej/iBMCjlaH/OzDUS9mfMND+F338gg+onj1ER/vk1SdVaho
         bW9RzDYaUeUUg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E9B47C433E7; Wed, 31 Aug 2022 10:09:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 216430] New: mdtest may pause for 5-10 mins on ext4
Date:   Wed, 31 Aug 2022 10:09:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: sunjunchao2870@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216430-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216430

            Bug ID: 216430
           Summary: mdtest may pause for 5-10 mins on ext4
           Product: File System
           Version: 2.5
    Kernel Version: 5.10
          Hardware: AMD
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: sunjunchao2870@gmail.com
        Regression: No

Created attachment 301705
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D301705&action=3Dedit
mdtest may pause for 5-10 mins on ext4

Hi, all. Recenlty we ran mdtest on ext4, and observed a wired phenomenon:

After ran some mdtest cases, mdtest will pause for 5-10mins, this impacts
performance of ext4 severely. And we can not repro this on xfs.

Some information about machine:

[root@client2 mnt_ramdisk2]# lscpu=20
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                128
On-line CPU(s) list:   0-127
Thread(s) per core:    2
Core(s) per socket:    32
Socket(s):             2
NUMA node(s):          2
Vendor ID:             AuthenticAMD
CPU family:            25
Model:                 1
Model name:            AMD EPYC 7543 32-Core Processor
Stepping:              1
CPU MHz:               1799.746
CPU max MHz:           3737.8899
CPU min MHz:           1500.0000
BogoMIPS:              5599.80
Virtualization:        AMD-V
L1d cache:             32K
L1i cache:             32K
L2 cache:              512K
L3 cache:              32768K
NUMA node0 CPU(s):     0-31,64-95
NUMA node1 CPU(s):     32-63,96-127
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge=
 mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe=
1gb
rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmpe=
rf
pni pclmulqdq monitor ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt=
 aes
xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a
misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core
perfctr_nb bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 invpcid_single hw_pst=
ate
sme ssbd mba sev ibrs ibpb stibp vmmcall sev_es fsgsbase bmi1 avx2 smep bmi2
invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsaveopt xsavec
xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irp=
erf
xsaveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_sca=
le
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload
vgif umip pku ospke vaes vpclmulqdq rdpid overflow_recov succor smca

[root@client2 ~]# uname  -r
5.10.139-default

We could also reproduced with 5.3.18 and 5.15.

We could reproduced this by running:
modprobe brd rd_nr=3D1 rd_size=3D167772160 max_part=3D0
/opt/tools/e2fsprogs/mkfs.ext4 -i 2048 -I 1024 -J size=3D20000
-Odir_index,large_dir,filetype /dev/ram0
echo `blkid /dev/ram0 |awk '{print $2}'` /mnt_ramdisk3 ext4
defaults,noatime,nodiratime,user_xattr,nofail,x-systemd.device-timeout=3D5 =
0 0 >>
/etc/fstab

mount -a
for ((i=3D1;i<=3D100;i++)) ; do  (time  /usr/local/bin/mdtest -R -C -L -F -=
u -z 10
-b 2 -I 1000 -u -d /mnt_ramdisk3/mdtest-$RANDOM) 2>&1 |grep -E " at |real" =
 ;
done

which mnt_ramdisk3 is mounted a ext4 file system with ram or nvme disk. This
problem occured one time per 100 mdtest cases almostly. The test result is
attched.


Any thoughts or hints about this? Let me known if any information is requir=
ed.
Thanks!

Kind regards,
JunChao

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
