Return-Path: <linux-ext4+bounces-5496-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC89E69F1
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 10:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69948281A25
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Dec 2024 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F11DFE0E;
	Fri,  6 Dec 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxxhcN57"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710E91DED74;
	Fri,  6 Dec 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476931; cv=fail; b=hZ3OKzh/pJ+szW5d4sJ5STY9wl29Boz6rJx8QcJO4jhYL/IxgPirTtFNH0oDoGJNokS4uxtXAJ+ks7vCfkWdkGGH+QD4Zjpi6Mch8NCvhGTxg05pPIZk1nWyqtNImIpyz1M7q7/5zX6ess6DY4KSgyl1vLtILf554ULG4Y1Bm1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476931; c=relaxed/simple;
	bh=2IVADLQtLslwXuGtnumqdGVt2gOkWg6bcd5+VkQRCVU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=C6YXeSNLXjb97mQuDUDMcO9NZroMv4xtl0cubzC6JfS42Rw0mukycnuZOCFkkvlYGfQeH+W+QaJ1cf5M1SDVanj5PrWn/BfdXv8Lwdnq5VvBoSqxGH2+fo9PXTTqvhRsYa++stCOEu4x738j2LDxrOUYE5aR3knUHOUSrHYWu3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxxhcN57; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733476928; x=1765012928;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=2IVADLQtLslwXuGtnumqdGVt2gOkWg6bcd5+VkQRCVU=;
  b=JxxhcN57gKKjqseiKckhtjJMewoLvqnlIbLO9S+l5lgfK2DC8jHLRe86
   0mGCNpTk1+j7dKa/je8KLare7cjnNhlB4U2Gpg+7qjj8S+887TFzEkZ11
   ck+hpiHoyfe9DEO0VFO1Q7FNqYOy/Pu4mCfhNujIgmssEZlNKMCE4cnBN
   HF8elQNYCI/kxNSdcNleDpC0/rX0oLBQd0JM9o7Xet5+rYmYl/55fzd6b
   WbSVyhNAf1rURj8pKkipwViobs/Wq5Kj+gRqw5Y95aLFjQKATQj4FQwit
   fldVqTiYeCtZW6SYXhZfy3Y1Bq+ZLH954utVkKkekfwEzoV5YDP9UsJfA
   g==;
X-CSE-ConnectionGUID: oogmiyqdRsWqsiBjSIbtFQ==
X-CSE-MsgGUID: 7g+wjDgySui80rSxk4gfYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="56314231"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="56314231"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 01:22:07 -0800
X-CSE-ConnectionGUID: yDeZJfIKTSaQ9XrSEGgQ1A==
X-CSE-MsgGUID: l7SV//vfQTqWCk6AOmHGxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94839553"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2024 01:22:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Dec 2024 01:22:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Dec 2024 01:22:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 01:22:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA4ckfGKfByrbe7DiYlorcasVChUTHyLLQoQNBz0DSynB/YMrDJ0muz/YYLTqQaPODwJHc0v9uQJ9QfUJZ2bd3bZPTG+DkX9CnSb+Asb/drCVUPpNWCW8izSY8UdOhmn+wnkxcY05wObFh7uTzEo5M5BDOaI8QiE2OTT0mpxpegj2879GgRkVsN1OgjiV0bcv7MrY+4Ns2bpzPLl2nj/ED9s5EdbJfc97164oBdHwVcmrvfjY5ZmGNh/0Ktfwp+ffGrLEqzJY4lYeXh39WTRMjWd0cL86r2DkxSdlQglsgsTMuR9Ah4E3Tr6j+P243atc1rgHmkGVgXrN8BlbSPdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWpe9NxpvWChrvLWaBF5zMm2FqwlGyYor2VYrQtQqlw=;
 b=YwDcaPo5FCVFLR3P/dluGn0WfB1oT2cANjqxJKGqjPn+ldDp5qyJNIBwGE/tqSji2HuPT5W6/O3jP1pw/pJ5o5Wlh1LTi9/LQMclD8wKmjmzDXj7ccOqxtGArOLBu+kfDa+ECJbFebpqiiJno92zKZtL/cciPu4sbaG0A4qc3TllckWHskSiCSlcyiGLBBG0foLutIFDqAfIp3W39w07Cor9aFVnp1gXNRuw8jfS/PZO3fUO5mlCVsH0B+rUStnD9MtsGuWjd90jPBrZcE3ujPeJu2WpZd4KgBCbdfCQsSdYFApsP/cY2VFX2j9jkEBhdvw5AF1hsF+ZObJvuIZxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 09:22:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 09:22:03 +0000
Date: Fri, 6 Dec 2024 17:21:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Brian Foster <bfoster@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [ext4]  c7fc0366c6:  stress-ng.metamix.ops_per_sec
 22.9% improvement
Message-ID: <202412061635.d962a313-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a567a2-d052-4221-350d-08dd15d771be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?NT/Rk2RcIHo4laPOqcNVyrPPQ8jEhnYTlKZtJsfTMf0IEP6SueqJtCvkvt?=
 =?iso-8859-1?Q?spdCDUCzvUiga/BAl4q5oj4mwEescBuhknMWLdUE1emIAPr2JJvQoFDFtn?=
 =?iso-8859-1?Q?Wyq7OnaIPtxGBbiY7kWv4FFgHxThvYlr5GSK4kVQXH4HHr9v7HrGMGdqEU?=
 =?iso-8859-1?Q?HdvnvJtpg8CW9dxWxCCfdVNZsPWUF+nYYz3TXLmEZdvO+TgJH7J6AWjv9k?=
 =?iso-8859-1?Q?JwO9u/3cZQTZcDgTIR1PczWgvesQgh+6m6ylyiyni6Z0+IyDIjyJZOZC4t?=
 =?iso-8859-1?Q?KBgk16hMOTvxJTR4E4LIE5C1h1XfPK7DmuW4IfvHBD3BPB7NVqoAEME49H?=
 =?iso-8859-1?Q?rSkZF1/5w1uqR+2RYWfQNb4sILLogFy7qBmM8+HceWLm4xQHIns9xAceit?=
 =?iso-8859-1?Q?OKqXYs4TWCN5IZdHNFw/jZ0Lyhljwt+f5VfHgWpFcwQtC2FIoAxvESC35r?=
 =?iso-8859-1?Q?K5khEPsCVedptaAcZK/sUlwdgEbN1xxfZ3RohbcPn0uBue5ylmw+IhWwBl?=
 =?iso-8859-1?Q?E/cODL6Zgjs9VIpZ7GHDy8cmoqvN6OGcgy78FLiZ6mAJ/IlRrF7nA+XgVI?=
 =?iso-8859-1?Q?JWsJC9whrGDx5tLZmkIwCUz2pBqfPEUqdPqC+ISrbg5LQgAIjOmcZjfNfx?=
 =?iso-8859-1?Q?Vp4bKSIYiUMfG3r9H/WqV+aGacnjQjOOZO0AmM+r13Xp3gIX3E8aQhJw2a?=
 =?iso-8859-1?Q?uzQjJXgRnjNA/G8S8uP31oTiJJZlm/KWO/gWt5kxK4H2HxfJPBhOG2r27n?=
 =?iso-8859-1?Q?Wo/N16NWqy7CE1c1Kbsd/CqCjTk2Q15fEYvpTfX91EiWi/Vm8USRAmVd7I?=
 =?iso-8859-1?Q?ozCINRGPgpg/ADswBeS3owLfX0vss2maVW4SMBwSp+92JApZFvZhGMqcYB?=
 =?iso-8859-1?Q?3FuetiQ6CrKdL3fH+9SC6y7pyD3iWPDokIrizR7XLloY2Ujhu9bgiPIlcg?=
 =?iso-8859-1?Q?I8wtwlAJWUN4FNhsAz2dZ2wx/u8LJJUS+TDAnK0H6rsYCZky6jQ/QYY5+V?=
 =?iso-8859-1?Q?+uojUr1JNXi+YVlj7tjLQ98Fo9WU90zug4rWJwPllVCIqr5OPB18DKu952?=
 =?iso-8859-1?Q?E230O5Ej2A1gIpNr/fKw6J5FnQGeK4dEcUDHFuAugszR6jaYYHJW0tOVkw?=
 =?iso-8859-1?Q?7Yqf3MuKDxV5NhmaSmXs9GamOLNVeE8iGvq72z0JsR2LaIS/vx4f2nuDsO?=
 =?iso-8859-1?Q?OM2CjfhCjgcXU6fwHfAGSL1dovVpCypjMk8gIpS2wWJyeps4cOV1iIF8v/?=
 =?iso-8859-1?Q?fUd/pFDJ6Z3zcdDt748EWCKdEpctM7zUmWgjgcBgNsjJStOgLTG4nzMkhB?=
 =?iso-8859-1?Q?oQk/obhWFyh7X7sq6qEi/yivg8sMti6yxdzw6CCxoctGlnnlqH+6OtE9DY?=
 =?iso-8859-1?Q?kssDDH0lBZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ibAcallZr2xk3wwBBiZXi9CdaqlySLyTLnhV7x9ZPeOkOP76icDi481ih7?=
 =?iso-8859-1?Q?rjIwfkYl9q39wjvkbmhJq/LJW232TXGbHz2yoyy4xhMfwr3TSiqi1amSuB?=
 =?iso-8859-1?Q?gtuA8C5mQAyBXait+jCfx7FQws+W7Av1QyQOSX9U/U0AbccrdOQuZz4ayA?=
 =?iso-8859-1?Q?hLWRvs/6z7vmqEJUAHvU/viDOnbao/zTmPpV8WuDdmPh4ngYHLBLVodJTR?=
 =?iso-8859-1?Q?oz53Xhbxa4CSB8dRx5jMQswvq/tG5Faw/K0cS9LPEBKNUBGAbATM37Py5Y?=
 =?iso-8859-1?Q?cw4a2O8y9d9xJNhjbQqg1es2Y08cOu/Uxq+yrDYpMs8FYQx4gVELiqwDdN?=
 =?iso-8859-1?Q?m4N4APx1N7wilZuoqSRnMqq86sdT1dJRDiaoIpTFRAusQSVPlkLQu6PR/z?=
 =?iso-8859-1?Q?4teUOK0WOoc5iJaQJLUXhKBv8JAhCQ3jncwDVtGsDFlBW4T+TzXKEZJjA0?=
 =?iso-8859-1?Q?fs5tDxg/tvJDp2W40JgqyJfo/36ihcsmS/A/XgExn2pNcUHqgw0FJMkMs3?=
 =?iso-8859-1?Q?cLxlBhdszSgBhoeroXrFfLb3C/IhJS67U1TSw9Nm2U0bWxELiuWZ/ib7Gp?=
 =?iso-8859-1?Q?npKrAcvWZ/6KJJB4bJKs/hbRPM3dq+ATgCYPp/GpsmcDXzoszRm4aJnqyl?=
 =?iso-8859-1?Q?a3I72sbZfe/gI9hilrxyE+8m2oHu69UCyb5UkSSSnqBE37YQAXmf5QN0Vk?=
 =?iso-8859-1?Q?/BVwEUT4gtntBhocofXxSbxVtN9rmBx1qxaClBWf6Q0oGfwm+dP1LGibqb?=
 =?iso-8859-1?Q?yJusTw72i90NiH0UcBwjdO1ROsks/o2ByRD/7fZiqfXMHfoSQ3O0hirm3I?=
 =?iso-8859-1?Q?NWdhLN5WHlB7sxHt8ek1FqXt2NddbkSWuBRuMkpMySnuVKIReu+8edZw49?=
 =?iso-8859-1?Q?C9hrHwD7bN+D46YhF0tYVzvsDZmtdneYoFwqnCp6aNA+x7YdOgLfIY4/yi?=
 =?iso-8859-1?Q?LoxFjltNMuMbLul7h8UdWj0av8TrJf6I80+2HwlALDzX1KXF4vU98pAcqT?=
 =?iso-8859-1?Q?bCd33v4HIfiGuPeHr+wdrW0koorX/uqDhhHqodgmf81dqO8kRAswY+RCk5?=
 =?iso-8859-1?Q?lqL0DGYoSLL+UWcQKrziTW1Q4GBCIf24RZUq/XkowPcdjhBFmyAiymup8d?=
 =?iso-8859-1?Q?/uAilQhVdl27BIU9wbbdWzuvZHoe6Tl/py/f5AgXSBLYFFiU6DUkcRPayi?=
 =?iso-8859-1?Q?MVgJg4Q83MylnNGNaJpNG3lU4GZqm7NfW17mHEi+N1XYSD7VJYBg1B9Gf5?=
 =?iso-8859-1?Q?w5IssaKzBnCUbxPJaTSgiBNhjV8lZGSoJPMzwDREvlrzPLjM4eKwuyYqsE?=
 =?iso-8859-1?Q?VKaEVd51b1daHE/kQgl5oSDXIuHysOxctFGva3WWSZ++lvjzrA14053BIu?=
 =?iso-8859-1?Q?O7V2Umz7R04lxJVcOIEe54+6PO/pKocatdT2QLTm5pYSxwlTulVSyLP3ef?=
 =?iso-8859-1?Q?y4PjivGWF1dnz+Zmq4R5QqkVCzeq56ZO0glSKEI1eS21HIUpu5QJoinpXQ?=
 =?iso-8859-1?Q?1EHJweKaENPwGKBIB5mSqfPvWdxjzZ7ZxKu3Rj/0wpatT7M9h2PtCbwnWc?=
 =?iso-8859-1?Q?s5z8Axp6KXubYSTtOhrLPSDkvMKRXlwXS6ExVDGnkwEkveAnaHxUviK/1j?=
 =?iso-8859-1?Q?clFQf7M1yPecWoqx+6RVKW3P+yktJmcBro5bHguzwAbclmqvIUqG6ePg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a567a2-d052-4221-350d-08dd15d771be
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 09:22:03.0750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uxC0dOoq+UPLkseHmbKpWVTd6qKZxYxDJYFwJJWyCo4Cr4+f5WVJvmkwvTd1cRUjc5ZlEDIvaH3auTurmKU5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 22.9% improvement of stress-ng.metamix.ops_per_sec on:


commit: c7fc0366c65628fd69bfc310affec4918199aae2 ("ext4: partial zero eof block on unaligned inode size extension")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: metamix
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241206/202412061635.d962a313-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-ivb-d01/metamix/stress-ng/60s

commit: 
  25f51ea8ac ("ext4: disambiguate the return value of ext4_dio_write_end_io()")
  c7fc0366c6 ("ext4: partial zero eof block on unaligned inode size extension")

25f51ea8ac8144af c7fc0366c65628fd69bfc310aff 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    553.38 ±  4%     +12.1%     620.15 ±  2%  uptime.idle
     26348 ±  3%     -40.4%      15711 ±  7%  meminfo.Dirty
     16924 ±  2%     -32.5%      11430 ±  7%  meminfo.Writeback
      6.91 ±  9%    +163.1%      18.17 ±  7%  iostat.cpu.idle
     90.85           -13.0%      79.04        iostat.cpu.iowait
      1.45           +33.6%       1.93        iostat.cpu.system
 1.117e+08 ±  4%     +15.9%  1.295e+08 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.avg
   8990780 ± 48%    +201.7%   27121462 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.min
 1.117e+08 ±  4%     +15.9%  1.295e+08 ±  6%  sched_debug.cfs_rq:/.min_vruntime.avg
   8990780 ± 48%    +201.7%   27121462 ± 23%  sched_debug.cfs_rq:/.min_vruntime.min
      4.41 ± 14%     +11.6       16.01 ±  9%  mpstat.cpu.all.idle%
     93.54           -12.1       81.39        mpstat.cpu.all.iowait%
      0.23 ±  2%      +0.1        0.31 ±  2%  mpstat.cpu.all.irq%
      0.07 ±  2%      +0.0        0.07        mpstat.cpu.all.soft%
      1.13            +0.4        1.54        mpstat.cpu.all.sys%
      6.94 ±  9%    +162.5%      18.21 ±  7%  vmstat.cpu.id
     90.85           -13.0%      79.05        vmstat.cpu.wa
     31576           +20.8%      38129        vmstat.io.bo
     64.71 ±  3%     -33.6%      42.98 ±  8%  vmstat.procs.b
      2893            +2.9%       2976        vmstat.system.in
      1911 ±  2%     +21.8%       2328        stress-ng.metamix.ops
     30.37           +22.9%      37.32 ±  2%  stress-ng.metamix.ops_per_sec
   4111968 ±  2%     +20.4%    4952304        stress-ng.time.file_system_outputs
     24323            +8.5%      26386        stress-ng.time.minor_page_faults
      6.17 ±  6%     +54.1%       9.50 ±  5%  stress-ng.time.percent_of_cpu_this_job_got
     23964 ±  2%     +18.6%      28423        stress-ng.time.voluntary_context_switches
    514496 ±  2%     +20.4%     619656        proc-vmstat.nr_dirtied
      6606 ±  3%     -42.4%       3807 ±  5%  proc-vmstat.nr_dirty
      4338            +3.4%       4486 ±  2%  proc-vmstat.nr_page_table_pages
      4266 ±  2%     -33.9%       2820 ±  7%  proc-vmstat.nr_writeback
    514089 ±  2%     +20.5%     619358        proc-vmstat.nr_written
     10850 ±  3%     -39.1%       6607 ±  6%  proc-vmstat.nr_zone_write_pending
    666231 ±  2%     +15.4%     769072        proc-vmstat.numa_hit
    666231 ±  2%     +15.5%     769184        proc-vmstat.numa_local
    698850 ±  2%     +14.8%     802298        proc-vmstat.pgalloc_normal
    678127 ±  3%     +15.7%     784461 ±  2%  proc-vmstat.pgfree
   2088116 ±  2%     +19.9%    2503923        proc-vmstat.pgpgout
  94023007           +15.2%  1.083e+08        perf-stat.i.branch-instructions
   2405282           +15.0%    2765956        perf-stat.i.branch-misses
     14.62 ±  2%      -1.2       13.38        perf-stat.i.cache-miss-rate%
    583290 ±  2%     +17.5%     685524 ±  2%  perf-stat.i.cache-misses
   3648640 ±  2%     +29.2%    4714050        perf-stat.i.cache-references
 5.461e+08           +24.7%  6.808e+08 ±  2%  perf-stat.i.cpu-cycles
    164.88 ±  2%     +24.0%     204.37        perf-stat.i.cpu-migrations
    833.08            +7.0%     891.37 ±  2%  perf-stat.i.cycles-between-cache-misses
 4.545e+08           +16.6%  5.301e+08        perf-stat.i.instructions
      0.61            -1.1%       0.60        perf-stat.i.ipc
     15.99            -1.4       14.54        perf-stat.overall.cache-miss-rate%
      1.20            +6.9%       1.28        perf-stat.overall.cpi
    936.52 ±  2%      +6.1%     993.24        perf-stat.overall.cycles-between-cache-misses
      0.83            -6.4%       0.78        perf-stat.overall.ipc
  92548187           +15.2%  1.066e+08        perf-stat.ps.branch-instructions
   2367842           +15.0%    2723489        perf-stat.ps.branch-misses
    574185 ±  2%     +17.5%     674749 ±  2%  perf-stat.ps.cache-misses
   3591758 ±  2%     +29.2%    4640021        perf-stat.ps.cache-references
 5.375e+08           +24.7%  6.701e+08 ±  2%  perf-stat.ps.cpu-cycles
    162.31 ±  2%     +23.9%     201.17        perf-stat.ps.cpu-migrations
 4.474e+08           +16.6%  5.218e+08        perf-stat.ps.instructions
 2.874e+10           +15.8%  3.328e+10 ±  2%  perf-stat.total.instructions
      0.02 ±  9%     +25.2%       0.02 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.48 ± 44%    +216.9%       1.52 ±106%  perf-sched.sch_delay.avg.ms.io_schedule.bit_wait_io.__wait_on_bit.out_of_line_wait_on_bit
      0.00 ± 16%    +148.1%       0.01 ± 76%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.02 ± 10%     +26.8%       0.03 ±  8%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.94 ± 52%     -76.1%       1.90 ±131%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
      0.02 ± 55%   +1263.0%       0.21 ±185%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
    252.86 ± 13%     -46.6%     134.96 ± 19%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    291.92 ±  4%     -38.6%     179.21 ± 17%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     45.27 ±  9%     -11.1%      40.23 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     26.86 ±  2%     +22.0%      32.76 ±  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    292.00 ± 12%     +71.9%     501.83 ± 16%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    323.83 ±  7%     +29.0%     417.83 ± 12%  perf-sched.wait_and_delay.count.jbd2_log_wait_commit.ext4_sync_file.do_fsync.__x64_sys_fdatasync
      2817 ±  2%     -17.3%       2329 ±  8%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    999.12 ±  4%     +71.7%       1715 ± 20%  perf-sched.wait_and_delay.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    909.77 ± 11%     +88.7%       1716 ± 20%  perf-sched.wait_and_delay.max.ms.jbd2_log_wait_commit.__jbd2_journal_force_commit.jbd2_journal_force_commit.ext4_sync_file
    970.08 ±  4%     +51.7%       1471 ± 28%  perf-sched.wait_and_delay.max.ms.jbd2_log_wait_commit.ext4_sync_file.do_fsync.__x64_sys_fdatasync
    252.77 ± 13%     -46.6%     134.90 ± 19%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
    291.02 ±  4%     -38.8%     178.11 ± 17%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     21.25 ±192%   +2117.6%     471.24 ± 90%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     45.22 ±  9%     -11.1%      40.19 ±  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     26.84 ±  2%     +22.0%      32.73 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    998.61 ±  4%     +71.3%       1710 ± 20%  perf-sched.wait_time.max.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
    908.10 ± 12%     +88.5%       1711 ± 20%  perf-sched.wait_time.max.ms.jbd2_log_wait_commit.__jbd2_journal_force_commit.jbd2_journal_force_commit.ext4_sync_file
    969.71 ±  4%     +51.4%       1468 ± 28%  perf-sched.wait_time.max.ms.jbd2_log_wait_commit.ext4_sync_file.do_fsync.__x64_sys_fdatasync
     28.45 ±194%   +3281.7%     962.20 ± 56%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
     40.18 ±  3%      -4.3       35.85 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     40.18 ±  3%      -4.3       35.85 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     44.88 ±  3%      -4.3       40.58        perf-profile.calltrace.cycles-pp.common_startup_64
     40.10 ±  3%      -4.3       35.80 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     36.18 ±  4%      -4.2       31.96 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     39.12 ±  3%      -4.2       34.91 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     39.55 ±  4%      -4.1       35.44        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     22.45 ±  4%      -1.7       20.71 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      3.22 ± 14%      -1.6        1.58 ± 15%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.97 ±  7%      -1.6        5.40 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
      6.97 ±  7%      -1.6        5.40 ±  5%  perf-profile.calltrace.cycles-pp.do_fsync.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync
      6.96 ±  7%      -1.6        5.40 ±  5%  perf-profile.calltrace.cycles-pp.ext4_sync_file.do_fsync.__x64_sys_fdatasync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.03 ±  7%      -1.6        5.46 ±  6%  perf-profile.calltrace.cycles-pp.fdatasync.stress_metamix
      6.99 ±  7%      -1.6        5.43 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
      6.99 ±  7%      -1.6        5.43 ±  6%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fdatasync.stress_metamix
      6.17 ±  7%      -1.5        4.71 ±  7%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.ext4_sync_file.do_fsync.__x64_sys_fdatasync.do_syscall_64
      5.84 ±  8%      -1.3        4.51 ±  7%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file.do_fsync.__x64_sys_fdatasync
      5.84 ±  8%      -1.3        4.51 ±  7%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file.do_fsync
      5.83 ±  8%      -1.3        4.51 ±  7%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.ext4_sync_file
      5.82 ±  8%      -1.3        4.51 ±  7%  perf-profile.calltrace.cycles-pp.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      5.82 ±  9%      -1.3        4.50 ±  7%  perf-profile.calltrace.cycles-pp.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      5.87 ±  9%      -0.9        4.99 ±  6%  perf-profile.calltrace.cycles-pp.llseek.stress_metamix
      3.42 ±  6%      -0.6        2.78 ±  5%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc
      3.20 ±  5%      -0.6        2.64 ± 14%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.42 ±  6%      -0.5        1.96 ± 15%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.09 ±  8%      -0.4        1.66 ±  9%  perf-profile.calltrace.cycles-pp.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages.do_writepages
      1.00 ± 16%      -0.4        0.59 ± 45%  perf-profile.calltrace.cycles-pp.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_writepages.do_writepages.filemap_fdatawrite_wbc
      1.79 ±  5%      -0.4        1.39 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.llseek.stress_metamix
      1.37 ± 16%      -0.3        1.03 ± 11%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.llseek.stress_metamix
      1.62 ±  8%      -0.3        1.34 ±  9%  perf-profile.calltrace.cycles-pp.mpage_submit_folio.mpage_map_and_submit_buffers.mpage_map_and_submit_extent.ext4_do_writepages.ext4_writepages
      0.89 ± 16%      -0.2        0.68 ± 17%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_domains.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.00            +0.6        0.62 ± 17%  perf-profile.calltrace.cycles-pp.start_this_handle.jbd2__journal_start.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +0.8        0.76 ± 13%  perf-profile.calltrace.cycles-pp.mark_buffer_dirty.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write
      0.00            +0.8        0.76 ± 25%  perf-profile.calltrace.cycles-pp.__ext4_get_inode_loc.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_da_do_write_end
      0.00            +0.8        0.76 ± 24%  perf-profile.calltrace.cycles-pp.mpage_prepare_extent_to_map.ext4_do_writepages.ext4_normal_submit_inode_data_buffers.jbd2_journal_commit_transaction.kjournald2
      0.00            +0.8        0.78 ± 23%  perf-profile.calltrace.cycles-pp.ext4_get_inode_loc.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_da_do_write_end.generic_perform_write
      0.00            +0.8        0.78 ± 19%  perf-profile.calltrace.cycles-pp.crc32c_pcl_intel_update.ext4_inode_csum.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode
      0.00            +0.8        0.78 ± 23%  perf-profile.calltrace.cycles-pp.ext4_do_writepages.ext4_normal_submit_inode_data_buffers.jbd2_journal_commit_transaction.kjournald2.kthread
      0.00            +0.8        0.78 ± 23%  perf-profile.calltrace.cycles-pp.ext4_normal_submit_inode_data_buffers.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      0.19 ±142%      +0.9        1.10 ± 21%  perf-profile.calltrace.cycles-pp.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.19 ±142%      +0.9        1.10 ± 21%  perf-profile.calltrace.cycles-pp.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +1.0        0.96 ±  9%  perf-profile.calltrace.cycles-pp.jbd2__journal_start.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +1.0        0.97 ± 16%  perf-profile.calltrace.cycles-pp.__block_commit_write.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.0        1.03 ± 16%  perf-profile.calltrace.cycles-pp.ext4_reserve_inode_write.__ext4_mark_inode_dirty.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.0        1.03 ± 16%  perf-profile.calltrace.cycles-pp.block_write_end.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +1.1        1.08 ±  8%  perf-profile.calltrace.cycles-pp.ext4_inode_csum.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty
      0.00            +1.1        1.08 ± 18%  perf-profile.calltrace.cycles-pp.memset_orig.zero_user_segments.__ext4_block_zero_page_range.ext4_da_do_write_end.generic_perform_write
      0.00            +1.2        1.15 ±  9%  perf-profile.calltrace.cycles-pp.ext4_inode_csum_set.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty
      0.00            +1.2        1.16 ± 19%  perf-profile.calltrace.cycles-pp.zero_user_segments.__ext4_block_zero_page_range.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.7        1.70 ± 11%  perf-profile.calltrace.cycles-pp.ext4_fill_raw_inode.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_da_do_write_end
      0.00            +1.7        1.71 ± 10%  perf-profile.calltrace.cycles-pp.__ext4_block_zero_page_range.ext4_zero_partial_blocks.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +1.8        1.78 ±  9%  perf-profile.calltrace.cycles-pp.ext4_zero_partial_blocks.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +1.9        1.88 ± 13%  perf-profile.calltrace.cycles-pp.__ext4_block_zero_page_range.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
      0.00            +2.2        2.16 ±  9%  perf-profile.calltrace.cycles-pp.ext4_do_update_inode.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_da_do_write_end.generic_perform_write
      0.00            +2.3        2.34 ±  8%  perf-profile.calltrace.cycles-pp.ext4_mark_iloc_dirty.__ext4_mark_inode_dirty.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter
      0.00            +3.4        3.42 ±  5%  perf-profile.calltrace.cycles-pp.__ext4_mark_inode_dirty.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write
     43.79 ±  4%      +5.7       49.45        perf-profile.calltrace.cycles-pp.stress_metamix
     13.98 ± 10%      +8.6       22.60 ±  3%  perf-profile.calltrace.cycles-pp.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64
     15.52 ± 10%      +8.7       24.25 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write.stress_metamix
     15.46 ± 10%      +8.7       24.21 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_metamix
     14.55 ± 10%      +8.8       23.32 ±  2%  perf-profile.calltrace.cycles-pp.ext4_buffered_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.97 ± 10%      +8.8       23.79 ±  2%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     15.16 ± 10%      +8.8       24.01 ±  2%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write.stress_metamix
     17.88 ± 10%      +8.9       26.79 ±  2%  perf-profile.calltrace.cycles-pp.write.stress_metamix
      0.00           +10.0       10.04 ±  6%  perf-profile.calltrace.cycles-pp.ext4_da_do_write_end.generic_perform_write.ext4_buffered_write_iter.vfs_write.ksys_write
     40.18 ±  3%      -4.3       35.85 ±  2%  perf-profile.children.cycles-pp.start_secondary
     44.88 ±  3%      -4.3       40.58        perf-profile.children.cycles-pp.common_startup_64
     44.88 ±  3%      -4.3       40.58        perf-profile.children.cycles-pp.cpu_startup_entry
     44.87 ±  3%      -4.3       40.57        perf-profile.children.cycles-pp.do_idle
     43.72 ±  3%      -4.2       39.52        perf-profile.children.cycles-pp.cpuidle_idle_call
     40.17 ±  4%      -4.1       36.03        perf-profile.children.cycles-pp.cpuidle_enter_state
     40.30 ±  4%      -4.1       36.18        perf-profile.children.cycles-pp.cpuidle_enter
     22.45 ±  4%      -1.7       20.71 ±  4%  perf-profile.children.cycles-pp.intel_idle
      3.44 ± 14%      -1.7        1.79 ± 16%  perf-profile.children.cycles-pp.poll_idle
      7.44 ±  7%      -1.6        5.84 ±  6%  perf-profile.children.cycles-pp.do_fsync
      7.43 ±  7%      -1.6        5.84 ±  6%  perf-profile.children.cycles-pp.ext4_sync_file
      7.01 ±  7%      -1.6        5.45 ±  6%  perf-profile.children.cycles-pp.__x64_sys_fdatasync
      7.07 ±  7%      -1.5        5.54 ±  6%  perf-profile.children.cycles-pp.fdatasync
      6.20 ±  7%      -1.5        4.74 ±  7%  perf-profile.children.cycles-pp.file_write_and_wait_range
      5.89 ±  8%      -1.3        4.54 ±  7%  perf-profile.children.cycles-pp.do_writepages
      5.87 ±  8%      -1.3        4.54 ±  7%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      5.87 ±  8%      -1.3        4.54 ±  7%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      5.86 ±  8%      -1.3        4.54 ±  7%  perf-profile.children.cycles-pp.ext4_writepages
      6.07 ±  9%      -0.9        5.19 ±  6%  perf-profile.children.cycles-pp.llseek
      3.42 ±  6%      -0.6        2.78 ±  6%  perf-profile.children.cycles-pp.mpage_map_and_submit_extent
      3.21 ±  5%      -0.6        2.64 ± 14%  perf-profile.children.cycles-pp.worker_thread
      3.42 ± 10%      -0.5        2.90 ±  9%  perf-profile.children.cycles-pp.handle_softirqs
      2.42 ±  6%      -0.5        1.96 ± 15%  perf-profile.children.cycles-pp.process_one_work
      2.09 ±  8%      -0.4        1.66 ±  9%  perf-profile.children.cycles-pp.mpage_map_and_submit_buffers
      0.34 ± 16%      -0.2        0.13 ± 55%  perf-profile.children.cycles-pp.mpage_process_page_bufs
      0.50 ± 23%      -0.2        0.33 ± 28%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.24 ± 31%      -0.1        0.13 ± 36%  perf-profile.children.cycles-pp.ext4_file_read_iter
      0.25 ± 20%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.khugepaged
      0.24 ± 17%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.24 ± 17%      -0.1        0.15 ±  8%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.23 ± 13%      -0.1        0.15 ± 12%  perf-profile.children.cycles-pp.collapse_huge_page
      0.17 ± 13%      -0.0        0.14 ±  7%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.07 ± 51%      +0.1        0.14 ± 27%  perf-profile.children.cycles-pp.tmigr_quick_check
      0.11 ± 48%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.00            +0.1        0.14 ± 41%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      0.12 ± 72%      +0.2        0.27 ± 19%  perf-profile.children.cycles-pp.inode_to_bdi
      0.13 ± 55%      +0.2        0.32 ± 25%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      0.01 ±223%      +0.2        0.21 ± 45%  perf-profile.children.cycles-pp.add_transaction_credits
      0.30 ± 42%      +0.2        0.50 ± 14%  perf-profile.children.cycles-pp.__find_get_block
      0.06 ± 75%      +0.2        0.27 ± 20%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.31 ± 41%      +0.2        0.54 ± 13%  perf-profile.children.cycles-pp.bdev_getblk
      0.03 ±145%      +0.2        0.28 ± 27%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      0.01 ±223%      +0.2        0.26 ± 27%  perf-profile.children.cycles-pp.stop_this_handle
      0.05 ±165%      +0.3        0.31 ± 13%  perf-profile.children.cycles-pp.ext4_inode_journal_mode
      0.00            +0.3        0.28 ± 26%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.37 ± 15%      +0.3        0.65 ± 23%  perf-profile.children.cycles-pp.__cond_resched
      0.14 ± 52%      +0.3        0.43 ± 18%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      0.00            +0.3        0.29 ± 33%  perf-profile.children.cycles-pp.folio_redirty_for_writepage
      0.36 ± 25%      +0.4        0.75 ± 10%  perf-profile.children.cycles-pp.filemap_get_entry
      0.10 ± 80%      +0.4        0.55 ±  9%  perf-profile.children.cycles-pp.jbd2_journal_stop
      0.00            +0.5        0.45 ± 18%  perf-profile.children.cycles-pp.jbd2_journal_file_inode
      0.10 ± 80%      +0.5        0.61 ± 11%  perf-profile.children.cycles-pp.__ext4_journal_stop
      0.22 ± 57%      +0.6        0.86 ± 27%  perf-profile.children.cycles-pp.__ext4_get_inode_loc
      0.22 ± 58%      +0.6        0.87 ± 27%  perf-profile.children.cycles-pp.ext4_get_inode_loc
      0.44 ± 27%      +0.7        1.10 ± 21%  perf-profile.children.cycles-pp.kjournald2
      0.44 ± 28%      +0.7        1.10 ± 21%  perf-profile.children.cycles-pp.jbd2_journal_commit_transaction
      0.05 ±103%      +0.7        0.72 ± 11%  perf-profile.children.cycles-pp.start_this_handle
      0.42 ± 15%      +0.8        1.18 ± 13%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      0.00            +0.8        0.78 ± 23%  perf-profile.children.cycles-pp.ext4_normal_submit_inode_data_buffers
      0.28 ± 41%      +1.0        1.23 ± 17%  perf-profile.children.cycles-pp.ext4_reserve_inode_write
      0.08 ± 74%      +1.0        1.04 ±  6%  perf-profile.children.cycles-pp.jbd2__journal_start
      0.26 ± 23%      +1.0        1.23 ±  5%  perf-profile.children.cycles-pp.ext4_inode_csum
      0.28 ± 19%      +1.0        1.32 ±  6%  perf-profile.children.cycles-pp.ext4_inode_csum_set
      3.99 ± 13%      +1.1        5.13 ±  6%  perf-profile.children.cycles-pp.__filemap_get_folio
      3.80 ± 18%      +1.2        4.95 ±  6%  perf-profile.children.cycles-pp.memset_orig
      3.80 ± 18%      +1.4        5.20 ±  5%  perf-profile.children.cycles-pp.zero_user_segments
      0.40 ± 19%      +1.6        1.96 ± 11%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      0.00            +1.8        1.80 ±  9%  perf-profile.children.cycles-pp.ext4_zero_partial_blocks
      0.55 ± 16%      +2.0        2.55 ±  7%  perf-profile.children.cycles-pp.ext4_do_update_inode
      0.58 ± 19%      +2.2        2.78 ±  6%  perf-profile.children.cycles-pp.ext4_mark_iloc_dirty
      0.85 ± 16%      +3.2        4.03 ±  4%  perf-profile.children.cycles-pp.__ext4_mark_inode_dirty
      0.00            +3.6        3.61 ±  9%  perf-profile.children.cycles-pp.__ext4_block_zero_page_range
     38.33 ±  4%      +5.5       43.88 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     38.13 ±  4%      +5.6       43.69 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     43.79 ±  4%      +5.7       49.45        perf-profile.children.cycles-pp.stress_metamix
     13.98 ± 10%      +8.6       22.61 ±  3%  perf-profile.children.cycles-pp.generic_perform_write
     14.57 ± 10%      +8.8       23.33 ±  2%  perf-profile.children.cycles-pp.ext4_buffered_write_iter
     15.14 ±  9%      +8.8       23.92 ±  2%  perf-profile.children.cycles-pp.vfs_write
     15.35 ±  9%      +8.8       24.15 ±  2%  perf-profile.children.cycles-pp.ksys_write
     18.28 ±  9%      +8.8       27.11 ±  2%  perf-profile.children.cycles-pp.write
      0.00           +10.0       10.04 ±  6%  perf-profile.children.cycles-pp.ext4_da_do_write_end
     22.43 ±  4%      -1.7       20.71 ±  4%  perf-profile.self.cycles-pp.intel_idle
      3.24 ± 15%      -1.6        1.69 ± 18%  perf-profile.self.cycles-pp.poll_idle
      0.34 ± 16%      -0.2        0.13 ± 53%  perf-profile.self.cycles-pp.mpage_process_page_bufs
      0.50 ± 23%      -0.2        0.33 ± 28%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.24 ± 31%      -0.1        0.12 ± 30%  perf-profile.self.cycles-pp.ext4_file_read_iter
      0.01 ±223%      +0.1        0.10 ± 33%  perf-profile.self.cycles-pp.mmap_region
      0.00            +0.1        0.11 ± 34%  perf-profile.self.cycles-pp.jbd2_journal_dirty_metadata
      0.01 ±223%      +0.1        0.15 ± 55%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      0.10 ± 85%      +0.1        0.24 ± 20%  perf-profile.self.cycles-pp.inode_to_bdi
      0.00            +0.1        0.14 ± 32%  perf-profile.self.cycles-pp.jbd2__journal_start
      0.00            +0.1        0.14 ± 25%  perf-profile.self.cycles-pp.jbd2_journal_file_inode
      0.18 ± 43%      +0.2        0.34 ± 11%  perf-profile.self.cycles-pp.__cond_resched
      0.05 ±102%      +0.2        0.22 ± 26%  perf-profile.self.cycles-pp.ext4_do_update_inode
      0.07 ± 78%      +0.2        0.24 ± 43%  perf-profile.self.cycles-pp.__ext4_get_inode_loc
      0.06 ± 75%      +0.2        0.24 ± 33%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.00            +0.2        0.18 ± 43%  perf-profile.self.cycles-pp.ext4_da_do_write_end
      0.00            +0.2        0.19 ± 38%  perf-profile.self.cycles-pp.ext4_mark_iloc_dirty
      0.03 ±142%      +0.2        0.22 ± 32%  perf-profile.self.cycles-pp.ext4_inode_csum
      0.00            +0.2        0.20 ± 45%  perf-profile.self.cycles-pp.add_transaction_credits
      0.00            +0.2        0.20 ± 38%  perf-profile.self.cycles-pp.__ext4_block_zero_page_range
      0.00            +0.2        0.21 ± 37%  perf-profile.self.cycles-pp.stop_this_handle
      0.71 ± 19%      +0.2        0.93 ± 15%  perf-profile.self.cycles-pp._raw_spin_lock
      0.10 ± 55%      +0.2        0.34 ±  9%  perf-profile.self.cycles-pp.filemap_get_entry
      0.05 ±165%      +0.2        0.29 ± 12%  perf-profile.self.cycles-pp.ext4_inode_journal_mode
      0.07 ± 50%      +0.3        0.34 ± 32%  perf-profile.self.cycles-pp.zero_user_segments
      0.00            +0.3        0.34 ±  7%  perf-profile.self.cycles-pp.start_this_handle
      0.05 ±103%      +0.5        0.50 ± 24%  perf-profile.self.cycles-pp.ext4_fill_raw_inode
      0.19 ± 19%      +0.7        0.89 ±  9%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


