Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090EB7CCFDF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJQWMI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Oct 2023 18:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWMH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Oct 2023 18:12:07 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F159595
        for <linux-ext4@vger.kernel.org>; Tue, 17 Oct 2023 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1697580727; x=1729116727;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=idvRWyzD1kZSJgalGoPzbRXhnU2C6oddZyZMVHbP9Rg=;
  b=l34d0uOyamglQl2P0Vfqorx4FDVM7/Q/2NJY2OlQluFe2lCFQjKVFb1m
   3Ldn6BefwniC2l3i2ifTsh77SSmrqs4T+G0k+nkSwGxBzCaaQ17Ds5Cvk
   LlatEPPS5laQAXBsEpEGp8ycbAe/hcFOt8JQ6FYaPRrzr9kP+L914z2SU
   g=;
X-IronPort-AV: E=Sophos;i="6.03,233,1694736000"; 
   d="scan'208";a="246210976"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 22:12:04 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
        by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 24A9BA3767;
        Tue, 17 Oct 2023 22:12:01 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:18766]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.182:2525] with esmtp (Farcaster)
 id 1eaae146-b040-432c-bf5c-0b90ab339e27; Tue, 17 Oct 2023 22:12:01 +0000 (UTC)
X-Farcaster-Flow-ID: 1eaae146-b040-432c-bf5c-0b90ab339e27
Received: from EX19D023UWA002.ant.amazon.com (10.13.139.65) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 22:11:51 +0000
Received: from EX19D017UWC003.ant.amazon.com (10.13.139.227) by
 EX19D023UWA002.ant.amazon.com (10.13.139.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 17 Oct 2023 22:11:50 +0000
Received: from EX19D017UWC003.ant.amazon.com ([fe80::f6d2:d06:a0ec:a97e]) by
 EX19D017UWC003.ant.amazon.com ([fe80::f6d2:d06:a0ec:a97e%6]) with mapi id
 15.02.1118.037; Tue, 17 Oct 2023 22:11:50 +0000
From:   "Lu, Davina" <davinalu@amazon.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Kiselev, Oleg" <okiselev@amazon.com>,
        hazem ahmed mohamed <hazem.ahmed.abuelfotoh@gmail.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 1/1] ext4: remove the bottleneck of ext4-rsv-conversion work
 queue
Thread-Topic: [PATCH 1/1] ext4: remove the bottleneck of ext4-rsv-conversion
 work queue
Thread-Index: AdoBRuwfXYXJC+v+S0ufPaUWI5yXuQ==
Date:   Tue, 17 Oct 2023 22:11:50 +0000
Message-ID: <18c6a1302c9a4a94a44e7262b97c8750@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.143.137]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

=20

When dioread_nolock and delay_alloc are both enaled, the
bio_endio() will trigger ext4-rsv-conversion work queue to do
ext4_do_flush_completed_IO(). The current work queue is
one-by-one updating for EXT4_IO_END_UNWRITTEN extend block at
io_end->list_vec which added by ext4_writepages().
So if the BIO has high performance, and only one thread to do
EXT4 flush will be an bottleneck. So we simple allow more thread
and with a semaphore protection, since the "ext4-rsv-conversion"
this workqueue is only for updating the EXT4_IO_END_UNWRITTEN
extend block(only exist on dioread_unlock and delay_alloc options
are set).
---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/extents.c | 2 ++
 fs/ext4/super.c   | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..15d8d7a1810e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1134,6 +1134,7 @@ struct ext4_inode_info {
 	atomic_t i_unwritten; /* Nr. of inflight conversions pending */
=20
 	spinlock_t i_block_reservation_lock;
+	struct rw_semaphore i_rsv_unwritten_sem;
=20
 	/*
 	 * Transactions that contain inode's metadata needed to complete
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e4115d338f10..dbd3f69853cf 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4807,6 +4807,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, =
struct inode *inode,
 				break;
 			}
 		}
+		down_write(&EXT4_I(inode)->i_rsv_unwritten_sem);
 		ret =3D ext4_map_blocks(handle, inode, &map,
 				      EXT4_GET_BLOCKS_IO_CONVERT_EXT);
 		if (ret <=3D 0)
@@ -4815,6 +4816,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, =
struct inode *inode,
 				     "ext4_ext_map_blocks returned %d",
 				     inode->i_ino, map.m_lblk,
 				     map.m_len, ret);
+		up_write(&EXT4_I(inode)->i_rsv_unwritten_sem);
 		ret2 =3D ext4_mark_inode_dirty(handle, inode);
 		if (credits) {
 			ret3 =3D ext4_journal_stop(handle);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..af2af5173424 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1466,6 +1466,7 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&ei->i_orphan);
 	init_rwsem(&ei->xattr_sem);
 	init_rwsem(&ei->i_data_sem);
+	init_rwsem(&ei->i_rsv_unwritten_sem);
 	inode_init_once(&ei->vfs_inode);
 	ext4_fc_init_inode(&ei->vfs_inode);
 }
@@ -5452,7 +5453,7 @@ static int __ext4_fill_super(struct fs_context *fc, s=
truct super_block *sb)
 	 * concurrency isn't really necessary.  Limit it to 1.
 	 */
 	EXT4_SB(sb)->rsv_conversion_wq =3D
-		alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+		alloc_workqueue("ext4-rsv-conversion", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!EXT4_SB(sb)->rsv_conversion_wq) {
 		printk(KERN_ERR "EXT4-fs: failed to create workqueue\n");
 		err =3D -ENOMEM;
--=20
2.40.1
