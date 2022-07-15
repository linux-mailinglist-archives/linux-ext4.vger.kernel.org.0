Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276ED57641B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiGOPFt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 11:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiGOPFo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 11:05:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FFC2B275;
        Fri, 15 Jul 2022 08:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnJazViVN56ZOkUqnSuEXD9gwN+w81Ty8NZH+sAE/ccZDECAefhh3UAbFH19CNwA7xP6zXFcdPLZX7MxhEzHw1gavXIAKQU5SIUc+OSmlpmLgmMrAiwLgRHSHqKsyzLLl2eBBc30Xs3yws48+16v1h2JU7xbi4UGkrtg5MwMQLmiQDbIw4qp3ssiWqg6FG6DMeBDLvSg1rYnJ2794qKS3vMWDHPj9+l/3z2BuTdrLSWrVyDGlWIsbzmFd3nIAlD6hkVQD1iSXATJ+DmgyebvByzZV+S+uNa0H8L3clndLflIzF2Lx8c7Nt1UqjvRbBtWf9DZBLiuqFnMoCzMrk3/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7KEXeC3QAbxMHsFgSJMAkiGsYbORg+uuhIqq3gFxLw=;
 b=bVacYqAOjfA1kqRUMJelMW3ligbJ0tKfVw3H5YwrXOy6k/4gNiCXXmmLYMFeiy1xSOElIZBZFX38FUnPds/4nYhDb9K0ub/ayqaVoqjwVje5cyJIIU73Zm3Xcjd4JwFGgsG2fLPIO82J9b81RtTkEiJ5CXB1+dSDEIiqbZ8i9hspRFNURV6joiUOk5DQYFjUXbBka2v7bAoblewQKnMfkqn5C7YfehM4lrfs+cnEY9cjoID3gWpcU14XrXrTpwj/Z3VrBWVsmW9J2O7mlMtgKzAXM0fX49j3lbf3SHiY64is9QmGxMHmq+2BJGUqNAVR4NtCvK8t4yf1RF157GZCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7KEXeC3QAbxMHsFgSJMAkiGsYbORg+uuhIqq3gFxLw=;
 b=dIVHMHp9OsVT5zMszZRkW/bLenbuSJzSKS2BTsyZYF9tBz+i68QnICDgPB0zEjyMnWgrYVdwpOt4j8alaQOgIqVhbhSQStSIn40wP2779orWB6UwHIW5pYKzMDK5k8LAZDFacY/1Js+Ywmun+wXQPrlhmBP1LtDPIqGmsKq2o7w=
Received: from DS7P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::24) by
 BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.13; Fri, 15 Jul 2022 15:05:40 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::d2) by DS7P222CA0007.outlook.office365.com
 (2603:10b6:8:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 15:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 15:05:40 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 10:05:38 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v9 04/14] mm: handling Non-LRU pages returned by vm_normal_pages
Date:   Fri, 15 Jul 2022 10:05:11 -0500
Message-ID: <20220715150521.18165-5-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 82e6a23a-a628-48a8-fc5b-08da66737b63
X-MS-TrafficTypeDiagnostic: BY5PR12MB4917:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xp2CKpQqeLZ1f9qKLjVA9Kg7NSxFK//yA3R7GSskPREVVRNaxe0nrgJDtw+s14kSwhzG0BKQ5fc6KilK2R2IjeSPpyv/ibMLHbAcHtcWfTvCzGdFrchgOC7mr9wtDtC1GJERRsa3fU4IM/H1lUQ4gWPOGp0kP4LpTHMhR01d3x8w5hKtTg6ipN5FKlzPqhOlLu0HQfEBylmcQmkZwngcS4EQWCuJ/Jitim5z4CgjrVnTMhrp78TqpS+YGKZ/bdTvAqk+i73CTP65WgesrcUYAjS1grxRLYvgZKvzqLdgj+zW+fP2msAwNpwGeWPQTPDUA0uPH2BPnoqduEtAeUWXCxf0cC7UT5wSVJoQnSgvwU7bhrGTMxJTwEf3vxqt1eN9oCa2Q3Ah5ZeaT47rPOdZSwcglcwfAB5acjIJ1CEEUWjTv9PqHqonpw0jPdc3Swsem2hVZ8jnlCkVt706hrRY8egx04pVDkNQRwN0Ih75+crMrKA2lFXVFScE1NfR9RUibH09bkdxUCFeFhRi9FAa889uXUdWI6WPUbnCd0dADugg7sD5a7Eex5PE9WMYg5hZbvG8daVM2WdCBXqEq3H36SqloOi1cgGzG0AnWe1XRYz97u9E1RD2hdLTuISjqo3chRrfPJxJac9zJT/XAelELFpocBcpNOcpx2IL+ui7Hxh8cpqvIE6bcJ7FOaJ6JVFjSZYz6W8x8rKJzfmliEjnHSRx9ZvKSsTIqT2Zi63F1F06Ru1xO37xhHbhGE67M0RvjFZuAT+hHeOfJBnU/70iaMqK9OHH7g97hcaEqqM3Glr88SAbfGWkaAWAw18SrGIIHASjhMI7I1p/i8eslkCMJfp2Tda/Yqz6I8d4h8YwIjs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(82310400005)(2616005)(6916009)(54906003)(316002)(86362001)(36860700001)(7696005)(26005)(36756003)(16526019)(186003)(40460700003)(1076003)(47076005)(426003)(336012)(81166007)(41300700001)(4326008)(7416002)(6666004)(70206006)(70586007)(2906002)(8676002)(82740400003)(44832011)(83380400001)(356005)(8936002)(5660300002)(478600001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 15:05:40.2675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e6a23a-a628-48a8-fc5b-08da66737b63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
device-managed anonymous pages that are not LRU pages. Although they
behave like normal pages for purposes of mapping in CPU page, and for
COW. They do not support LRU lists, NUMA migration or THP.

Callers to follow_page() currently don't expect ZONE_DEVICE pages,
however, with DEVICE_COHERENT we might now return ZONE_DEVICE. Check
for ZONE_DEVICE pages in applicable users of follow_page() as well.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com> (v2)
Reviewed-by: Alistair Popple <apopple@nvidia.com> (v6)
---
 fs/proc/task_mmu.c |  2 +-
 mm/huge_memory.c   |  2 +-
 mm/khugepaged.c    |  9 ++++++---
 mm/ksm.c           |  6 +++---
 mm/madvise.c       |  4 ++--
 mm/memory.c        | 10 +++++++++-
 mm/mempolicy.c     |  2 +-
 mm/migrate.c       |  4 ++--
 mm/mlock.c         |  2 +-
 mm/mprotect.c      |  2 +-
 10 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2d04e3470d4c..2dd8c8a66924 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1792,7 +1792,7 @@ static struct page *can_gather_numa_stats(pte_t pte, struct vm_area_struct *vma,
 		return NULL;
 
 	page = vm_normal_page(vma, addr, pte);
-	if (!page)
+	if (!page || is_zone_device_page(page))
 		return NULL;
 
 	if (PageReserved(page))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 834f288b3769..c47e95b02244 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2910,7 +2910,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 
 		if (IS_ERR(page))
 			continue;
-		if (!page)
+		if (!page || is_zone_device_page(page))
 			continue;
 
 		if (!is_transparent_hugepage(page))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 16be62d493cd..671ac7800e53 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -618,7 +618,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 			goto out;
 		}
 		page = vm_normal_page(vma, address, pteval);
-		if (unlikely(!page)) {
+		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out;
 		}
@@ -1267,7 +1267,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 			writable = true;
 
 		page = vm_normal_page(vma, _address, pteval);
-		if (unlikely(!page)) {
+		if (unlikely(!page) || unlikely(is_zone_device_page(page))) {
 			result = SCAN_PAGE_NULL;
 			goto out_unmap;
 		}
@@ -1479,7 +1479,8 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 			goto abort;
 
 		page = vm_normal_page(vma, addr, *pte);
-
+		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
+			page = NULL;
 		/*
 		 * Note that uprobe, debugger, or MAP_PRIVATE may change the
 		 * page table, but the new page will not be a subpage of hpage.
@@ -1497,6 +1498,8 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 		if (pte_none(*pte))
 			continue;
 		page = vm_normal_page(vma, addr, *pte);
+		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
+			goto abort;
 		page_remove_rmap(page, vma, false);
 	}
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 54f78c9eecae..831b18a7a50b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -475,7 +475,7 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 		cond_resched();
 		page = follow_page(vma, addr,
 				FOLL_GET | FOLL_MIGRATION | FOLL_REMOTE);
-		if (IS_ERR_OR_NULL(page))
+		if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
 			break;
 		if (PageKsm(page))
 			ret = handle_mm_fault(vma, addr,
@@ -560,7 +560,7 @@ static struct page *get_mergeable_page(struct rmap_item *rmap_item)
 		goto out;
 
 	page = follow_page(vma, addr, FOLL_GET);
-	if (IS_ERR_OR_NULL(page))
+	if (IS_ERR_OR_NULL(page) || is_zone_device_page(page))
 		goto out;
 	if (PageAnon(page)) {
 		flush_anon_page(vma, page, addr);
@@ -2308,7 +2308,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 			if (ksm_test_exit(mm))
 				break;
 			*page = follow_page(vma, ksm_scan.address, FOLL_GET);
-			if (IS_ERR_OR_NULL(*page)) {
+			if (IS_ERR_OR_NULL(*page) || is_zone_device_page(*page)) {
 				ksm_scan.address += PAGE_SIZE;
 				cond_resched();
 				continue;
diff --git a/mm/madvise.c b/mm/madvise.c
index 0316bbc6441b..e252635fe935 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -421,7 +421,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		page = vm_normal_page(vma, addr, ptent);
-		if (!page)
+		if (!page || is_zone_device_page(page))
 			continue;
 
 		/*
@@ -639,7 +639,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 
 		page = vm_normal_page(vma, addr, ptent);
-		if (!page)
+		if (!page || is_zone_device_page(page))
 			continue;
 
 		/*
diff --git a/mm/memory.c b/mm/memory.c
index 4cf7d4b6c950..e939cc851a0e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -624,6 +624,14 @@ struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 		if (is_zero_pfn(pfn))
 			return NULL;
 		if (pte_devmap(pte))
+		/*
+		 * NOTE: New users of ZONE_DEVICE will not set pte_devmap()
+		 * and will have refcounts incremented on their struct pages
+		 * when they are inserted into PTEs, thus they are safe to
+		 * return here. Legacy ZONE_DEVICE pages that set pte_devmap()
+		 * do not have refcounts. Example of legacy ZONE_DEVICE is
+		 * MEMORY_DEVICE_FS_DAX type in pmem or virtio_fs drivers.
+		 */
 			return NULL;
 
 		print_bad_pte(vma, addr, pte, NULL);
@@ -4693,7 +4701,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 
 	page = vm_normal_page(vma, vmf->address, pte);
-	if (!page)
+	if (!page || is_zone_device_page(page))
 		goto out_map;
 
 	/* TODO: handle PTE-mapped THP */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..abc26890fc95 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -523,7 +523,7 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pte_present(*pte))
 			continue;
 		page = vm_normal_page(vma, addr, *pte);
-		if (!page)
+		if (!page || is_zone_device_page(page))
 			continue;
 		/*
 		 * vm_normal_page() filters out zero pages, but there might
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c1ea61f39d8..a98a219d12ab 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1620,7 +1620,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 		goto out;
 
 	err = -ENOENT;
-	if (!page)
+	if (!page || is_zone_device_page(page))
 		goto out;
 
 	err = 0;
@@ -1810,7 +1810,7 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 		if (IS_ERR(page))
 			goto set_status;
 
-		if (page) {
+		if (page && !is_zone_device_page(page)) {
 			err = page_to_nid(page);
 			put_page(page);
 		} else {
diff --git a/mm/mlock.c b/mm/mlock.c
index 716caf851043..b14e929084cc 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -333,7 +333,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (!pte_present(*pte))
 			continue;
 		page = vm_normal_page(vma, addr, *pte);
-		if (!page)
+		if (!page || is_zone_device_page(page))
 			continue;
 		if (PageTransCompound(page))
 			continue;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..e034aae2a98b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -95,7 +95,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 					continue;
 
 				page = vm_normal_page(vma, addr, oldpte);
-				if (!page || PageKsm(page))
+				if (!page || is_zone_device_page(page) || PageKsm(page))
 					continue;
 
 				/* Also skip shared copy-on-write pages */
-- 
2.32.0

