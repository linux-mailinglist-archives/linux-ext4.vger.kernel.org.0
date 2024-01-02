Return-Path: <linux-ext4+bounces-590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02E8217FF
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 08:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838A5282363
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 07:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A71B23AD;
	Tue,  2 Jan 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5Trm3tw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9A20F9;
	Tue,  2 Jan 2024 07:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704180695; x=1735716695;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HGoeHa91jS41vDMV0Lca+BvCLVEXW0QYQ7/1m9RsEAE=;
  b=C5Trm3twsWnk/03FrChClgX4d4D6BJABstjw34T4lAjMZJ+SVV5A38Zh
   mHGbcMzzTzEoHUuJXg4UBKj2FOO7rPi+3HM2bttaQSe1YjAjFQt72NNmh
   4I9uPpPQMCIlol94MPPVwgeH0eSjOb7qlxh36fFgUBfLNJomHcHM2G5JC
   ARhXXU+j2RpWE6NikJ4s828fSdLJvzmdPY+FUpXSGA9Nf/Iav9/ASWyvb
   TvYO4FUZ7U8sW8HW/zOk13iD5V3nPanCayBLqNOgPWy7tsh3I9UUX4GGe
   gABneC78MQ3Scb3uRWvDTNr0rWEUVr23db+yS7Qpr1O6nzhtbopVopQmv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="396578088"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="396578088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 23:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="808446553"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="808446553"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jan 2024 23:31:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 23:31:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 23:31:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jan 2024 23:31:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jan 2024 23:31:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UodKRGPOA9fihp573/PkfGU7Sqp+rdPktKZZVITbPFraIATR+4KJkzzcRsdo1hDLG38KAjpYIs6E8ORsY6bBhxj5nuPpwgH1B8UB1Zv3MNerAew6n3z3Yi6bp60AWgr5+v0gXHekwl8m9ZXqvQ+D1DibxnEr/rea1OyY0vapM73cXe3J+J7Y3/bl8RmNJx8mzrW39rS0Wa6WdE4lg69EoJvLt/t8u6BKuxtFvzqCbUc7pfMu2vtg2fFDxgWwhbfTqJzpOdDe44FXZqGI3giJNfvswrebJw5yht1tdoSWHsUgvbIl5+5SpTqq0wLDS79Vh9lQgCEP4z/WfzRLxhOBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcNU7s61KiQxEappSv+vAcUS6waehmxVJrMQNeISCtE=;
 b=oHNkkKKYIqwNSS7/Jtl27ubRnMUqhAJWKDxgdPjdahEONWVjFsZblqclf4cJGdLcpWc4GvOJ/T59NzFoJ9e+oHp0EyKLytyZ67Xp3IJ+Jx3JSq8KBZ41A28I/5jiSwBFbvIs5a/hknpq3bVyf+4rCIzsU2KRZMKmeOfAs3I/LKuyPADSqxbDV2t11EWlc3BxX/tBF/oFYfuwiAvFsnZi7cNCjo7iyj6ajOQMkJj2hp+Ys1M0rdLeq74rFv39qTew+iVQlVhSkjqG6dlk/ZZWrXJ8mlzMcu7OGmNEwO72oS+/JugxQDTuIEbFPnJIps/9qgGvzvfS/EYceycIknIgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6929.namprd11.prod.outlook.com (2603:10b6:510:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 07:31:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 07:31:10 +0000
Date: Tue, 2 Jan 2024 15:31:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Yi <yi.zhang@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	<linux-ext4@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [jbd2]  6a3afb6ac6:  fileio.latency_95th_ms 92.5%
 regression
Message-ID: <202401021525.a27b9444-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: c91032cd-1fb3-42f1-da03-08dc0b64c9da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHrQQgLzng2xSLencNa/RZxPL+cB7LCXQAO1zblLXByKgtNGn2Gpjz1Z9eMu35mraZmei9i8wAx/T0IvcBuy3wh2qrfAha3uLoYKCgv/dOhWEiimvZ9Aw5lyoM+Qd7xxSm48lHHm2Y8qsVTh762NGQcfVXtW2zZeXRQU7fI+77MIz0gCUbWM+fiU9RtCJHq3VQIXtagMHFnUdOwrYKhOtQ6MYjG45EcLUvSxeQnRwTk9JLG3emAUQnLkGEFPl/tETPP0CbGljI8M8Ynu9r2Yjpr+N8dRJ61X6cv9zl9U9qEmzkI0DZJpgBc+zsuFV7ID96Py2kYvSLjJ1oBnzYI4SrtUPUArAPj8RSBMqvHmbQx3R16DagHIrNfECDtfnjDrNY9Fk+HOaYyCO9HPoxQ0dVJpOZoilZeSiH7Z52nR8v7IKAUvQySdELoqyHyNHOCu8Mc1SPmvmrTR1GRX87GYc1oSPyo7oU36u1oC8b/gjAFnLdua+PhM3XZDoubuzn920xugiuL1xHhCf6o5EpylBTn8VTWUWiauj0KOAWhgHvTHzdeL4X961CfW9fVp/0Xpi7ULEfLAs+vhBQWzL6kmbTw+Un233Em9z4txtVfh4YMIfVzjg9ql8vBq4jKZrluGcgdeTKlVpwp0K93aonJSGSqqBj1E2hVwHwqE3wWeQNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(230473577357003)(230373577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(107886003)(1076003)(83380400001)(6666004)(6506007)(6512007)(5660300002)(4326008)(41300700001)(2906002)(6486002)(478600001)(966005)(316002)(54906003)(66946007)(8676002)(8936002)(6916009)(66476007)(66556008)(86362001)(36756003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PTp0Niv31avmCYG1MkihHVg/HgGYT6AAWhP4984EYgW7w34lHiQXGTW+X1?=
 =?iso-8859-1?Q?xbuFVFBIGdMEuVVJ4NZqiLfBRzbOITW/Nq+HsnqrTdFvKaW41dKKbvsh44?=
 =?iso-8859-1?Q?cUQ3SRCIGoVyUdXGX5n/yKNXWNiAvAIzKHyztFYFXLqFZ0ImIt4UQxVwAR?=
 =?iso-8859-1?Q?pZKKklFzz2hyu4J6EosJHQ0UUF83MWzCcpLyimgUJ32te/MEkBJ0a4uNEU?=
 =?iso-8859-1?Q?jZqOOHw8Aep2X70C4PFWVsVFCcBVu/2O7o/dm10Dc69jZ5C+ossIquid7S?=
 =?iso-8859-1?Q?ctT/LzEHn0nWjsV9YDEr6wBIHjopq5F5uKfnOx784s5KlXawtXV8mIEIUc?=
 =?iso-8859-1?Q?XYoAWJEHbM7LXuso3/t57AGRx8m3eneouwWoq6PXAyXF869SV/xL7lq7Sj?=
 =?iso-8859-1?Q?csXSmVkHc2f/U1CcY0TxyM6iskSwsXxaNowRIDd+MrUXyCCZM2IWwBkzcl?=
 =?iso-8859-1?Q?5q6DEdgo9V8StJfTELKKFe+6ylNLEn8CHq3Kel6682JLDeMHeKX+eLTplo?=
 =?iso-8859-1?Q?gvbQYedfED+4Qcn3trCDp3eVt5hY+RuBpp+aRPqX3gz7sjp11RmwV4z90g?=
 =?iso-8859-1?Q?HoTffjGdnsahCqgYDn6VbEHfQKtCcdHhJss3B+0ZaQ179GFLnRLmdG53Pv?=
 =?iso-8859-1?Q?NGjXt1zpxX0NjDnD1yjXbdpJBWgwMWLLBGnfftU8+XDWcP24I6NDfTwd/x?=
 =?iso-8859-1?Q?0PLH07FTJBETVOH9Qdbr4B3lw4GN+RAQFYn0CImr947/wRU5LkzmVlNu4L?=
 =?iso-8859-1?Q?zmv2B9YzyGIQzZaMbcrOKrcip7ae+6C9a8ovDYGyWoFlZ7f4l4RuTKhfVw?=
 =?iso-8859-1?Q?UO2mvpk74I5J8jmU7X1zppJlmct2dtlIf/cvBiggC16G7Bs7+H2YdHRj1t?=
 =?iso-8859-1?Q?OTAa3PONqhoQspYlJReJP0gM/351eopDvTKHHEJCqBde/pb2uGuQw01dda?=
 =?iso-8859-1?Q?Kbi3BhYtJIBRCcNBp1ibH1QkYaWlm9VFFMzBCm8rH0KIwLdNVnoSuhfaPk?=
 =?iso-8859-1?Q?NxfIZ1uKSjfV0hdtqV+ffUHZNtLggebuTZK+dF+CpfYarpCxl5OxTKd/W+?=
 =?iso-8859-1?Q?j42gPFMuEDOWVXMSQjFsHqzSTKHOCj6qUkt5mbfXhqyZGOTPkM6TxNRA0y?=
 =?iso-8859-1?Q?whb4OJ2JT8GXnSfOup9BumbOAIZ/hL85PFww6GWFpDgImEIGHghb3QtgId?=
 =?iso-8859-1?Q?8jmrMRtuZREKoEcrCzjWYFxlk9mLdfMYfS4nt6IWGE5GbTTf0mUHFZJezf?=
 =?iso-8859-1?Q?ExZoyZdy05yZ1kgwUT4i5xbDphCw64HxQ39vzYkjDQiHAnYufFEYsafWfM?=
 =?iso-8859-1?Q?nGN75x4xn4a/2emGLZJrzkqs/rxZyRs41hGCAArnBLBX6nOtuGY3OIgAWx?=
 =?iso-8859-1?Q?EiJpbIBCjQ+FCTMrq+qHtQbageJ+CzIwsGyZg3iCqX1Sn8lT1HfSzvhWKK?=
 =?iso-8859-1?Q?5zdV7tdSSUyk3QSK5MMNR4yaCP52AiT3p+2XVAuxNqcmppJl1uF2belby2?=
 =?iso-8859-1?Q?mmAr2A8GMOjjMFOIQV55egxRsIqbdryZXAaFBzzu8wrWpdSvsZivEYQFpK?=
 =?iso-8859-1?Q?y75kJVQ0r8LkEpXSs0FxQ49zbDrRXSt9+vwEPeRV9+hVflAqL0+F8rIAvQ?=
 =?iso-8859-1?Q?Dkkp56R5zV9QQNRevvAInx6aPb5LqBb+YQnJciR5b+6VRX+4r1ciNpZA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c91032cd-1fb3-42f1-da03-08dc0b64c9da
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 07:31:09.2079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJVtnkJgvMdrIpH9x+Ef79WM/HxxOrH41Bb2a3DjZEWhUYLSHC6p2+raJNqP/c8HaGV8Z0kJm9qcCooRHn7Kgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6929
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 92.5% regression of fileio.latency_95th_ms on:


commit: 6a3afb6ac6dfab158ebdd4b87941178f58c8939f ("jbd2: increase the journal IO's priority")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fileio
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	period: 600s
	nr_threads: 100%
	disk: 1HDD
	fs: ext4
	size: 64G
	filenum: 1024f
	rwmode: seqwr
	iomode: sync
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401021525.a27b9444-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240102/202401021525.a27b9444-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filenum/fs/iomode/kconfig/nr_threads/period/rootfs/rwmode/size/tbox_group/testcase:
  gcc-12/performance/1HDD/1024f/ext4/sync/x86_64-rhel-8.3/100%/600s/debian-11.1-x86_64-20220510.cgz/seqwr/64G/lkp-icl-2sp5/fileio

commit: 
  8555922721 ("jbd2: correct the printing of write_flags in jbd2_write_superblock()")
  6a3afb6ac6 ("jbd2: increase the journal IO's priority")

85559227211020b2 6a3afb6ac6dfab158ebdd4b8794 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     37.99 ±  9%     +92.5%      73.13        fileio.latency_95th_ms
     19872 ± 16%     -24.1%      15078 ± 21%  numa-meminfo.node1.Active(file)
     24.74 ±  6%     +97.3%      48.81 ±  2%  perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
   8157448            -5.7%    7691858 ±  2%  proc-vmstat.pgpgout
     13464            -5.7%      12700 ±  2%  vmstat.io.bo
      4968 ± 16%     -24.1%       3768 ± 21%  numa-vmstat.node1.nr_active_file
      4968 ± 16%     -24.1%       3768 ± 21%  numa-vmstat.node1.nr_zone_active_file
      1413            +2.8%       1452 ±  2%  perf-stat.i.cycles-between-cache-misses
      1.59            -2.9%       1.54        perf-stat.overall.MPKI
      1368            +2.5%       1402        perf-stat.overall.cycles-between-cache-misses
    161.13 ±  9%     +17.4%     189.23 ± 10%  sched_debug.cpu.curr->pid.avg
     25531 ±  6%     -12.4%      22376 ±  8%  sched_debug.cpu.nr_switches.stddev
    -93.66           +38.8%    -130.00        sched_debug.cpu.nr_uninterruptible.min




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


