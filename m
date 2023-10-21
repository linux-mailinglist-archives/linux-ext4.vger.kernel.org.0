Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9615B7D1C5C
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Oct 2023 12:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjJUKHx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Oct 2023 06:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUKHx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Oct 2023 06:07:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BB1A3
        for <linux-ext4@vger.kernel.org>; Sat, 21 Oct 2023 03:07:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C21E3C433CB
        for <linux-ext4@vger.kernel.org>; Sat, 21 Oct 2023 10:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697882870;
        bh=isUX/A7LYll4EVyRd/9BOjv8klj3zg2AfLV9iQ/xl6k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vHWwu3asWa4Iwxkyl1sBzO5wWpYwDbCCWuSu2l1SMmx1SpcZPMgKc1xfbkaZLzQkW
         kNUwcSlQ65ATz/9F2xV5De6II6u4aXGmEe+iJC3vRhuKKl+VVpPKXu/Jh7HEkd6HDt
         42RqbyLt1wIxRfZNoD+axSbiXx3gFxx37j4FCmaQKTIWL3NLk+KsR5jEW1apOSlgS2
         O13WSghmePN/epOGwc+wl98AyIilQalm3ABSfbCg/EHLO/YmM0PFjAHBfo+ObXPiaA
         /myV/jaccFjqnyZeGfUTKPafTUWKRIdX1KtVOCu72e2rpl8Ynx2HkhRZX2bjPD2OeQ
         Pwa8gGOdI5Mcg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A9BCFC53BD3; Sat, 21 Oct 2023 10:07:50 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Sat, 21 Oct 2023 10:07:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: glandvador@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-bO51tuEU8t@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #18 from Eduard Kohler (glandvador@yahoo.com) ---
Hi Ojaswin,

If you want to replicate something similar to my setup, I better give you m=
ore
info about it, because it's not a desktop computer.

It's a very slow system by current standards and I think it may impact why
there aren't more people complaining about this issue. In Ivan's case it se=
ems
that after a small while, it recovered even with a lot of files. His setup
seems more powerful than mine. In my case pulling a 75MB container with pod=
man
didn't recovered after 2 hours of 100% CPU.

The system has 4G RAM:
# free
               total        used        free      shared  buff/cache=20=20
available
Mem:         3977448      615760      410332       14580     2951356=20=20=
=20=20
3045304
Swap:        1564668           0     1564668

and an AMD G-T40E processor:
# cat /proc/cpuinfo=20
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 20
model           : 2
model name      : AMD G-T40E Processor
stepping        : 0
microcode       : 0x5000119
cpu MHz         : 801.798
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmpe=
rf
pni monitor ssse3 cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse 3dnowprefetch ibs skinit wdt hw_pstate vmmcall arat npt l=
brv
svm_lock nrip_save pausefilter
bugs            : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2
spec_store_bypass
bogomips        : 1999.82
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 20
model           : 2
model name      : AMD G-T40E Processor
stepping        : 0
microcode       : 0x5000119
cpu MHz         : 799.941
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb
rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmpe=
rf
pni monitor ssse3 cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm
sse4a misalignsse 3dnowprefetch ibs skinit wdt hw_pstate vmmcall arat npt l=
brv
svm_lock nrip_save pausefilter
bugs            : fxsave_leak sysret_ss_attrs null_seg spectre_v1 spectre_v2
spec_store_bypass
bogomips        : 1999.82
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate

The raid1 underlying hardware changed from the 2013 from 1T -> 2T -> 4T HDD.
The file system grew up accordingly. During the step 2T -> 4T disk layout w=
as
converted from MBR to GPT:
# gdisk -l /dev/sdb
GPT fdisk (gdisk) version 1.0.9

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with protective MBR; using GPT.
Disk /dev/sdb: 7814037168 sectors, 3.6 TiB
Model: ST4000VN008-2DR1
Sector size (logical/physical): 512/4096 bytes
Disk identifier (GUID): CD6E68D9-1A0F-40F7-9755-FDE136159F92
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 34, last usable sector is 7814037134
Partitions will be aligned on 2048-sector boundaries
Total free space is 1537100 sectors (750.5 MiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048      7812502048   3.6 TiB     8300  primary

And again the raid1 md0 partition table:
# gdisk -l /dev/md0
GPT fdisk (gdisk) version 1.0.9

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

Found valid GPT with protective MBR; using GPT.
Disk /dev/md0: 7812237857 sectors, 3.6 TiB
Sector size (logical/physical): 512/4096 bytes
Disk identifier (GUID): 46C6A662-69D1-492D-A31F-1121048F9FE3
Partition table holds up to 128 entries
Main partition table begins at sector 2 and ends at sector 33
First usable sector is 34, last usable sector is 7812237823
Partitions will be aligned on 2048-sector boundaries
Total free space is 3933 sectors (1.9 MiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048      7812235904   3.6 TiB     8300  Linux filesystem

Last one is the EXT4 filesystem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
