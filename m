Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35F6576411
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiGOPFj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 11:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiGOPFi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 11:05:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65AADAF;
        Fri, 15 Jul 2022 08:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCriNHKb0Ev7qw7YhMqFHN/boqlEBf15HpCzZvD41n7Kjcg+yo1QcjzKc/8GV0YtcyYDrRoROL1Cpdz8egD3F9W/YNv4InlR9bHr816rug7UZZ4AehI8b7RuxdZw41BIudIkSJoyP8k/klgsVddrSCm2gZcwKQNYu+1ZcMRv0N3INSiW2Ikf+go0m8mfYK9ZEy7yl/F56t3BN9WVcKYDZ+PEMkT0K7TJjs06LAocNUoiXn75yl8Iq8a5aCyZvIdddsS8ZKDv8hNEUsTGGP9j3dZUiH/4ufyNpZ+r2ngQXBvRbws6otO8PCljsm0ZoAj1Rmq16kWd1rpyitlTlL3MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZGhdkmfhVbbMbtYqiY0o7FTOj+0MzOTvzmjDbLDeEM=;
 b=obQfPenpb4qO21ZkPpmyY6jNnB8K8h2Y0WYOlby5M/BNqDbBUWmWzq8JC583+mxoMKqvBR+rsJb9FcCromRC9QKxac+MWLPp7J0oT7EXVziNQ7wH02ep/NNRywTK6jPRestL4cJmafAl3z3fBy03L8Jx1LPyDg7Ivogjdz7Tz/WjpnBuZOmvWsrQVhXFV1Ac4VsqazN5IoTVfQ5UOjma2GDfh+BG8GyPZnpBSxh5bwKsea5xeTz5ApBFSRpUa5FylltfDFgyL05/zKWYlrbhoRySufhn64wwLWIhNtl8NApZk+cHkf4ijyVL1LaUbMmVjZvh2waxw+nlQzT7PNYEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZGhdkmfhVbbMbtYqiY0o7FTOj+0MzOTvzmjDbLDeEM=;
 b=2U9LAXmGGWPbhzo/lXQQYM3vWdxQ1LHG5DZeqHgEIDzdS6iBeEsIDbdNHeTfWQC6wSPjdyMkNfYEXARPmngOtgv9lqzLvXV4vIYJyxA2y9OcWuTJzoYQLjE3LYfdmoqJB4mKDUER+MACOsNRhWzvTb0jQZ1CaSF69QtiuF/Vc40=
Received: from DM6PR06CA0061.namprd06.prod.outlook.com (2603:10b6:5:54::38) by
 DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.18; Fri, 15 Jul 2022 15:05:35 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::8c) by DM6PR06CA0061.outlook.office365.com
 (2603:10b6:5:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 15:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 15:05:35 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 10:05:33 -0500
From:   Alex Sierra <alex.sierra@amd.com>
To:     <jgg@nvidia.com>
CC:     <david@redhat.com>, <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>,
        <akpm@linux-foundation.org>
Subject: [PATCH v9 00/14] Add MEMORY_DEVICE_COHERENT for coherent device memory mapping
Date:   Fri, 15 Jul 2022 10:05:07 -0500
Message-ID: <20220715150521.18165-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b35874-da18-4570-0730-08da66737849
X-MS-TrafficTypeDiagnostic: DS0PR12MB6605:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQhmq3pjwDWXYY35Jk+B+VtJAV1DzO7h6fcbYBxhLN4IGOlTSRv6FVa8kPsCYAuk/wKWms2wyfdFaSNNWOJXysFtFK0+eVsJbY6nyaJjPegRv62U1sIZxTIq3yaPQsJ/TidW9N2egTNjonqsaQ+ISZMqVYIRyUz0Sa7i4YyBMmV4kg6w7ACTUV6bmeLgVNcrDVH05GbkDbdkdT8EVGnDueg/jCSfge7xdWce0JTl730VcPjRJPim4Hhx649vv827OkCtr/BsL73ecN7NOYkXyVI9xijaQ9qM8LU7wueznEJjVV6Iib6nskUcI8Pah2jb2uZVMHhRSSttsCnQnD1dlUattrXIyz5VMZQvhfKA69BR4c6RToyjTZU78b3Qr2fIrt4DvvYKQfWewcRUQrGVHzmy7Ns8485pTUWZvSc2tI+f6rTHPwMUTQS8LxGi9Pn7ktXgbwrYdgvaCUDupjsYjVps1PJ4LJKCXIEWy8Q18pNqSxihoS4YDJLOYA4LbWJgcaTaj+teoW6DDKh2pXpNoveBA9o+5Di50HRTLZNmrRWOdlsQulOfl1hiMKieYzgZraaq8bHcjC0JzzaSsj50GvhurHsIPngqna8of5ypdCnPqMNIpaiwLdW2xEEHlKTTp53+fNwfXxJeK4+6a6VFgV+F0UobE+NruS49+5Se+ix4xv+KGwrlZY34W9ZFfEXKSt/f6a3xe0/D0pCOJxj7DDWTMvzSXrmO5oiXTI4TKHwnGxdxN6v/F+65Ir7svmC3fRWRW5knKL6AMrOod5Cl8iv/ds6sAU6e8qVODEuOpe6C7LANzGz/2HEZtLD5EtkKURi7U4qJeTAW6GRqoUZ5xk3QzUlqPB2iHgzxjJf0/9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(40470700004)(36840700001)(46966006)(70586007)(426003)(70206006)(83380400001)(40480700001)(47076005)(44832011)(4326008)(2616005)(8676002)(336012)(186003)(8936002)(16526019)(82740400003)(86362001)(1076003)(7416002)(5660300002)(356005)(2906002)(36756003)(40460700003)(36860700001)(81166007)(6916009)(7696005)(54906003)(316002)(82310400005)(41300700001)(478600001)(6666004)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 15:05:35.0733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b35874-da18-4570-0730-08da66737849
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is our MEMORY_DEVICE_COHERENT patch series rebased and updated
for current 5.19.0-rc6

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
FOLL_LONGTERM.

v7:
- Reorder patch series.
- Remove FOLL_LRU and check on each caller for LRU pages handling
instead.

v8:
- Add "mm: move page zone helpers into new header-specific file"
patch. The intention is to centralize all page zone helpers and keep
them independent from mm.h and memremap.h.

v9:
- Rebase to 5.19.0-rc6
- Include latest Alistair's patch
"mm/gup: migrate device coherent pages when pinning instead of failing"
with changes based on David Hildenbrand comments.
- Replace moving page zone helpers into new header-specific file.
Instead, those were moved to mmzone.h.
Patch "mm: move page zone helpers from mm.h to mmzone.h"

Alex Sierra (13):
  mm: rename is_pinnable_pages to is_longterm_pinnable_pages
  mm: move page zone helpers from mm.h to mmzone.h
  mm: add zone device coherent type memory support
  mm: handling Non-LRU pages returned by vm_normal_pages
  mm: add device coherent vma selection for memory migration
  drm/amdkfd: add SPM support for SVM
  lib: test_hmm add ioctl to get zone device type
  lib: test_hmm add module param for zone device type
  lib: add support for device coherent type in test_hmm
  tools: update hmm-test to support device coherent type
  tools: update test_hmm script to support SP config
  tools: add hmm gup tests for device coherent type
  tools: add selftests to hmm for COW in device memory

Alistair Popple (1):
  mm/gup: migrate device coherent pages when pinning instead of failing

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  34 ++-
 fs/proc/task_mmu.c                       |   2 +-
 include/linux/memremap.h                 |  21 +-
 include/linux/migrate.h                  |   1 +
 include/linux/mm.h                       |  91 +-----
 include/linux/mmzone.h                   |  80 ++++++
 lib/test_hmm.c                           | 337 +++++++++++++++++------
 lib/test_hmm_uapi.h                      |  19 +-
 mm/gup.c                                 |  52 +++-
 mm/gup_test.c                            |   2 +-
 mm/huge_memory.c                         |   2 +-
 mm/hugetlb.c                             |   2 +-
 mm/internal.h                            |   1 +
 mm/khugepaged.c                          |   9 +-
 mm/ksm.c                                 |   6 +-
 mm/madvise.c                             |   4 +-
 mm/memcontrol.c                          |   7 +-
 mm/memory-failure.c                      |   8 +-
 mm/memory.c                              |  10 +-
 mm/mempolicy.c                           |   2 +-
 mm/memremap.c                            |  10 +
 mm/migrate.c                             |   4 +-
 mm/migrate_device.c                      |  80 +++++-
 mm/mlock.c                               |   2 +-
 mm/mprotect.c                            |   2 +-
 mm/rmap.c                                |   5 +-
 tools/testing/selftests/vm/hmm-tests.c   | 311 +++++++++++++++++++--
 tools/testing/selftests/vm/test_hmm.sh   |  24 +-
 28 files changed, 874 insertions(+), 254 deletions(-)

-- 
2.32.0

