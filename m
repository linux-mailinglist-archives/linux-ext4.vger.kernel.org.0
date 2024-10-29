Return-Path: <linux-ext4+bounces-4849-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF1D9B5452
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2024 21:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C317B23EEE
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2024 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF6018F2C3;
	Tue, 29 Oct 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PfP1ipkB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EqHRKeI0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313620720A
	for <linux-ext4@vger.kernel.org>; Tue, 29 Oct 2024 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234713; cv=fail; b=Oi/qG3lfnDjIqaygf/teuFsYozjJdRYXrWC89PZanCDfL6TYrrzKiLAJHhEm3Ysu1o6yqn5uFi29G1qCO77aopDaUgqkjFgQNzLbljewXkkdkqc9fKU80iUuAHW1+iMLLOtMjAFU4hl4cTXtb8jFnNHp0gbjDFwxipsD/3FWmsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234713; c=relaxed/simple;
	bh=e4wUjtkkqq8SP/dM6JQNuy4vfULTsYjuzAHBB79qSGg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S3rHPjaeTmgcRFtxqzqetYD1iZa95rNozHtjq0IxEoeWYCgnL91yT+GqLMp2YF8oWNWlGvGddFdgMrWUd6PYjlEpU5BZwre+N+mJgnA4OllBGPsMBJ22tsTSWjNuUpBkKgV4dcjWnGMP6Jt5OVQxCxc9nC/a2wr0bC792fTFHVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PfP1ipkB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EqHRKeI0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGffZ8018861;
	Tue, 29 Oct 2024 20:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=bSyRdm01SBMNKeoZ
	VMMStQy3/wTYNTV0KN0JB+RCyWI=; b=PfP1ipkB7enm2kIInvwe+obF1CkgvSv3
	HIxBKSqCFoXf5gPLT2zGh+jIMDAqmwiPKeXKp4hLcwBocp5XNrAZJzMj7jLTFlRO
	CaufFGucgrSMwiv4w+dAjJrX9cx2AXRO4+uAiiiMVRCdqikWa9tHVdjWo4iybtqh
	++qcsNAl35O9oeaVp9Gha2YIXQlMFKwwj5WsDCcIJvnLSkeTYhuQOI65V99ta+KB
	uOxGZwQLKGNu3m3zTmfSljO14rgZS5XUQpvexTjp7zonyArKIZo0qQixsSIR7GWB
	WRkDEJhdTa0lj8iIcVXBLbwnVGsmIVlKwYKowCpf7H7Cr3CC+3A+ww==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys6kmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 20:45:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TKKnY9034807;
	Tue, 29 Oct 2024 20:45:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd8802e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 20:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcNOGWjO/z3YILRXZgxtY3iPQeObEUNwGZ9rTqQT/zndaAMnD2q4+Ebmfx40UDZ5djvy5h+GSjU4Jse7ghOOT7L2B+vutBuXwGPQIa3eY7KVhWT2mfm4NgtvaWH2V95+6bHcv8g7O9/ZBtHrnqhsMMo2sw9tIkzSkkU1BilgyRG9hp1sXjuhbjWdDJRSDpA05L+0IL/uaeopNziZRo5C61xqcJxXUjNuNsMTQsCeGMvsjXmlLpdEHYlmLw0MIFv0gnVTilVi5V64+2wBDKUV7q25XB9NwfLI1L3XJp7K/XdXpdeIxrl8reyNDZu7wUgQfxkTFBe1GpZzQ9shnQltOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSyRdm01SBMNKeoZVMMStQy3/wTYNTV0KN0JB+RCyWI=;
 b=JT4I887rfllJNgZ4rjkO0cucfRYP1Yw0MjgsVD0p1ANwwZYwOrvoiyWMMNtq4G/omf12ncrrpl1CProOs46HqatjuGw6JPRyO051ez/cbxGX4UOjbVY3CwI2gq90piHfXM5P4oAoP7zW2K7oBA6BCu9ZlrSMg8F+hgjsbloreFcW5bzp/Ix28f2oVsfVIP2i5lCqMLstkyRj8xwMl2ZAX4vBS2qFDiB1dE4q9dE/j7r4a2TLZLET6hYJQ6IflW3e2NLgLHGAq7t6qPRE76yEfypFp0cQyOSqwfjq3+ddvhsLr64HfyMUYmwKHVT+DtZ0JNA6m+83sOVNGa7/3C2ATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSyRdm01SBMNKeoZVMMStQy3/wTYNTV0KN0JB+RCyWI=;
 b=EqHRKeI0sTg+pTR3+ORKd4Z4elv7FLepk0d6VuegCVXSfZWXscfk7GDISqGsa3vKrTinEd6lBhSDbIzUvrmFcq42QXnyxcRRp+rwDuLHdFtvS7YP65ylbHaDEmzfU0MGB/liEfZmqJci/+9UBiv3iM+8p+i0TJP/4PKyyJ3G5Mg=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by IA1PR10MB6121.namprd10.prod.outlook.com (2603:10b6:208:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 20:45:03 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%3]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 20:45:03 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: djwong@kernel.org
Subject: [RFC PATCH v1] ext2: remove buffer heads from quota handling
Date: Tue, 29 Oct 2024 13:45:01 -0700
Message-Id: <20241029204501.47463-1-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::24) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|IA1PR10MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e33dcc7-0d5f-4253-6920-08dcf85a9016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zRhaY5N0FyV9OtPOFcBW7dh5lyUlzWz507987qR0V62Hu5a1vZrxXusN66XD?=
 =?us-ascii?Q?GekBpZ3yjcjr5bDKQWorw2a9/zxPLssN7awcTHNWG7VzYLTV5MAlZ/ZpfANJ?=
 =?us-ascii?Q?4UB908ooHdOtfbYG4vTNPJ7jTdtQUa/WRwPtmUvH/HzFTaO3S7c8eAtbeZRr?=
 =?us-ascii?Q?nE1BFVeF9UuGT6ckU5U6zLxDaJJJvWNS9xzr4jSYE0lmZOpULRJgXNHxCiwI?=
 =?us-ascii?Q?Zlzojm12/FqQUbffNXTCs6N+XiZRVDk1BPyKcn0cR1ysA4DXxhFogF+dCa2+?=
 =?us-ascii?Q?mVWm6QsNcE/39aDaAJMGGD2BbL9M0+k5QTMQJ4/KKTR6E2wXo6WIzvXPd3pA?=
 =?us-ascii?Q?nHA3flhJSdLr8wBrFbuz47au4qPmubwC9k8l10o8GcuVWj+1wQ76MzGzOV27?=
 =?us-ascii?Q?VmKM7uE9WnA2c0N0eQBy5kluWPfo6sb51Zl2AWZxCRAmSXlJCkr4P53AvYCt?=
 =?us-ascii?Q?UPWd7BAYGWG1o22hOXXg1eWQL/j2sWjebH9Ol5MzKSsOttiChXPVG0D7VPHS?=
 =?us-ascii?Q?RJlCjkFz745LQN96Jvx7J2Km00Bq8ByL3IpFgihdgPrXxGDXJmid8JMUt7WO?=
 =?us-ascii?Q?K/6OgAtWPEiC4kFVc/tEz1K5I6RxpFmz2Aa8BGC02EvM8tVFUIPMnzcHZiE9?=
 =?us-ascii?Q?nVzQ4n/k06gvXGNqOi1XjbUoNCUryARtokmG9PEZFylLu7kINR4Bk3R608Ol?=
 =?us-ascii?Q?0Ygx6i/hR7RlyrjNN7rcb15lSaJNmY4W9WpdCQJXV0+AOKkRBWQXLac3ZEJc?=
 =?us-ascii?Q?2LaPdXmb35v1droY+f8X1Pp66Pp6ZRpZhxoH3xK7Ay12AoKcBLM3fJ6E93HL?=
 =?us-ascii?Q?wCm8gUhZr0JNMJaYlRJInsrDiGLpzBDrwDliuvYY5UcAJ+Pq9nL4vApn0pA2?=
 =?us-ascii?Q?8JAqSf9TYBSVBY4CEZiCoBCIFOX++CQY9XyeVXq06mVyP/dnHJ8UnF1ws1mG?=
 =?us-ascii?Q?kAqZOS9DqaESWlB0gNvczfz4vmfgquPYUxOvXVQ7XwaJxVUywsACuy57uEP7?=
 =?us-ascii?Q?FO6L5MaXt5FcbRQPpj+sorG3dZ9mZQIlztc9xpoWDh79/AN7xCJ9+GuLzfpC?=
 =?us-ascii?Q?i/uQ8ejds+nF+JlClKIQsnfqh7foKTpT3UxKYSXlUISJnMFp8Hkcdab1NlEg?=
 =?us-ascii?Q?hSeinlr6GBUM1yfG0UqITHL5inj4es3tb5N/H5235+5YLS1/lmrWusW9sDd/?=
 =?us-ascii?Q?/jeKfFDQg16pFrv77vQOFUUcU+ZE8uRazCOcTnecZGeYTWgBccbfCv/CkwC9?=
 =?us-ascii?Q?ONKrcbFR0CQ7qmXoHHmuYFbSihnmwnvz9aN7EAzU1tC1Nf1dSSQZe6lF2T/0?=
 =?us-ascii?Q?3FWi2/pyNpCIgqzLFfYCp1k7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u2/c/T8/APIqGeev5XsJqzXWxq2q3x0rLqivgHb3LEp1xBbT3DDdhstXRvdZ?=
 =?us-ascii?Q?JpcuQxlFSETCc51Ht7g3PaiDH+ksl7z8mu52JvfjORHPlNunukeI0UAMJ78v?=
 =?us-ascii?Q?4azsBfBbRyK01NLPByMQQTV2IjbsmjURZ4wMmxf6tIr1k4Fxrjcbheip78My?=
 =?us-ascii?Q?3adGKx3eYJvP+gX4VED0h3bdQZj1oIOUoraYHzHpFPFAvNxwt1YTUeX8FHNB?=
 =?us-ascii?Q?KgQgncc+3KUl7LJ4y+p62DM+LgQCI7JJUlh5X3B7o0MzADzkfhs56mV+oOWM?=
 =?us-ascii?Q?JlXLma+QtkvNKpDglpqmDGL9dW3lvSgWB3/Z7SCZ8Ls+XL9VNrhzZb2ZtSdz?=
 =?us-ascii?Q?fSj+tTK4CcSKLf+F8vFAciVh7AnMcuyVKQYTm0eCpoTGi9OOhCHNN2WiUvVt?=
 =?us-ascii?Q?v8/4atkc854U7F1yL4gcwNss3IRJxn9lxjq9Ewy9iAVB+FcuOnOero6YOeSV?=
 =?us-ascii?Q?U73h9qMVj1aYiBs0D5KjHGD4lSUORLklqjhKuwe38agOCiKI6Ve5oJAuy6yB?=
 =?us-ascii?Q?gMrRU6YvmqmcUpwnn+d6ldnEQf7QzTdSzZKbD5kDEOiGVcV5KcMjJ48xvh/D?=
 =?us-ascii?Q?6TeYcGs4E8ntj9DYYxFVvnWf6FKWhoRg1FMVOQ6TL+dy2sZfnDUM7zN1kLln?=
 =?us-ascii?Q?xvn9iZcMoBoiTXnRC6mfjXEEC9vpjxWglrfL5owEz/zARkyKrU5Hqfw5wyqK?=
 =?us-ascii?Q?ATbCwkkwb9Fs1rCBnRa/SA3wXxf+Qij1U/OwhJasljGkhPOgSqJfUS/g1hAr?=
 =?us-ascii?Q?Ll0e3kWFMfDAPM3Bxp9U8RqdsACQCITeJJk7mIBbmlfjle6ORYOaF0lF0IVl?=
 =?us-ascii?Q?NP0RcbykQQXLkISOLyowRBvdUtNe5ntKvlRl4mxWPUvdZYMqvDTXaM4GJpcW?=
 =?us-ascii?Q?EThZCrnSgg4lVhiX974WVi38wTq45ANpBf2bKRAEBSCzxN59keP5y9+vcUsG?=
 =?us-ascii?Q?5sZeTTAOWHgvQpg22KkkWe7sxVTOeUMCj6WyeZh3BjPFxhc6Rb69pRJTKbRm?=
 =?us-ascii?Q?ieAtrjUj8j19/pvy2MUe3tKiUCBfvqFdv0jZREQp/glaZSncEb8He32KPgVW?=
 =?us-ascii?Q?o0H90eAkuOIVCk9IuX5GMC6xYMmF7FCn4h4w97epCV532NdzVF07qZcc6Fdc?=
 =?us-ascii?Q?yF2pBxtpssI9ha07d86e5sQRf0MfhMAyBGUtRoqITiag+/J63L6TyNgLQcc/?=
 =?us-ascii?Q?jmpufk7byxMkOdLxXGRl50Oxk6Yuxe/E+BFC1N1X7y5LiqApUnf2oZbC8pJO?=
 =?us-ascii?Q?sA6UPZo6CR2mfY94C0jzYM2N5+SEPDO5Tu0Jh03f/OqYggS4anRQirY49Nvp?=
 =?us-ascii?Q?pGgWuQk8pYl9ZyOZhBE1x+C3pnYdZwo1npfqcook8DaPYHHeMaBS9QYnkylD?=
 =?us-ascii?Q?3eC2zPLUGEZi37S3eFramioENFyVlPzt/hZERToqHHYWNFoC+a6InC1AEq5C?=
 =?us-ascii?Q?oAztA0Lw/jwLaDevXJHtyUyN5M4fDO7zhsNrrAopSHB3xm/KOPlqTXJviAZx?=
 =?us-ascii?Q?u7JewrOUolOQAv5HE7Lqimqmt8Mi/E8zmx3uTED+OXKLNHL8vkssEj20+A3w?=
 =?us-ascii?Q?zDQMGcA+EQmz4n67/xetcer1edTA1k+Hlr/to1o2W3bQ5RDvLm18X7g/gWsx?=
 =?us-ascii?Q?DUnVuKM61ePv2fcu65ODlquwDUU5kWkXUl7qIqRfrlVyNEViIzUeBnKXJXrp?=
 =?us-ascii?Q?mUCimA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CYLpmy4dc3KblLf3B4+wc0/dbh7DkRAmNekoa5SmNptszY94lu0xv8MmUtWb2DGuANUNReZUJyfHLqvh9ahI6FaB+uMSqMmQduiqhb0b3R7dSfJPAsHDsvEMXAjqWTrH/wCVzG0BXruBtbLww1PoaBpX+FMGCNUHo+H/vP5EkceQM5R99tRxzdjUbndZN7m0XgyXTduqqO/HokWpOWaJS3KZ28vaAi98zcL3RBaI3q4aSKdTNrq0uils43Wf9N1bYoEaTBs9Cxuv0MNf1OhhgyHiwAaUWkZvur3zeZbQNsu8/wapi27JpsnnYN+ksRTRKLO2h19/QPps8ViUdGR13CwDVPQvb0w/ZJwcrivcs1fTvmW+RyTILTDRFqzTR0ljYke90nKkO0GksxvZ9mM8NqaGMCsDDm8BRI+XefHKgX1sq5UgL5F5ZzxFSct77St9X+D4xF6/kVc7lKGgqhKhE+am7FCjiUwydQAhQMjUj/WZxQuzQzqgCbvHp4GxF1OKaqVKf3slLFvP58qAkwfmPnKn1Mwd5fbJWqzVaw8LhncQKJRfvjqhtxIw0QnUj7l97jsgk+dJtD3uwqJwYpBV6eQpzj591L3b1dUYMtuK3Lw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e33dcc7-0d5f-4253-6920-08dcf85a9016
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 20:45:03.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jebFAvZ7VErKWPBl+GY7A1AoT3H5tv2ZpnKpxYy+yw1nyEu7Z2sF1iuqQg1wNuTXCdvdxG3vWuL10lSDtS9AcOrv9DDjA7h1J8/y+VSvVwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_16,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290157
X-Proofpoint-ORIG-GUID: ckbkD4TkYzVbK1fBjOZhLFzHMAC_bi7s
X-Proofpoint-GUID: ckbkD4TkYzVbK1fBjOZhLFzHMAC_bi7s

This patch removes the use of buffer heads from the quota read and
write paths. To do so, we implement a new buffer cache using an
rhashtable. Each buffer stores data from an associated block, and
can be read or written to as needed.

Ultimately, we want to completely remove buffer heads from ext2.
This patch serves as an example than can be applied to other parts
of the filesystem.

Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
---
 fs/ext2/Makefile |   2 +-
 fs/ext2/cache.c  | 195 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/ext2.h   |  30 ++++++++
 fs/ext2/inode.c  |  20 +++++
 fs/ext2/super.c  |  62 ++++++++-------
 5 files changed, 281 insertions(+), 28 deletions(-)
 create mode 100644 fs/ext2/cache.c

diff --git a/fs/ext2/Makefile b/fs/ext2/Makefile
index 8860948ef9ca..e8b38243058f 100644
--- a/fs/ext2/Makefile
+++ b/fs/ext2/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_EXT2_FS) += ext2.o
 
-ext2-y := balloc.o dir.o file.o ialloc.o inode.o \
+ext2-y := balloc.o cache.o dir.o file.o ialloc.o inode.o \
 	  ioctl.o namei.o super.o symlink.o trace.o
 
 # For tracepoints to include our trace.h from tracepoint infrastructure
diff --git a/fs/ext2/cache.c b/fs/ext2/cache.c
new file mode 100644
index 000000000000..c58416392c52
--- /dev/null
+++ b/fs/ext2/cache.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 Oracle. All rights reserved.
+ */
+
+#include "ext2.h"
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/rhashtable.h>
+#include <linux/mm.h>
+#include <linux/types.h>
+
+static const struct rhashtable_params buffer_cache_params = {
+	.key_len     = sizeof(sector_t),
+	.key_offset  = offsetof(struct ext2_buffer, b_block),
+	.head_offset = offsetof(struct ext2_buffer, b_rhash),
+	.automatic_shrinking = true,
+};
+
+static struct ext2_buffer *insert_buffer_cache(struct super_block *sb, struct ext2_buffer *new_buf)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct rhashtable *buffer_cache = &sbi->buffer_cache;
+	struct ext2_buffer *old_buf;
+
+	spin_lock(&sbi->buffer_cache_lock);
+	old_buf = rhashtable_lookup_get_insert_fast(buffer_cache,
+				&new_buf->b_rhash, buffer_cache_params);
+	spin_unlock(&sbi->buffer_cache_lock);
+
+	if (old_buf)
+		return old_buf;
+
+	return new_buf;
+}
+
+static void buf_write_end_io(struct bio *bio)
+{
+	struct ext2_buffer *buf = bio->bi_private;
+
+	clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
+	bio_put(bio);
+}
+
+static int submit_buffer_read(struct super_block *sb, struct ext2_buffer *buf)
+{
+	struct bio_vec bio_vec;
+	struct bio bio;
+	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
+
+	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = sector;
+
+	__bio_add_page(&bio, buf->b_page, buf->b_size, 0);
+
+	return submit_bio_wait(&bio);
+}
+
+static void submit_buffer_write(struct super_block *sb, struct ext2_buffer *buf)
+{
+	struct bio *bio;
+	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
+
+	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
+
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_end_io = buf_write_end_io;
+	bio->bi_private = buf;
+
+	__bio_add_page(bio, buf->b_page, buf->b_size, 0);
+
+	submit_bio(bio);
+}
+
+int sync_buffers(struct super_block *sb)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct rhashtable *buffer_cache = &sbi->buffer_cache;
+	struct rhashtable_iter iter;
+	struct ext2_buffer *buf;
+	struct blk_plug plug;
+
+	blk_start_plug(&plug);
+	rhashtable_walk_enter(buffer_cache, &iter);
+	rhashtable_walk_start(&iter);
+	while ((buf = rhashtable_walk_next(&iter)) != NULL) {
+		if (IS_ERR(buf))
+			continue;
+		if (test_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags)) {
+			submit_buffer_write(sb, buf);
+		}
+	}
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+	blk_finish_plug(&plug);
+
+	return 0;
+}
+
+static struct ext2_buffer *lookup_buffer_cache(struct super_block *sb, sector_t block)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct rhashtable *buffer_cache = &sbi->buffer_cache;
+	struct ext2_buffer *found = NULL;
+
+	found = rhashtable_lookup_fast(buffer_cache, &block, buffer_cache_params);
+
+	return found;
+}
+
+static int init_buffer(struct super_block *sb, sector_t block, struct ext2_buffer **buf_ptr)
+{
+	struct ext2_buffer *buf;
+
+	buf = kmalloc(sizeof(struct ext2_buffer), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->b_block = block;
+	buf->b_size = sb->s_blocksize;
+	buf->b_flags = 0;
+
+	mutex_init(&buf->b_lock);
+	refcount_set(&buf->b_refcount, 1);
+
+	buf->b_page = alloc_page(GFP_KERNEL);
+	if (!buf->b_page)
+		return -ENOMEM;
+
+	buf->b_data = page_address(buf->b_page);
+
+	*buf_ptr = buf;
+
+	return 0;
+}
+
+void put_buffer(struct ext2_buffer *buf)
+{
+	refcount_dec(&buf->b_refcount);
+	mutex_unlock(&buf->b_lock);
+}
+
+struct ext2_buffer *get_buffer(struct super_block *sb, sector_t block, bool need_uptodate)
+{
+	int err;
+	struct ext2_buffer *buf;
+	struct ext2_buffer *new_buf;
+
+	buf = lookup_buffer_cache(sb, block);
+
+	if (!buf) {
+		err = init_buffer(sb, block, &new_buf);
+		if (err)
+			return ERR_PTR(err);
+
+		if (need_uptodate) {
+			err = submit_buffer_read(sb, new_buf);
+			if (err)
+				return ERR_PTR(err);
+		}
+
+		buf = insert_buffer_cache(sb, new_buf);
+		if (IS_ERR(buf))
+			kfree(new_buf);
+	}
+
+	mutex_lock(&buf->b_lock);
+	refcount_inc(&buf->b_refcount);
+
+	return buf;
+}
+
+void buffer_set_dirty(struct ext2_buffer *buf)
+{
+    set_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
+}
+
+int init_buffer_cache(struct rhashtable *buffer_cache)
+{
+	return rhashtable_init(buffer_cache, &buffer_cache_params);
+}
+
+static void destroy_buffer(void *ptr, void *arg)
+{
+	struct ext2_buffer *buf = ptr;
+
+	WARN_ON(test_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags));
+	__free_page(buf->b_page);
+	kfree(buf);
+}
+
+void destroy_buffer_cache(struct rhashtable *buffer_cache)
+{
+	rhashtable_free_and_destroy(buffer_cache, destroy_buffer, NULL);
+}
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index f38bdd46e4f7..ce0bb03527e0 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -18,6 +18,7 @@
 #include <linux/rbtree.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/rhashtable.h>
 
 /* XXX Here for now... not interested in restructing headers JUST now */
 
@@ -116,6 +117,8 @@ struct ext2_sb_info {
 	struct mb_cache *s_ea_block_cache;
 	struct dax_device *s_daxdev;
 	u64 s_dax_part_off;
+	struct rhashtable buffer_cache;
+	spinlock_t buffer_cache_lock;
 };
 
 static inline spinlock_t *
@@ -683,6 +686,24 @@ struct ext2_inode_info {
  */
 #define EXT2_STATE_NEW			0x00000001 /* inode is newly created */
 
+/*
+ * ext2 buffer
+ */
+struct ext2_buffer {
+	sector_t b_block;
+	struct rhash_head b_rhash;
+	struct page *b_page;
+	size_t b_size;
+	char *b_data;
+	unsigned long b_flags;
+	refcount_t b_refcount;
+	struct mutex b_lock;
+};
+
+/*
+ * Buffer flags
+ */
+ #define EXT2_BUF_DIRTY_BIT 0
 
 /*
  * Function prototypes
@@ -716,6 +737,14 @@ extern int ext2_should_retry_alloc(struct super_block *sb, int *retries);
 extern void ext2_init_block_alloc_info(struct inode *);
 extern void ext2_rsv_window_add(struct super_block *sb, struct ext2_reserve_window_node *rsv);
 
+/* cache.c */
+extern int init_buffer_cache(struct rhashtable *);
+extern void destroy_buffer_cache(struct rhashtable *buffer_cache);
+extern int sync_buffers(struct super_block *);
+extern struct ext2_buffer *get_buffer(struct super_block *, sector_t, bool);
+extern void put_buffer(struct ext2_buffer *);
+extern void buffer_set_dirty(struct ext2_buffer *);
+
 /* dir.c */
 int ext2_add_link(struct dentry *, struct inode *);
 int ext2_inode_by_name(struct inode *dir,
@@ -741,6 +770,7 @@ extern int ext2_write_inode (struct inode *, struct writeback_control *);
 extern void ext2_evict_inode(struct inode *);
 void ext2_write_failed(struct address_space *mapping, loff_t to);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
+extern int ext2_get_block_bno(struct inode *, sector_t, int, u32 *, bool *);
 extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
 extern int ext2_getattr (struct mnt_idmap *, const struct path *,
 			 struct kstat *, u32, unsigned int);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 0caa1650cee8..7e7e6a5916c4 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -803,6 +803,26 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
 
 }
 
+int ext2_get_block_bno(struct inode *inode, sector_t iblock,
+		int create, u32 *bno, bool *mapped)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head tmp_bh;
+	int err;
+
+	tmp_bh.b_state = 0;
+	tmp_bh.b_size = sb->s_blocksize;
+
+	err = ext2_get_block(inode, iblock, &tmp_bh, 0);
+	if (err)
+		return err;
+
+	*mapped = buffer_mapped(&tmp_bh);
+	*bno = tmp_bh.b_blocknr;
+
+	return 0;
+}
+
 static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 37f7ce56adce..11d88882ad24 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -152,6 +152,8 @@ static void ext2_put_super (struct super_block * sb)
 	ext2_xattr_destroy_cache(sbi->s_ea_block_cache);
 	sbi->s_ea_block_cache = NULL;
 
+	destroy_buffer_cache(&sbi->buffer_cache);
+
 	if (!sb_rdonly(sb)) {
 		struct ext2_super_block *es = sbi->s_es;
 
@@ -835,6 +837,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
 					   NULL, NULL);
 
+	spin_lock_init(&sbi->buffer_cache_lock);
+	ret = init_buffer_cache(&sbi->buffer_cache);
+	if (ret) {
+		ext2_msg(sb, KERN_ERR, "error: unable to create buffer cache");
+		goto failed_sbi;
+	}
+
 	spin_lock_init(&sbi->s_lock);
 	ret = -EINVAL;
 
@@ -1278,6 +1287,8 @@ static int ext2_sync_fs(struct super_block *sb, int wait)
 	 */
 	dquot_writeback_dquots(sb, -1);
 
+	sync_buffers(sb);
+
 	spin_lock(&sbi->s_lock);
 	if (es->s_state & cpu_to_le16(EXT2_VALID_FS)) {
 		ext2_debug("setting valid to 0\n");
@@ -1491,9 +1502,10 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
 	int offset = off & (sb->s_blocksize - 1);
 	int tocopy;
 	size_t toread;
-	struct buffer_head tmp_bh;
-	struct buffer_head *bh;
 	loff_t i_size = i_size_read(inode);
+	struct ext2_buffer *buf;
+	u32 bno;
+	bool mapped;
 
 	if (off > i_size)
 		return 0;
@@ -1503,20 +1515,19 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
 	while (toread > 0) {
 		tocopy = min_t(size_t, sb->s_blocksize - offset, toread);
 
-		tmp_bh.b_state = 0;
-		tmp_bh.b_size = sb->s_blocksize;
-		err = ext2_get_block(inode, blk, &tmp_bh, 0);
+		err = ext2_get_block_bno(inode, blk, 0, &bno, &mapped);
 		if (err < 0)
 			return err;
-		if (!buffer_mapped(&tmp_bh))	/* A hole? */
+		if (!mapped)	/* A hole? */
 			memset(data, 0, tocopy);
 		else {
-			bh = sb_bread(sb, tmp_bh.b_blocknr);
-			if (!bh)
-				return -EIO;
-			memcpy(data, bh->b_data+offset, tocopy);
-			brelse(bh);
+			buf = get_buffer(sb, bno, 1);
+			if (IS_ERR(buf))
+				return PTR_ERR(buf);
+			memcpy(data, buf->b_data+offset, tocopy);
+			put_buffer(buf);
 		}
+
 		offset = 0;
 		toread -= tocopy;
 		data += tocopy;
@@ -1535,32 +1546,29 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
 	int offset = off & (sb->s_blocksize - 1);
 	int tocopy;
 	size_t towrite = len;
-	struct buffer_head tmp_bh;
-	struct buffer_head *bh;
+	struct ext2_buffer *buf;
+	u32 bno;
+	bool mapped;
 
 	while (towrite > 0) {
 		tocopy = min_t(size_t, sb->s_blocksize - offset, towrite);
 
-		tmp_bh.b_state = 0;
-		tmp_bh.b_size = sb->s_blocksize;
-		err = ext2_get_block(inode, blk, &tmp_bh, 1);
+		err = ext2_get_block_bno(inode, blk, 1, &bno, &mapped);
 		if (err < 0)
 			goto out;
+
 		if (offset || tocopy != EXT2_BLOCK_SIZE(sb))
-			bh = sb_bread(sb, tmp_bh.b_blocknr);
+			buf = get_buffer(sb, bno, 1);
 		else
-			bh = sb_getblk(sb, tmp_bh.b_blocknr);
-		if (unlikely(!bh)) {
-			err = -EIO;
+			buf = get_buffer(sb, bno, 0);
+		if (IS_ERR(buf)) {
+			err = PTR_ERR(buf);
 			goto out;
 		}
-		lock_buffer(bh);
-		memcpy(bh->b_data+offset, data, tocopy);
-		flush_dcache_page(bh->b_page);
-		set_buffer_uptodate(bh);
-		mark_buffer_dirty(bh);
-		unlock_buffer(bh);
-		brelse(bh);
+		memcpy(buf->b_data+offset, data, tocopy);
+		buffer_set_dirty(buf);
+		put_buffer(buf);
+
 		offset = 0;
 		towrite -= tocopy;
 		data += tocopy;
-- 
2.43.0


