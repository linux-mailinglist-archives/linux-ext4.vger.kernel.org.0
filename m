Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BBC799EDA
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Sep 2023 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjIJPhr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Sep 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjIJPho (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Sep 2023 11:37:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EFA118;
        Sun, 10 Sep 2023 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694360255; x=1725896255;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=/E3rHib5NzKyLJYeikFfP44EUod9KK3IYT9vtbBV+q0=;
  b=f5GaQ4UlFewfILrwIBYFDfuvqJ8O8KfIH7h4BkuVWn1pDNsIsVjB4udZ
   deKeuuiADjX7fu8VMtJ7SdLocPQIoTsIFwZkdcsVyTdBJdBw1haobh2+w
   WDbWkr44M2cN8mNMWokrRBT8D+paX9zVUmXFeNqnX91zlWOCUIQGx/3ST
   Tyo1I01+xWu5v95ZMDXJbViPF3D2h+BjRWB/AJNXjwT/6O7ePFZPE/Ljw
   1/TYgdGg2yK7Aae+AvFv+2q9KtLt7lY8HnQaPyky7ULo+a5mSS8cZ1AND
   uwlK3xfU1QYWMQvyTClsdmflxgqhnZDAfEvtYXp766JEp9S8c+7bP38RY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444333961"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="444333961"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 08:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="1073846101"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="1073846101"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 08:37:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 08:37:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 08:37:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 10 Sep 2023 08:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq/FFoN3IK9f44kb32tj73Huqer9icUoXsxQc4k7ySXoMeJGCW4wA3yR7GdXZtiKWyVPjzV7EIrrYOphuOAhas1dDjTNgl3fw7vWt9ZcFSnqJH5x5NBrTZ+ewYyYOAFK7wkYZTMRVUd28RlI5j0K9zGtbQwDPKp4H5oJ3s/e9RPaNtuc4R09r0m/IAUGBjFi0vqT+5uKaxZEWHPTFGI8D5H7onVaft3C2vNNO4IlE1xnDZFvXhq6xDCsoyPDZdZJFlhB1QwCkXEpe/2pPnoNxCIJ3njahdPbCDhnybPtethasroo7Zjjuo7gEgrBZwM+zKBPMiUdm/IBxSBBhVOReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKX+ZEmmYmKj2fBqswBOlUh51AMhL8WPiWKN9BdHpb8=;
 b=EXtaiXc4qBJC6h1AWNGs1qRBQgEIm3lVOAGUd7LgulBBJQ7LYvdkFbARXNIyzv7D0i52IXiSzza5ZibG+ot3N+7ntAmi7aELPTgTdTKsURxazmtS6YH5Hu7E9B2gZ+bmJkX8csaEfRYChyw7NDgAvGyjGyDou2koaVyXyz9oveFGMdPf0x6qNdnlkDPAlXRBF7iKdWbpvcLpZyFYdLhziwworO4BjYH99dG/1hvyGmGdT/eK3umi1fquJAK2sZAO/IP8T0P00fMQ+pxPRZ8eMZ94X7Tv9etc5cpHRdKoDze03LWn6Y51kRnusm19S172pdxEV3+eHcIefIDiocS2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Sun, 10 Sep
 2023 15:37:22 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 15:37:22 +0000
Date:   Sun, 10 Sep 2023 23:37:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Liu Song <liusong@linux.alibaba.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [ext4]  03de20bed2:  aim7.jobs-per-min 249.0%
 improvement
Message-ID: <202309102324.54bc305d-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: d2308a24-889a-42fa-b43d-08dbb213d305
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsoT2Y1Dl3rKyQhuUvBOKdSCBoSas/4GlUN9frXsgSHQFMpjIWZn05ZstWjsgn0HP++gqJ6VMru+tWAdGBwC+NkXxunkpAsQI9cIvhAq+EvIzgNaSf6B83fjsoRfLOkMtQiT3l0vBDlYoLGOuaQoQleixs5m+1VvCXX2xtDdzdNDxqPfSMc16X5EgBmkgYajG8nsgdUvONmWE1Y5ezg6DqjsNX36iGlGqLr06gGVBy2gxbQZCmcUysMmJKYIeqAglUDxq5umV4tv2dYPDm4R3C7V8C1ca7vqvEbe8mvzCYO7KikDuu/t2MY7Mnus9Jvt73Vi9cy14dkh5Je0yeP71hU0ux44yBi6ToAG+DB0+Zbv+k3yLLeeJRM/uqSyBT1nNeevtiQYU+p5Mwunin/pDkV5O7BDN4qm7vf7hB1G1enpCKw3sq8nuA1svUhanO6H6U5zJyJEmZxSTHNhuy1afjo8bFj5ZqDbQmzYv7GNwsXqqX9hckneLBl4vgf44br7eHtqTPSPVJ0safJAbOqAoU0XUc5AdFzlJ62kB6lFYcTddbAot0+DxDsHTcF+AtQy6YVoMo3Ho2bBQvgDjt8IrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199024)(186009)(1800799009)(5660300002)(19627235002)(2906002)(4326008)(8936002)(1076003)(107886003)(66476007)(66556008)(6916009)(66946007)(30864003)(8676002)(41300700001)(54906003)(316002)(966005)(478600001)(6666004)(6506007)(6486002)(6512007)(36756003)(26005)(2616005)(38100700002)(83380400001)(82960400001)(86362001)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?icDcWFcfgSwLgaYhQpm28MyTjg/cAI7VnolcAAELuWZD4gCSU0GSzCSQyM?=
 =?iso-8859-1?Q?+pFQqFSz5+BnTgUawr2UrtEgfJv3SzHGYgwjZC9+9MDmYfZoq3n3X8wowb?=
 =?iso-8859-1?Q?xGU8h1sipDYZp70SlD4+7zIC1055wkVYdtKHsJfRZYX1wGE3uZzwGLZItQ?=
 =?iso-8859-1?Q?gNdaFCv74EWIEKGZ3g1QY3rHLnn7kOJpt6V37d11jJYkLjG4oyGnACh6NB?=
 =?iso-8859-1?Q?8HgogtZ3EHr6WEd7LLdUJZvjrBZhpVrDlJHi1RZoBeByDF9mSr4guSBGiz?=
 =?iso-8859-1?Q?oLeoBs8L4R2i9Z7NjCk1mWIjlpg5yo4LkAqFL/NAEDoQ+keIHVQDwU01WV?=
 =?iso-8859-1?Q?oRthZsrPbxpYrnF82PsM27Qmvy16xUTvvuogBMqBP0NaU6DobXV2JzGtyI?=
 =?iso-8859-1?Q?p7pe1XxT8l5TmrOVI1LXL9U61Ws8lJrLb4Hb/EgVMqv5QbZQWuUrfI17Dr?=
 =?iso-8859-1?Q?1Wwryqn5LHs+8p0XiYDYV9bHJuWwahb1CwbP4h8anrI7bUyrFjG8PvMn3i?=
 =?iso-8859-1?Q?UyIagvyD623GpYicJ0868JRtRr2hrO70h19G4/5w/6JnqvMhsTUHFOe2pc?=
 =?iso-8859-1?Q?uWS3buYegwT/MsZMUKMyv08prGOStNppzdzh+MPRU3ev3GrLMDqQwEiIHi?=
 =?iso-8859-1?Q?B3K+4ppFM+nTg/LJR5qDB2R6Eqc8nstL6T4zjAj31UnkOOn4LQcX3hc8R8?=
 =?iso-8859-1?Q?Aj7d9llADejm/ppqKFsjgzF1oEOehzfKHPbJGEwi37PLsAf69kJgRiFhLY?=
 =?iso-8859-1?Q?zu48+24AXyod9sm99pX0SuH9kkJcwAZbribyplHLQyay5YBnmmBr/4xg08?=
 =?iso-8859-1?Q?doAzdhoFV2Ahx6ZhHbbjWGuCPe8jJgwxPbtAH3oSZaLcVFOhTmA51pHMMU?=
 =?iso-8859-1?Q?qwnPT4+KmX7LFNuIRbWmRezWNvvVDBcbtHlAtrcBEcJIo1Fqeo224HGXfa?=
 =?iso-8859-1?Q?BCIjCu/EgJWgZsmVNHc4op05ur/4JllITsBWJBQG/QOfKHdW+8JgXB4j/E?=
 =?iso-8859-1?Q?XsJOX/VKl/DFBVYwh0hAUG+McqTDfHRr+42ibRWdsH0Q0oiDHCZTZ3+0tn?=
 =?iso-8859-1?Q?KU1QqV4kDzdwkH7Ns1ZzUz8UlPaMSm2elotXJQgj81ZMAn0WdMdUXFvpwd?=
 =?iso-8859-1?Q?aJxr0r/nMKIawSI7p2gP4qPYrVls5uNWtJhJ6wV3Nvm2z3E4ci6jXLkdjM?=
 =?iso-8859-1?Q?HwKcbLP1qVitzRY2YR87wDpAl0bZeF/gOkvKdLvtMQtYQ+fIizv0hFViuz?=
 =?iso-8859-1?Q?2o1r1zsofF5htRuV8CaxmqCfg4Vxnxl2bpKWFZgD4DV9giI7EouHUgrGds?=
 =?iso-8859-1?Q?S1aXpu8WycMcsFL5cG2gPwsiMAeNWZKX33cFtXEujvmurLLvG6+5rhQyFE?=
 =?iso-8859-1?Q?0RbjhOyPVwlUQEFXmIWxqtJhQ9qNTc73CPKvLhHTVgovxWmDcG2c4K5qcB?=
 =?iso-8859-1?Q?J67RcPyeDa2LqliSOz8RBvQzJBREsvBf6cnmu2mLzWhqNAoWN1lOuAQz+l?=
 =?iso-8859-1?Q?wjtgM6kTo4YdkNBraF+xqTXcAznLFjAaIIe4Cp/COo5uaurLp4cDhI+5aV?=
 =?iso-8859-1?Q?2JugdfWe1VHwr16YoByCq6aiy2kteLk8Yy7rGkjw4oSguKpDwqkWkkR2X/?=
 =?iso-8859-1?Q?d8Sgupi7GUgpVbUh22l/jHYHsdsw5FESxnKTP4VLaly8XLHIv1NaGuew?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2308a24-889a-42fa-b43d-08dbb213d305
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 15:37:22.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvlvxMyFmbcpGzsEOs7ClRDoKc3QrgzgW5cc5cVF2k+THAjQnGwq4FdklPLZQswPP/CM0MVmJlnwV5e60WcX/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Hello,

kernel test robot noticed a 249.0% improvement of aim7.jobs-per-min on:


commit: 03de20bed203b0819225d4de98353c1f8755a1dd ("ext4: do not mark inode dirty every time when appending using delalloc")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: aim7
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	disk: 1BRD_48G
	fs: ext4
	test: disk_cp
	load: 3000
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 144.2% improvement                                                 |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                               |
|                  | disk=1BRD_48G                                                                              |
|                  | fs=ext4                                                                                    |
|                  | load=3000                                                                                  |
|                  | test=disk_rr                                                                               |
+------------------+--------------------------------------------------------------------------------------------+
| testcase: change | aim7: aim7.jobs-per-min 253.0% improvement                                                 |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory |
| test parameters  | cpufreq_governor=performance                                                               |
|                  | disk=1BRD_48G                                                                              |
|                  | fs=ext4                                                                                    |
|                  | load=3000                                                                                  |
|                  | test=disk_rw                                                                               |
+------------------+--------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230910/202309102324.54bc305d-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/disk_cp/aim7

commit: 
  bb15cea20f ("ext4: rename s_error_work to s_sb_upd_work")
  03de20bed2 ("ext4: do not mark inode dirty every time when appending using delalloc")

bb15cea20f211e11 03de20bed203b0819225d4de983 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    130.36           -40.6%      77.38        uptime.boot
     20.19 ±  3%    +195.8%      59.73 ±  2%  iostat.cpu.idle
     79.13           -50.7%      39.04 ±  3%  iostat.cpu.system
      0.68 ±  2%     +81.0%       1.23 ±  5%  iostat.cpu.user
     18.03 ±  3%     +38.6       56.62 ±  3%  mpstat.cpu.all.idle%
      0.03 ±  2%      +0.0        0.05 ±  3%  mpstat.cpu.all.soft%
     80.17           -39.2       41.00 ±  3%  mpstat.cpu.all.sys%
      0.69 ±  2%      +0.6        1.29 ±  5%  mpstat.cpu.all.usr%
    251.00 ± 22%     -97.9%       5.17 ± 85%  perf-c2c.DRAM.local
      5000 ± 12%     -97.8%     109.33 ± 50%  perf-c2c.DRAM.remote
     10555 ±  9%     -99.1%      93.00 ± 58%  perf-c2c.HITM.local
      2577 ± 18%     -98.0%      52.33 ± 77%  perf-c2c.HITM.remote
     13132 ±  8%     -98.9%     145.33 ± 52%  perf-c2c.HITM.total
     19.50 ±  2%    +205.1%      59.50 ±  2%  vmstat.cpu.id
     78.67           -51.5%      38.17 ±  3%  vmstat.cpu.sy
     10947 ±  5%    +191.6%      31926 ±  3%  vmstat.io.bo
      1983 ±  9%     -15.4%       1677 ±  5%  vmstat.memory.buff
   3362359           -11.6%    2971587        vmstat.memory.cache
    190.33 ±  8%     -68.8%      59.33 ±  6%  vmstat.procs.r
    190061           -12.6%     166183        vmstat.system.in
    254336          +249.0%     887650        aim7.jobs-per-min
     71.02           -71.1%      20.50        aim7.time.elapsed_time
     71.02           -71.1%      20.50        aim7.time.elapsed_time.max
    408718 ±  2%     -90.7%      38170 ±  5%  aim7.time.involuntary_context_switches
      1599 ± 48%    +119.5%       3511 ± 26%  aim7.time.major_page_faults
    218530 ±  2%     -25.4%     163088        aim7.time.minor_page_faults
      7462           -84.0%       1192        aim7.time.system_time
     39.45 ±  3%     -22.7%      30.49        aim7.time.user_time
     75909           -69.5%      23177 ±  3%  aim7.time.voluntary_context_switches
      2117           -49.3%       1074 ±  3%  turbostat.Avg_MHz
     81.62           -38.2       43.44 ±  3%  turbostat.Busy%
     18.58 ±  2%     +36.0       54.56 ±  3%  turbostat.C1%
     18.38 ±  2%    +207.8%      56.56 ±  2%  turbostat.CPU%c1
      0.05        +42723.3%      21.41 ± 99%  turbostat.IPC
  14105535 ±  2%     -71.3%    4047051 ±  3%  turbostat.IRQ
     73.50            +5.9%      77.83        turbostat.PkgTmp
    330.14            -6.7%     308.02        turbostat.PkgWatt
     31.64           +17.1%      37.05        turbostat.RAMWatt
     23932 ±121%     -88.1%       2842 ± 73%  numa-meminfo.node0.Active
     22433 ±133%     -90.4%       2142 ± 75%  numa-meminfo.node0.Active(anon)
     43821 ±  4%     -64.2%      15693 ±  6%  numa-meminfo.node0.Dirty
     44731 ±  3%     -63.1%      16506 ± 13%  numa-meminfo.node0.Inactive(file)
     46985 ± 24%     -75.7%      11438 ±102%  numa-meminfo.node0.Mapped
     35016 ±124%     -82.2%       6240 ± 27%  numa-meminfo.node0.Shmem
    228030 ± 18%     -97.1%       6712 ± 34%  numa-meminfo.node1.Active
    226044 ± 18%     -97.9%       4674 ± 39%  numa-meminfo.node1.Active(anon)
     47213 ± 12%     -65.5%      16305 ± 15%  numa-meminfo.node1.Dirty
     48300 ± 12%     -61.6%      18536 ± 21%  numa-meminfo.node1.Inactive(file)
    103313 ± 16%     -69.4%      31599 ± 37%  numa-meminfo.node1.Mapped
    304912 ± 19%     -95.3%      14356 ± 26%  numa-meminfo.node1.Shmem
    249694 ±  5%     -96.1%       9636 ±  3%  meminfo.Active
    246203 ±  5%     -97.2%       6895 ±  4%  meminfo.Active(anon)
      3491 ±  5%     -21.5%       2740 ±  3%  meminfo.Active(file)
     93587           -29.4%      66064 ± 10%  meminfo.AnonHugePages
      1976 ±  9%     -16.5%       1651 ±  6%  meminfo.Buffers
   3193748           -11.8%    2815954        meminfo.Cached
   3095532           -17.0%    2567975        meminfo.Committed_AS
     92010 ±  9%     -65.5%      31764 ±  4%  meminfo.Dirty
    712870           -20.6%     566353        meminfo.Inactive
    618803           -14.1%     531560        meminfo.Inactive(anon)
     94067 ±  9%     -63.0%      34792 ±  4%  meminfo.Inactive(file)
    149905 ±  4%     -70.7%      43938 ±  4%  meminfo.Mapped
    100552 ±  7%     -16.6%      83873 ±  7%  meminfo.PageTables
    338318 ±  5%     -93.6%      21567 ±  8%  meminfo.Shmem
      5436 ±132%     -90.1%     536.83 ± 75%  numa-vmstat.node0.nr_active_anon
     10981 ±  4%     -64.6%       3883 ±  9%  numa-vmstat.node0.nr_dirty
     11195 ±  2%     -63.4%       4098 ± 16%  numa-vmstat.node0.nr_inactive_file
     11817 ± 25%     -75.0%       2955 ± 99%  numa-vmstat.node0.nr_mapped
      8620 ±123%     -81.9%       1561 ± 27%  numa-vmstat.node0.nr_shmem
      6587 ±111%     -87.7%     810.17 ±166%  numa-vmstat.node0.nr_written
      5436 ±132%     -90.1%     536.83 ± 75%  numa-vmstat.node0.nr_zone_active_anon
     11204 ±  2%     -63.4%       4103 ± 16%  numa-vmstat.node0.nr_zone_inactive_file
     10988 ±  4%     -64.7%       3875 ±  9%  numa-vmstat.node0.nr_zone_write_pending
     55594 ± 18%     -97.8%       1195 ± 36%  numa-vmstat.node1.nr_active_anon
     11988 ± 18%     -66.4%       4023 ± 17%  numa-vmstat.node1.nr_dirty
     12261 ± 19%     -62.5%       4603 ± 22%  numa-vmstat.node1.nr_inactive_file
     26174 ± 16%     -69.4%       8010 ± 36%  numa-vmstat.node1.nr_mapped
     75635 ± 20%     -95.0%       3776 ± 20%  numa-vmstat.node1.nr_shmem
     55593 ± 18%     -97.8%       1195 ± 36%  numa-vmstat.node1.nr_zone_active_anon
     12269 ± 19%     -62.4%       4615 ± 22%  numa-vmstat.node1.nr_zone_inactive_file
     12004 ± 18%     -66.5%       4027 ± 17%  numa-vmstat.node1.nr_zone_write_pending
     61555 ±  6%     -97.2%       1715 ±  3%  proc-vmstat.nr_active_anon
    872.83 ±  5%     -21.6%     684.50 ±  3%  proc-vmstat.nr_active_file
    131541            -1.7%     129347        proc-vmstat.nr_anon_pages
     23371 ± 11%     -67.4%       7627 ±  5%  proc-vmstat.nr_dirty
    799284           -11.9%     704109        proc-vmstat.nr_file_pages
    154679           -14.0%     132968        proc-vmstat.nr_inactive_anon
     23847 ± 11%     -64.7%       8414 ±  4%  proc-vmstat.nr_inactive_file
     65127            -7.2%      60468        proc-vmstat.nr_kernel_stack
     37709 ±  4%     -70.9%      10988 ±  4%  proc-vmstat.nr_mapped
     25106 ±  7%     -16.4%      21000 ±  7%  proc-vmstat.nr_page_table_pages
     84563 ±  5%     -93.6%       5395 ±  8%  proc-vmstat.nr_shmem
     40934            -7.3%      37939        proc-vmstat.nr_slab_reclaimable
     89060            -4.0%      85512        proc-vmstat.nr_slab_unreclaimable
     10487 ± 78%     -89.1%       1138 ±115%  proc-vmstat.nr_written
     61555 ±  6%     -97.2%       1715 ±  3%  proc-vmstat.nr_zone_active_anon
    872.83 ±  5%     -21.6%     684.50 ±  3%  proc-vmstat.nr_zone_active_file
    154679           -14.0%     132968        proc-vmstat.nr_zone_inactive_anon
     23847 ± 11%     -64.7%       8412 ±  4%  proc-vmstat.nr_zone_inactive_file
     23370 ± 11%     -67.4%       7627 ±  5%  proc-vmstat.nr_zone_write_pending
     69735 ± 14%     -96.4%       2532 ±141%  proc-vmstat.numa_hint_faults
     38844 ± 27%     -97.0%       1157 ±223%  proc-vmstat.numa_hint_faults_local
     26075 ± 14%     -94.7%       1375 ±203%  proc-vmstat.numa_pages_migrated
    211004 ±  5%     -96.8%       6823 ±141%  proc-vmstat.numa_pte_updates
    135452 ±  9%     -99.6%     557.17 ±  6%  proc-vmstat.pgactivate
    744081 ±  2%     -44.8%     410581        proc-vmstat.pgfault
     26075 ± 14%     -94.7%       1375 ±203%  proc-vmstat.pgmigrate_success
     42679 ±  8%     -66.5%      14318 ±  2%  proc-vmstat.pgreuse
      1614            -6.7%       1505        proc-vmstat.unevictable_pgs_culled
    666368 ±  2%     -57.9%     280576 ±  2%  proc-vmstat.unevictable_pgs_scanned
      1.00 ± 18%     -87.9%       0.12 ± 11%  sched_debug.cfs_rq:/.h_nr_running.avg
      3.08 ± 17%     -62.2%       1.17 ± 31%  sched_debug.cfs_rq:/.h_nr_running.max
      0.62 ± 12%     -47.0%       0.33 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
   3425267           -99.9%       2091 ±  6%  sched_debug.cfs_rq:/.min_vruntime.avg
   4253936 ±  5%     -99.5%      20021 ± 29%  sched_debug.cfs_rq:/.min_vruntime.max
   2848265 ±  4%    -100.0%      87.71 ± 31%  sched_debug.cfs_rq:/.min_vruntime.min
    190893 ± 13%     -98.3%       3186 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.55 ±  2%     -77.9%       0.12 ± 11%  sched_debug.cfs_rq:/.nr_running.avg
     21.02 ± 20%   +1830.7%     405.79 ±191%  sched_debug.cfs_rq:/.removed.load_avg.avg
    593.75 ± 30%   +2535.3%      15646 ±208%  sched_debug.cfs_rq:/.removed.load_avg.max
    106.16 ± 19%   +2188.0%       2428 ±202%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     53.83 ± 34%     +94.7%     104.82 ± 24%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
    296.42 ± 21%     +79.6%     532.50 ±  5%  sched_debug.cfs_rq:/.removed.util_avg.max
     49.14 ± 18%    +113.3%     104.82 ± 24%  sched_debug.cfs_rq:/.removed.util_avg.stddev
      1078 ± 15%     -74.2%     278.58 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
      2871 ± 17%     -52.0%       1378 ± 15%  sched_debug.cfs_rq:/.runnable_avg.max
    147.58 ± 87%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    507.45 ± 10%     -37.1%     319.26 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -456282           -98.8%      -5569        sched_debug.cfs_rq:/.spread0.avg
  -1038651           -99.3%      -7568        sched_debug.cfs_rq:/.spread0.min
    192545 ± 13%     -98.3%       3185 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
    625.29 ±  3%     -55.5%     278.18 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
    100.00 ± 80%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    640.98 ± 21%     -96.0%      25.41 ± 21%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      2072 ± 11%     -60.7%     815.33 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.max
    381.41 ± 12%     -70.1%     113.95 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    316300 ±  6%     -98.8%       3906 ± 13%  sched_debug.cpu.avg_idle.min
    159101 ±  8%     +51.9%     241735 ± 11%  sched_debug.cpu.avg_idle.stddev
     88363 ±  3%     -37.1%      55602        sched_debug.cpu.clock.avg
     88409 ±  3%     -37.1%      55608        sched_debug.cpu.clock.max
     88310 ±  3%     -37.0%      55595        sched_debug.cpu.clock.min
     28.16 ± 43%     -88.2%       3.32 ± 13%  sched_debug.cpu.clock.stddev
     87895 ±  3%     -36.9%      55473        sched_debug.cpu.clock_task.avg
     88066 ±  3%     -36.9%      55598        sched_debug.cpu.clock_task.max
     80219 ±  3%     -40.4%      47819        sched_debug.cpu.clock_task.min
      3562 ±  4%     -86.6%     476.22 ± 12%  sched_debug.cpu.curr->pid.avg
      6949 ±  3%     -36.2%       4434        sched_debug.cpu.curr->pid.max
      0.00 ± 41%     -61.7%       0.00 ± 36%  sched_debug.cpu.next_balance.stddev
      1.00 ± 18%     -88.3%       0.12 ± 10%  sched_debug.cpu.nr_running.avg
      3.08 ± 17%     -62.2%       1.17 ± 31%  sched_debug.cpu.nr_running.max
      0.62 ± 11%     -48.0%       0.32 ±  5%  sched_debug.cpu.nr_running.stddev
      4217 ±  2%     -55.9%       1858 ±  2%  sched_debug.cpu.nr_switches.avg
      1728 ±  6%     -92.2%     135.00 ±  6%  sched_debug.cpu.nr_switches.min
      8.46 ±  4%     -99.8%       0.01 ± 44%  sched_debug.cpu.nr_uninterruptible.avg
     86.50 ± 13%     -57.4%      36.83 ± 39%  sched_debug.cpu.nr_uninterruptible.max
     13.17 ±  6%     -53.1%       6.17 ± 17%  sched_debug.cpu.nr_uninterruptible.stddev
     88310 ±  3%     -37.0%      55598        sched_debug.cpu_clk
     87080 ±  3%     -37.6%      54368        sched_debug.ktime
     89181 ±  3%     -36.6%      56504        sched_debug.sched_clk
      9.00 ±  4%     -24.2%       6.82 ±  2%  perf-stat.i.MPKI
  7.14e+09          +132.9%  1.663e+10 ±  2%  perf-stat.i.branch-instructions
      0.40 ±  5%      +0.3        0.66 ±  7%  perf-stat.i.branch-miss-rate%
  18044265 ±  8%     +48.4%   26782750 ±  5%  perf-stat.i.branch-misses
     22.14 ±  3%      -6.6       15.56 ±  2%  perf-stat.i.cache-miss-rate%
  87563094 ±  6%     +78.7%  1.565e+08 ±  3%  perf-stat.i.cache-misses
 3.595e+08 ±  6%    +112.9%  7.653e+08        perf-stat.i.cache-references
      6.60           -67.8%       2.13 ±  4%  perf-stat.i.cpi
 2.682e+11           -44.8%  1.481e+11 ±  2%  perf-stat.i.cpu-cycles
      1077           -25.6%     801.93 ±  4%  perf-stat.i.cpu-migrations
   1671110 ± 11%     -28.3%    1198470 ± 11%  perf-stat.i.dTLB-load-misses
 1.021e+10          +125.1%  2.299e+10        perf-stat.i.dTLB-loads
      0.01 ± 11%      +0.0        0.01 ±  7%  perf-stat.i.dTLB-store-miss-rate%
 5.804e+09          +126.6%  1.315e+10 ±  2%  perf-stat.i.dTLB-stores
 3.674e+10          +131.0%  8.488e+10 ±  2%  perf-stat.i.instructions
      0.21 ±  2%    +172.5%       0.56 ±  3%  perf-stat.i.ipc
     26.39 ± 47%    +568.7%     176.47 ± 29%  perf-stat.i.major-faults
      2.09           -44.7%       1.16 ±  2%  perf-stat.i.metric.GHz
    576.22 ±  2%     +35.0%     777.81 ±  9%  perf-stat.i.metric.K/sec
    183.25          +128.0%     417.77 ±  2%  perf-stat.i.metric.M/sec
      8277 ±  2%     +44.3%      11947        perf-stat.i.minor-faults
   9964163 ±  3%      +4.9%   10451044        perf-stat.i.node-load-misses
    231571 ±  4%     +40.5%     325344 ±  3%  perf-stat.i.node-loads
     29.37 ±  3%     +44.0       73.36 ±  4%  perf-stat.i.node-store-miss-rate%
  10852436 ±  2%    +429.1%   57421746 ±  3%  perf-stat.i.node-store-misses
  40607345 ±  2%     -51.0%   19892361 ±  3%  perf-stat.i.node-stores
      8303 ±  2%     +46.0%      12123        perf-stat.i.page-faults
      9.80 ±  5%      -8.0%       9.02        perf-stat.overall.MPKI
      0.25 ±  7%      -0.1        0.16 ±  4%  perf-stat.overall.branch-miss-rate%
     24.28 ±  2%      -3.8       20.45 ±  2%  perf-stat.overall.cache-miss-rate%
      7.31           -76.1%       1.75        perf-stat.overall.cpi
      3079 ±  5%     -69.3%     946.69        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 12%      -0.0        0.01 ± 11%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 19%      -0.0        0.00 ± 25%  perf-stat.overall.dTLB-store-miss-rate%
      0.14          +318.5%       0.57        perf-stat.overall.ipc
     21.03 ±  2%     +53.3       74.28        perf-stat.overall.node-store-miss-rate%
 7.216e+09          +124.6%  1.621e+10 ±  2%  perf-stat.ps.branch-instructions
  17862623 ±  8%     +44.8%   25865039 ±  4%  perf-stat.ps.branch-misses
  88419742 ±  6%     +72.6%  1.526e+08 ±  3%  perf-stat.ps.cache-misses
 3.641e+08 ±  6%    +105.0%  7.463e+08        perf-stat.ps.cache-references
    126189            -3.3%     122077        perf-stat.ps.cpu-clock
 2.712e+11           -46.8%  1.444e+11 ±  2%  perf-stat.ps.cpu-cycles
      1076           -28.2%     772.98 ±  4%  perf-stat.ps.cpu-migrations
   1790530 ± 12%     -35.0%    1164590 ± 10%  perf-stat.ps.dTLB-load-misses
 1.032e+10          +117.0%  2.241e+10 ±  2%  perf-stat.ps.dTLB-loads
 5.871e+09          +118.4%  1.282e+10 ±  2%  perf-stat.ps.dTLB-stores
 3.713e+10          +122.8%  8.273e+10 ±  2%  perf-stat.ps.instructions
     22.33 ± 48%    +634.8%     164.07 ± 28%  perf-stat.ps.major-faults
      8064 ±  2%     +40.6%      11334        perf-stat.ps.minor-faults
    232893 ±  4%     +36.2%     317139 ±  3%  perf-stat.ps.node-loads
  10946890 ±  2%    +411.7%   56018178 ±  3%  perf-stat.ps.node-store-misses
  41123733 ±  2%     -52.8%   19399957 ±  3%  perf-stat.ps.node-stores
      8086 ±  2%     +42.2%      11498        perf-stat.ps.page-faults
    126189            -3.3%     122077        perf-stat.ps.task-clock
 2.664e+12           -33.0%  1.784e+12 ±  4%  perf-stat.total.instructions
      4.66 ±214%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      5.16 ± 86%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      0.16 ±105%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.07 ±159%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      4.46 ± 48%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.56 ± 96%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      4.87 ± 97%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.67 ±144%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      0.04 ±211%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      4.80 ± 96%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
     19.69 ±138%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.12 ± 29%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.36 ±140%     -99.8%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      2.56 ± 37%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      2.15 ±185%    -100.0%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      3.83 ± 39%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3.53 ± 78%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     10.03 ±218%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     10.79 ±  9%    -100.0%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.21 ± 73%     -99.5%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.40 ±121%     -98.3%       0.01 ± 55%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 26%     -60.2%       0.01 ± 46%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.23 ±200%     -97.5%       0.01 ± 44%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.54 ±200%     -99.7%       0.00 ±  8%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.09 ±107%     -87.5%       0.01 ± 56%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.11 ± 53%     -96.4%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.50 ± 67%     -99.8%       0.00 ± 38%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 14%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.49 ± 72%     -98.5%       0.01 ± 46%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.17 ±102%     -95.2%       0.01 ± 40%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.02 ± 25%     -71.5%       0.01 ± 42%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      1.54 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
      4.50 ± 92%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1.68 ± 53%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.12 ± 89%     -98.6%       0.00 ±101%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ±  6%     -50.9%       0.01 ± 29%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04 ±114%     -90.7%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.03 ± 70%     -69.2%       0.01 ± 52%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.50 ±149%     -98.8%       0.01 ± 36%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      1.59 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      5.08 ± 66%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      1.19 ± 47%     -97.0%       0.04 ± 65%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    465.10 ±216%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      2058 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      3.53 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      3.61 ±165%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      3107 ±  3%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     98.76 ±126%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      1574 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      1.69 ±220%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      4.89 ±101%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     68.00 ±156%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      0.90 ±218%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      1530 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
    968.15 ±136%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
     15.25 ± 43%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     28.76 ±209%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     23.66 ±142%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      2982 ±  4%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
    514.53 ±205%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      3104 ±  5%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1984 ± 65%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
    500.35 ±219%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     38.71 ± 14%    -100.0%       0.00 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     38.51 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     15.37 ± 67%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.84 ±104%     -99.8%       0.01 ± 55%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1.08 ±216%     -99.4%       0.01 ± 30%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    174.34 ±211%    -100.0%       0.06 ± 59%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      7.76 ± 49%     -99.9%       0.01 ± 32%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2466 ± 44%    -100.0%       0.01 ± 34%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.01 ± 16%    -100.0%       0.00        perf-sched.sch_delay.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
    867.11 ± 44%     -99.8%       1.49 ±115%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.98 ±101%     -99.6%       0.01 ± 51%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.03 ± 26%     -60.6%       0.01 ± 46%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    548.81 ±209%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      5.64 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
     43.18 ± 85%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
      1487 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      2519 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      6.35 ± 85%    -100.0%       0.00 ±107%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.04 ± 35%     -61.1%       0.02 ± 53%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
     30.62 ±189%    -100.0%       0.01 ± 12%  perf-sched.sch_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.93 ±150%     -98.8%       0.01 ± 29%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     16.99 ± 48%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    163.00 ± 25%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    454.40 ± 43%     -98.6%       6.32 ±176%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.90 ± 38%     -99.5%       0.01 ± 41%  perf-sched.total_sch_delay.average.ms
      3158 ±  4%     -99.6%      12.29 ± 73%  perf-sched.total_sch_delay.max.ms
    169.04 ±  6%     -78.3%      36.61 ± 25%  perf-sched.total_wait_and_delay.average.ms
     49103 ±  9%     -91.4%       4245 ±  7%  perf-sched.total_wait_and_delay.count.ms
      6051 ±  3%     -80.7%       1167 ± 17%  perf-sched.total_wait_and_delay.max.ms
    166.14 ±  6%     -78.0%      36.60 ± 25%  perf-sched.total_wait_time.average.ms
      4306 ± 10%     -72.9%       1167 ± 17%  perf-sched.total_wait_time.max.ms
    199.54 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
    206.30 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    206.62 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    180.49 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
     25.81 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    174.70 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
    230.42 ± 14%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
    201.30 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    203.88 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     36.12 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
    796.26          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    789.38 ±  3%     -93.0%      55.56 ±223%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    249.13 ±  3%     -98.9%       2.69 ± 27%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    224.50 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     22.35 ± 26%     -91.6%       1.87 ± 88%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    478.80 ± 11%     -73.9%     125.12 ±100%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    361.87 ±  5%     -81.2%      68.05 ± 26%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    331.30 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     53.37 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    452.10           -38.1%     279.95 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.49 ±  4%     +69.2%       7.59 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    652.34 ± 13%     -77.7%     145.34 ± 33%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    631.56 ±  7%     -91.8%      52.00 ± 48%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    822.50 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
     14832 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    315.67 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    598.17 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
    719.50 ± 25%     -40.4%     429.00 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    376.17 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    356.33 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      2026 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      9132 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    781.17 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
    311.17 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      9.83 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.83 ± 14%     -89.7%       0.50 ±223%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    124.33 ±  6%    +531.6%     785.33 ±  3%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    146.33 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      4577 ± 25%     -99.9%       4.33 ±141%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3505 ± 28%     -83.9%     565.17 ±  2%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.33 ± 11%     -91.0%       2.00 ±100%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    339.83 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      4637 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
     19.50 ±  7%     -76.1%       4.67 ± 20%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1165 ±  7%     -87.1%     150.50 ± 13%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1359 ± 15%     -44.5%     754.67 ± 13%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3059 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      5583 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      3013 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3012 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      2483 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      3549 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      3063 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      5501 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3031 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
      2861 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      1002          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1002           -83.4%     166.67 ±223%  perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      2973 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      3942 ± 31%     -88.0%     471.73 ±141%  perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1751 ± 21%     -80.5%     341.77 ±136%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      3543 ± 33%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      3040 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      4259 ±  9%     -72.7%       1164 ± 18%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2037           -47.8%       1063 ± 16%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     60.58 ± 76%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
    200.74 ± 28%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
    194.38 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
     13.84 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_inode.ext4_evict_inode.evict
     13.95 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create.lookup_open
     17.76 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
     13.24 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink.ext4_unlink
    232.01 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
     12.72 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create.lookup_open
     11.04 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
    101.68 ± 59%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
    201.84 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     15.98 ± 38%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict.__dentry_kill
    206.07 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     13.37 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
    175.62 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
     42.17 ±153%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread.__ext4_read_dirblock
     13.43 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode.ext4_create
     12.80 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode.ext4_evict_inode
    223.45 ±133%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.memcg_slab_post_alloc_hook
    273.55 ± 98%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     25.61 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    105.55 ± 94%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
     13.06 ± 13%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.__fput.task_work_run
    169.90 ± 18%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
    212.96 ± 52%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
    112.97 ±198%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      1.04 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      5.95 ± 29%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
     73.51 ± 66%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     49.82 ±175%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.fscrypt_file_open.ext4_file_open.do_dentry_open
     63.54 ± 56%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
    227.86 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
    200.31 ± 42%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
    197.47 ±  9%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    143.76 ± 76%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
    200.36 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
    202.44 ±133%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
    193.48 ± 54%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     16.99 ± 92%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_numa_page
     19.33 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
     74.58 ±117%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
     81.12 ±195%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     35.93 ± 31%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
    203.94 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    795.85          -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    789.15 ±  3%     -93.0%      55.56 ±223%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    247.60 ±  2%     -98.9%       2.68 ± 27%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     30.38 ± 40%     -98.7%       0.39 ±  3%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    224.39 ± 20%     -99.9%       0.20 ±173%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      9.88 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      7.40 ±121%     -98.1%       0.14 ±186%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     28.89 ± 44%     -87.6%       3.59 ±223%  perf-sched.wait_time.avg.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.18 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
     21.85 ± 26%     -91.5%       1.87 ± 88%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    478.62 ± 11%     -73.9%     125.12 ±100%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    361.48 ±  5%     -81.2%      67.82 ± 26%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     49.66 ± 48%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
    371.14 ±104%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
     33.37 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
    326.81 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     51.69 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      6.04 ± 20%     -99.5%       0.03 ±103%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    452.08           -38.1%     279.94 ± 14%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.45 ±  3%     +70.6%       7.59 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    652.31 ± 13%     -77.7%     145.33 ± 33%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.80 ± 36%   +2089.0%      39.43 ±112%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.64 ± 82%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     70.54 ± 93%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    630.38 ±  7%     -91.8%      51.96 ± 48%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    235.05 ±117%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      2931 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      3026 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
     19.17 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_inode.ext4_evict_inode.evict
     30.99 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create.lookup_open
     18.60 ± 50%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
     22.85 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink.ext4_unlink
      2889 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
     17.90 ± 37%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create.lookup_open
     12.80 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
      2421 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      3089 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     63.95 ±124%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict.__dentry_kill
      3013 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     17.33 ± 28%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
      3002 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
    488.81 ±209%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread.__ext4_read_dirblock
     22.77 ± 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode.ext4_create
     25.61 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode.ext4_evict_inode
    947.36 ±137%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc_node.memcg_alloc_slab_cgroups.memcg_slab_post_alloc_hook
      1918 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      2426 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      1437 ± 97%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
     28.96 ± 27%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dentry_kill.dput.__fput.task_work_run
      3007 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      2892 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
    523.22 ±214%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      7.26 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     20.48 ± 48%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
      2369 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
    446.09 ±213%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.fscrypt_file_open.ext4_file_open.do_dentry_open
      2451 ± 43%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      3034 ±  2%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      2956 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      3081 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1104 ± 71%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3019 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
    967.20 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      2433 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     20.47 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_numa_page
     24.83 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
    855.02 ±137%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
    502.37 ±216%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2861 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      2930 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1000          -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1001           -83.4%     166.68 ±223%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1427 ± 63%     -99.9%       1.00 ± 25%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2972 ±  2%     -99.9%       1.95 ±177%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     21.40 ± 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
     18.05 ± 67%     -99.2%       0.14 ±181%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      3040 ±  3%     -84.4%     475.09 ±139%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     28.89 ± 44%     -87.6%       3.59 ±223%  perf-sched.wait_time.max.ms.futex_wait_queue.futex_wait.do_futex.__x64_sys_futex
      0.19 ± 30%    -100.0%       0.00        perf-sched.wait_time.max.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      1586 ± 24%     -78.5%     341.77 ±136%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2429 ± 43%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      1519 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
      2925 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
      3009 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      3013 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    148.76 ± 21%    -100.0%       0.05 ±109%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     93.75 ± 82%    +211.5%     292.00 ± 17%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4259 ±  9%     -72.7%       1164 ± 18%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.60 ± 36%   +9977.9%     362.97 ±122%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     12.04 ± 80%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      1462 ± 91%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      2037           -47.8%       1063 ± 16%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     79.60           -79.6        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     76.76           -76.8        0.00        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
     49.18 ±  2%     -49.2        0.00        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
     91.58           -46.1       45.51        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     87.54           -44.4       43.17        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     44.08 ±  2%     -44.1        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
     91.96           -43.8       48.19        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     43.35 ±  2%     -43.4        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     92.06           -43.3       48.72        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.18           -43.0       49.22        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     92.24           -42.8       49.48        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     92.54           -41.5       51.02        perf-profile.calltrace.cycles-pp.write
     26.00 ±  2%     -26.0        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
     25.90 ±  2%     -25.9        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
     15.07           -15.1        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     12.81 ±  5%     -12.8        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      2.86 ± 23%      -1.8        1.02 ±  3%  perf-profile.calltrace.cycles-pp.file_modified_flags.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      0.64            +0.1        0.75        perf-profile.calltrace.cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write
      0.63            +0.1        0.74        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
      0.64            +0.1        0.75        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.65            +0.1        0.79        perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter
      0.66            +0.2        0.84        perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write
      1.44 ±  2%      +0.2        1.68        perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.45 ±  2%      +0.3        1.73        perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.82 ±  2%      +0.3        1.12 ±  2%  perf-profile.calltrace.cycles-pp.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.mem_cgroup_css_rstat_flush.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      0.00            +0.6        0.59 ±  3%  perf-profile.calltrace.cycles-pp.ext4_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.65 ±  2%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +0.7        0.66 ±  4%  perf-profile.calltrace.cycles-pp.ext4_file_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.7        0.69 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_account_cleaned.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio
      0.00            +0.7        0.70 ±  4%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin
      0.00            +0.7        0.70 ±  2%  perf-profile.calltrace.cycles-pp.atime_needs_update.touch_atime.filemap_read.vfs_read.ksys_read
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.__entry_text_start.write
      0.00            +0.7        0.73 ±  2%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio
      0.00            +0.7        0.75 ± 25%  perf-profile.calltrace.cycles-pp.__entry_text_start.read
      0.00            +0.8        0.78 ±  3%  perf-profile.calltrace.cycles-pp.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin
      0.00            +0.8        0.78        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      0.00            +0.8        0.79 ±  2%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +0.8        0.80        perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.8        0.82 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write
      0.00            +0.8        0.84        perf-profile.calltrace.cycles-pp.touch_atime.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.9        0.85 ±  2%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      0.00            +0.9        0.87 ±  2%  perf-profile.calltrace.cycles-pp.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +0.9        0.90 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      0.00            +1.0        0.95        perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.79            +1.0        1.83 ±  2%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +1.1        1.06        perf-profile.calltrace.cycles-pp.folio_account_cleaned.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range
      0.00            +1.1        1.11        perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.2        1.21        perf-profile.calltrace.cycles-pp.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      0.00            +1.3        1.27        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      0.00            +1.3        1.27        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      0.00            +1.3        1.28        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      0.00            +1.3        1.30        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      0.00            +1.3        1.30        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      0.00            +1.4        1.36        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +1.4        1.37        perf-profile.calltrace.cycles-pp.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end
      0.54 ± 50%      +1.4        1.92 ± 22%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat
      1.20            +1.4        2.59        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.77 ± 18%      +1.4        2.17 ± 20%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink
      0.78 ± 19%      +1.4        2.18 ± 20%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.78 ± 19%      +1.4        2.18 ± 20%  perf-profile.calltrace.cycles-pp.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.93 ± 16%      +1.5        2.39 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.93 ± 16%      +1.5        2.39 ± 19%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.94 ± 16%      +1.5        2.40 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      0.94 ± 16%      +1.5        2.40 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.94 ± 16%      +1.5        2.41 ± 18%  perf-profile.calltrace.cycles-pp.unlink
      0.83 ±  7%      +1.7        2.48 ±  4%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.vfs_read.ksys_read
      0.00            +1.7        1.69        perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end
      0.00            +1.7        1.74        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read
      0.00            +1.8        1.81        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.53 ±  2%      +1.8        2.35        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.57 ±  2%      +1.8        2.40        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.78 ± 21%      +1.8        2.62 ± 15%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      0.79 ± 21%      +1.9        2.66 ± 15%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      0.79 ± 21%      +1.9        2.66 ± 15%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.79 ± 20%      +1.9        2.66 ± 15%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.79 ± 20%      +1.9        2.66 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.80 ± 21%      +1.9        2.68 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.80 ± 21%      +1.9        2.68 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.80 ± 21%      +1.9        2.68 ± 15%  perf-profile.calltrace.cycles-pp.creat64
      0.12 ±223%      +1.9        2.02 ± 19%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.90 ±  6%      +1.9        2.82 ±  4%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.24 ±144%      +2.0        2.20 ± 18%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
      0.25 ±144%      +2.0        2.22 ± 17%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
      0.25 ±144%      +2.0        2.22 ± 17%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.0        2.01        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      0.96            +2.0        2.99        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.00            +2.1        2.15        perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.00            +2.2        2.18        perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write
      0.00            +2.2        2.22        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      2.96            +2.7        5.66        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +3.8        3.85        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +4.0        4.04        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +4.7        4.72        perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.32 ±  3%      +5.3        7.59 ±  2%  perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.71 ±  2%      +7.5       10.19        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.84 ±  2%      +7.9       10.77        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      2.96 ±  2%      +8.4       11.32        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.00 ±  2%      +8.6       11.58        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.26            +9.8       13.06        perf-profile.calltrace.cycles-pp.read
      0.00           +20.5       20.45        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
      0.00           +20.5       20.48        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      0.00           +20.5       20.49        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      0.76           +20.8       21.58        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.54 ±  2%     +20.9       21.49        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      0.00           +22.1       22.13        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
      0.00           +22.2       22.16        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range
      0.00           +22.2       22.18        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      1.99           +22.3       24.24        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.54 ±  3%     +22.9       23.46        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      3.23           +23.5       26.74        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.56 ±  2%     +24.2       24.79        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      6.36           +26.8       33.14        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1.97 ±  2%     +27.1       29.06        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dentry_kill
      2.11 ±  2%     +27.1       29.25        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dentry_kill.dput
      2.12 ±  2%     +27.2       29.28        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
      2.13 ±  2%     +27.2       29.30        perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
      2.13 ±  2%     +27.2       29.30        perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_loop
      2.13 ±  2%     +27.2       29.31        perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      2.14 ±  2%     +27.2       29.33        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.14 ±  2%     +27.2       29.34        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.14 ±  2%     +27.2       29.34        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.15 ±  2%     +27.2       29.36        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      2.15 ±  2%     +27.2       29.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.14 ±  2%     +27.2       29.35        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.14 ±  2%     +27.2       29.35        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.15 ±  2%     +27.2       29.37        perf-profile.calltrace.cycles-pp.__close
     79.61           -79.6        0.00        perf-profile.children.cycles-pp.generic_write_end
     79.59           -79.2        0.41 ±  7%  perf-profile.children.cycles-pp.__mark_inode_dirty
     50.86           -50.6        0.25 ± 10%  perf-profile.children.cycles-pp.ext4_dirty_inode
     91.59           -46.0       45.61        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     45.72           -45.5        0.21 ± 11%  perf-profile.children.cycles-pp.jbd2__journal_start
     45.05           -44.8        0.20 ± 12%  perf-profile.children.cycles-pp.start_this_handle
     87.61           -44.3       43.32        perf-profile.children.cycles-pp.generic_perform_write
     92.02           -43.7       48.29        perf-profile.children.cycles-pp.vfs_write
     92.12           -43.3       48.80        perf-profile.children.cycles-pp.ksys_write
     92.63           -41.1       51.54        perf-profile.children.cycles-pp.write
     27.06 ±  2%     -27.0        0.06 ± 11%  perf-profile.children.cycles-pp.__ext4_journal_stop
     26.98 ±  2%     -26.9        0.06 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_stop
     15.43 ±  2%     -15.4        0.04 ± 71%  perf-profile.children.cycles-pp.add_transaction_credits
     13.44 ±  6%     -13.4        0.00        perf-profile.children.cycles-pp.stop_this_handle
      5.16            -5.0        0.19 ±  3%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
     99.19            -3.5       95.71        perf-profile.children.cycles-pp.do_syscall_64
     99.28            -3.2       96.10        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      2.59 ±  2%      -2.5        0.09 ±  5%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      2.53 ±  2%      -2.4        0.14 ±  4%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      2.68 ± 25%      -2.4        0.31 ± 10%  perf-profile.children.cycles-pp.generic_update_time
      1.99 ±  2%      -1.9        0.12 ±  6%  perf-profile.children.cycles-pp.ext4_do_update_inode
      2.88 ± 23%      -1.8        1.08 ±  3%  perf-profile.children.cycles-pp.file_modified_flags
      1.82 ±  2%      -1.8        0.07 ±  5%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      1.80 ±  2%      -1.7        0.07 ±  7%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      1.64 ±  2%      -1.6        0.07 ±  5%  perf-profile.children.cycles-pp.__getblk_gfp
      1.60 ±  2%      -1.5        0.07 ±  7%  perf-profile.children.cycles-pp.__find_get_block
      1.37 ± 10%      -1.3        0.09 ±  7%  perf-profile.children.cycles-pp._raw_read_lock
      1.12            -1.0        0.09 ±  7%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      0.56 ±  2%      -0.5        0.03 ± 70%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.76 ±  4%      -0.3        0.44 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.55 ±  3%      -0.3        0.28 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.34 ±  2%      -0.3        0.08 ± 10%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.46 ± 15%      -0.2        0.28 ±  3%  perf-profile.children.cycles-pp.up_write
      0.21 ±  3%      -0.1        0.11 ± 14%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.11 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.up_read
      0.10            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp._raw_write_lock
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.children.cycles-pp.filemap_free_folio
      0.07 ±  5%      +0.0        0.10 ±  5%  perf-profile.children.cycles-pp.__es_remove_extent
      0.13 ±  2%      +0.0        0.16 ±  7%  perf-profile.children.cycles-pp.__ext4_unlink
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.folio_wait_stable
      0.13 ±  2%      +0.0        0.16 ±  6%  perf-profile.children.cycles-pp.ext4_unlink
      0.14 ±  3%      +0.0        0.17 ±  6%  perf-profile.children.cycles-pp.vfs_unlink
      0.09 ± 11%      +0.0        0.13 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.children.cycles-pp.update_cfs_group
      0.17 ±  4%      +0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__ext4_read_dirblock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ext4_bread
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.ext4_getblk
      0.09 ±  4%      +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.__ext4_new_inode
      0.08 ±  6%      +0.1        0.13 ±  4%  perf-profile.children.cycles-pp.try_charge_memcg
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.times
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.xas_alloc
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.folio_memcg_unlock
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.make_vfsgid
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ext4_orphan_del
      0.08 ±  7%      +0.1        0.14 ± 11%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ext4_invalidate_folio
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.wait4
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.make_vfsuid
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.xas_set_mark
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.refill_obj_stock
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__x64_sys_write
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.add_dirent_to_buf
      0.03 ± 70%      +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.ext4_has_free_clusters
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.ext4_es_can_be_merged
      0.04 ± 44%      +0.1        0.11        perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.uncharge_folio
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.ext4_free_inode
      0.08 ±  4%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.03 ± 70%      +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.09            +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.drop_buffers
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.ext4_add_entry
      0.31 ±  3%      +0.1        0.39        perf-profile.children.cycles-pp.block_invalidate_folio
      0.00            +0.1        0.08 ±  7%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.16 ±  3%      +0.1        0.25        perf-profile.children.cycles-pp.ext4_create
      0.03 ± 70%      +0.1        0.12 ± 10%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.06 ± 16%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.alloc_pages
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.ext4_lookup
      0.04 ± 45%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.02 ±141%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.1        0.09 ±  6%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.10 ±  8%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.02 ±141%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.xa_get_order
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.xas_find
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.open64
      0.09            +0.1        0.19 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.node_page_state
      0.01 ±223%      +0.1        0.11        perf-profile.children.cycles-pp.__x64_sys_read
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.02 ±141%      +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.xas_create
      0.64            +0.1        0.75        perf-profile.children.cycles-pp.do_flush_stats
      0.64            +0.1        0.75        perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.64            +0.1        0.75        perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.06 ±  6%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.ext4_da_write_end
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.generic_file_read_iter
      0.02 ±141%      +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.05 ±  7%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.uncharge_batch
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.ext4_release_folio
      0.06            +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__xa_set_mark
      0.01 ±223%      +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.01 ±223%      +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.ret_from_fork
      0.01 ±223%      +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.kthread
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.read@plt
      0.00            +0.1        0.13 ± 36%  perf-profile.children.cycles-pp.write@plt
      0.07            +0.1        0.20        perf-profile.children.cycles-pp.__es_insert_extent
      0.02 ±141%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.ext4_claim_free_clusters
      0.05 ±  7%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.40 ±  2%      +0.1        0.54 ±  3%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.00            +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.14 ±  3%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.14 ±  3%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.rw_verify_area
      0.65            +0.1        0.79        perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.00            +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.inode_to_bdi
      0.02 ± 99%      +0.2        0.18 ±  2%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.31 ±  5%      +0.2        0.46        perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.01 ±223%      +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.__do_softirq
      0.11 ±  5%      +0.2        0.26 ±  6%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.25 ±  2%      +0.2        0.41        perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.21 ±  2%      +0.2        0.37 ±  2%  perf-profile.children.cycles-pp.lookup_open
      0.01 ±223%      +0.2        0.17 ±  4%  perf-profile.children.cycles-pp.__file_remove_privs
      0.09 ±  4%      +0.2        0.25 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.2        0.16 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.2        0.17 ±  2%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.06 ±  7%      +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.66            +0.2        0.84        perf-profile.children.cycles-pp.balance_dirty_pages
      0.20 ±  2%      +0.2        0.38        perf-profile.children.cycles-pp.find_lock_entries
      0.25 ±  4%      +0.2        0.44 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.09 ±  5%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.21 ±  7%      +0.2        0.40 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.27 ±  5%      +0.2        0.46 ±  5%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.2        0.20 ±  3%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.08            +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.free_unref_page_list
      0.30 ±  4%      +0.2        0.52 ±  5%  perf-profile.children.cycles-pp.update_process_times
      0.31 ±  5%      +0.2        0.52 ±  5%  perf-profile.children.cycles-pp.tick_sched_handle
      0.06 ±  6%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.00            +0.2        0.22 ±  6%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.00            +0.2        0.22 ±  6%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.32 ±  5%      +0.2        0.54 ±  6%  perf-profile.children.cycles-pp.tick_sched_timer
      0.44 ±  3%      +0.2        0.66 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.39 ±  3%      +0.2        0.61 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.01 ±223%      +0.2        0.24 ±  4%  perf-profile.children.cycles-pp.aa_file_perm
      0.05            +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.45 ±  3%      +0.2        0.68 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.74 ± 12%      +0.2        0.98 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.06 ±  6%      +0.2        0.29 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.02 ± 99%      +0.2        0.26 ±  4%  perf-profile.children.cycles-pp.mod_objcg_state
      0.08 ±  6%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.disk_cp
      0.01 ±223%      +0.2        0.25 ±  2%  perf-profile.children.cycles-pp.node_dirty_ok
      0.02 ±141%      +0.2        0.26 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.3        0.25 ±  8%  perf-profile.children.cycles-pp.fsnotify_perm
      1.44 ±  2%      +0.3        1.70        perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.10 ±  5%      +0.3        0.36 ±  4%  perf-profile.children.cycles-pp.xas_start
      0.10 ±  5%      +0.3        0.37 ±  3%  perf-profile.children.cycles-pp.generic_write_checks
      0.08 ±  4%      +0.3        0.36 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.45 ±  2%      +0.3        1.73        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.00            +0.3        0.30 ±  5%  perf-profile.children.cycles-pp.__mmput
      0.00            +0.3        0.30 ±  5%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.3        0.30 ±  5%  perf-profile.children.cycles-pp.exit_mm
      0.14 ±  5%      +0.3        0.44        perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.3        0.30 ± 42%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.00            +0.3        0.30 ± 42%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.00            +0.3        0.31 ±  4%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.00            +0.3        0.31 ± 42%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +0.3        0.31 ± 42%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +0.3        0.32 ±  5%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.3        0.32 ±  5%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.3        0.32 ±  5%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.07 ±  5%      +0.3        0.38 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.50 ±  3%      +0.3        0.81 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.82 ±  2%      +0.3        1.14 ±  2%  perf-profile.children.cycles-pp.folio_create_empty_buffers
      0.00            +0.3        0.33 ± 43%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.13 ±  8%      +0.3        0.46 ±  3%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.00            +0.3        0.33 ± 42%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.00            +0.3        0.33 ± 42%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.00            +0.3        0.33 ± 42%  perf-profile.children.cycles-pp.do_idle
      0.00            +0.3        0.33 ± 42%  perf-profile.children.cycles-pp.start_secondary
      0.23 ±  6%      +0.3        0.57 ±  3%  perf-profile.children.cycles-pp.__count_memcg_events
      0.48 ±  5%      +0.4        0.85        perf-profile.children.cycles-pp.filemap_get_entry
      0.29 ±  4%      +0.4        0.68 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      0.33 ±  5%      +0.4        0.75 ±  2%  perf-profile.children.cycles-pp.charge_memcg
      0.18 ±  2%      +0.4        0.61        perf-profile.children.cycles-pp.lru_add_fn
      0.14 ±  4%      +0.4        0.57        perf-profile.children.cycles-pp.current_time
      0.12 ±  4%      +0.4        0.55        perf-profile.children.cycles-pp.xas_descend
      0.14 ±  6%      +0.4        0.59 ±  4%  perf-profile.children.cycles-pp.xas_store
      0.13 ± 13%      +0.5        0.60 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.28 ±  3%      +0.5        0.78 ±  3%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.28 ±  5%      +0.5        0.80 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.38 ±  3%      +0.5        0.92        perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.04 ± 44%      +0.6        0.60 ±  3%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.16 ± 10%      +0.6        0.74 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.30 ±  3%      +0.6        0.88 ±  3%  perf-profile.children.cycles-pp.folio_alloc_buffers
      0.14 ±  9%      +0.6        0.73        perf-profile.children.cycles-pp.fault_in_readable
      0.21 ±  3%      +0.6        0.81 ±  2%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.15 ±  5%      +0.6        0.76        perf-profile.children.cycles-pp.atime_needs_update
      0.04 ± 44%      +0.6        0.68 ±  3%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.33 ±  5%      +0.6        0.97 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.17 ±  8%      +0.7        0.84        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.20 ±  4%      +0.7        0.87        perf-profile.children.cycles-pp.touch_atime
      0.15 ±  5%      +0.7        0.85 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.12 ±  8%      +0.7        0.83 ±  3%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.38 ±  3%      +0.7        1.12        perf-profile.children.cycles-pp.folio_alloc
      0.17 ±  4%      +0.9        1.03        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.19 ±  4%      +0.9        1.08        perf-profile.children.cycles-pp.security_file_permission
      0.24 ±  3%      +1.0        1.20        perf-profile.children.cycles-pp.xas_load
      0.11 ±  4%      +1.0        1.07        perf-profile.children.cycles-pp.folio_account_cleaned
      0.16 ±  3%      +1.1        1.23        perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.80            +1.1        1.90 ±  2%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.32 ±  4%      +1.1        1.46        perf-profile.children.cycles-pp.copyin
      0.24 ±  3%      +1.1        1.39        perf-profile.children.cycles-pp.__entry_text_start
      0.17 ±  4%      +1.2        1.40        perf-profile.children.cycles-pp.folio_account_dirtied
      0.40            +1.3        1.70        perf-profile.children.cycles-pp.__folio_mark_dirty
      0.88            +1.3        2.21        perf-profile.children.cycles-pp.mark_buffer_dirty
      0.00            +1.3        1.33        perf-profile.children.cycles-pp.lru_add_drain_cpu
      1.22            +1.4        2.63        perf-profile.children.cycles-pp.__filemap_add_folio
      0.43 ±  3%      +1.4        1.85        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.31 ±  2%      +1.5        1.76 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.93 ± 16%      +1.5        2.39 ± 18%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.93 ± 16%      +1.5        2.39 ± 19%  perf-profile.children.cycles-pp.do_unlinkat
      0.94 ± 16%      +1.5        2.41 ± 18%  perf-profile.children.cycles-pp.unlink
      0.35 ±  7%      +1.5        1.83        perf-profile.children.cycles-pp.copyout
      0.22 ±  2%      +1.6        1.79        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.39 ±  7%      +1.6        2.04        perf-profile.children.cycles-pp._copy_to_iter
      0.84 ±  7%      +1.7        2.52 ±  4%  perf-profile.children.cycles-pp.filemap_get_read_batch
      0.46 ±  2%      +1.7        2.17        perf-profile.children.cycles-pp.try_to_free_buffers
      0.44 ±  7%      +1.8        2.25        perf-profile.children.cycles-pp.copy_page_to_iter
      0.60 ±  3%      +1.8        2.42        perf-profile.children.cycles-pp.memset_orig
      0.57 ±  2%      +1.8        2.42        perf-profile.children.cycles-pp.zero_user_segments
      0.78 ± 21%      +1.8        2.62 ± 15%  perf-profile.children.cycles-pp.open_last_lookups
      0.79 ± 20%      +1.9        2.66 ± 15%  perf-profile.children.cycles-pp.__x64_sys_creat
      0.80 ± 21%      +1.9        2.68 ± 15%  perf-profile.children.cycles-pp.creat64
      0.82 ± 20%      +1.9        2.73 ± 14%  perf-profile.children.cycles-pp.do_filp_open
      0.82 ± 20%      +1.9        2.73 ± 14%  perf-profile.children.cycles-pp.path_openat
      0.83 ± 19%      +1.9        2.76 ± 14%  perf-profile.children.cycles-pp.do_sys_openat2
      0.90 ±  7%      +1.9        2.85 ±  4%  perf-profile.children.cycles-pp.filemap_get_pages
      1.92            +2.0        3.88        perf-profile.children.cycles-pp.__block_commit_write
      0.96            +2.0        3.00        perf-profile.children.cycles-pp.truncate_cleanup_folio
      1.97            +2.1        4.08        perf-profile.children.cycles-pp.block_write_end
      0.30 ±  3%      +2.3        2.64        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      2.97            +2.7        5.69        perf-profile.children.cycles-pp.ext4_block_write_begin
      1.05 ± 28%      +2.9        3.94 ± 20%  perf-profile.children.cycles-pp.osq_lock
      1.88 ± 16%      +2.9        4.78 ± 17%  perf-profile.children.cycles-pp.down_write
      1.32 ± 23%      +3.1        4.40 ± 18%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      1.28 ± 24%      +3.1        4.38 ± 18%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      0.00            +4.8        4.77        perf-profile.children.cycles-pp.ext4_da_do_write_end
      2.34 ±  3%      +5.3        7.67 ±  2%  perf-profile.children.cycles-pp.filemap_read
      2.73 ±  2%      +7.5       10.27        perf-profile.children.cycles-pp.vfs_read
      2.85 ±  2%      +8.0       10.83        perf-profile.children.cycles-pp.ksys_read
      3.34           +10.2       13.56        perf-profile.children.cycles-pp.read
      0.77           +20.8       21.61        perf-profile.children.cycles-pp.folio_add_lru
      1.99           +22.3       24.25        perf-profile.children.cycles-pp.filemap_add_folio
      0.57 ±  2%     +22.3       22.85        perf-profile.children.cycles-pp.folio_batch_move_lru
      0.58 ±  2%     +23.2       23.81        perf-profile.children.cycles-pp.release_pages
      3.24           +23.6       26.84        perf-profile.children.cycles-pp.__filemap_get_folio
      0.56 ±  3%     +24.2       24.79        perf-profile.children.cycles-pp.__folio_batch_release
      6.39           +26.8       33.22        perf-profile.children.cycles-pp.ext4_da_write_begin
      1.98 ±  2%     +27.1       29.07        perf-profile.children.cycles-pp.truncate_inode_pages_range
      2.11 ±  2%     +27.1       29.25        perf-profile.children.cycles-pp.ext4_evict_inode
      2.12 ±  2%     +27.2       29.28        perf-profile.children.cycles-pp.evict
      2.13 ±  2%     +27.2       29.30        perf-profile.children.cycles-pp.__dentry_kill
      2.13 ±  2%     +27.2       29.30        perf-profile.children.cycles-pp.dentry_kill
      2.14 ±  2%     +27.2       29.32        perf-profile.children.cycles-pp.dput
      2.17           +27.2       29.36        perf-profile.children.cycles-pp.task_work_run
      2.14 ±  2%     +27.2       29.33        perf-profile.children.cycles-pp.__fput
      2.17           +27.2       29.37        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      2.15 ±  2%     +27.2       29.37        perf-profile.children.cycles-pp.__close
      2.21           +27.3       29.56        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.27           +27.6       29.89        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.84           +43.7       44.52        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.53 ±  4%     +43.8       44.29        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.42 ±  3%     +43.8       44.20        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     28.19           -28.1        0.14 ± 12%  perf-profile.self.cycles-pp.start_this_handle
     15.34 ±  2%     -15.3        0.03 ± 70%  perf-profile.self.cycles-pp.add_transaction_credits
     13.40 ±  2%     -13.4        0.00        perf-profile.self.cycles-pp.jbd2_journal_stop
     13.36 ±  6%     -13.4        0.00        perf-profile.self.cycles-pp.stop_this_handle
      1.75 ±  7%      -1.6        0.10 ±  3%  perf-profile.self.cycles-pp.__mark_inode_dirty
      1.58 ±  2%      -1.5        0.05 ±  7%  perf-profile.self.cycles-pp.__find_get_block
      1.35 ± 10%      -1.3        0.08 ±  8%  perf-profile.self.cycles-pp._raw_read_lock
      0.75 ±  4%      -0.3        0.42 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.54 ±  3%      -0.3        0.26 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.53 ±  6%      -0.3        0.26        perf-profile.self.cycles-pp.down_write
      0.36 ±  3%      -0.2        0.16 ±  2%  perf-profile.self.cycles-pp.folio_create_empty_buffers
      0.44 ± 16%      -0.2        0.25 ±  3%  perf-profile.self.cycles-pp.up_write
      0.38 ±  9%      -0.2        0.18 ±  5%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.41 ±  3%      -0.2        0.26 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.22 ±  3%      -0.1        0.08 ±  5%  perf-profile.self.cycles-pp.folio_add_lru
      0.21 ±  4%      -0.1        0.08 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.44            -0.1        0.37 ±  2%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.11            -0.1        0.06        perf-profile.self.cycles-pp.up_read
      0.10            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp._raw_write_lock
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.09 ±  7%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.filemap_free_folio
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.down_read
      0.06 ±  6%      +0.0        0.09 ±  6%  perf-profile.self.cycles-pp.try_charge_memcg
      0.30 ±  3%      +0.0        0.33 ±  2%  perf-profile.self.cycles-pp.block_invalidate_folio
      0.02 ±141%      +0.0        0.06 ± 13%  perf-profile.self.cycles-pp.update_cfs_group
      0.13 ±  5%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.alloc_buffer_head
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.zero_user_segments
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.xas_set_mark
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.ext4_invalidate_folio
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.folio_wait_stable
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.ext4_es_can_be_merged
      0.08 ±  7%      +0.1        0.14 ± 11%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.12 ±  6%      +0.1        0.17 ±  6%  perf-profile.self.cycles-pp.cgroup_rstat_flush_locked
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.refill_obj_stock
      0.01 ±223%      +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__es_remove_extent
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ext4_has_free_clusters
      0.06 ± 13%      +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.08 ±  4%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.00            +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.uncharge_folio
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.xas_find
      0.04 ± 71%      +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.__count_memcg_events
      0.03 ± 70%      +0.1        0.10        perf-profile.self.cycles-pp.page_counter_uncharge
      0.04 ± 44%      +0.1        0.11        perf-profile.self.cycles-pp.touch_atime
      0.09            +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.drop_buffers
      0.08 ±  7%      +0.1        0.15 ±  8%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.node_page_state
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.free_unref_page_list
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.try_to_free_buffers
      0.00            +0.1        0.08        perf-profile.self.cycles-pp.charge_memcg
      0.06 ±  8%      +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.ext4_generic_write_checks
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.ext4_es_insert_delayed_block
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.__x64_sys_read
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.xas_clear_mark
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.00            +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.alloc_pages
      0.00            +0.1        0.09 ±  6%  perf-profile.self.cycles-pp.folio_alloc_buffers
      0.00            +0.1        0.09 ± 10%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.inode_to_bdi
      0.00            +0.1        0.10 ±  5%  perf-profile.self.cycles-pp.folio_memcg_lock
      0.06 ±  8%      +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.generic_file_read_iter
      0.10 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.__es_insert_extent
      0.13 ±  3%      +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.lru_add_fn
      0.02 ±141%      +0.1        0.12 ±  7%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.00            +0.1        0.11 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.rw_verify_area
      0.06            +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.rcu_all_qs
      0.00            +0.1        0.11 ±  3%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.18 ±  2%      +0.1        0.30 ±  3%  perf-profile.self.cycles-pp.find_lock_entries
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.02 ± 99%      +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.__alloc_pages
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.ext4_release_folio
      0.39 ±  3%      +0.1        0.51 ±  3%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.37 ±  3%      +0.1        0.49 ±  3%  perf-profile.self.cycles-pp.__filemap_get_folio
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.08 ±  5%      +0.1        0.22 ±  2%  perf-profile.self.cycles-pp.block_write_end
      0.02 ± 99%      +0.1        0.16 ±  3%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.00            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.folio_account_dirtied
      0.00            +0.1        0.14 ±  6%  perf-profile.self.cycles-pp.__file_remove_privs
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.00            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.05 ±  8%      +0.1        0.20 ±  4%  perf-profile.self.cycles-pp.generic_write_checks
      0.00            +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.00            +0.2        0.16 ± 43%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.00            +0.2        0.16 ±  2%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.node_dirty_ok
      0.25 ±  5%      +0.2        0.43 ±  5%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.00            +0.2        0.18 ±  5%  perf-profile.self.cycles-pp.ksys_write
      0.02 ± 99%      +0.2        0.21 ±  3%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.09 ±  5%      +0.2        0.27 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.2        0.19 ±  4%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.00            +0.2        0.19 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.2        0.20 ±  2%  perf-profile.self.cycles-pp.aa_file_perm
      0.00            +0.2        0.20 ±  4%  perf-profile.self.cycles-pp.ksys_read
      0.18 ±  5%      +0.2        0.38 ±  3%  perf-profile.self.cycles-pp.release_pages
      0.06 ±  9%      +0.2        0.26 ±  6%  perf-profile.self.cycles-pp.disk_cp
      0.06 ±  6%      +0.2        0.27        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.2        0.21 ±  4%  perf-profile.self.cycles-pp._copy_to_iter
      0.06 ±  8%      +0.2        0.27 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.00            +0.2        0.22 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.2        0.22 ±  2%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.02 ±141%      +0.2        0.24 ±  4%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.00            +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.mod_objcg_state
      0.00            +0.2        0.22 ±  2%  perf-profile.self.cycles-pp.file_modified_flags
      0.00            +0.2        0.24 ±  7%  perf-profile.self.cycles-pp.fsnotify_perm
      0.05 ±  8%      +0.2        0.29 ±  3%  perf-profile.self.cycles-pp.do_syscall_64
      0.07 ± 10%      +0.2        0.31 ±  2%  perf-profile.self.cycles-pp.xas_store
      0.01 ±223%      +0.2        0.26 ±  2%  perf-profile.self.cycles-pp.security_file_permission
      0.07 ±  5%      +0.3        0.32 ±  5%  perf-profile.self.cycles-pp.xas_start
      0.16 ±  4%      +0.3        0.41        perf-profile.self.cycles-pp.__cond_resched
      0.14 ±  3%      +0.3        0.39 ±  2%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.06 ±  7%      +0.3        0.32        perf-profile.self.cycles-pp.filemap_get_pages
      0.12 ±  6%      +0.3        0.39        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.08 ±  6%      +0.3        0.35        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.10 ±  8%      +0.3        0.40        perf-profile.self.cycles-pp.current_time
      0.08 ±  6%      +0.3        0.38 ±  2%  perf-profile.self.cycles-pp.atime_needs_update
      0.09 ±  7%      +0.3        0.41        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ±  4%      +0.3        0.41        perf-profile.self.cycles-pp.xas_load
      0.09 ±  7%      +0.3        0.43        perf-profile.self.cycles-pp.__entry_text_start
      0.10 ±  5%      +0.4        0.48 ±  2%  perf-profile.self.cycles-pp.xas_descend
      0.12 ±  6%      +0.4        0.50 ±  2%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.10 ±  3%      +0.4        0.51 ±  6%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.10 ±  4%      +0.4        0.52 ±  2%  perf-profile.self.cycles-pp.generic_perform_write
      0.12 ± 11%      +0.4        0.57 ±  5%  perf-profile.self.cycles-pp.__fget_light
      0.11 ± 15%      +0.5        0.56 ±  3%  perf-profile.self.cycles-pp.write
      0.00            +0.5        0.45 ±  2%  perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.10 ±  5%      +0.5        0.55 ±  2%  perf-profile.self.cycles-pp.read
      0.10 ±  4%      +0.5        0.60 ±  2%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.03 ± 70%      +0.6        0.58 ±  3%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.13 ±  5%      +0.6        0.70 ±  2%  perf-profile.self.cycles-pp.fault_in_readable
      0.02 ± 99%      +0.6        0.65 ±  4%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.10 ± 11%      +0.6        0.75 ±  3%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.85            +0.7        1.54        perf-profile.self.cycles-pp.__block_commit_write
      0.10 ±  7%      +0.7        0.80 ±  4%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.16 ±  4%      +0.7        0.87        perf-profile.self.cycles-pp.vfs_read
      0.79 ±  4%      +0.8        1.59 ±  5%  perf-profile.self.cycles-pp.filemap_read
      0.16 ±  3%      +0.8        1.00        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.07 ±  5%      +1.0        1.04 ±  2%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.18 ±  4%      +1.0        1.21 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.31 ±  4%      +1.1        1.43        perf-profile.self.cycles-pp.copyin
      0.73 ±  8%      +1.3        2.02 ±  5%  perf-profile.self.cycles-pp.filemap_get_read_batch
      0.18 ±  4%      +1.4        1.56 ±  2%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.35 ±  8%      +1.5        1.80        perf-profile.self.cycles-pp.copyout
      0.60 ±  2%      +1.8        2.39        perf-profile.self.cycles-pp.memset_orig
      1.04 ± 28%      +2.9        3.91 ± 20%  perf-profile.self.cycles-pp.osq_lock
      0.53 ±  4%     +43.8       44.29        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/disk_rr/aim7

commit: 
  bb15cea20f ("ext4: rename s_error_work to s_sb_upd_work")
  03de20bed2 ("ext4: do not mark inode dirty every time when appending using delalloc")

bb15cea20f211e11 03de20bed203b0819225d4de983 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   1723173 ±  2%     -10.2%    1547921        cpuidle..usage
    128.82           -33.7%      85.36        uptime.boot
     19.77 ±  2%    +113.9%      42.29        iostat.cpu.idle
     79.39           -29.0%      56.38        iostat.cpu.system
      0.84           +57.4%       1.32        iostat.cpu.user
     17.60 ±  3%     +21.1       38.69        mpstat.cpu.all.idle%
      0.00 ± 54%      -0.0        0.00        mpstat.cpu.all.iowait%
     80.43           -21.5       58.92        mpstat.cpu.all.sys%
      0.86            +0.5        1.36        mpstat.cpu.all.usr%
    342.83 ±  8%     -98.8%       4.17 ± 69%  perf-c2c.DRAM.local
      9406 ±  7%     -98.8%     108.33 ± 39%  perf-c2c.DRAM.remote
      9020 ± 10%     -98.5%     132.17 ± 36%  perf-c2c.HITM.local
      1793 ± 21%     -97.0%      53.33 ± 71%  perf-c2c.HITM.remote
     10813 ±  6%     -98.3%     185.50 ± 18%  perf-c2c.HITM.total
     19.17          +117.4%      41.67        vmstat.cpu.id
     12405 ±  5%    +127.7%      28251        vmstat.io.bo
      2273 ±  2%     -16.1%       1908 ±  5%  vmstat.memory.buff
   4816370           -22.9%    3713859        vmstat.memory.cache
    174.50 ±  6%     -37.0%     110.00 ±  3%  vmstat.procs.r
    188288           +12.2%     211198 ±  3%  vmstat.system.in
    252467          +144.2%     616452        aim7.jobs-per-min
     71.53           -58.9%      29.43        aim7.time.elapsed_time
     71.53           -58.9%      29.43        aim7.time.elapsed_time.max
    382798 ±  3%     -68.8%     119583        aim7.time.involuntary_context_switches
    214968           -25.7%     159736        aim7.time.minor_page_faults
      7502           -68.9%       2332        aim7.time.system_time
     52.82 ±  2%     -17.3%      43.66        aim7.time.user_time
     78215 ±  2%     -60.4%      30966        aim7.time.voluntary_context_switches
      2130           -26.8%       1558        turbostat.Avg_MHz
     82.08           -20.9       61.22        turbostat.Busy%
     18.12 ±  2%     +20.4       38.48        turbostat.C1%
     17.92 ±  2%    +116.4%      38.78        turbostat.CPU%c1
      0.05        +37213.3%      18.66 ± 81%  turbostat.IPC
  14003643           -50.8%    6887302 ±  3%  turbostat.IRQ
     72.83            +5.9%      77.17        turbostat.PkgTmp
    331.45            -1.6%     326.14        turbostat.PkgWatt
     33.10           +17.8%      38.98        turbostat.RAMWatt
    262284           -77.6%      58810 ±  9%  meminfo.Active
    241854           -93.5%      15644 ± 32%  meminfo.Active(anon)
     20429 ±  3%    +111.3%      43165        meminfo.Active(file)
     97809 ±  9%     -33.1%      65414 ± 10%  meminfo.AnonHugePages
      2265 ±  2%     -16.8%       1885 ±  5%  meminfo.Buffers
   4611269           -23.1%    3547492        meminfo.Cached
   3126441           -11.4%    2770620        meminfo.Committed_AS
   1506425           -53.1%     706352        meminfo.Dirty
   2132411           -39.5%    1289503        meminfo.Inactive
   1504094           -54.1%     689689        meminfo.Inactive(file)
    207534           -15.6%     175182        meminfo.KReclaimable
    161029 ±  6%     -48.0%      83676        meminfo.Mapped
   8599440           -10.8%    7672383        meminfo.Memused
    207534           -15.6%     175182        meminfo.SReclaimable
    341497 ±  2%     -77.1%      78086 ±  8%  meminfo.Shmem
   9218114           -14.4%    7891596        meminfo.max_used_kB
     30311 ±110%     -90.4%       2897 ± 65%  numa-meminfo.node0.Active(anon)
      9895 ± 10%    +115.2%      21300 ±  6%  numa-meminfo.node0.Active(file)
    818307 ±  8%     -56.5%     355620 ±  2%  numa-meminfo.node0.Dirty
   2703666 ± 48%     -49.9%    1353551 ± 92%  numa-meminfo.node0.FilePages
   1057080 ± 15%     -46.7%     563740 ± 27%  numa-meminfo.node0.Inactive
    815861 ±  9%     -57.7%     345209 ±  2%  numa-meminfo.node0.Inactive(file)
     68353 ± 33%     -50.7%      33672 ± 43%  numa-meminfo.node0.Mapped
     48185 ±105%     -86.9%       6320 ± 30%  numa-meminfo.node0.Shmem
    219039 ± 15%     -84.3%      34397 ± 13%  numa-meminfo.node1.Active
    208571 ± 16%     -93.8%      12945 ± 35%  numa-meminfo.node1.Active(anon)
     10467 ±  9%    +104.9%      21451 ±  4%  numa-meminfo.node1.Active(file)
    689171 ±  9%     -50.2%     343314 ±  2%  numa-meminfo.node1.Dirty
   1078758 ± 13%     -33.5%     717900 ± 21%  numa-meminfo.node1.Inactive
    689488 ±  9%     -51.3%     335956        numa-meminfo.node1.Inactive(file)
     94869 ± 19%     -44.6%      52583 ± 27%  numa-meminfo.node1.Mapped
    291464 ± 17%     -74.8%      73424 ±  7%  numa-meminfo.node1.Shmem
      7577 ±110%     -90.4%     724.00 ± 65%  numa-vmstat.node0.nr_active_anon
      2428 ± 10%    +121.3%       5374 ±  7%  numa-vmstat.node0.nr_active_file
    204163 ±  9%     -56.6%      88706 ±  2%  numa-vmstat.node0.nr_dirty
    675553 ± 48%     -49.9%     338176 ± 92%  numa-vmstat.node0.nr_file_pages
    203573 ±  9%     -57.7%      86058 ±  2%  numa-vmstat.node0.nr_inactive_file
     17153 ± 33%     -50.7%       8454 ± 43%  numa-vmstat.node0.nr_mapped
     12071 ±105%     -86.9%       1579 ± 30%  numa-vmstat.node0.nr_shmem
      7577 ±110%     -90.4%     724.00 ± 65%  numa-vmstat.node0.nr_zone_active_anon
      2435 ± 10%    +121.2%       5386 ±  7%  numa-vmstat.node0.nr_zone_active_file
    203552 ±  9%     -57.7%      86058 ±  2%  numa-vmstat.node0.nr_zone_inactive_file
    204146 ±  9%     -56.5%      88717 ±  2%  numa-vmstat.node0.nr_zone_write_pending
     52113 ± 16%     -93.8%       3251 ± 36%  numa-vmstat.node1.nr_active_anon
      2562 ± 10%    +110.5%       5393 ±  3%  numa-vmstat.node1.nr_active_file
    171975 ±  9%     -50.3%      85426        numa-vmstat.node1.nr_dirty
    172062 ±  9%     -51.4%      83604        numa-vmstat.node1.nr_inactive_file
     23751 ± 20%     -44.1%      13274 ± 27%  numa-vmstat.node1.nr_mapped
     72823 ± 17%     -74.6%      18516 ±  8%  numa-vmstat.node1.nr_shmem
     52113 ± 16%     -93.8%       3251 ± 36%  numa-vmstat.node1.nr_zone_active_anon
      2564 ± 10%    +110.1%       5387 ±  3%  numa-vmstat.node1.nr_zone_active_file
    172057 ±  9%     -51.4%      83609        numa-vmstat.node1.nr_zone_inactive_file
    171971 ±  9%     -50.3%      85427        numa-vmstat.node1.nr_zone_write_pending
     59782           -93.4%       3929 ± 32%  proc-vmstat.nr_active_anon
      5191 ±  2%    +111.6%      10983 ±  4%  proc-vmstat.nr_active_file
    132519            +1.4%     134318        proc-vmstat.nr_anon_pages
    377321           -53.3%     176172        proc-vmstat.nr_dirty
   1153742           -23.1%     887078        proc-vmstat.nr_file_pages
    157898            -5.0%     149977        proc-vmstat.nr_inactive_anon
    376725           -54.4%     171791        proc-vmstat.nr_inactive_file
     65711            -5.0%      62415        proc-vmstat.nr_kernel_stack
     40889 ±  6%     -48.3%      21157        proc-vmstat.nr_mapped
     85035 ±  2%     -76.8%      19690 ±  8%  proc-vmstat.nr_shmem
     51936           -15.8%      43753        proc-vmstat.nr_slab_reclaimable
     90416            -3.2%      87489        proc-vmstat.nr_slab_unreclaimable
     59782           -93.4%       3929 ± 32%  proc-vmstat.nr_zone_active_anon
      5191 ±  2%    +111.5%      10981 ±  4%  proc-vmstat.nr_zone_active_file
    157898            -5.0%     149977        proc-vmstat.nr_zone_inactive_anon
    376725           -54.4%     171792        proc-vmstat.nr_zone_inactive_file
    377321           -53.3%     176172        proc-vmstat.nr_zone_write_pending
     68692 ± 13%    -100.0%       0.33 ±223%  proc-vmstat.numa_hint_faults
     37456 ± 23%    -100.0%       0.00        proc-vmstat.numa_hint_faults_local
     28172 ± 15%    -100.0%       0.33 ±223%  proc-vmstat.numa_pages_migrated
    189054 ±  5%    -100.0%       0.33 ±223%  proc-vmstat.numa_pte_updates
    738258           -40.5%     439447        proc-vmstat.pgfault
     28172 ± 15%    -100.0%       0.33 ±223%  proc-vmstat.pgmigrate_success
     44981 ±  8%     -66.1%      15239        proc-vmstat.pgreuse
      1613            -2.9%       1566        proc-vmstat.unevictable_pgs_culled
    666880           -49.3%     337792        proc-vmstat.unevictable_pgs_scanned
      0.78 ± 13%     -85.1%       0.12 ± 16%  sched_debug.cfs_rq:/.h_nr_running.avg
      2.42 ± 14%     -44.8%       1.33 ± 35%  sched_debug.cfs_rq:/.h_nr_running.max
      0.50 ±  9%     -35.1%       0.33 ±  9%  sched_debug.cfs_rq:/.h_nr_running.stddev
   3336418           -99.9%       2120 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
   4091074           -99.6%      15421 ± 21%  sched_debug.cfs_rq:/.min_vruntime.max
   2729646 ±  2%    -100.0%      84.64 ± 23%  sched_debug.cfs_rq:/.min_vruntime.min
    150356 ± 11%     -98.0%       2962 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.55 ±  2%     -78.8%       0.12 ± 16%  sched_debug.cfs_rq:/.nr_running.avg
      0.22 ± 26%     +46.0%       0.33 ±  9%  sched_debug.cfs_rq:/.nr_running.stddev
    104.84 ± 32%   +1296.4%       1464 ±193%  sched_debug.cfs_rq:/.removed.load_avg.stddev
    305.17 ± 30%     +71.9%     524.67        sched_debug.cfs_rq:/.removed.runnable_avg.max
     47.09 ± 33%     +83.8%      86.56 ± 18%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
    304.33 ± 30%     +72.4%     524.67        sched_debug.cfs_rq:/.removed.util_avg.max
     47.01 ± 33%     +84.1%      86.56 ± 18%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    893.57 ±  8%     -70.8%     261.21 ±  8%  sched_debug.cfs_rq:/.runnable_avg.avg
      2485 ±  8%     -41.5%       1454 ± 16%  sched_debug.cfs_rq:/.runnable_avg.max
    120.50 ± 53%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    453.52 ±  8%     -31.2%     311.84 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -250714           -97.7%      -5771        sched_debug.cfs_rq:/.spread0.avg
    506441 ± 24%     -98.5%       7479 ± 63%  sched_debug.cfs_rq:/.spread0.max
   -862785           -99.1%      -7847        sched_debug.cfs_rq:/.spread0.min
    151706 ± 10%     -98.1%       2956 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
    622.04 ±  2%     -58.1%     260.93 ±  8%  sched_debug.cfs_rq:/.util_avg.avg
     92.42 ± 51%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    487.13 ± 15%     -95.7%      20.84 ± 16%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1745 ± 11%     -52.6%     827.17        sched_debug.cfs_rq:/.util_est_enqueued.max
    301.49 ± 11%     -65.0%     105.52 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    360203 ±  9%     -98.7%       4769 ± 24%  sched_debug.cpu.avg_idle.min
    151624 ±  5%     +62.2%     245997 ± 12%  sched_debug.cpu.avg_idle.stddev
     86676 ±  2%     -36.1%      55376        sched_debug.cpu.clock.avg
     86715 ±  2%     -36.1%      55382        sched_debug.cpu.clock.max
     86634 ±  2%     -36.1%      55367        sched_debug.cpu.clock.min
     22.66 ± 35%     -84.8%       3.44 ± 15%  sched_debug.cpu.clock.stddev
     86209 ±  2%     -35.9%      55246        sched_debug.cpu.clock_task.avg
     86366 ±  2%     -35.9%      55372        sched_debug.cpu.clock_task.max
     78486 ±  3%     -39.3%      47614        sched_debug.cpu.clock_task.min
      3579 ±  3%     -86.9%     467.79 ± 15%  sched_debug.cpu.curr->pid.avg
      6935 ±  3%     -36.1%       4431        sched_debug.cpu.curr->pid.max
      0.78 ± 13%     -84.9%       0.12 ± 16%  sched_debug.cpu.nr_running.avg
      2.50 ± 20%     -46.7%       1.33 ± 35%  sched_debug.cpu.nr_running.max
      0.51 ± 10%     -35.4%       0.33 ±  9%  sched_debug.cpu.nr_running.stddev
      4043           -54.4%       1843        sched_debug.cpu.nr_switches.avg
      1639 ±  7%     -91.8%     133.67 ± 10%  sched_debug.cpu.nr_switches.min
      9.07 ±  3%     -99.9%       0.01 ± 44%  sched_debug.cpu.nr_uninterruptible.avg
     91.92 ± 10%     -49.0%      46.83 ± 23%  sched_debug.cpu.nr_uninterruptible.max
     12.93 ±  4%     -48.8%       6.62 ±  6%  sched_debug.cpu.nr_uninterruptible.stddev
     86634 ±  2%     -36.1%      55371        sched_debug.cpu_clk
     85404 ±  2%     -36.6%      54141        sched_debug.ktime
     87505 ±  2%     -35.7%      56242        sched_debug.sched_clk
      8.54 ±  5%     -16.4%       7.14 ±  2%  perf-stat.i.MPKI
 7.634e+09           +84.9%  1.411e+10        perf-stat.i.branch-instructions
      0.42 ±  3%      +0.1        0.57 ±  5%  perf-stat.i.branch-miss-rate%
  21013457 ±  5%     +25.0%   26259387 ±  3%  perf-stat.i.branch-misses
     27.93 ±  2%      -8.6       19.31 ±  2%  perf-stat.i.cache-miss-rate%
 1.149e+08 ±  4%     +31.9%  1.516e+08        perf-stat.i.cache-misses
  3.66e+08 ±  5%     +67.2%  6.121e+08        perf-stat.i.cache-references
      6.25           -56.7%       2.71        perf-stat.i.cpi
 2.682e+11           -26.4%  1.974e+11        perf-stat.i.cpu-cycles
      1093           -18.0%     897.29 ±  2%  perf-stat.i.cpu-migrations
   2034287 ±  8%     -25.0%    1526568 ± 10%  perf-stat.i.dTLB-load-misses
 1.084e+10           +73.6%  1.882e+10        perf-stat.i.dTLB-loads
 6.143e+09           +63.7%  1.005e+10        perf-stat.i.dTLB-stores
 3.899e+10           +78.9%  6.977e+10        perf-stat.i.instructions
      0.22          +101.0%       0.44 ±  3%  perf-stat.i.ipc
      2.09           -26.4%       1.54        perf-stat.i.metric.GHz
    671.89 ±  2%     +28.3%     861.92 ±  3%  perf-stat.i.metric.K/sec
    194.89           +74.3%     339.70        perf-stat.i.metric.M/sec
      8141 ±  2%     +18.0%       9609        perf-stat.i.minor-faults
  29102266           +15.7%   33660531        perf-stat.i.node-load-misses
    965648           +32.4%    1278390        perf-stat.i.node-loads
     29.43 ±  5%     +51.7       81.15 ±  3%  perf-stat.i.node-store-miss-rate%
   9281421 ±  2%    +304.4%   37530050        perf-stat.i.node-store-misses
  33504110           -81.5%    6202090        perf-stat.i.node-stores
      8163 ±  2%     +18.3%       9660        perf-stat.i.page-faults
      0.27 ±  6%      -0.1        0.18 ±  3%  perf-stat.overall.branch-miss-rate%
     31.39 ±  2%      -6.6       24.79        perf-stat.overall.cache-miss-rate%
      6.89           -58.9%       2.83        perf-stat.overall.cpi
      2339 ±  4%     -44.4%       1301        perf-stat.overall.cycles-between-cache-misses
      0.02 ±  7%      -0.0        0.01 ± 10%  perf-stat.overall.dTLB-load-miss-rate%
      0.15          +143.2%       0.35        perf-stat.overall.ipc
     21.66           +64.2       85.83        perf-stat.overall.node-store-miss-rate%
 7.722e+09           +78.4%  1.378e+10        perf-stat.ps.branch-instructions
  20820327 ±  6%     +21.6%   25308344 ±  3%  perf-stat.ps.branch-misses
 1.164e+08 ±  4%     +27.4%  1.483e+08        perf-stat.ps.cache-misses
 3.712e+08 ±  5%     +61.1%   5.98e+08        perf-stat.ps.cache-references
    126096            -3.6%     121517        perf-stat.ps.cpu-clock
 2.717e+11           -29.0%  1.929e+11        perf-stat.ps.cpu-cycles
      1090           -20.8%     863.63        perf-stat.ps.cpu-migrations
   2190166 ±  7%     -32.1%    1487512 ± 10%  perf-stat.ps.dTLB-load-misses
 1.097e+10           +67.5%  1.837e+10        perf-stat.ps.dTLB-loads
  6.22e+09           +57.8%  9.818e+09        perf-stat.ps.dTLB-stores
 3.944e+10           +72.6%  6.809e+10        perf-stat.ps.instructions
      7973           +12.3%       8955        perf-stat.ps.minor-faults
  29509182           +11.5%   32917369        perf-stat.ps.node-load-misses
    977623           +27.9%    1250573        perf-stat.ps.node-loads
   9389484 ±  2%    +290.6%   36679412        perf-stat.ps.node-store-misses
  33960848           -82.2%    6054255        perf-stat.ps.node-stores
      7992           +12.6%       9001        perf-stat.ps.page-faults
    126096            -3.6%     121517        perf-stat.ps.task-clock
  2.85e+12           -30.8%  1.973e+12        perf-stat.total.instructions
      0.09 ±107%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      1.93 ±119%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      0.13 ±139%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      2.68 ± 55%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      0.27 ± 50%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.80 ± 45%     -99.8%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      3.42 ±155%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      0.09 ± 99%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      0.17 ±212%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      5.01 ±159%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      0.26 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.86 ± 27%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      0.04 ±138%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      2.06 ± 64%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      2.58 ± 47%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3.24 ± 82%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
      0.36 ± 95%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     11.76 ± 13%    -100.0%       0.00 ± 39%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1.99 ±135%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.17 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ±121%     -98.2%       0.01 ± 47%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      9.00 ± 78%     -99.9%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.02 ± 29%     -76.4%       0.01 ± 48%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      3.15 ±128%     -99.9%       0.00 ± 16%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.07 ± 58%     -93.3%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.29 ± 62%     -98.8%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.48 ±165%     -99.9%       0.00 ±223%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.21 ±128%     -97.7%       0.00 ± 40%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      4.50 ± 87%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.08 ±155%     -94.7%       0.00 ± 11%  perf-sched.sch_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.09 ±122%     -93.3%       0.01 ± 34%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.30 ±195%     -98.8%       0.00 ± 20%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.27 ±145%     -97.9%       0.01 ± 13%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.11 ± 61%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      0.67 ± 60%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      2.15 ±159%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.12 ± 86%     -96.7%       0.00 ± 46%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 26%     -66.2%       0.01 ± 32%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.18 ±159%     -96.7%       0.01        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.43 ±139%     -99.6%       0.01 ± 24%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      1.88 ± 18%     -99.9%       0.00 ± 72%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2.82 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      5.88 ±135%     -99.6%       0.02 ± 39%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.18 ±115%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      1110 ±132%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      2.47 ±145%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      2.30 ±197%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      3197 ±  7%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     33.31 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.80 ± 45%     -99.8%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.__flush_work.isra.0.__lru_add_drain_all
      1075 ±135%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      7.21 ±222%     -99.9%       0.01 ± 54%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     14.86 ± 90%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      2.07 ±212%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      1117 ±131%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
     11.66 ± 95%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
     14.80 ± 26%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      2.85 ±139%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      2648 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
    570.68 ±219%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      3183 ±  8%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2128 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     11.66 ±101%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     54.37 ± 33%    -100.0%       0.01 ± 91%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      1046 ±136%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      8.16 ± 21%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.99 ±130%     -99.8%       0.01 ± 47%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      9.00 ± 78%     -99.9%       0.01 ± 29%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ± 35%     -81.8%       0.01 ± 66%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    347.59 ±136%     -99.9%       0.23 ±179%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      5.55 ± 81%     -97.9%       0.12 ±148%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     26.85 ± 64%    -100.0%       0.01 ± 32%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      4.95 ±144%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
    565.29 ±187%    -100.0%       0.01 ± 14%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     11.46 ± 82%    -100.0%       0.00        perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
    188.76 ±199%    -100.0%       0.02 ± 31%  perf-sched.sch_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      2.03 ±141%     -99.6%       0.01 ± 43%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.87 ±206%     -99.2%       0.01 ±  6%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      2.56 ±144%     -99.5%       0.01 ± 27%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      8.45 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      1183 ±123%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1110 ±135%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      6.34 ± 81%     -99.9%       0.01 ± 45%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.07 ± 65%     -81.6%       0.01 ± 47%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
    203.42 ±169%    -100.0%       0.02 ± 44%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3.62 ±140%     -99.6%       0.01 ± 39%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     11.42 ±  8%    -100.0%       0.00 ± 72%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    143.19 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    876.61 ± 42%     -99.7%       3.03 ± 10%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.96 ± 44%     -99.6%       0.01 ± 12%  perf-sched.total_sch_delay.average.ms
      3798 ± 23%     -99.9%       3.57 ± 21%  perf-sched.total_sch_delay.max.ms
    170.08 ±  5%     -80.6%      32.98 ±  5%  perf-sched.total_wait_and_delay.average.ms
     47617 ±  7%     -91.2%       4188 ± 14%  perf-sched.total_wait_and_delay.count.ms
      5337 ± 22%     -85.0%     799.08 ± 25%  perf-sched.total_wait_and_delay.max.ms
    168.12 ±  6%     -80.4%      32.97 ±  5%  perf-sched.total_wait_time.average.ms
      4119 ± 13%     -80.6%     799.08 ± 25%  perf-sched.total_wait_time.max.ms
    214.77 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
    201.88 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    184.46 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    194.96 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      4.51 ± 17%     -69.9%       1.36 ± 44%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     69.87 ±115%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    210.55 ± 25%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
    185.27 ± 20%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
    191.45 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    203.42 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     72.74 ± 86%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
    800.01          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    772.30 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    247.62 ±  9%     -98.8%       3.08 ± 51%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     43.76 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     25.18 ±  8%     -95.4%       1.15 ± 33%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    553.97 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    382.69 ±  3%     -86.3%      52.38 ± 62%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     53.60 ± 24%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    164.50 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    453.57           -53.7%     209.84 ± 44%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.38 ±  3%     +63.0%       7.14 ±  9%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    666.23 ±  9%     -79.4%     137.41 ± 13%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    625.57 ±  3%     -94.6%      33.55 ± 16%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    643.50 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
     14307 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    273.67 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    503.67 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
    315.83 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    389.83 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      2520 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      9115 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    924.67 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
    570.17 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
     10.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.17 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    121.67 ±  2%    +522.2%     757.00 ± 20%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      4129 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2875 ± 10%     -81.7%     525.33 ± 18%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     22.50 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     12.83 ±  2%     +46.8%      18.83 ±  7%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3359 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1518 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
     20.00 ±  2%     -83.3%       3.33 ± 44%  perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1176 ±  6%     -89.9%     119.33 ± 18%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1334 ± 10%     -40.4%     794.83 ± 14%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3168 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      4744 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      3119 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3583 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      1014 ±  3%     -38.3%     625.75 ± 42%  perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2511 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      3142 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      4102 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      4723 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3207 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
      3146 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      1005          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1414 ± 59%     -53.8%     653.76 ± 30%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3636 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1909 ±  8%     -88.2%     225.07 ± 79%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1049 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3201 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      3181 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      3966 ± 14%     -83.0%     674.45 ± 31%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2061 ± 15%     -68.5%     648.85 ± 33%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    584.00 ±151%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
    121.24 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
     17.53 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.__ext4_new_inode.ext4_create.lookup_open
     12.50 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_delete_entry.__ext4_unlink.ext4_unlink
    212.84 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
    266.04 ±212%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_inode.ext4_evict_inode.evict
     52.91 ±159%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create.lookup_open
     14.22 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
     96.37 ±189%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink.ext4_unlink
      9.30 ± 57%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.__ext4_unlink.ext4_unlink
    112.57 ± 75%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
     11.59 ± 48%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create.lookup_open
     95.92 ± 77%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
    199.20 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    108.05 ±193%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.touch_atime
     54.87 ±144%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict.__dentry_kill
    184.20 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     10.33 ± 24%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
    191.55 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
    181.38 ±151%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread.__ext4_read_dirblock
     13.38 ± 22%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode.ext4_create
     75.08 ±180%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode.ext4_evict_inode
      4.50 ± 17%     -69.8%       1.36 ± 44%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     90.92 ±201%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     69.78 ±115%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    290.24 ±107%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
     58.39 ±158%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.__fput.task_work_run
    205.54 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
    247.38 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
     10.23 ± 45%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      1.41 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      6.60 ± 22%     -99.8%       0.02 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
     57.06 ± 88%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     16.91 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.fscrypt_file_open.ext4_file_open.do_dentry_open
     62.09 ± 75%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     13.87 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.__ext4_unlink.ext4_unlink
    183.21 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
     86.31 ±154%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
    188.86 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    177.02 ± 65%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
    200.18 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
      9.56 ± 47%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
    201.66 ± 56%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     72.66 ±185%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     15.77 ± 51%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.rmap_walk_anon.migrate_pages_batch.migrate_pages.migrate_misplaced_page
     40.76 ±154%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
    258.34 ±209%    -100.0%       0.01 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
     70.75 ± 86%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
    202.23 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
    799.69          -100.0%       0.00        perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.71 ±141%    +249.3%       2.47 ± 18%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    772.28 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    244.47 ±  9%     -98.7%       3.07 ± 52%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     18.18 ± 68%     -97.8%       0.40 ±  3%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    187.11 ± 50%     -99.7%       0.51 ±216%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    141.17 ± 99%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
     41.53 ±197%    -100.0%       0.02 ±223%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     43.56 ± 22%     -99.9%       0.04 ± 91%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     25.10 ±  8%     -95.4%       1.15 ± 33%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    553.89 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    382.43 ±  3%     -86.3%      52.38 ± 62%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    162.24 ± 94%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
    199.09 ±135%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
     99.26 ± 86%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
     52.93 ± 25%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    162.34 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      1.13 ±129%     -93.7%       0.07 ±177%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
      6.27 ± 16%     -96.5%       0.22 ± 51%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    453.55           -53.7%     209.83 ± 44%  perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.35 ±  3%     +64.0%       7.13 ±  9%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    666.04 ±  9%     -79.4%     137.41 ± 13%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.99 ±101%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    101.72 ± 69%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    619.68 ±  2%     -94.6%      33.53 ± 16%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1038 ±102%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      3022 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
     17.53 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.__ext4_new_inode.ext4_create.lookup_open
     21.53 ± 59%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_delete_entry.__ext4_unlink.ext4_unlink
      3168 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
    524.03 ±215%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_free_inode.ext4_evict_inode.evict
    529.80 ±209%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create.lookup_open
     21.63 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
    534.16 ±210%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink.ext4_unlink
     11.50 ± 47%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.__ext4_unlink.ext4_unlink
      1995 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
     14.77 ± 52%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create.lookup_open
      2575 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      3241 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    546.46 ±210%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.touch_atime
    572.96 ±194%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict.__dentry_kill
      3119 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
     13.62 ± 14%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
      3148 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      1072 ±137%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread.__ext4_read_dirblock
     25.49 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode.ext4_create
    575.20 ±213%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode.ext4_evict_inode
      1007           -37.9%     625.75 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    513.83 ±213%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      2510 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      2550 ± 45%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
    578.05 ±208%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dentry_kill.dput.__fput.task_work_run
      3127 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      3060 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
     19.21 ± 43%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
     12.40 ± 61%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     26.92 ± 27%     -99.9%       0.02 ±223%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
      1987 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     24.43 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.fscrypt_file_open.ext4_file_open.do_dentry_open
      2089 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     22.87 ± 41%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.__ext4_unlink.ext4_unlink
      3189 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      1550 ± 95%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.vfs_read.ksys_read.do_syscall_64
      3206 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1451 ± 51%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3174 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     14.95 ± 25%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      2930 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
    322.01 ±212%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     18.61 ± 36%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.rmap_walk_anon.migrate_pages_batch.migrate_pages.migrate_misplaced_page
    482.23 ±211%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
    513.18 ±209%    -100.0%       0.01 ±223%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3138 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      3109 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1002          -100.0%       0.00        perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1000          -100.0%       0.00        perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1411 ± 59%     -53.7%     653.76 ± 30%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    777.51 ±101%     -99.3%       5.33 ±176%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      3101 ±  7%     -99.9%       3.64 ±210%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1471 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
    152.29 ±207%    -100.0%       0.02 ±223%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      3148 ±  8%    -100.0%       0.20 ± 91%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1909 ±  8%     -88.2%     225.06 ± 80%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1047 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      2096 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
    943.95 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
      1926 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
      3144 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      3158 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      1.68 ±101%     -91.5%       0.14 ±176%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.isra.0
    124.27 ± 47%     -99.5%       0.57 ± 46%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3966 ± 14%     -83.0%     674.44 ± 31%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.84 ± 45%     -42.2%       3.95 ± 13%  perf-sched.wait_time.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     26.09 ±127%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      1982 ± 66%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      1887 ± 18%     -65.6%     648.69 ± 34%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     75.09           -75.1        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     72.36           -72.4        0.00        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
     86.72           -52.2       34.56        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     87.09           -51.4       35.70        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     87.21           -51.2       35.98        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     87.36           -51.1       36.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     87.42           -51.0       36.37        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     87.63           -50.7       36.90        perf-profile.calltrace.cycles-pp.write
     83.44           -49.9       33.49        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     46.95 ±  3%     -47.0        0.00        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
     42.80 ±  3%     -42.8        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
     42.35 ±  3%     -42.3        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     24.01 ±  5%     -24.0        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
     23.86 ±  5%     -23.9        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
     14.14 ±  4%     -14.1        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     11.35 ±  6%     -11.3        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      1.50 ±  5%      -0.7        0.81        perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      1.52 ±  5%      -0.7        0.83        perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3.04 ±  3%      -0.3        2.69        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.82 ±  3%      -0.2        0.65 ±  2%  perf-profile.calltrace.cycles-pp.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.60 ±  2%      -0.1        0.55        perf-profile.calltrace.cycles-pp.workingset_age_nonresident.workingset_activation.folio_mark_accessed.filemap_read.vfs_read
      0.84 ±  3%      +0.1        0.89        perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.65            +0.1        0.72        perf-profile.calltrace.cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write
      0.65            +0.1        0.72        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.64            +0.1        0.71        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
      0.66            +0.1        0.73        perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter
      0.65 ±  3%      +0.1        0.73        perf-profile.calltrace.cycles-pp.workingset_activation.folio_mark_accessed.filemap_read.vfs_read.ksys_read
      0.66            +0.1        0.76        perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.88            +0.2        1.10        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.79 ±  2%      +0.3        1.12        perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +0.5        0.51        perf-profile.calltrace.cycles-pp.mem_cgroup_css_rstat_flush.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end
      1.03            +0.6        1.66        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +0.8        0.75        perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end
      0.24 ±151%      +0.8        1.01        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.09 ±223%      +0.8        0.86        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.16 ±223%      +0.8        0.98        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.80 ± 19%      +0.8        1.65        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read
      0.85 ± 18%      +0.9        1.78        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.vfs_read.ksys_read
      0.00            +1.0        0.98        perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write
      0.88 ± 17%      +1.0        1.88        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.vfs_read.ksys_read.do_syscall_64
      0.08 ±223%      +1.1        1.14 ±  2%  perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.00            +1.3        1.28        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      0.00            +1.3        1.28        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      0.00            +1.3        1.28        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      0.00            +1.3        1.30        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      0.00            +1.3        1.30        perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      0.00            +1.3        1.31        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release
      0.00            +1.3        1.31        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range
      0.00            +1.3        1.31        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      0.00            +1.3        1.34        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      0.00            +1.4        1.38        perf-profile.calltrace.cycles-pp.llseek
      0.00            +1.8        1.76        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.9        1.86        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +2.2        2.20        perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1.60 ± 17%     +19.7       21.32        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed
      1.61 ± 17%     +19.7       21.32        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read
      1.58 ± 17%     +19.7       21.30        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_activate
      3.26 ±  9%     +19.8       23.08        perf-profile.calltrace.cycles-pp.folio_mark_accessed.filemap_read.vfs_read.ksys_read.do_syscall_64
      2.19 ± 13%     +20.0       22.18        perf-profile.calltrace.cycles-pp.folio_activate.folio_mark_accessed.filemap_read.vfs_read.ksys_read
      2.06 ± 14%     +20.1       22.14        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_activate.folio_mark_accessed.filemap_read.vfs_read
      6.09 ±  3%     +20.8       26.93        perf-profile.calltrace.cycles-pp.filemap_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.04 ± 10%     +21.4       22.47        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
      1.06 ± 10%     +21.4       22.49        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      1.06 ± 10%     +21.4       22.49        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      1.59 ±  7%     +21.5       23.10        perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      6.42 ±  3%     +21.6       28.04        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.41 ±  8%     +21.6       23.05        perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      6.81           +21.7       28.47        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      2.48 ±  5%     +21.8       24.23        perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      6.49 ±  3%     +21.8       28.28        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      3.65 ±  3%     +21.8       25.48        perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      6.57 ±  3%     +22.0       28.53        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      6.61 ±  3%     +22.0       28.65        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      6.84 ±  3%     +22.6       29.40        perf-profile.calltrace.cycles-pp.read
      1.42 ± 11%     +23.1       24.50        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
      1.43 ± 10%     +23.1       24.51        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range
      1.43 ± 10%     +23.1       24.52        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      1.82 ±  8%     +23.5       25.32        perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      2.02 ±  9%     +26.0       27.98        perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      3.58 ±  5%     +26.8       30.36        perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
      3.58 ±  5%     +26.8       30.35        perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dentry_kill.dput
      3.60 ±  5%     +26.8       30.37        perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
      3.60 ±  5%     +26.8       30.37        perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_loop
      3.60 ±  5%     +26.8       30.38        perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      3.61 ±  5%     +26.8       30.40        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.62 ±  5%     +26.8       30.40        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.62 ±  5%     +26.8       30.41        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.63 ±  5%     +26.8       30.42        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.63 ±  5%     +26.8       30.42        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      3.63 ±  5%     +26.8       30.42        perf-profile.calltrace.cycles-pp.__close
      3.62 ±  5%     +26.8       30.41        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.62 ±  5%     +26.8       30.41        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      3.44 ±  6%     +26.8       30.25        perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dentry_kill
     75.10           -75.1        0.00        perf-profile.children.cycles-pp.generic_write_end
     74.87           -74.7        0.17 ±  2%  perf-profile.children.cycles-pp.__mark_inode_dirty
     86.73           -52.1       34.60        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     87.14           -51.4       35.78        perf-profile.children.cycles-pp.vfs_write
     87.26           -51.2       36.06        perf-profile.children.cycles-pp.ksys_write
     87.72           -50.6       37.16        perf-profile.children.cycles-pp.write
     83.49           -49.9       33.60        perf-profile.children.cycles-pp.generic_perform_write
     48.46 ±  3%     -48.4        0.10 ±  5%  perf-profile.children.cycles-pp.ext4_dirty_inode
     44.30 ±  3%     -44.2        0.07 ±  7%  perf-profile.children.cycles-pp.jbd2__journal_start
     43.90 ±  3%     -43.8        0.06 ±  8%  perf-profile.children.cycles-pp.start_this_handle
     24.92 ±  5%     -24.9        0.00        perf-profile.children.cycles-pp.__ext4_journal_stop
     24.78 ±  5%     -24.8        0.00        perf-profile.children.cycles-pp.jbd2_journal_stop
     14.64 ±  4%     -14.6        0.00        perf-profile.children.cycles-pp.add_transaction_credits
     11.86 ±  7%     -11.9        0.00        perf-profile.children.cycles-pp.stop_this_handle
      4.26 ±  3%      -4.2        0.10 ±  3%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      2.22 ±  4%      -2.2        0.05 ±  8%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      2.23 ± 14%      -2.1        0.08 ±  4%  perf-profile.children.cycles-pp.generic_update_time
      2.40 ± 13%      -1.9        0.46 ±  2%  perf-profile.children.cycles-pp.file_modified_flags
      2.00 ±  2%      -1.9        0.07 ±  6%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
     98.92            -1.9       97.04        perf-profile.children.cycles-pp.do_syscall_64
     99.03            -1.7       97.32        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.56 ±  3%      -1.5        0.07 ±  5%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.93 ±  2%      -0.9        0.05        perf-profile.children.cycles-pp.ext4_fill_raw_inode
      1.52 ±  5%      -0.7        0.84        perf-profile.children.cycles-pp.ext4_da_get_block_prep
      1.50 ±  5%      -0.7        0.82        perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.68 ±  2%      -0.4        0.23 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      0.50 ±  4%      -0.4        0.14 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      3.05 ±  3%      -0.3        2.70        perf-profile.children.cycles-pp.ext4_block_write_begin
      0.92 ± 13%      -0.3        0.61 ± 14%  perf-profile.children.cycles-pp.down_write
      0.43 ±  8%      -0.3        0.14 ±  4%  perf-profile.children.cycles-pp.up_write
      0.37 ±  4%      -0.2        0.15 ±  3%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.72 ± 11%      -0.2        0.53 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.83 ±  3%      -0.2        0.66 ±  2%  perf-profile.children.cycles-pp.folio_create_empty_buffers
      0.46 ± 18%      -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.46 ± 18%      -0.1        0.32 ±  7%  perf-profile.children.cycles-pp.do_unlinkat
      0.58 ±  3%      -0.1        0.44 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.47 ± 18%      -0.1        0.33 ±  7%  perf-profile.children.cycles-pp.unlink
      0.33 ± 10%      -0.1        0.20        perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      1.90 ±  5%      -0.1        1.78        perf-profile.children.cycles-pp.__block_commit_write
      0.32            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.block_invalidate_folio
      0.17 ±  7%      -0.1        0.08 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.13 ± 12%      -0.1        0.05        perf-profile.children.cycles-pp.__es_remove_extent
      0.30 ±  6%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.20 ± 10%      -0.1        0.14 ±  4%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.60 ±  2%      -0.1        0.55        perf-profile.children.cycles-pp.workingset_age_nonresident
      0.09 ±  4%      -0.0        0.05        perf-profile.children.cycles-pp.down_read
      0.46 ±  3%      -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.44 ±  3%      -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.14 ±  7%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.14 ±  5%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__ext4_unlink
      0.14 ±  5%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.ext4_unlink
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.vfs_unlink
      0.16 ±  6%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.ext4_create
      0.09 ± 16%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.09 ±  6%      -0.0        0.07        perf-profile.children.cycles-pp.__ext4_new_inode
      0.15 ±  3%      +0.0        0.16 ±  2%  perf-profile.children.cycles-pp.find_lock_entries
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ext4_da_write_end
      0.06 ± 11%      +0.0        0.09        perf-profile.children.cycles-pp.__xa_set_mark
      0.17 ±  5%      +0.0        0.20 ±  2%  perf-profile.children.cycles-pp.rmqueue
      0.04 ± 71%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.06 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.14 ±  3%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.14 ±  3%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.03 ± 70%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.06 ±  6%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.04 ± 71%      +0.0        0.07 ± 10%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.04 ± 45%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.04 ± 44%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
      0.08 ±  5%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.rcu_all_qs
      0.01 ±223%      +0.0        0.06 ±  9%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.09 ±  6%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xa_get_order
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xas_clear_mark
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.free_unref_page_prepare
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.generic_file_llseek_size
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xas_create
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.generic_file_read_iter
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.write@plt
      0.02 ±141%      +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.ext4_lookup
      0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ext4_add_entry
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.28 ±  6%      +0.1        0.33 ±  3%  perf-profile.children.cycles-pp.charge_memcg
      0.06 ±  6%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.ext4_search_dir
      0.09 ±  4%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.__mod_zone_page_state
      0.84 ±  3%      +0.1        0.90        perf-profile.children.cycles-pp.filemap_get_pages
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.rcu_do_batch
      0.01 ±223%      +0.1        0.07 ±  6%  perf-profile.children.cycles-pp.__do_softirq
      0.65            +0.1        0.72        perf-profile.children.cycles-pp.do_flush_stats
      0.65            +0.1        0.72        perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.01 ±223%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.01 ±223%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
      0.01 ±223%      +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.kthread
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.rw_verify_area
      0.64            +0.1        0.71        perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.27 ±  2%      +0.1        0.34        perf-profile.children.cycles-pp.__cond_resched
      0.66            +0.1        0.73        perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.alloc_pages
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.inode_to_bdi
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.ext4_llseek
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.__file_remove_privs
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.ext4_nonda_switch
      0.43 ±  3%      +0.1        0.51        perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.65 ±  3%      +0.1        0.74        perf-profile.children.cycles-pp.workingset_activation
      0.09 ±  5%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.generic_write_checks
      0.21 ±  7%      +0.1        0.29 ±  4%  perf-profile.children.cycles-pp.__count_memcg_events
      0.08            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.32 ±  3%      +0.1        0.40 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.08 ±  5%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.05 ±  8%      +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.90 ±  2%      +0.1        0.99        perf-profile.children.cycles-pp.mark_buffer_dirty
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.fsnotify_perm
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.66            +0.1        0.76        perf-profile.children.cycles-pp.balance_dirty_pages
      0.01 ±223%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.node_dirty_ok
      0.12 ±  4%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.04 ± 71%      +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.mod_objcg_state
      0.07 ±  5%      +0.1        0.18        perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.11 ±  7%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.aa_file_perm
      0.00            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.01 ±223%      +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.ext4_invalidate_folio
      0.06 ±  6%      +0.1        0.19 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.18 ±  2%      +0.1        0.32        perf-profile.children.cycles-pp.lru_add_fn
      0.30 ±  4%      +0.1        0.43        perf-profile.children.cycles-pp.touch_atime
      0.24 ±  6%      +0.1        0.38        perf-profile.children.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.exit_mmap
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.exit_mm
      0.09 ±  4%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.14 ±  6%  perf-profile.children.cycles-pp.__mmput
      0.30 ±  4%      +0.1        0.44 ±  3%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.15 ±  3%      +0.1        0.29 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.do_group_exit
      0.00            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.05            +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.09 ±  7%      +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.08 ± 18%      +0.2        0.24        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.12 ±  4%      +0.2        0.28        perf-profile.children.cycles-pp.xas_store
      0.12 ±  7%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.current_time
      0.13 ±  3%      +0.2        0.30        perf-profile.children.cycles-pp.disk_rr
      0.28 ±  4%      +0.2        0.46        perf-profile.children.cycles-pp.__alloc_pages
      0.34 ±  3%      +0.2        0.52 ±  3%  perf-profile.children.cycles-pp.folio_alloc_buffers
      0.12 ±  3%      +0.2        0.30        perf-profile.children.cycles-pp.xas_descend
      0.12 ±  6%      +0.2        0.31        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.00            +0.2        0.19 ±  4%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.20 ±  5%      +0.2        0.39        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.13 ± 10%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.atime_needs_update
      0.31 ±  5%      +0.2        0.54        perf-profile.children.cycles-pp.folio_alloc
      0.14            +0.2        0.37        perf-profile.children.cycles-pp.fault_in_readable
      0.12 ±  4%      +0.2        0.36 ±  2%  perf-profile.children.cycles-pp.ksys_lseek
      0.88            +0.2        1.13        perf-profile.children.cycles-pp.__filemap_add_folio
      0.17 ±  7%      +0.3        0.43 ±  3%  perf-profile.children.cycles-pp.__fget_light
      0.16            +0.3        0.43        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.13 ±  5%      +0.3        0.40        perf-profile.children.cycles-pp.apparmor_file_permission
      0.22 ±  3%      +0.3        0.52        perf-profile.children.cycles-pp.folio_activate_fn
      0.20 ±  4%      +0.3        0.53 ±  3%  perf-profile.children.cycles-pp.__fdget_pos
      0.17 ±  3%      +0.4        0.52        perf-profile.children.cycles-pp.security_file_permission
      0.80 ±  2%      +0.4        1.15        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.40 ±  4%      +0.4        0.76        perf-profile.children.cycles-pp.__folio_mark_dirty
      0.32 ± 19%      +0.4        0.69        perf-profile.children.cycles-pp.copyin
      0.24 ±  2%      +0.4        0.62        perf-profile.children.cycles-pp.xas_load
      0.12 ±  4%      +0.4        0.50        perf-profile.children.cycles-pp.folio_account_cleaned
      0.16 ±  5%      +0.4        0.57        perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.60 ± 29%      +0.4        1.02        perf-profile.children.cycles-pp.memset_orig
      0.18 ±  6%      +0.4        0.60        perf-profile.children.cycles-pp.folio_account_dirtied
      0.56 ± 31%      +0.4        1.01        perf-profile.children.cycles-pp.zero_user_segments
      0.41 ± 15%      +0.5        0.88        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      0.23 ±  4%      +0.6        0.79        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      1.03            +0.6        1.66        perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.32 ±  4%      +0.6        0.96 ±  3%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.50 ±  2%      +0.7        1.15 ±  2%  perf-profile.children.cycles-pp.try_to_free_buffers
      0.34 ±  3%      +0.7        1.02        perf-profile.children.cycles-pp.__entry_text_start
      0.26 ±  5%      +0.8        1.01 ±  2%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.82 ± 19%      +0.9        1.70        perf-profile.children.cycles-pp.copyout
      0.31 ±  5%      +0.9        1.20        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.85 ± 18%      +0.9        1.80        perf-profile.children.cycles-pp._copy_to_iter
      0.88 ± 17%      +1.0        1.89        perf-profile.children.cycles-pp.copy_page_to_iter
      0.50 ±  3%      +1.1        1.64        perf-profile.children.cycles-pp.llseek
      0.10 ±  8%      +1.2        1.32        perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.00            +2.2        2.22        perf-profile.children.cycles-pp.ext4_da_do_write_end
      3.28 ±  9%     +19.8       23.10        perf-profile.children.cycles-pp.folio_mark_accessed
      2.19 ± 13%     +20.0       22.19        perf-profile.children.cycles-pp.folio_activate
      6.11 ±  3%     +20.9       26.98        perf-profile.children.cycles-pp.filemap_read
      1.60 ±  7%     +21.6       23.14        perf-profile.children.cycles-pp.folio_add_lru
      6.43 ±  3%     +21.6       28.08        perf-profile.children.cycles-pp.vfs_read
      6.83           +21.7       28.51        perf-profile.children.cycles-pp.ext4_da_write_begin
      2.48 ±  5%     +21.8       24.24        perf-profile.children.cycles-pp.filemap_add_folio
      6.51 ±  3%     +21.8       28.32        perf-profile.children.cycles-pp.ksys_read
      3.67 ±  3%     +21.9       25.53        perf-profile.children.cycles-pp.__filemap_get_folio
      6.92 ±  3%     +22.7       29.65        perf-profile.children.cycles-pp.read
      1.92 ±  8%     +23.6       25.54        perf-profile.children.cycles-pp.release_pages
      2.02 ±  9%     +26.0       27.98        perf-profile.children.cycles-pp.__folio_batch_release
      3.58 ±  5%     +26.8       30.35        perf-profile.children.cycles-pp.ext4_evict_inode
      3.58 ±  5%     +26.8       30.36        perf-profile.children.cycles-pp.evict
      3.60 ±  5%     +26.8       30.37        perf-profile.children.cycles-pp.__dentry_kill
      3.65 ±  5%     +26.8       30.43        perf-profile.children.cycles-pp.exit_to_user_mode_loop
      3.60 ±  5%     +26.8       30.38        perf-profile.children.cycles-pp.dentry_kill
      3.64 ±  5%     +26.8       30.42        perf-profile.children.cycles-pp.task_work_run
      3.61 ±  5%     +26.8       30.39        perf-profile.children.cycles-pp.dput
      3.61 ±  5%     +26.8       30.40        perf-profile.children.cycles-pp.__fput
      3.63 ±  5%     +26.8       30.42        perf-profile.children.cycles-pp.__close
      3.44 ±  6%     +26.8       30.25        perf-profile.children.cycles-pp.truncate_inode_pages_range
      3.70 ±  5%     +26.9       30.57        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      3.78 ±  5%     +27.0       30.80        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      3.68 ± 11%     +44.2       47.92        perf-profile.children.cycles-pp.folio_batch_move_lru
      4.64 ± 12%     +66.7       71.31        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      4.44 ± 13%     +66.7       71.15        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.27 ± 13%     +66.8       71.11        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     27.76 ±  6%     -27.8        0.00        perf-profile.self.cycles-pp.start_this_handle
     14.56 ±  4%     -14.6        0.00        perf-profile.self.cycles-pp.add_transaction_credits
     12.80 ±  5%     -12.8        0.00        perf-profile.self.cycles-pp.jbd2_journal_stop
     11.79 ±  7%     -11.8        0.00        perf-profile.self.cycles-pp.stop_this_handle
      1.56 ±  4%      -1.5        0.04 ± 44%  perf-profile.self.cycles-pp.__mark_inode_dirty
      0.67 ±  2%      -0.4        0.22 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.50 ±  4%      -0.4        0.13 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.41 ±  9%      -0.3        0.12 ±  4%  perf-profile.self.cycles-pp.up_write
      0.46 ±  3%      -0.3        0.19 ±  2%  perf-profile.self.cycles-pp.mark_buffer_dirty
      0.34 ±  6%      -0.3        0.08        perf-profile.self.cycles-pp.folio_create_empty_buffers
      0.43 ±  2%      -0.3        0.17        perf-profile.self.cycles-pp.folio_mark_accessed
      0.70 ±  3%      -0.2        0.49        perf-profile.self.cycles-pp.filemap_get_read_batch
      0.38 ±  4%      -0.2        0.19        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.81 ±  2%      -0.2        0.62        perf-profile.self.cycles-pp.filemap_read
      0.30 ±  5%      -0.2        0.13 ±  2%  perf-profile.self.cycles-pp.down_write
      0.42 ±  6%      -0.2        0.25        perf-profile.self.cycles-pp.__filemap_get_folio
      0.31 ±  5%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.ext4_da_map_blocks
      0.24 ±  2%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.18 ±  6%      -0.1        0.06        perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.33 ±  5%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.31 ±  2%      -0.1        0.20        perf-profile.self.cycles-pp.block_invalidate_folio
      0.82 ±  7%      -0.1        0.72        perf-profile.self.cycles-pp.__block_commit_write
      0.32 ±  3%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.20 ± 10%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.60 ±  3%      -0.1        0.55 ±  2%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.17 ±  5%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__filemap_add_folio
      0.06 ± 11%      +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.06            +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.06 ±  8%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.rcu_all_qs
      0.05            +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.12 ±  4%      +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_flush_locked
      0.15 ±  6%      +0.0        0.19 ±  3%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.touch_atime
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__list_add_valid
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.generic_file_read_iter
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.free_unref_page_prepare
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.15 ±  3%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.rw_verify_area
      0.09 ±  4%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__slab_free
      0.12 ±  4%      +0.1        0.18 ±  5%  perf-profile.self.cycles-pp.folio_activate_fn
      0.11 ±  3%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.kmem_cache_free
      0.04 ± 44%      +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.generic_write_checks
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.folio_account_dirtied
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.folio_account_cleaned
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.rmqueue
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__file_remove_privs
      0.01 ±223%      +0.1        0.07        perf-profile.self.cycles-pp.generic_write_check_limits
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.ext4_llseek
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.folio_alloc_buffers
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.__alloc_pages
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.ext4_nonda_switch
      0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.ksys_lseek
      0.00            +0.1        0.07 ±  9%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.node_dirty_ok
      0.07            +0.1        0.15 ±  3%  perf-profile.self.cycles-pp.xas_start
      0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.41 ±  4%      +0.1        0.49        perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.08 ± 12%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.atime_needs_update
      0.06 ±  7%      +0.1        0.15        perf-profile.self.cycles-pp.xas_store
      0.03 ± 70%      +0.1        0.12        perf-profile.self.cycles-pp.__get_task_ioprio
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.fsnotify_perm
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.ksys_read
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.aa_file_perm
      0.02 ±141%      +0.1        0.11        perf-profile.self.cycles-pp.file_modified_flags
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ksys_write
      0.09 ±  7%      +0.1        0.19        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.06 ±  7%      +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.00            +0.1        0.10        perf-profile.self.cycles-pp._copy_to_iter
      0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.05            +0.1        0.16        perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.00            +0.1        0.11        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.08 ±  8%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.current_time
      0.01 ±223%      +0.1        0.12        perf-profile.self.cycles-pp.ext4_invalidate_folio
      0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.mod_objcg_state
      0.02 ±141%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.filemap_get_pages
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.security_file_permission
      0.08 ±  5%      +0.1        0.21 ±  2%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.01 ±223%      +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.08 ±  6%      +0.1        0.21        perf-profile.self.cycles-pp.xas_load
      0.07 ±  5%      +0.1        0.20 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 45%      +0.1        0.18 ±  3%  perf-profile.self.cycles-pp.workingset_activation
      0.09            +0.1        0.23 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.08 ± 17%      +0.2        0.23        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.03 ± 70%      +0.2        0.19 ±  2%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.11 ±  8%      +0.2        0.26 ±  2%  perf-profile.self.cycles-pp.disk_rr
      0.11 ±  3%      +0.2        0.26        perf-profile.self.cycles-pp.xas_descend
      0.09 ±  5%      +0.2        0.25        perf-profile.self.cycles-pp.generic_perform_write
      0.12 ±  3%      +0.2        0.28 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.10 ±  4%      +0.2        0.27        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.11 ±  9%      +0.2        0.28        perf-profile.self.cycles-pp.write
      0.00            +0.2        0.18 ±  2%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.09 ±  9%      +0.2        0.28 ±  2%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.11 ±  8%      +0.2        0.30        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.10 ±  5%      +0.2        0.28        perf-profile.self.cycles-pp.apparmor_file_permission
      0.08 ±  6%      +0.2        0.27        perf-profile.self.cycles-pp.llseek
      0.10 ± 11%      +0.2        0.29 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.08 ±  4%      +0.2        0.28 ±  2%  perf-profile.self.cycles-pp.read
      0.00            +0.2        0.22        perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.13            +0.2        0.36        perf-profile.self.cycles-pp.fault_in_readable
      0.16 ±  6%      +0.2        0.40 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.13 ±  7%      +0.3        0.43        perf-profile.self.cycles-pp.vfs_read
      0.17 ±  4%      +0.4        0.52 ±  2%  perf-profile.self.cycles-pp.vfs_write
      0.31 ± 18%      +0.4        0.68        perf-profile.self.cycles-pp.copyin
      0.10 ± 16%      +0.4        0.46        perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.60 ± 29%      +0.4        1.01        perf-profile.self.cycles-pp.memset_orig
      0.22 ±  5%      +0.5        0.76        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.21 ±  5%      +0.6        0.84 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.81 ± 18%      +0.9        1.68        perf-profile.self.cycles-pp.copyout
      4.44 ± 13%     +66.7       71.15        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1BRD_48G/ext4/x86_64-rhel-8.3/3000/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp2/disk_rw/aim7

commit: 
  bb15cea20f ("ext4: rename s_error_work to s_sb_upd_work")
  03de20bed2 ("ext4: do not mark inode dirty every time when appending using delalloc")

bb15cea20f211e11 03de20bed203b0819225d4de983 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    128.68 ±  2%     -39.8%      77.47 ±  2%  uptime.boot
     19.95 ±  3%    +196.2%      59.09        iostat.cpu.idle
     79.17           -50.6%      39.12        iostat.cpu.system
      0.88 ±  2%    +103.2%       1.79        iostat.cpu.user
     17.80 ±  3%     +37.7       55.50        mpstat.cpu.all.idle%
      0.00 ± 43%      -0.0        0.00        mpstat.cpu.all.iowait%
      0.04 ±  4%      +0.0        0.05        mpstat.cpu.all.soft%
     80.20           -38.7       41.45        mpstat.cpu.all.sys%
      0.90 ±  2%      +1.0        1.91        mpstat.cpu.all.usr%
    173.50 ±  9%     -97.4%       4.50 ± 37%  perf-c2c.DRAM.local
      4557 ± 11%     -96.9%     139.83 ± 25%  perf-c2c.DRAM.remote
      8249 ±  5%     -98.6%     114.50 ± 39%  perf-c2c.HITM.local
      1980 ± 16%     -96.3%      73.50 ± 38%  perf-c2c.HITM.remote
     10229 ±  5%     -98.2%     188.00 ± 14%  perf-c2c.HITM.total
     19.33 ±  2%    +203.4%      58.67        vmstat.cpu.id
     78.83           -51.0%      38.67        vmstat.cpu.sy
     11554 ±  8%    +198.8%      34525 ±  6%  vmstat.io.bo
      2279 ±  2%     -26.3%       1680 ±  5%  vmstat.memory.buff
   4866032           -30.1%    3403273        vmstat.memory.cache
    181.83 ±  5%     -67.7%      58.67 ±  7%  vmstat.procs.r
    188076           -10.0%     169312        vmstat.system.in
    251688          +253.0%     888392        aim7.jobs-per-min
     71.78           -71.5%      20.49        aim7.time.elapsed_time
     71.78           -71.5%      20.49        aim7.time.elapsed_time.max
    381992 ±  2%     -90.7%      35424 ±  6%  aim7.time.involuntary_context_switches
    959.50 ± 37%    +295.2%       3792 ± 30%  aim7.time.major_page_faults
    211635           -23.0%     162916        aim7.time.minor_page_faults
      7499 ±  2%     -84.5%       1163        aim7.time.system_time
     56.60 ±  3%     -18.2%      46.27        aim7.time.user_time
     78293           -68.5%      24661 ±  4%  aim7.time.voluntary_context_switches
      2125           -48.2%       1100        turbostat.Avg_MHz
     81.90           -37.7       44.19        turbostat.Busy%
     18.31 ±  2%     +35.9       54.18        turbostat.C1%
     18.10 ±  2%    +208.3%      55.81        turbostat.CPU%c1
      0.05        +1.3e+05%      64.15 ± 91%  turbostat.IPC
  14014810           -71.6%    3985285        turbostat.IRQ
     73.67            +6.3%      78.33        turbostat.PkgTmp
    330.78            -5.7%     311.79        turbostat.PkgWatt
     32.41           +10.2%      35.73        turbostat.RAMWatt
     46450 ± 70%     -92.3%       3557 ± 59%  numa-meminfo.node0.Active
     45266 ± 72%     -94.3%       2577 ± 65%  numa-meminfo.node0.Active(anon)
    819907 ±  6%     -72.2%     228146 ±  8%  numa-meminfo.node0.Dirty
   2280452 ± 55%     -47.8%    1191344 ± 94%  numa-meminfo.node0.FilePages
   1092263 ± 14%     -57.8%     460792 ± 31%  numa-meminfo.node0.Inactive
    821130 ±  6%     -72.1%     229300 ±  8%  numa-meminfo.node0.Inactive(file)
     64379 ± 22%     -75.4%      15837 ± 87%  numa-meminfo.node0.Mapped
     68319 ± 72%     -90.6%       6451 ± 23%  numa-meminfo.node0.Shmem
    202547 ± 19%     -97.2%       5627 ± 39%  numa-meminfo.node1.Active
    200781 ± 20%     -97.9%       4288 ± 39%  numa-meminfo.node1.Active(anon)
    731030 ±  6%     -67.7%     236466 ±  2%  numa-meminfo.node1.Dirty
   1086993 ± 13%     -50.5%     537671 ± 26%  numa-meminfo.node1.Inactive
    732307 ±  6%     -67.4%     239028 ±  2%  numa-meminfo.node1.Inactive(file)
     93968 ± 18%     -72.2%      26167 ± 53%  numa-meminfo.node1.Mapped
    277127 ± 18%     -95.2%      13323 ± 12%  numa-meminfo.node1.Shmem
     11098 ± 72%     -94.2%     642.67 ± 65%  numa-vmstat.node0.nr_active_anon
    206645 ±  5%     -72.3%      57241 ±  8%  numa-vmstat.node0.nr_dirty
    571590 ± 55%     -47.9%     298048 ± 93%  numa-vmstat.node0.nr_file_pages
    206977 ±  5%     -72.2%      57529 ±  8%  numa-vmstat.node0.nr_inactive_file
     16309 ± 22%     -76.1%       3899 ± 89%  numa-vmstat.node0.nr_mapped
     16896 ± 73%     -90.5%       1611 ± 23%  numa-vmstat.node0.nr_shmem
     11098 ± 72%     -94.2%     642.67 ± 65%  numa-vmstat.node0.nr_zone_active_anon
    206967 ±  5%     -72.2%      57522 ±  8%  numa-vmstat.node0.nr_zone_inactive_file
    206638 ±  5%     -72.3%      57232 ±  8%  numa-vmstat.node0.nr_zone_write_pending
     49577 ± 19%     -97.9%       1058 ± 41%  numa-vmstat.node1.nr_active_anon
    183307 ±  6%     -67.7%      59257 ±  3%  numa-vmstat.node1.nr_dirty
    183649 ±  6%     -67.4%      59895 ±  3%  numa-vmstat.node1.nr_inactive_file
     24064 ± 20%     -73.0%       6489 ± 53%  numa-vmstat.node1.nr_mapped
     69163 ± 18%     -95.3%       3225 ± 17%  numa-vmstat.node1.nr_shmem
     49576 ± 19%     -97.9%       1058 ± 41%  numa-vmstat.node1.nr_zone_active_anon
    183644 ±  6%     -67.4%      59888 ±  3%  numa-vmstat.node1.nr_zone_inactive_file
    183297 ±  6%     -67.7%      59246 ±  3%  numa-vmstat.node1.nr_zone_write_pending
    247975 ±  4%     -96.3%       9181 ±  2%  meminfo.Active
    245024 ±  4%     -97.2%       6862 ±  2%  meminfo.Active(anon)
      2950           -21.4%       2318 ±  4%  meminfo.Active(file)
     93530 ±  2%     -35.3%      60504 ±  8%  meminfo.AnonHugePages
      2271 ±  2%     -26.9%       1659 ±  5%  meminfo.Buffers
   4663482           -30.3%    3248497        meminfo.Cached
   3134097           -16.7%    2609260        meminfo.Committed_AS
   1554455           -70.0%     466831 ±  3%  meminfo.Dirty
   2184888           -54.2%    1000863        meminfo.Inactive
    627906           -15.5%     530366        meminfo.Inactive(anon)
   1556981           -69.8%     470496 ±  3%  meminfo.Inactive(file)
    209061           -21.3%     164633        meminfo.KReclaimable
    160556 ±  5%     -73.9%      41866 ±  2%  meminfo.Mapped
   8621436           -16.4%    7209577        meminfo.Memused
    209061           -21.3%     164633        meminfo.SReclaimable
    345743           -94.3%      19747 ±  3%  meminfo.Shmem
    570535           -10.9%     508570        meminfo.Slab
   9278069           -19.2%    7492359        meminfo.max_used_kB
     61023 ±  4%     -97.2%       1715 ±  2%  proc-vmstat.nr_active_anon
    737.17           -21.4%     579.17 ±  4%  proc-vmstat.nr_active_file
    131712            -1.8%     129355        proc-vmstat.nr_anon_pages
    388337           -70.0%     116609 ±  4%  proc-vmstat.nr_dirty
   1166215           -30.3%     812477        proc-vmstat.nr_file_pages
    157211           -15.7%     132527        proc-vmstat.nr_inactive_anon
    388956           -69.8%     117586 ±  4%  proc-vmstat.nr_inactive_file
     65538            -7.3%      60758        proc-vmstat.nr_kernel_stack
     40647 ±  4%     -74.3%      10458        proc-vmstat.nr_mapped
     86498           -94.3%       4926 ±  3%  proc-vmstat.nr_shmem
     52237           -21.3%      41126        proc-vmstat.nr_slab_reclaimable
     90324            -4.8%      85956        proc-vmstat.nr_slab_unreclaimable
     61023 ±  4%     -97.2%       1715 ±  2%  proc-vmstat.nr_zone_active_anon
    737.17           -21.4%     579.17 ±  4%  proc-vmstat.nr_zone_active_file
    157211           -15.7%     132527        proc-vmstat.nr_zone_inactive_anon
    388956           -69.8%     117587 ±  4%  proc-vmstat.nr_zone_inactive_file
    388337           -70.0%     116612 ±  4%  proc-vmstat.nr_zone_write_pending
     69677 ± 18%     -96.4%       2532 ±141%  proc-vmstat.numa_hint_faults
     37235 ± 31%     -97.0%       1104 ±223%  proc-vmstat.numa_hint_faults_local
     29530 ± 12%     -95.2%       1427 ±194%  proc-vmstat.numa_pages_migrated
    210879 ± 16%     -96.8%       6823 ±141%  proc-vmstat.numa_pte_updates
    134920 ±  5%     -99.8%     310.83 ±  8%  proc-vmstat.pgactivate
    739769           -44.9%     407395        proc-vmstat.pgfault
     29530 ± 12%     -95.2%       1427 ±194%  proc-vmstat.pgmigrate_success
     42997 ±  4%     -65.9%      14675 ±  8%  proc-vmstat.pgreuse
      1757 ± 18%     -14.4%       1504        proc-vmstat.unevictable_pgs_culled
    666752 ±  2%     -58.3%     277760        proc-vmstat.unevictable_pgs_scanned
      0.82 ± 16%     -84.7%       0.13 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
      2.42 ± 14%     -58.6%       1.00        sched_debug.cfs_rq:/.h_nr_running.max
      0.55 ± 10%     -39.9%       0.33        sched_debug.cfs_rq:/.h_nr_running.stddev
     66226 ±199%     -96.2%       2529 ±  7%  sched_debug.cfs_rq:/.load.avg
   3366324           -99.9%       1942 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
   4029229 ±  4%     -99.6%      15674 ± 27%  sched_debug.cfs_rq:/.min_vruntime.max
   2718307 ±  7%    -100.0%      75.09 ± 37%  sched_debug.cfs_rq:/.min_vruntime.min
    164864 ± 14%     -98.2%       2896 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.54 ±  4%     -76.7%       0.13 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
     29.70 ± 24%   +1996.6%     622.66 ± 75%  sched_debug.cfs_rq:/.removed.load_avg.avg
    512.00        +11524.1%      59515 ± 69%  sched_debug.cfs_rq:/.removed.load_avg.max
    118.12 ± 10%   +4825.1%       5817 ± 70%  sched_debug.cfs_rq:/.removed.load_avg.stddev
     12.27 ± 29%     +69.4%      20.78 ± 18%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    261.58           +98.8%     520.00        sched_debug.cfs_rq:/.removed.runnable_avg.max
     50.93 ± 14%     +83.9%      93.68 ±  8%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
     12.27 ± 29%     +69.3%      20.77 ± 18%  sched_debug.cfs_rq:/.removed.util_avg.avg
    261.58           +98.7%     519.67        sched_debug.cfs_rq:/.removed.util_avg.max
     50.93 ± 14%     +83.9%      93.67 ±  8%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    939.43 ± 12%     -72.2%     261.35 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
      2573 ± 10%     -54.6%       1168 ±  7%  sched_debug.cfs_rq:/.runnable_avg.max
    184.67 ± 84%    -100.0%       0.00        sched_debug.cfs_rq:/.runnable_avg.min
    474.31 ±  8%     -36.7%     300.12 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -219950           -97.5%      -5496        sched_debug.cfs_rq:/.spread0.avg
   -873191           -99.2%      -7347        sched_debug.cfs_rq:/.spread0.min
    165830 ± 14%     -98.3%       2886 ±  9%  sched_debug.cfs_rq:/.spread0.stddev
    621.71 ±  3%     -58.0%     260.96 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
      1701 ± 10%     -31.3%       1168 ±  7%  sched_debug.cfs_rq:/.util_avg.max
    103.00 ± 81%    -100.0%       0.00        sched_debug.cfs_rq:/.util_avg.min
    516.60 ± 20%     -94.8%      26.62 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1738 ± 15%     -52.4%     826.67        sched_debug.cfs_rq:/.util_est_enqueued.max
    338.95 ± 14%     -65.2%     118.11 ±  4%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    332028 ± 22%     -98.6%       4503 ± 14%  sched_debug.cpu.avg_idle.min
    149016 ±  5%     +58.8%     236705 ± 11%  sched_debug.cpu.avg_idle.stddev
     86373 ±  2%     -34.8%      56346 ±  3%  sched_debug.cpu.clock.avg
     86409 ±  2%     -34.8%      56352 ±  3%  sched_debug.cpu.clock.max
     86327 ±  2%     -34.7%      56337 ±  3%  sched_debug.cpu.clock.min
     22.04 ± 28%     -84.1%       3.51 ± 11%  sched_debug.cpu.clock.stddev
     85905 ±  2%     -34.6%      56216 ±  3%  sched_debug.cpu.clock_task.avg
     86066 ±  2%     -34.5%      56342 ±  3%  sched_debug.cpu.clock_task.max
     78066 ±  3%     -37.8%      48576 ±  3%  sched_debug.cpu.clock_task.min
      3507 ±  5%     -85.8%     497.84 ±  5%  sched_debug.cpu.curr->pid.avg
      6948 ±  3%     -36.4%       4422        sched_debug.cpu.curr->pid.max
      0.82 ± 15%     -85.3%       0.12 ±  7%  sched_debug.cpu.nr_running.avg
      2.42 ± 14%     -58.6%       1.00        sched_debug.cpu.nr_running.max
      0.55 ± 10%     -41.0%       0.33 ±  3%  sched_debug.cpu.nr_running.stddev
      4027           -53.3%       1879 ±  3%  sched_debug.cpu.nr_switches.avg
      1602 ±  6%     -91.3%     139.67 ± 10%  sched_debug.cpu.nr_switches.min
      9.02 ±  3%     -99.9%       0.01 ±111%  sched_debug.cpu.nr_uninterruptible.avg
     92.00 ± 13%     -53.6%      42.67 ± 51%  sched_debug.cpu.nr_uninterruptible.max
     14.14 ±  7%     -55.2%       6.33 ± 20%  sched_debug.cpu.nr_uninterruptible.stddev
     86324 ±  2%     -34.7%      56342 ±  3%  sched_debug.cpu_clk
     85094 ±  2%     -35.2%      55111 ±  3%  sched_debug.ktime
     87194 ±  2%     -34.3%      57252 ±  3%  sched_debug.sched_clk
      7.58 ±  6%     -26.8%       5.55 ±  5%  perf-stat.i.MPKI
 7.862e+09          +147.7%  1.948e+10        perf-stat.i.branch-instructions
      0.40 ±  4%      +0.3        0.72 ±  3%  perf-stat.i.branch-miss-rate%
  18805671 ±  7%     +76.1%   33118170        perf-stat.i.branch-misses
     29.39 ±  2%     -14.4       15.04 ±  4%  perf-stat.i.cache-miss-rate%
 1.091e+08 ±  5%     +23.0%  1.342e+08 ±  3%  perf-stat.i.cache-misses
 3.294e+08 ±  6%    +102.4%  6.667e+08 ±  2%  perf-stat.i.cache-references
      6.04 ±  2%     -67.3%       1.98 ±  2%  perf-stat.i.cpi
 2.669e+11           -45.0%  1.467e+11 ±  2%  perf-stat.i.cpu-cycles
      1096           -21.5%     860.27 ±  4%  perf-stat.i.cpu-migrations
      3544 ±  7%     +32.5%       4696 ± 14%  perf-stat.i.cycles-between-cache-misses
   1887807 ± 12%     -36.2%    1204164 ± 11%  perf-stat.i.dTLB-load-misses
 1.124e+10          +141.3%  2.713e+10        perf-stat.i.dTLB-loads
      0.01 ± 16%      +0.0        0.01 ±  5%  perf-stat.i.dTLB-store-miss-rate%
 6.393e+09          +141.0%  1.541e+10 ±  2%  perf-stat.i.dTLB-stores
 4.013e+10          +146.2%  9.879e+10        perf-stat.i.instructions
      0.22 ±  3%    +183.5%       0.63 ±  2%  perf-stat.i.ipc
     16.27 ± 39%   +1103.1%     195.71 ± 31%  perf-stat.i.major-faults
      2.08           -45.0%       1.14 ±  2%  perf-stat.i.metric.GHz
    740.10 ±  2%     +15.5%     854.57 ±  6%  perf-stat.i.metric.K/sec
    201.33          +142.8%     488.77        perf-stat.i.metric.M/sec
      8092 ±  2%     +45.9%      11809        perf-stat.i.minor-faults
    282227 ±  4%     +24.3%     350866 ±  4%  perf-stat.i.node-loads
     23.78 ±  4%     +49.6       73.37 ±  5%  perf-stat.i.node-store-miss-rate%
  10479847 ±  2%    +374.2%   49690247 ±  3%  perf-stat.i.node-store-misses
  61374002 ±  2%     -66.8%   20355015 ±  3%  perf-stat.i.node-stores
      8108 ±  2%     +48.1%      12005        perf-stat.i.page-faults
      8.23 ±  6%     -18.0%       6.75        perf-stat.overall.MPKI
      0.23 ±  8%      -0.1        0.17        perf-stat.overall.branch-miss-rate%
     33.06           -12.9       20.14        perf-stat.overall.cache-miss-rate%
      6.65 ±  2%     -77.7%       1.48        perf-stat.overall.cpi
      2454 ±  5%     -55.5%       1092        perf-stat.overall.cycles-between-cache-misses
      0.02 ± 11%      -0.0        0.00 ± 12%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ± 22%      -0.0        0.00 ± 19%  perf-stat.overall.dTLB-store-miss-rate%
      0.15 ±  2%    +348.1%       0.67        perf-stat.overall.ipc
     14.54 ±  3%     +56.4       70.94        perf-stat.overall.node-store-miss-rate%
 7.966e+09          +137.4%  1.891e+10        perf-stat.ps.branch-instructions
  18598842 ±  8%     +71.5%   31892838        perf-stat.ps.branch-misses
 1.105e+08 ±  5%     +18.0%  1.305e+08 ±  3%  perf-stat.ps.cache-misses
 3.345e+08 ±  6%     +93.7%  6.478e+08 ±  2%  perf-stat.ps.cache-references
      9039 ±  2%     -10.9%       8055 ±  7%  perf-stat.ps.context-switches
    126032            -3.4%     121771        perf-stat.ps.cpu-clock
 2.704e+11           -47.3%  1.425e+11 ±  2%  perf-stat.ps.cpu-cycles
      1095           -24.5%     826.51 ±  3%  perf-stat.ps.cpu-migrations
   2065613 ± 13%     -43.5%    1166765 ± 12%  perf-stat.ps.dTLB-load-misses
 1.139e+10          +131.3%  2.635e+10        perf-stat.ps.dTLB-loads
 6.484e+09          +130.9%  1.497e+10 ±  2%  perf-stat.ps.dTLB-stores
 4.065e+10          +136.0%  9.595e+10        perf-stat.ps.instructions
     13.45 ± 38%   +1252.8%     181.89 ± 31%  perf-stat.ps.major-faults
      7917           +40.8%      11150        perf-stat.ps.minor-faults
    284666 ±  4%     +19.8%     340989 ±  3%  perf-stat.ps.node-loads
  10594399 ±  2%    +356.1%   48321812 ±  3%  perf-stat.ps.node-store-misses
  62318550 ±  2%     -68.2%   19795139 ±  3%  perf-stat.ps.node-stores
      7930           +42.9%      11332        perf-stat.ps.page-faults
    126032            -3.4%     121771        perf-stat.ps.task-clock
 2.933e+12           -31.6%  2.005e+12 ±  3%  perf-stat.total.instructions
      0.13 ± 75%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      1.91 ±129%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      0.42 ±222%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
      0.15 ±219%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      5.88 ±110%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      5.94 ±153%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      6.96 ± 85%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      5.07 ±214%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      6.58 ±104%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      0.07 ±139%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3.06 ± 26%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      5.31 ±222%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.19 ±157%     -99.6%       0.00 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      4.24 ±120%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      3.73 ±109%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3.26 ±100%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
      0.14 ± 75%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     11.52 ±  6%    -100.0%       0.00 ± 35%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.33 ± 74%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      9.37 ± 73%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.08 ±144%     -93.0%       0.01 ± 85%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      6.45 ±102%     -99.9%       0.00 ± 64%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.44 ±133%     -98.7%       0.01 ± 55%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      4.27 ±147%     -99.9%       0.01 ± 71%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.14 ± 70%     -91.4%       0.01 ± 49%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.61 ±131%     -99.9%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      2.37 ±142%     -99.9%       0.00 ± 27%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.03 ± 23%     -84.4%       0.00 ± 15%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      6.75 ±142%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      0.63 ±110%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
      1.15 ± 85%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      7.77 ±120%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.20 ± 97%     -99.7%       0.00 ±223%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.03 ± 30%     -60.4%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.04 ± 89%     -83.0%       0.01 ± 27%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6.08 ± 45%     -99.9%       0.00 ± 32%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      2.08 ± 25%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      3.33 ± 45%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      2.43 ± 44%     -98.7%       0.03 ± 34%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.15 ± 76%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      1095 ±137%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      7.99 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
     10.31 ±222%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      3160 ± 10%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      1573 ±100%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      2023 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      1.23 ±217%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    618.08 ±212%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      1624 ± 98%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      3.16 ±136%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
     21.45 ± 61%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
    593.91 ±222%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     15.03 ±167%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
      2048 ± 71%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      3144 ±  9%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1557 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
      5.68 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     50.91 ± 22%    -100.0%       0.01 ± 58%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
     53.86 ± 72%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      1922 ± 70%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55 ±201%     -99.0%       0.01 ± 85%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      6.47 ±101%     -99.9%       0.01 ± 26%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      2.34 ±139%     -99.7%       0.01 ± 72%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    341.00 ±137%     -99.5%       1.55 ±215%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    999.74 ±134%    -100.0%       0.01 ± 20%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1640 ± 96%    -100.0%       0.01 ± 27%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1.89 ±136%     -99.5%       0.01 ± 34%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.05 ± 36%     -82.2%       0.01 ± 15%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      1009 ±140%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
     16.79 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
      1666 ± 89%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      2721 ± 41%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
     11.50 ± 86%    -100.0%       0.00 ±223%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.09 ± 58%     -81.1%       0.02 ± 20%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      8.11 ± 44%     -99.9%       0.01 ± 17%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
     19.70 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    149.91 ± 30%    -100.0%       0.00        perf-sched.sch_delay.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    781.38 ± 45%     -99.6%       3.48 ± 53%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.82 ±103%     -98.6%       0.05 ±173%  perf-sched.total_sch_delay.average.ms
      3566 ± 19%     -95.1%     173.32 ±213%  perf-sched.total_sch_delay.max.ms
    185.88 ±  9%     -79.8%      37.61 ±  8%  perf-sched.total_wait_and_delay.average.ms
     47794 ±  4%     -91.7%       3977 ±  2%  perf-sched.total_wait_and_delay.count.ms
      5000 ± 26%     -80.3%     986.83 ±  4%  perf-sched.total_wait_and_delay.max.ms
    182.05 ± 10%     -79.4%      37.55 ±  8%  perf-sched.total_wait_time.average.ms
      4000 ±  9%     -75.3%     986.83 ±  4%  perf-sched.total_wait_time.max.ms
    245.24 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
    218.00 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    157.25 ± 32%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    234.16 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      4.97 ± 19%     -73.5%       1.32 ± 94%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     84.06 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    236.78 ± 16%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
    228.21 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
    193.16 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    232.25 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
    799.37          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    777.58 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    246.02 ±  3%     -99.0%       2.39 ± 40%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     60.00 ± 49%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     27.00 ± 39%     -96.3%       1.00 ± 63%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    482.25 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    369.82 ± 12%     -81.9%      66.91 ± 21%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     69.71 ± 21%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    230.58 ± 17%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    452.64           -44.3%     251.96        perf-sched.wait_and_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.69 ±  5%     +57.2%       7.38 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    673.01 ±  9%     -73.6%     177.61 ± 13%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    662.26 ±  5%     -93.5%      43.14 ± 41%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    657.67 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
     14416 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    554.17 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    494.17 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
    271.67 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    406.17 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      2005 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
     10494 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    643.83 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     10.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.67 ± 19%    -100.0%       0.00        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    122.50 ±  5%    +534.6%     777.33 ±  2%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      3288 ± 44%    -100.0%       0.00        perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3102 ± 34%     -82.0%     559.17 ±  7%  perf-sched.wait_and_delay.count.pipe_read.vfs_read.ksys_read.do_syscall_64
     25.33 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3737 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1425 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
     19.67 ±  3%     -79.7%       4.00        perf-sched.wait_and_delay.count.schedule_timeout.kcompactd.kthread.ret_from_fork
      1136 ±  6%     -88.5%     131.17 ±  8%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1329 ±  7%     -50.5%     657.67 ±  6%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    839.67 ±  4%     -30.1%     586.83 ± 16%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3673 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      4284 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
      3560 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3574 ± 28%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
      2995 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      3681 ± 41%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      4149 ± 40%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      4276 ± 37%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      3675 ± 42%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
    999.37          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1004          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      3121 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      1933 ± 10%     -91.0%     173.67 ±212%  perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1004          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      3171 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      4209 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      3885 ± 15%     -74.6%     985.69 ±  4%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2077 ± 23%     -57.9%     873.82 ± 18%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    730.33 ±184%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
    227.53 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
    243.33 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
    174.03 ±141%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create.lookup_open
    146.58 ±161%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink.ext4_unlink
      9.74 ± 56%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.__ext4_unlink.ext4_unlink
    303.07 ± 43%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
     15.18 ± 27%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create.lookup_open
    163.46 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
    212.12 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     72.63 ±117%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict.__dentry_kill
    151.31 ± 33%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
    227.20 ± 10%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
     57.36 ±173%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread.__ext4_read_dirblock
    167.30 ±141%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode.ext4_create
     15.28 ± 26%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode.ext4_evict_inode
      4.97 ± 19%     -73.4%       1.32 ± 94%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    133.11 ±113%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     78.99 ± 55%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
    161.01 ±111%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
    103.34 ±125%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dentry_kill.dput.__fput.task_work_run
    230.21 ± 16%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
    186.00 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
     11.67 ± 36%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
      1.16 ± 49%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      5.59 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
     81.94 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     13.23 ± 17%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.fscrypt_file_open.ext4_file_open.do_dentry_open
     79.97 ± 46%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     10.09 ± 34%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     14.04 ± 32%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.__ext4_unlink.ext4_unlink
    223.96 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
    189.42 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
    145.63 ± 53%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
    228.98 ± 11%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     13.04 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
    189.62 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     14.08 ± 68%     -99.9%       0.01 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
    236.50 ±128%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     12.36 ± 29%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
     96.33 ±194%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
     85.53 ± 84%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
    214.05 ± 34%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.94 ±223%   +2961.9%     671.93 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
    799.30          -100.0%       0.00 ±141%  perf-sched.wait_time.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    777.14 ±  8%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    241.76 ±  2%     -99.0%       2.38 ± 40%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
     12.79 ± 90%     -96.9%       0.40 ±  2%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
    152.10 ± 81%     -95.2%       7.32 ±221%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     47.91 ±170%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      7.56 ± 40%     -99.9%       0.01 ±167%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     57.64 ± 49%     -99.9%       0.08 ±104%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
     64.63 ±175%    -100.0%       0.00        perf-sched.wait_time.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
     26.79 ± 39%     -97.4%       0.70 ±  5%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    482.16 ± 19%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    369.43 ± 12%     -82.0%      66.58 ± 21%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    216.09 ±134%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
    310.21 ±164%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
    263.48 ±150%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
     68.56 ± 21%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    222.81 ± 14%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      6.03 ± 53%     -99.7%       0.02 ±223%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    452.61           -44.3%     251.95        perf-sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      4.58 ±  4%     +60.5%       7.35 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    672.97 ±  9%     -73.6%     177.60 ± 13%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.65 ± 64%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
    180.09 ± 87%    -100.0%       0.00        perf-sched.wait_time.avg.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
    659.84 ±  5%     -93.5%      43.11 ± 41%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    943.58 ±149%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
      3017 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      3088 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      1102 ±137%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create.lookup_open
      1060 ±136%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_delete_entry.__ext4_unlink.ext4_unlink
     11.73 ± 51%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.__ext4_unlink.ext4_unlink
      2886 ± 12%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_dirty_inode
     19.84 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.__ext4_new_inode.ext4_create.lookup_open
      2919 ±  6%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      3154 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
    971.89 ±138%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_evict_inode.evict.__dentry_kill
      3044 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      3099 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
    516.42 ±207%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_getblk.ext4_bread.__ext4_read_dirblock
    987.10 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.__ext4_new_inode.ext4_create
     26.52 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__getblk_gfp.ext4_read_inode_bitmap.ext4_free_inode.ext4_evict_inode
      1429 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      2991 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.block_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      2006 ± 69%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
    852.18 ±136%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dentry_kill.dput.__fput.task_work_run
      3107 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.ext4_da_map_blocks.constprop.0
      2970 ± 11%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.ext4_buffered_write_iter.vfs_write.ksys_write
     19.80 ± 32%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.vfs_unlink.do_unlinkat.__x64_sys_unlink
     11.72 ± 50%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
     21.18 ± 22%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.task_work_run.exit_to_user_mode_loop
      2982 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.do_unlinkat.__x64_sys_unlink.do_syscall_64
     27.69 ± 19%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.fscrypt_file_open.ext4_file_open.do_dentry_open
      2952 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.dput.open_last_lookups.path_openat.do_filp_open
     14.81 ± 15%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
     22.03 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.__ext4_unlink.ext4_unlink
      3093 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      3159 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      1484 ± 59%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.generic_perform_write.generic_file_write_iter.vfs_write.ksys_write
      3089 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers
     21.99 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.alloc_empty_file.path_openat.do_filp_open
      2929 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     28.72 ±110%     -99.9%       0.02 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.security_file_alloc.init_file.alloc_empty_file
    543.15 ±123%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.lock_mm_and_find_vma.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     18.30 ± 47%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.open_last_lookups.path_openat.do_filp_open
    531.38 ±211%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.slab_pre_alloc_hook.constprop.0.kmem_cache_alloc_lru
      3006 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      3039 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.80 ±223%   +1434.2%     671.93 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
    999.34          -100.0%       0.00 ±141%  perf-sched.wait_time.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      1002          -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    503.43 ±171%     -99.8%       0.94 ± 10%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      2990 ±  9%     -97.6%      72.54 ±220%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
    435.98 ±209%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
     13.70 ± 14%     -99.9%       0.02 ±189%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      3099 ±  9%    -100.0%       0.48 ± 96%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    455.66 ±194%    -100.0%       0.00        perf-sched.wait_time.max.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      1916 ±  9%     -99.6%       7.78 ± 58%  perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      1002          -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1596 ± 97%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      1048 ±140%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
      2104 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
      3113 ±  9%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      3090 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    168.82 ±137%    -100.0%       0.03 ±223%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    118.17 ± 45%    +106.1%     243.50 ± 26%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3885 ± 15%     -74.6%     985.69 ±  4%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     13.17 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      2439 ± 42%    -100.0%       0.00        perf-sched.wait_time.max.ms.wait_transaction_locked.add_transaction_credits.start_this_handle.jbd2__journal_start
      1877 ± 20%     -53.5%     873.81 ± 18%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     79.64           -79.6        0.00        perf-profile.calltrace.cycles-pp.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     74.04           -74.0        0.00        perf-profile.calltrace.cycles-pp.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
     47.78 ±  2%     -47.8        0.00        perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
     43.43 ±  2%     -43.4        0.00        perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.generic_write_end.generic_perform_write
     42.92 ±  2%     -42.9        0.00        perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.generic_write_end
     94.04           -40.4       53.60        perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     89.50           -40.4       49.11        perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     94.78           -35.6       59.18        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.00           -34.7       60.28        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.23           -33.9       61.36        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     95.36           -33.5       61.89        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     95.84           -30.4       65.40        perf-profile.calltrace.cycles-pp.write
     24.82 ±  3%     -24.8        0.00        perf-profile.calltrace.cycles-pp.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write.ext4_buffered_write_iter
     24.68 ±  4%     -24.7        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end.generic_perform_write
     14.70 ±  3%     -14.7        0.00        perf-profile.calltrace.cycles-pp.add_transaction_credits.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
     11.85 ± 11%     -11.8        0.00        perf-profile.calltrace.cycles-pp.stop_this_handle.jbd2_journal_stop.__ext4_journal_stop.__mark_inode_dirty.generic_write_end
      2.91 ± 26%      -1.1        1.84 ±  2%  perf-profile.calltrace.cycles-pp.file_modified_flags.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      1.56 ±  2%      +0.1        1.66 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_map_blocks.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.65            +0.1        0.75        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.65            +0.1        0.76        perf-profile.calltrace.cycles-pp.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write
      0.64            +0.1        0.75        perf-profile.calltrace.cycles-pp.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats.balance_dirty_pages
      1.59 ±  2%      +0.1        1.71 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_get_block_prep.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.65            +0.1        0.79        perf-profile.calltrace.cycles-pp.mem_cgroup_wb_stats.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter
      0.66            +0.2        0.84        perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.88 ±  3%      +0.3        1.22 ±  2%  perf-profile.calltrace.cycles-pp.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.mem_cgroup_css_rstat_flush.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.00            +0.6        0.55        perf-profile.calltrace.cycles-pp.current_time.file_modified_flags.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +0.6        0.56 ±  4%  perf-profile.calltrace.cycles-pp.__fget_light.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.6        0.59 ±  2%  perf-profile.calltrace.cycles-pp.lru_add_fn.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      0.00            +0.7        0.65        perf-profile.calltrace.cycles-pp.__entry_text_start.llseek
      0.00            +0.7        0.67 ±  4%  perf-profile.calltrace.cycles-pp.__fdget_pos.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.00            +0.7        0.67 ±  3%  perf-profile.calltrace.cycles-pp.generic_write_checks.ext4_generic_write_checks.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +0.7        0.70 ±  3%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio
      0.00            +0.7        0.72 ±  4%  perf-profile.calltrace.cycles-pp.ksys_lseek.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +0.7        0.72        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_account_cleaned.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio
      0.00            +0.7        0.73 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin
      0.00            +0.7        0.75        perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      0.00            +0.8        0.76 ±  3%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin
      0.00            +0.8        0.82 ±  3%  perf-profile.calltrace.cycles-pp.__mod_lruvec_page_state.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write
      0.00            +0.8        0.82        perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.00            +0.8        0.83 ±  3%  perf-profile.calltrace.cycles-pp.alloc_buffer_head.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin
      0.00            +0.8        0.85 ±  3%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      0.00            +0.9        0.86 ±  3%  perf-profile.calltrace.cycles-pp.apparmor_file_permission.security_file_permission.vfs_write.ksys_write.do_syscall_64
      0.00            +0.9        0.86 ±  2%  perf-profile.calltrace.cycles-pp.ext4_generic_write_checks.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
      0.00            +0.9        0.89 ±  2%  perf-profile.calltrace.cycles-pp.xas_load.filemap_get_entry.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.00            +0.9        0.91 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_pages.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.00            +0.9        0.95 ±  3%  perf-profile.calltrace.cycles-pp.folio_alloc_buffers.folio_create_empty_buffers.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +1.0        0.98 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu
      0.00            +1.0        0.98 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release
      0.00            +1.0        0.98 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range
      0.00            +1.0        1.01 ±  3%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      0.00            +1.0        1.01 ±  3%  perf-profile.calltrace.cycles-pp.lru_add_drain_cpu.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      1.08 ±  4%      +1.0        2.13        perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.1        1.07 ±  2%  perf-profile.calltrace.cycles-pp.folio_alloc.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.1        1.08 ±  2%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.12 ±  2%  perf-profile.calltrace.cycles-pp.folio_account_cleaned.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range
      0.00            +1.3        1.27 ±  2%  perf-profile.calltrace.cycles-pp.__folio_cancel_dirty.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode
      0.00            +1.3        1.28 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.llseek
      0.00            +1.3        1.33 ±  8%  perf-profile.calltrace.cycles-pp.ext4_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.4        1.35        perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +1.4        1.38 ±  3%  perf-profile.calltrace.cycles-pp.folio_account_dirtied.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end
      0.91            +1.5        2.36        perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.57 ± 11%      +1.5        2.08        perf-profile.calltrace.cycles-pp.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.5        1.52 ± 14%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      0.00            +1.5        1.54 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.llseek
      0.37 ± 72%      +1.6        2.02        perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write
      0.00            +1.7        1.65        perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +1.7        1.70 ±  3%  perf-profile.calltrace.cycles-pp.__folio_mark_dirty.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end
      0.90 ±  2%      +1.9        2.79 ±  2%  perf-profile.calltrace.cycles-pp.balance_dirty_pages_ratelimited_flags.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +2.0        2.00 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.00            +2.0        2.04 ± 10%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat
      0.17 ±141%      +2.2        2.32        perf-profile.calltrace.cycles-pp.try_to_free_buffers.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict
      0.58 ± 12%      +2.2        2.78 ±  7%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
      0.58 ± 12%      +2.2        2.78 ±  7%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.18 ±141%      +2.2        2.38        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.58 ± 12%      +2.2        2.80 ±  7%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.58 ± 12%      +2.2        2.80 ±  7%  perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.95 ±  2%      +2.2        3.16        perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      0.59 ± 12%      +2.2        2.80 ±  7%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
      0.59 ± 12%      +2.2        2.81 ±  7%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
      0.59 ± 12%      +2.2        2.81 ±  7%  perf-profile.calltrace.cycles-pp.creat64
      0.00            +2.3        2.26 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat
      0.00            +2.3        2.28 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.open_last_lookups.path_openat.do_filp_open
      0.00            +2.3        2.28 ±  9%  perf-profile.calltrace.cycles-pp.down_write.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.3        2.31 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink
      0.39 ± 71%      +2.3        2.72 ±  8%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
      0.00            +2.3        2.33 ±  9%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64
      0.00            +2.3        2.33 ±  9%  perf-profile.calltrace.cycles-pp.down_write.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10 ±223%      +2.5        2.59 ±  9%  perf-profile.calltrace.cycles-pp.do_unlinkat.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.10 ±223%      +2.5        2.60 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_unlink.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.10 ±223%      +2.5        2.60 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.unlink
      0.10 ±223%      +2.5        2.60 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.unlink
      0.10 ±223%      +2.5        2.61 ±  9%  perf-profile.calltrace.cycles-pp.unlink
      3.32 ±  2%      +2.5        5.84        perf-profile.calltrace.cycles-pp.ext4_block_write_begin.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.66 ±  5%      +2.6        3.22        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00            +3.0        2.98        perf-profile.calltrace.cycles-pp.llseek
      0.00            +3.8        3.78 ±  2%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write
      0.00            +6.1        6.09        perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +6.4        6.43        perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +7.7        7.74 ±  2%  perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.00           +16.6       16.57 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru
      0.00           +16.6       16.60 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio
      0.00           +16.6       16.61 ±  4%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio
      0.72 ±  3%     +17.0       17.69 ±  4%  perf-profile.calltrace.cycles-pp.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write
      0.53 ±  3%     +17.1       17.60 ±  4%  perf-profile.calltrace.cycles-pp.folio_batch_move_lru.folio_add_lru.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin
      0.00           +17.8       17.79 ±  4%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release
      0.00           +17.8       17.82 ±  4%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range
      0.00           +17.8       17.84 ±  4%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode
      1.66           +18.5       20.12 ±  3%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter
      0.56 ±  2%     +18.6       19.17 ±  3%  perf-profile.calltrace.cycles-pp.release_pages.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict
      0.59 ±  3%     +19.6       20.21 ±  3%  perf-profile.calltrace.cycles-pp.__folio_batch_release.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill
      4.10 ±  2%     +20.4       24.54 ±  2%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write
      1.95 ±  2%     +22.7       24.63 ±  2%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.ext4_evict_inode.evict.__dentry_kill.dentry_kill
      2.09 ±  2%     +22.7       24.83 ±  2%  perf-profile.calltrace.cycles-pp.ext4_evict_inode.evict.__dentry_kill.dentry_kill.dput
      2.10 ±  2%     +22.8       24.85 ±  2%  perf-profile.calltrace.cycles-pp.evict.__dentry_kill.dentry_kill.dput.__fput
      2.11 ±  2%     +22.8       24.88 ±  2%  perf-profile.calltrace.cycles-pp.__dentry_kill.dentry_kill.dput.__fput.task_work_run
      2.11 ±  2%     +22.8       24.88 ±  2%  perf-profile.calltrace.cycles-pp.dentry_kill.dput.__fput.task_work_run.exit_to_user_mode_loop
      2.12 ±  2%     +22.8       24.90 ±  2%  perf-profile.calltrace.cycles-pp.dput.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      2.12 ±  2%     +22.8       24.92 ±  2%  perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.13 ±  2%     +22.8       24.94 ±  2%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      2.13 ±  2%     +22.8       24.94 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.13 ±  2%     +22.8       24.95 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.13 ±  2%     +22.8       24.95 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.14 ±  2%     +22.8       24.96 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.14 ±  2%     +22.8       24.96 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      2.14 ±  2%     +22.8       24.97 ±  2%  perf-profile.calltrace.cycles-pp.__close
      7.64           +24.3       31.96        perf-profile.calltrace.cycles-pp.ext4_da_write_begin.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     79.66           -79.7        0.00        perf-profile.children.cycles-pp.generic_write_end
     76.80           -76.3        0.47 ±  5%  perf-profile.children.cycles-pp.__mark_inode_dirty
     49.44 ±  2%     -49.1        0.29 ±  7%  perf-profile.children.cycles-pp.ext4_dirty_inode
     45.07 ±  2%     -44.8        0.26 ±  6%  perf-profile.children.cycles-pp.jbd2__journal_start
     44.63           -44.4        0.24 ±  9%  perf-profile.children.cycles-pp.start_this_handle
     94.08           -40.3       53.79        perf-profile.children.cycles-pp.ext4_buffered_write_iter
     89.58           -40.2       49.37        perf-profile.children.cycles-pp.generic_perform_write
     94.86           -35.5       59.35        perf-profile.children.cycles-pp.vfs_write
     95.07           -34.6       60.42        perf-profile.children.cycles-pp.ksys_write
     96.01           -30.5       65.50        perf-profile.children.cycles-pp.write
     25.82 ±  4%     -25.7        0.08 ± 11%  perf-profile.children.cycles-pp.__ext4_journal_stop
     25.71 ±  4%     -25.6        0.08 ± 12%  perf-profile.children.cycles-pp.jbd2_journal_stop
     15.04 ±  4%     -15.0        0.05 ± 13%  perf-profile.children.cycles-pp.add_transaction_credits
     12.43 ± 12%     -12.4        0.00        perf-profile.children.cycles-pp.stop_this_handle
     98.83            -5.0       93.82        perf-profile.children.cycles-pp.do_syscall_64
     98.97            -4.6       94.41        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.46            -4.3        0.19 ±  3%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      2.62 ± 28%      -2.3        0.36 ±  6%  perf-profile.children.cycles-pp.generic_update_time
      2.30 ±  4%      -2.2        0.10 ±  5%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      2.12 ±  2%      -2.0        0.15 ±  5%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      1.62 ±  5%      -1.5        0.08 ±  6%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      1.66 ±  2%      -1.5        0.13 ±  5%  perf-profile.children.cycles-pp.ext4_do_update_inode
      1.60 ±  5%      -1.5        0.07 ±  5%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      1.45 ±  6%      -1.4        0.08        perf-profile.children.cycles-pp.__getblk_gfp
      1.41 ±  6%      -1.3        0.08 ±  4%  perf-profile.children.cycles-pp.__find_get_block
      1.30 ±  9%      -1.2        0.09 ±  7%  perf-profile.children.cycles-pp._raw_read_lock
      2.93 ± 26%      -1.0        1.96 ±  2%  perf-profile.children.cycles-pp.file_modified_flags
      1.00 ±  3%      -0.9        0.09 ±  6%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      1.18 ±  3%      -0.7        0.52 ±  3%  perf-profile.children.cycles-pp.folio_unlock
      0.54 ±  4%      -0.5        0.03 ± 70%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      0.34 ±  5%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.72 ±  4%      -0.2        0.48 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
      0.72 ±  5%      -0.2        0.54        perf-profile.children.cycles-pp.up_write
      0.17 ±  3%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.39 ±  4%      -0.1        0.32 ±  4%  perf-profile.children.cycles-pp.ext4_es_lookup_extent
      0.11 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp._raw_write_lock
      0.11 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.up_read
      0.14 ±  8%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.__es_remove_extent
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.filemap_free_folio
      0.06 ±  7%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.___slab_alloc
      0.08 ±  4%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.01 ±223%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.xas_alloc
      0.11 ± 22%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.do_open
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.ext4_getblk
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.folio_memcg_unlock
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.times
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ext4_bread
      0.09 ±  4%      +0.1        0.15 ±  2%  perf-profile.children.cycles-pp.__ext4_new_inode
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.wait_consider_task
      0.06 ± 11%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.refill_obj_stock
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.radix_tree_lookup
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.ext4_orphan_del
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.xas_set_mark
      0.07 ± 10%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.try_charge_memcg
      0.05            +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.ext4_add_nondir
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.__ext4_read_dirblock
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.15 ±  6%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.__dquot_alloc_space
      0.34 ±  4%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.ext4_es_insert_delayed_block
      0.14            +0.1        0.21 ±  4%  perf-profile.children.cycles-pp.__ext4_unlink
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.ext4_es_can_be_merged
      0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.14            +0.1        0.21 ±  3%  perf-profile.children.cycles-pp.ext4_unlink
      0.15 ±  2%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.vfs_unlink
      0.00            +0.1        0.07 ±  9%  perf-profile.children.cycles-pp.ext4_search_dir
      0.08            +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.jbd2_journal_grab_journal_head
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.uncharge_folio
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.kernel_wait4
      0.00            +0.1        0.08 ± 10%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.add_dirent_to_buf
      0.00            +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.wait4
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.ext4_has_free_clusters
      0.00            +0.1        0.08 ± 12%  perf-profile.children.cycles-pp.__do_sys_wait4
      0.00            +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.ext4_free_inode
      0.04 ± 45%      +0.1        0.12 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.02 ± 99%      +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.ext4_lookup
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.unlock_page
      0.00            +0.1        0.08        perf-profile.children.cycles-pp.__list_add_valid
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.file_modified
      0.09            +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.drop_buffers
      0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.free_unref_page_commit
      0.06            +0.1        0.14 ±  5%  perf-profile.children.cycles-pp.ext4_dx_find_entry
      0.02 ± 99%      +0.1        0.11 ±  6%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.00            +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.06 ±  6%      +0.1        0.15 ±  4%  perf-profile.children.cycles-pp.ext4_claim_free_clusters
      0.06            +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.__ext4_find_entry
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.open64
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.xas_find
      0.02 ±141%      +0.1        0.11 ±  5%  perf-profile.children.cycles-pp.xas_find_conflict
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.00            +0.1        0.09 ±  7%  perf-profile.children.cycles-pp.ext4_dx_add_entry
      0.00            +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.node_page_state
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.ext4_add_entry
      0.00            +0.1        0.10 ±  6%  perf-profile.children.cycles-pp.folio_memcg_lock
      0.01 ±223%      +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.kthread
      0.16 ±  3%      +0.1        0.27 ±  3%  perf-profile.children.cycles-pp.ext4_create
      0.01 ±223%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.ret_from_fork
      0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.xas_create
      0.01 ±223%      +0.1        0.11 ± 20%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.00            +0.1        0.10 ±  7%  perf-profile.children.cycles-pp.xa_get_order
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.generic_file_llseek_size
      0.09 ±  6%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.__es_insert_extent
      0.09 ±  5%      +0.1        0.19        perf-profile.children.cycles-pp.jbd2_journal_try_to_free_buffers
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.aim_rand
      0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.xas_clear_mark
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__x64_sys_lseek
      0.65            +0.1        0.76        perf-profile.children.cycles-pp.do_flush_stats
      0.65            +0.1        0.76        perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.64            +0.1        0.75        perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.00            +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.28 ±  2%      +0.1        0.39 ±  2%  perf-profile.children.cycles-pp.block_invalidate_folio
      0.05            +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.uncharge_batch
      1.57 ±  3%      +0.1        1.69 ±  2%  perf-profile.children.cycles-pp.ext4_da_map_blocks
      0.06 ±  6%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__xa_set_mark
      0.42 ±  2%      +0.1        0.54        perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.14 ±  4%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.00            +0.1        0.12 ±  7%  perf-profile.children.cycles-pp.ext4_release_folio
      0.14 ±  5%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      0.05            +0.1        0.18 ±  6%  perf-profile.children.cycles-pp.__x64_sys_write
      1.59 ±  2%      +0.1        1.72 ±  2%  perf-profile.children.cycles-pp.ext4_da_get_block_prep
      0.65            +0.1        0.79        perf-profile.children.cycles-pp.mem_cgroup_wb_stats
      0.00            +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.rw_verify_area
      0.00            +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.rcu_do_batch
      0.00            +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.alloc_pages
      0.02 ± 99%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.__do_softirq
      0.00            +0.2        0.15        perf-profile.children.cycles-pp.rcu_core
      0.00            +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.31 ±  4%      +0.2        0.47 ±  2%  perf-profile.children.cycles-pp.ext4_da_reserve_space
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.ext4_llseek
      0.02 ±141%      +0.2        0.18 ±  6%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.16 ±  3%      +0.2        0.33        perf-profile.children.cycles-pp.find_lock_entries
      0.03 ±100%      +0.2        0.20 ±  4%  perf-profile.children.cycles-pp.write@plt
      0.66 ±  3%      +0.2        0.83 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.10 ± 12%      +0.2        0.28 ±  2%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.66            +0.2        0.84        perf-profile.children.cycles-pp.balance_dirty_pages
      0.06 ±  7%      +0.2        0.25 ±  5%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.22 ±  3%      +0.2        0.41 ±  2%  perf-profile.children.cycles-pp.lookup_open
      0.18 ±  5%      +0.2        0.37 ±  3%  perf-profile.children.cycles-pp.rmqueue
      0.00            +0.2        0.19 ±  6%  perf-profile.children.cycles-pp.folio_wait_stable
      0.28 ±  7%      +0.2        0.48 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.2        0.19 ± 11%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.00            +0.2        0.19 ± 11%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.09 ±  5%      +0.2        0.30 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.00            +0.2        0.20 ± 15%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.00            +0.2        0.20 ± 15%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.00            +0.2        0.21 ± 15%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +0.2        0.21 ± 16%  perf-profile.children.cycles-pp.cpuidle_enter
      0.01 ±223%      +0.2        0.22 ± 16%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.06 ±  9%      +0.2        0.27 ±  3%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.01 ±223%      +0.2        0.22 ± 16%  perf-profile.children.cycles-pp.start_secondary
      0.01 ±223%      +0.2        0.23 ± 14%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.01 ±223%      +0.2        0.23 ± 14%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.01 ±223%      +0.2        0.23 ± 14%  perf-profile.children.cycles-pp.do_idle
      0.04 ± 44%      +0.2        0.27 ±  6%  perf-profile.children.cycles-pp.inode_needs_update_time
      0.09 ±  6%      +0.2        0.32 ±  2%  perf-profile.children.cycles-pp.free_unref_page_list
      0.32 ±  7%      +0.2        0.55 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
      0.32 ±  7%      +0.2        0.55 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.04 ± 47%      +0.2        0.28 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
      0.06 ±  9%      +0.2        0.29 ±  2%  perf-profile.children.cycles-pp.__get_task_ioprio
      0.45 ±  5%      +0.2        0.69 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.41 ±  6%      +0.2        0.64 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.33 ±  7%      +0.2        0.57 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.00            +0.2        0.24 ±  3%  perf-profile.children.cycles-pp.aa_file_perm
      0.46 ±  5%      +0.2        0.70 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.00            +0.2        0.24 ±  2%  perf-profile.children.cycles-pp.node_dirty_ok
      0.06            +0.2        0.30 ±  3%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.00            +0.2        0.25 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ±  7%      +0.3        0.34 ±  2%  perf-profile.children.cycles-pp.ext4_da_write_end
      0.09 ±  5%      +0.3        0.34 ±  2%  perf-profile.children.cycles-pp.xas_start
      0.06 ±  7%      +0.3        0.32        perf-profile.children.cycles-pp.__file_remove_privs
      0.11 ±  5%      +0.3        0.38 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.3        0.27 ± 10%  perf-profile.children.cycles-pp.inode_to_bdi
      0.00            +0.3        0.27 ±  6%  perf-profile.children.cycles-pp.exit_mm
      0.00            +0.3        0.27 ±  6%  perf-profile.children.cycles-pp.__mmput
      0.00            +0.3        0.27 ±  6%  perf-profile.children.cycles-pp.exit_mmap
      0.07 ±  7%      +0.3        0.35 ±  2%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.07 ±  6%      +0.3        0.36 ±  3%  perf-profile.children.cycles-pp.generic_write_check_limits
      0.00            +0.3        0.29 ±  5%  perf-profile.children.cycles-pp.do_exit
      0.00            +0.3        0.30 ±  6%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.00            +0.3        0.30 ±  6%  perf-profile.children.cycles-pp.do_group_exit
      0.07            +0.3        0.38 ±  2%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.22 ±  8%      +0.3        0.53 ±  2%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      0.00            +0.3        0.32        perf-profile.children.cycles-pp.filemap_unaccount_folio
      0.52 ±  5%      +0.3        0.85 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.06 ±  7%      +0.3        0.41 ±  2%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.16 ±  7%      +0.3        0.51 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
      0.20 ± 10%      +0.4        0.55 ±  2%  perf-profile.children.cycles-pp.__count_memcg_events
      0.88 ±  3%      +0.4        1.24 ±  2%  perf-profile.children.cycles-pp.folio_create_empty_buffers
      0.10 ±  5%      +0.4        0.50 ±  2%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.06 ±  9%      +0.4        0.46 ±  4%  perf-profile.children.cycles-pp.ext4_nonda_switch
      0.29 ±  6%      +0.4        0.72 ±  3%  perf-profile.children.cycles-pp.charge_memcg
      0.18 ±  3%      +0.4        0.63 ±  2%  perf-profile.children.cycles-pp.lru_add_fn
      0.13 ±  8%      +0.5        0.58 ±  2%  perf-profile.children.cycles-pp.xas_store
      0.14 ± 14%      +0.5        0.61        perf-profile.children.cycles-pp.current_time
      0.14 ±  4%      +0.5        0.62 ±  2%  perf-profile.children.cycles-pp.disk_rw
      0.13 ±  5%      +0.5        0.62 ±  2%  perf-profile.children.cycles-pp.xas_descend
      0.25 ±  6%      +0.5        0.75 ±  3%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.33 ±  6%      +0.5        0.84 ±  3%  perf-profile.children.cycles-pp.alloc_buffer_head
      0.33 ±  5%      +0.5        0.86 ±  3%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      0.16 ±  4%      +0.6        0.75 ±  2%  perf-profile.children.cycles-pp.generic_write_checks
      0.36 ±  6%      +0.6        0.96 ±  3%  perf-profile.children.cycles-pp.folio_alloc_buffers
      0.21 ±  3%      +0.6        0.84        perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.29 ±  4%      +0.6        0.93 ±  2%  perf-profile.children.cycles-pp.__alloc_pages
      0.13 ±  6%      +0.6        0.77 ±  4%  perf-profile.children.cycles-pp.ksys_lseek
      0.34 ±  4%      +0.7        1.02        perf-profile.children.cycles-pp.__cond_resched
      0.13 ±  9%      +0.7        0.82 ±  6%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.18 ±  6%      +0.7        0.90 ±  5%  perf-profile.children.cycles-pp.__fget_light
      0.19 ±  4%      +0.7        0.92        perf-profile.children.cycles-pp.ext4_generic_write_checks
      0.32 ±  4%      +0.8        1.08 ±  2%  perf-profile.children.cycles-pp.folio_alloc
      0.15 ±  6%      +0.8        0.93 ±  2%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.22 ±  6%      +0.9        1.12 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.19 ±  5%      +1.0        1.16 ±  2%  perf-profile.children.cycles-pp.security_file_permission
      0.26 ±  3%      +1.0        1.25 ±  2%  perf-profile.children.cycles-pp.xas_load
      0.11 ±  4%      +1.0        1.13 ±  2%  perf-profile.children.cycles-pp.folio_account_cleaned
      0.00            +1.0        1.04 ±  3%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      1.10 ±  4%      +1.1        2.21        perf-profile.children.cycles-pp.filemap_get_entry
      0.16 ±  4%      +1.1        1.29 ±  2%  perf-profile.children.cycles-pp.__folio_cancel_dirty
      0.18 ±  7%      +1.2        1.40 ±  3%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.27 ±  6%      +1.2        1.49 ±  2%  perf-profile.children.cycles-pp.fault_in_readable
      0.09 ±  9%      +1.3        1.36 ±  8%  perf-profile.children.cycles-pp.ext4_file_write_iter
      0.40 ±  2%      +1.3        1.72 ±  3%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.24 ±  5%      +1.3        1.56 ±  2%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.31 ±  6%      +1.4        1.72        perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.64 ± 11%      +1.4        2.09        perf-profile.children.cycles-pp.memset_orig
      0.92            +1.5        2.41 ±  2%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.29 ±  7%      +1.5        1.78 ±  2%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.57 ± 11%      +1.5        2.08        perf-profile.children.cycles-pp.zero_user_segments
      0.22 ±  4%      +1.6        1.82        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.36 ±  4%      +1.7        2.10        perf-profile.children.cycles-pp.__entry_text_start
      0.49 ±  3%      +1.9        2.34        perf-profile.children.cycles-pp.try_to_free_buffers
      1.94 ±  4%      +1.9        3.81 ±  2%  perf-profile.children.cycles-pp.mark_buffer_dirty
      0.93 ±  2%      +2.0        2.94 ±  2%  perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.53 ±  6%      +2.0        2.56        perf-profile.children.cycles-pp.copyin
      0.47 ± 14%      +2.1        2.59 ±  9%  perf-profile.children.cycles-pp.do_unlinkat
      0.47 ± 14%      +2.1        2.60 ±  9%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.47 ± 13%      +2.1        2.61 ±  9%  perf-profile.children.cycles-pp.unlink
      0.56 ± 13%      +2.2        2.72 ±  8%  perf-profile.children.cycles-pp.open_last_lookups
      0.58 ± 12%      +2.2        2.80 ±  7%  perf-profile.children.cycles-pp.__x64_sys_creat
      0.95            +2.2        3.17        perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.59 ± 12%      +2.2        2.81 ±  7%  perf-profile.children.cycles-pp.creat64
      0.61 ± 11%      +2.2        2.84 ±  7%  perf-profile.children.cycles-pp.path_openat
      0.61 ± 11%      +2.2        2.85 ±  7%  perf-profile.children.cycles-pp.do_filp_open
      0.62 ± 11%      +2.3        2.88 ±  7%  perf-profile.children.cycles-pp.do_sys_openat2
      0.29 ±  3%      +2.3        2.59        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      3.34 ±  2%      +2.5        5.88        perf-profile.children.cycles-pp.ext4_block_write_begin
      3.59 ±  5%      +2.6        6.16        perf-profile.children.cycles-pp.__block_commit_write
      0.68 ±  5%      +2.6        3.28        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      3.68 ±  5%      +2.8        6.52        perf-profile.children.cycles-pp.block_write_end
      0.55 ±  4%      +2.9        3.47        perf-profile.children.cycles-pp.llseek
      0.37 ± 29%      +3.7        4.04 ± 10%  perf-profile.children.cycles-pp.osq_lock
      0.62 ± 20%      +4.0        4.61 ±  9%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
      0.58 ± 21%      +4.0        4.58 ±  9%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      1.28 ±  7%      +4.1        5.34 ±  8%  perf-profile.children.cycles-pp.down_write
      0.00            +7.8        7.84        perf-profile.children.cycles-pp.ext4_da_do_write_end
      0.73 ±  3%     +17.0       17.71 ±  4%  perf-profile.children.cycles-pp.folio_add_lru
      0.56 ±  3%     +18.1       18.66 ±  4%  perf-profile.children.cycles-pp.folio_batch_move_lru
      1.66           +18.5       20.13 ±  3%  perf-profile.children.cycles-pp.filemap_add_folio
      0.61 ±  2%     +18.9       19.50 ±  3%  perf-profile.children.cycles-pp.release_pages
      0.59 ±  3%     +19.6       20.21 ±  3%  perf-profile.children.cycles-pp.__folio_batch_release
      4.14 ±  2%     +20.6       24.71 ±  2%  perf-profile.children.cycles-pp.__filemap_get_folio
      1.95 ±  2%     +22.7       24.64 ±  2%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      2.09 ±  2%     +22.7       24.83 ±  2%  perf-profile.children.cycles-pp.ext4_evict_inode
      2.10 ±  2%     +22.8       24.85 ±  2%  perf-profile.children.cycles-pp.evict
      2.11 ±  2%     +22.8       24.88 ±  2%  perf-profile.children.cycles-pp.__dentry_kill
      2.11 ±  2%     +22.8       24.88 ±  2%  perf-profile.children.cycles-pp.dentry_kill
      2.12 ±  2%     +22.8       24.92 ±  2%  perf-profile.children.cycles-pp.dput
      2.16           +22.8       24.96 ±  2%  perf-profile.children.cycles-pp.task_work_run
      2.16 ±  2%     +22.8       24.97 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      2.12 ±  2%     +22.8       24.93 ±  2%  perf-profile.children.cycles-pp.__fput
      2.14 ±  2%     +22.8       24.97 ±  2%  perf-profile.children.cycles-pp.__close
      2.22           +23.0       25.26 ±  2%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.30 ±  2%     +23.5       25.76 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.67           +24.4       32.12        perf-profile.children.cycles-pp.ext4_da_write_begin
      0.66 ±  4%     +35.1       35.74 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.83           +35.2       36.01 ±  4%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.44 ±  2%     +35.2       35.66 ±  4%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     28.10           -27.9        0.16 ± 10%  perf-profile.self.cycles-pp.start_this_handle
     14.95 ±  4%     -14.9        0.05 ± 13%  perf-profile.self.cycles-pp.add_transaction_credits
     13.14 ±  2%     -13.1        0.02 ± 99%  perf-profile.self.cycles-pp.jbd2_journal_stop
     12.36 ± 12%     -12.4        0.00        perf-profile.self.cycles-pp.stop_this_handle
      1.60 ±  6%      -1.5        0.10 ±  3%  perf-profile.self.cycles-pp.__mark_inode_dirty
      1.38 ±  6%      -1.3        0.06 ±  9%  perf-profile.self.cycles-pp.__find_get_block
      1.29 ±  9%      -1.2        0.09 ±  4%  perf-profile.self.cycles-pp._raw_read_lock
      1.16 ±  3%      -0.7        0.49 ±  3%  perf-profile.self.cycles-pp.folio_unlock
      0.71 ±  3%      -0.3        0.44 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      0.70 ±  5%      -0.2        0.48        perf-profile.self.cycles-pp.up_write
      0.36 ±  3%      -0.2        0.17 ±  2%  perf-profile.self.cycles-pp.folio_create_empty_buffers
      0.62 ±  5%      -0.1        0.50 ±  2%  perf-profile.self.cycles-pp.down_write
      0.19 ±  3%      -0.1        0.08 ±  6%  perf-profile.self.cycles-pp.folio_add_lru
      0.38 ±  2%      -0.1        0.28 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.17 ±  3%      -0.1        0.07 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.19 ±  9%      -0.1        0.12 ±  6%  perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.26 ±  4%      -0.1        0.19 ±  4%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.11 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.up_read
      0.11 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp._raw_write_lock
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.filemap_free_folio
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.down_read
      0.08 ±  7%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__es_remove_extent
      0.05 ± 45%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.try_charge_memcg
      0.06 ±  6%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__count_memcg_events
      0.06 ±  6%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.__es_insert_extent
      0.08 ±  4%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.13 ±  7%      +0.0        0.18 ±  4%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.alloc_buffer_head
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.ext4_da_reserve_space
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.xas_set_mark
      0.12 ±  8%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.cgroup_rstat_flush_locked
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.zero_user_segments
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.unlock_page
      0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.wait_consider_task
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.ext4_es_can_be_merged
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.refill_obj_stock
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.aim_rand
      0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.xas_find_conflict
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.xas_find
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__list_add_valid
      0.26 ±  2%      +0.1        0.33 ±  2%  perf-profile.self.cycles-pp.block_invalidate_folio
      0.19 ±  8%      +0.1        0.26        perf-profile.self.cycles-pp.__filemap_add_folio
      0.08            +0.1        0.15        perf-profile.self.cycles-pp.jbd2_journal_grab_journal_head
      0.00            +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.uncharge_folio
      0.00            +0.1        0.07 ± 12%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.02 ± 99%      +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.node_page_state
      0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.ext4_has_free_clusters
      0.06 ±  6%      +0.1        0.14 ±  5%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.09 ±  4%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.drop_buffers
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.charge_memcg
      0.00            +0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__x64_sys_lseek
      0.00            +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.free_unref_page_list
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.alloc_pages
      0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.delete_from_page_cache_batch
      0.00            +0.1        0.09 ±  4%  perf-profile.self.cycles-pp.xas_clear_mark
      0.00            +0.1        0.09 ±  7%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.try_to_free_buffers
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.__folio_cancel_dirty
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.ext4_es_insert_delayed_block
      0.00            +0.1        0.09        perf-profile.self.cycles-pp.generic_file_llseek_size
      0.00            +0.1        0.09 ±  5%  perf-profile.self.cycles-pp.folio_memcg_lock
      0.29 ± 12%      +0.1        0.38        perf-profile.self.cycles-pp.block_write_end
      0.06 ± 17%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.00            +0.1        0.10 ± 15%  perf-profile.self.cycles-pp.acpi_safe_halt
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.14 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.find_lock_entries
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.12 ±  3%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.lru_add_fn
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.folio_alloc_buffers
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_state
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.rw_verify_area
      0.40 ±  3%      +0.1        0.51        perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.00            +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.folio_wait_stable
      0.00            +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.ext4_release_folio
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.folio_account_cleaned
      0.00            +0.1        0.12 ±  5%  perf-profile.self.cycles-pp.__x64_sys_write
      0.00            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.00            +0.1        0.13 ±  2%  perf-profile.self.cycles-pp.ext4_llseek
      0.02 ±141%      +0.1        0.15 ±  7%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.folio_account_dirtied
      0.00            +0.1        0.14 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.12 ±  4%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__alloc_pages
      0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__dquot_alloc_space
      0.00            +0.2        0.15 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.00            +0.2        0.16 ±  4%  perf-profile.self.cycles-pp.ksys_lseek
      0.00            +0.2        0.16 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.00            +0.2        0.16 ±  2%  perf-profile.self.cycles-pp.node_dirty_ok
      0.00            +0.2        0.17 ± 13%  perf-profile.self.cycles-pp.inode_to_bdi
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.ext4_generic_write_checks
      0.08 ±  6%      +0.2        0.25 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.06 ±  9%      +0.2        0.26 ±  4%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.00            +0.2        0.20 ±  3%  perf-profile.self.cycles-pp.aa_file_perm
      0.09 ±  5%      +0.2        0.29 ±  4%  perf-profile.self.cycles-pp.__slab_free
      0.18 ±  5%      +0.2        0.38        perf-profile.self.cycles-pp.release_pages
      0.05            +0.2        0.26 ±  2%  perf-profile.self.cycles-pp.__get_task_ioprio
      0.00            +0.2        0.22 ±  3%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
      0.01 ±223%      +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.mod_objcg_state
      0.07 ±  5%      +0.2        0.29 ±  2%  perf-profile.self.cycles-pp.xas_start
      0.06 ±  9%      +0.2        0.28 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.05 ±  8%      +0.2        0.28        perf-profile.self.cycles-pp.__file_remove_privs
      0.08 ±  4%      +0.2        0.31 ±  2%  perf-profile.self.cycles-pp.ext4_da_write_end
      0.00            +0.2        0.23 ±  3%  perf-profile.self.cycles-pp.__fdget_pos
      0.00            +0.2        0.24 ±  7%  perf-profile.self.cycles-pp.inode_needs_update_time
      0.00            +0.2        0.24 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.06 ± 11%      +0.2        0.31 ±  4%  perf-profile.self.cycles-pp.generic_write_check_limits
      0.02 ±141%      +0.2        0.26 ±  4%  perf-profile.self.cycles-pp.security_file_permission
      0.06 ±  9%      +0.2        0.31 ±  3%  perf-profile.self.cycles-pp.xas_store
      0.03 ± 70%      +0.3        0.29 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.06            +0.3        0.32 ±  2%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.88 ±  4%      +0.3        1.16 ±  2%  perf-profile.self.cycles-pp.filemap_get_entry
      0.06 ±  9%      +0.3        0.34 ±  2%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.21 ±  8%      +0.3        0.53 ±  3%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.08 ±  5%      +0.3        0.40        perf-profile.self.cycles-pp.generic_write_checks
      0.07 ±  7%      +0.3        0.40        perf-profile.self.cycles-pp.ksys_write
      0.09 ± 10%      +0.3        0.43 ±  2%  perf-profile.self.cycles-pp.current_time
      0.08 ±  4%      +0.4        0.43 ±  2%  perf-profile.self.cycles-pp.xas_load
      0.07            +0.4        0.44 ±  3%  perf-profile.self.cycles-pp.ext4_buffered_write_iter
      0.08 ±  6%      +0.4        0.45        perf-profile.self.cycles-pp.do_syscall_64
      0.04 ± 45%      +0.4        0.42 ±  4%  perf-profile.self.cycles-pp.ext4_nonda_switch
      0.08 ±  7%      +0.4        0.47 ±  2%  perf-profile.self.cycles-pp.file_modified_flags
      0.10 ±  5%      +0.4        0.49 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.12 ±  6%      +0.4        0.53 ±  2%  perf-profile.self.cycles-pp.disk_rw
      0.12 ±  4%      +0.4        0.54 ±  2%  perf-profile.self.cycles-pp.xas_descend
      0.08 ± 11%      +0.4        0.51 ±  9%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.19 ±  4%      +0.4        0.62 ±  2%  perf-profile.self.cycles-pp.__cond_resched
      0.08 ± 10%      +0.4        0.52 ±  2%  perf-profile.self.cycles-pp.llseek
      1.46 ±  5%      +0.5        1.92        perf-profile.self.cycles-pp.mark_buffer_dirty
      0.15 ± 15%      +0.5        0.62 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.30 ± 10%      +0.5        0.80 ±  2%  perf-profile.self.cycles-pp.ext4_block_write_begin
      0.13 ±  5%      +0.5        0.64 ±  2%  perf-profile.self.cycles-pp.__entry_text_start
      0.16 ±  5%      +0.6        0.72        perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.11 ±  6%      +0.6        0.67 ±  3%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.11 ± 12%      +0.6        0.74 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.17 ±  7%      +0.7        0.83 ±  5%  perf-profile.self.cycles-pp.__fget_light
      0.00            +0.8        0.84 ±  2%  perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.18 ±  6%      +0.8        1.04 ±  2%  perf-profile.self.cycles-pp.generic_perform_write
      1.33 ±  5%      +0.9        2.20        perf-profile.self.cycles-pp.__block_commit_write
      0.08 ±  9%      +0.9        0.97 ±  3%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.20 ± 11%      +0.9        1.14 ±  2%  perf-profile.self.cycles-pp.write
      0.15 ±  6%      +0.9        1.10 ±  4%  perf-profile.self.cycles-pp.ext4_da_write_begin
      0.25 ±  5%      +1.2        1.44 ±  2%  perf-profile.self.cycles-pp.fault_in_readable
      0.08 ±  8%      +1.2        1.31 ±  8%  perf-profile.self.cycles-pp.ext4_file_write_iter
      0.24 ±  4%      +1.3        1.51 ±  2%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.18 ±  7%      +1.4        1.57 ±  3%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.18 ±  7%      +1.4        1.58 ±  2%  perf-profile.self.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.64 ± 11%      +1.4        2.07        perf-profile.self.cycles-pp.memset_orig
      0.51 ±  6%      +2.0        2.51        perf-profile.self.cycles-pp.copyin
      0.34 ±  5%      +2.1        2.39        perf-profile.self.cycles-pp.vfs_write
      0.37 ± 28%      +3.6        4.01 ± 10%  perf-profile.self.cycles-pp.osq_lock
      0.66 ±  4%     +35.1       35.74 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

