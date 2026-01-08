Return-Path: <linux-ext4+bounces-12645-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FED04AC5
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 18:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F257319614A
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B543AD45;
	Thu,  8 Jan 2026 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sJj+nS4i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAC40F8CE;
	Thu,  8 Jan 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881522; cv=fail; b=di3iVooLPiBpI9kpEXdkDGHo1GmX0Ymm1xIjSV9mEfp92adidhNQKUgjEFGjhI5L1qA1d45JNcD6kgHQKfzSSTYBHxMA02JD3OZEm6wYcCPI8GuZiwy3c8xZiZmQDZyGjn+5xAK2cZ+tMBYYL5xIjoxxJBP3INPLHFZOifJYIxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881522; c=relaxed/simple;
	bh=MZmCuSXEZdxs2Tkm0ED8sMYzQjXZT5hjyrHhmvTFrxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxNxHouau3wd75q6+c1tdWFqmuagRDkwZkgb4lffy1cKCCQjsVo9semnib8uP+ZccQM75YAe/bxh5rjPOSN9Xlq3Kcjmt2ThLAchXNXMh/zTMkDZ5gaT/cZ9ZwCb36gah5q2S+Hw6v1VFYlf7INzwiiMDxIgaGQt5tvDAw8KYVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sJj+nS4i; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg9ea3E/b+KYnIDrFefkkQ3LvmPHaZCrqGdJXYsp3Axw9LcsZ64jIehAVq8PDNMVCs1hPqTJ19ebZ2qzS86zcd0cAbVMY3fqv912KIkz5+F3pKrSmVwEmYuYmP3kbH08z7O3FTl37Qulo2pvHHhKGpvpbibywQGemBhsAZOy30XvzYbP4OHfW0PXR88SPRRfg2iFzwihpnn/nhf9sd/NJwq7sNlY5uC4lEENfhtN5NMovXSTpNBnmXd7bjSKSwyHy96izaayXajQMdjRohHsTHXMITvCyUHS8PAo4fCaGbzrBs9wNoJ61Va+wSK0W4f+MhO2Hc18DtOAyK10JXrhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYbgod6BP1o7hhnP2vGvZ33pBDedWiqB6xykFcqfQbk=;
 b=H/OZFBGYjadd4t5CvYiMEcDtuoMi9BJXD8DTMUcF1kUsXbYjzs64vP9j6vUcRxSIHFURnMB42yOnBcyfGW07U+lxsryMQTchYKQ44wVQ1dgaei8M2/G3e5VfaxY5vz0ZfmCfEKj4TtUtJHtgWTVj7qiJJEoyZwyj737mZAt/hwpiwxNkhBkUwHQvlqocLNT3hmoSNauvJD6fiMPpftn9N/USZ7i+WoUb7rxmS59Jm/YFZTfxbfhvQvj6zcdVoNm44KR5QasMWuWCiMuX811ptAfwoiptsFKqGOWBPv039jAIs2eOf49sdBnEYpm//9JeGzrj2UYL7rFMPX3twp++Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYbgod6BP1o7hhnP2vGvZ33pBDedWiqB6xykFcqfQbk=;
 b=sJj+nS4i0gdocHyQeztNf+hREyqy6RrrJEpFuRUbWWABeVv4m/e3fVoTKkBzwTPd0fYpTr9TlgYOQEenh5CdxLx/DoMWXt1ajH0YaOs4JQX6XtCkdESU4d2p7XJ2IvxHi7WZNv7vWW2VotsiZGJr6bSC1kmptZiVhF8qVYJPMgDK2GvAHbhtw+AsVHRls+VeUPF0PFSGbUtbIB2JovJ4Au9/A16lN5ktQYnonLE7Vh2gFlk3byYaqNkaPtavt0TMBlw3rtqMk+03G0e6Y+55bv5MbIrBP8evGvoqKqMrVr3yDI/CJ2g0uGRsgfYwWCE5J2qjD9Lm2QxYYwN8gPSseQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8861.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:11:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 14:11:56 +0000
Message-ID: <b39a740d-ae58-4b83-bede-dad0845da1dd@siemens.com>
Date: Thu, 8 Jan 2026 15:11:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 242/262] ext4: fix checks for orphan inodes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
 patches@lists.linux.dev, stable@kernel.org, Zhang Yi <yi.zhang@huawei.com>,
 linux-ext4@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <20251013144326.116493600@linuxfoundation.org>
 <20251013144334.953291810@linuxfoundation.org>
 <ebd61bd3-1160-459f-b3b3-f186719fa5f3@siemens.com>
 <l36p4covbdywhdkmsxqkswww3azubmlew3imqv7acggcd3pm2k@sazu3kvtuzqn>
 <2026010845-undivided-stability-8bba@gregkh>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2026010845-undivided-stability-8bba@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:610:cd::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: f487577f-da47-4ff7-336d-08de4ebfe13b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmZxTU1wNnlEai9ma0JHSDNIVDdjSmpuY01vQXdqVzRtdHJ6cm9kYVpLbzFh?=
 =?utf-8?B?UjBSL1pRc25DQWVpQ3owK3lJaWtjMkdPN25ZeXpsUzBWTWVoUFVIa3JuUlhm?=
 =?utf-8?B?ZnJuTnBQdTlDcGh5VnBkT2FGTXNnYVBpSjIyRHFsWEVOL092OHlldWVRL0Q3?=
 =?utf-8?B?LzNwVzRGdzlOSnpmSDVpS2Z6QWNkWWVTRnZ3WDAxN2VoU1Y2eVJpYU41cmdl?=
 =?utf-8?B?d3d2YVNpcmNka3FBWjFPb1Qzb3M0amR3VmlPT0R3QVN3dzRvWFRIRUtHaW1O?=
 =?utf-8?B?eHhmMHJ4WXBYL29UQklIZ3FseWZ1WXFuTEJTR0czbXNZUlZadTZqZkFQK1dx?=
 =?utf-8?B?V2dMdjJWSDlPTEJpS0cveWFBK2RSU001U1RySXpNR0o1ZjlVRVArWDU0akNF?=
 =?utf-8?B?RGRuNzZYRDBQZUQ5d0l1WjJNbmxPRFRyY2h6eGNPaThqcDFMc2ZWcWVYUFVU?=
 =?utf-8?B?RFBFamNTWGZaNkk0WnlhV1dhNnZVSjRNUm1MZzdSanlOUzNjVUkvQ0plcnRY?=
 =?utf-8?B?Z01LSW0wNi9jU0cwTSsxbFVqaXROYmczc2JmZ1NUK2x2MU16cnRpSDFFZVJm?=
 =?utf-8?B?OE03YXcxUjF3RENMb3hwTXM2ai80K1hERGpXY1NSU01wVEFJRTBLZWtzaGJp?=
 =?utf-8?B?T005aDhMQlRiYmxuUWM5cFVzTW1hbEtEYmxjSzVXeGJnTGpRMlZyb2ZyZEdF?=
 =?utf-8?B?RitkTVBIN2xxWWw3MDJEcVRoMWh6NUM1R2RBdFVVVDI2M3dUNUlqeEhuUVBv?=
 =?utf-8?B?REdITzVQU0NVcDlGM3BwWDZFMU9OdzdwN2xJc1lZdE5lVjJzei83U2FrYUtH?=
 =?utf-8?B?S2ZpRXkrS2Y2aXBmUGFaTEtDVXJkQnJEZlp6Sm5LM0V2WUNITTNzK0pnZXRv?=
 =?utf-8?B?blVvQ0hxTi9BZkt6ckN6ZjBFcExvMldpMjRUeCtGTDdXSDZSQnQxNGZqTUJi?=
 =?utf-8?B?UktKbjZPOU8zZFpZNUJnZGhsOFZPK1RHa3AyQ2ZNbFVZQmdUS0o4WmE5SEV1?=
 =?utf-8?B?cmtFL1JhNGtkY0ltRmlpUDllR2g3TkwvVzM3dlZOekQ2cTBoUXNVWHBRQktS?=
 =?utf-8?B?ZGRFbEV3NGJGY0pUVTQ0UkF4ZGEvZ0tqUDdoWVE0c0ZwUU9BWU0wL0hjUlR6?=
 =?utf-8?B?T2xSd2ZxcnZwaHlDd1IzUEt1eSsxQ01nMXFxaFB2TVZvTmxCOG01ZTFLTk00?=
 =?utf-8?B?bkMvaXlqY3VpVm1CTXAzblNVcnh1b3ZiM0x6NGxtTmNGSy9jSVE2ZWRkSVl4?=
 =?utf-8?B?RlJwalg2RzcrMys3ZWpacDZLNGJHYmZqbVFIZlZRSTd4RmVSM3dzS3FWYnNZ?=
 =?utf-8?B?SjMrS1hEMjhMdzZKRGRJcEVUWjFySlkyV0p5d2k2aDlEbmNvcnB2N1lOQkxv?=
 =?utf-8?B?aG9tWWpnRU9sQkdWOURLcEt4OFh6aFJZQU5EVnQ3OEg1RDQ2K2d1VnJ2Vytu?=
 =?utf-8?B?ZDJLd0pwcDJHN3JyY1FEMVZVa1hkZEZaMllLN2VoTWlJUmJrQURwYUNrOURa?=
 =?utf-8?B?QWp3bXZkMTdWeHF0cDFxV2M3Q1p0VjcyUHNMcUNCQ29tem1YRHAydERlaXdH?=
 =?utf-8?B?cklpSlNOZlNiRG1BTVdZT2duTnlpVFJCQXdFdjJLUi9QZUM1QkZzMGE3YWpK?=
 =?utf-8?B?S3dyT3h5cmtieUo1UEUxL3FKYmxORjB5UHA0WWNNejNNelBBZDl1L0FlOTE3?=
 =?utf-8?B?WjZaUnQ4WVoybUpDZkpreGRlYXo1QjdPaHN2TkxlN1czV3BHdU5nYnJNemFS?=
 =?utf-8?B?Z1lrZVhQbGxLdWpqTExFZEF4NXMwbWNsY2VCLzExbEJKS2lKNy93LzVHbGE5?=
 =?utf-8?B?QzRZMjMveTVIT3NpcVY2QlpPYStBNzVuVkZYdFJ0bGlxdjl3YkhRc3hRbnQ3?=
 =?utf-8?B?ME9SWXA1czhMcERIT0h0djZ1TUI0WVdEeUlXL2xQVEo1bEw3WnZqK3FYaGhI?=
 =?utf-8?Q?th5/id4faOt7UDjAm/TY8njnPSbDmh7I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0dGdDV5U3B4VUdlNEtEZCtiTVlIR21IQW9yYUF4cEhFMU51eG9aZ3NBTE40?=
 =?utf-8?B?N0orZkdrN1dqU0M1dDNhTFVIMU00SDBRbDVLbHgrK3FVSWxVQ2ZZL1l4bmZI?=
 =?utf-8?B?TFV0RHdtSlE3a0dEZGJEWENRK0pWQ2ZGWXJtdUlsZTM5MEpWOEdtN2R5U1Vo?=
 =?utf-8?B?V1ZzaXA5NGRHRm11dzZTZVRlR1M4YVBoME9BMjdTQmtqbEo1dlNPdlBCSGhw?=
 =?utf-8?B?VW95RUdVMUNRa1NlYXN6TWVIQm9JSUl3UlpITmpmdjlsbzZ6RytMcjlQcnow?=
 =?utf-8?B?YjBiZUE3cmdxdVpZbjBzaVJ0N2JYaXYvaDBnWUo5Mjk1dkpKY0M3eWZHZEQ4?=
 =?utf-8?B?cnNUbVdWQUg3Yy85OWlsZnliNzVmS3NwRXhBamZtVFFyYUhHdXdhYUthL0wx?=
 =?utf-8?B?Q2FzRlp1NHpmSW0rdW1SL1ZoMEk2NDJSWFkxaEtVS0JlQVBFU25oOFRjTVNx?=
 =?utf-8?B?ekN1UGx5SEUzcXovclA3Y0pyd2p5NWh2c1AzN2xReVE5d0owc055UGoxU1cy?=
 =?utf-8?B?RjVISGc5TGR1K25sL0tFZ21YOHM2dHFrT204RHp1MGRvVVlsL3RVbElleU4v?=
 =?utf-8?B?am5yVTJlTThZaTJOUEVaQjA0dmQ2M21CNG9DU1psOS9ZQ29OeXEvakJxRm1i?=
 =?utf-8?B?b1RZemNabDdJek5YSTA4Uy8vSXhvcWprc3VVYll2eWNhYlR1Vk1tM1R1YVBk?=
 =?utf-8?B?SUhwamNkbzlkVlVlcWhia0xRdktjdWJPb3lKRGtZVUNPVmVrcW1aWWtnZjA5?=
 =?utf-8?B?bDRiY0NZMGNkMitXVXR5RWdpVDgvRzRSY2srRU1zT2dBTUxMejJHY20wRjVm?=
 =?utf-8?B?a1dLUkJDSWJ6NW4rbi9CeXlUNElqUDdRbkQ4eDJCbVNwNjgxUlJiRktNeGFF?=
 =?utf-8?B?VWF2S3ZSVzBOWEFkeG9nbkJzRG01bkVmZzI3VVplMmRTMGk5TTlSaktFUk9P?=
 =?utf-8?B?VDFrQjJaV1RPY1Fjd1c2T2FtK3dCTnhkWmJqb0tlbmNIeE1PY0lWZ2N4d1lj?=
 =?utf-8?B?REpvd3BGUGkzUXpZdS81V0hFZVN4WHpQNWdld1FtS2tlV1d3b1A4WDd6TXdH?=
 =?utf-8?B?M0s4emZZdTBDZHBBSXBYV21NVWpTMGVMR3ZhMWtsejZZajZIeG9zKyt6TmNm?=
 =?utf-8?B?dkF0TnI5VDdFVzhTYWh5VHYzS1BjTkdMRmdsdTVBaVE4YnZaNFh0SG1adGJi?=
 =?utf-8?B?MkpRTDZPaVhRZksxQWoxaVIvcmJSb2Q1SkphVUFGMWpVN0xWSVVHdjBDMzly?=
 =?utf-8?B?UHVWcTJYRFJJanp5aUxyQXcrRHV4RENXZ2F5K1pwR2U4cDErL04wUjN5NjJu?=
 =?utf-8?B?SlRQQ3dXQ1JKN1ZKUHg4dzZDYVgvaTFKL0ptU2pacS9QQzlrVUJ1aTQwNmxB?=
 =?utf-8?B?T3dzU2RhTlNqUEZVS3dNS3Qxem43bG1WbmE5VmlaQndXekF6eEVoTmZXU003?=
 =?utf-8?B?d1BLc2hzUWxsbmc3amdva0IxZVB0TmhSeW5LQmY4US9TTnZQTDFyR2tqY1F4?=
 =?utf-8?B?MEUwa3pIN2x5dWt1bFVGOU9xUXRHM0p5WWJtamQ4YjlKK3JwdWpvSE1WQVNi?=
 =?utf-8?B?STFlVi9MSkdMdHpzSlMxWTVvYXdQZC9wR0Zmd2NRS2JTQmVOU3BpMG0yM0tj?=
 =?utf-8?B?T1VpcHZma0RMREtFV2plWFBhR2FIbU5QODU1SkpRQ0ZSZjNtQllLSXY3ekQ3?=
 =?utf-8?B?Njc0dSs2QzZiaGhFeGh5OWkxaDYyc1lQM282dnF2cldmdzFMR240SWJpZU9w?=
 =?utf-8?B?djR5Q2p0by91MlFoK1JyUW9vMmZsZC84cEhTKzFwa3lPN1lyWGJzTVRWOURJ?=
 =?utf-8?B?eEhNekZsVlVxTituOUV5cGpmR3RXdFRnK0VVVGx6V3J2NVJPcUcrWngxWmkx?=
 =?utf-8?B?RmM4bCtZQlZhcFd2eXBMcm9UYkxwL1ZQYkp0Z1JReDZtRFpwZHZlNVhCaW1h?=
 =?utf-8?B?dFNNZzJvZ0dQUjhwN2VnK0FYblU1TnBwTGxJalBWaC8vbUpzb1lLVzFBQWdw?=
 =?utf-8?B?cThXczNLZW5BVkxEOCtrQ2hoQzRkdUZsUW9oL3EwNnhMRmM1ZkxBanM1c2Rl?=
 =?utf-8?B?elVpVEs2bzVUMXI2Y1ZmcWZOeG1NZWd5QkFWQnA1NUhXaXNlbVpaamZGOEo4?=
 =?utf-8?B?cmtnY0hzWDRVT3ZEOTBqdVRNZEdOME9YSlk3TE5DSFo5ODhWdlZ0UHo0OUUx?=
 =?utf-8?B?Q0MyYXc0aHdYQzRGcmtjci9pZTJ6eDZTMWpTcEhJM2hkbVpXY3RLT2hGaWdH?=
 =?utf-8?B?alBHZ1FtT2JFVWtMRmZNeEJPcmorazhaVVA1emdoeWZmVnVNcHFvRmMzRnk5?=
 =?utf-8?B?MWxHQ2c5U0lYd1J6eGtveE5QaUI0VzJxKytVVkRzUG1SbGRaSnZVZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f487577f-da47-4ff7-336d-08de4ebfe13b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:11:56.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI7P5kErugCGoBYelHZydxteqiK2l5UVCEP0OGfFK4DlyoOfFGmFSjsauNkOfsCdMQxGf6kkjyMCsXHmCwDhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8861

On 08.01.26 11:43, Greg Kroah-Hartman wrote:
> On Thu, Jan 08, 2026 at 11:31:10AM +0100, Jan Kara wrote:
>> On Thu 08-01-26 09:19:23, Jan Kiszka wrote:
>>> On 13.10.25 16:46, Greg Kroah-Hartman wrote:
>>>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Jan Kara <jack@suse.cz>
>>>>
>>>> commit acf943e9768ec9d9be80982ca0ebc4bfd6b7631e upstream.
>>>>
>>>> When orphan file feature is enabled, inode can be tracked as orphan
>>>> either in the standard orphan list or in the orphan file. The first can
>>>> be tested by checking ei->i_orphan list head, the second is recorded by
>>>> EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
>>>> we want to check whether inode is tracked as orphan and only some of
>>>> them properly check for both possibilities. Luckily the consequences are
>>>> mostly minor, the worst that can happen is that we track an inode as
>>>> orphan although we don't need to and e2fsck then complains (resulting in
>>>> occasional ext4/307 xfstest failures). Fix the problem by introducing a
>>>> helper for checking whether an inode is tracked as orphan and use it in
>>>> appropriate places.
>>>>
>>>> Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file handling")
>>>> Cc: stable@kernel.org
>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
>>>> Message-ID: <20250925123038.20264-2-jack@suse.cz>
>>>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>  fs/ext4/ext4.h   |   10 ++++++++++
>>>>  fs/ext4/file.c   |    2 +-
>>>>  fs/ext4/inode.c  |    2 +-
>>>>  fs/ext4/orphan.c |    6 +-----
>>>>  fs/ext4/super.c  |    4 ++--
>>>>  5 files changed, 15 insertions(+), 9 deletions(-)
>>>>
>>>> --- a/fs/ext4/ext4.h
>>>> +++ b/fs/ext4/ext4.h
>>>> @@ -1970,6 +1970,16 @@ static inline bool ext4_verity_in_progre
>>>>  #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
>>>>  
>>>>  /*
>>>> + * Check whether the inode is tracked as orphan (either in orphan file or
>>>> + * orphan list).
>>>> + */
>>>> +static inline bool ext4_inode_orphan_tracked(struct inode *inode)
>>>> +{
>>>> +	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
>>>> +		!list_empty(&EXT4_I(inode)->i_orphan);
>>>> +}
>>>> +
>>>> +/*
>>>>   * Codes for operating systems
>>>>   */
>>>>  #define EXT4_OS_LINUX		0
>>>> --- a/fs/ext4/file.c
>>>> +++ b/fs/ext4/file.c
>>>> @@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup
>>>>  	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
>>>>  	 * now.
>>>>  	 */
>>>> -	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
>>>> +	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
>>>>  		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>>>>  
>>>>  		if (IS_ERR(handle)) {
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -4330,7 +4330,7 @@ static int ext4_fill_raw_inode(struct in
>>>>  		 * old inodes get re-used with the upper 16 bits of the
>>>>  		 * uid/gid intact.
>>>>  		 */
>>>> -		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
>>>> +		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
>>>>  			raw_inode->i_uid_high = 0;
>>>>  			raw_inode->i_gid_high = 0;
>>>>  		} else {
>>>> --- a/fs/ext4/orphan.c
>>>> +++ b/fs/ext4/orphan.c
>>>> @@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, st
>>>>  
>>>>  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
>>>>  		     !inode_is_locked(inode));
>>>> -	/*
>>>> -	 * Inode orphaned in orphan file or in orphan list?
>>>> -	 */
>>>> -	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
>>>> -	    !list_empty(&EXT4_I(inode)->i_orphan))
>>>> +	if (ext4_inode_orphan_tracked(inode))
>>>>  		return 0;
>>>>  
>>>>  	/*
>>>> --- a/fs/ext4/super.c
>>>> +++ b/fs/ext4/super.c
>>>> @@ -1461,9 +1461,9 @@ static void ext4_free_in_core_inode(stru
>>>>  
>>>>  static void ext4_destroy_inode(struct inode *inode)
>>>>  {
>>>> -	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
>>>> +	if (ext4_inode_orphan_tracked(inode)) {
>>>>  		ext4_msg(inode->i_sb, KERN_ERR,
>>>> -			 "Inode %lu (%p): orphan list check failed!",
>>>> +			 "Inode %lu (%p): inode tracked as orphan!",
>>>>  			 inode->i_ino, EXT4_I(inode));
>>>>  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
>>>>  				EXT4_I(inode), sizeof(struct ext4_inode_info),
>>>>
>>>>
>>>
>>> Since this patch, I'm getting "inode tracked as orphan" warnings on ARM 
>>> 32-bit boards (not qemu, other archs not tested yet) when rebooting or 
>>> shutting down. The affected partition is used as backing storage for an 
>>> overlayfs (Debian image built from [1]). Still, systemd reports to have 
>>> sucessfully unmounted the partition.
>>>
>>> [  OK  ] Stopped systemd-journal-flush.serv…lush Journal to Persistent Storage.
>>> [  OK  ] Unmounted run-lock.mount - Legacy Locks Directory /run/lock.
>>> [  OK  ] Unmounted tmp.mount - Temporary Directory /tmp.
>>> [  OK  ] Stopped target swap.target - Swaps.
>>>          Unmounting var.mount - /var...
>>> [  OK  ] Unmounted var.mount - /var.
>>> [  OK  ] Stopped target local-fs-pre.target…Preparation for Local File Systems.
>>> [  OK  ] Reached target umount.target - Unmount All Filesystems.
>>> [  OK  ] Stopped systemd-remount-fs.service…mount Root and Kernel File Systems.
>>> [  OK  ] Stopped systemd-tmpfiles-setup-dev…Create Static Device Nodes in /dev.
>>> [  OK  ] Stopped systemd-tmpfiles-setup-dev…ic Device Nodes in /dev gracefully.
>>> [  OK  ] Reached target shutdown.target - System Shutdown.
>>> [  OK  ] Reached target final.target - Late Shutdown Services.
>>> [  OK  ] Finished systemd-poweroff.service - System Power Off.
>>> [  OK  ] Reached target poweroff.target - System Power Off.
>>> [   52.948231] watchdog: watchdog0: watchdog did not stop!
>>> [   53.440970] EXT4-fs (mmcblk0p6): Inode 1 (b6b2dba9): inode tracked as orphan!
>>> [   53.449709] CPU: 0 UID: 0 PID: 412 Comm: (sd-umount) Not tainted 6.12.52-00240-gf50bece98c66 #12
>>> [   53.449728] Hardware name: ti TI AM335x BeagleBone Black/TI AM335x BeagleBone Black, BIOS 2025.07 07/01/2025
>>> [   53.449740] Call trace: 
>>> [   53.449757]  unwind_backtrace from show_stack+0x18/0x1c
>>> [   53.449807]  show_stack from dump_stack_lvl+0x68/0x74
>>> [   53.449839]  dump_stack_lvl from ext4_destroy_inode+0x7c/0x10c
>>> [   53.449870]  ext4_destroy_inode from destroy_inode+0x5c/0x70
>>> [   53.449897]  destroy_inode from ext4_mb_release+0xc8/0x268
>>> [   53.449936]  ext4_mb_release from ext4_put_super+0xe4/0x308
>>> [   53.449962]  ext4_put_super from generic_shutdown_super+0x84/0x154
>>> [   53.449996]  generic_shutdown_super from kill_block_super+0x18/0x34
>>> [   53.450023]  kill_block_super from ext4_kill_sb+0x28/0x3c
>>> [   53.450059]  ext4_kill_sb from deactivate_locked_super+0x58/0x90
>>> [   53.450086]  deactivate_locked_super from cleanup_mnt+0x74/0xd0
>>> [   53.450113]  cleanup_mnt from task_work_run+0x88/0xa0
>>> [   53.450136]  task_work_run from do_work_pending+0x394/0x3cc
>>> [   53.450156]  do_work_pending from slow_work_pending+0xc/0x24
>>> [   53.450175] Exception stack(0xe093dfb0 to 0xe093dff8)
>>> [   53.450190] dfa0:                                     00000000 00000009 00000000 00000000
>>> [   53.450205] dfc0: be9e0b2c 004e2aa0 be9e0a20 00000034 be9e0a04 00000000 be9e0a20 00000000
>>> [   53.450218] dfe0: 00000034 be9e095c b6ba609b b6b0f736 00030030 004e2ac0
>>> [   53.730379] reboot: Power down
>>>
>>> I'm not getting the warning with the same image but kernels 6.18+ or 
>>> also 6.17.13 (the latter received this as backport as well). I do get 
>>> the warning with 6.1.159 as well, and also when moving up to 6.12.63 
>>> which received further ext4 backports. I didn't test 6.6 or 5.15 so far, 
>>> but I suspect they are equally affected.
>>>
>>> Before digging deep into this to me unfamiliar subsystem: Could we miss 
>>> some backport(s) to 6.12 and below that 6.17+ have? Any suggestions to 
>>> try out first?
>>
>> I suspect you're missing 4091c8206cfd ("ext4: clear i_state_flags when
>> alloc inode") (which BTW has Fixes tag to this commit).
> 
> That is queued up for the next round of stable releases.  Hopefully the
> -rc releases for them will go out in a day or so.
> 

Perfect. It indeed looks like that this missing commit was causing the
issue.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

