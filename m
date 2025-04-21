Return-Path: <linux-ext4+bounces-7358-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9BA94C4C
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6BE3A7F7D
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Apr 2025 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062932586C1;
	Mon, 21 Apr 2025 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUDDDN8n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46572580F2;
	Mon, 21 Apr 2025 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745214988; cv=fail; b=LYuArcvzYq5uBBrjpi3sUlVSsvzR1t6dZkdDi8fM/up5yJGJHuNqtRyhzoyI3UmxO3IiZIrhNkNco8JVA6Ea2mH1hv9Qv8EGx8l9//qNWWEwy1pZHusOl8w0EPKYo2ylXtN9M2Y1WphBdbGerni5791X4w081hty2K3rek1ZQ5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745214988; c=relaxed/simple;
	bh=pMuXchkiZJRw4vnDWzXC6TDZAlHipmwY4lACfugZ530=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QJnsSRyJsaPZwU4LBD69n5Wd0KzBRDG3LPaDXR8YePnquarL3d9NgtLx5+Ofjm7WLFfTZKclQPPTOQZ3o553UqjdWfDSeli1owKVp7GofnnEpWEfYFx8nJIMNkrPaJqcotTEsgREnbom9/jr12P75a5i44aZef9HviUGLrE+0ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUDDDN8n; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745214987; x=1776750987;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=pMuXchkiZJRw4vnDWzXC6TDZAlHipmwY4lACfugZ530=;
  b=FUDDDN8nhPNtSTV4Fw3bdHdFBK+mzTN91ZZunTyjlN01jbBQXeGjYaY0
   IvT2VEceAkzZI66eYq/LrznnjaPQVwY4n443S5X/hGktNsAMWPeglU0NR
   q3Hi6iCJki2DtL8c4mu0xovzLf2a7iyQjJ99W6Qi2p4BsAdVNE7NV531Z
   ox29I4N5XRpbNPjmG6Or3abvDBDoBj0V9l48dH2PkE4LUjU1dkEL8wNmu
   Lsi6TaAttuDiVOyy6tr0NjBSvrWwPzUQcQf+P7vs4AbL/R3f5thfZx/Oj
   ojjtKymbsuNJO2UM/Knvrsum7r4gyHItailsUAy0tFCgA+i6eLFNVjBy4
   A==;
X-CSE-ConnectionGUID: 9Pa+8AARQP2IZPVk5s3o0w==
X-CSE-MsgGUID: VfXd5c0TQPW7XWnheaxWXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11409"; a="46634319"
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="46634319"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 22:56:26 -0700
X-CSE-ConnectionGUID: 21v7T0i5TJeq0ENTyN72dQ==
X-CSE-MsgGUID: cVetODNXSveqdghbPM7nzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,227,1739865600"; 
   d="scan'208";a="136728811"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 22:56:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 22:56:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 20 Apr 2025 22:56:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 20 Apr 2025 22:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqBleSGtv1bdyJ7JBldbOSPtK1TV3lpw4+LeyM1o9hOm8lhDv8vQFQrXrmjlwCLKYffVolalamIRy5D2EEX4XhSgecI0fFfeEATSau5saARPowo4T3EUyGoOwVwvsDLS9VWZcTCzNJfGyCgaMCoGY7bJRWxI+/DnYLvYD1cP3X3kLDzoHDdn0Yhph02HvS2ZTz0WUV8SUzMYnaad9GqIomJaZf0NX9PfbZwdYaotTPskluRXVJxURchdeByPcGLUEUBRv/JtKZ/c1odrvMLfU50hbkCEzDlMIrAtMO7g3+nEsILU27Qo1bvkyD1HTpJfzuihiFUX2RuZ+dDzITnTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nfkj1zF1VTtFgg0gB1PkSxDMZlgsFdbEnjeVMdu649g=;
 b=Havyghfe/50lOu4E0alXYfoEE2WAl5jUyRyVUu+tCqm/sgvz+zhNYmCKTZwqwB7abptlwx8PfwgGcKBBwhwmSn9w46njV79pO1IXfVmgkadfLSt/tzy8YtCNexd5OpHlhcR68chkZ91lEy1OcHfIXgUP5GNQ2D9hFbldd6Vh7ExEq8CXEti2Kh8jVK6WqBNNGDMD88AVVg/cI8f4mZEw/hvlMflfpKY8QVR7EBxfz2u2uG086xTKtFDwUj5rb3qD/cXzZIUsVczhidQBs3GWcr8a3t4QWSyhsSnVgoRhZNUiboi2AWNJuXfKjTg99b/+ptXD0QOnDMa99GzAcZmG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Mon, 21 Apr
 2025 05:56:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 05:56:18 +0000
Date: Mon, 21 Apr 2025 13:56:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Ritesh Harjani
	<ritesh.list@gmail.com>, Baokun Li <libaokun1@huawei.com>,
	<linux-ext4@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [ext4]  896b02d0b9:  stress-ng.fiemap.ops_per_sec
 15.8% regression
Message-ID: <202504211320.5025beac-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a34c08-f881-454a-00b8-08dd80993bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?srGGrDZTCg2R7nWm1K3Yqtnf9RU83Prsnig2DzNysjKTlSp+aQY1iAHxOr?=
 =?iso-8859-1?Q?XM3z//IdE2XNPai2B2KWFLoHr6UxlH87/X7X3jdacNOlKOSXnvHzjldvIA?=
 =?iso-8859-1?Q?oB7NNl8ujRYzszvTfCprry9q6h01OMECDUP9he/NxiZtHYfV4Wgn6GI7cv?=
 =?iso-8859-1?Q?ubrQWz/SrxZ56HUGtYmfRatwb3C/iAUk3CLHP6SacXN4WqJR3IAllR6Sgj?=
 =?iso-8859-1?Q?2noQoM82gI72XkBE1l6NCnHwge1ugrxI1sOf6djjlmh1k6ynlfxk+3eoJ2?=
 =?iso-8859-1?Q?UMH32NcgM3S0h8aGcaNj19y8HpXdE4bDhsUN+MAHIR8suUMCd6PkcKuVHa?=
 =?iso-8859-1?Q?6jW6OUhHV3G6YIw7XDyq/AOauSduvdqBcEkr/eAY8JjOEp5odS68jzkDmT?=
 =?iso-8859-1?Q?5KRY6e2afQHgyd8oL9hzUn8A7OQNXkvCw5WlMCNtsEDpkvt7jPqJrRvtD6?=
 =?iso-8859-1?Q?ogLUzNCngg3+eo4ACK9e2njcHE4Lly2M8wkSycCXZOe/Id3Y1D7V27A+r4?=
 =?iso-8859-1?Q?mep74vFNhsk3ANvutHg5fSM1xx0lufffn0R9SqWPR667RdSyEUpWkUUy+f?=
 =?iso-8859-1?Q?/rT+sW/m5KJ0JxAxffDVU7DdVRdDUlEKVcFh5Cd6qBw8QwVX77NfHkHBg/?=
 =?iso-8859-1?Q?pwrpHM+ry7q3FPgtzC9w4nCbYQyVRSRP9suW7pUZPGugjbBtRCW21wJkzv?=
 =?iso-8859-1?Q?M2o8uTGD3givFYQx60nOXeq2D7OPQsg7c17l8D4SEwocHHiKhZwJiFxAt8?=
 =?iso-8859-1?Q?I27CdCjUWx3H7ONLGaEvN3wl4NV5uKMvHqVy0FP33p1pI3aY38YYO4dKOz?=
 =?iso-8859-1?Q?L6KwbHeFcJHAa8PvmsGGLkUkxmQJjntlt5M7ybj9bqXJOcylCtUOStu1IS?=
 =?iso-8859-1?Q?zMFK6YrklCjDTD8/NLAMCY4iIFLVwaLDe6FWiOpBz2dyr/ePxPQW1ge4vI?=
 =?iso-8859-1?Q?SdrLjEg3P+/T80RCeqVu19OzZedEO13V1Cl+ht3XskYNmI9k0pftWCDIG1?=
 =?iso-8859-1?Q?Jg5rxr9am7bUj8J2ELDkBmC9ootAA/EmfMrYZyCcrfTku91/OjaktC0Eg0?=
 =?iso-8859-1?Q?iZe4oGPPC+wwwS6MbfG4TsY+YivrAfNDofjQsvk1jKiWcCVZnXE1J4z7T+?=
 =?iso-8859-1?Q?4tDbw0x2dPAtZuFnLcnsB82/KbN1gMouCJ1qA49ia+CVITxJoljPGw6tI2?=
 =?iso-8859-1?Q?ozyZgaMSRF5qAnCowPNXEF2TaW2GZPUU2XhFP1jb5sooa0IQLh23m/XA6J?=
 =?iso-8859-1?Q?OYG1dtawBk0oqY3s9aGcpnpLYpGzLFT7NaBq+MKqvQkd2I84vmVm0u39Ru?=
 =?iso-8859-1?Q?15yU+Sb+GzNewx03kggsqPp4rRbS4GSUdMoK2O1mKhhQql9qj+wvS0K1/L?=
 =?iso-8859-1?Q?tDKIgyC4Xs1uwCsTVdr0JuTuvNREnl0HJqawMyQHnttU2EDKAmt/rXvqh7?=
 =?iso-8859-1?Q?Na7UHevLnQiJ1Rvh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TAFZIZsiS1LF5O6JglkXjII2q//KTUplOQjPhRhp/NCZA2NYH0mSbHLdSV?=
 =?iso-8859-1?Q?wVvTRZQ4V3zeTFaPRQMPLyzP0/qQYQH7Mu0jsRnSEKC4gOgCpLDtL/ky8z?=
 =?iso-8859-1?Q?v1z/7rst402TpVVo1UMFwsYrgHeCvTBgHpH4ubMUb3N4nZwxcZug9bMNax?=
 =?iso-8859-1?Q?APpuSTejTyR0IqLWDDUnLAAqgmgI4AotDcVqtS4TwGQBJTk7/NbZFiLVWI?=
 =?iso-8859-1?Q?6/a0y2dczpVp7uq67Pd7bbk2RuuPRequYYg4kdacBKqcjLvn/J/fGuFkBY?=
 =?iso-8859-1?Q?Ymb41PH174XaN2Cp0rGFN4YKMcy9jMUQ3UhTguIBM4uGGNIenBqv6svJ7Z?=
 =?iso-8859-1?Q?4i3BpN3sNn0ujafd6BAHzJQhXCC7Vq/FZCb/N/ampqgZ/BMrkyAwESneh/?=
 =?iso-8859-1?Q?2uQBe4AUcdbAUkJHA6OnhkKdYzueJqn2JwSv5aahWpW5ks26aXUtm6oUgL?=
 =?iso-8859-1?Q?C4xU/VUq8cnxCaxNCTl0aSuuk7g0iZu1rOVvwvGgfVvJnZdovjxj/PWw84?=
 =?iso-8859-1?Q?O4DzpY99Lkm3o0v9Vxars1xfveu/eXRCgAazMe0zmh610e2cGN7O3tn7Gn?=
 =?iso-8859-1?Q?qFK3nwyA9wDoU+vjVKFx2Rdp5Lc5u5PUKn58L1rx9m8C/mK5ifH31KaEje?=
 =?iso-8859-1?Q?OjZ8ZF50Cf9GqWaroCGJwF4OEYF7/IwDqTTkQ1/4QR+crEE5VFaeEPFgCA?=
 =?iso-8859-1?Q?SNCgxuWB6n8dOUDSn3c3sU6/PKmrQh+H+M+HgZ8AarEAJ4gc94FWPDUWBX?=
 =?iso-8859-1?Q?6HZNzswO31+MR8Y9w0v2TsMGY61LNPOOeAewhl/5r0zSCMPM8radclUcxC?=
 =?iso-8859-1?Q?il42y95a1XtoYFr2n1JXHxvUgc3D/4jYkA6hNaJ+e8T/8q7BUMtofuPXU6?=
 =?iso-8859-1?Q?mUp4uDoeyM7ZNlqumb0NYkjAZELWv5CSiUVO3lYrVIoO2MShTlx5bZJH22?=
 =?iso-8859-1?Q?s2IPGVCWk2j+6ZEwJVXYEZ/OFBV2ACulPzGBAenN3+xlBABi8hvCO5w5tA?=
 =?iso-8859-1?Q?ArafXHBz4G3GFyUVTkqHsHGZUbdSurb9tg7ZbaDEsLs2UCF/WiE+2K+MCU?=
 =?iso-8859-1?Q?ddKaLz11JnSuP6YoUpaTAGTzjTyFL33AcW9Zsu6DoJ5YX4258VlH7lfEu3?=
 =?iso-8859-1?Q?Dgb8DiUsMF+cvos7RcbSp2Tc+GG6OxwRFjtihhCQujR2sZzA5bcxbVRWLW?=
 =?iso-8859-1?Q?nkIsGux6uon5qSttges2c79NftJU5c51Ca563jzy3TxqZNgZxYOasHxmPU?=
 =?iso-8859-1?Q?Klv0JzN6VBtQE+elwHgIe8huSqTMln7fopjY7E9um88FBl0SyHGem4IUHc?=
 =?iso-8859-1?Q?icnj1dV5S5AgHg2PXIKfYfgd8HKeJ54wzD6f7BupVvnHHaWFXVpmAZKGH0?=
 =?iso-8859-1?Q?bDqDcrnQGe9fIfopg+ILFlz9UQOPFJiw7+S+INFwXRfng8dLd8hAzLT0A/?=
 =?iso-8859-1?Q?9G6z3RgZf+BLFVBDt+oe8WquzhQWt2o7GFkO/kHxANPzgDS8Pk8EAHuFgI?=
 =?iso-8859-1?Q?FY8xayV+5JvLtASolBYHPNd8yYs1Wyl8cF3EUbCwGTR5uLtLi+ge1oj2y3?=
 =?iso-8859-1?Q?ClikIP8dwb0FBOMZaov+APbk/ZFrLTK2E6rKMqrok74forYQqEHmc25NjS?=
 =?iso-8859-1?Q?ssOLfkv+dAseRo1LglEUrXW2quEML9hxx1CHphCAO8YxIyu3x3727txw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a34c08-f881-454a-00b8-08dd80993bd2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:56:18.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcOTk3HbONWYrXJRcYl8mZVHeDCfUeW+wtKLz6E0sTyWFSTcsTBRYjaHdVUStwqYTXtEzffDdnzCMCKcLZ2IQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 15.8% regression of stress-ng.fiemap.ops_per_sec on:


commit: 896b02d0b9e7deb4a4eb365e13dd912b49916519 ("ext4: Make sb update interval tunable")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      1a1d569a75f3ab2923cb62daf356d102e4df2b86]
[test failed on linux-next/master f660850bc246fef15ba78c81f686860324396628]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: fiemap
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504211320.5025beac-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250421/202504211320.5025beac-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fiemap/stress-ng/60s

commit: 
  ce2f26e737 ("ext4: avoid journaling sb update on error if journal is destroying")
  896b02d0b9 ("ext4: Make sb update interval tunable")

ce2f26e73783b4a7 896b02d0b9e7deb4a4eb365e13d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.29 ±  6%     -13.2%       1.99 ±  7%  iostat.cpu.user
   1688381 ±  2%     -16.4%    1411358 ±  4%  vmstat.system.cs
      0.01 ± 12%      -0.0        0.01 ± 10%  mpstat.cpu.all.soft%
      2.33 ±  6%      -0.3        2.01 ±  7%  mpstat.cpu.all.usr%
     28467 ± 22%     +39.4%      39676 ± 13%  numa-meminfo.node0.Inactive
     28467 ± 22%     +39.4%      39676 ± 13%  numa-meminfo.node0.Inactive(file)
      7099 ± 22%     +40.0%       9937 ± 13%  numa-vmstat.node0.nr_inactive_file
      7099 ± 22%     +40.0%       9937 ± 13%  numa-vmstat.node0.nr_zone_inactive_file
   3186734 ±  2%     -13.0%    2770907        meminfo.Active
   3186734 ±  2%     -13.0%    2770907        meminfo.Active(anon)
   2332511 ±  4%     -17.1%    1933636 ±  2%  meminfo.Shmem
    829642 ±  3%     -16.0%     696952 ±  4%  sched_debug.cpu.nr_switches.avg
    992823 ±  4%     -14.5%     849332 ±  6%  sched_debug.cpu.nr_switches.max
    153915 ±  5%     -15.2%     130547 ± 11%  sched_debug.cpu.nr_switches.stddev
  64971130 ±  3%     -15.8%   54708915 ±  4%  stress-ng.fiemap.ops
   1067456 ±  3%     -15.8%     898490 ±  4%  stress-ng.fiemap.ops_per_sec
 1.079e+08 ±  2%     -16.0%   90643140 ±  4%  stress-ng.time.involuntary_context_switches
     67.64 ±  9%     -16.5%      56.46 ±  9%  stress-ng.time.user_time
    797292 ±  2%     -13.2%     692413        proc-vmstat.nr_active_anon
   1499550            -6.7%    1398519        proc-vmstat.nr_file_pages
    583908 ±  4%     -17.3%     483006 ±  2%  proc-vmstat.nr_shmem
    797292 ±  2%     -13.2%     692413        proc-vmstat.nr_zone_active_anon
   1256873 ±  2%     -12.3%    1102563        proc-vmstat.numa_hit
   1190636 ±  2%     -13.0%    1036297        proc-vmstat.numa_local
   1367314 ±  2%     -11.3%    1212232 ±  2%  proc-vmstat.pgalloc_normal
    369155 ±  5%      -6.9%     343753 ±  2%  proc-vmstat.pgfault
 2.492e+10 ±  2%     -18.5%  2.031e+10        perf-stat.i.branch-instructions
 1.232e+08 ±  7%     -15.2%  1.045e+08 ±  6%  perf-stat.i.branch-misses
 3.895e+08 ±  2%      -8.8%  3.553e+08        perf-stat.i.cache-references
   1759358 ±  2%     -16.0%    1478535 ±  3%  perf-stat.i.context-switches
      1.80 ±  2%     +22.5%       2.20        perf-stat.i.cpi
 1.262e+11 ±  2%     -18.5%  1.028e+11        perf-stat.i.instructions
      0.56 ±  2%     -18.5%       0.46        perf-stat.i.ipc
     27.44 ±  2%     -15.8%      23.10 ±  3%  perf-stat.i.metric.K/sec
      4132 ±  5%      -8.9%       3766 ±  2%  perf-stat.i.minor-faults
      4132 ±  5%      -8.9%       3766 ±  2%  perf-stat.i.page-faults
      1.79 ±  2%     +22.8%       2.20        perf-stat.overall.cpi
      0.56 ±  2%     -18.6%       0.45        perf-stat.overall.ipc
  2.45e+10 ±  2%     -18.5%  1.998e+10        perf-stat.ps.branch-instructions
  1.21e+08 ±  7%     -15.0%  1.028e+08 ±  6%  perf-stat.ps.branch-misses
 3.828e+08 ±  2%      -8.7%  3.496e+08        perf-stat.ps.cache-references
   1729946 ±  2%     -15.9%    1454325 ±  3%  perf-stat.ps.context-switches
 1.241e+11 ±  2%     -18.5%  1.011e+11        perf-stat.ps.instructions
      4060 ±  5%      -8.8%       3703 ±  2%  perf-stat.ps.minor-faults
      4060 ±  5%      -8.8%       3703 ±  2%  perf-stat.ps.page-faults
 7.699e+12 ±  2%     -18.7%  6.262e+12 ±  2%  perf-stat.total.instructions
      0.02 ±194%   +3583.1%       0.80 ±127%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.14 ±  5%     +21.4%       0.17 ±  2%  perf-sched.sch_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 12%     +35.4%       0.03 ± 11%  perf-sched.sch_delay.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.01 ±  3%     +14.8%       0.01 ±  6%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      2.90 ±107%    +259.8%      10.43 ± 35%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      8.62 ± 28%     +69.3%      14.58 ±  8%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.02 ±194%   +5175.4%       1.14 ± 88%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
    395.95 ±185%     -99.6%       1.67 ± 45%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     10.22 ± 15%     +49.3%      15.26 ±  4%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.05 ± 10%     +29.0%       0.06 ± 13%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.14 ±  5%     +20.6%       0.17 ±  2%  perf-sched.total_sch_delay.average.ms
      0.44 ±  3%     +19.7%       0.52 ±  3%  perf-sched.total_wait_and_delay.average.ms
   6639596 ±  3%     -17.7%    5461347 ±  3%  perf-sched.total_wait_and_delay.count.ms
      0.30 ±  2%     +19.3%       0.36 ±  3%  perf-sched.total_wait_time.average.ms
      0.28 ±  3%     +20.8%       0.34 ±  2%  perf-sched.wait_and_delay.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
   6614032 ±  3%     -17.8%    5436664 ±  3%  perf-sched.wait_and_delay.count.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      5.80 ±107%    +259.8%      20.86 ± 35%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
     17.23 ± 28%     +69.3%      29.17 ±  8%  perf-sched.wait_and_delay.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
     20.45 ± 15%     +63.4%      33.41 ± 21%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      0.02 ±223%   +4040.9%       0.79 ±127%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.15 ±  2%     +20.6%       0.18 ±  2%  perf-sched.wait_time.avg.ms.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      2.90 ±107%    +259.8%      10.43 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.down_write.shmem_file_write_iter.vfs_write.ksys_write
      8.62 ± 28%     +69.3%      14.58 ±  8%  perf-sched.wait_time.max.ms.__cond_resched.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.shmem_file_write_iter
      0.02 ±223%   +5863.5%       1.14 ± 88%  perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
     10.22 ± 15%    +103.2%      20.77 ± 61%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


