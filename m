Return-Path: <linux-ext4+bounces-11090-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B671DC0D93C
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A489B421B01
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6D302155;
	Mon, 27 Oct 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y99whbqy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HWMBYAP5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE72F1FC2;
	Mon, 27 Oct 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568171; cv=fail; b=KqPWXtvUf3IhJ0wSRkhe9h1qS6n4hcX89VhR7MoSgGnyFR9U30XZb73Y+JY6gLCuH6qdqaSKe1F3MhHpR0gTG25XLgaZmr8H0W7O7RmEH79F2qBDZxZpi4GviPdJi1P5H4qAgu0iMg4WDeg6smfBTrd5u01Ty4C9HIp+I0/h98g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568171; c=relaxed/simple;
	bh=t64e0eDEz5m6EshZU4dJMLlyWm9TEPJJDG77LrKEE4s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EaAt4IHbVvy3tHLnKysc3CwDJasdr+lAxKpS6AVZasLKx9uw3e6jRZg/Vta7Z0Ze7maucuHT1ycZ9IJshbT+BPzcFsjIeH0IIZefg4dmCUQRTjNbOAcxFTIpd1PjbqvRwEdpfJle75Dw+ZwL5ZlgJ4gbpxIqTUwVwi05El7DGCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y99whbqy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HWMBYAP5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCCKOk018669;
	Mon, 27 Oct 2025 12:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=S1y9YKln26cNdPwY
	Bel8RzPMaMWqW643qF08NAaPYnU=; b=Y99whbqyHW0iXXGTcgjwSaG4BRvUne/w
	RVtnzr5mWXs5qJ7i/W0Nx8vFxquzeK+KVFv+7NYkPRaQJHtM9tNkxxDRZixJH8Wf
	M+1EDVZUcSP3OGGtsKGwEZoIJ9dmGFUxfLn+anFl0ZldioptvlrY3YJgVaM2k5yo
	RuxwnrM9Zyy6q+TZgfaXhbtOXKc6EYb9Mwtz9B3xu+fwBP8DrFixkNqmwZXU8XNT
	VvtnJVn/3w1YTvR6vmX68FSISMIa6bELp97nTk+mHKwLeAbEx/4dQjp3bhNfqvRp
	zRzDCyx2z5Nk87ieoB4+EIrmq8NIIMrrBkG3YTojaxEJQCXWxoXbCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ykbb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RAeL97034846;
	Mon, 27 Oct 2025 12:29:03 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pe4dgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnzls6e3VJumuUkQzeLoNK6XnJee2BaINEKuoJI6s/cFlReOufgfQxSGiOocUoz4v3hDD37AK45M2Viv7EaRtxtLi3bi5D73tvwcQYeRS9EvZhMiAh/RvMaznGpb8NkwmSC/T2/Z9n2bJFzVLhQ1S5K5KQlTArjHvoZG9jo8mMFbFxY/sjYU4jR1CuOsv+Zy8lbVtnJRxU8cJ3wRdxVOTOq2h0uGo5c5h6CeU2LVG71EmM3wElHRlY3R+MnJyMUxmjlKAKloA6QjoBBVWeQ7AoMYcuSRLt2RqORnoIwXZkf+GeVA7rt/DcI+yjaHuCnEgcuMbnsfFmq6iJyKgXdc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1y9YKln26cNdPwYBel8RzPMaMWqW643qF08NAaPYnU=;
 b=gTcWefQ5D3swEYhY/RlzbgcKT9YkhoVcCE6XhiUfXlNGCTpQigNtXtcohbl9f2EOOFcv/fbVUXQRURLdWAzRmI4ORDCG8Gw22m05qOV/gQiVF0Y+YAt88d94FZy0/nUi3a20jLyAV1BTMEwpYTMx2hvswyFdFa4fCZ/9Nl8bIeWj5cswcbzbIn0h3Mb/u3N3thAyiioIxbH/558hAo7HKRyHWU6Zqzy+Qk2affWuO3U7rQxEcIZsV/Hbd7PHIyBDYpWouX8VqM7hCJcIn3F1NI6KyR25F5y+EEeMISGEzC9SsB+7UjGbWZ8sULVgSqX2+7KfA1AnsXiFbYx7TAb4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1y9YKln26cNdPwYBel8RzPMaMWqW643qF08NAaPYnU=;
 b=HWMBYAP5j3v+5C7pSJLpUzuOvQAZ7HFJjdJ3Fn5MyXMcyeDqnKl+KlxoauC/3QmNwhVIvBl+Wx2tcTwqJqFnQ2mG+zHjiTz3jPz3GXmDttEOaB2K9xeDQZbkKIrm4KzTQ/Ay+uQgnFxa/8BxlEqNNw31u4zWZQ+UW41huZvCZy0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:28:59 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:28:59 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 0/7] mm/slab: reduce slab accounting memory overhead by allocating slabobj_ext metadata within unused slab space 
Date: Mon, 27 Oct 2025 21:28:40 +0900
Message-ID: <20251027122847.320924-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0111.KORP216.PROD.OUTLOOK.COM (2603:1096:101::8)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 5678c85f-269d-4c15-9ef5-08de155467a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?USbUhWyPhI9Vsz+nVtwyigjUE/ePGU0f0j/OMN/1vrtudMm0N9NcSunL/liZ?=
 =?us-ascii?Q?GfskAr6vkOOX+VOEepO0dGBfimBUoZ3FOmsD4lC8+ZDLxlwlF5+Rm811ePk8?=
 =?us-ascii?Q?3mm9Q8WnsR1KAfBlKa1e4PCvKDtoRFmQKAblYyWsUcuclmpBAjq/CdYYfS8Q?=
 =?us-ascii?Q?3CoQuGJTJ87qGVTBaRyKEsFjcHkxzOALSx6OnUSuCBjql72oBEvSw9iBQ253?=
 =?us-ascii?Q?C4bKCbTcg4pbH4AgCF6zxAI9Rk2g+4kwdAKjkq8c3Jo4Vaw95oCJx5OaMegh?=
 =?us-ascii?Q?awIVMh6UVDZM+4Ui3GL4+1RayVpAAGSGTHQ8XXHbyksgdCh90sob0jACWvwp?=
 =?us-ascii?Q?TnAWXHOfeCA3Bf7Mf90MMueuJeMMZS3BOAaz0I6B38cYb7FGZgarUgz4c2ul?=
 =?us-ascii?Q?mykGBaXIBhlr5orfFu+qoSdghLK3/XHQ8dcZALQlHNXwvtURw9zxF7n7ouuk?=
 =?us-ascii?Q?ZpfqZzaHol9oUNUuOC+rSunMmvBmfK2fbSdDXqT6mnBTuRlKGkvUoKfUhTVe?=
 =?us-ascii?Q?95ozLQbI/gqwVIysGmLcLcimzlXLnlnZ3QhPfcTNQM3EXOhAMwkQygV/6qvp?=
 =?us-ascii?Q?j/+eKuD1nyMP57REMbmDenPmGAASihs/cSU7u87pq9L4cOwqcjx3r7LEhYev?=
 =?us-ascii?Q?ylVDgBecdxVJBR8kiVVmLivRNMf+RxwMIcaF8a6L6/NVC6rXlDeOPbDgiImr?=
 =?us-ascii?Q?1zebdQac0drkM91JE4WxqoOrdwY4SYcq2GTVgdzPajGJ2i13NaU5H3pmW2Jo?=
 =?us-ascii?Q?zj+0XzOwR9fUNPNpERT3KX5hFR2XHP/zixXbx5jPh1SYgXwvzM7Wc+YMNJa5?=
 =?us-ascii?Q?O175zcgcaI78eUGQcdI/4sBmhfpqh8b6eWUwdavXkEywPrzVgG5CVw1v4KId?=
 =?us-ascii?Q?vK+otdvmwaRJixiRsgLRG9r9Dhl8NFGTdoGv0F/S+D0pHXhcTB55W/RUJEfl?=
 =?us-ascii?Q?gFYtRRaOLbGqNsCEEkPGFVAkJeWdWt/4udwR1B//6iygpHo/x/U5bN4F7pCz?=
 =?us-ascii?Q?30H25y/ryOKHg6zeFHkpHQ+IXXdyFuTXmCmE1Rvr1jvkse/z4yI5FQT+AMAb?=
 =?us-ascii?Q?QsBty9ckNLz42x9CiFRVZ/yFpGJHdJy+pZwAZl41OyZdMWjSAV7KyGE5ItEK?=
 =?us-ascii?Q?4o6mGHKSeJeKxdnxvyFXCSsxVT1IifYoTd5wJaO+C7CUjZgFISntziTiPzg6?=
 =?us-ascii?Q?BWsDnduUQn3Gj8jigNS7wefWGpzA2H6PUYzT8YczmEoPO/vy8ZfZBjoSQko2?=
 =?us-ascii?Q?B8xobDQu8GaTc40QsJKum3lg8vFQPNAkLINqg48yLF2miIc3QDyvJeUmSB3Y?=
 =?us-ascii?Q?ongXKGCrOuG3D+eY6Hib/wJNlweLYX8n8pyDpoPkP0JsYhoM52WDCcE9x0zm?=
 =?us-ascii?Q?/pS/IcdsxxhKnLAnVRBpBilrp83lRB6VjuljYo6VXCXqQPnf2kS0aRRdotN8?=
 =?us-ascii?Q?Q5SMsSb+7QxHTM7DG16mq/E7jdoxe8NmiZ26CyZ3x1TlVdY7KNbEyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ofEBMr3ufh6OT7vdpZraa800GDKd0OAwT+fqN0WHYeUxGUj24CMueOC4Bap?=
 =?us-ascii?Q?Ep2XiJcc7KYuT1c9ZaZqCqn6V+7ijXLaywQjd2H1W6W924wz132N6+nmhhi3?=
 =?us-ascii?Q?lqNXqVTh0rfxGxD1ZAArJj7Fmk9U4A4Ehr/hWKEdp/Xzo+M5lZz806LG2Mze?=
 =?us-ascii?Q?oQZeBVgT3pZw/Qgb5F347jhjBNTaPEENas+ozyfspTH29uEYaUMsh2RlykQP?=
 =?us-ascii?Q?osRL4Aay7FNI7Py+PRjPPGotwcIf8gWkaHcLezrdxc+g8whQMT2hntQk5yvs?=
 =?us-ascii?Q?wkTIK59BLbKUY+UL7gVATGrzU+iJgXGf/LWwRhMFCnO4dDyK6uOd8PiXrACp?=
 =?us-ascii?Q?UELtNZ+8vM7KToq43++PulJCenIX5rMdk5xM6Kmoi2mEUtdHXbo8yG1nCAxh?=
 =?us-ascii?Q?dzPXtLuBbc6VEXDT0lfa7gCK+u6btBZ+pOu7uWvhVlTBGUu+P5BgCbKKHN7m?=
 =?us-ascii?Q?yLX/NbvsuNkKvRS362qe9mSC+oRPNqOmcFh1APH2MUZVcDfLq7P7NprMAXIP?=
 =?us-ascii?Q?Srf0//vH+Ch7KkeVaU/hyumbX7TQe7LoRRPsJTozBxQyfgXgrIsVIn5PMxIZ?=
 =?us-ascii?Q?chuL4tPhJIeISYSXyz8CAmhMZX/NnYvW0YNTwYpYoUAO68zI69XH8jBgJFBg?=
 =?us-ascii?Q?tdwZzKgzUDFG5WDPiFs7Xv7t7IEGYC9BbBE3cAsPIrQ+iOAHL9HgV2YNINv9?=
 =?us-ascii?Q?XbfQ7QbBrdaC2fKDI9TI/bLqPkIOzP9aDUZC/smyukadT9hCrR4c3yndnSBD?=
 =?us-ascii?Q?uzl4iT2rEK7wg8CBDiUEXCn0rdWAhqVMINQh7jx5pvMfp4qusJlkeatGxq33?=
 =?us-ascii?Q?4LpyWlI5e+KdybWFKbqaISCJvunGXkDr7Sv8k9+EElSDV4w4NnmXk8tSqdpj?=
 =?us-ascii?Q?dKPPcoywv+vRypi+e+DHM6lLjOjCXx0suvikPYq9DBtjFoaaf5I6HkRK5+fQ?=
 =?us-ascii?Q?QyYkeWgnD9g5dKqrWiujfC9tiobxzGnP0kW/q3t5DQNokqdB8zUDa46Hck/5?=
 =?us-ascii?Q?CsAfaXEJ+UZXzHzSMDKqCZ7h37EJcysiVYd4klj4zq0SPAK+isv7vMdHCpyU?=
 =?us-ascii?Q?7Kh/Rmx2L8FLSJ6dEup9zpi+XIj4QSPSV/pIfxdEnpGRRDJqpL0v03LFIty4?=
 =?us-ascii?Q?h6jGWL4VKFncVwrOVQ3Cn6CaASL38AA9LW32JN+NJCPo3Z2NpvnRJkcUL7sK?=
 =?us-ascii?Q?H3DpChg6EybAIlVokMq75hi2MGUObtdgmuzIpbC35pURt03Rqg8ZS166CjBP?=
 =?us-ascii?Q?joYLRdm/mz9iC8YIV7FFy9jzau3XeehR1S7Qtyj7IdYyPcJE6PFCFwcaR2jx?=
 =?us-ascii?Q?bn/xfjcGdHpip2h31h0XfvwVscWstiOApApKbBSpQ3aHIsO0r91xDGIOvjCJ?=
 =?us-ascii?Q?ygHoR5yGjr50Sbah/a9iLYiM7N55N+0+5aFmPx92FQ3wyezpLrgNBEUT3EAD?=
 =?us-ascii?Q?ISNNzl9fMZnvLVfbFKlz1NzjlgZEnlHh6NDkGiG6WFgUyY3lMWWaX4vmQZEx?=
 =?us-ascii?Q?hRx6j9oneMR8RJQ1L+szURxhYtJaYzGEGVdBNP6qfuSWmo/DoYhumtqTBtdK?=
 =?us-ascii?Q?A5t1P/w5M3SFMb/TSQWsQ/QSqBnKHQw8RDpaIpir?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ke6iWjSCYbUXoG7pGsj5Nz0n+udZwG+PA1bJ+qsLjtrY1FT3Kxr9lROhqQJ6lGw+GuPtyEjkDWXMkXLOQzdQkUS4LqbvDzjFGBXLa636iFQ742m4S6FAUDrDbllnQXzDfCDX0OkbuZwQ3JVg+PtjTI28kVW7k5P7ojhHPptMlzJIrWFWTd4OQ9owhmdipzuFtgp8HjKc1p3gVF3EimC4qnTi5Xv5x3EeWVgpYjYC6UzxiJ+nQvNWaglt4oHZ+qZs84C7tyo2tlRN1bOCi+HObO452/uhD6nLIv1MFHUxZUNHH0VmTYd3/eWb4nO1Pw2ZUIjWyhioeiUUokGFah1chhH6POLf/Jw7M2ourUe82SlYtKDRH4RpqbnrTDgdlt3E3+95x/mGNtKaP3UV8DSgN7eBFbYYO7pzLOUrni7dTxEnE55ABjhD6l7tRVJu/FcGD8ZGpjFTcdawHrjyuXWt63z0+ai5451OzU37RGfjXdGLxLQFYPSHOD92p/OTeiOYiPv+6DlckBGJMsKdlBBwwlLwtUIicgXYh5DVb8cx/Xsgg9mYYt86E/1QLl/mtktH3blaK8HoILXrvXu4pJ5VxZJROXe8GgttKGdRWzaaYME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5678c85f-269d-4c15-9ef5-08de155467a0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:28:59.6848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqEKvJSxR8g22W877w5n4Jaz+l1L8Z0NcfnkW7ckr/yNBqO50Q3lsqK3cf1DLZ/USYb5H9VJwwroV/YeL9Xh+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX26DV8nkLX5mm
 glw4okqNrOp+LKDx6aEdhrHt/JjybcXbFTe9yjAp/c7vPnijxQ3xdVRBb3RFu6EFBWYkbwhJsbs
 d3Xyw6REaQEgzguL992gLzUl2hr0kyRmLmhrQCm4OFGM0GFEkIvJHcJ9ChLeDE3otjOBFyCJ0JR
 lQbHkOBnFjan6NTP2Cv4BATX6HVxlPJ3TqXTjtfSWzbYa0Rxtzq/Urc991QKcNrth8+tP/lyyWx
 oSoKc0K5Bguej2zcbOZId9asio0rA9DbNEJbdbg3PYE/BA9FI/9Ac4exOEwzLGQqvlJwlGPFhex
 rOBowyA7Iqm2LqEQKU+N1dVoS3ie309szQpM7pwlg3qvgqcilHBQ+zcIQYTeqFb/ATWpAv4q110
 0zAclt42tNlOREbuHSQsMCYFWStTDFI4oF0/2arpCHx8tFEoQzw=
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=68ff6591 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=F2bBXNHfPZ7v51Lu1DoA:9 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: OZrVmUQqVMYkYAUT_ge2NQCysuebZ6e0
X-Proofpoint-GUID: OZrVmUQqVMYkYAUT_ge2NQCysuebZ6e0

RFC v2: https://lore.kernel.org/linux-mm/20250827113726.707801-1-harry.yoo@oracle.com/

RFC v2 -> v3:
  - RFC v3 now depends on the patch "[PATCH V2] mm/slab: ensure all metadata
    in slab object are word-aligned"

  - During the merge window, the size of ext4 inode cache has shrunken
    and it couldn't benefit from the change anymore as the unused space
    became smaller. But I somehow found a way to shrink the size of
    ext4 inode object by a word...

    With new patch 1 and 2, now it can benefit from the optimization again.

  - As suggested by Andrey, SLUB now disables KASAN and KMSAN, and reset the
    kasan tag instead of unpoisoning slabobj_ext metadata (Patch 5).

When CONFIG_MEMCG and CONFIG_MEM_ALLOC_PROFILING are enabled,
the kernel allocates two pointers per object: one for the memory cgroup
(obj_cgroup) to which it belongs, and another for the code location
that requested the allocation.

In two special cases, this overhead can be eliminated by allocating
slabobj_ext metadata from unused space within a slab:

  Case 1. The "leftover" space after the last slab object is larger than
          the size of an array of slabobj_ext.

  Case 2. The per-object alignment padding is larger than
          sizeof(struct slabobj_ext).

For these two cases, one or two pointers can be saved per slab object.
Examples: ext4 inode cache (case 1) and xfs inode cache (case 2).
That's approximately 0.7-0.8% (memcg) or 1.5-1.6%% (memcg + mem profiling)
of the total inode cache size.

Implementing case 2 is not straightforward, because the existing code
assumes that slab->obj_exts is an array of slabobj_ext, while case 2
breaks the assumption.

As suggested by Vlastimil, abstract access to individual slabobj_ext
metadata via a new helper named slab_obj_ext():

static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
                                               unsigned long obj_exts,
                                               unsigned int index)
{
        return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
} 

In the normal case (including case 1), slab->obj_exts points to an array
of slabobj_ext, and the stride is sizeof(struct slabobj_ext).

In case 2, the stride is s->size and
slab->obj_exts = slab_address(slab) + s->red_left_pad + (offset of slabobj_ext)

With this approach, the memcg charging fastpath doesn't need to care the
storage method of slabobj_ext.

Harry Yoo (7):
  mm/slab: allow specifying freepointer offset when using constructor
  ext4: specify the free pointer offset for ext4_inode_cache
  mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
  mm/slab: use stride to access slabobj_ext
  mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
  mm/slab: save memory by allocating slabobj_ext array from leftover
  mm/slab: place slabobj_ext metadata in unused space within s->size

 fs/ext4/super.c      |  20 ++-
 include/linux/slab.h |   9 ++
 mm/memcontrol.c      |  34 +++--
 mm/slab.h            |  94 ++++++++++++-
 mm/slab_common.c     |   8 +-
 mm/slub.c            | 304 ++++++++++++++++++++++++++++++++++++-------
 6 files changed, 398 insertions(+), 71 deletions(-)

-- 
2.43.0


