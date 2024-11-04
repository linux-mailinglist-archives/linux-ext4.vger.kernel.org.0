Return-Path: <linux-ext4+bounces-4933-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FF99BACB3
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 07:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76799281F3D
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0518D63C;
	Mon,  4 Nov 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PASAqcOb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9A38F97;
	Mon,  4 Nov 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702628; cv=fail; b=KIyn4JV23fKLMiOmFRv+n2vep6ppqw6Q5J2FdgEwXa22d3XMak94VpP42PigVnmG0VuHQUvpVrRboU5GuhPkh/tpwJHCOvCsJHKBC7HCJe4hIhRQhpIAExr8RJfjzKtG9tVdoaKZkhg3AlNJUJmKkTc3r4eFzUKAGgMAmqoWfNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702628; c=relaxed/simple;
	bh=qKi8kdv/ZhIChBC5qO18TW91vWnWOElgLjw1n+ZLSR8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VuMYemVPL17VuazRYpNjzCw3PI+f7fv2us3bDnVWVqS6BIRmEij1XZc01mkUDjy/KjgBU+9NB4vJM2S9iklxTV2O01zY2abejzj7XMH/l7qZol8CX7muYTHnSMKIDPN/3X7MW8W99P7y2Y7NCR0DeI2Fpn54K1Q4XpbeZT4NEHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PASAqcOb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730702626; x=1762238626;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=qKi8kdv/ZhIChBC5qO18TW91vWnWOElgLjw1n+ZLSR8=;
  b=PASAqcObofM9xI8mMb04WeUWHV4UY1wepRBnDfFXDh4r89uH3KJ4vQMp
   Ux5N11SLps1YAb1/Uot7LpSGmsgjI2JpYmXW52HQzXkyJ5py0JYrQlgk2
   Mp7EGsSYcbrb3SsivOrasqrkb1zs12XY6cUsh+U/6DeOkhLOhdVuYxkwB
   TrAoOCIO/B3RKciiCllpBjhhA1+VpXqo7i6CfRc3LAtgdN+ASXcsJwtUO
   6MUpfkOuF27ZHbcBwuNCZpdB0yXvUYob+JVcQT4/6/v0DzQJcBB5Dz5mz
   yC7YLS8BxT4mfB8qI265fv8kBy2C8e0nWWvbZ5V/1WPsvDZfOxzNpU4IH
   w==;
X-CSE-ConnectionGUID: KRdlKYbDRTCnwKiGA9MzwA==
X-CSE-MsgGUID: ZqKUA93kTpyaKqB6iTUHqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="47892279"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="47892279"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:43:46 -0800
X-CSE-ConnectionGUID: qt/uTcgeQ12iM9su7xwcUQ==
X-CSE-MsgGUID: eLPPjrBHQvG817GWiCBYcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88073900"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2024 22:43:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 22:43:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 22:43:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 22:43:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+f65NRZPinJFAu8xgzF7aMNCMsS1hvfFEw0angENZH41U+KWR1UMGi/gGoLpsAzI6sMoJQXK+FUa7eEyTOGfb6cagFPmtBznfNA6jynVF5y1QMmv0eQlqMLO/O/QERbvYAk4QImUIbu13ldAYugQgiW4jmgR2ertiZUIEyGkP4VVxhsIjWPA0vxm+pbe1NcPng4Ok4LD1Wsl8+RXLDKDHqExM6Vjcyu+LCga+lBYuPa5yRCwhrgpUhyqT04iffv99FSAEZk8A2GLOEcNpHUc9njY60e2Szi59idA+TdnYpD9cAVpDiDQjzbg18lB1eWDT6sZNzbpABVdev99UO0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfjS/K6iKF/1hiCkhaeUr99rP3I8ImamrPpKUBMUALY=;
 b=o4Na9WL7cHPqUacJ4ksk0WWP78z705253MM2LuklCeHHRzwZwaA0Je74+G3ZrAkNB7+Q02JSjriJ8Wt40HH0FW65U9WxUgidaM+O8QabcF9Apvt2mCxx98bm0eSuRgo8mrvc8faW2Mn6QXHdXxWeiksL4ZzsVL1TRQxjKvzFm26luu/dTGWyV88Q1qkIFSZ85Rm/keIlMZq77bXRDWjm5vpGRHGdJD9yKeuD0IMNGK0OkPqD3cvuZrwY12QdLyD1ZzNLGQ4YknDuQOtT0RKlAaIMCeYJXPCug/G3SxWRiJGgnfUGd2jYBZBgTNbl0bc5bEi4Y9kjd7ybXz9JRAo1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 06:43:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 06:43:42 +0000
Date: Mon, 4 Nov 2024 14:43:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Edward Adam Davis <eadavis@qq.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-ext4@vger.kernel.org>,
	<adilger.kernel@dilger.ca>, <eadavis@qq.com>, <linux-kernel@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>,
	<syzbot+0c99c3f90699936c1e77@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>, <oliver.sang@intel.com>
Subject: Re: [PATCH V2] ext4: Add a sanity check for next dentry when insert
Message-ID: <202411041103.a030928c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_2EB5A7DB06DD92D88651C9B3EED8AEF38C06@qq.com>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a125592-f626-4aef-a69e-08dcfc9c057c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?36DxE862JoiPyGY5+L1l03DIOC7ItcvWdsVOFzXIN/EEgvXCZQ7ADi9v6yIC?=
 =?us-ascii?Q?cqugop1Y0o9IJjaJte+BnNf8elczfnass7i+dWXYNG/bzMdJCrpu0+4Ramvq?=
 =?us-ascii?Q?bIjt5TEZt9wCgDrDONF2QSb5EAfHkhbOY0hlM2xlhQMeeGdfq629gS/xOBuX?=
 =?us-ascii?Q?bDk+6fykGj3X2UzIloRYz3EAu6hFu+mxlGzxEq06mhewlAHH/4mJRG8wdLM8?=
 =?us-ascii?Q?mk5u4V30i6IS4sGdyzwbppR5NnF2QaLJMz/8jrnJdoYc6DfbXMjfRTiOIu/1?=
 =?us-ascii?Q?uJifo/ozeKbQbbJeY6DJbmXxOnp/6Ijra/cqqtzPamV/gxYX8wamf1JJWc+E?=
 =?us-ascii?Q?L5aG+Bc0wmzvLj+33S4W6gJRmBO+yrWhZC/+OElsV6doh0EYmK7MWrvFKPRa?=
 =?us-ascii?Q?3oAHfJXUICYKsjdgqy+UAR+m2XbZ1UJX/2+VsQcNAo7FYA2IkhRwXZInKjFy?=
 =?us-ascii?Q?6w64eGJL/6JQYvNuEOw78tPo15t3vcF0wnrfni/a0YMh9DEjx0mEr0zuyjH3?=
 =?us-ascii?Q?yZekL3CnTTH1Bcozw9vGjsrPAohwhXspZ+goMlECoV/sBej+2y+sT6KOT/WL?=
 =?us-ascii?Q?u8DpFb5Tzq/zN0X17bPJN6dy6cspMf1eEzkOVRw5UFBJL5pc2HbnPheojbD1?=
 =?us-ascii?Q?nmbfH9y4FyJ2gFMjEFAihy1c6Vs1r9ta384+RBZ4z0cw5kDu01NYKph7r8WU?=
 =?us-ascii?Q?FXOPMLRulw+/p5tvo6hWrNzR+xMYPaYPlqoxE303ERmFAZYkpjXah90YdF81?=
 =?us-ascii?Q?vz/qO44xZ/zMYqPtdd/9Cn7VhZOL+d8YF2h6P7aq4z6UgYsoukUit8CUZ6Aq?=
 =?us-ascii?Q?bthDuO0Ra92w7AykInxaFYv8LSwyMzOp7pFuE1I3LEUnl7gDw6tkttD8Pl+D?=
 =?us-ascii?Q?QOLRz/xn5dDZJ2JAVVkQfq8UrdmbY0xWthoQaBpUQSwAB1RIViseScEU91nI?=
 =?us-ascii?Q?2xy8nFxMeVUUKKg8P5gN4fjTkjwNsiTM0kGCQk9bwkixHC8Dnfn+BeVyAxg2?=
 =?us-ascii?Q?Nv6LpoJDdATzB+iZKLFink4HWeYUeD1Wlr1E27KcZqs3t2VNR5wYyPrVf2r1?=
 =?us-ascii?Q?/3NuQpQ9KYKtJlIwl1t3LDw6o5kkMVUmnF1xhl7k5HqbpxeVDa5badApqLBo?=
 =?us-ascii?Q?XGs+RyHG0wvNjlekguKNIOnOrwls371HhiDW4b2O+rz+Y4lXBO5xmsJ+bSeQ?=
 =?us-ascii?Q?X5BnzXP/7dqlIgNEGG0m1CXdCy3gRmCMbnSplkTNM5RKcQC66/H1QsU1oM7l?=
 =?us-ascii?Q?rW8B5KdrRR20DuSkNLA35PQhprEmHARTzuWkFKZX8w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6JcP5TrGO7v8EqSm14/gpMuDcOAmvTLTe26UY9e2gldRcgCHHvv3maF8iSQn?=
 =?us-ascii?Q?BrgU+YWYST6zer9MI+kY9HFdqt/5+9D+i5k67+sFkLaEbvvdIH4PsYfzmtu9?=
 =?us-ascii?Q?JgBxZibvIpq7NRFm9znKJl77EtVvju1NY2jTfzKaO6KmpDhxMX0lZ5VqEuxb?=
 =?us-ascii?Q?QOcVJdryQu7y4wQ0ISP3o+W+Kh7uStZuxxfYqjnLrEz4yNO9CqUxTa3bThn3?=
 =?us-ascii?Q?eImInuIfp+/oStlP81T5HM1bEqLe2iosYQxWFjTvXvBKtv702Cjyn1tlw8b0?=
 =?us-ascii?Q?wxZU5cCO2s3QO0JSGe8+Q44fqnJn+F7tbr8K86BbjMjCbVx6HTpdwdA3eUAX?=
 =?us-ascii?Q?r3ruY4oer+oWiRb2GaJ+VlchePIobST2n9nSWa6Esv4JeCDw8HdzuQDmlVKz?=
 =?us-ascii?Q?EAufZ0VjL4GFywvKwSqonVXIK+iLELhcV6XdHlHEZWohcrS1qkbi4ndpDLY+?=
 =?us-ascii?Q?NqOHiwg/Lifz3jPqd2bqYzcSumyW+KTxX9CsJ1ocF6u96E51eiijest3zrHC?=
 =?us-ascii?Q?XPtRlsSm5PjwzoNCtyijilVar+3SIrKCPPn6G9AOYeljDWzsFkGicdBwMPjK?=
 =?us-ascii?Q?YI/QebIxHks8WMKKUdlJr944iMdapRu6MUsPom/DLByp2BCqIIPK2Bz2/hqD?=
 =?us-ascii?Q?185pD6k+89CAwa91exOvMq7LTZyBzsWzWeaOWWvcXwAGZ53OvMEBsXENQTua?=
 =?us-ascii?Q?y7rL85v4IRQXZ8Wbw9Y0fV0BUoY7YApCjdzSBb9vM/fj0gaMfoTa2w7rdvab?=
 =?us-ascii?Q?U0/Nek7uOvh2ej+dtpLnNGa3z/WjwRRAUwmls1lpT/F+xkC2S6zakAsZ0ook?=
 =?us-ascii?Q?3DE6x/azjMA7/smr7NQZCrR7hncA/E1dhrtPrG49KjzhXosaLa1Ht0IfhjEE?=
 =?us-ascii?Q?ZZZsMjQc0B2qyMeP2EZI1CViUkWfhSMySDYx9zgfiZT70Ef4pZ47GlleRl7B?=
 =?us-ascii?Q?0I2kof1DK/+zy0eOntoHaCXyv0vO3XK1+1UN5iT30yf9eIVJBJhJMH7gCgT4?=
 =?us-ascii?Q?eEyR0xdV9Cp6xloax6wsK6IAkafB5usiy/PNcOFSEyOVthJgR0eB9oLl3mbJ?=
 =?us-ascii?Q?bIOGqEeSl0jOTUALPG4UILVTz7oekjq+nzaDBj/B8oKLqMdf4sqrWAncXxWs?=
 =?us-ascii?Q?U+ayA7EnXy0KcUQjc9GKN5omLeURb4h5oGo00jCcFbqPjrHGH6Q9l39mobxw?=
 =?us-ascii?Q?ubRF3J1ee3SMC23HeptTRqAttUzYKe9KF2fYGyxR/5EY+gXEpgWO4r1JeoY7?=
 =?us-ascii?Q?JsJTLTe7uJZ0Mj3nzRy4iESnxICO5X88htNLs4OTY/uxE1wqlI9hDVmWoG8r?=
 =?us-ascii?Q?5kuFb/ky8LSKVbww3Id3ksyJg8splogxvokWOW+2+Y+XXbiuxkZLoSQN5nNC?=
 =?us-ascii?Q?Jz23ASa4sGKixm+hRkImeGmzWkpkAqpKiYyIoua0DwekQolBmzGSq6+xTkV0?=
 =?us-ascii?Q?I40KFiiSNeXS0sxrobhgGOa+foSBCemRgZCCsqcbCszrBBD4FUMqc2L8m3z3?=
 =?us-ascii?Q?t4F9/UZxtVboj5PbC+u6w3KxTWh3Jz61ZSO1AjoSzvPQwTJIJuCTpppHosDI?=
 =?us-ascii?Q?OI0P6REnU7W1zghfYfQmePdkeCfdzwaEqyEu6BRc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a125592-f626-4aef-a69e-08dcfc9c057c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 06:43:42.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JKlqWS9iylCuJcBWLQnqLv+wF0q9bklwPGfqBx1n2K2xsGdFirWbfVilqD8sPPOgVQoypYBpWpMobbKwyVnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.080.fail" on:

commit: d29093707e013ca381d404c4444413df49c719c1 ("[PATCH V2] ext4: Add a sanity check for next dentry when insert")
url: https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/ext4-Add-a-sanity-check-for-next-dentry-when-insert/20241028-220910
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/tencent_2EB5A7DB06DD92D88651C9B3EED8AEF38C06@qq.com/
patch subject: [PATCH V2] ext4: Add a sanity check for next dentry when insert

in testcase: xfstests
version: xfstests-x86_64-891f4995-1_20241028
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-080



config: x86_64-rhel-8.3-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411041103.a030928c-oliver.sang@intel.com

2024-10-31 17:45:57 mount /dev/sda1 /fs/sda1
2024-10-31 17:45:58 mkdir -p /smbv2//cifs/sda1
2024-10-31 17:45:58 export FSTYP=cifs
2024-10-31 17:45:58 export TEST_DEV=//localhost/fs/sda1
2024-10-31 17:45:58 export TEST_DIR=/smbv2//cifs/sda1
2024-10-31 17:45:58 export CIFS_MOUNT_OPTIONS=-ousername=root,password=pass,noperm,vers=2.0,mfsymlinks,actimeo=0
2024-10-31 17:45:58 echo generic/080
2024-10-31 17:45:58 ./check -E tests/cifs/exclude.incompatible-smb2.txt -E tests/cifs/exclude.very-slow.txt generic/080
FSTYP         -- cifs
PLATFORM      -- Linux/x86_64 lkp-skl-d05 6.12.0-rc1-00004-gd29093707e01 #1 SMP PREEMPT_DYNAMIC Wed Oct 30 22:27:17 CST 2024

generic/080       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/080.out.bad)
    --- tests/generic/080.out	2024-10-28 16:28:46.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/080.out.bad	2024-10-31 17:46:01.599410948 +0000
    @@ -1,2 +1,3 @@
     QA output created by 080
     Silence is golden.
    +rm: cannot remove '/smbv2/cifs/sda1/mmap_mtime_testfile': Permission denied
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/080.out /lkp/benchmarks/xfstests/results//generic/080.out.bad'  to see the entire diff)
Ran: generic/080
Failures: generic/080
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241104/202411041103.a030928c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


