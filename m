Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0119A53316F
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238888AbiEXTH5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbiEXTHf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 15:07:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F26737ABD;
        Tue, 24 May 2022 12:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsWsaWvT+d9Dot0beALQmczytOlHQpiWxQPQW1JnmFPaPdjjFlXrTOVf+i+KHKkNBGc+iFE08151GSfiBrUBwxA0yLDDnycWZW9d+/0nl1mUSaNPXcfHN65Pi7L8pjeukwLazWTJ8qELPNN88oMGFrJnBwTb8wEfAKAjAQ74RUk6boM6FxbfmLhumFy71LlelikLuKaJxW53sN0+moKKCnrD+sV4j/DjGCQJTEHFS2JAISjcGDD6se6U5fzN4qec+QvGzZ7+MPGO6DqNO4rB9V/0++2bmqxwhIYngQxJij6HN+KEyASCO1V1xab51aFjjc+zQdgI9UL5sjrwOsGyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nl288P0aFMxHvyTdajqKdYE2bhkbzZtjR6cg4VQwpEg=;
 b=WCCNOf1J25IWTukc8tq0Ye/Nw4qHw5yPt7Lh1Z4WWGrH1oifwVTaCHj4GxYBCrkMvgKAx2qzJsVn2+nHqgkgrVj2vd3A2KHPNjhKKSu/rTYi2pDFjXv+E/Wibr2m2M4FIWfmvtgJfBkZUFIqFVIqf+8oqkbyfkECeNrAfOBgjTXz8mi7mraZzEGR2s5JScF4iO2Bre9hQxfJnWxxmjdzjyIXk0Mg4po/CqOg7npcuEEBrDQsbHw9pHhFhOgriG4CAkL1GINISZK2SFz0RotfssbkMj4oymZxwywsXC4BjTTlTTz16Sd4broiOUF7OjAha+1IH4nlCK8+GjFX52mFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl288P0aFMxHvyTdajqKdYE2bhkbzZtjR6cg4VQwpEg=;
 b=J3tEjVyyqIbquBx4SaYMCgDNE+O2B/IG0rUYW/+XGnZ6Lo2gErvBeCb7Y7nQOuTd1r65KG9KZFCQ6UBZ8FqV8Du3TXQUhilJ0RfH3QXWS2Ifi5miK4v9tW7UhB2gWhs8j+es2W7K7VrDM9OWW77/cOl4KvI1VnapwXT4gj4vHmw=
Received: from DM5PR17CA0062.namprd17.prod.outlook.com (2603:10b6:3:13f::24)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 19:07:25 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::57) by DM5PR17CA0062.outlook.office365.com
 (2603:10b6:3:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23 via Frontend
 Transport; Tue, 24 May 2022 19:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 19:07:25 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 24 May
 2022 14:07:21 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v3 06/13] drm/amdkfd: add SPM support for SVM
Date:   Tue, 24 May 2022 14:06:25 -0500
Message-ID: <20220524190632.3304-7-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220524190632.3304-1-alex.sierra@amd.com>
References: <20220524190632.3304-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 718ec335-643c-4a56-615b-08da3db8a3ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB359615F00ABA8B3842D11BB4FDD79@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qc8n8htpyi4Yzd39kp1Nl9mZrm2fZZ55Tm1YITTwdE3Xg+gtiuxAvUZrxsHXIgGMZfYlxrgWt3t+fiIRWvUQi6635q4O3XcUC0ueQzsLJkpFuhT/owUDV8lFYiMZdI5LQydJMFqjZqgHFjTn5mN7wePRd2rWhUBqMoWXHbVazjDZ8a0/gSbMgnATIIKRZ0KySnrwZt8TLnGvgQk/Jxjrx+ugkZ6ohZgiK0ohtvOiKjNJ+r4+lrd/StJvrx+KSCOy5V/4U5WH/1fhLz/wLZYBZ/yy8hyPcfpXHMYj4b5mU22EhyJf0s/0s3T1Yqvqfx/LlP0EPBAHMVIclr36IQAptqaXKTj8SBCnwdyfAaSbW8gdNRpVefoPbFyfTfQrh47QGCbYVhtLNefG2uJSa0RuTGfnAaG5QUL/btsXflo0P2J/J3I5vncIQXbsjehPzuoqeraj84CpwKmYpF9/4GtnnrgTvlPSa/Lk3sHXk25MmqoU+KKvGcICB9Dvh+9jdBr0ASj+a+mZz9YofFK52Ui0Hs56al5uGgbx0bzIgXUokyttIKcKms4hkrOffDnKdpc50YaxdkJQfNz2n22Mlxr4ZpcWcjqGes505L9+pELRSIewgVNCMH/26puApPzpyIckcpGDGAsZLqudHgJ0l/tsO2Wd/CuOmwDsxXq18/rEhB8cenpZd17KGKY4PsCFfsDtB9CqpFM9O2MaN25SdGLNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(54906003)(6916009)(8936002)(44832011)(36756003)(508600001)(4326008)(2906002)(40460700003)(86362001)(7416002)(70586007)(70206006)(81166007)(356005)(5660300002)(8676002)(83380400001)(36860700001)(426003)(82310400005)(16526019)(316002)(47076005)(186003)(1076003)(26005)(336012)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 19:07:25.4512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 718ec335-643c-4a56-615b-08da3db8a3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
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
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 33 +++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7e3a7fcb9fe6..25c9f7a4325d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -673,9 +673,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 	migrate.vma = vma;
 	migrate.start = start;
 	migrate.end = end;
-	migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	migrate.pgmap_owner = SVM_ADEV_PGMAP_OWNER(adev);
 
+	if (adev->gmc.xgmi.connected_to_cpu)
+		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_COHERENT;
+	else
+		migrate.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
 	size = 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_addr_t);
 	size *= npages;
 	buf = kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
@@ -948,7 +951,7 @@ int svm_migrate_init(struct amdgpu_device *adev)
 {
 	struct kfd_dev *kfddev = adev->kfd.dev;
 	struct dev_pagemap *pgmap;
-	struct resource *res;
+	struct resource *res = NULL;
 	unsigned long size;
 	void *r;
 
@@ -963,28 +966,34 @@ int svm_migrate_init(struct amdgpu_device *adev)
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

