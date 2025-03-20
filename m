Return-Path: <linux-ext4+bounces-6936-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712EA6AA3E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Mar 2025 16:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74187982627
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Mar 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018281EB1A8;
	Thu, 20 Mar 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="viO4x2F2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAF1E2852;
	Thu, 20 Mar 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485614; cv=none; b=gcW6hks+xNHgE8L4Zls1XzHt2zl23omoCDMcYR5LzDEFhJroW48s8VHalzDFVA31VLkVlekQzSUToVoHblnAfQXVYj30X/99bbuMxL7or2quKOjc9hpPjC3hIusnrdeQd1TxX6dZa4RzELQL2f8vvF0TxRU4SsNLfcbpGa3R5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485614; c=relaxed/simple;
	bh=QlzjqiyXxem5/96A8SeWhR/8S3BS/BqcGio0FD718r8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sCxsEZMwTKTu+tJ7eio51OoDh79fwzKKSYkEaIEQuQ3k6YXzCzc54sk3XonCyvTfZ1IznYWwo0kp+H6r4TMgu8U3MwwFBbMQQ0TPiPAq9Q8Wr/AASXSOZ/9XxXnE2sDqY27dDQJSYw7WeESo1EsgT6V02PtnR38UDnzqZo/97Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=viO4x2F2; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1742485612; x=1774021612;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=XcPv3CbdUSM7iTcNveWy76kFCLMhX0n3GxNEQsZcAro=;
  b=viO4x2F2Viz4vX+GhAdsbJP5KiihogFBE7JHPQb59JPqvAS4pJLGHXZR
   Gfh/Bwprm9IsiBMwXrzzHPdQRN2exOnnI3kwtW/JUqJEeN/y8++Onn38x
   WkP2H1eWoNQNHRQMoBPdGJkU2ChWFGwVyVfpj98pOFmoZ4tot7b0dfU28
   M=;
X-IronPort-AV: E=Sophos;i="6.14,262,1736812800"; 
   d="scan'208";a="183620688"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 15:46:51 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:56646]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.52:2525] with esmtp (Farcaster)
 id 54ef2665-6285-4618-b050-7a48e99ebad3; Thu, 20 Mar 2025 15:46:50 +0000 (UTC)
X-Farcaster-Flow-ID: 54ef2665-6285-4618-b050-7a48e99ebad3
Received: from EX19D019EUB002.ant.amazon.com (10.252.51.33) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 20 Mar 2025 15:46:49 +0000
Received: from EX19D019EUB003.ant.amazon.com (10.252.51.50) by
 EX19D019EUB002.ant.amazon.com (10.252.51.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 20 Mar 2025 15:46:49 +0000
Received: from EX19D019EUB003.ant.amazon.com ([fe80::531b:a721:1f0c:7896]) by
 EX19D019EUB003.ant.amazon.com ([fe80::531b:a721:1f0c:7896%3]) with mapi id
 15.02.1544.014; Thu, 20 Mar 2025 15:46:49 +0000
From: "Acs, Jakub" <acsjakub@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC: "acsjakub@amazon.com" <acsjakub@amazon.com>, Theodore Ts'o
	<tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Mahmoud Adam
	<mngyadam@amazon.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"security@kernel.org" <security@kernel.org>
Subject: [PATCH v2] ext4: fix OOB read when checking dotdot dir
Thread-Topic: [PATCH v2] ext4: fix OOB read when checking dotdot dir
Thread-Index: AQHbma9L44YWgUtfIkGCovMFjqZb+Q==
Date: Thu, 20 Mar 2025 15:46:49 +0000
Message-ID: <b3ae36a6794c4a01944c7d70b403db5b@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Mounting a corrupted filesystem with directory which contains '.' dir=0A=
entry with rec_len =3D=3D block size results in out-of-bounds read (later=
=0A=
on, when the corrupted directory is removed).=0A=
=0A=
ext4_empty_dir() assumes every ext4 directory contains at least '.'=0A=
and '..' as directory entries in the first data block. It first loads=0A=
the '.' dir entry, performs sanity checks by calling ext4_check_dir_entry()=
=0A=
and then uses its rec_len member to compute the location of '..' dir=0A=
entry (in ext4_next_entry). It assumes the '..' dir entry fits into the=0A=
same data block.=0A=
=0A=
If the rec_len of '.' is precisely one block (4KB), it slips through the=0A=
sanity checks (it is considered the last directory entry in the data=0A=
block) and leaves "struct ext4_dir_entry_2 *de" point exactly past the=0A=
memory slot allocated to the data block. The following call to=0A=
ext4_check_dir_entry() on new value of de then dereferences this pointer=0A=
which results in out-of-bounds mem access.=0A=
=0A=
Fix this by extending __ext4_check_dir_entry() to check for '.' dir=0A=
entries that reach the end of data block. Make sure to ignore the phony=0A=
dir entries for checksum (by checking name_len for non-zero).=0A=
=0A=
Note: This is reported by KASAN as use-after-free in case another=0A=
structure was recently freed from the slot past the bound, but it is=0A=
really an OOB read.=0A=
=0A=
This issue was found by syzkaller tool.=0A=
=0A=
Call Trace:=0A=
[   38.594108] BUG: KASAN: slab-use-after-free in __ext4_check_dir_entry+0x=
67e/0x710=0A=
[   38.594649] Read of size 2 at addr ffff88802b41a004 by task syz-executor=
/5375=0A=
[   38.595158]=0A=
[   38.595288] CPU: 0 UID: 0 PID: 5375 Comm: syz-executor Not tainted 6.14.=
0-rc7 #1=0A=
[   38.595298] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014=0A=
[   38.595304] Call Trace:=0A=
[   38.595308]  <TASK>=0A=
[   38.595311]  dump_stack_lvl+0xa7/0xd0=0A=
[   38.595325]  print_address_description.constprop.0+0x2c/0x3f0=0A=
[   38.595339]  ? __ext4_check_dir_entry+0x67e/0x710=0A=
[   38.595349]  print_report+0xaa/0x250=0A=
[   38.595359]  ? __ext4_check_dir_entry+0x67e/0x710=0A=
[   38.595368]  ? kasan_addr_to_slab+0x9/0x90=0A=
[   38.595378]  kasan_report+0xab/0xe0=0A=
[   38.595389]  ? __ext4_check_dir_entry+0x67e/0x710=0A=
[   38.595400]  __ext4_check_dir_entry+0x67e/0x710=0A=
[   38.595410]  ext4_empty_dir+0x465/0x990=0A=
[   38.595421]  ? __pfx_ext4_empty_dir+0x10/0x10=0A=
[   38.595432]  ext4_rmdir.part.0+0x29a/0xd10=0A=
[   38.595441]  ? __dquot_initialize+0x2a7/0xbf0=0A=
[   38.595455]  ? __pfx_ext4_rmdir.part.0+0x10/0x10=0A=
[   38.595464]  ? __pfx___dquot_initialize+0x10/0x10=0A=
[   38.595478]  ? down_write+0xdb/0x140=0A=
[   38.595487]  ? __pfx_down_write+0x10/0x10=0A=
[   38.595497]  ext4_rmdir+0xee/0x140=0A=
[   38.595506]  vfs_rmdir+0x209/0x670=0A=
[   38.595517]  ? lookup_one_qstr_excl+0x3b/0x190=0A=
[   38.595529]  do_rmdir+0x363/0x3c0=0A=
[   38.595537]  ? __pfx_do_rmdir+0x10/0x10=0A=
[   38.595544]  ? strncpy_from_user+0x1ff/0x2e0=0A=
[   38.595561]  __x64_sys_unlinkat+0xf0/0x130=0A=
[   38.595570]  do_syscall_64+0x5b/0x180=0A=
[   38.595583]  entry_SYSCALL_64_after_hwframe+0x76/0x7e=0A=
=0A=
Fixes: ac27a0ec112a0 ("[PATCH] ext4: initial copy of files from ext3")=0A=
Signed-off-by: Jakub Acs <acsjakub@amazon.de>=0A=
Cc: "Theodore Ts'o" <tytso@mit.edu>=0A=
Cc: Andreas Dilger <adilger.kernel@dilger.ca>=0A=
Cc: linux-ext4@vger.kernel.org=0A=
Cc: linux-kernel@vger.kernel.org=0A=
Cc: Mahmoud Adam <mngyadam@amazon.com>=0A=
Cc: stable@vger.kernel.org=0A=
Cc: security@kernel.org=0A=
---=0A=
v1: https://lore.kernel.org/all/20250319110134.10071-1-acsjakub@amazon.com/=
=0A=
v1->v2:=0A=
- optimize condition as per suggestions=0A=
- remove questions=0A=
- move this section to correct place=0A=
=0A=
I ran 'kvm-xfstests smoke' and '-c ext4/4k -g quick' as suggested in=0A=
reply to v1. Some were skipped, none failed.=0A=
=0A=
 fs/ext4/dir.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c=0A=
index 02d47a64e8d1..253992fcf57c 100644=0A=
--- a/fs/ext4/dir.c=0A=
+++ b/fs/ext4/dir.c=0A=
@@ -104,6 +104,9 @@ int __ext4_check_dir_entry(const char *function, unsign=
ed int line,=0A=
 	else if (unlikely(le32_to_cpu(de->inode) >=0A=
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))=0A=
 		error_msg =3D "inode out of bounds";=0A=
+	else if (unlikely(next_offset =3D=3D size && de->name_len =3D=3D 1 &&=0A=
+			  de->name[0] =3D=3D '.'))=0A=
+		error_msg =3D "'.' directory cannot be the last in data block";=0A=
 	else=0A=
 		return 0;=0A=
 =0A=
-- =0A=
2.47.1=0A=

