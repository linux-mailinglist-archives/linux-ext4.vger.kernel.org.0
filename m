Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8385D4D507D
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Mar 2022 18:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiCJR2R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Mar 2022 12:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244981AbiCJR1x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Mar 2022 12:27:53 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FCC2E62;
        Thu, 10 Mar 2022 09:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFEBKSQFyqeRHtai7awNAGQ/SGHMOflQITcG1gx7HMlk00BPX/qmMs0LnVSrXh0dFppweNV7/AF9CIh8haJbD9zZONveuFkoPW2kxW69CviKutowrYWHyuGA0xuSeZs6O2ui9gOTl2G1srovSxBWjkmDuuctxdJgbUKmGKvkOoyKS155kOr9RGIQJBY1hT4PZ1nsrkUObQD5M7PaWU3zMNjNrTheX6sVtufFY5zIlHLCFde3dtjWchzWzP/eduNUSW5aXYEs2QSObLsZH93vjDyicQl63JOLDnGNbW5t2BKYm6drBrESypQj8AOuB58dDFEWHWnc2lE6CgUR2LgxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+v+1UPaPthHsygapXxuY4sqVDC3cvlVfCyGWQ0h08FA=;
 b=n1iy540S9M4XzPyVHItLtr5MFznLBd728lGCGmIiIDjXuI/oo/fT9ua4sHUPIN9WU1Ep34iwI12K+8VAbX4AuSoj7xp9fJvgUb0ATfm+6FlyuKSkpQ+SmRVVgdMt1xtTyN8p6o9ZKxlK9mKAMH+XGELMYs+OLi8BuTu8vv1ne9645GkSnBOIOrJZYYyWaXYSS6scsFSNquvZvt2+HtwCFdpigHWJWHmZ4CAiUdH6im0NpV1GiB5RJumleqhfXEK2lL938L/QvwiNDfaQMxGWt7W0aGcBF5EQN1xy3r7qQmMv+82utCJbIzafe3jBMyJTtEzLZLx5J4R7nIZ2Rz20tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+v+1UPaPthHsygapXxuY4sqVDC3cvlVfCyGWQ0h08FA=;
 b=NNmB470gb/CYX90FK4yEbhGDNmtUDwjqkl72EgETLlLCQ/6xDMUzK5iY8SW6q5Bi2eUl99mubFJbJdNdoM9w+c7Fat/ZG5++cL0h5oCxuz9HbrisKngmZ/i3IPq0DHF+mbwg4j910rEkooHMTDc+vajAFkQuS9sh6sLGWukc6F8=
Received: from DM3PR11CA0019.namprd11.prod.outlook.com (2603:10b6:0:54::29) by
 BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Thu, 10 Mar 2022 17:26:47 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::da) by DM3PR11CA0019.outlook.office365.com
 (2603:10b6:0:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.27 via Frontend
 Transport; Thu, 10 Mar 2022 17:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 17:26:47 +0000
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
Subject: [PATCH v1 3/3] tools: add selftests to hmm for COW in device memory
Date:   Thu, 10 Mar 2022 11:26:33 -0600
Message-ID: <20220310172633.9151-4-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85354b9d-0445-47ff-a513-08da02bb278d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5141:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5141E25CAEBBBB5DA3CDA141FD0B9@BL1PR12MB5141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCbRBKF8uJrOBI8LouOXjRxOdyXZMhchPVjs8D+xtAq+7pBrN92E8HVOh1idHSDDnASLZlwyrx884SnsUFAVb3I2F/wplQtQx/aIQcAVN6g1dZ0iMGoHxxRt0pMjlB2t3IyYscBrb9QjNmr+POap6/+aKa8kD8RUy1HbtZQZC9lhZfde95b8PCz+Kh+Vk1AnLrN2zDRQad6fH9hys/S1Jus+cRzk3j4QQHCl+VsUFElnzS/DmqKt/SBQYAPgZVybdxX5IVjPEfKo8iXIwZA34pE9xVeAEwpIDp74lodgsrz5zS7JBugcJynpHFtqlYpTIr45aFc9Wsalptbt28LZ9L0+jeY89nKj2Semp2eOIykwi3iPq6qG4vOMz/pXLOsH2dDeL9Zp73+jc+/b5sn2/e+cULzj7Ai1UWHYD53QUjNCsKw2WJ68nI5kdOX1UIdmwLNznB3JpJX/7GBYFTpaNvdqbTXL1vYhAma5RNGb9DR722ER+iodnCdsoWgPRcZTxHkMG5/i8y21rcyfD+hnhoWlYpWihdy399WtuUluqYB+dhVUdoRH+comEnnFEpyp8HE6lybrtG94lrMtbpijjS9O4r4HHRJE9ToFEt//p9lnZxnUmiqkTMH/VGB3AmXxclyjOPkcV3vO6KaYOhUH2E0xykJR1wTmgJnBBTsV9J7yUdel5SWAT0sLj2TI98FSMuDc0I83RWDRP2pfcIBXgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(47076005)(7416002)(2616005)(6666004)(40460700003)(83380400001)(1076003)(26005)(2906002)(8936002)(82310400004)(44832011)(7696005)(336012)(426003)(16526019)(186003)(70206006)(36756003)(4326008)(81166007)(6916009)(70586007)(54906003)(356005)(316002)(86362001)(8676002)(508600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 17:26:47.0830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85354b9d-0445-47ff-a513-08da02bb278d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
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

