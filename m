Return-Path: <linux-ext4+bounces-6975-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5CA70EA0
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259B317887E
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 01:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F9219E8;
	Wed, 26 Mar 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EOCOAw81";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c3aWQlFT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095062E403
	for <linux-ext4@vger.kernel.org>; Wed, 26 Mar 2025 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953782; cv=fail; b=PO9p3NOL95zpmrHHotUp56ifupGq6FybEGPR4OQMmBUf7e7bwlnLYR/Stk4NhXwo6ivC3xjLpUs2v2XCO6Cpr1Tb/T3bCOpuVhFQqZmk3uALvw2TUDey05uNmOmCIZQhVrXgyIBlQY2LzUmjcpVA6TJz1umuPdq32yuJLQAgKvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953782; c=relaxed/simple;
	bh=Jsm5+uWoYnk0wAl2wbu2VZUy1HHFFsgXWUNHD41zt2E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PIPP6ri+sd6JgNpVbjHgqItiw42TFIMxLPYIB+D/+OHb/zYcO70crv5ojBr91Pkuu9Z9syEEiMwWlLmNLw4XRwH6/DImH8LDgoniGWd3N3C2dOEnXCkAWU+Qo3j67YOG8ZXc8+Nv4Xi/REFxIopQI3DplnHOQmro2qOMoboYj2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EOCOAw81; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c3aWQlFT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtvCW032312;
	Wed, 26 Mar 2025 01:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=k7LwrXI3ml/Ie0R5
	Y85CS1PPTBW6g5qcIRl6LCseiRg=; b=EOCOAw81sUrDBde3Bs4SuQN8CVS44A7t
	C3oOW1qKYtqud6e3fPNrJWgypid0L0bZgVjnkSKdypHDi5KJikyeOB8u8sVSgIJP
	ZjfAVh0YyL1rNx5E+uELXPDsEHTvJ453el3WSbw7d6o0eOnBDsvv985sEriNPHkN
	gC6ptjU1542mv3JPMIBfAdIUdv7WEXYq1yk+SgK6nMAWAL1xLvjCuFBHNpvljLIK
	dHQfFUtKSRnd3FEeM+CXR4GnxXoJx4jDF7NHFCD9t3NPJ6R/1tll5Ra0Qgipzt9f
	BUBYYUR+ky8jTjP45xxuCX1/Skwl+3HlTBOrrHNCz27cwmkfdJripA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd68cxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q01bTt008223;
	Wed, 26 Mar 2025 01:49:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6uxbuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyGBXHapNq9EgzmnXrv8xQXeGirsILiCA7+gYLNnA0I0GPtSFSmBVqa5ddLQR3awv1dfKbWMg9rmORnHIlkbyLsGO5oG3fhVAs3QDfOgxqdsroBjB3CYGC72M8wohGCJeupczNqFd2Mce3MjGvMn2lbpvnBaD2q//+0aN4Q/ak4h7fDL+RtPWII9f9/cW3F9SISVP72GjzE+J00P4Dmqy+pIizMV4yX6u/0QW0gkiVDZad8iXu8LnZ+T/WKaXz4mZnKs1FXNbs/Bjriu6iJ3W3T7cPsnAfGoMdE9KJA4c2ZWRgcDEcr2+Qx+CoGJI3QykoXWhb9SyzsE5HSzgghdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7LwrXI3ml/Ie0R5Y85CS1PPTBW6g5qcIRl6LCseiRg=;
 b=X8DHB38eamRezG/50QM4L8uYdXuNBQ8TQ/Aa+B5b5WrLSQY5A246GzdBwdDcUlRpRRpntnoVWrxUt234PRD03MRYp6yrPaMROewaa+i2yct+/lpJokmZhvLiUByR7Q3rnINC/cJ5ocQOnzPUnL3Ick8FLDxNM6wmDRMrs1By6F/vjC+hUV1eh0LhSuLOOnPGzSztLmO5AJWCOC26UhBBqF6gV84lIXKvhy9J2oKY+OyrZOm+b2sjxyR6h0gHc/wnBMbqD2s/8YoQc2KOpM1CDJuCwkrxchqo+/0WJKEcgM70qM1llUIEp9Fc4BfU1D3IrTO459mM02ux9VMAyxZiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7LwrXI3ml/Ie0R5Y85CS1PPTBW6g5qcIRl6LCseiRg=;
 b=c3aWQlFTNRuMdazwFJL4FBdPg3AKvZdBw2Zl/KnIn2ZKXDwN67jRJHNy5Vfs5xlXhbZk6dYCPgsB+s11XrYpaLVc4YozxIMyEe66fvICiSOPeo+x0VY0sF8PWQBWFCIz0uX9LHdZcffAPzxeEJ2xpjqhyH//CNfmTqsMUqr8OvQ=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 01:49:34 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:49:34 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: djwong@kernel.org
Subject: [RFC PATCH v2 0/4] remove buffer heads from ext2
Date: Tue, 25 Mar 2025 18:49:24 -0700
Message-Id: <20250326014928.61507-1-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0138.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::31) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 1768d976-6e76-4322-a4fe-08dd6c087526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KhOQXe3eAh9kT3udKqvamLuVx8sqOrr+HWgLIh1Q6BOB7Ft/ZJC0hMV7gtB?=
 =?us-ascii?Q?dq9GVrjSe/xplQ21/fdBfBbA3glIJbP/TzXKk3fWIqIDPBxBqAon6gL/y5ak?=
 =?us-ascii?Q?lskJG40LMmRZ7ByKInrvk+1v2ihXkaPcjgiVxGgThTV61liaEfAz4Nf5duAb?=
 =?us-ascii?Q?8nTKuz/TkB2dbxom7dwxUMlLYbTss+7bVxhN73lrLQp4gCB+YYsFlWiV3wfr?=
 =?us-ascii?Q?Cy5KbskdjhCKHgiC4fUnTtjxvHyo1DUjg9SB8gbsNLTANRrrFKULXOaZW1hG?=
 =?us-ascii?Q?8CB//Gf6vvUMj8K3nFG+0P+RShVTyD6PL2sndSQlLwvx+KZhHG2dHaK/kSUN?=
 =?us-ascii?Q?Y7ItFprGXE+UUF9w8sGiRd+RS4ITSIBIhMgEVNOStbM3EFDSQJEWasLEMNpD?=
 =?us-ascii?Q?WVv1tQAD1bLmeYqgRQSdPTuF+UbVX5GWrVHphD71xt2Nqe5I38vQHIcZtAkX?=
 =?us-ascii?Q?nlYLOsVgGikUMHarQ3v0wxblHW/KCVGwvlr7oD67HwwAxbf4Bf4NWF4ArQfQ?=
 =?us-ascii?Q?POgZsJHvwZ3AhC/OwEsBQh8K6fZCEoMtt2L67VnfGeLMXQHbrZZS40M+TPGd?=
 =?us-ascii?Q?fdHT8IHCkBY6s/SyhfhcZqokxJD4rHV0xPLuXas6+NO6+blyE9jCBYXxY+/w?=
 =?us-ascii?Q?zuxH72vXnollfpDYCwhiqmJflGuCqfhqnxcKTk17TOqCth4gPIMBsJZScYm3?=
 =?us-ascii?Q?meual9o8fl0yUmbiYbd6lmLoJb8sy85AsGnHwdQnOuko7q/MJjtU/i+jzArV?=
 =?us-ascii?Q?6rg9ob62RJLgCFLuKj013QHYmFcJYvVHZ0e2rYBSJ629pl6yShvP+WtzbNMD?=
 =?us-ascii?Q?pHOnNMfLbjvt5qZTppzrNNtS7H+X+/iLKbi1jpOTdhosDM5NjR+TyA3MbrVq?=
 =?us-ascii?Q?PyqarvVrw6AlSRFe3cptzmWWq/JNCD55Oy4t0+GRzJgohxrqBxgTlYyRfVOo?=
 =?us-ascii?Q?ab6l8hsq4/wd+j13gDIdOogsd7sZlhTuvnCv4AIDFAlB0pRLKGHHJWnYozIe?=
 =?us-ascii?Q?qsCffXwCdamxeztTpj6L4Kt6bWr3xOz6nNyzqkUrTHoAFO7zfWsHoYC/uz3i?=
 =?us-ascii?Q?1+WMqHrhjAOyh0gin+Rmhl+hpBGaIPV+DtSlbHVkEQKsjGRM1T73Ls8DFkMd?=
 =?us-ascii?Q?VCYlRF94dk6z3JBzofBU3sjAFa4QC1JTwONMQQKBs2XENGDiIH9sUjSdimzB?=
 =?us-ascii?Q?QyKWTOBbHKWXi0cCdtcci7IldU76FUbXc8ShE9USmSZg3frtwQ3KBJw1CLuZ?=
 =?us-ascii?Q?NzT/2vZHx5XlQ/6OkXbrI37M+I9Fad4Yf0EkLzEgwyFzTJp4S3FJxdwy2YUz?=
 =?us-ascii?Q?7SXgegQFX6yheZtwj/cjxmzq+X3sZCc2RnY0vjJxijS2i1SVkoo1II5mpWY2?=
 =?us-ascii?Q?ahs8iXcDzSOYaqP1+TvLWZtRRrXh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+rE9sKOZCANGiPppU/QItQADH1imDr39iUVKQFICBCvPn+gTQNduqFwnKIhC?=
 =?us-ascii?Q?6tDmkcyUzdFMrxFtl5vtgLS80JzGjQKDSCeG9LlTyOxdUc7Gt0cXSL8GIWpm?=
 =?us-ascii?Q?eXd4N2ZCyahdBA59ARsLvvYDbP0S+8GGEhBIRAFMbfACe6dZc3qHImE2ALPS?=
 =?us-ascii?Q?Kj1pP1jVQNsjhnLfHt7JeUQM0QOMOJEeW1SIf6GKau0SRSG6SBFhjGW3uqdh?=
 =?us-ascii?Q?7lFlyyzgUZet+umvHm+DlwN0KCTVo20HQ633aJqg5VHzhiHTdexFWCbrfvgc?=
 =?us-ascii?Q?DON9Zm5/BFSv4VUfGMZg9LbKObRNzogEr2wsuL0Bc9e5w/Rgkgosgq9Yn8pF?=
 =?us-ascii?Q?iTebV6I3AnMFtFBDIJo5WMMh+mbBDouyjpWa9i43573LLhzHxoZrFmyq8r8h?=
 =?us-ascii?Q?5x5l2dYxOhl07dlOrn5jxwnUS/apC6dtj+PFjq0Z9atjCI0NThaNtkTfJTdb?=
 =?us-ascii?Q?v2gTe5+AGV6l5YjlEDXdq/n8rVAhtb0nirlaWcdOg5rV8hAj9GFYKTn+iscl?=
 =?us-ascii?Q?xF6R5WI1vr6DSvFt/5+aCLkDaP6Yp/WjdthLbVRqtVJwaRgC+xjemNNCFkiL?=
 =?us-ascii?Q?2aHViRNqe8qDidjwTMzAFvhIQDligfFaHU9x45xOEeJAqYG9pLjlJBkN8o3D?=
 =?us-ascii?Q?ijgKiC7WpWABKornccmXNQkYin7494hBVOWT+K5Wq1+YsW4lLKlds0ht0BFy?=
 =?us-ascii?Q?88duZ3b21e2JMQ65S/G2xgRqfhhYZZdEzFUAvzsSU2+XOim1mOZKUy2N0KgS?=
 =?us-ascii?Q?0GoWkOmFSaADhpNUf8xYyZsVLjgjZqjLUhk/E66vJ4esIvcv4hd6oH1i81gd?=
 =?us-ascii?Q?TYgIcIu0NV+ZWxDBl1K2pcecYUpDR3fsvv2IWEGlDcTlz6OB4Gb/vgQPSZfW?=
 =?us-ascii?Q?FA3iaZ1Jqf8fo7mGcMrs8QIrEzCq+xkz/VFTe3SSifaVoF6vPViAw8aFc/I5?=
 =?us-ascii?Q?y1dPHekhjwtzHauWPUi1Dnaxe9qLngZVDVm8yNGK4LpmKbcEQseZ5dEPLmah?=
 =?us-ascii?Q?ZkGmCp/IYJRSWN2TAilyv+iGxc4Ihbtn9SI+KEmcgVzjE4PfIx7rOxhQNMut?=
 =?us-ascii?Q?FYGrhlEJ29T+bA9IIeVPimeG7VpVpi6eV+RfeDTOJH0FdCWkJvWH2ddVqyuT?=
 =?us-ascii?Q?HMQc3FHbgM5jp3wqOjnH7bJ0aGmSb1iLsXLNuCBdhjNjdsKeNxtbUU67/0HU?=
 =?us-ascii?Q?1tVX23uTQSe5xcxOmULj0aZ85WHYT2eVZkRpTlOO1VeB7WsRP4XUXmZyqQ8H?=
 =?us-ascii?Q?DyMD0bHvr8CLWH/DGSbwz6aefHfQ4q+b7RGJi12PLu6IAuYJ3ZViQaVXw22h?=
 =?us-ascii?Q?rTCZztL6J1oEB0NdDDXD4TlknjXfzgXI+PsvNS6MW4j/dutUgyYGpKBxEukl?=
 =?us-ascii?Q?qoAhdXujKspaRKMl4Cp3iokQnpeuZgYULupkj7ewgp7ul/zAHWWXaeHoKrwR?=
 =?us-ascii?Q?OSARz2RuLnNj1jAHsuVVB6da8R6osFf3bRBjO+2iFWK/G1CMq7OC+TC03SUu?=
 =?us-ascii?Q?oTEJz35vhx1C85g2v/NfrEgd3qxWWT+hhNKu4uPulWbIKoznDfVch6L5A4bB?=
 =?us-ascii?Q?p/6aCI4lWQh7F0wRtOBteGazQGrvbaVJgzO50qEXqsV4H5I/YbJa1Wl/R9MT?=
 =?us-ascii?Q?Nhgsjo9mk8wviFKc7rGu1SNySVEtytO2oCV17rn4SqtZJn//T/vkMfoUHQc5?=
 =?us-ascii?Q?DaM/uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LB91VcFd94a9nWWwUwreMSVqS832/y3nanX1pC5jJFgT40fnEXB+BQodC4KeyOMyPjE0yoJVOyHj0Ws52f4+l9FuglNuBas6m5X1h6I9EbUXqM8kovwf7mTJTZ/zTDrKK+mc9g3XOfAoquFt2aWRVOCNMkPrpfN4XI5gzQortPVf+pGJ8o+b8cLucgUFS/j4Ekbn3ZxkQr+01gaBsUgbYvzeASdLamkvN64lEvTrpyGssOomtnLd4QBInxLCDkDjFddoVTM1FV1xwA3XEAhg5qlKrAGgwTPXJGlbaQTxdOVIXebm2q+7MU90RQFrMn7YmffdqW3zI1d6BVgHoMpuexfAU839HSgXJc6P60OtaxZ7ygB1ulQH+gWVKh/lyBYLqXrtEc5yYbaO3lDwpH5FN5oyIjVglJnt2fGQZKT0Rb3GimRuu9OiEYJerz8Ug1/Ji0RTPl0WWnrDhs9bMuvi6HQtAaXqmv/ki5D911LT/GhQQp8QjNnmrKdnClbLiuB4U1dKj6OPJai+85wyQDIiTkVRUF5KWqBVmLln1jOldzMYMGQsbN8VLMEB/VSwlfiTm9CpsyZ2IGGz7LR5H6bMXmjPnwA0C/lnVI6ij8U1oWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1768d976-6e76-4322-a4fe-08dd6c087526
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:49:34.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4Ijz+hT24Srz9B9Uhv5kPsT845q8SdaZb1VbWrf7c0+zybThF7LzelBUtuLMZtK7muWczOiJC/7gEErHxMKGiBLXVUlT9+/z8PrOlpR2R0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=807 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260009
X-Proofpoint-ORIG-GUID: akeHre2DI_XH3yk62gurScqG95UMGCYu
X-Proofpoint-GUID: akeHre2DI_XH3yk62gurScqG95UMGCYu

Hi all,

This series is an effort to begin removing buffer heads from ext2. 
The first patch introduces the bulk of the new buffer cache code, while
the rest of the patches split up changes to each part of the fs for
easier testing.

This is still a work in progress, and there are a couple more things on
my todo list:
- finish removing buffer heads from xattrs, inode allocation, etc
- implement a buffer cache shrinker
- fix various locking issues

Comments and feedback appreciated!

Catherine Hoang (4):
  ext2: remove buffer heads from superblock
  ext2: remove buffer heads from group descriptors
  ext2: remove buffer heads from quota handling
  ext2: remove buffer heads from block bitmaps

 fs/ext2/Makefile |   2 +-
 fs/ext2/balloc.c | 132 ++++++++++-----------
 fs/ext2/cache.c  | 302 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/ext2.h   |  47 +++++++-
 fs/ext2/ialloc.c |  12 +-
 fs/ext2/super.c  |  96 ++++++++-------
 fs/ext2/xattr.c  |   2 +-
 7 files changed, 468 insertions(+), 125 deletions(-)
 create mode 100644 fs/ext2/cache.c

-- 
2.43.0


