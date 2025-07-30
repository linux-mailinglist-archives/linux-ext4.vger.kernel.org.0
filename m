Return-Path: <linux-ext4+bounces-9231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680D5B15C73
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911CA5478E1
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03D127467A;
	Wed, 30 Jul 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="d89MPjXo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012008.outbound.protection.outlook.com [52.101.126.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879A36124;
	Wed, 30 Jul 2025 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868582; cv=fail; b=J1Oxycl1NGugo+SJert9HYAy+LpHIn2yPabSgnwf3Ry9ESYSJy/QZ8foW6D98/yvyXTs3Sp26LBukHRVpwL/lp4J3O+qurm3vBMhBim5RisQh6QpWgN0h44qqLMJh+WgBlDG5kjhY/E4ZMD/ggEk7FxgWvD/fe0wxB4+YKMOiPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868582; c=relaxed/simple;
	bh=3hY53Hj2HyJ40we5q70TYTt2czWlNcoFI5ucT4Q52bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AGmotRTDs7EpS24ujpwrB3MRbowdKp66Wi0VVUWFuhHmM5F1dB0mD7IHoCmeO/++Vf8CBwyf9gSS7+8g7lQsxj+POnMEG64YWLlKSvbJANoLNxV7OWlsjb0eyiXFD34e3l2UC++Wi6ViIL9KSCCOsAD9q9bGmgrDuLV2SSuHxao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=d89MPjXo; arc=fail smtp.client-ip=52.101.126.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YamxDyAQzxo+s9pv4wEJXFSoTiGebrwEhFrDEVcgeyUwcBjnziwtvPuDYs3FSUa9HDAMjFYtcMQ1G3mxgUfJtp3oRPlZbxW6sm/jNhv8X3MWdGnydoNZ9WzsZKLaP8hvrxSvqno60fdWYke/56g3N8ce7yYWPd6raC+mhmwC4BW1Pt3rp+G/vo+N8eZW9HD7h3WBcr6Xrxvx2RAoAnwM7h6uGr2zLYafRMUMxo+i47ofgZfTaM6SXgjVoeSP2w3Ex212QkHrbVqc3xw0YFqUUaNq008NquqS5S3PFEH8IYNYhgl94XV7kx8BTnP0KaWfSWnP9BC3769SXdRzDmkhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebwzxi93GE81gIg9/wfNW/1T31+sPh/m63ytGMN2ZH8=;
 b=CcOP8pLQeYfv2IGOQBV5E/6ahm6nQfJaY3foFoK60P9P3YDWfDhW8JMUJHn+HgxndW91/Xdf/oT+WHHlabfjY2V+koWb83jFQAOGPRBeUkRTKRHmDD3Der/mi5bR77SBTHNAVSCte4DruR9Ti1Zkh3slf6IrvSOxGMX6b1DsZ2TA8nhiMkfcJn4ybpI+enrTI7hSg+LfEbA4YVSSVnvv6MZw1VzWcmjArsw6/pBP6DzE5ydT0vhT7yPdBu3XqNv6zyMWNmDt53Ru+cQko3wLJAPUz36NgnDbuGANbXVnx94KjrDLEPhhMXrR/M04rgMylh1beE1rXQbJfHj4OqF5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebwzxi93GE81gIg9/wfNW/1T31+sPh/m63ytGMN2ZH8=;
 b=d89MPjXobKVZ/XGdo2vd+Ss+y0Y3kawClP6TAghwtpDwRmItLfzRH037kc8oV+cXDk4gFTeXwUzY3tTr2o1JUjEbmX87ylleh2XjkLNzE+A+HYdQ3Qy7+m/Onu6LrTZJj7QjCG07qZwObPsxfd0WicU7NV+4GR0uKNtJJcyTffoIdJIsetvkllYFaTRnUiEwEWBQDqiYdaG2cVlvnr+XgV/tS8a5YL7O3c8v6IIvpVANY7AVUTkgaSMsyblygUWcvQ9D/i4y8O5i9jQUlV60+yZQDjddK+YRIAFvhvn5pJIlWJ0b1sGndpqwC6ynL2B7wV5asJZ8B8uHlGwlyvSBFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com (2603:1096:400:469::8)
 by PUZPR06MB6221.apcprd06.prod.outlook.com (2603:1096:301:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:42:50 +0000
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2]) by TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 09:42:49 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: viro@zeniv.linux.org.uk
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	zhao.xichao@vivo.com
Subject: Re: [PATCH] ext4: Use IS_ERR_OR_NULL() helper function
Date: Wed, 30 Jul 2025 17:42:40 +0800
Message-Id: <20250730094240.425748-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730064937.GM222315@ZenIV>
References: <20250730064937.GM222315@ZenIV>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To TYSPR06MB7008.apcprd06.prod.outlook.com
 (2603:1096:400:469::8)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7008:EE_|PUZPR06MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 253a4485-f326-4f55-d255-08ddcf4d7269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9D5EYmWz8IzBX6czgnGsGU0e5QO+hlnDq/2fexzsyIy+L4LL1g+kJd5oco1?=
 =?us-ascii?Q?irXqgLHQHZpz5K0YKfvCdsoQeBdfMYIGb8iGXUUo1kea2gMHzH6mSNYJXHC9?=
 =?us-ascii?Q?+fYJNxhk27acaF3qRUrBGUDfep4GvqV3lvwGB+oV0PH3lMga0bGEQCmXrecf?=
 =?us-ascii?Q?61vKMHc+V1cLe4s6RdHsldGhLMe+FKxOgz5dn2E7o52+hixQJ0TO4QlWkiy+?=
 =?us-ascii?Q?m1x1R/kQk43ragfaQZCrlziak45bKxRK9oWYietTme5IftK/vk8BOLxOcU1a?=
 =?us-ascii?Q?XtgJtwApAfCPeHhFFaEyGqSqslwUvBiJr/njfH8GGVvusqAci5QhQVzGSQ6y?=
 =?us-ascii?Q?Y/wB/La1mFFvSbxPhW9w03JrrgJdzI07hiFxASpJwvvjQmZN8aT3/OgYNNDt?=
 =?us-ascii?Q?OPjS9payJ1rM8jX6iXQ+bJK/aSFIbDe8VmBOpsvZXCAnhzvfuXddzE/b7LNo?=
 =?us-ascii?Q?iAuaCRUdP3ejWy7RAz2mzZe8JIV+KFPKUKgMhPbnRhE9wnhSV4NIvbk8jnjN?=
 =?us-ascii?Q?mdDJEYVnfLE5nMbTXyDlcLwQzaEiEEQObGuq3o0LYgswIawdIZ2975ja6bmE?=
 =?us-ascii?Q?pfzRwWRdPnaJQbACkX+SlE3QJgU1F6t3fBmeSOB0zWCr/A/qo5c/5Hqo1nEB?=
 =?us-ascii?Q?w4BpGofmkA47ToqIEF4/GUCGZMORLp7LGgR7oIWRRLl3hHHtKLQveP+LpdZQ?=
 =?us-ascii?Q?LsGTOHlczObKRQ+MhqOcG3WKPyz1H5EIIEXqQ72IGjrFQSbHPSrdJY6FGo1w?=
 =?us-ascii?Q?L8x+SJgXqojYQD1wbn5RXE8leiUsWRqIWAKCBHWB1OVGUPwEBtfTNI9aUqwk?=
 =?us-ascii?Q?FZyB8GYTiMK5sb6/kTrhYkS5j5nrAKXA9njm/iHGIgYdEdjniq4aQAs0uNpA?=
 =?us-ascii?Q?J32N0EFL/qY+ZjQZi9tfwlmZ8ZLv5XL3jZRAB4ctAGo3SOT44Ia4TpwkDTYj?=
 =?us-ascii?Q?YGLyREFEeeqwiXO+GgLZSROT8W/I6G3fym3u7Vhws2T1woNTWSo3OWCFxu/U?=
 =?us-ascii?Q?PUx6wFTEgwIg3ZJjpRTEpAH17pmPKPEP2sMDXvUFvlGYSfKbNs2bDg78RTvN?=
 =?us-ascii?Q?jD3aiZmDZk2kZ8ktMZG9BCT6WQ3gYlzbBetDlqj2aEyck94oJb/cEK9eDgw6?=
 =?us-ascii?Q?/HgrvNjrgBZJInqUALam26ngmlIyYVxY7dM2+okjXyhzfIz5/7becOmzy2vi?=
 =?us-ascii?Q?RkDg0YKmvsX/6JBVnj9a5lLPtSmW1nRjWFoL7eI2X8MD7k79QQXzndgX6Qd4?=
 =?us-ascii?Q?mIsjivvsLOQkCEUj4m0w92IJ7BxnXJ7DvQmJy9ATkgYGMbPIQYgoR8p5Nw83?=
 =?us-ascii?Q?1xkQTeLUy+zGau7I1+cnWYQL9Kk072gkdhWAhPmlUpvu250eGzJP2ZM+xtYW?=
 =?us-ascii?Q?aJlfs1YuyoJzONc2/8RctYvV2XEaRF+aK60ZChAoRLhBnbKwAnXMunv+ik0h?=
 =?us-ascii?Q?qTS2h57AE3Y1ldYn8UjkCU68mThvMSbim8FgPzCdslBuYU+pa4C2KQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7008.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1b04WBG5NsLh1+VsT8LFUkjAb5ScHZbF9nMTeYK+Db/BuCeWqaWNigYn2dJ/?=
 =?us-ascii?Q?YJwqmiKw5vgeldwy1IJFcGtYJpmdiu9uVZxJKxb+egUDUHLdpIzP7y3czvIW?=
 =?us-ascii?Q?Ln+uRkogsXJ2wx0oz16pQaWfYVFSUrUpXn5ctMeXPuLJVuUiQqFDmOsMUay8?=
 =?us-ascii?Q?obHnjAxxx7iS2hx0+dk9GwGdk1JJS/XqX5v6gPtGUksZPKPcZyoPvKH0/Jzq?=
 =?us-ascii?Q?oU4jGHpWTAZ1/ClYtddMmwmH1btspgszWMkkQQIIdj4+SJlH3xlbNSDZvGAg?=
 =?us-ascii?Q?4cS3AZ/i0mGc9urC8FEwJ5bIlFcCQkXwZnywzAbKtK1DHT1U5q1ILayKXZhC?=
 =?us-ascii?Q?7b0j+k9grwrQhvs6zLzZRcE8GCXyAOQmgm2R+hPY1WXSmCHMuZP7Xe6wQ8cH?=
 =?us-ascii?Q?vRQEqpJ9Dnc0FT0DBi1XWPlgUzWUAw7QuDSi/ayMu+p3ZdJPuPrs0wbJBT1L?=
 =?us-ascii?Q?DV1KEZATHeO3XZhYaX0sh0PqlXasr+ekzY0bfsboKgzLK0aLh2oRRh2o+Dvr?=
 =?us-ascii?Q?hA6whSev5G8+WCazpVyhdnKxVMVDyzjMc+av1sJ1ZG5hG/yOYGZ8Nf9JmHqj?=
 =?us-ascii?Q?OnU22g0P75uzqlrZX2F1r11m+A7ifE2Hgbb0htSXt/HtEXtd1VHYdEHotMjo?=
 =?us-ascii?Q?urT9EVFqc7WpTaCBw/wU3xd2WiDoxilIBSiO7xfg7fjekbev4TeU7q3v7+DT?=
 =?us-ascii?Q?eyaz4lHSTypqGvQ8AT3dYAJLDfIbwoJuf+rSpnfQSDb4U3vnwBSkrdSAtb3m?=
 =?us-ascii?Q?fqXV+y0tgWP9gf24VzOx85LUxHGT5oGwPk90lNHpXKxu8YYyw0idswThyEgw?=
 =?us-ascii?Q?tdysg6Df44X9cItl5H3oaFrrw8zjsz0iiZWySAMVbZx6hpJDe9LWAMWBpLNp?=
 =?us-ascii?Q?oJOXj67RoLli3qy6VIplCfM7fAX0FYxoR3SM5+XonKy2dD6KaEiGoT4HDdMK?=
 =?us-ascii?Q?QihOFmfmqjdKigYKEd5ElgyFpmUd0dYcsWDmQXc8POaKdkrODnD924I4xrUj?=
 =?us-ascii?Q?D3N6IVgBK1EbNP5GhFTKbu2FrQmJkqnHDLcrAOd0+akbmJibTi3z+3ZEbgQA?=
 =?us-ascii?Q?bJI2QYK1lK4M/q7vHK7uzNj/sXV8Q2iEJlXl+eaU9mN1y+wFKeegk32nNcT7?=
 =?us-ascii?Q?jCRWIVqkkLK2QZMPeld6WJCxrOz0CVrSeuNKR/4aqpG94pCMpfb+/zcwMDAx?=
 =?us-ascii?Q?guNuEG9a5++0caS5B54P1pd1ZACJnpUCJzmYCaaZUX+qt4XW1BcVWzJtb8ZY?=
 =?us-ascii?Q?VXS1O6uTDKL8RM0x8on3tSEsvWIqjbfxfeyUGveijgikOAEZGWNT7epcwA8d?=
 =?us-ascii?Q?4t1xiuWttxlf5Ld27qhAXsnAEHtLysgXWSyrU6VeGw0/FO/GhklahujsOHRs?=
 =?us-ascii?Q?a3lfrtqUejUE1KX/w8N8SVUe+kPZv5TQY9D1pO5nzlk+Ilcjas0KeEmkGRwL?=
 =?us-ascii?Q?NEryhaOQS65a4Zl/RsS0rF6fEvmuez+QgJ7kMpBeQBSEx45YEEvqXCknEV4m?=
 =?us-ascii?Q?BI9gwBSb9iqR7Hxw4Rern614WpsHTGfwnYl8/IrjAJBwnGWhfMTes6ZS4YXa?=
 =?us-ascii?Q?jeRwY2AOGm94592b7k40+d0r1k5A4NeEJyF6QBIB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253a4485-f326-4f55-d255-08ddcf4d7269
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7008.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:42:49.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNdjPaJeyQrvrJyPwIiyx5yHTl53Rjti5/BFth55Vb3mxw5loyM/xG/d53YVpA6FuBfd+UQCRigqSNLtQSWd1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6221

Thank you for your response. As a beginner who just started submitting patches to the community, 
I mistakenly thought these could simplify the code. I have learned a lot from your reply, thank you very much.

