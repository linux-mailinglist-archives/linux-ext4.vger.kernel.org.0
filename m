Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A382A539788
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 22:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347621AbiEaUBD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 May 2022 16:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbiEaUBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 May 2022 16:01:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927261600;
        Tue, 31 May 2022 13:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn9wMh4PZL8IDYXNuVi1lG/2Y9ilPDrCg3vWlf5OTSgPt4J8VummOXm7LAeNOwIIUF4BpHvySspH5llBbGoRYoXYO+wmaJ6mxAqHIPGL/3mw+mwEBH5iYgSZnoNCpzklL83ppX+bSqzpFho9MCCuD5Zi6ScfR4BdFo/Hy6tEPewAoEeKwgyS1Wf7sIldHzCCmV2iA9VHQoAZD7ANdeBb9e2plbEkt31Mt2/s7MCdTPbY8X7F52M/D0pmg52uIxu/bmus6pCFzhovx+RHgJj3h/RUSOqWd6GOB2yKAyGbnmSegQHZXQ+UlgE7PZynwDSPGkVJ24m4THogetZWv+iCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EJHkZDbAdLVpEXXE+RGiJTJBXEdpU2pe/Diqmm86p8=;
 b=B0ER/WB7QQq/sOkGBGXaCxq56fsx35LaTaohcD8BdtxLH6OB9QW4d5lvd6Nt78laKBu3cVLNVmRh6wYlChC1y2o6DYRzTy1yVwj+AaWx0wn+OMgetuwgpI+pHT/21IgV0mxorRBZpzF79vSnh+Qq5MMO5+Q/Vroj3Ap6TQwFqLjOA5nKNG2vdHqt23eh8uwGPRKo8GCV/T+yDnugbfowprNekYwbnQl5xAVMw3efOvKAfZxGJiTpuBuVWUIJtahzX64nS9VOItWGOo6bEWhyFW+YVeknaFM9cy0xVAElb9D1LYcnV1cDxHDWC06heoliurzKQTV2UJ8zKtb4r/2WOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EJHkZDbAdLVpEXXE+RGiJTJBXEdpU2pe/Diqmm86p8=;
 b=cM1VjDo3ZpMX1LECLjvU/pT9KWqdaZ0F1tecEUwIAQADHXUfWoAawKaif+DFMnlcXPsaXFZ9AmvvJEy81G6G5jMmrXE1XUMgGaVZfQ+bNwtvyG4h9si830zyzguumy2mCHr0a4BM/koVzwC1CX0thaiDrg3zzQj3mX+yacFlINA=
Received: from BN9PR03CA0398.namprd03.prod.outlook.com (2603:10b6:408:111::13)
 by BL0PR12MB2450.namprd12.prod.outlook.com (2603:10b6:207:4d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 20:00:57 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::42) by BN9PR03CA0398.outlook.office365.com
 (2603:10b6:408:111::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 20:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 20:00:57 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 15:00:56 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v5 04/13] mm: remove the vma check in migrate_vma_setup()
Date:   Tue, 31 May 2022 15:00:32 -0500
Message-ID: <20220531200041.24904-5-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220531200041.24904-1-alex.sierra@amd.com>
References: <20220531200041.24904-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d84212-9237-4ba4-e038-08da43404723
X-MS-TrafficTypeDiagnostic: BL0PR12MB2450:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24504F0975B8EBDB5B83FD3AFDDC9@BL0PR12MB2450.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gg6WZvfRv61kOlZs0O5fVxY0i+XFjkKLnzRTb+oeWpcvDYnxh2ajlRZL9eWofLT6cUDfSSX/bo671SN83N3gI8MHGsTY0WCFtYOfpx1Qvn38T+ejUqtoqyiMNscnDjDAjhAGrRQoIGP0NlaLeOSY+t1QKUbKxztCMDM51mry0i1zK011PKd0ZF90b9avnIj+Lj9QDJM1vUHdove1l35JltG0oxVahxhw/fwLdHGRgHqa7DrZ5Cu8eGYHuzxoxmzHb/BaTUyrTjI/Oe7Z0QzQFh8NraxsrAfyb/zXBHETPdUlf99pyhq0kO1M3ZwtxO109fb0pnhHNMhFqYJAN8C+qOBOHewfQaxFpEGBzdYk1u+4R7xUCw/QOoL1iXkYSPbhRxwMr0qn0bIwA6uavZqe9T75AaxqCXLHG/eDGpvRRSP/W5tLhFdANQ0cCX1oOLrFj0k5xSBJCudKtxBtzSehemqAzal4U/qnJMxFjPQU6GMgrwPKW19GOCYZqOH5c9voczltIbZ/h1nmie2a2LOvd7IDUZvHeQT1+WFuVE/fZUNTHO6tNbRxRBJOLFK7WP1Wg/H3wh0ieW04hE7PGvVCoZU0PpyLkWzTNJDB6Mf1LiCEx5KSDh/cdHq0CNQK0xHzBS7ungGCXcUYjrJMsriG1bQ23rzImRmHtitcWwN4NuOj/SZFyTVCL23QywKlBvCT8ZgB0rN9D41lXxhyT+JBgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(356005)(81166007)(6916009)(54906003)(40460700003)(6666004)(316002)(2906002)(8936002)(508600001)(70206006)(70586007)(7696005)(16526019)(186003)(5660300002)(44832011)(26005)(86362001)(82310400005)(1076003)(8676002)(2616005)(4326008)(36860700001)(47076005)(7416002)(336012)(426003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 20:00:57.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d84212-9237-4ba4-e038-08da43404723
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alistair Popple <apopple@nvidia.com>

migrate_vma_setup() checks that a valid vma is passed so that the page
tables can be walked to find the pfns associated with a given address
range. However in some cases the pfns are already known, such as when
migrating device coherent pages during pin_user_pages() meaning a valid
vma isn't required.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/migrate_device.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 18bc6483f63a..cf9668376c5a 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -486,24 +486,24 @@ int migrate_vma_setup(struct migrate_vma *args)
 
 	args->start &= PAGE_MASK;
 	args->end &= PAGE_MASK;
-	if (!args->vma || is_vm_hugetlb_page(args->vma) ||
-	    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
-		return -EINVAL;
-	if (nr_pages <= 0)
-		return -EINVAL;
-	if (args->start < args->vma->vm_start ||
-	    args->start >= args->vma->vm_end)
-		return -EINVAL;
-	if (args->end <= args->vma->vm_start || args->end > args->vma->vm_end)
-		return -EINVAL;
 	if (!args->src || !args->dst)
 		return -EINVAL;
-
-	memset(args->src, 0, sizeof(*args->src) * nr_pages);
-	args->cpages = 0;
-	args->npages = 0;
-
-	migrate_vma_collect(args);
+	if (args->vma) {
+		if (is_vm_hugetlb_page(args->vma) ||
+		    (args->vma->vm_flags & VM_SPECIAL) || vma_is_dax(args->vma))
+			return -EINVAL;
+		if (args->start < args->vma->vm_start ||
+		    args->start >= args->vma->vm_end)
+			return -EINVAL;
+		if (args->end <= args->vma->vm_start ||
+		    args->end > args->vma->vm_end)
+			return -EINVAL;
+		memset(args->src, 0, sizeof(*args->src) * nr_pages);
+		args->cpages = 0;
+		args->npages = 0;
+
+		migrate_vma_collect(args);
+	}
 
 	if (args->cpages)
 		migrate_vma_unmap(args);
@@ -685,7 +685,7 @@ void migrate_vma_pages(struct migrate_vma *migrate)
 			continue;
 		}
 
-		if (!page) {
+		if (!page && migrate->vma) {
 			if (!(migrate->src[i] & MIGRATE_PFN_MIGRATE))
 				continue;
 			if (!notified) {
-- 
2.32.0

