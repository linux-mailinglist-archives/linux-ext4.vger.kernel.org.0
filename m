Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204A151CB3A
	for <lists+linux-ext4@lfdr.de>; Thu,  5 May 2022 23:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385937AbiEEVjQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 May 2022 17:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385946AbiEEViu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 May 2022 17:38:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DD5DE5C;
        Thu,  5 May 2022 14:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9+AMwWAToWMcjP6AZ6ZlY1rlBE6bdzmQWRMWi/NnsqnYMj/tE+Q3mX4aNiNB4YAREEc315kzNvXRNFFwciTkWSOiWU22py/RuNXVZFA9q6JACnxZr8Sj+4BkD7FFQ8NTSu5yfYRy3VEF33TXO4cJdG/xiAS0TblXJpZ5kJ7toIRsO+snZ4b6uZf21Us26bwnxkBhpSX0hPXnwPQ70C8nWqsgVASpGTZHB4rOtfHXj1TWtgP6N6VvEdKIw11R814y2qaT5r5UTdrjZ8kupGntGW/arKZPTM5GZtlD8RiDBdrs8EFC/BUKUN7H4djRCYsdY59PmFxoK9W5DrQWXtd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NnrGS6YZU8gQt+7tgfyVxU1Jq6fVp8xiHVCSF24jGU=;
 b=JKNnxmnzkuU/GUrsSnG0KtTaZYoPAjXP7XpCXoXz2cmjgs+3UheG9LQ/yS/tjrF92jn8QFJ00dRRizwO3Pq7L/CZdImMXTMtF7wOEfE6I8XcBhziB5BWzjHCcJSKZizYx169z+JhAq3t7Qeq3ECkDU8G+wT74mNiCzJsxaG5GZFLELgCf7RFNGBDo0V/I25IMCug2H+dirj4uV+pkv91A/UjJKeIOE6sDYlC4nCFoPZ2DsDveOKI1ERZ95DvvANoXqajQ63H/9Pq9iVcX+HmfpMkWtG2NRdLYGCEhwA6qq6WSJf6wtBvsk7cCiQkNHnY7ZUxVjvteVo5VSzVzdrNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NnrGS6YZU8gQt+7tgfyVxU1Jq6fVp8xiHVCSF24jGU=;
 b=VO+lVdaj+5PbpNO4Y0gmLcLfBBKTXq1/hKenuH6yf39w+COenk9SYAe7t8+d9Ce4nBXi/bYQc7qS8L+uqu/+YED5DbTcBLY0SFL6PtSx35v/1ss4EkmG7grNWcIatX8OgW5pDSmcoLQBZaa1MDlmnE7obXCGZbR0/FVE8HSpJpg=
Received: from MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::15)
 by PH7PR12MB5687.namprd12.prod.outlook.com (2603:10b6:510:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 21:35:03 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::87) by MW4P220CA0010.outlook.office365.com
 (2603:10b6:303:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 21:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 21:35:03 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 16:35:01 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v1 10/15] lib: add support for device coherent type in test_hmm
Date:   Thu, 5 May 2022 16:34:33 -0500
Message-ID: <20220505213438.25064-11-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505213438.25064-1-alex.sierra@amd.com>
References: <20220505213438.25064-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 612d8f0c-bc0d-4682-4160-08da2edf1dc1
X-MS-TrafficTypeDiagnostic: PH7PR12MB5687:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB568778759780CBDA24189040FDC29@PH7PR12MB5687.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XcExLZbRUOfrR0jdyCweutb7C4/Qhj0f5G17/TO3lYQ34Oclt9D78GZw7jjAMDR1ftyvGDPpWRWa8nEx4aVPfmTb6BVLOmKB66dczcbUs44dXcNZMPSO7Ul3hTjVYpNuPddbGVHPAiSm3LJYnb2L4UCtu7phfDq4Z8k//ENEsUDN9aG54MpsbY0gTDSg5wU0FMqwnI1M4hXdxFj89E3ebLzB6TfwEXopecje/ASV68hJxAz0vZfAyZuthOLg/4qDYleKwJc9XqiRXFt+7Yc4ekzx0QgqE/Kh89V/mS8VqRitOqmeCr6dYsSvCuXowm1uL/K8UzXkRHIFTxABjNml5YwZhDlKPpfSwEB94Zy/q+Vi79cCVQZBvIlcCcD84f0WcsgvyTN5+bSFf9BvRkRIF5Ug4ijiP05BLrNdgquZdyEwlY+6dEeMePNdVYAYlOSZZn2pZ2eOeWyYPy5ZAMOFiwrxI6ca/ZZnP8JbxCnS4pgHgJWyv3VTCYtS34kMZftol4k2UPTdij1kwUxGT1JKOyz9f5yht6kDY1rthAAIMO52IV4Ls7sKMv0rEh7NTijGbmKvbRPIJEgvTj8lcfvycyYc4NlypN/9IVdR7hSXCx2MahsjWaYQdI+TBE+pRP5ct06JjJ0+64uBMveMyfnHkVaj6+gJS4YvbhVcOC0K4IssqqYiHhNLAMFsEbE2kWiMPDsP8wHfjF4qVAB1ECPJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(6666004)(8676002)(16526019)(4326008)(30864003)(186003)(86362001)(508600001)(8936002)(70586007)(44832011)(70206006)(7696005)(426003)(5660300002)(7416002)(336012)(47076005)(82310400005)(81166007)(83380400001)(54906003)(6916009)(40460700003)(356005)(1076003)(2616005)(26005)(316002)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 21:35:03.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 612d8f0c-bc0d-4682-4160-08da2edf1dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Device Coherent type uses device memory that is coherently accesible by
the CPU. This could be shown as SP (special purpose) memory range
at the BIOS-e820 memory enumeration. If no SP memory is supported in
system, this could be faked by setting CONFIG_EFI_FAKE_MEMMAP.

Currently, test_hmm only supports two different SP ranges of at least
256MB size. This could be specified in the kernel parameter variable
efi_fake_mem. Ex. Two SP ranges of 1GB starting at 0x100000000 &
0x140000000 physical address. Ex.
efi_fake_mem=1G@0x100000000:0x40000,1G@0x140000000:0x40000

Private and coherent device mirror instances can be created in the same
probed. This is done by passing the module parameters spm_addr_dev0 &
spm_addr_dev1. In this case, it will create four instances of
device_mirror. The first two correspond to private device type, the
last two to coherent type. Then, they can be easily accessed from user
space through /dev/hmm_mirror<num_device>. Usually num_device 0 and 1
are for private, and 2 and 3 for coherent types. If no module
parameters are passed, two instances of private type device_mirror will
be created only.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Alistair Poppple <apopple@nvidia.com>
---
 lib/test_hmm.c      | 253 +++++++++++++++++++++++++++++++++-----------
 lib/test_hmm_uapi.h |  15 ++-
 2 files changed, 202 insertions(+), 66 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 15747f70c5bc..361a026c5d21 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -32,11 +32,22 @@
 
 #include "test_hmm_uapi.h"
 
-#define DMIRROR_NDEVICES		2
+#define DMIRROR_NDEVICES		4
 #define DMIRROR_RANGE_FAULT_TIMEOUT	1000
 #define DEVMEM_CHUNK_SIZE		(256 * 1024 * 1024U)
 #define DEVMEM_CHUNKS_RESERVE		16
 
+/*
+ * For device_private pages, dpage is just a dummy struct page
+ * representing a piece of device memory. dmirror_devmem_alloc_page
+ * allocates a real system memory page as backing storage to fake a
+ * real device. zone_device_data points to that backing page. But
+ * for device_coherent memory, the struct page represents real
+ * physical CPU-accessible memory that we can use directly.
+ */
+#define BACKING_PAGE(page) (is_device_private_page((page)) ? \
+			   (page)->zone_device_data : (page))
+
 static unsigned long spm_addr_dev0;
 module_param(spm_addr_dev0, long, 0644);
 MODULE_PARM_DESC(spm_addr_dev0,
@@ -125,6 +136,21 @@ static int dmirror_bounce_init(struct dmirror_bounce *bounce,
 	return 0;
 }
 
+static bool dmirror_is_private_zone(struct dmirror_device *mdevice)
+{
+	return (mdevice->zone_device_type ==
+		HMM_DMIRROR_MEMORY_DEVICE_PRIVATE) ? true : false;
+}
+
+static enum migrate_vma_direction
+dmirror_select_device(struct dmirror *dmirror)
+{
+	return (dmirror->mdevice->zone_device_type ==
+		HMM_DMIRROR_MEMORY_DEVICE_PRIVATE) ?
+		MIGRATE_VMA_SELECT_DEVICE_PRIVATE :
+		MIGRATE_VMA_SELECT_DEVICE_COHERENT;
+}
+
 static void dmirror_bounce_fini(struct dmirror_bounce *bounce)
 {
 	vfree(bounce->ptr);
@@ -575,16 +601,19 @@ static int dmirror_allocate_chunk(struct dmirror_device *mdevice,
 static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mdevice)
 {
 	struct page *dpage = NULL;
-	struct page *rpage;
+	struct page *rpage = NULL;
 
 	/*
-	 * This is a fake device so we alloc real system memory to store
-	 * our device memory.
+	 * For ZONE_DEVICE private type, this is a fake device so we allocate
+	 * real system memory to store our device memory.
+	 * For ZONE_DEVICE coherent type we use the actual dpage to store the
+	 * data and ignore rpage.
 	 */
-	rpage = alloc_page(GFP_HIGHUSER);
-	if (!rpage)
-		return NULL;
-
+	if (dmirror_is_private_zone(mdevice)) {
+		rpage = alloc_page(GFP_HIGHUSER);
+		if (!rpage)
+			return NULL;
+	}
 	spin_lock(&mdevice->lock);
 
 	if (mdevice->free_pages) {
@@ -603,7 +632,8 @@ static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mdevice)
 	return dpage;
 
 error:
-	__free_page(rpage);
+	if (rpage)
+		__free_page(rpage);
 	return NULL;
 }
 
@@ -629,12 +659,16 @@ static void dmirror_migrate_alloc_and_copy(struct migrate_vma *args,
 		 * unallocated pte_none() or read-only zero page.
 		 */
 		spage = migrate_pfn_to_page(*src);
+		if (WARN(spage && is_zone_device_page(spage),
+		     "page already in device spage pfn: 0x%lx\n",
+		     page_to_pfn(spage)))
+			continue;
 
 		dpage = dmirror_devmem_alloc_page(mdevice);
 		if (!dpage)
 			continue;
 
-		rpage = dpage->zone_device_data;
+		rpage = BACKING_PAGE(dpage);
 		if (spage)
 			copy_highpage(rpage, spage);
 		else
@@ -648,6 +682,8 @@ static void dmirror_migrate_alloc_and_copy(struct migrate_vma *args,
 		 */
 		rpage->zone_device_data = dmirror;
 
+		pr_debug("migrating from sys to dev pfn src: 0x%lx pfn dst: 0x%lx\n",
+			 page_to_pfn(spage), page_to_pfn(dpage));
 		*dst = migrate_pfn(page_to_pfn(dpage));
 		if ((*src & MIGRATE_PFN_WRITE) ||
 		    (!spage && args->vma->vm_flags & VM_WRITE))
@@ -725,11 +761,7 @@ static int dmirror_migrate_finalize_and_map(struct migrate_vma *args,
 		if (!dpage)
 			continue;
 
-		/*
-		 * Store the page that holds the data so the page table
-		 * doesn't have to deal with ZONE_DEVICE private pages.
-		 */
-		entry = dpage->zone_device_data;
+		entry = BACKING_PAGE(dpage);
 		if (*dst & MIGRATE_PFN_WRITE)
 			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
 		entry = xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
@@ -809,15 +841,126 @@ static int dmirror_exclusive(struct dmirror *dmirror,
 	return ret;
 }
 
-static int dmirror_migrate(struct dmirror *dmirror,
-			   struct hmm_dmirror_cmd *cmd)
+static vm_fault_t dmirror_devmem_fault_alloc_and_copy(struct migrate_vma *args,
+						      struct dmirror *dmirror)
+{
+	const unsigned long *src = args->src;
+	unsigned long *dst = args->dst;
+	unsigned long start = args->start;
+	unsigned long end = args->end;
+	unsigned long addr;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE,
+				       src++, dst++) {
+		struct page *dpage, *spage;
+
+		spage = migrate_pfn_to_page(*src);
+		if (!spage || !(*src & MIGRATE_PFN_MIGRATE))
+			continue;
+
+		if (WARN_ON(!is_device_private_page(spage) &&
+			    !is_device_coherent_page(spage)))
+			continue;
+		spage = BACKING_PAGE(spage);
+		dpage = alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
+		if (!dpage)
+			continue;
+		pr_debug("migrating from dev to sys pfn src: 0x%lx pfn dst: 0x%lx\n",
+			 page_to_pfn(spage), page_to_pfn(dpage));
+
+		lock_page(dpage);
+		xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
+		copy_highpage(dpage, spage);
+		*dst = migrate_pfn(page_to_pfn(dpage));
+		if (*src & MIGRATE_PFN_WRITE)
+			*dst |= MIGRATE_PFN_WRITE;
+	}
+	return 0;
+}
+
+static unsigned long
+dmirror_successful_migrated_pages(struct migrate_vma *migrate)
+{
+	unsigned long cpages = 0;
+	unsigned long i;
+
+	for (i = 0; i < migrate->npages; i++) {
+		if (migrate->src[i] & MIGRATE_PFN_VALID &&
+		    migrate->src[i] & MIGRATE_PFN_MIGRATE)
+			cpages++;
+	}
+	return cpages;
+}
+
+static int dmirror_migrate_to_system(struct dmirror *dmirror,
+				     struct hmm_dmirror_cmd *cmd)
 {
 	unsigned long start, end, addr;
 	unsigned long size = cmd->npages << PAGE_SHIFT;
 	struct mm_struct *mm = dmirror->notifier.mm;
 	struct vm_area_struct *vma;
-	unsigned long src_pfns[64];
-	unsigned long dst_pfns[64];
+	unsigned long src_pfns[64] = { 0 };
+	unsigned long dst_pfns[64] = { 0 };
+	struct migrate_vma args;
+	unsigned long next;
+	int ret;
+
+	start = cmd->addr;
+	end = start + size;
+	if (end < start)
+		return -EINVAL;
+
+	/* Since the mm is for the mirrored process, get a reference first. */
+	if (!mmget_not_zero(mm))
+		return -EINVAL;
+
+	cmd->cpages = 0;
+	mmap_read_lock(mm);
+	for (addr = start; addr < end; addr = next) {
+		vma = vma_lookup(mm, addr);
+		if (!vma || !(vma->vm_flags & VM_READ)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		next = min(end, addr + (ARRAY_SIZE(src_pfns) << PAGE_SHIFT));
+		if (next > vma->vm_end)
+			next = vma->vm_end;
+
+		args.vma = vma;
+		args.src = src_pfns;
+		args.dst = dst_pfns;
+		args.start = addr;
+		args.end = next;
+		args.pgmap_owner = dmirror->mdevice;
+		args.flags = dmirror_select_device(dmirror);
+
+		ret = migrate_vma_setup(&args);
+		if (ret)
+			goto out;
+
+		pr_debug("Migrating from device mem to sys mem\n");
+		dmirror_devmem_fault_alloc_and_copy(&args, dmirror);
+
+		migrate_vma_pages(&args);
+		cmd->cpages += dmirror_successful_migrated_pages(&args);
+		migrate_vma_finalize(&args);
+	}
+out:
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	return ret;
+}
+
+static int dmirror_migrate_to_device(struct dmirror *dmirror,
+				struct hmm_dmirror_cmd *cmd)
+{
+	unsigned long start, end, addr;
+	unsigned long size = cmd->npages << PAGE_SHIFT;
+	struct mm_struct *mm = dmirror->notifier.mm;
+	struct vm_area_struct *vma;
+	unsigned long src_pfns[64] = { 0 };
+	unsigned long dst_pfns[64] = { 0 };
 	struct dmirror_bounce bounce;
 	struct migrate_vma args;
 	unsigned long next;
@@ -854,6 +997,7 @@ static int dmirror_migrate(struct dmirror *dmirror,
 		if (ret)
 			goto out;
 
+		pr_debug("Migrating from sys mem to device mem\n");
 		dmirror_migrate_alloc_and_copy(&args, dmirror);
 		migrate_vma_pages(&args);
 		dmirror_migrate_finalize_and_map(&args, dmirror);
@@ -862,7 +1006,10 @@ static int dmirror_migrate(struct dmirror *dmirror,
 	mmap_read_unlock(mm);
 	mmput(mm);
 
-	/* Return the migrated data for verification. */
+	/*
+	 * Return the migrated data for verification.
+	 * Only for pages in device zone
+	 */
 	ret = dmirror_bounce_init(&bounce, start, size);
 	if (ret)
 		return ret;
@@ -905,6 +1052,12 @@ static void dmirror_mkentry(struct dmirror *dmirror, struct hmm_range *range,
 			*perm = HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL;
 		else
 			*perm = HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE;
+	} else if (is_device_coherent_page(page)) {
+		/* Is the page migrated to this device or some other? */
+		if (dmirror->mdevice == dmirror_page_to_device(page))
+			*perm = HMM_DMIRROR_PROT_DEV_COHERENT_LOCAL;
+		else
+			*perm = HMM_DMIRROR_PROT_DEV_COHERENT_REMOTE;
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		*perm = HMM_DMIRROR_PROT_ZERO;
 	else
@@ -1101,8 +1254,12 @@ static long dmirror_fops_unlocked_ioctl(struct file *filp,
 		ret = dmirror_write(dmirror, &cmd);
 		break;
 
-	case HMM_DMIRROR_MIGRATE:
-		ret = dmirror_migrate(dmirror, &cmd);
+	case HMM_DMIRROR_MIGRATE_TO_DEV:
+		ret = dmirror_migrate_to_device(dmirror, &cmd);
+		break;
+
+	case HMM_DMIRROR_MIGRATE_TO_SYS:
+		ret = dmirror_migrate_to_system(dmirror, &cmd);
 		break;
 
 	case HMM_DMIRROR_EXCLUSIVE:
@@ -1167,14 +1324,13 @@ static const struct file_operations dmirror_fops = {
 
 static void dmirror_devmem_free(struct page *page)
 {
-	struct page *rpage = page->zone_device_data;
+	struct page *rpage = BACKING_PAGE(page);
 	struct dmirror_device *mdevice;
 
-	if (rpage)
+	if (rpage != page)
 		__free_page(rpage);
 
 	mdevice = dmirror_page_to_device(page);
-
 	spin_lock(&mdevice->lock);
 	mdevice->cfree++;
 	page->zone_device_data = mdevice->free_pages;
@@ -1182,43 +1338,11 @@ static void dmirror_devmem_free(struct page *page)
 	spin_unlock(&mdevice->lock);
 }
 
-static vm_fault_t dmirror_devmem_fault_alloc_and_copy(struct migrate_vma *args,
-						      struct dmirror *dmirror)
-{
-	const unsigned long *src = args->src;
-	unsigned long *dst = args->dst;
-	unsigned long start = args->start;
-	unsigned long end = args->end;
-	unsigned long addr;
-
-	for (addr = start; addr < end; addr += PAGE_SIZE,
-				       src++, dst++) {
-		struct page *dpage, *spage;
-
-		spage = migrate_pfn_to_page(*src);
-		if (!spage || !(*src & MIGRATE_PFN_MIGRATE))
-			continue;
-		spage = spage->zone_device_data;
-
-		dpage = alloc_page_vma(GFP_HIGHUSER_MOVABLE, args->vma, addr);
-		if (!dpage)
-			continue;
-
-		lock_page(dpage);
-		xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
-		copy_highpage(dpage, spage);
-		*dst = migrate_pfn(page_to_pfn(dpage));
-		if (*src & MIGRATE_PFN_WRITE)
-			*dst |= MIGRATE_PFN_WRITE;
-	}
-	return 0;
-}
-
 static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
 {
 	struct migrate_vma args;
-	unsigned long src_pfns;
-	unsigned long dst_pfns;
+	unsigned long src_pfns = 0;
+	unsigned long dst_pfns = 0;
 	struct page *rpage;
 	struct dmirror *dmirror;
 	vm_fault_t ret;
@@ -1238,7 +1362,7 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
 	args.src = &src_pfns;
 	args.dst = &dst_pfns;
 	args.pgmap_owner = dmirror->mdevice;
-	args.flags = MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
+	args.flags = dmirror_select_device(dmirror);
 
 	if (migrate_vma_setup(&args))
 		return VM_FAULT_SIGBUS;
@@ -1317,6 +1441,12 @@ static int __init hmm_dmirror_init(void)
 				HMM_DMIRROR_MEMORY_DEVICE_PRIVATE;
 	dmirror_devices[ndevices++].zone_device_type =
 				HMM_DMIRROR_MEMORY_DEVICE_PRIVATE;
+	if (spm_addr_dev0 && spm_addr_dev1) {
+		dmirror_devices[ndevices++].zone_device_type =
+					HMM_DMIRROR_MEMORY_DEVICE_COHERENT;
+		dmirror_devices[ndevices++].zone_device_type =
+					HMM_DMIRROR_MEMORY_DEVICE_COHERENT;
+	}
 	for (id = 0; id < ndevices; id++) {
 		ret = dmirror_device_init(dmirror_devices + id, id);
 		if (ret)
@@ -1339,7 +1469,8 @@ static void __exit hmm_dmirror_exit(void)
 	int id;
 
 	for (id = 0; id < DMIRROR_NDEVICES; id++)
-		dmirror_device_remove(dmirror_devices + id);
+		if (dmirror_devices[id].zone_device_type)
+			dmirror_device_remove(dmirror_devices + id);
 	unregister_chrdev_region(dmirror_dev, DMIRROR_NDEVICES);
 }
 
diff --git a/lib/test_hmm_uapi.h b/lib/test_hmm_uapi.h
index 625f3690d086..e190b2ab6f19 100644
--- a/lib/test_hmm_uapi.h
+++ b/lib/test_hmm_uapi.h
@@ -33,11 +33,12 @@ struct hmm_dmirror_cmd {
 /* Expose the address space of the calling process through hmm device file */
 #define HMM_DMIRROR_READ		_IOWR('H', 0x00, struct hmm_dmirror_cmd)
 #define HMM_DMIRROR_WRITE		_IOWR('H', 0x01, struct hmm_dmirror_cmd)
-#define HMM_DMIRROR_MIGRATE		_IOWR('H', 0x02, struct hmm_dmirror_cmd)
-#define HMM_DMIRROR_SNAPSHOT		_IOWR('H', 0x03, struct hmm_dmirror_cmd)
-#define HMM_DMIRROR_EXCLUSIVE		_IOWR('H', 0x04, struct hmm_dmirror_cmd)
-#define HMM_DMIRROR_CHECK_EXCLUSIVE	_IOWR('H', 0x05, struct hmm_dmirror_cmd)
-#define HMM_DMIRROR_GET_MEM_DEV_TYPE	_IOWR('H', 0x06, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_MIGRATE_TO_DEV	_IOWR('H', 0x02, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_MIGRATE_TO_SYS	_IOWR('H', 0x03, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_SNAPSHOT		_IOWR('H', 0x04, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_EXCLUSIVE		_IOWR('H', 0x05, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_CHECK_EXCLUSIVE	_IOWR('H', 0x06, struct hmm_dmirror_cmd)
+#define HMM_DMIRROR_GET_MEM_DEV_TYPE	_IOWR('H', 0x07, struct hmm_dmirror_cmd)
 
 /*
  * Values returned in hmm_dmirror_cmd.ptr for HMM_DMIRROR_SNAPSHOT.
@@ -52,6 +53,8 @@ struct hmm_dmirror_cmd {
  *					device the ioctl() is made
  * HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE: Migrated device private page on some
  *					other device
+ * HMM_DMIRROR_PROT_DEV_COHERENT: Migrate device coherent page on the device
+ *				  the ioctl() is made
  */
 enum {
 	HMM_DMIRROR_PROT_ERROR			= 0xFF,
@@ -63,6 +66,8 @@ enum {
 	HMM_DMIRROR_PROT_ZERO			= 0x10,
 	HMM_DMIRROR_PROT_DEV_PRIVATE_LOCAL	= 0x20,
 	HMM_DMIRROR_PROT_DEV_PRIVATE_REMOTE	= 0x30,
+	HMM_DMIRROR_PROT_DEV_COHERENT_LOCAL	= 0x40,
+	HMM_DMIRROR_PROT_DEV_COHERENT_REMOTE	= 0x50,
 };
 
 enum {
-- 
2.32.0

