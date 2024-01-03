Return-Path: <linux-ext4+bounces-648-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E1822820
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 06:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A360D284EFE
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 05:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F02F1798A;
	Wed,  3 Jan 2024 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVXtFT+l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD918027;
	Wed,  3 Jan 2024 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704261231; x=1735797231;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0XWHfMYnFi8L0U9JLVCDy50DbTfMnZL5tiXZlPKdB/k=;
  b=MVXtFT+lb++O8DcQiNFOmHJXDenQPXi61RQi6R9P3Xc8XaK4d4faoKrm
   mQk1+51pXvlfnDs+EEGtB580Q/Xqb9Zu7XK9AKEbhu+6RkiZsKb9v0rCy
   jgjTmmvDD7AhPErxHt2xhbhdUIcOJSEWO8EFDri4kDiTd4ktJDZnFKWSs
   ltE2KhdLp1kS4h74XZLSeil8oeFFrKPh2kBwcITTFG6AO7LSSkey8Fr7c
   LQStZ+RUOKwn6gFmjsVwi7wK5bpOq0waP/H4oJWf3qGIMDdEBjGcil2Dv
   L52+XgD1IZXDCZNhil/AXt/cYejcVk3qdvSj0ErOAl+QxEV5Lr4/QvUFn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15605043"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="15605043"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 21:53:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="814156783"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="814156783"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 21:53:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 21:53:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 21:53:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 21:53:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKaP5FqQR5Z1EQMAVdHZuCBo2MNhU8qnilD6Y4dPi5ITm2l7a6ovUFCwEhgrnB7sAeGvR9yHr3DiTaLB7XzI2TSuRLVbEDRoGNZF8w+DrUecZkn4QEEH1A1L1c6pBrDTthcHVfpGVK6BQ9N5ge4lUoCYjetR9/OosFTBOfEpzYPrwK2eSELP9vNOPgD27VkEy76jPsXUS1pYxZgf9UIo1KAnW3iaN8/82SWtz6k47uR1IUSFBcVc1ockxK8YKyBqkYjdtpvQN1easoOkeyWd7HPJ7yNPuVDm/kZ68d3esG+PTNYW5pEMmX7tfvm2dC7q9K1ljM0ex3k8eJ3u6+VtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw3pcotuqAnzL+TThvn2bIh8nEg60T30NVL+3TuE6xw=;
 b=KQJ8vAbor3yQ8f+43dtYXW1lODSHjF3oY1M/x6TCWGcdIeY2pd+EuRMUdK5dCKi/RgM419Xchaxi114peIHf7yVadTPvwq1aA1hU++XxQ3HrgZn6xQdvW0pp47Zt+q9Oz/vC4BabbcOgP1358TWH7Q9uXPuXIIMKqYyjmhwEjOkwhSz5OMEhuTT4FF9axlzr2eGlaaZsGFutyjhWipbqiRF5Kl/77zziIDwCtWBdUQF2bXSM6QcTYl6+YAhAb0LCdMiYxHmT7dsB04Lw7U2LLr59MANN/jVtgAI1CRMGz6BubG5iZsp6CXtf4Pe9WfvNNcjVoAsTDfjqK3eFN9NrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 05:53:46 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 05:53:45 +0000
Date: Wed, 3 Jan 2024 13:53:32 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Zhang Yi <yi.zhang@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	<linux-ext4@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <yukuai3@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [jbd2] 6a3afb6ac6: fileio.latency_95th_ms 92.5%
 regression
Message-ID: <ZZT2XInayfY0eRu+@xsang-OptiPlex-9020>
References: <202401021525.a27b9444-oliver.sang@intel.com>
 <dcc72d34-89e1-6181-3556-a1a981256cc6@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcc72d34-89e1-6181-3556-a1a981256cc6@huawei.com>
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: e24f8149-ff25-4849-347f-08dc0c2058c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKSUnEYEnXrp6C+zD0priSKXpiVh5ny2CvqoR1SPiVZlyMUcIPdFQkx8mw6dpZnGheH2mgJzOCKZpY1KNsziidl7R8IXdYDGxoBEjZDiB2JNhp3LO5w61MmnaWxAdBLywrpZRyNN19pPN1+0uybXhpCSBn7cTJwXrAsb8Kppc9+jNTfK4KvRELZYiMHM0pXIlNWtJ9lD3AMdsmN9HG64PH/JHBWdhWHH6tjRnoiLm0Ba517fx5T/jMG6MNhMKFziwWndGZr6kPCEzTkeNeEFs13SHIAgNjxh77y4YgVzaokulwq8haGA2qtVXwXyDeoldWOnVnOM0aMxQyVwuxPA4RasCHrf/oWcmuLFghJxtFTierkeH7t0QrYZfOaYnwA6X3Uv/wRHKwkKa1NfWruxsBWZPmImWlMShY0mFdSu+2c5QptS8jYiz24RnPQT0mIwwS1IUDCJTXyctHxCwvCWh6yahjuZouSORZs7Z5Z2U8ELmDVPhseK5hVe2WIZl49Jq+icvA0lJo03VaCVSR3K60+D8RyqF2ZY+52grIGgEMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(107886003)(26005)(38100700002)(82960400001)(33716001)(8676002)(8936002)(316002)(54906003)(5660300002)(2906002)(4326008)(44832011)(6666004)(478600001)(966005)(6512007)(9686003)(6506007)(53546011)(6916009)(66476007)(66556008)(66946007)(6486002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mKtOx/dFc9kR0pDGy8cYpgUUdQ+uY1WDFt94DJ/UyHV10NutVfdq9vVEzJl9?=
 =?us-ascii?Q?f9T84pfsP/S7x5Sr4ZmqOioejqfKSSKa14rTfa75xpXMr1We8g2fqqutot0L?=
 =?us-ascii?Q?JcAlmfcHy3qluyiERjWRcs69w/Jcr+sy6FJdBc5CvuHdALOIyPb3unbOEAUW?=
 =?us-ascii?Q?KE+YkyiF8wfv3oUdszRm6DGEXWe4X8sWoT/5tFzD1oTD9Afej6unL4qXyviF?=
 =?us-ascii?Q?eNQxbT11ZxQOV25z9fXA64/BjAXt0Ker5APt/fQqmRbcSv9FGP6hvNaGmXgp?=
 =?us-ascii?Q?i/jX2bYuHe63p5plIVA/o1tvCSBh/dg4kHceoLe1clzApP/UHgfmGBIlv5HJ?=
 =?us-ascii?Q?f9v8dlweVO6s5k5aPLxDhEvm6xaNRNM2/gtbB1DSVQirokIFc2Ix4bW7OyTt?=
 =?us-ascii?Q?VXSP798UX+tdnYSI5epFYZ9jqv4G5qQascDKoc+s81KR/vpUWAbhrsblNc57?=
 =?us-ascii?Q?yDySnZs5Tb5s17mygVIqOiKeit9UVvT2GrTp6xlLsveKwKtuKr9vIbRtOWb5?=
 =?us-ascii?Q?b/R3vUbeE8zmPm3viJl0sDbTY/VKWS5j5O8S/yLzx2izGiZbJXE3olImTh9Y?=
 =?us-ascii?Q?T75G+s9k+/UgiQEDi6ziCmfeAPSJa6TLITtbOz3FAwiYrPwNugEa0C00VphO?=
 =?us-ascii?Q?ROOeBX/gNZFgAbuvzGgD47LFkvlBcI6pGG8/EiQfNyGUpFVvq8nzTOK9Q3x4?=
 =?us-ascii?Q?pFNGBg671w+4gpOoo0HwaCjc/9RQ1wZVmmL87Y4nipNmo79QqSMDz4vZQ7ol?=
 =?us-ascii?Q?lREY3R24ijp58rFiA70LWves791l25MkyJsd+DaJc06dei6JkGd47WxpHuTx?=
 =?us-ascii?Q?n2w/M3byvns3QZCnqUuxLZtEiw0xGc55teRpkDjhPGN3Y3t5061EGtsGhcxn?=
 =?us-ascii?Q?gRan4o4vXHCQuxtmPp03R7nXVixEdooTFS5U9TI0BCkT6IumBOPZT3vOYH9y?=
 =?us-ascii?Q?QjDqvX4ZKFDmTHGE/aNSrQkGHkPgUVR4fMSXIsqs8oOnRB1UghRHRRXvzq6E?=
 =?us-ascii?Q?trYnnnG3Rf5qx5jTdazsFQkrb4yPt7MJExBtK9iYqRchw7oQFtcu6yebwX4J?=
 =?us-ascii?Q?dNV/e7q78K1obTCGrSukYKjJ+D59eoU0rlFg/8vJCb9geXUnFE5OnJkwwRi1?=
 =?us-ascii?Q?3MaHehCfv11h3ZyC6K94r3pfRFIy+3kHUgX1u80Iq8Uk41DlQy3aFW8BQr8F?=
 =?us-ascii?Q?hPLHvQ2Mo5yuCkNWc2GahzRO3uR4pFe+yU+L/j2a2GrNRjOzXGZ5d13VoNLr?=
 =?us-ascii?Q?LqgCzE1E15vOHTDbORldgT8WXAr5UzIipdyjzRImeBPOZboR/XyoiE4hieVj?=
 =?us-ascii?Q?sSoIknx0GHZErBoR1DJYcxr5vWo1k35vSEgC3aQOV9+kjg78qLny4xS+SNAs?=
 =?us-ascii?Q?MOGXNocM1AbqpLIejDa2XRPROTYs86ZcdgSZH4k8kefJ5OYGGny6aKwKBa0C?=
 =?us-ascii?Q?weZ5isDsdebiyOuJP+3CyxnQ9Y14kfIyz50pB0EYRO4J9gwuHOa90cbj6iNE?=
 =?us-ascii?Q?kiFsHmITltW2Z0aHoGODaaoPjdpl8H2QbJp1lAgb3RkA49LGgvBLLcYhcGM4?=
 =?us-ascii?Q?XqXx1NW0dgIyG4VJXZBL19+f+x/09J88mTjR6H1Hk78MD0caDBxlTatONjY1?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e24f8149-ff25-4849-347f-08dc0c2058c4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 05:53:45.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAVqqRPBiSkD3XDvp0UBHUdDg0B703PRA+/lb1DVg2sDlpn6ZAQj26tZbEINRyhfWDBGvDY1fGu/Fr6sOXmr7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7566
X-OriginatorOrg: intel.com

hi, Yi,

On Wed, Jan 03, 2024 at 11:31:39AM +0800, Zhang Yi wrote:
> On 2024/1/2 15:31, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 92.5% regression of fileio.latency_95th_ms on:
> 
> Hello,
> 
> This seems a little weird, the tests doesn't use blk-cgroup, and the patch
> increase IO priority in WBT, so there shouldn't be any negative influence in
> theory. I've tested sysbench on my machine with Intel Xeon Gold 6240 CPU,
> 400GB memory with HDD disk, and couldn't reproduce this regression.

we double confirmed the latency_95th_ms data is stable in multi runs on our
test platform (Ice Lake).
however, we cannot gurantee the regression could be reproduced on another test
machine.

our team's goal is to report issues (both performance and func) we observed in
our tests to community to help author/community to review then improve code
quality if possible. so just FYI. it's up to author/community to judge the next
step.

regarding this report, if you want to dig further, we will be very happen to
do further tests if you give us some debug patches. Thanks a lot!


> 
> ==
> Without 6a3afb6ac6 ("jbd2: increase the journal IO's priority")
> ==
> 
>  $ sysbench fileio --events=0 --threads=128 --time=600 --file-test-mode=seqwr --file-total-size=68719476736 --file-io-mode=sync --file-num=1024 run
> 
>   sysbench 1.1.0-df89d34 (using bundled LuaJIT 2.1.0-beta3)
> 
>   Running the test with following options:
>   Number of threads: 128
>   Initializing random number generator from current time
> 
> 
>   Extra file open flags: (none)
>   1024 files, 64MiB each
>   64GiB total file size
>   Block size 16KiB
>   Periodic FSYNC enabled, calling fsync() each 100 requests.
>   Calling fsync() at the end of test, Enabled.
>   Using synchronous I/O mode
>   Doing sequential write (creation) test
>   Initializing worker threads...
> 
>   Threads started!
> 
> 
>   Throughput:
>            read:  IOPS=0.00 0.00 MiB/s (0.00 MB/s)
>            write: IOPS=31961.19 499.39 MiB/s (523.65 MB/s)
>            fsync: IOPS=327500.24
> 
>   Latency (ms):
>            min:                                  0.00
>            avg:                                  0.33
>            max:                                920.89
>            95th percentile:                      0.33
>            sum:                            71212319.19
> 
> ==
> With 6a3afb6ac6 ("jbd2: increase the journal IO's priority")
> ==
> 
>  $ sysbench fileio --events=0 --threads=128 --time=600 --file-test-mode=seqwr --file-total-size=68719476736 --file-io-mode=sync --file-num=1024 run
> 
>   sysbench 1.1.0-df89d34 (using bundled LuaJIT 2.1.0-beta3)
> 
>   Running the test with following options:
>   Number of threads: 128
>   Initializing random number generator from current time
> 
> 
>   Extra file open flags: (none)
>   1024 files, 64MiB each
>   64GiB total file size
>   Block size 16KiB
>   Periodic FSYNC enabled, calling fsync() each 100 requests.
>   Calling fsync() at the end of test, Enabled.
>   Using synchronous I/O mode
>   Doing sequential write (creation) test
>   Initializing worker threads...
> 
>   Threads started!
> 
> 
>   Throughput:
>            read:  IOPS=0.00 0.00 MiB/s (0.00 MB/s)
>            write: IOPS=31710.38 495.47 MiB/s (519.54 MB/s)
>            fsync: IOPS=324931.88
> 
>   Latency (ms):
>            min:                                  0.00
>            avg:                                  0.33
>            max:                               1051.69
>            95th percentile:                      0.32
>            sum:                            71309894.62
> 
> Thanks,
> Yi.
> 
> > 
> > 
> > commit: 6a3afb6ac6dfab158ebdd4b87941178f58c8939f ("jbd2: increase the journal IO's priority")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > testcase: fileio
> > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> > parameters:
> > 
> > 	period: 600s
> > 	nr_threads: 100%
> > 	disk: 1HDD
> > 	fs: ext4
> > 	size: 64G
> > 	filenum: 1024f
> > 	rwmode: seqwr
> > 	iomode: sync
> > 	cpufreq_governor: performance
> > 

