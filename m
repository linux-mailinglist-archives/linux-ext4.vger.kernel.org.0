Return-Path: <linux-ext4+bounces-11330-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CB2C192F5
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 648B3356601
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605631D748;
	Wed, 29 Oct 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XfGL06hj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rY+D27+r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142331A059;
	Wed, 29 Oct 2025 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727820; cv=fail; b=Q/kuYnI3HbDHyVitd/L7ff+6U0pzVeEuyIxqTP4VnJ5dvDg1Kffl47nU4bI3Nqld4YM5A+XhpNbDSBIhL8Vd8YAeVydIrkwVOqcZBSw57P3+UPcak6dP7fzeGz+/9g8YPMWfo6yNrwLe6tya2Vx6cuHmhe0ua5dDDa5rhV1E8A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727820; c=relaxed/simple;
	bh=Wv8dAFSONk42XjlQq7vMcG1TJH8C35KxeOUepoPaoTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GMAhqZQb5ig/XKI2LHK5uS3NKyd44mseG9FS2Jf4IwuTdcA68FsiszUa/4lQDg9C4DWVJilysYKzri6XSIv5nOBUQrDituk4nNDB3JHT+6Vn9LR26n8ZMTVQxbGvPZ1aTQibtXkLKxFabkIUvFho6igxNRJ8zOwHkoMJGEoxws8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XfGL06hj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rY+D27+r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59T7gFFr017026;
	Wed, 29 Oct 2025 08:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=v5kuehRlkOBMx8+2i91gHMuf9swVNEfa2KSftg+jFEw=; b=
	XfGL06hjwiEZ7TfUAMLXUyzUymTsLCNp6jE6L7nejo85Gzja/w8cGuaC8kAVnEXP
	Sbh+vEsuOPWm9vHNfxQE0oANr4FAS/RxxOka5KYLl2YMpGgajREoAzEdnW/Eg0ML
	0Ua5KRiwIurOQPSRX8mAI8by/sN5RfFvWNa2G4nUQ6tzS9ZE7gTJ9D6gUdUtEGci
	Efgnbbgm20e11LDHPsZFO8XKn2PMmyBDgj4I/QHW0L8mY8uNrzAxNnpBbzxGzqeZ
	/ppK5goIbJ6K05AH23QG1ptaQ6/qSrqQ3CaDOUes5ylHhLXDZZ+e2S6YsG86e/wP
	4lU1eaECZivqCotfZPRqrQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a3c3b0c4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:49:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T8Dokb021207;
	Wed, 29 Oct 2025 08:49:46 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a359tk4x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIpmBGGAD4mGOISEalumLDAiBVM0mXcIdiNVBOya/3OjfYlvkghznS7MraBnxAgMP7Zp7oj4kr9B2WvQ3myThB8MUq9T/v+PiWWuzo/5quF9NjttY/sYticBDwN9j1Ktu58ZPGMd52WicWo6CRBRr5MayaLhlX0z7tnENa0hOYp4sjsGRjc8TwyEoCVtEA+TcErAWVTFu45H8+jblHveYeKMDtb+YXDeiapW3r8MqZnGjDWcEjPnG8aGQQqMlf4KHUIVJFZBvzMhNgP/iOYvdj2CdxxD9ksEBhIAtU8j4RBxP8aSh47r7fRqwsFRMjEX7eydggxNyRo2s/Qna+6E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5kuehRlkOBMx8+2i91gHMuf9swVNEfa2KSftg+jFEw=;
 b=uvs7ThpmU3AglhS/i+3S0SeMT78TluAH9glKczhAnOgwSzE4VBQspJpdvgxUiYXUqIJLb7W4FcNblujmsQLLNWqHIKNY+UvzDCtpM7d5SFJpXqtGyARJYlPYIxCn4tcSX/XtVQ1qtg86SJ5xhnOcbKRP8qd88OhxO7rRx+803y0Nuo9WA5FuXWcIhu8FgtzNrEhY2e7Y2RdtZgMlPw+8oWHLeVcXjCjkH2fdRxMHYTmCwyQ1Xuj1KB9lbbhWlFYbpqTGPyd3tpvi8fQt4p+/SjloUMHgbnj3FGmZCRL0Zp3alNDot4m8P5CVVJMc76w/XI6Xv52W264ctIUCkvNNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5kuehRlkOBMx8+2i91gHMuf9swVNEfa2KSftg+jFEw=;
 b=rY+D27+rVRrXWK6Owzzdk+LCdFmhuPB0cBIiI+MXML8xOKLGDcz3m0Xp5/m5U/dazKLzDQHP8tdEXXslLhA4ZTT0KtFMNrZdifvAHBzPHnHcuOkx5jyLCg6gCTVyboKoaeayHCa8BJPkdx+85bsQih3SeeraFbhop/Ap46JC9Rg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM4PR10MB6742.namprd10.prod.outlook.com (2603:10b6:8:10e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:49:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 08:49:42 +0000
Date: Wed, 29 Oct 2025 17:49:30 +0900
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
Message-ID: <aQHVB_8NVMZ2cuvh@hyeyoo>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
 <20251027122847.320924-4-harry.yoo@oracle.com>
 <CAJuCfpE9PRvd1Tsm6gAvxKvPFgVt640q3vSbt0wAWOa3G4tnfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE9PRvd1Tsm6gAvxKvPFgVt640q3vSbt0wAWOa3G4tnfA@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0085.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM4PR10MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cca6f4a-5871-4c2c-5dc6-08de16c819e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDlHYmE2eElGM2dhdmlXUXdvNTd5MU1xSEoyNkdFeHo2bmpHdlN1VXBMQVN2?=
 =?utf-8?B?alBvcElCYnhNVkV3dkNzWVdtaDZqb2MxRGNQYzZteFRoYzIrL282c1luamRW?=
 =?utf-8?B?cXNRcDYwcEh0T1ZiSld6eFBGbVdzQVROU1dtQTBHa1FXaUdYa2d2blFONVda?=
 =?utf-8?B?TWpoNGIyenlNRVJnYWZ1S1BUUGt5OVhjaTNSbmRUL1ZmTDZlQTlFc0RtZFoz?=
 =?utf-8?B?TTVoZGEzSGVpUGowaVg4amV6Rnh0WjJHN3UxTURsZkpQNnNGQXg2VEM1Wkk2?=
 =?utf-8?B?b25xOFNRT2hnUFdJOS9yYWlzZlRVR1BvSGFENzRPK1RrSmQ2N1lpL0JEUWpx?=
 =?utf-8?B?R2VXcXI0M2U2M1FwWXFwaEprSVBZUE85SEJzTVZicWQ1RDhNM3VCZENlTnlK?=
 =?utf-8?B?dEtLYjVYd0dkOXlvNjlsbFNwVysvRmRkbDFrYmtUaUxUa1FRTEI2R3FhN3Y2?=
 =?utf-8?B?RG9oQ2tmeDU4eDl1WHR5cVFpQUNOTzBKM2UvR0JMZlZBTGg4bnc2NXB3TlFq?=
 =?utf-8?B?YUlxTHdHOEZuWHp4YmZIOWNOeXIyMkFsZHhrOW9IYWRIck42RlEzRjU0cWha?=
 =?utf-8?B?cTZFKzBlMkVmWWd6QmowNDJ4bDZiblRDZThhZHgvYm0vOTN2WmRESHc3dS9Y?=
 =?utf-8?B?K2QxR2tIT0Z6THhlV2ducmpFRklOZnJJTldScm1iSXNjME4wbDVucnFOMUow?=
 =?utf-8?B?NTN0dkdJdDNhZEtudnBhSFRCWmhKa2JnR1dYY0pJMy9ONlk2di9XN09MQ2dM?=
 =?utf-8?B?MGtCMURRbU56ajQycmwyUFYxSDRCNDhoODhSZEdCVTJaQVFxQ09pSHgvc0VD?=
 =?utf-8?B?TGVoS1lvRXdUZ0pNYWFqdWJncUZCZzJQY0ZWRHVHZXRXNTlQYkxid2xpNy9h?=
 =?utf-8?B?VGRYZzMyMElIdHBuSGVCc1BvZFU0WFBISkRzRUFaZUVyTmhvVWJQdCswdHIw?=
 =?utf-8?B?VmxiNkFXUnkzUEFVNW5ndG1uSzJxUWNhR3BaZmZPeUdqR2s4QTlwUWFXZnVi?=
 =?utf-8?B?TE5rZDFOdTR3QnJaQXQ3d1lCdjNDMnBuVW55RC9HTHpxQS9VNi9WcmFKU3E1?=
 =?utf-8?B?TEpJRTR3ckZRMjdlaFc0S3VkQk94dDcvL1ZjTmZqNzhtY2VFbndFdHJaNzk4?=
 =?utf-8?B?aHhrU29xMVBQYVR2VG0rRTZxMkkyOWgrc0Y3dFhkaVRYR043MVlTTjh1RVQz?=
 =?utf-8?B?NmN1dFBBcGxSSTF5andjeGNKZUl5RjRrTlQwRXlNQjlxaXRHR0k2RldWSXND?=
 =?utf-8?B?WTg1bTBQN2xTbUZHdTgrU2VJRDcrQUx1OUg0YjF2SE5RbTZQa3FnMjhhTWpy?=
 =?utf-8?B?ZVhmRUxLK3p1YVU5MWxlaWEvcjlOU0lDRlBORVE0TWxvY285Q3V1YTNsYldR?=
 =?utf-8?B?V1IrVDd3cElPVnYvdXFQSG5ncjdVa0VEdHJPUlJNZEdIV1pYRW9xL0RZcmg0?=
 =?utf-8?B?OGkvWHNsWFI0S1ptdnkxZktiZGlCZGJFbGxSMnpFY1hlNTlBSUt1cmd4MW1Z?=
 =?utf-8?B?NDNZaHRoSGI1Tkg2VDhWSjFFQXl5VklLU20rNWoyWW9Ed3ByTTNoNUgzRmF1?=
 =?utf-8?B?aEtFT05sbVR3Q2FoWVArOFo2bXJMRlY3VjFmMWQ1Y3BDOWJvYkh4Q3RPeUVM?=
 =?utf-8?B?cWIwckR6bDJiaXZBbEJKVmtJOXgySVRvWElyRW0veXJNd1U1cEwvVkJhWjFq?=
 =?utf-8?B?d29SaFBhcVE3Z1RhSzF2VTdWVlhnTHlra3VSTFQ5Y012bXc3RWlyb1Jybk91?=
 =?utf-8?B?cU9qNm9TaUhTWHNsblVFVVBMTkVkKytxazk1K3hqdkVCQjZPTUh4VHdScTZz?=
 =?utf-8?B?SkJCL29LbERzVmpjOE1PN0pDUnNmcEwwdUUwSnhvZis5NnhxV1ljQTBwN3M3?=
 =?utf-8?B?SzJidXBMSlVuRzVOQVhvWVpoUkZOM3h0VkVIbllHa1FJUUpvOUxxOEZLQWxh?=
 =?utf-8?Q?xPQFfD/JQn8cjpAsnJtLVja+tfglyqN3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVU5ZzNScHQ3KzJjemRIY2JleEljNnlGSjFCY0RzZXBnallGUGg5SGhLMG5a?=
 =?utf-8?B?RVFRME5zaXhkWUY4TXdvWWRkVDhTTXJwWVB0YXdYZFdZYkJoemFuWXBtdmhC?=
 =?utf-8?B?Z1NTOFk0dHphS2Y4aWxYeFBidHh5aVlZQi9JWlorWm5ieE9PbWJPZkluTWxK?=
 =?utf-8?B?bUwzVFhVbTdMdDZzTlVvcllrMGJtVStBSTNnMzRvdlJJZ2VTUUZrZHpzMHo2?=
 =?utf-8?B?dVFUUVlaZTVKVkNYMVBjYUtzcXZwbGtMTFBkZVQ2T0VCL1ZCeWk2MjErSXpp?=
 =?utf-8?B?cUdqdFZnUVpjUC95YTVnK3E4b3JrUmlFeEJDZXBRS1JIWjZzMlFyMDFxV1FD?=
 =?utf-8?B?cVd4eHI4UmJpNlJob0pyRXFHUDEyczJCNnU0cnJuUEIrV1haUzFoakZwRElz?=
 =?utf-8?B?amQxWXBjeE1UK2Vhc2ZnOGFzRHd4N1NUazQzNnRnSVhrMHlOQTNQMjlPYVJ1?=
 =?utf-8?B?UWpCSE9PWE9SdXFSYlQ2T2NYaXRTZGtvOXM0bEhTMC9EZ3lRdzlTWU1MeGVM?=
 =?utf-8?B?RnVZZjJZcEdaN0dLTUdCS21QZ2dubUNUSkFiZGFmaS93NWJEbDhia3VnbXRN?=
 =?utf-8?B?QTlnbEt6RW1CQVRZbjd5dmY5MURRTmVIVnNsNDI4WkpWOFJhTTZoRGdtMGZp?=
 =?utf-8?B?dDVuSEFVektKT2E0TEI5Q1dMU2JlZUR6MHBPV0JUQnhlMXk2dS90Q0VaUTFP?=
 =?utf-8?B?Ylk0KzYvTUlmcFIvcm9Ic3VrTDJTY0JOZkkvQW8rb1B0OWcxcjcwNlNseTJ0?=
 =?utf-8?B?YnFtZDJGdVhPa0k2NEJocG9nckR0U1ZYQVpqZ1g4R1N5T05rOXJNb0FUTHN4?=
 =?utf-8?B?dzFNV1orRjdGVHRDZ2VwRmhiWWdHY3daRmRMQVcvdEUyc0ZQSGlnYld0TjVa?=
 =?utf-8?B?Z3pLQVE3eGZJVDdnK2Y4MVNpS3JVVGRHN1NTSW1ucTZ2L2l0U0l4VlZGSDZW?=
 =?utf-8?B?ZkQ5bUVneXUxT2tWWlBSd1lNRS9BUkdPV1M3ekc3RDN2bkc4RG0wZC9FMDhV?=
 =?utf-8?B?dm1icW5WTnBLM1k5YXRrK2pPNFFlMVFFTE84a3NHOVBTUC8vUHhiamtvamlV?=
 =?utf-8?B?ZEVBbFdJa25BazVrdUlzUkswMTlIcDI3VHhlL0l0YnE3SWNaTGdXVk5wSmt0?=
 =?utf-8?B?NkFVYVhrNGdGYlAxYUFMMGVNYkRlWmxhbk80YkUwMk1KVW9qaVFHd2s1WUMz?=
 =?utf-8?B?TGduam16WXBqRDZtVXVzOWFjZjNxVEUwNEwwamFPeXlmTlQ5WDNiSnJVZC9i?=
 =?utf-8?B?VDA4cG5BeFpNQ2ViYzRmWS9hOFVjaWN5ZHJMR09UTTlINHVJMlVaOVl4UlVG?=
 =?utf-8?B?NmZXaVdCYUV2ejVUTmR1ckNYZ0pIRStqeEhJQVUwUVN1OE53QWp0bEdtTGNz?=
 =?utf-8?B?ZEF4OFNUZXVZakpzT2tPNUEyb1lONEdQSy9hVXV1Q0FrSUo0RFRtN0tiNjRy?=
 =?utf-8?B?eHVvajh1MlZ2ZVpXZ0VoK0NKV1dFQVJoSzFPaEJFNFFjVEp2bGZtU1hraTdT?=
 =?utf-8?B?cnovYm9GRHNxaVRiV29IM2JyNm1zMFdFUEQrQytubjQ4L0NrT0wwR3ErY2FD?=
 =?utf-8?B?b3JkSlZhMEpJQ0pYYTRRVkx4WkpseXE0VllnV1dwdTBidHUxc3ZYa2FOTnFv?=
 =?utf-8?B?ZUVTQVU1SFlTdFcxOUVmMzEzQTlaTk1CS0NWMG9lRTZVUEc5alVPY2NIckQ3?=
 =?utf-8?B?MW8xN0dxR2Y3RlZPK1pVOXFaODdXUHNaL2NBb2MyelU2czdlcHhOZ3NrdHpI?=
 =?utf-8?B?TnJuR1l1THFwM0pCWUNRY0xIaU1zKzJXTjhzMzdUa1hRMVMzNHlRRjJDQ2VJ?=
 =?utf-8?B?emNiZ2dNakhuTEFRMzB5YjR6TXV3Rzl5Ujlzdk9yMVF6azVINEtCUXI0SmRN?=
 =?utf-8?B?ekFmcGlIYVFZMWZzNU1JbjRuMnRxMUpPdTRETTlWR3g0RnlNeWpjcWcwWG5P?=
 =?utf-8?B?bXU4N090SG5JeUd1YXhuK2ovWE8yUC83VzNxdWkvRDZnY1Yvdm1zRUNqVy8r?=
 =?utf-8?B?dUdya3NBQ0YwRGxnUmZma21RWUtWMUdiN0RYd1Y4bVhVcUxjUWpOdlR2Vlhj?=
 =?utf-8?B?dmZQak5aL3ZMQUc2QkdxNE9VRnJJZW1LdENoL3lhT2RJb0draUFQK1JwaWpo?=
 =?utf-8?Q?/2No8Z73FibvJLjtgfvPSUpAf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FRaXoQy0ajK22QEEgyQQuGwtmNlyCoQOLfAbFlTFWJwNtaJgcoKKu2BMM7ErB0LNrOsfAq5Sn73Kz+VVLj+61QURXsbjpFwW04MXVn+U8k9Cva5m/jVTU+/8nh+GA4x8NpsXVtTkQJ4BUAanGfCepaS1UCa2e4KSU9TALBuEhv5FeWRT4KGKxicCbO6Idcoq0fnKttqUL/uNRFGqcz8Rn9rR5bIrFtXISYIFf26rJO507Chu2hTE70Xhf/halZ5PeOklIh6F/egMqU3ymHVFzJYOIJXGdRdSIpk9hbcRA4+DrfSdfTPq94JDFy6kf3UjBC/Va/2Why2is0Xr5fGBq2XgUysUbf8jYnK2pfGrSPgb7ebcnXXqevcZUEbJpFHLS2zCzO83xXZzAw+R3HVGGJWh5bfQqya0t3lUkRIGDAf+fUPnDiI04yiW7B99a1N6NeEzLWZj0N6zP5xg+ct1Fr2asYibmbXbQnCBxsEsTsn3O/ReGssgygV0Achr/9uOkRXQP0Plhzs2AE8tEAYZVKXzthOM1QI53QxF2Be+7ehLSDcu5ddz62ZRs/xNc5UglNHSKubaSSOtqIAFdDggHVE+ATMvm+FyAggxUNZMsHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cca6f4a-5871-4c2c-5dc6-08de16c819e8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:49:42.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMfMrZi/9FB/A3iNrant880QZeVUDsDNMlqt26jtHUyCaWTU6NxIMy29r8Sx7597eZPCwIIq2mw8LaAklZPdrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2510290065
X-Proofpoint-GUID: shmj9FqF4hHDjACD7UWZ9yy-J3JZJAWx
X-Proofpoint-ORIG-GUID: shmj9FqF4hHDjACD7UWZ9yy-J3JZJAWx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDAzNCBTYWx0ZWRfX9s7R665XAYi9
 qM5Cqcign0UdnT+aIDjRYVP9zo+N/S+5yMf/UzXN6vwpZWPb3o31w+tt1IjBncY3a6vp4Ml4JFR
 eUbO0+n2/K+olasxt34wQjzHsZjGf3n4+71MqeheUh+d4wbvZjqR3hHEI7wBQ/vcjQw3Je8FUZB
 W1bCyZMWNavcaQWFI1iDK0qCeVy4BLBNV2pKDfrrz4zQOGtGbfeu6br6mhjkRodTDAGgZ4DOXJH
 FORzFGiLMswrNGnyKGph4Df0lw45jL2039LSVkO3GCtzBrqeUKGkwE/Z/NrE6j+EgrWKKmbGwB/
 2FRUsGYNXySLUh/sMDgULIrnoxATaD17ylmsFee3hCPQp6+jFUIY6tlUNlMoJRrs860AkpTm8Rw
 TINEzMWZ4GqzciyLUZPoCAdQ8hIaiSR+dmByzqo1Ipx48mfjWwA=
X-Authority-Analysis: v=2.4 cv=S4LUAYsP c=1 sm=1 tr=0 ts=6901d52a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=7umB1LHiOwhAnYfhuKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12123

On Tue, Oct 28, 2025 at 10:55:39AM -0700, Suren Baghdasaryan wrote:
> On Mon, Oct 27, 2025 at 5:29 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > Currently, the slab allocator assumes that slab->obj_exts is a pointer
> > to an array of struct slabobj_ext objects. However, to support storage
> > methods where struct slabobj_ext is embedded within objects, the slab
> > allocator should not make this assumption. Instead of directly
> > dereferencing the slabobj_exts array, abstract access to
> > struct slabobj_ext via helper functions.
> >
> > Introduce a new API slabobj_ext metadata access:
> >
> >   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
> >   struct slabobj_ext element at the given index.
> >
> > Directly dereferencing the return value of slab_obj_exts() is no longer
> > allowed. Instead, slab_obj_ext() must always be used to access
> > individual struct slabobj_ext objects.
> 
> If direct access to the vector is not allowed, it would be better to
> eliminate slab_obj_exts() function completely and use the new
> slab_obj_ext() instead. I think that's possible. We might need an
> additional `bool is_slab_obj_exts()` helper for an early check before
> we calculate the object index but that's quite easy.

Good point, but that way we cannot avoid reading slab->obj_exts
multiple times when we access slabobj_ext of multiple objects
as it's accessed via READ_ONCE().

-- 
Cheers,
Harry / Hyeonggon

