Return-Path: <linux-ext4+bounces-11093-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90031C0D91B
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE4188B801
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F48931078B;
	Mon, 27 Oct 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dtw/0vO6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="obUS7uVk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521930F544;
	Mon, 27 Oct 2025 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568183; cv=fail; b=ZLeryIp1JjIDDyEeRHRf+UhxA5jqsZ6IoPMcZhjUnDREJFtw6goiclbWvV1pUId7gz2/W4SXljHxOWhN3igwpa/tOPp0GZvr1jUZY9NvVEPz3hUdb+AmfkSGQUlYh26A6jvjWfcQ3dlIDXbwRyw92n/sXkpPlOqiBSpRhjZKNoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568183; c=relaxed/simple;
	bh=9t4QBN+QpeV/4+RfCsFB5tGWghzLGL1BFwO5oKPoi6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMHgSORn3r2KOenwGyG/YKeiW5sJh03CstDroD6fcG86dzWlfEsnkPORhtwRRa3nCxwI6sKK2heDveUTBJrL4T+NnKWeRqCAinnVJtb93KWqtGucQtiinutCixR/1FEo4eIMSg0nfcSeRBhrAKnl15aEzkQXNZi5Wi/eV/qkdno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dtw/0vO6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=obUS7uVk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCCQoU007390;
	Mon, 27 Oct 2025 12:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V8+JeUiIuH7eVva3pOXFlGYID03SjbsKZEJTSX5UBm4=; b=
	dtw/0vO68Il0ORobZeObiHPDUh/1tpAai5hH6OfapnDJBytWMxy8zBfO3sTAlXMh
	sEaMG1vrMfEIEOXxXVtojR+xWq3KJU2wXis9TfrMhDcClknriXgkHU9AuIFXfzhD
	klmGPb6Y1p5ootAQrLktxJxMejEbGNgdFPkY8AnnEfhFRl4CVP0j/KLqqbbG5Uom
	s0ssytIzmZIa4InAro3X8y5qJZxzMGjGeBZ7Tg2+jWBnIwm8uPiU7G5ojdkWdz/4
	eU3wv7CAqHT8RyK5qYl/3QgnIdcqd2nYPzB7mv2EkZXEeLu7reQqN1ZTHrng6Kah
	2pi6WFQpCpuDtE/LkYzwTw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwgsgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RARlEQ014984;
	Mon, 27 Oct 2025 12:29:11 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n06r04f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewPODe7cDMdgRQZ+2qvdWq6G4Go/oigEaJG635nzTbDslCeYKFOSH2Z/E3CHhKj7Yfsfu3R9MylpXtUtPMo0TPGhF+YkN/z/Qr4TxUpIJFMb+hCBSfwvyY9Wbk7q5zTz+O29irxAiVnNCs5Mq5BuTbMWfgMYizs9kIOmfukfNhRo/XKLn4uiXKM0lam5wJwXYC0TGS2VAxsQFKhh9kP3JfXWddVmGvKbIdZCFmRnH4nkViryMnCQi4wA+lFkWchvsS4W7YIgRMsmtGgm8pGnACxCChS8CJ8DNn9qps6w9LwdBbw5yjJYYQv/Gh2ILaKdsnZ6MOa87niv4yxSVlUsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8+JeUiIuH7eVva3pOXFlGYID03SjbsKZEJTSX5UBm4=;
 b=tQmIvoO1uVrRtrW41D5U/6p6Vpb62mP+i/ymoyQmFvhQsNvjbTQjLp43yXQj2me+nifLa6cYWBjA+veXrVAG5c+Je8WgqX5+cS8sIqFOUiMZFO9wMSmGObT7LDRe0lSApzI4zrVKvrzpNwqIpVlS8HUo8A6okiCHWEcN1PV9ml7j5PLO8g8PZPxChU/ME/CyUae9B+BTtH7OkY97Km7zwHrEiMwB8LXkg+ulf4+KMVtY/zE4N0RcV7zTE2A8dhqi7InMDjF8wqfbQgm2UU6lJQRNPouvog/lNmd03HdSOtSe2IgrRiGTg55CA1lT8vaiXfBx9JhyF/gm0A8LNS7lIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8+JeUiIuH7eVva3pOXFlGYID03SjbsKZEJTSX5UBm4=;
 b=obUS7uVk3xHE02IsUVnrnRpOoElQ7h/czAbY1bmOlSwQ2rKs3HpAhng/ic7ZsAF9OubiXvxbovYlsIRMx8/VI8M5mMnnLfukLEGKK26E6KCMUoE9DvmdBfX28htcfcsx/Egb/L94MXTcjeZTW7h2jqAF2CCvN2AKnOlwr7NPSK4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:29:07 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:29:07 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 2/7] ext4: specify the free pointer offset for ext4_inode_cache
Date: Mon, 27 Oct 2025 21:28:42 +0900
Message-ID: <20251027122847.320924-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027122847.320924-1-harry.yoo@oracle.com>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0113.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d36135-5768-4e2d-5ab4-08de15546c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DLNCZsW5FqEpgr6JSSWxFYZk2S5RGT1QMffRmobWOgQdi92K3xwEVgT+zkQx?=
 =?us-ascii?Q?kQgAN8zT8x57N2i5yhDR8p53gVj8GFf7dC8N4hXTpsfzG2Z/Qi4G2/1EAsvp?=
 =?us-ascii?Q?4cHYCYmmPdFMuc1wQdtE82Fyx+NT9jnzpXy8GwaSS7qERQEPysHabhq+fbMm?=
 =?us-ascii?Q?jrciVA0eMWycN6SH6FOfbQ4EMbWjj8NOfkXKbNhLj7Dr6k4TN1CqiwpjfAOv?=
 =?us-ascii?Q?Jk7QoOdBVjLuXkF5dtwqxibgJLIMKfLI9Q1qRVWxSv1PPt25LaY2HpbpK+gT?=
 =?us-ascii?Q?hE/TnFLwR8+bzwD04bPkonplQK2ZSxxpfIN9915UUvbWY5Q5FjLyvcq/gtpx?=
 =?us-ascii?Q?pu3/keKFP2RvLXfpZnbHsrmWnKs9xUhYB/4WllRvSciqiEdXVyyes3m1jAKE?=
 =?us-ascii?Q?UUftXJZ11EkFxOJgAFa2oqj5CLc8DpW6MUWs3x2yC1mJmItkRN4h7rTm4Ltm?=
 =?us-ascii?Q?aXPfpqzGL8cs2p3xnBlTih+P+5+6ETutpxtIuRx5yE2UrSoOX+7NBJgd+OPG?=
 =?us-ascii?Q?cEQ/d9nSWmzra3mi5WBdx9Xa7BU32OwsigmGhoRNCVnz0D0eCJrz3TWNPFqT?=
 =?us-ascii?Q?kXJs3uIbEAsfZnjPV5FkM1Dfmqi1UxlhY54DZy+WHB13MTa6zWlgDoNq5+Li?=
 =?us-ascii?Q?2jo2+ByckKw7/6y79GztE04Kl42ZFrRN+QjvyJoNBL9bx+TaxnO3jdD6V7IO?=
 =?us-ascii?Q?NBBp4jPEWsbTKU3iUOMSJFqJ5+Bubqi83ysVPTimxUJNGzhPu63fku4942Ge?=
 =?us-ascii?Q?620eG4kat4ynklikbdX98CZ68ugmIWQCzlBQnZYrqAy56wJkrfgOU7hQlJbd?=
 =?us-ascii?Q?F8z+udxgTke//aJa5t/9+Ej8P1brVZfhiKKt9eWGwCF9YX2ojF4e0htSyuZJ?=
 =?us-ascii?Q?CeVLtS9spbgIhphOx+3gmgErHqtbO2oejbEM+Z4tjfJO58MWuxxLhXMUFtiS?=
 =?us-ascii?Q?bVG+wp4F8tBDsORj0PO+6xuNxna/wTRe15y/aByi/50TzUbXMSaqGJmgvqEV?=
 =?us-ascii?Q?rZ1h8hpB1RtmCYumKmgPIVqNA202kXM5howLUA51cyzFhjAdKzBD9HThy32A?=
 =?us-ascii?Q?5twL4+4TmU4iXsiCdIpygidUJHcmqoYlWIJ9GVbPVPO08f7HiWhMRmTyKHur?=
 =?us-ascii?Q?6FGdbwilitavmN9DlbuIeLeBMq37PFPuN88iwmEjDemAn7HK7ms+QSoHFuqP?=
 =?us-ascii?Q?zQ8CNzH5a2R+TOGFI4Ikk1lM0iwmo9eGNk6BvkVnb9b0Ht1WMqcr7PFvom/G?=
 =?us-ascii?Q?EE6KgOiTqDm7kGqbiio9RgaQpP+eBwjszcqp7X5mxe7bR3UDJVCAWRefLDFN?=
 =?us-ascii?Q?mOQQFwLm8lSOQCkvTr5RXPgmG4R1m8Fb/y0tqsuTcB47OpXESJFVodK0Fsta?=
 =?us-ascii?Q?YsRKH2ULw0DewhUS0wzPi8qJP647xvFJ3VJeZte1RSFsAye42+mGjAhBcKyD?=
 =?us-ascii?Q?ZvVsneWERkxdFQh1NDJVaVo2hF0Fqlfk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3kZn30I9EsVETtqV3GaheZ9FlVQSU4mwa8mxXJuPGCuzOCjSRXNh3SyHg+Fz?=
 =?us-ascii?Q?QJeYWIAjBzHez6CzfB3Et/nSEw2YC/DpDvx214C/uoWD0wD+Eu2prnEFhydW?=
 =?us-ascii?Q?LH2dUUbdmvRiqWr2DPe9feA/40bv+UJQmOxr95lNbRYI1CY35rWZEnhLYhP/?=
 =?us-ascii?Q?xfvGEJWZw0t5HiZ1WDpT1t5SBYuWIwP+LCorD+EL1N/Qien0esM/6eIkvdXn?=
 =?us-ascii?Q?kgsid6xn1mRVuYcjH0H0pTFstcJufx+6ykfvCr7anjGbMdVaFIPFhABg7c0j?=
 =?us-ascii?Q?bteaBENgYlcm4xJl0F1Uc6GWWZCMUiC7O5YimhZxgsaxqJiPD79XdF+vJL8a?=
 =?us-ascii?Q?exhuHcwrcvIKMx2pE/CUhJydtA1MlxHZqI+A8Ic7eaKlL2Ra6Ot4OlD82xBY?=
 =?us-ascii?Q?BB05FntchNx+ZskxFdwIsdze6ae32ftfFSLNcg4rO6Wsk6vGjYvVuYBQ+LXx?=
 =?us-ascii?Q?NpScWUPeX3WIJchcwORpr7tE/0oaeSIVqprkCKv3v1dQYk2LnXsPrnvGwLs/?=
 =?us-ascii?Q?hhuXb5Mc2+AyeuZUhsfl1ZOmJ9FxyEn7GpWv0erGf7ATIzOtEd5JV273jiVP?=
 =?us-ascii?Q?HFmcQXTxZFEmEUYw0UsAOVqas00TbW9kD3+2v9RQo6BKHfrgOBcne+Dmc7eG?=
 =?us-ascii?Q?g2R91+SsnwfVn+cu2lneDsjTCXHtVMindLZnvFqmqGAHaRaiG4bAVuIwCPkf?=
 =?us-ascii?Q?NDagwGaB6g6LR+Wo7VRg2xRJ527MP8JnmH1iYdZc0q8H+aWa/0MAjAyRSRSt?=
 =?us-ascii?Q?28Tt6I2bDy0VOpOvGDXvwz5ccqfglcNFDka/nvqt//Vi1+SJ61WFWPT4iXHl?=
 =?us-ascii?Q?9DaCFm2n4O2zpnPv+BOpiOU+c1t5SZDCzIPCNBCIQJpHODw8HtB/sjCE7XJr?=
 =?us-ascii?Q?LNYolOLfioJn93HaYGEkG01Ked8KEYuBaJoHkUPZQC6NBoMYL+kDz1JDMORJ?=
 =?us-ascii?Q?zcxYiNcUxW5Zh/crUi44MqUJJEi2FDyMDBZZCN8F5bIogp7P7STobgQNgBDi?=
 =?us-ascii?Q?0sl95lv/XDNs7hXjNYJIBOsg6lZ3wK+aKhDDqOJaz/ilaI5oWpJwdYS+cS8y?=
 =?us-ascii?Q?ZdMUg6CzN84R3OqRRB5rV1Lq3JcoNnWKORDgRrzdRDM4US2sjnpKdcKoqsS9?=
 =?us-ascii?Q?5H3W7bMurd+jXbntYXY3kngTmymVLxpgBhI3KH7ATZGi99GtAL0RUdoq/8DK?=
 =?us-ascii?Q?E7k+FKAR+9IXnQWJpSSSfac7eLAXxPvyiIzvNvMLQ1AcJ0Gf8RLKB3H0/Vcu?=
 =?us-ascii?Q?0pLEhTgiREmraQ9jcm05yF5wnXFyBfAo9dy1Wq4eQNPry+Eq0ONCnhHR77zf?=
 =?us-ascii?Q?OFwpcyPaUR3zSsLFEcQ6ZJ5LMbdiYy2KD8kfkrffL2DbAfBz7Ri8CC7k/xQ2?=
 =?us-ascii?Q?yALAOUE8IHyFrvE2kFSZpssyShG+NPLBi7zdw543mqgjIYSdrj6BU4BR5/Zt?=
 =?us-ascii?Q?zvS+FzblmLIgpLgFcCYdwiTjN/TTLRyAmVFNgiGNY4gMDwupceQRAWmp1rHW?=
 =?us-ascii?Q?uBlm6teVSRSPFtWNGN38tJ4WKCvy8DsCnAidve11jOc8kDj0PZya/fTkFfl7?=
 =?us-ascii?Q?ZHPpGQinjUpzTsoWJLgmbQahqgxHPjubNrHnpN0p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q08HXxSRQyRsWcpHx5W3mLbaoiFvlkQ6PQG9pHPDJZ1gBsdEfSAle72IB2yqz/WXCP8TO4yDXJ/c9yUppMEWKn8733HPNmgYi2+m6Di3PrmcbIsbaC33Cbq2pu9OZYQIMvoY5kIsgyWaGdb450yv3zwxWSUgp19PRr/H/aAsmNaRjI5bH++DfrKVju5EJJ2Clo1LwtApZiGpUNrXt9fj7ZB6sFAZfCw4K7qDeSRvuq82+OD6ANefs0+o6lfMH9WW6tuGWp0lCq1Yg+qd1cjRyCbx+J1DMcQ25t4lLYA+cGKtvaGFf8TR/jwA5AI6D3Kqbk51cLD2nW9Di1AymVEDigojwG6IJ/Y5/xE9kdHTtRWeLGEZN4zriWHXr7evyQnhlExWU4lOSsyjTxgiByxPm6P/6dovw1djOcrFnUout1mV/cu4uQ+BMB2Hlonbogye2Pvs2Mj7sypYfK5aoCwQFowRnkVP2tpFBSnkHt6LTJuMgn8wJlXCPW4dGjfd7N54VxCIZPFiycHLHQLhTWpw/oC/pbIWbx0RAm9ixcmaZ/YE5rGvAYN78F+4qfOhyLivk/FxLxogv8xpCjq7KV9LbkQ8Vjpwkiv9thO8nsRiJbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d36135-5768-4e2d-5ab4-08de15546c2e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:29:07.3383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ya0EsHMyhAFIxl5FIhwt0KZh+UTOGV0SwycZHjjkwdyEEISZYQUIsky8ggS7LuDCBU6iHE7615rvJg8EPT0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270116
X-Proofpoint-GUID: zNLLkqpcGCMPihsqKgFqYOuVtBUhLQBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX70/uqpaUJ+gG
 nEMNbRoiaEDlKFnW1TJ4g3ZvUmfeA/bUL0uzzWps3WAvQPvtrW1M1FlSKhNpK61W79NbhqW81Gc
 XqHO0togO1FgFPFuRIBwHhii5EF92CMVeOZqExqWnyg7C7kjspH/v9sqoJRVGaxAP27T3NKro1n
 hyHF598VINqdAQpYywpEh77dBKyxcLPEy0MPrmVZXHj0sc8DHZfu5wNgyU9be48w39d0gW1aOkH
 0XDdnBhGthyw/sqhOiHgGm1PX9KKzeJYyzKII5lPxaKEfV5jW2ZRZMdKjBtKAPeDPpm0QwVS4Ni
 5myTi04zNdLkrmEOi4nw7/g19NasbwNcqUflr7qMU2a6YWXNp33d2KYtZkNVMOeH0lkI1jqm7SR
 LexYH73zmznFllry0XE2dM/mcnCIxZC2M8Ywq5av1SzmgrKjBNo=
X-Proofpoint-ORIG-GUID: zNLLkqpcGCMPihsqKgFqYOuVtBUhLQBB
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=68ff6597 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=JkBuEhRSSIryOgRXcmIA:9 cc=ntf awl=host:13624

Convert ext4_inode_cache to use the kmem_cache_args interface and
specify a free pointer offset.

Since ext4_inode_cache uses a constructor, the free pointer would be
placed after the object to overwriting fields used by the constructor.
However, some fields such as ->i_flags are not used by the constructor
and can safely be repurposed for the free pointer.

Specify the free pointer offset at i_flags to reduce the object size.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 fs/ext4/super.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 699c15db28a8..2860e0ee913f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1474,12 +1474,20 @@ static void init_once(void *foo)
 
 static int __init init_inodecache(void)
 {
-	ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
-				sizeof(struct ext4_inode_info), 0,
-				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
-				offsetof(struct ext4_inode_info, i_data),
-				sizeof_field(struct ext4_inode_info, i_data),
-				init_once);
+	struct kmem_cache_args args = {
+		.align = 0,
+		.useroffset = offsetof(struct ext4_inode_info, i_data),
+		.usersize = sizeof_field(struct ext4_inode_info, i_data),
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct ext4_inode_info, i_flags),
+		.ctor = init_once,
+	};
+
+	ext4_inode_cachep = kmem_cache_create("ext4_inode_cache",
+				sizeof(struct ext4_inode_info),
+				&args,
+				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT);
+
 	if (ext4_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
-- 
2.43.0


