Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FD056AB78
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiGGTEp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 15:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiGGTEc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 15:04:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929733E1E;
        Thu,  7 Jul 2022 12:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1SGoWL7bD+Px+Ka7NIRzzmcca3Ol523dKlTbUjaI9umgBgmsETxemygBAOCk72dtkgMbDbSzyZZOevZK02i+Bv96LMzGtyD3sbF4fCWdAa4Bn1pmgtyfcgW/mx/6OHGWiX3m1nw3D26qeQqnPFwfKqZylqrqrQLEYBadqOraU9LeJhvHmw3542nM3cFro/x/W4fjUKEUgVQlwImfdJ3qnDZIspEDdP75IuAUI5HK6pfWYp0SsEYO+gqwidAJD/9opTZfCbY//ad02EBN2UhXAcb/Yxtq5kBX9krTs/wCWx4qM/g34SJ/4b3y2H5zOyIlpwxvoMuVyT24rwyi6617w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP3ikngykfp62hqgKGCY9CKncoZ/5EVzq4BZbbmWmCY=;
 b=OCY4tDJXzUIUoVDC8rDsdWcOPMDgMMkF93OzK4DSr42laGYIoCzSLJ6+ECqZvS0pYfy2FlOSArOdiONhx8LELtMvHTZoIDe6DGgLm32VcW16WmQCia0wkiyqsSIMUZiMYsAhia1iY+o55myA+4zhUsQ6/9vjJ0MJVY/fcvvZ0vLttERw8fRry5bCfzPhRZbTRYNADae4E9GXogd8SoKjhQXFgKXouI6xvxiomKRNs8dURn7kNbN1/0CPeo+9k1v++sryogABDOPeCVfcT/MPSPmYEwhXMqXtJx4jcjbX8YMOj0EiaBkiIv5GS6ZEU3Fk061uZF2fSmnmtyFp+7FSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP3ikngykfp62hqgKGCY9CKncoZ/5EVzq4BZbbmWmCY=;
 b=v+Fy5G8oKzTSMwcgmdEO5zYRHmIs/tU6Us0SUEBUa8aN7gszzdZFKRE1v3RK9y9NUnLb0cB/Ia9dnpBt/28oVCeb7SR/iK9GIabALf3A1VH/rzUmg2c8Gf20nwmVGhoID92JmFfkjF3D5IQ5SAmme/yNb4Xt12uJWIiFLkzygTA=
Received: from BN9PR03CA0669.namprd03.prod.outlook.com (2603:10b6:408:10e::14)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 19:04:23 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::de) by BN9PR03CA0669.outlook.office365.com
 (2603:10b6:408:10e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 19:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 19:04:23 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 14:04:21 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v8 14/15] tools: add hmm gup tests for device coherent type
Date:   Thu, 7 Jul 2022 14:03:48 -0500
Message-ID: <20220707190349.9778-15-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220707190349.9778-1-alex.sierra@amd.com>
References: <20220707190349.9778-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc4c240-26cb-4e46-6ad7-08da604b8146
X-MS-TrafficTypeDiagnostic: BY5PR12MB4259:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xT84/5HyFkH35dzp/dIgv6P8UHQfU0oYR2eY+7DMe/R5YVAGGbXeJkqS8+e7jiYVdJkUV/GQyK+IaKx7xd4KpwEykoErsTYkMwXNBURK09ppEyW7UQ0f4+l8l376vssNMLfgMBg0tbhfvdbysK719Kw5nIcxdzFZLW710/yMCkBPueYAVYixawxx+QAWjLKD7FkZW+f7H7jl1jeoYsr5sf5nyJwz3FsFuiB6m3ldB+BM6pmpQ0iT8tOCbnJXCclYc3VvEPgnEjBHkYQNB6++T936tzdadc+ETwS1n3ZjC0MPkg9enGfmJ9oy7tWeurrD8j/X7VH2t/aRg5/o2oUdz//bcT5arEfCeIDBtOefyiaPe/jJFfEsii2TsuwX0q7dIUXYmfq0ti3x76HUa1Bpk27h0/ZyBN7P1FOP1DUF3qspg2KQBoGKplN3/nVA+8L0y3KFKYfHjwuYihZgWWXC7RQR1696Vac2Kkkb5Xzwia7z5BmyVRqIhz4VjvWDey5Di9ADmeQN1BfXM/rEHhmNv3V5CuCbMTwFJUlV1NC02XaoxyWDU4d4rhwbTZyqjWwf9oEo/AtVtvyPMYZjwrzEbVSH/vFv0a9CNXC8Mu4n59krLm8yaO6kzGfCiBZNq8caB6EJT4im09PLZ6iWVAgP7eePSwcq9/riR6KgTRSxIA7zgQQOlzuEeHv5xhPrEjBHLNe2GvPfHtqhkKSvQtR6jl3I1uNzs29aVuwpxIhSdSMUVZvDKBIBeoA6830GfSWLLtY6DP5YfesTNYy3cTGrwyjJ4Dqy4447gmqykfvq/aFgR7EBoD2SBNzOS7P3cVWz0GfOyfX7nZrsKut5AccVH4uldCWSpcH3XCwdtrmJBj3rHTM30vKfbJRu6BH0mz3N
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(40470700004)(36840700001)(46966006)(70586007)(54906003)(40480700001)(426003)(336012)(47076005)(8936002)(26005)(82310400005)(83380400001)(40460700003)(7696005)(7416002)(36860700001)(5660300002)(316002)(81166007)(478600001)(41300700001)(6666004)(6916009)(44832011)(86362001)(8676002)(356005)(16526019)(186003)(36756003)(82740400003)(4326008)(1076003)(2906002)(34020700004)(70206006)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 19:04:23.3410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc4c240-26cb-4e46-6ad7-08da604b8146
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The intention is to test hmm device coherent type under different get
user pages paths. Also, test gup with FOLL_LONGTERM flag set in
device coherent pages. These pages should get migrated back to system
memory.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
---
 tools/testing/selftests/vm/hmm-tests.c | 110 +++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 4b547188ec40..bb38b9777610 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -36,6 +36,7 @@
  * in the usual include/uapi/... directory.
  */
 #include "../../../../lib/test_hmm_uapi.h"
+#include "../../../../mm/gup_test.h"
 
 struct hmm_buffer {
 	void		*ptr;
@@ -59,6 +60,9 @@ enum {
 #define NTIMES		10
 
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
+/* Just the flags we need, copied from mm.h: */
+#define FOLL_WRITE	0x01	/* check pte is writable */
+#define FOLL_LONGTERM   0x10000 /* mapping lifetime is indefinite */
 
 FIXTURE(hmm)
 {
@@ -1764,4 +1768,110 @@ TEST_F(hmm, exclusive_cow)
 	hmm_buffer_free(buffer);
 }
 
+static int gup_test_exec(int gup_fd, unsigned long addr, int cmd,
+			 int npages, int size, int flags)
+{
+	struct gup_test gup = {
+		.nr_pages_per_call	= npages,
+		.addr			= addr,
+		.gup_flags		= FOLL_WRITE | flags,
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
+/*
+ * Test get user device pages through gup_test. Setting PIN_LONGTERM flag.
+ * This should trigger a migration back to system memory for both, private
+ * and coherent type pages.
+ * This test makes use of gup_test module. Make sure GUP_TEST_CONFIG is added
+ * to your configuration before you run it.
+ */
+TEST_F(hmm, hmm_gup_test)
+{
+	struct hmm_buffer *buffer;
+	int gup_fd;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	int *ptr;
+	int ret;
+	unsigned char *m;
+
+	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	if (gup_fd == -1)
+		SKIP(return, "Skipping test, could not find gup_test driver");
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
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	ASSERT_EQ(gup_test_exec(gup_fd,
+				(unsigned long)buffer->ptr,
+				GUP_BASIC_TEST, 1, self->page_size, 0), 0);
+	ASSERT_EQ(gup_test_exec(gup_fd,
+				(unsigned long)buffer->ptr + 1 * self->page_size,
+				GUP_FAST_BENCHMARK, 1, self->page_size, 0), 0);
+	ASSERT_EQ(gup_test_exec(gup_fd,
+				(unsigned long)buffer->ptr + 2 * self->page_size,
+				PIN_FAST_BENCHMARK, 1, self->page_size, FOLL_LONGTERM), 0);
+	ASSERT_EQ(gup_test_exec(gup_fd,
+				(unsigned long)buffer->ptr + 3 * self->page_size,
+				PIN_LONGTERM_BENCHMARK, 1, self->page_size, 0), 0);
+
+	/* Take snapshot to CPU pagetables */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+	m = buffer->mirror;
+	if (hmm_is_coherent_type(variant->device_number)) {
+		ASSERT_EQ(HMM_DMIRROR_PROT_DEV_COHERENT_LOCAL | HMM_DMIRROR_PROT_WRITE, m[0]);
+		ASSERT_EQ(HMM_DMIRROR_PROT_DEV_COHERENT_LOCAL | HMM_DMIRROR_PROT_WRITE, m[1]);
+	} else {
+		ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[0]);
+		ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[1]);
+	}
+	ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[2]);
+	ASSERT_EQ(HMM_DMIRROR_PROT_WRITE, m[3]);
+	/*
+	 * Check again the content on the pages. Make sure there's no
+	 * corrupted data.
+	 */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	close(gup_fd);
+	hmm_buffer_free(buffer);
+}
 TEST_HARNESS_MAIN
-- 
2.32.0

