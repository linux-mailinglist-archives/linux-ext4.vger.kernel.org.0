Return-Path: <linux-ext4+bounces-8293-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59131ACC992
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 16:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5500171E74
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jun 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D39239E94;
	Tue,  3 Jun 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCQZHayX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125A4239086;
	Tue,  3 Jun 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962204; cv=fail; b=O3hYfn2NVjxf/Y62awedIH+B+vc9anwljPKSBqxhrlJtQcwKDBI+fuZE1jjXVRcDfCvRgvz8EVQwYaJ8/KhuNnPBDtTZ6cVmafDUQCPCvH0V4KzAVSIerkI2UKgUj6A+Rsi6Vtt085QdtRcBPhpGhPngq33x0l8sOHxlR0/TJYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962204; c=relaxed/simple;
	bh=tI+mWuPbjM5/88MguNMfkm9g+fIbq+1QpyMRDktOWHY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EAMng5w8rSAg3bdBWVRnXnOzqXPIioUB6H3kEVf+LZn8lBOcey7Rm2FjL+ZqoNDYA3XhSmkga4Y6/Y8cUtaa/yCOrhCosnM6+ELrFV7/XqG9A5Qv5hpfSHuOCK3cCzjohU1KQSZQMR9t26gizN/gtEnnag3O5C+HhPyVhrfDb3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCQZHayX; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748962199; x=1780498199;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=tI+mWuPbjM5/88MguNMfkm9g+fIbq+1QpyMRDktOWHY=;
  b=mCQZHayX02Mo7EvBLHBKb7YWAYVP6ero/73WpVbKbXpo1tRORHLuNcft
   SJj8//5oD4Uih5VlWX4oxJTY4x6U5mPqlGCYYbJixcGEk5A4vR3q/7M7o
   EQjIUPjYsD52a/aBVi01k3i/gmh9LmcTptVV3vLUzO+6HCWokVba0JMhq
   CT8JWro3eozMuiJFDWb66AFoF5tl/e/Lx2IqvwUx/6sC3m6Tb7JurNW9C
   nre/HXuhc/dPPm6b+Tbha/R39jdUBmAr/DrMKnUK7zZr5+TBpX09tk3qj
   AiMJD3oAGankFOMw/3lIr1CQk6J/Kf9SWFMVsrhQnpqigmPWqV94yXjdB
   w==;
X-CSE-ConnectionGUID: OGO/zk2hSl+uz8VQ0pqsPw==
X-CSE-MsgGUID: eY82TjYWQruC191jAT/pOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62363740"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="62363740"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:49:58 -0700
X-CSE-ConnectionGUID: YYyqKsB4QBe9KbR7rq53Nw==
X-CSE-MsgGUID: PGts308wQ8aYDxDkXRORbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144769807"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:49:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 07:49:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 07:49:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.79) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 07:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TX8P+Zo0mxMBM2NU19ixDTzrZbbJ6Bl1kBAXpoFRgimMI+ihbzg2enMcvh30sMpZDdgNcSX5Kpuf8emW+Hn9TcgXqnTxjYwmrBx3Citl/1SZyxjdu9+LkWBXPlknKezrlLFm0t6xHLzM7CePGcVuP1vXw8EfKDgvy+hukUN3IriDNk3YeTdwNR6qMpEKls4AOo3vGtvDJ1RmcBSaTPfLJ5gbuOFFLg9i3QGJrXTqedHITjYafWWJ0cybxjFofoIZwodObpKO18IEw0An9n6hc5ECV8cYjBE5SEn155oBqliEX1TArYVmeDZoDe5xopC7M+lwLsZ9rw5cesUdTiNfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eUPcyEQ++2BmcE44+BwYSXX7oi1NQiusLwycvZ0cCI=;
 b=IZFArXH54HKFqHzQsZROU5B/QtJCPq/jA5fPZ1lyFTIacwfjgVhl44RL6ENUXliMcFDAQvE8uvv1EObzlR1ClPjLKuMtbsI+gNjPjxwk5JzlcWMs/j06R2k4/kl89Ye/HbTyHVRo1ebYyhky3YF6orhG5w5gH8bz6/YB5hnboWW4SEuL7JGOlEwPV7S3hAckkzr2cF+L/EnUYk/t49iK3kCfnQp/aPseS0K80ifNM2SCJYTNqTVCFYoQKqKMoUcnlJIcSoix1+hsTWrhFwdkEzPFBodtg5GSNG0DhL6VHjjw/GG/5+7RyaEE3tOLsiLXPxKnG1tsavmbJpMcuvByQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA4PR11MB9060.namprd11.prod.outlook.com (2603:10b6:208:56d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Tue, 3 Jun
 2025 14:49:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 14:49:55 +0000
Date: Tue, 3 Jun 2025 22:49:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Yi <yi.zhang@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [ext4]  7ac67301e8:  aim7.jobs-per-min 22.9%
 regression
Message-ID: <202506032249.cd0b4bc-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0145.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::9) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA4PR11MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: c46cc62f-bc9a-4d41-0e4d-08dda2ade722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Sz794+QYR74Z6B49qbnHkZBLP0eKg7bmHObKP8JgVi9G15q6/wtTM0iz67?=
 =?iso-8859-1?Q?ulTxoSjq4ghckRQtb9IrOve0HR3u15k+x0PD86rOUzekXBPy8UhpKoNI2X?=
 =?iso-8859-1?Q?ObZ3Q8JFyEJm1F7X17GuKjpa/kz4MktTqlOxe6D/d8gQTk6MoIQQjXHSbP?=
 =?iso-8859-1?Q?VxpRDdumMzsn+H0NPcUe42pbrIDC3MI+91sPz960IXMdYWWlHvhuhbMY8E?=
 =?iso-8859-1?Q?WSTkNYHnjSWUIatcL3D3B1Ny/XT0Js5H4JCAOthhLRZ/H7OyyBC6rMsWQE?=
 =?iso-8859-1?Q?3Y83loafXAKhzSHY6PHfAREjyDpSteEn1zsWYAnut3jZ7uFZf9hTcSHqQd?=
 =?iso-8859-1?Q?2cHeECA4N1IUFTDtr8GGk0CnyOqaC1qR2C3+OfmRHvKDq3enhRlH06MFpY?=
 =?iso-8859-1?Q?LS8gtso34jXIdHCRoiu11zWQpBLAvM891pYKTBzUpA3hKWitCVZwN6hc0F?=
 =?iso-8859-1?Q?AG8jJVe0YPGtznMrpUOrClGWB9xfr7XXUNz2+XZNQI8LMShZPWffUYC9kj?=
 =?iso-8859-1?Q?gUN/H/cyVok1NTzagqsRswWQrBnYYx4uuQQSWOO+69Ybu9CPXNFw/G7D/G?=
 =?iso-8859-1?Q?psvH4GscVkwJY4LPCr6tnQphM4cy4rV+Q/NhpNdbeWIbiCIy0O6XC3zEqS?=
 =?iso-8859-1?Q?WPIQWVRTCjlYH6tilrKupxEytHm+rerIEPofakyiQyvUPmWG4eIOo4ffgo?=
 =?iso-8859-1?Q?8QQsm6DiQYZp/mSArC7VC/3JJT0jlHKVCWdcMHps+vlWwinzchK2xgTtiy?=
 =?iso-8859-1?Q?QubZsZzIpqTOwf8RNX0cunqix7yqxa7yQy8OqmfE8G58w0ZeOtk5ynJSw8?=
 =?iso-8859-1?Q?ZRw3D/Rw/elNmB/MOW8dJBDqELTptE6Cu3hN3AEZOvn40kFlJcJJC6COA0?=
 =?iso-8859-1?Q?7WeiEWLh94iaa8vObgp6QFr02Y2k9YGdKgPHC+FDrYZZzvpmXUNvyEvZ2N?=
 =?iso-8859-1?Q?DKBxLifu1VL6dB5Pv5iOXZ/9dP8SEZPwab1FgrAtYMJWt62FnW0IywW4er?=
 =?iso-8859-1?Q?vZ3Kzbk6P845oT5YJBKBcMNankoMpiqa45bH7bzyjNdbE4epaRE4UlcuT9?=
 =?iso-8859-1?Q?7tXWQNtT/GUFRX6BvGDMEPbnAErBlPD6sjOOEzD6JO3W0nzoYNGDqdvEAC?=
 =?iso-8859-1?Q?MsnUVG+Gcy8Ql2772sWhtIjouvnR9OTcN5Z//aGm7IywfLYcGUaivWup58?=
 =?iso-8859-1?Q?v/XV3ga9prdIyuMNloro18T7bRJulok95HGrRx98E+EkOh6LdKnHUkPWqe?=
 =?iso-8859-1?Q?m+USdghS408ohSYN4oGdggiGiMGc/jMvaRFCigldOh1WvdjnIVQXmn3V+7?=
 =?iso-8859-1?Q?Sm5i4Zn6urhneqaW1Fj+JRn1UEts3h2ZJAVdFuBkVNi1EQ54oR+aazfvtg?=
 =?iso-8859-1?Q?ir9Dp2197/oaBgW1SPReQlfYV/I4BmTGMknF0cQ43tpbVw7OE26xAziDB/?=
 =?iso-8859-1?Q?98Qbih371gOXjACm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?O5c8ZTNpARNjXDEqm7wuJXUCbh0Um29iwXIN0B5J9bJ0pTYUlT+mZZcAcR?=
 =?iso-8859-1?Q?vsna0bQRcFV3BgjJgo+3yeEWHVhpS4Yyp6Jb4+ft4MMdY0bN3whj9zt++2?=
 =?iso-8859-1?Q?9xC7X9cvP1V+CpvEC8xTPJA++FXC++t9jtAYhZiIWU6hAOSJsViXNZUSCY?=
 =?iso-8859-1?Q?Q8299vLnXv66hREE3pmstAl81jm2GIqbA1J12c6UW6VOEVCkuydEWQ/4UQ?=
 =?iso-8859-1?Q?x4t/i95vRNKngIKTHvgIzN3C/bhfdUCk1Y5IDFFe4JQigLGF9nFzf1+43F?=
 =?iso-8859-1?Q?3q+wII/bcjEfOy05AGgsV9kC9u2725XwDqWPHfmZ/kD4HPpWI25VdV/bsg?=
 =?iso-8859-1?Q?rd5shpBWCDCtORPJ/5DsTe+fI7ULUjBgrrAG7XhAjvUm8OWPEXVDOkqEGo?=
 =?iso-8859-1?Q?ZUHVfVE6cdPKse/W6mp6k6b9Aj7eWsu692zrTMTTBJVdPFQ3YtAyX7Xqn8?=
 =?iso-8859-1?Q?lvRKlunnV/lVIXmxiS1XYtRLjsV44TWgdK1l3UmkjmLr63xr1IpiPWHXDh?=
 =?iso-8859-1?Q?cV9PLn+sf3zUMjuhzf84bKdx3iJqis69XkIzHjF3YiXXBkcckOnFMbboMv?=
 =?iso-8859-1?Q?M259PxrUF3/JR45TETArMZVIytm2gQOLHEtZpc8K9njr+GMjn16AAS0R4k?=
 =?iso-8859-1?Q?K/ehMiWVu3mEKakB8QbIsfr0l0CFjmf00y0z3kqzfvdUO6ZG6Eu7oGEcfP?=
 =?iso-8859-1?Q?py6IDT5puSebiN8wViLmVzsheKXd60R5No4QUv6usPW1FXUTgx8USpnocT?=
 =?iso-8859-1?Q?sUleGY+cq2eCMRKHTHGXYTYlIc95hvnfJj+H2ZU0TmIFlZAOHAQoWWcbso?=
 =?iso-8859-1?Q?5hUipBWlJI70nuvT680iqoqzN7+A3uM8PL6NVyKDQOCaivYxKuvdJVogtz?=
 =?iso-8859-1?Q?woW35iZ61QvQMhExCEuhUk9e4POkiciyvP5AHtrI/gs0xHpnLZsj8+HDU3?=
 =?iso-8859-1?Q?UfFDPiye2JLNIlZVDlHgLOV67L7BkO++y8P4BDKILepBPzGLkqCFuUuyYe?=
 =?iso-8859-1?Q?j5wYSnQGCYnoEshTk5ZpWs5jDhpAnbRtWMGrewc8YALfh5RC0UHtDKN94w?=
 =?iso-8859-1?Q?EX58MkHz2MzwIbgUk1e07sU1oCWVzzct5wy1/o8jvQlWz0t3lvuuzjygJQ?=
 =?iso-8859-1?Q?p6d3v7EW204srj9rqeZ84acd+LHBf2qAOu1lyVnDSqWgFS3MY2ptPtn7eF?=
 =?iso-8859-1?Q?9GiI2zSpOGPndGNCInFc3Gn8rWLssXcAR0+cMpDq8BkzYTHUPs38Vqp4G5?=
 =?iso-8859-1?Q?2x1FGg07gDX7+JMD6d86kPfYycoJ3jwTJLfgrhuAnVdXxGAHHpasnmvPlN?=
 =?iso-8859-1?Q?pR+wtiUjjPHn3Rf/1BaxoZ2xNt+fvLdkjRhqLu9h6hppQIEzvzcdzyhtmt?=
 =?iso-8859-1?Q?bN/OCKSxDLbcmXHiXzeyiMo/VHI51ZsfEQtlZSxfmKmyuuPKd9hBB+Lgbz?=
 =?iso-8859-1?Q?+jPPeWSYBnCe2hfL2PWhcdM576OCuxplCIAZsRmNSH1yftPWh+jfbsjVVk?=
 =?iso-8859-1?Q?vYSzOf/rdqW0EEOj80E3vY2qMWtdVm8QrOg6Z0PmOF/ffZw7jNVZ+G/j4O?=
 =?iso-8859-1?Q?MmzUAib8BASBpp091NpShBBqErntvWckrUpOXAw7Q6GaX0vmsUg40RSclt?=
 =?iso-8859-1?Q?lgVFb/Dfz+cdxO8Y95b/jRiztrIhrf+ikh7b6+f9baut5D5CK9wwyaaw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c46cc62f-bc9a-4d41-0e4d-08dda2ade722
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 14:49:55.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcsJQzEbp7UnUVTGTnJnnGXkWvT+rzzPPJxdmjrt9kkAVbVKuLGkG2j2mHlgd33/GBG1B+6ik3rEL/yIOVkXHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9060
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 22.9% regression of aim7.jobs-per-min on:


commit: 7ac67301e82f02b77a5c8e7377a1f414ef108b84 ("ext4: enable large folio for regular file")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master 3a83b350b5be4b4f6bd895eecf9a92080200ee5d]

testcase: aim7
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
parameters:

	disk: 4BRD_12G
	md: RAID0
	fs: ext4
	test: creat-clo
	load: 1000
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+----------------------------------------------------------------------------------------------------+
| testcase: change | filebench: filebench.sum_operations/s 13.9% improvement                                            |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory |
| test parameters  | cpufreq_governor=performance                                                                       |
|                  | disk=1SSD                                                                                          |
|                  | fs=ext4                                                                                            |
|                  | test=randomread.f                                                                                  |
+------------------+----------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506032249.cd0b4bc-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250603/202506032249.cd0b4bc-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/load/md/rootfs/tbox_group/test/testcase:
  gcc-12/performance/4BRD_12G/ext4/x86_64-rhel-9.4/1000/RAID0/debian-12-x86_64-20240206.cgz/lkp-csl-2sp3/creat-clo/aim7

commit: 
  01e807e18f ("ext4: make online defragmentation support large folios")
  7ac67301e8 ("ext4: enable large folio for regular file")

01e807e18fd87937 7ac67301e82f02b77a5c8e7377a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.039e+10 ± 33%    +141.0%  2.504e+10        cpuidle..time
  20464297 ± 49%    +227.8%   67090730 ±  2%  cpuidle..usage
     21.42 ± 22%     +88.3%      40.33        iostat.cpu.idle
     78.35 ±  6%     -24.1%      59.45        iostat.cpu.system
    552.32 ±  6%     +26.6%     699.14        uptime.boot
     14635 ± 23%    +101.0%      29415 ±  2%  uptime.idle
     68206 ± 39%    +145.2%     167235        meminfo.Buffers
     71959 ± 37%    +137.4%     170796        meminfo.Inactive
     71959 ± 37%    +137.4%     170796        meminfo.Inactive(file)
    894.92 ± 11%     +40.9%       1260        meminfo.Mlocked
   1125010 ± 22%    +155.5%    2874061        numa-numastat.node0.local_node
   1183030 ± 22%    +146.6%    2917772        numa-numastat.node0.numa_hit
   1270609 ± 29%    +133.6%    2968203 ±  2%  numa-numastat.node1.local_node
   1312306 ± 27%    +130.5%    3024283 ±  2%  numa-numastat.node1.numa_hit
   1182349 ± 22%    +146.8%    2917852        numa-vmstat.node0.numa_hit
   1124328 ± 22%    +155.6%    2874142        numa-vmstat.node0.numa_local
   1311405 ± 27%    +130.6%    3024180 ±  2%  numa-vmstat.node1.numa_hit
   1269707 ± 29%    +133.8%    2968101 ±  2%  numa-vmstat.node1.numa_local
     21.46 ± 22%     +87.9%      40.32        vmstat.cpu.id
      9467 ± 39%    +214.4%      29766        vmstat.io.bo
     94.65           -27.6%      68.51 ±  6%  vmstat.procs.r
     77160 ± 39%    +175.9%     212860        vmstat.system.cs
    110041 ±  3%     +18.3%     130180        vmstat.system.in
     21.11 ± 23%     +19.0       40.15        mpstat.cpu.all.idle%
      0.00 ±116%      +0.0        0.05 ± 22%  mpstat.cpu.all.iowait%
      0.51 ±  5%      +0.1        0.63        mpstat.cpu.all.irq%
      0.04 ± 27%      +0.1        0.09        mpstat.cpu.all.soft%
     78.11 ±  6%     -19.2       58.90        mpstat.cpu.all.sys%
      0.22 ±  7%      -0.1        0.17 ±  2%  mpstat.cpu.all.usr%
     28.67 ± 15%   +2158.7%     647.50        mpstat.max_utilization.seconds
     12003 ±  6%     -22.9%       9255        aim7.jobs-per-min
    502.51 ±  7%     +29.0%     648.48        aim7.time.elapsed_time
    502.51 ±  7%     +29.0%     648.48        aim7.time.elapsed_time.max
   3006810 ± 34%    +197.8%    8952958        aim7.time.involuntary_context_switches
      2361            +1.5%       2396        aim7.time.maximum_resident_set_size
    120010 ±  2%      -7.7%     110766 ±  2%  aim7.time.minor_page_faults
      7505 ±  6%     -25.3%       5607        aim7.time.percent_of_cpu_this_job_got
     37471            -3.1%      36310        aim7.time.system_time
  23471247 ± 53%    +256.2%   83610596        aim7.time.voluntary_context_switches
   1052963            +1.8%    1071691        proc-vmstat.nr_file_pages
     17995 ± 37%    +137.3%      42699        proc-vmstat.nr_inactive_file
     18010            -2.0%      17656        proc-vmstat.nr_mapped
    223.82 ± 11%     +40.8%     315.11        proc-vmstat.nr_mlock
    134427            -4.5%     128396        proc-vmstat.nr_shmem
     33925            +1.9%      34558        proc-vmstat.nr_slab_reclaimable
     17995 ± 37%    +137.3%      42699        proc-vmstat.nr_zone_inactive_file
   2495758 ± 24%    +138.1%    5942873        proc-vmstat.numa_hit
   2396041 ± 25%    +143.9%    5843083        proc-vmstat.numa_local
   2727788 ± 22%    +125.1%    6139263        proc-vmstat.pgalloc_normal
   1536291 ±  6%     +22.1%    1875129        proc-vmstat.pgfault
   2558575 ± 24%    +132.6%    5950566        proc-vmstat.pgfree
   4923796 ± 50%    +293.3%   19362948        proc-vmstat.pgpgout
     84986 ±  4%     +12.4%      95485        proc-vmstat.pgreuse
      0.61 ±  3%     +23.7%       0.75 ±  2%  perf-stat.i.MPKI
 1.175e+10 ±  7%     -33.7%  7.789e+09 ±  2%  perf-stat.i.branch-instructions
      0.25 ±  8%      +0.1        0.32 ±  4%  perf-stat.i.branch-miss-rate%
  15144423 ±  4%     +25.7%   19035266        perf-stat.i.branch-misses
     38.23 ±  5%      -8.6       29.64        perf-stat.i.cache-miss-rate%
  34494766 ±  6%     -17.6%   28420268        perf-stat.i.cache-misses
  89945462            +6.7%   95927456        perf-stat.i.cache-references
     77676 ± 39%    +174.9%     213543        perf-stat.i.context-switches
      4.00 ±  2%     +12.1%       4.48 ±  2%  perf-stat.i.cpi
 2.328e+11 ±  6%     -26.3%  1.715e+11        perf-stat.i.cpu-cycles
      6559 ± 27%    +135.2%      15428 ±  3%  perf-stat.i.cpu-migrations
      6657           -10.0%       5989        perf-stat.i.cycles-between-cache-misses
 5.832e+10 ±  7%     -34.8%    3.8e+10 ±  2%  perf-stat.i.instructions
      0.26           -11.5%       0.23        perf-stat.i.ipc
      0.61 ± 58%    +263.1%       2.22        perf-stat.i.metric.K/sec
      2826            -4.4%       2701        perf-stat.i.minor-faults
      2826            -4.4%       2701        perf-stat.i.page-faults
      0.59 ±  2%     +26.3%       0.75 ±  2%  perf-stat.overall.MPKI
      0.13 ± 13%      +0.1        0.24 ±  3%  perf-stat.overall.branch-miss-rate%
     38.34 ±  5%      -8.7       29.62        perf-stat.overall.cache-miss-rate%
      4.00 ±  2%     +13.0%       4.52 ±  2%  perf-stat.overall.cpi
      6747           -10.6%       6034        perf-stat.overall.cycles-between-cache-misses
      0.25 ±  2%     -11.5%       0.22 ±  2%  perf-stat.overall.ipc
 1.173e+10 ±  7%     -33.7%  7.776e+09 ±  2%  perf-stat.ps.branch-instructions
  15120179 ±  4%     +25.8%   19015313        perf-stat.ps.branch-misses
  34435926 ±  6%     -17.6%   28376133        perf-stat.ps.cache-misses
  89790928            +6.7%   95792014        perf-stat.ps.cache-references
     77356 ± 39%    +175.6%     213185        perf-stat.ps.context-switches
 2.324e+11 ±  6%     -26.3%  1.712e+11        perf-stat.ps.cpu-cycles
      6536 ± 27%    +135.7%      15403 ±  3%  perf-stat.ps.cpu-migrations
 5.823e+10 ±  7%     -34.8%  3.794e+10 ±  2%  perf-stat.ps.instructions
      2820            -4.4%       2696        perf-stat.ps.minor-faults
      2820            -4.4%       2696        perf-stat.ps.page-faults
 2.915e+13 ±  2%     -15.5%  2.464e+13 ±  2%  perf-stat.total.instructions
  13893356 ± 10%     -28.1%    9985283 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
  14866508 ±  9%     -25.0%   11157233 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.max
  13368653 ± 10%     -29.6%    9413191 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.min
    217979 ±  4%    +132.7%     507327 ± 18%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.40 ± 18%     +40.2%       3.36 ±  8%  sched_debug.cfs_rq:/.load_avg.min
  13893356 ± 10%     -28.1%    9985283 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
  14866508 ±  9%     -25.0%   11157233 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  13368653 ± 10%     -29.6%    9413191 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
    217979 ±  4%    +132.7%     507327 ± 18%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.68 ±  9%     -27.0%       0.50 ±  2%  sched_debug.cfs_rq:/.nr_queued.avg
      0.38 ± 11%     +26.8%       0.48        sched_debug.cfs_rq:/.nr_queued.stddev
    136.33 ± 39%     -33.6%      90.51 ±  4%  sched_debug.cfs_rq:/.removed.load_avg.max
     30.24 ± 18%     -36.3%      19.26 ± 20%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      1397 ± 26%     +53.5%       2145 ±  4%  sched_debug.cfs_rq:/.runnable_avg.avg
      2938 ± 18%     +44.0%       4230 ± 16%  sched_debug.cfs_rq:/.runnable_avg.max
    651.69 ±  9%     -26.3%     480.36        sched_debug.cfs_rq:/.util_avg.avg
      1626 ± 16%     -33.3%       1084 ± 16%  sched_debug.cfs_rq:/.util_avg.max
    274.82 ± 14%     -38.0%     170.26 ±  8%  sched_debug.cfs_rq:/.util_avg.stddev
    825.51 ± 11%     -46.6%     440.94 ±  4%  sched_debug.cfs_rq:/.util_est.avg
      3315 ± 19%     -48.0%       1725 ±  4%  sched_debug.cfs_rq:/.util_est.max
    813.04 ± 22%     -37.6%     507.58 ±  4%  sched_debug.cfs_rq:/.util_est.stddev
    695475 ± 14%     -27.5%     504320 ±  3%  sched_debug.cpu.avg_idle.avg
    947694 ±  6%     -18.0%     776966 ±  4%  sched_debug.cpu.avg_idle.max
    123841 ± 12%     -24.0%      94117 ±  3%  sched_debug.cpu.avg_idle.stddev
    288821 ±  5%     +24.5%     359697 ±  4%  sched_debug.cpu.clock.avg
    288831 ±  5%     +24.5%     359707 ±  4%  sched_debug.cpu.clock.max
    288810 ±  5%     +24.5%     359686 ±  4%  sched_debug.cpu.clock.min
    287274 ±  5%     +24.4%     357262 ±  4%  sched_debug.cpu.clock_task.avg
    287497 ±  5%     +24.4%     357608 ±  4%  sched_debug.cpu.clock_task.max
    279648 ±  5%     +24.9%     349351 ±  4%  sched_debug.cpu.clock_task.min
      3160 ±  9%     -25.4%       2357        sched_debug.cpu.curr->pid.avg
      1873 ± 11%     +29.4%       2424 ±  3%  sched_debug.cpu.curr->pid.stddev
    225517 ± 52%    +202.2%     681409 ±  4%  sched_debug.cpu.nr_switches.avg
    238933 ± 50%    +199.7%     716085 ±  4%  sched_debug.cpu.nr_switches.max
    215091 ± 53%    +200.4%     646099 ±  5%  sched_debug.cpu.nr_switches.min
      6339 ± 35%    +322.0%      26749 ± 15%  sched_debug.cpu.nr_switches.stddev
    470.00 ± 17%     +89.1%     888.96 ± 10%  sched_debug.cpu.nr_uninterruptible.max
   -436.21          +166.4%      -1162        sched_debug.cpu.nr_uninterruptible.min
    175.08 ± 20%    +126.7%     396.98 ±  6%  sched_debug.cpu.nr_uninterruptible.stddev
    288810 ±  5%     +24.5%     359686 ±  4%  sched_debug.cpu_clk
    288250 ±  5%     +24.6%     359126 ±  4%  sched_debug.ktime
    289382 ±  5%     +24.5%     360266 ±  4%  sched_debug.sched_clk
      0.43 ± 27%     +62.1%       0.70 ± 14%  perf-sched.sch_delay.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_orphan_add.ext4_truncate.ext4_setattr
      0.14 ±116%     -78.4%       0.03 ±136%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.04 ± 40%    +541.3%       0.28 ±160%  perf-sched.sch_delay.avg.ms.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
      0.43 ± 51%    +126.8%       0.97 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.76 ± 76%     +93.3%       1.47 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_truncate.ext4_setattr
      0.89 ±146%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.11 ± 60%     -78.1%       0.02 ±117%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.01 ± 59%     -75.4%       0.00 ± 31%  perf-sched.sch_delay.avg.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.14 ± 86%     -91.3%       0.01 ± 70%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.82 ±  8%     -26.4%       0.60 ±  9%  perf-sched.sch_delay.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.07 ± 46%    +649.3%       0.50 ±136%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.37 ± 37%     -74.9%       0.09 ± 55%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.05 ± 62%    +196.8%       0.15 ± 71%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.04 ±104%    +177.2%       0.10 ± 11%  perf-sched.sch_delay.max.ms.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.jbd2_journal_get_descriptor_buffer
      0.31 ±127%     -90.0%       0.03 ±136%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.wait_for_completion_state.kernel_clone.__x64_sys_vfork
      0.09 ± 44%  +23615.3%      20.95 ±207%  perf-sched.sch_delay.max.ms.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
      0.01 ± 42%     -81.0%       0.00 ±142%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
      2.11 ± 76%    +132.6%       4.91 ± 19%  perf-sched.sch_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_truncate.ext4_setattr
      2.29 ± 69%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
      0.68 ± 79%     -79.6%       0.14 ±149%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      9.93 ±114%     -88.5%       1.14 ± 97%  perf-sched.sch_delay.max.ms.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      0.95 ± 93%   +1396.1%      14.16 ±192%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1232 ±131%     -97.0%      36.96 ±124%  perf-sched.total_sch_delay.max.ms
     63.11 ± 65%     -66.8%      20.95 ±  2%  perf-sched.total_wait_and_delay.average.ms
    100984 ± 48%     +85.7%     187485        perf-sched.total_wait_and_delay.count.ms
     61.91 ± 66%     -68.1%      19.75 ±  2%  perf-sched.total_wait_time.average.ms
     88.55 ±133%     -72.8%      24.08 ±  4%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
     59.33 ± 81%     -62.6%      22.21 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
     71.70 ± 76%     -76.6%      16.81 ±  3%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
     74.50 ± 98%   +1048.1%     855.33 ±  9%  perf-sched.wait_and_delay.count.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.ext4_truncate.ext4_setattr
      0.67 ±141%    +925.0%       6.83 ± 24%  perf-sched.wait_and_delay.count.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.jbd2_journal_get_descriptor_buffer
     31.50 ±141%    +210.1%      97.67        perf-sched.wait_and_delay.count.__cond_resched.bdev_getblk.jbd2_journal_get_descriptor_buffer.jbd2_journal_commit_transaction.kjournald2
      1.00 ±115%    +266.7%       3.67 ± 40%  perf-sched.wait_and_delay.count.__cond_resched.down_write.ext4_truncate.ext4_setattr.notify_change
    107.67 ±148%   +1574.6%       1803 ± 27%  perf-sched.wait_and_delay.count.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
     39510 ± 53%     +78.9%      70701        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
      1392 ± 18%     -38.3%     859.50 ±  2%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    947.20 ±110%     -94.3%      53.91 ± 50%  perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      2500 ± 63%     -96.6%      86.00 ± 88%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
      2480 ± 64%     -97.2%      70.57 ± 74%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
     71.88 ± 65%     -72.8%      19.58 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_orphan_add.ext4_truncate.ext4_setattr
    113.18 ±116%     -77.1%      25.93 ±  2%  perf-sched.wait_time.avg.ms.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.ext4_truncate.ext4_setattr
     88.09 ±134%     -72.9%      23.91 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
     81.81 ± 78%     -69.7%      24.80 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.__ext4_get_inode_loc
     48.73 ± 76%     -88.2%       5.73 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
     65.97 ± 87%     -58.7%      27.24 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
    104.27 ± 92%     -76.1%      24.89 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
     58.53 ± 48%     -55.1%      26.29 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
     64.58 ± 74%     -59.6%      26.11 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
     56.99 ± 47%     -58.9%      23.45 ± 19%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.jbd2__journal_start.ext4_truncate.ext4_setattr
    112.58 ±105%     -76.3%      26.65 ±  6%  perf-sched.wait_time.avg.ms.__cond_resched.mnt_want_write.do_open.path_openat.do_filp_open
    242.61 ±111%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
     59.19 ± 91%     -57.5%      25.15 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.67 ± 52%    +470.8%      15.24 ±  4%  perf-sched.wait_time.avg.ms.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
     57.13 ± 85%     -64.9%      20.04 ±  2%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
     70.26 ± 78%     -77.8%      15.58 ±  3%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
    113.86 ±110%     -92.6%       8.40 ± 13%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      1.22 ± 25%     -37.3%       0.76 ±  5%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      6.62 ± 28%     +48.7%       9.85 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1507 ± 87%     -97.0%      45.93 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
      1646 ± 93%     -97.5%      40.37 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_orphan_add.ext4_truncate.ext4_setattr
      1142 ±116%     -96.0%      46.24 ± 28%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_journal_get_write_access.ext4_orphan_add.ext4_truncate.ext4_setattr
    913.53 ±116%     -95.1%      44.79 ± 27%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
    107.27 ± 85%     -72.9%      29.08 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_ext_truncate.ext4_truncate.ext4_setattr
    582.25 ±159%     -94.2%      34.03 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.__ext4_get_inode_loc
    111.60 ± 91%     -70.0%      33.52 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
    718.87 ±195%     -96.2%      27.67 ± 46%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_noprof.ext4_ext_remove_space.ext4_ext_truncate.ext4_truncate
    155.77 ± 75%     -78.3%      33.76 ±  7%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.ext4_orphan_add
    787.80 ±193%     -95.9%      31.91 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.__mutex_lock.constprop.0.ext4_orphan_del
     71.24 ±112%     -92.0%       5.73 ±223%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
      1596 ± 97%     -97.5%      40.35 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.bdev_getblk.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write
    567.42 ±149%     -93.9%      34.41 ±  2%  perf-sched.wait_time.max.ms.__cond_resched.down_read.ext4_xattr_get.__vfs_getxattr.cap_inode_need_killpriv
    111.57 ± 66%     -69.7%      33.76 ±  3%  perf-sched.wait_time.max.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
    179.12 ± 55%     -81.2%      33.67 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
    494.41 ±155%     -93.1%      34.32 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      1024 ±118%     -95.5%      45.74 ± 29%  perf-sched.wait_time.max.ms.__cond_resched.ext4_orphan_add.ext4_truncate.ext4_setattr.notify_change
    165.88 ± 60%     -80.1%      33.03 ±  4%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
    113.61 ± 87%     -73.2%      30.42 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
    127.53 ± 72%     -74.2%      32.88 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
    102.22 ± 54%     -70.4%      30.29 ± 12%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.jbd2__journal_start.ext4_truncate.ext4_setattr
    895.85 ±122%     -96.0%      35.84 ± 11%  perf-sched.wait_time.max.ms.__cond_resched.mnt_want_write.do_open.path_openat.do_filp_open
      1523 ±100%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
     72.88 ± 95%     -56.3%      31.88 ±  5%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
    558.24 ±151%     -92.9%      39.83 ± 32%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      2439 ± 67%     -97.5%      60.23 ± 55%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_add
      2431 ± 68%     -97.7%      54.78 ± 46%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.ext4_orphan_del
      1533 ± 91%     -97.5%      37.66 ±  4%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1127 ±133%     -96.9%      35.52 ±  8%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
    716.22 ± 56%     -93.7%      45.07 ± 31%  perf-sched.wait_time.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     43.31 ±  3%     -10.6       32.68 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.ext4_orphan_del.ext4_truncate.ext4_setattr
     43.97 ±  3%     -10.5       33.46 ±  4%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.ext4_orphan_add.ext4_truncate.ext4_setattr
     44.73 ±  3%     -10.4       34.28 ±  4%  perf-profile.calltrace.cycles-pp.ext4_orphan_del.ext4_truncate.ext4_setattr.notify_change.do_truncate
     43.90 ±  3%     -10.3       33.57 ±  4%  perf-profile.calltrace.cycles-pp.__mutex_lock.ext4_orphan_del.ext4_truncate.ext4_setattr.notify_change
     92.63 ±  2%      -8.5       84.12        perf-profile.calltrace.cycles-pp.ext4_truncate.ext4_setattr.notify_change.do_truncate.do_open
     45.41            -6.9       38.48 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_lock.ext4_orphan_add.ext4_truncate.ext4_setattr.notify_change
     46.25            -6.7       39.54 ±  2%  perf-profile.calltrace.cycles-pp.ext4_orphan_add.ext4_truncate.ext4_setattr.notify_change.do_truncate
     96.15            -1.4       94.76        perf-profile.calltrace.cycles-pp.ext4_setattr.notify_change.do_truncate.do_open.path_openat
     96.18            -1.4       94.80        perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_open.path_openat.do_filp_open
     96.29            -1.4       94.92        perf-profile.calltrace.cycles-pp.do_truncate.do_open.path_openat.do_filp_open.do_sys_openat2
     96.44            -1.4       95.08        perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat
     96.58            -1.3       95.29        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64
     96.59            -1.3       95.30        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     96.67            -1.3       95.40        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     96.68            -1.3       95.40        perf-profile.calltrace.cycles-pp.__x64_sys_creat.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     96.76            -1.2       95.55        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.creat64
     96.76            -1.2       95.55        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.creat64
     96.85            -1.2       95.67        perf-profile.calltrace.cycles-pp.creat64
      2.45 ±  6%      +0.4        2.81 ±  3%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      2.50 ±  5%      +0.5        3.03 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      2.50 ±  5%      +0.5        3.04 ±  3%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      2.51 ±  5%      +0.6        3.12 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.56 ±  4%      +0.8        3.36 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      2.56 ±  4%      +0.8        3.36 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      2.56 ±  4%      +0.8        3.36 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      2.58 ±  4%      +0.8        3.39 ±  4%  perf-profile.calltrace.cycles-pp.common_startup_64
      0.76 ± 80%      +3.4        4.18 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__mutex_lock.ext4_orphan_add.ext4_truncate
      0.76 ± 80%      +3.5        4.22 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__mutex_lock.ext4_orphan_add.ext4_truncate.ext4_setattr
      2.89 ± 62%      +6.3        9.16 ±  6%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.start_this_handle.jbd2__journal_start.ext4_dirty_inode
      2.90 ± 62%      +6.3        9.21 ±  6%  perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty
      3.13 ± 60%      +6.9       10.03 ±  6%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change
      3.12 ± 61%      +6.9       10.02 ±  6%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      3.38 ± 57%      +7.0       10.42 ±  6%  perf-profile.calltrace.cycles-pp.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr.notify_change.do_truncate
      3.42 ± 56%      +7.1       10.53 ±  6%  perf-profile.calltrace.cycles-pp.__mark_inode_dirty.ext4_setattr.notify_change.do_truncate.do_open
      0.61 ± 58%      +8.1        8.73 ± 19%  perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.start_this_handle.jbd2__journal_start.ext4_truncate.ext4_setattr
      0.32 ±141%      +8.2        8.52 ± 19%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.start_this_handle.jbd2__journal_start.ext4_truncate
      0.78 ± 56%      +8.7        9.47 ± 18%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_truncate.ext4_setattr.notify_change
      0.79 ± 56%      +8.7        9.48 ± 18%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_truncate.ext4_setattr.notify_change.do_truncate
     87.39 ±  3%     -21.1       66.25 ±  4%  perf-profile.children.cycles-pp.osq_lock
     89.41 ±  2%     -17.3       72.15 ±  3%  perf-profile.children.cycles-pp.__mutex_lock
     44.78 ±  3%     -10.5       34.33 ±  4%  perf-profile.children.cycles-pp.ext4_orphan_del
     92.63 ±  2%      -8.5       84.12        perf-profile.children.cycles-pp.ext4_truncate
     46.30            -6.7       39.58 ±  2%  perf-profile.children.cycles-pp.ext4_orphan_add
     96.15            -1.4       94.76        perf-profile.children.cycles-pp.ext4_setattr
     96.18            -1.4       94.80        perf-profile.children.cycles-pp.notify_change
     96.29            -1.4       94.92        perf-profile.children.cycles-pp.do_truncate
     96.44            -1.4       95.08        perf-profile.children.cycles-pp.do_open
     96.59            -1.3       95.29        perf-profile.children.cycles-pp.path_openat
     96.60            -1.3       95.31        perf-profile.children.cycles-pp.do_filp_open
     96.68            -1.3       95.40        perf-profile.children.cycles-pp.__x64_sys_creat
     96.67            -1.3       95.40        perf-profile.children.cycles-pp.do_sys_openat2
     96.86            -1.2       95.68        perf-profile.children.cycles-pp.creat64
     97.09            -1.1       95.94        perf-profile.children.cycles-pp.do_syscall_64
     97.10            -1.1       95.95        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.62 ±  2%      -0.1        0.51 ±  3%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.10 ±  8%      -0.0        0.07        perf-profile.children.cycles-pp.osq_unlock
      0.09            +0.0        0.10        perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.09            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.vfs_open
      0.06 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.evict
      0.06 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.ext4_evict_inode
      0.10 ±  3%      +0.0        0.12 ±  6%  perf-profile.children.cycles-pp.__ext4_journal_start_sb
      0.11 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__x64_sys_close
      0.10 ±  4%      +0.0        0.12 ±  5%  perf-profile.children.cycles-pp.mutex_lock
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
      0.06 ±  9%      +0.0        0.08        perf-profile.children.cycles-pp.__ext4_unlink
      0.06 ±  9%      +0.0        0.08        perf-profile.children.cycles-pp.ext4_unlink
      0.06 ±  9%      +0.0        0.08        perf-profile.children.cycles-pp.vfs_unlink
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.22 ±  2%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.__close
      0.12 ±  6%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.58            +0.0        0.61        perf-profile.children.cycles-pp.ext4_do_update_inode
      0.17 ±  4%      +0.0        0.20 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.13 ±  6%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.13 ±  6%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.do_unlinkat
      0.13 ±  6%      +0.0        0.16 ±  4%  perf-profile.children.cycles-pp.unlink
      0.15 ±  4%      +0.0        0.19 ±  5%  perf-profile.children.cycles-pp.find_get_block_common
      0.16 ±  4%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.bdev_getblk
      0.22 ±  4%      +0.0        0.27 ±  4%  perf-profile.children.cycles-pp.sched_tick
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__cond_resched
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.jbd2_write_access_granted
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.task_mm_cid_work
      0.01 ±223%      +0.1        0.07 ± 11%  perf-profile.children.cycles-pp.task_work_run
      0.01 ±223%      +0.1        0.07 ±  8%  perf-profile.children.cycles-pp.stop_this_handle
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.select_idle_cpu
      0.08 ± 18%      +0.1        0.15 ±  9%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.schedule_idle
      0.34 ±  8%      +0.1        0.41 ±  3%  perf-profile.children.cycles-pp.__mutex_unlock_slowpath
      0.01 ±223%      +0.1        0.08 ±  6%  perf-profile.children.cycles-pp.open_last_lookups
      0.08 ± 11%      +0.1        0.15 ±  6%  perf-profile.children.cycles-pp.jbd2_journal_stop
      0.10 ± 10%      +0.1        0.16 ±  4%  perf-profile.children.cycles-pp.__ext4_journal_stop
      0.32 ±  3%      +0.1        0.38 ±  3%  perf-profile.children.cycles-pp.update_process_times
      0.00            +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.select_idle_sibling
      0.34 ±  4%      +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.01 ±223%      +0.1        0.09 ±  6%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.dequeue_entity
      0.06 ± 14%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.00            +0.1        0.09 ±  9%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.select_task_rq
      0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.62 ±  2%      +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.00            +0.1        0.10 ± 10%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.01 ±223%      +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.00            +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.00            +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.38 ±  4%      +0.1        0.49 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.enqueue_entity
      0.08 ± 22%      +0.1        0.18 ±  8%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.1        0.11 ± 10%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.73 ±  2%      +0.1        0.85 ±  3%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.12 ± 14%      +0.1        0.25 ±  7%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.44 ±  4%      +0.1        0.57        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.44 ±  4%      +0.1        0.57        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.11 ± 12%      +0.1        0.24 ±  8%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      0.01 ±223%      +0.1        0.14 ± 10%  perf-profile.children.cycles-pp.try_to_block_task
      0.01 ±223%      +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      0.01 ±223%      +0.1        0.15 ± 10%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.09 ± 22%      +0.1        0.24 ±  7%  perf-profile.children.cycles-pp._raw_read_lock
      0.01 ±223%      +0.1        0.16 ±  9%  perf-profile.children.cycles-pp.dequeue_entities
      0.01 ±223%      +0.1        0.16 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.12 ± 19%      +0.2        0.28 ±  9%  perf-profile.children.cycles-pp.try_to_wake_up
      0.03 ±101%      +0.2        0.19 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.02 ±141%      +0.2        0.18 ± 12%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.03 ±103%      +0.2        0.20 ±  9%  perf-profile.children.cycles-pp.enqueue_task
      0.02 ±141%      +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.__wake_up
      0.03 ±101%      +0.2        0.20 ±  9%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.02 ±141%      +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.__wake_up_common
      0.03 ±103%      +0.2        0.20 ± 11%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.04 ±101%      +0.2        0.22 ±  9%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.04 ±102%      +0.2        0.24 ±  9%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.04 ±101%      +0.2        0.24 ±  8%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.04 ±102%      +0.2        0.24 ±  9%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.48 ±  6%      +0.2        0.70 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.50 ±  6%      +0.2        0.74 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.04 ±102%      +0.2        0.28 ± 10%  perf-profile.children.cycles-pp.jbd2_journal_commit_transaction
      0.04 ±102%      +0.2        0.29 ± 11%  perf-profile.children.cycles-pp.kjournald2
      0.10 ± 30%      +0.2        0.36 ± 14%  perf-profile.children.cycles-pp.kthread
      0.10 ± 30%      +0.2        0.36 ± 14%  perf-profile.children.cycles-pp.ret_from_fork
      0.10 ± 30%      +0.2        0.36 ± 14%  perf-profile.children.cycles-pp.ret_from_fork_asm
      0.07 ± 58%      +0.3        0.35 ±  8%  perf-profile.children.cycles-pp.sched_balance_rq
      0.06 ± 77%      +0.3        0.36 ±  8%  perf-profile.children.cycles-pp.sched_balance_newidle
      0.10 ± 59%      +0.3        0.42 ±  7%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.09 ± 61%      +0.3        0.43 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.09 ± 61%      +0.4        0.44 ±  8%  perf-profile.children.cycles-pp.__pick_next_task
      2.47 ±  6%      +0.4        2.83 ±  3%  perf-profile.children.cycles-pp.intel_idle
      0.14 ± 48%      +0.6        0.70 ±  8%  perf-profile.children.cycles-pp.schedule
      2.52 ±  5%      +0.6        3.07 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter
      2.52 ±  5%      +0.6        3.07 ±  3%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.16 ± 49%      +0.6        0.76 ±  8%  perf-profile.children.cycles-pp.__schedule
      0.12 ± 56%      +0.6        0.72 ± 11%  perf-profile.children.cycles-pp.add_transaction_credits
      2.53 ±  4%      +0.6        3.15 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      2.56 ±  4%      +0.8        3.36 ±  4%  perf-profile.children.cycles-pp.start_secondary
      2.58 ±  4%      +0.8        3.39 ±  4%  perf-profile.children.cycles-pp.common_startup_64
      2.58 ±  4%      +0.8        3.39 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      2.58 ±  4%      +0.8        3.39 ±  4%  perf-profile.children.cycles-pp.do_idle
      1.15 ± 52%      +3.9        5.01 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      3.38 ± 57%      +7.0       10.42 ±  6%  perf-profile.children.cycles-pp.ext4_dirty_inode
      3.42 ± 56%      +7.1       10.53 ±  6%  perf-profile.children.cycles-pp.__mark_inode_dirty
      3.57 ± 58%     +14.5       18.04 ± 11%  perf-profile.children.cycles-pp.queued_read_lock_slowpath
      3.98 ± 56%     +15.6       19.60 ± 11%  perf-profile.children.cycles-pp.start_this_handle
      4.01 ± 56%     +15.6       19.62 ± 11%  perf-profile.children.cycles-pp.jbd2__journal_start
      4.54 ± 59%     +18.3       22.85 ± 10%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     86.96 ±  3%     -21.1       65.83 ±  4%  perf-profile.self.cycles-pp.osq_lock
      0.62 ±  2%      -0.1        0.50 ±  3%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.17 ±  2%      -0.0        0.13 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.28            -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.__mutex_lock
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.osq_unlock
      0.22            -0.0        0.20 ±  3%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.05 ±  8%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__ext4_handle_dirty_metadata
      0.13 ±  3%      +0.0        0.15 ±  5%  perf-profile.self.cycles-pp.ext4_orphan_add
      0.08 ±  4%      +0.0        0.10 ±  6%  perf-profile.self.cycles-pp.update_cfs_group
      0.09            +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.find_get_block_common
      0.12 ±  6%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.06 ± 15%      +0.0        0.10 ±  7%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.jbd2_write_access_granted
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.task_mm_cid_work
      0.04 ± 45%      +0.1        0.10 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock
      0.01 ±223%      +0.1        0.07 ±  8%  perf-profile.self.cycles-pp.stop_this_handle
      0.01 ±223%      +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.jbd2_journal_stop
      0.02 ±141%      +0.1        0.09 ±  9%  perf-profile.self.cycles-pp.update_load_avg
      0.03 ±100%      +0.1        0.16 ±  9%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.09 ± 22%      +0.1        0.23 ±  8%  perf-profile.self.cycles-pp._raw_read_lock
      0.06 ± 75%      +0.2        0.25 ±  8%  perf-profile.self.cycles-pp.add_transaction_credits
      0.04 ±102%      +0.2        0.24 ± 11%  perf-profile.self.cycles-pp.queued_read_lock_slowpath
      2.47 ±  6%      +0.4        2.83 ±  3%  perf-profile.self.cycles-pp.intel_idle
      0.18 ± 30%      +0.4        0.56 ±  9%  perf-profile.self.cycles-pp.start_this_handle
      4.50 ± 59%     +18.2       22.66 ± 10%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath


***************************************************************************************************
lkp-csl-2sp10: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz (Cascade Lake) with 176G memory
=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1SSD/ext4/x86_64-rhel-9.4/debian-12-x86_64-20240206.cgz/lkp-csl-2sp10/randomread.f/filebench

commit: 
  01e807e18f ("ext4: make online defragmentation support large folios")
  7ac67301e8 ("ext4: enable large folio for regular file")

01e807e18fd87937 7ac67301e82f02b77a5c8e7377a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      1339 ±  4%     -10.2%       1202 ±  4%  perf-c2c.DRAM.remote
      0.08 ± 13%     -20.2%       0.06 ± 12%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     31210            +1.1%      31555        vmstat.io.bo
      3177 ±218%  +81142.5%    2581268 ± 99%  numa-meminfo.node2.Inactive
      3177 ±218%  +81142.5%    2581268 ± 99%  numa-meminfo.node2.Inactive(file)
    794.16 ±218%  +81233.1%     645917 ± 99%  numa-vmstat.node2.nr_inactive_file
    794.16 ±218%  +81233.0%     645916 ± 99%  numa-vmstat.node2.nr_zone_inactive_file
     66252            -4.0%      63604        proc-vmstat.nr_slab_reclaimable
   2328335           -56.1%    1022608        proc-vmstat.numa_hit
   2030258           -64.3%     724500        proc-vmstat.numa_local
      2695 ±  2%     +13.9%       3071        filebench.sum_bytes_mb/s
  20707377 ±  2%     +13.9%   23594148        filebench.sum_operations
    345075 ±  2%     +13.9%     393184        filebench.sum_operations/s
    345075 ±  2%     +13.9%     393184        filebench.sum_reads/s
      0.00           -33.3%       0.00        filebench.sum_time_ms/op
     11.85            +6.0%      12.56        perf-stat.i.MPKI
  14126211            +1.5%   14333361        perf-stat.i.branch-misses
  19038125           +11.3%   21192935        perf-stat.i.cache-misses
  47685799            +7.9%   51436964        perf-stat.i.cache-references
      2.69            -1.4%       2.65        perf-stat.i.cpi
     12.56           +11.8%      14.04        perf-stat.overall.MPKI
      4.48            +0.1        4.55        perf-stat.overall.branch-miss-rate%
     39.99            +1.3       41.27        perf-stat.overall.cache-miss-rate%
    168.91           -10.3%     151.57        perf-stat.overall.cycles-between-cache-misses
  13998510            +1.5%   14206269        perf-stat.ps.branch-misses
  18912177           +11.4%   21059829        perf-stat.ps.cache-misses
  47298361            +7.9%   51025248        perf-stat.ps.cache-references
 2.498e+11            -1.4%  2.463e+11        perf-stat.total.instructions





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


