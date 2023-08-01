Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC5D76A80F
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Aug 2023 06:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjHAEyO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 00:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjHAEyO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 00:54:14 -0400
Received: from outbound-ip7b.ess.barracuda.com (outbound-ip7b.ess.barracuda.com [209.222.82.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C48A10F0
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 21:54:11 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102]) by mx-outbound17-37.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 01 Aug 2023 04:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn8/x3kWvxih8ot18rIRgHdrgsluQx9ZPbRJBrzUQDA+/6d2lh7KuGfrmwc271ZKRbazdFvekg8BfdALLlDXwwlIlEGryXZPv4efseBmuu4x8gbD0mXW0REekeVxBXA16gS5KaJWRZT8MkOxFVAbHkFB+Osw52IE6qA9qnZdyaulLc3G1q1KJpfLdWgg7YjSbT9TP3Q0MxwYGTg9k9FYagEiWt7qcucHa6844PT+dvhiFdO+It7ci7D2xeH10sBZyBIJhrL4OuY3f0uouhJUuZXwNYEVoh2AUqymb2TVuhguJm8sM8SqV/BtSHquS9+gopby5G9afG7DLwxoSV0R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLmBE2RFPlfhEjQmfXVMr7gxpqsMBZxR3OwHHVSz1G8=;
 b=Kown+3sB/uOji8wfKHgoAkRba2fGecdaTfzS7jAYrDTMzh5lZRpMhpoMlfn3r8rWeOh2kVFCDiZf0oTELRPcKuMlciBXCrZAtT2bRMlCBfDZJWjhXhlr28jDAoa2VDL9nhmT7sddVUA7DGVqfG9cjPsZ0OFcCh8EoX3Rb2dKLMLYlyxw6CYfnvAtj179t71sTDba7Q1zEGHm4aor/2i2Qskixdyg8X+9yEVKXKyF+qSYU6pRfU82V3cC81DVN20zK9bTjRaebiobL/2v0BDriI9ilK8H+YjXxkBBwzwujlr5u2lGu7jWFIC5AubsX/stSIGNqXlhMt1V0JhxS94hrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLmBE2RFPlfhEjQmfXVMr7gxpqsMBZxR3OwHHVSz1G8=;
 b=1iyhufdf7aOWijyrIsKwRrHY/6xPcSxfJ4LbX5XBqTTtn1guZL5KDIqiQgCful0i9TIr+hiOBZtCb3qVrZcC2xs+vC4NndO8pGDURG+p1+HnxikjCaGomS6gU21LFupMaEvYb2x3U7QH4B0uFoF1kRmfQ7yDaG9UjG6l2OVtMVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 SJ0PR19MB5414.namprd19.prod.outlook.com (2603:10b6:a03:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 04:54:05 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 04:54:05 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca
Subject: [PATCH] e2fsck: use rb-tree to track EA reference counts
Date:   Tue,  1 Aug 2023 14:53:57 +1000
Message-ID: <20230801045357.1034819-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0022.ausprd01.prod.outlook.com (2603:10c6:10::34)
 To DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|SJ0PR19MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: a5da5ec9-ebda-4399-2781-08db924b54e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvyAHneMHGMASR6xfFNdAtaZYXucYGk0qy5CM4yQiEuuZCx1LPkO7YuXdqcORN/XkBWkD4PP0A7Gi/wnUejKid/8PeAI6L5LIpibCtxiOimSu+c6BUKH+ioJeV4FBzty9EVhNlmhtobt09z+4aG0UgFMUTRpBtqupQvW9duKt5tqcP7hSsUqex+zWN2I4RDV9Ft7J3K4PR/BJC8q8TLJglmN4h9bBGmn5DjLTMCwtts2vU/qnlZLALz6NYFWCFbjUdHpMHgOWJTguMHbjWchwaZjyTVWdH+vgN+OfIqAyVH5TVL0trzmgsQrMVw/kkEsqSvcYC+CHPoyA8qdXadyUjakdFM8qRFuZchTjlzZVrU4/ZgpUkSeI3pFFwehpFxxG3cyKUONmpIySaNeTDJq5apR/NjoiNwT1GtgZgyyxHL2x+XnfsTdMeew/LowCFEG4B6pspXQskfVIdlkKYtsxFiN6YVSFQbpRwtWDLEqzZGZiEuwHm4dloHHodw0t2ETXnrJerWJQH4YtDrspxeMH7VwVxuE7vZxOxZEh1bP6whYGX2VUlpDdmI90McgsPZE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39850400004)(396003)(451199021)(6916009)(55236004)(26005)(478600001)(186003)(316002)(4326008)(1076003)(6506007)(41300700001)(6666004)(6512007)(6486002)(38100700002)(30864003)(2906002)(83380400001)(5660300002)(8936002)(8676002)(2616005)(36756003)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UgU23j4S+XX0pXTAZckVHNmY4Cd+9rg74BSBpCUCXjjUUxKDF2kak8bYnDgO?=
 =?us-ascii?Q?6wlfMqdcEbJoLZ69w+e5y925dnALXuMp/lu3ZIceWUwL9Nko0/csiYgiR6w1?=
 =?us-ascii?Q?1My3GFngczcf3wadQo5KSMK4AMKPEMmFGo1cJVYHc2CWP1DT8WAfM0L48hOX?=
 =?us-ascii?Q?pQaAjD/UKPFtY4kjrzw+jj/hOwYAp4y/j8BkpS8UgINwZNF2kC7ov3qI+xRL?=
 =?us-ascii?Q?KCQDBp9ZEORWUQXNqKuuuynZDm16a6Sfmp0XvgmFzMvsUjhHrfand9P6nbaG?=
 =?us-ascii?Q?JmY/5E7CXgcxfBDyk6Q/rtGVgNEniRfdMn69jgMCn9KzFhNuJsc9rJMPZvN3?=
 =?us-ascii?Q?LVVxhoBSrayRHhCTxWhAXKwS8Has7tl+MV/ibNNIuH7HSxvu6Na8ZqL6fjcd?=
 =?us-ascii?Q?qLmCd1jTRKQZSNWWnovPTUcHviGZZ5ogGZ8iXIC6ho5zSFK+3cIkDgQELVsT?=
 =?us-ascii?Q?5sqePJAY++RgBuBE8XkZPUO8X+9EUlPDMq5SFfLog9aC/aAGof+SixTt+/1u?=
 =?us-ascii?Q?cs6tXCcuIWyXlbkXB66huzJT2/2/9ymonsH+2aPspyef/Ag7xiA87H8M9bi4?=
 =?us-ascii?Q?uzjOFjUXGbUxk1oERpBCFP9f/+27bIiYwe4GZDT0frGPhIn0S9Rq1VcCLKLo?=
 =?us-ascii?Q?XrabByw3WZujmpOHtC8IZewG9OtWuJ3idEDwX9OI+8EkpkCOV4yZEoY3/q1W?=
 =?us-ascii?Q?XXMp1a27TfYpw0af0uEdiu5r0cHsRk083ESn3HcmAHdR/NNV41zvR07okqBz?=
 =?us-ascii?Q?TiWdvTebrmr8tfLWIr/gDjeQH70H/cE4cKYIu4+Fc88h0gdgCuGRzEgZkcl+?=
 =?us-ascii?Q?UxPn/wUOeg3QM9K8TZORKFIx6o7a+t+DR0psQIs8n8V3ajjUN7KB8S6cx1mE?=
 =?us-ascii?Q?uIxCA0Qf1ezW8zn9RTtV6sZgIAU8rPiytavsh1AjwjPNVj0DoED0R177NNoO?=
 =?us-ascii?Q?uJ3K0gCvD5Bs5D6LLRq8Ms/GvTYT4YsWvPbRbXRHZEXOpe+rWfAx6XBxeATm?=
 =?us-ascii?Q?2oAWMLTTAsj7K6YFpdwtQqngjMol+R7ZAYD3lcwuOXUWCa4XKkRIDOqJNqgz?=
 =?us-ascii?Q?eINAOy99xu7wJUPPemtfnWN/Hl6+PgUA+kkWni6n0pxATqgCv6dPUjOUe0pY?=
 =?us-ascii?Q?ZPmWF86GzrC7AphgWL/ElC7+NKUnVHTt6y7MlSfIsj287WjjB0ylGWsWda7D?=
 =?us-ascii?Q?cl4KqSlQW05qz9k+DWNEWbK8M3ieitFulvdju/aPMWs7AF/lzUtqk9jNtDr6?=
 =?us-ascii?Q?k8HJX0WMvrk9rh3mMxcCyyWuZUo+NpUehdmxnRutTBmcZsDD03T2N8+2bnqz?=
 =?us-ascii?Q?p/yzTHeGtasklylnTE0XH06eB6Epb7NNQioR0iBLuSS/4meNOvhpzyGsaZh2?=
 =?us-ascii?Q?lGN0wcBswouFdHqcjtE86siC6R9A30ck5Iv9f333VYWAdVCgTDv+dbMZNK9i?=
 =?us-ascii?Q?8DGhs2qqh46erm2juMuwaxSLpA6F7ljaBK6jAo4aMglNPaqbjSbvRzu2se9S?=
 =?us-ascii?Q?oyx0ONnu3sHgE75Ohjd63yjimhWZsHQ7YqHN5NVDQvD1QE09Pk9gnc3fCWcJ?=
 =?us-ascii?Q?qou4jdMHRUV6avgxYK8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kuiTT3VVhPMWwYYlUJM5zutUxqCoXBqVlWsd6LMkzq1brIz2b24Mcl9QjkHji37RVR5bZBrys9dyDJUTRyg8MSnx0qpm+Ye4LGDUugRBQkvQcSPSi45JdRXXB3lP6nsdoP1l/WCBQtXXU+BhUx6eDic55Ig1xqI9RWhVQeMIqpXyNL0FI5rXXy+sOO56llMuMuf5fHaqE+/pOkBSATQ/PlLv39f93u0reTWgR+KQpaiOKfTmdhPJQ0mWW2mqbOGqjFvB2VOx2kdxyXNDSdTZ669s+XnvoQKS8op/KQXTJh2LfP4eUXZDgNxy2nP53wCxAf9m338fY5VeIA6zuR9T2U8VOImxHOpQDtkLyzktuVAbGm17AJTp55+U0GkNZLlw59PjOqmuNxzxa/7v44yeuP6jljiblZXdHEQWeQ777TJxujQjPH0hF391pm0nTs4MmCLsyU/qg0CXEIQ+0P242q8DpkHrCtlv0WXZJtALoQx9ADJVbKw0Q0OrchzWwj7EfIoEUVA72h42rwWRyDwWam6dJf1dundldUpmkCR1a4WgMothjG/LOWDztuTmopUIjIMYUPIcvcQKh1LKCKniABdk3gnA8TCQg5TWtuWezIu12s1vHQglayY+fsYqq55LcmGRjdWNrNbJ8usHe3AbOJ8tRtDgRpuT+qJozVi4LeaUirxZ4fHrpkaZCpVd/VaiY7yw1U6AdJRytBWYrVA0wpOydg54+0+i4QrEkB08k3U/CWE2NdJeK0A31SL9+kftlZBX/kFxBP/9H0IvjcKQxr9no2YCKAvuhR4Ol3SoUtdt1IR4Qi8A/8Czxn9dtuOY
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5da5ec9-ebda-4399-2781-08db924b54e9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 04:54:04.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mBzAjmgEzyNss6LEC7lilCcixUHhfRSHIgPNDECQdE7r30Cby95OUIB0dff1nrXx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5414
X-BESS-ID: 1690865649-104389-12478-59569-1
X-BESS-VER: 2019.1_20230731.2236
X-BESS-Apparent-Source-IP: 104.47.58.102
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmZubmQGYGUNTE1CLZxDQpNd
        UoKdXM1DzFyMQixcDM0CTZLMU8OcXMRKk2FgDqMBCSQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249857 [from 
        cloudscan16-119.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Using the sorted array to track the EA blocks and
their refs is not scalable.
When the file system has a huge number of EA blocks
reporting wrong ref, pass1 scanning could not be
finished within a reasonable time,
as 95%+ of CPU time is spent in memmove() when
trying to enlarge the the sorted array.

On a file system with 20 million problematic EA blocks
on an NVMe device, pass1 time taken:
without patch:
time: 2014.78/1838.70/19.91
with patch:
time: 45.17/20.17/20.19

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 e2fsck/e2fsck.h      |   3 +-
 e2fsck/ea_refcount.c | 286 +++++++++++++++----------------------------
 e2fsck/pass1.c       |  14 +--
 3 files changed, 102 insertions(+), 201 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 3f2dc3084..bc2490c9d 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -533,7 +533,7 @@ extern struct dx_dir_info *e2fsck_dx_dir_info_iter(e2fsck_t ctx,
 typedef __u64 ea_key_t;
 typedef __u64 ea_value_t;
 
-extern errcode_t ea_refcount_create(size_t size, ext2_refcount_t *ret);
+extern errcode_t ea_refcount_create(ext2_refcount_t *ret);
 extern void ea_refcount_free(ext2_refcount_t refcount);
 extern errcode_t ea_refcount_fetch(ext2_refcount_t refcount, ea_key_t ea_key,
 				   ea_value_t *ret);
@@ -543,7 +543,6 @@ extern errcode_t ea_refcount_decrement(ext2_refcount_t refcount,
 				       ea_key_t ea_key, ea_value_t *ret);
 extern errcode_t ea_refcount_store(ext2_refcount_t refcount, ea_key_t ea_key,
 				   ea_value_t count);
-extern size_t ext2fs_get_refcount_size(ext2_refcount_t refcount);
 extern void ea_refcount_intr_begin(ext2_refcount_t refcount);
 extern ea_key_t ea_refcount_intr_next(ext2_refcount_t refcount,
 				      ea_value_t *ret);
diff --git a/e2fsck/ea_refcount.c b/e2fsck/ea_refcount.c
index 7154b47c3..fb8b009f1 100644
--- a/e2fsck/ea_refcount.c
+++ b/e2fsck/ea_refcount.c
@@ -16,193 +16,100 @@
 #undef ENABLE_NLS
 #endif
 #include "e2fsck.h"
+#include "ext2fs/rbtree.h"
 
 /*
  * The strategy we use for keeping track of EA refcounts is as
- * follows.  We keep a sorted array of first EA blocks and its
- * reference counts.  Once the refcount has dropped to zero, it is
- * removed from the array to save memory space.  Once the EA block is
+ * follows.  We keep the first EA blocks and its reference counts
+ * in the rb-tree.  Once the refcount has dropped to zero, it is
+ * removed from the rb-tree to save memory space.  Once the EA block is
  * checked, its bit is set in the block_ea_map bitmap.
  */
 struct ea_refcount_el {
+	struct rb_node	node;
 	/* ea_key could either be an inode number or block number. */
 	ea_key_t	ea_key;
 	ea_value_t	ea_value;
 };
 
 struct ea_refcount {
-	size_t		count;
-	size_t		size;
-	size_t		cursor;
-	struct ea_refcount_el	*list;
+	struct rb_root	root;
+	struct rb_node	*cursor;
 };
 
 void ea_refcount_free(ext2_refcount_t refcount)
 {
+	struct ea_refcount_el *el;
+	struct rb_node *node, *next;
+
 	if (!refcount)
 		return;
 
-	if (refcount->list)
-		ext2fs_free_mem(&refcount->list);
+	for (node = ext2fs_rb_first(&refcount->root); node; node = next) {
+		next = ext2fs_rb_next(node);
+		el = ext2fs_rb_entry(node, struct ea_refcount_el, node);
+		ext2fs_rb_erase(node, &refcount->root);
+		ext2fs_free_mem(&el);
+	}
 	ext2fs_free_mem(&refcount);
 }
 
-errcode_t ea_refcount_create(size_t size, ext2_refcount_t *ret)
+errcode_t ea_refcount_create(ext2_refcount_t *ret)
 {
 	ext2_refcount_t	refcount;
 	errcode_t	retval;
-	size_t		bytes;
 
 	retval = ext2fs_get_memzero(sizeof(struct ea_refcount), &refcount);
 	if (retval)
 		return retval;
-
-	if (!size)
-		size = 500;
-	refcount->size = size;
-	bytes = size * sizeof(struct ea_refcount_el);
-#ifdef DEBUG
-	printf("Refcount allocated %zu entries, %zu bytes.\n",
-	       refcount->size, bytes);
-#endif
-	retval = ext2fs_get_memzero(bytes, &refcount->list);
-	if (retval)
-		goto errout;
-
-	refcount->count = 0;
-	refcount->cursor = 0;
+	refcount->root = RB_ROOT;
 
 	*ret = refcount;
 	return 0;
-
-errout:
-	ea_refcount_free(refcount);
-	return(retval);
-}
-
-/*
- * collapse_refcount() --- go through the refcount array, and get rid
- * of any count == zero entries
- */
-static void refcount_collapse(ext2_refcount_t refcount)
-{
-	unsigned int	i, j;
-	struct ea_refcount_el	*list;
-
-	list = refcount->list;
-	for (i = 0, j = 0; i < refcount->count; i++) {
-		if (list[i].ea_value) {
-			if (i != j)
-				list[j] = list[i];
-			j++;
-		}
-	}
-#if defined(DEBUG) || defined(TEST_PROGRAM)
-	printf("Refcount_collapse: size was %zu, now %d\n",
-	       refcount->count, j);
-#endif
-	refcount->count = j;
-}
-
-
-/*
- * insert_refcount_el() --- Insert a new entry into the sorted list at a
- * 	specified position.
- */
-static struct ea_refcount_el *insert_refcount_el(ext2_refcount_t refcount,
-						 ea_key_t ea_key, int pos)
-{
-	struct ea_refcount_el 	*el;
-	errcode_t		retval;
-	size_t			new_size = 0;
-	int			num;
-
-	if (refcount->count >= refcount->size) {
-		new_size = refcount->size + 100;
-#ifdef DEBUG
-		printf("Reallocating refcount %d entries...\n", new_size);
-#endif
-		retval = ext2fs_resize_mem((size_t) refcount->size *
-					   sizeof(struct ea_refcount_el),
-					   (size_t) new_size *
-					   sizeof(struct ea_refcount_el),
-					   &refcount->list);
-		if (retval)
-			return 0;
-		refcount->size = new_size;
-	}
-	num = (int) refcount->count - pos;
-	if (num < 0)
-		return 0;	/* should never happen */
-	if (num) {
-		memmove(&refcount->list[pos+1], &refcount->list[pos],
-			sizeof(struct ea_refcount_el) * num);
-	}
-	refcount->count++;
-	el = &refcount->list[pos];
-	el->ea_key = ea_key;
-	el->ea_value = 0;
-	return el;
 }
 
-
 /*
  * get_refcount_el() --- given an block number, try to find refcount
- * 	information in the sorted list.  If the create flag is set,
- * 	and we can't find an entry, create one in the sorted list.
+ * 	information in the rb-tree.  If the create flag is set,
+ * 	and we can't find an entry, create and add it to rb-tree.
  */
 static struct ea_refcount_el *get_refcount_el(ext2_refcount_t refcount,
 					      ea_key_t ea_key, int create)
 {
-	int	low, high, mid;
+	struct rb_node		**node;
+	struct rb_node		*parent = NULL;
+	struct ea_refcount_el	*el;
+	errcode_t		retval;
 
-	if (!refcount || !refcount->list)
-		return 0;
-retry:
-	low = 0;
-	high = (int) refcount->count-1;
-	if (create && ((refcount->count == 0) ||
-		       (ea_key > refcount->list[high].ea_key))) {
-		if (refcount->count >= refcount->size)
-			refcount_collapse(refcount);
-
-		return insert_refcount_el(refcount, ea_key,
-					  (unsigned) refcount->count);
-	}
-	if (refcount->count == 0)
+	if (!refcount)
 		return 0;
 
-	if (refcount->cursor >= refcount->count)
-		refcount->cursor = 0;
-	if (ea_key == refcount->list[refcount->cursor].ea_key)
-		return &refcount->list[refcount->cursor++];
-#ifdef DEBUG
-	printf("Non-cursor get_refcount_el: %u\n", ea_key);
-#endif
-	while (low <= high) {
-		mid = (low+high)/2;
-		if (ea_key == refcount->list[mid].ea_key) {
-			refcount->cursor = mid+1;
-			return &refcount->list[mid];
-		}
-		if (ea_key < refcount->list[mid].ea_key)
-			high = mid-1;
+	node = &refcount->root.rb_node;
+	while (*node) {
+		el = ext2fs_rb_entry(*node, struct ea_refcount_el, node);
+
+		parent = *node;
+		if (ea_key < el->ea_key)
+			node = &(*node)->rb_left;
+		else if (ea_key > el->ea_key)
+			node = &(*node)->rb_right;
 		else
-			low = mid+1;
-	}
-	/*
-	 * If we need to create a new entry, it should be right at
-	 * low (where high will be left at low-1).
-	 */
-	if (create) {
-		if (refcount->count >= refcount->size) {
-			refcount_collapse(refcount);
-			if (refcount->count < refcount->size)
-				goto retry;
-		}
-		return insert_refcount_el(refcount, ea_key, low);
+			return el;
 	}
-	return 0;
+
+	if (!create)
+		return 0;
+
+	retval = ext2fs_get_memzero(sizeof(struct ea_refcount_el), &el);
+	if (retval)
+		return 0;
+
+	el->ea_key = ea_key;
+	el->ea_value = 0;
+	ext2fs_rb_link_node(&el->node, parent, node);
+	ext2fs_rb_insert_color(&el->node, &refcount->root);
+
+	return el;
 }
 
 errcode_t ea_refcount_fetch(ext2_refcount_t refcount, ea_key_t ea_key,
@@ -240,13 +147,18 @@ errcode_t ea_refcount_decrement(ext2_refcount_t refcount, ea_key_t ea_key,
 	struct ea_refcount_el	*el;
 
 	el = get_refcount_el(refcount, ea_key, 0);
-	if (!el || el->ea_value == 0)
+	if (!el)
 		return EXT2_ET_INVALID_ARGUMENT;
 
 	el->ea_value--;
 
 	if (ret)
 		*ret = el->ea_value;
+
+	if (el->ea_value == 0) {
+		ext2fs_rb_erase(&el->node, &refcount->root);
+		ext2fs_free_mem(&el);
+	}
 	return 0;
 }
 
@@ -262,17 +174,13 @@ errcode_t ea_refcount_store(ext2_refcount_t refcount, ea_key_t ea_key,
 	if (!el)
 		return ea_value ? EXT2_ET_NO_MEMORY : 0;
 	el->ea_value = ea_value;
+	if (el->ea_value == 0) {
+		ext2fs_rb_erase(&el->node, &refcount->root);
+		ext2fs_free_mem(&el);
+	}
 	return 0;
 }
 
-size_t ext2fs_get_refcount_size(ext2_refcount_t refcount)
-{
-	if (!refcount)
-		return 0;
-
-	return refcount->size;
-}
-
 void ea_refcount_intr_begin(ext2_refcount_t refcount)
 {
 	refcount->cursor = 0;
@@ -281,19 +189,23 @@ void ea_refcount_intr_begin(ext2_refcount_t refcount)
 ea_key_t ea_refcount_intr_next(ext2_refcount_t refcount,
 				ea_value_t *ret)
 {
-	struct ea_refcount_el	*list;
-
-	while (1) {
-		if (refcount->cursor >= refcount->count)
-			return 0;
-		list = refcount->list;
-		if (list[refcount->cursor].ea_value) {
-			if (ret)
-				*ret = list[refcount->cursor].ea_value;
-			return list[refcount->cursor++].ea_key;
-		}
-		refcount->cursor++;
+	struct ea_refcount_el	*el;
+	struct rb_node		*node = refcount->cursor;
+
+	if (node == NULL)
+		node = ext2fs_rb_first(&refcount->root);
+	else
+		node = ext2fs_rb_next(node);
+
+	if (node) {
+		refcount->cursor = node;
+		el = ext2fs_rb_entry(node, struct ea_refcount_el, node);
+		if (ret)
+			*ret = el->ea_value;
+		return el->ea_key;
 	}
+
+	return 0;
 }
 
 
@@ -301,26 +213,28 @@ ea_key_t ea_refcount_intr_next(ext2_refcount_t refcount,
 
 errcode_t ea_refcount_validate(ext2_refcount_t refcount, FILE *out)
 {
-	errcode_t	ret = 0;
-	int		i;
+	struct ea_refcount_el	*el;
+	struct rb_node		*node;
+	ea_key_t		prev;
+	int			prev_valid = 0;
 	const char *bad = "bad refcount";
 
-	if (refcount->count > refcount->size) {
-		fprintf(out, "%s: count > size\n", bad);
-		return EXT2_ET_INVALID_ARGUMENT;
-	}
-	for (i=1; i < refcount->count; i++) {
-		if (refcount->list[i-1].ea_key >= refcount->list[i].ea_key) {
+	for (node = ext2fs_rb_first(&refcount->root); node != NULL;
+	     node = ext2fs_rb_next(node)) {
+		el = ext2fs_rb_entry(node, struct ea_refcount_el, node);
+		if (prev_valid && prev >= el->ea_key) {
 			fprintf(out,
-				"%s: list[%d].ea_key=%llu, list[%d].ea_key=%llu\n",
-				bad, i-1,
-				(unsigned long long) refcount->list[i-1].ea_key,
-				i,
-				(unsigned long long) refcount->list[i].ea_key);
-			ret = EXT2_ET_INVALID_ARGUMENT;
+				"%s: prev.ea_key=%llu, curr.ea_key=%llu\n",
+				bad,
+				(unsigned long long) prev,
+				(unsigned long long) el->ea_key);
+			return EXT2_ET_INVALID_ARGUMENT;
 		}
+		prev = el->ea_key;
+		prev_valid = 1;
 	}
-	return ret;
+
+	return 0;
 }
 
 #define BCODE_END	0
@@ -332,10 +246,9 @@ errcode_t ea_refcount_validate(ext2_refcount_t refcount, FILE *out)
 #define BCODE_FETCH	6
 #define BCODE_VALIDATE	7
 #define BCODE_LIST	8
-#define BCODE_COLLAPSE 9
 
 int bcode_program[] = {
-	BCODE_CREATE, 5,
+	BCODE_CREATE,
 	BCODE_STORE, 3, 3,
 	BCODE_STORE, 4, 4,
 	BCODE_STORE, 1, 1,
@@ -362,7 +275,6 @@ int bcode_program[] = {
 	BCODE_FETCH, 30,
 	BCODE_DECR, 2,
 	BCODE_DECR, 2,
-	BCODE_COLLAPSE,
 	BCODE_LIST,
 	BCODE_VALIDATE,
 	BCODE_FREE,
@@ -373,7 +285,6 @@ int main(int argc, char **argv)
 {
 	int	i = 0;
 	ext2_refcount_t refcount;
-	size_t		size;
 	ea_key_t	ea_key;
 	ea_value_t	arg;
 	errcode_t	retval;
@@ -383,15 +294,13 @@ int main(int argc, char **argv)
 		case BCODE_END:
 			exit(0);
 		case BCODE_CREATE:
-			size = bcode_program[i++];
-			retval = ea_refcount_create(size, &refcount);
+			retval = ea_refcount_create(&refcount);
 			if (retval) {
 				com_err("ea_refcount_create", retval,
-					"while creating size %zu", size);
+					"while creating refcount");
 				exit(1);
 			} else
-				printf("Creating refcount with size %zu\n",
-				       size);
+				printf("Creating refcount\n");
 			break;
 		case BCODE_FREE:
 			ea_refcount_free(refcount);
@@ -465,9 +374,6 @@ int main(int argc, char **argv)
 				       (unsigned long long) arg);
 			}
 			break;
-		case BCODE_COLLAPSE:
-			refcount_collapse(refcount);
-			break;
 		}
 
 	}
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index a341c72ac..27364cd73 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -398,8 +398,7 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 		if (!entry->e_value_inum)
 			goto next;
 		if (!ctx->ea_inode_refs) {
-			pctx->errcode = ea_refcount_create(0,
-							   &ctx->ea_inode_refs);
+			pctx->errcode = ea_refcount_create(&ctx->ea_inode_refs);
 			if (pctx->errcode) {
 				pctx->num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
@@ -2475,7 +2474,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 
 	/* Create the EA refcount structure if necessary */
 	if (!ctx->refcount) {
-		pctx->errcode = ea_refcount_create(0, &ctx->refcount);
+		pctx->errcode = ea_refcount_create(&ctx->refcount);
 		if (pctx->errcode) {
 			pctx->num = 1;
 			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
@@ -2509,8 +2508,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 			return 1;
 		/* Ooops, this EA was referenced more than it stated */
 		if (!ctx->refcount_extra) {
-			pctx->errcode = ea_refcount_create(0,
-					   &ctx->refcount_extra);
+			pctx->errcode = ea_refcount_create(&ctx->refcount_extra);
 			if (pctx->errcode) {
 				pctx->num = 2;
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
@@ -2651,8 +2649,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 
 	if (quota_blocks != EXT2FS_C2B(fs, 1U)) {
 		if (!ctx->ea_block_quota_blocks) {
-			pctx->errcode = ea_refcount_create(0,
-						&ctx->ea_block_quota_blocks);
+			pctx->errcode = ea_refcount_create(&ctx->ea_block_quota_blocks);
 			if (pctx->errcode) {
 				pctx->num = 3;
 				goto refcount_fail;
@@ -2664,8 +2661,7 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 
 	if (quota_inodes) {
 		if (!ctx->ea_block_quota_inodes) {
-			pctx->errcode = ea_refcount_create(0,
-						&ctx->ea_block_quota_inodes);
+			pctx->errcode = ea_refcount_create(&ctx->ea_block_quota_inodes);
 			if (pctx->errcode) {
 				pctx->num = 4;
 refcount_fail:
-- 
2.41.0

