Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4770087F
	for <lists+linux-ext4@lfdr.de>; Fri, 12 May 2023 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbjELMxS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 May 2023 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbjELMxR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 May 2023 08:53:17 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E754530D4
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 05:52:49 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230512125246euoutp01b84943502853edcb48fa395726257724~eZnWkBnmY2055720557euoutp01B
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 12:52:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230512125246euoutp01b84943502853edcb48fa395726257724~eZnWkBnmY2055720557euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683895966;
        bh=V3rxQTRSZd7Pf7I80d3lvCaeQe97jhSxZA6BS7xfmJ0=;
        h=From:To:CC:Subject:Date:References:From;
        b=ZixI2sBNzdYKWrFk3qbR/AviRc6l+Qcet8CDNa1kxm6DwinfABT/wMHjR3lbWCUHn
         7GE0okXWb+QFSza2mGG0lKvHATaAv98rWExIL6sFJUMFYrSwNCIQH6go2EwNAxLRIt
         MdVGzRAK1FTVAXck6aJla/RvB+ZZDucIe0h6qBbc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230512125245eucas1p26959ebac952862a82284d09c4c0e25b6~eZnWDLSJE0544805448eucas1p2c;
        Fri, 12 May 2023 12:52:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A7.4F.37758.D963E546; Fri, 12
        May 2023 13:52:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230512125245eucas1p1053d2f8bdf304b920b8012eaf6abf02a~eZnVzTsWO0093200932eucas1p1e;
        Fri, 12 May 2023 12:52:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230512125245eusmtrp1ba3e325972e178b0de191cd96054284f~eZnVyyu140800508005eusmtrp1s;
        Fri, 12 May 2023 12:52:45 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-61-645e369d028b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.DF.14344.D963E546; Fri, 12
        May 2023 13:52:45 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230512125245eusmtip177f96acee8419b98de9b30a17b3e00bf~eZnVkjtVO1289712897eusmtip17;
        Fri, 12 May 2023 12:52:45 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 12 May 2023 13:52:44 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <adilger.kernel@dilger.ca>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] ext4: use folio_create_empty_buffers() instead of
 create_empty_buffers()
Date:   Fri, 12 May 2023 14:52:43 +0200
Message-ID: <20230512125243.73696-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzned25ZnEpBrc3KVh8/dLBYjFz3h02
        i8u75rBZtPb8ZLf4/WMOmwOrR8vmco/NK7Q8ms4cZfb4vEkugCWKyyYlNSezLLVI3y6BK2PH
        ig2sBVuEKl59XsnWwLiRv4uRk0NCwESiccE/xi5GLg4hgRWMEs8n7WKGcL4wSkw/95gNwvnM
        KDF/0xJGmJbFzbvZIRLLGSUez5nDDle1dMdKqGFbGCW6lr4FynBwsAloSTR2gpkiAvoScxdJ
        gZQwC8xklGht2s4MMlVYIFri9ZHdTCA2i4CqxN4jf9hAbF4BS4l11w8wg/RKCMhLLH4gAREW
        lDg58wkLiM0MFG7eOpsZwpaQOPjiBTPEoUoSDZvPsEDYtRJ7mw+A3SkhsIdDYuvjPqgiF4nz
        T4+yQ9jCEq+Ob4GyZSROT+6Baq6WeHrjNzNEcwujRP/O9WwQB1lL9J3JgahxlNhwdzITRJhP
        4sZbQYh7+CQmbZsOdT6vREebEES1msTqe29YJjAqz0LyzSwk38xC8s0CRuZVjOKppcW56anF
        xnmp5XrFibnFpXnpesn5uZsYgank9L/jX3cwrnj1Ue8QIxMH4yFGCQ5mJRHet0uiU4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwicVeO/vmSMEEqVCZ
        xKVfUsylj32IeezXyxo29aVrhWz6od2bHK6FWitEcM8qq7V+67e61zFaKOC8erDf5pvqSw3X
        Lwqa/yesPWZTVfa+nLv6XH8T8noZw+YemuG/Qnb+ywbZjvZ5anHV72fLJkbmigQmnLswNSL9
        5+vC/Gcxt7bvcZsgbfi+OGDnv8eVhy2zTrhtujE3dnXolgVLd/WmvrpsuUa7dPY7nmUaWhO4
        /zw3ZJ1psXFZyLOnE35qv/i+7PuszAs9BsoPBHd5/gm438q18urzcO/rfokOacxh2hwVRxP+
        hmkzLZw3sVDs2DnTYvPKDRs8Oe4zpG0qbUquru574Pl82ozPopI5VWr/lFiKMxINtZiLihMB
        Ms1JTJQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsVy+t/xu7pzzeJSDM7+5LL4+qWDxWLmvDts
        Fpd3zWGzaO35yW7x+8ccNgdWj5bN5R6bV2h5NJ05yuzxeZNcAEuUnk1RfmlJqkJGfnGJrVK0
        oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsaOFRtYC7YIVbz6vJKtgXEjfxcj
        J4eEgInE4ubd7F2MXBxCAksZJSb9384GkZCR2PjlKiuELSzx51oXG0TRR0aJmcebGCGcLYwS
        rbdbmLsYOTjYBLQkGjvZQUwRAX2JuYukQEqYBWYClTRtZwYZJCwQKTH9y3Iwm0VAVWLvkT9g
        y3gFLCXWXT8ANkZCQF5i8QMJiLCgxMmZT1hAbGagcPPW2cwQtoTEwRcvmCFuU5Jo2HyGBcKu
        leh8dZptAqPQLCTts5C0z0LSvoCReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg5Gw79nPL
        DsaVrz7qHWJk4mA8xCjBwawkwvt2SXSKEG9KYmVValF+fFFpTmrxIUZToHcmMkuJJucDYzev
        JN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoEp77PYrrCzsZxT1gs9
        3RB4tL4o7bu7wGvp1s+WRzcdShNSX9q8M1Xr5iyh2vn7lu55MumuoNi21pavyo5Gi9ZsYBCZ
        /COpU+ZpgmZW18TXayvYbkgnZrIv2BR3iitA6ME9HbmyCU6TOyPTTq20zGNSy5jV7Hv1vvh9
        l6q0d1c2H2zafNbzdAHz1liX/yWch59Gu6j+n/tJLcQ3cZulyb9LmzevYlZduo2ZU3JK8q/q
        fM1X/kcuXpnJVn3a+mYTj9aPs5OWbl3wwudapL2wXrtc6sclT7/n7Hot0/m34O60AouKvfy/
        ZDQPLjP6v/N+5cn217ZVIrEnU2/K2+SpLnVk8Dx0Ua/6FLN1xu31QruPK7EUZyQaajEXFScC
        AJMSzcElAwAA
X-CMS-MailID: 20230512125245eucas1p1053d2f8bdf304b920b8012eaf6abf02a
X-Msg-Generator: CA
X-RootMTR: 20230512125245eucas1p1053d2f8bdf304b920b8012eaf6abf02a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230512125245eucas1p1053d2f8bdf304b920b8012eaf6abf02a
References: <CGME20230512125245eucas1p1053d2f8bdf304b920b8012eaf6abf02a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use folio_create_empty_buffers() as the functions that call
create_empty_buffers() work directly on folios.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/ext4/inode.c       | 6 +++---
 fs/ext4/move_extent.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce5f21b6c2b3..a43bbf019316 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1037,7 +1037,7 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 
 	head = folio_buffers(folio);
 	if (!head) {
-		create_empty_buffers(&folio->page, blocksize, 0);
+		folio_create_empty_buffers(folio, blocksize, 0);
 		head = folio_buffers(folio);
 	}
 	bbits = ilog2(blocksize);
@@ -1169,7 +1169,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * starting the handle.
 	 */
 	if (!folio_buffers(folio))
-		create_empty_buffers(&folio->page, inode->i_sb->s_blocksize, 0);
+		folio_create_empty_buffers(folio, inode->i_sb->s_blocksize, 0);
 
 	folio_unlock(folio);
 
@@ -3632,7 +3632,7 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 
 	bh = folio_buffers(folio);
 	if (!bh) {
-		create_empty_buffers(&folio->page, blocksize, 0);
+		folio_create_empty_buffers(folio, blocksize, 0);
 		bh = folio_buffers(folio);
 	}
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b5af2fc03b2f..18b38cefa27e 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -184,7 +184,7 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 	blocksize = i_blocksize(inode);
 	head = folio_buffers(folio);
 	if (!head) {
-		create_empty_buffers(&folio->page, blocksize, 0);
+		folio_create_empty_buffers(folio, blocksize, 0);
 		head = folio_buffers(folio);
 	}
 
@@ -385,7 +385,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	/* Perform all necessary steps similar write_begin()/write_end()
 	 * but keeping in mind that i_size will not change */
 	if (!folio_buffers(folio[0]))
-		create_empty_buffers(&folio[0]->page, 1 << orig_inode->i_blkbits, 0);
+		folio_create_empty_buffers(folio[0], 1 << orig_inode->i_blkbits, 0);
 	bh = folio_buffers(folio[0]);
 	for (i = 0; i < data_offset_in_page; i++)
 		bh = bh->b_this_page;
-- 
2.39.2

