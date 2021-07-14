Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E423C8919
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jul 2021 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhGNQ5q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jul 2021 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhGNQ5q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jul 2021 12:57:46 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02on0626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe05::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198B8C06175F;
        Wed, 14 Jul 2021 09:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmj82tXJCxlVAAdhRIhzaOJQ4TdzhWHJ1ADqNbRBUXOqAH8HP2r5yPAffx/iese213P2RA0zntvSeEYzT0WjnrdtsP+8/D7wr2shyjSt2TWN0sTu1DlU0erMQx5pu5STnOd9vJ4tkpDds9+lNWQSBstRDm/iyyKym78qXzTfGf91jolW1cl4LB20UOrHSEWpZdwjAs2mdHlbWPdARfnlrt7KDAfRomowrQbGqjbQyXilKBhyO+gecqkCCvPKVQEBKNu3E97yqzSfR9M1An+bUJB7VcyVbzH6XOhOL6iP+z5NI5Omzt80+JczDFoY+8Ew45GDY5e2ySmoHmV+cZt27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8xH9dIlzrOnaxdpt+o+G1D2ModVrM9yC3aOk2N099o=;
 b=RXR6wd94ZMJgmscV1PtQMg34uwfMyYdJmBIh+B+pFYQNwEk/1saKUh6Nb0pgJeiVzHmBSWVX+Yk9aNi1ChNrQ7GPUkjOjoxMmJIwJRli8O5n+f/bgRYH63i6lndMbn6U2TQlu6SK3R2Zj5I3vWENxvTgkltSMMHs57HSDoKZjFFxosi4hnllEQFbUlfKeMqZBUiL58ecuYxYiYG3A0hI4vYbT9CL61ueRv9nqjwnlXFsPYlQjO0S5Q+8TdYTuRe8q5sD9FLoDNZOTvU4NeOfY3HOU3hPMwVhIX6Mi3ld3ZgS3GqtXcRdfMlkZIRvt5dweH6Y8mjXiFo+9AJY517deQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=urjc.es; dmarc=pass action=none header.from=urjc.es; dkim=pass
 header.d=urjc.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urjc.onmicrosoft.com;
 s=selector2-urjc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8xH9dIlzrOnaxdpt+o+G1D2ModVrM9yC3aOk2N099o=;
 b=f0gAbxRaeLOqNmCCyEc2PW59gGuKxO4JaqHBp66k1NCd937WcdptZkhxd45lMzK4nfYySU36om4JPjtCJ3CsapD7cVrdT07PB1zl66XMa0e5IAFjxBXWXilOoDzaxmaxQrnnUBWLuwJP7KRirDcQrVVPZt0oREkKzdy39JwwR8Y=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=urjc.es;
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com (2603:10a6:10:5c::15)
 by DB6PR0201MB2199.eurprd02.prod.outlook.com (2603:10a6:4:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 16:54:51 +0000
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e]) by DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e%7]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 16:54:50 +0000
Date:   Wed, 14 Jul 2021 18:54:48 +0200
From:   Javier Pello <javier.pello@urjc.es>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-Id: <20210714185448.8707ac239e9f12b3a7f5b9f9@urjc.es>
In-Reply-To: <20210714090013.GA9457@quack2.suse.cz>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
        <20210713165918.10da0318af5b9b73e599a517@urjc.es>
        <20210713163018.GF24271@quack2.suse.cz>
        <20210713193319.a223cd12e3fb8687f0cae0e8@urjc.es>
        <20210714090013.GA9457@quack2.suse.cz>
Organization: Universidad Rey Juan Carlos
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0096.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::10) To DB7PR02MB4663.eurprd02.prod.outlook.com
 (2603:10a6:10:5c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mo-dep2-d036-01.escet.urjc.es (212.128.1.36) by MR1P264CA0096.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3f::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 16:54:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3d5971a-da69-463b-ad12-08d946e8182b
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2199:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2199C31ED11CD15AF93F66BD9B139@DB6PR0201MB2199.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:37;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpXPqFJHpLDvcblOoR7dRWi6uDlBGisV1MaZjY5ksJScaZ/tjYmWf8TCSpMIKftQQXWdhK09ydPJ9mJK6usqMEGC8HlKKMrUpqzmFC0skB9MdRmO6UiGVaNZHriUdbl3fQk+A1eGoRlU+UM8fd9IpjAi3xfAbbtTD+o86C6rIIqPiPpGXwGxbSRCaxlGDahr6JTFRtxCYSfWv4X67C6HVkSkQYNq8xdVp5FAJL6u61oeIXrUQdStFmqExkO7Oppr9/8bXnNGa+PhZIOzSkrHF58Oz4UMu4z7x257o23QDf0kC+SbM2FlWU4pSn7Creb1CIBKCDTzy+DeAX9RoPg881vnShL3XYvIhDhwHCA1q84ENGWhgyQoHsGQU66xdfgpgd9k8Mw2zMPlF9SX2jSO174RUkucFkbtRyO59LBAv2foT2fCI1qFhyc22B61HNkR+z01U94YIr/vEV+bdLRpiV/E+hH17BUMeJRItlyY9Bcf2sPgzoZkAwY05HM58C13bApAcGWxrLuZfU4saK4GvyJYVwaxeVdOyw09qMuXvO76u1aOp3dQ4X1tqmHW8KtZvM2njF5d1PyelbAg4P91dWpny1NgfRTE6FQ/mV8LWvHV44yv+Sv13y0qJtNMWdLoTBYXB7V//ZWu9SCh+Kr9zlZR8gXk8rpD1vUkJUNxedH4cNF/Ui6HoZ4yB6ry8l8YK+cetQG1KrZ4LhkNLcSw+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR02MB4663.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(376002)(346002)(366004)(136003)(52116002)(83380400001)(36916002)(7696005)(66476007)(956004)(44832011)(2616005)(54906003)(478600001)(66946007)(36756003)(66556008)(316002)(6916009)(38350700002)(186003)(786003)(8936002)(38100700002)(2906002)(5660300002)(6486002)(1076003)(4326008)(86362001)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y1HtxdHUcbjgDKY37Y9mCj3rBn2GJTz7VgWO6a1UoY3g0oLAqEBxOAXp7Do5?=
 =?us-ascii?Q?5qKXKfcsRME4UAcVvnW1Apl5reJ6KIa4BUogJK3p4+n/vAmOI6Gd3aI2kxCY?=
 =?us-ascii?Q?gjyJr/CPA12z7t4zEC7AIpj2+qMZ4Li/HSGtO03QhHl2vIvC5ekQiC6qREIe?=
 =?us-ascii?Q?s2YtdTWjoc7x2Nw5DBQasQ9Mlz1lNztwvCtmwApC9+nIRHJLe0CU52Id225s?=
 =?us-ascii?Q?V4vfcq/sUCKhOTZvKB1Lgjl42gghgbX0ImvweO8nrQaGm/kOcoZv5lOLgI8P?=
 =?us-ascii?Q?gtRld8rUviU2dgwOtDH51TUMUoHqcram5sVIRbXNeKR3HD+9yUrpTPbJAx/C?=
 =?us-ascii?Q?edI16uP4K+nng6IWG1DQETQuskQB1eFnFR9BaIlTju0lprKToMEiKKaZuZOW?=
 =?us-ascii?Q?JKbVSOu44PH5PWwMxHox4gkWjP2C1YWYZc3ji5W+LhhmsJCvi/kUKil05XmN?=
 =?us-ascii?Q?KQCDs+mas7hevS7m2woN3Cz7iRfyrLpMhoYjwDEe6LFDKb2IKRHS5Cu37ZiM?=
 =?us-ascii?Q?EWZcGK6uPGFsXIiYh0EOttYJt0L2DTF+uIuCuoJrSsvtFLdVCiLk9MMKG9WF?=
 =?us-ascii?Q?SjxCuLEqvy6b6UKd8yS5R5KeBFOd7vFFCBoq/jq4VH/p8244pvGHXXF+CDGl?=
 =?us-ascii?Q?7/PyjHIuNDpy/I9IIBMvUDWh+u154lP5cY2a6RNLY3BFSoQfyG6PX7SFrWZJ?=
 =?us-ascii?Q?5yL7LQMYupFtzs6vYHKJDKs2+fuf31K/H6PGxVvBlGKiSQGLqaXuoRFm3ITl?=
 =?us-ascii?Q?pnH9OxLeLd0EZUJ3z2u19ai9p2ClygdxBBxGiV/8oJiwBKlKk2AIx67Yy44j?=
 =?us-ascii?Q?DAQQTPfQG40fD7hDDrPaP5+LO3hI7d3/1URHiQtfF7hOR/1vKTGITHBRz4Mq?=
 =?us-ascii?Q?6HHinc2DDi6gFx52AO3CUKwtHAyOXfb16ktpMishgyLAs3BoKvczUDOvnsC3?=
 =?us-ascii?Q?84U2JmYRhFBlH+46AVNS3xHiil0HVBto1vFUbU5gzhSyUCnFxBtAvnp1uUDr?=
 =?us-ascii?Q?akQ0AZdzirekrKWlV8en4hllbPfUWQWWmpopboFQOFjIjrqmDGTYFRlrqdVB?=
 =?us-ascii?Q?7Nhftw//2lVggxuyJdi+b9SpGVh7FAlrwNJCGSoVlBJoIjVHanQjmab/tGva?=
 =?us-ascii?Q?XQW1c03Nrb5tp1X0KK5rTW7SU9QqqtK5aZRnM0UX0h5Doii0EJpDZhiMs2+A?=
 =?us-ascii?Q?SO5R4dCCyvatoian4lxedulj3WBvAnKqDtS3IlZltjAKjdFjshC7T7a1dAAX?=
 =?us-ascii?Q?Lfz4R8WyYF522SAnF1U7ZncUZws8Uz9SYDZp7VmghWo9bvHoDIqAOi8WdEg9?=
 =?us-ascii?Q?sQrfwwwrhyciDb1bdmHb6tl7?=
X-OriginatorOrg: urjc.es
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d5971a-da69-463b-ad12-08d946e8182b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4663.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:54:50.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5f84c4ea-370d-4b9e-830c-756f8bf1b51f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBd+2A5xuXhGqIs5pW16a89kaLN2MTkLlXWb0f8Yw+y21MPrfRjyT666T7EywHrMnimXfuTN6kzXb6rLAg92dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2199
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
Fixes: 782b76d7abdf ("fs/ext2: Replace kmap() with kmap_local_page()")
---

v2: Use char * for the new parameter to ext2_delete_entry.

 fs/ext2/dir.c   | 12 ++++++------
 fs/ext2/ext2.h  |  3 ++-
 fs/ext2/namei.c |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 14292dba..2c2f179b 100644
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
@@ -584,10 +584,10 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
  * ext2_delete_entry deletes a directory entry by merging it with the
  * previous entry. Page is up-to-date.
  */
-int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
+int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
+			char *kaddr)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = page_address(page);
 	unsigned from = ((char*)dir - kaddr) & ~(ext2_chunk_size(inode)-1);
 	unsigned to = ((char *)dir - kaddr) +
 				ext2_rec_len_from_disk(dir->rec_len);
@@ -607,7 +607,7 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
 		de = ext2_next_entry(de);
 	}
 	if (pde)
-		from = (char*)pde - (char*)page_address(page);
+		from = (char *)pde - kaddr;
 	pos = page_offset(page) + from;
 	lock_page(page);
 	err = ext2_prepare_chunk(page, pos, to - from);
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index b0a69482..e512630c 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -740,7 +740,8 @@ extern int ext2_inode_by_name(struct inode *dir,
 extern int ext2_make_empty(struct inode *, struct inode *);
 extern struct ext2_dir_entry_2 *ext2_find_entry(struct inode *, const struct qstr *,
 						struct page **, void **res_page_addr);
-extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
+extern int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page,
+			     char *kaddr);
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
