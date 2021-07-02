Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374F03B9E94
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jul 2021 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhGBKAR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jul 2021 06:00:17 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:38881
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhGBKAP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Jul 2021 06:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncBAYpY3no1NOjZ7JTrcxz8lG3VBnmfHAxJxhFFBk6HciQoVsYUPERbnQpWuF/XtQZwBGF75W30Ue4erI2WW1An4Qjk3NIoXGE6vmvkGNIeGGosT4qlcq90dp/GRNF3YIxnLGX+phjSi1EBTN2e+kL2hPKy3Ujmg2TC0u4PVoLlBuawDIpDktPsvAxgk8PRA/SgUQcPYzPaw8dXgUvB2VgodRqz41jjeVjif+rp5hl7u8TBG4lwmX8y6aI6DU0L3B/5cpyX7R0ISfpvQRT8tuUEpK95xPPTsVsv4+m19WYzXei3xUvy88bvYxe3hjqnT/hiRWAuWJGtDplY7Q8l2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG2tFIMmsNNVnVuHS71YoFyiAdvB8pwnEhUm434J+Ic=;
 b=BoBuy+tdlvmg7ee1YBtC3pq/Z/39Xp4K0yBN/sygazQF4mgAVZTmKOBUD34InSaO8tY7sx7erSND+r3uZ9CYnPCsmR+ofvneaCTtHly095jjWpHDHYP+lbVItaCbj3jbxqHLqsRuaw3KKkgBFtwuJVE1S5MLcl/oRAwm5TT9X0leZVzeWom9m9IS7ddU35B29NkkiCXwX4IYJEe1clQLt7WZaoLSVtz8k1ymDKfl52P5V5cZ5eUb0sdWuGTRi08Z0PmSGBU04iTYANy/W1W9+9RBr4xMAodLiTDONw4Dx33ULCjDrut7+ov0t9cVo03CPKx7a2fA+1zYnqVm1jeCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG2tFIMmsNNVnVuHS71YoFyiAdvB8pwnEhUm434J+Ic=;
 b=q7ullNZLNtf8ulUxMls/KgUMMCXqjkQJjxYlEqJV5zC1A65pWB9TTkCIZ6EFXLQKCav9H6uTgUmMe+fOPJGml8MLb3hqZnnjipc8WeW5gaJY3yIGbJS+EGchOnpzCFg9xH1CHPtxaQzcmMx0p7aAQgCiYsTT4iL7PnxNfcy0T8rW4dbbZxnSWwaNYHbhtusmzNFbXuHE/zwZMVtHEf7ub1+UHB1j1R0ALUhn7uV9nxxRgC2olE6fKBikrz/zeeCZohXLQQoc51D+1BE2fA1Ne/PGr0sYNpzbaQhnKxsOCpVP/JkxKXs6dR+Zqmh1iurydR6V7Mb6fD4B9gfv0Y6fyQ==
Received: from MW4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:303:b7::12)
 by BN8PR12MB3393.namprd12.prod.outlook.com (2603:10b6:408:46::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 2 Jul
 2021 09:57:41 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::8c) by MW4PR03CA0097.outlook.office365.com
 (2603:10b6:303:b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23 via Frontend
 Transport; Fri, 2 Jul 2021 09:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 09:57:41 +0000
Received: from [10.26.49.10] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 2 Jul
 2021 09:57:39 +0000
Subject: Re: [GIT PULL] ext4 updates for v5.14
To:     Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YNzY12HgR4UViC4/@mit.edu>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <87ade24e-08f2-5fb1-7616-e6032af399a3@nvidia.com>
Date:   Fri, 2 Jul 2021 10:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNzY12HgR4UViC4/@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1f342b7-fb84-4bd5-f7ce-08d93d3fd518
X-MS-TrafficTypeDiagnostic: BN8PR12MB3393:
X-Microsoft-Antispam-PRVS: <BN8PR12MB33937C1B844D896C4F227C98D91F9@BN8PR12MB3393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap2kaSuS4idnSkPk5DTqoK+/aHcfLC4SKod/xw98YjvgyZV/1uO7le+tVlx+fzaGxb5aZX4Fku17E+tZyVIvNFQG9SBdmE8w54ajVIYZtl1plI1guxo85vvJjtBZbt2cS5xOBusorptotUJTyaio+aiQ12ysyKWaHsxYBhV1srfKtYfv7d+gBwUsxLOWQR1TJiLcIzq1ZiUo1YvNiVPsUGaqTZKk0f1H5BjoFPAnQ2MvaGSG+Bzq+wto8P+DqphxED25N8Lbzu8Uu4TxXwAVgcVz9x+D6BX6Vx8FmYH8qZLHOiD959BL8/SRPyeHIi9INpELKdMiAB0iutiTSxx+NyMwXPUeYZVgNdRPRkjU4kVlt5DewSthb2HNzk4+UkZ9035ANYxKj/igmOrkdF7bo/tH5GWTTAfZAJ9cE0fVTyJfaXe4GI2AU3udAhdbvTJaSP9MZoek3TLlWp9eD1ZoQ6EDN3UAPrNc7yPVGgugz+d2+H4213QZlo0nhdrZn8WYuGSAEEY/86sVjkpuV3OBanaA3sCl8cW0Vt2PPgVm4ntBchZkYo3X4BRX4wJ1Nt/HoeIMFKD+q0MyNj22UxrE7LIyeWblBdmjw2N3yq7Jwj/NVe+Gg7qWmfnUJvytXIquqLutDuhv4MHMjDJ9D28oPgzYhuY5+NT01z2QQu+J+AxI2oJ0YDHyY1ZWy/sweeckMuTw5mGyEVb4aUSP6jt/TDY7797HtMrYdrsyFCq/cnECHOZ7P03FPC2aTbHaf6YfkZ2DZIs+hCqCm1QtiGUaYw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(16526019)(186003)(86362001)(83380400001)(36756003)(7636003)(5660300002)(110136005)(82740400003)(26005)(356005)(31686004)(336012)(53546011)(2616005)(8676002)(426003)(31696002)(82310400003)(16576012)(36860700001)(70206006)(70586007)(47076005)(4326008)(15650500001)(316002)(478600001)(54906003)(45080400002)(8936002)(36906005)(2906002)(43740500002)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 09:57:41.5903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f342b7-fb84-4bd5-f7ce-08d93d3fd518
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3393
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted, Zhang,

On 30/06/2021 21:49, Theodore Ts'o wrote:
> The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:
> 
>   Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus
> 
> for you to fetch changes up to 16aa4c9a1fbe763c147a964cdc1f5be8ed98ed13:
> 
>   jbd2: export jbd2_journal_[un]register_shrinker() (2021-06-30 11:05:00 -0400)
> 
> ----------------------------------------------------------------
> In addition to bug fixes and cleanups, there are two new features for
> ext4 in 5.14:
>  - Allow applications to poll on changes to /sys/fs/ext4/*/errors_count
>  - Add the ioctl EXT4_IOC_CHECKPOINT which allows the journal to be
>    checkpointed, truncated and discarded or zero'ed.
> 
> ----------------------------------------------------------------

...

> Zhang Yi (12):
>       ext4: cleanup in-core orphan list if ext4_truncate() failed to get a transaction handle
>       ext4: remove check for zero nr_to_scan in ext4_es_scan()
>       ext4: correct the cache_nr in tracepoint ext4_es_shrink_exit
>       jbd2: remove the out label in __jbd2_journal_remove_checkpoint()
>       jbd2: ensure abort the journal if detect IO error when writing original buffer back
>       jbd2: don't abort the journal when freeing buffers
>       jbd2: remove redundant buffer io error checks
>       jbd2,ext4: add a shrinker to release checkpointed buffers


I have noticed that with next-20210701 that one of our eMMC tests
started failing on all our ARM and ARM64 platforms and bisect is
pointing to commit 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to
release checkpointed buffers"). Today I am seeing the same failure
on the mainline.

Looking at the kernel logs I see the following crash ...

[   74.430365] Unable to handle kernel paging request at virtual address ffff8001e353a000
[   74.438304] Mem abort info:
[   74.441110]   ESR = 0x96000005
[   74.444226]   EC = 0x25: DABT (current EL), IL = 32 bits
[   74.449548]   SET = 0, FnV = 0
[   74.452595]   EA = 0, S1PTW = 0
[   74.455740]   FSC = 0x05: level 1 translation fault
[   74.460620] Data abort info:
[   74.463504]   ISV = 0, ISS = 0x00000005
[   74.467343]   CM = 0, WnR = 0
[   74.470314] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081adc000
[   74.477013] [ffff8001e353a000] pgd=10000002771ff803, p4d=10000002771ff803, pud=0000000000000000
[   74.485718] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[   74.491284] Modules linked in: tegra_drm snd_soc_tegra186_dspk cec snd_soc_tegra210_dmic snd_soc_tegra210_admaif snd_soc_tegra_pcm snd_soc_tegra210_i2s drm_kms_helper drm snd_soc_tegra210_ahub tegra210_adma crct10dif_ce snd_hda_codec_hdmi snd_soc_tegra_audio_graph_card snd_soc_audio_graph_card snd_hda_tegra snd_soc_simple_card_utils snd_hda_codec at24 tegra_bpmp_thermal snd_hda_core tegra_aconnect tegra_xudc ina3221 host1x ip_tables x_tables ipv6
[   74.530804] CPU: 0 PID: 936 Comm: umount Tainted: G S                5.13.0-next-20210701-gfb0ca446157a #1
[   74.540446] Hardware name: NVIDIA Jetson TX2 Developer Kit (DT)
[   74.546354] pstate: a0000005 (NzCv daif -PAN -UAO -TCO BTYPE=--)
[   74.552354] pc : percpu_counter_add_batch+0x30/0x118
[   74.557317] lr : __jbd2_journal_remove_checkpoint+0x70/0x170
[   74.562972] sp : ffff800013923b90
[   74.566278] x29: ffff800013923b90 x28: ffff000080ba8d80 x27: 0000000000000000
[   74.573408] x26: 0000000000000001 x25: 0000000000000006 x24: ffff000080ba8d80
[   74.580536] x23: ffff00008965a450 x22: ffff800011ce9000 x21: ffff00008965a380
[   74.587665] x20: ffffffffffffffff x19: ffff00008a9d8000 x18: 0000000000000011
[   74.594792] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000000038d
[   74.601921] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   74.609048] x11: 0000000000000001 x10: 0000000000000960 x9 : ffff800013923b90
[   74.616175] x8 : ffff000080ba9740 x7 : 0000000000000400 x6 : ffff00008965a0b0
[   74.623304] x5 : ffff00008965a0b0 x4 : ffff8001e353a000 x3 : ffff000080ba8d80
[   74.630430] x2 : 0000000000000020 x1 : 0000000000000000 x0 : ffff00008965a380
[   74.637558] Call trace:
[   74.640000]  percpu_counter_add_batch+0x30/0x118
[   74.644610]  __jbd2_journal_remove_checkpoint+0x70/0x170
[   74.649914]  jbd2_log_do_checkpoint+0xa8/0x398
[   74.654351]  jbd2_journal_destroy+0x100/0x2a8
[   74.658703]  ext4_put_super+0x7c/0x388
[   74.662449]  generic_shutdown_super+0x70/0xf8
[   74.666802]  kill_block_super+0x1c/0x60
[   74.670633]  deactivate_locked_super+0x6c/0x98
[   74.675071]  deactivate_super+0x84/0x90
[   74.678901]  cleanup_mnt+0x8c/0x110
[   74.682385]  __cleanup_mnt+0x10/0x18
[   74.685953]  task_work_run+0x78/0x150
[   74.689612]  do_notify_resume+0x31c/0x498
[   74.693618]  work_pending+0xc/0x328
[   74.697103] Code: 11000484 b9000864 d538d084 f9401001 (b8a46833) 
[   74.703186] ---[ end trace e18485293afc06e4 ]---


Is this causing problems for anyone else?

Thanks
Jon

-- 
nvpublic
