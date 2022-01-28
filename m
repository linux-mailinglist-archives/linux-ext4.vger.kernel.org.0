Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF52A4A0173
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jan 2022 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351138AbiA1UI7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jan 2022 15:08:59 -0500
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:14816
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351134AbiA1UIz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Jan 2022 15:08:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymd+qmU5o2LEkJORnQB7ZWlHLpj/ciP8GDvSBIiqwyydMKi0Deas/CkOewGt+0ZfWQppXdEXUqdnCq0o8fmMA6vzB2FM6t5XhbkC9O/hFOw4sapYIq2VbalDMWnUoATklTwInCELZejopWz+HcjebOss4/ivut0LdL0ALZIL13yG9UQnrUiHyms20HDUF5q0fS4NNCI0u8h4th/ywW7xy/TUQZzNmbGB2HcBr46sSin9WkM4CUca7GH9Ym6BBexmzSaMpsQ8Nhjjuy2y/8ZmawY3k+kM0Y838fHAvEuexZnlWtaAE2kDJQ0nqWT4D8aUJsQqqzt/X584ajIML4lVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8c+snyg1lETNsdQ8VpQ4cgA8WAjjh8EpLlh6CLuAWAg=;
 b=LZ49h+aeV+wVTJaA4i6udBtbN1iOfdoDqcf+8MYpUqQ6AkRwcjGuz7dd3mtt6g8ai/tfmtum40GiHlv3xZzF/J6TOcgMGEcDxuVrRCs/7pj6WyqTo5CGNQ6V/VFR8pXv+5QtQPqDT3xK/dhEMQVQYOcHQixv8ZHRc/XIGfon5s0C07KN86/tEeK2/pYLP5vZ61srKaHeTPPE+HbFMVvOvFjY0Ilm/lTc9cJgFWD2HPBHrt85nPWahDoSXp90EZc0sxFqlYjZ9qjSOeXM3YBE8gJQmXChBAQ14ZKPzz5F1HCNNnmU9V+K0aUXDanr7+kewOzl/F7Xb9HSMOTxk7ikYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c+snyg1lETNsdQ8VpQ4cgA8WAjjh8EpLlh6CLuAWAg=;
 b=YnrlAWFtnGuKnuxBhXLesBW5o8HUx5gnORLKC2/ZdI8+Z9pW+sLvvKvbIZevds8nTTByxOavOZv4+O4zWPq8mJHgBX/SVBxhXS6o4mlZBDrqIlHYGNGy/jv40yJWoBWXJGqNcUtUuTHQEyWJMzqe0ryvDNeNE16G4VZAMWj6C/g=
Received: from MWHPR19CA0056.namprd19.prod.outlook.com (2603:10b6:300:94::18)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Fri, 28 Jan
 2022 20:08:54 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::d3) by MWHPR19CA0056.outlook.office365.com
 (2603:10b6:300:94::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 20:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 20:08:53 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 14:08:51 -0600
From:   Alex Sierra <alex.sierra@amd.com>
To:     <akpm@linux-foundation.org>, <Felix.Kuehling@amd.com>,
        <linux-mm@kvack.org>, <rcampbell@nvidia.com>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <hch@lst.de>, <jgg@nvidia.com>, <jglisse@redhat.com>,
        <apopple@nvidia.com>, <willy@infradead.org>
Subject: [PATCH v5 03/10] mm/gup: fail get_user_pages for LONGTERM dev coherent type
Date:   Fri, 28 Jan 2022 14:08:18 -0600
Message-ID: <20220128200825.8623-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220128200825.8623-1-alex.sierra@amd.com>
References: <20220128200825.8623-1-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f2e7c04-f5c8-46c2-04dd-08d9e29a0239
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5596CACBBBF7FDBA75BCB081FD229@PH7PR12MB5596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5i2aPYhVfZmuTKdq9kznvOfaVAkvrP04UWHoEJhbsBKmkNb5a1SD8h7U9Lbwx29KRczDHW8CDeqVGea0NSqdmJWCOozMlBpahMh1J93TmgcdNTl7f5Emm5xSIbMsRHvvVz/nJMYYkP/Bo0pYd5jYcESveARF5X7LODPAHpWwW5Vc3G6x0PZx7VLCq1EkPjSg1WBWWlwerBeq3ZPmPNbYmVPPLLz7YpEhNh9HXNkyR9TGEV9DmUEt71nDNFOoBSpwQ82m6WNF3s3CGrxsJj0Go3NQECthkP4l0n+5NZGdN+NCTQgqSkJeQDgHCBKea0RAeNWfovYJYqhkXTKdtEXBVTiZrgLAlEnP6NOnl0NjZyiMtQwVUZ6uIgz0CwYAa/hAfbN0lWpO6DWsQrHoBcmWYTkqlBI0z0pRgi6miVykbm9Q0WO0+jeVGf7ZuVuCfIYqhwd/1jWiLdXAVrmBfBFg9U9+W+z0wtHFNivv8wQTtnz0K8R85iMYzfS0RANMIlYIeWDnIjfNU9BxN7goRUlmjP6nOO1T1jCsERmf6jFp3+3lSqxPxDA9efD7+i9ItX+ZSr5eUTS5vvUrsf6cWIpjjp6TgEKbBwp9HDNlBMJbWMSy4oCDs7SZyJPj7FZ1uzvUesooC+ht+Lbe2gLxxAqreYPKEHBzCtBmogi00slx8NrRY+yZxDZFCvb/834SaXVZ/D/pHCZD5glSRPr1a2u6LNAj7vD6JT9xM0FrpYdE8bdNN41G/PDuj3XMGFaYF+LbLipcMRY6jm9U5RblC8D3EYlPSbc3Fx1Fj6IqFMBhnSg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(36756003)(36860700001)(2616005)(44832011)(26005)(86362001)(316002)(1076003)(6666004)(81166007)(8936002)(7696005)(40460700003)(186003)(110136005)(8676002)(16526019)(356005)(54906003)(47076005)(5660300002)(508600001)(70586007)(2906002)(7416002)(82310400004)(426003)(336012)(4326008)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 20:08:53.7893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2e7c04-f5c8-46c2-04dd-08d9e29a0239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Avoid long term pinning for Coherent device type pages. This could
interfere with their own device memory manager. For now, we are just
returning error for PIN_LONGTERM Coherent device type pages. Eventually,
these type of pages will get migrated to system memory, once the device
migration pages support is added.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Alistair Poppple <apopple@nvidia.com>
---
 mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..f596b932d7d7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1864,6 +1864,12 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 		 * If we get a movable page, since we are going to be pinning
 		 * these entries, try to move them out if possible.
 		 */
+		if (is_dev_private_or_coherent_page(head)) {
+			WARN_ON_ONCE(is_device_private_page(head));
+			ret = -EFAULT;
+			goto unpin_pages;
+		}
+
 		if (!is_pinnable_page(head)) {
 			if (PageHuge(head)) {
 				if (!isolate_huge_page(head, &movable_page_list))
@@ -1894,6 +1900,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	if (list_empty(&movable_page_list) && !isolation_error_count)
 		return nr_pages;
 
+unpin_pages:
 	if (gup_flags & FOLL_PIN) {
 		unpin_user_pages(pages, nr_pages);
 	} else {
-- 
2.32.0

