Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B43BC2A3
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jul 2021 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGEScD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 14:32:03 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:48032
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229743AbhGEScD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 5 Jul 2021 14:32:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4OavroDbaWaXznatrQXlZ+5oKJRZSTwMR8+uUoIENMe6H0a5os45eykvD/GVeOBzMWe9bkreIzjoZtMyRQr6sM1ihltArCd0mBHT+kU0Z6qMNPbyZfCzTAk4UEEWkMvj2/OQnNej9shEZtbus+jbrpq+7eJI5l0nvIlOVOcQ5CEn26ZYfAqyeiv4fBvsKzcWaEpjqSM46zm1Uc7WvCqkfzTh6lHXYeaX2z093/nyJb6vnq7LLevwemgN9iY7sHsgQyr3z2tKp7whE724QpPuzjCZ+E5lAkk4ZmJZAey6O7ZMw7dy0XjS0G1YNVmjmwydBiW6SZFGnQgI5VtKQcvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iyaKIV9TRVAmn4UC8K2tDsruVUCNFDkhgKBNH0b0bU=;
 b=MbdQakcxA0gYevnYNnHCThcBJiH/3jxVfq8Tkw03+PVSxtyL0MVTofDEFT3Au2Y7aa4Pe6Hut0rSrOc8hN5Vmi2zLQfyOVz63svCXVZLUyBynU4rouiJppP7EQw4KbwNmjyoDzGHlwXTqJXGYrbhyAtPt9oYu11Wj5l5N3aIurD7WfSZnjKM9XBiVXYdFgEpsjx4v6Ulk6dbghNguSSZUlFIxN+BFdh7RWVMOT3/nXvG/cjFkl8R859Eagq7T0IrpCLw5u6ld+KNrpTZ8/Cm7+gNCpHVLzI6xDRSONmVal5e2VhAL0HPVc/9JcoC0DATxY8x5Ygau+DXbPLsgoGKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iyaKIV9TRVAmn4UC8K2tDsruVUCNFDkhgKBNH0b0bU=;
 b=Ahblbz/3I9ytKVnQh7N1EcTlUwR3XLzBoJAznwpafgfnQ5UnnL5J96MenGCdOJPRap4BKdEprofGN8gmpRdV/+QpomIX/6nxJJ9ItnAC/Pvx+CXdDLUg3AmxRZvBtcSBXdt+N4RiUqcNOGV9UgO9gZL0GNNpEC5vpC5yW/MQXJb6pFMnV8gnRUjfIiGEE2H4MhUV0RgQK71a6TTh1DYwEV6q8RzwgIi8Z6GOqhu2i3bLR7Do7xYSPMo5E3hYUiwcU1rIQcvB69CBqS/QEPcxAyDT9p2nr9qohNUdz2RiMnr62cWFedcq7pyJvM3G4vqMscFqopB69u9EaKhjt/9rHQ==
Received: from BN0PR04CA0146.namprd04.prod.outlook.com (2603:10b6:408:ed::31)
 by BN6PR1201MB2481.namprd12.prod.outlook.com (2603:10b6:404:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.32; Mon, 5 Jul
 2021 18:29:23 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::d4) by BN0PR04CA0146.outlook.office365.com
 (2603:10b6:408:ed::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Mon, 5 Jul 2021 18:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 18:29:23 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Jul
 2021 18:29:20 +0000
Subject: Re: [PATCH -v2] ext4: inline jbd2_journal_[un]register_shrinker()
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huawei.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <3acc3ee6-3a3d-3b26-7580-b20955270913@huawei.com>
 <20210705145025.3363130-1-tytso@mit.edu>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <ecd3fa6b-7b49-74b8-cdfa-a1f00d92ec51@nvidia.com>
Date:   Mon, 5 Jul 2021 19:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210705145025.3363130-1-tytso@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c93ce869-c649-47fa-ca62-08d93fe2d01a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2481:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB248156A76E82CECFF30CCAA7D91C9@BN6PR1201MB2481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFlU8mghsEpkCr/2M0f5DLwzYlHzc9SUm5H8GUCTne6hhSzfR+u3cfS5tnPrKq1NpoY+LMZn0WZOL9JIDMTkunpPT11JgbbiYsTIpxh5DDYWYZxYMOVEOZhLiKPfPfpXIDofsNPDKdtjJYPJhdWCMrshy9CoXmVPfv+8BJwXriDycgAagas4xUAnouDaXDnPydOS38Ypz20SnUQdsSaovzVi/QeDo8KleKV+Mzy/ktWoONUmFO0phfeDi2KwO+lNfFEhm5Z0yXsDRMM5cJS0pq8l89q443nohzZvHy4joKkuWvmKdAIzD3EjUKJYBNLXQBnVYN8XjVl19pIRnEqkZAeuwxkiHqJAgOg5gl59vyQ5PL8PX0go3jgc9PowbX7x5YqNfuqg7un8t7g151Y7LKUycKOHKeDzIPttYVT6NfmZevbFYyaoO3+kdnOLpTcBu+0d+lFxCS9Y6ynVD+ArpjxkcbA6dl8Uki9vfmnX1ph06oGmdvNyItXODNlkq4IoHoJRLg7D9+oTFztfG2XQxKyN7qiLxnHAxY3ovilCDkUpqvDgasYKJpQqDZ407xkTTMbhqb9rdLsV1I0nIrI76Dqgj8GwbMUAzXLLF4DokQQysKUuRKSorUYGBlQIStwWAGmELQ4nqa9K9i5Z5MBct/NZGYEDdoHMqujN7lwSGIJNTPZZerqoCiawuWdP/b/L4mQawad5tZp7eNnxBrwUG5Es2lSu+SQJtYCH6JsuMZ0=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(47076005)(86362001)(82740400003)(53546011)(4326008)(356005)(70586007)(478600001)(336012)(54906003)(316002)(2616005)(2906002)(426003)(110136005)(36906005)(8936002)(70206006)(16576012)(31696002)(8676002)(16526019)(82310400003)(36860700001)(7636003)(31686004)(26005)(186003)(36756003)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 18:29:23.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93ce869-c649-47fa-ca62-08d93fe2d01a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2481
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 05/07/2021 15:50, Theodore Ts'o wrote:
> The function jbd2_journal_unregister_shrinker() was getting called
> twice when the file system was getting unmounted.  On Power and ARM
> platforms this was causing kernel crash when unmounting the file
> system, when a percpu_counter was destroyed twice.
> 
> Fix this by removing jbd2_journal_[un]register_shrinker() functions,
> and inlining the shrinker setup and teardown into
> journal_init_common() and jbd2_journal_destroy().  This means that
> ext4 and ocfs2 now no longer need to know about registering and
> unregistering jbd2's shrinker.
> 
> Also, while we're at it, rename the percpu counter from
> j_jh_shrink_count to j_checkpoint_jh_count, since this makes it
> clearer what this counter is intended to track.
> 
> Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Thanks, works for me.

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
