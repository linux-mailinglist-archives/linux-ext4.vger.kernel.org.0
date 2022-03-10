Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A35A4D5083
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 18:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbiCJR2S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 12:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiCJR17 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 12:27:59 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E15A1BDD;
        Thu, 10 Mar 2022 09:26:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdNV13xn8P6SHj1yUq3vAI8ZTay3rclqFZtAju3PUBwS9kqMdvvL80Mo9wVuL1QHJ19IZ+A2G874cWU7CSTfegf5lTzfcjeNFbWrF9/iQ92Lwksiczu9noFYqfHbxi8TmgwC5XxwHeHxg5t6vpjJ8IvAmulWL1ZENAfm89ToCtkaHUt0Gj0UCrSW7WBoNhA1kmex7gnzugybdbbGU0l2BdXITiVsP6KwUKsiYkYinLrqy+RFQ4RgCiYU6RMbQ+Xc5g3ty1FhJTKkcBo7bzbtqtc+k54dWt3Fj7UgMeoxcSVhjA8dc9F9jwgcw75BAxX0bOXpzLUP371lY1nMAp7GUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHU7YhU+SJ2J7kH8Bg29HQQ9+RIQsN1DFo8UaEiYdGg=;
 b=F2EZQaDGBaGLNZLri1J0MUvtC9yXlUl/rYMh06BNbPyyDvha0qug4ZYWkHDs202mf4PlHQwWghpaExf1VZdglVzkUxF+2qeXnZm2ZpCv2AissqPwPq7vNt1Bv+pVIhEfkR1nODh0IBZkVsNpJVpPGlJ9g0abfVuMiGmNwwyN8o+DvHLfhD1z2jhFllPtQsgvequDED/0wR7tV98qrwXLnOks0poe1TUPgO0ZlFWNCZ9LKOSIkwb9x9Z1rmEzWnvAxc9aRGP/EiYXlex8f9VBMGtJFGyUaErSLAaVqUgsoi/mWs/pGlgfdQebINn0dqbWfILImZIxNfq7mAV19V6xgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHU7YhU+SJ2J7kH8Bg29HQQ9+RIQsN1DFo8UaEiYdGg=;
 b=FDgVa9nGuts7Yztb1A9ktwizeKFQD4b3o6LgUGMrlYougNpKfw+LszcXjPAXFmeYUljvzNBRbPkVCtTFYkooRsKBeqYOm04lREl3EPuKJlndzsgjkYhS5DIO3cwvk1PAnfXcgGhz03HcPnVASpeUj1rwDFzPRQ3Bj7U+HR1FQu8=
Received: from DM3PR11CA0012.namprd11.prod.outlook.com (2603:10b6:0:54::22) by
 BYAPR12MB4982.namprd12.prod.outlook.com (2603:10b6:a03:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 17:26:46 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::db) by DM3PR11CA0012.outlook.office365.com
 (2603:10b6:0:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 17:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 17:26:46 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 11:26:45 -0600
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v1 2/3] tools: add more gup configs to hmm_gup selftests
Date:   Thu, 10 Mar 2022 11:26:32 -0600
Message-ID: <20220310172633.9151-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220310172633.9151-1-alex.sierra@amd.com>
References: <20220310172633.9151-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7edfc9fe-5d1b-481a-0d46-08da02bb2733
X-MS-TrafficTypeDiagnostic: BYAPR12MB4982:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB49824EF3D611F02714CC4824FD0B9@BYAPR12MB4982.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9VHFhXQVTro1PivJPVHcG2Fhdh66kxS4HpoSgNTIv6UAmCHlgMHtX+DcFIjLpYhk0d10CIb+u/DtnqroJszg0kt2ZNrQ2u3zkqPpSM0ZaG/j/MrNJ24NssydSaSAgW6Lb8hb3OM9K7QuagLSKKDdKssHzT77exOj9RX+CqiDQguqy2WhUMpzRlKkQBlf/KrH83QOo6qpKKF5eJabmvqq9W14lBo9rOGML7xZ9guW6hV0inTngnNFEzqdH87ZGrVH1MUdr1lwGo1968tc7UdohXcQZXrGSFfpvKlq+l0qwvH5ODcur3YVMZCiTIqZ7OyewiFyCcPDpiZ6ZhJ54H00nrHtHXYCXSOK1Snwa7SHffxUB3l5RYI2BEQTjOoHVza6lNjwAyIEvMaho+6MOB08NcctafV1QBqQYWKm5ByxlqVTz3hBqYa0O7XGG3ujJ7qfZReWl1aYILwe+AdzKA5NwYZdVwj5kx9n+38kUEyBlssroD779CnM4PzxD+oQeeUYvYu+Xj8dLQpqJmrySFjFVKuz0nwDTQn7ihTmjFkLoXKHXnJnz6CBiR2suXKKVFd8JQjymqSFW2lep59t8KO6JkGVzSE0Odknwh+dVlllFnyav73V8MKfRsSkzDBqrR88CechEJdIBAvv1hICr0Zjpvy5NILHHNQ8DDyGWWAvb24x/OZ7IboV83N3sLJ3E3tZX6gjHbCPT42faL1t7r4PSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(82310400004)(81166007)(508600001)(186003)(26005)(8676002)(70206006)(16526019)(70586007)(6666004)(356005)(86362001)(44832011)(5660300002)(47076005)(7696005)(36860700001)(83380400001)(4326008)(36756003)(8936002)(316002)(6916009)(54906003)(7416002)(426003)(336012)(1076003)(2906002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 17:26:46.4737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edfc9fe-5d1b-481a-0d46-08da02bb2733
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Test device pages with get_user_pages and get_user_pages_fast.
The motivation is to test device coherent type pages in the gup and
gup fast paths, after vm_normal_pages was split into LRU and non-LRU
handled.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 tools/testing/selftests/vm/hmm-tests.c | 65 +++++++++++++++++---------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 11b83a8084fe..65e30ab6494c 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1769,6 +1769,24 @@ TEST_F(hmm, exclusive_cow)
 	hmm_buffer_free(buffer);
 }
 
+static int gup_test_exec(int gup_fd, unsigned long addr,
+			 int cmd, int npages, int size)
+{
+	struct gup_test gup = {
+		.nr_pages_per_call	= npages,
+		.addr			= addr,
+		.gup_flags		= FOLL_WRITE,
+		.size			= size,
+	};
+
+	if (ioctl(gup_fd, cmd, &gup)) {
+		perror("ioctl on error\n");
+		return errno;
+	}
+
+	return 0;
+}
+
 /*
  * Test get user device pages through gup_test. Setting PIN_LONGTERM flag.
  * This should trigger a migration back to system memory for both, private
@@ -1779,7 +1797,6 @@ TEST_F(hmm, exclusive_cow)
 TEST_F(hmm, hmm_gup_test)
 {
 	struct hmm_buffer *buffer;
-	struct gup_test gup;
 	int gup_fd;
 	unsigned long npages;
 	unsigned long size;
@@ -1792,8 +1809,7 @@ TEST_F(hmm, hmm_gup_test)
 	if (gup_fd == -1)
 		SKIP(return, "Skipping test, could not find gup_test driver");
 
-	npages = 4;
-	ASSERT_NE(npages, 0);
+	npages = 3;
 	size = npages << self->page_shift;
 
 	buffer = malloc(sizeof(*buffer));
@@ -1822,28 +1838,35 @@ TEST_F(hmm, hmm_gup_test)
 	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
 		ASSERT_EQ(ptr[i], i);
 
-	gup.nr_pages_per_call = npages;
-	gup.addr = (unsigned long)buffer->ptr;
-	gup.gup_flags = FOLL_WRITE;
-	gup.size = size;
-	/*
-	 * Calling gup_test ioctl. It will try to PIN_LONGTERM these device pages
-	 * causing a migration back to system memory for both, private and coherent
-	 * type pages.
-	 */
-	if (ioctl(gup_fd, PIN_LONGTERM_BENCHMARK, &gup)) {
-		perror("ioctl on PIN_LONGTERM_BENCHMARK\n");
-		goto out_test;
-	}
-
-	/* Take snapshot to make sure pages have been migrated to sys memory */
+	ASSERT_EQ(gup_test_exec(gup_fd,
+				(unsigned long)buffer->ptr,
+				GUP_BASIC_TEST, 1, self->page_size), 0);
+	ASSERT_EQ(gup_test_exec(gup_fd,
+				(unsigned long)buffer->ptr + 1 * self->page_size,
+				GUP_FAST_BENCHMARK, 1, self->page_size), 0);
+	ASSERT_EQ(gup_test_exec(gup_fd,
+				(unsigned long)buffer->ptr + 2 * self->page_size,
+				PIN_LONGTERM_BENCHMARK, 1, self->page_size), 0);
+
+	/* Take snapshot to CPU pagetables */
 	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
 	ASSERT_EQ(ret, 0);
 	ASSERT_EQ(buffer->cpages, npages);
 	m = buffer->mirror;
-	for (i = 0; i < npages; i++)
-		ASSERT_EQ(m[i], HMM_DMIRROR_PROT_WRITE);
-out_test:
+	if (hmm_is_coherent_type(variant->device_number)) {
+		ASSERT_EQ(HMM_DMIRROR_PROT_DEV_COHERENT_LOCAL | HMM_DMIRROR_PROT_WRITE, m[0]);
+		ASSERT_EQ(HMM_DMIRROR_PROT_DEV_COHERENT_LOCAL | HMM_DMIRROR_PROT_WRITE, m[1]);
+	} else {
+		ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[0]);
+		ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[1]);
+	}
+	ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[2]);
+	/* Check again the content on the pages. Make sure there's no
+	 * corrupted data.
+	 */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
 	close(gup_fd);
 	hmm_buffer_free(buffer);
 }
-- 
2.32.0

