Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789EC3C72B2
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbhGMPBQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 11:01:16 -0400
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:34176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236763AbhGMPBP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 13 Jul 2021 11:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7VEcVP9KrOFIBEFcm3cgI4P4XRKaceMAf+rvNpfqhFClF6717c7iakmIaawTCZ9UzEsZ1bfqgYjXNtTj7df1nACcanZ+bIxgEWMCeqUzOMtFpH1oOwcsbSlySQbZ1VUEOrAATPC7ZQ1rj4s3y27Daon04e+leBugsx+x2FvRuPCCTYv5uv8tbwRcPF92apSaL9oYPx4eFzd07jTu/wHxI/hjjMdblFaWri0foUKz+H/ayL+41HmHvZfTZynv4RKkvZJOQKMeqOJh3qI5RPXhzLvLLQuu+fpPmkXFI6ndshbEeeww5jbhYby94EovxEwwLSt4qZCgmq+WqoxzZVtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIEHqXkLktev5RabZtjnouIDUWPE38G3x8Fhb9RYnBU=;
 b=VjozPtucJLHBIwyw3YZh4K+JRzAJm72exQRdsZ6D4AadMGnQK5BzAZH/Acom9PItPXzrsCDWcFH2fZi4hYC7wb5XQVjUkH1h9XVTdwJ10OBHaD9YJlksuWvbFj00VVXLuyMrB4O+058E1OA0pnTIPSRqWvIH6Ap7A/T5bdTtq1Wm5hNGlVfjy4h8PgPZqbkgB1MT8JlrKnpu2z9hyeypCJTvTFvyc4JF9j2y5x7Ez+sEY8TxYM8lTJBl46lhMorApq1JInh0dWLpXjjX6oWFAMHdp28agpdWpA3/nrSLhIB3meHvPVHwlWH8Q3IG59Ra1hwW3WYN5fqpwr4s4JzACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=urjc.es; dmarc=pass action=none header.from=urjc.es; dkim=pass
 header.d=urjc.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urjc.onmicrosoft.com;
 s=selector2-urjc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIEHqXkLktev5RabZtjnouIDUWPE38G3x8Fhb9RYnBU=;
 b=WV8iFU8i1Q7se42JJhnuCrDCx4JYv5dqiHwc8Z+glSnqcaoYQPvawH8D94FVWazX42uHDWdLvAvgeYt+pDoV+WUvup06yPP6DQpw4d/ydDqrdw/M00y9Yavb5fHotDMSLFkZ9VSvREFE0WdWq5kN8wPYw202UvqYlAdjybwwQCA=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=urjc.es;
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com (2603:10a6:10:5c::15)
 by DBAPR02MB6278.eurprd02.prod.outlook.com (2603:10a6:10:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 14:58:23 +0000
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e]) by DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 14:58:23 +0000
Date:   Tue, 13 Jul 2021 16:58:21 +0200
From:   Javier Pello <javier.pello@urjc.es>
To:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Kernel oopses on ext2 filesystems after 782b76d7abdf
Message-Id: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
Organization: Universidad Rey Juan Carlos
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::33) To DB7PR02MB4663.eurprd02.prod.outlook.com
 (2603:10a6:10:5c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mo-dep2-d036-01.escet.urjc.es (212.128.1.36) by MR2P264CA0141.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 14:58:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dfeb12a-f35a-4442-4735-08d9460ea915
X-MS-TrafficTypeDiagnostic: DBAPR02MB6278:
X-Microsoft-Antispam-PRVS: <DBAPR02MB62789CBA64212A4954895E4A9B149@DBAPR02MB6278.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50zl0qqKt8oIWs7WGU4T6WGHj1IhBKam2oespfbVJpTC7MVSs0eSkHI1XrGzY5Bul5593rSh/DURWQ0ZD9mxVZ37Pb54AKV0257QDRpZGsHNzY1rcvfbJ46TzLkhuEKeNGpWTeZAhoERROF5XRgL83xuGUPfZgbEyYJsnwoHN8tb0Be7kbIeaL/XvivxI1K2EjRi0PGiXymTFVGl41ge6vGrNIKndmn/9obLW03/ESetwG4pPeARcwmwUk6PVJe2T+Aa1zvOd/16jaO6Oa3gyLJOpFwOIRDweCoeieLtoyd2bVPSbi6nsBAHgwfgu3SVdADAJQuXT5TLrF+V4autxZVr9mp6iZhMdhUmRegg2gpb1ar3/xW0/2FwfBc1SE5doPP1bYXbV9YVYNRSe/aTIrC/UU+CFxH/JWnVOYYRivHRVwQYXn2knhBFf8q8YWfXXvCGFElorNLLv09rE7B8BXCyi7S35gQ7aaEiu0KfvIVQ6adO53xedpUJTL0mQdvmHbehBQ4zGoBfzNhsrUMOcq+w4b9UdP5P3RqL0QOWtY9WBgkyglup2Y02bescfzIYf473Bptq4FNf+ZnOWxii4bWEOJsZexI+GsymUdi6k0xnF6lYvgu05xNIhXZUtx2OPjhs9uPUMWnZ0rfvxwt7J9yvVj1wQY/SnOf3Zw5XMDhSTvnp+GqMy+kEj2B4K3QM4O3AkAPd9veZFF+Dbw8rPiVoQjhL4EzJkjgDljMHIlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR02MB4663.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39850400004)(366004)(136003)(956004)(26005)(36756003)(8936002)(36916002)(52116002)(5660300002)(186003)(7696005)(478600001)(8676002)(2616005)(44832011)(83380400001)(1076003)(786003)(316002)(6486002)(2906002)(66476007)(66946007)(86362001)(66556008)(38100700002)(38350700002)(505234006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hK25Uzl+UofqDHlw3aqLlal540yOUz1SlRstvWCpvMHFNB13PPuAFCIHScCP?=
 =?us-ascii?Q?4p/GwB3I52/GMlQjiQyhulTyxdjxgZ4te2I2x07mVaAImuOBpoZQwMimQrwe?=
 =?us-ascii?Q?yAEAO+qwFtInH4d8H7CbkcEQut6fHdtoil+gmkLyx+Gs3d/6s3b6vkuibvZ1?=
 =?us-ascii?Q?JigBwXPCtrBoE8XER6GRfuODotB8IwizFmW3WMDdgqiKdGFVH8PF+dNLmdW4?=
 =?us-ascii?Q?iTuLJA8ignVefNaUTtIOBzVS82WUXTEeMzJ4wsbesj8nuHZP3tlTdqJ8lK3m?=
 =?us-ascii?Q?50O8BzIN3nozrRlAOhAcyZq71I1jmpqvg/gW2kX/4Gu7TpL0Mn1rf7JxFpvv?=
 =?us-ascii?Q?rg/I4OJIvz2Yn3PNTQTy2TBu8+MHA3j1r+7nICg+oyVlrGHuSPu83NCUqoh1?=
 =?us-ascii?Q?FeX1UgBzqDO46Gxor222p4QYQ/dvLeYS7OGmaNMWKXtaZHpRUzddNH3fAd9V?=
 =?us-ascii?Q?8r2RXjwjCEJFVY9KtSl+oVTPRVSw8CiYJCC+PXSSwtFXXDOnQGrzcG8LQonp?=
 =?us-ascii?Q?ZCs3ffC5ooeEjQSV/48EmZHWh+m1lqtXJb8Sfb5Ste7ZfgyiWePZmDmXv5Y8?=
 =?us-ascii?Q?uhfaHGEiLqqIBVHdQsU9axUWfX0SJgVqlZB3vMEQIQyKVY+VrIZ1PN5l+Tkd?=
 =?us-ascii?Q?c+Zy9c6auHLhCnWstrwMSV6riIY4xGq9xJEdHG1YAuWMDDxL9do8rRqC2dP1?=
 =?us-ascii?Q?C99tCkUPGN3fYsr5gigsD+Ac4cHdrLI0Wyoc/XXOoE1pYaW4Zc/hgu8Nu6MA?=
 =?us-ascii?Q?4nxSSA0s4GNam/WE83uWStZp/I+hf1zByWpHca9cX3fsXzBUjr/YLNPu1BF9?=
 =?us-ascii?Q?MWmR9r6V8+lbtjvhSZ4mhRgRawWY/UBgpY7seP+FbkCOl+oglTe5Gktprt+U?=
 =?us-ascii?Q?JnUmwWtFBJOk29Vyek5UmNasM2hPD4yAYZyr9eUx8bywMRUm+U27Fqxbk2lT?=
 =?us-ascii?Q?tO7u5/TWgOHJ5Ymag8ANWw6d73ztTZSXGcOCOsuxTev3K1mCWTdE/xoeLzJf?=
 =?us-ascii?Q?pVSSXP9ulDQ9M61gmw2i/Ji8GeSTKY9jYxCJYODnSAlTqKJbmzWCRfVRv7aP?=
 =?us-ascii?Q?v5XybYIbqN0hyJ7RnPGHR8FVUvo2ypugwkG3PaNA1YjxcQqEbJ9HLzGGWkb1?=
 =?us-ascii?Q?/uVV6Hj5XweXp4pMKCdCV0uY7AdsFWBRIG9MSVt89aUrCpKY2n2xShr+zX+k?=
 =?us-ascii?Q?WfcCDLmmzmzbcfiYqMEldApNeLePEM7r/99RSYkvf6WjU6UBLC9v5HTqEkid?=
 =?us-ascii?Q?lnXSiF+ErfcBJuD+Xi4u9MBQMrm9IO9+q7h3Pfp7dLajvrjf5Kp6tWBiANXv?=
 =?us-ascii?Q?g+3h3NvLDYk1m7yFZuwyP3R6?=
X-OriginatorOrg: urjc.es
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfeb12a-f35a-4442-4735-08d9460ea915
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4663.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 14:58:23.1255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5f84c4ea-370d-4b9e-830c-756f8bf1b51f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQPrJX8Li2z3ozi6Z2XY8BNWnoip3kU+ZOs9ax1NVHz2DkNW+DQPLVihyh2Qb4y/gKWjpkK3bORmGRpZaxv/vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6278
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Javier Pello <javier.pello@urjc.es>

The current mainline kernel oopses when handling ext2 filesystems,
and the filesystem is not usable, sometimes leading to a panic.

I recently tried to upgrade the kernel on my system from 5.10.7 to
5.13.1 but, when I booted the new kernel, I started getting oopses
consistently during the boot process as the init script tried to
mount an ext2 filesystem, and other weird behaviour (like tasks
stuck in uninterruptible sleep) if I accessed the filesystem later
(which I did not do for long for fear of data loss). I managed to
set up a QEMU virtual machine with as small a reproducer as I could
get (kernel stripped of as much stuff as possible) and this is the
oops message that I got (I set the kernel to panic on oops to that
I could get the first report; otherwise, the kernel tries to go on
but ends up attempting to kill init):

BUG: kernel NULL pointer dereference, address: 00000004
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
*pde = 00000000
Oops: 0000 [#1]
CPU: 0 PID: 41 Comm: init.boot Not tainted 5.12.0-rc3+ #23
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
EIP: ext2_get_page.isra.0+0xe2/0x2b0
Code: 8b 45 dc 89 5d cc 8b 80 cc 01 00 00 8b 40 34 8b 00 89 45 d4 8b 45 e0 f7 d8 89 45 e0 8b 45 e8 83 e8 0c 89 45 d0 8b 45 f0 01 f8 <0f> b7 48 04 89 ca 66 83 f9 0b 76 4a 83 e2 03 0f 85 09 01 00 00 0f
EAX: 00000000 EBX: f73fa700 ECX: 00000000 EDX: 00000001
ESI: 00000000 EDI: 00000000 EBP: c2509ce8 ESP: c2509cb0
DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
CR0: 80050033 CR2: 00000004 CR3: 024dd000 CR4: 00150e90
Call Trace:
 ext2_find_entry+0x79/0x240
 ext2_inode_by_name+0x16/0x70
 ext2_lookup+0x27/0x70
 __lookup_slow+0x4f/0xe0
 walk_component+0xf7/0x160
 link_path_walk.part.0+0x24d/0x350
 ? terminate_walk+0x7d/0xf0
 path_lookupat+0x39/0x180
 filename_lookup+0x78/0x130
 ? kmem_cache_alloc+0x21/0x130
 ? getname_flags+0x1f/0x160
 ? getname_flags+0x36/0x160
 user_path_at_empty+0x25/0x30
 vfs_statx+0x53/0xd0
 __do_sys_stat64+0x27/0x50
 __ia32_sys_stat64+0xd/0x10
 __do_fast_syscall_32+0x40/0x70
 do_fast_syscall_32+0x28/0x60
 do_SYSENTER_32+0x15/0x20
 entry_SYSENTER_32+0x98/0xe6
EIP: 0xb7ee8549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
EAX: ffffffda EBX: 0a0dd360 ECX: bf993cc0 EDX: b7e64000
ESI: 0a0dd360 EDI: 0a0dd000 EBP: 0a0dd340 ESP: bf993c98
DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
CR2: 0000000000000004
---[ end trace 865a3cf144c3889e ]---

I am running a 32-bit kernel on an x86 machine, in case this is
relevant. Also, I noticed that the high memory support config
option must be set to 4GB to trigger the bug; I could not
reproduce the bug if I set high memory to off.

As the text says, the oops is triggered within ext2_get_page.
I managed to track it down to line 130 in fs/ext2/dir.c, within
ext2_check_page,
    rec_len = ext2_rec_len_from_disk(p->rec_len);
Adding a printk in the function I confirmed that, while variable
page has a non-null value on function entry, the assignment
    char *kaddr = page_address(page);
in line 114 sets kaddr to a null value indeed, and this triggers
the bug when dereferenced later.

I bisected the problem to commit

782b76d7abdf02b12c46ed6f1e9bf715569027f7
fs/ext2: Replace kmap() with kmap_local_page()

The oops triggers consistently on this commit but its parent
commit works fine. Analysing the commit, I think that it may be
incomplete, as ext2_check_page and ext2_delete_entry are still
using page_address to get at the page address, but this no longer
works because those pages are now mapped with kmap_local_page,
not kmap. It seems to me that ext2_check_page and ext2_delete_entry
should be provided with the page address that their callers already
have for the page, as with all other functions in fs/ext2/dir.c
now. The proposed patch does precisely this.

Javier Pello (1):
  fs/ext2: Avoid page_address on pages returned by ext2_get_page

 fs/ext2/dir.c   | 20 ++++++++++----------
 fs/ext2/ext2.h  |  3 ++-
 fs/ext2/namei.c |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.30.1
