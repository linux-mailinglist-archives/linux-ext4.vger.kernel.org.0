Return-Path: <linux-ext4+bounces-3545-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BA942591
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF45E1C21768
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 04:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A334CC4;
	Wed, 31 Jul 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AiuqA6Zj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0C8376F1;
	Wed, 31 Jul 2024 04:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722401827; cv=fail; b=uDPa9bqerjVtxltnIdlzIh2Zr+yJGJz6RUq35Fy6kedfkFgjcuh32yIUzWIh8mVUnJEFKWuYzWd53+TpnLrXRxcjujEPImpuSo/0b9EVFUAvRoKnE4QLQxGuLrAKQkG8FofH+0bcraj4RLGzP8j3PptfK/fyOJISeXx3is2B+CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722401827; c=relaxed/simple;
	bh=jOjhdcWnYM55d0sC5higBYZ2/pb46ZuHVAOu6N8q5dI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Dg/bxPah6Y/AZnXzEbKCMw2Lqg9D0Sa8fRvqdxSEo3YUTokM8+z8NXHvOaKUEmCHQrZX4irKKNdgvMAlldXUxkJlD+W6wNtyvvO3+y0rVztVHHgxzYyZVKUmq5ajebv220v+gjjfS9nqEubg1yEPIIzQDQvpegHo5hFwDyl7/fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AiuqA6Zj; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722401824; x=1753937824;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=jOjhdcWnYM55d0sC5higBYZ2/pb46ZuHVAOu6N8q5dI=;
  b=AiuqA6ZjdWQ0cmewwmyJ0IeeIv6T2Kx1G/MMaLnuVVVZQMZcY2x2aZap
   /O33I7K9nVXPgqqyJGqUY53ZMdsfgWgUBvNhpD+8+xIyU8gQoY3uF1W/n
   B6vspx5OKx/pIignahbSxDMJLntZDkkAzXSH896O9MEEPux0bSWU6hc6B
   nwO7K+zD3h22baQNRJ5aQ26eSYCRtId7tjRGz0oh+fGPGgBclb0hTa/Ke
   dsdzsYOPJfLNXVBr1bO19e77WUJj6mnPYELYFnfYoIK1djdiwmmEI/LO+
   44hdJFwa6xgOaPtaknZ80XourYz/StV/ocOiaYP3MUocDF7fJbh7WaZlB
   g==;
X-CSE-ConnectionGUID: Qf5plCnNTnmqYYQy7tY7DQ==
X-CSE-MsgGUID: 2oB8wnEQS+eOhUZCoFUqkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20065395"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="20065395"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 21:56:21 -0700
X-CSE-ConnectionGUID: qXkCLHBqSoaji/3oMijtAw==
X-CSE-MsgGUID: 5vp+FbFfQZ2dLmZoOs8FPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54603443"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 21:56:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 21:56:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 21:56:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 21:56:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 21:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/lQRor4oXe0iJI4Zwl5JEFcnA7k3Eg+YaJ11zVJLSnVJ44TDKL0d9B9GmZR9hv5UqDP2skt1+hLrqGrqPz84ejbrpcZcc9FZ8fH+kQTKZDu0V+zj0ylh+igKHBj9dPJdVJekUeHzvPpIt/Dx1ChLfboDD6SYDOyhwvZ6ibdJt6+nyFLQ85gATRzM3TGgy9GeZw/fXiU4n95hYrsHC2iVLjQ2+m04j5bs45DklIS8UA0/ZxKj5DCqPdfOOmtH0zXfCuH4zDHhQKK6SFKt3lapSXAu2KAeyiZg2Hr7c0HlQkwu9jllwQODY1mheW4EyBYpDF4xWbfBdW+sik7w49tTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUOz52n+ycPBNQ+jLiN4zAcwJUjYEbqs3XL+8pT0M+o=;
 b=x5mhpCx/9YmnCurxz/3kWgAnWbkV7llbaJNCjEZWfOLIPeM5VitvzNhuLsyBxFs1tWcvoi+oK3snOeYdBcazkzlUWObOWVjT2H1Q1KIgvY3mj8D4gnzPwgEFPIVPtRMM0XHsmDZkiNKoB+ng7Txvrddg65uUkgLNl2qNCboEMjAdwIjAz7yy6RkMZoBWsx/y7NK02eIjAidkAqAq2vx/HQvIO7Iqld+eJfL/WGmu/g16haolxsy/6PAOuzX/WgFMLDWdDQ4FTM/xChTC7vWk5Dzqq70iw4zrgJM3k57JSlO/PtdNvW9Zx21wWtE5M23LsWURu6VUiw2XjUIEkiEwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7293.namprd11.prod.outlook.com (2603:10b6:208:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 04:56:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:56:10 +0000
Date: Wed, 31 Jul 2024 12:55:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huawei.com>,
	<linux-ext4@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [jbd2]  a794c9ad02:
 fxmark.ssd_ext4_MWCL_18_bufferedio.works/sec 10.9% improvement
Message-ID: <202407301600.a03deb58-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 826e2453-17fa-4096-6d47-08dcb11d184c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6MotMdHyzaBVsQp9FuU+kXwy/zCAarnRKBwFKrIz3MKVoM8HtVVMWVvd+J?=
 =?iso-8859-1?Q?AtTXezfMj/5PgNDuS4n6w9a4gkhqfQwcf8pqxMuF2wA5zNJ4yLDMtCAEaN?=
 =?iso-8859-1?Q?eCEB4URlnR54Ac4ju0iev+TX1f2uR/KRMVMInjoyNmmr/DnaYsv7HIuMu+?=
 =?iso-8859-1?Q?NfXUEMUjKh7ar4UE8u6GgjViU21Br2jwjqGKIuDfG0iXrjHPXmlVMlyI36?=
 =?iso-8859-1?Q?E/u1lZk5Q/oCmSO4sC4IHev9faIEl+nImMw/co1x1TomXTlVou9m69UmTo?=
 =?iso-8859-1?Q?VgGStoMbav4RfwXYMnZm3UirINU2XiPDYkSYTrK73cg+83WGF/C/+ndoBl?=
 =?iso-8859-1?Q?vVLK7BhlKwrcby9bnHMIvLZPMISqbwhe3E3Qv7OoNjeUFjIUMMQ3+oOd3N?=
 =?iso-8859-1?Q?3VTbbwFmuUBTplvEstlt8ma8Fzdwj2u3E8pqCw/1+Vq74CrUEBRIFS2/pI?=
 =?iso-8859-1?Q?VcE82/6HozFVOOs/omGFdwV7sFjDXo/AHVsUOOxyA+11IWjPR5/tOLUNDP?=
 =?iso-8859-1?Q?fLjTChXwz1tSG5rFlxJ+t9Xp/M4N1Zn9PXvl6l8BkPBsFS7IPXva3BQENy?=
 =?iso-8859-1?Q?hAOsVMmwA3U2q9xVahNovwyWFbi4el5C/HcKI1KVgOX0JoldWh80tEN5FU?=
 =?iso-8859-1?Q?sVn8uIf13aoDEc/z2SBI4l6v4TefrnooPlpXHPEtVE9rBPCftxnwAI13tq?=
 =?iso-8859-1?Q?1MAEhLoV2OAwGhTH3hXSLm+CMN5gVi3Ykk5b+sNlYg7AEwZawJUtI9L4zc?=
 =?iso-8859-1?Q?F3Zbb/mQB4mk1cCOULznyWH/n/5dfNr0mQdt7v+eFZr54LKxXEwlzHibfU?=
 =?iso-8859-1?Q?XcBay2NqSoHybn5W2zjVVVoeGv9dvbzNwHzg3yOSS22WQ1ZPaQc/W5oI07?=
 =?iso-8859-1?Q?XLKcc9CbLUkiW6ao7o8YxkU3jqAKQhcSL/pl55Zc7F0OVriNUmSL0koCgj?=
 =?iso-8859-1?Q?fvX9F0HBykSMeNmXn8Ztv5VgJHMkY7+DY4GymcqajCrAs74IB24igoZ+X5?=
 =?iso-8859-1?Q?xTx+0iXGcS5e3XCJHV4PyyMBL+EZzbZHr9RDkZuawpKCNvKFZTA61cEL1y?=
 =?iso-8859-1?Q?s5PvqLTgjZ9TmM+JpSLQ3kHirLoKTKFKage1cLSyD/K+QSF4W7PCMFnMSJ?=
 =?iso-8859-1?Q?WHSQq8yt9jKS9yblfCbAoBqt9lBMwfqh99b8CGQk4Mo1IW6ByCh0Uk/0ex?=
 =?iso-8859-1?Q?DocdjGdYl0Gb5M8NUgXr5hsZcYFTAt0OiH7hLfFNCccAn+GIGQRhXiBSGy?=
 =?iso-8859-1?Q?qxhBg8awyRVbw6jytlOtxypt/k/67Me3s6qJN8/4vwJ/7xLvI+A28EBrZz?=
 =?iso-8859-1?Q?zkN9Kty9fGjiaMqPwCLnfQCbWjl1aMcfLNec29oUWfipmKdT/6UPD4F0LC?=
 =?iso-8859-1?Q?on20GxOYof?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OShjnb5Qj+N07xTtZGK1UrjjNpLLp0IEpyF4+9iqWYyG/2NjAgiE1lo7t9?=
 =?iso-8859-1?Q?wEHC1bVcxiT0/okcugF4WeaQPAXQJHKo6PAfKwZNnoF9p5+ydLWAmR16Y1?=
 =?iso-8859-1?Q?PWmRMCmfZlbRqWfJJcusbNo+XQeQuPO9d+rC1zWDw2agAXwrh7z9j9VYUC?=
 =?iso-8859-1?Q?EAJL0addwk9XjQBaZpBK173GIQbtXxLIXaNneRg9WJGjn46DsXkGe2d7d5?=
 =?iso-8859-1?Q?gCsYzRbdn64c7/6zY7nKz49eDk+ntUGCWNNn4VA8vCv8YrtEGTEppnCWvu?=
 =?iso-8859-1?Q?tKofT6U/CaXO0XKRCzY5ZR/SbtIIwZ1sqLpoH36UJU8ztTf0i95M9dNdIM?=
 =?iso-8859-1?Q?4ouLYs864UCHKAs7Co7YJWUYLMgFi0+KMTq4/50VHuVHiQ86LoH2GpLPEp?=
 =?iso-8859-1?Q?NQyjP7nUfGkaQFlsxjlzwrLINve51yB+grGwjOYdAEgQslhhqZBm0YrZo0?=
 =?iso-8859-1?Q?D2vdOjqOXgrje4Z5YjB6fa1gGalfDWq3t+t/9h6NrqkGecWTaqeW7UvLcJ?=
 =?iso-8859-1?Q?3RzKZyC3rjynPwKA5ppChu43GCYsGmRw4Gck5P0NUs1SyVktK166ajQGH+?=
 =?iso-8859-1?Q?45rG/OdbK3Xin5qeqIzX4p0CIt6bsCkQmXoc/MGDJbVdn70TfSJT4UHR9x?=
 =?iso-8859-1?Q?2c44iOBS0e6+Kijhc396GEFuz4Qh1sL7PZzrlInNuvcukFVI5K98DVQtTA?=
 =?iso-8859-1?Q?Vs29fkpp12hIbzA8qDrB5pZTnY8eN/9B3y0JDxFFynVBpKXVE6nqSFOSCg?=
 =?iso-8859-1?Q?BBa826O2xv9xO0c7xDMA1txR0eKfkUbta0UuI5ebJlvEmyNWZ6FPCuAQ18?=
 =?iso-8859-1?Q?xo4xPxmSBc2I4H/4dkkYjLOc1vQkMyTBY+I1xo7FFL1CGZi4OjvGi9cgpG?=
 =?iso-8859-1?Q?P0tMumcMs7PQMmBWokmHKuNWkiwZw5pLQnk6CWfYmkMV4FiITm6WEAzrwz?=
 =?iso-8859-1?Q?7Gg13KYOTXk4+3QDgxsJzpwhA4dbrJMFYcUvxayrC5I0YZhRVa40SP0+0n?=
 =?iso-8859-1?Q?vae03/9c3ZOFq8i3ueY77VeiLi14+kLX4ZM5RgV6FOaB/43GWAx1x1wv0F?=
 =?iso-8859-1?Q?6GHREm92xKMmPtH9bqzXZu8GL24C5sjfryhnSeHKSiDViSRZaeDpApu7Z4?=
 =?iso-8859-1?Q?RDOF7Fs3g7cZF0ovx8bK4AJAs/Buq3FzMg1XbRGIFCC8SCkP1TqDzEw80f?=
 =?iso-8859-1?Q?2s5pMH0RNAHumcxw/R3fxCPDErCSvX+2nbNLD1SMf7U+Qa84UAkKHQp8Yu?=
 =?iso-8859-1?Q?1bAALljEl9Qwy5fi+2Dachm0RXY04oZsDorLFLefZeVFcwvNfwWTdiGjfY?=
 =?iso-8859-1?Q?p6GFLPgVzu9TwGHpYczq+uX3A55h3cvPBm0MuOKUj4z5f83hKE6lTKOKZx?=
 =?iso-8859-1?Q?ZfIyDv2YznirEvec2S7iDVENVyFBljrRTHYqcI+hATKgHS7bvCSJuUueHA?=
 =?iso-8859-1?Q?azZLM5OrnOoG/i4r4gy4zqdNHD6ylTdKznsy8EvPea2TJYEjpp3O8df/6A?=
 =?iso-8859-1?Q?UdalZ1/7ZmtlBl4VLaQ8SKfpEYkBzz2Wu/7bEhbFySyNSoDaCKftWP8YOw?=
 =?iso-8859-1?Q?ySOabDHGjW3PXjJfclpuHcEtJT8gQ7p0wmUAKGzHO1qFXdybKSQdg/4Xwi?=
 =?iso-8859-1?Q?sv+3Lzl10zeowrDDuGkIs/Mr/+Bzs2t5AnUOAPC71U5vH98KKvqddtdw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 826e2453-17fa-4096-6d47-08dcb11d184c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:56:10.3337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRERee+yZdGtlFs5nq2y0LDdZm+FEBxduEnB6gZgkGEqE7uy+wv+qHwFaZS+zwFY6c7x2JrBbJSAFRdohmCACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7293
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 10.9% improvement of fxmark.ssd_ext4_MWCL_18_bufferedio.works/sec on:


commit: a794c9ad026f0a28044347f31929fcdb0270eadc ("jbd2: increase maximum transaction size")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: fxmark
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1SSD
	media: ssd
	test: MWCL
	fstype: ext4
	directio: bufferedio
	thread_nr: 18
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------------------------------+
| testcase: change | fxmark: fxmark.ssd_ext4_MWCL_18_directio.works/sec 10.9% improvement                          |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                  |
|                  | directio=directio                                                                             |
|                  | disk=1SSD                                                                                     |
|                  | fstype=ext4                                                                                   |
|                  | media=ssd                                                                                     |
|                  | test=MWCL                                                                                     |
|                  | thread_nr=18                                                                                  |
+------------------+-----------------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240730/202407301600.a03deb58-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-13/performance/bufferedio/1SSD/ext4/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp5/MWCL/fxmark/18

commit: 
  1cf5b024a3 ("jbd2: drop pointless shrinker batch initialization")
  a794c9ad02 ("jbd2: increase maximum transaction size")

1cf5b024a3ffa479 a794c9ad026f0a28044347f3192 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10.27            +5.0%      10.78 ±  2%  iostat.cpu.system
     54.92 ±  8%     +30.7%      71.75 ±  7%  mpstat.max_utilization_pct
     25.35 ± 14%     -27.2%      18.46 ± 14%  sched_debug.cfs_rq:/.util_est.avg
    169479 ±  3%      -7.0%     157666 ±  4%  vmstat.io.bo
   1278745 ±  2%     +13.0%    1445139 ±  4%  vmstat.memory.buff
      0.18 ± 54%      -0.1        0.10 ± 30%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.09 ± 19%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.10 ± 17%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.do_group_exit
      0.11 ± 14%      -0.0        0.08 ± 16%  perf-profile.children.cycles-pp.do_exit
   2408170            -8.3%    2207695 ±  9%  perf-stat.i.branch-misses
   6871267            -4.3%    6578038 ±  2%  perf-stat.i.cache-references
   2404936            -8.3%    2204831 ±  9%  perf-stat.ps.branch-misses
   6890735            -4.3%    6594005 ±  2%  perf-stat.ps.cache-references
   1295677 ±  2%     +14.0%    1477204 ±  4%  numa-meminfo.node0.Active
   1280375 ±  2%     +13.9%    1458502 ±  4%  numa-meminfo.node0.Active(file)
   5276009 ±  2%     +12.7%    5945616 ±  3%  numa-meminfo.node0.KReclaimable
   5276009 ±  2%     +12.7%    5945616 ±  3%  numa-meminfo.node0.SReclaimable
    677395 ±  3%     +13.1%     766117 ±  5%  numa-meminfo.node0.SUnreclaim
   5953404 ±  2%     +12.7%    6711734 ±  3%  numa-meminfo.node0.Slab
    320063 ±  2%     +13.9%     364570 ±  4%  numa-vmstat.node0.nr_active_file
    748619           +15.4%     863566        numa-vmstat.node0.nr_dirtied
   1318890 ±  2%     +12.7%    1486316 ±  3%  numa-vmstat.node0.nr_slab_reclaimable
    169339 ±  3%     +13.1%     191517 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
    748621           +15.4%     863569        numa-vmstat.node0.nr_written
    320063 ±  2%     +13.9%     364570 ±  4%  numa-vmstat.node0.nr_zone_active_file
   1296975 ±  2%     +14.2%    1480589 ±  4%  meminfo.Active
   1281245 ±  2%     +14.1%    1461473 ±  4%  meminfo.Active(file)
   1283104 ±  2%     +14.0%    1462913 ±  4%  meminfo.Buffers
   5305939 ±  2%     +12.5%    5970380 ±  4%  meminfo.KReclaimable
   5305939 ±  2%     +12.5%    5970380 ±  4%  meminfo.SReclaimable
    775354            +9.6%     849840 ±  3%  meminfo.SUnreclaim
   6081293 ±  2%     +12.2%    6820221 ±  3%  meminfo.Slab
    420.02 ±  3%      -6.9%     391.11        fxmark.ssd_ext4_MWCL_18_bufferedio.idle_sec
     46.36 ±  3%      -7.3%      42.95        fxmark.ssd_ext4_MWCL_18_bufferedio.idle_util
    133.80            +9.9%     147.07        fxmark.ssd_ext4_MWCL_18_bufferedio.sys_sec
     14.77            +9.4%      16.15 ±  2%  fxmark.ssd_ext4_MWCL_18_bufferedio.sys_util
      3.40 ±  3%     +12.3%       3.81 ±  2%  fxmark.ssd_ext4_MWCL_18_bufferedio.user_sec
      0.37 ±  3%     +11.8%       0.42 ±  2%  fxmark.ssd_ext4_MWCL_18_bufferedio.user_util
   9455194           +11.4%   10532038        fxmark.ssd_ext4_MWCL_18_bufferedio.works
    187654           +10.9%     208067        fxmark.ssd_ext4_MWCL_18_bufferedio.works/sec
    320194 ±  2%     +14.0%     364991 ±  4%  proc-vmstat.nr_active_file
    748619           +15.4%     863566        proc-vmstat.nr_dirtied
   1049747            +4.3%    1095271        proc-vmstat.nr_file_pages
   1326715 ±  2%     +12.5%    1492704 ±  4%  proc-vmstat.nr_slab_reclaimable
    193876            +9.6%     212469 ±  3%  proc-vmstat.nr_slab_unreclaimable
    748621           +15.4%     863569        proc-vmstat.nr_written
    320194 ±  2%     +14.0%     364991 ±  4%  proc-vmstat.nr_zone_active_file
   2458878            +7.3%    2639428        proc-vmstat.numa_hit
   2325681            +7.8%    2506229        proc-vmstat.numa_local
   5333733            +9.0%    5812775        proc-vmstat.pgalloc_normal
   5244126            +9.3%    5730805        proc-vmstat.pgfree
  18378357 ±  2%      -4.6%   17536147 ±  2%  proc-vmstat.pgpgout


***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/directio/disk/fstype/kconfig/media/rootfs/tbox_group/test/testcase/thread_nr:
  gcc-13/performance/directio/1SSD/ext4/x86_64-rhel-8.3/ssd/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp7/MWCL/fxmark/18

commit: 
  1cf5b024a3 ("jbd2: drop pointless shrinker batch initialization")
  a794c9ad02 ("jbd2: increase maximum transaction size")

1cf5b024a3ffa479 a794c9ad026f0a28044347f3192 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     82.99 ± 12%     +20.2%      99.71        mpstat.max_utilization_pct
    329.38            -5.0%     313.04 ±  2%  perf-stat.i.instructions-per-iTLB-miss
    153741 ±  4%     +14.4%     175847 ±  2%  turbostat.C1
    102.10            +1.1%     103.26        turbostat.PkgWatt
     76.73            -1.7%      75.39        iostat.cpu.idle
     13.30            +2.2%      13.60        iostat.cpu.iowait
      9.52 ±  2%      +8.5%      10.33 ±  2%  iostat.cpu.system
    115484            -7.5%     106777        vmstat.io.bo
    911997           +13.2%    1032821        vmstat.memory.buff
     26825            +1.2%      27151        vmstat.system.in
     45.31 ±  2%     -10.1%      40.72 ±  3%  fxmark.ssd_ext4_MWCL_18_directio.idle_util
    172.12 ±  3%     +15.7%     199.13 ±  3%  fxmark.ssd_ext4_MWCL_18_directio.sys_sec
     19.08 ±  3%     +15.1%      21.95 ±  3%  fxmark.ssd_ext4_MWCL_18_directio.sys_util
   9211191           +11.5%   10268392        fxmark.ssd_ext4_MWCL_18_directio.works
    183642           +10.9%     203658        fxmark.ssd_ext4_MWCL_18_directio.works/sec
     15.67 ±  3%     +10.6%      17.33 ±  2%  fxmark.time.percent_of_cpu_this_job_got
    919451           +13.3%    1041606        meminfo.Active
    913989           +13.3%    1035788        meminfo.Active(file)
    915350           +13.3%    1036928        meminfo.Buffers
   3702431           +12.3%    4157764        meminfo.KReclaimable
   3702431           +12.3%    4157764        meminfo.SReclaimable
   4266197           +11.9%    4773429        meminfo.Slab
    919001           +13.3%    1041492        numa-meminfo.node0.Active
    913908           +13.4%    1036089        numa-meminfo.node0.Active(file)
   3680931           +12.3%    4135083        numa-meminfo.node0.KReclaimable
   3680931           +12.3%    4135083        numa-meminfo.node0.SReclaimable
    499103 ±  3%     +12.2%     560196 ±  2%  numa-meminfo.node0.SUnreclaim
   4180035           +12.3%    4695280        numa-meminfo.node0.Slab
    228435           +13.4%     258980        numa-vmstat.node0.nr_active_file
    741634            +9.7%     813930 ±  4%  numa-vmstat.node0.nr_dirtied
    920204           +12.3%    1033566        numa-vmstat.node0.nr_slab_reclaimable
    124764 ±  3%     +12.2%     140030 ±  2%  numa-vmstat.node0.nr_slab_unreclaimable
    741636            +9.7%     813931 ±  4%  numa-vmstat.node0.nr_written
    228435           +13.4%     258980        numa-vmstat.node0.nr_zone_active_file
     44474 ±  8%     +27.7%      56792 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.avg
     61425 ± 14%     +28.1%      78705 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.max
     38449 ±  9%     +28.4%      49369 ±  3%  sched_debug.cfs_rq:/.avg_vruntime.min
     44474 ±  8%     +27.7%      56792 ±  3%  sched_debug.cfs_rq:/.min_vruntime.avg
     61425 ± 14%     +28.1%      78705 ± 10%  sched_debug.cfs_rq:/.min_vruntime.max
     38449 ±  9%     +28.4%      49369 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
      1368            +6.3%       1453 ±  2%  proc-vmstat.nr_active_anon
    228583           +13.4%     259248        proc-vmstat.nr_active_file
    741634            +9.7%     813930 ±  4%  proc-vmstat.nr_dirtied
    960887            +3.2%     991722        proc-vmstat.nr_file_pages
    926829           +12.3%    1040665        proc-vmstat.nr_slab_reclaimable
    141078            +9.2%     154034        proc-vmstat.nr_slab_unreclaimable
    741636            +9.7%     813931 ±  4%  proc-vmstat.nr_written
      1368            +6.3%       1453 ±  2%  proc-vmstat.nr_zone_active_anon
    228583           +13.4%     259248        proc-vmstat.nr_zone_active_file
   2377668            +7.2%    2548605        proc-vmstat.numa_hit
   2277581            +7.3%    2444791        proc-vmstat.numa_local
     27510            +9.6%      30163        proc-vmstat.pgactivate
   5155991            +9.2%    5629540        proc-vmstat.pgalloc_normal
   5134429            +9.2%    5608738        proc-vmstat.pgfree
  18015387            -5.4%   17048860        proc-vmstat.pgpgout
      6.85 ±  6%      -2.2        4.68 ± 12%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      6.85 ±  6%      -2.2        4.68 ± 12%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      6.85 ±  6%      -2.2        4.68 ± 12%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      5.63 ±  5%      -1.9        3.74 ± 14%  perf-profile.calltrace.cycles-pp.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      5.61 ±  5%      -1.9        3.74 ± 14%  perf-profile.calltrace.cycles-pp.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      2.53 ± 10%      -0.7        1.83 ±  8%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir
      2.55 ±  9%      -0.7        1.86 ±  8%  perf-profile.calltrace.cycles-pp.__ext4_journal_get_write_access.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir.ext4_create
      1.79 ± 12%      -0.6        1.17 ±  8%  perf-profile.calltrace.cycles-pp.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
      1.88 ± 11%      -0.6        1.29 ±  8%  perf-profile.calltrace.cycles-pp.__ext4_handle_dirty_metadata.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir
      1.68 ± 12%      -0.6        1.13 ± 10%  perf-profile.calltrace.cycles-pp.do_get_write_access.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_dx_add_entry.ext4_add_entry
      0.95 ± 19%      -0.5        0.41 ± 72%  perf-profile.calltrace.cycles-pp._raw_spin_lock.do_get_write_access.jbd2_journal_get_write_access.__ext4_journal_get_write_access.ext4_dx_add_entry
      1.42 ± 11%      -0.5        0.94 ± 14%  perf-profile.calltrace.cycles-pp.crc32c_pcl_intel_update.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork
      1.40 ± 11%      -0.5        0.92 ± 14%  perf-profile.calltrace.cycles-pp.crc_pcl.crc32c_pcl_intel_update.jbd2_journal_commit_transaction.kjournald2.kthread
      1.08 ± 17%      -0.4        0.65 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock.jbd2_journal_dirty_metadata.__ext4_handle_dirty_metadata.add_dirent_to_buf.ext4_dx_add_entry
      1.60 ±  7%      -0.3        1.31 ± 11%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.63 ±  6%      -0.3        0.38 ± 71%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.63 ±  6%      -0.2        0.38 ± 71%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.95 ± 11%      -0.2        0.72 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.84 ± 12%      -0.2        0.64 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.76 ±  5%      -0.1        0.66 ±  8%  perf-profile.calltrace.cycles-pp.jbd2_journal_get_write_access.__ext4_journal_get_write_access.__ext4_new_inode.ext4_create.lookup_open
      1.52 ±  6%      +0.1        1.62 ±  2%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.67 ± 13%      +0.1        0.81 ±  9%  perf-profile.calltrace.cycles-pp.__ext4_read_dirblock.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir.ext4_create
      0.84 ±  9%      +0.2        1.00 ± 13%  perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.27 ±  6%      +0.2        1.44 ±  5%  perf-profile.calltrace.cycles-pp.ext4_bread.__ext4_read_dirblock.dx_probe.ext4_dx_add_entry.ext4_add_entry
      1.26 ±  6%      +0.2        1.43 ±  4%  perf-profile.calltrace.cycles-pp.ext4_getblk.ext4_bread.__ext4_read_dirblock.dx_probe.ext4_dx_add_entry
      1.46 ±  7%      +0.2        1.66 ±  4%  perf-profile.calltrace.cycles-pp.do_split.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir.ext4_create
      1.42 ±  7%      +0.2        1.66 ±  6%  perf-profile.calltrace.cycles-pp.__ext4_read_dirblock.dx_probe.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir
      2.34 ±  4%      +0.3        2.59 ±  3%  perf-profile.calltrace.cycles-pp.dx_probe.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir.ext4_create
      1.98 ±  3%      +0.3        2.24 ±  6%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.54 ±  4%      +0.3        2.83 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.57 ±  4%      +0.3        2.87 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      2.42 ±  4%      +0.3        2.74 ±  5%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      2.39 ±  5%      +0.4        2.74 ±  5%  perf-profile.calltrace.cycles-pp.ext4_bread.__ext4_read_dirblock.dx_probe.ext4_dx_find_entry.__ext4_find_entry
      2.38 ±  5%      +0.4        2.73 ±  5%  perf-profile.calltrace.cycles-pp.ext4_getblk.ext4_bread.__ext4_read_dirblock.dx_probe.ext4_dx_find_entry
      2.62 ±  6%      +0.5        3.07 ±  4%  perf-profile.calltrace.cycles-pp.__ext4_read_dirblock.dx_probe.ext4_dx_find_entry.__ext4_find_entry.ext4_lookup
      3.64 ±  4%      +0.5        4.13 ±  4%  perf-profile.calltrace.cycles-pp.dx_probe.ext4_dx_find_entry.__ext4_find_entry.ext4_lookup.lookup_open
     18.30 ±  2%      +0.9       19.16        perf-profile.calltrace.cycles-pp.__ext4_find_entry.ext4_lookup.lookup_open.open_last_lookups.path_openat
     18.92 ±  2%      +0.9       19.81        perf-profile.calltrace.cycles-pp.ext4_lookup.lookup_open.open_last_lookups.path_openat.do_filp_open
      4.84            +1.0        5.82 ± 10%  perf-profile.calltrace.cycles-pp.__ext4_check_dir_entry.ext4_find_dest_de.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry
     15.33            +1.2       16.48 ±  2%  perf-profile.calltrace.cycles-pp.ext4_find_dest_de.add_dirent_to_buf.ext4_dx_add_entry.ext4_add_entry.ext4_add_nondir
     51.37            +1.7       53.03 ±  2%  perf-profile.calltrace.cycles-pp.ext4_create.lookup_open.open_last_lookups.path_openat.do_filp_open
     72.49            +2.6       75.05        perf-profile.calltrace.cycles-pp.lookup_open.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
     73.47            +2.7       76.12        perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     80.62            +2.7       83.30        perf-profile.calltrace.cycles-pp.open64
     78.14            +2.7       80.83        perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     79.10            +2.7       81.80        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     78.22            +2.7       80.92        perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     79.14            +2.7       81.85        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     79.56            +2.7       82.29        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     79.60            +2.7       82.33        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      6.86 ±  6%      -2.2        4.68 ± 12%  perf-profile.children.cycles-pp.ret_from_fork
      6.86 ±  6%      -2.2        4.68 ± 12%  perf-profile.children.cycles-pp.ret_from_fork_asm
      6.85 ±  6%      -2.2        4.68 ± 12%  perf-profile.children.cycles-pp.kthread
      5.63 ±  5%      -1.9        3.74 ± 14%  perf-profile.children.cycles-pp.jbd2_journal_commit_transaction
      5.63 ±  5%      -1.9        3.74 ± 14%  perf-profile.children.cycles-pp.kjournald2
      6.26 ±  7%      -1.0        5.24 ±  4%  perf-profile.children.cycles-pp.jbd2_journal_get_write_access
      6.46 ±  7%      -1.0        5.45 ±  4%  perf-profile.children.cycles-pp.__ext4_journal_get_write_access
      2.15 ± 11%      -0.7        1.46 ±  7%  perf-profile.children.cycles-pp.jbd2_journal_dirty_metadata
      3.07 ±  8%      -0.7        2.38 ±  6%  perf-profile.children.cycles-pp.__ext4_handle_dirty_metadata
      1.96 ± 12%      -0.6        1.32 ±  9%  perf-profile.children.cycles-pp.do_get_write_access
      2.74 ± 16%      -0.5        2.20 ± 11%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      2.62 ±  4%      -0.4        2.20 ±  5%  perf-profile.children.cycles-pp.crc_pcl
      3.91 ±  4%      -0.4        3.49 ±  4%  perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      1.18 ±  4%      -0.3        0.89 ± 10%  perf-profile.children.cycles-pp.__jbd2_journal_file_buffer
      1.67 ±  6%      -0.3        1.38 ± 11%  perf-profile.children.cycles-pp.intel_idle
      0.66 ±  8%      -0.2        0.44 ± 20%  perf-profile.children.cycles-pp.jbd2_journal_write_metadata_buffer
      1.28 ±  7%      -0.2        1.07 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.58 ±  8%      -0.2        0.40 ± 14%  perf-profile.children.cycles-pp.__jbd2_journal_refile_buffer
      1.13 ±  9%      -0.2        0.95 ±  7%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.56 ±  9%      -0.2        0.40 ± 11%  perf-profile.children.cycles-pp.__jbd2_journal_temp_unlink_buffer
      1.20 ±  2%      -0.2        1.05 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.40 ±  8%      -0.1        0.27 ± 18%  perf-profile.children.cycles-pp.jbd2_journal_put_journal_head
      0.33 ±  9%      -0.1        0.21 ± 21%  perf-profile.children.cycles-pp.__jbd2_journal_remove_checkpoint
      0.34 ± 15%      -0.1        0.24 ± 14%  perf-profile.children.cycles-pp.mark_buffer_dirty
      0.36 ± 10%      -0.1        0.26 ± 10%  perf-profile.children.cycles-pp.submit_bh_wbc
      0.26 ± 14%      -0.1        0.17 ± 13%  perf-profile.children.cycles-pp.__slab_free
      0.35 ± 10%      -0.1        0.26 ± 12%  perf-profile.children.cycles-pp.end_bio_bh_io_sync
      0.28 ± 12%      -0.1        0.20 ± 13%  perf-profile.children.cycles-pp.jbd2_journal_add_journal_head
      0.41 ± 13%      -0.1        0.33 ± 15%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      0.38 ± 16%      -0.1        0.30 ± 15%  perf-profile.children.cycles-pp.__submit_bio
      0.16 ± 17%      -0.1        0.09 ± 17%  perf-profile.children.cycles-pp.free_buffer_head
      0.22 ±  6%      -0.1        0.14 ± 28%  perf-profile.children.cycles-pp.jbd2_journal_file_buffer
      0.59 ±  7%      -0.1        0.53 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.34 ± 13%      -0.1        0.27 ± 12%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.16 ± 16%      -0.1        0.10 ± 15%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.23 ±  8%      -0.0        0.18 ± 14%  perf-profile.children.cycles-pp.ktime_get
      0.11 ±  6%      -0.0        0.07 ± 12%  perf-profile.children.cycles-pp.mempool_alloc_noprof
      0.12 ± 14%      +0.0        0.15 ±  4%  perf-profile.children.cycles-pp.ext4_get_group_info
      0.10 ± 18%      +0.0        0.15 ± 16%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.09 ± 32%      +0.1        0.16 ± 24%  perf-profile.children.cycles-pp.mnt_want_write
      0.22 ±  9%      +0.1        0.29 ± 16%  perf-profile.children.cycles-pp.memcg_list_lru_alloc
      0.13 ± 53%      +0.1        0.22 ± 30%  perf-profile.children.cycles-pp.__dquot_initialize
      2.40 ±  3%      +0.2        2.59 ±  5%  perf-profile.children.cycles-pp.ext4_fill_raw_inode
      1.47 ±  7%      +0.2        1.67 ±  4%  perf-profile.children.cycles-pp.do_split
      2.00 ±  3%      +0.3        2.26 ±  6%  perf-profile.children.cycles-pp.__fput
      2.42 ±  4%      +0.3        2.74 ±  5%  perf-profile.children.cycles-pp.__x64_sys_close
      5.98 ±  4%      +0.8        6.74 ±  2%  perf-profile.children.cycles-pp.dx_probe
     18.30 ±  2%      +0.9       19.16        perf-profile.children.cycles-pp.__ext4_find_entry
     18.92 ±  2%      +0.9       19.82        perf-profile.children.cycles-pp.ext4_lookup
      4.94            +1.0        5.94 ± 10%  perf-profile.children.cycles-pp.__ext4_check_dir_entry
      8.26 ±  5%      +1.0        9.29 ±  3%  perf-profile.children.cycles-pp.__ext4_read_dirblock
     15.44            +1.1       16.58 ±  2%  perf-profile.children.cycles-pp.ext4_find_dest_de
     51.38            +1.7       53.03 ±  2%  perf-profile.children.cycles-pp.ext4_create
     72.50            +2.6       75.06        perf-profile.children.cycles-pp.lookup_open
     73.48            +2.7       76.13        perf-profile.children.cycles-pp.open_last_lookups
     80.70            +2.7       83.36        perf-profile.children.cycles-pp.open64
     78.19            +2.7       80.87        perf-profile.children.cycles-pp.path_openat
     79.15            +2.7       81.84        perf-profile.children.cycles-pp.do_sys_openat2
     78.26            +2.7       80.96        perf-profile.children.cycles-pp.do_filp_open
     79.19            +2.7       81.89        perf-profile.children.cycles-pp.__x64_sys_openat
     82.66            +2.9       85.59        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     82.58            +2.9       85.51        perf-profile.children.cycles-pp.do_syscall_64
      2.72 ± 16%      -0.5        2.19 ± 11%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.61 ±  4%      -0.4        2.18 ±  5%  perf-profile.self.cycles-pp.crc_pcl
      1.18 ±  5%      -0.4        0.77 ± 16%  perf-profile.self.cycles-pp.jbd2_journal_commit_transaction
      2.27 ±  8%      -0.3        1.97 ±  9%  perf-profile.self.cycles-pp.jbd2_journal_get_write_access
      1.67 ±  6%      -0.3        1.38 ± 11%  perf-profile.self.cycles-pp.intel_idle
      0.78 ±  3%      -0.2        0.57 ±  9%  perf-profile.self.cycles-pp.__jbd2_journal_file_buffer
      0.56 ±  9%      -0.2        0.40 ± 11%  perf-profile.self.cycles-pp.__jbd2_journal_temp_unlink_buffer
      0.35 ±  5%      -0.1        0.22 ± 28%  perf-profile.self.cycles-pp.jbd2_journal_write_metadata_buffer
      0.37 ±  7%      -0.1        0.25 ± 20%  perf-profile.self.cycles-pp.jbd2_journal_put_journal_head
      0.28 ± 13%      -0.1        0.18 ± 14%  perf-profile.self.cycles-pp.do_get_write_access
      0.26 ± 13%      -0.1        0.16 ± 13%  perf-profile.self.cycles-pp.__slab_free
      0.26 ± 13%      -0.1        0.18 ± 14%  perf-profile.self.cycles-pp.jbd2_journal_add_journal_head
      0.49 ±  6%      -0.1        0.44 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.18 ± 10%      -0.0        0.13 ± 23%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.17 ±  7%      -0.0        0.13 ±  9%  perf-profile.self.cycles-pp.jbd2__journal_start
      0.16 ±  8%      -0.0        0.13 ± 13%  perf-profile.self.cycles-pp.ktime_get
      0.12 ± 14%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.ext4_get_group_info
      0.03 ±100%      +0.1        0.08 ± 27%  perf-profile.self.cycles-pp.ext4_group_desc_csum_set
      1.06 ±  6%      +0.1        1.17 ±  5%  perf-profile.self.cycles-pp.filemap_get_entry
      4.89            +1.0        5.88 ± 10%  perf-profile.self.cycles-pp.__ext4_check_dir_entry





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


