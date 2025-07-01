Return-Path: <linux-ext4+bounces-8724-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9054DAEEC9F
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 04:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D711BC321C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 02:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF8D1DF748;
	Tue,  1 Jul 2025 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9uonBzn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2177FC0A;
	Tue,  1 Jul 2025 02:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751338692; cv=fail; b=jy0dpkEkpsw7SzFYRTbMH6DHWwIJOrRizTweHKdba+7TWtMfvWIcUMMblTUTIbm/xX/9YsyXeelf30P8Eq9vzdc26yzymluOmngkKQsGEbJFwbw0ih4wCu1sz0Y82SMd/rsLzO4U7tCEa05NhsRG0gmX4shdHW3ll/QoukHgMkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751338692; c=relaxed/simple;
	bh=/FsXOePPbqFI4yPA7rVd46evI/aqOyQVLZvp12XHO6E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BLfPe7kwBZLRycbziK0iQg9PGMTa15tLOk1S0JI6LpSeYpKrHdfTW/VtEJLaBfiHJWWLcifhRWtF4PCg6f57AEuLRDIojBz2EngWp4XLmxj8NtF+MZoTEW/u4kE9I+VKSvArsoLQupWrPW5J+fB2ihIMO+lJmMlXlqJz+EzLfr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9uonBzn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751338690; x=1782874690;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/FsXOePPbqFI4yPA7rVd46evI/aqOyQVLZvp12XHO6E=;
  b=h9uonBzn63agzKHb0ulRt72TA9EMlvYGqzQbSEDa3U9ne70zA3dfDviy
   PQtUcjFMXOVGxChHD0RnNCMu8qJRdGJdf91F7F3VteLGIJn6YCiC9BjcN
   m/Cb/ZcinzX8hinPkZy+4ovE8JDcxMHJjZm411SLkatjehiNs8LWQlWVx
   4rFYd9n22D4jY/rjGpj+zOIbEAmvZQD/iRkKM+aOK1ea8V/ryeTQXsRDP
   BbdnjoZMzpssCJTfZQdsLITAaIBkYVE52sa9UWrdzNRV6RfpIMfjAMCd3
   fE7d+AFlnmmTSq9J7bzc9/mTVY0Zlc08NjDtbA1n5Zo6y9pT9z1hTDSyy
   g==;
X-CSE-ConnectionGUID: wJF/tvodQFyTauCIw44nlQ==
X-CSE-MsgGUID: pz/j6qBnQ9O/Gc2s4F+kPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71146383"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71146383"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 19:58:09 -0700
X-CSE-ConnectionGUID: lE7/SduGQhmR/Nf52OatLA==
X-CSE-MsgGUID: pXYqhLggRWSjKgx9cfmEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="159343341"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 19:58:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 19:58:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 19:58:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 19:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHqnnM/Q2uT5KCEenngW1ae45yvlFCst+csOVj25KDqPFO+BGvuxtIdvUoSYwKGhVj6zIrXan+V3A79pF7r/xtgwMJ+HWf7YTip4sStd5A9H+/4Ac/FFJdOcvr7aAgUteyra5pQ9E8OrVZxa4YXMBRH0MCw8OEy9eqRr5+SRnT996ldCecq7tzrlS5ACf5/EikIP+8Wwrbk72Aqv/ylpzN8VwbjGebE/tfZtzMpmkqftnb99lhK+nvy+eETF29znFlxjFtbQ88xzDgJ3wR5SrjMy/xn1syFX80IPs+owY/SY+zmnNLXGHmXdRyuwDEKEH3MYSIssfQfxX2aY4//yRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZaLBhbphLtktq0H69l4dkK0ezupY7Z7QoVIhiLo7kk=;
 b=pxlvDWTw1R+UGVpdR2RVwwHBekPPQ4zSKeDuMqcbsJ2cDONStj+YcHEd0KjZxNCUkfEqC9GT3JpP8cvPbOGd6mwsfNCiD2gAXvFWxpJ+3jZ0WD2WGPIr/dd+iWGo4+L2jT2KflzD/eaK2FsyGE2VnaOUKFOn+pAXAdUcFQFJ+FgFqc19TiUUvN0dFU26MUJRA+WGdiOB+0HlUGWIYoz78JI8LpMCHqDqNeBv3sQE+3XXx21l/f9XFg4T6C+jt4Bwimz4yd10LqMCLCC3vP2C6Qz3eaMjny73HXP8TJcHb9mhUPGpmrEDz00uUn6dc0svWJROupBlDXfrJY/OwfPK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Tue, 1 Jul
 2025 02:57:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8880.026; Tue, 1 Jul 2025
 02:57:45 +0000
Date: Tue, 1 Jul 2025 10:57:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Baokun Li <libaokun1@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-ext4@vger.kernel.org>,
	<tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun1@huawei.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <202507010457.3b3d3c33-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623073304.3275702-4-libaokun1@huawei.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5aa343-69ec-4948-fd73-08ddb84b0de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?yWmeoLcI5CO/04EIPgWF5/0gMX67KtDigInUDtHi4jd0Ht10GYlnFxsaB2?=
 =?iso-8859-1?Q?s1wn7YYoLLubaukKD8ZszBmjkcnbdvqojrKBPVVPiKeEGYuQUNL3ihapUy?=
 =?iso-8859-1?Q?wE+rbvb7Dg+U+iieXVnRdKhoEqKH35eerFpkpm6e4F9nPQ5E1ibLfWvOLB?=
 =?iso-8859-1?Q?Vf2HEXfqS/ITQagIFzrn2iuXZdP8abae4u4r8wvK8lE1vQUEaSVPkEMk+B?=
 =?iso-8859-1?Q?KBafZz27MMiqG1vV81JPK8EDV7cJGgGw+qhqE/4vy1mDipb1S3QWB5WUFJ?=
 =?iso-8859-1?Q?loBw/SfhKMtFcJ14eyRnls+kWXcU1iN5oeg+Y7M7hU9fLNmNtH+o3xUZpt?=
 =?iso-8859-1?Q?/EB2iD1y7FkpNmwZDa/2ebdD9BPs7KJ6T/z75Rt7IAX368vXvQcHhi6PzX?=
 =?iso-8859-1?Q?Ne2LBtJCjCEMOS1fAtA1lVIULhJ78IoAuufb4zRk+mRGydTUuNon6YLpuP?=
 =?iso-8859-1?Q?Bi7IuFTtmw6feFTvYf++PssOJi+FUhdYn+eDgaqGIJcEtStQW/4hSTvqD0?=
 =?iso-8859-1?Q?GBbB5wUG8OsPo6P07WIY+LQKgm/LySxfe45W732L6AYIsZQVZdn6roc4xK?=
 =?iso-8859-1?Q?RHRo4lHjMH7dXqmTERKZEUDv4j/w6n4ZtiCgH6wPRpTJLJcJ1/Ak3a+bHv?=
 =?iso-8859-1?Q?P4cpSzScoch2hPS/wjbAboWMr9K8rDGTdU0lMQyVatoRqJcahem6iE5JSR?=
 =?iso-8859-1?Q?/JMp6WPLePO+5OEQrt8HNM3Gycm6iZOXpFDAFK5GDM5MkuoeK+HT5SRIty?=
 =?iso-8859-1?Q?nZM5gULVBnWbhvfK7s3W6Pr2w3///tfA+4LOW/tGKTcZxYJFnlZJ8QCCnO?=
 =?iso-8859-1?Q?yzDu3Q7h6LbkpxM6uEnNYkCYG070j5/DVbjTfzaQ76xAl4OZGjW8Pj/RVc?=
 =?iso-8859-1?Q?cSzIIxhfjDN8GXOXosVN5aqXyyZuUbOaXWn7BLoyGwTf7e3CkEQk0PNXQF?=
 =?iso-8859-1?Q?MSnUFnC+uIdRyoHCzG56PsJsPDGjl+zZG5adAfw3R2ZBcPq917fNNFXW8f?=
 =?iso-8859-1?Q?s4A3kBJWYD5tEJfY+U+ITqBUVBxrvaW6V7oshlkMonWYE5GO4qC3gByNsf?=
 =?iso-8859-1?Q?ffWEwyC5Wu/B/koCidK4kds92txnFYZ42rFneUo5bm9alj1lcB5jyudkKh?=
 =?iso-8859-1?Q?V8mY0ulj4XiGHofkUdIg0omMhmJCMu8prXV0UM5AZ1NVWu+25SPbfpVnww?=
 =?iso-8859-1?Q?xvq1KHClSszamtaOioZgpjpzz0W2CjOOHzYASJqVsh9Bdw9ZHQN40v6rHZ?=
 =?iso-8859-1?Q?qwSKyC7KfaFvytcJTUNNxzHvmrRiJLQibXlJOofcOoXC29xGZaCAygUKx+?=
 =?iso-8859-1?Q?rlH4ls+6rQylKGVHg8jWnaWtaYscjg14uAACRHu6yqgI3o2NmBW/6Tbf7h?=
 =?iso-8859-1?Q?8xrQv8A8le/UNYazXFFkGAm06h9gzlj6EekXEDAx4DFp+UFhcc9ncHxGLU?=
 =?iso-8859-1?Q?5y74HZJcfcG0WkjV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?91fVKJXlvD9Hd/aUu3CAI5RgU+Rr/E+JnDGvJpsXAHIYOHCh8ojorY7dkz?=
 =?iso-8859-1?Q?ov/VU6TJuYqYm97nNfqSTta1KF2wqKUKjZCRZw2hUJAOOyBela8WUdB6WA?=
 =?iso-8859-1?Q?IZ/GfvIJiR/Oi5JbjSsomYkDlo5Umv1A/RJbZ9f5ooh/bbRiZJ9VgaZKfv?=
 =?iso-8859-1?Q?+w6pPQDqk4ZnM+6LZD+QIWdr22ot7zqJd6oSijorYidF8ldjbhtLwE59qa?=
 =?iso-8859-1?Q?4GrrlN453blH+P28/KbESzl8QJWs1dSHBjiuakL6YnXV/p1aLQnMQnklTF?=
 =?iso-8859-1?Q?RuAOHi4Jfv66a+Epf+mwpm+rIYajD0mNjeUWsxOvSYDhJJGy1IA9b2bIsV?=
 =?iso-8859-1?Q?vGQJJ8XehIKD//wAJ2eAW0bEZv8wUKOMSQ6Red6WhXmiGEgA4KqSLyZuRY?=
 =?iso-8859-1?Q?18lv73F6ejIqSSLl4zrM7OUbxtOOohGeegXWntuS7jFvwajJ9A5mU4i1Sk?=
 =?iso-8859-1?Q?G9zeWZeC3ueBSuR70ddd1y8Oahxh+cLQ5i+xskBOIshO+Ah/+j4/r3MJym?=
 =?iso-8859-1?Q?4PEeDKgadjzstkl+4V0u2fXZorhZIHaa/CnHnFW1qFsPZZbJA2UBZ59jkV?=
 =?iso-8859-1?Q?2pmP0JuuRjFqs8rEqU2rqCPiOSh7ZWGrRfcz3v6MeapfHmCxebPlRd34Uz?=
 =?iso-8859-1?Q?eyCjjnwapI6DbfC4AujcPSc8+GGleo+7pi4vJKTHm5ALoz5jipnmDX53lo?=
 =?iso-8859-1?Q?7z85Bj/AcVJoGD4BB51YikNKoDUK0kZQG8wiHYiK36tKwEEHlWPiXfL/QJ?=
 =?iso-8859-1?Q?4nlSvvjKr41kgMYmy10CbM3sYn4TSDmv1MhnWfSm8XjwaUGbosm3VNwk9t?=
 =?iso-8859-1?Q?FyUeJR3/wLZhGEfp6asXW0j5P95eg0tfZveW70RjpbCqSrhqc1hw/OzBmG?=
 =?iso-8859-1?Q?KQiJXSJLNrVsRFmCJu7KgOhyKozYBj+rvYal2dHuFMq0cYGMpOigMuTRGf?=
 =?iso-8859-1?Q?43gV6zYLAlAFh8qBcHplD7eEzXn10icEeZrrlxcS5gRIfN/mRc19OuoksC?=
 =?iso-8859-1?Q?KyBHzjobNULtzjT+qxgl0fVTIQc4VlqNjFOtaastPXG6SthOyL/GfyI0fN?=
 =?iso-8859-1?Q?RAuTNrfZqUojIiWwoSPxI1ZGrQ0V1gwnCQybvaE3EqEVo4pq3dpiAVBAB3?=
 =?iso-8859-1?Q?HjFd86Dwl4jz2tlbGoA2vQIW4dX5Q0t1JDW9trs6vrnfRrXlOO/mXrxxbm?=
 =?iso-8859-1?Q?jff+K2FCjHz1yA6bAP5zIE+qk87aYh6NcDOM7Fz4v01gEle6tiiDtPS4ph?=
 =?iso-8859-1?Q?0nk9WvpIasrL1AH+HB6vvpAr9Euw/Wkta/oEy8dmt4x5GsXj0SlKVbdUNk?=
 =?iso-8859-1?Q?/2p6Mttou3xt1VN0qRlNoBQRUdqA3ipUzGhjJclg2cB4VVLW7nZDa8P4QN?=
 =?iso-8859-1?Q?0KYnGH2MLGop2bubaYj56SEqig/dIfSRGVZULahgtXWhQfTiYBiaBAdhPK?=
 =?iso-8859-1?Q?K5Jf0xuTPgTwZhXt9Ysra+ec/dCFjYI723IVt7nUpianWmt75KmSXXFeEs?=
 =?iso-8859-1?Q?FrUQqJ8qApyfXtPkCufC2B+CZUiHimxL0AQRLQiNrkjWtiIwcFVi6/96Yn?=
 =?iso-8859-1?Q?gBYhn2FWXEdJ9Zha+Y31iRnV4je7Rp3Ds44to15qy+I1Q1lX7oUHKFXbMN?=
 =?iso-8859-1?Q?uZZcd2iopSBUvi1O+IJK50RwG6A/BBqvl08tVkZtOtldDIz/o4EMe3IQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5aa343-69ec-4948-fd73-08ddb84b0de5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 02:57:45.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWjgNmL7aTFhnDZW2FMA2C3rxR/4oPtAhZh1jREheXSjuMLHDQ43HBXtQ7tE3FTpNJIzs3Jag3f8D7VMM0shkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 31.1% improvement of stress-ng.fsize.ops_per_sec on:


commit: ad0d50f30d3fe376a99fd0e392867c7ca9b619e3 ("[PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update s_mb_last_group")
url: https://github.com/intel-lab-lkp/linux/commits/Baokun-Li/ext4-add-ext4_try_lock_group-to-skip-busy-groups/20250623-155451
base: https://git.kernel.org/cgit/linux/kernel/git/tytso/ext4.git dev
patch link: https://lore.kernel.org/all/20250623073304.3275702-4-libaokun1@huawei.com/
patch subject: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update s_mb_last_group

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: ext4
	test: fsize
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250701/202507010457.3b3d3c33-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/ext4/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp4/fsize/stress-ng/60s

commit: 
  86f92bf2c0 ("ext4: remove unnecessary s_mb_last_start")
  ad0d50f30d ("ext4: remove unnecessary s_md_lock on update s_mb_last_group")

86f92bf2c059852a ad0d50f30d3fe376a99fd0e3928 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      5042 ±  4%     -10.1%       4532 ±  2%  meminfo.Dirty
    100194 ± 63%     +92.5%     192828 ± 32%  numa-meminfo.node0.Shmem
      5082 ±  3%     +28.1%       6510 ±  5%  vmstat.system.cs
     71089           -17.1%      58900 ±  2%  perf-c2c.DRAM.remote
     44206           -13.4%      38284 ±  2%  perf-c2c.HITM.remote
    131696            -4.1%     126359 ±  2%  perf-c2c.HITM.total
      0.15 ± 18%      +0.2        0.35 ± 14%  mpstat.cpu.all.iowait%
      0.32 ±  7%      -0.0        0.28 ±  4%  mpstat.cpu.all.irq%
      0.05 ±  4%      +0.0        0.07 ±  3%  mpstat.cpu.all.soft%
      0.50 ± 13%      +0.2        0.69 ± 16%  mpstat.cpu.all.usr%
  14478005 ±  2%     +32.7%   19217687 ±  4%  numa-numastat.node0.local_node
  14540770 ±  2%     +32.6%   19285137 ±  4%  numa-numastat.node0.numa_hit
  14722680           +28.8%   18967713        numa-numastat.node1.local_node
  14793059           +28.7%   19032805        numa-numastat.node1.numa_hit
    918392           -38.4%     565297 ± 18%  sched_debug.cpu.avg_idle.avg
    356474 ±  5%     -92.0%      28413 ± 90%  sched_debug.cpu.avg_idle.min
      2362 ±  2%     +18.8%       2806 ±  4%  sched_debug.cpu.nr_switches.avg
      1027           +35.5%       1391 ±  6%  sched_debug.cpu.nr_switches.min
     25263 ± 63%     +91.0%      48258 ± 31%  numa-vmstat.node0.nr_shmem
  14540796 ±  2%     +32.5%   19271949 ±  4%  numa-vmstat.node0.numa_hit
  14478031 ±  2%     +32.6%   19204499 ±  4%  numa-vmstat.node0.numa_local
  14792432           +28.6%   19020203        numa-vmstat.node1.numa_hit
  14722053           +28.8%   18955111        numa-vmstat.node1.numa_local
      3780           +30.9%       4950 ±  2%  stress-ng.fsize.SIGXFSZ_signals_per_sec
    643887           +31.0%     843807 ±  2%  stress-ng.fsize.ops
     10726           +31.1%      14059 ±  2%  stress-ng.fsize.ops_per_sec
    126167 ±  2%      +8.7%     137085 ±  2%  stress-ng.time.involuntary_context_switches
     21.82 ±  2%     +45.1%      31.66 ±  4%  stress-ng.time.user_time
      5144 ± 15%    +704.0%      41366 ± 20%  stress-ng.time.voluntary_context_switches
      1272 ±  4%     -10.8%       1135 ±  2%  proc-vmstat.nr_dirty
     59459            +8.1%      64288        proc-vmstat.nr_slab_reclaimable
      1272 ±  4%     -10.8%       1134 ±  2%  proc-vmstat.nr_zone_write_pending
  29335922           +30.6%   38319823        proc-vmstat.numa_hit
  29202778           +30.8%   38187281        proc-vmstat.numa_local
  35012787           +31.9%   46166245 ±  2%  proc-vmstat.pgalloc_normal
  34753289           +31.9%   45830460 ±  2%  proc-vmstat.pgfree
    120464            +2.3%     123212        proc-vmstat.pgpgout
      0.35 ±  3%      +0.1        0.41 ±  3%  perf-stat.i.branch-miss-rate%
  48059547           +21.7%   58484853        perf-stat.i.branch-misses
     33.69            -1.8       31.91        perf-stat.i.cache-miss-rate%
 1.227e+08           +13.5%  1.392e+08 ±  7%  perf-stat.i.cache-misses
 3.623e+08           +19.9%  4.342e+08 ±  7%  perf-stat.i.cache-references
      4958 ±  3%     +30.4%       6467 ±  4%  perf-stat.i.context-switches
      6.10            -5.2%       5.79 ±  4%  perf-stat.i.cpi
    208.43           +22.0%     254.30 ±  5%  perf-stat.i.cpu-migrations
      3333           -11.4%       2954 ±  7%  perf-stat.i.cycles-between-cache-misses
      0.33            +0.1        0.39 ±  2%  perf-stat.overall.branch-miss-rate%
     33.87            -1.8       32.04        perf-stat.overall.cache-miss-rate%
      6.16            -5.3%       5.83 ±  4%  perf-stat.overall.cpi
      3360           -11.5%       2973 ±  7%  perf-stat.overall.cycles-between-cache-misses
      0.16            +5.8%       0.17 ±  4%  perf-stat.overall.ipc
  47200442           +21.7%   57451126        perf-stat.ps.branch-misses
 1.206e+08           +13.5%  1.369e+08 ±  7%  perf-stat.ps.cache-misses
 3.563e+08           +19.9%  4.271e+08 ±  7%  perf-stat.ps.cache-references
      4873 ±  3%     +30.3%       6351 ±  4%  perf-stat.ps.context-switches
    204.75           +22.0%     249.75 ±  5%  perf-stat.ps.cpu-migrations
 6.583e+10            +5.7%  6.955e+10 ±  4%  perf-stat.ps.instructions
 4.046e+12            +5.5%  4.267e+12 ±  4%  perf-stat.total.instructions
      0.15 ± 24%     +97.6%       0.31 ± 21%  perf-sched.sch_delay.avg.ms.__cond_resched.ext4_free_blocks.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
      0.69 ± 34%     -45.3%       0.38 ± 24%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.04 ±  2%     -11.0%       0.03 ±  7%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.09 ± 18%    +104.1%       0.19 ± 38%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.32 ± 59%    +284.8%       1.24 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
     16.34 ± 81%     -81.7%       2.99 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks
      3.51 ± 11%     +56.2%       5.48 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      0.06 ±223%   +1443.8%       0.86 ± 97%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.47 ± 33%    +337.5%       2.05 ± 67%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_ext_insert_extent.ext4_ext_map_blocks.ext4_map_create_blocks
      0.47 ± 64%    +417.9%       2.43 ± 53%  perf-sched.sch_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_truncate.ext4_setattr.notify_change
      7.30 ± 60%     -53.7%       3.38 ± 22%  perf-sched.sch_delay.max.ms.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.ext4_read_block_bitmap_nowait
      2.72 ± 34%     +59.5%       4.33 ± 20%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.ext4_map_blocks.ext4_alloc_file_blocks.isra
      0.08 ±138%    +382.6%       0.37 ± 24%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_truncate.do_ftruncate.do_sys_ftruncate
      1.33 ± 90%    +122.5%       2.96 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.ext4_alloc_file_blocks.isra.0
      3.04           +93.7%       5.89 ± 82%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.ext4_setattr.notify_change.do_truncate
      3.66 ± 19%     +52.6%       5.59 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.ext4_truncate.ext4_setattr.notify_change
      0.41 ± 26%    +169.4%       1.11 ± 78%  perf-sched.sch_delay.max.ms.__cond_resched.ext4_free_blocks.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
      6.93 ± 82%     -65.5%       2.39 ± 49%  perf-sched.sch_delay.max.ms.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
      0.23 ± 68%    +357.9%       1.04 ± 82%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      0.26 ± 39%    +205.8%       0.78 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.ext4_mb_initialize_context.ext4_mb_new_blocks.ext4_ext_map_blocks
      0.11 ± 93%   +1390.4%       1.60 ± 62%  perf-sched.sch_delay.max.ms.io_schedule.bit_wait_io.__wait_on_bit_lock.out_of_line_wait_on_bit_lock
      0.30 ± 74%   +2467.2%       7.58 ± 60%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.__find_get_block_slow.find_get_block_common
      2.66 ± 18%     +29.4%       3.44 ±  7%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      2.64 ± 21%    +197.3%       7.84 ± 53%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     87.11 ±  2%     -15.3%      73.79 ±  4%  perf-sched.total_wait_and_delay.average.ms
     21561 ±  2%     +18.5%      25553 ±  4%  perf-sched.total_wait_and_delay.count.ms
     86.95 ±  2%     -15.4%      73.60 ±  4%  perf-sched.total_wait_time.average.ms
      0.76 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap.ext4_mb_mark_context
      0.61 ± 47%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
    168.47 ±  2%     -10.4%     150.98 ±  4%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    125.33 ± 10%     +72.2%     215.83 ±  8%  perf-sched.wait_and_delay.count.__cond_resched.__ext4_handle_dirty_metadata.ext4_do_update_inode.isra.0
    781.33 ±  3%     -74.6%     198.83 ± 15%  perf-sched.wait_and_delay.count.__cond_resched.__ext4_handle_dirty_metadata.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks
    278.67 ± 13%    +310.9%       1145 ± 20%  perf-sched.wait_and_delay.count.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      1116 ±  3%     -81.5%     206.33 ± 13%  perf-sched.wait_and_delay.count.__cond_resched.__find_get_block_slow.find_get_block_common.bdev_getblk.ext4_read_block_bitmap_nowait
    166.33 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap.ext4_mb_mark_context
    115.50 ± 46%    +298.7%     460.50 ± 16%  perf-sched.wait_and_delay.count.__cond_resched.down_read.ext4_map_blocks.ext4_alloc_file_blocks.isra
    138.33 ± 16%    +290.7%     540.50 ± 18%  perf-sched.wait_and_delay.count.__cond_resched.down_write.ext4_setattr.notify_change.do_truncate
    310.17 ± 14%    +263.9%       1128 ± 21%  perf-sched.wait_and_delay.count.__cond_resched.down_write.ext4_truncate.ext4_setattr.notify_change
      1274 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
      7148 ±  2%     +11.9%       7998 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     32.82 ± 80%     -81.8%       5.99 ± 34%  perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks
     12.06 ± 22%    +168.4%      32.36 ± 47%  perf-sched.wait_and_delay.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
     20.55 ± 82%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.bdev_getblk.ext4_read_block_bitmap_nowait.ext4_read_block_bitmap.ext4_mb_mark_context
     27.66 ± 20%     +78.9%      49.49 ± 60%  perf-sched.wait_and_delay.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
     16.75 ± 64%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.ext4_mb_regular_allocator.ext4_mb_new_blocks.ext4_ext_map_blocks.ext4_map_create_blocks
      0.19 ± 29%    +191.5%       0.55 ± 29%  perf-sched.wait_time.avg.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_truncate.ext4_setattr.notify_change
      0.15 ± 24%     +98.1%       0.31 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.ext4_free_blocks.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
    168.44 ±  2%     -10.4%     150.94 ±  4%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.36 ± 40%    +392.9%       1.78 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.folio_alloc_noprof.__filemap_get_folio
     17.42 ± 70%     -82.4%       3.07 ± 34%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_handle_dirty_metadata.ext4_mb_mark_context.ext4_mb_mark_diskspace_used.ext4_mb_new_blocks
     11.49 ± 26%    +180.6%      32.23 ± 48%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.ext4_setattr
      0.06 ±223%   +1443.8%       0.86 ± 97%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_dirty_inode.__mark_inode_dirty.generic_update_time
      0.47 ± 33%    +411.8%       2.40 ± 56%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_ext_insert_extent.ext4_ext_map_blocks.ext4_map_create_blocks
      0.64 ±161%    +244.6%       2.20 ± 61%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_setattr.notify_change.do_truncate
      0.47 ± 64%    +968.9%       5.01 ± 83%  perf-sched.wait_time.max.ms.__cond_resched.__ext4_mark_inode_dirty.ext4_truncate.ext4_setattr.notify_change
      0.08 ±138%    +382.6%       0.37 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.down_write.do_truncate.do_ftruncate.do_sys_ftruncate
      0.41 ± 26%    +169.4%       1.11 ± 78%  perf-sched.wait_time.max.ms.__cond_resched.ext4_free_blocks.ext4_remove_blocks.ext4_ext_rm_leaf.ext4_ext_remove_space
     17.67 ± 25%    +110.8%      37.26 ± 35%  perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_dirty_inode.__mark_inode_dirty
      2.23 ± 51%    +360.3%      10.28 ± 71%  perf-sched.wait_time.max.ms.__cond_resched.ext4_journal_check_start.__ext4_journal_start_sb.ext4_ext_remove_space.ext4_ext_truncate
     84.33 ± 14%     -46.9%      44.77 ± 72%  perf-sched.wait_time.max.ms.__cond_resched.ext4_mb_load_buddy_gfp.ext4_process_freed_data.ext4_journal_commit_callback.jbd2_journal_commit_transaction
      0.23 ± 68%    +357.9%       1.04 ± 82%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.ext4_mb_clear_bb.ext4_remove_blocks.ext4_ext_rm_leaf
      0.26 ± 39%    +205.8%       0.78 ± 73%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.ext4_mb_initialize_context.ext4_mb_new_blocks.ext4_ext_map_blocks
    276.82 ± 13%     -22.2%     215.50 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.30 ± 74%   +9637.4%      28.76 ± 48%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.__find_get_block_slow.find_get_block_common
      1.44 ± 79%  +11858.3%     172.80 ±219%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


