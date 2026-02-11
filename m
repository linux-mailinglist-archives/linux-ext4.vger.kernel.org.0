Return-Path: <linux-ext4+bounces-13674-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGFoJ1SHjGmHqgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13674-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 14:42:44 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2813F124DEE
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3671A3005A82
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666A28CF5D;
	Wed, 11 Feb 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ilKZzRPi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E02191F94;
	Wed, 11 Feb 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817361; cv=none; b=F2lPXz68QFwrjgdG7dyG4u7LqiYjqiV5Ifi1XyIy9lfBVOIxApuFaOo8PbSgXG6GbH7trZE3IiH9RJPU6HuCNVwuQcigLKwrSjWRloHyLMdjvdbq4NzXlYQ8aq621nVQ2eMul+u+QtW0+a2sOZP5kH5+DPM38bQuy+2NKbxrgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817361; c=relaxed/simple;
	bh=LAeHEsTseBTiviMP5+v2KGtbMVvUXbwADiCzIFDtPOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alX5unmsoxBW0QyIG4fKzvxm11V4iTtpPu+ikoUs0jdC/u7gCOQOKnlFagfAcl7/AYqJX9PNTD/h+DMPIVOo8q+tPkeF8M/7+6RbQHUGHq2cCAu4n/4QatheWTar7/kjxQv6y5UNXxgcHujXrxvygfSavJ1vy5f2QmVbLN/oaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ilKZzRPi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AM0IjW239438;
	Wed, 11 Feb 2026 13:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BeSvdzlhrcXKoe9AzF1nbNB6HPUQU5
	ShwBQt+l12aQs=; b=ilKZzRPim+HMPdHfiHbUBt1j9pQqlV3jn0GhFf/56UN7Az
	vXC1RmUVkQ1UKVM9EFir0Znn1vKgYB1tDy0BCY2X0nOwSdFf81r5CRX6iRu9kwxK
	xpdJ2DRmucKPB40CtEMBsdhBXWCEoQhbDJJ7VsCwa7ZtdPKKSXZjccuAHYLh6MvI
	Ej6jH2vDnqXb/f5RZuN+RHb7yRj12mVHlysoG9SBIHEifBG5HYR+dJHdiaDy+iqh
	PoTTZX/10VpdpTMp0Jcue6fbueTAS/eq90/pFOmRwU7LMJPyHlVCxU2EQwuu6RcS
	g8xVq/0EHBtAgRD4UXRzgDPyCp1a88+RnINbSnbw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uxvm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 13:42:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B8mr9x008400;
	Wed, 11 Feb 2026 13:42:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ye2dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 13:42:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61BDgYmS30278102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 13:42:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6014820043;
	Wed, 11 Feb 2026 13:42:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B273520040;
	Wed, 11 Feb 2026 13:42:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.166])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Feb 2026 13:42:32 +0000 (GMT)
Date: Wed, 11 Feb 2026 19:12:47 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
Message-ID: <aYyHV-wPS0UrL59y@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aYw97hffWIoiQQGH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <698c53d6.050a0220.340abe.000c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZruV+Od8xhooyEg5"
Content-Disposition: inline
In-Reply-To: <698c53d6.050a0220.340abe.000c.GAE@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDEwMyBTYWx0ZWRfX7IXXPrAH6T0x
 8kXkjaGXsYq9WMg5oxA+z7rceR51zELXLt8agrPdb5cFNZfqSJMG/95ldw42pUXXdl+2LCU7epo
 zlll9FscveX3WzRKg7M41ycv9bKb2GpDIfrLV/LggSNdaHaKGpitPkMJR1vecVIHSxyjxBtE9//
 RnG5rQIOuV/FaO5sOS9GEpCsBmnd/aiz5kI/8LXMIUnG3O2PvNhYl/N1fO9UT3XjUtAvnUGLgP+
 3jt49mGYREYRhMMsbqQ6cU/uq7L7vpgXtGiXN6ABT4E6cw7j2p/rkMIYvKrViBN3Cm7e3EV6feh
 hMH+xZUEqVq2AS8uE2Samx9MXVFTVQ+BrN9mdWg4EqH8llD19G06hG6VENo0kJoWzq4/AnyH+Rx
 DGG+PON7rmBmJoPo7Lq/resWDdKijY4ibnaGbLPzGUkUtcS++D+Kx1nMNXbI1gb728lmqYpGywz
 6Vev6p1b9B7Ijlp294w==
X-Proofpoint-ORIG-GUID: NBBVEFN5rRpKxPEh3asgU8NKshSDcZfN
X-Proofpoint-GUID: NBBVEFN5rRpKxPEh3asgU8NKshSDcZfN
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698c874d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=9MqdOkaDun1aO7x-NdkA:9 a=CjuIK1q_8ugA:10 a=ODdyehY1IsyT0BtBtVMA:9
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_01,2026-02-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	TAGGED_FROM(0.00)[bounces-13674-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com:mid,appspotmail.com:email];
	TAGGED_RCPT(0.00)[linux-ext4,ccf1421545dbe5caa20c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2813F124DEE
X-Rspamd-Action: no action


--ZruV+Od8xhooyEg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2026 at 02:03:02AM -0800, syzbot wrote:
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
> console output: https://syzkaller.appspot.com/x/log.txt?x=17815b22580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=120cccaa580000
> 
> Note: testing is done by a robot and is best-effort only.

Okay I think adding dump_stack() in the patches is leading to weird
invalid opcodes in syzbot which is hiding the actual issue. 

Lets try again (sorry for the spam, somehow im unable to replicate in my
vm):

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev



--ZruV+Od8xhooyEg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-ext4-add-logging-to-debug-issue.patch

From 7086e36d23ddbee429c3f0ca271f7e188f81bd61 Mon Sep 17 00:00:00 2001
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date: Tue, 10 Feb 2026 17:59:17 +0530
Subject: [PATCH] ext4: add logging to debug issue

---
 fs/ext4/extents.c        | 28 ++++++++++++++++++++++++++++
 fs/ext4/extents_status.c | 20 ++++++++++++++++++++
 fs/ext4/mballoc.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3630b27e4fd7..89a681f6e5ca 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -529,6 +529,7 @@ static void ext4_cache_extents(struct inode *inode,
 	int i;
 
 	KUNIT_STATIC_STUB_REDIRECT(ext4_cache_extents, inode, eh);
+	ext4_warning_inode(inode, "%s: caching extents\n", __func__);
 
 	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
 		unsigned int status = EXTENT_STATUS_WRITTEN;
@@ -2006,6 +2007,22 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
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
 
@@ -2832,6 +2849,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
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
@@ -4456,6 +4478,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
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
index a1538bac51c6..009c22108a7f 100644
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
@@ -1633,6 +1651,8 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
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


--ZruV+Od8xhooyEg5--


