Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A87475AEC0
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGTMuw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGTMu3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 08:50:29 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C911E2135
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 05:50:26 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48]) by mx-outbound11-174.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 20 Jul 2023 12:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wef3BTd0jt4NhFpVvVVht5c0zeG7U6QGTKY3GFBW4xRASStqc4LVyfCpeeFeyHD1HnbSbn1tZA+AehLWe11Kw/cTBJ3xKBouXmguwgSwgzF5DVrNKNK2putcpyTCojoanQt7Lfk+TMSW6/4Ah3fKmkX1upnixoq2DZfh2rrsyWcIltLS8sf9TO/G425sh//kTlxNij5nk57QUusqjPGHXUh9jXsEzuORI6h34SoHfqy1+Owwr33NLnglO9RVjPFsAMWVI4o+bzPYP0DPosaAbhyOMbVWWzR5/l9k9B2kPU2U1IGC5umnVEw9Jy2W13nHMjWtl2RWuxaRHFFb7/3HJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9ULAQDS+8JBBVlF4iLTGH5T8DMtuvn+ET0AaifYWp8=;
 b=Phvq6Q2R1nDWzySmCVFFUNSYb8x01YGSE/HBg91FhOXhXSGiY4N11smvFhuYjRRzk/f/Sq/nOXM1VWqxuoTKJ3jSsKmeDDFckvjSv2HU/8JAZ1ABuDU0KENgWisSOyWDYqViBl8d/AMgPY7D09COS/SD2mVXVSyanuxUUo8G3qIE+wqNB17+Ur+PwPUZiUp2liof0J11Gwta9QmIqZPFT/hX7ZItXDw7dz5WHpTrSa5Ihj2QIpVwlsSBiInj3rO7kRpvMHMiVmBtmaFlR5jBF3urkC/pQjZv+ePTBB3AWQPnJvTrq1P3hh4Tt3YUz0XFzdhklP80sXZ/182R699mLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9ULAQDS+8JBBVlF4iLTGH5T8DMtuvn+ET0AaifYWp8=;
 b=aRPFYomnGxCm2wEsi01b74j7r7MF0jxjoyofd5l5eumZU7HcOxQDtaLGjuRzrRulS3B1r0S9l+vorRwCzSf5TS0Ufg1UT8kK+Mo8MuM0cYYMEw54XiHq/H89dP/X/F4DbUc9MnZvwK7NyTTLKSDQfnwl5tfLdW6fnHPdhjFpI00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH7PR19MB7605.namprd19.prod.outlook.com (2603:10b6:510:26a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 20 Jul
 2023 12:50:20 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 12:50:20 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca
Subject: [PATCH] ext2fs: make sure we have at least EXT2_FIRST_INO + 1 inodes
Date:   Thu, 20 Jul 2023 22:50:12 +1000
Message-ID: <20230720125012.641504-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0018.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::16) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH7PR19MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: c0085619-15e4-43a1-1e3b-08db891fe025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0fRjufJzapTG20Tbex2SsfSa0kl+dYGfmfAlouUBlOVOeaxP1Od7FmQDu4kaukEuG5vw7dkPDz27F1F1EGOzDjunU02rKThUWaYwg7MIMpFHMMWkTpzmWH6HycG5LJ8K9gx++cjbsLNvxmLzPaAJ6mKbrNKXqrJFgll70ivx3eBwUDPgVvQRq1yL2XS+yE7s0+4kWQeRR1z8/WiksJzF5HkZZW4EeS4vEadeCudnveNOErv7D8VdIeztbhxcF70jgOR1oVTwhSP4llbBviKOwYk/L+ljFqwi1JltD0ZBPcIdCBLRv1kUsv9c88cFcWP+ltSO0LfVvUYki5h2PCo2EpkyCsO1r3NIPKr0OPa05NpvGDL/DKjuMMrmjtBj29KKOAN4+WSz1dgAOy1y7+jn+pss+nGW5Fg9nSwN2HNjyvY33YBCsnbGQxfvyGY8t/j9JtW+xGsnqnbXs72DpV2RNEyUaaImq475IKwjavtH3c/pAI/NXzJH0Wzl4zQBfwfvYNXjdnC+uyJDKWGBU00zJBugguRBr0sRtz7/DlObX0A4tRDoFGQTzNbMFfzwXhx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(451199021)(186003)(2616005)(36756003)(55236004)(83380400001)(26005)(1076003)(6506007)(6916009)(4326008)(2906002)(6666004)(6486002)(316002)(41300700001)(38100700002)(66556008)(66476007)(478600001)(66946007)(8676002)(5660300002)(8936002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b68I6l+l8PqTl+B1Rgjd4fhnSfkzvmJdopesw2rYbZpQb62vfZmEVlh2t+m5?=
 =?us-ascii?Q?ef1tKuXDshmygyEp8MggIRQUv2z7mk+P/QVHoEWVFtoAy45JzLUakT5sitoQ?=
 =?us-ascii?Q?u8W8MLihAHkkqMGLbIwgIHcIkm9qISupJ3uDXXluF2Upo65A+Z+km96IAhEJ?=
 =?us-ascii?Q?6U2GemvXoJ+yreEW0Yi5+DsJhXpH5khwDAZQxX9YcVJkfK27vpxaSbUInepo?=
 =?us-ascii?Q?okfhDm7QoN3Jfd3Oz9HgjccojkdRs/4TqVtopdSrZeSQoEdzVEz3DN0C+QGJ?=
 =?us-ascii?Q?UuKvFjrQPgIMPB2r+UfwwUc2qWyI1wm7yL8j/UoQSbjkk9C8ijgN55Vcqefi?=
 =?us-ascii?Q?mMZ6CkA7K5FMQGjXG/0GMGrRLAvpkGIw6AHIZvohJQMgbfMu7SS+1If7szqs?=
 =?us-ascii?Q?yzImZUc+LrYcjrkyGbs4ZMyWYVEt8WTE8I7WWTqFBjp2clmvdOOyp4hofWG3?=
 =?us-ascii?Q?oar6q71ZRARgCkW8Ram/RjOZaxJ9XbIWMAJnq180f5XngMKnr+LhtvcEDMoE?=
 =?us-ascii?Q?urZnYhTnukO1jZ+x+45e+ehxemJizfXLhzYkY4RS2DyiwqsJbBJtQ5i0orIZ?=
 =?us-ascii?Q?RMYnlJu4ErxM/TyxrMs6a9Bz6IG3zn0Bek0ttGRgwl4udOy7SYndzvDDR/mA?=
 =?us-ascii?Q?tJ0M5TXVTJHCjJpXALsdpr7YaV2xernlHIzlPb4KKumJjSWdOWoDwSoPNB16?=
 =?us-ascii?Q?XkIb/IfZZ1Yz2IXCiORrKKsfuGIaDPHOedDAXeNXAZU3ujrhIjgWdnyuBMJn?=
 =?us-ascii?Q?KaVJKmhlW8ouBRaJCl/n6wwHZpz0VH9ZdnpbE/WMOeC0y09zk6D17TPR4S4u?=
 =?us-ascii?Q?Zy93S9S/s80ND9ecULYD2p/ofz0uncWeqnOQZMpqVgoeiHSRYuNP0VAAgQD0?=
 =?us-ascii?Q?Ifp1xNMXIUxo19LQAHCVuDx0eHdsh4KrdUS00iAo4VIBqqL0KYQ5BgLkXnSF?=
 =?us-ascii?Q?EtvD/e5Bo5uKJ7fqZjOBXJiUdKa83gvL0a5blTTcIeJxQU4ZaU8O0q2WQZqX?=
 =?us-ascii?Q?6DHD55/pqja1Lqs9QO2eQM9ohDNtRAmDZ433CYnfFOoSbnXGV3R3+As/c3OY?=
 =?us-ascii?Q?ne80BCADkoIkXZiXN7OvR0/ReMhGwvsR1+u3dQewAni9WAtInr87w9iWGlK3?=
 =?us-ascii?Q?FQe3w6oJvQ/wPxyojmLPPdJOPriPoZbGYgYUrXOpijXJq/uW8W/ZfkUwshOd?=
 =?us-ascii?Q?BV7sdFTtPKCnfR8mSZ7F9kq2+FJNsGVXyL7IJQitE/r1oBFQ9XOveM/eetwj?=
 =?us-ascii?Q?mIXsR24BfR91j0XIhR0Pr1ibNLGqNGlPFuTkckdkll1gczdjd/AHJ9a5VXEU?=
 =?us-ascii?Q?5SzkiQd23+GYmOhnwClgC5bx4fJxB3kpBjeKG8VW8ec6rxVy1Lqh9C3VsDQH?=
 =?us-ascii?Q?4sYdZfwoT/vz5DmXrNTCOgREAUriVCQsPKO8coXCi0ymfc4/l8twug+g797N?=
 =?us-ascii?Q?Rf5w/0aKWOCobYC+UfTa/o7yR0B3158rdwlZ0YD07WgL9OnWbwYDQMHkzqXH?=
 =?us-ascii?Q?7aEurd+aEXEHZbwcq0sYG8xVd0ZEclh3QcZNCWJRXzFtNAYwAEADqBRqe1Ma?=
 =?us-ascii?Q?pc+oFz2MTXTdtIuZj7I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O/VaCpUkAyB2PhaEJ6vOhFMmd85U7zK8PtIqx9v5gNUBS6UMCbQZDhcvgRxVFFacIICVLif0snCLINHjIjwiGz2jprPLsd5oq9VJYYpb+yqXrkuSOGSjn0nmegAxD5JZNFXMbRVnmC+0O6ggoTDT8Q9Y4X4p2BfFxO91bJq3YFx/nJIvmZb1R++zcoHY1GSpvrAtsPU4F3ppK3w5B/klbj+b/QDuEPhlgKfuLNC/CPXQqT4U9lrRRq5qfM+KJIJOaMaGB5y1NpC7SW3w36jMLzfdA2kjY7BSmgQO161x4KD7w98x+EwlpHvIe1wGFNg0Muc6msw0XkRnkPbXzsMOuaqfj6H4Gro64Kdy2ZaPtgnVX0gK+u1z4WH0FwrebjlCjrwYVpOc8vbTFbwwNoVs2JaL3AGQ/qMvG09E2xZVNtjSasMpVYeWf+P5sTgMZUWyYNHhLHXAKn1Re4GGGW023MfmtVmfuSJwMX/+immrGBi+rde1mAmgzxD/DY3fme+3t/9vKDEGchiDshHMgkKLUUFUcu3YMrhKiUkRb4rmvgsY44aXNBtjtmq+ET4E8n55MB13nkkHbx6ToYxZfU8TxXdGXYPkI89QfVFuzQ+lqWhfQBjQ8wF6KENPNqIEqhSHgK7D1PzLfxy7sRAMhAxSv8sVtGo9hptlxP/awLw83RjFvvCK7k9yr2794ImHu0rBdgcHVXMbQOUZI+NUYMvx3XY04C2w9EEDag/Nnv8cUwgAqxmRcyuRsCJF/lha5Zs3ADqRDG+RTOwoR9pGfBK1+SCMZRrwNFGOCgfnlR7UCOLTGJ5+Jql4QNoekjmUTV7p0V9oRtxzUhopMvjhlHREFw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0085619-15e4-43a1-1e3b-08db891fe025
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:50:20.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAIQt4UG87oBtDLy3+DvJ/ClnZlZiKyESF3NXfbUSd+Rlf2xUpq2/0GxvfIC6Uw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7605
X-BESS-ID: 1689857425-102990-12361-6819-1
X-BESS-VER: 2019.1_20230719.2244
X-BESS-Apparent-Source-IP: 104.47.66.48
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamlqZAVgZQMM3Y3MwkOSnZ3N
        DIINUg1czEzMjC1DwpOS3JMMnCKM1UqTYWAEsmM4JBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.249610 [from 
        cloudscan12-174.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When creating a small fs with 100 1k blocks, mke2fs fails with:

Creating filesystem with 100 1k blocks and 8 inodes

Allocating group tables: done
Writing inode tables: done
ext2fs_mkdir: Could not allocate inode in ext2 filesystem while creating /lost+found

Increase s_inodes_per_group with a step of 8 to make
sure we have at least EXT2_FIRST_INO + 1 inodes.

Change-Id: Ib885735641dfa0ed9c6f6a4a1f9afec291673126
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 lib/ext2fs/initialize.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
index edd692bb9..e96f3cabd 100644
--- a/lib/ext2fs/initialize.c
+++ b/lib/ext2fs/initialize.c
@@ -307,13 +307,6 @@ retry:
 	else
 		set_field(s_inodes_count, ext2fs_blocks_count(super) / i);
 
-	/*
-	 * Make sure we have at least EXT2_FIRST_INO + 1 inodes, so
-	 * that we have enough inodes for the filesystem(!)
-	 */
-	if (super->s_inodes_count < EXT2_FIRST_INODE(super)+1)
-		super->s_inodes_count = EXT2_FIRST_INODE(super)+1;
-
 	/*
 	 * There should be at least as many inodes as the user
 	 * requested.  Figure out how many inodes per group that
@@ -375,6 +368,15 @@ ipg_retry:
 	}
 	super->s_inodes_count = super->s_inodes_per_group *
 		fs->group_desc_count;
+	/*
+	 * Make sure we have at least EXT2_FIRST_INO + 1 inodes, so
+	 * that we have enough inodes for the filesystem(!)
+	 */
+	if (super->s_inodes_count < EXT2_FIRST_INODE(super)+1) {
+		ipg += 8;
+		goto ipg_retry;
+	}
+
 	super->s_free_inodes_count = super->s_inodes_count;
 
 	/*
-- 
2.41.0

