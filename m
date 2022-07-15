Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C562957642C
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiGOPGW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 11:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGOPGD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 11:06:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A677C19A;
        Fri, 15 Jul 2022 08:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB0OIfBRAQ5exqkkeCT4v4DWeQgh2bLkFIxlLQgvO/4JsVvEVSAugOV1cSRiCewnCdZjWSX/NWuE4A/wz0pHfQVtyTBCGrd1EpWZkGqySp/6mUOvsACsX+BRg85I0/fsIxKdpglTHUFeJ3akD9Pagj13vY9jRFWzCjFNXRJzcOVd3/vKyculoZ8JA8J1kY5cDjfnPom7R5bCnYdWcflL5cC71CTzWgN1hW1aSRtkEkcdLoIie+bpjLQjqACpgScu2fNCgQ5hFxI3gz25x6moBGjtKs/Wg4R8EgsMmEzbXjBYGwRRu3n9zMDsDhlv+mOx6qwniKyY0KUzbSuYWgLKhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCXWiNEvF3TUrQgA6hemuT7kHRIWD5ROdsIgulORq7M=;
 b=HOGo0LyikZc9WD5IKrtvM+t1D6KUQJEP7pmEX/d5mFHXCEARA4gKBagrfzjKj5krT0rm8JxGhWv4wVm0M1dPk3F2OopkaUPsk/leiAqbmSS3XwdmYqNxLwFC99CCcjUvvsiGeC832tpvtXkDFSPhqzsF8U8pkt/3rm/ESBSc5a0m6nCqIMaiPgi3a0HLH8ugpk8xHWkxMw2tUuOC67i9NWqzD4SNLLtLJ3XlJNvs7TL830+fzb/ovCIrWWW1K3GKgFrUGJHRm+mX8IpW/ofl7I5a5tUW2aTArsQFGjmRid46hFaoC2qxth+5X1jn7e0WYhA82OUEi7BMHYWBm/73Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCXWiNEvF3TUrQgA6hemuT7kHRIWD5ROdsIgulORq7M=;
 b=JOjT9d05ZXCOySImmdY788C5dlpM+7MNqpbtzCGRVXzYw1quao/ztqzXK67I2YiWtEHzALfX/+cwxhMXxP/gEUiKDKKIGLqLgVij1p69KXULjsfbAFZDetVb3HUR/Qfm8Zj4YaoTnJw3jmoyYI8YflyzWD0k6dY9KpT+0EF/PkU=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 BN8PR12MB3059.namprd12.prod.outlook.com (2603:10b6:408:42::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Fri, 15 Jul 2022 15:05:44 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::b7) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 15:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 15:05:44 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 10:05:42 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v9 07/14] drm/amdkfd: add SPM support for SVM
Date:   Fri, 15 Jul 2022 10:05:14 -0500
Message-ID: <20220715150521.18165-8-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220715150521.18165-1-alex.sierra@amd.com>
References: <20220715150521.18165-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b8ce66b-7895-4694-720b-08da66737dec
X-MS-TrafficTypeDiagnostic: BN8PR12MB3059:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9s7+ESVJUBcu39zP92JQ9LAXjRjyVYWg3BT6GXuApuEpHcL5wkDxiauMEL0DVnmDMpWdyF+c6FVkSXFfukhrizwTo+vSkux9jkqm5SKbUrgp1Q/7RrsATmw0xsE5nzyndvoUcImoLjgLRcabceLpZYgcktBpRTJzQRtgSCfSmCKuaFMFmD30ScyeMG81CLRloKbpBqGMgamJNnZ+g1U5rQO+MLawjTdnZlekBuFNsoIHBwHcczIuN/XWNXkLv7cKpNaPw5wRa/O6p1Zy/AdKc0MSiw+fuWcenpPeQpsFhvnZSgIMW1326nrmEro+t1n/BxzGDUUwc30WXqKPhA7FKqt7R4tSMlQGa4SRph44gTJXm59q6aOkMrJNbKxPGYNohm6hy0nmjfNaMXuCpRgZVU0rSjTaoM46KbTMniaJ/voQuoHT1OJzDL83xqfiHhX1mHbqvYuqTYdYYZhuIAeLc/yrez7qdQs5Vyymisy+UQysXXhaWMOqmGPZrQpMioCFyr/pZKIy3de+m6K8IpgL54oR/8DcNUyljcPQZ2Dz5Py6JBI3Y17nrLtAznbrxMh/lp++WVHOLdd9pUUWx6gQS7uhqFUIZ/0JDjscFnla3Dsr+euIUM/hq2hZUAjKF6Tk76hFS85xj4TVQDsErHFT0PmT2/OL840mgzGl41PJ7LlBYBGm2v6SJ+WsH4k8ZjwkDDngvQyaJnr1mEWeRFmxKCkJdqvFphcYD/C99GU4qYprPLcSCHnff9aNM/DF4JpbaXiE2fS/pHa/hIfIspqLPtja75JWjbuaYpeDgd1IklqBQ5d5j/pGEndK2xNBacYl1Oq71qc8iAm5rTESoDkjaqyDkddv4w4rgWacNm7ddA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(40470700004)(36840700001)(26005)(4326008)(316002)(6916009)(82310400005)(54906003)(2616005)(40480700001)(7696005)(41300700001)(86362001)(478600001)(6666004)(82740400003)(356005)(40460700003)(81166007)(186003)(1076003)(8936002)(47076005)(426003)(16526019)(83380400001)(2906002)(70586007)(7416002)(70206006)(5660300002)(36756003)(8676002)(44832011)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 15:05:44.5172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8ce66b-7895-4694-720b-08da66737dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

