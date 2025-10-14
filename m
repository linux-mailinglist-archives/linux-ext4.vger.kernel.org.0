Return-Path: <linux-ext4+bounces-10869-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3572BD9C8F
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Oct 2025 15:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426673E69BB
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Oct 2025 13:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61797314A62;
	Tue, 14 Oct 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIbYryWJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D8313E10;
	Tue, 14 Oct 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449284; cv=fail; b=tbfazl1c+84A6qUbTk6YXuwu38MZV5mO67fqKZ718ulRUKVv5ppNuSh12p+C+w97ThjhTBqPD5U36RvcsV5yA1hlA6TZpRrBnvlmmFAiJmYHqBJk547WaUq4RVOq5y+v677YWUHzOITsgYPIXSe9qU4KG/AMBLgGzegj3nSrXa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449284; c=relaxed/simple;
	bh=s9tR5u8oUZl/PtnWR1ZaLYKc4TPyu2EMvjVSW1AlckI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxPkQY1ACAkVjb/90BzvtqH773i8h5B4WswYTWOMaPOcP8ckVGKSo8k8Q5coAVInb/QAtC/UuvobnA8Qe+eF7TckKBacC3LAek17tJb9epOYV6NP7CsAWIoMIHjHcQgcQT8YujkOO+1g1Y3BLCRZ0MmIHqX73ReUrsXJReRRvgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIbYryWJ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760449282; x=1791985282;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=s9tR5u8oUZl/PtnWR1ZaLYKc4TPyu2EMvjVSW1AlckI=;
  b=cIbYryWJ+5vP3BWgH3ES5gwNGTI4khxB4rrG7F6lcj67J52tBsPmDKjo
   CPCLhoNIkt3t1G1pujUZn9TkWQopmv3C/uTu07e2PQhGQ1c2VryHocuBc
   zvwRAv8x32fOpwVM49BXPgljGuzWXCnXGC4uPU1mD33SC/r54/k12EoDp
   JrtXpqeKnNt1WcYPeqLClSYP/69E28Ex0aVzsFmuYVRanJLDtOt3qlDpd
   qO/Sl67TP/F32SJgfRUp3nzEQpWdK/ifZBAOZfTSya0QFP0IKdmSWOv+x
   4LD2YHTHx0uzbUpVRD+ElNDpdJeEL6d2OAfF1nJqqRKwX172VvPZWwNPv
   Q==;
X-CSE-ConnectionGUID: tdhyTbrkR+uA0PwnL3C4PA==
X-CSE-MsgGUID: DeYv7K+gSMO5ZjuN2UPwZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62499164"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="62499164"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:41:21 -0700
X-CSE-ConnectionGUID: TYuL3nkZTt6y7nqjDJ3sQQ==
X-CSE-MsgGUID: zbmkE2v8TxG2g4JfCO7H1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182331075"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:41:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:41:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 06:41:20 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:41:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0o8ot3uVWSPkubZ0c/X3GDqbad3I2Di9envhabst9X1vdzKULPGuoRRdnSRl322GLOB1jkn0iBjj42gGIZilc3RlwEK36r9f427M7w+IfqZ0iOtMAHcwqT+0iOz+0T8I6FjPffHUHgqyQE35S8Hv2keABSpfkVDZU4GYV4lf8FtG9brJ9jOQ+hBKMTDKcl4AEWCRvh1acgrS1PMTxfJV+ac9Rxqx2OuufrW3x6zA35ZcnQHgKLT+5AaY2g8p3v9rfmHYY99fDpamncBJ5+aDHEgSEsMli5rUg+ymkIdvYMxDPIXY/gj9kef8LBu21CEvYLfxKhnfCEndWYqjf+/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmpbvAVykKwjtTdKyn2VijQYwFnaeBwhZuRdCQ4oqxs=;
 b=BAP9Gc1aLdIAAUOInyV5Y/iAbJk4qEdbKRjr4ctoqaYxBdU/KUcNqzBwjuuQxaHSsuczLqkedS3Cb3JYWCa0XYQMun1oRg4ryoHrgjFzB5FnYZJtfDx2neK62EohPh0P2VdKXpkTyuDbhs98GDHJ2tuXkyfEQZPl1Q9ISNselggX++FacNq2XH/Ynrsw7HeVNUXO7N3xM00sF7EGuey5toX4PYZweyceHLyzMMx4PcSY827w71qKVGjBQEEy/jLPxKESCFPqDtj/zL2KXTuzmp+BEu74yGGwnbjDid0NyZWg3ngr8SpY2sDwcTVE2JVEQDb5bLAe3uhwhTI4Cpi3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF8B755DBFD.namprd11.prod.outlook.com (2603:10b6:518:1::d36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 13:41:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 13:41:18 +0000
Date: Tue, 14 Oct 2025 21:41:08 +0800
From: kerne test robot <oliver.sang@intel.com>
To: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Deepanshu Kartikey
	<kartikey406@gmail.com>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<oliver.sang@intel.com>
Subject: Re: Forwarded: [PATCH] ext4: reject inline data flag when
 i_extra_isize is zero
Message-ID: <202510142118.8033d04d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <68df92d7.050a0220.2c17c1.0020.GAE@google.com>
X-ClientProxiedBy: KU0P306CA0081.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF8B755DBFD:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eabe74f-24ea-450a-c79f-08de0b275a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h0WtjVbd/wcWGDAZbLEMLv3PQLbCqox3sGV6CnnAoyjZ5HfBvMj2utyXe0AL?=
 =?us-ascii?Q?WwldSdsmHynrjWkmA9355ZE4hUg4kS53dKv6WR+5HgHT10p6s3JufAOvuaFh?=
 =?us-ascii?Q?jj4ZowdF8EComV2sOr9UIWARTyHiJHzo8r6UsE2D3OuKMHSSZE3Vv3ym8Z4q?=
 =?us-ascii?Q?Hf11pQyBu8OihZQyAAi01TmJI35Dmamxf1fjpgLjk4vHTHf82iTSw4R1nBOu?=
 =?us-ascii?Q?Zos+xI0NaJFSo38xH46G3cbvmi/CXYNkRtSKyLRB4Es/B1Wtn4creibG6yTe?=
 =?us-ascii?Q?OGfEknxpGGacrugFWOiFUIJFewRfBhXOG6nyGd1NazLXnYiBlSaJY1frtq2f?=
 =?us-ascii?Q?ywZlxeV7JRnHYqjQqZfJqe0ID1H/ipVpEbd6IRZs4IX+lI4s1L9KUPpReZcy?=
 =?us-ascii?Q?sAY8sgQ03pN2NHy+eooLSkaMFhdVqm+mHcmiPOTujzCwNvm7DFM+kqg3bcld?=
 =?us-ascii?Q?zC5jwDGz/alGW0+KR4PWWN9M8uTbDZrbT0BBX3OjgEh0STtat+9cZjFskdO7?=
 =?us-ascii?Q?tkNAhixNVwm85j8hNLYWkzEwsUUlIjaODA8rrjXzEGs6h+Wo66OC5wKhJXYY?=
 =?us-ascii?Q?cw9v2zUs2FI4gBOKgrIeEhZWJrIV4LkYZhr5bx9X/Wxd+USHdwjXNEzoTgCK?=
 =?us-ascii?Q?DYMFbJdkv7Qqu/0P7SWiLW9G4YYg5WwOBwHTus+WLJeue9d5sefJ6/23VuTD?=
 =?us-ascii?Q?w6HMsJUBuTqay3Pw4J/tInM1cx05cooB5halNv6y/F622GTuLVZXdg2QtSis?=
 =?us-ascii?Q?QuG9QG23ZC3L8ePS1PiuPXUGsaODW1pel921wz9ihjpOZ0tP05Cv5H0c1V5h?=
 =?us-ascii?Q?aTG4z5Aj1AIOjTBISPOWUiBZAhUGBEnxxoSicyWqgIHO9zmhlcRqGUfefiqI?=
 =?us-ascii?Q?M5ZmKaHzbHIDRGUA5YvLedzp2mzOTULxmMWbvv2l30L7qRpRaKK6x29up1eF?=
 =?us-ascii?Q?cHJ3XiNs3LI73vYS6SboSNx+e6u2A/fi7F/FSA1VzDdEn3Jb9+cEAsDcp2xO?=
 =?us-ascii?Q?+yxwOyPlsCBgpBhVS9fY1HpAffjnOkGgxt/zY9zVUwWb6zqXjxacB+V1RAhi?=
 =?us-ascii?Q?I5R+p+IMrHBws49o8iAc+xtChkfPPpctwp0ubHMEuoLlzpu7rAe+vNmoSHWB?=
 =?us-ascii?Q?GrLH7MvdAneQ9LPWqyYrOaLeBxmtLJ/tEIl/Jmy3YWLgb5UsAVfCkaUYd+Z6?=
 =?us-ascii?Q?sVo7WFJ3hk++YxRJmcbxl30UhBczZU5tRhU3IPIwwFf0xmmTVcmBfOG+1VMu?=
 =?us-ascii?Q?1chhB6AUHh8J+MnmvFLj5/zrZw2nsmeGtb0MlUbgo/9qTMC7nmEH8qlCBzGa?=
 =?us-ascii?Q?h0VqUwbpLYm7uCh8pOZrwOf2Z5N5i15+hAEFOIYAefZe1oxjVBbszYOjXtD0?=
 =?us-ascii?Q?+cNP4gl7Qp+8SiiAeyGQKLPBM6Zf+D1ImI4GxnsLaeCeQUeH+sy5gYKQxUeB?=
 =?us-ascii?Q?7AhZC8zMrRQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LyLy8zFCWXEte3EyiLpljmbiDsSEjQuOO3ytKgNxel6UJlq/SPv5+dXNBfb3?=
 =?us-ascii?Q?wq4j8a7VOPlpRIVefTSZ1jWBwvO8HeUq640d/UwGAsgW3pmZ2r2yK7HVMth5?=
 =?us-ascii?Q?u+ht8WPt6+jmwGzOA9GETdL8PHxeY/mCtpjwWmLxvf9R7LMHgIxWWJd5ApiP?=
 =?us-ascii?Q?keF57vGvI9zQ/7A4iPHYGsBvFoIcqXWY5YR8txBIkiU83nWb9Hg3OmWhpeB4?=
 =?us-ascii?Q?fuEF67FHWIL0XssSt2VDLNW7B+/czSI72BgXkwjN5lbFetWS3ygayGyVb85y?=
 =?us-ascii?Q?xNW76fe0sIrchT5rPyj3J4xTyxjZE53AnZ40O61TTEWUTWxcSV59cHPH/hOV?=
 =?us-ascii?Q?xwt23oqgqbofbtvBN4fexNB+QSto/GLpKuzuoJBhlpXi1mTj/8IIVVDaqtlj?=
 =?us-ascii?Q?4Z4NEdgHPBWTibJ8/+sCE+yDlhRjeT0yVsSdm76eoTSVVnD4mz7pl3wd65xx?=
 =?us-ascii?Q?P9JReJJXclP/EI86aff2ZL5l/qa8jKxuW+wNVCFXa8HZRb+bpIW+rn7+ov1N?=
 =?us-ascii?Q?+/Y131UK/Ihc1Kthv9FFIRYS4fBEAdfc9EyJaUvtKmGKkMYHvp7k4/+pK0Vg?=
 =?us-ascii?Q?9u26UhKOvUFNsT42D+pj4G/vs/pUEkcTRdmVZ3p5b8HHZnezimRqX4z+XDT9?=
 =?us-ascii?Q?cfOG3p1Rj+nbYXLI72JGtcJ/2MKCeEKGtvC5Ao2O66atDRfBH5+0H/CRyr4j?=
 =?us-ascii?Q?FY0QCvKcsvWrDsL9aKKCfqNw/MRbiiurWVlGhy63Zllw4MMDdi2sylu4iakG?=
 =?us-ascii?Q?3YW+1FTT+8JKsmso8pE6s3SAdJNZWO+vBrbuseyXrVK0kugCXLSp7XrR1x3A?=
 =?us-ascii?Q?QTzGfPNtrzIqOXTdH1B3rarSZjmDnq/vQ8ez4JlvRTd39etBv81rhPoesQ7Y?=
 =?us-ascii?Q?TzRSuKXQ4AazV+MW/vYr76JWd8gYCWdttkAWUYF1q4sLqOscx9luFowFfkbl?=
 =?us-ascii?Q?LqXufvi3C7kwEGfZXFn9MdSbiOgTbgO/uz1El4nGf1kzocoOSEcqtjIGHKKB?=
 =?us-ascii?Q?If7XfP0zRTnj29uXD7PFCXDxx3oi+Mzlz1Xw5IHW0gqApY5qYrSRK3QnytFi?=
 =?us-ascii?Q?alErMVIo8DwQ7nzjRmTT80dauN/ZV3InPUVlOy4TFsjSFhSNWklO4+cV6Hko?=
 =?us-ascii?Q?Y6/x/8f/poSUX9VGPg6j7FViXnbKpfvj5bMSQgWDY/20ANK0V9NH42SoohQs?=
 =?us-ascii?Q?WnvWobOZIPC1d+pNBJG3Z07ockSGnmZzATRyrkHtDeRu+1+ejdbZJXY7JUVo?=
 =?us-ascii?Q?I7b1HV/cGkyNgJ7IDC6kbLuAJH+2NkWmo5nxDD9R1bTxJf3lEuRf1RyZdg3Z?=
 =?us-ascii?Q?wX8kI2O1hEmkzb9hb/KuBeB3zKmKqjSrwzxrga+WwVHHhxbB42Hp/YAKRxSz?=
 =?us-ascii?Q?CaJQpJI6H5m7UlRPjzVYSBD1QE/e/kUE66eHidmpn56euxrCVL+hPOlGXICL?=
 =?us-ascii?Q?zWWl6FV9boMODukagylT+q01zpw8lJNYQGsmhOlEK0WSsTchHdyF/sPAU2pu?=
 =?us-ascii?Q?95WXvuNcYjYcqjklCLnfBw+sFuGBaVEnvT/j/BvIfC/6sWseLri6emZEiFkZ?=
 =?us-ascii?Q?pkEwato9/bsw1DoZbmGlpZgaThoytNnE6aAIEsKT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eabe74f-24ea-450a-c79f-08de0b275a11
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 13:41:18.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2TWHxovohb1NrthH063cYclyBRhuELRAnzV8w1rbduTYkjttZdW7iGvU7LkvWYZAL06sfysIN+++lKp2LASBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8B755DBFD
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.482.fail" on:

commit: a0c31dc212c0f22e40ee114504562030264e1246 ("Forwarded: [PATCH] ext4: reject inline data flag when i_extra_isize is zero")
url: https://github.com/intel-lab-lkp/linux/commits/syzbot/Forwarded-PATCH-ext4-reject-inline-data-flag-when-i_extra_isize-is-zero/20251003-171522
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/68df92d7.050a0220.2c17c1.0020.GAE@google.com/
patch subject: Forwarded: [PATCH] ext4: reject inline data flag when i_extra_isize is zero

in testcase: xfstests
version: xfstests-x86_64-5a9cd3ef-1_20250910
with following parameters:

	disk: 4HDD
	fs: ext4
	test: generic-482



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510142118.8033d04d-lkp@intel.com

2025-10-09 22:02:09 cd /lkp/benchmarks/xfstests
2025-10-09 22:02:10 export TEST_DIR=/fs/sda1
2025-10-09 22:02:10 export TEST_DEV=/dev/sda1
2025-10-09 22:02:10 export FSTYP=ext4
2025-10-09 22:02:10 export SCRATCH_MNT=/fs/scratch
2025-10-09 22:02:10 mkdir /fs/scratch -p
2025-10-09 22:02:10 export SCRATCH_DEV=/dev/sda4
2025-10-09 22:02:10 export LOGWRITES_DEV=/dev/sda2
2025-10-09 22:02:10 echo generic/482
2025-10-09 22:02:10 ./check -E tests/exclude/ext4 generic/482
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d07 6.17.0-rc4-00019-ga0c31dc212c0 #1 SMP PREEMPT_DYNAMIC Fri Oct 10 05:40:27 CST 2025
MKFS_OPTIONS  -- -F /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/482       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/482.out.bad)
    --- tests/generic/482.out	2025-09-10 01:40:16.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/482.out.bad	2025-10-09 22:03:12.185850079 +0000
    @@ -1,2 +1,3 @@
     QA output created by 482
    -Silence is golden
    +_check_generic_filesystem: filesystem on /dev/mapper/thin-vol.482 is inconsistent
    +(see /lkp/benchmarks/xfstests/results//generic/482.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/482.out /lkp/benchmarks/xfstests/results//generic/482.out.bad'  to see the entire diff)
Ran: generic/482
Failures: generic/482
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251014/202510142118.8033d04d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


