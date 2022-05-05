Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4851CB4B
	for <lists+linux-ext4@lfdr.de>; Thu,  5 May 2022 23:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385958AbiEEVj3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 May 2022 17:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385952AbiEEVjC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 May 2022 17:39:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1718DB43;
        Thu,  5 May 2022 14:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcZkF5d5Swf5dspJvhDvxsDLpUyXOu9siD4m9TqBWZmezETDicCaXM/g/6feh/pP93h6cfOBcdbsaWwbYpB3+7t8rwrIup5ksidtQ4UE/FAspN5DhfrsEJjYTSmpcGUoEKUGCNM4l9ohiPPnxh4mIe+lZaBR9S5kbOkqmO6cIoMSI3VVB6qSoIW3DWknPZ1PQRg22ZweLLhYGVqZJoXdWPgADklBjaVv+2O0Ej2kElKa4dP/QqsQFGxzoKIbzjEFtqVdKcg7zxfW76mvOphawoVm29aoEQwampMBsQ0QgiiErJ7JyHjq3fbUIPBPBGw+kSHzDM1c2suOic103RroLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v+1UPaPthHsygapXxuY4sqVDC3cvlVfCyGWQ0h08FA=;
 b=FDOWVixT+7Ge2xV+HYgOb4F8Asbsm/gWf4Tf6R0U+VUBwEpU0177waVnP6WOt5dYi+eDqMvSOIrBzLRXvfIEXPB9lBXynazCtqtZrnf3MxIkMUEDiFvMP97j7f5pJUWSZc/2Q4Lv+ostg3LM45kArISqCNZqwGiO/dBcFjpmRqw9HjrhdPiFsySReWvli7N0ANaWiT/LFgJD2Fu1rhpgRvFvctnfZAqqEHEbL0yoxtQVKE7RR9YQ6EDPLrCuePjiJrsOkTY2iUfIMgXuiUHl0ocOHMQrJ/zqe/aYqCGU8earYZSlvSfJ+MNFdF1BFg8UnDIYf97jahZW0iR6w9sg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v+1UPaPthHsygapXxuY4sqVDC3cvlVfCyGWQ0h08FA=;
 b=BU+ZP2k4XFl6VahBRO8AjeeXqVgDaXOQvnYWvLTvFrBjhFNM05vr+8zf1hAY/4gAI5Sn1NI+ZsuIwAb9HLA4I5qkbWwyfyvHFfo765lqFPCZ/CPGyY2phhbSuW+CIJB3Z5sllKto7mAVCWRUc+VK/pCNuOhVz84MCN/858Ik240=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by MWHPR12MB1376.namprd12.prod.outlook.com (2603:10b6:300:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Thu, 5 May
 2022 21:35:10 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::48) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 5 May 2022 21:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 21:35:10 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 16:35:05 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v1 15/15] tools: add selftests to hmm for COW in device memory
Date:   Thu, 5 May 2022 16:34:38 -0500
Message-ID: <20220505213438.25064-16-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18397a44-07b2-427b-c428-08da2edf219d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1376:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1376B4EE555D03DEB42FC22CFDC29@MWHPR12MB1376.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+FpmzbRPhi6/A1DyxrxbPiO2wzcHSkkhDZxbnT9+cU3YjUR1KfzC3hCKc8f3Dtfwgp9QSN+fNqRgVRNhTNw0PAWz/lSlHtPGfuAoJpSRrrYqIrwwARRNlVR0zw9K5DfXYWJO7wZ4WkUNr/D1rmPj2ucz5/m9tpCpaaABn/ERujJwJIWvGKVtTsw6JihF+GSFfxwKpPoxOHzkOKNFRGSFC4DL39Oq/Jgn/8rmpusGp5G30pB2jSYkF4dHMq0yxNBdyUbALHBaWskSSuHw5bkfgiNu7WhXKX/bIrysWmaFcg7NtxPOmdHRw3fEQlQt9P3SQP1W7Nx4FLhl8yMD/Vgm+cMH0qH25SbcjfpF03U4QQxp9RdQB3uiixaFByieDBCgN83alNrouoSPSSE2VKyOSWUlse1dBGlhqo2rO01RtPgpFtpn0qB8zqG70HA3bsc5Cz+Isu2Btm+Wicd5HM5S7wipAmNcdWQemrytsVb6hESI8D7PRmj6G+QpUldlQJYoHRdpuLt0ISmIsxLz+aT+IhJ1RsIM8hBskTdMCvLrlQg49elduCBaRHoigUOa1gRTPIRSGrX5wB+EOGFJDZLjy/EbuqOoQdN10NQGGOXaEWK8Gol2lYjsaBapXp0gAnrPBYjCnDPmytRXh9dwG1AhrwuqRM46ATFT4MvmV8WpebzC3xx+ZNRyyhj3La93JJ9mVgJtDejW8Mi+nd2ZyoPYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(426003)(83380400001)(186003)(336012)(47076005)(36756003)(16526019)(40460700003)(2616005)(44832011)(82310400005)(36860700001)(2906002)(70206006)(8936002)(5660300002)(26005)(6916009)(7416002)(508600001)(316002)(70586007)(81166007)(86362001)(4326008)(7696005)(8676002)(54906003)(356005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 21:35:10.1043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18397a44-07b2-427b-c428-08da2edf219d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The objective is to test device migration mechanism in pages marked
as COW, for private and coherent device type. In case of writing to
COW private page(s), a page fault will migrate pages back to system
memory first. Then, these pages will be duplicated. In case of COW
device coherent type, pages are duplicated directly from device
memory.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 tools/testing/selftests/vm/hmm-tests.c | 80 ++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 65e30ab6494c..d70b780df877 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1870,4 +1870,84 @@ TEST_F(hmm, hmm_gup_test)
 	close(gup_fd);
 	hmm_buffer_free(buffer);
 }
+
+/*
+ * Test copy-on-write in device pages.
+ * In case of writing to COW private page(s), a page fault will migrate pages
+ * back to system memory first. Then, these pages will be duplicated. In case
+ * of COW device coherent type, pages are duplicated directly from device
+ * memory.
+ */
+TEST_F(hmm, hmm_cow_in_device)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	unsigned char *m;
+	pid_t pid;
+	int status;
+
+	npages = 4;
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/* Migrate memory to device. */
+
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	pid = fork();
+	if (pid == -1)
+		ASSERT_EQ(pid, 0);
+	if (!pid) {
+		/* Child process waitd for SIGTERM from the parent. */
+		while (1) {
+		}
+		perror("Should not reach this\n");
+		exit(0);
+	}
+	/* Parent process writes to COW pages(s) and gets a
+	 * new copy in system. In case of device private pages,
+	 * this write causes a migration to system mem first.
+	 */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/* Terminate child and wait */
+	EXPECT_EQ(0, kill(pid, SIGTERM));
+	EXPECT_EQ(pid, waitpid(pid, &status, 0));
+	EXPECT_NE(0, WIFSIGNALED(status));
+	EXPECT_EQ(SIGTERM, WTERMSIG(status));
+
+	/* Take snapshot to CPU pagetables */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	m = buffer->mirror;
+	for (i = 0; i < npages; i++)
+		ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[i]);
+
+	hmm_buffer_free(buffer);
+}
 TEST_HARNESS_MAIN
-- 
2.32.0

