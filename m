Return-Path: <linux-ext4+bounces-6513-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F5BA3D1F7
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 08:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32AE17D5DC
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2025 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D61C1E7C16;
	Thu, 20 Feb 2025 07:13:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08641E6DC5
	for <linux-ext4@vger.kernel.org>; Thu, 20 Feb 2025 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035607; cv=fail; b=lhePqswjmK0aPcaUT7wTr1FjxOtsFNBipo2M63reXfMmjFvo9Xml0iR9pksMbwjOoUb4EJMccH0h12ibKLtkbBr/SsUCEMmV1oazjdTmUhs6qKe51zdpJLAwvm7L4Of5l8NdK22qM47PY5Ov7PH/l8O/0lSASoQagIJJUFs8ngk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035607; c=relaxed/simple;
	bh=SS751Qx5DM1nX7/g5ypSZ9/YBen9ls+BaRA52Aj4dsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gqnbcn0h4+xIR2+f21jkQRsnT/h0RPmawD6PUaCy7Y7SRc5FJaEimuTK+uCMOAo+b4RLoQjUXFwGJZCLP87lhP6WBvUxbrk5vwLz/paKZd+wYoo1/4t2xmnTpllccqfdgpcwBSu9p4Qo5KvqlnYivqDRZ6Jt2UpO3r7bdx+sEfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com; spf=pass smtp.mailfrom=toshiba-tsip.com; arc=fail smtp.client-ip=210.130.202.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba-tsip.com
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51K7DDWr2539215; Thu, 20 Feb 2025 16:13:13 +0900
X-Iguazu-Qid: 2rWhEqwpj4pjaTrnO7
X-Iguazu-QSIG: v=2; s=0; t=1740035593; q=2rWhEqwpj4pjaTrnO7; m=kZ1BMAsxrPDwF2mcEpwFsIcrQ6gMzWdBYXfgvUmv7ok=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 51K7DCSS1718867
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:13:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkrN7Hjd5QA9EClbS4rkDyptU+1yetI1mGHPUkr6DQG1AVm5wVShBqNRD+5ySysnkfm4lwhivpps7Vkn6kErHElVCFc7FVTetugJkASk0n1RxAbAlo8hX1ZxeYRRMMIUdLpKH3lxQ8DEeyy45RtrlvZG6EOzhZbqgOMJ6NCpAShlmm7EZWGapIUijHbcxYiyx8/mZJkcqLJAHDGBXQmrTJWLkKzgCbMa1SF6j1XPxmmROnxg4gghiXfpWVPBkOOdidqLJNB2yuD1Z/4hfnSUc6F6KHaHy1ITYX2ZgCt72N5t3b79Bt+vc6ZxqXLPCRAeSY4cEcO+RMmPp+X5AUBVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSMl7iAhS+3wNDlIHaUNmZ3It1SfW4ZwxK13TqGqkpQ=;
 b=WV5lDHFox3ALCRNzJoOytpo8OgENUI8Om8OWcbs/vHfe+5QyFEFHyk/fvsaj02/4aQwOXTwGvv48diTPaaZAfWIuUdCnkMicV0t26pLGr7qoaFXSUoMTrp5wh9JGwWLVM8nAYjIF3XIo7lSJxJBA8CsPEZmU1cscI4XRTc2UTIXFuWuBBFHMv0R9D+D9jRFm62ihPopEipLRzdk+Q1Spg7YrORqVA+CkJmUtcHhf77L9gB/955esncOgGcrUGm1Vwc1hg+pkCgo+qaGbl6qZSgdRYz2XFZqub6VIc7mDUldVKTcrLnrxJWuy7ukQZBZm0I3x91c+hwk23uQcUH4ryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <adilger@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>, <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Is it possible to make ext4 images reproducible even after
 filesystem operations ?
Thread-Topic: Is it possible to make ext4 images reproducible even after
 filesystem operations ?
Thread-Index: AQHbbAAVquWdDiPLDEGVbp6qNXKc6rNPOWuAgAC4vAI=
Date: Thu, 20 Feb 2025 07:13:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB96692D5D2E01BA7D587B45CAC4C42@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB966943691EBB5DA3F5F85621C4E62@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <21C92625-5A8E-430C-8359-A07CE698DE42@dilger.ca>
In-Reply-To: <21C92625-5A8E-430C-8359-A07CE698DE42@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS3PR01MB10168:EE_
x-ms-office365-filtering-correlation-id: 1d3b6fcc-5979-4d6e-96cf-08dd517e07c5
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aUNwNm1NQ0h1V1QyaU1aUk1aYmVCcjRNUUhDU1JKamU5SU1KOWVZZ3FH?=
 =?iso-2022-jp?B?YVFnMWN5M2pLakU0Z2xoWTl1OStldVM4bmVMUXU0SGNNK0NnQmNaSFQr?=
 =?iso-2022-jp?B?emxCb1RiaDRmVXhUNjE4ZnBjdldscjVKa3BoeXM5SmU4OHJ0MmJPdXc3?=
 =?iso-2022-jp?B?NE1iWlRGdy9CVWlXVU1NbmxmajRXY3gxZjk3V1o1Q2FucGM2UWFadTMw?=
 =?iso-2022-jp?B?aUJNbmg2K1JUbzhYbFVwYzg2Y1k5Nm4yaW5QdlFYL2t1T1RIY1Z4MXdx?=
 =?iso-2022-jp?B?OWsvSGhZbHhPU3c0MVkzTnYvV01aOHpQMnVlbzV5cHhyS0hXZFh2SmZT?=
 =?iso-2022-jp?B?clVRMldVbmtZSDR0d0YwT3NtdG5yZy8yeERETjV2Y0JzSU9RYTVLUFoz?=
 =?iso-2022-jp?B?Z2FyODlNYXRid2IwOSs3emczVEdsUnA3OTJvR1Ewd3JKVUxuQjlYQmJM?=
 =?iso-2022-jp?B?VmtlU1dVSUVrMlNqa2ZUb2NuU2N4TE5aZDlQRThyUS92Nk8zeUNCRjlV?=
 =?iso-2022-jp?B?cWVaNkFSTklrWElVL3Q2QzVUUSt6SG5NYnpyKzFJU05ma2k5TTV5SVA1?=
 =?iso-2022-jp?B?anM5MkQ4bkIxUmpQUy9ydGlERlM5TUpQQnNqbzltRUI0dktkaEVmWDBl?=
 =?iso-2022-jp?B?Q0JqSUl6ZVZhRXBGZzdOdzV3TmxBZFNSa25kQ2RiRlUrckxKSzNzeWtm?=
 =?iso-2022-jp?B?aVBrd0cvZVFwUnNOdjZCeHgrL2ZnRjlRTWJqeHJUUXRZUThCbTVPVDE2?=
 =?iso-2022-jp?B?YUExMzVqZGUzRFpZV3VnTjhhVDBoZytzbUd6Lzc1eUJzZHpOVU5XZFVT?=
 =?iso-2022-jp?B?Wkd5UzZ5bXRwKzFBN3A5R3JyTVQ4aGVJVVBCWVdTTDd3ZkJZQnB0SFV1?=
 =?iso-2022-jp?B?Y0FYeFE3dHdzWHY0MGpoRUdFRklFTHd2VXlXTTRVRGZDdTlGbUo1WUZs?=
 =?iso-2022-jp?B?NTF1bExTZlhvMVltL1RjWGhjemdOb2pYYzk1SHlNK0VWUm8rMnNlNC9O?=
 =?iso-2022-jp?B?YnRpYkVuejY0WVJndDMwLzF0NlFUUi9OSnhBcm1QY1JTOFJ5STNjY3gx?=
 =?iso-2022-jp?B?ZVo4MGVBQ2s2UVRnbDAralgxMDZ2TjJWZXdmYTJDZnp4OVNYb3lkRHR3?=
 =?iso-2022-jp?B?QVZMek9Jd3lRb3dUYlRVeWVLNU8xZnJRNmV2OHVpZitSaUFOSjFKREFM?=
 =?iso-2022-jp?B?UjBBbnpHdEZ0dVFXRERDendLZmJSK3ZReCtoUEJITnRSMFF6SGNJRlh6?=
 =?iso-2022-jp?B?VmtOblY5U3kzMVRObjZoYUE5Q29tcVg3aW5EZWxRQkpFQWQ2TXNMR2VH?=
 =?iso-2022-jp?B?eEE2Yll5WlhvRHRFRXJvUFV5UTFNL2dWSjlwb1BpVmJZSHZMRUhvU2px?=
 =?iso-2022-jp?B?ME8za0J6NVVhbzFNd2tPcEpEajN1ZGkxWmVUL1BhQ2wyRnM3ZGsxOVBN?=
 =?iso-2022-jp?B?ck4rRFhxV2c3aEdUc0U1OU9Zc3NJT3FpU1c5cWFpZDN1dFN6QmMzVmdi?=
 =?iso-2022-jp?B?YS9BeFJ3VFhDNHI1dFRHMlQyRG9KZ2pZUXE3UzgzOVdZVjNxTlExNG5r?=
 =?iso-2022-jp?B?L0pTOUwraEhsK25sbnpDWnpPMkU1dGxxMUdMaUx2U250c013OExmb2dS?=
 =?iso-2022-jp?B?SG1TcEx6VS9KUGh0ZHpyNW0rUFlSNVNZTFRrSlY5UnJSblpDZzk0MzJm?=
 =?iso-2022-jp?B?WWc2bkprTXJGVzJ5ejAzQzBCeUJ0TnVHZ0Z2LzNGVkJiYnRycjhHSjFh?=
 =?iso-2022-jp?B?MXptS0JGRjliWW00c2tjY2RFeFR4azZIWHRRcnJNRHdYa0NRby9Rbjg2?=
 =?iso-2022-jp?B?cHd3QXBGTUdpYUFFY1VFdUpYYkllbS9QSEVIcTlrU2xHcDF6SW40Wmt0?=
 =?iso-2022-jp?B?eURpRVluRDI0RHNHSXduVVMzanJFYWU2emxsSjJGSFF3RmVSc1RIMGFt?=
 =?iso-2022-jp?B?dThEeEJiSDBXa0d4QXF6dEsyRDdBQTczYUY2SWR1cWMxYkFvWlpDM2Rx?=
 =?iso-2022-jp?B?SHJrWkxEMzVXNGs5QVVCWTRIUjdhbjVYSGpEWHRLMlVTQ0NCOTA4N2lR?=
 =?iso-2022-jp?B?STUvUUI2MmdWczlsOTBwU2tBM2FOSHQ1dUVaVjV3cTJ0Z3VYMWZ3Q1dF?=
 =?iso-2022-jp?B?R3g=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NTJJSlNPQ09zV2psakJaQ0R4ZGltTnY4cWZveFNoM2NRQXNyWmxycTNo?=
 =?iso-2022-jp?B?b1NpcGt5VjRJZ2E3TlFCVVJHNW5Pd3RqODJEMk5JYzBDS0lDY0FzTzBr?=
 =?iso-2022-jp?B?d2VoSURhaFdJRmdXaDdoL0JZK1B2WldVSG1TN0g0YTFJMW9hZWE4b3dp?=
 =?iso-2022-jp?B?Zk9XcEw4N0s5cjFkYjdhT3dJRFVCZzB3QjhQSmt2N29sNUdkWVVOalpV?=
 =?iso-2022-jp?B?TGtYUUY4UGVYaGg4MnMwQmY2ZlkyUFVlZ2JxRlllQUtLUnhId3NOZndY?=
 =?iso-2022-jp?B?dytPV2JLTmZzUlh0djJiNGZuMDRSaDVZRlVJRTZuY3d6WDhvZEVmU09F?=
 =?iso-2022-jp?B?NWZoNjhmUnVYNkhlWXM4NEN0QzNUdzNpRWhTcmZPYzNxakZCMWhieWtz?=
 =?iso-2022-jp?B?V0c2akRGa3QyWG1BRktLMmNTWU1lVDFpSHh5T1FyM2VId21ST09pY3Qr?=
 =?iso-2022-jp?B?OFBweHpyc3pieC9PZWVTZ2dQZWdEaTRzZ1JWUUtNdHg2NElwOEJJWVow?=
 =?iso-2022-jp?B?NFhYWXdXRDVpaTJGM3FEckRYLzVnZktPelBNbmcvbHhiT3BuZGFSY3U3?=
 =?iso-2022-jp?B?aEhheEoyTmd1d2M5aGU4Rmo3K0t4OVNDL2FHY0FNREN1SU9OWGEvY2h1?=
 =?iso-2022-jp?B?dWpGYzBBMDNkclNJdUxBTHpPVHNJMWNva2JFc0wyWUNVSHdzVCtEcjlB?=
 =?iso-2022-jp?B?ejdGWnlTSEMxOHU0S3lDVXBPNVdiQS9xMkZRRGZZMm9RTkRYeGFsSVo3?=
 =?iso-2022-jp?B?dzBiNmF6NEZFanllN0pWdUVkU0lIWFZFWWJDSXJrSVZuSVNkRDk2bHFF?=
 =?iso-2022-jp?B?b1R3SXpzU1ljZUJmZ2V0RDFJT1R1OENZcUpKVnpCR3luWmZoZ0JOWTJT?=
 =?iso-2022-jp?B?RU1jazA5TXlIcjlZd2pIa2VEOEhYSnpZUXhiUTR4bTI3SHpJVlNyMXRS?=
 =?iso-2022-jp?B?MG1jUEhNZjU1dVNyZWVwV1hWc0MweWsrSUt1dWJkbnhDZW5LYjd1TUdQ?=
 =?iso-2022-jp?B?RGUxK0tSSGhWZjZQd0hRMVc1WWJpMUsyZXN4VTRwSFhsVzBmOWhQNDYw?=
 =?iso-2022-jp?B?dUlaYU01VEVLbFZYYWd1TlhFdFprT21ZcisxV1hHTkZ4VWJrbkVnT3pE?=
 =?iso-2022-jp?B?NHQxU2YwSjhBT21tWVRpZ0lOTHZYMjhFK0VLcGtSZHYvQ1pxRGZLZTY0?=
 =?iso-2022-jp?B?U1NrOWpGRzYzRllPcUcwYVVoNkZjMFFOTVZPRncwWUtJOUpXTE5jbnpt?=
 =?iso-2022-jp?B?NDNxWkd1cjc2ZlNJUVowWjFXOURraVJ2amFUZUxYd1ZhSGJSMDRNUURF?=
 =?iso-2022-jp?B?NVY5czVUVnJnWFhhdktGQWpXQWcvTzVSLzdkUVk4VTJITVlpTlVPS1FW?=
 =?iso-2022-jp?B?UjFRYXlrMWc2dkgxRlNGR05FWkVWRmRDd1c2NDIweUJ5Ly91MitGenRl?=
 =?iso-2022-jp?B?ZXdFRStzblF2YzZEVkdHVFJXTDFmTUVhenhrSEJIUVdYSncyNE1XNWR0?=
 =?iso-2022-jp?B?NkxBakxDYlVMMHFVVis1eks5ZkNzYmM3cFlHRTFOejMyeHVnNXUvejBi?=
 =?iso-2022-jp?B?R3JyY3pITDI3M08rWEh3N24yQjNSZXp2S1BIWHF1T0hpVWZpQk5EY2Qv?=
 =?iso-2022-jp?B?ME9NSkl2WEM1RTBDUWc3emJHSTg0dnpmTWRuYXI3N0hkK3pZa2ZaelRl?=
 =?iso-2022-jp?B?RXJxMnVlU0RHbU1MMHRsUUhPb0F3UkpYUldrQ2QvSHA2aUFnYnZlN1Nm?=
 =?iso-2022-jp?B?T0VqNk5XcGpJd0dZNTRsVVp1Q0xIaUZrRHkrc2d0K3RDRDl5VWZiaFVr?=
 =?iso-2022-jp?B?SXZFOFdoS1hIZWp4K3dNbU54R1F2ZElvcFBQc2YxTTBkMGFMWUY3NFky?=
 =?iso-2022-jp?B?Szk4MDJvWlVBZ01JZG8ySzVFTkJNQ1djMXNXVWxHemtFUFNFODdLS0gw?=
 =?iso-2022-jp?B?aUx1b3NsWEFoVUdhdVVMYUtxdTBDcmhRSlNMMWl1SldCakNGcGJ6ellJ?=
 =?iso-2022-jp?B?Zys4anpCQ1pKV2EzNGQ4TlU4RTFFakttQUdDb1dBU2N0UldDS2VJa1Zs?=
 =?iso-2022-jp?B?U09mU3Bsd013bEZDalpWdkFQc0k2RVViTlpmTytYV0JzeE80SGpiYWsy?=
 =?iso-2022-jp?B?V2VjdTZEb3BZbmV1R3NLa1MxY0xoRjNNNndTd0E5T0pSTDZsUzhiNHdh?=
 =?iso-2022-jp?B?ZDNsYm9JaktoK2ZpbjF4WHgvUDFOR2VqT0FyM0lpSFc5SHZpUStENjNa?=
 =?iso-2022-jp?B?UmdWMno4SGhRb1prNkpXOWxhS29abXFiYXRJdFNoSmR0NHdOdWFNUUI0?=
 =?iso-2022-jp?B?eHAvaTlxWEpqcDh3Um1icHZ0NWZ2MmRoVFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3b6fcc-5979-4d6e-96cf-08dd517e07c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 07:13:09.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBXCUTr8JC5guoD6TcOXjRK2J6jCkZ64DI1NSczgjqb42V28x9Z0ObPoHs5QEzDFr4988ibOe/vOYxiSB6t9MFtscJ4b1c8IItSRQc3wet0kkXAYHI9XyfNJTKD0tbq/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10168

Hi Andreas,=0A=
=0A=
Thanks for the reply. And yes, I did come across the usage of debugfs for u=
pdating certain metadata and it works fine. =0A=
=0A=
On the same note, I also came across another observation. I noticed that nu=
mber of free blocks in some of the block groups are different for the 2 ext=
4 images in comparison although the filesystem contents are identical. Is t=
his an expected behaviour? Any hints on what would lead to this could be he=
lpful.=0A=
=0A=
I am including a diff of dumpe2fs from the 2 ext4 images I am comparing bel=
ow:=0A=
=0A=
host@debian12:~/work/temp$ diff image1.dumpe2fs image2.dumpe2fs=0A=
< Lifetime writes:          316 MB=0A=
---=0A=
> Lifetime writes:          314 MB=0A=
47c47=0A=
< Checksum:                 0x6a0e9f0e=0A=
---=0A=
> Checksum:                 0xbba8f574=0A=
53c53=0A=
< Journal sequence:         0x00000008=0A=
---=0A=
> Journal sequence:         0x00000007=0A=
56c56=0A=
< Journal checksum:         0x5c50e847=0A=
---=0A=
> Journal checksum:         0xba912c29=0A=
68c68=0A=
< Group 1: (Blocks 32768-65535) csum 0x9bf2 [ITABLE_ZEROED]=0A=
---=0A=
> Group 1: (Blocks 32768-65535) csum 0x98a6 [ITABLE_ZEROED]=0A=
71c71=0A=
<   Block bitmap at 65 (bg #0 + 65), csum 0x9ecad502=0A=
---=0A=
>   Block bitmap at 65 (bg #0 + 65), csum 0xe702afc8=0A=
74,75c74,75=0A=
<   93 free blocks, 6070 free inodes, 1049 directories, 6070 unused inodes=
=0A=
<   Free blocks: 33264-33279, 47035, 51832-51839, 52923-52927, 53244-53247,=
 54773-54783, 56723-56735, 58622-58623, 62006-62015, 62463, 64752-64767, 65=
530-65535=0A=
---=0A=
>   538 free blocks, 6070 free inodes, 1049 directories, 6070 unused inodes=
=0A=
>   Free blocks: 33264-33279, 47035, 52732-52735, 53951, 54782-54783, 54823=
-55295, 56275-56287, 58622-58623, 59389-59391, 62521-62527, 62975, 65275-65=
279, 65526-65535=0A=
77,78c77,78=0A=
< Group 2: (Blocks 65536-98303) csum 0x0943 [ITABLE_ZEROED]=0A=
<   Block bitmap at 66 (bg #0 + 66), csum 0xc4b03f5a=0A=
---=0A=
> Group 2: (Blocks 65536-98303) csum 0x9332 [ITABLE_ZEROED]=0A=
>   Block bitmap at 66 (bg #0 + 66), csum 0x8b8b9691=0A=
81,82c81,82=0A=
<   328 free blocks, 7996 free inodes, 4 directories, 7996 unused inodes=0A=
<   Free blocks: 73714-73727, 77307-77311, 79347-79359, 80371-80383, 81404-=
81407, 82430-82431, 83954-83967, 88575, 90621-90623, 93497-93503, 94719, 95=
731-95743, 96020-96255, 96670-96671=0A=
---=0A=
>   811 free blocks, 7996 free inodes, 4 directories, 7996 unused inodes=0A=
>   Free blocks: 70652-70655, 72177-72191, 73215, 74239, 75775, 77311, 7855=
9, 79358-79359, 83959-83967, 85499-85503, 86522-86527, 87257-87263, 88028-8=
8031, 89586-89599, 90489-90495, 92444-92447, 93694-93695, 94966-94975, 9522=
6-95231, 95890-95903, 96253-96255, 97531-97791, 97871-98303=0A=
84c84=0A=
< Group 3: (Blocks 98304-127999) csum 0xceff [ITABLE_ZEROED]=0A=
---=0A=
> Group 3: (Blocks 98304-127999) csum 0xb1ee [ITABLE_ZEROED]=0A=
87c87=0A=
<   Block bitmap at 67 (bg #0 + 67), csum 0x2c1ce6ca=0A=
---=0A=
>   Block bitmap at 67 (bg #0 + 67), csum 0x4e67b818=0A=
90,91c90,91=0A=
<   14411 free blocks, 7994 free inodes, 6 directories, 7994 unused inodes=
=0A=
<   Free blocks: 98803-98815, 100852-100863, 102393-102399, 102910-102911, =
104958-104959, 106487-114687, 116223, 116669-116735, 116914-117247, 117354-=
122879, 123391, 123688-123903, 126830-126847, 126967-126975, 127487, 127999=
=0A=
---=0A=
>   13483 free blocks, 7994 free inodes, 6 directories, 7994 unused inodes=
=0A=
>   Free blocks: 103224-103423, 104447, 109582-110079, 110128-122879, 12696=
0-126975, 127984-127999=0A=
=0A=
=0A=
Thanks and Regards,=0A=
Adithya Balakumar=0A=
________________________________________=0A=
From: Andreas Dilger=0A=
Sent: Thursday, February 20, 2025 1:28 AM=0A=
To: balakumar adithya(=1B$B#T#S#I#P=1B(B DITC_DIT-OST)=0A=
Cc: linux-ext4@vger.kernel.org; kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC=
_DIT-OST); dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST); hayashi kazuhiro(=
=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=
=1B(B); iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)=0A=
Subject: Re: Is it possible to make ext4 images reproducible even after fil=
esystem operations ?=0A=
=0A=
On Jan 21, 2025, at 5:29 AM, Adithya.Balakumar@toshiba-tsip.com wrote:=0A=
> I am working towards reproducible builds for a project that I am involved=
 in. We use a few ext4 partitions in our disk images and I am trying to mak=
e the ext4 filesystems reproducible.=0A=
>=0A=
> I understand that from e2fsprogs v1.47.1 onwards we can create a reproduc=
ible ext4 filesystem image. We can indeed create a reproducible ext4 filesy=
stem image when we use the "-d" option in "mke2fs" command to pass the cont=
ents of the filesystem at the time of creation of the filesystem itself. I =
understand that there are a few other parameters that needs to passed to th=
e "mke2fs" command like a deterministic UUID and hash_seed values to make t=
he filesystem image reproducible.=0A=
>=0A=
> In the project that I am working on, there are some mount operations done=
 on the filesystem to copy certain files into the file system. This updates=
 the "Last mount" and "Last write" timestamps in the filesystem metadata (c=
onfirmed this with dumpe2fs) thereby making the images generated not reprod=
ucible.=0A=
>=0A=
> I would like to understand if its possible to make the ext4 images reprod=
ucible even after filesystem operations like mounting and unmounting the fi=
lesystem ?=0A=
=0A=
It should be possible to use debugfs commands to change the timestamps (and=
 other=0A=
fields) in the superblock to an arbitrary value, something like:=0A=
=0A=
    {=0A=
        echo "ssv wtime 123456789"=0A=
        echo "ssv mtime 123456789"=0A=
    } | debugfs -w -F /dev/stdin $IMAGE_FILE=0A=
=0A=
Depending on what changes are being made while the filesystem is mounted, y=
ou=0A=
may also need to modify the inode timestamps directly as well:=0A=
=0A=
    {=0A=
        echo "sif $PATHNAME ctime 123456789"=0A=
        echo "sif $PATHNAME2 ctime 123456789"=0A=
        :=0A=
    } | debugfs -w -F /dev/stdin $IMAGE_FILE=0A=
=0A=
The debugfs commands could all be combined into a single debugfs invocation=
,=0A=
and are just shown here as separate commands for clarity.  If the commands=
=0A=
are always the same, they could also be written into a command file instead=
=0A=
of read from stdin each time:=0A=
=0A=
    debugfs -w -f $COMMANDS $IMAGE_FILE=0A=
=0A=
but for scripting purposes it can be convenient to generate debugfs command=
s=0A=
on the fly (e.g. with looping, etc.) and pipe it to debugfs via stdin, and=
=0A=
this is not obvious, so I thought it would be good to show an example.=0A=
=0A=
Cheers, Andreas=0A=
=0A=
=0A=
=0A=
=0A=
=0A=


