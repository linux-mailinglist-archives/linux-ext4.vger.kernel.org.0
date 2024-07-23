Return-Path: <linux-ext4+bounces-3380-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BF93A1EF
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3550C1F237C4
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC21509BF;
	Tue, 23 Jul 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i39JeSzM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wfrR4srl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DEC8F70;
	Tue, 23 Jul 2024 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742638; cv=fail; b=aAoX2Q8UdFcPDtbaEWyahyuX265eiRKHblN+DfkFo41udNmd9HWSLIRbUtEz17iiHR+8Lm5jPt8fx0bCdhfZXUVmq/0N/eVP4+MXu6XJp0y2vu+r23FRyyqba3BJOl1twpFrfqrSxsfWEFoCRPvWpvv3RTxFZyXSsrnR9QsHPEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742638; c=relaxed/simple;
	bh=yG24S7hIwLmu8K3okt0rjffX35hPqEoehOr9R8mPYYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hxbX/ft3/6E3yQoA1e1uPTweTgJrjd8wZPzPlPKk0euWfDSVX2Qb8j5/J2Tta7b8r7NvF494JJhi52Xbjy+1ma0zRic/qy1xs3AiSTmXUHftD2CyU1DXP2bqYvyYML13v5EYADESk/W5ZDTLyUlULKS3pIRGEJQAhLBbdrQJ6dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i39JeSzM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wfrR4srl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCGS1o000968;
	Tue, 23 Jul 2024 13:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=yG24S7hIwLmu8K3okt0rjffX35hPqEoehOr9R8mPY
	YI=; b=i39JeSzMvjyyjn6bT9OGFwFqDqj0Ro1qy7nmXm0/eyJ6TgKmmNSH82p2X
	17+gN5X7yjVe4WCvcr9WlouzaBXQUnEJKNWhIghmf1sseAN8EIx/ItV1YMAVhUKb
	dvXg/ewi40SQ1jUm3sQ65eEkITJNq9bzsHxHpcfTrT4Fq4/voSpAElOGpTNSU+gl
	k5p5my3W4GTLIKYr6Qngp/2rebhXk/9y9TRzB8sG6dGTFgU9P8eZWXxJiaX0TeS2
	Z8f2v3Dudgc/mnm8ezgmL9B7WaLXUx5yD9a6a1flZUtan44+KgAAxGP/1WyuYY3o
	90P6CyoGV3+PTw6fuZKX0pEx9wdrw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpetcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:48:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDQSEn010999;
	Tue, 23 Jul 2024 13:48:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29r7bg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7G6e/lDfeymtRDegbKuV/mljGIrWaLc8NhLcpMuYiPe5NeoD8e0QW60qFhe6RBhYBmmZZpxCIhDWdVh7WDps+TP2Gxc9xHnTI1yUWtkjUA8aduUsj1KsX3sAH0AA+ocUWi2BOshNhuHT3KJJ0uojYPgOZaETXPQw5p8NqW5cfEYcA0oPLpw+9sR2tItVw21RaR7i9cFfm9dIt4w0JuwB/4ugr/Vxzn/COmiA/BWr2gvtHpwcyMBs5Kz9zASphJc0GTgoImyRse8psGlWsKNmitx+Idcwgj9Pc/dP5M0Sa8DRpZsgMQdLt4sr8GsHqFyA74fJiZihszcvzrec7SBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG24S7hIwLmu8K3okt0rjffX35hPqEoehOr9R8mPYYI=;
 b=MQWLfkpNeofVcHsSZzHC5Fe2D+y/iW/4Cr4/FcZlcbeYweMuIfkAL+YQRKh8ey8aUgIRDqQhLoee4iUQ15jhCWv+RNNFKK9Ncoy2soV2PBOmZJZ/PfxAhAEKpOljp/eU3Rc5Dz9mjp2MB+lql2abOmlSH/zMF/hwKR+y4xCDuEARGDyjmJTcDOV30m1A4Or/ziK7vIo6HWPQBqvsifProlHo2Ek+Z2on5Ugzq/mAjyxLX4dj1FjSbIx3gbG8jWAflSTQrK52af08UH8ddDFB9hCJEX35mWeyhJwd/+4VZNVknfIlpdiv4JoeGidLZyfRv0r4jW5F6OA9TyK51BvaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG24S7hIwLmu8K3okt0rjffX35hPqEoehOr9R8mPYYI=;
 b=wfrR4srlqrzTguEfLf07KoH6HxQfXuh/JWM9nMmqmLvuQgpSmDNj69mwLJ6IT3zY4HXTBdARgjJkUDnN4igI/x9yp2Cj/YC7hGl0ETMHvtDghTFRD7FbhbkT+jpP00SlqsrkphSEt3A4tYhSvgeCZuDYgq4kNoqtnC6JnnBAJBI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 13:47:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 13:47:45 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Ajay Kaher <ajay.kaher@broadcom.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "krisman@collabora.com" <krisman@collabora.com>,
        "patches@lists.linux.dev"
	<patches@lists.linux.dev>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "alexey.makhalov@broadcom.com" <alexey.makhalov@broadcom.com>,
        "vasavi.sirnapalli@broadcom.com" <vasavi.sirnapalli@broadcom.com>,
        "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
Thread-Topic: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
Thread-Index: AQHawX+uwoYrLA2UOkeTCBaoZEb1HLIEGqyAgAAlf4CAAEqTAA==
Date: Tue, 23 Jul 2024 13:47:45 +0000
Message-ID: <1C4B79C7-D88F-4664-AA99-4C9A39A32934@oracle.com>
References: <20240618123422.213844892@linuxfoundation.org>
 <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
 <CAOQ4uxgz4Gq2Yg4upLWrOf15FaDuAPppRVsLbYvMxrLbpHJE1g@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgz4Gq2Yg4upLWrOf15FaDuAPppRVsLbYvMxrLbpHJE1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5647:EE_
x-ms-office365-filtering-correlation-id: 968cb267-f64c-48b9-afec-08dcab1e0835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGVucnVMWFdJZlVweUJYTG92a0lndFFLbGlNYW5wTklmR1V5WEpKWmdQdTNZ?=
 =?utf-8?B?cGI3VURKOGIrcEtpNEdCQ0p4bzkvYVB2ZWtMcjlQWEttMndIYnR4V0xrcm5j?=
 =?utf-8?B?SVdGcUE3ZW1NMk1hMEZIcnRESVhBTVhEZk1KM1UrYkZOQS9oWkdyNkFKMkNB?=
 =?utf-8?B?OGIzM3p1TmlVWW9ueGJpT3pTVlRHcWlDZzdvbWFHYnUrY2Z4Z0dvWk9TODA4?=
 =?utf-8?B?MTQ1dU1RQVBEU2R5ZFJzMjhDbmU5R2ZiMkJvamRUYzBydW9aN25lN3RFRU9m?=
 =?utf-8?B?NVZkdVFmMmNIcUs4bmx6MVZuYmxqSTJ3TjgxTXA5RWV6MVA3SDNGT3R2dmN6?=
 =?utf-8?B?RklUWG5tUTEzTG1PdkFodWZiS2JianZpMklWTHdNUW5FM2VrNGRTVFdWNjRk?=
 =?utf-8?B?cThlbXBZY1BoLzV6WUtMNk85ZVpHQmgzdVRFbEg2UzgrdWRORFVqa2NRTDF4?=
 =?utf-8?B?MERKc1V4OHl1TkY3KytMNE93bllBUlVtR3RBeXZHWSttUlEwMU1PcG9vemwr?=
 =?utf-8?B?MWVCYnNlM3VNNDJLMjZ5enBvdGkrNU1rRlVYZy96UHpEa1ZQL2VzZTMxNFFJ?=
 =?utf-8?B?anNaMm1QdjNoSEdNcHhlSFdVa2lWUDVwV0Y3dUpYU2REZ01wT2FnQlViRnZz?=
 =?utf-8?B?NGdsYTErbVgyaVBqenNpL3JKMXBQOXZMeFNPcmV3d3BZblhwdkYwck5FY0p6?=
 =?utf-8?B?ZEJRek15YVJITmUya21UV1hjNjNnR1Z5ZUlGc0xKWEN0TnY1ZnZKRWQxUTFq?=
 =?utf-8?B?aDZqRVMzbTlnSEZWaHRNcUFUQ05ZZ1dqbDU1U2pXMk81UEtIU2Y0NVA3eXJl?=
 =?utf-8?B?U2xTQ045dlZwTzZrUG90dGpTZHowNUwveHFabEk2T2draEY5cnF3Q2Y1NHI3?=
 =?utf-8?B?SjYzbldaUW81U2kxZS9SZDRyNW5jWDNxMk0xUlBzdURVQ2FUMGVmWGo2eTJG?=
 =?utf-8?B?ZEtMckRhRHJGZkcwQjFHMlU4Ym5BYVFMM1BvcCtkMVpzY3lDMkphYXZFb3o1?=
 =?utf-8?B?R3JuRVlacEUxNDBWV3RjTFFiOVJYSE0wKytnRjFWUFpxRTVta2RKOWRqWkI5?=
 =?utf-8?B?UnpZMkE4LzRoZmdhZHU1ZEdneHRrMjRCc3BNNWRWekJUUThxVkZ6bml1Ni9W?=
 =?utf-8?B?NnJiL1cvS0VoazV3MlVvdHFIRm1lbFY5Q1hXYjdRek9PQURNVmFyYklXcVQ3?=
 =?utf-8?B?cFpmRVROK3hjUVc5QmM4aXRKQU5yK0YzNkw4eTRhcnRsTEkwVzNtSGxOTjdN?=
 =?utf-8?B?WjZES3RVNTQ5YUkzU0liWWZodDdCdit1WFdhRXQ1cHZlK2paODcvN0UvYms0?=
 =?utf-8?B?THNuVHA4VUpMME1TakMyQ2kyQTZ4NFpoVlV5RXVobWRpN2xuVXRwN29JWEYx?=
 =?utf-8?B?ZXcvbFZPN3Rwck1vdG9KaWlPWVRlOWxwcVpUUDdQSXFIbkczNG9tVXBzSFM2?=
 =?utf-8?B?bWluaG5hR3R2bWdQOTlqdFlnazBHWjViZktLQk9IMWhBWmNjUlpzOHpoT2Q4?=
 =?utf-8?B?cUtzOUFvY0RHaVJxOEFtRWlrVHh1NnhyOUp4c1JweDJXQmQwS1BPaDJpN0JT?=
 =?utf-8?B?NHpCSXBEajY3TWJaMXVDN1g4ZktQUDdPT2tlbDk4UzJZbDZ2NkZ4dy9ZNXpU?=
 =?utf-8?B?WDJMMENRaWxFUkFQK096UlZOUU9hRDlHWjcrZ1Q0amc1Q2VZYlFZYWk4V1Bq?=
 =?utf-8?B?czF1NFNNL0t3d2RKNk9nN05ZUHo0amtHVTZqbHB5UUVPYkZrQUdFQnpCbUlP?=
 =?utf-8?B?eGg5clRMaXU3L2FDbklORjc3WjlwTW1sWGZpVTNyTjQzbm1oajVMbVcrQ2lh?=
 =?utf-8?Q?nAuX20bSq7goF30/brC+jj+b4ggiu1IXT07OQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFdKMEQySUcrVFQzd1ozMzlpemJyYmtXbGdJMTBWTmtJTGsvQlh5ZDVWL2xw?=
 =?utf-8?B?d204cDI2Q25tVitRY2VnOUtUdWpNeXZsTDZsaEdXTzU0U2ZuUSttME1FWWRL?=
 =?utf-8?B?WnIrcmd4eC9PNUg4d29TNEc1ZTNseVRLdFphOGFzRERBNm1PdjVsSkx1RFdi?=
 =?utf-8?B?R21Mb0tpUGVha1RXcERUTVVPSlkxaTVrbDRHU2pndVF2MnZ2cHJYc3Z6czQx?=
 =?utf-8?B?S05yaTFaYURnZjRCeVRtWThyTnh6Ylo1VEJSb1FSQ1ZGbnlJdUEwYWliOGND?=
 =?utf-8?B?Q2g2dmlhbmJLTmRUdlFiajFJalkydnNvM3ZSQ0t6QmJ1Y3FQRGdKamkrRC9t?=
 =?utf-8?B?dzNMMVZZZ3BrOTFxcjhlc1hOMTYrdkZnL3hDY01aWXdkOGY4UXNobUVuSlVw?=
 =?utf-8?B?ZHdIVUF6RmpxbldDemErYTRaMGhYMm15eU5IQ2lkWmdIcVJNZzhLUm15cm1O?=
 =?utf-8?B?cm1wM1ZyVHRZajBUd2ZWaE55TVhtK1g4VnFWMUJTanhDaFVMQ29MNXRQVjUw?=
 =?utf-8?B?THYrd0RScDhRODhUSzlJbkwxUmRQRTB4ZDhxYjN2aDBCc3c3djhNc2Q1Zk9r?=
 =?utf-8?B?OEtaOHc5RWplUlBCL2FES1dMVjI2L29zWnh2SSt6Nk9pc2M5Ny9rME9zMmlX?=
 =?utf-8?B?U1NpWnBVSDBYL2sxL1htOFQ3UEFSVVdLUGhyblRTWERKT3RIeW5HUTEwSjRq?=
 =?utf-8?B?aUE0czByOGpvQXE0OFd0cFVUYkRzUkVrbTdZQlg1bWJSWDZKZWxqTWZsanZ5?=
 =?utf-8?B?UWFPSDhsWTJmZVlFNzk3ZURONGNxcnZkUVNITm5mZUdkYURCSHRGbk1aUVNu?=
 =?utf-8?B?TTFNNzZkengyckxjNzBqaFpRd2IxVkQ0cnlYVVorVGZRdERYY3hIRU1lZ01k?=
 =?utf-8?B?UnNROGE4dXEyY2JtN0xiWmV5NjlNVWRxQlZ4Z2cxUlZ6MEwzTGpkR0t5ODlT?=
 =?utf-8?B?bFM1ckFnWWdveG0xN1FjQzNXYjBKZG9yVkZHTUphb3lORVBPZFZQK1BKWUpx?=
 =?utf-8?B?TCt6UUVRWVZ5aU5sRzc5c3l0QUxPdVY0R2N1T01IRmo2TnVhTGcrbGhzVFN2?=
 =?utf-8?B?dHU2MWk4NDZSNlVaTGtGTU8rZ3p4enJqcXMvZ1R1YTBWN2pyNGdpNy92WGQv?=
 =?utf-8?B?QnVhZ3hCN3h3eWxxeEVQdVQ4ajlCWGlXZndJMys3VUxBSGEvUnh1RlNqY1l6?=
 =?utf-8?B?eXZGSUNKUDdiRk5SSGVWcE8vRGpUMnJZRi81L2tXZk1DdVgxaGdqcERkcFpr?=
 =?utf-8?B?U1p5dEwwUTF2VnJ4aTBuQ3ZXSC8xcTZ1V3NUV3Jud1ZVL3N4MTlVVUx6Q0pM?=
 =?utf-8?B?cW9KNjU2b1VMQ1loT2RzUmx3YmE5emJjSEZUeFh2cHc0cks0ZXdhQ0t1TlNF?=
 =?utf-8?B?MlhCeVQxR0IvdnhiNXh2SVFrR24wU2ZTQytFeGRUSllPQ2piUmxDeFJZR0xq?=
 =?utf-8?B?M1Noa0ZkTEJvdEQ5L1pzcCt6bVhiZXNGU2ZtaG5FRE5Vekk2VDZFUkFrU3Ra?=
 =?utf-8?B?emovUFB0c0FVY3gvVW9Uc2J5MmxJN0RNTHF5TEdYQ3A0RDNDcGN3S20zbnpB?=
 =?utf-8?B?RjZha0xYZS9qdTlLcGZoVGZDT3dLQi9hZ1pjV3Q5NHZ0Rzd0MU9HSUdMMDJI?=
 =?utf-8?B?dGdIdTd0bSsxbXV1STZHVVJINGsybWtvRndlWENMbkdDUVFJaFJNS1ZmUHhW?=
 =?utf-8?B?bGxwOVY1Yjg1UG5tRDNIUVRHU1NweW9yV3RMWU5IQk1EYWJoNFdMS2RhU0Zq?=
 =?utf-8?B?dE1NUUV0RHhHRG9ZWHF4V3d1azNQMlJKUlJWdmhmaFQwK2pDWUlhZkxXZytC?=
 =?utf-8?B?dC9FQmRpaiszdEFEZllqV1RybnRlZSs4TUx4c2xXeFVQMG9GRGhLM3h0VlZJ?=
 =?utf-8?B?VFYyYnAyRmJtc3BzQmRDSjRvVHJhYS9yVWhjUG5ITk9jeldZajcwVjdIZEFR?=
 =?utf-8?B?NjlYalMyZTZjRW14SVJwb3d5UmFWOTRaYkJ4ODJoQUZ5dGlIMTBUem5rQkRQ?=
 =?utf-8?B?dFl3Tm9QME8xTEFscEY4emVQUmd1b0w3b1pqU2k3aGoxK2EzdW9CMFN0WGQw?=
 =?utf-8?B?akpUUi9pbmpJYlRTaTJseW04M2dFdktITXl4RkY3eURScDEvL2h2eWZLS045?=
 =?utf-8?B?RUJqa1NFY0xWZWpMcXQ4MjBSb3FrRWZHb3JJUWV1c0Z0d2dFNmlkUW4vL0Jq?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E80D8485E5486448D8E4CEC9E5D4D0C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k3TYEuCJed5kcOUYMP4M9OA9HSbljl0VDx3Q5kA+OO90apEW/Go54rzjtRnFYemwgi4npW0K53iVIRFDIoqj0wni23yZus4X/Y4HPBD4a1Ng7HEy+OjNp8h0VrIy2KxmXW5pOFRFGVkR8I8YQ9oqFrOJs4uGFEi5EB6dOezpVjbku7qHb/jSEs/jchNXm0uNcQmEeYnTYUXRjL6UpDdWxw/0RJmV4V8OPOW3cduMFb6FbpUEs01ZdUB21DszxbgSkqUBHfy5StQFkKNqEnqfLYP+U7GmDaxLpHWJNIj/zYbuGr/fI+2YzUUpMnmVdgctwd3NIsUVRx9gt+4c4j8UYNygN67gtSTZgcnS47+dDHQXn/qNMRyum/OOfUZ8gpz33OkHscSAbItK9hKeMcLPetNtvvpw6QPWdiB0rGEM7AavQ6mU26cNvWzS06TScge81CjdgaEJJu0P256KmrMJPElDmk04Dp4LSYg1mMdMpwAvIuflAP9SjNNtIvjrUGN4cZSDPt+jesIbFkPDG8EIua6fnSSxeBy7qlvhjPY4apvJPPMrh19eWQF4HOjhF3ETG5VexwDFaKj8Lv61IN85dqTPKyBmhNmQ6NpoDW80xP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968cb267-f64c-48b9-afec-08dcab1e0835
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 13:47:45.4273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/vfoVoNGoJcFf7e+aFc/GSrbGew7caIUIua1ZmRqApAzTiGo9LM5H9O8ll04X+ePfAhrxNZ80yc6YuUlhCirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_03,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230099
X-Proofpoint-GUID: q1u9Y0rROUdm7aojLLpPxQm5GQ6x-Uwd
X-Proofpoint-ORIG-GUID: q1u9Y0rROUdm7aojLLpPxQm5GQ6x-Uwd

DQoNCj4gT24gSnVsIDIzLCAyMDI0LCBhdCA1OjIw4oCvQU0sIEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKdWwgMjMsIDIwMjQgYXQgMTA6
MDbigK9BTSBBamF5IEthaGVyIDxhamF5LmthaGVyQGJyb2FkY29tLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+PiBbIFVwc3RyZWFtIGNvbW1pdCA5NzA5YmQ1NDhmMTFhMDkyZDEyNDY5ODExODAxM2Y2NmUx
NzQwZjliIF0NCj4+PiANCj4+PiBXaXJlIHVwIHRoZSBGQU5fRlNfRVJST1IgZXZlbnQgaW4gdGhl
IGZhbm90aWZ5X21hcmsgc3lzY2FsbCwgYWxsb3dpbmcNCj4+PiB1c2VyIHNwYWNlIHRvIHJlcXVl
c3QgdGhlIG1vbml0b3Jpbmcgb2YgRkFOX0ZTX0VSUk9SIGV2ZW50cy4NCj4+PiANCj4+PiBUaGVz
ZSBldmVudHMgYXJlIGxpbWl0ZWQgdG8gZmlsZXN5c3RlbSBtYXJrcywgc28gY2hlY2sgaXQgaXMg
dGhlDQo+Pj4gY2FzZSBpbiB0aGUgc3lzY2FsbCBoYW5kbGVyLg0KPj4gDQo+PiBHcmVnLA0KPj4g
DQo+PiBXaXRob3V0IDk3MDliZDU0OGYxMSBpbiB2NS4xMC55IHNraXBzIExUUCBmYW5vdGlmeTIy
IHRlc3QgY2FzZSwgYXM6DQo+PiBmYW5vdGlmeTIyLmM6MzEyOiBUQ09ORjogRkFOX0ZTX0VSUk9S
IG5vdCBzdXBwb3J0ZWQgaW4ga2VybmVsDQo+PiANCj4+IFdpdGggOTcwOWJkNTQ4ZjExIGluIHY1
LjEwLjIyMCwgTFRQIGZhbm90aWZ5MjIgaXMgZmFpbGluZyBiZWNhdXNlIG9mDQo+PiB0aW1lb3V0
IGFzIG5vIG5vdGlmaWNhdGlvbi4gVG8gZml4IG5lZWQgdG8gbWVyZ2UgZm9sbG93aW5nIHR3byB1
cHN0cmVhbQ0KPj4gY29tbWl0IHRvIHY1LjEwOg0KPj4gDQo+PiAxMjRlN2M2MWRlYjI3ZDc1OGRm
NWVjMDUyMWMzNmNmMDhkNDE3ZjdhOg0KPj4gMDAwMS1leHQ0X2ZpeF9lcnJvcl9jb2RlX3NhdmVk
X29uX3N1cGVyX2Jsb2NrX2R1cmluZ19maWxlX3N5c3RlbS5wYXRjaA0KPj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvc3RhYmxlLzE3MjE3MTcyNDAtODc4Ni0xLWdpdC1zZW5kLWVtYWlsLWFqYXku
a2FoZXJAYnJvYWRjb20uY29tL1QvI21mNzY5MzA0ODc2OTdkOGMxMzgzZWQ1ZDIxNjc4ZmU1MDRl
OGUyMzA1DQo+PiANCj4+IDlhMDg5YjIxZjc5YjQ3ZWVkMjQwZDRkYTdlYTBkMDQ5ZGU3YzliNGQ6
DQo+PiAwMDAxLWV4dDRfU2VuZF9ub3RpZmljYXRpb25zX29uX2Vycm9yLnBhdGNoDQo+PiBMaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9zdGFibGUvMTcyMTcxNzI0MC04Nzg2LTEtZ2l0LXNl
bmQtZW1haWwtYWpheS5rYWhlckBicm9hZGNvbS5jb20vVC8jbWQxYmU5OGUwZWNhZmU0ZjkyZDdi
NjFjMDQ4ZTE1YmNmMjg2Y2JkNTMNCj4+IA0KPj4gLUFqYXkNCj4gDQo+IEkgYWdyZWUgdGhhdCB0
aGlzIGlzIHRoZSBiZXN0IGFwcHJvYWNoLCBiZWNhdXNlIHRoZSB0ZXN0IGhhcyBubyBvdGhlcg0K
PiB3YXkgdG8gdGVzdA0KPiBpZiBleHQ0IHNwZWNpZmljYWxseSBzdXBwb3J0cyBGQU5fRlNfRVJS
T1IuDQo+IA0KPiBDaHVjaywNCj4gDQo+IEkgd29uZGVyIGhvdyB0aG9zZSBwYXRjaGVzIGVuZCB1
cCBpbiA1LjE1LnkgYnV0IG5vdCBpbiA1LjEwLnk/DQoNClRoZSBwcm9jZXNzIHdhcyBieSBoYW5k
LiBJIHRyaWVkIHRvIGNvcHkgdGhlIHNhbWUNCmNvbW1pdCBJRCBzZXQgZnJvbSA1LjE1IHRvIDUu
MTAsIGJ1dCBzb21lIHBhdGNoZXMNCmRpZCBub3QgYXBwbHkgdG8gNS4xMCwgb3IgbWF5IGhhdmUg
YmVlbiBvbWl0dGVkDQp1bmludGVudGlvbmFsbHkuDQoNCg0KPiBBbHNvLCBzaW5jZSB5b3UgYmFj
a3BvcnRlZCAqbW9zdCogb2YgdGhpcyBzZXJpZXM6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIxMTAyNTE5Mjc0Ni42NjQ0NS0xLWtyaXNtYW5AY29sbGFib3JhLmNvbS8NCj4gDQo+
IEkgdGhpbmsgaXQgd291bGQgYmUgd2lzZSB0byBhbHNvIGJhY2twb3J0IHRoZSBzYW1wbGUgY29k
ZSBhbmQgZG9jdW1lbnRhdGlvbg0KPiBwYXRjaGVzIHRvIDUuMTUueSBhbmQgNS4xMC55Lg0KPiAN
Cj4gOWFiZWFlNWQ0NDU4IGRvY3M6IEZpeCBmb3JtYXR0aW5nIG9mIGxpdGVyYWwgc2VjdGlvbnMg
aW4gZmFub3RpZnkgZG9jcw0KPiA4ZmM3MGIzYTE0MmYgc2FtcGxlczogTWFrZSBmcy1tb25pdG9y
IGRlcGVuZCBvbiBsaWJjIGFuZCBoZWFkZXJzDQo+IGMwYmFmOWFjMGIwNSBkb2NzOiBEb2N1bWVu
dCB0aGUgRkFOX0ZTX0VSUk9SIGV2ZW50DQo+IDU0NTEwOTMwODFkYiBzYW1wbGVzOiBBZGQgZnMg
ZXJyb3IgbW9uaXRvcmluZyBleGFtcGxlLg0KPiANCj4gR2FicmllbCwgaWYgOWFiZWFlNWQ0NDU4
IGhhcyBhIEZpeGVzOiB0YWcgaXQgbWF5IGhhdmUgYmVlbiBhdXRvIHNlbGVjZWQNCj4gZm9yIDUu
MTUueSBhZnRlciBjMGJhZjlhYzBiMDUgd2FzIHBpY2tlZCB1cC4uLg0KDQpPciB0aGlzLi4uIEkg
bWlnaHQgbm90IGhhdmUgYmFja3BvcnRlZCB0aG9zZSBhdCBhbGwNCnRvIDUuMTUsIGFuZCB0aGV5
IGdvdCBwdWxsZWQgaW4gYnkgYW5vdGhlciBwcm9jZXNzLg0KDQpJbiBhbnkgZXZlbnQsIGRvIHlv
dSB3YW50IG1lIHRvIGJhY2twb3J0IHRoZXNlIHRvDQo1LjEwLCBvciB3b3VsZCB5b3UgbGlrZSB0
byBkbyBpdCB5b3Vyc2VsZj8NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

