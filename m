Return-Path: <linux-ext4+bounces-11350-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C33C1E059
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 02:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35933A55CF
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E2272E56;
	Thu, 30 Oct 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AaAIICP/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gU2+oJn3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B72940D;
	Thu, 30 Oct 2025 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787628; cv=fail; b=bLrrdBxGRLUbC4qLhgioirXLQWZPQdxa8vAnIBukcf2R2sS29wYKSccqRdlWfYsjZ0W98UnVR2Wj3hf4soQnTTNPUJpwTqnARWpFvGEPxGiC8zCWWbhgkNA2BcG15qgxFN0FfEcBz08MtPplJOatkKNbMAPB9/HHRo0/ALjaZtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787628; c=relaxed/simple;
	bh=lR2lqkvRmp1NyjBit9xj7mldqvghj096PXnRk4F+GKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHHpaV/QnwCdzyvATLv3tviDErNaS8pTkrRSu9H5EqrauYYOeIDo74W47FXPHlheztWV3ygVZH5RxVlhDgZQhYNpMqAMh+Q904o19aN4Ah2Z1NQ6GyKit3+AUExyA0KSKmQti5JtZaPHvLFbIHflNywua97HE/7HwtyoMi8LPww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AaAIICP/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gU2+oJn3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U0uOlH009165;
	Thu, 30 Oct 2025 01:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nh78G2YcS+N2Ld3/cmUBqQ6qx9t2FOxgwIoGt5qt5Ow=; b=
	AaAIICP/BX9QhfaU0kHoh93xLNm1J4UFjh4AzYXXp7wgywFgFLxFV7re4e4M6Hb2
	c7xoM6U3tn3N00MLclkz67nqUQsW8cbyXo2bK2zZmpkCAGaOjuMYoGV7wEthhsxl
	hWSJ194wXRCgkqqMPjywc/LeG1xcP8KVTqH3lS55Gjvs+/H5+7ZEQB4CbxMEmCB9
	GzxwgKbX4P+OAaJN+3lR16ss8SH8eFHrmKPO/4phCteQbhfJcrU8rO6o8miAh6+J
	8YcxRIC16XF7TuQzs+GG4jLN1dzp+afjKyk+WkAE77//c931n7w2TG52cbSAuAtl
	jqFNNTQDnDJ/Iq1DpkH52A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3cv9ajwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 01:26:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U0Udo7022993;
	Thu, 30 Oct 2025 01:26:42 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33xyy5mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 01:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFFCtCdnn36dDLG+ayZv37b/3g3jVg2D74oAKjSX8eLEc87q5pLvoMMcSR9Ib+7JeTqsEX2NX0p0mzBgYUDUQgcr+jKp+TqPH1ahRTXJ312mM5toxYbnXiTiXiO4C7+XaLpfwpHtQ97vlwKRbgtkxpaWygUr6XInOdzVp2VLXbP8W3Eu0tHc0MB1MA1adBwmB9SEwp3oyqh/4DbEd3AMOWubh+jf4R0bOyuC9KxaV48ZqJU2vSnN0L4DBw2zijGO0zYR9lxca3RyNCg4dr8Ouvgf8QJGnpRARcD8MwFffJbzmKC27xLxvPfbqlJwRALvcAxEt3X60VCMljAJN6mYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh78G2YcS+N2Ld3/cmUBqQ6qx9t2FOxgwIoGt5qt5Ow=;
 b=SZWQRevsrG2+7iKIxh0DdrWBN8Sgk4k7EkC8xvCEkG2em9uSbd+5uL4Nn2ksGHIPb6/zuRroL2+3dHkpDZIpzmiMaIlxCDqKvICraT7fRPdYBT5W4SGBLQ78Je4oiMctoZMTFes1V8BDB9EGpmHMt8y0UznnICz63V82AyLK7Nvw3J3NfdSu1ahMNESt/xOLZCizKx7D1FSDnbBr89IsvLvV/45fP54vakL637tbDHl3R6IlnYMBMxgmn4XUCIE5qUEa9NBAUnTVIjApGTGSYRWxs9IIJW+0sCz9NllxlKS3pXdhG0+382aTl+LGjvnQbnkpFdlhA8kBYbZWUAvbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh78G2YcS+N2Ld3/cmUBqQ6qx9t2FOxgwIoGt5qt5Ow=;
 b=gU2+oJn3VY3tyKIXT2/kvOfcXc0cAhiYSXFZNA6M+2M8uDXbfy3JN7aqOEh+QtYNH/Hn+sH2N3oP9bRz+A9VhD4MK8UCOcd3lua6A4/PeC5tmFWdFtrZACOhZMMuV51FdD6zxhJaHyXwMs5nWH/hIPIBbJImWqrvC/OZeEibJLI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7826.namprd10.prod.outlook.com (2603:10b6:a03:56b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 01:26:39 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 01:26:39 +0000
Date: Thu, 30 Oct 2025 10:26:27 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 3/7] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
Message-ID: <aQK-wyE-h1bvaNOq@hyeyoo>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-4-harry.yoo@oracle.com>
 <CAJuCfpE9PRvd1Tsm6gAvxKvPFgVt640q3vSbt0wAWOa3G4tnfA@mail.gmail.com>
 <aQHVB_8NVMZ2cuvh@hyeyoo>
 <CAJuCfpGFPuoUceB7SvAJPtVvzOOCzqS50yCcjbuMxV2a0e0KWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGFPuoUceB7SvAJPtVvzOOCzqS50yCcjbuMxV2a0e0KWA@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0013.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4c02cc-2999-4dee-23a1-08de17535fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmcvNFg4anBrUDlnOHhCQUtCaXRlL0RYcG4rUUhDWENWUGJCNGgrQzBieVh2?=
 =?utf-8?B?SWlmbTd6WG11ZWFyTmdFaFVsZkpVOGNEQXBBbDl4dlNhbC9hbjhPNVJLTG56?=
 =?utf-8?B?ZWVwTTRyOHJVV0o4cFJvRmVzb04yYWpobk8vVjZwcWNPOEJTTVdVeTl3SlF1?=
 =?utf-8?B?K2RmWk9pOCtZd2FIekRueEFLc2tMUGMzZVM0My9rUXVKUE5lOFZMbXhlbnBP?=
 =?utf-8?B?TlhOTUxsWVJYNnpqQm56eThyR1hUZGZXTGtGNEthcWdyNjFTeWxLOFRwMy9t?=
 =?utf-8?B?Tk8raGRuWHFoSlY3UjZiQVArOTU1VCtZZVZWNHF6VzdlU1kwcjhSZURQTVh5?=
 =?utf-8?B?MWsrNXMrV0kzTlpEN0FyWUVMbGU2Vzd6amZ1RTJUOVJRUThOOEpHK1Jjb2FD?=
 =?utf-8?B?T3ZydDd2UjRoKzQ5dTBXK3RWTGhndjQ5bnZxTFYwZTNGN3djVHAzY3lEbUJh?=
 =?utf-8?B?THd1cEhOZjBYSk1HczVlSzhhTlVxZmNCcE5lNmpYalhnU2V1R0J5NWk0WUlj?=
 =?utf-8?B?WnBHdEU1U01sY0lKUDFGWjBYVmJxM2ZnR3pSUExDNjl2T0ZjcjZZRlloM3Zy?=
 =?utf-8?B?SlJ1YW94UjkzdXg3U3RuanI5ZzY3QjRGRFJ1MlFPdG1RY0ZLRCsxcjUrb0dL?=
 =?utf-8?B?TDNhKzJGU0Fla01vMjZSZGJqdkM3b2E3YnhjT2VZTitJN2tjRGQxWkhSK29w?=
 =?utf-8?B?b0tLcEgwRDMwMFBmZUozWk9YdE9pMDR2R1BURmphYWxxeTZFUGRqMzVrQzZ0?=
 =?utf-8?B?OXp4ekp2WUVVNjJvQTZ3OW9YQzNOeDd0S1dpdWlhRTE3amtuei90V3c3anM1?=
 =?utf-8?B?Ris3RE83Sld2UVBRajA3Mjh5Y0YzTXJ3eWZuR2ZiS2VQYk8zbFplKzRBbzRW?=
 =?utf-8?B?dm1wQytSQVh5a0NLTHM4SlE0UnlwZHJCa1RJbGcxMWFXU1V3UHE0NFpyLzho?=
 =?utf-8?B?SllGc3NWeE5RMXVFZHBjVGttWTE3Rnlra0xMcDM0K2hQME5BR1pXSlY1ckVK?=
 =?utf-8?B?NUdBZlAxcFljMkRxK09nK1lLcklpTWdqVHI0Z0lEakl5enNpTTZ5Q2Y2enJI?=
 =?utf-8?B?SGgvdk9GbzY0NlpKU0YvZWl2THUwQjZqajZiZFNwUXEvenNJUVVVNk1lbDdS?=
 =?utf-8?B?WXR4K1d2eXlqTkUwbjI1aEU2eFVFdk1ET0xoOU51WVNtTjRLdVhJTDV4M3Fu?=
 =?utf-8?B?YWpocWFIM1VyOTZTMWQ0VFdpNnY2THppZzMwT2ZKZHpmbHRpdmRkTDNXeFZk?=
 =?utf-8?B?bW5pdE9lanlFRGhkQVRsWno2K1ZHcE5RUDEzK21pR3k0RUNIcFNnTkZzS0JQ?=
 =?utf-8?B?ZEhDQngxQ1hBR2VzOHpTYmx4QkQzcDJMSUFlWlBzbnlwK2FCZVI0bFFxWkE0?=
 =?utf-8?B?M2NkK1c2T1RDQ3RENjZKSzUrekZiUXlPL3Bobk5uRS8zWEtLMGs5WnRrNUJl?=
 =?utf-8?B?cVMwQ2YvakpiNS9jb1R0TE1ESnZTemlGU01pdWRUeTQvOTZ2NDhjSVpadGpv?=
 =?utf-8?B?ZVlNYVhYL0ovUzJkUENaeHRtQTdoVDFBK2xQN1ZOVGN2aVVlMjB3elV0b2Nt?=
 =?utf-8?B?djBibjNTamhyWVNad21Da0QrZ0xXZldXN2ZlOEE2ZWpTbTZkL0FqSzV5N1NH?=
 =?utf-8?B?V0Q2NTcyZVNwRFhOMU8vTk9qSC85L2pjc2dHbGI4dTZzbVNncDl5djlPTFpj?=
 =?utf-8?B?WVBFYll4K09jVTFCcHg3ZkRROWpBRHg1aUtPV3lGZVUrcjNxMEJQdGp4eG9C?=
 =?utf-8?B?dnkrTDBqY0xsR21hMEdLcUVINzJzYTNyUlZHbmlOOUc4Y0lxOC9aZ3YxakdU?=
 =?utf-8?B?MC96aVlsNUgrK0JOZXlnWGhUWVE2TGJVMXF4akt0aWgwZnpCL1M5bUNYbjRa?=
 =?utf-8?B?UjhEUFVGeklTUUY2SmhXbjZ3bzVrcVJnZHdmT0tyQUVONkc4c1dSS2h4eHVB?=
 =?utf-8?Q?AaS0SmowNUYKPyY+ADdv5Iu3RGViEFrO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODZ5K2o1WVJIQjY5V2xXU1p3T3pxZU4xSy84akttc3RjYzdMSVNhOHVuVy93?=
 =?utf-8?B?Y3g2dHQzVGxpa1BYbmRyMnJCbTlLbWJQckhjVEE3anJXNmpkNmxGN2U1b2Mx?=
 =?utf-8?B?WDk3eWRjajRzcTJ6NlBMS3NIOUIzNWN0bi9rT1lXa2c2eTUya2FLWmRCVzNN?=
 =?utf-8?B?RFE4c3hMUkYzdmFoQmNxKzJHU0t3dmE1Mmx4OUxQcTNMQTBPeXd1dWhOcEVi?=
 =?utf-8?B?UEYxNGYrNktvRnBwZkZPcnZDaFE3Zi9ma3FyY2JqMzduSWN5RUZ5a0E3S0dI?=
 =?utf-8?B?bXdTeFZLcS9vY1p4OEo0d1ZtWjgvRkJaaW9Ldm5xeWE5bkgwZ2JIRE5RZjJS?=
 =?utf-8?B?Z1R2dVBEZVUyK3o5blZ4UUNKZG5MbW9Zc3BnN2FNd1R6M0hLNXVmM0lBTG9t?=
 =?utf-8?B?SnpkT1FNN1NrQStsbmllTUt6VVUrRi9yMTV2NzBDQVc3V0hYL1BxV1F3RHFv?=
 =?utf-8?B?SkpPTGdrZ25DeWhaVVRtMkZzMnFOeXhIcm8yby9nZmEveVhyNGxNNWprT2Fh?=
 =?utf-8?B?NG5UclpFWEdMRmpUWXFlWjk5VTJ1c1p5bWRzU2dPYUJHQmhxUlU2c1BtbTZk?=
 =?utf-8?B?WkdKODR3Q0JtSVk1cmVLazVjc3ZZWG9UZEJTWW5lZXZUOE10RTBvV2w5dHFW?=
 =?utf-8?B?MFhqZVZhNHZzTy9EQXpWazZoMUdHalBCeHJvNWJaMWVEMXJzTnZIOE5tOFBn?=
 =?utf-8?B?QlpndkFET1dVckNuZVFqdEIzWENDTmZaSlozYmdLeWNyLzJJckNZS2xuRDdy?=
 =?utf-8?B?ZHhzakRLZnlWSWJvRktuSkxMY0tMb1NPaFB6Y2oxdSt5QThPMUdtWEpDcVFi?=
 =?utf-8?B?MGt5UUMrcHZOTTltNHYzU0pQY25kN2RaQWpoVVhaYjlHSjN2UW80ODR2M3M3?=
 =?utf-8?B?UGpwdFpIYUR6WStOVURzL3BncGhTSHRJQXI4SFIzZTk4ZjVycE4rNnhlUXl2?=
 =?utf-8?B?MFpZeVZydTFScFh4VWxraUV3akVqR2gzdlNZTkRTY2dRTFFxT1M1V2Vhbkp0?=
 =?utf-8?B?VHg5VlBpc2IyclZpaUJQK0Q5UXFVYmkwbmlFRXdhVlBhQjFDS1lYYWZBVlk1?=
 =?utf-8?B?NGkzRTFJVnJFYnNPUm1PTWdESlNlWU5WNHQ1ZHV5Uit3QkZxSnpSYksvaE9l?=
 =?utf-8?B?OG9uWmI3ejRyWmFsWUhMUDcrYVBKbitXWjVwYzI4RGZtZjJWeG5vSlhJMHg1?=
 =?utf-8?B?R0o0OHRZdkhFT05vTDJzQUJjRDhqZHF4TlAyVEl0OGdzZy9OeXZmSXBEVk5z?=
 =?utf-8?B?cVpqYlYxZzBnZWFzMVlBK2FLd2RSU0IycnJ1V2Z0eTV4STJ2NU5NUk56cEpa?=
 =?utf-8?B?NGZSS2plUW9XSEg2aHpQR0ovUHFhSGpwejdTMkxBMFpwOHY3NzZ1K1NGT0Vw?=
 =?utf-8?B?Zmh4QTg1ejdEVkVQY0Q4ejJKQjNxd3NyWmF2N20xT0pnNzlwUkJob2NoaHVi?=
 =?utf-8?B?TDZoWkJXUVduc3hDTmdHekt1TnQrMkVPTlJ1a3lZek80c3V1WTVVUmtoN2xF?=
 =?utf-8?B?OUNUQ0lCejZOSjV4dndiUkpPL3AyOUNIaEw1UGczMzE5K01KMnVBbmlQTVdI?=
 =?utf-8?B?Sm0wdzJoTk0zRm9IUDVzdS9ObWdxZWZKNDZ0UmhUbnB2OEdjeWNXSE9UZHFW?=
 =?utf-8?B?ZXVUT2gxMHBONHZBZnVsZzVhcGQyT1ljRllQWkRJdWlSc1c3bU5jZnpDRGxt?=
 =?utf-8?B?Y2dsekNuQ0xlcWx4YTh5MmY2c1BJellkYjJKOThETmo1bXhYazVWZ0R2ZGxz?=
 =?utf-8?B?ZC92VncyQTRGL2xnWUlleWJ5b3R2Uld5VmxsbjAvUkV1NHI1cXlPYW9ESlFV?=
 =?utf-8?B?elNndklxZk4yWFM4UzQ2Z1hVdEFKNUJSKzIxRzFITi8wU0NnSnpnWW1SeWZy?=
 =?utf-8?B?K3hJRk9ncVNMNGJxTjBUbyszRCtCUVM3OFUxNVFKcHlBOXZadnZSZ2NuOGV1?=
 =?utf-8?B?cmt4bStxTUdBRXF0c1h4MkI3c2dJL2FBb29JOEYxaGdqWkp1UWdELzIvM0Yw?=
 =?utf-8?B?bG1yQk5hWEdCOFdVKzJRVGxEcXU2b0NJN0hsNmxyeTBMWUtUL1VCaFcrdUhl?=
 =?utf-8?B?dU5qMEVTUWVZTGJMLzFVS1JuS2ppT3g4Z3crdlVzVHdLWVpYVjVxZE1VRXBn?=
 =?utf-8?Q?Od6AS6Ulst8B+Jvcc5Fy3+VGl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oXw0uU4fSvqFWHNSgnaNpMq8WEzpC2EJB3pR7B7edF26otVT71NpSY5rzJKunclqQH7r4jZvfl768ow/hygvweOSOazeXV4rm/3L5+TC8dcbOQTaKEE8OvAxjVuUhSOLHwWWPiS2TUyq7Q/MZ8NLfacN30UzUp2/S1Bn9EGI9Tr1hYCYTb2TOzGdIXwhVjp1Wk3OxR+mGgXcc4kMMnvvjW+KCOxWGgSa7i3U3xVWmDrg2Ry/j/4i9XOImZyuPQRABmxiz4NRbPAJEgYY0S0Oivz6jfjAk3b3VtavSPjtRdJ4IZATThQbmqt/wF984ybkZ+Q1Nym3MUGDN4AqUZbTX55zWv6X8qzfOgrIJrzYHAMYVeVl5Lf48sFotv07UGh5YyEVKEJdX+06F07xeWLPz9DiV3d+KYPKHegq2+qLLtV5ItSYs5GzIckQA3PfjoiGeq8ubYFuvWvW512NdfS02UApUylFC8Qivk0pJBnQWXz90ZfCy7nBBy4HYh6HnU61qh86tbCKr1VFtjgDQF9kcDV6th1UAfKmJdF1gOlJpAIcYJ84So7t63pnQr/keE2XSceQvCFfi7lUGxzK9vSzK/tMb1Y0eejuFD74gl2h0AY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c02cc-2999-4dee-23a1-08de17535fab
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 01:26:39.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nexBZbzln2Tegzxj75IsTueYm/avd6nXGkd8pRDkRNqNxOd9Mbnmm20onxjjI1Hfi3D35AfmvzaoBB1bc1HRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300009
X-Authority-Analysis: v=2.4 cv=NfrrFmD4 c=1 sm=1 tr=0 ts=6902bed3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=m2Mt5VEg61-ob7ERTSMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: aNLuGnkI0SVPb5X2hRMUnRJR7pqiFNCD
X-Proofpoint-ORIG-GUID: aNLuGnkI0SVPb5X2hRMUnRJR7pqiFNCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzOSBTYWx0ZWRfXzqKZusY1/PJn
 WMCwjE8b/uS7kVTrY/hisyOMs84gIqa/el6+HBsCn61novKVU5WYG0nHsq9RNOlNGvM8xselcpL
 XiuJqr3hVxfWOprZbWR863P56Fr3BjHYloSReH6OQw5CYzURU9x4R70gGY3fPv1lOMTZqkbJVF9
 GYFnxaTok0Ey4CcEcZa0+KigleBFX2PCyF9BJrYNdJ7NT1UrwqGiBMzq5uBkMscq0tYM+8CpGup
 D2U3pArJX+OTlOQfYwwxby0TKKqRMb6piVa/Frza2iGRVrgZVsTUw/bC6es0E5OL7ElB3l2znVE
 vD7vSbBKycMLlmzr6kiaSYQ/UqC//urVIo49t3/EMe2C2MQWyrhuAdKEleGLSSyR/OzTVrCsG8J
 sxk0WWaSY9nOQWVuKeIxr4JZ5AIBXg==

On Wed, Oct 29, 2025 at 08:24:35AM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 29, 2025 at 1:49 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > On Tue, Oct 28, 2025 at 10:55:39AM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Oct 27, 2025 at 5:29 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > > >
> > > > Currently, the slab allocator assumes that slab->obj_exts is a pointer
> > > > to an array of struct slabobj_ext objects. However, to support storage
> > > > methods where struct slabobj_ext is embedded within objects, the slab
> > > > allocator should not make this assumption. Instead of directly
> > > > dereferencing the slabobj_exts array, abstract access to
> > > > struct slabobj_ext via helper functions.
> > > >
> > > > Introduce a new API slabobj_ext metadata access:
> > > >
> > > >   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
> > > >   struct slabobj_ext element at the given index.
> > > >
> > > > Directly dereferencing the return value of slab_obj_exts() is no longer
> > > > allowed. Instead, slab_obj_ext() must always be used to access
> > > > individual struct slabobj_ext objects.
> > >
> > > If direct access to the vector is not allowed, it would be better to
> > > eliminate slab_obj_exts() function completely and use the new
> > > slab_obj_ext() instead. I think that's possible. We might need an
> > > additional `bool is_slab_obj_exts()` helper for an early check before
> > > we calculate the object index but that's quite easy.
> >
> > Good point, but that way we cannot avoid reading slab->obj_exts
> > multiple times when we access slabobj_ext of multiple objects
> > as it's accessed via READ_ONCE().
> 
> True. I think we use slab->obj_exts to loop over its elements only in
> two places: __memcg_slab_post_alloc_hook() and
> __memcg_slab_free_hook(). I guess we could implement some kind of
> slab_objext_foreach() construct to loop over all elements of
> slab->obj_exts?

Not sure if that would help here. In __memcg_slab_free_hook() we want to
iterate only some of (not all of) elements from the same slab
(we know they're from the same slab as we build detached freelist and
sort the array) and so we read slab->obj_exts only once.

In __memcg_slab_post_alloc_hook() we don't know if the objects are from
the same slab, so we read slab->obj_exts multiple times and charge them.

I think we need to either 1) remove slab_obj_exts() and
then introduce is_slab_obj_exts() and see if it has impact on
performance, or 2) keep it as-is.

Thanks!

-- 
Cheers,
Harry / Hyeonggon

