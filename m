Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA39119ABCC
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbgDAMiW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 08:38:22 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:42097 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbgDAMiV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 08:38:21 -0400
Received: by mail-qk1-f179.google.com with SMTP id 139so16878522qkd.9
        for <linux-ext4@vger.kernel.org>; Wed, 01 Apr 2020 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=YGFjO0wz1oUe3Q7lbI+90ID2Sy9a3w+Ee/XP7QhsOew=;
        b=lwbpRa+3n1SS1uMBYemwYSsojYi9AW4ThWRP6l85tg2ycQ6f2bAAZRtfZpHBJCx2e2
         tsAE4nudZanyaZ71Ht7UcqlTlC6Lwc7nQIueeRCfT4wgk3NMbIxvYobPAWSIEB4Z0K/A
         ERDTy7N5LloL7l5CBUJ8wqgsjqEki9kD/ZAzfuiX7hF/cF6wZVoPtM0uXfeJuYxOlcaw
         88v7bxtY9jIKh6VfXrdf4DGY3B4FJ6ScJOpoaAgZdcHFEteW6HQ2/sHp2pdIC3L8HJZO
         pzg+NSWzuK2o3OXRoJd//5Tje3LgsahibbtF1ILPE2cTllIOQXSKbOJ6gwG+Q8yxIkWn
         /TOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=YGFjO0wz1oUe3Q7lbI+90ID2Sy9a3w+Ee/XP7QhsOew=;
        b=ubkE/yKSNZtFMILE1owuLl4w8v5MV2ADhlsCZoyjUqRcL/yetk4T3sZnE5kUTJZHRE
         5DmXZdDpjEG1plAJ12BcOqYCdvJqwyjO3XInG7X35s6vfe1siG1xLv/RIVZirfi9yLua
         UR4qGOiJV6CZHek3Fi96aI+v9QHKfwHhQTW06QkVpGC9A1pqvNW+VmKy6lmi9+KFZErm
         2lXocHVCBSCng9SdNNpzfTLj0mAH5Wgl2rzyB1MpFF82+dFoTnvf494Tsibj0nxs7oSL
         JATJRKIMi5RqMU64l7UagPQHo2zC5umuEXvVkGTyEV8bwdlywgKOr1DsWakuAFlyDBkj
         3H9A==
X-Gm-Message-State: ANhLgQ0ggE2AysYkA9N02KyRcVeyUUo0A1BYETz/NjU88ePt4agZh0V0
        zMboL0zX36vt1t+Yz2ehii0GGQ==
X-Google-Smtp-Source: ADFU+vt46CZ7QdWzidCgLkyN41uEQiw1qWJu2SsrTbImDr4OUOL8Z08IKth8E+zvvMCimjNnE5Aslg==
X-Received: by 2002:a37:a505:: with SMTP id o5mr9298206qke.30.1585744698802;
        Wed, 01 Apr 2020 05:38:18 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f1sm1284471qkl.72.2020.04.01.05.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 05:38:18 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: spontaneous crash with "ext4: move ext4 bmap to use iomap
 infrastructure"
Message-Id: <B97A26CF-3511-40D2-82B6-D8BCC7F2DE74@lca.pw>
Date:   Wed, 1 Apr 2020 08:38:16 -0400
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It is not always reproducible so far, but it start to show up on =
today=E2=80=99s linux-next. Look
Trough the commits and noticed this recent one matched the new call =
traces,

ac58e4fb03f9 (=E2=80=9Cext4: move ext4 bmap to use iomap =
infrastructure")

Thought?

[  206.744625][T13224] LTP: starting fallocate04
[  207.601583][T27684] /dev/zero: Can't open blockdev
[  208.674301][T27684] EXT4-fs (loop0): mounting ext3 file system using =
the ext4 subsystem
[  208.680347][T27684] BUG: Unable to handle kernel instruction fetch =
(NULL pointer?)
[  208.680383][T27684] Faulting instruction address: 0x00000000
[  208.680406][T27684] Oops: Kernel access of bad area, sig: 11 [#1]
[  208.680439][T27684] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
[  208.680474][T27684] Modules linked in: ext4 crc16 mbcache jbd2 loop =
kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio tg3 =
libata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
[  208.680576][T27684] CPU: 117 PID: 27684 Comm: fallocate04 Tainted: G  =
      W         5.6.0-next-20200401+ #288
[  208.680614][T27684] NIP:  0000000000000000 LR: c0080000102c0048 CTR: =
0000000000000000
[  208.680657][T27684] REGS: c000200361def420 TRAP: 0400   Tainted: G    =
    W          (5.6.0-next-20200401+)
[  208.680700][T27684] MSR:  900000004280b033 =
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 42022228  XER: 20040000
[  208.680760][T27684] CFAR: c00800001032c494 IRQMASK: 0=20
[  208.680760][T27684] GPR00: c0000000005ac3f8 c000200361def6b0 =
c00000000165c200 c00020107dae0bd0=20
[  208.680760][T27684] GPR04: 0000000000000000 0000000000000400 =
0000000000000000 0000000000000000=20
[  208.680760][T27684] GPR08: c000200361def6e8 c0080000102c0040 =
000000007fffffff c000000001614e80=20
[  208.680760][T27684] GPR12: 0000000000000000 c000201fff671280 =
0000000000000000 0000000000000002=20
[  208.680760][T27684] GPR16: 0000000000000002 0000000000040001 =
c00020030f5a1000 c00020030f5a1548=20
[  208.680760][T27684] GPR20: c0000000015fbad8 c00000000168c654 =
c000200361def818 c0000000005b4c10=20
[  208.680760][T27684] GPR24: 0000000000000000 c0080000103365b8 =
c00020107dae0bd0 0000000000000400=20
[  208.680760][T27684] GPR28: c00000000168c3a8 0000000000000000 =
0000000000000000 0000000000000000=20
[  208.681014][T27684] NIP [0000000000000000] 0x0
[  208.681065][T27684] LR [c0080000102c0048] ext4_iomap_end+0x8/0x30 =
[ext4]
[  208.681091][T27684] Call Trace:
[  208.681129][T27684] [c000200361def6b0] [c0000000005ac3bc] =
iomap_apply+0x20c/0x920 (unreliable)
iomap_apply at fs/iomap/apply.c:80 (discriminator 4)
[  208.681173][T27684] [c000200361def7f0] [c0000000005b4adc] =
iomap_bmap+0xfc/0x160
iomap_bmap at fs/iomap/fiemap.c:142
[  208.681228][T27684] [c000200361def850] [c0080000102c2c1c] =
ext4_bmap+0xa4/0x180 [ext4]
ext4_bmap at fs/ext4/inode.c:3213
[  208.681260][T27684] [c000200361def890] [c0000000004f71fc] =
bmap+0x4c/0x80
[  208.681281][T27684] [c000200361def8c0] [c00800000fdb0acc] =
jbd2_journal_init_inode+0x44/0x1a0 [jbd2]
jbd2_journal_init_inode at fs/jbd2/journal.c:1255
[  208.681326][T27684] [c000200361def960] [c00800001031c808] =
ext4_load_journal+0x440/0x860 [ext4]
[  208.681371][T27684] [c000200361defa30] [c008000010322a14] =
ext4_fill_super+0x342c/0x3ab0 [ext4]
[  208.681414][T27684] [c000200361defba0] [c0000000004cb0bc] =
mount_bdev+0x25c/0x290
[  208.681478][T27684] [c000200361defc40] [c008000010310250] =
ext4_mount+0x28/0x50 [ext4]
[  208.681520][T27684] [c000200361defc60] [c00000000053242c] =
legacy_get_tree+0x4c/0xb0
[  208.681556][T27684] [c000200361defc90] [c0000000004c864c] =
vfs_get_tree+0x4c/0x130
[  208.681593][T27684] [c000200361defd00] [c00000000050a1c8] =
do_mount+0xa18/0xc50
[  208.681641][T27684] [c000200361defdd0] [c00000000050a9a8] =
sys_mount+0x158/0x180
[  208.681679][T27684] [c000200361defe20] [c00000000000b3f8] =
system_call+0x5c/0x68
[  208.681726][T27684] Instruction dump:
[  208.681747][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX=20
[  208.681797][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX=20
[  208.681839][T27684] ---[ end trace 4e9e2bab7f1d4048 ]---
[  208.802259][T27684]=20
[  209.802373][T27684] Kernel panic - not syncing: Fatal exception=
