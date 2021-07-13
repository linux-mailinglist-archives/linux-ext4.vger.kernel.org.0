Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFC23C72B6
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhGMPCM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 11:02:12 -0400
Received: from mail-db8eur05on2046.outbound.protection.outlook.com ([40.107.20.46]:28128
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236842AbhGMPCL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 13 Jul 2021 11:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIyzpbP8+jjH6psPnnsmZCGdH74i5GOk9RxZgYGO+oh7Knq7dlrIfbd7l7KuOtxCATNdX+hbWjDGD3jkIPErcBmkIt8MYOASxK4P01lTHPrgl/At01sCfT0VqVULTQrvQffB2joN7SMXT4uRwpUBrV8sjRJDVk7dezVTW+WRiX7wmtoSV870vI5/uDBMfpSjLuGF03DbWvdZ5sSM2463nPexQhte32awRin0bdFw1TUJSXcHLrdAHuG7jMCQELJ25KAHOR63rhJeEr7uOwxBSC8rTO1E9cZjpAHzc/Xr/7Dkdf5GIcy1wEOgPfKmxj//QzKjWa2wS9QDVSckKC3gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0438sOdSFTMHC7R3F+qcZDc13Qoy5CXM2MGi/Gwvkto=;
 b=ni+eaf+qEflV//Esa1PHj/s2aIiigQJ7bvWSQdId6cksd51QapGXk8fbgisIeUy/sKDnyTaCiBOpG3v6IfMHceV78Q38qQqiJwFvN0FNfDpHmHtbdZ3q/OyPOpFYOqq/TfdHPrIpq6Pr13RrxO/gTsqOmsX+CvW0HBmlPhU4oQelmJ4ASMUGHZyqY304DlcHcRPjFYq8F7Uz4JdRNpwBbwYmkp4Mqhce1Mduf2Gl7dOsXTYQSbAEcCBz8OG/a/6cmf171mmISdhP1vTDuHv7rYSo8dr/17zTmiMzolpWlZiUxm8EWB+nuNy4shkhGW8w3Jh5rlmdkq/r9UYDgBNDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=urjc.es; dmarc=pass action=none header.from=urjc.es; dkim=pass
 header.d=urjc.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urjc.onmicrosoft.com;
 s=selector2-urjc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0438sOdSFTMHC7R3F+qcZDc13Qoy5CXM2MGi/Gwvkto=;
 b=uV7t6WQKP0TO+5R0O6J6hsRhGtZFTgtItX0slcfP0qFP7UJF4JIlrLpr28B5Xm01nQV0yYL1kUb2eJNfk1caI3oXCUYdcvP6f+c70tqYCeX2VyJz6kpnX7hctnR2ZJa++mjI2fvBu/g36EWBEfuc1wMnPtrIUrX8KmIjYMZ7qSc=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=urjc.es;
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com (2603:10a6:10:5c::15)
 by DBAPR02MB6278.eurprd02.prod.outlook.com (2603:10a6:10:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Tue, 13 Jul
 2021 14:59:20 +0000
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e]) by DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 14:59:20 +0000
Date:   Tue, 13 Jul 2021 16:59:18 +0200
From:   Javier Pello <javier.pello@urjc.es>
To:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-Id: <20210713165918.10da0318af5b9b73e599a517@urjc.es>
In-Reply-To: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
Organization: Universidad Rey Juan Carlos
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0162.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::25) To DB7PR02MB4663.eurprd02.prod.outlook.com
 (2603:10a6:10:5c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mo-dep2-d036-01.escet.urjc.es (212.128.1.36) by MR2P264CA0162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 13 Jul 2021 14:59:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f4de268-da6e-4dfb-04d9-08d9460ecb15
X-MS-TrafficTypeDiagnostic: DBAPR02MB6278:
X-Microsoft-Antispam-PRVS: <DBAPR02MB62789A40CAB985BF7EF604DB9B149@DBAPR02MB6278.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:37;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/KhOc3Qj++meX7ZGAjA4Cnl78DLPX/hwpiyVDXsPH8Dk+Cq3yjeCha7aIvFvimwofff+1youWaprmseZX+S1Vbz/3+6w0TYbCThXRpQHXFMynUvVHww588s2YND+urDsNblUrhHkrpZjd1u7x0xKNk0CyXhs3tdZyWiGh43IHDgBJooeT4CRQPoroKfkF0kkclj1ljXWS2JEYlFEhnMXmJP3k8ljUbNFd9Tx18pO95ujTTug0I5vrIfITEtBy6h2BleUif2wnKt6PXP5u8DiUoq1samP3HAsEYZIuMpIa58/OWzasjTvy0t9Rj1E0tqFKgGIHbGi0yScbg18HFUGDmGmqCsLiqPMY4zx0NESpdMBLfYW2JdcobJCjFFJM8L0llcEfab8JYg1DhuJvIxwxv/A62GrrmAOp72UyDQcQkna693ShON9dgCicrhiwohM8YXABoTlQu3Nq/asvAFqmD7njDUHC+NdlyA8Gq54jfihU06IJSaRTEusO5sqkid5cGw2SThe2ZS5rGlwKrip6swjUb4keuRuuz2xYD6GW2Z8M94nSAts3esrLY1BcZmfZlSRM+HnjTfKuCHuKJqP8kfENXGpEHOmSAVco7dn2ySQd7sq6WdUMDVLO32Y6NSfNl6fu9yPHfjQE2L8hwquYt/EQHSSBFL2kQ2Bz2zCJP8Pxn7/UF6GJsrsLxJNJod8CX4Fgqcu2Dnoqpko6BtPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR02MB4663.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39850400004)(366004)(136003)(956004)(26005)(36756003)(8936002)(36916002)(52116002)(5660300002)(186003)(7696005)(478600001)(8676002)(2616005)(44832011)(83380400001)(1076003)(786003)(316002)(6486002)(2906002)(66476007)(66946007)(86362001)(66556008)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M9Ga/DBPP1d5OrmI1usN8oWYRSGb9WB9luPEZka5WudhEkZKhMxSLqGFIRT2?=
 =?us-ascii?Q?5/L5gkcVmOOz+KjeQsW532GJ7q4PNTdIM7lE78BnNJwxbg6zE38QrKLihAx2?=
 =?us-ascii?Q?v+E6Dexf3NgYZmNA3Mmzwwc0To6NZJrcU7NQQTYpmQ+jMoZk4TUT3uZB0+ji?=
 =?us-ascii?Q?cbAM6gInw0htj7XXazC4eeU4ao+Fu6TAYhvSYqDa/yJz/gloaOUW4x/haMqZ?=
 =?us-ascii?Q?wv6jHUzEVa3eYhCMTUlPKlkGJfTY0HcG4P6ak8FHCKHDfOV4roZ69R5fB7xP?=
 =?us-ascii?Q?oyd2wX88qRbpqOK4sAb753+OBGBurroylyBq+MqkRJGnjM1FhaMTsrDyTGlR?=
 =?us-ascii?Q?a7V9R29iQ8L+A907FFH5KgBXRxPjsltXrxJur/OAHYzLvU5vIW90gaHUeI6z?=
 =?us-ascii?Q?W1yUPmaOjSoH70DC06XFhEA7NQ9JGvzAXl/sSj3rK/00bXk0FK1aYZYudSfu?=
 =?us-ascii?Q?oKZC42xp/o8kDpqoI8wGEvfGY1vzlRrsH0KptTxuq7gHFFuV0K6QrYhi0h9N?=
 =?us-ascii?Q?0rWoBnkS9XHVxyQSubcvtbMyJPv3+66sq8+F0iJZoA38uX16vqR3zyfVRtiZ?=
 =?us-ascii?Q?wezKY7DXlWewZ3EtL4AalSM2EFKiEdBhxZdE8VcXKw3amihfn9idyp7WHpk+?=
 =?us-ascii?Q?Ntf4FFH2n7OTdwIuC5fCowR+zOVuYLnWP0HnxUc4mHef4cLhKbLK248rrtjo?=
 =?us-ascii?Q?3/ry0Ed1xPYV9G0wstu4pz0a6y1PxLes8dwynlhzjr65330bd21ES33udffm?=
 =?us-ascii?Q?QpN6JPB7HnbFGHnFyyjbSGwDqjTM+iYm7BgY9wcqhiKo/8Os6YrShBnt5oFA?=
 =?us-ascii?Q?5FAz2+LvR+zetZDRoNLzHPV317BvNHUylUYr1KXCKF5DQhO9NOQjxTn3VTRx?=
 =?us-ascii?Q?urmXq+kfmm++PXK0nv0WGp0rpE6cDh/U62+Or81QVc0UzhdQZBscV1suK+jf?=
 =?us-ascii?Q?L9XaY0TfXao9ED/a9BMpJUobv0CRRj/NsHuhuCbBz2ZQNrAB3mqrtfTdGB3J?=
 =?us-ascii?Q?7jr827BTsjdThl4jjXFkZ6jvtvYjO9TgB7sQ/Rs+JqZZxnXdZ1o1PjI9xi07?=
 =?us-ascii?Q?oJCdP2lyD1iXZR2jQOv2AY519C8T/sdgrArZOllB1WNlv5Awh6U8tCY0TkyB?=
 =?us-ascii?Q?1UWLsvtgLWs2/7eLep2LNUBiQyc3HdeG4Bn2Ro0BaxpMGvzIYZLB4xy1XPHS?=
 =?us-ascii?Q?3HYrPPb9OcVad8gyz8qCmMcgt/jyRS3wJuGrLiAoHdzDUlryjc0szGb2H4VH?=
 =?us-ascii?Q?JKa/H+85LbcJdDz7iWEBJznTQvvs9ucqIyMYZfo61vY8LNsoQg+ThXJjfnb6?=
 =?us-ascii?Q?qfIRK1OH5fjdCn12fIfei0uN?=
X-OriginatorOrg: urjc.es
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4de268-da6e-4dfb-04d9-08d9460ecb15
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4663.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 14:59:20.1823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5f84c4ea-370d-4b9e-830c-756f8bf1b51f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuolfSdKf6lWMb98B6b/wjKCpgnfFQSrjd1Jb6yodatrsvw8/MLKZR9FMMsv5uFln4A0R6qpetugbaErWdixVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6278
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Javier Pello <javier.pello@urjc.es>

Commit 782b76d7abdf02b12c46ed6f1e9bf715569027f7 ("fs/ext2: Replace
kmap() with kmap_local_page()") replaced the kmap/kunmap calls in
ext2_get_page/ext2_put_page with kmap_local_page/kunmap_local for
efficiency reasons. As a necessary side change, the commit also
made ext2_get_page (and ext2_find_entry and ext2_dotdot) return
the mapping address along with the page itself, as it is required
for kunmap_local, and converted uses of page_address on such pages
to use the newly returned address instead. However, uses of
page_address on such pages were missed in ext2_check_page and
ext2_delete_entry, which triggers oopses if kmap_local_page happens
to return an address from high memory. Fix this now by converting
the remaining uses of page_address to use the right address, as
returned by kmap_local_page.

Signed-off-by: Javier Pello <javier.pello@urjc.es>
Fixes: 782b76d7abdf fs/ext2: Replace kmap() with kmap_local_page()
---
 fs/ext2/dir.c   | 20 ++++++++++----------
 fs/ext2/ext2.h  |  3 ++-
 fs/ext2/namei.c |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 14292dba..0c59b4d3 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -106,12 +106,11 @@ static int ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static bool ext2_check_page(struct page *page, int quiet)
+static bool ext2_check_page(struct page *page, int quiet, char *kaddr)
 {
 	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
 	unsigned chunk_size = ext2_chunk_size(dir);
-	char *kaddr = page_address(page);
 	u32 max_inumber = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
 	unsigned offs, rec_len;
 	unsigned limit = PAGE_SIZE;
@@ -205,7 +204,8 @@ static struct page * ext2_get_page(struct inode *dir, unsigned long n,
 	if (!IS_ERR(page)) {
 		*page_addr = kmap_local_page(page);
 		if (unlikely(!PageChecked(page))) {
-			if (PageError(page) || !ext2_check_page(page, quiet))
+			if (PageError(page) || !ext2_check_page(page, quiet,
+								*page_addr))
 				goto fail;
 		}
 	}
@@ -584,16 +584,16 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
  * ext2_delete_entry deletes a directory entry by merging it with the
  * previous entry. Page is up-to-date.
  */
-int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
+int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
+			void *kaddr)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = page_address(page);
-	unsigned from = ((char*)dir - kaddr) & ~(ext2_chunk_size(inode)-1);
-	unsigned to = ((char *)dir - kaddr) +
-				ext2_rec_len_from_disk(dir->rec_len);
+	unsigned int delta = (char *)dir - (char *)kaddr;
+	unsigned int from = delta & ~(ext2_chunk_size(inode)-1);
+	unsigned int to = delta + ext2_rec_len_from_disk(dir->rec_len);
 	loff_t pos;
 	ext2_dirent * pde = NULL;
-	ext2_dirent * de = (ext2_dirent *) (kaddr + from);
+	ext2_dirent *de = (ext2_dirent *) ((char *)kaddr + from);
 	int err;
 
 	while ((char*)de < (char*)dir) {
@@ -607,7 +607,7 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
 		de = ext2_next_entry(de);
 	}
 	if (pde)
-		from = (char*)pde - (char*)page_address(page);
+		from = (char *)pde - (char *)kaddr;
 	pos = page_offset(page) + from;
 	lock_page(page);
 	err = ext2_prepare_chunk(page, pos, to - from);
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index b0a69482..7bda9379 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -740,7 +740,8 @@ extern int ext2_inode_by_name(struct inode *dir,
 extern int ext2_make_empty(struct inode *, struct inode *);
 extern struct ext2_dir_entry_2 *ext2_find_entry(struct inode *, const struct qstr *,
 						struct page **, void **res_page_addr);
-extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
+extern int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page,
+			     void *kaddr);
 extern int ext2_empty_dir (struct inode *);
 extern struct ext2_dir_entry_2 *ext2_dotdot(struct inode *dir, struct page **p, void **pa);
 extern void ext2_set_link(struct inode *, struct ext2_dir_entry_2 *, struct page *, void *,
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 1f69b816..5f6b7560 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -293,7 +293,7 @@ static int ext2_unlink(struct inode * dir, struct dentry *dentry)
 		goto out;
 	}
 
-	err = ext2_delete_entry (de, page);
+	err = ext2_delete_entry (de, page, page_addr);
 	ext2_put_page(page, page_addr);
 	if (err)
 		goto out;
@@ -397,7 +397,7 @@ static int ext2_rename (struct user_namespace * mnt_userns,
 	old_inode->i_ctime = current_time(old_inode);
 	mark_inode_dirty(old_inode);
 
-	ext2_delete_entry(old_de, old_page);
+	ext2_delete_entry(old_de, old_page, old_page_addr);
 
 	if (dir_de) {
 		if (old_dir != new_dir)
-- 
2.30.1
