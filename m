Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F4758B41
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jul 2023 04:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGSCQI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Jul 2023 22:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGSCQH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Jul 2023 22:16:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234611BCD;
        Tue, 18 Jul 2023 19:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689732958; x=1721268958;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=gcWP42pWHWNGRVdTb3QnSotsTSxo2HTdjAQCjW7lZ7Y=;
  b=mcg2Nngnsv43GbXtltxyIqF5NDUvY0MtWiM4FvEdMNGaFDd8+5W6Mnl8
   9C7bvSo2Dit+3BKsEGiL15HIcisYmjJQwPIiEPm6a7XTK9IRnChchfVSt
   EOEDR7SsHBJR/uJyOy5szthXVVYoJoUeLNT31HxVEtHK2a19WZ7DTFu4/
   ejPsSBAtBtHpv+e/FMtQ6jL30TmYUKQxPOaSRQzvhZ9tncv0zQ+i4KxeN
   ZPzslCl02suZDdjxtQF5tB/QDJkibZFnpmbh+x5jen1XQBjPoc08VCnlY
   GJqTp0vIPPDdN5pZ6WEJ3/00V1wOC/LBfJvBWLnT7fg7OFY3zwddzlLxh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432536880"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="yaml'?scan'208";a="432536880"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="789260554"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="yaml'?scan'208";a="789260554"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2023 19:15:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 19:15:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 19:15:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 19:15:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER6D+p+NFPDG+cmUp0qDHM3VxB6kOu9Lv+m/u/VR7gBrEx+jX1drzFccKhffdLu7CZsr+af2bNaJ2WJ/McEe4AWp7YCXvj6uVt/QOMa7Pe+/BRohIFZNmSzfH7JTnEemb34dRkrrkDwZ5m43H2uNdrrDdw+vn6gFN9LC28ImHb0KT+lL4JfYzJnbeK7UU5ddrJXRLje7QwD7hEMw7iM2tXaTXYBXeASCze+ic6hYraihQv6ho4GUOb/U1Zsxz750Dmi7Z65gBv068nQQQJNbtSgrMUJMZOvV734PEIQ3gN3SRtxj6dFZdCtoGS5af4+VqHTFz4tovLR/jqnL+ELN1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuPByJdN4+Vd3FZpXHyAl8ueGuZN10YhRdOVVXTpdy0=;
 b=CyFwKr9d+YGq5YZao/3Rq5hLVBV1ZqJ07YYW86vQL1xyM9g6h3GoajONSPW4IIogY/120zNSuYkoGeQkZtcftTypDid1q9DTQaEMx4tQE6SfWNHTXbBRt+U8H3yMdI4PMvpDV8CM9r1FCAy7SMyBdeLrXlHf41c+uERlcj3EBFiqxXE8rDmzTnzNa+OJQW0kIWkQanJgY6m8+vmJIaqSWkkhHsdOudCWrDW1hfaNX15ID9usqcfw4j5iTrRZnvfJCgAl/+KtY9DNGQ6rUXSiDuNITDUMKlsJlQVRTr2oBG9k7/3mfZAQB4Do+zaXW6KC7qcaB1d+dXJpEd2mzMw8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 02:15:45 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e%5]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:15:45 +0000
Date:   Wed, 19 Jul 2023 10:15:32 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        "Jan Kara" <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [ext4]  4f3d1e4533:  fio.write_iops -2.5% regression
Message-ID: <202307190954.683c919b-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="QlvYCRFNV0rTKB28"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::29) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 4381edb9-2603-4270-7c20-08db87fe0ed2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kn39zBs+tiizdlKyaapJ3447Q2BsofYd1er4H2BHxZ5C9oeBSk22tysZAmEzCghRsQ2BfjL/ZNkcSRZJMNvtxMCP/rb1TqgFMPKWHEHfNFlaeTKHiZxf1YWQH4JQEv5QF8OyPgpJ9yaGrlEFq0/ueWxHsj8e0txBL4LiGtcmeXw9xmUho2uzKZN+d/6ljoqBeVVDgKtrAwgmsXvgUSSijofqFESJmblokyXLkEFQs7U30284+6GQr1Fx8ypngdTYgUmX1C+fw3/wpaRMm2L+Qgb2EaMxOzYso3ue1hzGbOTG6D6ZTqYMTlct3Ee80D7Ro1PQF5xzMhAcwPRWQwRA8AeAtxNL5nebCgsuufl6QHmEYQzxI8iwl7EydzD0DHiNOrZxykzi0NHKdJu/BAuxWnB8rDtiKMIqQisE5Ev4lGaKnTn8OhkhGWsnGunVI3QzcRPopavbVumb9yFULIsIU7uu3oysZJBb6Pz+LGN03nZ7pODnrdIbCQ7U4j3Hj+wu8UIf81BjM/d8lsAk+7GsTG/uuVNd1LnJZSSmYVozkP4Pc68DYZ0/+d/dYRUVRIyH1+Wd43JSlDN9aDv5OPmoZISQCt0SGvwREia048PkEPrPkT0kbE2J/fLcXX2h4e+tfSSX5N/E+VOHDsoxO4L5RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(19627235002)(82960400001)(38100700002)(54906003)(44144004)(6512007)(966005)(6486002)(6666004)(478600001)(41300700001)(5660300002)(235185007)(8676002)(8936002)(66556008)(66476007)(6916009)(66946007)(4326008)(316002)(2616005)(66574015)(186003)(21490400003)(83380400001)(6506007)(1076003)(26005)(107886003)(86362001)(36756003)(30864003)(2906002)(2700100001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O71yELd3DC1LC3UzmjTBCjToMiT1jCsSa9g87JL4XdWLlIIb6ZCKvbh+MA?=
 =?iso-8859-1?Q?zwBCUMUzpSYPTiqxZ6bi3MaZ28bG9wFCXpsQqkGSXKAy/o0T9TxFLuz29r?=
 =?iso-8859-1?Q?AthvYMhe3zWrrPqllHVKlFE8yKs1PhV17quGrJip6tgcTDcoY7ZT3iCI1+?=
 =?iso-8859-1?Q?2Novq1Z22bRkBw7XEwYeHHiLR7puauybi7R6H+ruQjeZsUFr3bt98NS32l?=
 =?iso-8859-1?Q?WNqSASISw4heXGeSiusswTtUhGOzYjNPII4W4fhJ96UfCN37B0ywQeJFs2?=
 =?iso-8859-1?Q?jZ182HB1vGIVVR+YnXPTAQQGIMmDw1nuU0YTsriKlDsKGBKagZYriexz+6?=
 =?iso-8859-1?Q?GmPNSbtNe/h2LOEpO44v9ouXh0PlXg34mMMLpFhmK9+cfhk4Hc8ZX3R8+f?=
 =?iso-8859-1?Q?KksU5i59jl0nMhQLoD/EhclTxHkv9zCb2m9dP+LM/aW7PgBvQFhZO6ukCx?=
 =?iso-8859-1?Q?EaKlwKEveDLSbbCMD5nLnguWe/7lziIyTVIVXhxw/zOP2rRuUieOUzAayI?=
 =?iso-8859-1?Q?HLnp5YnzlWwZRWi4Je37E9sGDyYcNaVZqLbW8rEq3T07W7tN0YAcVPG3tW?=
 =?iso-8859-1?Q?YfJQAKJdIzli5/BhT2Iy+hnssrdM7tlwKBuOn5Vn7Wao+XDMX5JHW1kIMm?=
 =?iso-8859-1?Q?iA7EifwPuzb3ic7+4mf6mEV83Pc5PvHfo5JOje4AbaVovuOHLEVL75W+xW?=
 =?iso-8859-1?Q?Xjj8CbhEZ1juDUp4n9QUy5PKLNIm4V8WQsJh+ZowPXAEYxAtqe62Rg5Vyq?=
 =?iso-8859-1?Q?nNQeBRvBsgM/mWjxCDx+wqXHcOQRj1+8eEytAIWXGONUEbKNi10OVsQnth?=
 =?iso-8859-1?Q?ugKzNIsbXAsJyA+VCW9kJk2fGV7QXYaNsjv5wlSqPqHRRER+IATaBhq6n2?=
 =?iso-8859-1?Q?Ud5dgQax7a6Wc4PGQZbbFXg3OpxOe/M3uWioP4o/M0x/R62aDf77p4lS3D?=
 =?iso-8859-1?Q?jpFVgPe3uJCzpsYZ393rMXP1QS9fRiivcQgIxkaEHyBcdqgdXdbkXM+NDE?=
 =?iso-8859-1?Q?E1mmHO7PMJ2UL8hbzUxGwpfNn1xht56yhgizkzPkvGDUVy4OuGMTb5eRIs?=
 =?iso-8859-1?Q?EX0ExWTLyBqTMcOvDqEhdnTm7nVubLPXldDaNPdfh5U6ruyHfhDGO+PY/P?=
 =?iso-8859-1?Q?R3tpq8Vcv7gcVvYCddcrdDYiylLu3y6qNg5K/MM2nmwSWAtsjTKE2qkwC6?=
 =?iso-8859-1?Q?KqaB5F16YJfJs3wIR+/Xhzz6dwg7ZbDJjPPBz95I74qudpCnMM4ZgS+0eX?=
 =?iso-8859-1?Q?YFtG0/XqgyoxknWSvm3zrhqb8r0tZf20cUJYIHHneg2tpH5Ww7wBVgrV7p?=
 =?iso-8859-1?Q?XpFFIEhAAmPln3LBRsPdrejaho1dxtx1yotbQY/M4SwoD18i2jQhy4yKE3?=
 =?iso-8859-1?Q?dpZqVCyV7VrCcv51fPHAN3reOQJxw2WRgiPEpQADkeDzBxEWilGP7irD+B?=
 =?iso-8859-1?Q?QbsvIBJv/cQiFtEeAVCFLLSq366ILVs/HM3+/J0w57ILQIcnTlNCgjsG4k?=
 =?iso-8859-1?Q?kCU+U6TNkpLFoZXL0zop3WWxcLnyMWU90MpQDcl4Jz07N+D/cqjK7JX4F4?=
 =?iso-8859-1?Q?Ch/q52LTRt87kfDm8Tr6316joFmxna1mXU/EPz27E9S2fa5l9d04pqvMHp?=
 =?iso-8859-1?Q?BSwsaKoaRAOLw4d+bu4BvVadf7e1W5jXZPcIMoLAS7Sx2IMpXtcRkOnw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4381edb9-2603-4270-7c20-08db87fe0ed2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:15:45.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e8Y3YwsobcHwKKlWyBc6LuM0f9QSYFADB/8hrc0JiWssxwUaNk8/AeWVP4qjJ/4b7FNet+tMcM9k7ObonBjNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--QlvYCRFNV0rTKB28
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a -2.5% regression of fio.write_iops on:


commit: 4f3d1e4533b0982034f316ace85415d3bc57e3da ("ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fio-basic
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	disk: 1HDD
	fs: ext4
	nr_task: 1
	test_size: 128G
	rw: write
	bs: 4k
	ioengine: sync
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202307190954.683c919b-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
  4k/gcc-12/performance/1HDD/ext4/sync/x86_64-rhel-8.3/1/debian-11.1-x86_64-20220510.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic

commit: 
  3c6296046c ("ext4: Don't skip prefetching BLOCK_UNINIT groups")
  4f3d1e4533 ("ext4: Ensure ext4_mb_prefetch_fini() is called for all prefetched BGs")

3c6296046c85333b 4f3d1e4533b0982034f316ace85 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     96.15            -0.2%      95.95        iostat.cpu.idle
      3.04            +6.5%       3.23 ±  2%  iostat.cpu.iowait
      0.75            +0.5%       0.76        iostat.cpu.system
      0.06 ±  2%      -0.1%       0.06 ±  2%  iostat.cpu.user
      9.14 ± 38%     -24.8%       6.88 ± 50%  perf-c2c.DRAM.local
     27.43 ± 17%     -18.9%      22.25 ± 21%  perf-c2c.DRAM.remote
     71.57 ± 12%      -1.8%      70.25 ± 12%  perf-c2c.HITM.local
     14.14 ± 21%     -12.5%      12.38 ± 25%  perf-c2c.HITM.remote
     85.71 ± 11%      -3.6%      82.62 ± 10%  perf-c2c.HITM.total
     96.15            -0.2       95.95        mpstat.cpu.all.idle%
      3.05            +0.2        3.25 ±  2%  mpstat.cpu.all.iowait%
      0.59            +0.0        0.59        mpstat.cpu.all.irq%
      0.03 ±  5%      +0.0        0.04 ±  4%  mpstat.cpu.all.soft%
      0.13            -0.0        0.13        mpstat.cpu.all.sys%
      0.06 ±  2%      +0.0        0.06 ±  2%  mpstat.cpu.all.usr%
    300.29            +0.0%     300.30        time.elapsed_time
    300.29            +0.0%     300.30        time.elapsed_time.max
 1.517e+08            -2.5%  1.479e+08        time.file_system_outputs
    161.00 ±  7%      -5.9%     151.50 ±  7%  time.involuntary_context_switches
      8582 ± 16%      -1.5%       8452 ± 15%  time.maximum_resident_set_size
      2253            -0.1%       2251        time.minor_page_faults
      4096            +0.0%       4096        time.page_size
     10.57 ±  4%      -5.4%      10.00        time.percent_of_cpu_this_job_got
     26.40            -2.8%      25.65        time.system_time
      6.84 ±  3%      -1.0%       6.77 ±  3%  time.user_time
     67547            -1.0%      66872        time.voluntary_context_switches
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   8172846 ± 76%     -15.5%    6906019 ± 94%  numa-numastat.node0.local_node
   3555855 ± 86%     -19.2%    2874774 ±100%  numa-numastat.node0.numa_foreign
   8213018 ± 75%     -15.5%    6940189 ± 94%  numa-numastat.node0.numa_hit
   2322489 ±115%     +21.8%    2829144 ±100%  numa-numastat.node0.numa_miss
   2340494 ±114%     +22.3%    2863278 ± 98%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
   6046825 ±109%     +15.0%    6952463 ± 94%  numa-numastat.node1.local_node
   2297905 ±116%     +23.2%    2829967 ±100%  numa-numastat.node1.numa_foreign
   6073084 ±108%     +15.0%    6984658 ± 94%  numa-numastat.node1.numa_hit
   3533268 ± 86%     -18.6%    2874774 ±100%  numa-numastat.node1.numa_miss
   3559280 ± 86%     -18.3%    2906887 ± 98%  numa-numastat.node1.other_node
     95.71            -0.7%      95.00        vmstat.cpu.id
      1.00            +0.0%       1.00        vmstat.cpu.sy
      0.00          -100.0%       0.00        vmstat.cpu.us
      2.86 ± 12%      +5.0%       3.00        vmstat.cpu.wa
      0.86 ± 40%     +16.7%       1.00        vmstat.io.bi
    102648            -6.2%      96267 ±  2%  vmstat.io.bo
     10886            -0.1%      10880        vmstat.memory.buff
  62767240            -1.5%   61808853        vmstat.memory.cache
 1.995e+08            +0.5%  2.005e+08        vmstat.memory.free
      1.43 ± 34%     +40.0%       2.00        vmstat.procs.b
      0.00          -100.0%       0.00        vmstat.procs.r
      2072            -0.3%       2067 ±  2%  vmstat.system.cs
     64874            -0.0%      64845        vmstat.system.in
     39.29            -0.1%      39.25        turbostat.Avg_MHz
      1.10            -0.0        1.09        turbostat.Busy%
      3600            +0.0%       3600        turbostat.Bzy_MHz
  19501099            +0.0%   19506120        turbostat.C1
     99.72            +0.0       99.73        turbostat.C1%
     98.90            +0.0%      98.91        turbostat.CPU%c1
     80.71 ±  6%      -2.4%      78.75 ±  6%  turbostat.CoreTmp
      0.17 ±  2%      -0.1%       0.17        turbostat.IPC
  19675125            +0.0%   19676681        turbostat.IRQ
      1455 ± 66%     +87.5%       2728 ±126%  turbostat.POLL
     80.29 ±  5%      -2.5%      78.25 ±  5%  turbostat.PkgTmp
    242.65            -1.1%     239.92        turbostat.PkgWatt
     56.39            -0.3%      56.21        turbostat.RAMWatt
      3093            +0.0%       3093        turbostat.TSC_MHz
      0.01            +0.0        0.01        fio.latency_100ms%
      0.01            +0.0        0.01        fio.latency_100us%
      0.19            +0.0        0.19        fio.latency_10ms%
      2.35 ±  4%      -0.0        2.33 ±  2%  fio.latency_10us%
      0.01            +0.0        0.01        fio.latency_20ms%
      0.10 ±  4%      +0.0        0.11 ±  2%  fio.latency_20us%
      0.01            +0.0        0.01        fio.latency_250ms%
      0.01            +0.0        0.01        fio.latency_250us%
      0.01 ± 63%      +0.0        0.01 ± 37%  fio.latency_2ms%
     91.42            +0.2       91.65        fio.latency_2us%
      0.00 ±158%      -0.0        0.00 ±173%  fio.latency_4ms%
      5.93 ±  6%      -0.2        5.72 ±  4%  fio.latency_4us%
      0.01 ± 86%      -0.0        0.00 ±129%  fio.latency_500ms%
      0.01            +0.0        0.01        fio.latency_50ms%
      0.01            +0.0        0.01        fio.latency_50us%
    300.29            +0.0%     300.30        fio.time.elapsed_time
    300.29            +0.0%     300.30        fio.time.elapsed_time.max
 1.517e+08            -2.5%  1.479e+08        fio.time.file_system_outputs
    161.00 ±  7%      -5.9%     151.50 ±  7%  fio.time.involuntary_context_switches
      8582 ± 16%      -1.5%       8452 ± 15%  fio.time.maximum_resident_set_size
      2253            -0.1%       2251        fio.time.minor_page_faults
      4096            +0.0%       4096        fio.time.page_size
     10.57 ±  4%      -5.4%      10.00        fio.time.percent_of_cpu_this_job_got
     26.40            -2.8%      25.65        fio.time.system_time
      6.84 ±  3%      -1.0%       6.77 ±  3%  fio.time.user_time
     67547            -1.0%      66872        fio.time.voluntary_context_switches
  18968277            -2.5%   18488028        fio.workload
    246.98            -2.5%     240.73        fio.write_bw_MBps
      1923            -0.7%       1910        fio.write_clat_90%_us
      2466            -1.9%       2420 ±  3%  fio.write_clat_95%_us
      4658            -0.7%       4624        fio.write_clat_99%_us
     15609            +2.6%      16021        fio.write_clat_mean_us
    359915            +1.7%     366016 ±  3%  fio.write_clat_stddev
     63226            -2.5%      61625        fio.write_iops
     34259            -0.5%      34081        meminfo.Active
     15516 ±  2%      -1.1%      15346 ±  2%  meminfo.Active(anon)
     18742            -0.0%      18733        meminfo.Active(file)
    183456 ±  9%      +0.8%     184983 ±  5%  meminfo.AnonHugePages
    341569            -0.1%     341250        meminfo.AnonPages
     10886            -0.1%      10879        meminfo.Buffers
  60957435            -1.5%   60027353        meminfo.Cached
 1.319e+08            +0.0%  1.319e+08        meminfo.CommitLimit
    702695            -0.1%     702335        meminfo.Committed_AS
 2.588e+08            +0.2%  2.594e+08        meminfo.DirectMap1G
  10966162 ± 10%      -4.9%   10427904 ± 39%  meminfo.DirectMap2M
    364262 ± 22%      -1.3%     359508 ± 20%  meminfo.DirectMap4k
  43195034            +0.0%   43202254        meminfo.Dirty
      2048            +0.0%       2048        meminfo.Hugepagesize
  58491167            -1.6%   57560868        meminfo.Inactive
    349043            -0.1%     348651        meminfo.Inactive(anon)
  58142123            -1.6%   57212216        meminfo.Inactive(file)
   1735123            -1.5%    1708705        meminfo.KReclaimable
     14107            -0.4%      14052        meminfo.KernelStack
     34533            -0.2%      34454        meminfo.Mapped
 2.576e+08            +0.0%  2.576e+08        meminfo.MemAvailable
 1.996e+08            +0.5%  2.005e+08        meminfo.MemFree
 2.638e+08            +0.0%  2.638e+08        meminfo.MemTotal
  64201413            -1.5%   63238211        meminfo.Memused
      0.00       +8.8e+101%       0.88 ±264%  meminfo.Mlocked
      4328            -0.0%       4326        meminfo.PageTables
     29433            +0.7%      29625        meminfo.Percpu
   1735123            -1.5%    1708705        meminfo.SReclaimable
    346996            -1.3%     342564        meminfo.SUnreclaim
     22771            -0.8%      22598        meminfo.Shmem
   2082120            -1.5%    2051270        meminfo.Slab
   2784647            -0.0%    2784646        meminfo.Unevictable
 1.374e+13            +0.0%  1.374e+13        meminfo.VmallocTotal
    250145            -0.3%     249431        meminfo.VmallocUsed
     13834 ±  3%      +1.9%      14097 ±  3%  meminfo.Writeback
  64202772            -1.5%   63239679        meminfo.max_used_kB
     10408 ± 67%      -7.4%       9639 ± 75%  numa-meminfo.node0.Active
      1197 ± 30%      +3.6%       1240 ± 23%  numa-meminfo.node0.Active(anon)
      9211 ± 73%      -8.8%       8399 ± 84%  numa-meminfo.node0.Active(file)
     57593 ±123%      +1.5%      58464 ± 85%  numa-meminfo.node0.AnonHugePages
    132128 ± 64%      +2.0%     134798 ± 40%  numa-meminfo.node0.AnonPages
    164460 ± 51%     +16.2%     191141 ± 38%  numa-meminfo.node0.AnonPages.max
  21956572 ± 14%      -1.7%   21582624 ± 14%  numa-meminfo.node0.Dirty
  32542746 ± 29%      -8.7%   29698542 ± 34%  numa-meminfo.node0.FilePages
  31041556 ± 31%      -7.5%   28726429 ± 34%  numa-meminfo.node0.Inactive
    138298 ± 61%      +1.1%     139843 ± 39%  numa-meminfo.node0.Inactive(anon)
  30903257 ± 31%      -7.5%   28586585 ± 34%  numa-meminfo.node0.Inactive(file)
   1005600 ± 77%     -16.2%     842773 ± 95%  numa-meminfo.node0.KReclaimable
      7284 ±  6%      +2.2%       7447 ±  7%  numa-meminfo.node0.KernelStack
     19938 ± 75%     -32.6%      13431 ±112%  numa-meminfo.node0.Mapped
  97440244 ± 10%      +3.1%  1.005e+08 ± 11%  numa-meminfo.node0.MemFree
 1.317e+08            +0.0%  1.317e+08        numa-meminfo.node0.MemTotal
  34256594 ± 30%      -8.8%   31228527 ± 35%  numa-meminfo.node0.MemUsed
      0.00       +1.2e+101%       0.12 ±264%  numa-meminfo.node0.Mlocked
      2321 ± 13%      -2.8%       2257 ± 16%  numa-meminfo.node0.PageTables
   1005600 ± 77%     -16.2%     842773 ± 95%  numa-meminfo.node0.SReclaimable
    196324 ± 46%      -9.8%     177055 ± 53%  numa-meminfo.node0.SUnreclaim
      6963 ± 16%      -7.2%       6465 ± 23%  numa-meminfo.node0.Shmem
   1201925 ± 72%     -15.2%    1019829 ± 88%  numa-meminfo.node0.Slab
   1623293 ± 75%     -32.4%    1097072 ±114%  numa-meminfo.node0.Unevictable
      7266 ± 61%      -2.6%       7074 ± 77%  numa-meminfo.node0.Writeback
     23841 ± 29%      +2.4%      24425 ± 30%  numa-meminfo.node1.Active
     14310 ±  4%      -1.5%      14090 ±  4%  numa-meminfo.node1.Active(anon)
      9530 ± 71%      +8.4%      10334 ± 68%  numa-meminfo.node1.Active(file)
    125879 ± 56%      +0.5%     126531 ± 47%  numa-meminfo.node1.AnonHugePages
    209495 ± 40%      -1.4%     206536 ± 27%  numa-meminfo.node1.AnonPages
    280959 ± 34%      -0.5%     279649 ± 19%  numa-meminfo.node1.AnonPages.max
  21239244 ± 15%      +1.8%   21619480 ± 14%  numa-meminfo.node1.Dirty
  28426462 ± 33%      +6.7%   30334457 ± 33%  numa-meminfo.node1.FilePages
  27450562 ± 35%      +5.0%   28829304 ± 34%  numa-meminfo.node1.Inactive
    210811 ± 40%      -0.9%     208902 ± 27%  numa-meminfo.node1.Inactive(anon)
  27239751 ± 35%      +5.1%   28620401 ± 34%  numa-meminfo.node1.Inactive(file)
    729558 ±107%     +18.7%     865777 ± 93%  numa-meminfo.node1.KReclaimable
      6817 ±  7%      -3.1%       6604 ±  9%  numa-meminfo.node1.KernelStack
     14618 ±103%     +44.0%      21046 ± 71%  numa-meminfo.node1.Mapped
 1.021e+08 ± 10%      -2.0%  1.001e+08 ± 11%  numa-meminfo.node1.MemFree
 1.321e+08            +0.0%  1.321e+08        numa-meminfo.node1.MemTotal
  29945714 ± 34%      +6.9%   32004426 ± 35%  numa-meminfo.node1.MemUsed
      0.00       +1.6e+102%       1.62 ±264%  numa-meminfo.node1.Mlocked
      2000 ± 15%      +3.4%       2069 ± 17%  numa-meminfo.node1.PageTables
    729558 ±107%     +18.7%     865777 ± 93%  numa-meminfo.node1.SReclaimable
    150687 ± 61%      +9.8%     165494 ± 57%  numa-meminfo.node1.SUnreclaim
     15808 ±  8%      +2.0%      16127 ± 11%  numa-meminfo.node1.Shmem
    880247 ± 99%     +17.2%    1031272 ± 87%  numa-meminfo.node1.Slab
   1161353 ±105%     +45.3%    1687573 ± 74%  numa-meminfo.node1.Unevictable
      6488 ± 75%     +10.4%       7160 ± 76%  numa-meminfo.node1.Writeback
    165.57 ± 24%      -1.4%     163.25 ± 22%  proc-vmstat.direct_map_level2_splits
      5.43 ± 29%     -10.2%       4.88 ± 80%  proc-vmstat.direct_map_level3_splits
      3878 ±  2%      -1.1%       3836 ±  2%  proc-vmstat.nr_active_anon
      4685            -0.0%       4683        proc-vmstat.nr_active_file
     85391            -0.1%      85312        proc-vmstat.nr_anon_pages
     89.00 ± 10%      +0.8%      89.75 ±  5%  proc-vmstat.nr_anon_transparent_hugepages
  18969312            -2.5%   18489055        proc-vmstat.nr_dirtied
  10798854            +0.0%   10800591        proc-vmstat.nr_dirty
   6405343            +0.0%    6406173        proc-vmstat.nr_dirty_background_threshold
  12826349            +0.0%   12828011        proc-vmstat.nr_dirty_threshold
  15242782            -1.5%   15009879        proc-vmstat.nr_file_pages
  49891205            +0.5%   50132381        proc-vmstat.nr_free_pages
     87261            -0.1%      87162        proc-vmstat.nr_inactive_anon
  14536233            -1.6%   14303375        proc-vmstat.nr_inactive_file
      0.00       +1.2e+101%       0.12 ±264%  proc-vmstat.nr_isolated_anon
     14105            -0.4%      14051        proc-vmstat.nr_kernel_stack
      8633            -0.2%       8613        proc-vmstat.nr_mapped
      0.00       +1.2e+101%       0.12 ±264%  proc-vmstat.nr_mlock
      1081            -0.0%       1081        proc-vmstat.nr_page_table_pages
      5693            -0.8%       5649        proc-vmstat.nr_shmem
    433799            -1.5%     427185        proc-vmstat.nr_slab_reclaimable
     86751            -1.3%      85642        proc-vmstat.nr_slab_unreclaimable
    696161            -0.0%     696161        proc-vmstat.nr_unevictable
      3460 ±  4%      +2.1%       3531 ±  3%  proc-vmstat.nr_writeback
   7758636            -6.2%    7277165 ±  2%  proc-vmstat.nr_written
      3878 ±  2%      -1.1%       3836 ±  2%  proc-vmstat.nr_zone_active_anon
      4685            -0.0%       4683        proc-vmstat.nr_zone_active_file
     87261            -0.1%      87162        proc-vmstat.nr_zone_inactive_anon
  14536233            -1.6%   14303375        proc-vmstat.nr_zone_inactive_file
    696161            -0.0%     696161        proc-vmstat.nr_zone_unevictable
  10802315            +0.0%   10804123        proc-vmstat.nr_zone_write_pending
   5853761 ±  8%      -2.5%    5704742 ±  4%  proc-vmstat.numa_foreign
      1000 ±242%    +280.2%       3802 ±102%  proc-vmstat.numa_hint_faults
      6.29 ±148%   +9970.5%     633.00 ±244%  proc-vmstat.numa_hint_faults_local
  14288500 ±  3%      -2.5%   13927181        proc-vmstat.numa_hit
      6.43 ±173%    +269.4%      23.75 ±112%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
  14222068 ±  3%      -2.5%   13860816        proc-vmstat.numa_local
   5855757 ±  7%      -2.6%    5703919 ±  4%  proc-vmstat.numa_miss
   5899774 ±  8%      -2.2%    5770166 ±  3%  proc-vmstat.numa_other
      1358 ±244%    +373.0%       6426 ±104%  proc-vmstat.numa_pages_migrated
      5538 ±161%    +261.5%      20020 ± 82%  proc-vmstat.numa_pte_updates
      7927 ±  4%      -0.3%       7903 ±  4%  proc-vmstat.pgactivate
  20287900            -2.4%   19799295        proc-vmstat.pgalloc_normal
    692551            +0.5%     695757        proc-vmstat.pgfault
    703292            +0.6%     707503        proc-vmstat.pgfree
      1358 ±244%    +373.0%       6426 ±104%  proc-vmstat.pgmigrate_success
    281.14 ± 40%     +16.7%     328.00        proc-vmstat.pgpgin
  31054498            -6.2%   29131770 ±  2%  proc-vmstat.pgpgout
     29285            +1.0%      29579        proc-vmstat.pgreuse
    114.86 ±  5%      -1.1%     113.62 ±  4%  proc-vmstat.thp_collapse_alloc
      0.29 ±244%     +75.0%       0.50 ±141%  proc-vmstat.thp_deferred_split_page
      8.43 ±  8%      +2.3%       8.62 ±  9%  proc-vmstat.thp_fault_alloc
      0.71 ±244%    +792.5%       6.38 ±119%  proc-vmstat.thp_migration_success
      0.29 ±244%     +75.0%       0.50 ±141%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
     33.29 ±134%     +27.3%      42.38 ±114%  proc-vmstat.unevictable_pgs_culled
      0.00       +7.6e+103%      75.88 ±264%  proc-vmstat.unevictable_pgs_mlocked
      0.00         +5e+101%       0.50 ±264%  proc-vmstat.unevictable_pgs_munlocked
      0.00         +5e+101%       0.50 ±264%  proc-vmstat.unevictable_pgs_rescued
   2296763            -0.0%    2296608        proc-vmstat.unevictable_pgs_scanned
    299.00 ± 30%      +3.6%     309.75 ± 23%  numa-vmstat.node0.nr_active_anon
      2302 ± 73%      -8.8%       2099 ± 84%  numa-vmstat.node0.nr_active_file
     33031 ± 64%      +2.0%      33699 ± 40%  numa-vmstat.node0.nr_anon_pages
     27.86 ±124%      +1.0%      28.12 ± 87%  numa-vmstat.node0.nr_anon_transparent_hugepages
   9907211 ± 33%      -7.0%    9211522 ± 38%  numa-vmstat.node0.nr_dirtied
   5489159 ± 14%      -1.7%    5395664 ± 14%  numa-vmstat.node0.nr_dirty
   8136061 ± 29%      -8.7%    7424899 ± 34%  numa-vmstat.node0.nr_file_pages
  24359684 ± 10%      +3.1%   25116813 ± 11%  numa-vmstat.node0.nr_free_pages
     34574 ± 61%      +1.1%      34960 ± 39%  numa-vmstat.node0.nr_inactive_anon
   7726189 ± 31%      -7.5%    7146910 ± 34%  numa-vmstat.node0.nr_inactive_file
      0.14 ±244%    -100.0%       0.00        numa-vmstat.node0.nr_isolated_anon
      7284 ±  6%      +2.3%       7454 ±  7%  numa-vmstat.node0.nr_kernel_stack
      4985 ± 75%     -32.6%       3357 ±112%  numa-vmstat.node0.nr_mapped
      0.00          -100.0%       0.00        numa-vmstat.node0.nr_mlock
    580.00 ± 13%      -2.8%     563.88 ± 16%  numa-vmstat.node0.nr_page_table_pages
      1740 ± 16%      -7.2%       1616 ± 23%  numa-vmstat.node0.nr_shmem
    251410 ± 77%     -16.2%     210700 ± 95%  numa-vmstat.node0.nr_slab_reclaimable
     49082 ± 46%      -9.8%      44264 ± 53%  numa-vmstat.node0.nr_slab_unreclaimable
    405822 ± 75%     -32.4%     274267 ±114%  numa-vmstat.node0.nr_unevictable
      1843 ± 59%      -3.6%       1776 ± 79%  numa-vmstat.node0.nr_writeback
   4222687 ± 61%     -14.6%    3607998 ± 78%  numa-vmstat.node0.nr_written
    299.00 ± 30%      +3.6%     309.75 ± 23%  numa-vmstat.node0.nr_zone_active_anon
      2302 ± 73%      -8.8%       2099 ± 84%  numa-vmstat.node0.nr_zone_active_file
     34574 ± 61%      +1.1%      34960 ± 39%  numa-vmstat.node0.nr_zone_inactive_anon
   7726188 ± 31%      -7.5%    7146910 ± 34%  numa-vmstat.node0.nr_zone_inactive_file
    405822 ± 75%     -32.4%     274267 ±114%  numa-vmstat.node0.nr_zone_unevictable
   5491002 ± 14%      -1.7%    5397440 ± 14%  numa-vmstat.node0.nr_zone_write_pending
   3555855 ± 86%     -19.2%    2874774 ±100%  numa-vmstat.node0.numa_foreign
   8213113 ± 75%     -15.5%    6940388 ± 94%  numa-vmstat.node0.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
   8172940 ± 76%     -15.5%    6906217 ± 94%  numa-vmstat.node0.numa_local
   2322489 ±115%     +21.8%    2829144 ±100%  numa-vmstat.node0.numa_miss
   2340494 ±114%     +22.3%    2863278 ± 98%  numa-vmstat.node0.numa_other
      3577 ±  4%      -1.5%       3522 ±  4%  numa-vmstat.node1.nr_active_anon
      2382 ± 71%      +8.4%       2583 ± 68%  numa-vmstat.node1.nr_active_file
     52374 ± 40%      -1.4%      51633 ± 27%  numa-vmstat.node1.nr_anon_pages
     61.00 ± 56%      +0.4%      61.25 ± 48%  numa-vmstat.node1.nr_anon_transparent_hugepages
   9062101 ± 36%      +2.4%    9277522 ± 38%  numa-vmstat.node1.nr_dirtied
   5309855 ± 15%      +1.8%    5404888 ± 14%  numa-vmstat.node1.nr_dirty
   7107018 ± 33%      +6.7%    7583852 ± 33%  numa-vmstat.node1.nr_file_pages
  25531215 ± 10%      -2.0%   25016703 ± 11%  numa-vmstat.node1.nr_free_pages
     52704 ± 40%      -0.9%      52226 ± 27%  numa-vmstat.node1.nr_inactive_anon
   6810339 ± 35%      +5.1%    7155338 ± 34%  numa-vmstat.node1.nr_inactive_file
      6818 ±  7%      -3.2%       6602 ±  9%  numa-vmstat.node1.nr_kernel_stack
      3654 ±103%     +44.0%       5262 ± 71%  numa-vmstat.node1.nr_mapped
      0.00       +3.8e+101%       0.38 ±264%  numa-vmstat.node1.nr_mlock
    499.57 ± 15%      +3.4%     516.62 ± 17%  numa-vmstat.node1.nr_page_table_pages
      3952 ±  8%      +2.0%       4032 ± 11%  numa-vmstat.node1.nr_shmem
    182398 ±107%     +18.7%     216450 ± 93%  numa-vmstat.node1.nr_slab_reclaimable
     37673 ± 61%      +9.8%      41373 ± 57%  numa-vmstat.node1.nr_slab_unreclaimable
    290337 ±105%     +45.3%     421892 ± 74%  numa-vmstat.node1.nr_unevictable
      1627 ± 74%     +10.1%       1791 ± 78%  numa-vmstat.node1.nr_writeback
   3536416 ± 73%      +3.7%    3666622 ± 76%  numa-vmstat.node1.nr_written
      3577 ±  4%      -1.5%       3522 ±  4%  numa-vmstat.node1.nr_zone_active_anon
      2382 ± 71%      +8.4%       2583 ± 68%  numa-vmstat.node1.nr_zone_active_file
     52704 ± 40%      -0.9%      52226 ± 27%  numa-vmstat.node1.nr_zone_inactive_anon
   6810339 ± 35%      +5.1%    7155337 ± 34%  numa-vmstat.node1.nr_zone_inactive_file
    290337 ±105%     +45.3%     421892 ± 74%  numa-vmstat.node1.nr_zone_unevictable
   5311484 ± 15%      +1.8%    5406680 ± 14%  numa-vmstat.node1.nr_zone_write_pending
   2297905 ±116%     +23.2%    2829967 ±100%  numa-vmstat.node1.numa_foreign
   6073045 ±108%     +15.0%    6984946 ± 94%  numa-vmstat.node1.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
   6046786 ±109%     +15.0%    6952751 ± 94%  numa-vmstat.node1.numa_local
   3533268 ± 86%     -18.6%    2874774 ±100%  numa-vmstat.node1.numa_miss
   3559280 ± 86%     -18.3%    2906887 ± 98%  numa-vmstat.node1.numa_other
      6.32            -0.6%       6.29        perf-stat.i.MPKI
 2.319e+08            -1.7%   2.28e+08        perf-stat.i.branch-instructions
      0.71            +0.0        0.73        perf-stat.i.branch-miss-rate%
   1688722            -0.3%    1684085        perf-stat.i.branch-misses
     20.82 ±  2%      -1.0       19.85        perf-stat.i.cache-miss-rate%
   1681590            -4.2%    1610595        perf-stat.i.cache-misses
   7493340            -1.7%    7369155        perf-stat.i.cache-references
      2026            -0.2%       2022 ±  2%  perf-stat.i.context-switches
      2.00 ±  2%      +1.3%       2.03 ±  2%  perf-stat.i.cpi
     64001            +0.0%      64002        perf-stat.i.cpu-clock
 1.831e+09 ±  2%      -1.0%  1.813e+09 ±  2%  perf-stat.i.cpu-cycles
     69.37            +0.2%      69.50        perf-stat.i.cpu-migrations
      1587 ±  2%      +7.7%       1709 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.03 ± 15%      +0.0        0.03 ±  5%  perf-stat.i.dTLB-load-miss-rate%
     59316 ± 14%      -1.9%      58180 ±  4%  perf-stat.i.dTLB-load-misses
 3.092e+08            -1.5%  3.045e+08        perf-stat.i.dTLB-loads
      0.01 ±  2%      +0.0        0.01 ±  4%  perf-stat.i.dTLB-store-miss-rate%
     13664 ±  2%      -0.8%      13548 ±  3%  perf-stat.i.dTLB-store-misses
 1.586e+08            -1.6%  1.561e+08        perf-stat.i.dTLB-stores
 1.131e+09            -1.7%  1.112e+09        perf-stat.i.instructions
      0.53 ±  2%      -1.2%       0.53        perf-stat.i.ipc
      0.01 ±130%    +155.9%       0.02 ± 58%  perf-stat.i.major-faults
      0.03 ±  2%      -1.1%       0.03 ±  2%  perf-stat.i.metric.GHz
    133.49            -1.8%     131.15        perf-stat.i.metric.K/sec
     10.93            -1.6%      10.76        perf-stat.i.metric.M/sec
      1913            +0.5%       1923        perf-stat.i.minor-faults
     70.37 ±  5%      -3.1       67.30 ±  7%  perf-stat.i.node-load-miss-rate%
     74229 ± 10%     -15.1%      62993 ± 13%  perf-stat.i.node-load-misses
     36203 ±  9%      -3.6%      34893 ±  9%  perf-stat.i.node-loads
     22.33 ± 14%      -3.0       19.35 ±  9%  perf-stat.i.node-store-miss-rate%
    304517 ±  8%      -4.0%     292217 ±  5%  perf-stat.i.node-store-misses
    705246 ±  3%      -2.4%     687973        perf-stat.i.node-stores
      1913            +0.5%       1923        perf-stat.i.page-faults
     64001            +0.0%      64002        perf-stat.i.task-clock
      6.63            -0.0%       6.63        perf-stat.overall.MPKI
      0.73            +0.0        0.74        perf-stat.overall.branch-miss-rate%
     22.44            -0.6       21.86        perf-stat.overall.cache-miss-rate%
      1.62 ±  2%      +0.6%       1.63        perf-stat.overall.cpi
      1089            +3.4%       1125 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.02 ± 14%      -0.0        0.02 ±  5%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  2%      +0.0        0.01 ±  3%  perf-stat.overall.dTLB-store-miss-rate%
      0.62 ±  2%      -0.7%       0.61        perf-stat.overall.ipc
     67.11 ±  4%      -3.0       64.09 ±  7%  perf-stat.overall.node-load-miss-rate%
     30.14 ±  8%      -0.3       29.79 ±  3%  perf-stat.overall.node-store-miss-rate%
     17876            +1.0%      18051        perf-stat.overall.path-length
 2.311e+08            -1.7%  2.272e+08        perf-stat.ps.branch-instructions
   1682635            -0.3%    1678039        perf-stat.ps.branch-misses
   1675559            -4.2%    1604789        perf-stat.ps.cache-misses
   7466545            -1.7%    7342786        perf-stat.ps.cache-references
      2019            -0.2%       2015 ±  2%  perf-stat.ps.context-switches
     63788            +0.0%      63789        perf-stat.ps.cpu-clock
 1.825e+09 ±  2%      -1.0%  1.806e+09 ±  2%  perf-stat.ps.cpu-cycles
     69.20            +0.2%      69.32        perf-stat.ps.cpu-migrations
     59121 ± 14%      -1.9%      57988 ±  4%  perf-stat.ps.dTLB-load-misses
 3.081e+08            -1.5%  3.034e+08        perf-stat.ps.dTLB-loads
     13616 ±  2%      -0.8%      13501 ±  3%  perf-stat.ps.dTLB-store-misses
  1.58e+08            -1.6%  1.555e+08        perf-stat.ps.dTLB-stores
 1.127e+09            -1.7%  1.108e+09        perf-stat.ps.instructions
      0.01 ±130%    +155.9%       0.02 ± 58%  perf-stat.ps.major-faults
      1906            +0.5%       1916        perf-stat.ps.minor-faults
     73981 ± 10%     -15.1%      62784 ± 13%  perf-stat.ps.node-load-misses
     36087 ±  9%      -3.6%      34783 ±  9%  perf-stat.ps.node-loads
    303335 ±  8%      -4.0%     291086 ±  5%  perf-stat.ps.node-store-misses
    702698 ±  3%      -2.5%     685445        perf-stat.ps.node-stores
      1906            +0.5%       1916        perf-stat.ps.page-faults
     63788            +0.0%      63789        perf-stat.ps.task-clock
 3.391e+11            -1.6%  3.337e+11        perf-stat.total.instructions
     10.54 ±244%     +36.1%      14.35 ±130%  sched_debug.cfs_rq:/.MIN_vruntime.avg
    674.87 ±244%     +36.1%     918.59 ±130%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
     83.70 ±244%     +36.1%     113.92 ±130%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.09 ±  5%      +0.9%       0.09 ±  8%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.00            +0.0%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
      0.27 ±  2%      -1.0%       0.26 ±  4%  sched_debug.cfs_rq:/.h_nr_running.stddev
     43132 ±  8%      -5.5%      40747 ± 12%  sched_debug.cfs_rq:/.load.avg
   1009035 ±  4%      +0.1%    1009841 ±  4%  sched_debug.cfs_rq:/.load.max
    178967 ±  3%      -2.6%     174319 ±  5%  sched_debug.cfs_rq:/.load.stddev
     66.29 ± 10%      -8.0%      60.95 ± 10%  sched_debug.cfs_rq:/.load_avg.avg
      1106 ±  7%      -5.8%       1042 ±  7%  sched_debug.cfs_rq:/.load_avg.max
    224.95 ±  4%      -5.2%     213.21 ±  7%  sched_debug.cfs_rq:/.load_avg.stddev
     10.54 ±244%     +36.1%      14.35 ±130%  sched_debug.cfs_rq:/.max_vruntime.avg
    674.87 ±244%     +36.1%     918.59 ±130%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
     83.70 ±244%     +36.1%     113.92 ±130%  sched_debug.cfs_rq:/.max_vruntime.stddev
     13566 ± 16%     +11.3%      15094 ± 21%  sched_debug.cfs_rq:/.min_vruntime.avg
     28371 ± 14%      -0.4%      28244 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
      6773 ± 17%      +7.8%       7301 ± 43%  sched_debug.cfs_rq:/.min_vruntime.min
      3925 ± 14%      +4.1%       4085 ± 13%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.09 ±  5%      +0.9%       0.09 ±  8%  sched_debug.cfs_rq:/.nr_running.avg
      1.00            +0.0%       1.00        sched_debug.cfs_rq:/.nr_running.max
      0.27 ±  2%      -1.0%       0.26 ±  4%  sched_debug.cfs_rq:/.nr_running.stddev
     30.01 ± 26%     -13.0%      26.10 ± 19%  sched_debug.cfs_rq:/.removed.load_avg.avg
    512.00 ± 39%      +0.0%     512.00 ± 40%  sched_debug.cfs_rq:/.removed.load_avg.max
    108.94 ± 31%      -4.4%     104.14 ± 29%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     12.70 ± 28%     -15.4%      10.74 ± 25%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    259.81 ± 39%      -0.7%     258.08 ± 40%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     49.80 ± 34%      -5.6%      47.02 ± 35%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     12.70 ± 28%     -15.4%      10.74 ± 25%  sched_debug.cfs_rq:/.removed.util_avg.avg
    259.81 ± 39%      -0.7%     258.08 ± 40%  sched_debug.cfs_rq:/.removed.util_avg.max
     49.80 ± 34%      -5.6%      47.02 ± 35%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    104.40 ±  3%      -3.0%     101.32 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    699.88 ±  7%      +0.5%     703.42 ± 11%  sched_debug.cfs_rq:/.runnable_avg.max
    144.26 ±  8%      -2.0%     141.39 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1296 ±196%     -93.0%      90.97 ±5015%  sched_debug.cfs_rq:/.spread0.avg
     16100 ± 33%     -17.8%      13242 ± 39%  sched_debug.cfs_rq:/.spread0.max
     -5496           +40.1%      -7700        sched_debug.cfs_rq:/.spread0.min
      3925 ± 14%      +4.1%       4084 ± 13%  sched_debug.cfs_rq:/.spread0.stddev
    104.31 ±  3%      -2.9%     101.26 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
    699.86 ±  7%      +0.5%     703.31 ± 11%  sched_debug.cfs_rq:/.util_avg.max
    144.20 ±  8%      -2.0%     141.33 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
     10.35 ± 16%      -3.2%      10.02 ± 13%  sched_debug.cfs_rq:/.util_est_enqueued.avg
    237.48 ± 10%      -2.0%     232.62 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.max
     40.11 ± 10%      -3.4%      38.75 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    938250 ±  3%      -0.5%     933185 ±  3%  sched_debug.cpu.avg_idle.avg
   1098159 ± 14%      +1.4%    1114007 ± 14%  sched_debug.cpu.avg_idle.max
    446053 ±  9%      +6.1%     473179 ± 18%  sched_debug.cpu.avg_idle.min
    129839 ± 25%      -0.5%     129157 ± 19%  sched_debug.cpu.avg_idle.stddev
    213403 ±  2%     +10.1%     234962 ± 16%  sched_debug.cpu.clock.avg
    213405 ±  2%     +10.1%     234963 ± 16%  sched_debug.cpu.clock.max
    213401 ±  2%     +10.1%     234960 ± 16%  sched_debug.cpu.clock.min
      1.00 ±  3%      +3.3%       1.04 ±  2%  sched_debug.cpu.clock.stddev
    211784 ±  2%      +9.7%     232324 ± 16%  sched_debug.cpu.clock_task.avg
    212396 ±  2%     +10.0%     233709 ± 16%  sched_debug.cpu.clock_task.max
    196698            +0.6%     197824        sched_debug.cpu.clock_task.min
      1944 ± 29%    +125.9%       4393 ±108%  sched_debug.cpu.clock_task.stddev
    294.42 ± 10%      +4.7%     308.20 ±  3%  sched_debug.cpu.curr->pid.avg
      7518            -0.1%       7514        sched_debug.cpu.curr->pid.max
      1191 ±  3%      +1.0%       1203        sched_debug.cpu.curr->pid.stddev
    516499 ±  6%      -0.1%     516017 ±  6%  sched_debug.cpu.max_idle_balance_cost.avg
    584334 ± 16%      +1.7%     594376 ± 14%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
     17972 ±143%     +18.7%      21340 ±129%  sched_debug.cpu.max_idle_balance_cost.stddev
      4294            +0.0%       4294        sched_debug.cpu.next_balance.avg
      4294            +0.0%       4294        sched_debug.cpu.next_balance.max
      4294            +0.0%       4294        sched_debug.cpu.next_balance.min
      0.00 ± 24%     +17.1%       0.00 ± 26%  sched_debug.cpu.next_balance.stddev
      0.07 ± 12%      +6.0%       0.07 ±  5%  sched_debug.cpu.nr_running.avg
      1.00            +0.0%       1.00        sched_debug.cpu.nr_running.max
      0.21 ±  8%      +3.2%       0.22        sched_debug.cpu.nr_running.stddev
     11488            +0.3%      11525        sched_debug.cpu.nr_switches.avg
    210532 ±  2%      -0.1%     210227        sched_debug.cpu.nr_switches.max
      1061 ±  8%      +8.2%       1148 ± 15%  sched_debug.cpu.nr_switches.min
     27936 ±  2%      -2.0%      27391        sched_debug.cpu.nr_switches.stddev
 2.008e+09 ±  7%      +8.0%   2.17e+09 ±  6%  sched_debug.cpu.nr_uninterruptible.avg
 4.295e+09            +0.0%  4.295e+09        sched_debug.cpu.nr_uninterruptible.max
 2.137e+09            +0.3%  2.143e+09        sched_debug.cpu.nr_uninterruptible.stddev
    213402 ±  2%     +10.1%     234960 ± 16%  sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
    212163 ±  2%     +10.2%     233723 ± 16%  sched_debug.ktime
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
      0.00 ± 60%      -2.3%       0.00 ± 43%  sched_debug.rt_rq:.rt_time.avg
      0.02 ± 60%      -2.3%       0.02 ± 43%  sched_debug.rt_rq:.rt_time.max
      0.00 ± 60%      -2.3%       0.00 ± 43%  sched_debug.rt_rq:.rt_time.stddev
    206340            +0.6%     207483        sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
  58611259            +0.0%   58611259        sched_debug.sysctl_sched.sysctl_sched_features
      0.75            +0.0%       0.75        sched_debug.sysctl_sched.sysctl_sched_idle_min_granularity
     24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
      0.00 ±118%     -67.2%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      0.00        +2.5e+98%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__put_user_4
      0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.vma_prepare.__split_vma.mprotect_fixup
      0.00 ±244%    +162.5%       0.00 ±173%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00        +7.5e+98%       0.00 ±173%  perf-sched.sch_delay.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.00 ±158%     -67.2%       0.00 ±264%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 17%     -14.9%       0.01 ± 16%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00           +12.5%       0.00 ± 29%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 12%      +0.6%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00 ±  8%      -0.4%       0.00 ±  8%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±244%    +308.3%       0.00 ± 79%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00 ± 51%     +21.4%       0.01 ± 15%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ± 13%      -1.1%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.00 ± 19%      +6.9%       0.00 ± 15%  perf-sched.sch_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.01 ±  3%      -1.2%       0.01 ±  2%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork
      0.00        +1.6e+99%       0.00 ±173%  perf-sched.sch_delay.avg.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
      0.00 ± 20%      -0.8%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork
      0.00 ± 26%      +2.1%       0.00 ± 24%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00           +68.8%       0.00 ±107%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +6.3%       0.00 ± 15%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.00 ± 19%      -7.0%       0.00 ± 15%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.00 ± 13%      +6.5%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ± 41%     -26.5%       0.00 ± 78%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_map_blocks
      0.00 ± 95%     +75.0%       0.00 ± 43%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 69%     +16.7%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00        +6.2e+98%       0.00 ±177%  perf-sched.sch_delay.avg.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00 ± 75%     +15.1%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.00 ± 19%      +9.4%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.00 ± 17%      -8.3%       0.00 ± 15%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.00 ± 13%      -1.1%       0.00 ± 13%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00        +1.2e+99%       0.00 ±131%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      0.00        +1.1e+99%       0.00 ±129%  perf-sched.sch_delay.avg.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
      0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 16%      +3.8%       0.01 ± 10%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00            +0.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      0.01 ±  3%      +1.6%       0.01        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
      0.00 ±118%     -67.2%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      0.01 ± 15%      -7.5%       0.00 ± 15%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00        +2.5e+98%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.__put_user_4
      0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.vma_prepare.__split_vma.mprotect_fixup
      0.00 ±244%    +162.5%       0.00 ±173%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00        +7.5e+98%       0.00 ±173%  perf-sched.sch_delay.max.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.pipe_write.vfs_write.ksys_write
      0.00 ±158%     -67.2%       0.00 ±264%  perf-sched.sch_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00 ±244%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.01 ± 57%     -17.1%       0.00 ± 11%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 20%     -11.6%       0.01 ± 21%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.00 ± 23%     +72.2%       0.01 ± 52%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 52%     +20.6%       0.01 ± 45%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.01 ± 37%     -12.5%       0.01 ± 41%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00 ±244%    +337.5%       0.00 ± 77%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.01 ± 45%     +17.5%       0.01 ± 10%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00 ± 20%      -3.8%       0.00 ± 14%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.01 ± 19%      +5.0%       0.01 ± 22%  perf-sched.sch_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.02 ±  6%     +30.9%       0.02 ± 62%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork
      0.00        +1.6e+99%       0.00 ±173%  perf-sched.sch_delay.max.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
      0.00 ± 20%      -0.8%       0.00 ± 10%  perf-sched.sch_delay.max.ms.kjournald2.kthread.ret_from_fork
      0.02 ± 58%     +36.2%       0.02 ± 61%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.01 ±  5%   +9107.6%       0.63 ±261%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 21%      -7.5%       0.00 ± 15%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.01 ± 36%      -7.5%       0.01 ± 15%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ± 13%      -4.4%       0.01 ± 19%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00 ± 41%     -26.5%       0.00 ± 78%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_map_blocks
      0.00 ± 95%     +75.0%       0.00 ± 43%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      0.01 ± 58%      -8.5%       0.01 ± 60%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 ± 69%     +41.0%       0.01 ± 21%  perf-sched.sch_delay.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00        +6.2e+98%       0.00 ±177%  perf-sched.sch_delay.max.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00 ± 75%     +38.2%       0.00 ± 17%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      0.01 ± 40%     -17.4%       0.01 ± 34%  perf-sched.sch_delay.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.01 ± 19%     -26.7%       0.00 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.01 ± 10%     +14.3%       0.01 ± 33%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00        +1.5e+99%       0.00 ±129%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      0.00        +1.1e+99%       0.00 ±129%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
      0.01 ± 41%      -2.3%       0.01 ± 24%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 22%      +5.7%       0.01 ± 16%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.01 ± 52%     -36.1%       0.00 ± 29%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.sch_delay.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      2.51            +0.4%       2.52        perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork
      0.00 ± 12%      +5.0%       0.00        perf-sched.total_sch_delay.average.ms
      2.51           +12.8%       2.83 ± 28%  perf-sched.total_sch_delay.max.ms
    102.66 ±  2%      +2.3%     105.00 ±  2%  perf-sched.total_wait_and_delay.average.ms
      6051            +0.0%       6052        perf-sched.total_wait_and_delay.count.ms
      4995            +0.0%       4995        perf-sched.total_wait_and_delay.max.ms
    102.65 ±  2%      +2.3%     104.99 ±  2%  perf-sched.total_wait_time.average.ms
      4995            +0.0%       4995        perf-sched.total_wait_time.max.ms
     23.43            +0.0%      23.43        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00       +2.4e+103%      24.07 ±264%  perf-sched.wait_and_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
    799.90            -0.0%     799.90        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     17.86            +0.0%      17.86        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    222.01 ±  5%      -3.4%     214.41        perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.29            -0.5%       0.29        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    106.88           +16.8%     124.89 ± 26%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    101.85            -0.0%     101.84        perf-sched.wait_and_delay.avg.ms.irq_thread.kthread.ret_from_fork
      0.00       +5.6e+104%     563.93 ±264%  perf-sched.wait_and_delay.avg.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
    326.82 ± 11%     -21.2%     257.48 ± 58%  perf-sched.wait_and_delay.avg.ms.kjournald2.kthread.ret_from_fork
     33.59 ±  4%      +0.3%      33.70 ±  4%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.29 ±  7%      +1.1%       4.33 ± 10%  perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    571.99            +0.0%     571.99        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    144.08            -0.1%     143.93        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    376.22 ±  2%      -5.8%     354.56 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00       +4.3e+103%      42.98 ±174%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_map_blocks
      0.31 ±  2%      -2.4%       0.30        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    175.85 ± 65%     +28.5%     226.04 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00       +1.3e+103%      12.87 ±264%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00       +7.3e+104%     731.94 ± 44%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      7.54            +1.7%       7.67 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    452.41            -0.0%     452.21        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.71 ±  4%      -0.9%       4.67 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00       +1.3e+103%      13.06 ±264%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
    588.89 ±  2%      +0.6%     592.45        perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +0.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    325.19            +3.6%     336.95 ±  5%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork
    384.00            +0.0%     384.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00       +1.2e+101%       0.12 ±264%  perf-sched.wait_and_delay.count.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     10.00            +0.0%      10.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    503.14            -0.0%     503.12        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    112.00            +0.0%     112.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    111.00            +0.0%     111.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     44.29            -4.3%      42.38 ±  3%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     48.00            +0.0%      48.00        perf-sched.wait_and_delay.count.irq_thread.kthread.ret_from_fork
      0.00       +1.2e+101%       0.12 ±264%  perf-sched.wait_and_delay.count.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
      1.00           -25.0%       0.75 ± 57%  perf-sched.wait_and_delay.count.kjournald2.kthread.ret_from_fork
      1911 ±  4%      -0.3%       1904 ±  4%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
    466.29            +0.6%     469.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork
     21.00            +0.0%      21.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     32.86            +0.4%      33.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
     13.71 ±  3%      +3.9%      14.25 ±  7%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00       +2.5e+101%       0.25 ±173%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_map_blocks
     78.00            +0.0%      78.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.71 ± 63%    +425.0%       3.75 ± 39%  perf-sched.wait_and_delay.count.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00       +1.2e+101%       0.12 ±264%  perf-sched.wait_and_delay.count.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00       +3.6e+102%       3.62 ± 45%  perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
    631.57            -1.3%     623.12        perf-sched.wait_and_delay.count.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
     19.57 ±  3%      -0.4%      19.50 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
    637.29 ±  3%      -0.3%     635.50 ±  6%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00       +2.5e+101%       0.25 ±264%  perf-sched.wait_and_delay.count.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
    517.86 ±  2%      +0.8%     521.88        perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
     32.00            +0.0%      32.00        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.do_open
    461.86 ±  3%      +0.5%     464.38 ±  3%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
      4995            +0.0%       4995        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00       +2.4e+103%      24.07 ±264%  perf-sched.wait_and_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
    999.89            -0.0%     999.89        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000            +0.0%       1000        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1566 ± 66%     -36.0%       1002        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     11.37            -0.1%      11.36        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    324.06 ± 11%    +165.8%     861.46 ±163%  perf-sched.wait_and_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    105.01            -0.0%     105.01        perf-sched.wait_and_delay.max.ms.irq_thread.kthread.ret_from_fork
      0.00       +5.6e+104%     563.93 ±264%  perf-sched.wait_and_delay.max.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
    326.82 ± 11%     -21.2%     257.48 ± 58%  perf-sched.wait_and_delay.max.ms.kjournald2.kthread.ret_from_fork
      1002            +0.0%       1002        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.00            +0.0%       5.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      1000            -0.0%       1000        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    250.00            +0.0%     250.01        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    515.39 ±  5%      -2.8%     500.81        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.00       +4.3e+103%      42.98 ±174%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_map_blocks
      0.62 ±  3%      -3.4%       0.60 ±  2%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    175.85 ± 65%     +69.9%     298.77 ± 10%  perf-sched.wait_and_delay.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00       +1.3e+103%      12.87 ±264%  perf-sched.wait_and_delay.max.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00       +9.3e+104%     926.46 ± 47%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     91.27 ± 34%     -17.7%      75.14 ± 57%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    504.72            +0.0%     504.75        perf-sched.wait_and_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      6.86 ±  5%      -1.6%       6.75 ±  6%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00       +1.3e+103%      13.12 ±264%  perf-sched.wait_and_delay.max.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
      2727 ± 26%     +10.2%       3006        perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      0.01 ± 52%     -36.1%       0.00 ± 29%  perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2770 ± 21%     +11.4%       3085 ± 31%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork
     23.43            +0.0%      23.43        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.25 ±244%     +50.9%       1.88 ±173%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00         +2e+102%       2.04 ±173%  perf-sched.wait_time.avg.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
     19.01 ±158%     +26.6%      24.07 ±264%  perf-sched.wait_time.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.01 ±244%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    799.90            -0.0%     799.90        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.56 ± 10%      -7.0%       1.45 ±  8%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     17.86            +0.0%      17.86        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    222.01 ±  5%      -3.4%     214.41        perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.28            -0.5%       0.28        perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00        +3.8e+98%       0.00 ±264%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.37 ±244%     +31.3%       0.48 ±264%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     43.66 ± 25%     +16.6%      50.90 ± 36%  perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
    106.88           +16.8%     124.89 ± 26%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    101.83            -0.0%     101.82        perf-sched.wait_time.avg.ms.irq_thread.kthread.ret_from_fork
      0.00       +5.6e+104%     563.93 ±264%  perf-sched.wait_time.avg.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
    326.81 ± 11%     -21.2%     257.48 ± 58%  perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork
     33.58 ±  4%      +0.3%      33.70 ±  4%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      4.29 ±  7%      +1.0%       4.33 ± 10%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork
    571.98            +0.0%     571.98        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    144.08            -0.1%     143.92        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    376.21 ±  2%      -5.8%     354.55 ±  9%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     79.73 ± 43%      +0.4%      80.05 ± 85%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_map_blocks
      0.31 ±  2%      -2.3%       0.30        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    175.84 ± 65%     +28.5%     226.03 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00       +2.6e+103%      25.87 ±173%  perf-sched.wait_time.avg.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00       +7.3e+104%     731.94 ± 44%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
      7.54            +1.7%       7.66 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    452.40            -0.0%     452.21        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ± 31%      -4.5%       0.00 ± 37%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      4.70 ±  4%      -0.9%       4.66 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00       +2.8e+103%      28.17 ±129%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      0.00       +3.9e+103%      39.05 ±129%  perf-sched.wait_time.avg.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
    588.89 ±  2%      +0.6%     592.45        perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
      1.57 ± 10%      -7.0%       1.46 ±  8%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00       +9.7e+101%       0.97 ±264%  perf-sched.wait_time.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    325.18            +3.6%     336.94 ±  5%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork
      4995            +0.0%       4995        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.25 ±244%     +64.9%       2.06 ±173%  perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00         +2e+102%       2.04 ±173%  perf-sched.wait_time.max.ms.__cond_resched.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
     19.01 ±158%     +26.6%      24.07 ±264%  perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.01 ±244%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    999.89            -0.0%     999.89        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      3.11 ± 10%      -7.0%       2.90 ±  8%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      1000            +0.0%       1000        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1566 ± 66%     -36.0%       1002        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     11.36            -0.1%      11.35        perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.00        +6.2e+98%       0.00 ±264%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.11 ±244%     -12.5%       0.97 ±264%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     80.64 ± 29%     +58.8%     128.02 ± 36%  perf-sched.wait_time.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
    324.05 ± 11%    +165.8%     861.45 ±163%  perf-sched.wait_time.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    105.00            -0.0%     104.99        perf-sched.wait_time.max.ms.irq_thread.kthread.ret_from_fork
      0.00       +5.6e+104%     563.93 ±264%  perf-sched.wait_time.max.ms.jbd2_journal_wait_updates.jbd2_journal_commit_transaction.kjournald2.kthread
    326.81 ± 11%     -21.2%     257.48 ± 58%  perf-sched.wait_time.max.ms.kjournald2.kthread.ret_from_fork
      1002            +0.0%       1002        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      5.00            +0.0%       5.00        perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork
      1000            -0.0%       1000        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    250.00            +0.0%     250.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    515.39 ±  5%      -2.8%     500.80        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     79.73 ± 43%      +0.4%      80.05 ± 85%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.ext4_map_blocks
      0.62 ±  3%      -3.4%       0.60 ±  2%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    175.84 ± 65%     +69.9%     298.77 ± 10%  perf-sched.wait_time.max.ms.schedule_timeout.ext4_lazyinit_thread.part.0.kthread
      0.00       +2.6e+103%      25.87 ±173%  perf-sched.wait_time.max.ms.schedule_timeout.hwrng_fillfn.kthread.ret_from_fork
      0.00       +9.3e+104%     926.46 ± 47%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.__wait_for_common.submit_bio_wait
     91.27 ± 34%     -17.7%      75.13 ± 57%  perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    504.71            +0.0%     504.75        perf-sched.wait_time.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.00 ± 31%      -4.5%       0.00 ± 37%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      6.86 ±  5%      -1.6%       6.75 ±  6%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00       +3.9e+103%      39.21 ±129%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_data.tpm_tis_send_main
      0.00       +3.9e+103%      39.11 ±129%  perf-sched.wait_time.max.ms.schedule_timeout.wait_for_tpm_stat.tpm_tis_send_main.tpm_try_transmit
      2727 ± 26%     +10.2%       3006        perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
      3.13 ± 10%      -7.0%       2.91 ±  8%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00       +9.7e+101%       0.97 ±264%  perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      2770 ± 21%     +11.4%       3085 ± 31%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork
      8.72 ± 11%      -1.4        7.28 ± 12%  perf-profile.calltrace.cycles-pp.__libc_write
      8.45 ± 11%      -1.4        7.08 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write
      8.42 ± 11%      -1.4        7.06 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      8.36 ± 11%      -1.3        7.03 ± 13%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      8.30 ± 11%      -1.3        6.97 ± 13%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      8.02 ± 10%      -1.3        6.76 ± 13%  perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.74 ± 10%      -1.2        6.53 ± 14%  perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      2.99 ± 66%      -0.9        2.05 ± 79%  perf-profile.calltrace.cycles-pp.ktime_get.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      3.32 ± 58%      -0.9        2.46 ± 63%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      3.59 ± 53%      -0.8        2.76 ± 56%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      3.02 ± 10%      -0.6        2.44 ± 13%  perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.90 ± 10%      -0.5        2.36 ± 13%  perf-profile.calltrace.cycles-pp.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      2.54 ± 10%      -0.5        2.06 ± 13%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.generic_write_end.generic_perform_write.ext4_buffered_write_iter
      0.47 ± 42%      -0.4        0.08 ±264%  perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter
      0.47 ± 42%      -0.4        0.08 ±264%  perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_atomic.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.47 ± 42%      -0.4        0.08 ±264%  perf-profile.calltrace.cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write
      0.52 ± 42%      -0.4        0.14 ±174%  perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.69 ± 14%      -0.4        0.31 ±102%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end.generic_perform_write
      2.94 ± 11%      -0.3        2.59 ± 17%  perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.62 ± 45%      -0.3        0.34 ±103%  perf-profile.calltrace.cycles-pp.ktime_get.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.42 ± 64%      -0.3        0.15 ±173%  perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.generic_write_end
      0.82 ± 52%      -0.3        0.57 ± 63%  perf-profile.calltrace.cycles-pp.tick_sched_do_timer.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.31 ± 87%      -0.2        0.07 ±264%  perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush_atomic.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
     35.42 ±  5%      -0.2       35.21 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.58 ± 41%      -0.2        0.38 ± 78%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.34 ± 89%      -0.2        0.14 ±173%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.50 ± 69%      -0.2        0.31 ±100%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      1.12 ± 13%      -0.2        0.93 ± 20%  perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.55 ± 43%      -0.2        0.39 ± 79%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.rcu_report_qs_rdp.rcu_core.__do_softirq.__irq_exit_rcu
      1.73 ± 12%      -0.2        1.57 ± 17%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.14 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.fio_gettime
      0.34 ± 87%      -0.1        0.21 ±129%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
      1.40 ± 22%      -0.1        1.28 ± 29%  perf-profile.calltrace.cycles-pp.ext4_end_io_rsv_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.18 ±160%      -0.1        0.07 ±264%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      1.38 ± 22%      -0.1        1.27 ± 29%  perf-profile.calltrace.cycles-pp.ext4_finish_bio.ext4_release_io_end.ext4_end_io_rsv_work.process_one_work.worker_thread
      1.39 ± 22%      -0.1        1.28 ± 29%  perf-profile.calltrace.cycles-pp.ext4_release_io_end.ext4_end_io_rsv_work.process_one_work.worker_thread.kthread
      0.46 ± 65%      -0.1        0.36 ± 77%  perf-profile.calltrace.cycles-pp.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_vmap.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_shmem_object_vmap.drm_gem_vmap.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev_generic_helper_fb_dirty
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_shmem_vmap_locked.drm_gem_shmem_object_vmap.drm_gem_vmap.drm_gem_vmap_unlocked.drm_client_buffer_vmap
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_shmem_get_pages.drm_gem_shmem_vmap_locked.drm_gem_shmem_object_vmap.drm_gem_vmap.drm_gem_vmap_unlocked
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_shmem_get_pages_locked.drm_gem_shmem_get_pages.drm_gem_shmem_vmap_locked.drm_gem_shmem_object_vmap.drm_gem_vmap
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked.drm_gem_shmem_get_pages.drm_gem_shmem_vmap_locked.drm_gem_shmem_object_vmap
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.shmem_read_mapping_page_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked.drm_gem_shmem_get_pages.drm_gem_shmem_vmap_locked
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_client_buffer_vmap.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_read_folio_gfp.shmem_read_mapping_page_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked
      0.10 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.shmem_read_folio_gfp.shmem_read_mapping_page_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked.drm_gem_shmem_get_pages
      0.09 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_read_folio_gfp.shmem_read_mapping_page_gfp.drm_gem_get_pages
      0.09 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_read_folio_gfp.shmem_read_mapping_page_gfp
      0.09 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write
      5.38 ±  9%      -0.1        5.29 ±  4%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.09 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.xas_load.filemap_get_entry.shmem_get_folio_gfp.shmem_read_folio_gfp
      0.09 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.xas_load.filemap_get_entry.shmem_get_folio_gfp
      0.09 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.xas_load.filemap_get_entry
      0.09 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.xas_load
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.fio_gettime
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.fio_gettime
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.fio_gettime
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.fio_gettime
      0.36 ± 90%      -0.1        0.28 ±100%  perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.fio_io_end
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.check_cpu_stall.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_sched_handle
      4.81 ±  9%      -0.1        4.73 ±  3%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.fio_io_end
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.fio_io_end
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.fio_io_end
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.fio_io_end
      0.08 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin
      0.94 ± 23%      -0.1        0.87 ± 45%  perf-profile.calltrace.cycles-pp.folio_end_writeback.ext4_finish_bio.ext4_release_io_end.ext4_end_io_rsv_work.process_one_work
      0.07 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      0.15 ±158%      -0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.15 ±158%      -0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.15 ±158%      -0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.execve
      0.15 ±158%      -0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.15 ±158%      -0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      2.03 ± 15%      -0.1        1.96 ± 10%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.07 ±244%      -0.1        0.00        perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3.64 ± 25%      -0.1        3.57 ± 12%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      3.61 ± 25%      -0.1        3.54 ± 12%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      1.16 ± 13%      -0.1        1.09 ± 14%  perf-profile.calltrace.cycles-pp.rcu_pending.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer
      0.83 ± 22%      -0.1        0.76 ± 45%  perf-profile.calltrace.cycles-pp.__folio_end_writeback.folio_end_writeback.ext4_finish_bio.ext4_release_io_end.ext4_end_io_rsv_work
      0.42 ± 64%      -0.1        0.36 ± 79%  perf-profile.calltrace.cycles-pp.native_apic_msr_eoi_write.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      3.84 ± 23%      -0.1        3.79 ± 12%  perf-profile.calltrace.cycles-pp.ret_from_fork
      3.84 ± 23%      -0.1        3.79 ± 12%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.76 ± 12%      -0.0        1.72 ±  5%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.60 ± 43%      -0.0        0.56 ± 41%  perf-profile.calltrace.cycles-pp.rcu_report_qs_rdp.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      1.02 ± 15%      -0.0        0.98 ± 20%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.89 ± 25%      -0.0        0.85 ± 13%  perf-profile.calltrace.cycles-pp.ext4_bio_write_folio.mpage_submit_folio.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_writepages
      0.78 ± 19%      -0.0        0.74 ±  6%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu
      0.32 ±158%      -0.0        0.28 ±173%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit._printk
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.calltrace.cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.calltrace.cycles-pp._printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.calltrace.cycles-pp.vprintk_emit._printk.irq_work_single.irq_work_run_list.irq_work_run
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.irq_work_single.irq_work_run_list
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit._printk.irq_work_single
      1.32 ± 12%      -0.0        1.28 ± 11%  perf-profile.calltrace.cycles-pp.rcu_sched_clock_irq.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.90 ±  9%      -0.0        0.86 ± 13%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt
      1.42 ±  9%      -0.0        1.39 ± 18%  perf-profile.calltrace.cycles-pp.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.33 ±158%      -0.0        0.31 ±173%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.33 ±158%      -0.0        0.31 ±173%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.15 ±244%      -0.0        0.13 ±264%  perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      0.62 ± 42%      -0.0        0.61 ± 41%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      0.08 ±244%      -0.0        0.07 ±264%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.rcu_report_qs_rdp.rcu_core.__do_softirq
      1.02 ± 11%      +0.0        1.03 ±  6%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.51 ± 65%      +0.0        0.51 ± 60%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      1.67 ± 10%      +0.0        1.68 ± 12%  perf-profile.calltrace.cycles-pp.arch_scale_freq_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.66 ± 44%      +0.0        0.67 ±  6%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      1.14 ±  8%      +0.0        1.16 ± 13%  perf-profile.calltrace.cycles-pp.perf_rotate_context.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.76 ±  6%      +0.0        1.79 ± 12%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.11 ± 14%      +0.0        1.14 ± 12%  perf-profile.calltrace.cycles-pp.note_gp_changes.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      1.14 ± 11%      +0.0        1.18 ± 13%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.wb_do_writeback.wb_workfn.process_one_work.worker_thread.kthread
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_do_writeback.wb_workfn.process_one_work.worker_thread
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn.process_one_work
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
      1.37 ± 27%      +0.1        1.43 ± 14%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.calltrace.cycles-pp.ext4_do_writepages.ext4_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      1.95 ± 12%      +0.1        2.01 ± 22%  perf-profile.calltrace.cycles-pp.ktime_get_update_offsets_now.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.36 ± 27%      +0.1        1.42 ± 13%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages.do_writepages
      0.07 ±244%      +0.1        0.13 ±173%  perf-profile.calltrace.cycles-pp.ktime_get.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.08 ±244%      +0.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.update_blocked_averages.run_rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.1        0.06 ±264%  perf-profile.calltrace.cycles-pp.timerqueue_add.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      1.15 ± 23%      +0.1        1.22 ± 16%  perf-profile.calltrace.cycles-pp.mpage_submit_folio.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages
      0.52 ± 67%      +0.1        0.59 ± 12%  perf-profile.calltrace.cycles-pp.__folio_start_writeback.ext4_bio_write_folio.mpage_submit_folio.mpage_map_and_submit_buffers.mpage_map_and_submit_extent
      0.00            +0.1        0.07 ±264%  perf-profile.calltrace.cycles-pp.enqueue_hrtimer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.07 ±264%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.get_io_u
      0.00            +0.1        0.07 ±264%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.get_io_u
      0.00            +0.1        0.07 ±264%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_io_u
      0.00            +0.1        0.07 ±264%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.get_io_u
      0.08 ±244%      +0.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.memcpy_toio
      0.08 ±244%      +0.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes
      0.08 ±244%      +0.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update
      0.08 ±244%      +0.1        0.15 ±173%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.memcpy_toio.drm_fb_memcpy
      0.98 ± 10%      +0.1        1.05 ± 20%  perf-profile.calltrace.cycles-pp.lapic_next_deadline.clockevents_program_event.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.07 ±264%  perf-profile.calltrace.cycles-pp.update_rq_clock_task.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.td_io_queue
      0.00            +0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.td_io_queue
      0.00            +0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.td_io_queue
      0.00            +0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.td_io_queue
      0.00            +0.1        0.08 ±264%  perf-profile.calltrace.cycles-pp.calc_global_load_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      0.00            +0.1        0.09 ±264%  perf-profile.calltrace.cycles-pp.td_io_queue
      0.00            +0.1        0.10 ±264%  perf-profile.calltrace.cycles-pp.get_io_u
      1.33 ± 14%      +0.1        1.43 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      1.38 ± 15%      +0.1        1.49 ± 13%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.17 ±158%      +0.1        0.29 ±101%  perf-profile.calltrace.cycles-pp.run_rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.37 ± 15%      +0.1        1.49 ± 12%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.44 ± 64%      +0.1        0.56 ± 40%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.44 ± 64%      +0.1        0.56 ± 40%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.13 ±244%      +0.1        0.25 ±173%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      0.15 ±244%      +0.1        0.28 ±173%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.15 ±244%      +0.1        0.28 ±173%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.15 ±244%      +0.1        0.28 ±173%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.13 ±244%      +0.1        0.26 ±173%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      0.13 ±244%      +0.1        0.26 ±173%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      0.13 ±244%      +0.1        0.26 ±173%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      0.13 ±244%      +0.1        0.26 ±173%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      0.13 ±244%      +0.1        0.26 ±173%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      0.13 ±244%      +0.1        0.26 ±173%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      0.08 ±244%      +0.2        0.23 ±130%  perf-profile.calltrace.cycles-pp.cpuidle_governor_latency_req.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.44 ±  6%      +0.3        2.72 ±  6%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      6.02 ±  9%      +0.5        6.47 ± 16%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
     16.75 ±  3%      +0.5       17.22 ±  7%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
     19.61 ±  2%      +0.7       20.30 ±  6%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      9.66 ±  6%      +0.7       10.41 ± 12%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
     43.07 ±  4%      +0.8       43.82 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      9.35 ±  6%      +0.8       10.13 ± 12%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
     14.95 ±  5%      +0.8       15.75 ±  7%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
     15.11 ±  5%      +0.8       15.92 ±  7%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
     12.71 ±  5%      +0.8       13.54 ± 10%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
     24.55 ±  2%      +0.9       25.48 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
     23.75 ±  2%      +1.0       24.70 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
     77.39 ±  2%      +1.3       78.74        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     78.37 ±  2%      +1.4       79.82        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     77.30 ±  2%      +1.5       78.81        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     80.76 ±  2%      +1.6       82.34        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     81.47 ±  2%      +1.6       83.10        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     81.47 ±  2%      +1.6       83.10        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     81.30 ±  2%      +1.6       82.93        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     82.85            +1.7       84.59        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
    106.34            +1.9      108.23        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      8.81 ± 11%      -1.5        7.34 ± 12%  perf-profile.children.cycles-pp.__libc_write
     10.24 ±  9%      -1.3        8.92 ± 11%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.21 ±  8%      -1.3        8.90 ± 11%  perf-profile.children.cycles-pp.do_syscall_64
      8.43 ± 11%      -1.3        7.13 ± 13%  perf-profile.children.cycles-pp.ksys_write
      8.36 ± 11%      -1.3        7.07 ± 13%  perf-profile.children.cycles-pp.vfs_write
      8.04 ± 10%      -1.3        6.78 ± 13%  perf-profile.children.cycles-pp.ext4_buffered_write_iter
      7.76 ± 10%      -1.2        6.56 ± 14%  perf-profile.children.cycles-pp.generic_perform_write
      4.73 ± 43%      -1.1        3.65 ± 44%  perf-profile.children.cycles-pp.ktime_get
      3.41 ± 58%      -0.9        2.54 ± 62%  perf-profile.children.cycles-pp.tick_irq_enter
      3.67 ± 53%      -0.8        2.83 ± 56%  perf-profile.children.cycles-pp.irq_enter_rcu
      3.02 ± 10%      -0.6        2.44 ± 13%  perf-profile.children.cycles-pp.generic_write_end
      2.91 ± 10%      -0.5        2.38 ± 13%  perf-profile.children.cycles-pp.block_write_end
      2.55 ± 10%      -0.5        2.06 ± 13%  perf-profile.children.cycles-pp.__block_commit_write
      2.27 ± 10%      -0.4        1.90 ± 13%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.96 ± 11%      -0.4        2.60 ± 17%  perf-profile.children.cycles-pp.ext4_da_write_begin
      0.62 ± 35%      -0.2        0.41 ± 20%  perf-profile.children.cycles-pp.xas_load
      0.88 ± 42%      -0.2        0.68 ± 33%  perf-profile.children.cycles-pp.tick_sched_do_timer
      1.12 ± 12%      -0.2        0.93 ± 20%  perf-profile.children.cycles-pp.ext4_block_write_begin
      0.26 ± 79%      -0.2        0.10 ± 49%  perf-profile.children.cycles-pp.filemap_get_entry
      0.69 ± 15%      -0.2        0.54 ± 21%  perf-profile.children.cycles-pp.mark_buffer_dirty
      1.74 ± 13%      -0.2        1.59 ± 17%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.49 ± 60%      -0.1        0.34 ± 15%  perf-profile.children.cycles-pp.fio_gettime
      1.40 ± 22%      -0.1        1.28 ± 29%  perf-profile.children.cycles-pp.ext4_end_io_rsv_work
      0.56 ± 14%      -0.1        0.45 ± 23%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.19 ±112%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages
      0.19 ±112%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages_locked
      0.19 ±112%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.drm_gem_get_pages
      0.19 ±112%      -0.1        0.08 ± 14%  perf-profile.children.cycles-pp.shmem_read_mapping_page_gfp
      0.20 ±106%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.drm_gem_vmap_unlocked
      0.20 ±106%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.drm_gem_vmap
      0.20 ±106%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.drm_gem_shmem_object_vmap
      0.20 ±106%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.drm_gem_shmem_vmap_locked
      1.39 ± 22%      -0.1        1.27 ± 29%  perf-profile.children.cycles-pp.ext4_finish_bio
      0.17 ±120%      -0.1        0.06 ± 15%  perf-profile.children.cycles-pp.shmem_read_folio_gfp
      1.39 ± 22%      -0.1        1.28 ± 29%  perf-profile.children.cycles-pp.ext4_release_io_end
      0.15 ±140%      -0.1        0.05 ± 58%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
     35.48 ±  5%      -0.1       35.38 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.13 ±177%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.drm_client_buffer_vmap
      0.60 ± 19%      -0.1        0.50 ± 22%  perf-profile.children.cycles-pp.folio_create_empty_buffers
      0.92 ± 20%      -0.1        0.82 ± 12%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.95 ±  8%      -0.1        0.86 ± 14%  perf-profile.children.cycles-pp.native_sched_clock
      0.65 ± 16%      -0.1        0.56 ± 15%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.57 ± 21%      -0.1        0.48 ± 16%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.48 ± 16%      -0.1        0.40 ± 21%  perf-profile.children.cycles-pp.copyin
      0.39 ± 15%      -0.1        0.30 ± 30%  perf-profile.children.cycles-pp.ext4_da_write_end
      0.63 ± 20%      -0.1        0.55 ± 32%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.54 ± 19%      -0.1        0.46 ± 22%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.23 ± 37%      -0.1        0.15 ± 34%  perf-profile.children.cycles-pp.timekeeping_advance
      0.23 ± 37%      -0.1        0.15 ± 34%  perf-profile.children.cycles-pp.update_wall_time
      0.56 ± 24%      -0.1        0.48 ± 20%  perf-profile.children.cycles-pp.folio_alloc
      0.41 ± 23%      -0.1        0.33 ± 25%  perf-profile.children.cycles-pp.folio_alloc_buffers
      0.27 ± 13%      -0.1        0.20 ± 23%  perf-profile.children.cycles-pp.read
      0.54 ± 21%      -0.1        0.47 ± 17%  perf-profile.children.cycles-pp.__alloc_pages
      0.38 ± 24%      -0.1        0.30 ± 26%  perf-profile.children.cycles-pp.alloc_buffer_head
      3.64 ± 25%      -0.1        3.57 ± 12%  perf-profile.children.cycles-pp.worker_thread
      0.19 ± 24%      -0.1        0.12 ± 42%  perf-profile.children.cycles-pp.__xa_set_mark
      1.20 ± 11%      -0.1        1.13 ± 14%  perf-profile.children.cycles-pp.rcu_pending
      3.61 ± 25%      -0.1        3.54 ± 12%  perf-profile.children.cycles-pp.process_one_work
      0.08 ±244%      -0.1        0.01 ±264%  perf-profile.children.cycles-pp.fio_io_end
      5.50 ±  8%      -0.1        5.43 ±  4%  perf-profile.children.cycles-pp.__irq_exit_rcu
      2.07 ± 14%      -0.1        2.01 ± 10%  perf-profile.children.cycles-pp.rcu_core
      0.43 ± 12%      -0.1        0.36 ± 20%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.92 ±  8%      -0.1        0.86 ± 11%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.38 ±135%      -0.1        0.32 ±164%  perf-profile.children.cycles-pp.irq_work_run_list
      0.51 ± 20%      -0.1        0.45 ± 17%  perf-profile.children.cycles-pp.cgroup_rstat_flush_atomic
      0.28 ± 18%      -0.1        0.22 ± 21%  perf-profile.children.cycles-pp.vfs_read
      0.51 ± 20%      -0.1        0.45 ± 16%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.30 ± 17%      -0.1        0.24 ± 19%  perf-profile.children.cycles-pp.ksys_read
      0.51 ± 20%      -0.1        0.45 ± 17%  perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.44 ± 26%      -0.1        0.38 ± 21%  perf-profile.children.cycles-pp.kmem_cache_alloc
      3.86 ± 23%      -0.1        3.80 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
      0.51 ± 20%      -0.1        0.45 ± 16%  perf-profile.children.cycles-pp.do_flush_stats
      1.06 ± 10%      -0.1        1.00 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock
      3.84 ± 23%      -0.1        3.79 ± 12%  perf-profile.children.cycles-pp.kthread
      4.91 ±  9%      -0.1        4.85 ±  3%  perf-profile.children.cycles-pp.__do_softirq
      0.17 ± 23%      -0.1        0.11 ± 40%  perf-profile.children.cycles-pp.thread_main
      1.19 ± 10%      -0.1        1.14 ± 12%  perf-profile.children.cycles-pp.read_tsc
      0.35 ± 16%      -0.1        0.30 ± 20%  perf-profile.children.cycles-pp.xas_descend
      0.66 ± 30%      -0.0        0.61 ± 13%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.10 ± 40%      -0.0        0.05 ± 95%  perf-profile.children.cycles-pp.xas_start
      1.81 ± 11%      -0.0        1.77 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
      0.84 ± 19%      -0.0        0.79 ±  6%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.10 ± 57%      -0.0        0.05 ± 61%  perf-profile.children.cycles-pp.account_io_completion
      0.44 ± 14%      -0.0        0.40 ± 17%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.15 ± 22%      -0.0        0.10 ± 45%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.27 ±160%      -0.0        0.22 ±176%  perf-profile.children.cycles-pp.io_serial_in
      0.19 ± 22%      -0.0        0.15 ± 22%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.09 ± 50%      -0.0        0.05 ± 92%  perf-profile.children.cycles-pp.xa_get_order
      0.06 ± 46%      -0.0        0.02 ±180%  perf-profile.children.cycles-pp.__open64_nocancel
      1.02 ± 15%      -0.0        0.98 ± 20%  perf-profile.children.cycles-pp.filemap_add_folio
      0.13 ± 23%      -0.0        0.09 ± 50%  perf-profile.children.cycles-pp.seq_read_iter
      0.79 ±  8%      -0.0        0.74 ± 13%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.11 ± 37%      -0.0        0.07 ± 42%  perf-profile.children.cycles-pp.folio_unlock
      1.36 ± 12%      -0.0        1.32 ± 11%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.05 ± 69%      -0.0        0.02 ±176%  perf-profile.children.cycles-pp.up_write
      0.10 ± 22%      -0.0        0.06 ± 24%  perf-profile.children.cycles-pp.asm_common_interrupt
      0.10 ± 22%      -0.0        0.06 ± 24%  perf-profile.children.cycles-pp.common_interrupt
      0.06 ± 54%      -0.0        0.02 ±131%  perf-profile.children.cycles-pp.___slab_alloc
      0.04 ±121%      -0.0        0.00        perf-profile.children.cycles-pp.dequeue_task_fair
      0.67 ± 20%      -0.0        0.64 ± 18%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.03 ±119%      -0.0        0.00        perf-profile.children.cycles-pp.dequeue_entity
      0.07 ± 74%      -0.0        0.04 ±103%  perf-profile.children.cycles-pp.alloc_pages
      0.10 ± 28%      -0.0        0.06 ± 79%  perf-profile.children.cycles-pp.node_dirty_ok
      0.87 ± 18%      -0.0        0.83 ±  4%  perf-profile.children.cycles-pp.find_busiest_group
      0.32 ±158%      -0.0        0.28 ±173%  perf-profile.children.cycles-pp.serial8250_console_write
      0.13 ± 38%      -0.0        0.09 ± 63%  perf-profile.children.cycles-pp.tick_check_broadcast_expired
      0.89 ± 25%      -0.0        0.86 ± 13%  perf-profile.children.cycles-pp.ext4_bio_write_folio
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.irq_work_run
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp._printk
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.vprintk_emit
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.console_unlock
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.console_flush_all
      0.04 ±102%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.pcpu_alloc
      0.67 ± 20%      -0.0        0.64 ± 24%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.10 ± 25%      -0.0        0.06 ± 23%  perf-profile.children.cycles-pp.__common_interrupt
      0.20 ± 16%      -0.0        0.17 ± 37%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.29 ± 20%      -0.0        0.26 ± 35%  perf-profile.children.cycles-pp.local_clock
      0.08 ± 19%      -0.0        0.05 ± 65%  perf-profile.children.cycles-pp.setlocale
      0.09 ± 25%      -0.0        0.06 ± 23%  perf-profile.children.cycles-pp.handle_irq_event
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.32 ±158%      -0.0        0.29 ±173%  perf-profile.children.cycles-pp.irq_work_single
      0.31 ±158%      -0.0        0.28 ±173%  perf-profile.children.cycles-pp.wait_for_lsr
      0.09 ± 25%      -0.0        0.06 ± 23%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.14 ± 25%      -0.0        0.11 ± 28%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.19 ± 16%      -0.0        0.16 ± 19%  perf-profile.children.cycles-pp.hrtimer_get_next_event
      0.24 ± 26%      -0.0        0.21 ± 31%  perf-profile.children.cycles-pp.mmap_region
      0.40 ± 24%      -0.0        0.37 ± 13%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.14 ± 33%      -0.0        0.11 ± 46%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.26 ± 20%      -0.0        0.24 ± 21%  perf-profile.children.cycles-pp.rmqueue
      0.40 ± 15%      -0.0        0.38 ± 16%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.19 ± 32%      -0.0        0.17 ± 33%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.07 ± 57%      -0.0        0.04 ± 86%  perf-profile.children.cycles-pp.xas_clear_mark
      0.17 ± 28%      -0.0        0.14 ± 44%  perf-profile.children.cycles-pp.schedule
      0.26 ± 20%      -0.0        0.23 ± 33%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.13 ± 30%      -0.0        0.10 ± 21%  perf-profile.children.cycles-pp.cpuidle_reflect
      0.02 ±158%      -0.0        0.00        perf-profile.children.cycles-pp.in_ramp_time
      1.44 ±  8%      -0.0        1.42 ± 17%  perf-profile.children.cycles-pp.clockevents_program_event
      0.25 ± 28%      -0.0        0.23 ± 29%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.05 ± 66%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.drm_atomic_helper_prepare_planes
      0.20 ± 17%      -0.0        0.18 ± 28%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.25 ± 29%      -0.0        0.22 ± 29%  perf-profile.children.cycles-pp.do_mmap
      0.08 ± 73%      -0.0        0.05 ± 94%  perf-profile.children.cycles-pp.__split_vma
      0.04 ± 89%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.allocate_slab
      0.02 ±116%      -0.0        0.00        perf-profile.children.cycles-pp.io_schedule_timeout
      0.20 ± 18%      -0.0        0.18 ± 28%  perf-profile.children.cycles-pp.do_sys_openat2
      0.04 ± 95%      -0.0        0.02 ±173%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.69 ± 12%      -0.0        0.67 ± 13%  perf-profile.children.cycles-pp.native_apic_msr_eoi_write
      0.95 ± 23%      -0.0        0.93 ± 30%  perf-profile.children.cycles-pp.folio_end_writeback
      0.08 ± 50%      -0.0        0.06 ± 54%  perf-profile.children.cycles-pp.__fprop_add_percpu
      0.62 ± 18%      -0.0        0.60 ± 11%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.05 ± 66%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.drm_gem_fb_vmap
      0.07 ± 67%      -0.0        0.05 ± 85%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.46 ± 20%      -0.0        0.44 ± 25%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.06 ± 74%      -0.0        0.04 ± 86%  perf-profile.children.cycles-pp.io_completed
      0.15 ± 36%      -0.0        0.13 ± 31%  perf-profile.children.cycles-pp.__cond_resched
      0.14 ± 14%      -0.0        0.12 ± 20%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.05 ± 43%      -0.0        0.03 ±106%  perf-profile.children.cycles-pp.security_file_permission
      0.16 ± 32%      -0.0        0.14 ± 45%  perf-profile.children.cycles-pp.filemap_map_pages
      0.07 ± 17%      -0.0        0.05 ± 85%  perf-profile.children.cycles-pp.add_lat_sample
      0.09 ± 52%      -0.0        0.07 ± 47%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.18 ± 22%      -0.0        0.16 ± 40%  perf-profile.children.cycles-pp.path_openat
      0.02 ±163%      -0.0        0.00        perf-profile.children.cycles-pp.tick_nohz_idle_got_tick
      0.02 ±163%      -0.0        0.00        perf-profile.children.cycles-pp.current_time
      0.04 ± 89%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.handle_fasteoi_irq
      0.04 ± 89%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.acpi_irq
      0.04 ± 89%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.acpi_ev_sci_xrupt_handler
      0.04 ± 89%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.acpi_os_read_port
      0.04 ± 89%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.acpi_ev_gpe_detect
      0.04 ± 89%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.acpi_ev_detect_gpe
      0.06 ± 79%      -0.0        0.04 ± 80%  perf-profile.children.cycles-pp.mm_init
      0.02 ±116%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.folio_memcg_unlock
      0.02 ±116%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.timer_clear_idle
      0.03 ± 87%      -0.0        0.01 ±174%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.03 ± 87%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.schedule_timeout
      0.12 ± 20%      -0.0        0.10 ± 28%  perf-profile.children.cycles-pp.filemap_get_folios_tag
      0.02 ±158%      -0.0        0.00        perf-profile.children.cycles-pp.cpuidle_select
      0.02 ±161%      -0.0        0.00        perf-profile.children.cycles-pp._find_first_bit
      0.02 ±116%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.ntime_since
      0.03 ±120%      -0.0        0.01 ±174%  perf-profile.children.cycles-pp.alloc_bprm
      0.02 ±159%      -0.0        0.00        perf-profile.children.cycles-pp.__memcpy
      0.02 ±159%      -0.0        0.00        perf-profile.children.cycles-pp.drm_atomic_helper_cleanup_planes
      0.02 ±159%      -0.0        0.00        perf-profile.children.cycles-pp.drm_gem_fb_vunmap
      0.02 ±159%      -0.0        0.00        perf-profile.children.cycles-pp.ramp_time_over
      0.02 ±159%      -0.0        0.00        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.02 ±159%      -0.0        0.00        perf-profile.children.cycles-pp.evlist__id2evsel
      0.07 ± 49%      -0.0        0.05 ± 87%  perf-profile.children.cycles-pp.next_uptodate_page
      0.20 ± 23%      -0.0        0.19 ± 34%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.18 ± 19%      -0.0        0.17 ± 39%  perf-profile.children.cycles-pp.do_filp_open
      0.02 ±162%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.ext4_dirty_inode
      0.24 ± 30%      -0.0        0.23 ± 12%  perf-profile.children.cycles-pp.ct_idle_exit
      0.11 ± 70%      -0.0        0.09 ± 48%  perf-profile.children.cycles-pp.file_modified_flags
      0.08 ± 62%      -0.0        0.06 ± 62%  perf-profile.children.cycles-pp.run_timer_softirq
      0.01 ±158%      -0.0        0.00        perf-profile.children.cycles-pp.put_io_u
      0.01 ±158%      -0.0        0.00        perf-profile.children.cycles-pp.__update_load_avg_se
      0.01 ±158%      -0.0        0.00        perf-profile.children.cycles-pp.dup_task_struct
      0.06 ± 68%      -0.0        0.05 ± 82%  perf-profile.children.cycles-pp.down_write
      0.03 ± 89%      -0.0        0.02 ±175%  perf-profile.children.cycles-pp.show_stat
      0.02 ±162%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.__percpu_counter_init
      0.03 ±116%      -0.0        0.02 ±179%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.72 ± 18%      -0.0        0.70 ± 16%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.05 ± 70%      -0.0        0.04 ±111%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.mas_wr_modify
      0.04 ±142%      -0.0        0.03 ±104%  perf-profile.children.cycles-pp.update_vsyscall
      0.05 ± 67%      -0.0        0.04 ± 81%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.03 ± 87%      -0.0        0.02 ±182%  perf-profile.children.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.02 ±160%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.rcu_report_qs_rnp
      0.42 ± 21%      -0.0        0.41 ± 15%  perf-profile.children.cycles-pp.check_cpu_stall
      0.04 ±123%      -0.0        0.02 ±133%  perf-profile.children.cycles-pp.__get_io_u
      0.04 ±121%      -0.0        0.02 ±133%  perf-profile.children.cycles-pp.io_queue_event
      0.02 ±162%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.dput
      0.04 ± 90%      -0.0        0.03 ±144%  perf-profile.children.cycles-pp.step_into
      0.03 ±116%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.acpi_hw_gpe_read
      0.08 ± 68%      -0.0        0.07 ± 45%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.02 ±158%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.devkmsg_read
      0.02 ±158%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.force_qs_rnp
      0.02 ±159%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.generic_update_time
      0.02 ±116%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.getname_flags
      0.02 ±116%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.wait4
      0.24 ± 26%      -0.0        0.23 ± 34%  perf-profile.children.cycles-pp.__schedule
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.mas_wr_node_store
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.io_u_mark_depth
      0.17 ± 31%      -0.0        0.16 ± 42%  perf-profile.children.cycles-pp.do_read_fault
      0.04 ± 88%      -0.0        0.03 ±104%  perf-profile.children.cycles-pp.update_load_avg
      0.02 ±161%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.vma_prepare
      0.02 ±159%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.check_move_unevictable_folios
      0.02 ±159%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.check_move_unevictable_pages
      0.02 ±159%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.__bitmap_and
      0.03 ±127%      -0.0        0.02 ±130%  perf-profile.children.cycles-pp.sched_idle_set_state
      0.02 ±158%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.vma_complete
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp._copy_from_user
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.mas_next_entry
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.scsi_io_completion
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.log_io_u
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.mas_wr_walk
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.scsi_end_request
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.mas_wr_store_entry
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.perf_swevent_start
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.refill_obj_stock
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp._IO_fwrite
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__anon_vma_prepare
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.do_open
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_accelerate_cbs
      0.14 ± 30%      -0.0        0.13 ± 21%  perf-profile.children.cycles-pp.__entry_text_start
      0.01 ±158%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp._raw_read_lock
      0.02 ±169%      -0.0        0.01 ±174%  perf-profile.children.cycles-pp.policy_node
      0.03 ±124%      -0.0        0.02 ±130%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.04 ± 87%      -0.0        0.03 ±106%  perf-profile.children.cycles-pp.node_page_state
      0.18 ± 14%      -0.0        0.17 ± 30%  perf-profile.children.cycles-pp.lru_add_fn
      0.02 ±158%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.get_start_offset
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.io_bytes_exceeded
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.page_remove_rmap
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_segcblist_ready_cbs
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.remove_vm_area
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.workingset_update_node
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__list_add_valid
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.init_icd
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.task_tick_idle
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__vmalloc_node_range
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__vmalloc_area_node
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__alloc_pages_bulk
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.do_nanosleep
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__d_add
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.get_idle_time
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.update_curr
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__file_remove_privs
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.rcu_needs_cpu
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.free_unref_page_list
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.irq_exit_rcu
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.jbd2__journal_start
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.01 ±244%      -0.0        0.00        perf-profile.children.cycles-pp.open64
      0.11 ± 29%      -0.0        0.10 ± 28%  perf-profile.children.cycles-pp.hrtimer_forward
      0.07 ± 77%      -0.0        0.06 ± 80%  perf-profile.children.cycles-pp.activate_task
      0.06 ± 46%      -0.0        0.06 ± 87%  perf-profile.children.cycles-pp.error_return
      0.13 ± 22%      -0.0        0.13 ± 21%  perf-profile.children.cycles-pp.__xa_clear_mark
      0.50 ± 11%      -0.0        0.49 ± 16%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.04 ± 91%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.xas_find_marked
      0.06 ± 77%      -0.0        0.05 ± 62%  perf-profile.children.cycles-pp.can_stop_idle_tick
      0.08 ± 53%      -0.0        0.07 ± 64%  perf-profile.children.cycles-pp.call_timer_fn
      0.06 ± 50%      -0.0        0.05 ± 86%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.04 ± 89%      -0.0        0.03 ±111%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.02 ±159%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.02 ±159%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.find_idlest_group
      0.03 ±163%      -0.0        0.02 ±180%  perf-profile.children.cycles-pp.xas_set_mark
      1.13 ± 10%      -0.0        1.13 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.03 ±123%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.hrtimer_run_queues
      0.05 ± 69%      -0.0        0.05 ± 85%  perf-profile.children.cycles-pp.ext4_update_bh_state
      0.03 ±118%      -0.0        0.03 ±133%  perf-profile.children.cycles-pp.inode_to_bdi
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.__slab_free
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.get_arg_page
      0.03 ±159%      -0.0        0.02 ±173%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.06 ± 76%      -0.0        0.05 ± 80%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.85 ± 23%      -0.0        0.84 ± 31%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.05 ±104%      -0.0        0.04 ±106%  perf-profile.children.cycles-pp.filemap_get_folios
      0.07 ± 55%      -0.0        0.07 ± 24%  perf-profile.children.cycles-pp.rcu_do_batch
      0.05 ± 68%      -0.0        0.05 ± 43%  perf-profile.children.cycles-pp.pipe_read
      0.21 ± 32%      -0.0        0.21 ± 19%  perf-profile.children.cycles-pp.process_interval
      0.02 ±116%      -0.0        0.02 ±173%  perf-profile.children.cycles-pp.get_next_seq_offset
      0.10 ± 26%      -0.0        0.10 ± 28%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.34 ± 11%      -0.0        0.34 ± 22%  perf-profile.children.cycles-pp.folio_add_lru
      0.05 ± 76%      -0.0        0.05 ± 81%  perf-profile.children.cycles-pp.enqueue_entity
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.poll_spurious_irqs
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.__get_user_pages
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.shuffle_freelist
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.get_cpu_sleep_time_us
      0.43 ±106%      -0.0        0.42 ±111%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.43 ±106%      -0.0        0.42 ±111%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.11 ± 39%      -0.0        0.10 ± 52%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.14 ± 44%      -0.0        0.14 ± 27%  perf-profile.children.cycles-pp.tick_program_event
      0.10 ± 53%      -0.0        0.09 ± 61%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.02 ±159%      -0.0        0.01 ±173%  perf-profile.children.cycles-pp.__xstat64
      0.08 ± 57%      -0.0        0.08 ± 61%  perf-profile.children.cycles-pp.add_clat_sample
      0.02 ±116%      -0.0        0.02 ±131%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.21 ± 32%      -0.0        0.21 ± 19%  perf-profile.children.cycles-pp.cmd_stat
      0.21 ± 32%      -0.0        0.21 ± 19%  perf-profile.children.cycles-pp.dispatch_events
      0.02 ±169%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.handle_edge_irq
      0.06 ± 49%      -0.0        0.06 ± 94%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.wake_up_new_task
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.clock_nanosleep
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.__msecs_to_jiffies
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.perf_swevent_stop
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.mas_destroy
      0.09 ± 61%      -0.0        0.09 ± 60%  perf-profile.children.cycles-pp.__mark_inode_dirty
      0.03 ±120%      -0.0        0.02 ±129%  perf-profile.children.cycles-pp.do_set_pte
      0.02 ±118%      -0.0        0.02 ±134%  perf-profile.children.cycles-pp.folio_mapping
      0.05 ±112%      -0.0        0.05 ± 64%  perf-profile.children.cycles-pp.timekeeping_update
      0.04 ± 65%      -0.0        0.04 ±107%  perf-profile.children.cycles-pp.balance_fair
      0.03 ±121%      -0.0        0.03 ±134%  perf-profile.children.cycles-pp.__vfork
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.__switch_to
      0.07 ± 47%      -0.0        0.07 ± 67%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.common_nsleep
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.children.cycles-pp.affine_move_task
      0.08 ± 27%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.menu_reflect
      0.07 ± 51%      -0.0        0.07 ± 75%  perf-profile.children.cycles-pp.newidle_balance
      0.02 ±161%      -0.0        0.02 ±137%  perf-profile.children.cycles-pp.do_anonymous_page
      0.09 ± 48%      -0.0        0.09 ± 30%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.06 ± 50%      -0.0        0.06 ± 44%  perf-profile.children.cycles-pp.elf_map
      0.16 ± 31%      +0.0        0.16 ± 27%  perf-profile.children.cycles-pp.release_pages
      0.19 ± 36%      +0.0        0.19 ± 39%  perf-profile.children.cycles-pp.do_fault
      0.32 ± 35%      +0.0        0.32 ± 23%  perf-profile.children.cycles-pp.mpage_prepare_extent_to_map
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.03 ±116%      +0.0        0.03 ±134%  perf-profile.children.cycles-pp.__count_memcg_events
      0.07 ± 90%      +0.0        0.07 ± 50%  perf-profile.children.cycles-pp.__pagevec_release
      0.08 ± 47%      +0.0        0.08 ± 36%  perf-profile.children.cycles-pp.nr_iowait_cpu
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.poll_idle
      0.02 ±166%      +0.0        0.02 ±173%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.12 ± 52%      +0.0        0.12 ± 32%  perf-profile.children.cycles-pp.__note_gp_changes
      0.05 ± 66%      +0.0        0.05 ± 62%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.children.cycles-pp.task_work_run
      0.02 ±158%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.children.cycles-pp.do_cow_fault
      0.12 ± 30%      +0.0        0.12 ± 47%  perf-profile.children.cycles-pp.copy_process
      0.52 ± 16%      +0.0        0.52 ± 21%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.08 ± 59%      +0.0        0.09 ± 49%  perf-profile.children.cycles-pp.__run_timers
      0.03 ±116%      +0.0        0.04 ±105%  perf-profile.children.cycles-pp.account_process_tick
      0.01 ±158%      +0.0        0.02 ±179%  perf-profile.children.cycles-pp.sync_regs
      0.04 ± 86%      +0.0        0.05 ± 67%  perf-profile.children.cycles-pp.rcu_all_qs
      0.03 ± 90%      +0.0        0.04 ± 81%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.02 ±116%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.drm_gem_check_release_pagevec
      0.07 ± 51%      +0.0        0.08 ± 68%  perf-profile.children.cycles-pp.xas_find_conflict
      0.02 ±172%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.04 ± 91%      +0.0        0.04 ± 60%  perf-profile.children.cycles-pp.drm_gem_vunmap_unlocked
      0.04 ± 91%      +0.0        0.04 ± 60%  perf-profile.children.cycles-pp.drm_gem_vunmap
      0.04 ± 91%      +0.0        0.04 ± 60%  perf-profile.children.cycles-pp.drm_gem_shmem_vunmap
      0.37 ± 18%      +0.0        0.38 ± 17%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.18 ± 21%      +0.0        0.18 ± 18%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.07 ± 26%      +0.0        0.07 ± 46%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.02 ±244%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.mas_split
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__d_alloc
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.children.cycles-pp.sched_clock_tick
      0.05 ± 68%      +0.0        0.05 ± 86%  perf-profile.children.cycles-pp.perf_event_mmap
      0.01 ±158%      +0.0        0.02 ±175%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.02 ±116%      +0.0        0.03 ±130%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.28 ± 16%      +0.0        0.28 ± 23%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.11 ± 27%      +0.0        0.12 ± 34%  perf-profile.children.cycles-pp.fault_in_readable
      0.01 ±244%      +0.0        0.02 ±176%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.01 ±244%      +0.0        0.01 ±174%  perf-profile.children.cycles-pp.vsnprintf
      0.01 ±244%      +0.0        0.01 ±174%  perf-profile.children.cycles-pp.__wake_up_common
      0.03 ±119%      +0.0        0.03 ±103%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.08 ± 29%      +0.0        0.08 ± 49%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.04 ± 89%      +0.0        0.04 ±113%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.04 ± 94%      +0.0        0.04 ± 81%  perf-profile.children.cycles-pp.__fget_light
      0.02 ±158%      +0.0        0.02 ±130%  perf-profile.children.cycles-pp.generic_write_checks
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.kernel_wait4
      0.08 ± 21%      +0.0        0.08 ± 53%  perf-profile.children.cycles-pp.begin_new_exec
      0.02 ±158%      +0.0        0.02 ±131%  perf-profile.children.cycles-pp.xas_create
      0.12 ± 25%      +0.0        0.12 ± 37%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.06 ± 90%      +0.0        0.06 ± 59%  perf-profile.children.cycles-pp.tick_nohz_stop_idle
      0.06 ± 71%      +0.0        0.06 ± 83%  perf-profile.children.cycles-pp.copy_strings
      0.02 ±244%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.utime_since_now
      0.20 ± 26%      +0.0        0.21 ± 20%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.08 ± 47%      +0.0        0.09 ± 45%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.02 ±160%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.02 ±158%      +0.0        0.02 ±137%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      0.02 ±163%      +0.0        0.02 ±133%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.01 ±244%      +0.0        0.01 ±174%  perf-profile.children.cycles-pp.mas_preallocate
      0.01 ±244%      +0.0        0.01 ±174%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.05 ± 73%      +0.0        0.05 ± 69%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.mas_walk
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.children.cycles-pp.move_queued_task
      0.02 ±159%      +0.0        0.02 ±182%  perf-profile.children.cycles-pp.free_pgtables
      0.07 ± 47%      +0.0        0.07 ± 53%  perf-profile.children.cycles-pp.evsel__read_counter
      0.02 ±164%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.mprotect_fixup
      1.71 ± 10%      +0.0        1.72 ± 11%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.03 ±117%      +0.0        0.04 ± 80%  perf-profile.children.cycles-pp.io_u_sync_complete
      0.01 ±244%      +0.0        0.02 ±173%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__mod_timer
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.acpi_ps_parse_loop
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__fxstat64
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.copy_page
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.getenv
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.perf_stat_process_counter
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__perf_event_read_value
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.dentry_kill
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.rcu_gp_init
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__send_signal_locked
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.complete_signal
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.memmove
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.process_counters
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.cpu_latency_qos_limit
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.fio_syncio_queue
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp._IO_setvbuf
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__kmalloc_node
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.flush_tlb_func
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.do_poll
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__mmdrop
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__x64_sys_poll
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.do_sys_poll
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.copy_page_range
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.copy_p4d_range
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__poll
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.perf_evlist__poll
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.security_file_alloc
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.setup_arg_pages
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.mas_push_data
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.printk_get_next_message
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.vfree
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.clear_page_erms
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.mutex_lock
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp._IO_file_xsputn
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__call_rcu_common
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.khugepaged
      0.03 ±117%      +0.0        0.03 ± 78%  perf-profile.children.cycles-pp.drm_gem_put_pages
      0.03 ±117%      +0.0        0.03 ± 78%  perf-profile.children.cycles-pp.drm_gem_shmem_put_pages_locked
      0.37 ± 20%      +0.0        0.38 ± 21%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.24 ± 12%      +0.0        0.25 ± 19%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.ct_irq_exit
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__fput
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.select_task_rq
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.find_vma
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.mt_find
      0.01 ±244%      +0.0        0.02 ±176%  perf-profile.children.cycles-pp.load_elf_interp
      0.01 ±244%      +0.0        0.02 ±176%  perf-profile.children.cycles-pp.tick_nohz_idle_retain_tick
      0.10 ± 25%      +0.0        0.10 ± 66%  perf-profile.children.cycles-pp.try_to_wake_up
      0.04 ± 91%      +0.0        0.05 ± 65%  perf-profile.children.cycles-pp.try_charge_memcg
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.io_u_mark_submit
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.diskstats_show
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.finish_task_switch
      0.01 ±244%      +0.0        0.02 ±173%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.17 ± 34%      +0.0        0.18 ± 26%  perf-profile.children.cycles-pp.arch_cpu_idle_exit
      0.18 ± 17%      +0.0        0.19 ± 29%  perf-profile.children.cycles-pp.call_cpuidle
      0.35 ± 16%      +0.0        0.36 ± 11%  perf-profile.children.cycles-pp.update_rq_clock
      0.03 ±117%      +0.0        0.04 ±108%  perf-profile.children.cycles-pp.wp_page_copy
      0.18 ± 30%      +0.0        0.19 ± 20%  perf-profile.children.cycles-pp.read_counters
      0.03 ± 88%      +0.0        0.04 ± 61%  perf-profile.children.cycles-pp.memset_orig
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.mutex_unlock
      0.05 ± 42%      +0.0        0.06 ± 88%  perf-profile.children.cycles-pp.exec_mmap
      0.01 ±244%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.megasas_isr_fusion
      0.01 ±244%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.complete_cmd_fusion
      0.01 ±244%      +0.0        0.02 ±182%  perf-profile.children.cycles-pp.task_tick_mm_cid
      0.23 ± 32%      +0.0        0.24 ± 18%  perf-profile.children.cycles-pp.__libc_start_main
      0.23 ± 32%      +0.0        0.24 ± 18%  perf-profile.children.cycles-pp.main
      0.23 ± 32%      +0.0        0.24 ± 18%  perf-profile.children.cycles-pp.run_builtin
      0.20 ± 27%      +0.0        0.21 ± 42%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.15 ± 46%      +0.0        0.16 ± 19%  perf-profile.children.cycles-pp._find_next_and_bit
      0.00            +0.0        0.01 ±264%  perf-profile.children.cycles-pp.rcu_preempt_deferred_qs
      0.05 ± 44%      +0.0        0.06 ± 43%  perf-profile.children.cycles-pp.update_group_capacity
      0.01 ±244%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.open_last_lookups
      0.01 ±244%      +0.0        0.02 ±173%  perf-profile.children.cycles-pp.__switch_to_asm
      0.04 ± 91%      +0.0        0.05 ± 86%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.04 ± 96%      +0.0        0.05 ± 62%  perf-profile.children.cycles-pp.mpage_process_folio
      0.01 ±244%      +0.0        0.02 ±185%  perf-profile.children.cycles-pp.swake_up_one
      0.05 ± 72%      +0.0        0.07 ± 70%  perf-profile.children.cycles-pp.memcg_alloc_slab_cgroups
      0.13 ± 25%      +0.0        0.14 ± 35%  perf-profile.children.cycles-pp.kernel_clone
      0.29 ± 35%      +0.0        0.30 ± 28%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.sched_clock_idle_wakeup_event
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.__alloc_file
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.pick_link
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.__legitimize_path
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.try_to_unlazy
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.__perf_sw_event
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.ext4_io_submit
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      0.00            +0.0        0.01 ±173%  perf-profile.children.cycles-pp.tick_nohz_get_next_hrtimer
      0.04 ± 93%      +0.0        0.05 ± 41%  perf-profile.children.cycles-pp.__fdget_pos
      0.01 ±244%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.01 ±244%      +0.0        0.02 ±129%  perf-profile.children.cycles-pp.xas_find
      0.07 ± 75%      +0.0        0.08 ± 49%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.25 ± 25%      +0.0        0.26 ± 82%  perf-profile.children.cycles-pp.get_io_u
      0.18 ± 28%      +0.0        0.20 ± 35%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.06 ± 64%      +0.0        0.08 ± 67%  perf-profile.children.cycles-pp.xas_store
      0.05 ± 76%      +0.0        0.06 ± 82%  perf-profile.children.cycles-pp.schedule_idle
      0.10 ± 51%      +0.0        0.12 ± 41%  perf-profile.children.cycles-pp.intel_pmu_disable_all
      0.01 ±244%      +0.0        0.02 ±181%  perf-profile.children.cycles-pp.cpuidle_not_available
      0.00            +0.0        0.01 ±174%  perf-profile.children.cycles-pp.do_open_execat
      0.37 ± 18%      +0.0        0.38 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.01 ±244%      +0.0        0.02 ±173%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.02 ±158%      +0.0        0.03 ±104%  perf-profile.children.cycles-pp.invoke_rcu_core
      0.06 ± 49%      +0.0        0.07 ± 55%  perf-profile.children.cycles-pp.raise_softirq
      0.03 ±172%      +0.0        0.04 ± 79%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.03 ±172%      +0.0        0.04 ± 79%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.08 ± 72%      +0.0        0.09 ± 52%  perf-profile.children.cycles-pp.sched_setaffinity
      0.03 ±117%      +0.0        0.04 ±107%  perf-profile.children.cycles-pp.dup_mmap
      0.02 ±159%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.48 ± 15%      +0.0        0.50 ± 21%  perf-profile.children.cycles-pp.update_blocked_averages
      0.00            +0.0        0.02 ±173%  perf-profile.children.cycles-pp.perf_read
      0.00            +0.0        0.02 ±173%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.00            +0.0        0.02 ±176%  perf-profile.children.cycles-pp.__bio_try_merge_page
      0.00            +0.0        0.02 ±176%  perf-profile.children.cycles-pp.folio_mkclean
      0.20 ± 20%      +0.0        0.22 ± 23%  perf-profile.children.cycles-pp.idle_cpu
      0.09 ± 47%      +0.0        0.10 ± 56%  perf-profile.children.cycles-pp.__do_sys_clone
      0.06 ± 73%      +0.0        0.07 ± 45%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.01 ±244%      +0.0        0.02 ±137%  perf-profile.children.cycles-pp.create_elf_tables
      0.05 ± 65%      +0.0        0.07 ± 60%  perf-profile.children.cycles-pp.mod_objcg_state
      0.18 ± 28%      +0.0        0.20 ± 35%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.0        0.02 ±179%  perf-profile.children.cycles-pp.perf_evsel__read
      0.01 ±244%      +0.0        0.02 ±132%  perf-profile.children.cycles-pp.profile_tick
      0.01 ±244%      +0.0        0.02 ±133%  perf-profile.children.cycles-pp.restore_regs_and_return_to_kernel
      0.11 ± 28%      +0.0        0.12 ± 30%  perf-profile.children.cycles-pp.rb_erase
      0.02 ±159%      +0.0        0.03 ±136%  perf-profile.children.cycles-pp.bio_add_folio
      0.05 ± 96%      +0.0        0.06 ± 68%  perf-profile.children.cycles-pp.filename_lookup
      0.05 ± 96%      +0.0        0.06 ± 68%  perf-profile.children.cycles-pp.path_lookupat
      0.01 ±158%      +0.0        0.03 ±106%  perf-profile.children.cycles-pp.mtree_range_walk
      0.04 ±189%      +0.0        0.06 ±192%  perf-profile.children.cycles-pp.delay_tsc
      0.01 ±244%      +0.0        0.03 ±138%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.36 ± 13%      +0.0        0.38 ± 17%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.04 ± 64%      +0.0        0.06 ± 66%  perf-profile.children.cycles-pp.kmem_cache_free
      0.08 ± 53%      +0.0        0.10 ± 54%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.03 ±158%      +0.0        0.05 ± 85%  perf-profile.children.cycles-pp.vfs_statx
      0.07 ± 76%      +0.0        0.09 ± 36%  perf-profile.children.cycles-pp.__mmap
      0.41 ± 24%      +0.0        0.43 ± 19%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.41 ± 24%      +0.0        0.43 ± 19%  perf-profile.children.cycles-pp.do_execveat_common
      0.00            +0.0        0.02 ±174%  perf-profile.children.cycles-pp.__pthread_enable_asynccancel
      0.00            +0.0        0.02 ±129%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.05 ± 88%      +0.0        0.07 ± 69%  perf-profile.children.cycles-pp.dup_mm
      0.06 ± 44%      +0.0        0.08 ± 49%  perf-profile.children.cycles-pp._dl_addr
      0.14 ± 30%      +0.0        0.16 ± 34%  perf-profile.children.cycles-pp.exit_mm
      0.06 ± 72%      +0.0        0.08 ± 45%  perf-profile.children.cycles-pp.zap_pmd_range
      0.01 ±244%      +0.0        0.03 ±104%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.25 ± 25%      +0.0        0.27 ± 17%  perf-profile.children.cycles-pp.timerqueue_del
      0.14 ± 32%      +0.0        0.16 ± 39%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.02 ±158%      +0.0        0.05 ± 78%  perf-profile.children.cycles-pp.__lookup_slow
      0.16 ± 31%      +0.0        0.18 ± 52%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.0        0.02 ±173%  perf-profile.children.cycles-pp.unmap_region
      0.07 ± 48%      +0.0        0.09 ± 61%  perf-profile.children.cycles-pp.walk_component
      0.01 ±244%      +0.0        0.04 ±113%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.17 ± 28%      +0.0        0.20 ± 35%  perf-profile.children.cycles-pp.do_exit
      0.03 ± 87%      +0.0        0.06 ± 81%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.02 ±244%      +0.0        0.04 ± 59%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.30 ± 35%      +0.0        0.32 ± 25%  perf-profile.children.cycles-pp.handle_mm_fault
      0.03 ±163%      +0.0        0.05 ± 59%  perf-profile.children.cycles-pp.mod_zone_page_state
      0.11 ± 33%      +0.0        0.14 ± 40%  perf-profile.children.cycles-pp.__libc_fork
      0.01 ±244%      +0.0        0.04 ± 79%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.01 ±244%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.d_alloc
      0.11 ± 46%      +0.0        0.13 ± 41%  perf-profile.children.cycles-pp.link_path_walk
      0.40 ± 26%      +0.0        0.43 ± 19%  perf-profile.children.cycles-pp.execve
      0.07 ± 50%      +0.0        0.10 ± 40%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.0        0.03 ±100%  perf-profile.children.cycles-pp.___perf_sw_event
      0.01 ±244%      +0.0        0.03 ±104%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.01 ±158%      +0.0        0.04 ±107%  perf-profile.children.cycles-pp.lookup_fast
      0.01 ±244%      +0.0        0.04 ± 88%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.00            +0.0        0.03 ±102%  perf-profile.children.cycles-pp.__vm_munmap
      2.04 ± 13%      +0.0        2.07 ± 24%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.06 ± 72%      +0.0        0.09 ± 44%  perf-profile.children.cycles-pp.unmap_page_range
      0.02 ±161%      +0.0        0.05 ± 63%  perf-profile.children.cycles-pp.td_io_prep
      0.10 ± 32%      +0.0        0.13 ± 22%  perf-profile.children.cycles-pp.rb_next
      0.04 ±125%      +0.0        0.07 ± 53%  perf-profile.children.cycles-pp.vfs_fstatat
      0.25 ± 21%      +0.0        0.28 ± 25%  perf-profile.children.cycles-pp.exec_binprm
      0.03 ±117%      +0.0        0.06 ± 73%  perf-profile.children.cycles-pp._find_next_bit
      0.01 ±158%      +0.0        0.04 ±107%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.38 ± 14%      +0.0        0.41 ± 15%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.40 ± 21%      +0.0        0.43 ± 11%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.04 ±125%      +0.0        0.07 ± 54%  perf-profile.children.cycles-pp.__do_sys_newstat
      0.21 ± 24%      +0.0        0.24 ± 19%  perf-profile.children.cycles-pp.irqentry_exit
      1.21 ± 12%      +0.0        1.24 ± 14%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.05 ± 42%      +0.0        0.08 ± 37%  perf-profile.children.cycles-pp.ct_nmi_exit
      0.02 ±118%      +0.0        0.06 ± 64%  perf-profile.children.cycles-pp.pipe_write
      1.18 ±  9%      +0.0        1.21 ± 13%  perf-profile.children.cycles-pp.perf_rotate_context
      0.24 ± 14%      +0.0        0.27 ± 23%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      1.82 ±  6%      +0.0        1.85 ± 12%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.07 ± 77%      +0.0        0.10 ± 44%  perf-profile.children.cycles-pp.unmap_vmas
      0.11 ± 56%      +0.0        0.14 ± 23%  perf-profile.children.cycles-pp.charge_memcg
      0.18 ± 34%      +0.0        0.22 ± 16%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.24 ± 22%      +0.0        0.28 ± 25%  perf-profile.children.cycles-pp.search_binary_handler
      0.03 ± 88%      +0.0        0.06 ± 88%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.13 ± 13%      +0.0        1.16 ± 12%  perf-profile.children.cycles-pp.note_gp_changes
      0.06 ± 42%      +0.0        0.09 ± 52%  perf-profile.children.cycles-pp.write
      0.28 ± 22%      +0.0        0.31 ± 19%  perf-profile.children.cycles-pp.bprm_execve
      0.16 ± 27%      +0.0        0.19 ± 28%  perf-profile.children.cycles-pp.error_entry
      0.05 ± 91%      +0.0        0.08 ± 45%  perf-profile.children.cycles-pp.zap_pte_range
      0.18 ± 28%      +0.0        0.21 ± 36%  perf-profile.children.cycles-pp.__mmput
      0.18 ± 30%      +0.0        0.21 ± 36%  perf-profile.children.cycles-pp.exit_mmap
      0.08 ± 49%      +0.0        0.11 ± 22%  perf-profile.children.cycles-pp.mpage_process_page_bufs
      0.34 ± 18%      +0.0        0.38 ± 19%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.21 ± 30%      +0.0        0.25 ± 23%  perf-profile.children.cycles-pp.irq_work_tick
      0.24 ± 23%      +0.0        0.27 ± 25%  perf-profile.children.cycles-pp.load_elf_binary
      0.26 ± 27%      +0.0        0.30 ± 19%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.01 ±244%      +0.0        0.05 ± 83%  perf-profile.children.cycles-pp.update_dl_rq_load_avg
      0.21 ± 26%      +0.0        0.25 ± 19%  perf-profile.children.cycles-pp.ct_nmi_enter
      0.07 ± 53%      +0.0        0.12 ± 32%  perf-profile.children.cycles-pp.sched_clock
      0.01 ±244%      +0.0        0.05 ± 93%  perf-profile.children.cycles-pp.strnlen_user
      0.20 ± 36%      +0.0        0.24 ± 39%  perf-profile.children.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.07 ± 48%      +0.0        0.11 ± 33%  perf-profile.children.cycles-pp.tick_nohz_tick_stopped
      0.03 ±118%      +0.0        0.08 ± 40%  perf-profile.children.cycles-pp.__libc_read
      0.07 ± 68%      +0.0        0.12 ± 51%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.03 ±118%      +0.0        0.08 ± 39%  perf-profile.children.cycles-pp.readn
      0.26 ± 30%      +0.0        0.31 ± 53%  perf-profile.children.cycles-pp.calc_global_load_tick
      0.02 ±116%      +0.1        0.07 ± 48%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.08 ± 41%      +0.1        0.13 ± 29%  perf-profile.children.cycles-pp.rb_insert_color
      0.08 ± 68%      +0.1        0.14 ± 42%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.wb_workfn
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.wb_do_writeback
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.wb_writeback
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.writeback_sb_inodes
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.__writeback_single_inode
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.do_writepages
      1.37 ± 27%      +0.1        1.43 ± 14%  perf-profile.children.cycles-pp.mpage_map_and_submit_extent
      1.05 ±  9%      +0.1        1.10 ± 20%  perf-profile.children.cycles-pp.lapic_next_deadline
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.ext4_writepages
      1.71 ± 26%      +0.1        1.77 ±  8%  perf-profile.children.cycles-pp.ext4_do_writepages
      1.37 ± 27%      +0.1        1.43 ± 14%  perf-profile.children.cycles-pp.mpage_map_and_submit_buffers
      0.28 ± 18%      +0.1        0.34 ± 17%  perf-profile.children.cycles-pp.irqentry_enter
      1.16 ± 22%      +0.1        1.22 ± 15%  perf-profile.children.cycles-pp.mpage_submit_folio
      0.15 ± 33%      +0.1        0.23 ± 73%  perf-profile.children.cycles-pp.trigger_load_balance
      0.28 ± 18%      +0.1        0.36 ± 14%  perf-profile.children.cycles-pp.get_cpu_device
      0.08 ± 61%      +0.1        0.16 ±137%  perf-profile.children.cycles-pp.td_io_queue
      0.33 ± 30%      +0.1        0.41 ± 22%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.26 ± 21%      +0.1        0.34 ± 23%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      0.39 ± 27%      +0.1        0.47 ± 21%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.33 ± 30%      +0.1        0.42 ± 20%  perf-profile.children.cycles-pp.exc_page_fault
      0.26 ±130%      +0.1        0.35 ±126%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.26 ±130%      +0.1        0.35 ±125%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.20 ±168%      +0.1        0.29 ±155%  perf-profile.children.cycles-pp.commit_tail
      0.20 ±168%      +0.1        0.29 ±155%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.26 ±130%      +0.1        0.35 ±124%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.18 ±174%      +0.1        0.28 ±158%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.18 ±174%      +0.1        0.28 ±158%  perf-profile.children.cycles-pp.memcpy_toio
      0.18 ±174%      +0.1        0.28 ±158%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.18 ±174%      +0.1        0.28 ±158%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.18 ±174%      +0.1        0.28 ±158%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      1.41 ± 12%      +0.1        1.52 ± 12%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.31 ± 17%      +0.1        0.42 ± 17%  perf-profile.children.cycles-pp.enqueue_hrtimer
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.children.cycles-pp.x86_64_start_kernel
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.children.cycles-pp.x86_64_start_reservations
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.children.cycles-pp.start_kernel
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.children.cycles-pp.arch_call_rest_init
      1.38 ± 15%      +0.1        1.50 ± 13%  perf-profile.children.cycles-pp.rest_init
      0.22 ± 27%      +0.1        0.35 ± 23%  perf-profile.children.cycles-pp.timerqueue_add
      0.41 ± 18%      +0.2        0.56 ± 15%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      2.50 ±  6%      +0.3        2.78 ±  6%  perf-profile.children.cycles-pp.menu_select
      7.09 ±  8%      +0.5        7.55 ± 16%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
     17.07 ±  3%      +0.5       17.59 ±  7%  perf-profile.children.cycles-pp.tick_sched_timer
     20.04 ±  2%      +0.7       20.78 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
     24.95 ±  2%      +0.8       25.71 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
     24.17 ±  2%      +0.8       24.94 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      9.83 ±  6%      +0.8       10.62 ± 12%  perf-profile.children.cycles-pp.perf_event_task_tick
      9.75 ±  6%      +0.8       10.56 ± 11%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
     15.37 ±  5%      +0.9       16.24 ±  7%  perf-profile.children.cycles-pp.tick_sched_handle
     15.23 ±  5%      +0.9       16.10 ±  7%  perf-profile.children.cycles-pp.update_process_times
     71.39 ±  2%      +0.9       72.26        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     12.98 ±  5%      +0.9       13.86 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
     78.42 ±  2%      +1.4       79.87        perf-profile.children.cycles-pp.cpuidle_enter_state
     78.74 ±  2%      +1.5       80.20        perf-profile.children.cycles-pp.cpuidle_enter
     77.36 ±  2%      +1.5       78.85        perf-profile.children.cycles-pp.acpi_idle_enter
     77.19 ±  2%      +1.5       78.72        perf-profile.children.cycles-pp.acpi_safe_halt
     81.47 ±  2%      +1.6       83.10        perf-profile.children.cycles-pp.start_secondary
     82.22            +1.7       83.92        perf-profile.children.cycles-pp.cpuidle_idle_call
     82.85            +1.7       84.59        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     82.85            +1.7       84.59        perf-profile.children.cycles-pp.cpu_startup_entry
     82.85            +1.7       84.59        perf-profile.children.cycles-pp.do_idle
      3.71 ± 55%      -1.0        2.69 ± 59%  perf-profile.self.cycles-pp.ktime_get
      1.78 ± 12%      -0.3        1.44 ± 14%  perf-profile.self.cycles-pp.__block_commit_write
      1.64 ± 10%      -0.3        1.33 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.91 ±  9%      -0.1        0.80 ± 15%  perf-profile.self.cycles-pp.native_sched_clock
      0.58 ± 60%      -0.1        0.47 ± 43%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.91 ± 21%      -0.1        0.80 ± 12%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.48 ± 17%      -0.1        0.39 ± 22%  perf-profile.self.cycles-pp.copyin
      0.38 ± 14%      -0.1        0.30 ± 31%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.63 ± 19%      -0.1        0.54 ± 32%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.02 ± 10%      -0.1        0.94 ± 10%  perf-profile.self.cycles-pp._raw_spin_lock
      0.40 ± 29%      -0.1        0.34 ± 16%  perf-profile.self.cycles-pp.fio_gettime
      0.77 ±  8%      -0.1        0.71 ± 17%  perf-profile.self.cycles-pp.rcu_pending
      0.15 ± 35%      -0.1        0.08 ± 50%  perf-profile.self.cycles-pp.thread_main
      1.16 ± 11%      -0.1        1.10 ± 12%  perf-profile.self.cycles-pp.read_tsc
      0.30 ± 14%      -0.1        0.25 ± 22%  perf-profile.self.cycles-pp.xas_descend
      0.14 ± 25%      -0.1        0.09 ± 43%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.24 ± 26%      -0.0        0.19 ± 29%  perf-profile.self.cycles-pp.get_io_u
      0.08 ± 53%      -0.0        0.04 ±100%  perf-profile.self.cycles-pp.account_io_completion
      0.06 ± 45%      -0.0        0.02 ±176%  perf-profile.self.cycles-pp.irq_work_run_list
      0.13 ± 37%      -0.0        0.08 ± 47%  perf-profile.self.cycles-pp.rcu_core
      0.27 ±160%      -0.0        0.22 ±176%  perf-profile.self.cycles-pp.io_serial_in
      0.18 ± 13%      -0.0        0.14 ± 39%  perf-profile.self.cycles-pp.xas_load
      0.09 ± 49%      -0.0        0.05 ± 87%  perf-profile.self.cycles-pp.__libc_write
      0.07 ± 50%      -0.0        0.03 ±134%  perf-profile.self.cycles-pp.node_dirty_ok
      0.09 ± 67%      -0.0        0.06 ±120%  perf-profile.self.cycles-pp.timekeeping_advance
      0.14 ± 34%      -0.0        0.10 ± 26%  perf-profile.self.cycles-pp.acpi_idle_enter
      0.12 ± 27%      -0.0        0.09 ± 24%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.08 ± 48%      -0.0        0.04 ± 78%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.11 ± 40%      -0.0        0.07 ± 51%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.09 ± 71%      -0.0        0.06 ± 84%  perf-profile.self.cycles-pp.__cond_resched
      0.03 ± 91%      -0.0        0.00        perf-profile.self.cycles-pp.ksys_write
      0.04 ± 91%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.up_write
      0.09 ± 62%      -0.0        0.06 ± 63%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.37 ± 21%      -0.0        0.34 ± 31%  perf-profile.self.cycles-pp.block_write_end
      0.10 ± 39%      -0.0        0.07 ± 42%  perf-profile.self.cycles-pp.folio_unlock
      0.13 ± 36%      -0.0        0.10 ± 45%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.50 ± 19%      -0.0        0.47 ± 14%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.14 ± 48%      -0.0        0.11 ± 36%  perf-profile.self.cycles-pp.vfs_write
      0.07 ± 64%      -0.0        0.04 ± 93%  perf-profile.self.cycles-pp.xas_start
      0.09 ± 44%      -0.0        0.06 ± 71%  perf-profile.self.cycles-pp.clockevents_program_event
      0.10 ± 51%      -0.0        0.07 ± 47%  perf-profile.self.cycles-pp.timerqueue_del
      0.05 ± 44%      -0.0        0.03 ±144%  perf-profile.self.cycles-pp.ct_kernel_exit
      0.03 ± 87%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.irqentry_exit
      0.08 ± 29%      -0.0        0.05 ± 64%  perf-profile.self.cycles-pp.cpuidle_reflect
      0.10 ± 39%      -0.0        0.08 ± 66%  perf-profile.self.cycles-pp.folio_end_writeback
      0.05 ±106%      -0.0        0.02 ±129%  perf-profile.self.cycles-pp.ct_idle_exit
      0.39 ± 17%      -0.0        0.36 ± 18%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.11 ± 42%      -0.0        0.09 ± 65%  perf-profile.self.cycles-pp.tick_check_broadcast_expired
      0.02 ±116%      -0.0        0.00        perf-profile.self.cycles-pp.folio_memcg_unlock
      0.03 ± 87%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.03 ±116%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.run_rebalance_domains
      0.18 ± 26%      -0.0        0.16 ± 29%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.08 ± 50%      -0.0        0.06 ± 46%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.04 ± 94%      -0.0        0.02 ±179%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.05 ±120%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.generic_write_end
      0.09 ± 44%      -0.0        0.06 ± 42%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.14 ± 11%      -0.0        0.12 ± 39%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.69 ± 11%      -0.0        0.67 ± 13%  perf-profile.self.cycles-pp.native_apic_msr_eoi_write
      0.04 ± 96%      -0.0        0.02 ±173%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.05 ± 91%      -0.0        0.03 ±132%  perf-profile.self.cycles-pp.down_write
      0.07 ± 67%      -0.0        0.05 ± 78%  perf-profile.self.cycles-pp.folio_add_lru
      0.35 ± 24%      -0.0        0.33 ± 16%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.07 ± 18%      -0.0        0.05 ± 84%  perf-profile.self.cycles-pp.add_lat_sample
      0.02 ±163%      -0.0        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.03 ±117%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.filemap_get_entry
      0.04 ± 89%      -0.0        0.02 ±129%  perf-profile.self.cycles-pp.acpi_os_read_port
      0.06 ± 49%      -0.0        0.04 ± 84%  perf-profile.self.cycles-pp.filemap_get_folios_tag
      0.03 ±120%      -0.0        0.01 ±173%  perf-profile.self.cycles-pp.hrtimer_run_queues
      0.18 ± 32%      -0.0        0.17 ± 17%  perf-profile.self.cycles-pp.ext4_da_get_block_prep
      0.06 ± 71%      -0.0        0.04 ± 87%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.06 ± 74%      -0.0        0.04 ± 88%  perf-profile.self.cycles-pp.io_completed
      0.13 ± 33%      -0.0        0.11 ± 32%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.02 ±159%      -0.0        0.00        perf-profile.self.cycles-pp.__memcpy
      0.02 ±159%      -0.0        0.00        perf-profile.self.cycles-pp.ramp_time_over
      0.02 ±159%      -0.0        0.00        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.02 ±159%      -0.0        0.00        perf-profile.self.cycles-pp.evlist__id2evsel
      0.02 ±159%      -0.0        0.00        perf-profile.self.cycles-pp.in_ramp_time
      0.03 ±122%      -0.0        0.02 ±175%  perf-profile.self.cycles-pp.__get_io_u
      0.21 ± 18%      -0.0        0.20 ± 19%  perf-profile.self.cycles-pp.scheduler_tick
      0.01 ±158%      -0.0        0.00        perf-profile.self.cycles-pp.pipe_read
      0.04 ± 91%      -0.0        0.03 ±129%  perf-profile.self.cycles-pp.xas_find_marked
      0.06 ± 49%      -0.0        0.05 ± 87%  perf-profile.self.cycles-pp.next_uptodate_page
      0.04 ±142%      -0.0        0.03 ±104%  perf-profile.self.cycles-pp.update_vsyscall
      0.08 ± 51%      -0.0        0.07 ± 51%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.04 ±121%      -0.0        0.02 ±133%  perf-profile.self.cycles-pp.io_queue_event
      0.09 ± 60%      -0.0        0.08 ± 52%  perf-profile.self.cycles-pp.hrtimer_next_event_without
      0.10 ± 23%      -0.0        0.08 ± 50%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.10 ± 36%      -0.0        0.08 ± 34%  perf-profile.self.cycles-pp.hrtimer_forward
      0.03 ±115%      -0.0        0.02 ±173%  perf-profile.self.cycles-pp.tick_nohz_stop_idle
      0.35 ± 12%      -0.0        0.34 ± 27%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_report_qs_rnp
      0.08 ± 65%      -0.0        0.07 ± 45%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.04 ±121%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.02 ±159%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.check_move_unevictable_folios
      0.03 ±119%      -0.0        0.02 ±132%  perf-profile.self.cycles-pp.can_stop_idle_tick
      0.03 ± 87%      -0.0        0.02 ±132%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.08 ± 55%      -0.0        0.07 ± 78%  perf-profile.self.cycles-pp.add_clat_sample
      0.11 ± 26%      -0.0        0.10 ± 43%  perf-profile.self.cycles-pp.fault_in_readable
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.read_counters
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.mas_wr_node_store
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp._copy_from_user
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.apparmor_file_permission
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.log_io_u
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.policy_node
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.refill_obj_stock
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.cpuidle_select
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.__folio_mark_dirty
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.ntime_since
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp._IO_fwrite
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.current_time
      0.01 ±158%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp._raw_read_lock
      0.03 ± 87%      -0.0        0.03 ±130%  perf-profile.self.cycles-pp.filemap_map_pages
      0.06 ± 44%      -0.0        0.05 ± 62%  perf-profile.self.cycles-pp.folio_account_dirtied
      0.41 ± 22%      -0.0        0.40 ± 14%  perf-profile.self.cycles-pp.check_cpu_stall
      0.08 ± 68%      -0.0        0.07 ± 22%  perf-profile.self.cycles-pp.enqueue_hrtimer
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.filemap_add_folio
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.get_start_offset
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.io_bytes_exceeded
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.put_io_u
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.security_file_permission
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.workingset_update_node
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.do_syscall_64
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.get_cpu_sleep_time_us
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.tick_nohz_idle_got_tick
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.__file_remove_privs
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp._find_first_bit
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.01 ±244%      -0.0        0.00        perf-profile.self.cycles-pp.__update_load_avg_se
      0.54 ± 11%      -0.0        0.53 ± 13%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.02 ±159%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.02 ±167%      -0.0        0.02 ±175%  perf-profile.self.cycles-pp.xas_set_mark
      0.02 ±169%      -0.0        0.02 ±176%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.02 ±115%      -0.0        0.02 ±176%  perf-profile.self.cycles-pp.sched_idle_set_state
      0.09 ± 57%      -0.0        0.08 ± 23%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.06 ± 50%      -0.0        0.05 ± 87%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.07 ± 39%      -0.0        0.07 ± 65%  perf-profile.self.cycles-pp.generic_perform_write
      0.04 ±144%      -0.0        0.04 ±104%  perf-profile.self.cycles-pp.mpage_prepare_extent_to_map
      0.05 ± 69%      -0.0        0.05 ± 85%  perf-profile.self.cycles-pp.ext4_update_bh_state
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.__slab_free
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.alloc_pages
      0.07 ± 68%      -0.0        0.07 ± 45%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.07 ± 50%      -0.0        0.07 ± 52%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.08 ± 24%      -0.0        0.08 ± 52%  perf-profile.self.cycles-pp.folio_create_empty_buffers
      0.09 ± 23%      -0.0        0.09 ± 28%  perf-profile.self.cycles-pp.lru_add_fn
      0.03 ±115%      -0.0        0.03 ±130%  perf-profile.self.cycles-pp.account_process_tick
      0.06 ± 67%      -0.0        0.06 ± 69%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.02 ±163%      -0.0        0.02 ±176%  perf-profile.self.cycles-pp.folio_alloc_buffers
      0.15 ± 28%      -0.0        0.14 ± 21%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.04 ±117%      -0.0        0.04 ± 82%  perf-profile.self.cycles-pp.xas_clear_mark
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.acpi_idle_do_entry
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.generic_write_checks
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.update_group_capacity
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.__bitmap_and
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.xas_create
      0.02 ±161%      -0.0        0.02 ±176%  perf-profile.self.cycles-pp.node_page_state
      0.07 ± 74%      -0.0        0.07 ± 60%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.23 ± 12%      -0.0        0.23 ± 17%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.04 ± 97%      -0.0        0.04 ± 81%  perf-profile.self.cycles-pp.update_blocked_averages
      0.16 ± 42%      -0.0        0.16 ± 24%  perf-profile.self.cycles-pp.hrtimer_interrupt
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.__switch_to
      0.07 ± 67%      -0.0        0.07 ± 65%  perf-profile.self.cycles-pp.rmqueue
      0.01 ±244%      -0.0        0.01 ±264%  perf-profile.self.cycles-pp.mpage_map_and_submit_buffers
      0.02 ±159%      -0.0        0.02 ±176%  perf-profile.self.cycles-pp.get_next_seq_offset
      0.17 ± 14%      -0.0        0.17 ± 28%  perf-profile.self.cycles-pp.call_cpuidle
      0.30 ± 19%      -0.0        0.30 ± 21%  perf-profile.self.cycles-pp.do_idle
      0.04 ±144%      -0.0        0.04 ± 81%  perf-profile.self.cycles-pp.__alloc_pages
      0.05 ± 64%      -0.0        0.05 ± 85%  perf-profile.self.cycles-pp.intel_pmu_disable_all
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.02 ±159%      +0.0        0.02 ±173%  perf-profile.self.cycles-pp.io_u_sync_complete
      0.01 ±244%      +0.0        0.01 ±174%  perf-profile.self.cycles-pp.utime_since_now
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.self.cycles-pp.hrtimer_get_next_event
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.self.cycles-pp.poll_idle
      0.06 ± 45%      +0.0        0.06 ± 69%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.05 ± 96%      +0.0        0.05 ± 63%  perf-profile.self.cycles-pp.local_clock
      0.04 ± 94%      +0.0        0.04 ± 79%  perf-profile.self.cycles-pp.__fget_light
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.self.cycles-pp.kmem_cache_free
      0.02 ±163%      +0.0        0.02 ±129%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.self.cycles-pp.arch_cpu_idle_exit
      0.12 ± 31%      +0.0        0.12 ± 29%  perf-profile.self.cycles-pp.ext4_finish_bio
      0.01 ±244%      +0.0        0.01 ±264%  perf-profile.self.cycles-pp.task_tick_mm_cid
      0.01 ±158%      +0.0        0.02 ±179%  perf-profile.self.cycles-pp.sync_regs
      0.26 ± 27%      +0.0        0.26 ± 19%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.05 ± 71%      +0.0        0.05 ± 86%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.22 ± 24%      +0.0        0.22 ± 14%  perf-profile.self.cycles-pp.perf_pmu_nop_void
      0.03 ±178%      +0.0        0.03 ±104%  perf-profile.self.cycles-pp.filemap_get_folios
      0.02 ±116%      +0.0        0.03 ±130%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.03 ± 88%      +0.0        0.04 ± 81%  perf-profile.self.cycles-pp.memset_orig
      0.18 ± 35%      +0.0        0.18 ± 17%  perf-profile.self.cycles-pp.ext4_bio_write_folio
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.self.cycles-pp.inode_to_bdi
      0.01 ±244%      +0.0        0.01 ±173%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.04 ±117%      +0.0        0.04 ± 79%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      1.88 ± 13%      +0.0        1.88 ± 27%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.12 ± 45%      +0.0        0.13 ± 26%  perf-profile.self.cycles-pp.tick_program_event
      0.01 ±158%      +0.0        0.02 ±173%  perf-profile.self.cycles-pp.rcu_all_qs
      0.04 ± 88%      +0.0        0.04 ± 81%  perf-profile.self.cycles-pp.rcu_report_qs_rdp
      0.01 ±244%      +0.0        0.01 ±174%  perf-profile.self.cycles-pp.profile_tick
      0.01 ±244%      +0.0        0.01 ±174%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.10 ± 48%      +0.0        0.10 ± 36%  perf-profile.self.cycles-pp.__note_gp_changes
      0.14 ± 39%      +0.0        0.15 ± 33%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.link_path_walk
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.try_to_wake_up
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__xa_set_mark
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__count_memcg_events
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__tlb_remove_page_size
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.copy_page
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.timer_clear_idle
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.tick_sched_handle
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.evsel__read_counter
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.fio_syncio_queue
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.perf_event_mmap_output
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.vsnprintf
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.tick_nohz_get_next_hrtimer
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.bio_add_folio
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__fprop_add_percpu
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.clear_page_erms
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.mutex_lock
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp._IO_file_xsputn
      0.17 ± 19%      +0.0        0.17 ± 26%  perf-profile.self.cycles-pp.__folio_start_writeback
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.12 ± 49%      +0.0        0.13 ± 22%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.06 ± 49%      +0.0        0.06 ± 59%  perf-profile.self.cycles-pp.raise_softirq
      0.01 ±244%      +0.0        0.02 ±176%  perf-profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
      0.01 ±244%      +0.0        0.02 ±176%  perf-profile.self.cycles-pp.restore_regs_and_return_to_kernel
      0.01 ±244%      +0.0        0.02 ±176%  perf-profile.self.cycles-pp.tick_nohz_idle_retain_tick
      0.13 ± 29%      +0.0        0.14 ± 31%  perf-profile.self.cycles-pp.release_pages
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.io_u_mark_submit
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.01 ±244%      +0.0        0.02 ±175%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.08 ± 47%      +0.0        0.09 ± 45%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.04 ± 96%      +0.0        0.05 ± 63%  perf-profile.self.cycles-pp.mpage_process_folio
      0.03 ± 88%      +0.0        0.04 ± 59%  perf-profile.self.cycles-pp.menu_reflect
      0.01 ±244%      +0.0        0.02 ±188%  perf-profile.self.cycles-pp.cpuidle_not_available
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.tick_nohz_irq_exit
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.mutex_unlock
      0.01 ±244%      +0.0        0.02 ±175%  perf-profile.self.cycles-pp.__schedule
      0.13 ± 35%      +0.0        0.14 ± 43%  perf-profile.self.cycles-pp.folio_clear_dirty_for_io
      0.10 ± 49%      +0.0        0.11 ± 36%  perf-profile.self.cycles-pp.__sysvec_apic_timer_interrupt
      0.02 ±159%      +0.0        0.03 ±130%  perf-profile.self.cycles-pp.__radix_tree_lookup
      1.71 ± 10%      +0.0        1.72 ± 11%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.02 ±158%      +0.0        0.03 ±101%  perf-profile.self.cycles-pp.try_charge_memcg
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.fio_io_end
      0.00            +0.0        0.01 ±264%  perf-profile.self.cycles-pp.rcu_preempt_deferred_qs
      0.02 ±158%      +0.0        0.03 ±108%  perf-profile.self.cycles-pp.xas_find_conflict
      0.01 ±244%      +0.0        0.02 ±173%  perf-profile.self.cycles-pp.__switch_to_asm
      0.19 ± 23%      +0.0        0.20 ± 21%  perf-profile.self.cycles-pp.idle_cpu
      0.31 ± 20%      +0.0        0.32 ± 20%  perf-profile.self.cycles-pp.cpuidle_enter
      0.04 ± 93%      +0.0        0.05 ± 88%  perf-profile.self.cycles-pp.memcg_alloc_slab_cgroups
      0.00            +0.0        0.01 ±173%  perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.11 ± 21%      +0.0        0.13 ± 16%  perf-profile.self.cycles-pp.update_rq_clock
      0.00            +0.0        0.01 ±174%  perf-profile.self.cycles-pp.xas_find
      0.11 ± 34%      +0.0        0.12 ± 27%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.14 ± 46%      +0.0        0.16 ± 20%  perf-profile.self.cycles-pp._find_next_and_bit
      0.00            +0.0        0.02 ±176%  perf-profile.self.cycles-pp.__bio_try_merge_page
      0.00            +0.0        0.02 ±176%  perf-profile.self.cycles-pp.folio_mkclean
      0.01 ±244%      +0.0        0.02 ±130%  perf-profile.self.cycles-pp.file_modified_flags
      0.01 ±244%      +0.0        0.02 ±134%  perf-profile.self.cycles-pp.folio_mapping
      0.00            +0.0        0.02 ±179%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.01 ±244%      +0.0        0.02 ±132%  perf-profile.self.cycles-pp.invoke_rcu_core
      0.06 ± 44%      +0.0        0.07 ± 54%  perf-profile.self.cycles-pp._dl_addr
      0.01 ±158%      +0.0        0.03 ±106%  perf-profile.self.cycles-pp.mtree_range_walk
      0.03 ± 87%      +0.0        0.05 ± 80%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.0        0.02 ±175%  perf-profile.self.cycles-pp.error_return
      0.00            +0.0        0.02 ±175%  perf-profile.self.cycles-pp.nohz_balancer_kick
      0.04 ±189%      +0.0        0.06 ±192%  perf-profile.self.cycles-pp.delay_tsc
      0.21 ± 45%      +0.0        0.23 ± 26%  perf-profile.self.cycles-pp.update_process_times
      0.05 ± 43%      +0.0        0.07 ± 54%  perf-profile.self.cycles-pp.ct_nmi_exit
      0.00            +0.0        0.02 ±173%  perf-profile.self.cycles-pp.__pthread_enable_asynccancel
      0.09 ± 32%      +0.0        0.10 ± 29%  perf-profile.self.cycles-pp.rb_erase
      0.05 ± 71%      +0.0        0.07 ± 33%  perf-profile.self.cycles-pp.td_io_queue
      0.15 ± 21%      +0.0        0.17 ± 14%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.0        0.02 ±173%  perf-profile.self.cycles-pp.enqueue_entity
      0.01 ±244%      +0.0        0.03 ±102%  perf-profile.self.cycles-pp.folio_memcg_lock
      0.23 ± 35%      +0.0        0.25 ± 47%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.30 ± 15%      +0.0        0.32 ± 20%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.12 ± 26%      +0.0        0.15 ± 18%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.02 ±161%      +0.0        0.05 ± 62%  perf-profile.self.cycles-pp.td_io_prep
      0.28 ± 19%      +0.0        0.31 ± 16%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.32 ± 19%      +0.0        0.35 ± 18%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.0        0.02 ±181%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.08 ± 44%      +0.0        0.10 ± 38%  perf-profile.self.cycles-pp.tick_nohz_get_sleep_length
      0.02 ±159%      +0.0        0.04 ± 59%  perf-profile.self.cycles-pp.charge_memcg
      0.02 ±167%      +0.0        0.05 ± 60%  perf-profile.self.cycles-pp.mod_zone_page_state
      0.05 ± 44%      +0.0        0.08 ± 49%  perf-profile.self.cycles-pp.irqentry_enter
      0.37 ± 19%      +0.0        0.40 ± 10%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.00            +0.0        0.02 ±132%  perf-profile.self.cycles-pp.find_busiest_group
      0.00            +0.0        0.02 ±100%  perf-profile.self.cycles-pp.___perf_sw_event
      0.03 ±119%      +0.0        0.05 ± 64%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.10 ±158%      +0.0        0.13 ±145%  perf-profile.self.cycles-pp.memcpy_toio
      0.07 ± 50%      +0.0        0.10 ± 40%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.06 ± 67%      +0.0        0.08 ± 44%  perf-profile.self.cycles-pp.tick_sched_timer
      0.15 ± 33%      +0.0        0.18 ± 54%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.15 ± 33%      +0.0        0.18 ± 35%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.21 ± 30%      +0.0        0.24 ± 27%  perf-profile.self.cycles-pp.irq_work_tick
      0.01 ±244%      +0.0        0.04 ±106%  perf-profile.self.cycles-pp.xas_store
      0.05 ±100%      +0.0        0.08 ± 44%  perf-profile.self.cycles-pp.perf_mux_hrtimer_handler
      0.08 ± 25%      +0.0        0.11 ± 24%  perf-profile.self.cycles-pp.rb_next
      0.08 ± 44%      +0.0        0.12 ± 36%  perf-profile.self.cycles-pp.get_next_timer_interrupt
      0.05 ± 69%      +0.0        0.08 ± 54%  perf-profile.self.cycles-pp.tick_irq_enter
      0.16 ± 27%      +0.0        0.19 ± 29%  perf-profile.self.cycles-pp.error_entry
      0.03 ± 90%      +0.0        0.07 ± 46%  perf-profile.self.cycles-pp.cgroup_rstat_flush_locked
      0.15 ± 18%      +0.0        0.18 ± 35%  perf-profile.self.cycles-pp.__do_softirq
      0.50 ± 12%      +0.0        0.53 ± 17%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.0        0.04 ±134%  perf-profile.self.cycles-pp.zap_pte_range
      0.08 ± 49%      +0.0        0.11 ± 22%  perf-profile.self.cycles-pp.mpage_process_page_bufs
      0.01 ±244%      +0.0        0.05 ±112%  perf-profile.self.cycles-pp.strnlen_user
      0.03 ±158%      +0.0        0.07 ± 65%  perf-profile.self.cycles-pp.__entry_text_start
      0.11 ± 22%      +0.0        0.15 ± 42%  perf-profile.self.cycles-pp.ct_nmi_enter
      0.19 ± 35%      +0.0        0.23 ± 36%  perf-profile.self.cycles-pp.tick_check_oneshot_broadcast_this_cpu
      0.00            +0.0        0.04 ±111%  perf-profile.self.cycles-pp._find_next_bit
      0.03 ±127%      +0.0        0.07 ± 32%  perf-profile.self.cycles-pp.sched_clock
      0.30 ± 17%      +0.0        0.34 ± 12%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.01 ±244%      +0.0        0.05 ± 83%  perf-profile.self.cycles-pp.update_dl_rq_load_avg
      0.06 ± 67%      +0.0        0.10 ± 62%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.13 ± 48%      +0.0        0.17 ± 29%  perf-profile.self.cycles-pp.perf_rotate_context
      0.08 ± 51%      +0.0        0.12 ± 29%  perf-profile.self.cycles-pp.cpuidle_governor_latency_req
      0.07 ± 56%      +0.0        0.11 ± 38%  perf-profile.self.cycles-pp.rb_insert_color
      0.25 ± 16%      +0.0        0.30 ± 17%  perf-profile.self.cycles-pp.irq_enter_rcu
      0.77 ± 14%      +0.0        0.82 ± 13%  perf-profile.self.cycles-pp.note_gp_changes
      0.51 ± 20%      +0.0        0.56 ± 12%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.05 ± 69%      +0.0        0.10 ± 26%  perf-profile.self.cycles-pp.tick_nohz_tick_stopped
      0.04 ± 93%      +0.1        0.09 ± 35%  perf-profile.self.cycles-pp.hrtimer_update_next_event
      1.05 ±  9%      +0.1        1.10 ± 20%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.02 ±159%      +0.1        0.07 ± 51%  perf-profile.self.cycles-pp.pm_qos_read_value
      0.25 ± 34%      +0.1        0.30 ± 55%  perf-profile.self.cycles-pp.calc_global_load_tick
      0.09 ± 60%      +0.1        0.14 ± 35%  perf-profile.self.cycles-pp.rebalance_domains
      0.13 ± 37%      +0.1        0.19 ± 78%  perf-profile.self.cycles-pp.trigger_load_balance
      0.80 ±  9%      +0.1        0.87 ±  8%  perf-profile.self.cycles-pp.menu_select
      0.27 ± 19%      +0.1        0.35 ± 16%  perf-profile.self.cycles-pp.get_cpu_device
      0.14 ± 36%      +0.1        0.22 ± 23%  perf-profile.self.cycles-pp.timerqueue_add
      1.41 ± 12%      +0.1        1.52 ± 12%  perf-profile.self.cycles-pp.native_irq_return_iret
      2.89 ±  5%      +0.3        3.17 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      7.09 ±  8%      +0.5        7.55 ± 16%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
     39.34 ±  2%      +1.4       40.77 ±  6%  perf-profile.self.cycles-pp.acpi_safe_halt



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--QlvYCRFNV0rTKB28
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc5-00028-g4f3d1e4533b0"

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

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_DYNAMIC is not set
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
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
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
# CONFIG_RT_GROUP_SCHED is not set
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
CONFIG_EXPERT=y
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
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

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
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
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
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
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
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
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
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
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
CONFIG_CALL_PADDING=y
CONFIG_HAVE_CALL_THUNKS=y
CONFIG_CALL_THUNKS=y
CONFIG_PREFIX_SYMBOLS=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CALL_DEPTH_TRACKING=y
# CONFIG_CALL_THUNKS_DEBUG is not set
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
# CONFIG_SUSPEND_SKIP_SYNC is not set
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
# CONFIG_PM_DEBUG is not set
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
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
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
# CONFIG_X86_POWERNOW_K8 is not set
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
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
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
# CONFIG_KVM_WERROR is not set
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
# CONFIG_TRIM_UNUSED_KSYMS is not set
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
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
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
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
# CONFIG_SLUB_TINY is not set
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
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
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
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
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
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

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
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
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
# CONFIG_PAGE_POOL_STATS is not set
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
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
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
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
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
# CONFIG_SCSI_DEBUG is not set
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
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
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
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
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
# CONFIG_WLAN is not set
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
# CONFIG_TTY_PRINTK is not set
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
CONFIG_I2C_SMBUS=m
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
CONFIG_I2C_I801=m
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
CONFIG_GPIO_SYSFS=y
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
CONFIG_LPC_ICH=m
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
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
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

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

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
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
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
# CONFIG_INFINIBAND is not set
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
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
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
# CONFIG_EXT2_FS_XATTR is not set
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
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
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
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
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
CONFIG_NETFS_SUPPORT=m
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
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
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
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
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
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
CONFIG_SECURITY_APPARMOR_EXPORT_BINARY=y
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
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
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
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
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
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
CONFIG_CRYPTO_OFB=m
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
CONFIG_ZSTD_COMPRESS=y
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
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
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
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
# CONFIG_VMLINUX_MAP is not set
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
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
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
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
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
# CONFIG_DEBUG_MEMORY_INIT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

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
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
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
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
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
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
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
# CONFIG_TEST_BPF is not set
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

--QlvYCRFNV0rTKB28
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh

export_top_env()
{
	export suite=3D'fio-basic'
	export testcase=3D'fio-basic'
	export category=3D'benchmark'
	export runtime=3D300
	export nr_task=3D1
	export test_size=3D'128G'
	export job_origin=3D'fio-basic-1hdd-write.yaml'
	export queue_cmdline_keys=3D'force_schedule
force_reboot'
	export queue=3D'vip'
	export testbox=3D'lkp-icl-2sp9'
	export tbox_group=3D'lkp-icl-2sp9'
	export submit_id=3D'64b6343b0b9a932b7b60c01a'
	export job_file=3D'/lkp/jobs/queued/vip/lkp-icl-2sp9/fio-basic-4k-performa=
nce-1HDD-ext4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e=
4533b0-20230718-76667-11nrsap-1.yaml'
	export id=3D'14d39c4aa7bd1e6a3e409195541457e8201dcf6d'
	export queuer_version=3D'/lkp/xsang/.src-20230718-105547'
	export model=3D'Ice Lake'
	export nr_node=3D2
	export nr_cpu=3D64
	export memory=3D'256G'
	export nr_ssd_partitions=3D3
	export nr_hdd_partitions=3D6
	export hdd_partitions=3D'/dev/disk/by-id/wwn-0x50014ee2be2f4b3a-part*'
	export ssd_partitions=3D'/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part1
/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part2
/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part3'
	export rootfs_partition=3D'/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part4'
	export kernel_cmdline_hw=3D'acpi_rsdp=3D0x698f6014'
	export result_service=3D'tmpfs'
	export LKP_SERVER=3D'10.239.97.5'
	export avoid_nfs=3D1
	export brand=3D'Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz'
	export need_kconfig=3D'{"XFS_DEBUG"=3D>"n"}
{"XFS_WARN"=3D>"y"}
{"PM_DEBUG"=3D>"n"}
{"PM_SLEEP_DEBUG"=3D>"n"}
{"DEBUG_ATOMIC_SLEEP"=3D>"n"}
{"DEBUG_SPINLOCK_SLEEP"=3D>"n"}
{"CIFS_DEBUG"=3D>"n"}
{"SCSI_DEBUG"=3D>"n"}
{"NFS_DEBUG"=3D>"n"}
{"SUNRPC_DEBUG"=3D>"n"}
{"DM_DEBUG"=3D>"n"}
{"DEBUG_SHIRQ"=3D>"n"}
{"OCFS2_DEBUG_MASKLOG"=3D>"n"}
{"DEBUG_MEMORY_INIT"=3D>"n"}
{"SLUB_DEBUG"=3D>"n"}
{"EXPERT"=3D>"y"}
{"PREEMPT_VOLUNTARY"=3D>"y"}
{"PREEMPT_NONE"=3D>"n"}
{"PREEMPT"=3D>"n"}
{"PREEMPT_RT"=3D>"n"}
{"PREEMPT_DYNAMIC"=3D>"n"}
{"PREEMPT_VOLUNTARY_BEHAVIOUR"=3D>"y"}
{"PREEMPT_BEHAVIOUR"=3D>"n"}
{"PREEMPT_NONE_BEHAVIOUR"=3D>"n"}
{"PREEMPT_DYNAMIC"=3D>"n"}
{"PREEMPT_VOLUNTARY"=3D>"y"}
{"PREEMPT_NONE"=3D>"n"}
{"PREEMPT"=3D>"n"}
{"PREEMPT_RT"=3D>"n"}
BLK_DEV_SD
SCSI
{"BLOCK"=3D>"y"}
SATA_AHCI
SATA_AHCI_PLATFORM
ATA
{"PCI"=3D>"y"}
EXT4_FS'
	export commit=3D'4f3d1e4533b0982034f316ace85415d3bc57e3da'
	export ucode=3D'0xd000389'
	export need_kconfig_hw=3D'{"MEGARAID_NEWGEN"=3D>"y"}
MEGARAID_MM
MEGARAID_MAILBOX
MEGARAID_LEGACY
MEGARAID_SAS'
	export kconfig=3D'x86_64-rhel-8.3'
	export enqueue_time=3D'2023-07-18 14:42:06 +0800'
	export _id=3D'64b634400b9a932b7b60c025'
	export _rt=3D'/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-write=
-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/4=
f3d1e4533b0982034f316ace85415d3bc57e3da'
	export compiler=3D'gcc-12'
	export head_commit=3D'70e49dd32f8d664a83fc3eea895534f8d033b22c'
	export base_commit=3D'6995e2de6891c724bfeb2db33d7b87775f913ad1'
	export branch=3D'linus/master'
	export rootfs=3D'debian-11.1-x86_64-20220510.cgz'
	export user=3D'lkp'
	export scheduler_version=3D'/lkp/lkp/.src-20230718-114450'
	export arch=3D'x86_64'
	export max_uptime=3D2100
	export initrd=3D'/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append=3D'root=3D/dev/ram0
RESULT_ROOT=3D/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-write-=
128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/4f=
3d1e4533b0982034f316ace85415d3bc57e3da/8
BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316ace854=
15d3bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0
branch=3Dlinus/master
job=3D/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1HDD-ext4-s=
ync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0-20230718=
-76667-11nrsap-1.yaml
user=3Dlkp
ARCH=3Dx86_64
kconfig=3Dx86_64-rhel-8.3
commit=3D4f3d1e4533b0982034f316ace85415d3bc57e3da
nmi_watchdog=3D0
acpi_rsdp=3D0x698f6014
max_uptime=3D2100
LKP_SERVER=3D10.239.97.5
nokaslr
selinux=3D0
debug
apic=3Ddebug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=3D100
net.ifnames=3D0
printk.devkmsg=3Don
panic=3D-1
softlockup_panic=3D1
nmi_watchdog=3Dpanic
oops=3Dpanic
load_ramdisk=3D2
prompt_ramdisk=3D0
drbd.minor_count=3D8
systemd.log_level=3Derr
ignore_loglevel
console=3Dtty0
earlyprintk=3DttyS0,115200
console=3DttyS0,115200
vga=3Dnormal
rw'
	export modules_initrd=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982=
034f316ace85415d3bc57e3da/modules.cgz'
	export bm_initrd=3D'/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipco=
nfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_2022051=
3.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.c=
gz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/d=
eps/debian-11.1-x86_64-20220510.cgz/fio_20230715.cgz,/osimage/pkg/debian-11=
.1-x86_64-20220510.cgz/fio-x86_64-3.33-1_20230715.cgz,/osimage/deps/debian-=
11.1-x86_64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_=
64-20220510.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-2022=
0510.cgz/turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-=
11.1-x86_64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x86_64-=
20220510.cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11=
.1-x86_64-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debi=
an-11.1-x86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1-x86_6=
4-20220510.cgz/rootfs_20220515.cgz'
	export ucode_initrd=3D'/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd=3D'/osimage/user/lkp/lkp-x86_64.cgz'
	export site=3D'lkp-wsx01'
	export LKP_CGI_PORT=3D80
	export LKP_CIFS_PORT=3D139
	export job_initrd=3D'/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-perform=
ance-1HDD-ext4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1=
e4533b0-20230718-76667-11nrsap-1.cgz'
	export last_kernel=3D'6.4.0-02378-gd68f3b848dc3'
	export acpi_rsdp=3D'0x698f6014'
	export force_schedule=3Dtrue
	export force_reboot=3D1
	export kernel=3D'/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316a=
ce85415d3bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0'
	export result_root=3D'/result/fio-basic/4k-performance-1HDD-ext4-sync-1-30=
0s-write-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/=
gcc-12/4f3d1e4533b0982034f316ace85415d3bc57e3da/8'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=3D/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=3D1 $LKP_SRC/setup/disk

	run_setup fs=3D'ext4' $LKP_SRC/setup/fs

	run_setup rw=3D'write' bs=3D'4k' ioengine=3D'sync' $LKP_SRC/setup/fio-setu=
p-basic

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=3D1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-c2c
	run_monitor debug_mode=3D0 $LKP_SRC/monitors/no-stdout/wrapper perf-profil=
e
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper fio
}

extract_stats()
{
	export stats_part_begin=3D
	export stats_part_end=3D

	$LKP_SRC/stats/wrapper fio
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=3D1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-c2c
	env debug_mode=3D0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time fio.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--QlvYCRFNV0rTKB28
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"
Content-Transfer-Encoding: quoted-printable

---
suite: fio-basic
testcase: fio-basic
category: benchmark
runtime: 300s
disk: 1HDD
fs: ext4
nr_task: 1
test_size: 128G
fio-setup-basic:
  rw: write
  bs: 4k
  ioengine: sync
fio:
job_origin: fio-basic-1hdd-write.yaml
queue_cmdline_keys:
- branch
- commit
- kbuild_queue_analysis
queue: bisect
testbox: lkp-icl-2sp9
tbox_group: lkp-icl-2sp9
submit_id: 64b3f535617b43fead71c707
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1HDD-e=
xt4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0-202=
30716-65197-glsvq8-1.yaml"
id: d288c30ab88b87a9a92b4bbdd5bb422abda803d9
queuer_version: "/zday/lkp"
model: Ice Lake
nr_node: 2
nr_cpu: 64
memory: 256G
nr_ssd_partitions: 3
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/wwn-0x50014ee2be2f4b3a-part*"
ssd_partitions:
- "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part1"
- "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part2"
- "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part3"
rootfs_partition: "/dev/disk/by-id/wwn-0x500a0751e5ff0a85-part4"
kernel_cmdline_hw: acpi_rsdp=3D0x698f6014
result_service: tmpfs
LKP_SERVER: 10.239.97.5
avoid_nfs: 1
brand: Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz
need_kconfig:
- XFS_DEBUG: n
- XFS_WARN: y
- PM_DEBUG: n
- PM_SLEEP_DEBUG: n
- DEBUG_ATOMIC_SLEEP: n
- DEBUG_SPINLOCK_SLEEP: n
- CIFS_DEBUG: n
- SCSI_DEBUG: n
- NFS_DEBUG: n
- SUNRPC_DEBUG: n
- DM_DEBUG: n
- DEBUG_SHIRQ: n
- OCFS2_DEBUG_MASKLOG: n
- DEBUG_MEMORY_INIT: n
- SLUB_DEBUG: n
- EXPERT: y
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY_BEHAVIOUR: y
- PREEMPT_BEHAVIOUR: n
- PREEMPT_NONE_BEHAVIOUR: n
- PREEMPT_DYNAMIC: n
- PREEMPT_VOLUNTARY: y
- PREEMPT_NONE: n
- PREEMPT: n
- PREEMPT_RT: n
- BLK_DEV_SD
- SCSI
- BLOCK: y
- SATA_AHCI
- SATA_AHCI_PLATFORM
- ATA
- PCI: y
- EXT4_FS
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-c2c:
perf-profile:
  debug_mode: 0
cpufreq_governor: performance
sanity-check:
commit: 4f3d1e4533b0982034f316ace85415d3bc57e3da
ucode: '0xd000389'
need_kconfig_hw:
- MEGARAID_NEWGEN: y
- MEGARAID_MM
- MEGARAID_MAILBOX
- MEGARAID_LEGACY
- MEGARAID_SAS
kconfig: x86_64-rhel-8.3
enqueue_time: 2023-07-16 21:48:37.272837713 +08:00
_id: 64b3ff4c617b43fead71c708
_rt: "/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-write-128G/lkp=
-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/4f3d1e4533=
b0982034f316ace85415d3bc57e3da"
compiler: gcc-12
head_commit: 4959e9be4eebd7076b1bb56ddee8467516d2bb38
base_commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
branch: linux-devel/devel-hourly-20230715-100816
rootfs: debian-11.1-x86_64-20220510.cgz
user: lkp
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=3D/dev/ram0
- RESULT_ROOT=3D/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-writ=
e-128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/=
4f3d1e4533b0982034f316ace85415d3bc57e3da/0
- BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316ace8=
5415d3bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0
- branch=3Dlinux-devel/devel-hourly-20230715-100816
- job=3D/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1HDD-ext4=
-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0-202307=
16-65197-glsvq8-1.yaml
- user=3Dlkp
- ARCH=3Dx86_64
- kconfig=3Dx86_64-rhel-8.3
- commit=3D4f3d1e4533b0982034f316ace85415d3bc57e3da
- nmi_watchdog=3D0
- acpi_rsdp=3D0x698f6014
- max_uptime=3D2100
- LKP_SERVER=3D10.239.97.5
- nokaslr
- selinux=3D0
- debug
- apic=3Ddebug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=3D100
- net.ifnames=3D0
- printk.devkmsg=3Don
- panic=3D-1
- softlockup_panic=3D1
- nmi_watchdog=3Dpanic
- oops=3Dpanic
- load_ramdisk=3D2
- prompt_ramdisk=3D0
- drbd.minor_count=3D8
- systemd.log_level=3Derr
- ignore_loglevel
- console=3Dtty0
- earlyprintk=3DttyS0,115200
- console=3DttyS0,115200
- vga=3Dnormal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316ac=
e85415d3bc57e3da/modules.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_2022=
0515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/os=
image/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osima=
ge/deps/debian-11.1-x86_64-20220510.cgz/fs_20220526.cgz,/osimage/deps/debia=
n-11.1-x86_64-20220510.cgz/fio_20230715.cgz,/osimage/pkg/debian-11.1-x86_64=
-20220510.cgz/fio-x86_64-3.33-1_20230715.cgz,/osimage/deps/debian-11.1-x86_=
64-20220510.cgz/mpstat_20220516.cgz,/osimage/deps/debian-11.1-x86_64-202205=
10.cgz/turbostat_20220514.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/=
turbostat-x86_64-210e04ff7681-1_20220518.cgz,/osimage/deps/debian-11.1-x86_=
64-20220510.cgz/perf_20230522.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.=
cgz/perf-x86_64-00c7b5f4ddc5-1_20230402.cgz,/osimage/pkg/debian-11.1-x86_64=
-20220510.cgz/sar-x86_64-c5bb321-1_20220518.cgz,/osimage/deps/debian-11.1-x=
86_64-20220510.cgz/hw_20220526.cgz,/osimage/deps/debian-11.1-x86_64-2022051=
0.cgz/rootfs_20220515.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
job_initrd: "/lkp/jobs/scheduled/lkp-icl-2sp9/fio-basic-4k-performance-1HDD=
-ext4-sync-1-300s-write-128G-debian-11.1-x86_64-20220510.cgz-4f3d1e4533b0-2=
0230716-65197-glsvq8-1.cgz"
last_kernel: 6.5.0-rc1-05385-g7ddd6fdbf494
acpi_rsdp: '0x698f6014'
repeat_to: 3
bad_samples:
- 238.7158203125
- 235.755859375
- 234.1630859375

#! queue options

#! user overrides
kbuild_queue_analysis: 1
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-12/4f3d1e4533b0982034f316ace85415d3=
bc57e3da/vmlinuz-6.4.0-rc5-00028-g4f3d1e4533b0"
result_root: "/result/fio-basic/4k-performance-1HDD-ext4-sync-1-300s-write-=
128G/lkp-icl-2sp9/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3/gcc-12/4f=
3d1e4533b0982034f316ace85415d3bc57e3da/0"

#! schedule options

#! /db/releases/20230716204618/lkp-src/include/site/inn
dequeue_time: 2023-07-16 22:44:56.558007096 +08:00
job_state: wget_kernel_fail

--QlvYCRFNV0rTKB28
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

dmsetup remove_all
wipefs -a --force /dev/sdb1
mkfs -t ext4 -q -F /dev/sdb1
mkdir -p /fs/sdb1
mount -t ext4 /dev/sdb1 /fs/sdb1

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo '[global]
bs=4k
ioengine=sync
iodepth=32
size=137438953472
nr_files=1
filesize=137438953472
direct=0
runtime=300
invalidate=1
fallocate=posix
io_size=137438953472
file_service_type=roundrobin
random_distribution=random
group_reporting
pre_read=0

[task_0]
rw=write
directory=/fs/sdb1
numjobs=1' | fio --output-format=json -

--QlvYCRFNV0rTKB28--
