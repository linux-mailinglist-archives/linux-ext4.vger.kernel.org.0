Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA44AB49B
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 07:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349107AbiBGGRl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 01:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiBGE1R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Feb 2022 23:27:17 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E6C061A73;
        Sun,  6 Feb 2022 20:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4uraQ7LjsBKbkr4eDaPptidorMZympWeA313UL9O2iuBjmcjOjh+nTsf6Kxo4eKiIQYRMruBArkTkYf2yMcJbdqQoT+2vpVZJvMQ8ULDeMSyklL2skimrWZPfgx89NMoY6naIC6FWO35U0ax7OZECkm1ORgi5obtESXR81YdJcvIxvIIy63ZXgI18QrChEwyqzpm92GYA8jBBiAzdZWJlBFO6cdHmk4r0q4tMfF+OYTRJ1258uBfJnzeB0Zl13T0O70pjsGWw/AYtyW775v9RJ8sRk8Whkl2r/CpDzjDAaNxQFUuggntRwsdv9sfbVy8N+kugm9wzf+hPwTKWwp9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdXD7BcRhMXZ2AaqHVINHETP5vTM8yVcghtNkAXs1kk=;
 b=V4CD1DO+d9EUkNLaPVlnsXjMqpy5BV2ZS7rh97KPa44Bisp4vCMHiiYp4riW7+kH+AxBbp981KwCjAzR9JbcIZIsF0aoBdUMg8B4YzIRe+ImtNQlBJQK8viqyZhIZ+s+zvMgrBF2+Hw1E3EiO15yRg7iLFhhmCNlVEKQKrJ+o8IspT6NOgvsQjafmSo/rNQom9I272gpDeh7LhnchKc8GmCvnYx43FGkkUbUFUGFtjq8XenkDsLD14iAHZ/Z9OYNb3ZVF1cyzOdyy11scCoNxYLYYoSkTEOIjJHAb8uFNmNB1p+OZv29HTPdVE5JDtsBRBc0bRXt7t+MwTuY+vIinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdXD7BcRhMXZ2AaqHVINHETP5vTM8yVcghtNkAXs1kk=;
 b=oB67Wqzs6pmxLB0wzLqJNKCTZ+w2EBiSC6Oq2n4B8A4cOSAI4HRd7jGeg4XZkaUKv6NfDUPG3gMmEda/hiPpfIQDGp1eTkGyyDhMvrIANW2UfK3e2iu8C6Rymfw6hMSmpakM+9te4bZWd/W0W3cvE9uW4oQ6h1IbtlQAJcW33YVuzeQxnq5N/ZuxJ6zDiyX4p6+Hp7sbnlkhYleaRmrkQa4A64XN5DBggfmjA2onndEXyPDCWMUDVjju+eeiUPx37E/dy2bvC5bCRiGH3tpT41ZWgfxJa5loGf3TB7uYGp2Kkbww6Z4RYcbfI0GRlVdbjCzuDv0ItT2mf7bm+8wZMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL0PR12MB4705.namprd12.prod.outlook.com (2603:10b6:208:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Mon, 7 Feb
 2022 04:27:14 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::1528:82a2:aa0:7aa6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::1528:82a2:aa0:7aa6%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 04:27:13 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     Felix.Kuehling@amd.com, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com,
        willy@infradead.org, alex.sierra@amd.com, jhubbard@nvidia.com,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH v2 0/3] Migrate device coherent pages on get_user_pages()
Date:   Mon,  7 Feb 2022 15:26:45 +1100
Message-Id: <cover.0d3c846b1c6c294e055ff7ebe221fab9964c1436.1644207242.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c481c9bb-c437-48ee-432f-08d9e9f21d5e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4705:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4705FC35475EA7129B69BC3ADF2C9@BL0PR12MB4705.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c70CJ0r61acTppJ1c8FoH9eG0LEIvCEJGVzdra8OgyMC/aeSXUosLof2LJe4RjOGm2CccAL8WGYsu4JhZujMV8JajC62JbK3ueAjI61NHFCBK4aA/7pTt/vIWuX2PKI5jeTmgegr+RTL/nf9TSWfTbpPdNn5RGDRle76OOCBuklKtu+auHFHaXbBKorpwBDREezAV0X7ZDKuvX2EDJON6lW/Re15WS31Vc9vE2CmC+943mQFNhv3e6V9tvcvgiTlCTsVMhUUdmOyRC8gHaoVpirMwkmECjpuVmNnfswfYoP919vcJ5Jdr4ELVtot2EVELqe5C7Uo9naBzPdYebYvLr2geykCjeYDbm0sA6+w23+95v6D8FrGWy6uNhTNCNT6j19+MHBxp+V/ZngephI2qC++kG6SjtQXhCEMeCBNo7n9r9YI2WcEp+5XFzowXnRI3++fGEQMEoUapeZJ0qWl43mxJYHi+dwI7Kecnjy8GKUoR4vfatv6c9a/4fkE7KKF3Jy77Ao57cavN0oJ17WGi/mcCfo1i9Cod67cTSVfD5UXoharOkv8DD72OhApHJJBe3wRngJQ/jtTZOz4lm4amVAgyFpYzbZ8rB0/N4uhgidra8H39a0FqN4jT8ktTAmEXoFhP/MydoSYqoqIwBjyg6K73nhxKbwW1ZXCN8DQLOodob1/4MRrwPnwcPm3GwcUDLTALpwwjce+j1qT50SaEIn82upjr0aJZxlauTtzRRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(107886003)(6486002)(2906002)(508600001)(26005)(186003)(6666004)(6506007)(2616005)(6512007)(316002)(966005)(66946007)(8936002)(36756003)(83380400001)(7416002)(38100700002)(5660300002)(4326008)(66476007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwJAMdTcBFuDl7fbSY9Jd9LJfX/pSRPgWDGSrX5/EyI/dZaOZcD7XQXJ4+pi?=
 =?us-ascii?Q?sbAez9/NCQITwwhZfCzt8oTDNsAt5hftLiLBqV/Qmzf4cZYCfyH4DmO8aGbx?=
 =?us-ascii?Q?Nx8Gc3KaIrxfxQ8ZO/VKQswVclV8gVoIHZzp8YVgAHYflXewXuB9PMqL0ilU?=
 =?us-ascii?Q?BrTj4ITrZ1SO16oN/FtIHwk2q3oMOR2s208cQiiMK0Qq+Tqw7RtLqibjQ0h6?=
 =?us-ascii?Q?2M7Un5RhBymH6KCwcYNtbDccRsvyPMrjl4quouXP+BqkjpP4sbIWdzKKPfDe?=
 =?us-ascii?Q?oKLXR0H1y6CPTKlx6yky6fCN1U1m0up0FzjjJlXooBI5nXCD3BPTaq9Atvlu?=
 =?us-ascii?Q?OoJIlIoJh+LCjzhhgA1cyFuobNGRjfHhBhQgp/8GulgNOPt+vxEhr58BRrsh?=
 =?us-ascii?Q?RrPRUbo3I96I9mycMHcfdsFKrWCunOcilMBIUuAtWS1UfOJJ1OtnkFASel/Z?=
 =?us-ascii?Q?cRkCVToXEDNAU2EECgU9fuPyOjLX9+d8J9ablfpLHa1S4e3exnGW4eLvZIk1?=
 =?us-ascii?Q?YmAR6+JBGWc0i0YKBPChoMpl8lmu5PGWhMT5xlSGnxlXv9SjvIqz4lZvTBjA?=
 =?us-ascii?Q?wty+bWkzmLxR2sUzkWdkRLJ5OBu3A9NIk9EbR7bQYuSylpyfpbAWjeEUWkuL?=
 =?us-ascii?Q?xSkMVLVmwcmRR7citYmtQ7VH0/266zA5umzhBu2h821592iEgy0zXlGC/xZ8?=
 =?us-ascii?Q?ediKvI2SAyz0X2YCcPAC9cgGNXiIaqg+vD2xR4F5PfNnACRYBxN6kgfeV21l?=
 =?us-ascii?Q?v4ttK0MaXk3wEBj3ONuCPl/bpXSXeEyvwNPM1SC6OxDLGLf/uwi2fbjKiHvn?=
 =?us-ascii?Q?D0T8yvkKHbdXSkObLo0tZygG8QicPKCCdptDQmhyGUYNXoXHSTLwZYrX6UXk?=
 =?us-ascii?Q?x0Y7iBaY0NYPOiTnlZSCUc+BFn1bxAb1S/dtbtCcY2syDg0eyOzPok4JW7O4?=
 =?us-ascii?Q?FgtP0EF2ukFBEZLyyXguogCFF2BDjlxgmJTCnDm6B4qz+/7Qg9Z2tEQTh1gQ?=
 =?us-ascii?Q?HE5oF+aI8Mim7vrc1S5VQpJXcDVq5AeTr5KtlF6CCjVY+/tdfgK8+It4Q6AN?=
 =?us-ascii?Q?QcdDqTucRJWykGoZqZvY49bpOSCEP1TmCllJAGbqKPUuHT1yM6ooeHWC9KBX?=
 =?us-ascii?Q?16cF34hQvUHYWL0qOrtKJhoid+LNnmPttTWsf9Xyr/qgYW1RQDcY5K0w8rIv?=
 =?us-ascii?Q?SkCUbkkEjbUlbu6po/NXfRFpdIdKKIBvAMUNIqxaDULnCO0/A/Q1nsp0YPRs?=
 =?us-ascii?Q?dFFFzbLKLkpanq3qlFWcbauX98ReJyFG9tiXWt8Qyhncp8JGP5cyk690LbZk?=
 =?us-ascii?Q?CmM2ja/HPsYDuQBcCyawYXIn10FDZkM7Harr05SZ4Xwmm7sWpbaUEJnarA6X?=
 =?us-ascii?Q?oPy1etiyi6G0y3F4pXg0RWlLhZQd+mTz68T3WmcD1++uwuUupcouMdgsEG32?=
 =?us-ascii?Q?3NlOdM9FAUODGH5dVdnqOs7rtv0n+Ij4yoyCWOE5W0NtSVhBHjWP5JQsHlFZ?=
 =?us-ascii?Q?aGrE1Kzj/gyt2uAqfHrjQUS4EiZMAtk1rfLHsz1aadT6pLxadmb2R4kihQbD?=
 =?us-ascii?Q?MiaOuE7oqbBCjKBarN7fj5ZJKaSDaza7619FZFPNHMSjM4X4JNi/VzxS65Z8?=
 =?us-ascii?Q?svfKaAWb8Yw/jwuJQsSr8Fk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c481c9bb-c437-48ee-432f-08d9e9f21d5e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 04:27:13.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdUowcG5C0QfD57n+57YC21fXY76ph9j61SwGZtvqIA9iYWZTpCe09PwR2ut/01IiloVw77MdZOCobQd2xiNBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4705
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Device coherent pages represent memory on a coherently attached device such
as a GPU which is usually under the control of a driver. These pages should
not be pinned as the driver needs to be able to move pages as required.
Currently this is enforced by failing any attempt to pin a device coherent
page.

A similar problem exists for ZONE_MOVABLE pages. In that case though the
pages are migrated instead of causing failure. There is no reason the
kernel can't migrate device coherent pages so this series implements
migration for device coherent pages so the same strategy of migrate and pin
can be used.

This series depends on the series "Add MEMORY_DEVICE_COHERENT for coherent
device memory mapping"[1] which is in linux-next-20220204 and should apply
cleanly to that.

[1] - https://lore.kernel.org/linux-mm/20220128200825.8623-1-alex.sierra@amd.com/

Changes for v2:

 - Rebased on to linux-next-20220204

Alex Sierra (1):
  tools: add hmm gup test for long term pinned device pages

Alistair Popple (2):
  migrate.c: Remove vma check in migrate_vma_setup()
  mm/gup.c: Migrate device coherent pages when pinning instead of failing

 mm/gup.c                               | 105 +++++++++++++++++++++++---
 mm/migrate.c                           |  34 ++++----
 tools/testing/selftests/vm/Makefile    |   2 +-
 tools/testing/selftests/vm/hmm-tests.c |  81 ++++++++++++++++++++-
 4 files changed, 194 insertions(+), 28 deletions(-)

base-commit: ef6b35306dd8f15a7e5e5a2532e665917a43c5d9
-- 
git-series 0.9.1
