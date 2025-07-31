Return-Path: <linux-ext4+bounces-9244-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067BB16E5C
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 11:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552843BAF26
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 09:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908AA29E0FF;
	Thu, 31 Jul 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mFXeK/4s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sfuevjo3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3A221733;
	Thu, 31 Jul 2025 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953569; cv=fail; b=jJTsOSeMLsVSgt0FFDOBxDcvIKTMs10jaqyNZvvZpcuaWdlxqGmq/+Z3HJTIBTI7afax7Kc6JDf8VCtNWFTveJhzLuHCHabjvPaNTHvfuHy7Sl1AK/6xUd/Q4R9aaRx06cGw3s2KPBpS7Be1TRNRlB1gadHclikRtUlyd4qxkcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953569; c=relaxed/simple;
	bh=nZoWS81Hw8jgsZAi5PE7PIDmoopoQYGmgbtAsCnnjck=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fQTo/ChD9kOdxGm4HW5mF4G0s0R3P+hnkFqG+seY2BBXJMHxjOS2zKNi+V7Xjf3u+4HNp4T29zq4IT8DttoN4zYeN8peXfmGmllJk2ve0upjCW3QgWHHH37ZcQVhyp2XTnEcWZ/HgQ8roDxwrfGbkTMa2fXfnMsvaU8HVr9bW1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mFXeK/4s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sfuevjo3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7C3Ju009438;
	Thu, 31 Jul 2025 09:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=pjBk5LjkuEykSEK5
	VxddCAyNUScjp6PJv2pj5Dk/Xa8=; b=mFXeK/4sKT2euiTCgOfu6lRUoC/7iPRj
	X9pHooXJ/ku6kCUJQNAIocftPXLqWW7eaEB6RnT2oYX+8TfomCUqqfV1XV8qIhaV
	De2d0jnxd99ZuR8VLfPgiEuF/U58954cOzh1YC/D8pUkPPALd2HarySUC9UPTZW5
	4jid1BqmDaDngDpmjzQD4XRAmCYUGcNPsdyXUMzMWdWrQRa1sNzZFparjXqkJ9tc
	9Q2SymR3VPwPnRP44Ts70OYYh7oSj4d6YrDheW+w2fB/KPGDZihWB7llqF46A3Ty
	jyBRCWIc0aCznbuPqEP90i74JTgW219q5tfaDicd7vadxDDsSGzO+Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ebu2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:19:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V71RWc020374;
	Thu, 31 Jul 2025 09:19:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfjjpn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvltwy0Hgwk12lbkUnMhZeIQquvukl3/nyft3xnXkfWU47VHbFPSyprSR5ytQ3Hb1vwEXpmtnHDWEAM4m2skApkiqmzzbap1RZ8SXH3Kh37k3LAP6zV496HQ1AAiB1MHEB6wCWq1Oc2+WAFXS015dyYk1uK9TvxRgnjj/Uua7PQakvR/5HTXnmFxJ0lvjgMidZsrSQxhAFMMsqVklHu3Go+4zrutFPBwOqU09vpm49uNnodERsDBTLzblB3+KH8qj7gxHWvs22eQ96MqRqdge64IaFXIWmFrO/QxopcWbV2rMrJW534pYwRn/iQZoN8Y/zGOTqeeB/WU13r835FLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjBk5LjkuEykSEK5VxddCAyNUScjp6PJv2pj5Dk/Xa8=;
 b=E4zQmLxz+zahcfa9i76JFPc65SPGlw9lUW6bo/87n6e5BoJefIvnifd8Hnn6RnzNkB5NBr3L3JuhcThN2/pcF9U6NFcD1PK1poBWteEtYuiqGHP1RqzRgLtIgYBB9AFtuQ+1UevGLOqlm0xNrURC37qRSHCRNrmTEnGCUY8WVGjBWn2L9u3WS9dypJK5e+wEqb+y7z+ZazRqJ7IHNxrykQjEfL5r8oAbphxveXmIwUKUHGp8E5OQO4WnK7YGqeumz8yfTMlz3hPv4lm2tP60ZZ2zEF5u844TDmbxMnQ/CxBC1SV4rnWuIGqtKmyik5W3wnWdP7cvZrEszBOxnZmc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjBk5LjkuEykSEK5VxddCAyNUScjp6PJv2pj5Dk/Xa8=;
 b=Sfuevjo3ROrqvSIOAqggiOUaHo2Q8FwYvleklWH+wFeoLqsxhmXtbAwQJw+gQ/LgG/5FqGdOXnKXYYA1ftjGRmxcPL5xOh14QeuVXpYHPixI4DqRJ8yRhaZLNIdxWf4YFRKA+O/TKOKDMjqEAB8xiDOlWl1qBN81JiaUzhYMV7I=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4232.namprd10.prod.outlook.com (2603:10b6:610:a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Thu, 31 Jul
 2025 09:18:41 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 09:18:41 +0000
From: John Garry <john.g.garry@oracle.com>
To: zlang@redhat.com
Cc: djwong@kernel.org, fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] generic/765: modify some steps to fix test
Date: Thu, 31 Jul 2025 09:18:13 +0000
Message-ID: <20250731091813.2462058-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b98e5e5-3572-4ca4-7083-08ddd0133d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYCCqUCVGZPtPiuzCy9lGDMieuHyHYvW/NWZ2195UQA036a8HKLB3eDnJVFU?=
 =?us-ascii?Q?TuTy/gYANU3xSbzkEMFbNhlhafMKUDEDwvEJYTbJskrROD/oxNnbTGlFe3Lu?=
 =?us-ascii?Q?KIW6JSuB1U9525kCj783wv1xv5t24ZwcMFSb3erIwXrtiQrQW/dRf7RNT4li?=
 =?us-ascii?Q?CwH3w3eSP+NivlaFu8R9rbF7hDBSdXgqq8mLYHTABELYGkmMRZsKRzYBQ077?=
 =?us-ascii?Q?YTMPl8YrVCkXOMxvXbp4oSBz0ebU6fc16kDXWS32VjuCQWO1Jy9buqSYchlB?=
 =?us-ascii?Q?zI10k+HY4HvAe6UK+3UwSl7W4xAvSZe6jHvzHn/rC5c/0TqtKmSlF3ilMfAq?=
 =?us-ascii?Q?veuAhE+HdktOijicNOc5btTGzU1tTkgsWzXh/BRA+UjU5IJCG+OTo6W15M8I?=
 =?us-ascii?Q?80E1tF+tIlienk8I2VrYAL8QhSpXG2zT3DPS+OBeVw+AcBGGSO408RvAAXN/?=
 =?us-ascii?Q?gMGR7024FLIqF/RYPibZAJqY7UwNpOWUxIfmia5DAJbAn1TWtK7GMtn5Kn2e?=
 =?us-ascii?Q?XBVU0svRjdnl591RPeL//8A+WKL8Xw/6Tlf0rH3xwUgdBowMgI50JrbZcBqS?=
 =?us-ascii?Q?aEUyYDcbNy7gvcOY93rQkwvKLlM6Yratq/x3jLgtrZaePwDOc3vayFKOa0Yc?=
 =?us-ascii?Q?oO93FXRw0+yXf/i4pYXZesBDy3CkA07IDZx5nfYm+GEQh8fM99f2xDMNGKtn?=
 =?us-ascii?Q?3Uk6lhKCgMBr8nSZKTwP8IyJ3CXFmDOtgxW3Lf1mgPFDVEKP5m+JjXDcsfWv?=
 =?us-ascii?Q?ZuXtc01EV59CQFSHu8ww0L0PZ618T6BhQ6XXJO0JL1J3lgsw9OAy46EIvPJ5?=
 =?us-ascii?Q?P04AJ0vifxh8aHINH2CLb6jWcATgmcxfshe+3tffo2EgURNs+DT6q8ZvOAbL?=
 =?us-ascii?Q?13mBx2H78UcT1bINf8NCXeWvNSMtCiPLJACe6Fec4B9BkBfdJLypwFXaJXtA?=
 =?us-ascii?Q?f3UyTimOc0L+gI7yRAJ5Sf+OWgXprrZElW8HgI3YviQH3d2D4Utv0k0Xj3pt?=
 =?us-ascii?Q?C5YCnDssLsYnZWJvIqhRtriuIIgyFUFWiDcbhZCWKhWfOhjclQaqJUX7vsH0?=
 =?us-ascii?Q?K75VvjQcMyX5/pC8CUbJ0EpEBsWavUZHKc5U7QOhMWrC27Xs7kANRKSL3tXA?=
 =?us-ascii?Q?lHwEGhE1ItgUZLPTJxCxsIb2jOeKTe33SvVCN+ID0ELK45Og7danOFb4KatI?=
 =?us-ascii?Q?fUOquSAtpxtIaEmq/mP5L4/iNo5tCjtjg+BRG25vzP9Vd+0Vk607xp6jFnT7?=
 =?us-ascii?Q?y9BtLudQDeTBOslwTPfG27h575kCuYz/tVs2zTxqFhU/VNz9WL9qh3tpNRyf?=
 =?us-ascii?Q?HzCELwGZVxRFLodzMn4ReXq3g5VZhIQ0+RVynsSvjQE9y0LqBeInOX2aAZxV?=
 =?us-ascii?Q?MCwQY4uHZNjCieYhWnDupqOGR9ukhxjtbF68gElh/uv3sblKxUsaNRMFztUD?=
 =?us-ascii?Q?Esyxusz35VA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o0zlooQy9Fya/ab/Aun7Q5foDGYPYJrRKYDeTVDUNOVohZLIt0j1NUHgu5uE?=
 =?us-ascii?Q?I6CN1jiJqse3qlcsGMPsoGt6Of3PECtrOhNCaM1yVT7ya6ZLiTEOpInO+qdE?=
 =?us-ascii?Q?uKRerjbjHZOIvRa4YGqnkKI8rFirZDDU4v4LPtjCahYrCt8MirbYqoF6xgtQ?=
 =?us-ascii?Q?RUJ13ux5qWLNePlw/MOSSmrAEW6UNnuJ7g+4J7W1hNZrbqIb6Uhjy7PvOM/t?=
 =?us-ascii?Q?zWpwiNrp3RIqRjQMIlktYbuxxmk7P3yRADvLyZvOM75Ht1U7xevGi1JD5C4e?=
 =?us-ascii?Q?OuaZCXmyBXFcECVFKuU1EJrQLHIB4JMNBolBc4R0ZkKDK2UyO/WcEp9XCN+2?=
 =?us-ascii?Q?Pvb7pz5lzwyFerELD9Vq4iEl+d+kz3E24k4SKcelSmMLKi98KpK5asPbIx17?=
 =?us-ascii?Q?GgoAeudIRDEcBxa66YyiM4q7L70mvXhg0qmjEG2UnqprsstFr2eZPI583C4P?=
 =?us-ascii?Q?xhYemeV4EFnpNO6pKk7zrCYS6QWnmonzh/1cOtzgUfE04gZyaMsScONV7Y7H?=
 =?us-ascii?Q?ANdxLw7D1XA/fhTNQ+2UrTn4+X4RgZg6jPlueNbFIOeTxoIj7BGLzTJbRJKR?=
 =?us-ascii?Q?HGmSCXTGPlGEd0uWhDm4SIS7g5xJyQ6livqEVlDcw8FRQhDvMRGdgrmOl/ZF?=
 =?us-ascii?Q?uADNEoC8uVLS5MhfyDkg1+o7Aelq8v4rc8cRdZ9Sh+OYg9p8AxVfTAs1lTGa?=
 =?us-ascii?Q?us4cKQgavWcnfLFHBK+3YZLeLuw4Am2DzmCj1dnAqMgt6FHLuq07XgD6KVF3?=
 =?us-ascii?Q?yYDTF2bKmHO65WorBW7OWRVgakc+lr3RMNAuezLN28jN5Gv7lZmne4jE0Bu3?=
 =?us-ascii?Q?kwutiGWGO6bHUkcy+rO7nEN+V+7D+5So76Bbsp6j1VPnT7O6oVaeOcXyc+T1?=
 =?us-ascii?Q?j2K55WuWv+Oemuw4ZCtaOPedaCOT1CmrEQZtHZhMscp21WVS8xpC4H82WMAM?=
 =?us-ascii?Q?cFS5g8C+Se2bOQZKt3oImNtaudOdv1WgB8bEfeF0Mu/psdpLnXSkQHURciMH?=
 =?us-ascii?Q?LRKX8b/bYOs4EokT3fdJmJFINU/UdhSnIOBOa0Atge0kqajM75Cg5n8AjADf?=
 =?us-ascii?Q?CoP72ycjfK+6HHzlGjmdxyXHubrtVFLeS6nE6yOrjLkTaH9o1L4nxyyqP/nw?=
 =?us-ascii?Q?tN76kuHfeV1f+xlgEIru0PPGkeBlk81IOuXGF8JmVfCrTI3xXNmePambWr0M?=
 =?us-ascii?Q?rSfR3nuWTAPyaMQBOIe6FpdWpRatYeFnVSBQ34aXEoWsn8BP3uKsUtNsiH59?=
 =?us-ascii?Q?clg9oPOUHIec30KGzpUChFvcLj6Rfn3ZfNSLFMUHq5ea3Arx32lNbq5azFBE?=
 =?us-ascii?Q?HOuxJ80n0WqV49YF+1TL2Ef0lRykd19hNM1I6Gy3SaUu4ky3DWVqWY7tReIV?=
 =?us-ascii?Q?+DjOaLJcZeV4Mlrpfz4O1kTtW0rZnHlKM63doDa7uBzqzVV8PoHo7hAl8p+W?=
 =?us-ascii?Q?LtK6K7/xJSn7rMtWSKdZ9Kvczy1qq7gtI/RaQDI2YidHrBgJrO9AYIkr6Ly6?=
 =?us-ascii?Q?TAEo0uU2Qzz5Y5+K4wvKXGPJ6aY92SOPKJPEcZNRarPg3/gMogpsRosDEd4/?=
 =?us-ascii?Q?sl2493CvLDvLOptGOj5AMfJwEwYxczjPddlRQBbIi0gicgHTI3lsCgHPf+hw?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SlWTydT/CyjPbmVt3Hu3wXFegsXN6LStQTeILmcdrYOoBoCm164qoNYeMI1DL/MdG8uthZp9i8pqT5HkscUN5O+ccvFeilKdcvX9q3aeO5dczXW50KowIyxJts06ui3BZmlkk2PSBOsT5+jzmuovLaEu1Kdt7rIWr9kxVyOaNDMaYhPfiXhGO27r2JELpqVumtE71qEdHNLLZkAAVQRngWRF9T85zIFqE04EqzkO77cyrOQglvzyEbqMB0JBFREHvye3IyZU4zW0NpgEoPHKTI8uKKhh1oWKRb+EFjUe4GEgCLiXe2dfP6PZFQmh8FTGpuA1TFyUFPL5EUDSXATR3wXwXbKVnuZRNbqJpZzXAxCuiHFEC2VqZwhKa+QTftdn9Njc058UbG3wo2BDAEZSIJFtOuENy+3fbjXzQ54nOHwWi4XsK5s/fDYA+S8zvKeZZGuZzh1qHgXlcrpeA9zV70VREpO721smdPoExcBEKADw84XUexxBXantjxDTG5TM602RB3buKJR+qhb4XyUnYYoK+mou2nTfWa0wL5c2twts30GKl4wch54erFbuEQ/gDEPL6p8Gt40YGA6R01c0F9rC5KpZZk5AkMtpmeM0kgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b98e5e5-3572-4ca4-7083-08ddd0133d72
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 09:18:41.2020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gY3BrXbcQjI+fX4E5x112VtODBprBTmnLFLQyvxHBLVHLa7/ovtzbtbshjux9JwriqI+mXveOixrf8NNWZg/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310064
X-Proofpoint-ORIG-GUID: OwfkVQ473k5Bq5XL_wtdUhF_bU9ClbyG
X-Proofpoint-GUID: OwfkVQ473k5Bq5XL_wtdUhF_bU9ClbyG
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=688b3513 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=LtZAGE1ReaBs-9uQQ1sA:9 cc=ntf
 awl=host:12071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2MyBTYWx0ZWRfX49t/4vmaRije
 KOCv1RUkOVwabrzNtYH0zngkPuLM7IbfcBqnee8DLzB6w+mT6IcEOBt+Rcs8Y2FxTwPUmiI84Tq
 vnilyarqlLa48bZecekO/Dz4A90/ftVN1Zw7qutfHfTv+VJGo2h8i5Xj5q8eF2WdVaXNm6GniiG
 2UK2SIWT814+F+014yEntJyLqH1u7jUDE5islSkSViSHjmuOzW6ubgpw8eU8j1l+M1zOoqAtCEF
 +Il5JbUJptzBVYOTQyyfNi2SbUT9UmstkoIPsb2Yzzc5jIIH3B6Z9kJ5pzGUtKmba10QGPvUCMl
 n0Tqw3shChsW+cSdk1QIjMYCLytE8IPAgBJ3eFzHrji68cu29KoBM2rIrC1GoCKeLim3cVpouud
 y1azEBfskEkqmyaT3ZCwHu/86U76hK3rs2mCGSmz9hV9qB5jpl1xSqiLskxZyheR15EYZ3Ut

Now that multi-block atomics writes are supported, some of the test steps
are failing. Those steps relied on supporting single-block atomic writes
only.

The current test steps are as follows:
a. Ensure statx for bdev returns same awu_min/max as from sysfs
b. test mkfs for each size of bdev atomic writes capabilities and supported
   FS block size
c. Ensure atomic limits for file match block size for each in b.
d. Ensure that we can atomic write block size for each in b.
e. Ensure that we cannot write file for 2* bdev awu_max or bdev awu_max /2

Make test pass again by:
1. Modify c. to ensure file awu_max >= block size
2. dropping e. We already have tests to ensure that we can only write a
   size >= awu_min and <= awu_max in generic/767

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/tests/generic/765 b/tests/generic/765
index 71604e5e..8c4e0bd0 100755
--- a/tests/generic/765
+++ b/tests/generic/765
@@ -84,8 +84,8 @@ test_atomic_writes()
     # Check that atomic min/max = FS block size
     test $file_min_write -eq $bsize || \
         echo "atomic write min $file_min_write, should be fs block size $bsize"
-    test $file_max_write -eq $bsize || \
-        echo "atomic write max $file_max_write, should be fs block size $bsize"
+    test $file_max_write -ge $bsize || \
+        echo "atomic write max $file_max_write, should be at least fs block size $bsize"
     test $file_max_segments -eq 1 || \
         echo "atomic write max segments $file_max_segments, should be 1"
 
@@ -94,34 +94,6 @@ test_atomic_writes()
     _scratch_unmount
 }
 
-test_atomic_write_bounds()
-{
-    local bsize=$1
-
-    get_mkfs_opts $bsize
-    _scratch_mkfs $mkfs_opts >> $seqres.full
-    _scratch_mount
-
-    test "$FSTYP" = "xfs" && _xfs_force_bdev data $SCRATCH_MNT
-
-    testfile=$SCRATCH_MNT/testfile
-    touch $testfile
-
-    file_min_write=$(_get_atomic_write_unit_min $testfile)
-    file_max_write=$(_get_atomic_write_unit_max $testfile)
-    file_max_segments=$(_get_atomic_write_segments_max $testfile)
-
-    echo "test awb $bsize --------------" >> $seqres.full
-    echo "file awu_min $file_min_write" >> $seqres.full
-    echo "file awu_max $file_max_write" >> $seqres.full
-    echo "file awu_segments $file_max_segments" >> $seqres.full
-
-    $XFS_IO_PROG -dc "pwrite -A -D -V1 -b $bsize 0 $bsize" $testfile 2>> $seqres.full && \
-        echo "atomic write should fail when bsize is out of bounds"
-
-    _scratch_unmount
-}
-
 sys_min_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_min_bytes")
 sys_max_write=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/atomic_write_unit_max_bytes")
 
@@ -150,14 +122,6 @@ for ((bsize=$bdev_min_write; bsize<=bdev_max_write; bsize*=2)); do
     fi
 done;
 
-# Check that atomic write fails if bsize < bdev min or bsize > bdev max
-if [ $((bdev_min_write / 2)) -ge "$min_bsize" ]; then
-    test_atomic_write_bounds $((bdev_min_write / 2))
-fi
-if [ $((bdev_max_write * 2)) -le "$max_bsize" ]; then
-    test_atomic_write_bounds $((bdev_max_write * 2))
-fi
-
 # success, all done
 echo Silence is golden
 status=0
-- 
2.43.5


