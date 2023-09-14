Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5198D79FE88
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Sep 2023 10:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbjINIhA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Sep 2023 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjINIg7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Sep 2023 04:36:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650551BFC;
        Thu, 14 Sep 2023 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694680615; x=1726216615;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iZ/X6njf/vpii5c9j1krQ4mhnVgus0e/Rqfyk6LAUFw=;
  b=Tugk/i1uEi3HmfPOeNqTY6W9MK9ULUYn+Ay5pI/9XWJ9i+zjbH7VAFXM
   MpyB9AN6q4TyZ6kBQi9mfKdGrTr6mi/90bsf4r/+wJcF1jyDT2QCEXg+w
   GKOxjKyt50WDdFtzDmADdnjSZyOqnmdxpdJYq4sLC9avtw7ImX4dnH6Vd
   l2Waliw0LflSxgkNnRQGxoY50/rdnG1nhVtsDsLnjl8pBMAMQwYYPQS3A
   ZaZFt7nfX2NOrkuC/uT4YRWM8f+DtXvrlOPchP5qzqd0yIhQvobnaH33s
   DfxFTGSUWAQ1cK/hDwdNNF9i+pKbb5Uj9aAInUTdtyAwJZb53UJjFMaoT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381578894"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="381578894"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814592518"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="814592518"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 01:36:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 01:36:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 01:36:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 01:36:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VewK/vACrl+8MhDUm3nCyqmNHKCzmS2DDDZIUjC7gIb1JLzsbUtcsSesftLBDV0Pa2vC98nc2D2dCA2HeOIfRY+y0dR0lGXZNnpKS7ScxPZTR/Ve6Nb8XvyuFEjnNb7hCRurmswTrSXWgplMV9UqCXog5gfabvsWnJB/1CdklfhcIw2jwDNHxBJ62MGmfD8wOPHh9AJVUDCi/tGISOH5K51W+ALrtJK768UF3u5uRphoN1k6aBecIyE9jqRYv+TQydPXG95RNp0CES3A7N3XGdRh444G8f2lfFGzNSeUTadpcd9naSqdqtfOliVArFoLt0sIR2bfWPxAxF5j/5ZT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mGoR+eBek0Q2d61KCsEg+ByAP56KV3fQiznTtFDgTw=;
 b=n3k0y3VRNkks9yQf6dHmPkalnQ9WxObMxQuS7lTqjHlBBnQjAznTlQYfjtXfRYZKQ4gIMyaYaUaFAoCwoiqc8wpHVsFXSyLD6ZCIDj4pGYS2Ti2JTpphoGwmaRDG7xENtkxoJLLXd4cNEL9xna16fvpHBO8IcRx0pBG4WFsmL0p1CmWFDFh7qyuTNT9CWZ9v3B3IPDJPdFAI2G47jUMzP/twRCwk1OGoQBmOcZkPbKR6ySd51BMdMMSUJ1xlQGVO2WXui3K0j+wcnCdMQxI8Pg/6lKPE1pbMCDADsn8bhRakhZy/VjOhzMyyafauCH6d7N43jIM+Ytb8tG61fRN++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB7271.namprd11.prod.outlook.com (2603:10b6:208:429::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 08:36:51 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 08:36:51 +0000
Date:   Thu, 14 Sep 2023 16:36:42 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Wang Jianjian <wangjianjian0@foxmail.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [ext4]  68228da51c: xfstests.ext4.059.fail
Message-ID: <202309141602.8919c2a0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cde8a3-e231-42c3-e605-08dbb4fdbe17
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29G53QNTHHGrQ8TD+CdKRN1zYCD3a/c6JDrEXhtlRgEkhNURIY8T8BW9f9sWcdMp/u5i3OxsurriJm7XHdUVXOqVbW2A5s3JWAmt8Q2wBBP04JTrsqui7oHCp4+eDFWG+YrNm6iK7Q5ql/cxacUIABFKqSqyI12io32Y64ORl7jXfptWcssn9MVrE5bRFMUMENjpxUfsaJ7PsJOPV1JRb1wN9fKcSGb1vyoVvqkaLwG3/KLYH6gX7NNYV4HK2F+J34OOJEzo+MhUCdur1G/z7uS/5nX3ZL5jFibcu2FfSMZITrnktPcu470RLD/iAz3kQYQJCOlgBQCjmcOzGzjqOi/YoOXcW6r/Nm7K+UW6RIT+xn6EYVx4Exd/I2DICvb/GuungMVr/KZ33k37ibc0Z4YcN1S6cCPmsZJcxjenYmKkaO1iXd1cCC4yfnY3X4zKFrf/MIjwjuacUlnISI19Uo3enrHLV9XgSIFWbgyvU9W00PiPrS7iWXxWj84kPNlwB0jdmqRJ7fWopbKjmSHWZvkB/2UsnxgQjnNeLXS0FOLI6dpz9QpEvIamaB4y90NvKyAbW3xnHhAbX1MlYsDGbvtGrwn1+5A7TgNOiARVsUh+9rePmlm0j6Dd2CZ6isZTYyVOHiF81Z3FKzDf9NQedA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(66476007)(6506007)(66946007)(6486002)(6916009)(316002)(66556008)(6512007)(966005)(478600001)(41300700001)(6666004)(4326008)(8676002)(2616005)(107886003)(8936002)(1076003)(26005)(5660300002)(36756003)(38100700002)(82960400001)(2906002)(86362001)(83380400001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5QyTWynwmiPCiGSshqfAdTRwLEJTX4fJrGv+DJ4amaWWmvaUwDRYTHTm6wV?=
 =?us-ascii?Q?mt1xcjJLuAW8cSH+2GzgEcm2itHEa+QQx7YYmOAy3JFi77LNBHNq64rTXgi8?=
 =?us-ascii?Q?ZKxWsM8brfMYKpZhhUZ8wVXl29FE8SMd6nCb3nh9MBZGuviC+AGjCKZTVim9?=
 =?us-ascii?Q?nVemxTRuYUcGbfBXxCqDfgmHfVh3Q26sM0Tv7uu5ZHt6gSyqAkg60acjw2W3?=
 =?us-ascii?Q?nIl257sNSOmPIMNJTekBH2hDikxRYLrKu06/aKNHe8VS6EuAy7C/xtUoIEPH?=
 =?us-ascii?Q?ijBCvA1V3F1N3tgsmv34S4RNaeWeQ4FcSYsuKoxDC/LnVd5T3A8MRC2cES6j?=
 =?us-ascii?Q?Z1Bc0fODWAsW7tcBcwa5t1K5yzoM3EsObhfIFOk0F/jGcOrDZ92D0AQ8PsLJ?=
 =?us-ascii?Q?I+HJIlYDcgLyJz2JuKACOz1NJbmxcZDiNJJwwGnIUAqJCMQMcqPcjNxKpgwr?=
 =?us-ascii?Q?QC4qaNIDN0yKCvHqkx5pklWHWrRCH+7RRWMdY9UJa47dQqgzumwgwTpJS/F7?=
 =?us-ascii?Q?Jwa6bw/mX2m8AAeJYYWmiYv/SNSuOOhqz7scUPiZTArZEnJXJp36JKuzHbGc?=
 =?us-ascii?Q?ZEMT1JqUPnJ2B4g1QEg6n8K+06UOpTxktAMC9RiZnMt3kLRg8SEDnavuFOV6?=
 =?us-ascii?Q?Outig24CXGvCPpBt/DS8Lw880V0xj6fNozhW7ukPjZKSE/H16h0xlQ75qEf/?=
 =?us-ascii?Q?WGZZ692+eSkYy2kVd2WiSDEgCx+OnXGJWT5HH9nKfnSLr5IM6s8HY3ZluFCa?=
 =?us-ascii?Q?E3tQDcLoBtP1eHU8CaYzqmtAiLLbn35ivloZn4rvVZ4ygWNy3CffDoXW6YVw?=
 =?us-ascii?Q?+IE7JojppfsNDRx31+HLfDV4piuG8YWbYZfwnpcqxyg5OQNr/jZ34pr3bHXb?=
 =?us-ascii?Q?nHE1klqsKJZk0W5eVIIIAR6wc6MnMvMJBRsHD87iFY8uNHyCjwkQOGzzZ0dm?=
 =?us-ascii?Q?1y8ZBmNaZ3A2nFiq8QvC8ZZmdWePc66nwAPUxmXrQxLWrVZOmxp907Mbwf+s?=
 =?us-ascii?Q?G/W1q4QRMWv8FWlu5gwfXputdW176tV8s/lWUT+UdjELPbNVBZ8K5P0fGOYA?=
 =?us-ascii?Q?YbB6ocd+60/RfP3zaj9BuXaemCEDgBlJqX8q4qNRABBI/s+WFlvp3yMlhE4S?=
 =?us-ascii?Q?J6Rcd4mhUizdg6JmsLSoLADl7lmIboRzyvbBhHWKc4HWZSRJUgVQLpWYMCnU?=
 =?us-ascii?Q?L5/cqEHEVhPfatQtuO6EeFn7vqcGhE6l/8QG+Bjhfl0Z0RjL2pn8WN72mBhz?=
 =?us-ascii?Q?aN+uL5NgfUh8dH3jgAziF1+OtJUgwaYePrtud9bus4CKOkQbPIkEOxFsPfPg?=
 =?us-ascii?Q?GQBnEJGN0lEqW9cqfYvMTgK3mINkreNgW+AV05r3+mcJ7HtmZFNTixrUr6Re?=
 =?us-ascii?Q?FMb37trg6LVUmlvW40sT6jKOTsZapH5mSuVOvk/BcUgT/T1Uyj9UyETgiwIE?=
 =?us-ascii?Q?LyzpptcOT0mblJu0n28L/s9fmb7aSAp2lFN4S+XAnOrbnC8luBY0ygFvTxlT?=
 =?us-ascii?Q?EZPbh1ccy2o8sIjNG6iyPxNcIIc0NlyEmypNl2iVNwCYzM7uvo0IM28Bjv82?=
 =?us-ascii?Q?VoId4rRZxyiTQlYCwmoW8XcRx5IKCYU9uftdH+Ro1QvX8vghw8eTUT1kXp/H?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cde8a3-e231-42c3-e605-08dbb4fdbe17
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:36:51.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5G6udQFR+wLIvpgkzjr5XfWEUiiUQHrktI2VU6K/JhwfkqtxauCKEUs5Zq/d1amgrEd8TDRRWGF5iRnzrVp+Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7271
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


hi, Wang Jianjian,

FYI, for this failure, we noticed there is a
"
HINT: You _MAY_ be missing kernel fix:
      b55c3cd102a6 ext4: add reserved GDT blocks check
"

however, we tested newer commit on linus/master and linux-mext, both of
which include b55c3cd102a6, but we still observed similar failure of
xfstests.ext4.059


Hello,

kernel test robot noticed "xfstests.ext4.059.fail" on:

commit: 68228da51c9a436872a4ef4b5a7692e29f7e5bc7 ("ext4: add correct group descriptors and reserved GDT blocks to system zone")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 3669558bdf354cd352be955ef2764cde6a9bf5ec]
[test failed on linux-next/master e143016b56ecb0fcda5bb6026b0a25fe55274f56]

in testcase: xfstests
version: xfstests-x86_64-b15b6cc-1_20230828
with following parameters:

	disk: 4HDD
	fs: ext4
	test: ext4-059



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309141602.8919c2a0-oliver.sang@intel.com

2023-09-13 07:16:51 export TEST_DIR=/fs/sda1
2023-09-13 07:16:51 export TEST_DEV=/dev/sda1
2023-09-13 07:16:51 export FSTYP=ext4
2023-09-13 07:16:51 export SCRATCH_MNT=/fs/scratch
2023-09-13 07:16:51 mkdir /fs/scratch -p
2023-09-13 07:16:51 export SCRATCH_DEV=/dev/sda4
2023-09-13 07:16:51 echo ext4/059
2023-09-13 07:16:51 ./check -E tests/exclude/ext4 ext4/059
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.5.0-rc3-00051-g68228da51c9a #1 SMP PREEMPT_DYNAMIC Wed Sep 13 14:12:40 CST 2023
MKFS_OPTIONS  -- -F /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

ext4/059       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//ext4/059.out.bad)
    --- tests/ext4/059.out	2023-08-28 20:40:03.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//ext4/059.out.bad	2023-09-13 07:19:58.463397800 +0000
    @@ -1,2 +1,5 @@
     QA output created by 059
     Reserved GDT blocks:      100
    +mount: /fs/scratch: mount(2) system call failed: Structure needs cleaning.
    +mount -o acl,user_xattr /dev/sda4 /fs/scratch failed
    +(see /lkp/benchmarks/xfstests/results//ext4/059.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/ext4/059.out /lkp/benchmarks/xfstests/results//ext4/059.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      b55c3cd102a6 ext4: add reserved GDT blocks check

Ran: ext4/059
Failures: ext4/059
Failed 1 of 1 tests



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230914/202309141602.8919c2a0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

