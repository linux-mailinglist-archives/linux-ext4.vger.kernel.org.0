Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C155C8B0
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbiF1AP2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jun 2022 20:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiF1AP0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jun 2022 20:15:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F463C5;
        Mon, 27 Jun 2022 17:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3M35TTz7ScPnL9SwKCIIIevPZkz0lMRrZ2F5NKYwYkyiowScUXtz6siPvH3mXfKLPfuW4y3yTMQyMEk8A0TCDVjCvzo+fLuwLzbviFQQGBYLhCOhIYlaxTv9AahJD9Gpax8+rGmsAb8frA5wPXFNMJYSrG0+oPD3PZm5InLqpBy10c3/7K+AWAaZHHMbEYxKqvHLP7ppT8Rkc5HtcI/zc2DbzMmCteS3zy7HNuVFt6/GsRhFJgl4usBZmxauduQRPW170wmda1iHJJR0Zr6W6I48j2jqHlBvvB1Q3hRiZhF9yqo3wcDJ+LhF6zityhxfJeT8bJGAPFtZn0DBEFTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK7HshDiUhUFL8UUv60/b7ZE9dZACIugt4D5YYpbxfA=;
 b=PvGgk0mI42iIj1G7nrlbdybEeJh+gdMQap4VLh0oCjt5SCjKek5TtpdGH06lQ6TSvKPGHwb0Q8Km/Inx91z8vlIeJ1laFfOg5ww2IMozln2lHxKbTqO+Ziww/aCmFtNfYSKq1yxXawcO7JBstsdSOdt6CN7+uijjpYra7BKjOGVcIlvFA56n/ViJkk2BNh1nGKze18GoXc76f42Uc4dlR3G1GXhbGuW+bCoScsdZLZeewYK28c1T5CpqxfonfJn1LLJ0osiC0bUatxnoX5mfvWhCb7Iajz9Cgt1Aglb1BbY7P63+jbwlXWlFtoS0LONWNl+kmmPP9fffwfPfqfOXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK7HshDiUhUFL8UUv60/b7ZE9dZACIugt4D5YYpbxfA=;
 b=kpR1pWTy84y9dXPCFLxuFmfZviA30dAJIyLLcoyiENMVB06jKi4aVNtiA3Vcc6m5B1RQOEOyfN9+rz5Te+WBFMmIzqNX8GYU0QFBE4UxiUpv5qZGpcFP7u0HQQLj9pioRC4qmJqpv8nEKDTw1Fxri5hEYwETn1kd9mKR/ADjAVQ=
Received: from MWHPR15CA0051.namprd15.prod.outlook.com (2603:10b6:301:4c::13)
 by DM6PR12MB3100.namprd12.prod.outlook.com (2603:10b6:5:11b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 00:15:20 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::f9) by MWHPR15CA0051.outlook.office365.com
 (2603:10b6:301:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 00:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 00:15:20 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 19:15:18 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v6 00/14] Add MEMORY_DEVICE_COHERENT for coherent device memory mapping
Date:   Mon, 27 Jun 2022 19:14:40 -0500
Message-ID: <20220628001454.3503-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6b85f6d-4a3f-4028-1bec-08da589b499c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3100:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71e4jyhuU6gTErAMzSL8u6nGb/2TaKq6XHLxYpkpS/w7SrprpTwpOTV7EmWukGhSSCld16O7UZwQIg95T2Raje0GzRPaTAFq1ltiP7q3z5jbBr/6T4kliy4kmfhmuxpwU9Zlc17A2btBdGIanbq1srELTRjOvVDnj1EIIJt5Kqfe+Rb2Dmguyn5DvkgKpFFd4IKRpXWraVppzKpoweFMvAOupW9/+ktrBNlsEHMzPFPZK80ldXEgT4W2ioh8PVoVYBlY+NeWtVwMsZdnO2wNhaXo3GDknU5owJXxO89w58OXGFFDoA1U5yxCvzHMKcRGdd0NdjJ1zT0Y2YGjUDq+T1wbWwmopb4X4Wtt7/vjys9XEH+evvV3J5/T4vHDQuAC96XQ/2vwZ6yhsCJpmLxFl+nR+wCYUn5YA8eamRcmwRoHAw/+3Cq5St4WGxjtxA23GkCbFViw8vZv91CWo3CTJ1I7q0FI/Gsk1hzjZd1WH/CNE7BttBeAFcMd1CeK7rPa4SeHVOF921kcPe+8c/2qYaTGjS+0rHqqkt/uYMQTC8IyCticLKsF2f2sjbaeeY6YSl5dnob571bs7kZyxY0E3fqVxbtn2FgrbxeghcCcefI6UCOqOYpEf4Ni4vRw5yZ5AaJZ7mU0shyRB4YaLCswuq8GQXPOzZvkYKrO+f799Q49GIYwyuMNUkKbiYIPgwDN4DeHuFNqs3u3Db5RS6IeiAbAMCffzAz7m42yxxvIjloW2rDxwntHlWjXrXlrPbR4jPlbK158+VMLF6dSnwcTsn6n79FKzAAsfFw8tO1tPygyqEJwynE712gpsduhakGw/q3yZFVsdqcPs2F/Lwkl7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(40470700004)(36840700001)(5660300002)(86362001)(70206006)(82740400003)(16526019)(186003)(4326008)(316002)(8676002)(356005)(70586007)(81166007)(7696005)(44832011)(6916009)(54906003)(36756003)(40460700003)(41300700001)(336012)(7416002)(478600001)(6666004)(83380400001)(26005)(47076005)(426003)(1076003)(2616005)(36860700001)(8936002)(2906002)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 00:15:20.2614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b85f6d-4a3f-4028-1bec-08da589b499c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is our MEMORY_DEVICE_COHERENT patch series rebased and updated
for current 5.19.0-rc4

Changes since the last version:
- Fixed problems with migration during long-term pinning in
get_user_pages
- Open coded vm_normal_lru_pages as suggested in previous code review
- Update hmm_gup_test with more get_user_pages calls, include
hmm_cow_in_device in hmm-test.

This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
owned by a device that can be mapped into CPU page tables like
MEMORY_DEVICE_GENERIC and can also be migrated like
MEMORY_DEVICE_PRIVATE.

This patch series is mostly self-contained except for a few places where
it needs to update other subsystems to handle the new memory type.

System stability and performance are not affected according to our
ongoing testing, including xfstests.

How it works: The system BIOS advertises the GPU device memory
(aka VRAM) as SPM (special purpose memory) in the UEFI system address
map.

The amdgpu driver registers the memory with devmap as
MEMORY_DEVICE_COHERENT using devm_memremap_pages. The initial user for
this hardware page migration capability is the Frontier supercomputer
project. This functionality is not AMD-specific. We expect other GPU
vendors to find this functionality useful, and possibly other hardware
types in the future.

Our test nodes in the lab are similar to the Frontier configuration,
with .5 TB of system memory plus 256 GB of device memory split across
4 GPUs, all in a single coherent address space. Page migration is
expected to improve application efficiency significantly. We will
report empirical results as they become available.

Coherent device type pages at gup are now migrated back to system
memory if they are being pinned long-term (FOLL_LONGTERM). The reason
is, that long-term pinning would interfere with the device memory
manager owning the device-coherent pages (e.g. evictions in TTM).
These series incorporate Alistair Popple patches to do this
migration from pin_user_pages() calls. hmm_gup_test has been added to
hmm-test to test different get user pages calls.

This series includes handling of device-managed anonymous pages
returned by vm_normal_pages. Although they behave like normal pages
for purposes of mapping in CPU page tables and for COW, they do not
support LRU lists, NUMA migration or THP.

We also introduced a FOLL_LRU flag that adds the same behaviour to
follow_page and related APIs, to allow callers to specify that they
expect to put pages on an LRU list.

v2:
- Rebase to latest 5.18-rc7.
- Drop patch "mm: add device coherent checker to remove migration pte"
and modify try_to_migrate_one, to let DEVICE_COHERENT pages fall
through to normal page path. Based on Alistair Popple's comment.
- Fix comment formatting.
- Reword comment in vm_normal_page about pte_devmap().
- Merge "drm/amdkfd: coherent type as sys mem on migration to ram" to
"drm/amdkfd: add SPM support for SVM".

v3:
- Rebase to latest 5.18.0.
- Patch "mm: handling Non-LRU pages returned by vm_normal_pages"
reordered.
- Add WARN_ON_ONCE for thp device coherent case.

v4:
- Rebase to latest 5.18.0
- Fix consitency between pages with FOLL_LRU flag set and pte_devmap
at follow_page_pte.

v5:
- Remove unused zone_device_type from lib/test_hmm and
selftest/vm/hmm-test.c.

v6:
- Rebase to 5.19.0-rc4
- Rename is_pinnable_page to is_longterm_pinnable_page and add a
coherent device checker.
- Add a new gup test to hmm-test to cover fast pinnable case with
FOLL_LONGTERM

Alex Sierra (12):
  mm: add zone device coherent type memory support
  mm: handling Non-LRU pages returned by vm_normal_pages
  mm: add device coherent vma selection for memory migration
  mm: add device coherent checker to is_pinnable_page
  drm/amdkfd: add SPM support for SVM
  lib: test_hmm add ioctl to get zone device type
  lib: test_hmm add module param for zone device type
  lib: add support for device coherent type in test_hmm
  tools: update hmm-test to support device coherent type
  tools: update test_hmm script to support SP config
  tools: add hmm gup tests for device coherent type
  tools: add selftests to hmm for COW in device memory

Alistair Popple (2):
  mm: remove the vma check in migrate_vma_setup()
  mm/gup: migrate device coherent pages when pinning instead of failing

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  34 ++-
 fs/proc/task_mmu.c                       |   2 +-
 include/linux/memremap.h                 |  44 +++
 include/linux/migrate.h                  |   1 +
 include/linux/mm.h                       |  27 +-
 lib/test_hmm.c                           | 337 +++++++++++++++++------
 lib/test_hmm_uapi.h                      |  19 +-
 mm/gup.c                                 |  55 +++-
 mm/gup_test.c                            |   4 +-
 mm/huge_memory.c                         |   2 +-
 mm/hugetlb.c                             |   2 +-
 mm/internal.h                            |   1 +
 mm/khugepaged.c                          |   9 +-
 mm/ksm.c                                 |   6 +-
 mm/madvise.c                             |   4 +-
 mm/memcontrol.c                          |   7 +-
 mm/memory-failure.c                      |   8 +-
 mm/memory.c                              |   9 +-
 mm/mempolicy.c                           |   2 +-
 mm/memremap.c                            |  10 +
 mm/migrate.c                             |   4 +-
 mm/migrate_device.c                      | 115 ++++++--
 mm/mlock.c                               |   2 +-
 mm/mprotect.c                            |   2 +-
 mm/rmap.c                                |   5 +-
 tools/testing/selftests/vm/hmm-tests.c   | 311 +++++++++++++++++++--
 tools/testing/selftests/vm/test_hmm.sh   |  24 +-
 27 files changed, 834 insertions(+), 212 deletions(-)

-- 
2.32.0

