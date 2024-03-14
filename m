Return-Path: <linux-ext4+bounces-1620-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E702287B72C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 05:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EC16B2234C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061118BF0;
	Thu, 14 Mar 2024 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ve3yhTNL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2743611A
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710392251; cv=fail; b=hrUOQxNBEaYm6f2aYqDbb2suGt17r5ha6aTdQJQTbIuGfRf7sXi1uyQ3VNpDJWE/+grDneVA17n9riKGEoktCWmbhaxIe5Z1YFOseETlEFufYkOHGkaLpM2ppjU8Qt0imxLzebVHkaG5wLWFrzI2f8AWPxtQDFLKzwv9WvHJb5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710392251; c=relaxed/simple;
	bh=2Kc6XPQ8LHIKBjqZK7XFGGd4Zho+QX0DrlV1NJhZjOs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Bq3a7cXUy6M2w3IS1Bl8wdUigeMFytDbQXH3zrrtQs7dF+zDw7WXM3KfHJBsu0mypAO1Ob0Jhc6N1hR+DXd7+juLLk80W3M0rCj0xlPPAn3r99/TGAjoyJfEMeE5o6pk2ljBtAsl2PeKx06vmmqcIY287QPxxRzvbMzY0e9a+Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ve3yhTNL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710392249; x=1741928249;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Kc6XPQ8LHIKBjqZK7XFGGd4Zho+QX0DrlV1NJhZjOs=;
  b=Ve3yhTNLjG9Vc6juTKVzU6n8eBDRX82VTPtTdIPYzllDoy82Ub2F9bDB
   hDW6EFwakG9VJyuWyDVQO97JiACRw98BDR3Iyt5RJN0Sa/wZM6gCjKPTk
   T3ZTp1kcpWXCkoR3ZIWB/U0ksISUc30/gD3eDR1HCQheKADfMUB+MitQt
   AJEoZc7REajsUByWmOGQSE0eYwdEhWa7d6l92CBcZ3JdWJ03aa9JEM4Zj
   OZ+PTy63X9VyDYUGaHaI0l1brSbFG2bmMe7cs4Hl1RNbP6mPON8UQV4Jz
   ZtC1hJCsz2sBgncu/1aYNjhzn3dCXtAfcdYj7dlNY2GRhud9rcA1bCaTe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5378562"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5378562"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 21:57:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12051271"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 21:57:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 21:57:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 21:57:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 21:57:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk42NUmglFMfrLxKWYVFV0uQmKyU5m+8bKM45IMa4OjHHbILozOystE2nshiCmHW4AhxL4UzIN0s/NyOVwQxLyDrs/HDxQAnxevzNWcABkdH1udYtLhIU0embiIs30gupX/+uBoG1GTvprRO10EWtF150SgIbwhA61rELRRgWTPr/zTHws0zJu5MVc50/mYsdYmkX4DRitc/+jgc86VcOxbFhnNmn/puuBPz9oE8kDGNpAgj8n3N/BXp6ajSCRij6h2cJB+/ilnnMm+sQDvcMCBOAHk9w94bOEkl5vkP2tUjKq4KC7ZvDm4l/hcbEyp7kdpqF0dxD7fuUBS8EcARww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi5Ll8mgZEeikLIF0zEIp5RL48/0nkg56+UqaHkgqfc=;
 b=PYBC/aBWDcXy9R8ZlRTeMd6pF4GKhPl/I0pOv3gLinR5PsFaR1vrNzj0MrwnOAQ9i2h8a+RQThHSvJmCU9xICxPSVl5AwZJIDJ2oylAXAUhSaAhns4oi1M2esKMk9zpKVV9qUUOKswLMZ21L/EMhPVbhU2HLJFMM7gIa7GUwzFgl0GD0s+DMsMLKSiO2uONqzipXXWoCGbP0kvwOXMM+qo1uDd2ZkEgUclQnj6qpzw1ibp8fw/iJO3CeqykmhFBHp/BEyv5LCrh86EPRDGUq9s2cKI6aD8uEX4I6QgmA7e+KOKeWuv7Br9afnlr84JB41de5RQN+mv0DssyTr4y+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 04:57:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 04:57:14 +0000
Date: Thu, 14 Mar 2024 12:57:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-ext4@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [riteshharjani:ext2-iomap-lsfmm-rfcv2] [ext2]  44544ffe4d:
 xfstests.generic.093.fail
Message-ID: <202403141056.44846b46-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0cdc94-a318-4061-0b8b-08dc43e33778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5s4bSU5gMV4sJ0iwL+ziSwiJ5US4geYDRg46DLMFHQXMFnhtOG8gyUc+fOD2YCV3FF80eCg/+MF/ciqd6adTNN3x5TcI2NPWnYGKuu1PSATAEVLgykbQd5LCnGCP3lalvm7J6jRvzQYR76Zi6WOf/zw6CJaKZQid5vN4xOUU9nWNLLbdUtKXPAHNZF+AOGOv4ZrxvcKcjGlEMWVHTk7PP0FLdmRZZKw19YEzrqM3DL7mqdo69YwCGlhUX07zkRgsJ0gttI1Z+ixOUCOdLAPpkId8376sofp4RTL7HbdAqV5tcAw3OeWEt2UZ5OdtzPTa0iqsYsb1ScHV576a6GkisY4l0WcprFhdcv08E0WeZE/Zs8sCzglNvetdZ+8Z3vKEWUDDYyq+LPUmojVG8Lkh+YUtqETMA7bu9Ad1S+t3EK+Abbnu/1f7Btrf0pw2jTfxQWMsNMP0LOvwUL/ros57JFzYhryyZgbMiaNn6g+hjHGdsLzLP0fRav8siD/0tNqpIPGaxTDyUyZXK5K8cOPurI4zyr2N711VT4Sanq0DMzFJwCiCPicKLTkj68ooKHwcJKf4fanM+JHEWCy51ZmmDtNm2AuDn2SBiOFHZjgp7V15SbyZAhl8p7mp0k5rX2CD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iFcaaUqIR+yeiFwJOWsEcLzI1ex++JOT1mbApI29u8/orwXVdrWvyAYwt2V?=
 =?us-ascii?Q?MfxtQxvNEsiOHW6fGLOdD1sznIhInio0CbdLdqeFTlzjWE1cqQeXx86zI4kT?=
 =?us-ascii?Q?KfZK4rCDUrxZczGx2eKy9FgoFIBA9K8ZG3bo1UTafSU9JzvHsdZTBGq1NL1e?=
 =?us-ascii?Q?9A2ttIj+Z0vEyoCJ5F2pbGBmO98+ptqZyKG++vSKgl1XBvcOGDDGPanb+d3V?=
 =?us-ascii?Q?TDQ3hxy30AWxuXMxuhoI9EH4PSFFgGNz8iDNB2iYVjBN3VOsC+RwqcEUGNd6?=
 =?us-ascii?Q?VtsRC4r1oOVXiKpkYZ77plK5xLCRo5uqgdelPZsdRIrhWoNe8vdT/N8zBJEO?=
 =?us-ascii?Q?VyBFrNknU1l6Vs4LsHCF1Z2W7PlQsrg/ekFj29uIZXLPPwBtca0Yx9n3SanC?=
 =?us-ascii?Q?qoaG2clkwzffuVyTgpfKciOTlW+dRFVmGyvjf4SA0R3RcAI7lv7N6SGcTd9+?=
 =?us-ascii?Q?FN669PN8tHy1ImGmUYSlP3/1SziDoB0rJhmpnh6B/owP6snms0YqADm03q2V?=
 =?us-ascii?Q?8b8dRIkklWiFjv3jUpZCqrVAV42+xp7YssQ6mMpt1y6lugguAWdcKkhiFR3j?=
 =?us-ascii?Q?TvHETAuRYYqYlklK5/8G90393o6M9UnRuPLw3gfdjgq/47E1hUe9ZeIYiqkl?=
 =?us-ascii?Q?t53lN3VF/+xOR6w0nSDMPrrsaY33hKQIDXzqxLwb+EjKi91rE1hxIRJUuWN5?=
 =?us-ascii?Q?NkxL+2bYQ9k55cCBEwHeHb2U5AS9HOZdgVTNT/POw/itTcbbeNxJVA9c/Fgh?=
 =?us-ascii?Q?s5xKCUuaBeKLlLinD8/nuJMLCgBPgkEQNgKD3Beo1H+prcKzIh4yF6dlhIxC?=
 =?us-ascii?Q?dMLIN/qdfqYAUlsCFoX03NbSo+K/nEYgZlJ1PBJSCT8iaOINP278AsOTS3bF?=
 =?us-ascii?Q?PDqwcgKwIgOCiSlYug8fdPCrlny+5pODg5+XiQFvneBWDcybrJOvaeBGzkWH?=
 =?us-ascii?Q?wOAQOIK7QCE4MbDXZ4AKVPZaaw07vxH6P/gds8C6WlGZlui+zj2WN4rXqSRd?=
 =?us-ascii?Q?/Vll/pj8/mRU6JBB7yVlYmmx5ZjwPNwlnmZJpcEyZEDJg7ttK1+NvGUWSYPE?=
 =?us-ascii?Q?G9QlvbDg9SgjfRLQ/W7RswaCbL0nOuXufEQA9fuHDOFFa6kSyCT/MD7Gj/aR?=
 =?us-ascii?Q?JGZXMPN6QF2BL9g83ssj6q82MYPlhykBbfYixdM2HamJSJuIF0LoTqK5XNiB?=
 =?us-ascii?Q?WNTiCPKlgd9xKL9CstcRuwlN67/VWKtST56WYgX1gCAXtRrCsavI20o8aFn8?=
 =?us-ascii?Q?HfW2xOskvISkF48kFxxPNCPlDgF/U/3u8yedFG5cm+dlRSsBZHKaxHX/6gMk?=
 =?us-ascii?Q?lTa2X7InZJhLBdTIGEt+VnE5IDWRxLwF8Jw1XSdTurGx0gptY4iMvIkZZmRx?=
 =?us-ascii?Q?THMjiNF2Ts1aQV89hGM44+f+9LHELkEIV65uMdDXaRv4JDxxdrlKY6Namvzh?=
 =?us-ascii?Q?MM5x0lIOp8F6CV8QUTR449eG0IkylakIPKUx3sSELyMh4krMwstoCQx8tB0L?=
 =?us-ascii?Q?KgtKWDqfE9A18qWpYlGwnQxOmAGctQbJva58fEGuI58xN0hrw3JGtEVPxIHn?=
 =?us-ascii?Q?8dpLuxU4wfCNK/+eta7tZEvV9pOk0XL/eKqf7y12yifc8Z/jD0qqdXB3WOdt?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0cdc94-a318-4061-0b8b-08dc43e33778
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 04:57:14.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgr//r1KU4u96/9za7wtmVC5GVkVyalVuopRjIystiaGk+7wuxOsAIsd78Sw06mlRv/wLvU7mzlE5qopAgjpyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.093.fail" on:

commit: 44544ffe4db115b2fbd8d029ff447daea860c2d1 ("ext2: Convert ext2 regular file buffered I/O to use iomap")
https://github.com/riteshharjani/linux ext2-iomap-lsfmm-rfcv2

in testcase: xfstests
version: xfstests-x86_64-386c7b6a-1_20240304
with following parameters:

	disk: 4HDD
	fs: ext2
	test: generic-093



compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202403141056.44846b46-oliver.sang@intel.com

2024-03-09 17:31:14 export TEST_DIR=/fs/sdb1
2024-03-09 17:31:14 export TEST_DEV=/dev/sdb1
2024-03-09 17:31:14 export FSTYP=ext2
2024-03-09 17:31:15 export SCRATCH_MNT=/fs/scratch
2024-03-09 17:31:15 mkdir /fs/scratch -p
2024-03-09 17:31:15 export SCRATCH_DEV=/dev/sdb4
2024-03-09 17:31:15 echo generic/093
2024-03-09 17:31:15 ./check -E tests/exclude/ext2 generic/093
FSTYP         -- ext2
PLATFORM      -- Linux/x86_64 lkp-skl-d01 6.8.0-rc7-00022-g44544ffe4db1 #1 SMP PREEMPT_DYNAMIC Sat Mar  9 20:42:52 CST 2024
MKFS_OPTIONS  -- -F /dev/sdb4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sdb4 /fs/scratch

generic/093       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/093.out.bad)
    --- tests/generic/093.out	2024-03-04 19:06:51.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/093.out.bad	2024-03-09 17:35:42.412272485 +0000
    @@ -3,6 +3,7 @@
     **** Verifying that appending to file clears capabilities ****
     file cap_chown=ep
     data1
    +file cap_chown=ep
     
     **** Verifying that appending to file doesn't clear other xattrs ****
     data1
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/093.out /lkp/benchmarks/xfstests/results//generic/093.out.bad'  to see the entire diff)
Ran: generic/093
Failures: generic/093
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240314/202403141056.44846b46-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


