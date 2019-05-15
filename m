Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DA1F34D
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfEOMM0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 08:12:26 -0400
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:1443 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbfEOMMW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 May 2019 08:12:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ACAACO3/JbAFaJfQENVQ4LAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBBwEBAQEBAYFTAgEBAQEBCwGEEoN4gl6THiWXNoF6CAGEcAKEDzYHDQE?=
 =?us-ascii?q?DAQECAQECEAE0hgwBAQEBAyMEUhALDQQDAQIBKgICAk0IBg4FgyEBgRynPHB8M?=
 =?us-ascii?q?xqFJoRND4JtEYdHgxc/gREnDBOCTIReAQEeFwmCZDGCBCICiRKGQAQvT48bBwK?=
 =?us-ascii?q?CGgSCAYF0iyyBWIUIgxEDD4Z6mWMBggUzGi5vAYJBkCBKYgGMHYI+AQE?=
Received: from unknown (HELO [10.135.5.170]) ([1.125.137.86])
  by ipmail01.adl6.internode.on.net with ESMTP; 15 May 2019 21:42:17 +0930
Date:   Wed, 15 May 2019 21:42:11 +0930
User-Agent: K-9 Mail for Android
In-Reply-To: <20190515045717.GB5394@mit.edu>
References: <48BA4A6E-5E2A-478E-A96E-A31FA959964C@internode.on.net> <CAFLxGvwnKKHOnM2w8i9hn7LTVYKh5PQP2zYMBmma2k9z7HBpzw@mail.gmail.com> <20190511220659.GB8507@mit.edu> <09D87554-6795-4AEA-B8D0-FEBCB45673A9@internode.on.net> <850EDDE2-5B82-4354-AF1C-A2D0B8571093@internode.on.net> <17C30FA3-1AB3-4DAD-9B86-9FA9088F11C9@internode.on.net> <20190515045717.GB5394@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----WSCHIZVN6A37NMST66JKY3S8MFUOKF"
Content-Transfer-Encoding: 7bit
Subject: Re: ext3/ext4 filesystem corruption under post 5.1.0 kernels
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org
From:   Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <C24BBE18-1665-4343-9C98-5AF64BACDCA3@internode.on.net>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

------WSCHIZVN6A37NMST66JKY3S8MFUOKF
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15 May 2019 2:27:17 pm ACST, Theodore Ts'o <tytso@mit=2Eedu> wrote:
>Ah, I think I see the problem=2E  Sorry, this one was my fault=2E  Does
>this fix things for you?
>
>						- Ted
>
>From 0c72924ef346d54e8627440e6d71257aa5b56105 Mon Sep 17 00:00:00 2001
>From: Theodore Ts'o <tytso@mit=2Eedu>
>Date: Wed, 15 May 2019 00:51:19 -0400
>Subject: [PATCH] ext4: fix block validity checks for journal inodes
>using indirect blocks
>
>Commit 345c0dbf3a30 ("ext4: protect journal inode's blocks using
>block_validity") failed to add an exception for the journal inode in
>ext4_check_blockref(), which is the function used by ext4_get_branch()
>for indirect blocks=2E  This caused attempts to read from the ext3-style
>journals to fail with:
>
>[  848=2E968550] EXT4-fs error (device sdb7): ext4_get_branch:171: inode
>#8: block 30343695: comm jbd2/sdb7-8: invalid block
>
>Fix this by adding the missing exception check=2E
>
>Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using
>block_validity")
>Reported-by: Arthur Marsh <arthur=2Emarsh@internode=2Eon=2Enet>
>Signed-off-by: Theodore Ts'o <tytso@mit=2Eedu>
>---
> fs/ext4/block_validity=2Ec | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/fs/ext4/block_validity=2Ec b/fs/ext4/block_validity=2Ec
>index 8d03550aaae3=2E=2E8e83741b02e0 100644
>--- a/fs/ext4/block_validity=2Ec
>+++ b/fs/ext4/block_validity=2Ec
>@@ -277,6 +277,11 @@ int ext4_check_blockref(const char *function,
>unsigned int line,
> 	__le32 *bref =3D p;
> 	unsigned int blk;
>=20
>+	if (ext4_has_feature_journal(inode->i_sb) &&
>+	    (inode->i_ino =3D=3D
>+	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
>+		return 0;
>+
> 	while (bref < p+max) {
> 		blk =3D le32_to_cpu(*bref++);
> 		if (blk &&

I have built kernels with the attached patch applied and run git gc on the=
 patched kernels (both the 32 bit kernel on the Pentium-D and the 64 bit ke=
rnel on the Athlon II X4 640)=2E=20

There were a couple of warnings from other processes being blocked while t=
he git gc was taking place but no filesystem corruption detected=2E (I ran =
forced fsck checks on the root filesystems after the git gc runs to check f=
or corruption)=2E=20

Thanks for the patch!=20

Arthur=2E=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
------WSCHIZVN6A37NMST66JKY3S8MFUOKF
Content-Type: application/octet-stream;
 name="ext4.tmp"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ext4.tmp";
 size=506

ZGlmZiAtLWdpdCBhL2ZzL2V4dDQvYmxvY2tfdmFsaWRpdHkuYyBiL2ZzL2V4dDQvYmxvY2tfdmFs
aWRpdHkuYwppbmRleCA5NjhmMTYzYjVmZWIuLjY2MTQ2YTcxMTg3MSAxMDA2NDQKLS0tIGEvZnMv
ZXh0NC9ibG9ja192YWxpZGl0eS5jCisrKyBiL2ZzL2V4dDQvYmxvY2tfdmFsaWRpdHkuYwpAQCAt
Mjc2LDYgKzI3NiwxMSBAQCBpbnQgZXh0NF9jaGVja19ibG9ja3JlZihjb25zdCBjaGFyICpmdW5j
dGlvbiwgdW5zaWduZWQgaW50IGxpbmUsCiAJX19sZTMyICpicmVmID0gcDsKIAl1bnNpZ25lZCBp
bnQgYmxrOwogCisJaWYgKGV4dDRfaGFzX2ZlYXR1cmVfam91cm5hbChpbm9kZS0+aV9zYikgJiYK
KwkoaW5vZGUtPmlfaW5vID09CisJCWxlMzJfdG9fY3B1KEVYVDRfU0IoaW5vZGUtPmlfc2IpLT5z
X2VzLT5zX2pvdXJuYWxfaW51bSkpKQorCXJldHVybiAwOworCiAJd2hpbGUgKGJyZWYgPCBwK21h
eCkgewogCQlibGsgPSBsZTMyX3RvX2NwdSgqYnJlZisrKTsKIAkJaWYgKGJsayAmJgo=

------WSCHIZVN6A37NMST66JKY3S8MFUOKF
Content-Type: application/octet-stream;
 name="20190515iucode_tool.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="20190515iucode_tool.log";
 size=4281

WyAxMDg4LjE1NTAyNV0gSU5GTzogdGFzayBpdWNvZGVfdG9vbDo5NDU2IGJsb2NrZWQgZm9yIG1v
cmUgdGhhbiAxMjAgc2Vjb25kcy4KWyAxMDg4LjE1NTAzMl0gICAgICAgTm90IHRhaW50ZWQgNS4x
LjArICMzNDE3ClsgMTA4OC4xNTUwMzNdICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdf
dGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KWyAxMDg4LjE1NTAzNV0g
aXVjb2RlX3Rvb2wgICAgIEQgICAgMCAgOTQ1NiAgIDk0NTMgMHgwMDAwNDAwMApbIDEwODguMTU1
MDM5XSBDYWxsIFRyYWNlOgpbIDEwODguMTU1MDUyXSAgPyBfX3NjaGVkdWxlKzB4Mjk3LzB4Njkw
ClsgMTA4OC4xNTUwNTVdICA/IF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgyMi8weDUwClsgMTA4
OC4xNTUwNTddICBzY2hlZHVsZSsweDMzLzB4YzAKWyAxMDg4LjE1NTA3MF0gIGpiZDJfbG9nX3dh
aXRfY29tbWl0KzB4OWIvMHgxMDAgW2piZDJdClsgMTA4OC4xNTUwNzVdICA/IGZpbmlzaF93YWl0
KzB4YjAvMHhiMApbIDEwODguMTU1MTEwXSAgZXh0NF9zeW5jX2ZpbGUrMHgzZWIvMHg0NDAgW2V4
dDRdClsgMTA4OC4xNTUxMTVdICBkb19mc3luYysweDQzLzB4ODAKWyAxMDg4LjE1NTExN10gIF9f
eDY0X3N5c19mZGF0YXN5bmMrMHgxMy8weDIwClsgMTA4OC4xNTUxMjBdICBkb19zeXNjYWxsXzY0
KzB4NjQvMHgzZDAKWyAxMDg4LjE1NTEyM10gID8gX19kb19wYWdlX2ZhdWx0KzB4Mjg4LzB4NTkw
ClsgMTA4OC4xNTUxMjZdICA/IGZwcmVnc19hc3NlcnRfc3RhdGVfY29uc2lzdGVudCsweDFlLzB4
NTAKWyAxMDg4LjE1NTEyOV0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4
YTkKWyAxMDg4LjE1NTEzMl0gUklQOiAwMDMzOjB4N2Y1MTlmN2EzMmM0ClsgMTA4OC4xNTUxMzld
IENvZGU6IEJhZCBSSVAgdmFsdWUuClsgMTA4OC4xNTUxNDBdIFJTUDogMDAyYjowMDAwN2ZmZWIw
OWE4ODQ4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwNGIKWyAxMDg4
LjE1NTE0Ml0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDI0ZDAwMCBSQ1g6
IDAwMDA3ZjUxOWY3YTMyYzQKWyAxMDg4LjE1NTE0NF0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJT
STogMDAwMDAwMDAwMDAwMDAwMSBSREk6IDAwMDAwMDAwMDAwMDAwMDMKWyAxMDg4LjE1NTE0NV0g
UkJQOiAwMDAwMDAwMDAwMDAwMDAzIFIwODogMDAwMDAwMDAwMDAwMDE0ZiBSMDk6IDAwMDA1NWE5
ZTJkM2IxOTAKWyAxMDg4LjE1NTE0Nl0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAw
MDAwMDAwMDI0NiBSMTI6IDAwMDA1NWE5ZTJkMzc4NzAKWyAxMDg4LjE1NTE0N10gUjEzOiAwMDAw
MDAwMDAwMDAwMTUwIFIxNDogMDAwMDAwMDAwMDAwMDA2YyBSMTU6IDAwMDAwMDAwMDAwMDAwMDAK
WyAxMjA4LjkyNjU4NV0gSU5GTzogdGFzayBpdWNvZGVfdG9vbDo5NDU2IGJsb2NrZWQgZm9yIG1v
cmUgdGhhbiAyNDEgc2Vjb25kcy4KWyAxMjA4LjkyNjU4OV0gICAgICAgTm90IHRhaW50ZWQgNS4x
LjArICMzNDE3ClsgMTIwOC45MjY1OTBdICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdf
dGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KWyAxMjA4LjkyNjU5Ml0g
aXVjb2RlX3Rvb2wgICAgIEQgICAgMCAgOTQ1NiAgIDk0NTMgMHgwMDAwNDAwMApbIDEyMDguOTI2
NTk1XSBDYWxsIFRyYWNlOgpbIDEyMDguOTI2NjA0XSAgPyBfX3NjaGVkdWxlKzB4Mjk3LzB4Njkw
ClsgMTIwOC45MjY2MDddICA/IF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgyMi8weDUwClsgMTIw
OC45MjY2MDldICBzY2hlZHVsZSsweDMzLzB4YzAKWyAxMjA4LjkyNjYxOF0gIGpiZDJfbG9nX3dh
aXRfY29tbWl0KzB4OWIvMHgxMDAgW2piZDJdClsgMTIwOC45MjY2MjFdICA/IGZpbmlzaF93YWl0
KzB4YjAvMHhiMApbIDEyMDguOTI2NjQzXSAgZXh0NF9zeW5jX2ZpbGUrMHgzZWIvMHg0NDAgW2V4
dDRdClsgMTIwOC45MjY2NDddICBkb19mc3luYysweDQzLzB4ODAKWyAxMjA4LjkyNjY0OV0gIF9f
eDY0X3N5c19mZGF0YXN5bmMrMHgxMy8weDIwClsgMTIwOC45MjY2NTFdICBkb19zeXNjYWxsXzY0
KzB4NjQvMHgzZDAKWyAxMjA4LjkyNjY1NF0gID8gX19kb19wYWdlX2ZhdWx0KzB4Mjg4LzB4NTkw
ClsgMTIwOC45MjY2NTZdICA/IGZwcmVnc19hc3NlcnRfc3RhdGVfY29uc2lzdGVudCsweDFlLzB4
NTAKWyAxMjA4LjkyNjY1OF0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0LzB4
YTkKWyAxMjA4LjkyNjY2MV0gUklQOiAwMDMzOjB4N2Y1MTlmN2EzMmM0ClsgMTIwOC45MjY2NjZd
IENvZGU6IEJhZCBSSVAgdmFsdWUuClsgMTIwOC45MjY2NjddIFJTUDogMDAyYjowMDAwN2ZmZWIw
OWE4ODQ4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwNGIKWyAxMjA4
LjkyNjY2OV0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDI0ZDAwMCBSQ1g6
IDAwMDA3ZjUxOWY3YTMyYzQKWyAxMjA4LjkyNjY3MF0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJT
STogMDAwMDAwMDAwMDAwMDAwMSBSREk6IDAwMDAwMDAwMDAwMDAwMDMKWyAxMjA4LjkyNjY3MV0g
UkJQOiAwMDAwMDAwMDAwMDAwMDAzIFIwODogMDAwMDAwMDAwMDAwMDE0ZiBSMDk6IDAwMDA1NWE5
ZTJkM2IxOTAKWyAxMjA4LjkyNjY3Ml0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAw
MDAwMDAwMDI0NiBSMTI6IDAwMDA1NWE5ZTJkMzc4NzAKWyAxMjA4LjkyNjY3M10gUjEzOiAwMDAw
MDAwMDAwMDAwMTUwIFIxNDogMDAwMDAwMDAwMDAwMDA2YyBSMTU6IDAwMDAwMDAwMDAwMDAwMDAK
ClsgMTkzMy41NTYxODJdIElORk86IHRhc2sgVGhyZWFkIChwb29sZWQpOjIwOTEwIGJsb2NrZWQg
Zm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25kcy4KWyAxOTMzLjU1NjE4OV0gICAgICAgTm90IHRhaW50
ZWQgNS4xLjArICMzNDE3ClsgMTkzMy41NTYxOTBdICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVs
L2h1bmdfdGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4KWyAxOTMzLjU1
NjE5Ml0gVGhyZWFkIChwb29sZWQpIEQgICAgMCAyMDkxMCAgICAgIDEgMHgwMDAwNDAwMApbIDE5
MzMuNTU2MTk1XSBDYWxsIFRyYWNlOgpbIDE5MzMuNTU2MjA3XSAgPyBfX3NjaGVkdWxlKzB4Mjk3
LzB4NjkwClsgMTkzMy41NTYyMTBdICA/IF9yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgyMi8weDUw
ClsgMTkzMy41NTYyMTJdICBzY2hlZHVsZSsweDMzLzB4YzAKWyAxOTMzLjU1NjIyNF0gIGpiZDJf
bG9nX3dhaXRfY29tbWl0KzB4OWIvMHgxMDAgW2piZDJdClsgMTkzMy41NTYyMjhdICA/IGZpbmlz
aF93YWl0KzB4YjAvMHhiMApbIDE5MzMuNTU2MjYxXSAgZXh0NF9zeW5jX2ZpbGUrMHgzZWIvMHg0
NDAgW2V4dDRdClsgMTkzMy41NTYyNjZdICBkb19mc3luYysweDQzLzB4ODAKWyAxOTMzLjU1NjI2
OF0gIF9feDY0X3N5c19mZGF0YXN5bmMrMHgxMy8weDIwClsgMTkzMy41NTYyNzFdICBkb19zeXNj
YWxsXzY0KzB4NjQvMHgzZDAKWyAxOTMzLjU1NjI3NF0gID8gX19kb19wYWdlX2ZhdWx0KzB4Mjg4
LzB4NTkwClsgMTkzMy41NTYyNzddICA/IGZwcmVnc19hc3NlcnRfc3RhdGVfY29uc2lzdGVudCsw
eDFlLzB4NTAKWyAxOTMzLjU1NjI3OV0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDQ0LzB4YTkKWyAxOTMzLjU1NjI4Ml0gUklQOiAwMDMzOjB4N2Y5MGUyMmQ2MmU3ClsgMTkzMy41
NTYyODhdIENvZGU6IEJhZCBSSVAgdmFsdWUuClsgMTkzMy41NTYyOTBdIFJTUDogMDAyYjowMDAw
N2Y5MDlkNGU3YTAwIEVGTEFHUzogMDAwMDAyOTMgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwNGIK
WyAxOTMzLjU1NjI5Ml0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAx
YSBSQ1g6IDAwMDA3ZjkwZTIyZDYyZTcKWyAxOTMzLjU1NjI5M10gUkRYOiAwMDAwMDAwMDAwMDAw
MDAwIFJTSTogMDAwMDdmOTA5ZDRlNzlmMCBSREk6IDAwMDAwMDAwMDAwMDAwMWEKWyAxOTMzLjU1
NjI5NF0gUkJQOiAwMDAwN2Y5MDhjMDA0YmYwIFIwODogMDAwMDAwMDAwMDAwNDAxZiBSMDk6IDAw
MDA3ZjkwOGMwMDk5NDAKWyAxOTMzLjU1NjI5NV0gUjEwOiAwMDAwN2Y5MDhjMDA5OTEwIFIxMTog
MDAwMDAwMDAwMDAwMDI5MyBSMTI6IDAwMDAwMDAwMDAwMDAwMDEKWyAxOTMzLjU1NjI5Nl0gUjEz
OiAwMDAwMDAwMDAwMDAwMDAxIFIxNDogMDAwMDdmOTA5ZDRlN2I1MCBSMTU6IDAwMDAwMDAwMDAw
MDAwMDEK

------WSCHIZVN6A37NMST66JKY3S8MFUOKF--
