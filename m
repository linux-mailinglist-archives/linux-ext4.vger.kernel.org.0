Return-Path: <linux-ext4+bounces-10431-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04696BA220D
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 03:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E0C7AA160
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Sep 2025 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC839136988;
	Fri, 26 Sep 2025 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kHyNtaw6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DE28399
	for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 01:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758849346; cv=none; b=FIq6+wiQeaeWCT4VaIZ5eMgIy/z1/5q2MS8tmCzYPp4JIlgWiFfFhUrexlO+ZUlGfhAbipTXEJOFdHiXqR8eLomJJkm52DW9AKptU+VaJF5qyvKTcWr7sIaoWhiSubL2A5p+eec+cH7Ec105+x52TTDiGikt4DfF5yaDrLCBmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758849346; c=relaxed/simple;
	bh=Y27oR7TuiwgWXGZAPSxJuRkeqWa8vh7ccmbxQRfC9IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibb54RAOk8MplIvQMiuEER5M3danemFZqsH+ydl3na6jNPhJMv7RipD2tLUVKw9d1PBfs7JZiY7oDfGV0oUA4wk7s7aPxqbNvgylo0tuYDuJAxhAGDWMfg5upCfCPQ9hKf+SJW+lNjVwhWuWHAvahXsWW0CqkLxd2eHVx37sO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kHyNtaw6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-212.bstnma.fios.verizon.net [173.48.114.212])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58Q1FUAB003872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 21:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758849333; bh=3ebwP+G1VHPIvdj/wRsnbGUwjyhALWuVH4BrTlAWwJE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=kHyNtaw6Of6gRk2tWsLj1fqTwUe0FFMq8Z+TovZraK6JikGr2A0kTBJw3FNpC3aYN
	 XUrCIEbqe17egMcPRfk9+XF8ZfwT1W0PoWzK0O3cIGl+F5Cgel03D5OOwaUD/pMwyA
	 G1SQpZZaE3UE/nnc2bPbX3dH2UVA/vsZW0XCmTC/BEuGGnv14Bs31UZzSiLbu4lQKj
	 in+iKyLv4qWTGmXAnFar8nPTo516nUZ9Aszr5E7+GitFwjWcNNRQoxy89o3XXiKTjj
	 A2epUC9JSazCzwB/lBKOxR1emQlTMYtUiN64/DVx6KdVtbXPxol7QJbDFrsK3g57ic
	 iSmXDcyUUq8Ow==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D18572E00D9; Thu, 25 Sep 2025 21:15:30 -0400 (EDT)
Date: Thu, 25 Sep 2025 21:15:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: validate ea_ino and size in check_xattrs
Message-ID: <20250926011530.GH19231@mit.edu>
References: <20250923133245.1091761-1-kartikey406@gmail.com>
 <AB6112E6-A3CE-4232-83C6-9099463A7AA4@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a4JrLa6VDqGFRrSY"
Content-Disposition: inline
In-Reply-To: <AB6112E6-A3CE-4232-83C6-9099463A7AA4@dilger.ca>


--a4JrLa6VDqGFRrSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 12:04:42PM -0600, Andreas Dilger wrote:
> On Sep 23, 2025, at 7:32 AM, Deepanshu Kartikey <kartikey406@gmail.com> wrote:
> > 
> > During xattr block validation, check_xattrs() processes xattr entries
> > without validating that entries claiming to use EA inodes have non-zero
> > sizes. Corrupted filesystems may contain xattr entries where e_value_size
> > is zero but e_value_inum is non-zero, indicating invalid xattr data.
> > 
> > Add validation in check_xattrs() to detect this corruption pattern early
> > and return -EFSCORRUPTED, preventing invalid xattr entries from causing
> > issues throughout the ext4 codebase.
> 
> This should also have a corresponding check and fix in e2fsck, otherwise
> the kernel will fail but there is no way to repair such a filesystem.

Yep, I've checked and e2fsprogs doesn't handle this case correctly.

Patch attached....

						- Ted

From 003ead91bbedd39915ea7e8cd75c4278932504a1 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 25 Sep 2025 21:11:52 -0400
Subject: [PATCH] e2fsck: check for extended attributes with ea_inode but a
 zero ea_size

The combination of e_value_inum != 0 and e_value_size == 0 is invalid
and can trigger kernel warnings.  This should only happen with
delierately corrupted extended attribute entries; so if we come across
one, just clear the xattrs.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/pass1.c                |   6 ++++++
 tests/f_ea_zero_size/expect.1 |  30 ++++++++++++++++++++++++++++++
 tests/f_ea_zero_size/expect.2 |   7 +++++++
 tests/f_ea_zero_size/image.gz | Bin 0 -> 1313 bytes
 tests/f_ea_zero_size/name     |   1 +
 5 files changed, 44 insertions(+)
 create mode 100644 tests/f_ea_zero_size/expect.1
 create mode 100644 tests/f_ea_zero_size/expect.2
 create mode 100644 tests/f_ea_zero_size/image.gz
 create mode 100644 tests/f_ea_zero_size/name

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index e7d5d0ae9..fdde76cc2 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -343,6 +343,12 @@ static problem_t check_large_ea_inode(e2fsck_t ctx,
 
 	e2fsck_read_inode(ctx, entry->e_value_inum, &inode, "pass1");
 
+	if (entry->e_value_size == 0 ||
+	    entry->e_value_size != EXT2_I_SIZE(&inode)) {
+		pctx->num = entry->e_value_size;
+		return PR_1_ATTR_VALUE_SIZE;
+	}
+
 	retval = ext2fs_ext_attr_hash_entry3(ctx->fs, entry, NULL, &hash,
 					     &signed_hash);
 	if (retval) {
diff --git a/tests/f_ea_zero_size/expect.1 b/tests/f_ea_zero_size/expect.1
new file mode 100644
index 000000000..2aa0ae653
--- /dev/null
+++ b/tests/f_ea_zero_size/expect.1
@@ -0,0 +1,30 @@
+Pass 1: Checking inodes, blocks, and sizes
+Extended attribute in inode 12 has a value size (0) which is invalid
+Clear? yes
+
+Inode 12, i_blocks is 8, should be 0.  Fix? yes
+
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Regular filesystem inode 14 has EA_INODE flag set. Clear? yes
+
+Unattached inode 14
+Connect to /lost+found? yes
+
+Inode 14 ref count is 2, should be 1.  Fix? yes
+
+Pass 5: Checking group summary information
+Block bitmap differences:  -13
+Fix? yes
+
+Free blocks count wrong for group #0 (46, counted=47).
+Fix? yes
+
+Free blocks count wrong (46, counted=47).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 21/32 files (0.0% non-contiguous), 17/64 blocks
+Exit status is 1
diff --git a/tests/f_ea_zero_size/expect.2 b/tests/f_ea_zero_size/expect.2
new file mode 100644
index 000000000..17211daf9
--- /dev/null
+++ b/tests/f_ea_zero_size/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 21/32 files (0.0% non-contiguous), 17/64 blocks
+Exit status is 0
diff --git a/tests/f_ea_zero_size/image.gz b/tests/f_ea_zero_size/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..fff5b203f8fa3d36da038fd8bae5a1198fa91db4
GIT binary patch
literal 1313
zcmc&y{a2EA9DUR_Yt_NEPBt~HvsG(R&dN&LiBiugr>Liu<on8*qA6-^zSQ<)%~taj
zIfBLpGd(#iH8rJTfE7g=8@^0%prRsRJ}5yxBJjv}vOi(J?Edh%pU*j;d+z<=dKa%;
zS)dzAb#|d-oJmQBW=Eye^{2d`H#NI91cpYtIp5rP^XB!FvB$$OTJ@Ey!W)IZxdz@Y
z9DQ(v-cFjv)p}hKu_~rZgZ%uq%p5JXx@Y;)SlbGao@=DfrjM$hi>zaM0wEOc*pNZw
zO!27So>SBq1l(2wDWxOC`QAxokbYJFy4#0>V+DeWV>tqkY+-TLwI8<&fibu;jKnv_
z-l{(nkLI7c#munK8-k2j(~QBck;vr>d>-KYkT+Q;Miy;iPic~_r?>CVCv20j261oj
zPJMkSYy3$$ENC+}M7-dsEnPZgR}~JQX;0@ZY10R$Q=4X;p!@UhS%%?L`|Z@bWfmt0
zx{{on*0j~fv1yPk7hnj2PHWT5P9mvLc6RG1$WlLg6M0VyH=Zb+VKBZXMYV*)JX0%F
zgZjPe{ETW|GwGmx!HpS9RC?7#;pV<@Vm!61o|u?nQ><X00c>b(p2!af0^|tb8mde4
z0{WUvjQmo?8cO&z8~cDsK0v`P_^1GRw`8B4L@fgY1TfWwxt}%Yqzu^~m0(eIDUr8F
z0m4f1u+w9Tx-5RhVfL=sUimy))HzY#u8Nk((WqCncY3X0vKdn%1xT9xkO?z*fi9oT
z;O`muGI&Hze_y(V5o$G4X_nl5J3%Dqd}+dIPH;i7Wkh#Y6J=8=>KBL)lk}~V1WS25
zoQ@82>gc|c#w35vLZU<o>qNyWnF6L1rlBhTeiI3^gjT&UgEIYI<KPgm=4*-TO`K-C
zcpF<XdCkqZn4RB<2=|+tr9{e!C7hH7G&t`}sp7~D0*I6u2JzwJ^3Ad@UpMxA<nk;i
z-bMU4yy{c&C4jS(OR4}uf4=A;x*;x4UOLQrwrYgKMYmtgX>34(DQ|-1ZT10UOK*3i
z{3}CW`~sY0I3Jpl2KJ(`r#8QYtE0pCXnSp3_$-)@vxpI5$CR+PrB&%Zk^qWZZI4V;
z*`iJoXYrmLj^Vw_&~Or0-$g;}i~=0{g^Kssftvjco0dzk^VsiQ{p|XpIo7M9z}#FE
zKESH%EV36qsTG&4T|+KtlG}a?Nmmd*KX|c;Td-7DJ;FSvHeNpbaEC;O=yaYPzIN@!
zJO0QWH|5hcDUbb0Kd+d-r>gWYxIj?%C?&lbfHpw@a9y@y)ZAt+6C?r4Eri}WD(Jv?
zf`{W~@E4a9MjL-nAJaX3T#Xh64)@V~hy(18HDeDm3E!iM1N0>ctv`o@eBw~SZ<l8`
z|D^N3TB{8tS|4CT7tJ6g5$A>v*pBDR@&Md8ZwfI3N0!N5&oQCnnQ*D4eVP6P`r?WZ
zN?u8uO+VL>dw#8Fz+|9r2%ZvAnL~|}tJaaxA2xpIzb9ty?i_cw%20H_k2!0O?^3n6
fwTiy^E+HeTg$6cvIwJg!_zQD6Iv~q~pcT+RmcD}-

literal 0
HcmV?d00001

diff --git a/tests/f_ea_zero_size/name b/tests/f_ea_zero_size/name
new file mode 100644
index 000000000..95d9893c1
--- /dev/null
+++ b/tests/f_ea_zero_size/name
@@ -0,0 +1 @@
+zero extended attribute size with ea_inode
-- 
2.51.0



--a4JrLa6VDqGFRrSY
Content-Type: application/gzip
Content-Disposition: attachment; filename="foo.img.gz"
Content-Transfer-Encoding: base64

H4sICPLb1WgCA2Zvby5pbWcA7d3PbxRVHADwmW0FQktZEAKJGIkJSqotJCb+SEyogL+IgagH
QqLBbVpok9Im9IdQDkDiTUj0xqGamhD1oEb9CzhoIjcPcoKTMZJg0ESNFxPre7OzsJT+oqyt
bD+f5Ltvdnbane+8t6/vTWeySQIsVZtDdIRoCNEeoilfX8gjOVWOuN2jly/1/B4iSSYmXv8t
TdKwrvy8LM3LpvzJ06HY2Vj+3b8c//ri7nf3vPdl4/4fTo6/f3jyfmw70j+0bbCr87/M9Ytj
DzT07t374Mc/X1/74yfj7XF/m/PXNnXuO1D7Y7v5xjGZ7FhaX+1omY8SAMA9oZCP/Ruz8X9T
eN7ooAAAAECdmZhoyEsAAACgfj1k7g8AAAB1rnIdQLz/tRJL6fqH68+Fh2KSbLt8qeds/74D
McqvNCQrsnJFdm/ryj/SW+6MiLfv1uKe180hzi37bH2Mjp0/fbPUjj+weE6dDg8XOqbo/9O8
/5u/pknP02n6v2r6P1g4F+L4p2Oq8V8h/2yWe4HJ45+4vLxG45/F/PyfPz3d+De9Mf5Ls/yT
ed8Zu+vzZ0urZsh//J9dr54f7XsmRnz/WN7conCtkD6eLW3P1/T2hrVhp7LfWczXdZfLkTuU
9f/Fm/k3V/XW5fy35vnfPv5tvoP8Z6r/8T0nX6lE3IdYLujfv3nm31Kr/EP9VyLLP5QL3f7P
5HOfM/032//GGrX/wa1jfxdnyH/s2pvLx/4avRojvn8s59L+i3n7b73ywneV9l+6Q5X6b73S
8G38+bP9kz//W7N75Keq/9VzzH8o5D9T/Y9deTKLD0LE94/LC13/lblvdf5Jjep/eJb8z334
cHPWBkJk+YeyepvmsAO/BrGeSk9dPTgwPNQ2cKjtaKn/cPe9kP/IbPm/drUYj0GM+P6xrN5m
fdiB+/O2/kTQWepq6ykN9rQd6isdbusfGGob7B66y/5v7J1N6XTtf7r+b80c3+PtueSfR5Z/
KOup/R+bLf94/meG/NdU9XW7g1vrf/51P1v+tRr/HJ8t/7daNlbOgWX5h7K6/99Q1f4/an1j
/0ipr7d2nwAAAFg64rmN5iQttN9YLhTa28v/u1mXrCz0DQwOPXZoYLi/q3y+r5gsS/uGB4eO
dpfPfxST+9JsPJ7PB9eF2Xr1/HxtNsZfn043Z10XYlOY4Uw1p4mTgK7VG1LjfQAAALg7TZPm
/3+uLs//AQAAgDpTdAgAAADA/B8AAAAw/wcAAAAAAAAAFtMIAAAAUPfi92vH7/dOs3MBoyOT
zw8Uwgst+fKW5iTp7I7rxuJX/yVd2c8cHO3sdR4FAAAA/G8eAAAAWEwlAAAAoO5VX///4qed
X011/X/29QDhofXKIxcnX/9fKr10xPX/AAAAMH8LMf/vBwAAAOqesywAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADUVuFaGh5j7Dix48Rt
r4YXWuJCMUm2NCdJZ3dc19cQV3WFGBk5ONrZW95uVb7d82GhN9vu+2y77SFejut6HW2WrpH/
IbUCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAVPwLngp1UwAABAA=

--a4JrLa6VDqGFRrSY--

