Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0E755C1F
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jul 2023 08:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjGQGxh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jul 2023 02:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQGxg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jul 2023 02:53:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A001BC
        for <linux-ext4@vger.kernel.org>; Sun, 16 Jul 2023 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689576806; x=1721112806;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=SWflkA43sQNQDun8UAiOPdRCexcvVHUbpXiUpmMFmlo=;
  b=bRr5hS8eDQTpoHmVIDTik6e3pcjcXdLLn8RRts5yrWVQR40fAbQZJJF2
   MjajJuG8hZLtaO/bmPahN10CFMPZT6kGzyGIgGPqNqNpw83+cXsYmcEk7
   G9rTP77xyZFVXPMaBclS6irFzeRyP87k98uPjGMaujWpTp5AVfipMUHeS
   EXjgH1U2jGI2BJV/p6+/oUusNiQgh+2bsvEqgOVm89JfmCqX/NRc88l04
   fVZlDQhEG2gxUhnauOsswh7o2zhjPqjTsgOJU4sbPCrqEzPyNl67CtXIM
   QtTlA7UzJ0tO6OiC1U/uiESXf/MZt0JQ2q4QZ6Z8Orhtc3Ldpz9gp8xY0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="355795593"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="355795593"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 23:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="758290031"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="xz'341?yaml'341?scan'341,208,341";a="758290031"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2023 23:53:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 23:53:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 23:53:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 23:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKquajFH6Usm8AlCj8PW13a5jpkYxx4IYoqNSzLaVGVWi6ecRgf/o9KPPdUAXNxZEjoQONKjWLB7hxKxX5z/4ngvEQ9/5fyWL7k3dVrePtipUg2psVq281D2dF/7gBcox/HczAkQXenYZP0YF8viMO47VxQxnXRohpLWqRECvKOP7jyD9ylb6uab730dO2EzlbjSBTUKApa49kGMqB0MhVqDQlaYsil6bXMBuPOGQXsbeTJWbY3ASXvUsgMHCm+RjvZIgzPknWWP8D6N97k429xGo7adpd/rp7eLoKxS2RE51pglHe0Ra2vLLN4z7iv/IWlIUcHc9KVZgcOz9lIKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdTXJPdrM3UIL5MXf2x4bE6oDoTbayKs6QsZZ+46yak=;
 b=UCYcrG+8tJ/UDC34+Ngyepzluk+9mL4Q9KlAp+6iUHduMgu10oweL70Fxg0H6zCojHgjclpDSBFyqM7b+maEWjDxQDecUJ+dLTHhW1rSTkF4M8pyp7y3StgkqzdLYZ1SWZ3OO/6VR23uIddNplP3lNUesdcCjo62T1VQQV+klwurQXuJcxTJV5cfFf3sFHChSKDw79wUzph7mG2X5t0jCvT//CioIdLQWOgAHTyoQ1qa3hjNDr89eGSG0L3AlEYTA7adovhpw0534ZfvrNBg6stWMk4/ZtLv7nDCWgaKHSbLBzNORg84T2d3iGMufqjb+eRJtANk/YoPrPii3fb/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH8PR11MB6928.namprd11.prod.outlook.com (2603:10b6:510:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 06:53:10 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 06:53:10 +0000
Date:   Mon, 17 Jul 2023 14:52:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Fengnan Chang <changfengnan@bytedance.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-ext4@vger.kernel.org>, <wangjianchao@kuaishou.com>,
        <tytso@mit.edu>, Fengnan Chang <changfengnan@bytedance.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH] ext4: improve discard efficiency
Message-ID: <202307171455.ee68ef8b-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="s5GG2KMz2+C8vNaT"
Content-Disposition: inline
In-Reply-To: <20230704115613.88313-1-changfengnan@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH8PR11MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9ec1ca-0236-43c9-56e0-08db86927b73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZq6rr51LWQQujVsD3gWc/0jmx0fCfeWBlXX4XAw8pOK4WiXzfdptl4ebrQ1s9Lq1ouvaHg4JYSmeTmGt52LvIS5HBuySvedgYeP7A9leyREyX7tZpRhQTN2CKO+2flGZpbGFTKRv/Gx+mi/HwMBdoO8M9eqyeH83dpyUDRRaihmYvRWj0IXP75uGQkH20BVucFbZaMD5ZnDzN3zLT9DIEkWwcokdAOgZ5gqHx8+4bTeBFG56PR2PSAQH5ffl0e6OgO+AbPmWVE+7sn7XnVCCpll5VgGdtYpqtnBSyqqA7nbvR3+SkNeBgyHBub+QOpFNtDImwG0mNEqn97uL0Gk+gp4G9DbWvNgdVzYQSiAMutPbpdC7PavuNaLPNdLowVMDzcgNQND2mRDzhBUGHhy4QYbms/xrqT5+BFnrcfiSwhpMwpUYEoUNcj2qJsNugvH0sKE72fPQfZTr813VFXRSBCnhqIsajSXdOLzZy0nLT6mOM8dOne2eRGdHunCE1PJfSdLuu0j5IYPobJS//oIQ3b04HJFn3iS49XdeqE61NdG8zp26FH3Ce9ySCDq3J4iLvkbIOHFg/U/EWGM8XJZzKn/DyfChNjSPyGmlVMC1gw7KOiR2HkBfgotOD7cZBo6Nzwyyy+LbtlOC3G+XdxIaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(8936002)(235185007)(5660300002)(30864003)(8676002)(4326008)(6916009)(66476007)(66946007)(66556008)(41300700001)(316002)(2906002)(478600001)(6666004)(6486002)(44144004)(966005)(6512007)(6506007)(26005)(1076003)(107886003)(21490400003)(83380400001)(186003)(36756003)(38100700002)(82960400001)(2616005)(86362001)(2700100001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WanPgDqQhPCz2+ABM11uFnbnFFczOmR9fycNYFBk8BOu9oAIpV3v3ldFTd+x?=
 =?us-ascii?Q?A8oJTGvzsFvRNApLY4WjsvwlvSEQ6Uv6tklPGcI+ks/Ka1eABPSR2rLRefxS?=
 =?us-ascii?Q?1YFBCmVOhMx6j9lL0uHn5LpXEthDB3tH+HIXMd7f+VWh7PHwBxSYVboCNHzx?=
 =?us-ascii?Q?3/N3t/XiFSzeEFD9b4SLo/vXHiX7j0ga3TPY0pm9yRoU9VOQdbZ1HXWA83Id?=
 =?us-ascii?Q?YyrID4/hrEdEJOS4R38zQQYIV/u5C9fR9idNxuSOmjrqgealDq/8mkpWPE1N?=
 =?us-ascii?Q?RCeiy6wog+oVWi4KNYEAaphM63N0qptW24U2g13sxQPP+jxzxc2RP4F7KqJ1?=
 =?us-ascii?Q?wVN0hqtx4fpX2e83Uog6c+M1a/kGPmbVlCJdwU3b2w9nyV/O6ZS0HN8wJ5Mi?=
 =?us-ascii?Q?L/R1HwPceHSj8gUjj50VtxTixAxdCKKZ6cG5jlzt0uzfnc1seMHvYD8bfNe/?=
 =?us-ascii?Q?dUZuMRWxG3QIWVV3l/hOxzSXgHWmGknIlmBp8LDjDre85OK99wDRoPXSjI15?=
 =?us-ascii?Q?dPYBTV5WgGdOA/B4fTbjHXLLaeoX71jAdH2w0TnXEEzAZnR2oGt+18AGbd1p?=
 =?us-ascii?Q?hnKcE/175UpEDc5bImRaqBZu7ikzY80acUEGsLMD5Qe+gbd+E7Swb5ZK7aUA?=
 =?us-ascii?Q?eCWkv1HtNrrDYhqdRWddAOEVJP29iCrC4eRI/Q64Zfp4B4Yfly+nykxLm4A/?=
 =?us-ascii?Q?pkY+0hcOraBrYfif4vfJ01gAHcgjM9hDFaslM0IvW24wV/IpE43t/XNOc0+m?=
 =?us-ascii?Q?Y5pFOC2GQA2hQGp3KjCOirI+ua2NNlvoDHL62S2Wb28P1dl01/ts/RlSfM1X?=
 =?us-ascii?Q?J/UDrlHJRvIK6tPMH9zajANvM60hhutTWtTrKiZ4O6Qh0aisrlOfrvfzTwgF?=
 =?us-ascii?Q?MsT0gtmfgVp73+9BShMhcB3+c/seC+J4N/gARoXyejVcdr3JstzcT4VqcNk7?=
 =?us-ascii?Q?WR6Z5miB53oNn/OVB9dpYtKmVc0R4qkp79WA8Pp+VnCwj7tZNvzSqn+vGNhX?=
 =?us-ascii?Q?9FziHBHqfDLHD6qCxK1iXtuUd41GReiUQN40NgsKog0dS/NXjws9IsBidwLY?=
 =?us-ascii?Q?SHZU8V/ld6B1VxXbFBTuOxtgfOnr3g+P2kl3DzZ7nEoIsXCApaiLA6pFKZuw?=
 =?us-ascii?Q?Rk9fmvNj2muyWllBJCqsUou1I/iP8rM+ejVpui0/shBfk4TZvewIS5DvNacR?=
 =?us-ascii?Q?84xI62o0e2kN5TeiCjLumABCCfqY56Qsdmjygr82Sh8wUchgewRd6SZc5VPe?=
 =?us-ascii?Q?ZkoxR81kec3CIatnicdgEOi1FNyoS7yS4vscQqys8UwklRTqnCfbX4YUIpdH?=
 =?us-ascii?Q?Hk6HMvnz/x6KA8qwvTWygWxzavHvsaScO94THk/9PM/ZwcBL8IvGT2UIqL/x?=
 =?us-ascii?Q?wL/hWnpURn/21rp9qQjmJ13Yw9gs6JkUCXnzK7S5RTljZXUuhYp4Z8j58iAn?=
 =?us-ascii?Q?fYR1f+CVDH5z7edQZ+hZYoZ67C2KkZFTuK2TlHGn5KwkCWXN/lrXIXgb7T/d?=
 =?us-ascii?Q?2f8LSf2zm6g/8RKw2w3wE7RdIdXYeHukzNEpJo3rzujWnKc5Y758/KVS6kQ5?=
 =?us-ascii?Q?8WWTqvzkWTDhQ4kaYTGj5RH2oYhUzwwIFWnBRRwJnepO5KGJG44OiDNw68JG?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9ec1ca-0236-43c9-56e0-08db86927b73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:53:10.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJbl7xCHr6oYKap3mWR9FSR7tIsrYOAL+AY2/ooe1bUfI86ImTT4D7HM/CFGWJlqHn0g6Js4QzNnfOzDw/ZQ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6928
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--s5GG2KMz2+C8vNaT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:

commit: c880a1f2eea1cf05148aa346a46bb9abc34bb436 ("[PATCH] ext4: improve discard efficiency")
url: https://github.com/intel-lab-lkp/linux/commits/Fengnan-Chang/ext4-improve-discard-efficiency/20230704-195738
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20230704115613.88313-1-changfengnan@bytedance.com/
patch subject: [PATCH] ext4: improve discard efficiency

in testcase: xfstests
version: xfstests-x86_64-06c027a-1_20230710
with following parameters:

	disk: 4HDD
	fs: ext4
	test: generic-455



compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202307171455.ee68ef8b-oliver.sang@intel.com


[  159.926031][   T10] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  159.935325][   T10] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u16:0
[  159.944276][   T10] preempt_count: 1, expected: 0
[  159.948980][   T10] RCU nest depth: 0, expected: 0
[  159.953770][   T10] CPU: 6 PID: 10 Comm: kworker/u16:0 Not tainted 6.4.0-rc5-00060-gc880a1f2eea1 #1
[  159.962797][   T10] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  159.971737][   T10] Workqueue: events_unbound ext4_discard_work
[  159.977650][   T10] Call Trace:
[  159.980786][   T10]  <TASK>
[ 159.983579][ T10] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 159.987928][ T10] __might_resched (kernel/sched/core.c:10154) 
[ 159.992533][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 159.997575][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 160.002618][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 160.008095][ T10] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 160.012789][ T10] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 160.018090][ T10] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 160.022611][ T10] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 160.027739][ T10] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 160.032952][ T10] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 160.037735][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 160.043302][ T10] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 160.048168][ T10] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 160.053033][ T10] ? strscpy (lib/string.c:158) 
[ 160.057042][ T10] process_one_work (kernel/workqueue.c:2410) 
[ 160.061829][ T10] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 160.066359][ T10] ? process_one_work (kernel/workqueue.c:2495) 
[ 160.071405][ T10] kthread (kernel/kthread.c:379) 
[ 160.075321][ T10] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 160.080797][ T10] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  160.085062][   T10]  </TASK>
[  160.975678][   T67] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  160.984975][   T67] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 67, name: kworker/u16:5
[  160.993917][   T67] preempt_count: 1, expected: 0
[  160.998624][   T67] RCU nest depth: 0, expected: 0
[  161.003414][   T67] CPU: 5 PID: 67 Comm: kworker/u16:5 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  161.013914][   T67] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  161.022855][   T67] Workqueue: events_unbound ext4_discard_work
[  161.028766][   T67] Call Trace:
[  161.031904][   T67]  <TASK>
[ 161.034695][ T67] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 161.039043][ T67] __might_resched (kernel/sched/core.c:10154) 
[ 161.043651][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 161.048691][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 161.053731][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 161.059204][ T67] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 161.063899][ T67] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 161.069201][ T67] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 161.073730][ T67] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 161.078860][ T67] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 161.084083][ T67] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 161.088861][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 161.094423][ T67] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 161.099288][ T67] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 161.104156][ T67] ? strscpy (lib/string.c:158) 
[ 161.108161][ T67] process_one_work (kernel/workqueue.c:2410) 
[ 161.112952][ T67] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 161.117485][ T67] ? process_one_work (kernel/workqueue.c:2495) 
[ 161.122531][ T67] kthread (kernel/kthread.c:379) 
[ 161.126448][ T67] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 161.131922][ T67] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  161.136186][   T67]  </TASK>
[  162.184131][   T10] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  162.193393][   T10] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u16:0
[  162.202314][   T10] preempt_count: 1, expected: 0
[  162.207007][   T10] RCU nest depth: 0, expected: 0
[  162.211783][   T10] CPU: 6 PID: 10 Comm: kworker/u16:0 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  162.222249][   T10] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  162.231160][   T10] Workqueue: events_unbound ext4_discard_work
[  162.237074][   T10] Call Trace:
[  162.240219][   T10]  <TASK>
[ 162.243009][ T10] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 162.247358][ T10] __might_resched (kernel/sched/core.c:10154) 
[ 162.251967][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 162.257008][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 162.262047][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 162.267520][ T10] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 162.272215][ T10] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 162.277515][ T10] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 162.282035][ T10] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 162.287164][ T10] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 162.292382][ T10] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 162.297165][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 162.302725][ T10] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 162.307600][ T10] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 162.312464][ T10] ? strscpy (lib/string.c:158) 
[ 162.316468][ T10] process_one_work (kernel/workqueue.c:2410) 
[ 162.321251][ T10] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 162.325783][ T10] ? process_one_work (kernel/workqueue.c:2495) 
[ 162.330831][ T10] kthread (kernel/kthread.c:379) 
[ 162.334745][ T10] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 162.340220][ T10] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  162.344490][   T10]  </TASK>
[  163.242344][   T10] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  163.251636][   T10] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u16:0
[  163.260575][   T10] preempt_count: 1, expected: 0
[  163.265273][   T10] RCU nest depth: 0, expected: 0
[  163.270059][   T10] CPU: 3 PID: 10 Comm: kworker/u16:0 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  163.280550][   T10] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  163.289490][   T10] Workqueue: events_unbound ext4_discard_work
[  163.295404][   T10] Call Trace:
[  163.298546][   T10]  <TASK>
[ 163.301348][ T10] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 163.305706][ T10] __might_resched (kernel/sched/core.c:10154) 
[ 163.310322][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 163.315370][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 163.320412][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 163.325882][ T10] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 163.330581][ T10] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 163.335891][ T10] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 163.340414][ T10] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 163.345526][ T10] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 163.350731][ T10] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 163.355500][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 163.361049][ T10] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 163.365908][ T10] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 163.370760][ T10] ? strscpy (lib/string.c:158) 
[ 163.374748][ T10] process_one_work (kernel/workqueue.c:2410) 
[ 163.379521][ T10] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 163.384048][ T10] ? process_one_work (kernel/workqueue.c:2495) 
[ 163.389094][ T10] kthread (kernel/kthread.c:379) 
[ 163.393012][ T10] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 163.398486][ T10] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  163.402751][   T10]  </TASK>
[  164.657543][   T67] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  164.666838][   T67] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 67, name: kworker/u16:5
[  164.675784][   T67] preempt_count: 1, expected: 0
[  164.680483][   T67] RCU nest depth: 0, expected: 0
[  164.685272][   T67] CPU: 5 PID: 67 Comm: kworker/u16:5 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  164.695768][   T67] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  164.704695][   T67] Workqueue: events_unbound ext4_discard_work
[  164.710586][   T67] Call Trace:
[  164.713713][   T67]  <TASK>
[ 164.716496][ T67] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 164.720830][ T67] __might_resched (kernel/sched/core.c:10154) 
[ 164.725422][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 164.730446][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 164.735470][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 164.740925][ T67] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 164.745612][ T67] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 164.750895][ T67] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 164.755408][ T67] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 164.760526][ T67] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 164.765729][ T67] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 164.770496][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 164.776042][ T67] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 164.780891][ T67] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 164.785746][ T67] ? strscpy (lib/string.c:158) 
[ 164.789750][ T67] process_one_work (kernel/workqueue.c:2410) 
[ 164.794540][ T67] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 164.799061][ T67] ? process_one_work (kernel/workqueue.c:2495) 
[ 164.804107][ T67] kthread (kernel/kthread.c:379) 
[ 164.808024][ T67] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 164.813496][ T67] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  164.817759][   T67]  </TASK>
[  165.743793][   T10] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  165.753057][   T10] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u16:0
[  165.761979][   T10] preempt_count: 1, expected: 0
[  165.766669][   T10] RCU nest depth: 0, expected: 0
[  165.771444][   T10] CPU: 5 PID: 10 Comm: kworker/u16:0 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  165.781912][   T10] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  165.790823][   T10] Workqueue: events_unbound ext4_discard_work
[  165.796717][   T10] Call Trace:
[  165.799842][   T10]  <TASK>
[ 165.802627][ T10] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 165.806973][ T10] __might_resched (kernel/sched/core.c:10154) 
[ 165.811572][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 165.816598][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 165.821621][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 165.827076][ T10] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 165.831764][ T10] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 165.837058][ T10] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 165.841573][ T10] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 165.846693][ T10] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 165.851899][ T10] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 165.856673][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 165.862224][ T10] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 165.867082][ T10] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 165.871935][ T10] ? strscpy (lib/string.c:158) 
[ 165.875926][ T10] process_one_work (kernel/workqueue.c:2410) 
[ 165.880700][ T10] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 165.885220][ T10] ? process_one_work (kernel/workqueue.c:2495) 
[ 165.890252][ T10] kthread (kernel/kthread.c:379) 
[ 165.894164][ T10] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 165.899621][ T10] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  165.903880][   T10]  </TASK>
[  166.946743][   T67] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  166.956022][   T67] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 67, name: kworker/u16:5
[  166.964945][   T67] preempt_count: 1, expected: 0
[  166.969637][   T67] RCU nest depth: 0, expected: 0
[  166.974415][   T67] CPU: 7 PID: 67 Comm: kworker/u16:5 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  166.984880][   T67] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  166.993795][   T67] Workqueue: events_unbound ext4_discard_work
[  166.999692][   T67] Call Trace:
[  167.002823][   T67]  <TASK>
[ 167.005616][ T67] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 167.009960][ T67] __might_resched (kernel/sched/core.c:10154) 
[ 167.014562][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 167.019597][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 167.024633][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 167.030100][ T67] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 167.034789][ T67] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 167.040078][ T67] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 167.044592][ T67] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 167.049711][ T67] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 167.054917][ T67] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 167.059692][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 167.065241][ T67] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 167.070101][ T67] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 167.074964][ T67] ? strscpy (lib/string.c:158) 
[ 167.078959][ T67] process_one_work (kernel/workqueue.c:2410) 
[ 167.083737][ T67] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 167.088253][ T67] ? process_one_work (kernel/workqueue.c:2495) 
[ 167.093284][ T67] kthread (kernel/kthread.c:379) 
[ 167.097194][ T67] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 167.102658][ T67] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  167.106913][   T67]  </TASK>
[  168.645402][   T67] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  168.654693][   T67] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 67, name: kworker/u16:5
[  168.663643][   T67] preempt_count: 1, expected: 0
[  168.668348][   T67] RCU nest depth: 0, expected: 0
[  168.673136][   T67] CPU: 7 PID: 67 Comm: kworker/u16:5 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  168.683629][   T67] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  168.692553][   T67] Workqueue: events_unbound ext4_discard_work
[  168.698447][   T67] Call Trace:
[  168.701575][   T67]  <TASK>
[ 168.704360][ T67] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 168.708697][ T67] __might_resched (kernel/sched/core.c:10154) 
[ 168.713290][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 168.718314][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 168.723339][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 168.728792][ T67] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 168.733473][ T67] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 168.738758][ T67] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 168.743266][ T67] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 168.748386][ T67] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 168.753590][ T67] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 168.758360][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 168.763902][ T67] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 168.768753][ T67] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 168.773606][ T67] ? strscpy (lib/string.c:158) 
[ 168.777596][ T67] process_one_work (kernel/workqueue.c:2410) 
[ 168.782364][ T67] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 168.786873][ T67] ? process_one_work (kernel/workqueue.c:2495) 
[ 168.791907][ T67] kthread (kernel/kthread.c:379) 
[ 168.795809][ T67] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 168.801269][ T67] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  168.805528][   T67]  </TASK>
[  169.871290][   T68] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  169.880553][   T68] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 68, name: kworker/u16:6
[  169.889475][   T68] preempt_count: 1, expected: 0
[  169.894166][   T68] RCU nest depth: 0, expected: 0
[  169.898943][   T68] CPU: 4 PID: 68 Comm: kworker/u16:6 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  169.909410][   T68] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  169.918344][   T68] Workqueue: events_unbound ext4_discard_work
[  169.924255][   T68] Call Trace:
[  169.927394][   T68]  <TASK>
[ 169.930186][ T68] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 169.934538][ T68] __might_resched (kernel/sched/core.c:10154) 
[ 169.939156][ T68] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 169.944198][ T68] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 169.949241][ T68] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 169.954723][ T68] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 169.959418][ T68] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 169.964721][ T68] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 169.969251][ T68] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 169.974386][ T68] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 169.979607][ T68] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 169.984389][ T68] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 169.989949][ T68] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 169.994822][ T68] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 169.999691][ T68] ? strscpy (lib/string.c:158) 
[ 170.003693][ T68] process_one_work (kernel/workqueue.c:2410) 
[ 170.008485][ T68] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 170.013017][ T68] ? process_one_work (kernel/workqueue.c:2495) 
[ 170.018062][ T68] kthread (kernel/kthread.c:379) 
[ 170.021978][ T68] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 170.027451][ T68] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  170.031717][   T68]  </TASK>
[  171.009977][   T68] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  171.019277][   T68] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 68, name: kworker/u16:6
[  171.028225][   T68] preempt_count: 1, expected: 0
[  171.032933][   T68] RCU nest depth: 0, expected: 0
[  171.037722][   T68] CPU: 4 PID: 68 Comm: kworker/u16:6 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  171.048221][   T68] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  171.057152][   T68] Workqueue: events_unbound ext4_discard_work
[  171.063065][   T68] Call Trace:
[  171.066204][   T68]  <TASK>
[ 171.068996][ T68] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 171.073344][ T68] __might_resched (kernel/sched/core.c:10154) 
[ 171.077951][ T68] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 171.082991][ T68] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 171.088033][ T68] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 171.093506][ T68] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 171.098209][ T68] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 171.103516][ T68] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 171.108037][ T68] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 171.113166][ T68] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 171.118389][ T68] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 171.123170][ T68] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 171.128729][ T68] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 171.133603][ T68] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 171.138468][ T68] ? strscpy (lib/string.c:158) 
[ 171.142472][ T68] process_one_work (kernel/workqueue.c:2410) 
[ 171.147257][ T68] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 171.151788][ T68] ? process_one_work (kernel/workqueue.c:2495) 
[ 171.156836][ T68] kthread (kernel/kthread.c:379) 
[ 171.160757][ T68] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 171.166233][ T68] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  171.170496][   T68]  </TASK>
[  172.152180][   T67] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  172.161479][   T67] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 67, name: kworker/u16:5
[  172.170424][   T67] preempt_count: 1, expected: 0
[  172.175129][   T67] RCU nest depth: 0, expected: 0
[  172.179921][   T67] CPU: 3 PID: 67 Comm: kworker/u16:5 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  172.190412][   T67] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  172.199351][   T67] Workqueue: events_unbound ext4_discard_work
[  172.205262][   T67] Call Trace:
[  172.208396][   T67]  <TASK>
[ 172.211191][ T67] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 172.215541][ T67] __might_resched (kernel/sched/core.c:10154) 
[ 172.220145][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 172.225187][ T67] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 172.230230][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 172.235708][ T67] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 172.240410][ T67] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 172.245709][ T67] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 172.250229][ T67] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 172.255360][ T67] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 172.260585][ T67] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 172.265376][ T67] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 172.270943][ T67] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 172.275810][ T67] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 172.280677][ T67] ? strscpy (lib/string.c:158) 
[ 172.284682][ T67] process_one_work (kernel/workqueue.c:2410) 
[ 172.289465][ T67] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 172.293996][ T67] ? process_one_work (kernel/workqueue.c:2495) 
[ 172.299045][ T67] kthread (kernel/kthread.c:379) 
[ 172.302968][ T67] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 172.308453][ T67] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  172.312726][   T67]  </TASK>
[  173.196377][   T10] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  173.205672][   T10] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u16:0
[  173.214624][   T10] preempt_count: 1, expected: 0
[  173.219329][   T10] RCU nest depth: 0, expected: 0
[  173.224121][   T10] CPU: 5 PID: 10 Comm: kworker/u16:0 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  173.234627][   T10] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  173.243568][   T10] Workqueue: events_unbound ext4_discard_work
[  173.249482][   T10] Call Trace:
[  173.252620][   T10]  <TASK>
[ 173.255414][ T10] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 173.259766][ T10] __might_resched (kernel/sched/core.c:10154) 
[ 173.264379][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 173.269421][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 173.274464][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 173.279936][ T10] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 173.284637][ T10] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 173.289936][ T10] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 173.294460][ T10] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 173.299598][ T10] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 173.304822][ T10] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 173.309605][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 173.315170][ T10] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 173.320027][ T10] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 173.324889][ T10] ? strscpy (lib/string.c:158) 
[ 173.328891][ T10] process_one_work (kernel/workqueue.c:2410) 
[ 173.333672][ T10] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 173.338189][ T10] ? process_one_work (kernel/workqueue.c:2495) 
[ 173.343224][ T10] kthread (kernel/kthread.c:379) 
[ 173.347136][ T10] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 173.352597][ T10] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  173.356856][   T10]  </TASK>
[  174.279523][   T10] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
[  174.288828][   T10] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/u16:0
[  174.297776][   T10] preempt_count: 1, expected: 0
[  174.302474][   T10] RCU nest depth: 0, expected: 0
[  174.307268][   T10] CPU: 4 PID: 10 Comm: kworker/u16:0 Tainted: G        W          6.4.0-rc5-00060-gc880a1f2eea1 #1
[  174.317764][   T10] Hardware name: HP HP Z240 SFF Workstation/802E, BIOS N51 Ver. 01.63 10/05/2017
[  174.326702][   T10] Workqueue: events_unbound ext4_discard_work
[  174.332616][   T10] Call Trace:
[  174.335756][   T10]  <TASK>
[ 174.338549][ T10] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
[ 174.342899][ T10] __might_resched (kernel/sched/core.c:10154) 
[ 174.347509][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 174.352549][ T10] ? preempt_notifier_dec (kernel/sched/core.c:10108) 
[ 174.357598][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 174.363072][ T10] kmem_cache_alloc (include/linux/kernel.h:111 include/linux/sched/mm.h:306 mm/slab.h:670 mm/slub.c:3433 mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475) 
[ 174.367775][ T10] ext4_try_to_trim_range (fs/ext4/mballoc.c:6855) 
[ 174.373077][ T10] ? mb_mark_used (fs/ext4/mballoc.c:6825) 
[ 174.377596][ T10] ? __filemap_get_folio (mm/filemap.c:1944) 
[ 174.382724][ T10] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137) 
[ 174.387940][ T10] ext4_discard_work (fs/ext4/ext4.h:1741 fs/ext4/ext4.h:3445 fs/ext4/ext4.h:3480 fs/ext4/mballoc.c:3535) 
[ 174.392725][ T10] ? ext4_try_to_trim_range (fs/ext4/mballoc.c:3494) 
[ 174.398290][ T10] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 174.403163][ T10] ? read_word_at_a_time (include/asm-generic/rwonce.h:86) 
[ 174.408030][ T10] ? strscpy (lib/string.c:158) 
[ 174.412034][ T10] process_one_work (kernel/workqueue.c:2410) 
[ 174.416825][ T10] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2553) 
[ 174.421354][ T10] ? process_one_work (kernel/workqueue.c:2495) 
[ 174.426400][ T10] kthread (kernel/kthread.c:379) 
[ 174.430316][ T10] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 174.435791][ T10] ret_from_fork (arch/x86/entry/entry_64.S:314) 
[  174.440062][   T10]  </TASK>
[  175.621508][ T2397] EXT4-fs (dm-4): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  176.623506][ T2403] dm-4: detected capacity change from 409600 to 0
[  177.704957][ T2425] EXT4-fs (dm-3): recovery complete
[  177.721726][ T2425] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  177.734084][ T2425] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  177.769408][ T2428] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  179.515905][ T2452] EXT4-fs (dm-3): recovery complete
[  179.537783][ T2452] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  179.550277][ T2452] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  179.724415][ T2464] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  180.915081][ T2483] EXT4-fs (dm-3): recovery complete
[  180.931969][ T2483] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  180.944441][ T2483] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  181.118857][ T2492] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  182.234267][ T2511] EXT4-fs (dm-3): recovery complete
[  182.279753][ T2511] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  182.292255][ T2511] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  182.473388][ T2520] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  183.605915][ T2539] EXT4-fs (dm-3): recovery complete
[  183.622519][ T2539] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  183.634998][ T2539] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  183.791960][ T2548] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  184.874047][ T2570] EXT4-fs (dm-3): recovery complete
[  184.894253][ T2570] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  184.906747][ T2570] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  185.080013][ T2582] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  186.438097][ T2601] EXT4-fs (dm-3): recovery complete
[  186.493166][ T2601] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  186.505615][ T2601] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  186.691044][ T2610] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  187.962510][ T2629] EXT4-fs (dm-3): recovery complete
[  187.983151][ T2629] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  187.995652][ T2629] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  188.178126][ T2641] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  188.950567][ T2657] EXT4-fs (dm-3): recovery complete
[  188.968436][ T2657] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  188.980827][ T2657] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  189.111359][ T2669] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  190.033693][ T2687] EXT4-fs (dm-3): recovery complete
[  190.053092][ T2687] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  190.065505][ T2687] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  190.189057][ T2699] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  191.118121][ T2715] EXT4-fs (dm-3): recovery complete
[  191.139422][ T2715] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  191.151833][ T2715] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  191.267452][ T2727] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  192.087702][ T2743] EXT4-fs (dm-3): recovery complete
[  192.105721][ T2743] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  192.118348][ T2743] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  192.274541][ T2755] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  193.147771][ T2771] EXT4-fs (dm-3): recovery complete
[  193.169529][ T2771] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  193.181931][ T2771] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  193.314546][ T2783] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  194.243796][ T2799] EXT4-fs (dm-3): recovery complete
[  194.266788][ T2799] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  194.279170][ T2799] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  194.386986][ T2811] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  195.374952][ T2830] EXT4-fs (dm-3): recovery complete
[  195.396764][ T2830] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  195.409129][ T2830] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  195.533942][ T2842] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  196.504899][ T2865] EXT4-fs (dm-3): recovery complete
[  196.528684][ T2865] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  196.541077][ T2865] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  196.673380][ T2874] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.
[  197.644562][ T2893] EXT4-fs (dm-3): recovery complete
[  197.688906][ T2893] EXT4-fs (dm-3): mounted filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e r/w with ordered data mode. Quota mode: none.
[  197.701254][ T2893] ext4 filesystem being mounted at /fs/scratch supports timestamps until 2038-01-19 (0x7fffffff)
[  197.811543][ T2902] EXT4-fs (dm-3): unmounting filesystem e82fdffc-3525-47df-939b-0fdd5fd69b1e.


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--s5GG2KMz2+C8vNaT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc5-00060-gc880a1f2eea1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc5 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Debian 12.2.0-14) 12.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_BOOST is not set
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# CONFIG_RCU_LAZY is not set
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_INTEL_TDX_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBPB_ENTRY=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

# CONFIG_IP_SET is not set
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
# CONFIG_PATA_PARPORT is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_CAN_DEV is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
# CONFIG_ATH12K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ELKHARTLAKE is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_ACPI=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_KTZ8866 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set
CONFIG_HID_SUPPORT=y
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
# CONFIG_HID_EVISION is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2606MVV is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_ERDMA is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IDXD_PERFMON is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

# CONFIG_WPCM450_SOC is not set

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_LEGACY_DIRECT_IO=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_SUNRPC_XPRT_RDMA is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
# CONFIG_USER_EVENTS is not set
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_SUNRPC is not set
CONFIG_FAULT_INJECTION_CONFIGFS=y
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--s5GG2KMz2+C8vNaT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='xfstests'
	export testcase='xfstests'
	export category='functional'
	export need_memory='2G'
	export job_origin='xfstests-generic-part3.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-skl-d07'
	export tbox_group='lkp-skl-d07'
	export submit_id='64b1dc43b26b100d5a5e7c73'
	export job_file='/lkp/jobs/queued/validate/lkp-skl-d07/xfstests-4HDD-ext4-generic-455-debian-11.1-x86_64-20220510.cgz-c880a1f2eea1-20230715-68954-1k9gkb5-5.yaml'
	export id='dccd52d3203c2ab2c1013eb379b724d0ffb2c7f2'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=8
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export need_kconfig='BLK_DEV_SD
SCSI
{"BLOCK"=>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=>"y"}
EXT4_FS'
	export commit='c880a1f2eea1cf05148aa346a46bb9abc34bb436'
	export ucode='0xf0'
	export kconfig='x86_64-rhel-8.3-func'
	export enqueue_time='2023-07-15 07:37:40 +0800'
	export _id='64b1dc57b26b100d5a5e7c77'
	export _rt='/result/xfstests/4HDD-ext4-generic-455/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436'
	export compiler='gcc-12'
	export head_commit='d1e86e1c5d13264f2dec526259f81612a2d89222'
	export base_commit='06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5'
	export branch='linux-review/Fengnan-Chang/ext4-improve-discard-efficiency/20230704-195738'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=6000
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/xfstests/4HDD-ext4-generic-455/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/vmlinuz-6.4.0-rc5-00060-gc880a1f2eea1
branch=linux-review/Fengnan-Chang/ext4-improve-discard-efficiency/20230704-195738
job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-generic-455-debian-11.1-x86_64-20220510.cgz-c880a1f2eea1-20230715-68954-1k9gkb5-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-func
commit=c880a1f2eea1cf05148aa346a46bb9abc34bb436
nmi_watchdog=0
max_uptime=6000
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230710.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-06c027a-1_20230710.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-generic-455-debian-11.1-x86_64-20220510.cgz-c880a1f2eea1-20230715-68954-1k9gkb5-5.cgz'
	export last_kernel='4.20.0'
	export acpi_rsdp='0x000fbe30'
	export repeat_to=6
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/vmlinuz-6.4.0-rc5-00060-gc880a1f2eea1'
	export result_root='/result/xfstests/4HDD-ext4-generic-455/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/3'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=4 $LKP_SRC/setup/disk

	run_setup fs='ext4' $LKP_SRC/setup/fs

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='generic-455' $LKP_SRC/tests/wrapper xfstests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='generic-455' $LKP_SRC/stats/wrapper xfstests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time xfstests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--s5GG2KMz2+C8vNaT
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--s5GG2KMz2+C8vNaT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="xfstests"

2023-07-14 23:53:15 export TEST_DIR=/fs/sdb1
2023-07-14 23:53:15 export TEST_DEV=/dev/sdb1
2023-07-14 23:53:15 export FSTYP=ext4
2023-07-14 23:53:15 export SCRATCH_MNT=/fs/scratch
2023-07-14 23:53:15 mkdir /fs/scratch -p
2023-07-14 23:53:15 export SCRATCH_DEV=/dev/sdb4
2023-07-14 23:53:15 export LOGWRITES_DEV=/dev/sdb2
2023-07-14 23:53:15 echo generic/455
2023-07-14 23:53:15 ./check -E tests/exclude/ext4 generic/455
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.4.0-rc5-00060-gc880a1f2eea1 #1 SMP PREEMPT_DYNAMIC Fri Jul 14 19:39:43 CST 2023
MKFS_OPTIONS  -- -F /dev/sdb4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb4 /fs/scratch

generic/455       _check_dmesg: something found in dmesg (see /lkp/benchmarks/xfstests/results//generic/455.dmesg)

Ran: generic/455
Failures: generic/455
Failed 1 of 1 tests


--s5GG2KMz2+C8vNaT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---
suite: xfstests
testcase: xfstests
category: functional
need_memory: 2G
disk: 4HDD
fs: ext4
xfstests:
  test: generic-455
job_origin: xfstests-generic-part3.yaml
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d07
tbox_group: lkp-skl-d07
submit_id: 64b13216b26b10e104c2557f
job_file: "/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-generic-455-debian-11.1-x86_64-20220510.cgz-c880a1f2eea1-20230714-57604-ucy8i4-0.yaml"
id: 9866251e80a26e6133b94b8fc71247728e854412
queuer_version: "/zday/lkp"
model: Skylake
nr_cpu: 8
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST2000DM001-1ER164_Z4Z98KSZ-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BW480H6_CVTR612406D5480EGN-part1"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
kmsg:
heartbeat:
meminfo:
kmemleak:
sanity-check:
need_kconfig:
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- EXT4_FS
commit: c880a1f2eea1cf05148aa346a46bb9abc34bb436
ucode: '0xf0'
kconfig: x86_64-rhel-8.3-func
enqueue_time: 2023-07-14 19:31:35.822438706 +08:00
_id: 64b13216b26b10e104c2557f
_rt: "/result/xfstests/4HDD-ext4-generic-455/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436"
compiler: gcc-12
head_commit: d1e86e1c5d13264f2dec526259f81612a2d89222
base_commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
branch: linux-devel/devel-hourly-20230713-025101
rootfs: debian-11.1-x86_64-20220510.cgz
user: lkp
LKP_SERVER: internal-lkp-server
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 6000
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/xfstests/4HDD-ext4-generic-455/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/vmlinuz-6.4.0-rc5-00060-gc880a1f2eea1
- branch=linux-devel/devel-hourly-20230713-025101
- job=/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-generic-455-debian-11.1-x86_64-20220510.cgz-c880a1f2eea1-20230714-57604-ucy8i4-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-func
- commit=c880a1f2eea1cf05148aa346a46bb9abc34bb436
- nmi_watchdog=0
- max_uptime=6000
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/xfstests_20230710.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/xfstests-x86_64-06c027a-1_20230710.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: lkp-wsx01
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
job_initrd: "/lkp/jobs/scheduled/lkp-skl-d07/xfstests-4HDD-ext4-generic-455-debian-11.1-x86_64-20220510.cgz-c880a1f2eea1-20230714-57604-ucy8i4-0.cgz"
last_kernel: 6.4.0-07187-g27bd73b22249
acpi_rsdp: '0x000fbe30'

#! queue options

#! schedule options

#! /cephfs/db/releases/20230713144303/lkp-src/include/site/lkp-wsx01

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/vmlinuz-6.4.0-rc5-00060-gc880a1f2eea1"
result_root: "/result/xfstests/4HDD-ext4-generic-455/lkp-skl-d07/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-func/gcc-12/c880a1f2eea1cf05148aa346a46bb9abc34bb436/0"

#! /db/releases/20230714181615/lkp-src/include/site/lkp-wsx01
dequeue_time: 2023-07-14 19:45:55.360390335 +08:00
job_state: finished
loadavg: 1.74 1.42 0.65 1/186 4366
start_time: '1689335290'
end_time: '1689335485'
version: "/lkp/lkp/.src-20230714-145708:595a6e706832:3d49cd1c24ce"

--s5GG2KMz2+C8vNaT
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

dmsetup remove_all
wipefs -a --force /dev/sdb1
wipefs -a --force /dev/sdb2
wipefs -a --force /dev/sdb3
wipefs -a --force /dev/sdb4
mkfs -t ext4 -q -F /dev/sdb2
mkfs -t ext4 -q -F /dev/sdb1
mkfs -t ext4 -q -F /dev/sdb3
mkfs -t ext4 -q -F /dev/sdb4
mkdir -p /fs/sdb1
mount -t ext4 /dev/sdb1 /fs/sdb1
mkdir -p /fs/sdb2
mount -t ext4 /dev/sdb2 /fs/sdb2
mkdir -p /fs/sdb3
mount -t ext4 /dev/sdb3 /fs/sdb3
mkdir -p /fs/sdb4
mount -t ext4 /dev/sdb4 /fs/sdb4
export TEST_DIR=/fs/sdb1
export TEST_DEV=/dev/sdb1
export FSTYP=ext4
export SCRATCH_MNT=/fs/scratch
mkdir /fs/scratch -p
export SCRATCH_DEV=/dev/sdb4
export LOGWRITES_DEV=/dev/sdb2
echo generic/455
./check -E tests/exclude/ext4 generic/455

--s5GG2KMz2+C8vNaT--
