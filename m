Return-Path: <linux-ext4+bounces-3388-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B01C93A414
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6361C22712
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 16:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160B157494;
	Tue, 23 Jul 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a1JCgwm9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nA6nVF5W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F514EC61;
	Tue, 23 Jul 2024 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750411; cv=fail; b=qhG4PSFp/I8G0KLJjW4gRq333G6Hy8aGSievnPnf56uV9zpNY28uuvfLzLUBTf/a8ubXNSK6/ltg40BFqPYDrAX5PopF4X+Uiy9axqNJr3zrpZdh7G3yPBWwZ/MMc/aondYjDBr2/9Oofa3LOIQn6jIqAlXUwGJL08GHzZT+Dko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750411; c=relaxed/simple;
	bh=F+t4BXzeLAFhUO2x2IUZZHh10C4DosBdESLtbo33lME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKzUClZVhu4AAJxb2w1hAngHh+TWQbcKpRyblNrPkf5jeUUp4wlqTEkn1wIMuy4vpV9h/1KYZPKv2nj3Xlwa98poBjd8f91y4Heg9ufPvOKK0+clsccJ66UIivLnQ0PT6p3E38DWMwTr0id4yXlCPvouc7d+j+zcl1gw4ccgU5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a1JCgwm9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nA6nVF5W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NFfWmG023718;
	Tue, 23 Jul 2024 15:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=F+t4BXzeLAFhUO2x2IUZZHh10C4DosBdESLtbo33l
	ME=; b=a1JCgwm9fLOs1rNTAvV/QQlzAOqzn1KGtlp22/Zl97pVmwaOIZtBsAWp8
	xr12kDYGV5/k06foXKOUaFZQT1RyRGgSYZ50M8yQ32F8/3Kn7XsrKK+5WrEG+YOJ
	r69JCL0zzlulnU6qbD9EbONXGX+criGGzIHOhGvmtCU2K11N4of5uvUanf8bjfto
	oWHj73VSLwGswXvBonYwrkTDCzwC9/OwyMK5g38WeUEgqMP6+mTarM0j4xCD03tv
	U9QZC+yWxgKdyeu+l1oe11iTZOcJQq2jWQlhUn9Jb9Gt2God0wbt9+32wmCrR4c8
	YmEMCgo1lwF0O0LdtcbL00Cjh94DA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0eyac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 15:57:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NF4oLc011060;
	Tue, 23 Jul 2024 15:57:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29rcth7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 15:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPegZ3t+RadW0D6E1u9yhp2vtxyfA0gx7UZEC+xcExYHCJmCZq5KHj7MUtHlVcwCtqXwj1H2vAt4TgtU8CHsw5XhvpqLU3JiJaX7fFRsswIxKItFi2RjgCFECrWr6THkK0KSDQ4qrit/zfQloTe1+lXbHeHwMhBAQcfVn9Lki29eCQnx6+C6AqJLxkh5GXeetawYWJY6zWysxyfJ8EoD4LTsAuvxWtbmYO8TmfyKBwU/XJIYZryh7eQXyG8b3DYp81qa3AWkVex+RY05y9S2tg2M8lPBRLK9OCHHQ+OaDgPhOjhY7u1wtOBBTB0Rhm78w/Z7YE6vWrWUFWMioiq/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+t4BXzeLAFhUO2x2IUZZHh10C4DosBdESLtbo33lME=;
 b=YRana1FcD1Am96vLjKP2hDn1o1CmEowCXgZtlzeAx8Fv67WnwVswOfu3IFfN385JiQu7E8JQLlDEnBBjvSKugoC6zJMz8SCsocgvXS3DQjP6J+xhhlmWvvoGajOHbYRrexy3RJHO2ZTob2c8MFR5gAz0r+tneN+uaz6HrIGnIVoeirrrxpcR/U8loGxEKoKUtddUMmSm88bepaW2Uf5e9oPhpfmcWeuZR/+EFQDYRGHT+ipIcHLxPl3JSZckAuhJ9nvOyF8+DMPcOzmVjYI7tvb0gBaasQozB3ol+o17GFty928S4gNKoQSUH4OBmIVeD+uI7q8OKTcs0LqPpYBgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+t4BXzeLAFhUO2x2IUZZHh10C4DosBdESLtbo33lME=;
 b=nA6nVF5Wt4AdqOyJGwQf+1L3cAuJ4gQOjRfpVsF8W8fBlkHNWwCPWGfgPZeBikUCtwqSG46LQszR0P6+3zoQ+hD9Pqmp4fcAYYVUkwbXEskxKVjLk+cSZ/9ijALjbnUnwEtCpisL/1aKzLSxVjRk8vvurwVo8aptKkvg2C0R6r8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7318.namprd10.prod.outlook.com (2603:10b6:8:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 15:57:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 15:57:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
CC: Amir Goldstein <amir73il@gmail.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        "krisman@collabora.com" <krisman@collabora.com>,
        "patches@lists.linux.dev"
	<patches@lists.linux.dev>,
        Sasha Levin <sashal@kernel.org>,
        linux-stable
	<stable@vger.kernel.org>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "alexey.makhalov@broadcom.com" <alexey.makhalov@broadcom.com>,
        "vasavi.sirnapalli@broadcom.com" <vasavi.sirnapalli@broadcom.com>,
        "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
Thread-Topic: [PATCH 5.10 387/770] fanotify: Allow users to request
 FAN_FS_ERROR events
Thread-Index: AQHawX+uwoYrLA2UOkeTCBaoZEb1HLIEGqyAgAAlf4CAAFeyTYAAFzgA
Date: Tue, 23 Jul 2024 15:57:48 +0000
Message-ID: <912A3B93-366C-490D-86BF-02599F3E1A97@oracle.com>
References: <20240618123422.213844892@linuxfoundation.org>
 <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
 <CAOQ4uxgz4Gq2Yg4upLWrOf15FaDuAPppRVsLbYvMxrLbpHJE1g@mail.gmail.com>
 <875xswtbxb.fsf@mailhost.krisman.be>
In-Reply-To: <875xswtbxb.fsf@mailhost.krisman.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7318:EE_
x-ms-office365-filtering-correlation-id: 912605fd-0c61-4351-9b17-08dcab303359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVRDSGJEVlFWb2tjb0pXVnBBS2xCOGlreEtSWlBHMXlBbDdRVGppUXRhOWVO?=
 =?utf-8?B?YWJFTTFzQXcyazBEVHVXUFF2czVvWk1UOGk5S2dvSlZDNVlySk9xemhHbWp3?=
 =?utf-8?B?eUl3UGFCV1FQK1RQT2xlcHR4eTgvbnVaTks1Z2F3bEpMZ3pWRVZNbUh6QitL?=
 =?utf-8?B?RFczKzZuZFd6T1F0UFA2Q3crL0RTYnFUcTMxd1NSTE92QXhrSm9ZZ2R6NkFi?=
 =?utf-8?B?WEd1TWsraXVNcXNYWUdiOEU1ak9aUUR2RTdMdTFjUFZYalZCaXBYUDRXcXc1?=
 =?utf-8?B?Qkk1TVFVM0NCdlRaVVBPeWRacjFqWmozdS9UaC9pN3hhd1Nrd0Q4UWRwdXIy?=
 =?utf-8?B?ejRKZGV0QXBWVkZ0WTB5ZldNbXhGVUo0T3ZaQmIwUm9OTGtFcnZld1ZYb1Nh?=
 =?utf-8?B?WDJRNlJ6WHJhRkpvbWxteG5wczVtTUJWMDdaV2lld1BROGpqZVhjNHVPYm1t?=
 =?utf-8?B?TURXQlphN0xmaU1LTWZvSng1SmxrZkxwZWZKelIzekU2aFhQREVOUTB3TVdZ?=
 =?utf-8?B?WXc3aHFFVDJmTExtNm0zWE1OS1R1MWdMS0pYcEJURmxoREFDMHVtSHNyeFhY?=
 =?utf-8?B?YkRCRk5OVXdRbkgrL3B0MXVMRGNHdmRLZTZzalE5RjVNczdxOFB0aDcrcVVu?=
 =?utf-8?B?RklVQW5sRjhMUXZHM2V2RHNuaGpNbEZROEdsczZBTGJObWtBM2NrbVhPeUVp?=
 =?utf-8?B?eXdVNzhCK1hQaXJvUE92RFhFWG0wWURFd21xUE8vbUVkMEpLOE9ZVHloZHVk?=
 =?utf-8?B?am1aelB2Y3RYbDlEYmE3d0Iyclc1cW1wZDkyeCtQMnJrVW0xci84ZzhqWkYr?=
 =?utf-8?B?TENNSzZzSkIzM2FWYytjUFFzcHRYd3ZxQkdHeDkrQXRLT3owZklQMEdtVkwy?=
 =?utf-8?B?bTgyUFY0VzVoenhNUG9rL2ZKQk1sU204WWxOeFJOd0RkYVAvZHc2VUlRNlAr?=
 =?utf-8?B?bU0wc0Y3WUQ2Sm1SQlNhTFh0UXpoSVhxUW4ydVljZm52b1FxaWFRM2ZqZ05F?=
 =?utf-8?B?aVQ4UnNmcjdROGZRNGdVM3Q1ZkRvUlBZbnM1TWRhTlF5Q3lncloveVFRRlEw?=
 =?utf-8?B?aUZlOTNuREI4K0xaZlo4T2R4M2ZLVDlxeUdld3dyNU41alBQUGZNOXA3UFFT?=
 =?utf-8?B?d0daK20vRUlVWkNUNVNwdnlXcjFPckE0aWFZQjBVZ05vMDhJdVlNczRHK053?=
 =?utf-8?B?cjRBNENvSmpQUFFhd1kwWVhlZlJTdUZGVEN6SElrZ2hvSnB2Y1FxUzluT2N5?=
 =?utf-8?B?Z2MzY3laZXZxb1VBNFJtSmNhRnUwdXN5M1l0bXdTMHNaQnh0Vko0c1VneGpu?=
 =?utf-8?B?ZVdtbDN2Qy9RYU90SUp0ak5CZTc3TDhoSUViZ1hDcjVkUk5ZT05QOEN5NG0w?=
 =?utf-8?B?VEdnckJxd1J2Vkk1bkJVQys4azRqS2M3Q1pBWDZiSmoybkQ2U2ZONFNNdXk4?=
 =?utf-8?B?RTNDaGErNFA1eUJQU0VVOGhXeE9QeXdqaUlMcVpadWdkSzFYckkzVndydjdu?=
 =?utf-8?B?MS9ZVDNwd3ZpVDFaeDBDV0lVWkFPL0lSK0IyY2hVbGNNOTQrc3NlUkRtM0g1?=
 =?utf-8?B?cHZLZG80cGFVcUx2aTJXb3VrT1ZiNFB3akhBNEJkai9XWXMxQlVka1J5ampD?=
 =?utf-8?B?VVFOMjdCYU1NOEcvb1VDVFdCY2ZoNkwzVkVhN1k1VFJzaGNUQ3dVNjJSdlVn?=
 =?utf-8?B?bVFrdTY4TEU5SHNkWEpJRlBBSlNmcjkyK2M5TG1ybDRQQnhXT2hRaVYyNDc3?=
 =?utf-8?B?UUZNUkppUWNRMEdxeGk2UTYveXlxY0NXVkQyZVBOYVo0QkJLRlY2Zkxjc1Vl?=
 =?utf-8?Q?00GAIkKNEv8GYPIJXGolYWfgBn6ph6fNTwWWs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WEgzUW94emdxSTlVMUtjclFwZVZMU0tiNWJjRnpUZXBSTFlnMnNucTcweGV5?=
 =?utf-8?B?UzBaWlhiaWUxeUZ1NExtckVCNG5lOTdGbzIrLzRvNUlIWmZnb051K3lnOGtk?=
 =?utf-8?B?MFBlSmVSL1pmdDZ5RzhKbFJ3TmFLY2RuMEdWSVlLazgrSHY4UCtZaXQ1bUxI?=
 =?utf-8?B?WkVzazlxeFVldUpjTGxwdGcvYi9hTHUzVkhOeUdCOGx1emZaVFNpREdkcDZC?=
 =?utf-8?B?ZnNMV0hPbkVsZ2VwbGdtem0zTkNlT3J2bXFXUk1FVk5Od0dzYjRqYkkrekNt?=
 =?utf-8?B?L0JHVWlZRW13VXdJd1NqSnk5YTNwVlZuN0NQMmhCT1pZamdnWEZkZHF4Kys0?=
 =?utf-8?B?bzY0QXNrSDB6R1ZnOC8vdWZPMGNzdzY0by9UbzhlYXlWR05La3lDekthWHc5?=
 =?utf-8?B?dXZMME9ObG8yc0toVHZwZVU5R3o2L0Q3ZVg3WHRkY0VlQURwTlR1V09xdWV5?=
 =?utf-8?B?cVltbkFIZ3pKK0hieEw0QTBiOW9iTzM2Q3hMNDNHMVNRSkdrSlV0UjAycU1H?=
 =?utf-8?B?MHBmeDF0MUtWZ2RvNk8yQjM3eFAxQkxTMTBrcTNLY25zV1Jld3o5bk1rdms0?=
 =?utf-8?B?VmhCbmJSNW5CbkxjWmdOWXdacFhoRmlTRkQraUZqalYrakY1VlZiOElna3JN?=
 =?utf-8?B?QnhId2ZXSHB4SnIzRjFLRXBrUVZXLzdSck94RnY4NVB4dnQ2QWVvMTVBVFJF?=
 =?utf-8?B?Z0JrQ0JTUDBwenllL21qeTE0b3E5RmFOU3IrRnZnVUJyNjVoU1IwOG9WWUxO?=
 =?utf-8?B?c0Q4eHlaZmZiZ0ZSVFJ3bVlrWDNCc1ZSdlR4T0dTWUUxdEp0ZGtwQkZsR3ZJ?=
 =?utf-8?B?SFgyRTlVTCsxOEJpRm9VbFNPNTZ6T1JZQ3VlRzBabTc0bTNwbG8wYTg0QnQr?=
 =?utf-8?B?YlBKLzdqTHlGZGM4MnM0eDY0eEtuRkhiMC9MQVRiZEVYeG0xUFVHU09zRitp?=
 =?utf-8?B?S2RlNUUxdWZ3Y2tuc1B3aFRTVlVjcFplVlpSRW9LNFFiaHBjS01zaHhvTGlV?=
 =?utf-8?B?UFZidDBHRnlHTU5iNGFLREN0L0c1dlZxOEFhd3NSV01xM1gvdm5zZ21oYzNE?=
 =?utf-8?B?ZHpVdXNJcmNWeHFTTVRPM0FFWXVpWCt3L2NsVGpaMzRzMVBzeTJReGxHNnNN?=
 =?utf-8?B?TFNSM1NvOEM4eHkyQnIwaXY2UVRPY2tzZ1VPRTFrL3E3elJHNDB3WFZ2bmxq?=
 =?utf-8?B?UkJkbW5XL0pqVFA0bjUrY0ZrcC94QVZhNHZscTlTdlM2UE5pWERJSzY2cnR2?=
 =?utf-8?B?bGJXUWlRTVNia1liZmdkNW5oR1NXNlRFdnE1MXVwOFdNdWpTOTE1RzNTbHAr?=
 =?utf-8?B?dmhFZHNpV2REMFdEa2EraXJQeDRxaVlvckUrMFRzUTZXYUlRcCtEeFVvdnF2?=
 =?utf-8?B?TzNLYnk5NWNJRmo3a1RzQWp6QlNLSkJ4Z01nWmFEaWZyQ29jME5jMWJHY0ZW?=
 =?utf-8?B?OTBZbUVTVVkvdmNabm9ZTEt4MGxJYVVLNUcxaEp4ZmpkbllKMjF4ZlpkcnBG?=
 =?utf-8?B?anZ1NElVTXB0YVFFYldNUUcyeS9GY0tIa0dMays4bU03NlRmckQ3M1BvTUtn?=
 =?utf-8?B?YndVVDlacWdUcXQ4Q2dtRmU2M0hGNFlCdHErdDhueTN2Ull2RFZ0THdxSjI5?=
 =?utf-8?B?b21IbVJzSnZXSEc0UHdTUkhMN2w1VXExekZhL0pvVFplOVMwMFlwVkw5aWYw?=
 =?utf-8?B?TkF1ME1Cc2UxdFZWbW9ORjJSa0lsT2YzRjA1TXE3NEN0d29sQmlpTkdyeVZS?=
 =?utf-8?B?NlQzVStJQjQyNDNnc00zbHZTRnc2dlp3SDBOZHh2UzIzcE5oVW43eFVpRU9j?=
 =?utf-8?B?dmx4VXFrR1pzZDdQVnNFVXNSSTZKeU9heWtLcTNHNUNjNVFUMEFMSVpnT2Nh?=
 =?utf-8?B?VWp6T0NvUy9raTVTT3NteEhkWG9lMFh0MzRoS0NJRXVESmgvdmpVOFNQeTFh?=
 =?utf-8?B?L0RjOFI4NndBSTNvMXJoZitiOVJJWWNmWHRERjljcVNrcVBObnNacFpxZzRC?=
 =?utf-8?B?cVA4RnlaYkhpTUpXQS9nUXNCcEc2NFd6aVdBdXdHL1llajlYbE5TZFZkb245?=
 =?utf-8?B?WlFzU0hvMk14Y0NGSy8yMm50SUF4RE1vQVBBd2p0OG9uektSckcxbmhYdmdW?=
 =?utf-8?B?YzlaaGg4cmRQT252S3NBeStPN0ZjWWN0UkFTakpsckFmK2RneWN1aDNhcU5G?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FD1BA31117E5F46B8EBFB4AA607CDAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hqImSCgOthPdjYYgevt+YDnCwLvk285phErrw7Ulj29tI8mgZ4GmHee0L34+D7O5bacey6/g6Ni+nIbOVx+Wn/4iM6iyJ0lLEOMvIQeO9iBnuy8m6yjgZpsetoIYB1BBxHk8NZ8TVyHhuQg+lW8AmkZEizRa7etQ6kJY7TwhD9dHzNExDIE1jtZMfT2VhZHouMIUb7jQ9gvhGR2BmcEQfcymQrA50uvxMKx4dDIeZdXnq2bumV4mINzqCRM/mVEnFTMeXYFbY8W46g2MMAaMhS/XDyjXrKylqQNfC5EikoYHZReviEh2t/XI66byR8/S5xOl60FvwY02QBLEh6TSr7xGL8E9Edxz/xTNh0+AM/PmYe+2XZRHIGA4ajhgi/bxsPmluIwCvBoPQD0ofFdUxlvf97tx8GuEZcWe+ppIXthJB2umb5jdrKyvmDKqpMrj0bAnGu5DjhqYjfE2fmr+bltKI+yCJwG1b9GUPIyhThh7/4yzVwxWlwYFMkFAlM/y7RQnR40MaMytyzFQMWKWulXdBmw7pUmqfvGNOCNEDBhq2UOWREKFAHPgs58wGevUh3k6yUpo0zProZF2r2Nhsk7rW3y4imWRcY6OkKhMVuQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912605fd-0c61-4351-9b17-08dcab303359
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 15:57:48.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdnL4GBna9b9Cdw9o4pYnBf+UYSRIOFfQQB9P+MhUCl2F6VVgKGIi75IUwG1bgLkpkTwRp4udgXSYmYE087HGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_05,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230111
X-Proofpoint-GUID: jpbxnwpIivO572YbqOxx5waddT3VSHgR
X-Proofpoint-ORIG-GUID: jpbxnwpIivO572YbqOxx5waddT3VSHgR

DQoNCj4gT24gSnVsIDIzLCAyMDI0LCBhdCAxMDozNOKAr0FNLCBHYWJyaWVsIEtyaXNtYW4gQmVy
dGF6aSA8Z2FicmllbEBrcmlzbWFuLmJlPiB3cm90ZToNCj4gDQo+IEFtaXIgR29sZHN0ZWluIDxh
bWlyNzNpbEBnbWFpbC5jb20+IHdyaXRlczoNCj4gDQo+PiBPbiBUdWUsIEp1bCAyMywgMjAyNCBh
dCAxMDowNuKAr0FNIEFqYXkgS2FoZXIgPGFqYXkua2FoZXJAYnJvYWRjb20uY29tPiB3cm90ZToN
Cj4+PiBXaXRob3V0IDk3MDliZDU0OGYxMSBpbiB2NS4xMC55IHNraXBzIExUUCBmYW5vdGlmeTIy
IHRlc3QgY2FzZSwgYXM6DQo+Pj4gZmFub3RpZnkyMi5jOjMxMjogVENPTkY6IEZBTl9GU19FUlJP
UiBub3Qgc3VwcG9ydGVkIGluIGtlcm5lbA0KPj4+IA0KPj4+IFdpdGggOTcwOWJkNTQ4ZjExIGlu
IHY1LjEwLjIyMCwgTFRQIGZhbm90aWZ5MjIgaXMgZmFpbGluZyBiZWNhdXNlIG9mDQo+Pj4gdGlt
ZW91dCBhcyBubyBub3RpZmljYXRpb24uIFRvIGZpeCBuZWVkIHRvIG1lcmdlIGZvbGxvd2luZyB0
d28gdXBzdHJlYW0NCj4+PiBjb21taXQgdG8gdjUuMTA6DQo+Pj4gDQo+Pj4gMTI0ZTdjNjFkZWIy
N2Q3NThkZjVlYzA1MjFjMzZjZjA4ZDQxN2Y3YToNCj4+PiAwMDAxLWV4dDRfZml4X2Vycm9yX2Nv
ZGVfc2F2ZWRfb25fc3VwZXJfYmxvY2tfZHVyaW5nX2ZpbGVfc3lzdGVtLnBhdGNoDQo+Pj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzE3MjE3MTcyNDAtODc4Ni0xLWdpdC1zZW5kLWVt
YWlsLWFqYXkua2FoZXJAYnJvYWRjb20uY29tL1QvI21mNzY5MzA0ODc2OTdkOGMxMzgzZWQ1ZDIx
Njc4ZmU1MDRlOGUyMzA1DQo+Pj4gDQo+Pj4gOWEwODliMjFmNzliNDdlZWQyNDBkNGRhN2VhMGQw
NDlkZTdjOWI0ZDoNCj4+PiAwMDAxLWV4dDRfU2VuZF9ub3RpZmljYXRpb25zX29uX2Vycm9yLnBh
dGNoDQo+Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzE3MjE3MTcyNDAt
ODc4Ni0xLWdpdC1zZW5kLWVtYWlsLWFqYXkua2FoZXJAYnJvYWRjb20uY29tL1QvI21kMWJlOThl
MGVjYWZlNGY5MmQ3YjYxYzA0OGUxNWJjZjI4NmNiZDUzDQo+Pj4gDQo+Pj4gLUFqYXkNCj4+IA0K
Pj4gSSBhZ3JlZSB0aGF0IHRoaXMgaXMgdGhlIGJlc3QgYXBwcm9hY2gsIGJlY2F1c2UgdGhlIHRl
c3QgaGFzIG5vIG90aGVyDQo+PiB3YXkgdG8gdGVzdA0KPj4gaWYgZXh0NCBzcGVjaWZpY2FsbHkg
c3VwcG9ydHMgRkFOX0ZTX0VSUk9SLg0KPj4gDQo+PiBDaHVjaywNCj4+IA0KPj4gSSB3b25kZXIg
aG93IHRob3NlIHBhdGNoZXMgZW5kIHVwIGluIDUuMTUueSBidXQgbm90IGluIDUuMTAueT8NCj4g
DQo+IEkgd29uZGVyIHdoeSB0aGlzIHdhcyBiYWNrcG9ydGVkIHRvIHN0YWJsZSBpbiB0aGUgZmly
c3QgcGxhY2UuDQoNCkkgd2FudGVkIHRvIGZpeCB0aGUgbXlyaWFkIHByb2JsZW1zIHdpdGggdGhl
IE5GU0QgZmlsZSBjYWNoZQ0KaW4gdjUuMTAueSBhbmQgdjUuMTUueS4gVGhlc2UgcHJvYmxlbXMg
d2VyZSBhZGRyZXNzZWQgYnkgYQ0KbG9uZyBsaXN0IG9mIGNoYW5nZXMgZnJvbSB2NS4xOSB0byB2
Ni4zLiBJIHdhcyB0b2xkIHRoYXQgaXQNCndhcyBwcmVmZXJyZWQgdGhhdCBJIGRvIGEgZnVsbCBi
YWNrcG9ydCBvZiBhbGwgTkZTRCBjb21taXRzDQpmcm9tIHY2LjMgdG8gdGhlIG9sZGVyIGtlcm5l
bHMuDQoNClRoZSBmYW5vdGlmeSBwYXRjaGVzIHdlcmUgZGVwZW5kZW5jaWVzLg0KDQoNCj4gSSBn
ZXQNCj4gdGhlcmUgaXMgYSBsb3Qgb2YgcmVmYWN0b3JpbmcgaW4gdGhpcyBzZXJpZXMsIHdoaWNo
IG1pZ2h0IGJlIHVzZWZ1bCB3aGVuDQo+IGJhY2twb3J0aW5nIGZ1cnRoZXIgZml4ZXMuIGJ1dCA5
NzA5YmQ1NDhmMTEganVzdCBlbmFibGVkIGEgbmV3IGZlYXR1cmUgLQ0KPiB3aGljaCBzZWVtcyBh
Z2FpbnN0IHN0YWJsZSBydWxlcy4gIENvbnNpZGVyaW5nIHRoYXQgImFueXRoaW5nIGlzIGEgQ1ZF
IiwNCj4gd2UgcmVhbGx5IG5lZWQgdG8gYmUgY2F1dGlvdXMgYWJvdXQgdGhpcyBraW5kIG9mIHN0
dWZmIGluIHN0YWJsZQ0KPiBrZXJuZWxzLg0KDQpUaGVzZSBwYXRjaGVzIHdlcmUgcG9zdGVkIGZv
ciByZXZpZXcgYmVmb3JlIHRoZXkgd2VyZQ0KaW5jbHVkZWQuIEFtaXIgbm90ZWQgdGhlcmUgd2Vy
ZSBzb21lIGNoYW5nZXMgdG8gZmFub3RpZnkNCnRoYXQgd291bGQgcmVxdWlyZSBtYW4gcGFnZSB1
cGRhdGVzIGFuZCBzb21lIG1vZGlmaWNhdGlvbnMNCnRvIGx0cCwgYnV0IHRoZXJlIHdlcmUgbm8g
b3RoZXIgY29tbWVudHMuDQoNCg0KPiBJcyBpdCBwb3NzaWJsZSB0byBkcm9wIDk3MDliZDU0OGYx
MSBmcm9tIHN0YWJsZSBpbnN0ZWFkPw0KDQpJJ3ZlIGF0dGVtcHRlZCBhIHJldmVydC4gSXQncyBu
b3QgY2xlYW4sIGJ1dCBzZWVtcyB0byBiZQ0KZml4YWJsZSBieSBoYW5kLg0KDQpJIGNhbiBydW4g
c29tZSB0ZXN0cyB0byBzZWUgaWYgdGhhdCBicmVha3MgTkZTRC4NCg0KDQo+PiBHYWJyaWVsLCBp
ZiA5YWJlYWU1ZDQ0NTggaGFzIGEgRml4ZXM6IHRhZyBpdCBtYXkgaGF2ZSBiZWVuIGF1dG8gc2Vs
ZWNlZA0KPj4gZm9yIDUuMTUueSBhZnRlciBjMGJhZjlhYzBiMDUgd2FzIHBpY2tlZCB1cC4uLg0K
PiANCj4gcmlnaHQuICBJdCB3b3VsZCBiZSByZWFsbHkgY29vbCBpZiB3ZSBoYWQgYSB3YXkgdG8g
YXBwZW5kIHRoaXMNCj4gaW5mb3JtYXRpb24gYWZ0ZXIgdGhlIGZhY3QuICBIb3cgd291bGQgcGVv
cGxlIGZlZWwgYWJvdXQgdXNpbmcNCj4gZ2l0LW5vdGVzIGluIHRoZSBrZXJuZWwgdHJlZSB0byBz
dXBwb3J0IHRoYXQ/DQo+IA0KPiAtLSANCj4gR2FicmllbCBLcmlzbWFuIEJlcnRhemkNCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K

