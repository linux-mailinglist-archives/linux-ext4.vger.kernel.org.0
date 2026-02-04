Return-Path: <linux-ext4+bounces-13522-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDg3DlNTg2mJlQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13522-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 15:10:27 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2366E6E3A
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Feb 2026 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AAF7300825A
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Feb 2026 14:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20D40F8DF;
	Wed,  4 Feb 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwUYtilz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852A40B6EA
	for <linux-ext4@vger.kernel.org>; Wed,  4 Feb 2026 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214224; cv=fail; b=XeGQLXsbb4umDmhEejK8UtSebcGvYy6U6NG7Fz1TVISFWdugn37XonUm02B5eQhmuihn/ftMbUHDHkuVnHXtsOPd6Zo959jXmIs2Sa9k1ZnzRSDpZVlaZnrT2sYPb5IXdJJi+IzOxvinGHv0QOahIC1sk7Cl83dyYw4ME/sjZRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214224; c=relaxed/simple;
	bh=nVIA2IBH7YfcBLTuwPP/D2oUv1CTk8xN5V6ZgjeR7YY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KL1K3fPKQTjqwZRHPMOy4HeUTAj+nFQB37Ey7VpIHGdTxEraGANlzGT5lFX0Nt28+16s2TwiFKsRv0ENdtCZ1FLVg6PTQJHk9793qSSOvWR+Wg9aZL8Ks4TXNa2PN9/5iAeTTja4FHaW5L4oXNMRrBHuIoDw3DsvELzZ7zNh2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwUYtilz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770214224; x=1801750224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nVIA2IBH7YfcBLTuwPP/D2oUv1CTk8xN5V6ZgjeR7YY=;
  b=DwUYtilzYMIh5Dnw6aMECiENwfb8f1g363gIl93A5tCKODxP8/OQIvp6
   El9I/F+BvPWHV0JcOt8jsb7CqoEzzEa1iV7oj/kWiMSJSBmLA5Kd08qr5
   QuwASQySUmtwV08LZ43yhNzah9xQ4qLVD/tugivgzzS1MdYOY5gWfVhum
   yYzTk/NWq8BLBWpBx9IfRYY7nOAQBUB0R1LDhC3N/optUTj+tleyFB4zC
   CWDl1x9wPYNuuu1Ew026+PGHnP1NMz6hqudjAtE5e4Whhf3O/q25RoXFy
   JpISrcMbrsBwVVKtiE52ctHlie8oXT2l+h4TBZWsuRXtMvCZHjnX/b9nR
   w==;
X-CSE-ConnectionGUID: YYyw8BH1TzuFRIb7aDCCdA==
X-CSE-MsgGUID: n5OTLI60TDih01kWKpsgrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96853160"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="96853160"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:10:23 -0800
X-CSE-ConnectionGUID: LxJwioCPTqWZe/UVg0qndA==
X-CSE-MsgGUID: cU9daeeNRVaw58YrFBWALA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210218208"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:10:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 06:10:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 06:10:23 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 06:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5iX3PXqECibaHnqBHr0hwvhb/GCeOsrFbCHcpOGYhsKgF20+5L/WqGcXi8VRKzNZn6YYbGyli4WUvD1HAEQdsb3mef65J8I7vYm8HBP76qhauvYNy78hKEBNE9gcee/tgCl8JgYqV9G+9NyQ9r2SCTJzEjoaWvKhpjLd6Pr9L7D1JspIGW+d+3NGHkUXsQXVdUk2VGWB+1coPYyqoB4j1EFhOdMTDvRommRrwYypm+UizKejrAbRe3fsM5KClqA8qrmunvnmTGrpFPZgBeNLJlnD3q9dFYbHopKNMbbx/tTzZLCm0eWUFHMM4J3+YWNeGusheKaaq6KaLdfuVyNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2rd87UVJtewQ1S9wQmp7aIP1lK1ok209fS0L0FT5zY=;
 b=L9SY66brBElwVwaP1/h3qX+W3jS65+Cc99bbzP/XyaSJOZFkkXVqQOLvSu6CPlStc9MoY2RapIzit6zjioJVl05EuZzdy5aZEUo70XZzim4uwDcph1a2iNu+ZtcVNp+bTGozq/h2fr8VzaY2aZ3HiWOONHw0+MXKIUHi4JaTEdl+lKntM7FLaMap204T5/nGlhIlQ2AGIBt2AbMKh3Mb6zY9LI5f/41JTeA17HNe6pjJIftwavexV54weboF6hvUzPY9ZasloQSX6POm4du8Li+3FUHblgVkQuPP1rqgJa7xnEeoXdYlqdfTanmHjuSrLo7DBEGQRHWWSdMJTkElxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 14:10:20 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 14:10:19 +0000
Date: Wed, 4 Feb 2026 22:10:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, Jan Kara
	<jack@suse.cz>, <linux-ext4@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [ext4]  81d2e13a57: ltp.fanotify22.fail
Message-ID: <202602042124.87bd00e3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 729f3a4c-8f16-444a-8ae9-08de63f720b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Re+Y9oF+t/6P6Zjh4pOEDe2sKBNBMGtZNOVXJ/ZKf6JIvvGFercrVvoLj7kt?=
 =?us-ascii?Q?wAikOjcVrjPG9+cMAdmmpZrn155wbzujmFzQrBv+8i+S8n66hVwNbv2ddYT2?=
 =?us-ascii?Q?G8ty95VHz3/REoMGZGUJyflm3mUl5E3bYQkxi8k6yvn+3MRd1avRGkTHU5be?=
 =?us-ascii?Q?lVN1o7OdB0r6B9NEM591cKiH2sp3MqUk54ZEK/DZqb4YVM+4T3BlDzB0M+8X?=
 =?us-ascii?Q?OVq4tcawfawGbuv91szTlJ0kSE949e4cU4livvQMA/3GdnxFXu37D/FwwO/9?=
 =?us-ascii?Q?7DLxyWjko9rKCVf3vXHMT947Y9Z1pm0XgteYcbHWQkodNsa2j6MnS5A8ji2l?=
 =?us-ascii?Q?gn3XQl6Ttd3To+wJGsGlWtjTYw8QkgC4vxKC1A3pZbvbHTrXrEcZBFC+VUpm?=
 =?us-ascii?Q?YJMNlmTlZ+iAO3JYeKX3BmdO3WG3RT+GMwQ+9snCfz+0frzE4F0wrQKuH9PE?=
 =?us-ascii?Q?yybJ83QDLOa+au4V6WeD/Dac4QLeaJiLqPI2+pPm+HDAR780vWfMH7xyH6bS?=
 =?us-ascii?Q?qaK1fbZeqieX7SGKFC1vhypkV2n0rdsrX/RMFNDO2AzKuTxbc1qq7ecRg6J0?=
 =?us-ascii?Q?U5TZwVas87MJUZ3LNrOZA+ylU28dRsx4gPXPrY9ZdsfoE0wZil2DGz3Vn3tP?=
 =?us-ascii?Q?SP9DcF6Qqx3AanbbRpP29VLEC1dPimspcugC3368LF+tTZv56wI7CF1kr3Wc?=
 =?us-ascii?Q?Pwbw453h7748TC2OUeZINs4EXV6HRWo7KsI0vMp7RAbKh9YOpXq8Dr8LNWpc?=
 =?us-ascii?Q?Ud2fGkiECY65JWVsFn0VJ9yzYo62wGvrkP3Voc2j0AAm0QM+5VHNDTq+fjD2?=
 =?us-ascii?Q?oZGMFgvMVXGS/5xEnTp8yp6HDUkoF3ZHrgoWfIuEyhqv7w9Vu6EIP336/lnp?=
 =?us-ascii?Q?vhQoLjZxRhcWYCg527G4cpa2jj46uR3imSDLr7jQcDAoT6ascE5dYky9UAAD?=
 =?us-ascii?Q?QzkovoxTHp1icxT4Xd+ynfnh/y1CS7/i+AfvYAz+wPl7rqkRSpNwFOp1yFMV?=
 =?us-ascii?Q?P8/z/LEBlI6Phz9UFPR9VBH8zpEjWqkuGdbd0/kx7M7XJH3jKvjxPxj0c5oA?=
 =?us-ascii?Q?CmB25DCHkYx1M+5h19OBlRo6DK6Eb3a81yN9SSKvNgD52Zq+Sr7AlXOB4wpP?=
 =?us-ascii?Q?8rVVgEfqLYMSOeAdbeGWUtlbSPcfi1dkn8qemSaMgzwB0AXhGtQsJkoiQo1/?=
 =?us-ascii?Q?95XjReadeuaJGWaJhJJC+Bels6Ns5UtMGDdbN/DyCZz2dFUgod16xMVg5KNP?=
 =?us-ascii?Q?+b0cY8tSQkvZpGG5K1ZsWUO2f8H3bACWn96jXe/gSBU+W67sL/fAPrVbMOo8?=
 =?us-ascii?Q?HRT4wfHXpfgR0zGzmaYQVocmOJBNtmBD/JRdSEnm4PT/UBgdb2c2VgX2xVPG?=
 =?us-ascii?Q?mlQpF6CyUXXXNdCmjEQpVts9YxvDdUC8xsg+bPomRPfiOAvVlNKYfnSAFkvs?=
 =?us-ascii?Q?DizwkYZ8He70hoyvwVjkH45RU94DVDaBLYV5aw21K1d2ytMUUSLMVurhBaTX?=
 =?us-ascii?Q?ZLIA+7NplutwPgzzsDQQ2U2dSqEXmBNaGvsQZMYP0zQx+ZjggpTXwZdXPguo?=
 =?us-ascii?Q?+Gfc6OleojyZXyGtdazoJgPZ3W/hHGuDJxoUS49o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QFioKacidsBPqxjwY+Lb6eK7QwXzir3TsHt1oJRLinA4O0HxyJUBX/KZbeMq?=
 =?us-ascii?Q?3wJDnWjFVzmiewGZkNTZcWyYA1dfxbsZSWn+Kk8CbGQq4z3kW+lhPhV1pCb2?=
 =?us-ascii?Q?ekHxWjLm1LUH1j3HxD809Nm0bb5Q8/k5DBSFRkK8dgYMivEToge1Wed6sxiM?=
 =?us-ascii?Q?6dG8p4Xh/YHTrkUvPal8gXbQHv9x3z0yJG61g4f1fqLeRE1DjANzINoolJlR?=
 =?us-ascii?Q?pcWeQaI5hJb+ShhS8CCYP/XZ5E+iRKZQ9ELUwWGPbFsn7EZDYO95AEy8CDxY?=
 =?us-ascii?Q?05E1TgaxP14zH8iRbrdUx7VdN30voMYlsNLaWUD+QSw7u1SQjpFDtiE8ebzN?=
 =?us-ascii?Q?z1o6rSCa5lj9X1WYmjfUOkNb8BR7lmhPNkjnh9K3jeSv6Efjr/wcd01hrLZF?=
 =?us-ascii?Q?5MvkV6ngTW4NjXcIPBHPZCq32ZfG+4GskA6qhruPbboF0W6BDrhTFqlhl22r?=
 =?us-ascii?Q?zqfBedhIgmpvy9U7dv6nyrzIEij/Jh3R0qm37h9/RpHtghGV4LgCpKgFs0Px?=
 =?us-ascii?Q?Za2ijewGKQVZhzrY66aZCJzx7TBH87CV1scpqHONWQoPpbHjyIiVyZgKpIGs?=
 =?us-ascii?Q?zOcqsmMJTrkDS9uP3LY5ezFaPRg6qjsYaML27EAzjOT+ZX7DrbSVlrHPlLrv?=
 =?us-ascii?Q?Vrt2UVO7/84bhaSTdxsCHrW3+c/MiYRZRvv48hTRXKO7Y9+V8xoD3bA5cvyN?=
 =?us-ascii?Q?wUphWn7NpNZ9y92f7+C3wVRVcW67JNC7JQWMj/s0DFGm5obT/EmHxQ/gFQs7?=
 =?us-ascii?Q?Od8GNKYv+t3Rn/KwR1kjtZtI5lAMASxO58GaUgPhw/NEgfBNAubaWc193HOM?=
 =?us-ascii?Q?QX3aNtISjivPRe1+JGtTVPXgf/3Ue7L7eRgjzzqRHrwfN3WXUhgqIJH2tcUi?=
 =?us-ascii?Q?FYGSPFtFeK705dcn1UCrBr1/EExn/1Q9OCqnF0bLmTK45yZDB+6ryAi1scIz?=
 =?us-ascii?Q?LKIFjxZpUxaynYZB/IpLIU2LbrYR6l3rLNgdtDIjhVMS+OEu/ulSfCndyTYP?=
 =?us-ascii?Q?ISlk3fFIcLyvBFY3fxu7+ewTYpNjzxA1ahLsBAVUkVcpqa3zvDyk4s7xENPy?=
 =?us-ascii?Q?4O7HoSQRg2G8iSaCzfN5vokn2S1lfGwzgbdm2tAh0NWlLPZkmkfmyaTgSW6B?=
 =?us-ascii?Q?VO13z+HhqvS7Arn3204b94FaoyK4eAv2EAOjv7F5PNT4iyTAmBt8R3GBTqR0?=
 =?us-ascii?Q?+z4eMOurkYeOhnbl69xfmiH3451ygkezSqZ1im02DafQ3BH8cLJE2HXvqapp?=
 =?us-ascii?Q?j9u0qvyvodj5PDa6qUCXTR2XUgYYQF1bgg+C+bVTCKQRhrL8bZopOQygxwsW?=
 =?us-ascii?Q?at8yM/FysJI12frb7+06Z8e4MeYc/33RlxTTv5G6gfnNZN79l8o7ByA9CIJy?=
 =?us-ascii?Q?j0AlcBCvsidIQ5azLo8MboerwAnryMBGUzz7SV0sWyasIusGpOAz93P8S1rG?=
 =?us-ascii?Q?ROLD0YFQXRkHVqdlb+WnDGM0SKnDbpJak1/6YgnMfNnXR/97UqHMGZBPf1G/?=
 =?us-ascii?Q?sPrSCoOzUp9cDgetMIcnzVCFPGOhKdaep8vW+E1a1jcy3UUmkAT9U/mwF8n8?=
 =?us-ascii?Q?bp3AU2yGybgU5yF/81WCjAv3kFiWeLyFFYe8jxSaVnrmlmFLoeyNu0zh6PI3?=
 =?us-ascii?Q?214+JoIUYxsofoA9+rmpE5N2JwM9GWeUCSoWHdCqlBiUiKx9gRMAaycDZKSr?=
 =?us-ascii?Q?1XAN1gbJ2ifJDQK61jWxd0ZrQzBpQdzbfXE8J7yThABUAw2Ug2SJt+CJX2uR?=
 =?us-ascii?Q?jUpa2C7PfA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 729f3a4c-8f16-444a-8ae9-08de63f720b4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:10:19.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0q/hDGnhjyyqz9jhOP/xQLP2gKO3yYYs5zKuqdasmRnveAqKo/cvdLI0dZ73QiGaO2MmJbfSr9b6kYD2CdNUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13522-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oliver.sang@intel.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D2366E6E3A
X-Rspamd-Action: no action



Hello,

kernel test robot noticed "ltp.fanotify22.fail" on:

commit: 81d2e13a57c9d73582527966fae24d4fd73826ca ("ext4: convert to new fserror helpers")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 33a647c659ffa5bdb94abc345c8c86768ff96215]

in testcase: ltp
version: 
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-02/fanotify22


config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260204/202602042124.87bd00e3-lkp@intel.com


user  :notice: [  423.546026] [    T265] 	Hostname:   lkp-ivb-d04

user  :notice: [  423.554417] [    T265] 	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]

user  :notice: [  423.570800] [    T265] 	Directory:  /tmp/kirk.root/tmpefuyb6o0



user  :notice: [  423.584852] [    T265] Connecting to SUT: default

user  :warn  : [  423.586640] [   T5587] /lkp/benchmarks/ltp/kirk[5563]: fanotify22: start (command: fanotify22)


user  :notice: [  423.605665] [    T265] Starting suite: temp_single_test

user  :notice: [  423.613894] [    T265] ---------------------------------

kern  :info  : [  423.633832] [   T5592] loop: module loaded
kern  :info  : [  423.657047] [   T5591] loop0: detected capacity change from 0 to 614400
kern  :err   : [  423.821741] [   T5591] /dev/zero: Can't lookup blockdev
kern  :info  : [  424.033575] [   T5591] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
kern  :info  : [  424.098309] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
kern  :info  : [  424.345598] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
kern  :crit  : [  424.414068] [   T5607] EXT4-fs error (device loop0): __ext4_remount:6794: comm fanotify22: Abort forced by user
kern  :err   : [  424.423984] [   T5607] Aborting journal on device loop0-8.
kern  :crit  : [  424.463989] [   T5607] EXT4-fs (loop0): Remounting filesystem read-only
kern  :info  : [  424.470416] [   T5607] EXT4-fs (loop0): re-mounted 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 ro.
kern  :info  : [  424.479591] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
kern  :warn  : [  424.490528] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
kern  :info  : [  424.539426] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
kern  :crit  : [  424.552662] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1785: inode #32386: comm fanotify22: iget: bogus i_mode (377)
kern  :info  : [  424.617262] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
kern  :warn  : [  424.703481] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
kern  :info  : [  424.752431] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
kern  :crit  : [  424.765440] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1777: inode #32385: comm fanotify22: bad inode number: 1
kern  :crit  : [  424.776331] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1785: inode #32386: comm fanotify22: iget: bogus i_mode (377)
kern  :info  : [  424.845037] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
kern  :warn  : [  424.928434] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
kern  :info  : [  424.985535] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
kern  :crit  : [  424.998543] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1785: inode #32386: comm fanotify22: iget: bogus i_mode (377)
kern  :crit  : [  425.115411] [   T5607] EXT4-fs error (device loop0): __ext4_remount:6794: comm fanotify22: Abort forced by user
kern  :err   : [  425.125337] [   T5607] Aborting journal on device loop0-8.
kern  :crit  : [  425.191808] [   T5607] EXT4-fs (loop0): Remounting filesystem read-only
kern  :info  : [  425.198225] [   T5607] EXT4-fs (loop0): re-mounted 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 ro.
kern  :info  : [  425.207311] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
kern  :warn  : [  425.218247] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
kern  :info  : [  425.255422] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
kern  :info  : [  425.300422] [   T5591] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
user  :notice: [  425.421952] [    T265] \x1b[1;37mfanotify22: \x1b[0m\x1b[1;31mfail\x1b[0m | \x1b[1;33mtainted\x1b[0m  (1.808s)

user  :warn  : [  425.427743] [   T5635] /lkp/benchmarks/ltp/kirk[5563]: fanotify22: end (returncode: 1)
user  :notice: [  425.447575] [    T265]                                                                                                                                 

user  :notice: [  425.463971] [    T265] Execution time: 1.866s



user  :notice: [  425.476018] [    T265] 	Suite:       temp_single_test

user  :notice: [  425.483786] [    T265] 	Total runs:  1

user  :notice: [  425.490690] [    T265] 	Runtime:     1.808s

user  :notice: [  425.497330] [    T265] 	Passed:      3

user  :notice: [  425.503518] [    T265] 	Failed:      1

user  :notice: [  425.509637] [    T265] 	Skipped:     0

user  :notice: [  425.515735] [    T265] 	Broken:      0

user  :notice: [  425.521820] [    T265] 	Warnings:    0

user  :notice: [  425.529960] [    T265] 	Kernel:      Linux 6.19.0-rc1-00006-g81d2e13a57c9 #1 SMP PREEMPT_DYNAMIC Sat Jan 31 20:49:54 CST 2026

user  :notice: [  425.543805] [    T265] 	Machine:     unknown

user  :notice: [  425.550576] [    T265] 	Arch:        x86_64

user  :notice: [  425.557336] [    T265] 	RAM:         6899604 kB

user  :notice: [  425.564451] [    T265] 	Swap:        0 kB

user  :notice: [  425.571112] [    T265] 	Distro:      debian 13



user  :notice: [  425.582858] [    T265] Disconnecting from SUT: default

user  :notice: [  425.590377] [    T265] Session stopped



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


