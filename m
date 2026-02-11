Return-Path: <linux-ext4+bounces-13669-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ9iEfw9jGm7jwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13669-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 09:29:48 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F2C1223D8
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 09:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2C243019924
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3AA350A1D;
	Wed, 11 Feb 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cKlMFWZN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBC189F20;
	Wed, 11 Feb 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798583; cv=none; b=uKKFkQaltaZFk3EMtFPuevlQ28U4FY7ArBYOy3F9p10Pfd9I1yOujhQqHBgkoZ6RoUPI2uy9m3U77rzeJz2wVaTPO9XvUqS9ycZO/ADOdPPC6XUnnzWIx0QsaTILRa9PvqMo3A8tt182Nnh5sW3NZazkmhWIPvN2IvL/bTjcLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798583; c=relaxed/simple;
	bh=pxqNBxgyEprgdheVMRgEdoaOdzHlY7LdJWBa6FI+nXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4UQDZRq8T2Twy2WpuPpC6jv6XX6GmE2Uf0YROPU3CSZXWeVGiZGC3HrloVwCpImCwUH81YPEK8woAQYWuaJElvry3sGiVhz1N8JFwZhhgjKPvUmAc1ch/eJoD6A+bqMAjK4iIflf9ephJaPxa6Bqn6vja0yAZ5ifRLwqB0bTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cKlMFWZN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AMUVne130324;
	Wed, 11 Feb 2026 08:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3L/XmWmWyncpXi+CDCVKQSzX5ABb5v
	Y57LGxCgsWXn0=; b=cKlMFWZNhpFI7hHoa3goNHPoLmQT3phPygaqsLqXTErVxf
	z0eOOOyIYzppH7uVFmMKnyKN7th8zjOKBwWFgmv8Vg2xNkj98tk22GwllnBWdpJm
	XJ1C379pFd5x8j5V52QEj9vJjuesxZ9VMfBprze+r/faxQNvOJ9RVFUmxZN+brFn
	dDC51ssowcC7xgbL8MibHd0mc4JMn0j8P9AdlP+tsyj3kgeEkUtYUW+tHjFR4ulG
	zw5CoqSCvbppAZKsKf/L4LGYIqWGXAe+unjxEDxPUZknM2odDe75dkEelH12JJAI
	uzghIwAYwiv9+Q/1K79LCfKL1YQvlXDJQdVWZnhA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uwtxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 08:29:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B3EXSo008883;
	Wed, 11 Feb 2026 08:29:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3yd522-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 08:29:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61B8TaVR16318820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 08:29:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3690E2004B;
	Wed, 11 Feb 2026 08:29:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 802AC20043;
	Wed, 11 Feb 2026 08:29:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Feb 2026 08:29:34 +0000 (GMT)
Date: Wed, 11 Feb 2026 13:59:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
Message-ID: <aYw97hffWIoiQQGH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aYuOGWks1hXSx-Uk@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <698b9aeb.050a0220.2eeac1.008e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KAOAPSMP4V4RQ8AI"
Content-Disposition: inline
In-Reply-To: <698b9aeb.050a0220.2eeac1.008e.GAE@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA2NyBTYWx0ZWRfXwdJNdGbkRT7R
 3o2CubbJJRu0r3yTHTpnT1YUlXfAqgbD8yo3hX5tlIM9xBVwP+MFbXnQqT3zfWXhX7jpYQHojSG
 mKhhYIuhJ1NANo40vvJBySeFxmILfSTMz5C3Bujqzxf4HdFcvxU2DtGmhy0AYRka8EPRAW6Rx93
 aRkHKOe8RtmR5MaZ1j7H8bM9EGx23NaeZyuAnvg8hAFdyLQomtQy6/y85zmq0ZSfft60BRQdWn+
 RKIC2SLVhOA3VTl9iS7k2nr5ZZLox/6UnNRVT4jhJUrMaYkbHqwciHJnBIDFRDELWuju+Q6mr1B
 OiYmP5dCyvGo8akNu76Myl+tLHs6/4YFOEQftb0+dO2yqNkX9VfK29zArS9yQdHvAg+uwoJ1TGc
 PGbIwEByeeksGHXfkvFOiQATtIWEf5RuBDG35PP317mFMtpZ+BbdNf0EX9VZ3489nf9a4K7C2a+
 R9iTwO5DUKY7T2tB3DA==
X-Proofpoint-ORIG-GUID: yLobIjQyCauODSSkr7hVm_22Q2SMsNI0
X-Proofpoint-GUID: yLobIjQyCauODSSkr7hVm_22Q2SMsNI0
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698c3df2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=5ZRK68NpwNn3dGJtUu0A:9 a=CjuIK1q_8ugA:10 a=ODdyehY1IsyT0BtBtVMA:9
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110067
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13669-lists,linux-ext4=lfdr.de];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-ext4,ccf1421545dbe5caa20c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 65F2C1223D8
X-Rspamd-Action: no action


--KAOAPSMP4V4RQ8AI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2026 at 12:54:03PM -0800, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com
> Tested-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         4f5e8e6f et4: allow zeroout when doing written to unwr..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> console output: https://syzkaller.appspot.com/x/log.txt?x=15739b22580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d6f33a580000
> 
> Note: testing is done by a robot and is best-effort only.

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev


--KAOAPSMP4V4RQ8AI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ext4-add-logging-to-debug-issue.patch

From b185657580be6f773d45821709ba4fd3467c0788 Mon Sep 17 00:00:00 2001
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date: Tue, 10 Feb 2026 17:59:17 +0530
Subject: [PATCH] ext4: add logging to debug issue

---
 fs/ext4/extents.c        | 30 ++++++++++++++++++++++++++++++
 fs/ext4/extents_status.c | 23 +++++++++++++++++++++++
 fs/ext4/mballoc.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3630b27e4fd7..81dbe3a33777 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -529,6 +529,9 @@ static void ext4_cache_extents(struct inode *inode,
 	int i;
 
 	KUNIT_STATIC_STUB_REDIRECT(ext4_cache_extents, inode, eh);
+	ext4_warning_inode(inode, "%s: caching extents\n", __func__);
+	if (!strncmp(inode->i_sb->s_id, "loop", 4))
+		dump_stack();
 
 	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
 		unsigned int status = EXTENT_STATUS_WRITTEN;
@@ -2006,6 +2009,22 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		goto errout;
 	}
 
+	ext4_warning_inode(
+		inode,
+		"%s: add newext [%u, %u, %llu, unwrit:%d] to extent tree.\n",
+		__func__, le32_to_cpu(newext->ee_block),
+		ext4_ext_get_actual_len(newext), ext4_ext_pblock(newext),
+		ext4_ext_is_unwritten(newext));
+
+	if (ex) {
+		ext4_warning_inode(
+			inode,
+			"%s: ext at current path: [%u, %u, %llu, unwrit:%d]\n",
+			__func__, le32_to_cpu(ex->ee_block),
+			ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex),
+			ext4_ext_is_unwritten(ex));
+	}
+
 	/* try to insert block into found extent and return */
 	if (ex && !(gb_flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE)) {
 
@@ -2832,6 +2851,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	int i = 0, err = 0;
 	int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
 
+	ext4_warning_inode(
+		inode,
+		"%s: remove range [%u, %u] from extent tree\n",
+		__func__, start, end);
+
 	partial.pclu = 0;
 	partial.lblk = 0;
 	partial.state = initial;
@@ -4456,6 +4480,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 	}
 
+	ext4_warning_inode(
+		inode,
+		"%s: add newext [%u, %u, %llu, unwrit:%d] to extent tree.\n",
+		__func__, le32_to_cpu(newex.ee_block),
+		ext4_ext_get_actual_len(&newex), ext4_ext_pblock(&newex),
+		ext4_ext_is_unwritten(&newex));
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index a1538bac51c6..ce582b3dc83c 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -847,6 +847,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 	struct rb_node *parent = NULL;
 	struct extent_status *es;
 
+	ext4_warning_inode(inode, "%s: add lblk:%u len:%u pblk:%llu status:0x%x]\n", __func__,
+			   newes->es_lblk, newes->es_len, ext4_es_pblock(newes),
+			   ext4_es_status(newes));
+
 	while (*p) {
 		parent = *p;
 		es = rb_entry(parent, struct extent_status, rb_node);
@@ -921,6 +925,10 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
+	ext4_warning_inode(
+		inode,
+		"%s: add lblk:%u len:%u pblk:%llu 0x%x to es\n",
+		__func__, lblk, len, pblk, status);
 
 	if (!len)
 		return;
@@ -1031,6 +1039,11 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	bool conflict = false;
 	int err;
 
+	ext4_warning_inode(
+		inode,
+		"%s: cache extent lblk:%u len:%u pblk:%llu status:0x%x\n",
+		__func__, lblk, len, pblk, status);
+
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
@@ -1493,6 +1506,11 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	bool count_reserved = true;
 	struct rsvd_count rc;
 
+	ext4_warning_inode(
+		inode,
+		"%s: remove [%u,%u] range from extent status tree of inode %lu\n",
+		__func__, lblk, end, inode->i_ino);
+
 	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
 		count_reserved = false;
 	if (status == 0)
@@ -1631,8 +1649,13 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
+	if (!strncmp(inode->i_sb->s_id, "loop", 4))
+		dump_stack();
+
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
+	ext4_warning_inode(inode, "%s: remove lblk:%u len:%u from es\n",
+			   __func__, lblk, len);
 
 	if (!len)
 		return;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index dbc82b65f810..a37d6e3e004d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2004,6 +2004,18 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 	int last = first + count - 1;
 	struct super_block *sb = e4b->bd_sb;
 
+	ext4_fsblk_t pblk =
+		ext4_group_first_block_no(e4b->bd_sb, e4b->bd_group) +
+		(first << EXT4_SB(e4b->bd_sb)->s_cluster_bits);
+
+	if (inode)
+		ext4_warning_inode(inode, "%s: trying to free pblk:%llu count:%d\n",
+				__func__, pblk, count);
+	else
+		ext4_warning(sb, "%s: trying to free pblk:%llu count:%d\n",
+				__func__, pblk, count);
+
+
 	if (WARN_ON(count == 0))
 		return;
 	BUG_ON(last >= (sb->s_blocksize << 3));
@@ -3101,6 +3113,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 	if (!err && ac->ac_status != AC_STATUS_FOUND && ac->ac_first_err)
 		err = ac->ac_first_err;
 
+	ext4_warning_inode(
+		ac->ac_inode,
+		"%s: Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
+		__func__, ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
+		ac->ac_flags, ac->ac_criteria, err);
+
 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, cr %d ret %d\n",
 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
 		 ac->ac_flags, ac->ac_criteria, err);
@@ -6251,6 +6269,10 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	sb = ar->inode->i_sb;
 	sbi = EXT4_SB(sb);
 
+	ext4_warning_inode(ar->inode,
+			   "%s: Allocation requested for: lblk:%u len:%d\n",
+			   __func__, ar->logical, ar->len);
+
 	trace_ext4_request_blocks(ar);
 	if (sbi->s_mount_state & EXT4_FC_REPLAY)
 		return ext4_mb_new_blocks_simple(ar, errp);
@@ -6334,6 +6356,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ext4_mb_pa_put_free(ac);
 	}
 	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
+		ext4_warning_inode(
+			ar->inode,
+			"%s: Allocation found: lblk:%u, len:%d, pblk:%llu\n",
+			__func__, ar->logical, ac->ac_b_ex.fe_len,
+			ext4_grp_offs_to_block(sb, &ac->ac_b_ex));
 		*errp = ext4_mb_mark_diskspace_used(ac, handle);
 		if (*errp) {
 			ext4_discard_allocated_blocks(ac);
-- 
2.52.0


--KAOAPSMP4V4RQ8AI--


