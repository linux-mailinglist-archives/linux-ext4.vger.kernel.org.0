Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4D539797
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiEaUBV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 May 2022 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347627AbiEaUBE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 May 2022 16:01:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDB062A35;
        Tue, 31 May 2022 13:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGYxjqww3Af6QRnnF8a8NbhDnLICVTnpf62UlP1U26ucGCtcbSDO4r9LlF60epe/LXnIF9xlwYdx3mcfOCu5LvES3GE1t0CBArLx+51V49p34Cg9iYSSG0Lya/FjPbMrjOqbJWVVKbZIN0sVj4a6iUCLMDHaCpI1S5UPdNUtuHAlGmRHrCRX31vAoCYztPv7WarrSyo8//FS8rPi16Asvr7GwvPMhSG2F/BhvmIfsM4YnnR3OhJjRuXNNcTW/NyxVTsFy7qKHQ7dNCVyEvt5KwprMcJak/wv3kGIPeCo2ydMUBnP1wN/LbRujjymREezoHWWoVzTp8Bb2Y2y/OhFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/au3voUTSWe7TnDakyMc0huLOQFLzS/24zd0f/lP6w=;
 b=R3Y8HtaA3QQ9alvVijrL4ETidw5E3LS72DGtaxoyDGelFNKwX2tqnmgB33rdvPrY0y3Tu9TtlK0XMOl1/PwErOfmtM9YNwYsPPlSi8uFhscfz2/XM1MTHrQ3eH48QngyEh7Ln0+TMhlOriBxChpOZfzxllufj+CJ7hsF1nRu44rw3mQypdxn03PXhD5YGom3pM02o/2NSXmE8zvzH4M3QvhfvHgiVSuDsA9/ng1wt9Zhz1MeauyGI0tdHUtHQ6MQXui9hI/5OINq1+3hvX5hmJE2OvTNDXQOjpJ6uqqnrsRQ/1DoUUfFJD+0SJ7N3MdEqkJfdkSadoOsNpxGRoI4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/au3voUTSWe7TnDakyMc0huLOQFLzS/24zd0f/lP6w=;
 b=e5VZOrr9gVj9og8yUcFi3XOk8MoqVwP8ouGC9Dklryn5ZkvpSaqCC0NNugvvkuLGKu2sdSWl6zSGVnWcU4vwUxMtAWlRpLmA3R/1YT/4V7Ch4a2vQ7QFhVkK08zsQ4lcz0iB4ls/WCqqkxM4+b1nuAr3XclWs428D+v5gijRus8=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by BN6PR12MB1763.namprd12.prod.outlook.com (2603:10b6:404:107::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 20:00:58 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::6) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 20:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 20:00:58 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 15:00:57 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v5 05/13] mm/gup: migrate device coherent pages when pinning instead of failing
Date:   Tue, 31 May 2022 15:00:33 -0500
Message-ID: <20220531200041.24904-6-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f01b947-fcf1-4701-4d5c-08da434047b5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1763:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1763F341A312BC17E47A7850FDDC9@BN6PR12MB1763.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+2zy3jZtp83D0N9selg3aAG/N0Ph/MD9B5qOgCmFQlYn5yrrRwUieH/7yB9IrVjl5N6L+rWMFAVr2oA793etJb5RvpdvTeqw1pxbuce1QdWS6FMTKHNb68dep1JqC/hNP4iqaAsA1960McfXJR1915D6hpViNa9HcdfncUyoOQhjWL/JAngdnC2VYs8pGlIEyTIe1evwdVG7KMPT/GSpvFfBoHMc5CNESQIXuBMzhvFv8AKJhCTAgzavvoRFtNoQxKZL0hnu8SRFjWXVJhSn6t5FN2bzHljV8Z3GvQVJ/DGFlI8LO+bbjJVJuzHN55d/wVvxZJmaJ3acsri5cwgWroUK8ogN+xmTj7fqpoyaYso48JmOh7RCEYYjhNbi0GK4w2aaoz6ufyXKpreKZifS6C+scfY/GwkhWv9mR9Poi7ll7macMVLEn8bn90g+2n6JkWOxwNDq0T7ThI9RRKe1XBq7PJRfScmg6MBl9jpOhfIP8kxaeM1XKZDStvwzcqBNs74Bj150KxSdHvxlQEnGYuY54o8DQvtFJoMNYxBCXqCrHV6XnUb4hkKjpRiX3scxdJIzRPQtmdTfhlQHB11MglUrKbeAq3SgM8afIrnR0+oy8iOxLdivHJ1lnYHwj426aGcWdu2G7gCneYTsF7UuaMPlzC8tSGZPVgi4P8MswSKSJn1wmSWUpjWajL6rTKS2hi9xl7VzwE7vCXRB27Kaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(4326008)(316002)(36860700001)(40460700003)(8676002)(83380400001)(508600001)(7696005)(8936002)(6916009)(26005)(44832011)(5660300002)(7416002)(356005)(70206006)(6666004)(70586007)(54906003)(86362001)(36756003)(81166007)(426003)(82310400005)(1076003)(336012)(186003)(47076005)(2616005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 20:00:58.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f01b947-fcf1-4701-4d5c-08da434047b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1763
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

Currently any attempts to pin a device coherent page will fail. This is
because device coherent pages need to be managed by a device driver, and
pinning them would prevent a driver from migrating them off the device.

However this is no reason to fail pinning of these pages. These are
coherent and accessible from the CPU so can be migrated just like
pinning ZONE_MOVABLE pages. So instead of failing all attempts to pin
them first try migrating them out of ZONE_DEVICE.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
[hch: rebased to the split device memory checks,
      moved migrate_device_page to migrate_device.c]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c            | 47 +++++++++++++++++++++++++++++++++++-----
 mm/internal.h       |  1 +
 mm/migrate_device.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 48b45bcc8501..e6093c31f932 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1895,9 +1895,43 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			continue;
 		prev_folio = folio;
 
-		if (folio_is_pinnable(folio))
+		/*
+		 * Device private pages will get faulted in during gup so it
+		 * shouldn't be possible to see one here.
+		 */
+		if (WARN_ON_ONCE(folio_is_device_private(folio))) {
+			ret = -EFAULT;
+			goto unpin_pages;
+		}
+
+		/*
+		 * Device coherent pages are managed by a driver and should not
+		 * be pinned indefinitely as it prevents the driver moving the
+		 * page. So when trying to pin with FOLL_LONGTERM instead try
+		 * to migrate the page out of device memory.
+		 */
+		if (folio_is_device_coherent(folio)) {
+			WARN_ON_ONCE(PageCompound(&folio->page));
+
+			/*
+			 * Migration will fail if the page is pinned, so convert
+			 * the pin on the source page to a normal reference.
+			 */
+			if (gup_flags & FOLL_PIN) {
+				get_page(&folio->page);
+				unpin_user_page(&folio->page);
+			}
+
+			pages[i] = migrate_device_page(&folio->page, gup_flags);
+			if (!pages[i]) {
+				ret = -EBUSY;
+				goto unpin_pages;
+			}
 			continue;
+		}
 
+		if (folio_is_pinnable(folio))
+			continue;
 		/*
 		 * Try to move out any movable page before pinning the range.
 		 */
@@ -1933,10 +1967,13 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	return nr_pages;
 
 unpin_pages:
-	if (gup_flags & FOLL_PIN) {
-		unpin_user_pages(pages, nr_pages);
-	} else {
-		for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_pages; i++) {
+		if (!pages[i])
+			continue;
+
+		if (gup_flags & FOLL_PIN)
+			unpin_user_page(pages[i]);
+		else
 			put_page(pages[i]);
 	}
 
diff --git a/mm/internal.h b/mm/internal.h
index c0f8fbe0445b..eeab4ee7a4a3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -853,6 +853,7 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
 void free_zone_device_page(struct page *page);
+struct page *migrate_device_page(struct page *page, unsigned int gup_flags);
 
 /*
  * mm/gup.c
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index cf9668376c5a..5decd26dd551 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -794,3 +794,56 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 	}
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
+
+/*
+ * Migrate a device coherent page back to normal memory.  The caller should have
+ * a reference on page which will be copied to the new page if migration is
+ * successful or dropped on failure.
+ */
+struct page *migrate_device_page(struct page *page, unsigned int gup_flags)
+{
+	unsigned long src_pfn, dst_pfn = 0;
+	struct migrate_vma args;
+	struct page *dpage;
+
+	lock_page(page);
+	src_pfn = migrate_pfn(page_to_pfn(page)) | MIGRATE_PFN_MIGRATE;
+	args.src = &src_pfn;
+	args.dst = &dst_pfn;
+	args.cpages = 1;
+	args.npages = 1;
+	args.vma = NULL;
+	migrate_vma_setup(&args);
+	if (!(src_pfn & MIGRATE_PFN_MIGRATE))
+		return NULL;
+
+	dpage = alloc_pages(GFP_USER | __GFP_NOWARN, 0);
+
+	/*
+	 * get/pin the new page now so we don't have to retry gup after
+	 * migrating. We already have a reference so this should never fail.
+	 */
+	if (dpage && WARN_ON_ONCE(!try_grab_page(dpage, gup_flags))) {
+		__free_pages(dpage, 0);
+		dpage = NULL;
+	}
+
+	if (dpage) {
+		lock_page(dpage);
+		dst_pfn = migrate_pfn(page_to_pfn(dpage));
+	}
+
+	migrate_vma_pages(&args);
+	if (src_pfn & MIGRATE_PFN_MIGRATE)
+		copy_highpage(dpage, page);
+	migrate_vma_finalize(&args);
+	if (dpage && !(src_pfn & MIGRATE_PFN_MIGRATE)) {
+		if (gup_flags & FOLL_PIN)
+			unpin_user_page(dpage);
+		else
+			put_page(dpage);
+		dpage = NULL;
+	}
+
+	return dpage;
+}
-- 
2.32.0

