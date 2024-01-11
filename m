Return-Path: <linux-ext4+bounces-773-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4482B020
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A5C1F23352
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C63B187;
	Thu, 11 Jan 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KH+CnveQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E693B185;
	Thu, 11 Jan 2024 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704981697; x=1736517697;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WyiAnXjWEg6vJ3BnHzWMYLViY/IF/fE3dYvAyGQYWe8=;
  b=KH+CnveQMG7hQdfPmjaqeP6uZvbbFsefJwkSaNvvYlvWoxupyzao2u1x
   q8FUClygfH25RltplwP0t559jzUPL1vtP3kRrqMhXu26xLs+OB0Y9phJ2
   M44gSec93LA/Ne9Zn51zIfIE/DBbRWysflQdnofuHHr8/im8f13s2+HCH
   gqp92RymNBiIGXUFyqOcAm6cOgaKv/x74cdizgo1gDVrLTzCvg5WicFhe
   ShKsn8B1RkF912HaMjmxHpW7NfGyIsq595ZBxy5WVD7vWLgYBsAgaysRf
   /lLntwTJ/8XkSmdLYUPpNUiBNgTC1kr/4mw2p23nJecdHwOtXk5qrsGBi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="430035083"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="430035083"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 06:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="31009096"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 06:01:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 06:01:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 06:01:33 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 06:01:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijWkI8o956pupq268rHwdLWhKiSJxr1zbllu2CElj1eOaQ5gAhNFJXaZQBQD9n8SE4XPKRlAfoCBwBW8lu7l7hLLLGwJecnWrYQPqw5RhUHS497hXLCF81OvdpVb8kg0ECHNSml4fuSW7oi/zEWROswvcIBeGgZK1v/Nt+ti+lcV0dGdr2cSKpT8QMlSBGu9xAXu/I+I1uqOnyTPk5JHrZBj+W8hAEX+7R2pJFnKrcvpHh3bebMrbmc9PY6L2H9+wA6aoQfQWHdN9yyAKHhMQCM8fYDrzSW+Xut6lH9n4YIKJvwq01eRTDKFYKJzrlpSsCuDgjrId5xuEvGPCiOoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U16kqqH4S7QNG2y+FimMislg2NDJScbbQoaTAqTVtpM=;
 b=BvSeBfZFspK9mC9LUmKBkb9nyk93CEes3zt4NH8b3wniJzhYfhybO2S77w3CHRxiEQprJXXY2nASMg0bgFPFqzyOVy1gy37w9fV8wGJ9XgCU9I5KWoD6REYcICvQXrbogJjQGSF7bN7ioUhfWsRU7IUjCvvHkK0/j6xA2owrbrAtGtRylq8vmnE5F0AqezmYZ7iSkb7LR474mZtoHGXkmamTqXcwODyyojFcw+V2+NRJvulJGoXSLRwKtwF2Sbe0SMfyOO0XcMDpJpN6YjTLPjp94e7YQ8Hx0PTMmyPK/rXMBOs3j1lIpEl68XfzUvQ4EE0xwDsaLqIbzlLV66HGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 14:01:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 14:01:26 +0000
Date: Thu, 11 Jan 2024 22:01:17 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhihao Cheng <chengzhihao1@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	<linux-ext4@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [jbd2]  8a4fd33d87:  stress-ng.utime.ops_per_sec
 -42.3% regression
Message-ID: <202401111552.fc8b0703-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: be38e1b3-604a-445d-bdf8-08dc12adcd3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJRJLOlAI9kVvuuylhr/3tqRuf+3aGFt6rSbaZO2C0V00gBpGKXU9ofVhQMvxQTHegYeXyTVIT95y8PM2zckZlyKkiUCGAWpIkR3xRCVVEnGcXV8pU+jjZApexj5NBUzHtgcSQPEpZKzj86Om6US7TYLkferqX3g9glzvvg1PHTnhpbmgiWq96MO5k1Zgz7vViXyLIvFX5Ov2Wd9U2Hs9OzWBR1a0nZy9x6T0Aa/DMIIJhDClhgd4+AKCVxeTQtYrrYufEtBEZjlB42khN4v/I06qS9+2d9xK0wrFyXjx2YN1YHtbF+CLyc0fGpKPkyzNURsSYvG9L2D86wdkfFILrWtbNY/iRuny8sg1MgLjpZeddx+vUC9LXaw0J3CrPuTUZKoJJ92HATeZJ/k5l+kdH/tSi0i8pJVZhOzLELqXNN2xhFS6f7JhLH961/hjDzYi4Bk45eqfTCbB9PIU6ArGttj5zIw5mhz0Q9K+JhPw3yRMmiMeJrCfD3u89BzgJr1XiWxk8sSQ7ksTLxGJ0bdEsz3EB/WltLPlHVzFjT4vmmlIw+fPycLqLmgVJMSqr2EneX2bQGBsALOkphLeO9aI8Zv8sj5VX4veKELhTb4V7rdj40u5JHM9ZnZRqErhsm2rQZ4A23ZRqjcGndqpup84RDySesJgRWdPrl4CwQneQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(230373577357003)(230473577357003)(186009)(451199024)(64100799003)(1800799012)(36756003)(6486002)(2906002)(5660300002)(66946007)(83380400001)(30864003)(38100700002)(6666004)(54906003)(316002)(6506007)(6512007)(6916009)(4326008)(2616005)(1076003)(26005)(66556008)(66476007)(8936002)(8676002)(41300700001)(86362001)(478600001)(82960400001)(107886003)(966005)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/cpGQTk5Njk1M7jv6PlsOFPVrf/gGnt8YETgeZYbtpTf0IgG3EVRj0o+ay?=
 =?iso-8859-1?Q?0YbbGSU3uNsMhD1jNCPXDZeGWN32pQx6mANQ40VUerJpObJog3heNP8Uws?=
 =?iso-8859-1?Q?PYKWqlJ3VYsGHvscMBOD6yWm/Rl1sSi7oUAir9v+PufcBRExVX1gU58alt?=
 =?iso-8859-1?Q?HmWuEcsNo+qTBtXWh9jZKeBVGDmItSc7a8UEFqKknHFvga79yWCYBPDAKO?=
 =?iso-8859-1?Q?5ZqLh7Gyj6XPINdWsdVooAkgaqFjM2TRCpWa4dTT+1g9ihESVPba0LOhZ8?=
 =?iso-8859-1?Q?jsMvRRMBsALxZmSKgOuN5t5YRQNJzIg+8FzY+u87Vqsyv37/MfnfIrAxUz?=
 =?iso-8859-1?Q?9I3aloV9xyKfTAal94jVu/ZJdk0iXO8XTThCZJQM63YVt6s81uYLRaXm+r?=
 =?iso-8859-1?Q?JKSmdYsFUYJ6eET6UYl1x53jdaCC/9HTuASt0mAslASfjb5q2P9GrajMfm?=
 =?iso-8859-1?Q?VIeBz+3Xh0AeLKlIkj4pDZ58b3ud9C26uqcVjZBs6+hhOJOG0vuJxMTrIL?=
 =?iso-8859-1?Q?uQ7ZokEYTvqgKjwQ34W1dR1fPFJ8L//7sQLK04jmYnjv8PCOiUgRmto/F7?=
 =?iso-8859-1?Q?gwcgIVkZK8qIQDnS/ttvT2EElZkSvTDG46JmxHrM3d8cOOye7IyZf68PEW?=
 =?iso-8859-1?Q?svglO7gqEQ9jFr2N6JFvX/Sb3ev29Marf6FNcbnsfJ8gjCyuyidtOZzr5V?=
 =?iso-8859-1?Q?m1LVxJDBTQdAHiPkC/6bKxSnJqzCDJ3cIjRH7g1BvmCo3C+rXLh0uPZJPq?=
 =?iso-8859-1?Q?4XD008kN+LUoJm/nD1EJRZEs9FLPDMq1Gc8MwZk1l22ZoEQ5MW2Kesy4/s?=
 =?iso-8859-1?Q?wKuRDBJDgnPdXBbohRaN6PQCBTk0FjuDZFOiEeBG1fMcldGTkW2fqadR66?=
 =?iso-8859-1?Q?PgiFDdPD2ZHcjCmzAzbs11gQmN1Tb+P439K+P+nT1iaEDTTnWG8FWvIUSC?=
 =?iso-8859-1?Q?0isuRogHFZJ/LcKpopoZsdBQ2eJx2Fba8NyT7/1fceHLVFJDzrwMRGR1Ei?=
 =?iso-8859-1?Q?8xLmkRG29qKYe6rYKxOOuvyMYrTq68XGf7sIifw8M8Q3a5187Hgo0j046n?=
 =?iso-8859-1?Q?6PixHFVUeCsxQ2VYJWwNC/qpJn0AdfiTiL7NxoFjmndySUym3fsEeHxyBh?=
 =?iso-8859-1?Q?IvgePTkwh88cNRIiN29tSUGLnIXigFysRPySgwB5XbdjSZ+9ZPhKGFKdYI?=
 =?iso-8859-1?Q?KRV4+cNHJ8dF0/fb6ewNSYHYpefLIxV7AylzL4YSSRRq4vO6o5Cm1Xdrf4?=
 =?iso-8859-1?Q?AJw+RDFED9yiR9QIvJn0q0TfA/za124ZKBTwB9znQvjB6TvpsgYAh+lJKK?=
 =?iso-8859-1?Q?yEZGnqjFZDW03z/YRDhyVqVlO0c7U0UvwrlpnorSHwzWOHLha2CYWtXVzj?=
 =?iso-8859-1?Q?qYxryFkpXcONoay5i6rx0Q3CRQViKdIRZcZmEPGT6kAyCwmM9Y1H+r2OoN?=
 =?iso-8859-1?Q?cQ+h31G/2LZ0elXiKsumg1m6DGvnp2XtTqqVBx9Ft6FOH6CRfPBei2zQoM?=
 =?iso-8859-1?Q?ZOfZkyn6bvi27jma5FXY7/nfqI1FckhcSpPc/UQ9l0CcnrDSv91u1EySrl?=
 =?iso-8859-1?Q?sPuNXVKeweoCtexfnjpuj+QNF6jicS5lY98zW/tpVZOslYjQdPr2K7GBKc?=
 =?iso-8859-1?Q?e1FQ5uXaDu4LBSJPrFuoA2Mh4UzGhW78QJ06gs7/M5z1spvOUHLDzwnQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be38e1b3-604a-445d-bdf8-08dc12adcd3d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 14:01:26.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP/5B901b3pbV/HMm29wuYGXUthy7h3bNRkPon4xMMX/aaDoG944XPpXbNCjjlkAjAW9tkbBc6lVWGhP4oYdAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com



Hello,

when reviewing this report internally, we cannot connect the regression with
changes. however, we saw similar regression on different stress-ng tests and
the data is quite stable (comparing to the regression level), so we still
report what we observed in our tests just FYI.

below are details.


kernel test robot noticed a -42.3% regression of stress-ng.utime.ops_per_sec on:


commit: 8a4fd33d879fb303b207f06ea6340d73f698c4ed ("jbd2: remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	class: os
	test: utime
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.access.ops_per_sec -31.6% regression                                 |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory |
| test parameters  | class=os                                                                                  |
|                  | cpufreq_governor=performance                                                              |
|                  | disk=1HDD                                                                                 |
|                  | fs=ext4                                                                                   |
|                  | nr_threads=10%                                                                            |
|                  | test=access                                                                               |
|                  | testtime=60s                                                                              |
+------------------+-------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401111552.fc8b0703-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240111/202401111552.fc8b0703-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/utime/stress-ng/60s

commit: 
  62ec1707cb ("jbd2: replace journal state flag by checking errseq")
  8a4fd33d87 ("jbd2: remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'")

62ec1707cb071c95 8a4fd33d879fb303b207f06ea63 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      9.21            +1.7%       9.36        iostat.cpu.system
      0.52 ±  6%      -0.1        0.46 ±  4%  mpstat.cpu.all.usr%
      0.31 ±  2%     -37.8%       0.19 ±  3%  turbostat.IPC
   7163392           -42.3%    4134347 ±  2%  stress-ng.utime.ops
    119389           -42.3%      68905 ±  2%  stress-ng.utime.ops_per_sec
      6.00 ± 34%   +1600.0%     102.00 ± 21%  perf-c2c.DRAM.local
    453.67 ±  8%    +101.8%     915.33 ± 11%  perf-c2c.DRAM.remote
    480.00 ±  8%     +79.8%     863.17 ± 10%  perf-c2c.HITM.local
    441.50 ±  9%     +77.6%     784.00 ± 13%  perf-c2c.HITM.remote
      0.03 ± 26%     +36.8%       0.03 ± 14%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
    528.42 ±  4%      -9.9%     476.28 ±  4%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      4.17 ± 82%    +172.0%      11.33 ± 32%  perf-sched.wait_and_delay.count.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    528.38 ±  4%      -9.9%     476.24 ±  4%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     26601 ± 99%     -73.9%       6950 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.41 ±  8%     +23.6%       0.50 ± 12%  sched_debug.cfs_rq:/.h_nr_running.stddev
     26601 ± 99%     -73.9%       6950 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.41 ±  8%     +23.6%       0.50 ± 12%  sched_debug.cfs_rq:/.nr_running.stddev
      0.42 ±  4%     +17.6%       0.49 ± 10%  sched_debug.cpu.nr_running.stddev
      0.27 ±  2%     +68.9%       0.46 ±  3%  perf-stat.i.MPKI
 3.372e+09 ±  2%     -38.3%  2.081e+09        perf-stat.i.branch-instructions
      0.26 ±  3%      +0.1        0.32 ±  6%  perf-stat.i.branch-miss-rate%
      1.10 ±  2%     +63.6%       1.81        perf-stat.i.cpi
      4195 ±  3%      -5.3%       3973 ±  3%  perf-stat.i.cycles-between-cache-misses
 4.187e+09 ±  2%     -38.5%  2.577e+09        perf-stat.i.dTLB-loads
 2.572e+09 ±  2%     -39.5%  1.555e+09 ±  2%  perf-stat.i.dTLB-stores
 1.827e+10 ±  2%     -38.6%  1.122e+10        perf-stat.i.instructions
      0.91 ±  2%     -38.0%       0.57        perf-stat.i.ipc
    272.51            +2.6%     279.72        perf-stat.i.metric.K/sec
    158.24 ±  2%     -38.7%      97.04        perf-stat.i.metric.M/sec
     96.04            -7.3       88.70        perf-stat.i.node-load-miss-rate%
   2167594 ±  2%     -22.8%    1674094 ±  7%  perf-stat.i.node-load-misses
     99062 ± 27%    +138.7%     236511 ±  7%  perf-stat.i.node-loads
     92.50            -7.3       85.25        perf-stat.i.node-store-miss-rate%
   2391403           +14.0%    2727122 ±  3%  perf-stat.i.node-store-misses
    194998 ±  7%    +138.8%     465730 ±  3%  perf-stat.i.node-stores
      0.27 ±  3%     +71.0%       0.46 ±  3%  perf-stat.overall.MPKI
      0.24 ±  6%      +0.1        0.35 ±  7%  perf-stat.overall.branch-miss-rate%
      1.09 ±  2%     +64.3%       1.79        perf-stat.overall.cpi
      0.92 ±  2%     -39.1%       0.56        perf-stat.overall.ipc
     95.66            -8.1       87.59        perf-stat.overall.node-load-miss-rate%
     92.52            -7.1       85.43        perf-stat.overall.node-store-miss-rate%
 3.318e+09 ±  2%     -38.3%  2.047e+09        perf-stat.ps.branch-instructions
 4.121e+09 ±  2%     -38.5%  2.534e+09        perf-stat.ps.dTLB-loads
 2.532e+09 ±  2%     -39.6%   1.53e+09 ±  2%  perf-stat.ps.dTLB-stores
 1.798e+10 ±  2%     -38.6%  1.104e+10        perf-stat.ps.instructions
   2133465 ±  2%     -22.8%    1646709 ±  7%  perf-stat.ps.node-load-misses
     97073 ± 27%    +139.1%     232065 ±  7%  perf-stat.ps.node-loads
   2353998           +14.0%    2682934 ±  3%  perf-stat.ps.node-store-misses
    190563 ±  7%    +139.9%     457071 ±  3%  perf-stat.ps.node-stores
 1.141e+12           -39.7%  6.884e+11        perf-stat.total.instructions
     15.30 ±  6%      -5.8        9.51 ±  3%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.ext4_setattr.notify_change.vfs_utimes
     15.18 ±  6%      -5.7        9.44 ±  3%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.ext4_setattr.notify_change
      7.56 ±  2%      -3.8        3.75        perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change
      4.96 ±  5%      -2.3        2.64        perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      5.31 ±  3%      -2.2        3.10 ±  3%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_utimes.do_futimesat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.07 ±  6%      -1.8        2.28 ±  8%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      4.08 ±  3%      -1.7        2.38 ±  3%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_utimes.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.87 ±  2%      -1.6        1.32 ±  3%  perf-profile.calltrace.cycles-pp.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      2.83 ±  4%      -1.2        1.62 ±  3%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.do_utimes.do_futimesat.do_syscall_64
      2.86 ±  2%      -1.2        1.66 ±  2%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_utimes.__x64_sys_utime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.74 ±  3%      -1.1        0.66 ±  5%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.do_utimes
      2.54 ±  3%      -1.1        1.46 ±  3%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utimensat.do_syscall_64
      2.34 ±  4%      -1.0        1.34 ±  3%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.do_utimes.do_futimesat
      2.13 ±  3%      -0.9        1.22 ±  3%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utimensat
      2.16 ±  3%      -0.9        1.29 ±  3%  perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.do_utimes.do_futimesat.do_syscall_64
      2.11 ±  2%      -0.9        1.23 ±  2%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utime.do_syscall_64
     20.36            -0.8       19.58        perf-profile.calltrace.cycles-pp.utimensat
      1.91 ±  2%      -0.8        1.14 ±  4%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.do_utimes.do_futimesat
      1.81 ±  2%      -0.7        1.07 ±  3%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.do_utimes.__x64_sys_utime
     10.75            -0.6       10.14        perf-profile.calltrace.cycles-pp.syscall
      1.34 ±  3%      -0.6        0.79 ±  4%  perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.do_utimes.__x64_sys_utimensat.do_syscall_64
     10.51            -0.5       10.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     10.47            -0.5        9.98        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      1.14 ±  4%      -0.5        0.67 ±  4%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.do_utimes.__x64_sys_utimensat
      2.09 ± 15%      -0.5        1.64 ± 17%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.ext4_setattr
     10.38            -0.4        9.94        perf-profile.calltrace.cycles-pp.__x64_sys_utime.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
     10.23            -0.4        9.84        perf-profile.calltrace.cycles-pp.do_utimes.__x64_sys_utime.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      7.29            +0.8        8.12        perf-profile.calltrace.cycles-pp.vfs_utimes.do_utimes.__x64_sys_utime.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.11            +0.9        8.02        perf-profile.calltrace.cycles-pp.notify_change.vfs_utimes.do_utimes.__x64_sys_utime.do_syscall_64
      6.98            +1.0        7.95        perf-profile.calltrace.cycles-pp.ext4_setattr.notify_change.vfs_utimes.do_utimes.__x64_sys_utime
     26.62            +2.3       28.96        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     26.55            +2.4       28.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.36            +2.4       28.80        perf-profile.calltrace.cycles-pp.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.60            +2.7       28.28        perf-profile.calltrace.cycles-pp.vfs_utimes.do_utimes.do_futimesat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.70            +2.7       28.41        perf-profile.calltrace.cycles-pp.do_utimes.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.02            +2.9       27.94        perf-profile.calltrace.cycles-pp.notify_change.vfs_utimes.do_utimes.do_futimesat.do_syscall_64
     24.54            +3.1       27.66        perf-profile.calltrace.cycles-pp.ext4_setattr.notify_change.vfs_utimes.do_utimes.do_futimesat
     40.16            +4.4       44.56        perf-profile.calltrace.cycles-pp.vfs_utimes.do_utimes.__x64_sys_utimensat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     39.16            +4.8       43.98        perf-profile.calltrace.cycles-pp.notify_change.vfs_utimes.do_utimes.__x64_sys_utimensat.do_syscall_64
     38.43            +5.1       43.56        perf-profile.calltrace.cycles-pp.ext4_setattr.notify_change.vfs_utimes.do_utimes.__x64_sys_utimensat
     12.41 ±  8%      +6.7       19.11        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
      1.37 ±  5%      +7.2        8.52 ±  3%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     69.08            +9.6       78.70        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.ext4_setattr.notify_change.vfs_utimes.do_utimes
     53.42 ±  2%     +15.6       68.99        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change.vfs_utimes
     45.45 ±  2%     +19.1       64.58        perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change
     44.50 ±  2%     +19.5       64.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
     15.33 ±  6%      -5.8        9.52 ±  3%  perf-profile.children.cycles-pp.__ext4_journal_stop
     15.23 ±  6%      -5.8        9.47 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_stop
     12.30 ±  3%      -5.1        7.17 ±  2%  perf-profile.children.cycles-pp.user_path_at_empty
      7.60 ±  2%      -3.4        4.21        perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      7.74 ±  3%      -3.3        4.46 ±  2%  perf-profile.children.cycles-pp.getname_flags
      6.42 ±  3%      -2.7        3.71 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      5.07 ±  3%      -2.1        2.96        perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      4.51 ±  3%      -1.8        2.66        perf-profile.children.cycles-pp.ext4_do_update_inode
      4.48 ±  2%      -1.8        2.64 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      3.92 ±  2%      -1.6        2.32 ±  3%  perf-profile.children.cycles-pp.path_lookupat
      3.27 ±  3%      -1.3        1.92 ±  2%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      2.25 ±  3%      -1.2        1.09        perf-profile.children.cycles-pp.ext4_reserve_inode_write
      2.29 ±  3%      -0.9        1.38 ±  3%  perf-profile.children.cycles-pp.link_path_walk
      2.15 ±  3%      -0.9        1.26 ±  3%  perf-profile.children.cycles-pp.ext4_inode_csum_set
     20.55            -0.9       19.69        perf-profile.children.cycles-pp.utimensat
      1.68 ±  4%      -0.9        0.82        perf-profile.children.cycles-pp.ext4_get_inode_loc
      2.04 ±  3%      -0.8        1.20 ±  3%  perf-profile.children.cycles-pp.ext4_inode_csum
      1.60 ±  4%      -0.8        0.78        perf-profile.children.cycles-pp.__ext4_get_inode_loc
      1.12 ±  7%      -0.7        0.46 ±  9%  perf-profile.children.cycles-pp.bdev_getblk
      1.56 ±  4%      -0.6        0.91 ±  4%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
     10.85            -0.6       10.21        perf-profile.children.cycles-pp.syscall
      1.42 ±  4%      -0.6        0.83 ±  5%  perf-profile.children.cycles-pp._copy_from_user
      1.39 ±  5%      -0.6        0.80 ±  4%  perf-profile.children.cycles-pp.get_timespec64
      0.97 ±  8%      -0.6        0.39 ± 12%  perf-profile.children.cycles-pp.__find_get_block
      1.35 ±  4%      -0.6        0.80 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      1.14 ±  4%      -0.5        0.66 ±  3%  perf-profile.children.cycles-pp.__check_object_size
     10.39            -0.5        9.94        perf-profile.children.cycles-pp.__x64_sys_utime
      0.93 ±  6%      -0.4        0.53 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      2.61 ±  3%      -0.4        2.23 ±  6%  perf-profile.children.cycles-pp.stop_this_handle
      0.84 ±  3%      -0.4        0.48 ±  3%  perf-profile.children.cycles-pp.__xstat64
      0.76 ±  3%      -0.3        0.46 ±  4%  perf-profile.children.cycles-pp.kmem_cache_free
      0.71 ±  3%      -0.3        0.41 ±  3%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.68 ±  4%      -0.3        0.40 ±  2%  perf-profile.children.cycles-pp.walk_component
      0.66 ±  2%      -0.3        0.40 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.63 ±  4%      -0.3        0.38 ±  4%  perf-profile.children.cycles-pp.inode_permission
      0.62 ±  3%      -0.3        0.37 ±  5%  perf-profile.children.cycles-pp.complete_walk
      0.48 ±  4%      -0.3        0.23 ±  8%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.59 ±  3%      -0.3        0.34 ±  6%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.56 ±  5%      -0.2        0.31 ±  7%  perf-profile.children.cycles-pp.check_heap_object
      0.54 ±  3%      -0.2        0.31 ±  4%  perf-profile.children.cycles-pp.mnt_want_write
      0.56 ±  5%      -0.2        0.33 ±  5%  perf-profile.children.cycles-pp.try_to_unlazy
      0.50 ±  5%      -0.2        0.30 ±  4%  perf-profile.children.cycles-pp.lookup_fast
      0.44 ±  3%      -0.2        0.25 ±  2%  perf-profile.children.cycles-pp.vfs_statx
      0.44 ±  5%      -0.2        0.26 ±  8%  perf-profile.children.cycles-pp.__legitimize_path
      0.38 ±  5%      -0.2        0.21 ±  6%  perf-profile.children.cycles-pp.inode_maybe_inc_iversion
      0.36 ±  9%      -0.2        0.20 ±  8%  perf-profile.children.cycles-pp.path_init
      0.41 ±  6%      -0.2        0.25 ±  3%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.35 ±  7%      -0.2        0.20 ± 10%  perf-profile.children.cycles-pp.rcu_all_qs
      0.40 ±  7%      -0.2        0.24 ±  5%  perf-profile.children.cycles-pp.generic_permission
      0.36 ±  4%      -0.2        0.21 ±  7%  perf-profile.children.cycles-pp.down_write
      0.26 ± 10%      -0.1        0.12 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      0.37 ±  6%      -0.1        0.23 ±  5%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.34 ±  6%      -0.1        0.20 ± 10%  perf-profile.children.cycles-pp.__check_heap_object
      0.32 ±  3%      -0.1        0.18 ±  6%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.27 ±  7%      -0.1        0.14 ± 17%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.30 ±  4%      -0.1        0.18 ±  8%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
      0.30 ±  3%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.27 ±  8%      -0.1        0.15 ±  6%  perf-profile.children.cycles-pp.dput
      0.27 ±  9%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.path_put
      0.28 ±  9%      -0.1        0.17 ± 12%  perf-profile.children.cycles-pp.up_write
      0.23 ±  7%      -0.1        0.12 ± 11%  perf-profile.children.cycles-pp.stress_utime
      0.20 ± 12%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.27 ±  8%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.putname
      0.28 ±  5%      -0.1        0.18 ±  5%  perf-profile.children.cycles-pp.map_id_up
      0.25 ±  6%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.step_into
      0.24 ±  6%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__brelse
      0.25 ±  8%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp.make_vfsuid
      0.22 ±  8%      -0.1        0.12 ±  8%  perf-profile.children.cycles-pp.current_time
      0.21 ±  7%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.setattr_prepare
      0.22 ±  7%      -0.1        0.13 ± 10%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.18 ±  5%      -0.1        0.10 ±  5%  perf-profile.children.cycles-pp.ext4_journal_check_start
      0.20 ±  5%      -0.1        0.12 ±  6%  perf-profile.children.cycles-pp.crypto_shash_update
      0.19 ±  6%      -0.1        0.12 ± 10%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.18 ±  8%      -0.1        0.12 ± 13%  perf-profile.children.cycles-pp.memset_orig
      0.15 ±  6%      -0.1        0.09 ±  8%  perf-profile.children.cycles-pp.security_inode_permission
      0.29 ±  5%      -0.1        0.22 ± 11%  perf-profile.children.cycles-pp._raw_spin_lock
      0.14 ±  7%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.13 ±  6%      -0.1        0.07 ± 24%  perf-profile.children.cycles-pp.terminate_walk
      0.10 ± 14%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.security_inode_setattr
      0.14 ±  9%      -0.1        0.08 ± 12%  perf-profile.children.cycles-pp.lockref_put_return
      0.14 ±  7%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.kmalloc_trace
      0.16 ±  9%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.12 ± 17%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.setattr_copy
      0.14 ±  8%      -0.1        0.09 ± 10%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.13 ±  8%      -0.1        0.08 ± 10%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.09 ± 12%      -0.1        0.04 ± 71%  perf-profile.children.cycles-pp.ext4_fc_track_inode
      0.11 ±  9%      -0.1        0.06 ± 11%  perf-profile.children.cycles-pp.may_setattr
      0.12 ± 14%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__fget_light
      0.12 ± 11%      -0.1        0.07 ± 11%  perf-profile.children.cycles-pp.inode_owner_or_capable
      0.12 ±  6%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.10 ±  6%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.13 ±  5%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.__get_user_8
      0.08 ±  8%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.housekeeping_test_cpu
      0.11 ± 11%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07 ±  9%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.cp_new_stat
      0.10 ± 12%      -0.0        0.06 ± 14%  perf-profile.children.cycles-pp.timestamp_truncate
      0.09 ±  7%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.64 ±  9%      +0.2        0.86 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.60 ± 11%      +0.2        0.82 ±  4%  perf-profile.children.cycles-pp.__wake_up
     46.14            +1.9       48.04        perf-profile.children.cycles-pp.__x64_sys_utimensat
     86.06            +2.5       88.54        perf-profile.children.cycles-pp.do_utimes
      1.98 ±  5%      +6.6        8.54 ±  3%  perf-profile.children.cycles-pp._raw_read_lock
     12.43 ±  8%      +6.7       19.12        perf-profile.children.cycles-pp.add_transaction_credits
     73.16            +7.9       81.02        perf-profile.children.cycles-pp.vfs_utimes
     71.42            +8.6       80.01        perf-profile.children.cycles-pp.notify_change
     70.00            +9.2       79.21        perf-profile.children.cycles-pp.ext4_setattr
     69.10            +9.6       78.71        perf-profile.children.cycles-pp.__mark_inode_dirty
     53.46 ±  2%     +15.6       69.02        perf-profile.children.cycles-pp.ext4_dirty_inode
     45.48 ±  2%     +19.1       64.60        perf-profile.children.cycles-pp.jbd2__journal_start
     44.56 ±  2%     +19.5       64.05        perf-profile.children.cycles-pp.start_this_handle
     12.28 ±  7%      -5.2        7.03 ±  3%  perf-profile.self.cycles-pp.jbd2_journal_stop
      5.28 ±  3%      -2.2        3.04 ±  2%  perf-profile.self.cycles-pp.strncpy_from_user
      1.49 ±  4%      -0.6        0.87 ±  4%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      1.40 ±  4%      -0.6        0.81 ±  5%  perf-profile.self.cycles-pp._copy_from_user
      1.99 ±  4%      -0.6        1.41 ±  8%  perf-profile.self.cycles-pp.stop_this_handle
      0.83 ± 10%      -0.5        0.32 ± 15%  perf-profile.self.cycles-pp.__find_get_block
      0.86 ±  3%      -0.4        0.49 ±  5%  perf-profile.self.cycles-pp.ext4_fill_raw_inode
      0.84 ±  4%      -0.4        0.49 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.96 ±  3%      -0.4        0.61 ±  5%  perf-profile.self.cycles-pp.link_path_walk
      0.79 ±  3%      -0.3        0.44 ±  3%  perf-profile.self.cycles-pp.notify_change
      0.73 ±  3%      -0.3        0.44 ±  4%  perf-profile.self.cycles-pp.kmem_cache_free
      0.58 ±  2%      -0.2        0.32 ±  6%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.57 ±  7%      -0.2        0.32 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.56 ±  7%      -0.2        0.32 ±  6%  perf-profile.self.cycles-pp.vfs_utimes
      0.55 ±  6%      -0.2        0.32 ±  4%  perf-profile.self.cycles-pp.filename_lookup
      0.48 ±  6%      -0.2        0.26 ±  7%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.46 ±  2%      -0.2        0.27 ±  5%  perf-profile.self.cycles-pp.ext4_do_update_inode
      0.37 ±  5%      -0.2        0.20 ±  7%  perf-profile.self.cycles-pp.inode_maybe_inc_iversion
      0.36 ± 10%      -0.2        0.19 ±  8%  perf-profile.self.cycles-pp.path_init
      0.38 ±  5%      -0.2        0.23 ±  6%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.32 ±  5%      -0.2        0.17 ±  6%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.37 ±  7%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.35 ±  5%      -0.1        0.20 ±  6%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.32 ±  7%      -0.1        0.19 ± 10%  perf-profile.self.cycles-pp.__check_heap_object
      0.25 ±  7%      -0.1        0.14 ± 17%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.26 ±  4%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.down_write
      0.24 ± 10%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.jbd2__journal_start
      0.28 ±  4%      -0.1        0.17 ±  6%  perf-profile.self.cycles-pp.mnt_get_write_access
      0.27 ±  7%      -0.1        0.16 ± 11%  perf-profile.self.cycles-pp.getname_flags
      0.29 ±  4%      -0.1        0.18 ±  7%  perf-profile.self.cycles-pp.generic_permission
      0.27 ±  9%      -0.1        0.16 ± 10%  perf-profile.self.cycles-pp.up_write
      0.21 ±  7%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.stress_utime
      0.23 ±  6%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.step_into
      0.24 ±  9%      -0.1        0.14 ± 11%  perf-profile.self.cycles-pp.rcu_all_qs
      0.19 ±  9%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.24 ±  3%      -0.1        0.14 ±  7%  perf-profile.self.cycles-pp.get_timespec64
      0.23 ±  3%      -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.ext4_setattr
      0.22 ±  7%      -0.1        0.12 ±  9%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.25 ±  4%      -0.1        0.15 ±  6%  perf-profile.self.cycles-pp.map_id_up
      0.24 ±  7%      -0.1        0.14 ±  9%  perf-profile.self.cycles-pp.inode_permission
      0.25 ±  7%      -0.1        0.15 ±  4%  perf-profile.self.cycles-pp.putname
      0.23 ±  7%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__brelse
      0.23 ±  5%      -0.1        0.13 ± 10%  perf-profile.self.cycles-pp.check_heap_object
      0.24 ±  4%      -0.1        0.14 ±  6%  perf-profile.self.cycles-pp.utimensat
      0.24 ±  7%      -0.1        0.15 ±  9%  perf-profile.self.cycles-pp.do_utimes
      0.18 ± 26%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.__ext4_mark_inode_dirty
      0.20 ±  7%      -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.do_syscall_64
      0.20 ±  7%      -0.1        0.12 ± 12%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.21 ±  7%      -0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__check_object_size
      0.19 ±  7%      -0.1        0.12 ±  8%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.17 ±  5%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.path_lookupat
      0.16 ±  7%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.walk_component
      0.20 ±  6%      -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.utimes
      0.18 ± 10%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.make_vfsuid
      0.15 ±  5%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.current_time
      0.17 ±  7%      -0.1        0.10 ± 12%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.13 ± 10%      -0.1        0.06 ± 13%  perf-profile.self.cycles-pp.__ext4_journal_get_write_access
      0.28 ±  5%      -0.1        0.21 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock
      0.17 ± 10%      -0.1        0.11 ± 10%  perf-profile.self.cycles-pp.memset_orig
      0.13 ± 10%      -0.1        0.07 ± 13%  perf-profile.self.cycles-pp.security_inode_permission
      0.15 ±  7%      -0.1        0.09 ±  4%  perf-profile.self.cycles-pp.__ext4_handle_dirty_metadata
      0.09 ± 18%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.setattr_copy
      0.14 ±  7%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.crypto_shash_update
      0.12 ± 10%      -0.1        0.07 ±  8%  perf-profile.self.cycles-pp.lockref_put_return
      0.12 ±  5%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.setattr_prepare
      0.12 ±  9%      -0.1        0.06 ± 11%  perf-profile.self.cycles-pp.ext4_reserve_inode_write
      0.14 ±  5%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.syscall
      0.14 ±  5%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.__ext4_journal_start_sb
      0.13 ±  4%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.__x64_sys_utimensat
      0.08 ±  7%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.terminate_walk
      0.10 ±  5%      -0.1        0.04 ± 45%  perf-profile.self.cycles-pp.bdev_getblk
      0.11 ± 16%      -0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__fget_light
      0.14 ± 14%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.12 ±  9%      -0.0        0.07 ±  8%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.12 ±  6%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.12 ±  4%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.11 ±  9%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.lookup_fast
      0.12 ± 11%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.12 ±  3%      -0.0        0.07 ± 12%  perf-profile.self.cycles-pp.ext4_inode_csum_set
      0.07 ±  9%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.try_to_unlazy
      0.12 ±  9%      -0.0        0.07 ± 23%  perf-profile.self.cycles-pp.mnt_want_write
      0.07 ±  8%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.08 ±  8%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.do_futimesat
      0.12 ±  3%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.__get_user_8
      0.11 ±  3%      -0.0        0.06 ± 17%  perf-profile.self.cycles-pp.ext4_dirty_inode
      0.11 ± 11%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.10 ± 10%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.__ext4_journal_stop
      0.08 ± 10%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.10 ±  9%      -0.0        0.06 ± 14%  perf-profile.self.cycles-pp.user_path_at_empty
      0.08 ±  8%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.timestamp_truncate
      0.63 ± 10%      +0.2        0.84 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
     30.07 ±  6%      +6.2       36.30        perf-profile.self.cycles-pp.start_this_handle
      1.96 ±  5%      +6.5        8.50 ±  3%  perf-profile.self.cycles-pp._raw_read_lock
     12.37 ±  7%      +6.7       19.04        perf-profile.self.cycles-pp.add_transaction_credits


***************************************************************************************************
lkp-icl-2sp7: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  os/gcc-12/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/access/stress-ng/60s

commit: 
  62ec1707cb ("jbd2: replace journal state flag by checking errseq")
  8a4fd33d87 ("jbd2: remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'")

62ec1707cb071c95 8a4fd33d879fb303b207f06ea63 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     65.83 ± 33%    +224.8%     213.83 ± 17%  perf-c2c.DRAM.local
   1045119 ±  9%     +37.4%    1435641 ± 27%  sched_debug.cpu.avg_idle.max
      1.02 ±  2%      -0.4        0.58 ±  3%  mpstat.cpu.all.nice%
      1.55 ±  2%      -0.4        1.16 ±  3%  mpstat.cpu.all.usr%
    590102 ±  2%     -24.6%     445179 ±  5%  numa-numastat.node1.local_node
    615627 ±  3%     -24.9%     462450 ±  3%  numa-numastat.node1.numa_hit
   4191346            -9.6%    3789837        vmstat.memory.cache
      2359 ±  6%     +34.5%       3174 ± 10%  vmstat.system.cs
      0.99 ±  3%     -42.7%       0.57 ±  3%  iostat.cpu.nice
     24.53            +3.1%      25.29        iostat.cpu.system
      1.52 ±  3%     -24.2%       1.15 ±  3%  iostat.cpu.user
     10038 ±  4%    +138.0%      23891 ±  9%  turbostat.C1
      0.28 ±  3%     -28.1%       0.20 ±  2%  turbostat.IPC
    194.25            -3.0%     188.48        turbostat.PkgWatt
     61.63 ±110%   +9878.0%       6149 ± 97%  numa-meminfo.node0.Inactive(file)
   1069173 ±  4%     -37.8%     664934        numa-meminfo.node1.Active
   1062141 ±  4%     -37.7%     661359        numa-meminfo.node1.Active(anon)
   1125280 ±  5%     -36.6%     713710 ±  4%  numa-meminfo.node1.Shmem
   3204887 ±  2%     -31.6%    2192823 ±  3%  stress-ng.access.ops
     53413 ±  2%     -31.6%      36546 ±  3%  stress-ng.access.ops_per_sec
    986.54            +3.3%       1019        stress-ng.time.system_time
     84.65           -38.6%      51.96 ±  3%  stress-ng.time.user_time
      2106 ± 20%   +1099.7%      25265 ± 16%  stress-ng.time.voluntary_context_switches
   1072057 ±  5%     -37.2%     672895        meminfo.Active
   1064629 ±  5%     -37.5%     665595        meminfo.Active(anon)
   4082564            -9.8%    3684032        meminfo.Cached
   1788561 ±  3%     -22.4%    1387627        meminfo.Committed_AS
    179009 ±  5%     -17.7%     147259        meminfo.Mapped
   1143280 ±  4%     -34.9%     744688        meminfo.Shmem
     15.41 ±110%   +9878.0%       1537 ± 97%  numa-vmstat.node0.nr_inactive_file
     15.41 ±110%   +9878.0%       1537 ± 97%  numa-vmstat.node0.nr_zone_inactive_file
    265557 ±  4%     -37.7%     165354        numa-vmstat.node1.nr_active_anon
    281344 ±  5%     -36.6%     178448 ±  4%  numa-vmstat.node1.nr_shmem
    265557 ±  4%     -37.7%     165353        numa-vmstat.node1.nr_zone_active_anon
    615784 ±  4%     -24.9%     462381 ±  3%  numa-vmstat.node1.numa_hit
    590259 ±  2%     -24.6%     445111 ±  6%  numa-vmstat.node1.numa_local
    266182 ±  5%     -37.5%     166417        proc-vmstat.nr_active_anon
   1022496            -9.7%     922860        proc-vmstat.nr_file_pages
     44792 ±  5%     -17.7%      36844        proc-vmstat.nr_mapped
    285854 ±  4%     -34.9%     186196        proc-vmstat.nr_shmem
     25006            -1.2%      24718        proc-vmstat.nr_slab_reclaimable
    266182 ±  5%     -37.5%     166417        proc-vmstat.nr_zone_active_anon
    795660 ±  2%     -18.0%     652290        proc-vmstat.numa_hit
    729463 ±  2%     -19.7%     586060        proc-vmstat.numa_local
    837168 ±  2%     -16.9%     695403        proc-vmstat.pgalloc_normal
    417791            -2.3%     408171        proc-vmstat.pgfault
    247.49 ±  3%     -39.2%     150.43 ± 50%  perf-sched.total_wait_and_delay.average.ms
      2613          +166.5%       6962 ± 76%  perf-sched.total_wait_and_delay.count.ms
    247.09 ±  2%     -39.3%     149.99 ± 50%  perf-sched.total_wait_time.average.ms
      0.04 ± 21%     -71.2%       0.01 ±143%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     17.66 ±  5%     -29.3%      12.49 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     28.67 ± 17%     -80.2%       5.67 ±141%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     83.50 ± 23%    +543.5%     537.33 ± 56%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.chmod_common
    280.00 ±  5%     +41.5%     396.33 ±  9%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.02 ± 12%     -44.5%       0.01 ± 11%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.chmod_common
     17.65 ±  5%     -29.3%      12.48 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    166.68 ±223%    -100.0%       0.01 ±100%  perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
 8.735e+09           -27.6%  6.326e+09        perf-stat.i.branch-instructions
  16798144 ±  2%     -19.8%   13465773 ±  4%  perf-stat.i.branch-misses
  57796602 ±  5%     -26.2%   42673885 ±  2%  perf-stat.i.cache-references
      2093 ±  8%     +41.3%       2957 ± 12%  perf-stat.i.context-switches
      1.20           +40.5%       1.68        perf-stat.i.cpi
 1.219e+10           -30.9%  8.419e+09        perf-stat.i.dTLB-loads
      0.00            +0.3        0.28 ±221%  perf-stat.i.dTLB-store-miss-rate%
 6.908e+09           -35.4%  4.462e+09 ±  2%  perf-stat.i.dTLB-stores
 4.629e+10           -29.2%  3.279e+10        perf-stat.i.instructions
      0.84           -28.1%       0.60        perf-stat.i.ipc
    434.95           -31.0%     300.07        perf-stat.i.metric.M/sec
      4147            -3.3%       4010 ±  2%  perf-stat.i.minor-faults
  11055092 ± 19%     -30.3%    7710119 ± 23%  perf-stat.i.node-load-misses
      4147            -3.3%       4010 ±  2%  perf-stat.i.page-faults
      0.19 ±  2%      +0.0        0.21 ±  4%  perf-stat.overall.branch-miss-rate%
      1.20           +41.1%       1.70        perf-stat.overall.cpi
      0.00           +16.7       16.65 ±223%  perf-stat.overall.dTLB-store-miss-rate%
      0.83           -29.1%       0.59        perf-stat.overall.ipc
     95.51            -1.6       93.90        perf-stat.overall.node-load-miss-rate%
     76.99            -2.4       74.60        perf-stat.overall.node-store-miss-rate%
 8.596e+09           -27.6%  6.225e+09        perf-stat.ps.branch-instructions
  16491868 ±  2%     -19.9%   13215979 ±  4%  perf-stat.ps.branch-misses
  56882728 ±  5%     -26.2%   41989249 ±  2%  perf-stat.ps.cache-references
      2056 ±  8%     +41.3%       2904 ± 12%  perf-stat.ps.context-switches
 1.199e+10           -30.9%  8.285e+09        perf-stat.ps.dTLB-loads
   6.8e+09           -35.4%  4.391e+09 ±  2%  perf-stat.ps.dTLB-stores
 4.556e+10           -29.2%  3.226e+10        perf-stat.ps.instructions
      4069            -3.3%       3934 ±  2%  perf-stat.ps.minor-faults
  10876361 ± 19%     -30.2%    7587434 ± 23%  perf-stat.ps.node-load-misses
      4069            -3.3%       3934 ±  2%  perf-stat.ps.page-faults
 2.857e+12           -29.5%  2.015e+12        perf-stat.total.instructions
     12.95 ±  3%      -5.3        7.70 ±  8%  perf-profile.calltrace.cycles-pp.access
     12.33 ±  3%      -5.0        7.32 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.access
     12.22 ±  4%      -5.0        7.26 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.access
     11.34 ±  3%      -4.6        6.73 ±  7%  perf-profile.calltrace.cycles-pp.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.access
     10.47 ±  3%      -3.8        6.66 ±  6%  perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.30 ±  7%      -3.6        5.69 ±  7%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change
      9.72 ±  3%      -3.5        6.17 ±  6%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.do_faccessat.do_syscall_64
      8.68 ±  3%      -3.5        5.17 ±  8%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.access
      7.28 ±  5%      -2.9        4.42 ±  7%  perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.ext4_setattr.notify_change.chmod_common
      7.24 ±  5%      -2.8        4.39 ±  7%  perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.ext4_setattr.notify_change
      5.76 ±  8%      -2.5        3.30 ±  9%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      5.29 ±  8%      -2.4        2.88 ±  9%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      6.76 ±  5%      -2.1        4.62 ±  4%  perf-profile.calltrace.cycles-pp.syscall
      5.97 ±  5%      -1.9        4.07 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
      5.84 ±  5%      -1.9        3.99 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      5.56 ±  5%      -1.8        3.79 ±  4%  perf-profile.calltrace.cycles-pp.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      4.16 ±  2%      -1.6        2.57 ±  9%  perf-profile.calltrace.cycles-pp.getname_flags.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.90 ±  5%      -1.6        3.33 ±  4%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      4.04 ±  3%      -1.4        2.66 ±  2%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.user_path_at_empty.do_faccessat
      3.20 ±  9%      -1.3        1.93 ± 19%  perf-profile.calltrace.cycles-pp.complete_walk.path_lookupat.filename_lookup.user_path_at_empty.do_faccessat
      3.13 ±  9%      -1.2        1.89 ± 19%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.path_lookupat.filename_lookup.user_path_at_empty
      2.60 ± 12%      -1.2        1.38 ±  3%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.user_path_at_empty.do_faccessat.do_syscall_64
      1.60 ± 32%      -1.2        0.41 ± 71%  perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.ext4_setattr
      3.02 ± 10%      -1.2        1.83 ± 20%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat.filename_lookup
      2.43 ±  5%      -1.2        1.24 ± 13%  perf-profile.calltrace.cycles-pp.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_dirty_inode
      2.83 ± 10%      -1.1        1.71 ± 21%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.complete_walk.path_lookupat
      3.62 ±  5%      -1.1        2.50 ±  4%  perf-profile.calltrace.cycles-pp.faccessat
      3.31 ± 10%      -1.0        2.32 ±  5%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      2.14 ±  4%      -1.0        1.17 ±  5%  perf-profile.calltrace.cycles-pp.user_path_at_empty.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe.chmod
      3.08 ±  5%      -1.0        2.12 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.faccessat
      3.03 ±  5%      -0.9        2.08 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.faccessat
      2.08 ± 10%      -0.9        1.14 ±  7%  perf-profile.calltrace.cycles-pp.stress_access_spawn
      2.91 ±  5%      -0.9        2.01 ±  4%  perf-profile.calltrace.cycles-pp.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.faccessat
      3.02 ± 11%      -0.9        2.15 ±  6%  perf-profile.calltrace.cycles-pp.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty
      1.79 ±  4%      -0.8        0.95 ± 11%  perf-profile.calltrace.cycles-pp.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      1.76 ±  5%      -0.8        0.93 ± 11%  perf-profile.calltrace.cycles-pp.ext4_inode_csum.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty
      2.96 ± 11%      -0.8        2.13 ±  6%  perf-profile.calltrace.cycles-pp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      2.54 ±  5%      -0.8        1.75 ±  4%  perf-profile.calltrace.cycles-pp.user_path_at_empty.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.faccessat
      1.87 ±  4%      -0.8        1.09 ±  7%  perf-profile.calltrace.cycles-pp.inode_permission.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe.access
      1.63 ±  5%      -0.8        0.86 ± 12%  perf-profile.calltrace.cycles-pp.crc32c_pcl_intel_update.ext4_inode_csum.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode
      1.08 ±  8%      -0.8        0.32 ±100%  perf-profile.calltrace.cycles-pp.common_perm_cond.security_path_chmod.chmod_common.__x64_sys_chmod.do_syscall_64
      2.75 ± 13%      -0.7        2.00 ±  7%  perf-profile.calltrace.cycles-pp.bdev_getblk.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty
      2.68 ± 13%      -0.7        1.96 ±  7%  perf-profile.calltrace.cycles-pp.__find_get_block.bdev_getblk.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      2.26 ±  5%      -0.7        1.55 ±  5%  perf-profile.calltrace.cycles-pp.__fxstatat64
      1.12 ±  8%      -0.7        0.42 ± 72%  perf-profile.calltrace.cycles-pp.security_path_chmod.chmod_common.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.05 ±  5%      -0.6        1.41 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__fxstatat64
      2.02 ±  5%      -0.6        1.39 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstatat64
      1.96 ±  5%      -0.6        1.34 ±  5%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstatat64
      1.47 ±  4%      -0.6        0.86 ±  4%  perf-profile.calltrace.cycles-pp.__sched_yield
      1.32 ±  4%      -0.6        0.72 ±  6%  perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.45 ± 14%      -0.6        0.90 ±  6%  perf-profile.calltrace.cycles-pp.stress_access
      1.20 ±  3%      -0.5        0.66 ±  5%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.__x64_sys_chmod.do_syscall_64
      1.64 ±  4%      -0.5        1.12 ±  5%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstatat64
      1.21 ±  7%      -0.5        0.70 ±  3%  perf-profile.calltrace.cycles-pp.generic_permission.inode_permission.do_faccessat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.27 ± 10%      -0.5        0.78 ± 20%  perf-profile.calltrace.cycles-pp.up_write.chmod_common.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.18 ±  5%      -0.5        0.69 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.14 ±  5%      -0.5        0.66 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.72 ±  4%      -0.5        0.26 ±100%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat
      0.90 ±  5%      -0.4        0.45 ± 44%  perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.04 ±  5%      -0.4        0.61 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      1.03 ±  8%      -0.4        0.59 ±  3%  perf-profile.calltrace.cycles-pp.capable_wrt_inode_uidgid.generic_permission.inode_permission.do_faccessat.do_syscall_64
      1.00 ±  8%      -0.4        0.58 ±  4%  perf-profile.calltrace.cycles-pp.security_capable.capable_wrt_inode_uidgid.generic_permission.inode_permission.do_faccessat
      0.85 ±  6%      -0.4        0.42 ± 44%  perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98 ±  8%      -0.4        0.56 ±  4%  perf-profile.calltrace.cycles-pp.apparmor_capable.security_capable.capable_wrt_inode_uidgid.generic_permission.inode_permission
      1.10 ±  4%      -0.3        0.76 ±  6%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ±  4%      -0.3        0.47 ± 45%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newfstatat.do_syscall_64
      2.02 ±  4%      +0.2        2.20 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.96 ±  4%      +0.2        2.15 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.10 ±  4%      +0.2        2.30 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.12 ±  4%      +0.2        2.31 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.12 ±  4%      +0.2        2.32 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.12 ±  4%      +0.2        2.32 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      2.16 ±  3%      +0.2        2.36 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      6.39 ±  2%      +4.3       10.71 ±  5%  perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
      0.00            +4.5        4.50 ±  8%  perf-profile.calltrace.cycles-pp._raw_read_lock.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     14.32 ±  7%      +5.5       19.87 ±  9%  perf-profile.calltrace.cycles-pp.fchmod
     14.16 ±  7%      +5.6       19.76 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fchmod
     14.14 ±  7%      +5.6       19.74 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fchmod
     14.09 ±  7%      +5.6       19.70 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_fchmod.do_syscall_64.entry_SYSCALL_64_after_hwframe.fchmod
     14.02 ±  7%      +5.6       19.66 ±  9%  perf-profile.calltrace.cycles-pp.chmod_common.__x64_sys_fchmod.do_syscall_64.entry_SYSCALL_64_after_hwframe.fchmod
     13.62 ±  7%      +5.8       19.38 ±  9%  perf-profile.calltrace.cycles-pp.notify_change.chmod_common.__x64_sys_fchmod.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.40 ±  7%      +5.8       19.23 ± 10%  perf-profile.calltrace.cycles-pp.ext4_setattr.notify_change.chmod_common.__x64_sys_fchmod.do_syscall_64
     13.19 ±  7%      +5.9       19.08 ± 10%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.ext4_setattr.notify_change.chmod_common.__x64_sys_fchmod
     51.41 ±  2%      +6.1       57.47 ±  3%  perf-profile.calltrace.cycles-pp.chmod
     51.07 ±  2%      +6.2       57.29 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.chmod
     51.03 ±  2%      +6.2       57.27 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.chmod
     50.04 ±  2%      +6.8       56.79 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe.chmod
     15.81 ±  3%      +7.5       23.33 ±  4%  perf-profile.calltrace.cycles-pp.down_write.chmod_common.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe
     47.64 ±  2%      +7.9       55.49 ±  3%  perf-profile.calltrace.cycles-pp.chmod_common.__x64_sys_chmod.do_syscall_64.entry_SYSCALL_64_after_hwframe.chmod
     14.40 ±  4%      +8.1       22.50 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.chmod_common.__x64_sys_chmod.do_syscall_64
     13.22 ±  4%      +8.6       21.82 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.chmod_common.__x64_sys_chmod
     12.41 ±  5%      +9.0       21.42 ±  5%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.chmod_common
     31.66 ±  3%     +11.6       43.30 ±  3%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change.chmod_common
     22.22 ±  7%     +15.3       37.52 ±  5%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change
     21.29 ±  7%     +15.7       37.02 ±  5%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
     19.90 ±  3%      -7.3       12.58 ±  4%  perf-profile.children.cycles-pp.do_faccessat
     18.35 ±  2%      -6.9       11.46 ±  4%  perf-profile.children.cycles-pp.user_path_at_empty
     13.26 ±  3%      -5.4        7.88 ±  8%  perf-profile.children.cycles-pp.access
     12.64 ±  2%      -4.7        7.95 ±  5%  perf-profile.children.cycles-pp.filename_lookup
     11.78 ±  2%      -4.4        7.42 ±  5%  perf-profile.children.cycles-pp.path_lookupat
      9.31 ±  7%      -3.6        5.70 ±  7%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      7.29 ±  5%      -2.9        4.43 ±  7%  perf-profile.children.cycles-pp.__ext4_journal_stop
      7.26 ±  5%      -2.9        4.40 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_stop
      5.77 ±  8%      -2.5        3.31 ±  9%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      5.31 ±  8%      -2.4        2.89 ±  8%  perf-profile.children.cycles-pp.ext4_do_update_inode
      7.07 ±  5%      -2.2        4.83 ±  4%  perf-profile.children.cycles-pp.syscall
      5.77 ±  3%      -2.1        3.64 ±  3%  perf-profile.children.cycles-pp.getname_flags
      5.30 ±  2%      -1.9        3.43 ±  2%  perf-profile.children.cycles-pp.link_path_walk
      4.20 ±  7%      -1.6        2.57 ± 15%  perf-profile.children.cycles-pp.complete_walk
      4.03 ±  7%      -1.6        2.46 ± 15%  perf-profile.children.cycles-pp.try_to_unlazy
      3.77 ±  8%      -1.5        2.30 ± 16%  perf-profile.children.cycles-pp.__legitimize_path
      3.56 ±  3%      -1.4        2.20 ±  3%  perf-profile.children.cycles-pp.inode_permission
      3.53 ±  3%      -1.3        2.20 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      2.87 ±  4%      -1.3        1.59 ± 11%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      3.16 ± 10%      -1.2        1.92 ± 19%  perf-profile.children.cycles-pp.lockref_get_not_dead
      3.77 ±  5%      -1.2        2.61 ±  4%  perf-profile.children.cycles-pp.faccessat
      3.32 ± 10%      -1.0        2.32 ±  5%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      2.13 ± 10%      -1.0        1.17 ±  7%  perf-profile.children.cycles-pp.stress_access_spawn
      1.80 ± 21%      -1.0        0.85 ±  6%  perf-profile.children.cycles-pp.stop_this_handle
      2.07 ±  4%      -0.9        1.14 ±  9%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      2.03 ±  4%      -0.9        1.12 ±  9%  perf-profile.children.cycles-pp.ext4_inode_csum
      2.26 ±  4%      -0.9        1.38        perf-profile.children.cycles-pp.generic_permission
      3.03 ± 11%      -0.9        2.16 ±  6%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      2.06 ± 10%      -0.8        1.23 ±  9%  perf-profile.children.cycles-pp.kmem_cache_alloc
      2.97 ± 11%      -0.8        2.14 ±  6%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      1.84 ±  4%      -0.8        1.01 ± 10%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      2.77 ± 13%      -0.8        2.02 ±  7%  perf-profile.children.cycles-pp.bdev_getblk
      2.70 ± 13%      -0.7        1.98 ±  7%  perf-profile.children.cycles-pp.__find_get_block
      2.32 ±  5%      -0.7        1.60 ±  5%  perf-profile.children.cycles-pp.__fxstatat64
      1.58 ±  4%      -0.7        0.92 ±  5%  perf-profile.children.cycles-pp.__sched_yield
      1.40 ± 12%      -0.6        0.75 ± 23%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.68 ±  3%      -0.6        1.04 ±  3%  perf-profile.children.cycles-pp.__check_object_size
      1.97 ±  5%      -0.6        1.35 ±  5%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      1.50 ± 14%      -0.6        0.93 ±  5%  perf-profile.children.cycles-pp.stress_access
      1.19 ±  7%      -0.6        0.62 ± 14%  perf-profile.children.cycles-pp.security_path_chmod
      1.16 ±  7%      -0.6        0.61 ± 14%  perf-profile.children.cycles-pp.common_perm_cond
      1.72 ±  4%      -0.5        1.17 ±  5%  perf-profile.children.cycles-pp.vfs_fstatat
      1.51 ±  3%      -0.5        0.98 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.51 ±  3%      -0.5        0.98 ±  2%  perf-profile.children.cycles-pp.walk_component
      1.32 ± 10%      -0.5        0.81 ± 20%  perf-profile.children.cycles-pp.up_write
      1.02 ± 16%      -0.5        0.51 ± 32%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      1.05 ±  5%      -0.4        0.61 ±  4%  perf-profile.children.cycles-pp.__x64_sys_sched_yield
      1.03 ±  8%      -0.4        0.60 ±  4%  perf-profile.children.cycles-pp.capable_wrt_inode_uidgid
      1.01 ± 32%      -0.4        0.58 ± 16%  perf-profile.children.cycles-pp.__brelse
      1.01 ±  8%      -0.4        0.58 ±  3%  perf-profile.children.cycles-pp.security_capable
      0.99 ±  8%      -0.4        0.57 ±  4%  perf-profile.children.cycles-pp.apparmor_capable
      1.09 ±  3%      -0.4        0.71 ±  2%  perf-profile.children.cycles-pp.lookup_fast
      0.42 ± 17%      -0.4        0.03 ±101%  perf-profile.children.cycles-pp.osq_lock
      0.91 ±  5%      -0.4        0.54 ±  4%  perf-profile.children.cycles-pp.schedule
      0.88 ±  6%      -0.4        0.52 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.96 ±  4%      -0.4        0.61        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.12 ±  3%      -0.3        0.77 ±  6%  perf-profile.children.cycles-pp.vfs_statx
      0.86 ± 18%      -0.3        0.52 ± 24%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.88 ±  3%      -0.3        0.56 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.80 ±  5%      -0.3        0.48 ±  4%  perf-profile.children.cycles-pp.check_heap_object
      0.70 ± 26%      -0.3        0.38 ± 28%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.87 ±  4%      -0.3        0.56 ±  2%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.82 ±  4%      -0.3        0.52 ±  9%  perf-profile.children.cycles-pp.path_init
      0.76 ±  3%      -0.3        0.46 ±  4%  perf-profile.children.cycles-pp.dput
      0.77 ±  3%      -0.3        0.48 ±  3%  perf-profile.children.cycles-pp.path_put
      0.61 ±  4%      -0.2        0.38 ±  2%  perf-profile.children.cycles-pp.step_into
      0.58            -0.2        0.37 ±  3%  perf-profile.children.cycles-pp.__cond_resched
      0.49 ±  6%      -0.2        0.28 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.49 ±  6%      -0.2        0.29 ±  5%  perf-profile.children.cycles-pp.lockref_put_return
      0.51 ±  4%      -0.2        0.33 ±  4%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.47 ±  3%      -0.2        0.29 ±  3%  perf-profile.children.cycles-pp.putname
      0.49 ±  5%      -0.2        0.31 ±  3%  perf-profile.children.cycles-pp.__check_heap_object
      0.48 ±  3%      -0.2        0.30 ±  4%  perf-profile.children.cycles-pp.make_vfsuid
      0.31 ± 30%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.38 ±  9%      -0.2        0.23 ±  7%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.43 ±  3%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.security_inode_permission
      0.35            -0.1        0.21        perf-profile.children.cycles-pp.stress_time_now_timespec
      0.23 ± 41%      -0.1        0.10 ± 12%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.28 ±  7%      -0.1        0.16 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.26 ±  6%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.terminate_walk
      0.23 ±  6%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.stress_time_now
      0.24 ±  3%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.22 ±  4%      -0.1        0.14        perf-profile.children.cycles-pp.make_kuid
      0.20 ±  4%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.map_id_up
      0.26 ±  4%      -0.1        0.18 ±  4%  perf-profile.children.cycles-pp.getuid
      0.21 ±  2%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.24 ± 10%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.mnt_want_write
      0.19 ±  2%      -0.1        0.12 ±  3%  perf-profile.children.cycles-pp.map_id_range_down
      0.22 ±  7%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.21 ±  3%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.rcu_all_qs
      0.17 ± 12%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.clock_gettime
      0.14 ± 17%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.do_sched_yield
      0.17 ±  6%      -0.1        0.11 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.18 ±  6%      -0.1        0.12 ±  5%  perf-profile.children.cycles-pp.mntput_no_expire
      0.20 ± 10%      -0.1        0.14 ± 11%  perf-profile.children.cycles-pp.cp_new_stat
      0.20 ± 13%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.mnt_get_write_access
      0.13 ±  7%      -0.1        0.08 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      0.13 ± 11%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp.pick_next_entity
      0.16 ±  4%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.handle_dots
      0.14 ±  9%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.setattr_prepare
      0.12 ±  4%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.stress_mwc8modn
      0.13 ±  9%      -0.1        0.08 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      0.12 ±  6%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.legitimize_links
      0.07 ± 10%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.crypto_shash_update
      0.07 ± 10%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.osq_unlock
      0.12 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.setattr_copy
      0.09 ±  7%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.current_time
      0.12 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.check_stack_object
      0.07 ±  8%      -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.in_group_or_capable
      0.11 ± 12%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__pick_eevdf
      0.13 ±  6%      -0.0        0.09 ± 10%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.12 ±  6%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.shim_faccessat
      0.09 ± 10%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.is_vmalloc_addr
      0.10 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.10 ± 10%      -0.0        0.07 ± 11%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
      0.11 ±  7%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
      0.11 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.mntput
      0.11 ±  8%      -0.0        0.08 ± 10%  perf-profile.children.cycles-pp.sched_clock
      0.10 ±  5%      -0.0        0.07 ± 10%  perf-profile.children.cycles-pp.ext4_file_getattr
      0.10 ± 19%      -0.0        0.07 ±  8%  perf-profile.children.cycles-pp._copy_to_user
      0.08 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.make_vfsgid
      0.07 ±  6%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.ext4_getattr
      2.05 ±  3%      +0.2        2.24 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      2.04 ±  3%      +0.2        2.24 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      2.12 ±  4%      +0.2        2.32 ±  4%  perf-profile.children.cycles-pp.start_secondary
      2.14 ±  3%      +0.2        2.34 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      2.16 ±  3%      +0.2        2.36 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      2.16 ±  3%      +0.2        2.36 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      2.16 ±  3%      +0.2        2.36 ±  4%  perf-profile.children.cycles-pp.do_idle
     90.05            +2.8       92.85        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     89.74            +2.9       92.64        perf-profile.children.cycles-pp.do_syscall_64
      0.63 ±  8%      +3.9        4.50 ±  8%  perf-profile.children.cycles-pp._raw_read_lock
      6.40 ±  2%      +4.3       10.72 ±  5%  perf-profile.children.cycles-pp.add_transaction_credits
     14.40 ±  7%      +5.5       19.92 ±  9%  perf-profile.children.cycles-pp.fchmod
     14.09 ±  7%      +5.6       19.71 ±  9%  perf-profile.children.cycles-pp.__x64_sys_fchmod
     51.52 ±  2%      +6.0       57.54 ±  3%  perf-profile.children.cycles-pp.chmod
     50.05 ±  2%      +6.8       56.80 ±  3%  perf-profile.children.cycles-pp.__x64_sys_chmod
     42.89            +7.2       50.09 ±  2%  perf-profile.children.cycles-pp.notify_change
     42.26            +7.4       49.70 ±  2%  perf-profile.children.cycles-pp.ext4_setattr
     15.86 ±  3%      +7.5       23.37 ±  4%  perf-profile.children.cycles-pp.down_write
     40.82 ±  2%      +8.1       48.90 ±  2%  perf-profile.children.cycles-pp.__mark_inode_dirty
     14.41 ±  4%      +8.1       22.51 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     13.24 ±  4%      +8.6       21.82 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     12.42 ±  5%      +9.0       21.43 ±  5%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
     31.68 ±  3%     +11.6       43.32 ±  3%  perf-profile.children.cycles-pp.ext4_dirty_inode
     61.69           +13.5       75.17        perf-profile.children.cycles-pp.chmod_common
     22.23 ±  7%     +15.3       37.53 ±  5%  perf-profile.children.cycles-pp.jbd2__journal_start
     21.32 ±  7%     +15.7       37.03 ±  5%  perf-profile.children.cycles-pp.start_this_handle
      5.33 ±  2%      -1.9        3.47 ±  8%  perf-profile.self.cycles-pp.jbd2_journal_stop
      3.11 ± 10%      -1.2        1.89 ± 19%  perf-profile.self.cycles-pp.lockref_get_not_dead
      1.76 ± 21%      -1.0        0.81 ±  7%  perf-profile.self.cycles-pp.stop_this_handle
      2.09 ± 10%      -0.9        1.15 ±  7%  perf-profile.self.cycles-pp.stress_access_spawn
      1.81 ±  5%      -0.8        0.99 ± 10%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      2.27 ±  2%      -0.8        1.45 ±  2%  perf-profile.self.cycles-pp.link_path_walk
      1.85 ±  6%      -0.7        1.15 ± 17%  perf-profile.self.cycles-pp.__mark_inode_dirty
      2.64 ± 13%      -0.7        1.94 ±  7%  perf-profile.self.cycles-pp.__find_get_block
      1.86 ±  2%      -0.7        1.17 ±  3%  perf-profile.self.cycles-pp.strncpy_from_user
      1.42 ±  9%      -0.6        0.84 ± 16%  perf-profile.self.cycles-pp.down_write
      1.47 ± 14%      -0.6        0.91 ±  5%  perf-profile.self.cycles-pp.stress_access
      1.14 ±  7%      -0.5        0.59 ± 15%  perf-profile.self.cycles-pp.common_perm_cond
      1.30 ± 10%      -0.5        0.80 ± 20%  perf-profile.self.cycles-pp.up_write
      0.96 ± 17%      -0.5        0.47 ± 35%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      1.16 ±  3%      -0.5        0.68 ± 14%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      1.27 ±  5%      -0.5        0.80 ± 10%  perf-profile.self.cycles-pp.inode_permission
      0.72 ± 12%      -0.5        0.27 ±  6%  perf-profile.self.cycles-pp.ext4_do_update_inode
      1.00 ± 32%      -0.4        0.58 ± 16%  perf-profile.self.cycles-pp.__brelse
      0.98 ±  8%      -0.4        0.56 ±  3%  perf-profile.self.cycles-pp.apparmor_capable
      1.09 ±  3%      -0.4        0.68        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.93 ±  3%      -0.3        0.59        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.94 ± 19%      -0.3        0.60 ± 12%  perf-profile.self.cycles-pp.getname_flags
      0.82 ± 19%      -0.3        0.50 ± 25%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.88 ±  2%      -0.3        0.56        perf-profile.self.cycles-pp.generic_permission
      0.84 ±  2%      -0.3        0.52 ±  3%  perf-profile.self.cycles-pp.filename_lookup
      0.85 ±  3%      -0.3        0.54 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.67 ± 27%      -0.3        0.36 ± 29%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.68 ±  8%      -0.3        0.38 ± 27%  perf-profile.self.cycles-pp.ext4_fill_raw_inode
      0.78 ±  5%      -0.3        0.49 ±  9%  perf-profile.self.cycles-pp.path_init
      0.78 ±  4%      -0.3        0.50 ±  2%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.64 ±  5%      -0.2        0.41 ±  6%  perf-profile.self.cycles-pp.do_faccessat
      0.56 ±  3%      -0.2        0.36 ±  2%  perf-profile.self.cycles-pp.step_into
      0.47 ±  6%      -0.2        0.28 ±  5%  perf-profile.self.cycles-pp.lockref_put_return
      0.45 ±  3%      -0.2        0.28 ±  2%  perf-profile.self.cycles-pp.putname
      0.46 ±  6%      -0.2        0.29 ±  2%  perf-profile.self.cycles-pp.__check_heap_object
      0.47 ±  5%      -0.2        0.30 ±  4%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.39 ±  3%      -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.path_lookupat
      0.36 ±  8%      -0.1        0.21 ±  6%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.34 ±  3%      -0.1        0.20 ±  4%  perf-profile.self.cycles-pp.access
      0.40 ±  6%      -0.1        0.26 ±  3%  perf-profile.self.cycles-pp.walk_component
      0.36 ±  3%      -0.1        0.22 ±  7%  perf-profile.self.cycles-pp.make_vfsuid
      0.36            -0.1        0.23 ±  3%  perf-profile.self.cycles-pp.__cond_resched
      0.34 ±  6%      -0.1        0.21 ±  6%  perf-profile.self.cycles-pp.check_heap_object
      0.37 ±  2%      -0.1        0.24 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.36 ±  4%      -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.security_inode_permission
      0.30 ±  2%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.stress_time_now_timespec
      0.34 ±  4%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.38 ±  5%      -0.1        0.27 ±  5%  perf-profile.self.cycles-pp.syscall
      0.33 ± 12%      -0.1        0.22 ± 19%  perf-profile.self.cycles-pp.notify_change
      0.34 ±  4%      -0.1        0.22 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.31 ±  2%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp.__check_object_size
      0.36 ±  6%      -0.1        0.26 ±  4%  perf-profile.self.cycles-pp.faccessat
      0.27 ±  3%      -0.1        0.17 ±  4%  perf-profile.self.cycles-pp.lookup_fast
      0.24 ±  6%      -0.1        0.14 ±  8%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.21 ±  2%      -0.1        0.13 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.22 ±  7%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.16 ±  9%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.18 ±  2%      -0.1        0.11 ±  5%  perf-profile.self.cycles-pp.chmod_common
      0.18 ±  3%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.user_path_at_empty
      0.20 ±  3%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.17 ±  5%      -0.1        0.10 ±  9%  perf-profile.self.cycles-pp.map_id_up
      0.15 ±  4%      -0.1        0.08 ± 13%  perf-profile.self.cycles-pp.__schedule
      0.15 ± 12%      -0.1        0.08 ± 11%  perf-profile.self.cycles-pp.clock_gettime
      0.16 ±  7%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.stress_time_now
      0.13 ±  5%      -0.1        0.07 ±  8%  perf-profile.self.cycles-pp.chmod
      0.16 ±  6%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.complete_walk
      0.15 ± 14%      -0.1        0.09 ±  9%  perf-profile.self.cycles-pp.__legitimize_path
      0.16 ±  4%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.try_to_unlazy
      0.16 ±  6%      -0.1        0.10 ±  4%  perf-profile.self.cycles-pp.mntput_no_expire
      0.14 ±  5%      -0.1        0.08 ±  8%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.19 ± 13%      -0.1        0.13 ±  5%  perf-profile.self.cycles-pp.mnt_get_write_access
      0.14 ±  2%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.dput
      0.16 ±  4%      -0.1        0.10        perf-profile.self.cycles-pp.map_id_range_down
      0.14 ±  8%      -0.1        0.09 ±  8%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.16 ±  4%      -0.1        0.10 ±  6%  perf-profile.self.cycles-pp.terminate_walk
      0.11 ±  6%      -0.1        0.06 ±  9%  perf-profile.self.cycles-pp.stress_mwc8modn
      0.15 ±  3%      -0.1        0.10 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.12 ±  4%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__sched_yield
      0.10 ±  7%      -0.0        0.05 ± 45%  perf-profile.self.cycles-pp.update_curr
      0.08 ±  7%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.14 ±  2%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.handle_dots
      0.10 ±  6%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.check_stack_object
      0.10 ±  7%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.08 ±  7%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.jbd2__journal_start
      0.10 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.ext4_setattr
      0.10 ±  7%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.legitimize_links
      0.07 ±  6%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.fchmod
      0.10 ± 19%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp._copy_to_user
      0.10 ±  8%      -0.0        0.07 ± 10%  perf-profile.self.cycles-pp.shim_faccessat
      0.10 ±  9%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
      0.07 ±  8%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.mntput
      0.07 ±  8%      -0.0        0.04 ± 45%  perf-profile.self.cycles-pp.cp_new_stat
      0.07 ±  9%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__fxstatat64
      0.62 ±  9%      +3.9        4.48 ±  8%  perf-profile.self.cycles-pp._raw_read_lock
      6.37 ±  2%      +4.3       10.68 ±  5%  perf-profile.self.cycles-pp.add_transaction_credits
     14.25 ± 12%      +7.5       21.75 ±  4%  perf-profile.self.cycles-pp.start_this_handle
     12.38 ±  5%      +9.0       21.36 ±  5%  perf-profile.self.cycles-pp.rwsem_spin_on_owner





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


