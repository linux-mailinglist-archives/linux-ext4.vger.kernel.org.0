Return-Path: <linux-ext4+bounces-9389-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E58B2971F
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 04:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D520116EFF0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D33248883;
	Mon, 18 Aug 2025 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dr7HWP71"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEA3176F1;
	Mon, 18 Aug 2025 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755485182; cv=fail; b=k57OY7yXmcqOLSfqycOe8wBOh/Vmo3tno+NGUe7wjjQJg0ppDwkjHIYZ1fiRE1yXZPsaPLVIhVWVtTAyMVB70hpd1OXBe6p5t/n0MdAymf9ZKYZ4h3l+7jZH+ZmkpHLb6rrqZ0vS2vWW8ncEC2bbQpmz6ckO+HRe72Q6qrGykCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755485182; c=relaxed/simple;
	bh=pvgeTJqiznVybBaruZF9pEscsWCKlimUn9F4MP2D/h0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HEhnzDGXeh9xTufw1phf6Le9g9is6umjno9bYk7krN9hufny7o0bR7qQxqL6KlAF8cYxHnVCipEZ1qXG8yT1F6vAbGjrc9eF9FFysIQbaz5opVRTPokqTF/QPiCU2EJ7amrxWutbTt+BM7kXR+1+Am+m+eAbh8fJVATCbR4EMus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dr7HWP71; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755485180; x=1787021180;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=pvgeTJqiznVybBaruZF9pEscsWCKlimUn9F4MP2D/h0=;
  b=dr7HWP71HDhFoI15nq3FGUMBLHyFYH4K4mqIWUKsEBFFqKyf8xrRlr1h
   JMcVCLb/YBasizprrWziQ342S0+bqSCiQ41sEIMnaPgWjzMOv4wytPC3W
   biAC9401lrLI6DIiaMP//itaKfaS8mc0CNG7iUeKe+alkLfq8fi/h7snB
   0fpvgDceq8U2pmSCQzbkcEKr/iIpCsvbMyg5ZJCmBr/8oC7cFkugfPdmr
   dkrlQ3N2LBXhrACd2xwIhhDR2R82D0yY6crRRCGRoVIvgayt5EXz8RfW8
   iJRjyaK2zuBzYkVFS/egEjXcZ/jmDITCiWHZiIhKqYSEo2rZM4hCmgV4h
   Q==;
X-CSE-ConnectionGUID: STqdlJ6DRJ6MIIRKchAbIA==
X-CSE-MsgGUID: naghEBASSu6LBPO46VuhhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57562363"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57562363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:46:20 -0700
X-CSE-ConnectionGUID: jgWhdV57RRutgI2JVILFtg==
X-CSE-MsgGUID: fZXPx2nhTtGDK9CwXHLX3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198471505"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 19:46:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:46:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 19:46:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 19:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMORpE7mQ3fsEzYyHgs1Awpi7RXKBu20c46pz3iA0ePFcUsdppSkwfTpqawfH8h7vV6Pt1n2f/pVf3vMSSW76MWn1rdXOysB8Vp0m/K/sbREKiBW44KQmWgnyAVq3oGwNV6T67eesQiqBq+TlYXgrUJgzmd47p0YM+R4xM2OpdklguTLNRz3JoGo1ekmZAIueqjPU06Tth+Fy/DIx7pC0wXRon9l79syFUyjBin10wil6tNVC+T0v9zkFY/Kfk7hRzdO6kp96YJatyUXT7K6UU/d2Ejo95V1+RVMKWcTpDie0NS2QZyU/iKLZ2N8TqR36mTWRG1F5fk4Sk4O1Izxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIgYMWrBzoqV59rRX7yJasoiMnRHsyDyV1NW9AbqVP4=;
 b=YoFYk/MYqx8+7RFMeBP/4r+vJAKIPSULms4d0K+Uc57VLX6D38s9J8u3O95N4TQtF09BrATOkZUwuJKURkb5CFkWsLKMDVL5M+W/ETE7b5M7+R8pjyc+ickaGAyGL6EDmonXliLHWaQNrWQjSfgYYCfprTua2nFcZmwv4jLx4Eln5PAi7MHu/1UmNQEiJm/Yc8C63udNh1If4oPZIYzxzCtjzrkU0wWMGP4wEXOtsqH+g7YH1yewqVXTi5CEmpespdWQea+zmHgGcSd7xxbX/wqVCULg6K3rD2BOz6XZGrEHvCwftFjbSi2uY/CLFFJ61YFddvmQtWpouGfdX6Jw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 02:46:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 02:46:16 +0000
Date: Mon, 18 Aug 2025 10:46:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Baokun Li <libaokun1@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Ojaswin Mujoo
	<ojaswin@linux.ibm.com>, Zhang Yi <yi.zhang@huawei.com>,
	<linux-ext4@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [ext4]  4b41deb896:  stress-ng.fsize.ops_per_sec
 23.3% improvement
Message-ID: <202508181007.a67b7a17-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e901dc-0666-42e9-44fc-08ddde016733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZOpjdpkZJd2FwY+ujoKr8Q2NJLD8dZddYgGmvIQ60XyNRCn6H3g7D0uC0u?=
 =?iso-8859-1?Q?W1B8hMy0ZhvN0Z9QbNsB+cLWA+YXjSev5Xa0tyySAk9L+q/jUjPVVpUP+J?=
 =?iso-8859-1?Q?eKh9pbdBQl3E7iQhpZzaM8Klr9aFc5AlPHqOLM382fxACeiMWtrJSUF4YD?=
 =?iso-8859-1?Q?WWeIO5ECbKzTeWrfSEB0zqAW3MiAoA5Jwl7ZkVoTdD1YcHx6B3cUx5b8dI?=
 =?iso-8859-1?Q?2z7/XZFQeXMuagUCc5gtT11Br3zJYVGW0O0HmXdVmV1D/wJSxHL7YONY8U?=
 =?iso-8859-1?Q?k/hzVFZIl96D20WzNhcJhMa9jtRtM7XPRWa3pwxSSv5EBARM6nt5YJGleT?=
 =?iso-8859-1?Q?jIwQ7691DbWyK02Oa+zjBT9hKiCtK+MiL7R2BoFGDKRRghVlEU9k3EpIY7?=
 =?iso-8859-1?Q?SCTY9oyhr/ZZL2/8foxSHTzi4xGZWcIDMAuEJ/HCW4GJxsSwyfdEXUc6/R?=
 =?iso-8859-1?Q?BcCzUvWsJ+8348zLaLn7VUg8GkgP8yhxOjtTKrsQdjRO5oFQUmgFcPuYRm?=
 =?iso-8859-1?Q?X+b71wJZ/AGxIZcQvm2Ju2n2QRigxSO0AlicSzMMmQaEaTRjNkQDJiqDUV?=
 =?iso-8859-1?Q?ISsPPg/OVEUMfgkHYJb3OeSMHf40Qzb6NQkQ/2BHlOY3kHb7zJg8YDvewj?=
 =?iso-8859-1?Q?nhGdFGfXV67BiQuZB1h2Q4EBQxbPOrKrKGtN8XnG2AjvpO1gjUxbhtS2SU?=
 =?iso-8859-1?Q?zoU4jg6+aJze3XF4IabnV4RGx5geYUq6MJHvqp5ZDE+pyOoqI+gTD7kL1n?=
 =?iso-8859-1?Q?EZR9zPkT1l9FpnFVmhdUsBvt1p01eXwlat+0B7Cc+AQY9CeUem9cx+WnpB?=
 =?iso-8859-1?Q?BiWfVaH9lGwt6Pct2BNSF/DjDm4Ur9mq9wtfKV7luiAWTvcLt4ojj7iH0G?=
 =?iso-8859-1?Q?Fhst9pKNWTiq0FenBOespOUqQ9sCnkVjJ18wuGusxY5CrDe2zOnd1TN7TP?=
 =?iso-8859-1?Q?qMJPR8wLOAMTXAhf+gy/sDioGEH6iS6E2fr5jJLD6SjVuHPljWDMPZWl5B?=
 =?iso-8859-1?Q?CKN1jZMP5JnCjbp376E6kpeSOC5waSsWxpoEHW0DsoML46kZ9bi/emdO5t?=
 =?iso-8859-1?Q?zgRLrXtBdtXNRv63dbLtZzJYT+vll4QTMmhNFFT5qdkWt57z3f0Ocx2ip6?=
 =?iso-8859-1?Q?rjKV/N/QRnLZi0JPPdNf84wXJd+w4pIGKu2gswwO0abPAOwPLdePHJ7Yx2?=
 =?iso-8859-1?Q?isB1tWFYAR++mCa4UVIaQQMp6FN9IA8su1WKSrPRTMkeRce5vWikqekT6D?=
 =?iso-8859-1?Q?Lg84pxONLx3QAPGX1GQUK7Cs42EVgSwnlcCOYulDI7tB/Ut9tKhKRbwW/d?=
 =?iso-8859-1?Q?AM5p9b1gQFPA6/EtROttkOcninTbl61i05qMHy5sjOzprD6xXU19WeIpiX?=
 =?iso-8859-1?Q?EOTgffgaQyyR+NFcsIEi7wj0huV+u2Ql3xV3fga2PCEkn75ltlIy8/y0Px?=
 =?iso-8859-1?Q?IvAjvF38i+WiXvQD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?azgekBTkWMiPrXt+ylP2JZadzrceBq4WcN+3vSuYMu3UKoMykR5TYrLiaM?=
 =?iso-8859-1?Q?6bSffRy9iQ6fSIT5zMwhsLDabAmRn0uyWCUwcd6xOqBpdtCvVlKMge9YFT?=
 =?iso-8859-1?Q?vtBNRBXhbhD+50C/wxY4ysnV45Jtn4q/UFkj+pVcyQC7D36VZ4MDVJFpQU?=
 =?iso-8859-1?Q?DJmSYt4VXrTotqObrUzWW7k/xrtuu+kTAIfJXyrnGgxBtH43VfYtYSQxbe?=
 =?iso-8859-1?Q?Wb1wtpjZtQD+RlHdI1O/qgLGLQd612xBdW3AN6ay3+Y8v4ngM+4ZRRo0f7?=
 =?iso-8859-1?Q?IEtCTP5Jj832z6bxyKlL24vMSDHt3MTRBjSkyUP1yCfstr2bB2Vg/Nl83+?=
 =?iso-8859-1?Q?V4g8uBevDZ2Rub1nReI+ukrPcIEF7Gp+xuBkJjy2/E5LZ842YMjxvUJLIf?=
 =?iso-8859-1?Q?lqhO3z13hqbdD1HVKNSOlHMdE/aMFWlAi25EL6RufvPy28y5m7/qWcNi2z?=
 =?iso-8859-1?Q?5eZrkY5AHbGyEZtPh7ICEPu20DliDfsOq+WJ8Yc4CTI8P3t1mrC4UTuqz/?=
 =?iso-8859-1?Q?hymFyWWqOn5v6IYk65LUF+na9m0YQ2DLgaUnF9rF2pRcgapztQEgO8Q9Fs?=
 =?iso-8859-1?Q?GNVGxJ7wEE3GOdcWyGzoA6cBoUgAqs1tjD6Z7bUrzXN6bYbFPnDgU+Fqdy?=
 =?iso-8859-1?Q?NdvBLRm6uIxlgFH4sKMiOKDRO7DaCd+YAu2AKq5kLiRSewbXjNhNc1/Auy?=
 =?iso-8859-1?Q?C8as8HO3sIYkTlr00FpjJHc08a6Vou5rnyR67f/iJkxAHogQFGKucJxHPM?=
 =?iso-8859-1?Q?hw3IvoLqVb7sSRucihXkqdvsX/4ySBV899YNN3p1oeMrTd3vYP+HFX4D63?=
 =?iso-8859-1?Q?yKEcgW9+olWBx0BV2F5TxL6xJ6lxzQ6U7VHq10zzKv7xQRZ7hP76AlWlZS?=
 =?iso-8859-1?Q?fCghzPJWL9i99ngxcKRGTi6aqnBRbikWQLT1Yj6hHaDmK4fawA0WLjQleX?=
 =?iso-8859-1?Q?hjmsoRK9E5lPj0WUv+YEXuKfI2cDtDfo2WHJpmkifVyjVXztcJZEakHJ/E?=
 =?iso-8859-1?Q?E2348HAf71FTiD0H7gQIFZz5aPIl2FHd+vaKn0AtGftGW1bM97fm2UlRDu?=
 =?iso-8859-1?Q?h9xbjFOHPr0GQoTrd6gvRI1tqnZV6B0LhIBf+UH61bBXpZbrgXxiUHuHx7?=
 =?iso-8859-1?Q?5kky3lB43E5KOkXXXN8GoitmGd1FKVIyHVGSVW8s0ZndVDP4z0BWeJHvsz?=
 =?iso-8859-1?Q?XhPc+1F3yj1Q/uQFf8D9iZtKBys06jpSlzz/GVQ5pBFvoByEQNCPweUx4h?=
 =?iso-8859-1?Q?wkypW60QaR+cGOCSwuGbSjr45BNTVov5Yko7E4GJ/mWCwj60/ndU8dyQUJ?=
 =?iso-8859-1?Q?bU/nDWFbwS3bBikzQVJrVVPBm32Rrj6GvmIBiwrnQHi+LMDExF3tjS/vd6?=
 =?iso-8859-1?Q?8Xe+wsZ779AilyugCNcTIlppsgT8FciHiexXv3YuBsEQoZj10g7/cWcCSN?=
 =?iso-8859-1?Q?b2xxVfhO8T0RYuv7VEQ6IHiy6/TZaW3pxAhqfTT4thMJOSOsvS3EMN1Vgb?=
 =?iso-8859-1?Q?+8MU2u15ht2+1bBMLnQDCKa2l1VjisPT8nWN5SFZ82wsWPYdF2hY2G6Lmj?=
 =?iso-8859-1?Q?oYtnbug0lnj0BU2T2Cxag2MJ/HhPSmvSyoAAMu4NNppoKKAHYD7HPlWoGB?=
 =?iso-8859-1?Q?MaK2v6X4H9Wt7kaz/R9NgR/4B/iIw4pybZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e901dc-0666-42e9-44fc-08ddde016733
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:46:16.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+Xw00cwKolbF8gg7OnNK8KI9H9TpqbaeQC0yNCgZ5K0trhHx3kjLMH5F9ecsEZOP2SmvLmYigr8VSQFWjnaQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 23.3% improvement of stress-ng.fsize.ops_per_sec on:


commit: 4b41deb896e3d0417701759194f0765c06258b9c ("ext4: remove unnecessary s_md_lock on update s_mb_last_group")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory
parameters:

	nr_threads: 100%
	disk: 1SSD
	testtime: 60s
	fs: ext4
	test: fsize
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250818/202508181007.a67b7a17-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1SSD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/igk-spr-2sp1/fsize/stress-ng/60s

commit: 
  f0374d8071 ("ext4: remove unnecessary s_mb_last_start")
  4b41deb896 ("ext4: remove unnecessary s_md_lock on update s_mb_last_group")

f0374d80711adf86 4b41deb896e3d0417701759194f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.486e+08 ±  4%     +20.0%  4.183e+08 ±  5%  cpuidle..time
      0.29 ± 32%    +215.9%       0.90 ± 27%  iostat.cpu.iowait
      6783            +5.6%       7160        vmstat.system.cs
    414835            +4.2%     432174        vmstat.system.in
      0.29 ± 33%      +0.6        0.93 ± 28%  mpstat.cpu.all.iowait%
      1.00 ±  5%      -0.1        0.89 ±  4%  mpstat.cpu.all.irq%
      0.04 ±  2%      +0.0        0.05 ±  3%  mpstat.cpu.all.soft%
   9298066 ±  4%     +23.5%   11484309 ±  2%  numa-numastat.node0.local_node
   9407338 ±  4%     +22.9%   11564393 ±  2%  numa-numastat.node0.numa_hit
   9564550 ±  3%     +19.6%   11436032 ±  5%  numa-numastat.node1.local_node
   9653705 ±  3%     +19.7%   11555011 ±  4%  numa-numastat.node1.numa_hit
   9362645 ±  3%     +23.6%   11568925 ±  2%  numa-vmstat.node0.numa_hit
   9253372 ±  4%     +24.2%   11488841 ±  2%  numa-vmstat.node0.numa_local
   9609252 ±  3%     +20.3%   11556685 ±  4%  numa-vmstat.node1.numa_hit
   9520097 ±  3%     +20.1%   11437766 ±  5%  numa-vmstat.node1.numa_local
      3564 ±  7%     +12.7%       4018 ±  6%  perf-c2c.DRAM.local
     31639 ±  7%     +17.7%      37225 ±  6%  perf-c2c.DRAM.remote
     38438 ±  8%     +32.8%      51055 ±  5%  perf-c2c.HITM.local
     17530 ±  8%     +28.1%      22465 ±  6%  perf-c2c.HITM.remote
     55969 ±  8%     +31.4%      73520 ±  5%  perf-c2c.HITM.total
     66700            +6.4%      70950        proc-vmstat.nr_slab_reclaimable
  19021176 ±  3%     +21.6%   23136506        proc-vmstat.numa_hit
  18822748 ±  3%     +21.9%   22937443        proc-vmstat.numa_local
  21083213 ±  3%     +23.5%   26028768        proc-vmstat.pgalloc_normal
  20599860 ±  4%     +24.3%   25614743        proc-vmstat.pgfree
    869734 ±  3%     -31.1%     599551 ± 11%  sched_debug.cpu.avg_idle.avg
    181478 ± 14%     -87.9%      21936 ± 23%  sched_debug.cpu.avg_idle.min
    926.00 ±  3%     +10.2%       1020 ±  3%  sched_debug.cpu.nr_switches.min
     38.67 ± 25%     -32.5%      26.08 ± 18%  sched_debug.cpu.nr_uninterruptible.max
      5.72 ± 15%     -20.4%       4.56 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
      1600 ±  4%     +23.1%       1970        stress-ng.fsize.SIGXFSZ_signals_per_sec
    409112 ±  4%     +23.3%     504442        stress-ng.fsize.ops
      6819 ±  4%     +23.3%       8408        stress-ng.fsize.ops_per_sec
     15.18 ±  4%     +47.3%      22.37 ±  2%  stress-ng.time.user_time
      4913 ±  3%    +239.6%      16687 ±  9%  stress-ng.time.voluntary_context_switches
      1.35 ±  3%      +6.1%       1.43        perf-stat.i.MPKI
 1.508e+10            -8.2%  1.385e+10 ±  4%  perf-stat.i.branch-instructions
      0.37            +0.1        0.46        perf-stat.i.branch-miss-rate%
  53745812 ±  2%     +13.9%   61238496 ±  3%  perf-stat.i.branch-misses
      6655 ±  2%      +6.1%       7059        perf-stat.i.context-switches
    302.05           +11.2%     335.91        perf-stat.i.cpu-migrations
      0.13            -5.5%       0.12 ±  3%  perf-stat.i.ipc
      1.34 ±  3%      +6.4%       1.42        perf-stat.overall.MPKI
      0.35            +0.1        0.44        perf-stat.overall.branch-miss-rate%
 1.482e+10            -8.3%  1.359e+10 ±  4%  perf-stat.ps.branch-instructions
  52582897 ±  2%     +13.7%   59787848 ±  2%  perf-stat.ps.branch-misses
      6516 ±  2%      +6.0%       6904        perf-stat.ps.context-switches
    295.57           +11.1%     328.32 ±  2%  perf-stat.ps.cpu-migrations
 4.006e+12            -5.9%  3.768e+12 ±  3%  perf-stat.total.instructions
      0.01 ±124%   +1076.9%       0.15 ± 64%  perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.04 ± 77%    +706.0%       0.31 ± 91%  perf-sched.sch_delay.avg.ms.__cond_resched.do_ftruncate.do_sys_ftruncate.__x64_sys_ftruncate.do_syscall_64
      3.04 ±  7%     -42.0%       1.77 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.16 ± 14%     +68.2%       0.27 ± 15%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.00 ±103%   +1355.2%       0.07 ± 53%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      2.99 ± 28%     -25.2%       2.24 ±  7%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_mb_initialize_context
      0.31 ±154%    +340.7%       1.39 ± 50%  perf-sched.sch_delay.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      0.81 ±145%    +164.4%       2.14 ± 66%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_mb_mark_context.ext4_mb_clear_bb.ext4_remove_blocks
      0.02 ±138%   +3796.0%       0.65 ±103%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.66 ±163%    +348.6%       2.97 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_ext_truncate.ext4_truncate.ext4_setattr
      1.59 ± 92%    +121.2%       3.51 ± 12%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_truncate.ext4_setattr.notify_change
      0.07 ± 71%   +1499.3%       1.07 ±115%  perf-sched.sch_delay.max.ms.__cond_resched.do_ftruncate.do_sys_ftruncate.__x64_sys_ftruncate.do_syscall_64
      3.74 ±  6%     +29.7%       4.85 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.ext4_map_blocks.ext4_alloc_file_blocks.isra
      3.16 ±  7%     +35.0%       4.26 ±  5%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.unmap_mapping_range.truncate_pagecache.ext4_setattr
      0.46 ±159%    +331.6%       1.99 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.ext4_free_blocks.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
      0.55 ±190%    +351.1%       2.47 ± 66%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      0.24 ± 28%     +63.9%       0.39 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.71 ± 21%     +61.7%       2.76 ± 29%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.01 ±107%   +6151.4%       0.36 ± 34%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.69 ±132%    +561.4%       4.55 ± 24%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__find_get_block_slow.find_get_block_common
      0.31 ±154%    +340.7%       1.39 ± 50%  perf-sched.sch_delay.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      3570 ±  9%     +27.7%       4557 ±  7%  perf-sched.total_wait_and_delay.max.ms
      3570 ±  9%     +27.7%       4557 ±  7%  perf-sched.total_wait_time.max.ms
      0.95 ± 12%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap.ext4_mb_mark_context
      1226 ±  5%     -79.6%     250.00 ± 19%  perf-sched.wait_and_delay.count.__cond_resched.__ext4_handle_dirty_metadata.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks
    278.17 ± 18%    +333.4%       1205 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      1465 ±  3%     -92.0%     117.67 ± 71%  perf-sched.wait_and_delay.count.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.ext4_read_block_bitmap_nowait
    216.83 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap.ext4_mb_mark_context
     25.17 ±223%   +2141.1%     564.00 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.down_write.ext4_setattr.notify_change.do_truncate
    271.33 ± 18%    +315.5%       1127 ± 23%  perf-sched.wait_and_delay.count.__cond_resched.down_write.ext4_truncate.ext4_setattr.notify_change
      1778 ±  3%     -77.4%     402.33 ± 10%  perf-sched.wait_and_delay.count.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
    759.17 ± 22%     +90.0%       1442 ± 17%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     20.19 ± 85%    +838.0%     189.37 ± 85%  perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
     18.44 ± 46%     -71.0%       5.34 ± 70%  perf-sched.wait_and_delay.max.ms.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.ext4_read_block_bitmap_nowait
     21.76 ± 64%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap.ext4_mb_mark_context
      7.06 ±223%   +2468.4%     181.45 ± 93%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.ext4_setattr.notify_change.do_truncate
      2676 ± 14%     -72.6%     733.87 ±142%  perf-sched.wait_and_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.04 ± 77%    +745.3%       0.33 ± 95%  perf-sched.wait_time.avg.ms.__cond_resched.do_ftruncate.do_sys_ftruncate.__x64_sys_ftruncate.do_syscall_64
      0.48 ± 28%    +245.9%       1.65 ± 79%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.ext4_map_blocks.ext4_alloc_file_blocks.isra
      3.75 ± 47%     -37.0%       2.36 ±  5%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_mb_initialize_context
      0.31 ±154%    +351.8%       1.42 ± 44%  perf-sched.wait_time.avg.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
      1.19 ±104%    +187.2%       3.43 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
      0.81 ±145%    +164.4%       2.14 ± 66%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_mb_mark_context.ext4_mb_clear_bb.ext4_remove_blocks
     18.34 ± 93%    +932.7%     189.35 ± 85%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      0.15 ±127%    +384.4%       0.71 ± 89%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.66 ±163%    +348.6%       2.97 ± 44%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_ext_truncate.ext4_truncate.ext4_setattr
      0.99 ±137%    +179.9%       2.78 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_setattr.notify_change.do_truncate
      1.59 ± 92%    +121.2%       3.51 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_truncate.ext4_setattr.notify_change
     17.82 ± 52%     -70.1%       5.33 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.ext4_read_block_bitmap_nowait
      0.07 ± 71%   +1499.3%       1.07 ±115%  perf-sched.wait_time.max.ms.__cond_resched.do_ftruncate.do_sys_ftruncate.__x64_sys_ftruncate.do_syscall_64
      7.20 ±107%   +2430.6%     182.16 ± 79%  perf-sched.wait_time.max.ms.__cond_resched.down_read.ext4_map_blocks.ext4_alloc_file_blocks.isra
      3.16 ±  7%   +2622.2%      85.90 ±141%  perf-sched.wait_time.max.ms.__cond_resched.down_read.unmap_mapping_range.truncate_pagecache.ext4_setattr
      3.78 ±  6%   +4780.6%     184.48 ± 91%  perf-sched.wait_time.max.ms.__cond_resched.down_write.ext4_map_blocks.ext4_alloc_file_blocks.isra
      0.46 ±159%    +331.6%       1.99 ± 53%  perf-sched.wait_time.max.ms.__cond_resched.ext4_free_blocks.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
      4.47 ± 36%   +2537.3%     117.99 ±123%  perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_ext_remove_space.ext4_ext_truncate
      0.55 ±190%    +351.1%       2.47 ± 66%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      2668 ± 14%     -70.3%     793.19 ±127%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      4.94 ±169%   +2462.5%     126.53 ±116%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.__find_get_block_slow.find_get_block_common
      0.31 ±154%    +351.8%       1.42 ± 44%  perf-sched.wait_time.max.ms.schedule_timeout.khugepaged_wait_work.khugepaged.kthread
     29.76 ±100%     -18.9       10.89 ±223%  perf-profile.calltrace.cycles-pp.ext4_ext_remove_space.ext4_ext_truncate.ext4_truncate.ext4_setattr.notify_change
     29.65 ±100%     -18.8       10.84 ±223%  perf-profile.calltrace.cycles-pp.ext4_ext_rm_leaf.ext4_ext_remove_space.ext4_ext_truncate.ext4_truncate.ext4_setattr
     29.63 ±100%     -18.8       10.82 ±223%  perf-profile.calltrace.cycles-pp.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space.ext4_ext_truncate.ext4_truncate
     29.62 ±100%     -18.8       10.82 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space.ext4_ext_truncate
     29.92 ±100%     -18.8       11.15 ±223%  perf-profile.calltrace.cycles-pp.ext4_ext_truncate.ext4_truncate.ext4_setattr.notify_change.do_truncate
     30.90 ±100%     -18.4       12.49 ±223%  perf-profile.calltrace.cycles-pp.ext4_truncate.ext4_setattr.notify_change.do_truncate.do_ftruncate
     32.51 ±100%     -17.9       14.63 ±223%  perf-profile.calltrace.cycles-pp.ftruncate64
     32.50 ±100%     -17.9       14.62 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
     32.50 ±100%     -17.9       14.62 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     32.48 ±100%     -17.9       14.62 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     32.48 ±100%     -17.9       14.62 ±223%  perf-profile.calltrace.cycles-pp.do_ftruncate.do_sys_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     32.48 ±100%     -17.9       14.62 ±223%  perf-profile.calltrace.cycles-pp.do_sys_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
     32.47 ±100%     -17.9       14.60 ±223%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_ftruncate.do_sys_ftruncate.__x64_sys_ftruncate
     32.47 ±100%     -17.9       14.61 ±223%  perf-profile.calltrace.cycles-pp.do_truncate.do_ftruncate.do_sys_ftruncate.__x64_sys_ftruncate.do_syscall_64
     32.46 ±100%     -17.9       14.60 ±223%  perf-profile.calltrace.cycles-pp.ext4_setattr.notify_change.do_truncate.do_ftruncate.do_sys_ftruncate
     16.57 ±100%     -15.6        0.99 ±223%  perf-profile.calltrace.cycles-pp.ext4_map_create_blocks.ext4_map_blocks.ext4_alloc_file_blocks.ext4_do_fallocate.ext4_fallocate
     16.54 ±100%     -15.6        0.98 ±223%  perf-profile.calltrace.cycles-pp.ext4_ext_map_blocks.ext4_map_create_blocks.ext4_map_blocks.ext4_alloc_file_blocks.ext4_do_fallocate
     16.49 ±100%     -15.5        0.96 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks.ext4_map_blocks.ext4_alloc_file_blocks
     16.71 ±100%     -15.5        1.26 ±223%  perf-profile.calltrace.cycles-pp.ext4_map_blocks.ext4_alloc_file_blocks.ext4_do_fallocate.ext4_fallocate.vfs_fallocate
     17.33 ±100%     -15.4        1.96 ±223%  perf-profile.calltrace.cycles-pp.fallocate64
     17.31 ±100%     -15.4        1.95 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     17.31 ±100%     -15.4        1.95 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     17.21 ±100%     -15.3        1.86 ±223%  perf-profile.calltrace.cycles-pp.ext4_do_fallocate.ext4_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     17.18 ±100%     -15.3        1.85 ±223%  perf-profile.calltrace.cycles-pp.ext4_alloc_file_blocks.ext4_do_fallocate.ext4_fallocate.vfs_fallocate.__x64_sys_fallocate
     17.23 ±100%     -15.3        1.91 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     17.23 ±100%     -15.3        1.91 ±223%  perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     17.23 ±100%     -15.3        1.90 ±223%  perf-profile.calltrace.cycles-pp.ext4_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.94 ±100%     -12.7        4.20 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_free_metadata.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
     11.97 ±100%     -11.4        0.58 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks.ext4_map_blocks
      9.83 ±100%      -6.8        3.06 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_mark_context.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
      9.69 ±100%      -6.7        2.98 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_mb_mark_context.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      9.67 ±100%      -6.7        2.98 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ext4_mb_mark_context.ext4_mb_clear_bb.ext4_remove_blocks
      8.41 ±100%      -6.3        2.07 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_mb_free_metadata.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      8.42 ±100%      -6.3        2.08 ±223%  perf-profile.calltrace.cycles-pp.ext4_try_merge_freed_extent.ext4_mb_free_metadata.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      8.40 ±100%      -6.3        2.06 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_try_merge_freed_extent.ext4_mb_free_metadata.ext4_mb_clear_bb.ext4_remove_blocks
      8.39 ±100%      -6.3        2.06 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ext4_mb_free_metadata.ext4_mb_clear_bb.ext4_remove_blocks
      8.36 ±100%      -6.3        2.04 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ext4_try_merge_freed_extent.ext4_mb_free_metadata.ext4_mb_clear_bb
      5.35 ±100%      -5.4        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
      5.33 ±100%      -5.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks
      4.46 ±100%      -4.1        0.34 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks.ext4_map_blocks
      4.45 ±100%      -4.1        0.34 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
      4.24 ±100%      -4.0        0.24 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks.ext4_ext_map_blocks
      4.23 ±100%      -4.0        0.24 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks
      3.58 ±100%      -3.4        0.13 ±223%  perf-profile.calltrace.cycles-pp.ext4_mb_complex_scan_group.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
      3.31 ±100%      -3.3        0.00        perf-profile.calltrace.cycles-pp.ext4_mb_use_best_found.ext4_mb_complex_scan_group.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks
      3.28 ±100%      -3.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_mb_use_best_found.ext4_mb_complex_scan_group.ext4_mb_regular_allocator.ext4_mb_new_blocks
      3.26 ±100%      -3.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ext4_mb_use_best_found.ext4_mb_complex_scan_group.ext4_mb_regular_allocator
      2.66 ±100%      +0.8        3.46 ±223%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      2.67 ±100%      +0.8        3.46 ±223%  perf-profile.calltrace.cycles-pp._raw_spin_lock.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
     49.87 ±100%     -33.3       16.60 ±223%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     49.86 ±100%     -33.3       16.60 ±223%  perf-profile.children.cycles-pp.do_syscall_64
     44.38 ±100%     -33.1       11.32 ±223%  perf-profile.children.cycles-pp._raw_spin_lock
     44.30 ±100%     -32.5       11.80 ±223%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     29.76 ±100%     -18.9       10.89 ±223%  perf-profile.children.cycles-pp.ext4_ext_remove_space
     29.65 ±100%     -18.8       10.84 ±223%  perf-profile.children.cycles-pp.ext4_ext_rm_leaf
     29.63 ±100%     -18.8       10.82 ±223%  perf-profile.children.cycles-pp.ext4_mb_clear_bb
     29.63 ±100%     -18.8       10.82 ±223%  perf-profile.children.cycles-pp.ext4_remove_blocks
     29.92 ±100%     -18.8       11.16 ±223%  perf-profile.children.cycles-pp.ext4_ext_truncate
     30.90 ±100%     -18.4       12.49 ±223%  perf-profile.children.cycles-pp.ext4_truncate
     32.52 ±100%     -17.9       14.63 ±223%  perf-profile.children.cycles-pp.ftruncate64
     32.48 ±100%     -17.9       14.62 ±223%  perf-profile.children.cycles-pp.__x64_sys_ftruncate
     32.48 ±100%     -17.9       14.62 ±223%  perf-profile.children.cycles-pp.do_sys_ftruncate
     32.48 ±100%     -17.9       14.62 ±223%  perf-profile.children.cycles-pp.do_ftruncate
     32.47 ±100%     -17.9       14.60 ±223%  perf-profile.children.cycles-pp.notify_change
     32.47 ±100%     -17.9       14.61 ±223%  perf-profile.children.cycles-pp.do_truncate
     32.46 ±100%     -17.9       14.60 ±223%  perf-profile.children.cycles-pp.ext4_setattr
     16.57 ±100%     -15.6        0.99 ±223%  perf-profile.children.cycles-pp.ext4_map_create_blocks
     16.49 ±100%     -15.5        0.96 ±223%  perf-profile.children.cycles-pp.ext4_mb_new_blocks
     16.72 ±100%     -15.5        1.26 ±223%  perf-profile.children.cycles-pp.ext4_map_blocks
     16.64 ±100%     -15.4        1.22 ±223%  perf-profile.children.cycles-pp.ext4_ext_map_blocks
     17.33 ±100%     -15.4        1.96 ±223%  perf-profile.children.cycles-pp.fallocate64
     17.21 ±100%     -15.3        1.86 ±223%  perf-profile.children.cycles-pp.ext4_do_fallocate
     17.18 ±100%     -15.3        1.85 ±223%  perf-profile.children.cycles-pp.ext4_alloc_file_blocks
     17.23 ±100%     -15.3        1.91 ±223%  perf-profile.children.cycles-pp.vfs_fallocate
     17.23 ±100%     -15.3        1.91 ±223%  perf-profile.children.cycles-pp.__x64_sys_fallocate
     17.23 ±100%     -15.3        1.90 ±223%  perf-profile.children.cycles-pp.ext4_fallocate
     16.94 ±100%     -12.7        4.20 ±223%  perf-profile.children.cycles-pp.ext4_mb_free_metadata
     11.97 ±100%     -11.4        0.58 ±223%  perf-profile.children.cycles-pp.ext4_mb_regular_allocator
     14.28 ±100%     -10.9        3.40 ±223%  perf-profile.children.cycles-pp.ext4_mb_mark_context
      8.42 ±100%      -6.3        2.08 ±223%  perf-profile.children.cycles-pp.ext4_try_merge_freed_extent
      5.43 ±100%      -5.4        0.03 ±223%  perf-profile.children.cycles-pp.ext4_mb_use_best_found
      4.46 ±100%      -4.1        0.34 ±223%  perf-profile.children.cycles-pp.ext4_mb_mark_diskspace_used
      3.58 ±100%      -3.5        0.13 ±223%  perf-profile.children.cycles-pp.ext4_mb_complex_scan_group
     43.79 ±100%     -32.1       11.69 ±223%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


