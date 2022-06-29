Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85A355F49C
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 05:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiF2Dzt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jun 2022 23:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiF2DzR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jun 2022 23:55:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927C235275;
        Tue, 28 Jun 2022 20:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNbitqI5XsaG/zovofVFpmEvHGLmPszkLKmSQiPvXOzH4Ckh5GULKp6uH2XCkNez+VEjtDFPyyiG8Ujia+H0Lkz+ASdRHHCbXrv4Lto7UK1Y89M209nXzwwB4tXrMrqXTPzhOqBx32Kw6Xr9+KqWFq2e9KlA28JK73Gi7OBRyn2y8+l5m6XCC+Reg/iU0cEvpP0kvRhDG9ar8K/ykWI9SCDGYaoAlBFvUlJOj5s93723CYXbq+SYli3eD128Wa1Aqk+7O83jBTsNR4py6r3sOuG+GP9IBO6EkdGo4DRcEqf9cWFiz9pY1/At1HtkyDJYdsZHfYb5Q8DZSTkpB6jYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCXWiNEvF3TUrQgA6hemuT7kHRIWD5ROdsIgulORq7M=;
 b=MV7jWq1EmDENyC3IHRW1h8gVGLBUvSrvIH4qrDGTW0t+u/xjA7Jit1RoNEd87kq7emLxYnV5T3ottLsd589ZuBYHEuOihQakm+Z+GcxdQF/bFjrRbfYOAsdl9rLQgsOsoCXUNWCNzABUxB9/1+P7PSIWO/yJPuR4GaD36XwkbblVoqZjjRGYjLGW6jw1jdzP+T0YIhE50NcRNW5ZbGr1V6Ixk/LKL4EEBICRHhi5iGY2oulGg1Cgd9L4JjaQotQgmyWwVNIF/bsxT+KInViI47y6aUR2YD7YbqsGRNnEFyURDik9ID43MBW5gRWunsEYDfl0r/BsIJ7iNt9RxIvDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCXWiNEvF3TUrQgA6hemuT7kHRIWD5ROdsIgulORq7M=;
 b=NGW5Z8sbTXRaugIiswjrQyuG8IfZf8NRnrVRDn1zWSXTaZVf32HogBnRF3ISeRe6YIOVN0jUEcLYWw+y3h6aSiXQWrdMa8GKoAAFN0yHM+vBTnJrYXogMrKxnxr8K5tqQTSjIt0YN9D5h8pa0GXwcu4UyYcltQLdjetpyhsPAD4=
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by BYAPR12MB3334.namprd12.prod.outlook.com (2603:10b6:a03:df::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 03:55:11 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::9d) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Wed, 29 Jun 2022 03:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:55:11 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:55:09 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v7 07/14] drm/amdkfd: add SPM support for SVM
Date:   Tue, 28 Jun 2022 22:54:19 -0500
Message-ID: <20220629035426.20013-8-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629035426.20013-1-alex.sierra@amd.com>
References: <20220629035426.20013-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dae6057-6547-408a-f440-08da59832a58
X-MS-TrafficTypeDiagnostic: BYAPR12MB3334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFvNe7zou+EEyBCAbwXLt1N+FODR35tJP5D9GdOECbzE6ohDL/ctj+IWvqXcyCUE7QqGuXDqZX+wA5eiN/IM3Ig8KqoVkNJjM1aiPNYN3qXiEkcTrcJVlVYIb8rwPrGBZpJFRyU03oUjmYUBmaK4Ucu6cO/QGK+9EyeesMJan3cVDGzyFex0qtxiaFEyBrWHMaxQZhzIlqAXbfBF2LYqTp4OogVNNPvQDaFh9uYn/3r+nQE4QNmdDcHkT5raUk69JEOCR9CSs/wiNYDi9/CBNhOuWks8VyOzZNN5t6Pc+II4//fDvkaSE8KhkreJqYZU2B0ojJj9uCFw54nAAELvMqurp3vaCcKSLhlJonEfQH30lBRzTmmoBL3vBNxZ5x90z6++iScXEZILgFM6pjOi2LgHjyTidZOFRGA0pGYiQ476bTihmulJcmEEcNMirtJxz07LEPDHChfaF6wUyVcqH01mDqdL76UKw2vMl4tkraOZLzr/1XnYSPbSVCQY7ZjIF1YrFon66LP+BZgECU8jMfm1X1I9FqzuWyxlszvX9f1oh4KFhS3X2m7zkDueQ1K2aCJW+b14k9d3cfQ4xLjB0EwZhKeGU8OSjsDG0gM1pYgC7/fC6kVG/YbRKB1ABzJBgtthfFGBKQE2mqAfzlHxxXYIkg9jDyq0XxD7O0JEN3Yyw71uM8+SanDr0sTv7ZSAQE8957ylGjYVEUy+SZlSOYndGJzIG9fSu0mO0yctrQODIWSqEzuGn1ds82Iko5RSsyXyMU8R1sJj6bTkkqOfJfzwiFYRxhSTsck6sdwNkQXf9Mnsj6M33bmGAoT9FVZN84I9g8idGFfToGacPYY/YA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(6916009)(70586007)(70206006)(336012)(26005)(16526019)(41300700001)(86362001)(8676002)(316002)(7696005)(478600001)(54906003)(47076005)(83380400001)(36860700001)(426003)(6666004)(81166007)(82740400003)(356005)(1076003)(2616005)(4326008)(186003)(7416002)(5660300002)(36756003)(44832011)(2906002)(40460700003)(8936002)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:55:11.1469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dae6057-6547-408a-f440-08da59832a58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When CPU is connected throug XGMI, it has coherent
access to VRAM resource. In this case that resource
is taken from a table in the device gmc aperture base.
This resource is used along with the device type, which could
be DEVICE_PRIVATE or DEVICE_COHERENT to create the device
page map region.
Also, MIGRATE_VMA_SELECT_DEVICE_COHERENT flag is selected for
coherent type case during migration to device.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 34 +++++++++++++++---------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index e44376c2ecdc..f73e3e340413 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -671,13 +671,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.vma = vma;
 	migrate.start = start;
 	migrate.end = end;
-	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
+	if (adev->gmc.xgmi.connected_to_cpu)
+		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_COHERENT;
+	else
+		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 
 	buf = kvcalloc(npages,
 		       2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t),
 		       GFP_KERNEL);
-
 	if (!buf)
 		goto out;
 
@@ -947,7 +949,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 {
 	struct kfd_dev *kfddev = adev->kfd.dev;
 	struct dev_pagemap *pgmap;
-	struct resource *res;
+	struct resource *res = NULL;
 	unsigned long size;
 	void *r;
 
@@ -962,28 +964,34 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	 * should remove reserved size
 	 */
 	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
-	res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
-	if (IS_ERR(res))
-		return -ENOMEM;
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		pgmap->range.start = adev->gmc.aper_base;
+		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
+		pgmap->type = MEMORY_DEVICE_COHERENT;
+	} else {
+		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
+		if (IS_ERR(res))
+			return -ENOMEM;
+		pgmap->range.start = res->start;
+		pgmap->range.end = res->end;
+		pgmap->type = MEMORY_DEVICE_PRIVATE;
+	}
 
-	pgmap->type = MEMORY_DEVICE_PRIVATE;
 	pgmap->nr_range = 1;
-	pgmap->range.start = res->start;
-	pgmap->range.end = res->end;
 	pgmap->ops = &svm_migrate_pgmap_ops;
 	pgmap->owner = SVM_ADEV_PGMAP_OWNER(adev);
-	pgmap->flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
-
+	pgmap->flags = 0;
 	/* Device manager releases device-specific resources, memory region and
 	 * pgmap when driver disconnects from device.
 	 */
 	r = devm_memremap_pages(adev->dev, pgmap);
 	if (IS_ERR(r)) {
 		pr_err("failed to register HMM device memory\n");
-
 		/* Disable SVM support capability */
 		pgmap->type = 0;
-		devm_release_mem_region(adev->dev, res->start, resource_size(res));
+		if (pgmap->type == MEMORY_DEVICE_PRIVATE)
+			devm_release_mem_region(adev->dev, res->start,
+						res->end - res->start + 1);
 		return PTR_ERR(r);
 	}
 
-- 
2.32.0

