Return-Path: <linux-ext4+bounces-6977-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0FCA70EA1
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 02:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD57189493F
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 01:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B863D12DD95;
	Wed, 26 Mar 2025 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJzTpUBM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hR44L3jx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769E7DA73
	for <linux-ext4@vger.kernel.org>; Wed, 26 Mar 2025 01:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953787; cv=fail; b=RvGLiA+3QQ2k36+zZqKFl5C1EZGZBmvKe4XadHBHXC2MP6SATop/hHet4zIyVeSN4Gu8s8Q4ergskFjUoOQrAg8H1NDoiozewTEpTJNIYRoQNJj5aS8Y7RBHbk71ZSKqswdPKeYDLJ2xS7pm1hKLuHV7PqMR2VKU7e9mnt6M4f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953787; c=relaxed/simple;
	bh=kYt6muJhe0siFS0CyCmRZn+bC6ZUAJoS+8WEzFqI6kY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pug5X43EHkvl09gPejLVZxUvhtVFndKdwWvwcZOh6TaM13u5S6s2fF5uC6IHYiOF3CPvggu8lfOT6604LCvw15+hMHHetztjyboTxPrCnL2kPknlQws2ECai1+nJzTOJ6MbZQ9MceZl8dSeZS4CmRsZDVs/5YCfv77xIzxZujOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JJzTpUBM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hR44L3jx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLu9Nk020526;
	Wed, 26 Mar 2025 01:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mMvWohFG21N3iDWG33fi9aUWuhV/ugr0NZTB2Sz2l2A=; b=
	JJzTpUBMnlQQqX5k/kDXrkFZs7/KlR4ZH0z76C7AevgWNzdo9hs+sZFn+XlID4WQ
	I3jfdITa6as9ese+0u1j6UR9YZq6e/OeY5bWzVlUn/ilJBnlk/yH3WJ+T/0q/EEr
	GstnvAYWyRznos8xxeSXxxH4ftvjLRiDTdWClSdA3lxb7GnCO77GaFpKnkVxDWdz
	El5SDm9r3px4XMWroW/oRwWS61fSCwW0Y0zu79qfpfg2k3c0ocz9+lJwWjmHPFV1
	mWyY02u+7VJUrAHaXGofwh/o3y5jJ9qYD3jJxdeaZsegTH2vBorUknFsnxf1blAc
	DTtJHC7r8FE5VWPGWNVIZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn9c0fk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q0KFSf036487;
	Wed, 26 Mar 2025 01:49:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj5d6hns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hABoJiIA2ql3KG4+GHw7oc0exyKIc/vXunC3nsTZ4Eo9aS2fQzQLZ3M0A0JNdnW0OPXUfW8LVZVxWSnZeml/MNZee4x3rZKoNwyphyTBo+dWBBtLGyBkafgsyI/M5XtTjA+7EvG5KTOaEEEwqNy5tjOsUxf0MQj1zFbnT43U2CeHH8BCVHxQI+4vpQOeHlLAKnWKh3XL51dfzJ0oJsoD2q/oiTlFfe0SYSLJmJVYv0cFXjhWrfznJyBeadeUUM69C2jXynfGPF1LhEY0Lp6dVEA2jiyEWfJqwh9/JCdBC2SIrh6WB8RUNmfI+JQe/umSacSU1E7SsNIFlbumQfkD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMvWohFG21N3iDWG33fi9aUWuhV/ugr0NZTB2Sz2l2A=;
 b=GRQa8252btH+UKP4ErfpvHm60VpOSfeHkin74Bvrr89QyQNaXK5Zf5JnqdfG0xGYtjV/mNi1O9Lu+9KDacFoPqrnV9+CkXwP+W1Gg8c7PlHdwczw3eIzHg3E3RiL/AoWMuJaxjYUVW00hNQh+ldFmRnAnoA3qsaZkD92lYNR6GxpMgGU8cpVjYE1ECxhhHZqdi/COsj7JGZ1QJ98SR9wixdoIBkMlreCq59ae/bwMXC7GqJUJdsK4dM9DY3eWhzRoKlhND+zDMLzk4RHGsV0X9jOsIK8fih0DyVTCL1cv6MsZNP6alhspVQkvmNc852hIXVxXtLjVfPkNmFLbUF47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMvWohFG21N3iDWG33fi9aUWuhV/ugr0NZTB2Sz2l2A=;
 b=hR44L3jxjgqGTtw2W19L3mibyJ+k6/8KFLc0iv7ZW75n7kPUFk5eYqgcR151e/Za+BHsOpA/q44NCsna901LKUQG8s7QkbnhNb9K0mkuhsBlIU4DYkM1fmy9sJ5kUUlz910AqekkPsIU3JF1JPIAxS1Pg0TExGOKASyM2WhYW70=
Received: from BLAPR10MB5316.namprd10.prod.outlook.com (2603:10b6:208:326::6)
 by CH3PR10MB7744.namprd10.prod.outlook.com (2603:10b6:610:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 01:49:36 +0000
Received: from BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142]) by BLAPR10MB5316.namprd10.prod.outlook.com
 ([fe80::a63b:c94b:7ed8:4142%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:49:36 +0000
From: Catherine Hoang <catherine.hoang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: djwong@kernel.org
Subject: [RFC PATCH v2 1/4] ext2: remove buffer heads from superblock
Date: Tue, 25 Mar 2025 18:49:25 -0700
Message-Id: <20250326014928.61507-2-catherine.hoang@oracle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250326014928.61507-1-catherine.hoang@oracle.com>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::28) To BLAPR10MB5316.namprd10.prod.outlook.com
 (2603:10b6:208:326::6)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5316:EE_|CH3PR10MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 658a1da8-bce6-43ae-aee3-08dd6c087655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zg27NWI8jrEjDRtZzPEDbK71bNid14wXEpvnAYGPTOYEBRmf+fYy9SqhFm7/?=
 =?us-ascii?Q?+KOAwbS8TUpiUw5LbQ+mUCRtPFT7dKzORDUQ1mgPFmuOO+jTgyu5/gyOsrvr?=
 =?us-ascii?Q?O+ybYOO8oV0OBt96JfQ+F690ebyELC3Ofgdl24f/QrgDRmjFT6jz8mTZOhD/?=
 =?us-ascii?Q?m5SFG/fgg0hF1cjLXRsW5PpV36t4kdfUcV5ujh2n+Mnblhx8mmbu9kPPCM2L?=
 =?us-ascii?Q?CcFD4VgAOr9A2n0xky6G4wzHsPinTzGA3ZkSLqSICerhvRJ0sdY2BIHxfT1q?=
 =?us-ascii?Q?4oJQmkOQ1jkUA1MtmaLiETWxBNzXGweox3kDL3bBZXbAw0pY2qhQseXir+iO?=
 =?us-ascii?Q?iar69RFGgpO4lDBtKRhSEPrLyK0xtj7zSPsBj5ZrRaGQ+twIU8emQavEuAgd?=
 =?us-ascii?Q?VxB91aZyCzoj5q3i1z5PmDsY9ja+iDr81vPCs7ageoPEnmEcgIkOK0FltHPu?=
 =?us-ascii?Q?JZk3smO02QSCsZSeaA39nkgSBXQdHQBmi5k0i2rmMigoTK5VQN4d5DtJG/Yf?=
 =?us-ascii?Q?OaEyXhSokG9pGsD22u4hXUNzk2fZ1gPOeKYHsrwFZ0nCIVxwe1IYm6scC0U3?=
 =?us-ascii?Q?8AM1B3t6t12NTf+KmuNadmc49iJ9DBP0eijI3R68SHyx1dJXKmRZ/LVSv1Gk?=
 =?us-ascii?Q?ThlRw2a9oQMh2ELswgwYELqstDgcGJyW32hO/Rtl21zY8pPEAi9RQBUEcFMl?=
 =?us-ascii?Q?Lo93mzMLAv/9aAYfMONetZL16p2bpQyjEqNiPlScxiGdCpkBnXMoko8xDl+F?=
 =?us-ascii?Q?UoZ1M/PWL+3nVJoljAauGVZivOuZdzB7zdXlJHJ64Ep5Dg4oe4KdYJMVYcOr?=
 =?us-ascii?Q?V2bKvUb/n1uTgG0LpDRT50+QZvYzjQJUyQXh1qaB4ttpyFLJylt6PTpYR+RZ?=
 =?us-ascii?Q?zfbeXD01JQTWXyUVTOLw96R5DXheH3mRS+JL5oRJzg2inlREwfIlwKYRX+JC?=
 =?us-ascii?Q?JvD/WACQZMEekFmhQBLQC2pW1D7nBtx/45seUYqqU7U/tlZQKJantwrG+ZBT?=
 =?us-ascii?Q?OgBSAYSBak9txB7QUR3+0SK/lG1g404ocnIYVcEaC2IL8HXPN+zYMzR0qjNz?=
 =?us-ascii?Q?pTMWVgHpDmbfFXk100ieGXKIEfmKdTVksGQTMR8Y5wZ97TQT3XBj24zgGjUC?=
 =?us-ascii?Q?AfYOxljY8kuG7gv3n1tbo/CBfPru0sWPGnGpkXDpNOrYq+axfh1NophSV2yA?=
 =?us-ascii?Q?LGUPqzl8vataJKfcJUhSC++YqPr9OCOPJv3iqINIz4dw/BLfER9slJSDDL4A?=
 =?us-ascii?Q?A0yYx9YQFfC8FkuKM9aYZ1C22xSrwiehWc1/gtnq//A2T74VrIuho76Hqyjj?=
 =?us-ascii?Q?ZhWG321D595gzzBi11/Kx9Qw9nKCevIoz3QQq4jLCkGL3KZXrhhO6bdBP5lw?=
 =?us-ascii?Q?kkvtrHOXQQE7U2m1KbHimArJQqYA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5316.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kow9MYM5xifXA8z9d1wYyLhGIvhxp43Mz1X1PWEN6NEeUwnvRNprwXG/ts7y?=
 =?us-ascii?Q?0dkgQ0dVqljNoATbQLuGNGbaTYNqYKLW6aghrnd80o5PyTYODWxrTYRMkLLS?=
 =?us-ascii?Q?3dAQ+HKGg1uG5O2du5dTo0mPzOuYKTQx2Kw5+zjf3EhhsEScYRMIBcUKX+V4?=
 =?us-ascii?Q?QNdJQjacwDInD+JwMAESwA2+Vcxuidg59KfyLFBxgVAVp9VnAHRsq10OUfXp?=
 =?us-ascii?Q?Prs+Eeg8rZAnXP/3B6S8sbTouAkIA2PBslu+RFul0LP1NBgxN4VgF7P0Zobm?=
 =?us-ascii?Q?Q9mFjD/vv7NppEzPIvYOx3MmCNUiRDnvgbP/A08H5VswyP+vVegRQXJw4PMj?=
 =?us-ascii?Q?TpLhxsyfvsDS7wY6Njx7gXEeWjONueP5TkPo0m2uPJCVl+oSs9rfRAEierLU?=
 =?us-ascii?Q?rvYqSoiXpPwD/mJPVzqBV5ad0W2+VfneHReUxfC8FNRr9yDqeUnYzIKvjDHq?=
 =?us-ascii?Q?4N913l38Xle0IM3tNDUJ2g0IRNU5g9nxMF51A+AVzJY+N9WwpLjwjxzzgCWc?=
 =?us-ascii?Q?gzCSriG1HMrKkmQ8GKJA9+quhw5SOB23hD+M2N056CKYZnLFxBK1VG6Q4MVA?=
 =?us-ascii?Q?V1MuXnmRo8GdJx4YozNg7t26+1xH5sUIAsAEmFGl7g0YbWJOZ472hAiwZRgD?=
 =?us-ascii?Q?pRDSWUbpmz43A7aprk7znQnsR60bl9tjoOMdE6pI2maGsJ1F6rxCD1Wn9+kC?=
 =?us-ascii?Q?q96fq3Yd1Q7KG4C3FlH4hwcJeKI/EDa+OOQHkLKTcg8z3Pmang7608HyYOHl?=
 =?us-ascii?Q?Pf1fWHbK1gtm+jxUo5cFZD+9nec4TA7uJ8CHg+SRZSTNcYhQfw5C7HLbKd0a?=
 =?us-ascii?Q?Q/RCk3jcZre2PWP3cEfQBN+9r5hddsbjKdZxazYfOyUlTyxsEZ6J8JUAKeBR?=
 =?us-ascii?Q?pCCU045xzJvZ0yu41OCkiOlVSwp+9mI2qXv1A1qfVmtss41neetc+QqwlUNZ?=
 =?us-ascii?Q?DP+quKj663vZpFqMEwWXff3zNtmhx6aCFH0Zh3cFpBcqYGueYx43YQ/UlWa4?=
 =?us-ascii?Q?61r11A1WOMmx+zx5H5Vk8kHtKkZml+5Xfaow2uEQlHx/6D3FqeMGqylrV7FS?=
 =?us-ascii?Q?EFZo9GwTeIYHksREG+vTe/JJNu35tmgDWUjuNK16txiA/gyFRwWkoqU40DXU?=
 =?us-ascii?Q?QROK9kex9i+8ZJt0g9PlOiVKdrve5ZtSS0KqC1E/ufvgdyDMX5rbQ346WaTa?=
 =?us-ascii?Q?CZBWQSn15IHvYEK5wAIZJF7zE2LJOCrpzWF101cZTzP0O0bffJmtycuEJ+Hy?=
 =?us-ascii?Q?gMtFH8I24sPjWpC01Y/zJChVAJsPyHyFDOcDMrvxQ7gC2QwhVvAJPN9BGx1H?=
 =?us-ascii?Q?/nmYQ8YvF5Xlh1j4MXxBTDHJvLgFbpTARFv4x22Mt1C/Asfbs1e9sdjkAPFJ?=
 =?us-ascii?Q?4yTPyxN673fOSCmI/LwatTWDaIn17Tu8+LJo/vmmRtGewU31cg00EA9VSmz3?=
 =?us-ascii?Q?sOgYvWJw6mLLqGOKOi60FmoIdM/C4g7pBhO9uuNjvempahAyCdl7Nei1yDHR?=
 =?us-ascii?Q?5FW63h+C5rU0Hk7owLaEfhHsTuFWyAb1SDh09+Ob6H4ufE7ihrfM3mb19jn2?=
 =?us-ascii?Q?1lRBWACNp+t6dZ773NsZ2ZX+yKD2lM9gBEILDDf4dRI9hJRa6kuHfcIKHB6C?=
 =?us-ascii?Q?Z5J/zi+Dit2IBQ6HXn83xHAyJb5Soq+83XF9nFTc88dwM2JR7b4OoTwHLR7I?=
 =?us-ascii?Q?LTtznA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5p/QMpqzW32hCXe31rRyDA4ByUI6uE6TNUimImD0ndKkioURLWFt2Qjcfo4WvVvdiZ8WDuKl/wCIzfL2btX9dCoLykLPCg2Ft74F18fR47ePw4NIUlpvhN0C+IEDcUw0QuDRHPSmLbW7Oi/1C1XYS2ZupavdfM5mvVoAT1vnR57qA3a9hyhc6Lp3z4WZcM1rHpwbaIr3ShcAElPcoiGh6GCSVbvkG/HTxurjHO+bxUn0rlFyH6fJJviFAJv8JTRBSa2b5ToyHGldQig0N39RPql98c4XZz9w3SaLCI6etA6tqtkePNUFN1nBjmQHgcG32NbpWYlfVH0DqdHed4MqKhAiWEkAH4cTEGn8OQRucY/Xf+mzyBeH5rxus9/b1Gnwgtsso4D08RNzzoeXEZtRrRR0Sf5LPYSUKZ6S93v35/YWglCI6xO+dHp7OHJz1TMoUQYVUK3CsdlRzj+FpJcvyhjh9MIJnBUEjb+e9f4BGAvoeA+OSg10ZX9hxA3wk/+Ftv5L35h8XySTswxrLJSllIM0VbXcQhBfyq45zCaWZTqqzyF85MSt/ufcIagWdf3d20b0Yz9rUClUQjPxltSo3tgqgNAuHKhpk/u5Sw9XLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658a1da8-bce6-43ae-aee3-08dd6c087655
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5316.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:49:36.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMOXidwyHXdtXWD2qSb46b0x3Bxw0X1DECaNtcJc93YGcKGEJZ5CAr3GDm/iadH/7yWYGddNFKWK/FgRVbhrm+BV2l1qD0teD9ZKgytZC0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260009
X-Proofpoint-GUID: HEfRcjzXdz-RKep6nNbgGXrzT927uv5Z
X-Proofpoint-ORIG-GUID: HEfRcjzXdz-RKep6nNbgGXrzT927uv5Z

The superblock is stored in the buffer_head s_sbh in struct ext2_sb_info.
Replace this buffer head with the new ext2_buffer and update the buffer
functions accordingly. This patch also introduces new buffer cache code
needed for future patches.

Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
---
 fs/ext2/Makefile |   2 +-
 fs/ext2/cache.c  | 302 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext2/ext2.h   |  43 ++++++-
 fs/ext2/super.c  |  52 +++++---
 fs/ext2/xattr.c  |   2 +-
 5 files changed, 379 insertions(+), 22 deletions(-)
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
index 000000000000..464c506ba1b6
--- /dev/null
+++ b/fs/ext2/cache.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Oracle. All rights reserved.
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
+void ext2_buffer_lock(struct ext2_buffer *buf)
+{
+	mutex_lock(&buf->b_lock);
+}
+
+void ext2_buffer_unlock(struct ext2_buffer *buf)
+{
+	mutex_unlock(&buf->b_lock);
+}
+
+void ext2_buffer_set_dirty(struct ext2_buffer *buf)
+{
+    set_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
+}
+
+static int ext2_buffer_uptodate(struct ext2_buffer *buf)
+{
+    return test_bit(EXT2_BUF_UPTODATE_BIT, &buf->b_flags);
+}
+
+void ext2_buffer_set_uptodate(struct ext2_buffer *buf)
+{
+    set_bit(EXT2_BUF_UPTODATE_BIT, &buf->b_flags);
+}
+
+void ext2_buffer_clear_uptodate(struct ext2_buffer *buf)
+{
+    clear_bit(EXT2_BUF_UPTODATE_BIT, &buf->b_flags);
+}
+
+int ext2_buffer_error(struct ext2_buffer *buf)
+{
+       return buf->b_error;
+}
+
+void ext2_buffer_clear_error(struct ext2_buffer *buf)
+{
+       buf->b_error = 0;
+}
+
+static struct ext2_buffer *ext2_insert_buffer_cache(struct super_block *sb, struct ext2_buffer *new_buf)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_buffer_cache *bc = &sbi->s_buffer_cache;
+	struct rhashtable *buffer_cache = &bc->bc_hash;
+	struct ext2_buffer *old_buf;
+
+	rcu_read_lock();
+	old_buf = rhashtable_lookup_get_insert_fast(buffer_cache,
+				&new_buf->b_rhash, buffer_cache_params);
+
+	if (old_buf) {
+		refcount_inc(&old_buf->b_refcount);
+		rcu_read_unlock();
+		return old_buf;
+	}
+
+	refcount_inc(&new_buf->b_refcount);
+	rcu_read_unlock();
+	return new_buf;
+}
+
+static void ext2_buf_write_end_io(struct bio *bio)
+{
+	struct ext2_buffer *buf = bio->bi_private;
+	int err = blk_status_to_errno(bio->bi_status);
+
+	buf->b_error = err;
+	complete(&buf->b_complete);
+	mutex_unlock(&buf->b_lock);
+	bio_put(bio);
+}
+
+static int ext2_submit_buffer_read(struct super_block *sb, struct ext2_buffer *buf)
+{
+	struct bio_vec bio_vec;
+	struct bio bio;
+	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
+	int error;
+
+	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = sector;
+
+	buf->b_size = sb->s_blocksize;
+	__bio_add_page(&bio, buf->b_page, buf->b_size, 0);
+
+	mutex_lock(&buf->b_lock);
+	error = submit_bio_wait(&bio);
+	ext2_buffer_set_uptodate(buf);
+	mutex_unlock(&buf->b_lock);
+
+	return error;
+}
+
+static void ext2_submit_buffer_write(struct super_block *sb, struct ext2_buffer *buf)
+{
+	struct bio *bio;
+	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
+
+	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
+
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_end_io = ext2_buf_write_end_io;
+	bio->bi_private = buf;
+
+	__bio_add_page(bio, buf->b_page, buf->b_size, 0);
+
+	mutex_lock(&buf->b_lock);
+	submit_bio(bio);
+}
+
+static int ext2_sync_buffer_cache_wait(struct list_head *submit_list)
+{
+	struct ext2_buffer *buf, *n;
+	int error = 0, error2;
+
+	list_for_each_entry_safe(buf, n, submit_list, b_list) {
+		wait_for_completion(&buf->b_complete);
+		refcount_dec(&buf->b_refcount);
+		error2 = buf->b_error;
+		if (!error)
+			error = error2;
+	}
+
+	return error;
+}
+
+int ext2_sync_buffer_wait(struct super_block *sb, struct ext2_buffer *buf)
+{
+	if (test_and_clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags)) {
+		ext2_submit_buffer_write(sb, buf);
+		wait_for_completion(&buf->b_complete);
+		return buf->b_error;
+	}
+
+	return 0;
+}
+
+int ext2_sync_buffer_cache(struct super_block *sb)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_buffer_cache *bc = &sbi->s_buffer_cache;
+	struct rhashtable *buffer_cache = &bc->bc_hash;
+	struct rhashtable_iter iter;
+	struct ext2_buffer *buf, *n;
+	struct blk_plug plug;
+	LIST_HEAD(submit_list);
+
+	rhashtable_walk_enter(buffer_cache, &iter);
+	rhashtable_walk_start(&iter);
+	while ((buf = rhashtable_walk_next(&iter)) != NULL) {
+		if (IS_ERR(buf))
+			continue;
+		if (test_and_clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags)) {
+			refcount_inc(&buf->b_refcount);
+			list_add(&buf->b_list, &submit_list);
+		}
+	}
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	blk_start_plug(&plug);
+	list_for_each_entry_safe(buf, n, &submit_list, b_list) {
+		ext2_submit_buffer_write(sb, buf);
+	}
+	blk_finish_plug(&plug);
+
+	return ext2_sync_buffer_cache_wait(&submit_list);
+}
+
+static struct ext2_buffer *ext2_lookup_buffer_cache(struct super_block *sb, sector_t block)
+{
+	struct ext2_sb_info *sbi = EXT2_SB(sb);
+	struct ext2_buffer_cache *bc = &sbi->s_buffer_cache;
+	struct rhashtable *buffer_cache = &bc->bc_hash;
+	struct ext2_buffer *found = NULL;
+
+	rcu_read_lock();
+	found = rhashtable_lookup(buffer_cache, &block, buffer_cache_params);
+	if (found && !refcount_inc_not_zero(&found->b_refcount))
+		found = NULL;
+	rcu_read_unlock();
+
+	return found;
+}
+
+static struct ext2_buffer *ext2_init_buffer(struct super_block *sb, sector_t block, bool need_uptodate)
+{
+	struct ext2_buffer *buf;
+	gfp_t gfp = GFP_KERNEL;
+
+	buf = kmalloc(sizeof(struct ext2_buffer), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	buf->b_block = block;
+	buf->b_size = sb->s_blocksize;
+	buf->b_flags = 0;
+	buf->b_error = 0;
+
+	mutex_init(&buf->b_lock);
+	refcount_set(&buf->b_refcount, 1);
+	init_completion(&buf->b_complete);
+
+	if (!need_uptodate)
+		gfp |= __GFP_ZERO;
+
+	buf->b_page = alloc_page(gfp);
+	if (!buf->b_page) {
+		kfree_rcu(buf, b_rcu);
+		return NULL;
+	}
+
+	buf->b_data = page_address(buf->b_page);
+
+	return buf;
+}
+
+static void ext2_destroy_buffer(void *ptr, void *arg)
+{
+	struct ext2_buffer *buf = ptr;
+
+	WARN_ON(test_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags));
+	__free_page(buf->b_page);
+	kfree(buf);
+}
+
+void ext2_put_buffer(struct super_block *sb, struct ext2_buffer *buf)
+{
+	if (!buf)
+		return;
+
+	WARN_ON(refcount_read(&buf->b_refcount) < 1);
+	refcount_dec(&buf->b_refcount);
+}
+
+
+static struct ext2_buffer *ext2_find_get_buffer(struct super_block *sb, sector_t block, bool need_uptodate)
+{
+	int err;
+	struct ext2_buffer *buf;
+	struct ext2_buffer *new_buf;
+
+	buf = ext2_lookup_buffer_cache(sb, block);
+
+	if (!buf) {
+		new_buf = ext2_init_buffer(sb, block, need_uptodate);
+		if (!new_buf)
+			return ERR_PTR(-ENOMEM);
+
+		buf = ext2_insert_buffer_cache(sb, new_buf);
+		if (IS_ERR(buf) || buf != new_buf)
+			ext2_destroy_buffer(new_buf, NULL);
+	}
+
+	if (need_uptodate && !ext2_buffer_uptodate(buf)) {
+		err = ext2_submit_buffer_read(sb, buf);
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	return buf;
+}
+
+struct ext2_buffer *ext2_get_buffer(struct super_block *sb, sector_t bno)
+{
+	return ext2_find_get_buffer(sb, bno, false);
+}
+
+struct ext2_buffer *ext2_read_buffer(struct super_block *sb, sector_t bno)
+{
+	return ext2_find_get_buffer(sb, bno, true);
+}
+
+int ext2_init_buffer_cache(struct ext2_buffer_cache *bc)
+{
+	return rhashtable_init(&bc->bc_hash, &buffer_cache_params);
+}
+
+void ext2_destroy_buffer_cache(struct ext2_buffer_cache *bc)
+{
+	rhashtable_free_and_destroy(&bc->bc_hash, ext2_destroy_buffer, NULL);
+}
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index f38bdd46e4f7..bfed70fd6430 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -18,6 +18,7 @@
 #include <linux/rbtree.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
+#include <linux/rhashtable.h>
 
 /* XXX Here for now... not interested in restructing headers JUST now */
 
@@ -61,6 +62,29 @@ struct ext2_block_alloc_info {
 	ext2_fsblk_t		last_alloc_physical_block;
 };
 
+struct ext2_buffer {
+	sector_t b_block;
+	struct rhash_head b_rhash;
+	struct rcu_head b_rcu;
+	struct page *b_page;
+	size_t b_size;
+	char *b_data;
+	unsigned long b_flags;
+	refcount_t b_refcount;
+	struct mutex b_lock;
+	struct completion b_complete;
+	struct list_head b_list;
+	int b_error;
+};
+
+/* ext2_buffer flags */
+#define EXT2_BUF_DIRTY_BIT 0
+#define EXT2_BUF_UPTODATE_BIT 1
+
+struct ext2_buffer_cache {
+	struct rhashtable bc_hash;
+};
+
 #define rsv_start rsv_window._rsv_start
 #define rsv_end rsv_window._rsv_end
 
@@ -79,7 +103,7 @@ struct ext2_sb_info {
 	unsigned long s_groups_count;	/* Number of groups in the fs */
 	unsigned long s_overhead_last;  /* Last calculated overhead */
 	unsigned long s_blocks_last;    /* Last seen block count */
-	struct buffer_head * s_sbh;	/* Buffer containing the super block */
+	struct ext2_buffer * s_sbuf;	/* Buffer containing the super block */
 	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
 	struct buffer_head ** s_group_desc;
 	unsigned long  s_mount_opt;
@@ -116,6 +140,7 @@ struct ext2_sb_info {
 	struct mb_cache *s_ea_block_cache;
 	struct dax_device *s_daxdev;
 	u64 s_dax_part_off;
+	struct ext2_buffer_cache s_buffer_cache;
 };
 
 static inline spinlock_t *
@@ -716,6 +741,22 @@ extern int ext2_should_retry_alloc(struct super_block *sb, int *retries);
 extern void ext2_init_block_alloc_info(struct inode *);
 extern void ext2_rsv_window_add(struct super_block *sb, struct ext2_reserve_window_node *rsv);
 
+/* cache.c */
+extern void ext2_buffer_lock(struct ext2_buffer *);
+extern void ext2_buffer_unlock(struct ext2_buffer *);
+extern int ext2_init_buffer_cache(struct ext2_buffer_cache *);
+extern void ext2_destroy_buffer_cache(struct ext2_buffer_cache *);
+extern int ext2_sync_buffer_wait(struct super_block *, struct ext2_buffer *);
+extern int ext2_sync_buffer_cache(struct super_block *);
+extern struct ext2_buffer *ext2_get_buffer(struct super_block *, sector_t);
+extern struct ext2_buffer *ext2_read_buffer(struct super_block *, sector_t);
+extern void ext2_put_buffer(struct super_block *, struct ext2_buffer *);
+extern void ext2_buffer_set_dirty(struct ext2_buffer *);
+extern void ext2_buffer_set_uptodate(struct ext2_buffer *);
+extern void ext2_buffer_clear_uptodate(struct ext2_buffer *);
+extern int ext2_buffer_error(struct ext2_buffer *);
+extern void ext2_buffer_clear_error(struct ext2_buffer *);
+
 /* dir.c */
 int ext2_add_link(struct dentry *, struct inode *);
 int ext2_inode_by_name(struct inode *dir,
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 37f7ce56adce..ac53f587d140 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -168,7 +168,8 @@ static void ext2_put_super (struct super_block * sb)
 	percpu_counter_destroy(&sbi->s_freeblocks_counter);
 	percpu_counter_destroy(&sbi->s_freeinodes_counter);
 	percpu_counter_destroy(&sbi->s_dirs_counter);
-	brelse (sbi->s_sbh);
+	ext2_put_buffer (sb, sbi->s_sbuf);
+	ext2_destroy_buffer_cache(&sbi->s_buffer_cache);
 	sb->s_fs_info = NULL;
 	kfree(sbi->s_blockgroup_lock);
 	fs_put_dax(sbi->s_daxdev, NULL);
@@ -803,7 +804,7 @@ static unsigned long descriptor_loc(struct super_block *sb,
 
 static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 {
-	struct buffer_head * bh;
+	struct ext2_buffer * buf;
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
 	struct inode *root;
@@ -835,6 +836,12 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
 					   NULL, NULL);
 
+	ret = ext2_init_buffer_cache(&sbi->s_buffer_cache);
+	if (ret) {
+		ext2_msg(sb, KERN_ERR, "error: unable to create buffer cache");
+		goto failed_sbi;
+	}
+
 	spin_lock_init(&sbi->s_lock);
 	ret = -EINVAL;
 
@@ -862,7 +869,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		logic_sb_block = sb_block;
 	}
 
-	if (!(bh = sb_bread(sb, logic_sb_block))) {
+	if (IS_ERR(buf = ext2_read_buffer(sb, logic_sb_block))) {
 		ext2_msg(sb, KERN_ERR, "error: unable to read superblock");
 		goto failed_sbi;
 	}
@@ -870,7 +877,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	 * Note: s_es must be initialized as soon as possible because
 	 *       some ext2 macro-instructions depend on its value
 	 */
-	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
+	es = (struct ext2_super_block *) (((char *)buf->b_data) + offset);
 	sbi->s_es = es;
 	sb->s_magic = le16_to_cpu(es->s_magic);
 
@@ -966,7 +973,8 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* If the blocksize doesn't match, re-read the thing.. */
 	if (sb->s_blocksize != blocksize) {
-		brelse(bh);
+		ext2_buffer_clear_uptodate(buf);
+		ext2_put_buffer(sb, buf);
 
 		if (!sb_set_blocksize(sb, blocksize)) {
 			ext2_msg(sb, KERN_ERR,
@@ -976,13 +984,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
 		offset = (sb_block*BLOCK_SIZE) % blocksize;
-		bh = sb_bread(sb, logic_sb_block);
-		if(!bh) {
+		buf = ext2_read_buffer(sb, logic_sb_block);
+		if(IS_ERR(buf)) {
 			ext2_msg(sb, KERN_ERR, "error: couldn't read"
 				"superblock on 2nd try");
 			goto failed_sbi;
 		}
-		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
+		es = (struct ext2_super_block *) (((char *)buf->b_data) + offset);
 		sbi->s_es = es;
 		if (es->s_magic != cpu_to_le16(EXT2_SUPER_MAGIC)) {
 			ext2_msg(sb, KERN_ERR, "error: magic mismatch");
@@ -1021,7 +1029,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 					sbi->s_inodes_per_block;
 	sbi->s_desc_per_block = sb->s_blocksize /
 					sizeof (struct ext2_group_desc);
-	sbi->s_sbh = bh;
+	sbi->s_sbuf = buf;
 	sbi->s_mount_state = le16_to_cpu(es->s_state);
 	sbi->s_addr_per_block_bits =
 		ilog2 (EXT2_ADDR_PER_BLOCK(sb));
@@ -1031,7 +1039,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	if (sb->s_magic != EXT2_SUPER_MAGIC)
 		goto cantfind_ext2;
 
-	if (sb->s_blocksize != bh->b_size) {
+	if (sb->s_blocksize != buf->b_size) {
 		if (!silent)
 			ext2_msg(sb, KERN_ERR, "error: unsupported blocksize");
 		goto failed_mount;
@@ -1213,7 +1221,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	kvfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
 failed_mount:
-	brelse(bh);
+	ext2_put_buffer(sb, buf);
 failed_sbi:
 	fs_put_dax(sbi->s_daxdev, NULL);
 	sb->s_fs_info = NULL;
@@ -1224,9 +1232,9 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 static void ext2_clear_super_error(struct super_block *sb)
 {
-	struct buffer_head *sbh = EXT2_SB(sb)->s_sbh;
+	struct ext2_buffer *sbuf = EXT2_SB(sb)->s_sbuf;
 
-	if (buffer_write_io_error(sbh)) {
+	if (ext2_buffer_error(sbuf)) {
 		/*
 		 * Oh, dear.  A previous attempt to write the
 		 * superblock failed.  This could happen because the
@@ -1237,8 +1245,8 @@ static void ext2_clear_super_error(struct super_block *sb)
 		 */
 		ext2_msg(sb, KERN_ERR,
 		       "previous I/O error to superblock detected");
-		clear_buffer_write_io_error(sbh);
-		set_buffer_uptodate(sbh);
+		ext2_buffer_clear_error(sbuf);
+		ext2_buffer_set_uptodate(sbuf);
 	}
 }
 
@@ -1252,9 +1260,9 @@ void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es,
 	es->s_wtime = cpu_to_le32(ktime_get_real_seconds());
 	/* unlock before we do IO */
 	spin_unlock(&EXT2_SB(sb)->s_lock);
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
+	ext2_buffer_set_dirty(EXT2_SB(sb)->s_sbuf);
 	if (wait)
-		sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
+		ext2_sync_buffer_wait(sb, EXT2_SB(sb)->s_sbuf);
 }
 
 /*
@@ -1271,13 +1279,19 @@ static int ext2_sync_fs(struct super_block *sb, int wait)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+	int err = 0;
 
 	/*
 	 * Write quota structures to quota file, sync_blockdev() will write
 	 * them to disk later
 	 */
-	dquot_writeback_dquots(sb, -1);
+	err = dquot_writeback_dquots(sb, -1);
+	if (err)
+		goto out;
+
+	err = ext2_sync_buffer_cache(sb);
 
+out:
 	spin_lock(&sbi->s_lock);
 	if (es->s_state & cpu_to_le16(EXT2_VALID_FS)) {
 		ext2_debug("setting valid to 0\n");
@@ -1285,7 +1299,7 @@ static int ext2_sync_fs(struct super_block *sb, int wait)
 	}
 	spin_unlock(&sbi->s_lock);
 	ext2_sync_super(sb, es, wait);
-	return 0;
+	return err;
 }
 
 static int ext2_freeze(struct super_block *sb)
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index c885dcc3bd0d..1eb4a8607f67 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -387,7 +387,7 @@ static void ext2_xattr_update_super_block(struct super_block *sb)
 	ext2_update_dynamic_rev(sb);
 	EXT2_SET_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_EXT_ATTR);
 	spin_unlock(&EXT2_SB(sb)->s_lock);
-	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
+	ext2_buffer_set_dirty(EXT2_SB(sb)->s_sbuf);
 }
 
 /*
-- 
2.43.0


