Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC9793661
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjIFHgh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 03:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjIFHgg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 03:36:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E5CE
        for <linux-ext4@vger.kernel.org>; Wed,  6 Sep 2023 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985789; x=1725521789;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TS5DzqFzyl0HL7WkCWF8K5C3KV6xbhBrGes2dD81dEE=;
  b=CdLHfX1GpIwZztPpwDM0xMoufd5MK5XRDpwf9RCs275awYS+HNgwjXjc
   dG+5TtIVbV/lD2p7P9aMe36V6vumgMGSh5NFj09sc2KEHwSXvhAgPZpjT
   xXCvlPaLZaMOuW2StNlZUXkuammkA6uVuiDhKYYvq6oLPC+f1CsewVYkG
   4DV3WCq+AnJQFnR4KIAG6ZhcaJwJp0zqTn+gIHZdupv+KNeX0xnmfpfr9
   ldo06X686sLU1z5LECoIqMPd1uEnkN2Ah7M5mwT6IjgEY37d5vnBBtM/u
   G16Z6rDLblYj/sykyCnVWNn3buTw6j8o/Pn0ElM9c7sCGgYOJhcpnjcwy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357306506"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="357306506"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="831540798"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="831540798"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 00:36:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 00:36:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 00:36:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 00:36:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 00:35:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCL1W4N9hBntCNkLKBpSjtTYR0xU9VVk1wmL1pgz8ChdCY04JNdzzn05nSrnyYAkND6FyrdFEdsI0+AIDX7/X+VXCmvVGoOsg7GYTIKm4s4PrX6DUvzCYg9CHdq4QZmRT1yWhCmQEdadwK0tosKx8fb5vcfxhWP70RGyA/U+K/Xn4V1Maj9851lcGMqdaPaR+mrIsA9ZU8Y1B8vcWPhwJ91dTTkGTJGoXC6X9YZew6gh2x+rLDDC3tAugiSb1byXk/j+kuVp9bDCKuvOZGzRROpZk1nu+edC95Hb13DUwSfeto86H3Hv93VWj25VBBK3lH+O5NdyZwdzx+Jc2oyB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwqLaI8bxC+OMs1yvTjc5DQzMwX9VYUHI0ZTw4ZFE00=;
 b=Q///8DfaiCUf6jh//xOQj/xDDJ3MALLkc05DtZdKwoufIYOJ3OKop8YY58DsMIcSkGuX8H1Z/QBeUXmdIlOIN5CQwHdBpkY9rCr4iH1Cmn+qGhmeIwqz41C730pQrhWIhONaWJwE3Z63farug2ejmSw7r00xwfVuhM+gHNRSh0rcNDsMlbCv48XtV9KZA/+W840/M+/3WJBJaQw6488fRx13Hpqx0bqWWrjy2/eifiOJCfELZBH9uVWHa8o/QE9Fd7bvnB6k8SMaO0msRwP9Mh6w5sSoapBBO8eHpdfZ2qhRpSlkQe+wgH1P9ooKf4dYj/cfBwDO9OifHXiyDwDzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB6290.namprd11.prod.outlook.com (2603:10b6:208:3e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 07:35:56 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 07:35:56 +0000
Date:   Wed, 6 Sep 2023 15:35:44 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-ext4@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yi.zhang@huaweicloud.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH 12/16] ext4: update reserved meta blocks in
 ext4_da_{release|update_reserve}_space()
Message-ID: <202309061536.1b59f59d-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824092619.1327976-13-yi.zhang@huaweicloud.com>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 54929d15-7511-401e-7879-08dbaeabe824
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qU9KUpgcQpcNc3oIsr5G/a4BGuVyNYC63nzuBfPizlKgeF/awN68V4bgitq704kksYc99EgBQs6Ekjp28WrLT/QCz3YpHKfltuTgN2uOBlVxfW0cqHfHzbDR3LU4P9z4lUevIKWrmxRHmHGS/THWHPxvC0MJyiEC5mOQQOFafvGB555RMFe3sHk9IzKfXsckUMeSZ2JhNZaEHaYfGq/bdJ1T5gTL557xJqrV+2/FgbqPQGMLxoceGn304kbUPQdy3mViWMEwLUOESjURnAYZS1Xqqudsfcgt+CQhKlE/x0oEMRA4dmj1Sfo2GZh/vym2SqYaXmHgspqgvKkS9XPTcWnh5SnQw1gdviHc39yMnNgElhXxFL9uaXKm24jxzJiIa8x+T1aNCqKbhe9NzpOY1ygzbkrdxRYEsnXUpcKnyXZdgoxpXeDbDZ86A5QkfnenleVk2n9vHef48sOfwqwWcNsDeb/nkLepJfxsrRwBKMZ2Wpl8A+ofgrtjaCJf5U88BJb1PmYZmkqOitH/v+CCN5rTCbKDU0KHgyTpOnHIIPqN0ioaLeQFnx5tfmaBOQQZhMk4hyk2JHC+kVU+imM7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199024)(186009)(1800799009)(83380400001)(38100700002)(30864003)(82960400001)(15650500001)(36756003)(2906002)(66946007)(6512007)(316002)(6916009)(41300700001)(66556008)(66476007)(86362001)(4326008)(6486002)(6506007)(478600001)(6666004)(5660300002)(8936002)(8676002)(2616005)(107886003)(1076003)(966005)(26005)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kRzvQgwyebrU2BCniZWl5jMSzqZU/JdziuuLCbFfyqZrxe01ByvfNbmRle?=
 =?iso-8859-1?Q?larFWZLCACt8TtlR+YXFC5U2L77kPr9DkiNZd+O7Ds3c+ajUon8IV0yC60?=
 =?iso-8859-1?Q?pStmqU9NzW5Fbj+zezBmLedXL6hy+q0rFp80K+s/nwmSLwt/JRxLozRf4f?=
 =?iso-8859-1?Q?+P23ogPpWUMPkSx50SGgA3bPM+DOAa5xxMLYai5Ik+hL+EpAWgRsVk6VQd?=
 =?iso-8859-1?Q?nd1JnYLqXFD2XUZ3vgy1G4GsT4Ia1I7Pz8KKI5I8T2FClybAeekBVbJxEN?=
 =?iso-8859-1?Q?vDHB5T2hIOQyfQSAGshZ9Qix32EFMLmW6WmNfDElHnGRECaUu18gje0Sys?=
 =?iso-8859-1?Q?BpetD3ihcUlrOdO0meSwLAtZZCRRKsYeLNFZGuwxLvJst5bXwgO+o3T6C2?=
 =?iso-8859-1?Q?2iCnDNeAyLPB72p6ApGISn6SvIsnPD0P1iZUdmiRCqKd734zEsPBctCBms?=
 =?iso-8859-1?Q?TiC3IivrbfiMO6LkOipJd8Tkh+m7/JQrUtEq+v1WsXkro1054/nMIrITWj?=
 =?iso-8859-1?Q?wuflrZKPtQAqfl4tobYpl8j68Z3yaksPv6ztPWYjWxKMBvita7rh7IEpXN?=
 =?iso-8859-1?Q?QfzYo8WT+zcny2CZYLvPQZ6ifjVk08Wg2E60oMyllTJEnsRaSG4ohPF+qh?=
 =?iso-8859-1?Q?1su+TedYruyF5Qg9Al7dr5nZJd9UHqzvMtyEl+hHUAwp+RdSSld540tfwF?=
 =?iso-8859-1?Q?mHs5qEJKj3vxHit2s6zIArWW2ZaObaHUx86MFtRkO7CIzGwRGtNbmtrKma?=
 =?iso-8859-1?Q?KeumNaEdXhmq2FNzl5LIWtTXXTFEI3cu98EJiUkqqy80Qg9jMGjcuVLF1S?=
 =?iso-8859-1?Q?ujAH4KV/EKHu6n/vjMHRwyy/yrBL+0YcGsYb/kCviwcw2MEPgoJ/brdRG0?=
 =?iso-8859-1?Q?IrhnW1dPLrLxDaS2W5pgai2oJEbvuYj3hnyw5yScRCnonIsCNp1R27nHwo?=
 =?iso-8859-1?Q?38wTGNYKfIDAS5vKGPEs4WsjKHw7pYf5Yw6tgZvOBJeKMiKgfwfjBjLxWk?=
 =?iso-8859-1?Q?jGtZBld0CLEFY3KxR550UIFpd95XWfiIGynZ3WsF/FD6hjI9YwLSa3k4BQ?=
 =?iso-8859-1?Q?9F34ov5dMDZ5Oav7UWTrQEZKCsSRBYHOifGuT+j0nRXyIyohI7tEKrGJMm?=
 =?iso-8859-1?Q?dDCYPqwFhAJQAM4ZWFhzvxNQ30MlOdtJi+61v0auN2qcV5AyoXaaLTDvkG?=
 =?iso-8859-1?Q?Eef1urjWMnuG08DOtedsQbO+VfRG4CbKW4h5oL7AVSLH70ZDQYtZ8mCwss?=
 =?iso-8859-1?Q?p4bcfzjuSG/SoUihgG+usEzFkvJzgmnAhLgMh82kTmYWI5im2hqgRyQNPl?=
 =?iso-8859-1?Q?LaPxnQEJuVuvUKlTU9/JBL6b2kHh5eyWtn1Wm2ql/gENHabpuv3S3KhT9j?=
 =?iso-8859-1?Q?VD/KriDL6Zb+Z3bPAR79EwRAV9si+KCEM59qOwzCY/Pn/9Eq6/0XdAHPSA?=
 =?iso-8859-1?Q?rkqXxHmABt+aDG/23Ar/n6Q1AkQ8y/f2cubXgwZnrdbXeAm/IjN9QZZupV?=
 =?iso-8859-1?Q?aZuES0q0If05qYFZStm6/2Ay6wvAnwoMCXPAIoHlUNamzitbjg9+ZZ9f/A?=
 =?iso-8859-1?Q?wSrZTes1TTaZNSAM1wdRsjRBhvcMqjdA4klsPjAaFjnQrz2n3v8t+/08ow?=
 =?iso-8859-1?Q?Q+Qte9YCdwx1ihUAG+buyjuUVyadnKWhHjmAnYTXAHMBnjCq49UTlKog?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54929d15-7511-401e-7879-08dbaeabe824
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 07:35:56.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43VmBR4LCS8XadxugQWXEkW0D1ztdYgbKWOM9QBma7+wtvJf3uBNDopOfHzdpLxVoryjBfj34iaKNAQ9B2jH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6290
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Hello,

kernel test robot noticed a 25.3% improvement of stress-ng.msg.ops_per_sec on:


commit: 235f4f5bfea93e33e13ba9d8c553d9cf613a58ee ("[RFC PATCH 12/16] ext4: update reserved meta blocks in ext4_da_{release|update_reserve}_space()")
url: https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/ext4-correct-the-start-block-of-counting-reserved-clusters/20230824-173242
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20230824092619.1327976-13-yi.zhang@huaweicloud.com/
patch subject: [RFC PATCH 12/16] ext4: update reserved meta blocks in ext4_da_{release|update_reserve}_space()

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	class: pts
	test: msg
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230906/202309061536.1b59f59d-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/msg/stress-ng/60s

commit: 
  637653488a ("ext4: factor out common part of ext4_da_{release|update_reserve}_space()")
  235f4f5bfe ("ext4: update reserved meta blocks in ext4_da_{release|update_reserve}_space()")

637653488ad95a0c 235f4f5bfea93e33e13ba9d8c55 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2359            +1.3%       2390        boot-time.idle
   9537488           -18.9%    7734959        cpuidle..usage
      3.17            +0.6        3.78        mpstat.cpu.all.usr%
    336783 ± 17%     -28.6%     240355 ± 18%  numa-meminfo.node1.Active
    336689 ± 17%     -28.6%     240299 ± 18%  numa-meminfo.node1.Active(anon)
    460770 ± 16%     -30.0%     322742 ± 19%  numa-meminfo.node1.Shmem
    450337 ±  5%     +43.9%     648260 ±  6%  numa-numastat.node0.local_node
    485519 ±  4%     +40.1%     680005 ±  5%  numa-numastat.node0.numa_hit
    680896 ±  3%     +10.0%     748983 ±  4%  numa-numastat.node1.numa_hit
    136742           -14.2%     117325        sched_debug.cpu.nr_switches.avg
    116638 ±  3%     -13.7%     100689 ±  2%  sched_debug.cpu.nr_switches.min
      0.31 ± 10%     +18.2%       0.36 ±  7%  sched_debug.cpu.nr_uninterruptible.avg
     36.67 ±  4%     +10.9%      40.67 ±  2%  vmstat.procs.r
    273206           -14.6%     233356        vmstat.system.cs
    104671            +4.9%     109774        vmstat.system.in
     46.83 ±  7%     -31.0%      32.33 ± 14%  perf-c2c.DRAM.local
     10329 ±  8%     +26.9%      13107 ±  6%  perf-c2c.DRAM.remote
      8544 ±  8%     +31.0%      11194 ±  6%  perf-c2c.HITM.remote
     30099 ±  7%     +15.1%      34636 ±  5%  perf-c2c.HITM.total
    485599 ±  4%     +40.1%     680300 ±  5%  numa-vmstat.node0.numa_hit
    450417 ±  5%     +44.0%     648555 ±  6%  numa-vmstat.node0.numa_local
     84324 ± 17%     -28.7%      60140 ± 18%  numa-vmstat.node1.nr_active_anon
    115201 ± 16%     -30.0%      80698 ± 19%  numa-vmstat.node1.nr_shmem
     84323 ± 17%     -28.7%      60140 ± 18%  numa-vmstat.node1.nr_zone_active_anon
    680786 ±  3%     +10.0%     749101 ±  4%  numa-vmstat.node1.numa_hit
 7.181e+08           +24.4%  8.932e+08        stress-ng.msg.ops
  11872476           +25.3%   14879722        stress-ng.msg.ops_per_sec
    153117 ±  4%     +39.5%     213629 ±  3%  stress-ng.time.involuntary_context_switches
      3843            +5.3%       4048        stress-ng.time.percent_of_cpu_this_job_got
      2316            +4.4%       2418        stress-ng.time.system_time
     91.29           +28.5%     117.34        stress-ng.time.user_time
   9318632           -14.7%    7951016        stress-ng.time.voluntary_context_switches
    112355            -3.2%     108777 ±  2%  proc-vmstat.nr_active_anon
    154552            -3.9%     148580        proc-vmstat.nr_shmem
    112355            -3.2%     108777 ±  2%  proc-vmstat.nr_zone_active_anon
   1168434           +22.5%    1430780        proc-vmstat.numa_hit
   1102166           +23.8%    1364548        proc-vmstat.numa_local
    206664            -4.7%     196864        proc-vmstat.pgactivate
   1211499           +21.6%    1473352        proc-vmstat.pgalloc_normal
    973632           +28.0%    1246003 ±  2%  proc-vmstat.pgfree
     92337 ±  4%    +158.2%     238396 ±  7%  turbostat.C1
      0.09 ±  5%      +0.2        0.25 ±  8%  turbostat.C1%
   9175706           -22.1%    7147445        turbostat.C1E
     30.93            -3.9       27.02        turbostat.C1E%
    247900 ±  3%     +18.3%     293206 ±  2%  turbostat.C6
      6.42 ±  3%      +0.7        7.14 ±  2%  turbostat.C6%
      0.10           +15.0%       0.12 ±  4%  turbostat.IPC
     13954 ±  4%    +232.9%      46453 ± 10%  turbostat.POLL
    211.09            +2.4%     216.18        turbostat.PkgWatt
     59.62            +3.8%      61.89        turbostat.RAMWatt
      0.01 ± 12%     +34.4%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01           +13.0%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
      0.01 ±  3%     +19.7%       0.01 ±  2%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      1.39 ± 52%    +350.2%       6.24 ± 63%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.37 ±  3%     -12.2%       3.84 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    189683           -20.7%     150342        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
    103248           +15.7%     119498        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.sysvipc_proc_start
    859.83 ±  2%     +16.4%       1000 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     11.39 ± 22%     +88.6%      21.48 ± 38%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.msgctl_info.constprop
      0.55 ±  5%      -8.3%       0.50 ±  4%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.36 ±  3%     -12.3%       3.83 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.57 ± 36%    +125.7%       3.55 ± 23%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      1.06 ± 19%    +109.5%       2.21 ± 25%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
 7.183e+09           +20.5%  8.658e+09        perf-stat.i.branch-instructions
  37085833           +19.0%   44140894        perf-stat.i.branch-misses
     24.92            +3.3       28.26        perf-stat.i.cache-miss-rate%
  53067160           +38.2%   73340095        perf-stat.i.cache-misses
 2.157e+08           +21.2%  2.614e+08        perf-stat.i.cache-references
    289025           -14.7%     246454        perf-stat.i.context-switches
      3.34           -13.6%       2.89        perf-stat.i.cpi
 1.282e+11            +4.3%  1.337e+11        perf-stat.i.cpu-cycles
     76033           -19.8%      60961        perf-stat.i.cpu-migrations
      2396           -24.1%       1818        perf-stat.i.cycles-between-cache-misses
 9.348e+09           +20.5%  1.126e+10        perf-stat.i.dTLB-loads
      0.00 ±  2%      -0.0        0.00 ±  5%  perf-stat.i.dTLB-store-miss-rate%
 5.595e+09           +21.4%  6.791e+09        perf-stat.i.dTLB-stores
 3.773e+10           +20.6%  4.552e+10        perf-stat.i.instructions
      0.32           +14.1%       0.36        perf-stat.i.ipc
      2.00            +4.3%       2.09        perf-stat.i.metric.GHz
    847.80           +37.2%       1162        perf-stat.i.metric.K/sec
    349.01           +20.7%     421.38        perf-stat.i.metric.M/sec
     96.81            +0.9       97.69        perf-stat.i.node-load-miss-rate%
  34681142           +41.8%   49163827        perf-stat.i.node-load-misses
    571211 ± 12%     -19.2%     461475 ±  7%  perf-stat.i.node-loads
     69.19            +4.7       73.94        perf-stat.i.node-store-miss-rate%
  12432335           +42.8%   17748149        perf-stat.i.node-store-misses
   5384441           +11.0%    5974384        perf-stat.i.node-stores
     24.59            +3.5       28.04        perf-stat.overall.cache-miss-rate%
      3.40           -13.6%       2.94        perf-stat.overall.cpi
      2416           -24.6%       1823        perf-stat.overall.cycles-between-cache-misses
      0.00 ±  2%      -0.0        0.00 ±  6%  perf-stat.overall.dTLB-store-miss-rate%
      0.29           +15.7%       0.34        perf-stat.overall.ipc
     69.80            +5.0       74.83        perf-stat.overall.node-store-miss-rate%
  7.07e+09           +20.5%   8.52e+09        perf-stat.ps.branch-instructions
  36445205           +19.0%   43382549        perf-stat.ps.branch-misses
  52231245           +38.2%   72171401        perf-stat.ps.cache-misses
 2.124e+08           +21.2%  2.574e+08        perf-stat.ps.cache-references
    284550           -14.8%     242556        perf-stat.ps.context-switches
 1.262e+11            +4.3%  1.316e+11        perf-stat.ps.cpu-cycles
     74864           -19.9%      59988        perf-stat.ps.cpu-migrations
 9.201e+09           +20.5%  1.109e+10        perf-stat.ps.dTLB-loads
 5.507e+09           +21.4%  6.684e+09        perf-stat.ps.dTLB-stores
 3.714e+10           +20.6%  4.479e+10        perf-stat.ps.instructions
  34137147           +41.7%   48383050        perf-stat.ps.node-load-misses
    561002 ± 12%     -18.8%     455270 ±  7%  perf-stat.ps.node-loads
  12237881           +42.7%   17467084        perf-stat.ps.node-store-misses
   5295571           +11.0%    5875597        perf-stat.ps.node-stores
 2.342e+12           +20.5%  2.823e+12        perf-stat.total.instructions
     11.71           -10.7        1.04        perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.06           -10.1        0.94 ±  2%  perf-profile.calltrace.cycles-pp.idr_find.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.49            -9.2        6.24        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     15.74            -8.4        7.36        perf-profile.calltrace.cycles-pp.ipc_obtain_object_check.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
      7.11            -3.0        4.09        perf-profile.calltrace.cycles-pp.msgctl
      7.03            -3.0        4.02        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msgctl
      7.01            -3.0        4.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      6.93            -3.0        3.94        perf-profile.calltrace.cycles-pp.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      3.84            -1.7        2.14        perf-profile.calltrace.cycles-pp.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      2.74            -1.2        1.54 ±  2%  perf-profile.calltrace.cycles-pp.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.msgctl
      1.81 ±  2%      -1.2        0.62 ±  2%  perf-profile.calltrace.cycles-pp.down_read.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.59 ±  2%      -1.0        0.60 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.msgctl_info.ksys_msgctl.do_syscall_64
      1.71            -0.9        0.83 ±  4%  perf-profile.calltrace.cycles-pp.down_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.61            -0.8        0.80 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl.do_syscall_64
      2.96            -0.7        2.25        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      2.90            -0.7        2.21        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.90            -0.7        2.21        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      2.90            -0.7        2.22        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      1.84            -0.5        1.33        perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.87            -0.5        1.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.84            -0.5        1.34        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.85            -0.5        1.34        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.83            -0.5        1.33        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      1.89            -0.5        1.39        perf-profile.calltrace.cycles-pp.read
      1.87            -0.5        1.37        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.92 ±  3%      -0.5        0.42 ± 44%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64
      1.84            -0.4        1.39 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.66            -0.4        0.25 ±100%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      1.68            -0.4        1.28 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.66            -0.4        1.26 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.32            -0.4        0.94        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.97            -0.4        0.61 ±  3%  perf-profile.calltrace.cycles-pp.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read.ksys_read
      0.92 ±  2%      -0.3        0.58 ±  3%  perf-profile.calltrace.cycles-pp.down_read.sysvipc_proc_start.seq_read_iter.seq_read.vfs_read
      0.81            -0.3        0.51        perf-profile.calltrace.cycles-pp.up_write.msgctl_down.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ±  2%      -0.3        0.56 ±  4%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.sysvipc_proc_start.seq_read_iter.seq_read
      0.64 ±  3%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down
      0.64 ±  3%      -0.2        0.45 ± 44%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.msgctl_down.ksys_msgctl
      0.64 ±  3%      -0.2        0.44 ± 44%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write
      1.56 ±  2%      -0.2        1.40        perf-profile.calltrace.cycles-pp.__percpu_counter_sum.msgctl_info.ksys_msgctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.56            +0.1        0.61        perf-profile.calltrace.cycles-pp.ss_wakeup.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.82 ±  5%      +0.1        0.96 ±  2%  perf-profile.calltrace.cycles-pp._copy_from_user.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.66 ±  2%      +0.2        0.83        perf-profile.calltrace.cycles-pp.__check_object_size.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.53            +0.2        0.73 ± 26%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgrcv.stress_run
      0.70 ±  2%      +0.2        0.95 ±  2%  perf-profile.calltrace.cycles-pp.wake_up_q.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      0.57 ±  3%      +0.4        0.94 ± 27%  perf-profile.calltrace.cycles-pp.__entry_text_start.__libc_msgsnd.stress_run
      1.58            +0.4        1.99        perf-profile.calltrace.cycles-pp.stress_msg.stress_run
      0.56 ±  2%      +0.4        0.98        perf-profile.calltrace.cycles-pp.___slab_alloc.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
      0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     44.35            +0.6       44.90        perf-profile.calltrace.cycles-pp.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.__libc_msgsnd.stress_run
      2.27            +0.6        2.85        perf-profile.calltrace.cycles-pp.__list_del_entry_valid.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      2.52            +0.6        3.12        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     44.94            +0.7       45.61        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      2.65            +0.7        3.36        perf-profile.calltrace.cycles-pp.memcg_slab_post_alloc_hook.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg
     45.15            +0.7       45.86        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgrcv.stress_run
      3.08            +0.8        3.86 ±  2%  perf-profile.calltrace.cycles-pp.__kmem_cache_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.41            +0.9        3.27        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     45.96            +0.9       46.84        perf-profile.calltrace.cycles-pp.__libc_msgrcv.stress_run
      2.56            +0.9        3.44        perf-profile.calltrace.cycles-pp.check_heap_object.__check_object_size.store_msg.do_msg_fill.do_msgrcv
      3.75            +1.1        4.82 ±  9%  perf-profile.calltrace.cycles-pp._copy_to_user.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      3.16            +1.1        4.24        perf-profile.calltrace.cycles-pp.__check_object_size.store_msg.do_msg_fill.do_msgrcv.do_syscall_64
      3.60            +1.2        4.78 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.78            +1.4        6.22        perf-profile.calltrace.cycles-pp.__kmem_cache_alloc_node.__kmalloc.alloc_msg.load_msg.do_msgsnd
      4.99            +1.5        6.46        perf-profile.calltrace.cycles-pp.__kmalloc.alloc_msg.load_msg.do_msgsnd.do_syscall_64
      5.31            +1.7        6.97        perf-profile.calltrace.cycles-pp.alloc_msg.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
     36.29            +1.7       37.99        perf-profile.calltrace.cycles-pp.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      6.79            +1.9        8.66        perf-profile.calltrace.cycles-pp.load_msg.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     37.42            +2.0       39.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
      7.34            +2.2        9.50 ±  2%  perf-profile.calltrace.cycles-pp.free_msg.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      2.59            +2.2        4.76        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.33            +2.3        9.62 ±  4%  perf-profile.calltrace.cycles-pp.store_msg.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.28            +2.4        5.66        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
      7.85            +2.4       10.24 ±  4%  perf-profile.calltrace.cycles-pp.do_msg_fill.do_msgrcv.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgrcv
     38.05            +2.4       40.50        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_msgsnd.stress_run
     39.32            +2.8       42.12        perf-profile.calltrace.cycles-pp.__libc_msgsnd.stress_run
      6.28            +3.7       10.01        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.10            +4.1       11.20        perf-profile.calltrace.cycles-pp._raw_spin_lock.do_msgsnd.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_msgsnd
     87.71            +4.3       92.00        perf-profile.calltrace.cycles-pp.stress_run
     22.97           -21.0        2.02        perf-profile.children.cycles-pp.idr_find
     31.41           -17.7       13.70        perf-profile.children.cycles-pp.ipc_obtain_object_check
      7.13            -3.0        4.12        perf-profile.children.cycles-pp.msgctl
      6.93            -3.0        3.94        perf-profile.children.cycles-pp.ksys_msgctl
      3.84            -1.7        2.14        perf-profile.children.cycles-pp.msgctl_info
      2.74            -1.5        1.21 ±  3%  perf-profile.children.cycles-pp.down_read
      1.49            -1.3        0.18 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.44 ±  2%      -1.3        1.16 ±  3%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      2.74            -1.2        1.54 ±  2%  perf-profile.children.cycles-pp.msgctl_down
      1.71            -0.9        0.84 ±  4%  perf-profile.children.cycles-pp.down_write
     91.47            -0.8       90.65        perf-profile.children.cycles-pp.do_syscall_64
      1.61            -0.8        0.80 ±  4%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.42            -0.8        0.63        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      2.96            -0.7        2.25        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      2.96            -0.7        2.25        perf-profile.children.cycles-pp.cpu_startup_entry
      2.96            -0.7        2.25        perf-profile.children.cycles-pp.do_idle
      2.90            -0.7        2.22        perf-profile.children.cycles-pp.start_secondary
      1.84            -0.5        1.33        perf-profile.children.cycles-pp.seq_read
      1.84            -0.5        1.33        perf-profile.children.cycles-pp.seq_read_iter
      1.85            -0.5        1.34        perf-profile.children.cycles-pp.ksys_read
      1.85            -0.5        1.34        perf-profile.children.cycles-pp.vfs_read
      1.89            -0.5        1.39        perf-profile.children.cycles-pp.read
      1.88            -0.5        1.42 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.99            -0.4        0.56        perf-profile.children.cycles-pp.rwsem_wake
      1.72            -0.4        1.30 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
      1.71            -0.4        1.29 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.35            -0.4        0.95        perf-profile.children.cycles-pp.intel_idle
      0.49 ±  2%      -0.4        0.09 ±  5%  perf-profile.children.cycles-pp.up_read
      3.01 ±  3%      -0.4        2.65 ±  4%  perf-profile.children.cycles-pp.__schedule
      0.97            -0.4        0.61 ±  3%  perf-profile.children.cycles-pp.sysvipc_proc_start
     92.22            -0.3       91.87        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.04            -0.3        0.70        perf-profile.children.cycles-pp.try_to_wake_up
      0.81            -0.3        0.51        perf-profile.children.cycles-pp.up_write
      2.67 ±  3%      -0.3        2.38 ±  5%  perf-profile.children.cycles-pp.schedule
      0.35 ±  3%      -0.3        0.10 ±  5%  perf-profile.children.cycles-pp.idr_get_next_ul
      0.35 ±  3%      -0.2        0.10        perf-profile.children.cycles-pp.idr_get_next
      1.66 ±  3%      -0.2        1.42 ±  5%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.40            -0.2        0.17 ±  4%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.44 ±  2%      -0.2        0.23 ±  2%  perf-profile.children.cycles-pp.sysvipc_proc_next
      0.67            -0.2        0.50        perf-profile.children.cycles-pp.flush_smp_call_function_queue
      1.57 ±  2%      -0.2        1.40        perf-profile.children.cycles-pp.__percpu_counter_sum
      0.66            -0.2        0.51        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.56            -0.1        0.44        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.51            -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.activate_task
      0.49            -0.1        0.39 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.27            -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.msgctl_stat
      0.48            -0.1        0.38        perf-profile.children.cycles-pp.dequeue_task_fair
      0.41 ±  2%      -0.1        0.32        perf-profile.children.cycles-pp.dequeue_entity
      0.15 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.osq_lock
      0.15 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.61            -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.update_load_avg
      0.37            -0.1        0.28        perf-profile.children.cycles-pp.select_task_rq
      0.36            -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.43            -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.36 ±  2%      -0.1        0.28 ±  2%  perf-profile.children.cycles-pp.schedule_idle
      0.32            -0.1        0.25 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      1.84            -0.1        1.78        perf-profile.children.cycles-pp.wake_up_q
      0.18 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.select_idle_sibling
      0.17 ±  2%      -0.0        0.13        perf-profile.children.cycles-pp.wake_affine
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.16 ±  3%      -0.0        0.12        perf-profile.children.cycles-pp.__smp_call_single_queue
      0.14 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.select_idle_cpu
      0.15 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
      0.14 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.update_curr
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.task_h_load
      0.14 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.switch_fpu_return
      0.12            -0.0        0.09 ±  6%  perf-profile.children.cycles-pp.menu_select
      0.10 ±  4%      -0.0        0.08 ±  8%  perf-profile.children.cycles-pp.select_idle_core
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.17 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.16 ±  3%      -0.0        0.14 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.llist_add_batch
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.__switch_to
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.llist_reverse_order
      0.11 ±  5%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.prepare_task_switch
      0.10 ±  4%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.07 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.09 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.rebalance_domains
      0.08 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.update_rq_clock_task
      0.06 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.security_msg_queue_msgsnd
      0.10 ±  4%      +0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.09            +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.kmalloc_slab
      0.09 ±  6%      +0.0        0.11        perf-profile.children.cycles-pp.is_vmalloc_addr
      0.13 ±  5%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.10 ±  7%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.format_decode
      0.18 ±  2%      +0.0        0.21 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.09 ± 11%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.security_msg_msg_alloc
      0.14 ±  6%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.security_ipc_permission
      0.10 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.number
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.allocate_slab
      0.19 ±  3%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.26 ±  4%      +0.0        0.30 ±  3%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.24 ±  5%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.57            +0.1        0.63        perf-profile.children.cycles-pp.ss_wakeup
      0.47 ±  3%      +0.1        0.53 ±  5%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.34 ±  2%      +0.1        0.41        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.32            +0.1        0.39        perf-profile.children.cycles-pp.vsnprintf
      0.41            +0.1        0.48        perf-profile.children.cycles-pp.__put_user_8
      0.32            +0.1        0.39        perf-profile.children.cycles-pp.seq_printf
      0.34            +0.1        0.42        perf-profile.children.cycles-pp.sysvipc_msg_proc_show
      0.43            +0.1        0.51 ±  2%  perf-profile.children.cycles-pp.__get_user_8
      0.50            +0.1        0.59 ±  2%  perf-profile.children.cycles-pp.__x64_sys_msgsnd
      0.36 ±  2%      +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.29 ±  3%      +0.1        0.38 ±  2%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.39 ±  3%      +0.1        0.48        perf-profile.children.cycles-pp.__check_heap_object
      0.34 ±  2%      +0.1        0.45 ±  2%  perf-profile.children.cycles-pp.ipcperms
      0.61            +0.1        0.74        perf-profile.children.cycles-pp.mod_objcg_state
      0.83 ±  5%      +0.2        0.98 ±  2%  perf-profile.children.cycles-pp._copy_from_user
      0.66            +0.2        0.82        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.48 ±  2%      +0.2        0.65        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.86            +0.2        1.06        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.12            +0.2        1.37        perf-profile.children.cycles-pp.__entry_text_start
      0.56 ±  2%      +0.4        0.98        perf-profile.children.cycles-pp.___slab_alloc
      1.62            +0.4        2.04        perf-profile.children.cycles-pp.stress_msg
      2.35            +0.6        2.92        perf-profile.children.cycles-pp.__list_del_entry_valid
     44.55            +0.6       45.16        perf-profile.children.cycles-pp.do_msgrcv
      2.68            +0.7        3.39        perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      3.11            +0.8        3.90 ±  2%  perf-profile.children.cycles-pp.__kmem_cache_free
     46.38            +1.0       47.36        perf-profile.children.cycles-pp.__libc_msgrcv
      2.99            +1.0        4.00        perf-profile.children.cycles-pp.check_heap_object
      3.87            +1.1        4.97 ±  8%  perf-profile.children.cycles-pp._copy_to_user
      3.61            +1.2        4.79 ±  2%  perf-profile.children.cycles-pp.__slab_free
      4.25            +1.4        5.69        perf-profile.children.cycles-pp.__check_object_size
      4.86            +1.4        6.30        perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      4.97            +1.5        6.44        perf-profile.children.cycles-pp.percpu_counter_add_batch
      5.03            +1.5        6.51        perf-profile.children.cycles-pp.__kmalloc
      5.33            +1.7        7.00        perf-profile.children.cycles-pp.alloc_msg
     36.43            +1.7       38.16        perf-profile.children.cycles-pp.do_msgsnd
      7.07            +2.1        9.13        perf-profile.children.cycles-pp.load_msg
      7.44            +2.2        9.62 ±  3%  perf-profile.children.cycles-pp.free_msg
      7.39            +2.3        9.68 ±  4%  perf-profile.children.cycles-pp.store_msg
      7.88            +2.4       10.28 ±  4%  perf-profile.children.cycles-pp.do_msg_fill
     39.75            +2.9       42.64        perf-profile.children.cycles-pp.__libc_msgsnd
     11.25            +4.2       15.48        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     87.71            +4.3       92.00        perf-profile.children.cycles-pp.stress_run
     11.07            +6.5       17.57        perf-profile.children.cycles-pp._raw_spin_lock
     22.77           -20.8        1.98        perf-profile.self.cycles-pp.idr_find
      1.35            -0.4        0.95        perf-profile.self.cycles-pp.intel_idle
      0.33 ±  2%      -0.2        0.08        perf-profile.self.cycles-pp.idr_get_next_ul
      0.44 ±  2%      -0.2        0.21 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.26            -0.2        0.10 ±  4%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.17 ±  2%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.15 ±  3%      -0.1        0.06        perf-profile.self.cycles-pp.osq_lock
      0.30 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.update_load_avg
      0.16 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.__schedule
      0.15 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.task_h_load
      0.09 ±  7%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      0.12 ±  4%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.llist_add_batch
      0.09 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.llist_reverse_order
      0.17 ±  2%      -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.__switch_to
      0.10            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.07 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.update_rq_clock_task
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.menu_select
      0.06 ±  6%      +0.0        0.07        perf-profile.self.cycles-pp.security_msg_queue_msgrcv
      0.07 ±  5%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.is_vmalloc_addr
      0.06 ±  9%      +0.0        0.07        perf-profile.self.cycles-pp.__cond_resched
      0.08 ±  6%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.kmalloc_slab
      0.10 ±  5%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.vsnprintf
      0.08 ±  4%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.format_decode
      0.09 ±  4%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.do_msg_fill
      0.16 ±  3%      +0.0        0.19        perf-profile.self.cycles-pp.__list_add_valid
      0.09            +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.number
      0.08 ±  4%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.alloc_msg
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__kmalloc
      0.12 ±  4%      +0.0        0.14 ±  5%  perf-profile.self.cycles-pp.security_ipc_permission
      0.08 ± 14%      +0.0        0.11 ± 15%  perf-profile.self.cycles-pp.security_msg_msg_alloc
      0.21 ±  3%      +0.0        0.24        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.14 ±  2%      +0.0        0.17 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.16 ±  3%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.store_msg
      0.23 ±  7%      +0.0        0.28 ±  4%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.28 ±  2%      +0.1        0.34 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.54            +0.1        0.60        perf-profile.self.cycles-pp.ss_wakeup
      0.34 ±  2%      +0.1        0.41        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.40            +0.1        0.47        perf-profile.self.cycles-pp.__put_user_8
      0.29 ±  3%      +0.1        0.36        perf-profile.self.cycles-pp.__entry_text_start
      0.41            +0.1        0.48 ±  3%  perf-profile.self.cycles-pp.__get_user_8
      0.27 ±  3%      +0.1        0.35 ±  2%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.37 ±  3%      +0.1        0.46        perf-profile.self.cycles-pp.__check_heap_object
      0.35            +0.1        0.44 ±  6%  perf-profile.self.cycles-pp.kfree
      0.46 ±  2%      +0.1        0.55 ±  2%  perf-profile.self.cycles-pp.__libc_msgsnd
      0.31 ±  3%      +0.1        0.41 ±  2%  perf-profile.self.cycles-pp.ipcperms
      0.47            +0.1        0.57 ±  2%  perf-profile.self.cycles-pp.__libc_msgrcv
      0.57            +0.1        0.69        perf-profile.self.cycles-pp.mod_objcg_state
      0.80 ±  5%      +0.1        0.93 ±  2%  perf-profile.self.cycles-pp._copy_from_user
      0.26            +0.1        0.40        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.48 ±  2%      +0.2        0.65        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.84            +0.2        1.02        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.36            +0.2        0.55 ±  3%  perf-profile.self.cycles-pp.load_msg
      0.88            +0.2        1.08        perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.61            +0.2        0.85        perf-profile.self.cycles-pp.__percpu_counter_sum
      0.76 ±  2%      +0.3        1.01 ±  2%  perf-profile.self.cycles-pp.wake_up_q
      0.67            +0.3        0.93        perf-profile.self.cycles-pp.__check_object_size
      0.48 ±  2%      +0.4        0.87 ±  2%  perf-profile.self.cycles-pp.___slab_alloc
      1.57            +0.4        1.99        perf-profile.self.cycles-pp.stress_msg
      0.77            +0.5        1.25        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.14            +0.5        2.67        perf-profile.self.cycles-pp._raw_spin_lock
      2.32            +0.6        2.88        perf-profile.self.cycles-pp.__list_del_entry_valid
      2.49            +0.7        3.14 ±  2%  perf-profile.self.cycles-pp.__kmem_cache_free
      2.43            +0.7        3.08        perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      2.58            +0.9        3.48        perf-profile.self.cycles-pp.check_heap_object
      3.82            +1.1        4.91 ±  8%  perf-profile.self.cycles-pp._copy_to_user
      3.24            +1.2        4.41        perf-profile.self.cycles-pp.do_msgrcv
      3.58            +1.2        4.74 ±  2%  perf-profile.self.cycles-pp.__slab_free
      4.86            +1.4        6.32        perf-profile.self.cycles-pp.percpu_counter_add_batch
      7.55            +3.2       10.74        perf-profile.self.cycles-pp.ipc_obtain_object_check
      3.20            +3.2        6.42        perf-profile.self.cycles-pp.do_msgsnd
     11.14            +4.2       15.31        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

