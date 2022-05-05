Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61351CB45
	for <lists+linux-ext4@lfdr.de>; Thu,  5 May 2022 23:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385955AbiEEVjW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 May 2022 17:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385954AbiEEViw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 May 2022 17:38:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42C5E174;
        Thu,  5 May 2022 14:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baQW5YHLjkk/FgHtwlxLUHnjL5hT3sbhjnHkBugX9TA4TGi00BhlVFn90lhbd1RHxxViBoil0xL9rKNEzCu8fSMaS/EknLqjbIEHM9k4Y5d8t5jN2yc/ZWazaY7fRLXsRD/i4u2SVYKiOo2AiaiVzhvp2cyVx1phoIdQoRPTltNy8YQYqWNxC4OLRM+xMPjP1hMQYZ0tBdBIxxiXdc//kFNTLrmlx7JFfbaZvoIbpk3k24fQVWz/WARRDyhUanTE58aMrx9mF/BFjbOgl5PK4qKEBkiYdmbuB+BaiRiF/a89thOjLd05CmNJV6+zTQJFXIAWMDDUce75OU/tfh4fQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds2C6hKBCPm3LMFGvWFrTQmYNyEijOJ3/DIUhvifx8M=;
 b=SKFcgrLxZ9oRhqNLPwalL5O9cv1kNEek5g8KdFvRDSHpJmLP8CDaBzJWYOD6eAl/QElBmdO23yUh2VHUR8E2hjPAKNyEXO07Zg9yTGuHnabR9ASBEa42fgg6DW9wWXtOz24qf73X0R2x5fTTv/Q8Huqh/vueNYgIN749AF722CMEAvqiDbuv5iea04jkwmI2oZKJc1Bz7D0ABVWw3rnb+b2RTwbgf4MwIWFn6WWKbq6hG9evv+tJw8kOoaU29n1tZUfjSrJ+fRlKK3uHAuE712b9uVxLQhKsLSdx36vv6FWtixjVNzvcYpMHqsjYgLErpJj389UqCwlkZuKmv5eQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds2C6hKBCPm3LMFGvWFrTQmYNyEijOJ3/DIUhvifx8M=;
 b=or5Eeell3+xuGjRDQVchEauOVec4oO/J0B0hPxTh45Mv2Jejfr6Fd/4reLaNMAVjLfD4CF0FMz5XMTjsdRZoNHGPHUBCDSNqVZWN4RdEAfN6xc/TWoCNusDz5ciDznon6zXVD6KOgebNNhx1SPoXZkBr5nEwwZ0jJDWhb/Y9UJ0=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 21:35:06 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::30) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 21:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 21:35:06 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 16:35:03 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v1 12/15] tools: update test_hmm script to support SP config
Date:   Thu, 5 May 2022 16:34:35 -0500
Message-ID: <20220505213438.25064-13-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0e19951-302f-4ce9-75d0-08da2edf1f43
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2512F2803E4FDB502A8B57DCFDC29@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLEfd19q8VJ/pHMfsikQCLxYlJ4GdTvH4iMPFgZUD4MVPQQ/XVIdmEJ4gKQNuxmt/S56kIOPbDq5PXOTsC1Oyhm3UwR7hfEraSEoXMHfN3OmF++7X0bcE/fXGWbT5ZIq93nv6scFHIdIYLPlWhWjQxVRBg1BYkx1pZhuWfWJF4uFgnM4SO/M/71it9D3AU7XjXfC+iWU9AB6G8c+cVhvDIP02VfquML7ZzX0cdJLqVlz1X7yYE2hxtOmLmoGbrV++u6r82EKegI9Q1W15AQ3wjmoGm4NlqLG3QGV2LU19ZH8+of8vaEQ4MJq1JmKROq6U8k+YQjlCqL7dvPWKHF2exEa9fN/S+oZYVaVJzWEUNga0d+ylQt5+KxKG4/wRmn5vOO+R6ALmZJjUHIFFZOutkNX+Y8zTWzafVLgfmWety6+Shqj4iHdAq7Uzaw14isRbbRHu++YrcFV7Tc4ntKK0BP6kfw1t4eO6UhUMm5lSGoG901C3Amu/1tS9Y65jrawWGvMhsNJzeA7+jWYs57B9PaHxZwqWps9QYwhp16fwVCd+s2lvAWkDFgwren9RgeZAkqsHANxbticG2b5938yyqp+XwN8aYvx+NxVBM8sPYLPz0fzjKAC6qEuNblbN4569G/aUK4YyYCKmRGK49rFpPJ/sctYq00pR08IHmXaYNga9aph6246FlBm+XN6IEw0l6eLMoJuowRER6nTZakJNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7416002)(44832011)(356005)(40460700003)(6666004)(6916009)(2906002)(508600001)(316002)(5660300002)(83380400001)(86362001)(36756003)(81166007)(82310400005)(36860700001)(47076005)(2616005)(16526019)(186003)(336012)(426003)(7696005)(26005)(8936002)(4326008)(70586007)(70206006)(8676002)(1076003)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 21:35:06.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e19951-302f-4ce9-75d0-08da2edf1f43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add two more parameters to set spm_addr_dev0 & spm_addr_dev1
addresses. These two parameters configure the start SP
addresses for each device in test_hmm driver.
Consequently, this configures zone device type as coherent.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tools/testing/selftests/vm/test_hmm.sh | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/test_hmm.sh b/tools/testing/selftests/vm/test_hmm.sh
index 0647b525a625..539c9371e592 100755
--- a/tools/testing/selftests/vm/test_hmm.sh
+++ b/tools/testing/selftests/vm/test_hmm.sh
@@ -40,11 +40,26 @@ check_test_requirements()
 
 load_driver()
 {
-	modprobe $DRIVER > /dev/null 2>&1
+	if [ $# -eq 0 ]; then
+		modprobe $DRIVER > /dev/null 2>&1
+	else
+		if [ $# -eq 2 ]; then
+			modprobe $DRIVER spm_addr_dev0=$1 spm_addr_dev1=$2
+				> /dev/null 2>&1
+		else
+			echo "Missing module parameters. Make sure pass"\
+			"spm_addr_dev0 and spm_addr_dev1"
+			usage
+		fi
+	fi
 	if [ $? == 0 ]; then
 		major=$(awk "\$2==\"HMM_DMIRROR\" {print \$1}" /proc/devices)
 		mknod /dev/hmm_dmirror0 c $major 0
 		mknod /dev/hmm_dmirror1 c $major 1
+		if [ $# -eq 2 ]; then
+			mknod /dev/hmm_dmirror2 c $major 2
+			mknod /dev/hmm_dmirror3 c $major 3
+		fi
 	fi
 }
 
@@ -58,7 +73,7 @@ run_smoke()
 {
 	echo "Running smoke test. Note, this test provides basic coverage."
 
-	load_driver
+	load_driver $1 $2
 	$(dirname "${BASH_SOURCE[0]}")/hmm-tests
 	unload_driver
 }
@@ -75,6 +90,9 @@ usage()
 	echo "# Smoke testing"
 	echo "./${TEST_NAME}.sh smoke"
 	echo
+	echo "# Smoke testing with SPM enabled"
+	echo "./${TEST_NAME}.sh smoke <spm_addr_dev0> <spm_addr_dev1>"
+	echo
 	exit 0
 }
 
@@ -84,7 +102,7 @@ function run_test()
 		usage
 	else
 		if [ "$1" = "smoke" ]; then
-			run_smoke
+			run_smoke $2 $3
 		else
 			usage
 		fi
-- 
2.32.0

