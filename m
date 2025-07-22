Return-Path: <linux-ext4+bounces-9144-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05CFB0D181
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 07:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D8E1AA2172
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A900F28C5AF;
	Tue, 22 Jul 2025 05:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHEs3X+U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36432E36FD;
	Tue, 22 Jul 2025 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163676; cv=fail; b=LjlL2WjMRCOdgEV7siX5zL/FcoxuLYoTOLtejt/tFGx01dfrthRizl3ElmTMnOqRkiKcrRnkXEyC8Ac81OUVXsgY5lisxE3lk5yP/2vk/IWWFhgHJwzVWzrsafDm1TWrAzgIIukjm/TOkyu2nkU4ytyNZL1Oe92or4w2YIKdCXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163676; c=relaxed/simple;
	bh=wOb6Ra/lyR2sjtaOfNzB1lHlYzBdPPpkfrZsD59gJEc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K52pCF+PjybcwbXlwLPboEUasc3qEPfD8cIZfMx/OsdNc9Oer2c1NaW5MxgTsEG9vlBFRej2ynVBeB0X4hAVcB6gyICqytJWj7i7jeOj1mlsAXX6mejTlZi5F2gO0ye8LVCeFydI6d5E/0PR47lJ9XO/v1I7VpLCvk1JHHop0DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHEs3X+U; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753163675; x=1784699675;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=wOb6Ra/lyR2sjtaOfNzB1lHlYzBdPPpkfrZsD59gJEc=;
  b=BHEs3X+Ufk6HpRd8WrZKr4FkC/QeND8g6gDQ342/54QwSOAWmCq9RIW0
   PV1XjNamgYTu2oWDX70ry6b6PIk0MLwBVa8Y4dEgwHUwlFQt0I4rPGOJU
   HzBVawc32dEWIbDh6DMu7BV09YXzp9FWjrY4lEYh4iGEB35IG0+QihlgS
   n8KQEtWhhI0gaTDl8YWhyz5cVQDjAATofWdcvfrllAwNgY+hA20/PTAY6
   kPHXDYUjB5itvS06g2JKS12W48oNL+PCicy7+sZkJbOqFnTfNruiMlGud
   X83Z10CMc33APt/VnFDkWlzohqhNOwfeyqYlMt1pVTWz9mWd1aV/HbrfZ
   Q==;
X-CSE-ConnectionGUID: ZzfEahyxQnuzyFx6k5HUXg==
X-CSE-MsgGUID: Jq2+je9sRgG5Nm9OwOr/Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66468257"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="66468257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 22:54:34 -0700
X-CSE-ConnectionGUID: Ud02EzFKRNWsBEzFnCv3IA==
X-CSE-MsgGUID: 6UGIxhhAS/KshaL+2nk+eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="196115837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 22:54:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 22:54:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 22:54:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 22:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZvy+RvpO2hSoXolJeDkOXvIpRGYz3ZAz8VQT79OuG5/hggJJXdwicQdFYE64widm8/fB6IK830SeyIFSPlpkQACB4vteOrTYJpvSEMc0P3QfX131BMHfmOzH/VgPstjZsiqZYFKwQYDjlCMZctHs7CjtGJLLkDTGtOCCgscmHqADVdRydAwnjnmYrVPEnraDfTqjYQe3qQ8Q0L/LXDVnqhSqwC0QQZ/gn3jk/uCfzri/czbt4iwe49bOGqv273JMZpAl2chYJNOjRxHwyqRkScJdg4kbMIL4IY/46cJP3Mhn1zT72oz0+rAfxNJE7WSpIZZT0Jpeo84bu6UDkYtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xApnJs2cgjDYX+diKBqvkuiyIJTMMDslCU8dQy1uD4=;
 b=dEiqOSh2/yN9buRVjnG2Tpc8zXPuWBl7bcgwbOCSHD15AznUkYkobHYmAzS6+iUNbusfZRi13KrBy8DJXeEPAZFPpUIChpf03tKib/KfN3PZj6LoAv5ee6zwsv37ihep+ySmP7kjgPSuGVs6/ELdxlQ+fVnpNNNbRXc1KjzrcZ5CPIW43K6i+kG9iaX+6N6MoxNFyARrJoLoteA+bRCxL2Lpb6TTpYQJZrVyyM3CO7ipYCwQy6ZqbA8whMYsyj2PefVmdmX9KprBubWuGTzwTrmkfiA2RrpD++yQW9wcYDbiycew/a3grmuOW/8koVGuNtSuPzCF8xrVrEVMTbNbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 05:54:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 05:54:02 +0000
Date: Tue, 22 Jul 2025 13:53:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Moon Hee Lee <moonhee.lee.ca@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-ext4@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-kernel@vger.kernel.org>,
	<syzbot+544248a761451c0df72f@syzkaller.appspotmail.com>,
	<linux-kernel-mentees@lists.linux.dev>, <skhan@linuxfoundation.org>,
	<david.hunter.linux@gmail.com>, Moon Hee Lee <moonhee.lee.ca@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] ext4: bail out when EXT4_INLINE_DATA_FL lacks
 system.data xattr
Message-ID: <202507220717.738699fb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250710175837.29822-2-moonhee.lee.ca@gmail.com>
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 51053fdf-2938-460b-6618-08ddc8e428ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JqhIQVoEvyu08AOXGbq/62daFhn3xnNJp2N41VLG+dGtqrLnKYnCKP45sIRr?=
 =?us-ascii?Q?bIvUBiqb9Aac0xGtUqPVc634zQ81BHRRciicV2kx52Yhz6vmUqUXIpoljTqv?=
 =?us-ascii?Q?60WhT+GKsMl9kRiYL+mDEFpbtlq89xe2vCYsKSUr0Ar7HNc57hRWt0SL8dVA?=
 =?us-ascii?Q?uvK1rYQuuD9v59eWDDZ6A8rTch8Y1POeKjL92ZpNsoQu1D3HOhMGyEmsco+M?=
 =?us-ascii?Q?J6t0HXqFGlgaF0ZhLQD4fknMbh83AL9BwyYj5w3Wb4WEb9kHG8FdngGzHJc3?=
 =?us-ascii?Q?seitLCFctd3Q05rO7L6zjaDwILXL9PQyBLLUPfm8fEoy1TFfLyv/tqaeFkF7?=
 =?us-ascii?Q?vawWYerkz15pcztrbB61iSSaZzM1PlI+P4UAj+WIEPDY+aGAEUp9ZiSM9GmI?=
 =?us-ascii?Q?WuVUkOcoTEiHdCO9PnWlTEScvKCnUDn5aMJw53CSaiw7fQDsgFNIzDo7a4Gh?=
 =?us-ascii?Q?VlRIBiXmK7IvH2p0MbWIrBeM0aA5t9VnsGgpOpXCdtNu9FJec4z+eKZbVBGY?=
 =?us-ascii?Q?CIPFsWArbcRlf2bf3mZ/6ACInNbzPWBVimdsa+3wLofl2ArHV0cMfEgRZ11f?=
 =?us-ascii?Q?8x4v+RCYc/dGEFUdighkLnmln208ScyrnLzmNQDbR7WgSfLEwFpwgf3fcF62?=
 =?us-ascii?Q?ePUtsrf7RmrsvfJuUSVbUD9OoayRar1+6lp8EaovpbNz6ecbZ/0VoHpnmZFP?=
 =?us-ascii?Q?YOnjMgUTKRbT7vrzdO9A2jPojO/6itUvQvs3tdQUVC0PvqsTYd97Y7LDYr1D?=
 =?us-ascii?Q?ivQRMn2+SQpuIY2QWCluUfVB7xgp/nAlpQqqSYgsGiu7z8SfSUHKtAncxsfp?=
 =?us-ascii?Q?Q5+7KUYOm2RPyfgEHh9QMJy2QmdwtjqEtCwhpNbflEFN+YSMHQjylTW894cW?=
 =?us-ascii?Q?nQA/rM+fQDzKb0MYc6j55JI3RsXwYHEYFJ3PbV2oGTsZObkGkVzNFU4WYxe4?=
 =?us-ascii?Q?KbOI9kVIZH4JCMMWu82siaQSUY7UWHRCIJbi14E/edH3nfJZqA03F94xp3rk?=
 =?us-ascii?Q?n6Oe+ZURwPF8Pk0RhdkoCCvC8C606Euwf1qidOLboQMfFOsU1G9Wutasi7jz?=
 =?us-ascii?Q?Zpoe5n1E8nN7ncLPjEOImd1iTqUYYOpjxKJ3U3ngf3WHQjjdr3PicdB1U3dT?=
 =?us-ascii?Q?vFfo3APJfVy244V994i6v65WIwLEKzsILHJGHHiip4n3TPSySkYoWrYbikzJ?=
 =?us-ascii?Q?VNrV59WKPqEDTMqTzBcU8pLiI3QrxPylTbY44HJu7eFNZwgT40SJkw6lOwkw?=
 =?us-ascii?Q?b8IY0/SQYKkesXIgplSLIsvGEtpvVVSDB0Ohb/jJb2gXrS55uj2bwySCeSHr?=
 =?us-ascii?Q?jkc/4IplGIdWAtB9WmalPFilNCA8eTeK2micaQv8WUYjr063gVTBDpFKILh7?=
 =?us-ascii?Q?WaZuQLk2MK90UFCW2o0VNbGYsf7M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lwNHYtYB8mJdNGspEK0OuAT+4lF0j3JoPaMIziu/3kmikJT2Q6jiGRVPkJuv?=
 =?us-ascii?Q?ungRCBkbOp79rKoHgQuANSWR+t4Tgbom/nCSd3p0a9OLS2cUc8qhjOldxQYc?=
 =?us-ascii?Q?rzF+QSOd5ayyjd/1XzkkVZQqj/e4bTcox/LoLEQ2gtt+5YMTJJem+Pt9yP9X?=
 =?us-ascii?Q?bDgwAzkcQxUzXh8M8Zybh547uOJ/LlxFP1oLl8FY9b3pHjLCtwIuCUfWtEQb?=
 =?us-ascii?Q?CW+sosSBLpgPKosUvKmEqTDKKsQRbRYShNmATgsZuDNu1NGjU0fA+PNnri+E?=
 =?us-ascii?Q?Xm14b7SF0wJ3R9+OVJi+UTMb2ZxWXAkMH9qhaVa4gglYiwyz7KcHG+UR0w0D?=
 =?us-ascii?Q?gUxxxXypjLrDLHVrPxirSAVyKX4aR/8m2bLhkZknv3mM2s11x6PXWiRPPek3?=
 =?us-ascii?Q?J1dNMiUZbkRJ7wApjjdqsTikwGXf/iWSi0OUqr0hyWXx9oB1VLCvywohQ//Y?=
 =?us-ascii?Q?p0l4bylnO0Kc5KewkwqDQHJsQKX7JKkhehpaLesPH5ykQBgnGnO1vIYez5zt?=
 =?us-ascii?Q?5fE3/GJ7NjFDmhZu8XoavOFBNowww2QEZDMJgQs6EDjBeQWCAWK9ZNUURutd?=
 =?us-ascii?Q?fgB9doK85Wpv8udJir6Te6QyWpHrv+z28T7m8c3D6u2tRpkI4Hyh5PXmkwKv?=
 =?us-ascii?Q?0JbzL5UTbyjMSg6amo+HVy405Q/3/JoyVWulH21wdrLSyvz1f0zmUfIEl1Ae?=
 =?us-ascii?Q?/nun7iRnmHJYRvkRahHL1fT3ja4R5B1l2o0REpimghmpc9PamnOBgvcM1ojj?=
 =?us-ascii?Q?k1sodo0FMnHzsB+Byc5pgAa9AlgRG1IRyziRRTzMmNbdos4wLm//cjI0ijCx?=
 =?us-ascii?Q?0Wr3V85MQf0b2VtkXU9q0soPX1Jur2GiIqbzeuhg08NXippyO+nwcOoG54cc?=
 =?us-ascii?Q?660BoIDSYl//UjHH1WkLieZylZYiZFA9b1/AkKx7EGyIH9wtDWTF+ZlGTGwE?=
 =?us-ascii?Q?lacp5C60hihDu4qaO22Ik7uqEnF+uNK0deuT94kpa8jrLxiRNcUvM05B4F2b?=
 =?us-ascii?Q?uEEanfjaWz2WYjw+E6GtO9hITjgyTv0mQWYrBC0mekEcYOf6pCTmfZd9PJok?=
 =?us-ascii?Q?fUzbgVD8o6asow+2ctMdM6n1Fg61gT9Ai9LNrJoMvVA7PoinnhLLu5oK1Kvl?=
 =?us-ascii?Q?9VitIKjDwjhfX57QYNP07zUZjNNszcZkrkdzBnFFI/aNl0rnHrgX/qw/R7d8?=
 =?us-ascii?Q?1E55r/FirnCWm7p893cwVl+X19Iz/eV0eSRYGfFc/ouAY3iePapuOhUMZwZO?=
 =?us-ascii?Q?EYjJqoWRk/ZFQ2qV3T8lKt4a8r0ER8aSA/X3fpY3J3H8ug6wY/0lhzK7+mKl?=
 =?us-ascii?Q?ajJuthuLkLGOAt44zCsVfP6z3kK8D+zWTIcJkft5gIoVOD2H+/wmDs/cZzCy?=
 =?us-ascii?Q?p8+7Bc5kYgXcTcUEKhiVBWKtJdtFTvEbkbfTtNpKhWDXhF4TAr4IH1sTaiG1?=
 =?us-ascii?Q?dNMOIq96cZryRJ3x0NyseIrL8IWeUTGCakN+QJK2jLbR+h5m0wNx5VxyyGN1?=
 =?us-ascii?Q?RMpq8nbLk3EAwYe0XhRI9XoM0aLiFsnGQKE3yNtD4+jnS4S7neV5STMWbhjV?=
 =?us-ascii?Q?FW+fVLZTEM4CLrsIUCC5cKIW+7bhpD81mgOhgwD2KLN/EXAjJ79HYdFCZeWK?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51053fdf-2938-460b-6618-08ddc8e428ec
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 05:54:02.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I2Ui3h0is+Hymb0atRsI1EEbDegZ+3zzKuqu9zGeRNQWJIJQnfcXXUEImAfsSpMzIEXAdVdbWx33s8gxQ+ekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.ext4.031.fail" on:

commit: ac16746132e9dafa56057ce201948e8853fd3834 ("[PATCH] ext4: bail out when EXT4_INLINE_DATA_FL lacks system.data xattr")
url: https://github.com/intel-lab-lkp/linux/commits/Moon-Hee-Lee/ext4-bail-out-when-EXT4_INLINE_DATA_FL-lacks-system-data-xattr/20250711-020009
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20250710175837.29822-2-moonhee.lee.ca@gmail.com/
patch subject: [PATCH] ext4: bail out when EXT4_INLINE_DATA_FL lacks system.data xattr

in testcase: xfstests
version: xfstests-x86_64-e1e4a0ea-1_20250714
with following parameters:

	bp1_memmap: 4G!8G
	bp2_memmap: 4G!16G
	disk: 2pmem
	fs: ext4
	test: ext4-031


config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507220717.738699fb-lkp@intel.com

2025-07-17 19:49:18 export TEST_DIR=/fs/pmem0
2025-07-17 19:49:18 export TEST_DEV=/dev/pmem0
2025-07-17 19:49:18 export FSTYP=ext4
2025-07-17 19:49:18 export SCRATCH_MNT=/fs/scratch
2025-07-17 19:49:18 mkdir /fs/scratch -p
2025-07-17 19:49:18 export SCRATCH_DEV=/dev/pmem1
2025-07-17 19:49:18 echo ext4/031
2025-07-17 19:49:18 ./check -E tests/exclude/ext4 ext4/031
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d01 6.15.0-rc4-00053-gac16746132e9 #1 SMP PREEMPT_DYNAMIC Fri Jul 18 03:31:11 CST 2025
MKFS_OPTIONS  -- -F /dev/pmem1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/pmem1 /fs/scratch

ext4/031       - output mismatch (see /lkp/benchmarks/xfstests/results//ext4/031.out.bad)
    --- tests/ext4/031.out	2025-07-14 17:48:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//ext4/031.out.bad	2025-07-17 19:49:20.122098626 +0000
    @@ -1,2 +1,3 @@
     QA output created by 031
    +/lkp/benchmarks/xfstests/tests/ext4/031: line 35: echo: write error: Structure needs cleaning
     Silence is golden
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/ext4/031.out /lkp/benchmarks/xfstests/results//ext4/031.out.bad'  to see the entire diff)
Ran: ext4/031
Failures: ext4/031
Failed 1 of 1 tests


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250722/202507220717.738699fb-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


