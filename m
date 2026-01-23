Return-Path: <linux-ext4+bounces-13256-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENKSF5AUc2l3sAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13256-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:26:24 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB370F40
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92851300370A
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CB38A724;
	Fri, 23 Jan 2026 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RayHvLBC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32120372B2B;
	Fri, 23 Jan 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149571; cv=none; b=kJdJuAumJh370abHUYwLFWUW5eY6waFxTusZYIlNOPAOxv4l9Jg7tUtyvo2JtgaVqJp2IddDmigQ+rR7/xt2njc9Sj6RvkAHMtkFbDLf1VKtKTj+Nf+SR9qZ9ACTVcGlzUHSkSVQJBqJvVfjEA2vQ5N+bA/jf8VOzeQ+ypwHsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149571; c=relaxed/simple;
	bh=1OCvyJFcfGf4F80MZCh11VsAkqTDLjw/2cwZJpZsTrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNfMc3a+Plzper4TL8ChYMMSxFcIoythfAfCqMgxesBBJDtMd43cOXswljvtM/Uzb1qv+6GTD3gIpAEDE7rn1bb7l7zlvLjW/kPApH+vrQIF36fKQdnBIcmKDMui7DWR84KaFJslzi5vvMM8tfC+/jPtD2rYKJyUknNYmY/vI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RayHvLBC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MIHdJQ005941;
	Fri, 23 Jan 2026 06:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cGOo9GbL+Hw0tFROu
	LSC/D9tWOMq6qVuZl8QitzOePQ=; b=RayHvLBCyMnDcVWfaONRafzU35K5FE0q6
	2bLwWcvexNk+PGk888IaqI3Okf08cwR5sRnJN1GDSzRmSUYsByfxQK6tft1kfsSP
	X4mZxhW6Bk+hc2ubJU+ewnwGasbsGtvtXkgRvnyvevUB9i0JyFwrrTJDbGAdVuEp
	DG7u3Rozczshqr1OWKu7WANZ8fGwT17lv1CO8gLN8Czch/XIDzLsJMtPaZ1zPyIZ
	s/hde6Sf/4/oWUMs7wZfTW3vRO8mjN9PvLP2XpzVDX2LIgUvr5jlWLMdjQAkEnAl
	c3xGfnMstRB4EKJwO1/tdwrl2HgO9kt89VFEUTrC6cna32VPk3+1A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bus1ptpym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6PlcZ018495;
	Fri, 23 Jan 2026 06:25:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bus1ptpyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N4fcpa001162;
	Fri, 23 Jan 2026 06:25:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyk7a39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6Pioj30212482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:25:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82C9B2004F;
	Fri, 23 Jan 2026 06:25:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D92A20043;
	Fri, 23 Jan 2026 06:25:42 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:42 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] ext4: kunit tests for extent splitting and conversion
Date: Fri, 23 Jan 2026 11:55:32 +0530
Message-ID: <22bb9d17cd88c1318a2edde48887ca7488cb8a13.1769149131.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769149131.git.ojaswin@linux.ibm.com>
References: <cover.1769149131.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n6v2Cq2BjCQTFnTanNOJLe9wVhsKIr4x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfX6SFRmN6/nvLk
 Il5hPoAm0Xf0LJf0D7ziTxi2L2sOjovmEYzsrFFrkzg/Vc3ekWIKkrBVaYHXiiZdY0HFMNIKLAD
 JXKWnH2AewmuEFdBpsjXuD4eg408PM+FdMXbO2MzXhWxt7/74b6+FcjVoo/NfJwvoDl8tAZTBZE
 Y76b/7BQUwsFolXNjaw7w/wMNbOsXS7Rw+ITqXbMbWPDZ+ztznNIUMk/mnbEH+QuOxOERLi9yT+
 3PqwzPkG3gn8+vRzSsAkbdyxXW/YZyrTVfANINkOLW8QtyfjIKvJkuq9LGoczRF5E0363lvckiA
 7cg6k0yFclE3vivzxJPTPMQ5ea4yhJcr/9GN4YkgeLsUD+RtrcA+kw2jFwR8v8mt5tyzhZ4A3bQ
 bur9Z1BapkDKCwZvcXY0LNnME4jiCxMPEQMc9eQuoEruSZqRPvcBdXmWDiLB/ILKy8kVsZv2ymy
 Zs2RhAwDUygKd0XJUDg==
X-Proofpoint-GUID: _0wVEQ-IeObNMquNG858K0KWEjFf2wc2
X-Authority-Analysis: v=2.4 cv=GY8aXAXL c=1 sm=1 tr=0 ts=6973146b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=OOxyGJNtmdNL3i7zqkUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13256-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: 29BB370F40
X-Rspamd-Action: no action

Add multiple KUnit tests to test various permutations of extent
splitting and conversion.

We test the following cases:

1. Split of unwritten extent into 2 parts and convert 1 part to written
2. Split of unwritten extent into 3 parts and convert 1 part to written
3. Split of written extent into 2 parts and convert 1 part to unwritten
4. Split of written extent into 3 parts and convert 1 part to unwritten
5. Zeroout fallback for all the above cases except 3-4 because zeroout
   is not supported for written to unwritten splits

The main function we test here is ext4_split_convert_extents().
Currently some of the tests are failing due to issues in implementation.
All failures are mitigated at other layers in ext4 [1] but still point
out the mismatch in expectation of what the caller wants vs what the
function does.

The aim is to eventually fix all the failures we see here. More detailed
implementation notes can be found in the topmost commit in the test
file.

[1] for example, EXT4_GET_BLOCKS_CONVERT doesn't really convert the
split extent to written, but rather the callers end up doing the
conversion.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c   | 559 +++++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c        |  23 +-
 fs/ext4/extents_status.c |   3 +
 fs/ext4/inode.c          |   4 +
 4 files changed, 587 insertions(+), 2 deletions(-)
 create mode 100644 fs/ext4/extents-test.c

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
new file mode 100644
index 000000000000..15053c607cfd
--- /dev/null
+++ b/fs/ext4/extents-test.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Written by Ojaswin Mujoo <ojaswin@linux.ibm.com> (IBM)
+ *
+ * These Kunit tests are designed to test the functionality of
+ * extent split and conversion in ext4.
+ *
+ * Currently, ext4 can split extents in 2 ways:
+ * 1. By splitting the extents in the extent tree and optionally converting them
+ *    to written or unwritten based on flags passed.
+ * 2. In case 1 encounters an error, ext4 instead zerooes out the unwritten
+ *    areas of the extent and marks the complete extent written.
+ *
+ * The primary function that handles this is ext4_split_convert_extents().
+ *
+ * We test both of the methods of split. The behavior we try to enforce is:
+ * 1. When passing EXT4_GET_BLOCKS_CONVERT flag to ext4_split_convert_extents(),
+ *    the split extent should be converted to initialized.
+ * 2. When passing EXT4_GET_BLOCKS_CONVERT_UNWRITTEN flag to
+ *    ext4_split_convert_extents(), the split extent should be converted to
+ *    uninitialized.
+ * 3. In case we use the zeroout method, then we should correctly write zeroes
+ *    to the unwritten areas of the extent and we should not corrupt/leak any
+ *    data.
+ *
+ * Enforcing 1 and 2 is straight forward, we just setup a minimal inode with
+ * extent tree, call ext4_split_convert_extents() and check the final state of
+ * the extent tree.
+ *
+ * For zeroout testing, we maintain a separate buffer which represents the disk
+ * data corresponding to the extents. We then override ext4's zeroout functions
+ * to instead write zeroes to our buffer. Then, we override
+ * ext4_ext_insert_extent() to return -ENOSPC, which triggers the zeroout.
+ * Finally, we check the state of the extent tree and zeroout buffer to confirm
+ * everything went well.
+ */
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+#include <linux/gfp_types.h>
+#include <linux/stddef.h>
+
+#include "ext4.h"
+#include "ext4_extents.h"
+
+#define EXT_DATA_PBLK 100
+#define EXT_DATA_LBLK 10
+#define EXT_DATA_LEN 3
+
+struct kunit_ctx {
+	/*
+	 * Ext4 inode which has only 1 unwrit extent
+	 */
+	struct ext4_inode_info *k_ei;
+	/*
+	 * Represents the underlying data area (used for zeroout testing)
+	 */
+	char *k_data;
+} k_ctx;
+
+/*
+ * describes the state of an expected extent in extent tree.
+ */
+struct kunit_ext_state {
+	ext4_lblk_t ex_lblk;
+	ext4_lblk_t ex_len;
+	bool is_unwrit;
+};
+
+/*
+ * describes the state of the data area of a writ extent. Used for testing
+ * correctness of zeroout.
+ */
+struct kunit_ext_data_state {
+	char exp_char;
+	ext4_lblk_t off_blk;
+	ext4_lblk_t len_blk;
+};
+
+struct kunit_ext_test_param {
+	/* description of test */
+	char *desc;
+
+	/* is extent unwrit at beginning of test */
+	bool is_unwrit_at_start;
+
+	/* flags to pass while splitting */
+	int split_flags;
+
+	/* map describing range to split */
+	struct ext4_map_blocks split_map;
+
+	/* no of extents expected after split */
+	int nr_exp_ext;
+
+	/*
+	 * expected state of extents after split. We will never split into more
+	 * than 3 extents
+	 */
+	struct kunit_ext_state exp_ext_state[3];
+
+	/* Below fields used for zeroout tests */
+
+	bool is_zeroout_test;
+	/*
+	 * no of expected data segments (zeroout tests). Example, if we expect
+	 * data to be 4kb 0s, followed by 8kb non-zero, then nr_exp_data_segs==2
+	 */
+	int nr_exp_data_segs;
+
+	/*
+	 * expected state of data area after zeroout.
+	 */
+	struct kunit_ext_data_state exp_data_state[3];
+};
+
+static void ext_kill_sb(struct super_block *sb)
+{
+	generic_shutdown_super(sb);
+}
+
+static int ext_set(struct super_block *sb, void *data)
+{
+	return 0;
+}
+
+static struct file_system_type ext_fs_type = {
+	.name = "extents test",
+	.kill_sb = ext_kill_sb,
+};
+
+static void extents_kunit_exit(struct kunit *test)
+{
+	kfree(k_ctx.k_ei);
+	kfree(k_ctx.k_data);
+}
+
+static void ext4_cache_extents_stub(struct inode *inode,
+				    struct ext4_extent_header *eh)
+{
+	return;
+}
+
+static int __ext4_ext_dirty_stub(const char *where, unsigned int line,
+				 handle_t *handle, struct inode *inode,
+				 struct ext4_ext_path *path)
+{
+	return 0;
+}
+
+static struct ext4_ext_path *
+ext4_ext_insert_extent_stub(handle_t *handle, struct inode *inode,
+			    struct ext4_ext_path *path,
+			    struct ext4_extent *newext, int gb_flags)
+{
+	return ERR_PTR(-ENOSPC);
+}
+
+static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
+				       ext4_lblk_t len)
+{
+	return;
+}
+
+static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
+{
+	return;
+}
+
+/*
+ * We will zeroout the equivalent range in the data area
+ */
+static int ext4_ext_zeroout_stub(struct inode *inode, struct ext4_extent *ex)
+{
+	ext4_lblk_t ee_block, off_blk;
+	loff_t ee_len;
+	loff_t off_bytes;
+	struct kunit *test = kunit_get_current_test();
+
+	ee_block = le32_to_cpu(ex->ee_block);
+	ee_len = ext4_ext_get_actual_len(ex);
+
+	KUNIT_EXPECT_EQ_MSG(test, 1, ee_block >= EXT_DATA_LBLK, "ee_block=%d",
+			    ee_block);
+	KUNIT_EXPECT_EQ(test, 1,
+			ee_block + ee_len <= EXT_DATA_LBLK + EXT_DATA_LEN);
+
+	off_blk = ee_block - EXT_DATA_LBLK;
+	off_bytes = off_blk << inode->i_sb->s_blocksize_bits;
+	memset(k_ctx.k_data + off_bytes, 0,
+	       ee_len << inode->i_sb->s_blocksize_bits);
+
+	return 0;
+}
+
+static int ext4_issue_zeroout_stub(struct inode *inode, ext4_lblk_t lblk,
+				   ext4_fsblk_t pblk, ext4_lblk_t len)
+{
+	ext4_lblk_t off_blk;
+	loff_t off_bytes;
+	struct kunit *test = kunit_get_current_test();
+
+	kunit_log(KERN_ALERT, test,
+		  "%s: lblk=%u pblk=%llu len=%u", __func__, lblk, pblk, len);
+	KUNIT_EXPECT_EQ(test, 1, lblk >= EXT_DATA_LBLK);
+	KUNIT_EXPECT_EQ(test, 1, lblk + len <= EXT_DATA_LBLK + EXT_DATA_LEN);
+	KUNIT_EXPECT_EQ(test, 1, lblk - EXT_DATA_LBLK == pblk - EXT_DATA_PBLK);
+
+	off_blk = lblk - EXT_DATA_LBLK;
+	off_bytes = off_blk << inode->i_sb->s_blocksize_bits;
+	memset(k_ctx.k_data + off_bytes, 0,
+	       len << inode->i_sb->s_blocksize_bits);
+
+	return 0;
+}
+
+static int extents_kunit_init(struct kunit *test)
+{
+	struct ext4_extent_header *eh = NULL;
+	struct ext4_inode_info *ei;
+	struct inode *inode;
+	struct super_block *sb;
+	struct kunit_ext_test_param *param =
+		(struct kunit_ext_test_param *)(test->param_value);
+
+	/* setup the mock inode */
+	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
+	if (k_ctx.k_ei == NULL)
+		return -ENOMEM;
+	ei = k_ctx.k_ei;
+	inode = &ei->vfs_inode;
+
+	sb = sget(&ext_fs_type, NULL, ext_set, 0, NULL);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	sb->s_blocksize = 4096;
+	sb->s_blocksize_bits = 12;
+
+	ei->i_disksize = (EXT_DATA_LBLK + EXT_DATA_LEN + 10) << sb->s_blocksize_bits;
+	inode->i_sb = sb;
+
+	k_ctx.k_data = kzalloc(EXT_DATA_LEN * 4096, GFP_KERNEL);
+	if (k_ctx.k_data == NULL)
+		return -ENOMEM;
+
+	/*
+	 * set the data area to a junk value
+	 */
+	memset(k_ctx.k_data, 'X', EXT_DATA_LEN * 4096);
+
+	/* create a tree with depth 0 */
+	eh = (struct ext4_extent_header *)k_ctx.k_ei->i_data;
+
+	/* Fill extent header */
+	eh = ext_inode_hdr(&k_ctx.k_ei->vfs_inode);
+	eh->eh_depth = 0;
+	eh->eh_entries = cpu_to_le16(1);
+	eh->eh_magic = EXT4_EXT_MAGIC;
+	eh->eh_max =
+		cpu_to_le16(ext4_ext_space_root_idx(&k_ctx.k_ei->vfs_inode, 0));
+	eh->eh_generation = 0;
+
+	/*
+	 * add 1 extent in leaf node covering lblks [10,13) and pblk [100,103)
+	 */
+	EXT_FIRST_EXTENT(eh)->ee_block = cpu_to_le32(EXT_DATA_LBLK);
+	EXT_FIRST_EXTENT(eh)->ee_len = cpu_to_le16(EXT_DATA_LEN);
+	ext4_ext_store_pblock(EXT_FIRST_EXTENT(eh), EXT_DATA_PBLK);
+	if (!param || param->is_unwrit_at_start)
+		ext4_ext_mark_unwritten(EXT_FIRST_EXTENT(eh));
+
+	/* Add stubs */
+	kunit_activate_static_stub(test, ext4_cache_extents,
+				   ext4_cache_extents_stub);
+	kunit_activate_static_stub(test, __ext4_ext_dirty,
+				   __ext4_ext_dirty_stub);
+	kunit_activate_static_stub(test, ext4_es_remove_extent,
+				   ext4_es_remove_extent_stub);
+	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
+	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
+	kunit_activate_static_stub(test, ext4_issue_zeroout,
+				   ext4_issue_zeroout_stub);
+	return 0;
+}
+
+/*
+ * Return 1 if all bytes in the buf equal to c, else return the offset of first mismatch
+ */
+static int check_buffer(char *buf, int c, int size)
+{
+	void *ret = NULL;
+
+	ret = memchr_inv(buf, c, size);
+	if (ret  == NULL)
+		return 0;
+
+	kunit_log(KERN_ALERT, kunit_get_current_test(),
+		  "# %s: wrong char found at offset %u (expected:%d got:%d)", __func__,
+		  (u32)((char *)ret - buf), c, *((char *)ret));
+	return 1;
+}
+
+static void test_split_convert(struct kunit *test)
+{
+	struct ext4_ext_path *path;
+	struct inode *inode = &k_ctx.k_ei->vfs_inode;
+	struct ext4_extent *ex;
+	struct ext4_map_blocks map;
+	const struct kunit_ext_test_param *param =
+		(const struct kunit_ext_test_param *)(test->param_value);
+	int blkbits = inode->i_sb->s_blocksize_bits;
+
+	if (param->is_zeroout_test)
+		/*
+		 * Force zeroout by making ext4_ext_insert_extent return ENOSPC
+		 */
+		kunit_activate_static_stub(test, ext4_ext_insert_extent,
+					   ext4_ext_insert_extent_stub);
+
+	path = ext4_find_extent(inode, EXT_DATA_LBLK, NULL, 0);
+	ex = path->p_ext;
+	KUNIT_EXPECT_EQ(test, EXT_DATA_LBLK, le32_to_cpu(ex->ee_block));
+	KUNIT_EXPECT_EQ(test, EXT_DATA_LEN, ext4_ext_get_actual_len(ex));
+	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start,
+			ext4_ext_is_unwritten(ex));
+	if (param->is_zeroout_test)
+		KUNIT_EXPECT_EQ(test, 0,
+				check_buffer(k_ctx.k_data, 'X',
+					     EXT_DATA_LEN << blkbits));
+
+	map.m_lblk = param->split_map.m_lblk;
+	map.m_len = param->split_map.m_len;
+	ext4_split_convert_extents(NULL, inode, &map, path,
+				   param->split_flags, NULL);
+
+	path = ext4_find_extent(inode, EXT_DATA_LBLK, NULL, 0);
+	ex = path->p_ext;
+
+	for (int i = 0; i < param->nr_exp_ext; i++) {
+		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
+
+		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk,
+				le32_to_cpu(ex->ee_block));
+		KUNIT_EXPECT_EQ(test, exp_ext.ex_len,
+				ext4_ext_get_actual_len(ex));
+		KUNIT_EXPECT_EQ(test, exp_ext.is_unwrit,
+				ext4_ext_is_unwritten(ex));
+
+		/* Only printed on failure */
+		kunit_log(KERN_INFO, test,
+			  "# [extent %d] exp: lblk:%d len:%d unwrit:%d \n", i,
+			  exp_ext.ex_lblk, exp_ext.ex_len, exp_ext.is_unwrit);
+		kunit_log(KERN_INFO, test,
+			  "# [extent %d] got: lblk:%d len:%d unwrit:%d\n", i,
+			  le32_to_cpu(ex->ee_block),
+			  ext4_ext_get_actual_len(ex),
+			  ext4_ext_is_unwritten(ex));
+		kunit_log(KERN_INFO, test, "------------------\n");
+
+		ex = ex + 1;
+	}
+
+	if (!param->is_zeroout_test)
+		return;
+
+	/*
+	 * Check that then data area has been zeroed out correctly
+	 */
+	for (int i = 0; i < param->nr_exp_data_segs; i++) {
+		loff_t off, len;
+		struct kunit_ext_data_state exp_data_seg = param->exp_data_state[i];
+
+		off = exp_data_seg.off_blk << blkbits;
+		len = exp_data_seg.len_blk << blkbits;
+		KUNIT_EXPECT_EQ_MSG(test, 0,
+				    check_buffer(k_ctx.k_data + off,
+						 exp_data_seg.exp_char, len),
+				    "# corruption in byte range [%lld, %lld)",
+				    off, len);
+	}
+
+	return;
+}
+
+static const struct kunit_ext_test_param test_split_convert_params[] = {
+	/* unwrit to writ splits */
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 2,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1 + (EXT_DATA_LEN - 2),
+			       .ex_len = 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+
+	/* writ to unwrit splits */
+	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 2,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 1,
+			       .is_unwrit = 1 } },
+	  .is_zeroout_test = 0 },
+	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
+	  .is_unwrit_at_start = 0,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 3,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = 1,
+			       .is_unwrit = 0 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1,
+			       .ex_len = EXT_DATA_LEN - 2,
+			       .is_unwrit = 1 },
+			     { .ex_lblk = EXT_DATA_LBLK + 1 + (EXT_DATA_LEN - 2),
+			       .ex_len = 1,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 0 },
+
+	/*
+	 * ***** zeroout tests *****
+	 */
+	/* unwrit to writ splits */
+	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK, .m_len = 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 0,
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 1 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 2,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 1 } } },
+	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
+	  .is_unwrit_at_start = 1,
+	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
+	  .split_map = { .m_lblk = EXT_DATA_LBLK + 1, .m_len = EXT_DATA_LEN - 2 },
+	  .nr_exp_ext = 1,
+	  .exp_ext_state = { { .ex_lblk = EXT_DATA_LBLK,
+			       .ex_len = EXT_DATA_LEN,
+			       .is_unwrit = 0 } },
+	  .is_zeroout_test = 1,
+	  .nr_exp_data_segs = 3,
+	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
+			      { .exp_char = 'X',
+				.off_blk = 1,
+				.len_blk = EXT_DATA_LEN - 2 },
+			      { .exp_char = 0,
+				.off_blk = EXT_DATA_LEN - 1,
+				.len_blk = 1 } } },
+};
+
+static void ext_get_desc(struct kunit *test, const void *p, char *desc)
+
+{
+	struct kunit_ext_test_param *param = (struct kunit_ext_test_param *)p;
+
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s\n", param->desc);
+}
+
+static int test_split_convert_param_init(struct kunit *test)
+{
+	size_t arr_size = ARRAY_SIZE(test_split_convert_params);
+
+	kunit_register_params_array(test, test_split_convert_params, arr_size,
+				    ext_get_desc);
+	return 0;
+}
+
+/*
+ * Note that we use KUNIT_CASE_PARAM_WITH_INIT() instead of the more compact
+ * KUNIT_ARRAY_PARAM() because the later currently has a limitation causing the
+ * output parsing to be prone to error. For more context:
+ *
+ * https://lore.kernel.org/linux-kselftest/aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com/
+ */
+static struct kunit_case extents_test_cases[] = {
+	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
+				   test_split_convert_param_init, NULL),
+	{}
+};
+
+static struct kunit_suite extents_test_suite = {
+	.name = "ext4_extents_test",
+	.init = extents_kunit_init,
+	.exit = extents_kunit_exit,
+	.test_cases = extents_test_cases,
+};
+
+kunit_test_suites(&extents_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3c288d4b19d2..08aa36854c11 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -32,6 +32,7 @@
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
 #include "xattr.h"
+#include <kunit/static_stub.h>
 
 #include <trace/events/ext4.h>
 
@@ -197,6 +198,9 @@ static int __ext4_ext_dirty(const char *where, unsigned int line,
 {
 	int err;
 
+	KUNIT_STATIC_STUB_REDIRECT(__ext4_ext_dirty, where, line, handle, inode,
+				   path);
+
 	WARN_ON(!rwsem_is_locked(&EXT4_I(inode)->i_data_sem));
 	if (path->p_bh) {
 		ext4_extent_block_csum_set(inode, ext_block_hdr(path->p_bh));
@@ -535,6 +539,8 @@ static void ext4_cache_extents(struct inode *inode,
 	ext4_lblk_t prev = 0;
 	int i;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_cache_extents, inode, eh);
+
 	for (i = le16_to_cpu(eh->eh_entries); i > 0; i--, ex++) {
 		unsigned int status = EXTENT_STATUS_WRITTEN;
 		ext4_lblk_t lblk = le32_to_cpu(ex->ee_block);
@@ -898,6 +904,8 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	int ret;
 	gfp_t gfp_flags = GFP_NOFS;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_find_extent, inode, block, path, flags);
+
 	if (flags & EXT4_EX_NOFAIL)
 		gfp_flags |= __GFP_NOFAIL;
 
@@ -1990,6 +1998,9 @@ ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	ext4_lblk_t next;
 	int mb_flags = 0, unwritten;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_ext_insert_extent, handle, inode, path,
+				   newext, gb_flags);
+
 	if (gb_flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
 		mb_flags |= EXT4_MB_DELALLOC_RESERVED;
 	if (unlikely(ext4_ext_get_actual_len(newext) == 0)) {
@@ -3134,8 +3145,10 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 	ext4_fsblk_t ee_pblock;
 	unsigned int ee_len;
 
-	ee_block  = le32_to_cpu(ex->ee_block);
-	ee_len    = ext4_ext_get_actual_len(ex);
+	KUNIT_STATIC_STUB_REDIRECT(ext4_zeroout_es, inode, ex);
+
+	ee_block = le32_to_cpu(ex->ee_block);
+	ee_len = ext4_ext_get_actual_len(ex);
 	ee_pblock = ext4_ext_pblock(ex);
 
 	if (ee_len == 0)
@@ -3151,6 +3164,8 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
 	ext4_fsblk_t ee_pblock;
 	unsigned int ee_len;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_ext_zeroout, inode, ex);
+
 	ee_len    = ext4_ext_get_actual_len(ex);
 	ee_pblock = ext4_ext_pblock(ex);
 	return ext4_issue_zeroout(inode, le32_to_cpu(ex->ee_block), ee_pblock,
@@ -6177,3 +6192,7 @@ int ext4_ext_clear_bb(struct inode *inode)
 	ext4_free_ext_path(path);
 	return 0;
 }
+
+#ifdef CONFIG_EXT4_KUNIT_TESTS
+#include "extents-test.c"
+#endif
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index fc83e7e2ca9e..6c1faf7c9f2a 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -16,6 +16,7 @@
 #include "ext4.h"
 
 #include <trace/events/ext4.h>
+#include <kunit/static_stub.h>
 
 /*
  * According to previous discussion in Ext4 Developer Workshop, we
@@ -1627,6 +1628,8 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	int reserved = 0;
 	struct extent_status *es = NULL;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_es_remove_extent, inode, lblk, len);
+
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cf0ffd799501..fafe673e5e17 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -48,6 +48,8 @@
 #include "acl.h"
 #include "truncate.h"
 
+#include <kunit/static_stub.h>
+
 #include <trace/events/ext4.h>
 
 static void ext4_journalled_zero_new_buffers(handle_t *handle,
@@ -400,6 +402,8 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 {
 	int ret;
 
+	KUNIT_STATIC_STUB_REDIRECT(ext4_issue_zeroout, inode, lblk, pblk, len);
+
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
 		return fscrypt_zeroout_range(inode, lblk, pblk, len);
 
-- 
2.52.0


