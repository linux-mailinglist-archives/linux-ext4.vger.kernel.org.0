Return-Path: <linux-ext4+bounces-74-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB85C7F3C21
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 04:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2CB1C20E55
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 03:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE66523DF;
	Wed, 22 Nov 2023 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMfJTZny"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0390B90;
	Tue, 21 Nov 2023 19:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700622254; x=1732158254;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mbSsWFoIqIIvhF59+J6QPMYANMqHqouPOfSaGopFfm8=;
  b=KMfJTZny1KJmLy3tbaAZ46akKX7mXTzQDzxcs4RWAUoSFgQWMja7Vybx
   DIY7vvnS+IEQe1V6gwowIv9OCyUp0FJDKTEMnqbwA2RSwysqpEK6SPYo9
   tqmXo/jSavZBb9dyJgLgIa4fOYw5rtzEivcHZUM66qmm0gS3QxKV7hq9H
   j/aL6RVUOb1tRNMzMJdLFBByx5i2ljg6G5+0zMlLkBUrXQPP5prCei7kJ
   dPIweEKn+D+OcktrbUie+uWkKsekuVw7zUu5sb9on7Et2Vkt1WRB8DG56
   RvC48xHNjA5Lg6/D2RagPd1CQDGUVwgGQXVXKdWOL1XtW+WHCmjmrySwE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="390832820"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="390832820"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 19:04:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="832865298"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="832865298"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 19:04:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 19:04:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 19:04:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 19:04:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt0c/f5DjMb7Us87ojo6DFmYzo5b3Trq9ReceGX2MiPrt0VV47KsHtj8JySpAB0xk8C3TQYofsL7g54WlULLl0VuWctKAm4r+PNb+Gltn78A2k78jRfpNQRQTxVCCgAljIk0YdD4ds3A3aLvr2h4mOvjYPF/y28BRMf4yI+FEwc1zlxajqTAfijPaj+jkPZPt7hfX3rNnNNOenj1xZeEu5FQAb4CplVkVKk0L3/HUT8VyT7LYI/WHoiZXUTclQAxnM6qVw+tNIZhhtw0qPPK/iB3XAEgzfF75fJZQYNKKwAX0WIl7llUi/leeQBsCPZp/TR+6OZnwGUYaG4ucwsE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1N/Vrf1Q5IIbM6jd+aDal/ItraKeRgrGvxZsDlaTQ4=;
 b=foWnunSOb5MJkSC7EhjNCTjn3ltGgxPTWFlY6RSyDvVAwecpgGrLbGA74XOT+LEpQI1k36VTEzez4UeDeaUjAMG/mB5l3Izs0+YqxZIzl17hzrmu0aOcgpiJBOI1JNrBl+M2M0gVD/RF9HZtJBEYf8i3maHSOR+NyQpPYW9MjcVXFeuD4CJfdG1Q1IGxB9tOtHmde88TZK7/LrW7epEW2W5l6ZJ/kiTve8FJRwNp/oZa0xYyh6hpAAsiArxb6tjrrMun/1CNMzPP/FsNaS4mTMWVN5AscU068x9zIRk+FOdbIql3pJv8i0u7bmFV2MRWELsQuuDxxVtzrxySATd9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:04:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 03:04:05 +0000
Date: Wed, 22 Nov 2023 11:03:57 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [ext2]  bc943f4872: xfstests.generic.269.fail
Message-ID: <ZV1vnVoEinETb2z1@xsang-OptiPlex-9020>
References: <202311211653.3a9e8678-oliver.sang@intel.com>
 <87zfz7dkpk.fsf@doe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87zfz7dkpk.fsf@doe.com>
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: d74ff85c-fbf3-4dd9-13c0-08dbeb07b049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfRJ4P9MYaN/oUN4xiW10QbfbFC6X7wLgW7MWjdz697ooayMD8AATaRGXg8if1H/u1nzfmypp8bWv3GF+BMafIKBXwa1a+PucVkiBibnpT+1TcfZq9mXYIfElRaFOcYjf9CnmTXnbWQ7J88REQIVhrYFKg7fp7Mb037rleEDjQCw9kME8LwKiz7P3DMZl8cG7QMToGMJunqoYLaKiFlIyEpDGKZsA1KlTYUuvjDHcpeFxKuc5TKcqfRcOG2QMyLm80e/o9gwN0uHLzdsRdqXOphKqx9onM5eaCn48In1vssKmtD7/jT0tes6Lk2BlnCqebxEnuVgWb5kXDe7Il6a3NHSYViMNo94X1r/EXCZPE9wg0b4f47aoZYTlUOC9+ZT4dQ3disD/QrGB6YQAAoqOTFCIl1vJ3jT1Pkyjnt61OkK8wrprbqjKWhD8DrVsg+lxMcAY8qA4aoSnVL5fj4F3niCpgGboHPB6S74ge0hHFiaCXtFkwMfcv5C/si0IXXypc+bR7Ol/bZRYZKQ5pel9HA0mokwEnv0CBCPigIg0xwdd6pwTLFuBocD81BURa8c0tsDxX4clYjxiS6OiR0KsUAhk2ZszvGCd5q+RkpIZdirH5ZfRgLmzPuySd1NVzxmcazBWVOOjxFly/kpdGc8WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(316002)(66946007)(6916009)(6512007)(478600001)(6506007)(6666004)(107886003)(966005)(9686003)(6486002)(33716001)(82960400001)(38100700002)(83380400001)(26005)(86362001)(44832011)(5660300002)(2906002)(4744005)(8676002)(4326008)(8936002)(41300700001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3FWyW99d8J4+/Ps91kD1aRS0v1qnYiKws0fenyDMBs5pv0NZfOpbCBqp7rsR?=
 =?us-ascii?Q?ZBb9RkyhbnMCDU9ku0VdNHqqbzOqWWFE56nYuMruqLnjFRZW9dr2Lc1bNAJK?=
 =?us-ascii?Q?POkwRPwV+VpdtL0U+6EDT2tHjvA25mlxQoiEm3RNAh73SRIekN9usJIZYTIS?=
 =?us-ascii?Q?x90nUpJO0kzdfYwgPxaojHXjxxQy7tRtGKWvkdeWroMyiCj8IgFosnZQPSG2?=
 =?us-ascii?Q?/mRb+EwRg7PljCYa/+QSGKY5OSeVfEPB6MP4j5bL4PGjyorM51fi+zBGgKtj?=
 =?us-ascii?Q?gLZGgBtMHQNALxGLEF1Aao85rl754vS4PSMJ8gAd2BZxZN/Fqy5Eyq76mDaa?=
 =?us-ascii?Q?22FXEAt+ascMkmwaD/4SzK8m4L5rALkaDowuy9xyX0k4cfHHyvsw9G/aLVag?=
 =?us-ascii?Q?SKjWIgjhn7HmYhQFIgNZ5b95SySXekzJoBn8mYyONxb7Anl5QpXZP1eB+uNg?=
 =?us-ascii?Q?WwDU7CZmT7gMxnBvrzMgCZW4WegD2mmU4sq6boZg5IMjbkuibIipChd9N8Qw?=
 =?us-ascii?Q?A26jCktCvaAIg9+/Puv7j5dbBDXMvf2uQvcXic+mikwY/QkhiwqREomMHh2c?=
 =?us-ascii?Q?siPi8ItmxJWZ9lYF8E3XH9ripDHwOUN1LvU0k8vskiJbaKEQvVudhCcAsw2j?=
 =?us-ascii?Q?6/TzLfAe7Ajc1tYsN0O97eJiraDI74ytYP8EEu+HMOcmTdYFqGu3E6eymtcx?=
 =?us-ascii?Q?evQSMYGWt4ETnUK+2u5WS6RhD+BPIczcigpjcsIXzXORuDpwt7w6bViAmobK?=
 =?us-ascii?Q?diDSYQZzV1sEokoF3dJz0j3iACi/9LaVgqgJReRAVULD1cAC7zrkv3hjU60s?=
 =?us-ascii?Q?tLPkgxoyowpX151NeVGsvRCd3NINBRBOUf3wP0sygRs/bAw3wopGW+t10OLg?=
 =?us-ascii?Q?ih0sBuoHeMAJv0sD9WV2WHNguDEzpsBoWJ0TgSCq19y7ssf2BHUXbLTPrxKW?=
 =?us-ascii?Q?FAwIs+0zrUJrPLvlIFsCF93Zbt/eyzTiwawaeLk+F65vTvKCi/+b6Jq2t0bd?=
 =?us-ascii?Q?nFCbA1xXwlPF7msu12sbdF/FDuJR0rdDi454rqqhmmcyD/foobmhM30UCjB9?=
 =?us-ascii?Q?J0dAgKpaMwoscFR4aZrIje5dhpfHzxL6YPjz/pFKpp80xS92VZfyo70cMhB7?=
 =?us-ascii?Q?PCBuhDKbJvhCOWL09Fx/NVS/rqddGHyrAQ6rioW/Bc9V8VRy4CE+Ij+4FIZc?=
 =?us-ascii?Q?gPqb6Ol9rmBLRsnRQvXdvoF5BVoFVxGmzIA8SMU2F+0cimHVZbKR/DdgSr+l?=
 =?us-ascii?Q?eFdUC0i8oTIG+Ox+r80Rfvjm5mVDJh4zlJfUMmAT0T0Szhs1FhObXzsvwDRR?=
 =?us-ascii?Q?2lzj1r0VHGe/BdzxiYgcScg21kQ63rMl2s/0GLSVXxHZcli16+wkBJFmBIn7?=
 =?us-ascii?Q?uzuzjzCe4yHVJwx7n2uucLrV+8usopcQUDQ8rNvLdrQuigIKrK8ydDzBINkL?=
 =?us-ascii?Q?E8Hu1j+9CBT+k4GLWH9waw3d2tZle58gE6UUfSBUP02tpDOQYIBA34hTuYsG?=
 =?us-ascii?Q?ZXBV0+ZuhlUqkU0RPfAQPgNNZ/SYK2PPgeeuFNVyhBGWZgl2Mf12rmPJR/A7?=
 =?us-ascii?Q?8PPjT5P34q10zd7pReFDEDFT0katVwqwB58/nid/2JKK5/FvYsrn1wrTY4eG?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d74ff85c-fbf3-4dd9-13c0-08dbeb07b049
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:04:05.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bZ/u59HEFzg1+sYNrzcszsuvAhpeWqj2jyIl54p79IEjpPS2QBvpTofkfwBuXx47zianms5e+8P5ELQAtw72A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com

hi, Ritesh Harjani,

On Tue, Nov 21, 2023 at 11:58:55PM +0530, Ritesh Harjani wrote:
> kernel test robot <oliver.sang@intel.com> writes:
> 
> > Hello,
> >
> > kernel test robot noticed "xfstests.generic.269.fail" on:
> >
> 
> generic/269 is a ENOSPC with fsstress. There is a recent fix made to
> this testcase [1]. Could it be that you are missing generic/269 fix in
> your tree? xfstests recently got updated here [2].

thanks a lot for information and sorry for false positive.
we've updated the xfstests, confirmed the test PASS now.

> 
> [1]: https://lore.kernel.org/fstests/169687552545.3948976.16961989033707045098.stgit@frogsfrogsfrogs/
> 
> [2]: https://lore.kernel.org/fstests/5fbaeebad0ffc8fc6944b35631ebc117.Zorro%20Lang%20%3Czlang@kernel.org/
> 
> -ritesh

