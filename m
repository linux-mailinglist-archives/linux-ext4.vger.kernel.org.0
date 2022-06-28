Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE955C1E9
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbiF1APu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jun 2022 20:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241786AbiF1APa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jun 2022 20:15:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F2563C5;
        Mon, 27 Jun 2022 17:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgqoyZ0/TS5qPnTCyYsHkk+wS0pZ+KHaRgsclJaKg20iuoosmQo5lwn3ypz0QZ/ODfLZbQmSmaUk1P1N/nbFi4HZuTq0RauzQX/+GtzIZd6UG6bq5a+PypJRj6lgDvJ1ETj/RJS5Wmm5rNZevxsy19gjr552RNosklTbH7P/PCzRNWEwLCF0T7Zo97Tb4zw590Ps6dgD/a+u6UjC55NV4tgFwhj1z5sx9sBO73MYpF+Ivsyrgx93cmHZrjtbPbJ2NNlab4OEWnkvtv5T9COHP+QXVs/lVeBGPsAk6zqnLROu+DHe1e4T1qbK0IN9PEV3NWE3v+YYPaOUjYxf4+byVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCXWiNEvF3TUrQgA6hemuT7kHRIWD5ROdsIgulORq7M=;
 b=B2nqdXXnWT0gytKPJGjUqU3zoJQtNH5i6Rjusdcb7mHgNtxUzb0vAWK1mWU36Dm1A46PCm1WkhheJ54ULdF6LQJrQhupdpyIMv9jDn7RaA/zlZykkkB/SotnP9RevqYlRWrFs1mMNe5916Em52D6/u/pDS16zYGTLLIQylxPbZ53Kklm5F+GXeSqU8o8fnXlDBYUCMkUS4RDCxEZ/6OQN+e/Fvst2LV1AMS57E+fdLivYwi3rQjz3EbanI8VfECTOdni7ldJF4VvbqICtBLDGeBD2thqD7+J5e9cUc7X5f9VuiusSKPuJ2u1Dvh9COhzOKfAsSRysT4a8cg82632Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCXWiNEvF3TUrQgA6hemuT7kHRIWD5ROdsIgulORq7M=;
 b=MSzsgXs40NN+ZNAUAV7zmYxagt2kUeh07tGCePXh7NvL3K5jdm0IrTQAuDN+0BzfrRTglpSt1b/5kxyoYGfebTKyddClPBKyupyWJSdk91wL/x8TRoCTBqYQ76GcZP8uGhHzhXU5C9gu7zI4xOMbqmDApZeFpFLkd8viI4Weqfg=
Received: from MWHPR15CA0061.namprd15.prod.outlook.com (2603:10b6:301:4c::23)
 by MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 00:15:25 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::26) by MWHPR15CA0061.outlook.office365.com
 (2603:10b6:301:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 00:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 00:15:25 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 19:15:24 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v6 07/14] drm/amdkfd: add SPM support for SVM
Date:   Mon, 27 Jun 2022 19:14:47 -0500
Message-ID: <20220628001454.3503-8-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628001454.3503-1-alex.sierra@amd.com>
References: <20220628001454.3503-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c0017bb-faab-481a-5e63-08da589b4cb8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1328:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ijCzlUrFvFuNOxLh/fuHPaJPzYB+BcSKsT5H3KPm4zU83+atFWTvfWwQDYz3VTLK623ennhLfElWhkbGpyC4VpCkXEXW8P4GHme+j4TS5QI3fA2J5U0sMpIL8eQNaWA0f6H+GFn1if593JIQyT8W6ILxOv3Apbruhcm1gTtmJqpnWoH2TkVrGnPKqaerP6KJvjAzIRSE5XiQabxjp2XbtwAjwuNt1iWn7Epn3bIbKJpcA3ljDCz8nrqq3jui9CWb0wo0mT1pEf3I6gEd1k17YYSzyA2cQHS1u2K65SjsPdB/Cnr+dppdOWvHmcaHObZdP9031swaF5NJdtttBzGJRCuG9XeR+qTX/w1p6nsVo5ItFdY3LSqipXiPAHbCKp7s0k2Q++7+/LIS3YnkOmoFZgfLrmmolDf00Lzr+oVSLVK4QgnSSMHnbma0V4AS4eARB5pR8wHETwYqcJJ9i7bdiHI7Bjuxer1rJbE3hjHofeOplyimXvRg5uHj5AElLYAyJmfThdX9YpGUa82HYvzTx05jkgLP8Seye76Kalk36oBT52Bli4IwAJnahQt/UtjQQnMZ43Me0aU8/bICYcCjb980ArMWtQRvWYnxy0/BGyG4Asy+PAZNVobegaAN32H98Prswz20PCH9c+FE3LUL81EH531XSevM476xR5oFkqbzS1/0srvhcREBKVdgqwGG2LPngZmN9fr6J+1jz/zIIRB/wULpQivUDDqnK6EjfkquukY4se+4LDmT9hy75fL1bPMgbArt+6jOYfE8QH98NU/fSlUOfp7avkJF6iE0yjdQIt0IhESFKTAGoUmh8PB/bQcx7AR9aLfvvbSxu1UoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(40470700004)(46966006)(36840700001)(82740400003)(7696005)(356005)(8936002)(81166007)(36756003)(5660300002)(70586007)(70206006)(83380400001)(86362001)(82310400005)(44832011)(4326008)(36860700001)(7416002)(8676002)(26005)(426003)(40460700003)(2616005)(1076003)(40480700001)(478600001)(41300700001)(54906003)(6666004)(186003)(16526019)(316002)(6916009)(336012)(2906002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 00:15:25.4798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0017bb-faab-481a-5e63-08da589b4cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
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

