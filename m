Return-Path: <linux-ext4+bounces-67-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD347F306A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67812826EA
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Nov 2023 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDD54F9E;
	Tue, 21 Nov 2023 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0ytS8tf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8200D6C;
	Tue, 21 Nov 2023 06:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700575940; x=1732111940;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b49EjUj7hTKPsEuo0FbFaLokYi7dUk7+KT5WStb4Kps=;
  b=I0ytS8tfqhRDCxcs3RV2RIVfs0o8rqIXqzd5/aSXD0YxujdPlViIrob7
   tecxoE0+LpWeGxerdOJa9TMP0em79nneGRwisuDfKExDMauaghs+mOJj0
   9LqYl8icT8CL1Oz+h5yaGxUNoGPGMW2GwJ/vC4sElzAmRTLj68tQSflZ6
   4AcSoAsN6av2O4iy9VTSFmo4Qn3R/YpZkFrFooPgc/mAAiWS5CVhwxjal
   xRM3YYEGjl2CmguLANcrGA3nkxLccDO2xZZ5L0R/egiu30dp3Zcr3idPc
   GPCTiBOuGcoRRIzp+0b6cD6JRQQIykMveMF8z/fOKqwyObCt+mofi1FIG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="394684427"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="394684427"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="795806336"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="795806336"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 06:12:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 06:12:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 06:12:00 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 06:12:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz5aN6PLXEhOyLYf55mDqV5Un6oeCvkBVRnHaLq5Kg6JsB+fz2f05DWhLoOEw8/uFjx0qGEfSOWldRI5OnhyfL7vJbJmT9eozyU0ZlQj2pTeNVSJd/UIZ/N5NSUw5GudmXkeurb+7uNpuLyHgrZMnU1oIZOkIAhHfRQRMkRu5htR6T2GTxTRYNWax5UEsv2Sf+lrGc2Qw8x9ceYG73YnT2+trqkMMapmg59mjj3pImDrGFd92HkZJ9k5jjiu7fK1T9nZBC6Q3EFdx5YQWxBNWUF64mUzhu0IOTLNzJ3+4b7lTiXavnYEZ8L63YBT4PVcovEi2qV80QglGTGCuVStpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+ij549zCxoj3aHZPLL4jP/1xEWxDExPa5usKMrorqY=;
 b=T75Ll+Nbncc+YLsoYf5wx9Qkjtk9Zo3QkjH3vj7BJPV4ZDv3aYb6XvHgRxyRIqz2Why4CUCfQLbUZbBbgP7eZrcECZsGRlClygB3r/qfyGKA/5YqrNiwNdjSWspEiM3dribLw0bk4DUuf27lxN/pHcLkGdtz2KsQzqtPhdCdmoxIBPvsUmjhM4/gX7H6t4pJp+M+AC/qfDg/3EUSZtuUJaxlQbtGsuJ1ATE1NAK9emfobJHju2J7t196unIWMXHiR6J5IfjypOlezVZQg3FIA1+xF5yIcADbv8IeU3e7bpjZwb8Dj6vj9J9VaVZPZju5jbWhb/kzGF7W2fglYiwcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Tue, 21 Nov
 2023 14:11:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 14:11:58 +0000
Date: Tue, 21 Nov 2023 22:11:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [ext2]  bc943f4872: xfstests.generic.269.fail
Message-ID: <202311211653.3a9e8678-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 39575c02-d61d-481d-e113-08dbea9bd1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nePqeZb9kaTgU8O0CDKsOtDYCgvl6HGGYZCJGzWActCEc7a4gSXemdgwRShh7u/a8EyDCVrwZypBOUxPSrMivlXiGOvubcPibbOuP8+LgDX9LbSzV1NjYL3ZqdjEilU3RYu/oM0OxuCKhiEvPtAgC4eh4lAzDmyieQeisYdSyMo5r3fmfIaiCbEI07is5yvgYvK/BKn8LuNlfdoG94mfZ88m141kl2Rd6LsDB8/SyXGUz0qHiNvPaDulp1WlAqt7DNvBqerMD1hcl2rBu26230j9CxJ9P1zVmcys8r+tWM+nEMdK/Dd2vE636zd34q2mawqJklb1kc4gPjcpCpJ5n6fKovvfC9ENZtt/B9y5ptlif9VRndN6IUVE4vc5NmJDqiG3oofjAZnYCHDxKWmv5K+hIJLynVePtlzU1mOuAWlK+bF8ZU+RRLi5/Dabcl5ZeNZ6tqpmFYGtoKpwYIHQfdQL7VBpouaY2X6IlFeiQyC3Gfy2mMpKO/q8uPbrC+vZarIoVo1kfktc2X+kYzTfN85jBb1REuGklmhzVuAFZ87QoO2JphUfG6ectDOzQVTxy7HvGMmkIPNFSwESVljYTFiyGjvvYYso+E6J5gDWZ4ddJbteSas1XfcWA/bOfysHQbGEXhPvi+nYbSr8s4gRsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(966005)(6512007)(6486002)(83380400001)(1076003)(2616005)(107886003)(6666004)(478600001)(6506007)(26005)(66556008)(66946007)(6916009)(316002)(66476007)(82960400001)(86362001)(5660300002)(2906002)(41300700001)(4001150100001)(36756003)(38100700002)(8936002)(4326008)(8676002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5yRXq5uHMz0IJY9/o1Oiq6NsVhu4Wzs0Ek/PCczViJuboM+97PjE2dXxw2t?=
 =?us-ascii?Q?DLmOBoPD4PXmiD5mYpJ+GyybSQju72dtOwCHkgUf5tSFYFxNBwDsxnDe9SCD?=
 =?us-ascii?Q?9denkDV+2Vos86fqs4KdQhoR2Q+l0idQ/bnFEqNFTrr+WDKhbx9KIfUcVVog?=
 =?us-ascii?Q?xCkeK6iDx537QCCf3Jsu0VWRVCv872wkdV4kotPU2lsBTVcbTzHAvaLJn/nC?=
 =?us-ascii?Q?0ExXI/ac9KvhwcEYDP/RwCx2hWva5FRxft8EwVzfDkNCILT20DhXnls+QZwX?=
 =?us-ascii?Q?oCVUH8Y46IeKbgIX+y3orl8oRAEr2P2QcsK1+l5YRhmOi+wpPCMlbfvVcKwi?=
 =?us-ascii?Q?AQSaft0v/7RqXq7O9ler8gwfeY2xH6lISSFeTlhvuUgqi29eYR6d0RBZpHtf?=
 =?us-ascii?Q?TYGnznMt3ANw3GXEAdRndmEBTo4n/23BZY+pmqyHGHU5C59IeHzKwR3IU5kg?=
 =?us-ascii?Q?rPLV8gG7TlU+xHKCfi3Wrr8apM5h8yKmpR3VKAMHc2D5aAxG+P6IuVdnggj+?=
 =?us-ascii?Q?ohQMTLxteouUlLad4j9QBGaJYNZkUPIhQpi7TA7sR22yCZi1a7437t35MHVv?=
 =?us-ascii?Q?dBR14v/T0EjqOJ5Fu794KS9b3jYQfGAuME19AHezCSbhmuUTupknDL6AQTC3?=
 =?us-ascii?Q?ycpHR0gC3iFtQqqlOKg8H53jygLN5oyqpjGI4nJwjlMQMA4o1nsZ/374FNO/?=
 =?us-ascii?Q?3IcpDkpi83SlBTAdCU4UlYS0ItssnmuIrReFOF+3R6Md2QpzS36N6g+G+cBe?=
 =?us-ascii?Q?2PdF7HM7X4vfHu/sUGypqG71eQeZe+X65XFnqd/vHypgvZpkeXTJ3YfaXRg8?=
 =?us-ascii?Q?aVl5SU2RCIJ158KKfkENtKzekWfB3VPQ0594rYPFbGr2qIUqeSRJrytl62gu?=
 =?us-ascii?Q?+WdiB7mOryyD9Z8/JQ68wOKafc8yg4fhIgdg7RzxQOvdxDQRndjMzD/ebzFW?=
 =?us-ascii?Q?U9mI1+/2YqeAzArNJo3yK3UVETLmgBQU56ZMq6ubXwbvuyQp4pmfcV+3k/H3?=
 =?us-ascii?Q?XJVt7oCVoFeMjRfabCEbbrXJSyix3ziLEpIOPJ6hn6Gt7HSdRC02WTnY3Zb3?=
 =?us-ascii?Q?0T7ZTpaAx+b2+g6jbCRpGjU7a/v2ZNxMYqjtZ0QObe/RzSwKGD9E1drz5Hk/?=
 =?us-ascii?Q?JtoQJFisNPgF4myTEjq0a/05aBkv+Wu4TZIWPjm1cUy8IvDFHSXzkTeZ9ern?=
 =?us-ascii?Q?gFoqV6Hxl3veu+W9OsF+tAyh/T28xfSTVO7cLg0eugDdCJXrH61gRdt5bAsd?=
 =?us-ascii?Q?QWA2I2N88Uh4geVXXgUVmq4uUGiv73LX2teVFDxym868viikwvaWjcfGHyQd?=
 =?us-ascii?Q?XTYkv2j4x2W2Kwrd5OvmpxAlu6ElPx448ayPAN7gN7OLQvj1bKu3nHscn1Yo?=
 =?us-ascii?Q?wf30ahUj31gyzjaVARToYGgzRYhaIia/CJO2nNgv2zchyLAQA65aF56lzxHO?=
 =?us-ascii?Q?Y1mOsT7ycuy8gIFCRAQB/l/sa65VLxE2969l0VB/ix7nlIRkkm547zoXhIHM?=
 =?us-ascii?Q?Fu4/Nb7tsi5h3i+41971bYx9hO/IfkEqck/S/KhjmWOyhiREBVMcBN0+dCdJ?=
 =?us-ascii?Q?Ymcfo/T1EOS4Ye4ur/+SwB+1yBdxxqujBoZ5NaScO96maKakR8d/UnMTu2ur?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39575c02-d61d-481d-e113-08dbea9bd1e2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 14:11:57.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRCkJZVkVh2bcy6rh2eyMr2pgpzF5mS15B+nNk2/s5r6rxaoYisYWLCrrV6K0jb0qSqt48P/ma/cyQFKJzqT0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.269.fail" on:

commit: bc943f4872a722c5cc64d1cf41daaaf4ec63158e ("ext2: Don't flush page immediately for DIRSYNC directories")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 791c8ab095f71327899023223940dd52257a4173]
[test failed on linux-next/master eff99d8edbed7918317331ebd1e365d8e955d65e]

in testcase: xfstests
version: xfstests-x86_64-d860afa-1_20231030
with following parameters:

	disk: 4HDD
	fs: ext2
	test: generic-269



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311211653.3a9e8678-oliver.sang@intel.com

2023-11-18 01:55:44 export TEST_DIR=/fs/sda1
2023-11-18 01:55:44 export TEST_DEV=/dev/sda1
2023-11-18 01:55:44 export FSTYP=ext2
2023-11-18 01:55:44 export SCRATCH_MNT=/fs/scratch
2023-11-18 01:55:44 mkdir /fs/scratch -p
2023-11-18 01:55:44 export SCRATCH_DEV=/dev/sda4
2023-11-18 01:55:44 echo generic/269
2023-11-18 01:55:44 ./check -E tests/exclude/ext2 generic/269
FSTYP         -- ext2
PLATFORM      -- Linux/x86_64 lkp-skl-d02 6.1.0-rc2-00005-gbc943f4872a7 #1 SMP PREEMPT_DYNAMIC Sat Nov 18 03:54:42 CST 2023
MKFS_OPTIONS  -- -F /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/269       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/269.out.bad)
    --- tests/generic/269.out	2023-10-30 17:13:51.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/269.out.bad	2023-11-18 02:03:10.606457744 +0000
    @@ -3,3 +3,57 @@
     Run fsstress
     
     Run dd writers in parallel
    +p4a: No such file or directory
    +p4b: No such file or directory
    +p4c: No such file or directory
    +p4d: No such file or directory
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/269.out /lkp/benchmarks/xfstests/results//generic/269.out.bad'  to see the entire diff)
Ran: generic/269
Failures: generic/269
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231121/202311211653.3a9e8678-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


