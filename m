Return-Path: <linux-ext4+bounces-3247-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED3930A6D
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79551B211B0
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jul 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55691E886;
	Sun, 14 Jul 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbRMq5Wp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837FBA55
	for <linux-ext4@vger.kernel.org>; Sun, 14 Jul 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720968616; cv=fail; b=jrr+i1y8bYVBo7ozjxoXFhJaqt/5EXdEGhO8GwwHXkenrnOisZaGfYRxTurVOeJshVhkLLfErziNwkDj/A7tD5ahZ+FksGn0mS4+Qs+EMT23k9hL5d/IWef1vZkAHSl1SnsnKAW0+EoYatOV2lefPXNmFZGsYqI9QAcouFKVIdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720968616; c=relaxed/simple;
	bh=KDzkbBbeVNQFAtC4uwHZ/cRFC45NCPUA9NMZZ1GQ5BE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=cuk/LZEWB1mbcOE6TSQ9hwBR6bF+6sMcjaucSjrniDnZrOP6+HxIwq2NL5oBYvuFwc1WtpuXzSM0c+itVFG1urh4EuWo5NsPMqwiminb28deC8mO7m+TrmocMo7H25fYY6ATkkmQDRhIJf3Vh85Qf+YagNkGm+3tnHNqbqjpdjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbRMq5Wp; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720968614; x=1752504614;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=KDzkbBbeVNQFAtC4uwHZ/cRFC45NCPUA9NMZZ1GQ5BE=;
  b=JbRMq5WppDUQCuj4UTKTbJJBgajlztUfPUzeAoKi/VCJcbsNOX8Tsi+C
   O/hjhRoeAZbeu2GjJ4YVd44qwUGszIJeDQ0IDY+gWPphJM4nwuGsvaqSM
   Ua42FY3O09TXjzhOEZz0ABYrCYuZPQ+6X7BfZ8/oz0bCKdJQkcgM6+JgC
   ekM/m7tRN4yAt02lqdCzQtIEKITQNlpYK5Te9spoWwxKwSETQd2win0Tl
   rhBBmOY4+AmvK6TKCRtlCGw+yKQl3ph80gUZJiEWHbZgvN4nNlRYD3S/Y
   E0tsCNjGBWesqxhkFPNGA6ggAAz7ImVN2/lrdXtZd447pjeSdrJERarDD
   g==;
X-CSE-ConnectionGUID: 1ZeH9bfKTNa5bMIKBntmvA==
X-CSE-MsgGUID: UiRvmNKATXmsbKKsVoN+qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="17967481"
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="17967481"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 07:50:14 -0700
X-CSE-ConnectionGUID: /bmjidhiQSy2CryFVpDkew==
X-CSE-MsgGUID: +UoGHf77ShaBkIUAR2ks6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,208,1716274800"; 
   d="scan'208";a="49328826"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jul 2024 07:50:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 07:50:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 14 Jul 2024 07:50:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 14 Jul 2024 07:50:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 14 Jul 2024 07:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPSc7WfHy9ciANwygWLdclWLKpkBuiyhZTJbeYOubtro9TPrZCrWKG9q0KQmXMkYVwE6HDJGXq0X6caWVlBWBgpcoTFtrK7E25/LWKld3q6tb7/YuetWbjb6Z0bF/Rx8YAy0WyBXe8dBxxKZN46ogM8RrPhbtRFscSv8dqHjkHFBn2m9zgs/qDK5xkKz1qrEVFFQxwsZ1IaMDPLAMZS3DY+eHAeQ52dyiyedDkkrkCpiPyW11cd7kYyh55Ut1KHSLT/wN89UHwELr5UxyDAxMA+2YvPqQZgBl64A/5IaGe0zmZPUljG9NAidRlR57QXEHUnaz2RROpFl24tmEKN2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnn/ebRY2zyN9w594udaAfALKlWzu8Lz+5Ewv7dTYrc=;
 b=BPV1GZQV4+AQzqXDAwR3g3YR1rt3kK2ehxtWYXNnEbI6DPWem7Ib356GOWrf+xrwTxmv61BLAE7ZgsgJEH1VkiA08YHbXsOaniLWyk8iacswuYbqZYkU9xin9MnlFUDG8VCTcjfgD0FOJpix0SCcZXM14Qk+X3+gxo8aNdqLX500X/spLR6EMI5DimuuMwErVqQckSBMHh2GgO3R3EeuXy0XAi2KszNEUklhdsdzNDUnCbwonIPrsw8uvt9Z8+RZ6kXHoE2Ys035uiOYhw0/BwQBP+H1ahKpbnD2i2qgpx2jexzMCHE9+iFSuWOgvjES4gLCq/KfPZqDlSLkwxqy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6935.namprd11.prod.outlook.com (2603:10b6:303:228::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Sun, 14 Jul
 2024 14:50:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Sun, 14 Jul 2024
 14:50:07 +0000
Date: Sun, 14 Jul 2024 22:49:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zhang Yi <yi.zhang@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>, Jan Kara
	<jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [tytso-ext4:dev] [jbd2]  7c73ddb758:  stress-ng.fiemap.ops_per_sec
 565.3% improvement
Message-ID: <202407142212.5595ea54-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e237367-b4e0-4ab2-9628-08dca41440ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?OY162dKuO4auFNIWnKOPvK6MocgOZu6cCj1+7Nc2yJwIRhizZWKEy1ttom?=
 =?iso-8859-1?Q?GR4QXEUYhAsjX3Yr65rIh8tmqp+NBGcqBpyFFkWKOLFsVg4xx/qC9nxFzi?=
 =?iso-8859-1?Q?vtz7QOOwXs4N/vscMHDax6iV1dsaYZitqscr3myzE6kXxZQ/Wlu7sgLzxf?=
 =?iso-8859-1?Q?UEIoiQt3Fymaew+TiT7uyidTDhQ7Cx+YbErrsLYgY3BJgwp0CTdIMHOexy?=
 =?iso-8859-1?Q?IMG81KZ9Mze6dkp6fJk/5w3oCahWtLcs8NioGRoJFYyXqVhfeTY9lAXoMj?=
 =?iso-8859-1?Q?GHBnlhVPcOXBRE+gdlU/Z6ZcrNUKBKbN8MyreaXi8JXdrR0XT6TPqpDFHC?=
 =?iso-8859-1?Q?oA5oSwfRUBR12OyVOnRvFi/FQEIy0b0G99zBOkZvzYNpqrJlsOzDtSZFXU?=
 =?iso-8859-1?Q?r26ygj7HBb2ibXH0y5tpdKlgXbjDSkgVZEEtoYhc7hNKEdSqjq/UKlW8ZE?=
 =?iso-8859-1?Q?/ExxP/fs279LcMALsTbyq4402po3ejGP7Tjd+FCeXw+JnA4kIhe+GTK4ho?=
 =?iso-8859-1?Q?V5utyDA6eFr0ge/i2Q1/KawDZzWkhPn4p7Xe1vRAIirHsLVpDfrMar92LB?=
 =?iso-8859-1?Q?FgE+4s9sUhTM6hdLv9IpUel1R+9FxX/oiZD/293Mj7WA6X4dvSk+u7KYUk?=
 =?iso-8859-1?Q?+4fk9d7+RXQev+LctGjR+lk8WgqFtI/NhtR3s4HUOlVzJWGumTc9f8BE2D?=
 =?iso-8859-1?Q?s19IK8yRQHS9/7j65OVrIRRB56UYJFRu74YHeJ1/0QkfaeqSplonJ2i2H1?=
 =?iso-8859-1?Q?fYnv851ChNAcN6q/xT5Q46cL2S4ISsJaa/hrBesTlmeiBz8WtK4fLpK6SF?=
 =?iso-8859-1?Q?3GMhro/DxEhyvT3hhjK9/3PSVHwMtYGNdgq77Gvh+ODrP9jbCiBFFZYRK/?=
 =?iso-8859-1?Q?H+Z9UOv07WF0MEfOU4oo3Ui5p8YFqhoHrQIqbfzXIx2N5lWVGYkgnuX5eH?=
 =?iso-8859-1?Q?CkWNi7wSMpp++xIMqVrFKOOAaw3o9seRVni27+2sR+kXxiI1yo5qd80q6i?=
 =?iso-8859-1?Q?5o2z80MyBlNmWyN8HeX7bwaJcuXBx05kZGbJtANey/S6jEqSJvUHLrq+8z?=
 =?iso-8859-1?Q?w7ZThzcOa4loX93rOuuR4KKJmp3CWylM2YTLGxxp+AKbxRvMYa2wVG2x/c?=
 =?iso-8859-1?Q?QZr/Tl8cvrAeB1+21M5LkPtHhZJwQZ/JCe1r9q3NFCduJzhRYDlnuVkDqK?=
 =?iso-8859-1?Q?GJt6V226iVNMvoAV9TsjhswFImSd9ZoSaRzRq4WDwdH3MoXmmC9bDHoEj0?=
 =?iso-8859-1?Q?AD13JePay/CIH04MkMziFo7xwETWFCxwVlTjVXoPjwYx+Q6buyY8jsBY/u?=
 =?iso-8859-1?Q?R7e/lqvoPQvoyli56o7k7u0ReF5SXLWVUYEfG7USr70JS3MunddWYCv623?=
 =?iso-8859-1?Q?IZ2I5HadHs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PdPBz8+nPrxunYd/EfVfOEhFf/uVufGinPbz1eVr72UXuzdZcvPyZNDf5D?=
 =?iso-8859-1?Q?Ma8XCFgTVn5+2RFpRED5AUMRx2wthl9TVptTSCKSXkhZsx/8AprsRe7tsl?=
 =?iso-8859-1?Q?Aq9zVTP2V8fAa94dxoUVnkn4RgtiiASDWS1lpQAgfQbMew8ibzn8f+4yn5?=
 =?iso-8859-1?Q?m2HWBiMIfZHjK7sZtTEWELvE7ZYnVP+36AV+t8eXfyt8ug2ACe35yZDnIh?=
 =?iso-8859-1?Q?iB82s9EpEMAZnQ9yAz/y74Gq73BUN6slAha5+UkgIfFeWbcw6xFkAuDZcg?=
 =?iso-8859-1?Q?J6CdCWvc7szgZBl4OUxQTxlqXpa+naX0RrmuVdurSPOCHlLBS5+i8O0Zsl?=
 =?iso-8859-1?Q?oneahLe0r+B4iO/SSQZadI5hmkImToet93qv1ADrdr4BFGc1PpwRBZpwH9?=
 =?iso-8859-1?Q?3klfFDq3W2b3ypOhJc2W94I3RVMFZzcaJEK3HJyVJV50SiX8xjlzIBrAyo?=
 =?iso-8859-1?Q?KfXFfjxozyu0bdqOL3TvpJNYA+IYIrNHbVtaYg9lL82M1M01Xj60ZStxfU?=
 =?iso-8859-1?Q?f4EvnOZzuVPbuv4JLT2fyL/KSKoJ3E7LBo6+C4u2HFKgSTBr+7SmcJiz+t?=
 =?iso-8859-1?Q?YXqGWHEfq8d/Hm3J2UV6hYFhIaMfmDs5XQDS+5ms8EZRtr9Pkccsq9OVkG?=
 =?iso-8859-1?Q?r4BzvwtoB6OVoOgo5F7+goEQ28jvqItsKRVPtO4A3On1nF3V+v3qM7U6dE?=
 =?iso-8859-1?Q?p1jyxPWG/KxtoewVtGuThlk3/UsaxIXsP3Stwf9S/rqk/uLVCcNnEV3xjl?=
 =?iso-8859-1?Q?+5AmHsQ5IhsU+VkK/v5e9IOfyX7ha7Q+JbMB7IxOK9fKSKxyk755sBcKTD?=
 =?iso-8859-1?Q?g36uhgVro747b87vPWFmxuQxOqZqPlFNLx2kfrNDqW90K5CuZsb9E3Dp3U?=
 =?iso-8859-1?Q?ejOGYMkA4lFlQKXQJzfaKELWK0D//reMohMHY/XPYXZHiaSPgTSAlkTO3M?=
 =?iso-8859-1?Q?/FFHVTelOPQdjCk+w6Sp+JoZtUeMLDrQwc/SHFc8aLjvpYMyCL845Q5nVk?=
 =?iso-8859-1?Q?8kfo9ZT5M8E48PJabzoBaERoLPh6RbS84jeCTRhc+Qz84RoHYjlYf5alFo?=
 =?iso-8859-1?Q?4O7Pb34ccvNjipBeEgT5Izqpbbl6Mdq607r1AsiFLTX37eF0njsYHxnjUW?=
 =?iso-8859-1?Q?6bHBGcYZZjwP6z7aXmkG4MAQE8aiJWm8qZqn5SCM0qWS0xDzLR6K9GNGBT?=
 =?iso-8859-1?Q?guzd7GG2a8OqbHicNGEqByr32fZ90HuFG/8t6dWkx94vLPpr9jiaKYPN59?=
 =?iso-8859-1?Q?iM3afnGkVCs078OsO+FMfjZUmAKMZSrSKdZRCSrbSMMBZy3Ft/EZvdmiok?=
 =?iso-8859-1?Q?bogZi7UqaL2kcW37HuAkCIkibQNCu91tslrazbRpi2zcQu6EE02Keo5VgZ?=
 =?iso-8859-1?Q?qYtS8xlF4ckEF0kFbmKckfZvtoxRgeTHQ7tkAcHTgChJANdVk+bXd6ysle?=
 =?iso-8859-1?Q?RrIB5XRmLWJqJljmFADmIfL6LkDK44LQbOigJlFCSmTTvwZKKdqTIOviJx?=
 =?iso-8859-1?Q?kbDYcFw1jieojzFqi4U1mIRxymut1k28iKKbcTjF2P9vpyYle+wcyVct7r?=
 =?iso-8859-1?Q?pzQhzgYBqcXoEQouStfYL4EvuNfJmzt+TTLAF4OhhPU79Qq+1ZpBYoIxEJ?=
 =?iso-8859-1?Q?EIEqcAkTzfeDwXHNW7G3qgJOP5uboHyzXxca5u2dZPxUBGo1sdodDuPA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e237367-b4e0-4ab2-9628-08dca41440ba
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 14:50:07.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYUGE6OpZjo+Mnm08Q4I6bbIdrYK2bBNMdgCn4F8bvfE3BVCAB7N6MG8Pf8HZwUTK8M5DXQdXlxYG38vm2RE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6935
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 565.3% improvement of stress-ng.fiemap.ops_per_sec on:


commit: 7c73ddb7589fb8ddb1136b6306dfb72089c81511 ("jbd2: speed up jbd2_transaction_committed()")
https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: fiemap
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240714/202407142212.5595ea54-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-13/performance/1HDD/ext4/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fiemap/stress-ng/60s

commit: 
  8262fe9a90 ("ext4: make ext4_da_map_blocks() buffer_head unaware")
  7c73ddb758 ("jbd2: speed up jbd2_transaction_committed()")

8262fe9a902c8a7b 7c73ddb7589fb8ddb1136b6306d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.651e+08 ± 27%     -31.9%  1.125e+08 ±  6%  cpuidle..time
      1.15 ± 10%     +39.7%       1.61 ±  2%  iostat.cpu.user
    364499 ± 18%     +93.2%     704285 ± 21%  numa-numastat.node1.local_node
    391444 ± 13%     +87.0%     731983 ± 19%  numa-numastat.node1.numa_hit
      0.01 ± 93%      +0.0        0.04 ± 42%  mpstat.cpu.all.iowait%
      0.02 ± 11%      -0.0        0.01 ± 10%  mpstat.cpu.all.soft%
      1.17 ± 10%      +0.5        1.63 ±  2%  mpstat.cpu.all.usr%
      7.49 ± 26%    +150.8%      18.78 ±  5%  vmstat.procs.b
    206521 ± 17%    +533.8%    1309000 ±  2%  vmstat.system.cs
    161690 ±  3%      +9.7%     177423        vmstat.system.in
    295.83 ± 41%     +89.5%     560.50 ± 13%  perf-c2c.DRAM.local
      2738 ± 54%    +302.1%      11011 ± 22%  perf-c2c.DRAM.remote
     19455 ± 26%    +159.8%      50553 ±  3%  perf-c2c.HITM.local
      2088 ± 64%    +341.3%       9214 ± 25%  perf-c2c.HITM.remote
     21543 ± 28%    +177.4%      59768 ±  4%  perf-c2c.HITM.total
   7686439 ± 19%    +567.4%   51297323 ±  2%  stress-ng.fiemap.ops
    127116 ± 19%    +565.3%     845744 ±  2%  stress-ng.fiemap.ops_per_sec
  13124477 ± 16%    +538.2%   83760706 ±  2%  stress-ng.time.involuntary_context_switches
     16.98 ±  4%    +123.7%      37.98 ±  2%  stress-ng.time.user_time
     68650 ±  2%     +21.2%      83171 ±  6%  stress-ng.time.voluntary_context_switches
   3772338           +32.7%    5006703        meminfo.Cached
   3979639           +32.0%    5253874        meminfo.Committed_AS
   1184714 ± 10%     +70.1%    2014850 ± 15%  meminfo.Inactive
   1149048 ± 10%     +72.2%    1978594 ± 15%  meminfo.Inactive(anon)
    376153 ± 24%    +148.7%     935654 ± 15%  meminfo.Mapped
   5932787           +22.2%    7248581        meminfo.Memused
    564523 ±  7%    +218.2%    1796085        meminfo.Shmem
   5998794           +21.5%    7289549        meminfo.max_used_kB
    816342 ±130%    +203.1%    2474499 ± 40%  numa-meminfo.node0.FilePages
   1933517 ± 56%     +86.2%    3599441 ± 31%  numa-meminfo.node0.MemUsed
    205709 ± 33%    +120.9%     454343 ± 43%  numa-meminfo.node1.Active
    196984 ± 34%    +126.3%     445786 ± 45%  numa-meminfo.node1.Active(anon)
    647051 ± 24%    +120.3%    1425192 ± 29%  numa-meminfo.node1.Inactive
    632883 ± 25%    +123.0%    1411032 ± 29%  numa-meminfo.node1.Inactive(anon)
    249614 ± 23%    +145.7%     613193 ± 31%  numa-meminfo.node1.Mapped
    468647 ± 20%    +206.9%    1438272 ± 28%  numa-meminfo.node1.Shmem
    204074 ±130%    +203.1%     618583 ± 40%  numa-vmstat.node0.nr_file_pages
     48403 ± 36%    +128.8%     110725 ± 43%  numa-vmstat.node1.nr_active_anon
    158779 ± 25%    +122.3%     352949 ± 29%  numa-vmstat.node1.nr_inactive_anon
     62898 ± 23%    +143.8%     153346 ± 31%  numa-vmstat.node1.nr_mapped
    116833 ± 19%    +207.3%     359079 ± 28%  numa-vmstat.node1.nr_shmem
     48401 ± 36%    +128.8%     110724 ± 43%  numa-vmstat.node1.nr_zone_active_anon
    158780 ± 25%    +122.3%     352949 ± 29%  numa-vmstat.node1.nr_zone_inactive_anon
    389858 ± 13%     +87.4%     730598 ± 19%  numa-vmstat.node1.numa_hit
    362913 ± 18%     +93.7%     702900 ± 21%  numa-vmstat.node1.numa_local
   2712171 ±  7%     -11.3%    2404936 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.avg
   1407145 ± 17%     -30.4%     979280 ± 19%  sched_debug.cfs_rq:/.load.max
   2712177 ±  7%     -11.3%    2404936 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
    547.78 ± 36%    +106.3%       1130 ±  7%  sched_debug.cfs_rq:/.util_est.avg
      1863 ± 12%     +54.1%       2871 ± 17%  sched_debug.cfs_rq:/.util_est.max
     59.08 ±100%    +241.7%     201.92 ± 36%  sched_debug.cfs_rq:/.util_est.min
    392.55 ± 11%     +38.5%     543.51 ± 11%  sched_debug.cfs_rq:/.util_est.stddev
    104511 ± 16%    +518.1%     645974 ±  2%  sched_debug.cpu.nr_switches.avg
    204555 ± 32%    +290.2%     798142 ±  6%  sched_debug.cpu.nr_switches.max
     12171 ± 65%    +844.5%     114956 ± 47%  sched_debug.cpu.nr_switches.min
    945799           +32.6%    1254064        proc-vmstat.nr_file_pages
    287060 ± 10%     +72.7%     495669 ± 15%  proc-vmstat.nr_inactive_anon
     93971 ± 24%    +150.2%     235154 ± 15%  proc-vmstat.nr_mapped
    141268 ±  8%    +217.7%     448745        proc-vmstat.nr_shmem
     25272            +2.4%      25873        proc-vmstat.nr_slab_reclaimable
    287060 ± 10%     +72.7%     495669 ± 15%  proc-vmstat.nr_zone_inactive_anon
     24933 ± 50%    +200.6%      74949 ±  6%  proc-vmstat.numa_hint_faults
      9891 ± 50%    +317.8%      41324 ±  8%  proc-vmstat.numa_hint_faults_local
    614783 ±  2%     +72.8%    1062609        proc-vmstat.numa_hit
    548520 ±  2%     +81.6%     996296        proc-vmstat.numa_local
    549876 ±  4%     +14.4%     628860        proc-vmstat.numa_pte_updates
    734634 ±  2%     +60.7%    1180339        proc-vmstat.pgalloc_normal
    388924 ±  3%     +20.6%     468855 ±  2%  proc-vmstat.pgfault
    478242 ±  5%     -19.5%     385183 ± 14%  proc-vmstat.pgfree
 3.169e+09 ±  8%    +506.1%  1.921e+10        perf-stat.i.branch-instructions
      0.65 ±  3%      -0.1        0.53 ±  5%  perf-stat.i.branch-miss-rate%
  20491366 ±  5%    +378.8%   98121036 ±  5%  perf-stat.i.branch-misses
   7452019 ± 37%    +441.8%   40374999 ± 10%  perf-stat.i.cache-misses
  71298660 ±  3%    +361.7%  3.292e+08        perf-stat.i.cache-references
    227657 ± 19%    +498.6%    1362709 ±  2%  perf-stat.i.context-switches
     14.22 ±  8%     -83.9%       2.29        perf-stat.i.cpi
     37069 ± 36%     -84.2%       5866 ± 13%  perf-stat.i.cycles-between-cache-misses
   1.6e+10 ±  7%    +516.8%  9.867e+10        perf-stat.i.instructions
      0.08 ± 10%    +479.2%       0.44        perf-stat.i.ipc
      3.56 ± 19%    +502.1%      21.45 ±  2%  perf-stat.i.metric.K/sec
      5090 ±  4%     +25.5%       6387 ±  3%  perf-stat.i.minor-faults
      5090 ±  4%     +25.5%       6387 ±  3%  perf-stat.i.page-faults
      0.06 ± 45%    +637.9%       0.44        perf-stat.overall.ipc
 2.598e+09 ± 45%    +627.1%  1.889e+10        perf-stat.ps.branch-instructions
  17015300 ± 45%    +468.0%   96650879 ±  5%  perf-stat.ps.branch-misses
   5919193 ± 63%    +570.7%   39699549 ± 10%  perf-stat.ps.cache-misses
  58527096 ± 44%    +453.7%  3.241e+08        perf-stat.ps.cache-references
    181655 ± 48%    +640.9%    1345912 ±  2%  perf-stat.ps.context-switches
 1.311e+10 ± 45%    +640.3%  9.704e+10        perf-stat.ps.instructions
      4075 ± 44%     +53.6%       6260 ±  3%  perf-stat.ps.minor-faults
      4075 ± 44%     +53.6%       6260 ±  3%  perf-stat.ps.page-faults
 8.153e+11 ± 45%    +637.0%  6.009e+12        perf-stat.total.instructions
     85.99           -86.0        0.00        perf-profile.calltrace.cycles-pp.jbd2_transaction_committed.ext4_set_iomap.ext4_iomap_begin_report.iomap_iter.iomap_fiemap
     86.52           -84.1        2.43        perf-profile.calltrace.cycles-pp.ext4_set_iomap.ext4_iomap_begin_report.iomap_iter.iomap_fiemap.do_vfs_ioctl
     46.15 ± 12%     -46.2        0.00        perf-profile.calltrace.cycles-pp._raw_read_lock.jbd2_transaction_committed.ext4_set_iomap.ext4_iomap_begin_report.iomap_iter
     96.11           -10.9       85.20        perf-profile.calltrace.cycles-pp.ext4_iomap_begin_report.iomap_iter.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl
      4.58 ± 89%      -4.6        0.00        perf-profile.calltrace.cycles-pp.queued_read_lock_slowpath.jbd2_transaction_committed.ext4_set_iomap.ext4_iomap_begin_report.iomap_iter
     97.15            -4.5       92.65        perf-profile.calltrace.cycles-pp.iomap_iter.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      4.34 ± 89%      -4.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_read_lock_slowpath.jbd2_transaction_committed.ext4_set_iomap.ext4_iomap_begin_report
     97.78            -0.7       97.12        perf-profile.calltrace.cycles-pp.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.17 ±141%      +0.6        0.72        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.18 ±141%      +0.6        0.75        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.64 ± 16%      +0.6        1.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.64 ± 16%      +0.6        1.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.29 ±100%      +0.6        0.94        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      0.70 ± 14%      +0.9        1.60        perf-profile.calltrace.cycles-pp.__sched_yield
      0.00            +1.0        0.95        perf-profile.calltrace.cycles-pp.ext4_sb_block_valid.__check_block_validity.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter
      0.00            +1.0        1.05        perf-profile.calltrace.cycles-pp._copy_to_user.fiemap_fill_next_extent.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl
      0.00            +1.4        1.35 ± 11%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.percpu_counter_add_batch.ext4_es_lookup_extent.ext4_map_blocks
      0.00            +1.4        1.41        perf-profile.calltrace.cycles-pp.__check_block_validity.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter.iomap_fiemap
      0.00            +1.6        1.58 ± 10%  perf-profile.calltrace.cycles-pp._raw_spin_lock.percpu_counter_add_batch.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report
      0.00            +3.1        3.08        perf-profile.calltrace.cycles-pp.fiemap_fill_next_extent.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      0.82 ±  6%      +5.1        5.90        perf-profile.calltrace.cycles-pp.iomap_iter_advance.iomap_iter.iomap_fiemap.do_vfs_ioctl.__x64_sys_ioctl
      4.18 ± 17%      +5.2        9.35 ±  3%  perf-profile.calltrace.cycles-pp._raw_read_lock.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter
      0.62 ±  7%     +52.1       52.70        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter
      8.69 ± 13%     +68.0       76.73        perf-profile.calltrace.cycles-pp.ext4_es_lookup_extent.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter.iomap_fiemap
      9.30 ± 11%     +71.3       80.61        perf-profile.calltrace.cycles-pp.ext4_map_blocks.ext4_iomap_begin_report.iomap_iter.iomap_fiemap.do_vfs_ioctl
     86.24           -85.8        0.42        perf-profile.children.cycles-pp.jbd2_transaction_committed
     86.55           -83.8        2.70        perf-profile.children.cycles-pp.ext4_set_iomap
     50.52 ± 12%     -41.1        9.45 ±  3%  perf-profile.children.cycles-pp._raw_read_lock
     96.16           -10.6       85.61        perf-profile.children.cycles-pp.ext4_iomap_begin_report
      4.60 ± 89%      -4.6        0.00        perf-profile.children.cycles-pp.queued_read_lock_slowpath
     97.20            -4.2       92.96        perf-profile.children.cycles-pp.iomap_iter
      0.09 ± 14%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.update_process_times
      0.10 ± 13%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.06 ± 15%      +0.0        0.09        perf-profile.children.cycles-pp.switch_fpu_return
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__switch_to_asm
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.pick_eevdf
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__switch_to
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.put_prev_entity
      0.00            +0.1        0.09        perf-profile.children.cycles-pp.update_load_avg
      0.06 ±  7%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.do_sched_yield
      0.00            +0.1        0.11 ±  8%  perf-profile.children.cycles-pp.stress_fiemap
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.update_curr
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.00            +0.1        0.12 ±  3%  perf-profile.children.cycles-pp.clear_bhb_loop
      0.20 ± 13%      +0.1        0.33        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.1        0.13        perf-profile.children.cycles-pp.yield_task_fair
      0.07 ± 86%      +0.1        0.22 ± 19%  perf-profile.children.cycles-pp.ordered_events__queue
      0.07 ± 86%      +0.1        0.22 ± 19%  perf-profile.children.cycles-pp.queue_event
      0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.ext4_inode_block_valid
      0.07 ± 87%      +0.2        0.23 ± 17%  perf-profile.children.cycles-pp.process_simple
      0.17 ± 61%      +0.2        0.38 ± 11%  perf-profile.children.cycles-pp.reader__read_event
      0.17 ± 60%      +0.2        0.39 ± 11%  perf-profile.children.cycles-pp.perf_session__process_events
      0.17 ± 60%      +0.2        0.39 ± 11%  perf-profile.children.cycles-pp.record__finish_output
      0.07 ±  5%      +0.2        0.28        perf-profile.children.cycles-pp.pick_next_task_fair
      0.47 ± 10%      +0.3        0.74        perf-profile.children.cycles-pp.__schedule
      0.48 ± 10%      +0.3        0.75        perf-profile.children.cycles-pp.schedule
      0.06 ±  7%      +0.4        0.47        perf-profile.children.cycles-pp.iomap_to_fiemap
      0.50 ± 17%      +0.4        0.94        perf-profile.children.cycles-pp.__x64_sys_sched_yield
      0.15 ±  7%      +0.9        1.00        perf-profile.children.cycles-pp.ext4_sb_block_valid
      0.71 ± 14%      +0.9        1.64        perf-profile.children.cycles-pp.__sched_yield
      0.17 ±  8%      +1.0        1.21        perf-profile.children.cycles-pp._copy_to_user
      0.23 ±  9%      +1.3        1.52        perf-profile.children.cycles-pp.__check_block_validity
      0.18 ±  9%      +1.4        1.62 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock
      0.44 ±  6%      +2.7        3.15        perf-profile.children.cycles-pp.fiemap_fill_next_extent
      0.84 ±  7%      +5.2        6.02        perf-profile.children.cycles-pp.iomap_iter_advance
      0.63 ±  6%     +52.2       52.83        perf-profile.children.cycles-pp.percpu_counter_add_batch
      8.75 ± 13%     +68.4       77.12        perf-profile.children.cycles-pp.ext4_es_lookup_extent
      9.35 ± 11%     +71.6       81.00        perf-profile.children.cycles-pp.ext4_map_blocks
     50.35 ± 12%     -41.0        9.32 ±  3%  perf-profile.self.cycles-pp._raw_read_lock
     35.26 ±  7%     -35.0        0.25        perf-profile.self.cycles-pp.jbd2_transaction_committed
      0.06 ± 15%      +0.0        0.10        perf-profile.self.cycles-pp.__schedule
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.00            +0.1        0.10 ±  8%  perf-profile.self.cycles-pp.stress_fiemap
      0.00            +0.1        0.10 ±  4%  perf-profile.self.cycles-pp.ext4_inode_block_valid
      0.17 ± 12%      +0.1        0.27 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.1        0.12 ±  3%  perf-profile.self.cycles-pp.clear_bhb_loop
      0.06 ±107%      +0.2        0.21 ± 19%  perf-profile.self.cycles-pp.queue_event
      0.05 ± 46%      +0.3        0.37        perf-profile.self.cycles-pp.__check_block_validity
      0.04 ± 45%      +0.3        0.36        perf-profile.self.cycles-pp.iomap_to_fiemap
      0.14 ±  8%      +0.8        0.95        perf-profile.self.cycles-pp.ext4_sb_block_valid
      0.14 ±  7%      +0.8        0.99        perf-profile.self.cycles-pp.iomap_fiemap
      0.17 ±  8%      +1.0        1.18        perf-profile.self.cycles-pp._copy_to_user
      0.20 ±  7%      +1.2        1.44        perf-profile.self.cycles-pp.iomap_iter
      0.27 ±  7%      +1.7        1.95        perf-profile.self.cycles-pp.fiemap_fill_next_extent
      0.28 ±  7%      +1.8        2.10        perf-profile.self.cycles-pp.ext4_iomap_begin_report
      0.30 ±  7%      +1.9        2.24        perf-profile.self.cycles-pp.ext4_set_iomap
      0.40 ±  9%      +2.1        2.54        perf-profile.self.cycles-pp.ext4_map_blocks
      0.82 ±  6%      +5.1        5.91        perf-profile.self.cycles-pp.iomap_iter_advance
      3.91 ± 12%     +11.0       14.90        perf-profile.self.cycles-pp.ext4_es_lookup_extent
      0.55 ±  8%     +50.4       50.92        perf-profile.self.cycles-pp.percpu_counter_add_batch




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


