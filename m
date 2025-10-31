Return-Path: <linux-ext4+bounces-11393-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DFC26FF5
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 22:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8CD426A0C
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Oct 2025 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546C02F6904;
	Fri, 31 Oct 2025 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q/2rFama";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tpq+sWv9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D92F8BF0
	for <linux-ext4@vger.kernel.org>; Fri, 31 Oct 2025 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945571; cv=fail; b=pzGvJw3AcwvvqZ9GvYOioyLk2q7qWDAc2ZCJkYNWjBuTce1wYjXaU9vPZtWKTwxO4X2PmpzE+5+qjgISRVn5ZE65Te9pLGWoPtA8sBjAkXBumrjSnkc5Lq7xYuWYdfAMsTn8m5hwazN+I4ezQGmgxbr9qaaGA5WMhcmydScdW3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945571; c=relaxed/simple;
	bh=eAyTpGd6Si73hEzTBFxnV4W8VXitq8ZKTtTZtbjeYUg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nSUm+hbrdRCSOLPGLyXxAYNRArcWuEv2tWsFavvZWZhcAZUlybxMVpQb6oVssVxHYYPZR9h/6vTPhw4MPSb+iXCA2MyXWPLrAiERCXm/K5zC84EnK8mx62IkJ3caFARmronIVnI01FagFeXfy3Lg71VQICADA8GRyNFZrUJrJmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q/2rFama; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tpq+sWv9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VLEuZm009848;
	Fri, 31 Oct 2025 21:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=2r6d+4j9Y0mIQFtw
	i0LqTByi7yYoVdcdFJPmXbcgzWc=; b=Q/2rFamapgUiXoxsmiXTT6fZIRY19Jhn
	RSJ+j+ijgOXw6lBscQRF9nk1GpKaXAfwXDdG/ymTHhBBl3sNZq86jRkR1P0w5Pfm
	86SkpbWCJ+26fggSPNTJ2/mAy10Sp0og/XRITQZW1bkXwshWFV13U5B8yJA/6GrT
	Rh7TgZy/TXCtURBcJ+twk6ccSzF44uTFuVrgCql6jA6Uf+q3yBBs85Oa7dFn3tgh
	MgjEHsqGEZu7QaIpVnbgYAs7z5XYrg3sGXGl90loUy8MMiqDmChFYlrK9MdmxYFn
	L8AtLP7FhcaD2lPbiJScN2oQt7h0hkvmmzEXWaMb0J49yq+rbwVezw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a54urg0f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 21:19:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VJ2D2k017587;
	Fri, 31 Oct 2025 21:05:09 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33y2h2qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 21:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqIOHHjgLW4q8PTiiLfNqZZA/bWzDeDxOBUOBsCqdVkvGuL/FHIUiISa7IwBelPJuCduZRWhnIhNemRXoXspLwM+G3FkTN/JKPGBWVhWUiiiWMTrDTgq1ru2/pdxAfJha0xADgKusdAV4LXRA1mHheNI6LuOwhO1RxY3gmlcL9RMr9BNCGpzb04VX3iBUwF6Om3uJhy+6k2edyrHmALQXmQnhn/wh4a+d3KdJgMweefNG3n4cGFhqwPtR94WnZzb/Y6wObKXY6CpFmCVRUtvTNiThozexOcyhpQhVB3g70L4gedKejPplXP4M97SqNYSN7Re0PRaYetiG4t4QqpSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r6d+4j9Y0mIQFtwi0LqTByi7yYoVdcdFJPmXbcgzWc=;
 b=lGJFVHv8ZqQSH2sYuJZeLvqYFoqzVqx1a6slcWDGrb3BWzOuqdeIMQNrT1c6zRoYmFteLVE5Bofh40KPkpnOWDniIBVQ0qffE5cJmqMi7BwAvUVs0pKXkL8hCXU331F7mb6wB5MgCtrgehozjV7updMDyFUT6FpM12tkaunk59N6HC7ZbZLRSU10ec29k2jBW+4+UeauuJmsBQFTg2sDDGG8B+Uf5CHUFAlVI5pQ3oN4nANuLm+H3jH6h49UQyjjuz6U9EjtsAVOgf6fJjMGX3M2n2JwQLDmvUzfoAbuayOfgQeO/p+yLernvRnXA4nOo0bO1LaLstNFcaUkycwoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r6d+4j9Y0mIQFtwi0LqTByi7yYoVdcdFJPmXbcgzWc=;
 b=Tpq+sWv9wnbOz1fqcP42dbd3j4w5sgrUW7OFHC/PZNhrijv+8M/Y/YDaWEp5ETkNQbUHBaLQ4YVLvKZW04Xh5dVOGHa2RjMGjbxCi2wXwp/GfrhKnrMzFnsSd0zcgFQsyXic8/Y/QUUfN23YigE0iLvm5nQeeUqtTuV03ZPphGQ=
Received: from PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 by CH3PR10MB7861.namprd10.prod.outlook.com (2603:10b6:610:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 21:05:05 +0000
Received: from PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27]) by PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 21:05:05 +0000
From: Wengang Wang <wen.gang.wang@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: wen.gang.wang@oracle.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        yi.zhang@huaweicloud.com
Subject: [PATCH V2] jbd2: store more accurate errno in superblock when possible
Date: Fri, 31 Oct 2025 14:05:01 -0700
Message-ID: <20251031210501.7337-1-wen.gang.wang@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::18) To PH0PR10MB5795.namprd10.prod.outlook.com
 (2603:10b6:510:ff::15)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5795:EE_|CH3PR10MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a16231-ec0e-440f-6d94-08de18c12a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M1BZ/FeLq8s8/m8O+EkG+M/nXAt2KRUAjiXMvsvKFPoIp91KnyNz+5t2glfv?=
 =?us-ascii?Q?gjlMV24rQTAoZjbza+4Q6kVyZNg2sujzjNfSZsGroRIILKQnFbztMYYoaDcS?=
 =?us-ascii?Q?2/vyBO3/Lh4sgqXyJHozRmh86f32jpfUVqFfhPyVYi1VBM8xqwFwM3vDAL68?=
 =?us-ascii?Q?k9X2Aoe/6rakFdMiVUHPt2MyP8CPDlykazuJBCDFasD1WQ7FwiJAKJWWRvty?=
 =?us-ascii?Q?/eA9sYlmtxrZfzFvt8Eo+gN8SMoutRJ+jYCEFY7BVWye+RKN+XYbCwVteF7X?=
 =?us-ascii?Q?hWVrDBaob7LD5kmGph3qnrOrmj8Z811Bpy2CuxSDCWY4zw6IdW1N7l8s7N1f?=
 =?us-ascii?Q?/4j1GO1in0Jc0NuNbxLBnk5uFT7EN87zn5d2cd2WJdcTNbJkextO4pBrry7N?=
 =?us-ascii?Q?Ugj5EUs5fD/n5s2wUe/VJknr3Z19yMTCxP6VAZX16YbA2pLgKy4hReZrQAQd?=
 =?us-ascii?Q?agZt8UtbV4N+UhvqINR9LDWqB2LrsGSspfxeJ75Xx7jY38aUeX9McnT0q5aG?=
 =?us-ascii?Q?POPptMIW4Ih+razqC/qZLpGKnqRiiZaxTaoczVtJK0oLc0ldofIdovkTLsdJ?=
 =?us-ascii?Q?JIlKge5cQRfSgQyKSqRDEl9H9GqDG17DlBwvDysR00eTxPimIe76OLaaBaJN?=
 =?us-ascii?Q?5D6JktHY6Vo8NHyWlUHdi2nzoM/+DtHsHS4eKwt/ieV6yb8EJyhJICJnLHMM?=
 =?us-ascii?Q?NmuTxANvs1u9GtY5H0kpAqsYMYsZ2iSxpDNZ6LAEwuQG/H35deIW6gh3jps4?=
 =?us-ascii?Q?H6xqHEwTef8W9bVKcYzBSlSY1X3AuWHnJ+MpxD/gnb/2gZ/NE+d1b6c1nyyB?=
 =?us-ascii?Q?L0TscDdIfqpsWrl2iDw6j4NpcxmSnxP3UR5hHi994BhHePatTbS/OAbSGmfh?=
 =?us-ascii?Q?/M0xrER0M1W5qtGMPaV0rUd+nToBargW4cLA8H9aBuyX0nxTGiEo9eRvmBSY?=
 =?us-ascii?Q?q+DaiJR5frUSIdxFntFKakm6F87b73uC/niSi1lSRQN4ROdMuLZReApsxWNw?=
 =?us-ascii?Q?kGUneNz7BwNtveWIpHLwbo5/Tq/3nXwFn8m0LCy16fsSdR4EfWhp3TIeupcG?=
 =?us-ascii?Q?cPPQNej7+ZhOjAQRETvxdNtDX+ammchuZr8akkz+U6s/N6bIZgsmiIwYX6JG?=
 =?us-ascii?Q?Cp4wPzVAk1jMWSL253+/xT0gos0YQoRkoVutH0pJitF24ysBEOrcs9g2O9C0?=
 =?us-ascii?Q?hyUk36JEmb0rp4Y+P38W/r4AXOjJHh3fpLohySSkwukkcu1E4b44rsp2J08V?=
 =?us-ascii?Q?+l/8u1ceQOt2MkjrhVn4fqAgpfMGOl+6VJn3QlTD2MmWFK58m0JecIznV7WI?=
 =?us-ascii?Q?ve8pTzTOS1CeB62kuVOngqPdC1DY6vwNZdyy0BPjhTXv7ii7uTLi6QJnlHVE?=
 =?us-ascii?Q?x65Ad5c5x/wTCQfnF16U/+RJdep4x2vBq3vMPm3ts0KuDLl2Bog1o/gTQvCu?=
 =?us-ascii?Q?LAFhvZjKUAD95rA3EzKCMWjOwKwp6Gwb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5795.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3g3ClCZI8SNgeou0qg0pTNwwvE4LsWLyOIymFpLopRwT40Sx37nhyUZQ/sfL?=
 =?us-ascii?Q?k5zgIt0oGZu/zKfP4HbkYBYsDltF437nNOmueZL/eLyJmiuionQET4Vb2iie?=
 =?us-ascii?Q?W/UCgS5ItFhvWsE1ZkU9X4HzglF0o+dDUdwDFC7D0Nuel/XOK28A7fOU2EvR?=
 =?us-ascii?Q?K1SvlCFSPy0C2h3j4g8dl8/LwW1PCUdECWVL0j38kJAptCqQvtqg2DwAlZz7?=
 =?us-ascii?Q?jX9UeqWyvkF1ReFxSAhnAJc8c2OfhK+NF6OH3fQhrXOZTLUOfQypdqZ8KZb4?=
 =?us-ascii?Q?YnfMEi98PI9oBNOYm9xcx5PXDXwOjUIS2pfcQMNVZaQeHnSqN9LWY4SkHIgt?=
 =?us-ascii?Q?L0XKUf4XTBAD3oygg9StqAgRUdw59KMuxf+O/tH7b3sEbzGdnpq9tqte0UeF?=
 =?us-ascii?Q?03L15kNdk8zGkRDz2FfBinWhVHmTdSuTEkNBG7wMFXewJ8s+V8ZRV5aiDARn?=
 =?us-ascii?Q?9RkqQVgTpAzDvg87sncNXul5ITcN6ApYr0hS/LrVPW30ga+o3rlIttliLF3N?=
 =?us-ascii?Q?Vo6UcDRf5hLqqTfPEYEzOqaWnN9MnyRmvejfVugculJV1sqyIY1zb2c6+pQk?=
 =?us-ascii?Q?tYWqGxx+Un/6K5vFArH08I5v0kRPDOMJakj7VBwxhhyHlWNRfM0eMVHENnHp?=
 =?us-ascii?Q?L6dvSeURzR6JwCdSmiawUevaAlxJpoZA9jXtFY7XyquG3Fs2dEK54vk3AMWQ?=
 =?us-ascii?Q?moo2+kh/FYnQqk3iMu1Nfc3vBBlUVHaKd9iTTmCw+mgGwU2YUndFlU/fuWmz?=
 =?us-ascii?Q?hzcD6TMKm8+ADCGX/7kP/awvweqcSMCDgr5Y2KRU1nDxn3tqGca9C6txWek0?=
 =?us-ascii?Q?K5GG+gr4YFv79TUYpeq8tOxjN+OVWOJYk5OoUNkRZMCfhkelHrDoVtqLgJyd?=
 =?us-ascii?Q?p8IHJ+NZYUpjaDxhjHDO23APLQSMBZZ7jY90AIiHnNg0SGKC+YThfRktbObP?=
 =?us-ascii?Q?ntrugbQkWEAWKr9bP3oGJgAIE1xrNGD66+YnsncfPYXHy4jKWEJ3AZdABqJY?=
 =?us-ascii?Q?1MhfiL4Jf656Y1HoRZMdufXSnL1FwXkBcx1aW+AFfvaaWZCC+FJMa8pwi99k?=
 =?us-ascii?Q?i56bqhxLWXsOiBFrDT6A9kh2fqEinKUd3q1tTwEOeMs93/mWME9pD6uBn+9O?=
 =?us-ascii?Q?rvt1o73bFZeFyVeBZnPd8AObvfGuM1NTfKdFlkoDB1FJwnHDZLgzwXX0lvcP?=
 =?us-ascii?Q?84QJhxPU6Ri7B00ihYrtGPEl2Zi3yTgaihYs7YEkzZtWr6YEKi2E0qFvuHmu?=
 =?us-ascii?Q?zCBbwgeXDyw509wTmsVuajT880Nt10q15WZr0+vIq7hIw5IoVIJDubXFU0Ap?=
 =?us-ascii?Q?ViO7c3kW6szKmkdexiijU3zgwMo9bq+l/L0zEprvCt1aA4Gq9ofCo68lMIvi?=
 =?us-ascii?Q?ASQCN2ObsvfQxUtAyLAlC0tisSrjn+yOo5+N+RiUKjBsaNJz8oGixwSrFIVh?=
 =?us-ascii?Q?fdy85v+0/Z2sq7is0+jnSTjWXuBqz2Fs7UJ4L08ZJLkuDWZKVN2aTbOG0uOx?=
 =?us-ascii?Q?eg9qw8qfKKe6DJdHA2L8cRfC0sZuokFKqaLNolaCFCdqoV+w2H+HbVuEXsQZ?=
 =?us-ascii?Q?Fe8UorwHxRr0RMWZASly2LomahBnMOZ6TsIHCx6itzLU2gG98YOFsqik5OaS?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A2YOj/sRPinNCpIZaFrxsndp3XOMgxeetHKBtwNHoIsEkmYGtjs18JWOAgbCk5siWdZPvYHIYAgIGoSVE7iMSstxUjwRKkcboKyxCZgrpAsbAQgXkYeUJY/X0XyRVmKU0EXYvT8KS2r+IUgSmRfKUB6h4qyp/ZKgfmOixqtpFlcp0ri6NiXZfohzJkQju2V53IbXaDSrpHznFAIiTkMlEx1U+GV9Yts+hgwgVQ4QmOBCD1NfcjdL0MVtuivCs6FBcmfiAuy10ov0uc04+n/gMi7L0gNmnFX9C91i8hPe30HdxBOVHeeDO/cI0bWVTolcXXEi1e5QnX45RU9ca3DBb9rXIH/8U8R52wOB18WEu3AWmtpBKbJzGr+uYU0/64TzLxEbHrZIPz4jOkqXqqzkKUzg6a2ZKntAXeoHeeAWQjBNEp9DWs4y2x0REAL6y3OFVGTLfL3cWqJuZY8vY8fhiDzxJ2sn3acQOYzsmYJytJOj6L8ifGblM+XkBBwD9nJ6fVrhSAmLaJ8LABFgh3r7TIj/L/odNuGLig5yaMeUYeJQOtbOnEPcclKKoQhkLnGGLHvyO9ysFi2l4NRUPYPmdV+ZBC1i2eNDYjSaz9zpMv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a16231-ec0e-440f-6d94-08de18c12a3f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5795.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 21:05:05.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weZwGWvqeeYCPka7zr2RxLV2nePlVLEaXucFPwtSPl2QSf3VTfQo8kEtekyzSZjXyMWrImOw69i/1dvYPEJwnI85EkqiA8uX8BkIxaFPPow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310188
X-Proofpoint-ORIG-GUID: Qa9NJ-JZjE-FLHFK_M2_bTqh_L2J2a6l
X-Proofpoint-GUID: Qa9NJ-JZjE-FLHFK_M2_bTqh_L2J2a6l
X-Authority-Analysis: v=2.4 cv=YqcChoYX c=1 sm=1 tr=0 ts=690527d6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=MSlY4O-fIuqjGdFgB1EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE5MCBTYWx0ZWRfX7kZMZxFobJpP
 TNQU8HHepYsNa9S6PKGvsWbbGdHaEuGYn7wFkEt3+fr0FuazJ+cb+0589/yah3I//wKzS6IV43T
 hba6OEhplDjVYy16Q7/osKsdD7cxmlt95+g0kSq20e4iOtuqcBNchlUDjZGP+Vy3TlwMTQeEpbL
 yDFxLIhhBIhk0scq0qI17WRafSQ18UtxEk8AvSV7OVmItPU5+eptI6h7jf45yK8Vm6aksBJ/rWB
 DAcUnL3RqnnHbz6HmzkiKl4mnE60sSHhZ73hh2qXRYXZngqi4pRRxTGlLfFFcmXfnVu9qoocfh1
 V6ux5nDOs8xaJyB8JG/SgwXPu1yq0rcX62tOJhrhydx6Pyh/96JOaNtBC2sL+eREEB5hYIQ4O/k
 SjDkuOwoMKScUYtDUSO+OVra3t+MDg==

When jbd2_journal_abort() is called, the provided error code is stored
in the journal superblock. Some existing calls hard-code -EIO even when
the actual failure is not I/O related.

This patch updates those calls to pass more accurate error codes,
allowing the superblock to record the true cause of failure. This helps
improve diagnostics and debugging clarity when analyzing journal aborts.

Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
---
 fs/ext4/super.c       |  4 ++--
 fs/jbd2/checkpoint.c  |  2 +-
 fs/jbd2/journal.c     | 15 +++++++++------
 fs/jbd2/transaction.c |  5 +++--
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529..b82cee72f7e7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -698,7 +698,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		WARN_ON_ONCE(1);
 
 	if (!continue_fs && !ext4_emergency_ro(sb) && journal)
-		jbd2_journal_abort(journal, -EIO);
+		jbd2_journal_abort(journal, -error);
 
 	if (!bdev_read_only(sb->s_bdev)) {
 		save_error_info(sb, error, ino, block, func, line);
@@ -5842,7 +5842,7 @@ static int ext4_journal_bmap(journal_t *journal, sector_t *block)
 		ext4_msg(journal->j_inode->i_sb, KERN_CRIT,
 			 "journal bmap failed: block %llu ret %d\n",
 			 *block, ret);
-		jbd2_journal_abort(journal, ret ? ret : -EIO);
+		jbd2_journal_abort(journal, ret ? ret : -EFSCORRUPTED);
 		return ret;
 	}
 	*block = map.m_pblk;
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 2d0719bf6d87..de89c5bef607 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -113,7 +113,7 @@ __releases(&journal->j_state_lock)
 				       "journal space in %s\n", __func__,
 				       journal->j_devname);
 				WARN_ON(1);
-				jbd2_journal_abort(journal, -EIO);
+				jbd2_journal_abort(journal, -ENOSPC);
 			}
 			write_lock(&journal->j_state_lock);
 		} else {
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..d965dc0b9a59 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -937,8 +937,8 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long blocknr,
 			printk(KERN_ALERT "%s: journal block not found "
 					"at offset %lu on %s\n",
 			       __func__, blocknr, journal->j_devname);
+			jbd2_journal_abort(journal, ret ? ret : -EFSCORRUPTED);
 			err = -EIO;
-			jbd2_journal_abort(journal, err);
 		} else {
 			*retp = block;
 		}
@@ -1858,8 +1858,9 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	if (is_journal_aborted(journal))
 		return -EIO;
-	if (jbd2_check_fs_dev_write_error(journal)) {
-		jbd2_journal_abort(journal, -EIO);
+	ret = jbd2_check_fs_dev_write_error(journal);
+	if (ret) {
+		jbd2_journal_abort(journal, ret);
 		return -EIO;
 	}
 
@@ -2156,9 +2157,11 @@ int jbd2_journal_destroy(journal_t *journal)
 	 * failed to write back to the original location, otherwise the
 	 * filesystem may become inconsistent.
 	 */
-	if (!is_journal_aborted(journal) &&
-	    jbd2_check_fs_dev_write_error(journal))
-		jbd2_journal_abort(journal, -EIO);
+	if (!is_journal_aborted(journal)) {
+		int ret = jbd2_check_fs_dev_write_error(journal);
+		if (ret)
+			jbd2_journal_abort(journal, ret);
+	}
 
 	if (journal->j_sb_buffer) {
 		if (!is_journal_aborted(journal)) {
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3e510564de6e..44dfaa9e7839 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1219,7 +1219,8 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 		return -EROFS;
 
 	journal = handle->h_transaction->t_journal;
-	if (jbd2_check_fs_dev_write_error(journal)) {
+	rc = jbd2_check_fs_dev_write_error(journal);
+	if (rc) {
 		/*
 		 * If the fs dev has writeback errors, it may have failed
 		 * to async write out metadata buffers in the background.
@@ -1227,7 +1228,7 @@ int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 		 * it out again, which may lead to on-disk filesystem
 		 * inconsistency. Aborting journal can avoid it happen.
 		 */
-		jbd2_journal_abort(journal, -EIO);
+		jbd2_journal_abort(journal, rc);
 		return -EIO;
 	}
 
-- 
2.50.1 (Apple Git-155)


