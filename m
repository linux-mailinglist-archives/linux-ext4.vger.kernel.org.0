Return-Path: <linux-ext4+bounces-11077-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E09C08A68
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 05:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FC71CC6D7E
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B87A258CD9;
	Sat, 25 Oct 2025 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qBbTRnDm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pWWyq7sB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18D1F1306
	for <linux-ext4@vger.kernel.org>; Sat, 25 Oct 2025 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761363234; cv=fail; b=XRO53YR/bQ99nCGQlmZxitpThMIL4/XsfpLBdLeyFn408t2qKCRCg95eAzVsy6HN5BCU7GiHHNoQFyBMhvgIRJo+xcGsRG7ouTKNwwvZReQ5tXfr2aE8PgJwzLFQEZ6+i9UQYIyOMFFzY6LD3RTpAmyKxDC2PchsnnxQwd7DvlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761363234; c=relaxed/simple;
	bh=liqCxRELwVcGHWDNJR+FURd3iNx+NwSEmaIGmpdSQvY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6YA1xeeQI4giffB7i0bpPme8/9LZACFaVoQ7P5Gv2bZ0LrPQ1gdVRtm3eX7fufAO4tLKg7+i79hpVP20umdmuuPu/RDhKah/GzHmaguZszZF0YPqiLzyrGHercxJiqCs2CancO5kdlSWeCXD9ZIQSATqEHhMrJ73HsbSWcqCKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qBbTRnDm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pWWyq7sB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59P3TX1X023884;
	Sat, 25 Oct 2025 03:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=liqCxRELwVcGHWDNJR+FURd3iNx+NwSEmaIGmpdSQvY=; b=
	qBbTRnDmsXIJx+OrY/IkSHPeM2ogv2Z7CXo94Ws3vPwmNJgGw0+0sXL3AN3hs0hN
	wmOfTTkb9RqtnopoJdNzkwzhsgE2JcijdqNMSJ5JJXpL5tgq8z4KB9UQvYP5zTjT
	oxoe97Yv3K/sA1zRVK6GydJ+yBEUbkoj2QY62yXDD4YDH76TDQdMdjpToeeJ3qIJ
	Z/puHY8HU1Q8IAWdEemdLMJBSB7nUeKXG9xYAKtH/F/G6SM4mNAeO9+pFwBQfn/f
	aEfyK0G/wVerDcsBL6utu6wYTWfMa8ByW73AvvFxDkltv5X8NCD/Jh4L0OncnqTC
	JJuAWANF9VzX9+4QT/E/tg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0p5sr0qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Oct 2025 03:33:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59P1XhFS015068;
	Sat, 25 Oct 2025 03:33:31 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n05212q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Oct 2025 03:33:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXW2LanF0w5fZc8Yld8g4YibMN5xs8o4faLtg1s8/eOI275zETIOcVSwn6LHfMJn8h3BTNFtngenuEmW5dX/gQXZjeXQhjvFP/bh4C3zYZcEiRikCpQ9gIk1NKDRRCuki3QOki7HNuKrReOgnLmug3uKD42ijh7AouVV1B0B3frPcgYvhD583lM3YH+/Iwt7XGI5SX9Cfunrnigp3NDWxgWyU458xfMGywivhi3M5sPeCCBvtUMJRb/gjBxJxaUFJlQqprWymBcMRrfZheZzXKg8HA7lnMQfEtjjwk3UIV88WeKQ8xFfzgRDJ1l4UnxvpYJ9u9zzyBrjze2uGLOUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liqCxRELwVcGHWDNJR+FURd3iNx+NwSEmaIGmpdSQvY=;
 b=JfwRYZgsihCRFsHlKH7QygLvQXUdMHQ8uCN6xhaj4bS3m3W5rqjBKW/i4Zc+dv2KF+G2uGOfAvmuf2LVzKmiVjf0iawDehZMr49D0SbXGbIfB3Gd0gc/89z0b40x+9Qv0C0jDTOIgA9bnXC8V5IRn5DimQI1UCSqY9krlG2rPs2ElGb0E2knjqksJyJC4AgbytA5BNb/NL12MGOCGdnN572wYQU9u5t1tYNW+bMHkcsVGh8Ftsz8/wSuLlQaFpSf3KiUX4nO3r4F5HMUTiewNiaWPMkynXcgy0YW9TW2EcaniW+63S1uVETTzQuYtx+jm3v3s+bFeTo7XARPkzgl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liqCxRELwVcGHWDNJR+FURd3iNx+NwSEmaIGmpdSQvY=;
 b=pWWyq7sBu8hdl/4tHRqBUOHcdyDKDsc3qh14BVfOv15iekEhDhpH6lqAUaRCRF//77+HBr4HACIuh2+iysZl1dakvBteJxzG8p/Egiz+BrrLOYFdAJ6r5Mx6bmKu8UgMNKQMhWL4taSRzr4SEwirUHzCVxLn+5UI+2Tf0sEJEK0=
Received: from PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 03:33:28 +0000
Received: from PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27]) by PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27%5]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 03:33:28 +0000
From: Wengang Wang <wen.gang.wang@oracle.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu"
	<tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] jbd2: store more accurate errno in superblock when
 possible
Thread-Topic: [PATCH] jbd2: store more accurate errno in superblock when
 possible
Thread-Index: AQHcRR1dDvnZBQ/2wEOT8I9byAkR07TSHQ2AgAAY7IA=
Date: Sat, 25 Oct 2025 03:33:28 +0000
Message-ID: <F3159D0F-9DB8-4121-A9E0-51764C352BC3@oracle.com>
References: <20251024193532.45525-1-wen.gang.wang@oracle.com>
 <9c0b71f1-0cb3-4777-a9d7-dc9510fbb760@huaweicloud.com>
In-Reply-To: <9c0b71f1-0cb3-4777-a9d7-dc9510fbb760@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.100.1.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5795:EE_|CY8PR10MB6468:EE_
x-ms-office365-filtering-correlation-id: 9b50adf9-cf47-43ad-816a-08de13774334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXFxM0N3NWZZNTcrWEJhU3hVSGVsTHdyUDhmZ0llU25mdlN3SFZjOTk4ZmJl?=
 =?utf-8?B?NEg4L1J5S2kxdWJjQktBa1NEZHFZcWFyRlYvdmJ0SDlLMjVHRWdDV1Rnbmsw?=
 =?utf-8?B?aG5yMmVNMHJuNDdyRUJyQWlQUHVoRTd2R21tbUhqbW45N0xhaVUrMVI3dDd1?=
 =?utf-8?B?ZEo5aDJvSWxDOVh2ODNvUmkvcHN3czg5Vk43aUZHVmVhZHJSNnBPOTVQaStm?=
 =?utf-8?B?bU85d0M4UmFueVhLdk9YWUdFRnQxM0NwcXc3dWY1UXZJNEdLczRLaTVIRzhO?=
 =?utf-8?B?cWJubnpzcndkVUNoL3hCcnlXbW1MVW13MUJkV2tDY3RzQm1UajkzUElNclFw?=
 =?utf-8?B?aFF1UXBaNk15N05sN1c4cVZiMlJ1dWszVGlXMHBwVGdHWG1RUExtQlRyOTBJ?=
 =?utf-8?B?ZkJrNlpNdEcyaStYcWt0YlpxejZ6VFF5WHdhUGluYzkra0k4RUVIcUZocU10?=
 =?utf-8?B?aFo0Rm15eU1rd1BkYW5VQkpVVXpzR0E3VTdkYlpFT2lhSkQxOXRzV3NGN0JR?=
 =?utf-8?B?UDhTdmVwcytmbVoxb2hWM0FJVU5yWFoxZVJrVjJBczJjT0NOZHc0L1RwdmJl?=
 =?utf-8?B?Z0cvZWdqZHFWNERwYjFxWElBVjM1eG1XSDkyNUJRN0VpYTg3SC96NXdiT1R0?=
 =?utf-8?B?MU1rQmZOcG9HdXhTSzdpUXZiNWIxMldndllBL3dNWlRQczhKZDBjd1p3aC9S?=
 =?utf-8?B?ZisxSDdyWkJjQ2RQcDdGUjNmNEIzcGlJelBVRm1nWXJhM0I2eDZ2QXZVSW9I?=
 =?utf-8?B?bklZVTRzeTJtR0FEalgvbTRXWVNDSHEyWFQ5MXp3UGdrb3pvVmpMQjMwaDJz?=
 =?utf-8?B?WVBlSVB3VHZ5ajZsVThaYTROaUhySUJPWS9RVXVxQ3Y1UjFFZVpRdzFUQ1Vl?=
 =?utf-8?B?SGZvMU9uVmpaZ1dTMlhQNDJyQXcweUh1UXQ3N0NDLzkrMVpYcmpaY2UrWVVv?=
 =?utf-8?B?bFVsdXRwbzBzSkR6b21oWU9RVUcycVlHRUpoOWtXK2VLSDUyMTJ2eHZJdkVB?=
 =?utf-8?B?NUUyR3JPbEZZTHN5Z0d3QThabmxteXNmMkV4YXIvbnVuc3QyQlB0TXUvUFpM?=
 =?utf-8?B?dVk4bVBFVVc2QnZiNzdkWk5PcmZQcTdENVVaSy9ldjNaSHhxeDVjcmZsMGJR?=
 =?utf-8?B?SUduY3JQckhidnFzT0drdVl1MHZRd2lOMkp4MUp0WnBPVzYxU0pqUUIra242?=
 =?utf-8?B?VlBPUE5sb0s1Rzd4d3EzYTBCWThSU2dYQ3JEVGhaZHFpNVpwOU1oT0p2K2dK?=
 =?utf-8?B?enRDWlpwR04wNXFSSHNZalUvbUFKRDlKeDRPZTlqV0taRlljb3NMUUlSN2U0?=
 =?utf-8?B?ZUFnYis5cmpzL2NqLzFyc0E3R2JZdzFGOFhHa2xjRnJUdDNuMWpUQlBZVlFx?=
 =?utf-8?B?RW40d3J5RDR6NlBOYjFmVzFEdTdaRGhXVEM1OUZadzd4ZmxuMkRaTm1ETlJP?=
 =?utf-8?B?MTZxcFFmUkJ1V2VNcGdscXIwdEZjeEQ2VkRSbGxsYWlvWm0zaG5kdElmU0x3?=
 =?utf-8?B?TmJlRmhITzYvUDBONDUvYVZORDNYcG9ORmd3c2pjQ1N3NmxWZ2xLWnFNQlJD?=
 =?utf-8?B?TWJMVFBWa0x4Z3lxZDYwKytwRW1jR0dqb1FOT0ZGbThqV2ZqOHRQQUk1Vm5u?=
 =?utf-8?B?cVJ6bFIvTCtjNWo4dnRTWHFZbVdTQy9OcmhMTGtVSWsvc3ZTQUdCWEdzVEtm?=
 =?utf-8?B?SDBqTHlVZ3lWL1BMYlk4Q2FTS3pNRVZBZllIbXBFcUNUN2I5ZG9leFlxUGpM?=
 =?utf-8?B?YVh2ZVFWcUl3Y08rdm9MQTlHdjdmSXdqdytHOEdyRDlnb2luNUtNNXE2S3dj?=
 =?utf-8?B?UXdMVzRIYnZmdTR4QVluYU9xUDZrZUpMQURuTVRzdkRGOENiUlpLRFpKL0h0?=
 =?utf-8?B?TFNyeEJYZ0M0OVdhLzIrVStOTkZaM2FuNXFMQlBVT0FwUmtCR2Zmc2R6ZFNE?=
 =?utf-8?B?ZHNpVUxPbitjWTNoS0E1YnN2UWg1b2w2aWZpYlQyUTlQL0hmTnM2dkZBbTZo?=
 =?utf-8?B?dUFHeWxVWmJlaFNXVEx4RGhmSkNWTDRMRjZNVVVrQzVFNzZEQnM5STY1RFRJ?=
 =?utf-8?Q?W67x09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5795.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWFIUnVsQ0FKMGVjaUh2emtySnBBWVZrTngrS0lYZE5aYnpBT0lTeTlPWnFv?=
 =?utf-8?B?a2QwY1lwUDhaQytnK3VINFNCbXBlNlFoMkFZak9hZ1Q3c1A3bUpETUZZSzF4?=
 =?utf-8?B?aDhFak95eGkwZk43d0ZPemhtWDFqdjNhcFZMSHRwNkRmYkhQMHAzekhocWor?=
 =?utf-8?B?Rlh6VnpWbG9pbVFRc2J6NXJQTHQyaDU0S3NPVHl0Q3MxU0c1eU1TMTRnZE5T?=
 =?utf-8?B?UkNROWlPT3JRMGJ3YlVvdzFhQURSbnA2b3ZrcHp1NG9QbUlsNFp3amx0TWs1?=
 =?utf-8?B?djJzRWxTVU9YdHRpUExiTG9OTmtJWFlyVTI1YUpIWFpmV29BMTZqR2NPNVdQ?=
 =?utf-8?B?V1djODJGTFV0eVBEZWxEWWdvMXI2S1J5VEZuRTQ5akFHSUhjOEZiaFg5NjNK?=
 =?utf-8?B?UUZFY3p1ZjRJakNERkZwOVNjQTRXVktRbFBoRmJSK1dlY0lTUTNZb3VVNXhE?=
 =?utf-8?B?a3pUY2w4ZnZWMlRMWmpZdTdiWTJCdDBZWURTSmlPb3hCRjNhM3dnVUJiU2ZO?=
 =?utf-8?B?Z0JFN2ZxeklNUEYyYUU5aFBRRVNsa2lVWUl1b1JaR3c0TkRocWwyOFFFY0xa?=
 =?utf-8?B?MDdyMEdteElOcVRxbTFoYms3UzUyYWRseWFkMlFhWEk3SWxLWFFxcURMd0hC?=
 =?utf-8?B?RkxGcUdMMkFpblNaSVE3VVFiaUx0eENVSGNQMEVmUCtNRkorUis1TUxTaU9T?=
 =?utf-8?B?aUJzZ1JOemQxK0p5QndvdFVNbEszNWhXbkNoaU1ISVk0bUZHemJXWERHOW5I?=
 =?utf-8?B?ZVRUeUl0WjBVcVRTcHFaSndXTjBpZ2hrOCtGd0dpMER6SDAxTmJaQkMxL0RJ?=
 =?utf-8?B?UTJOcHVSamhkQ0RLM0tiRjhGQTl2amdMdkE3K2gvSGo4QzlxSXBkUlNkTVNu?=
 =?utf-8?B?T3VRaXE2WmZXZU9UdE5adUF6NGd1Z3E3V1hidnJLMlo0M3pDQjZBdWxianBP?=
 =?utf-8?B?WVFVNCthK3N5ZHV6QkxNMFBBQWZ5a0MyYzRuWTJWYkxWdmh3LzMyUkVtdlpI?=
 =?utf-8?B?WHQ5MXJNelNrV1hGNXNkaVEzbTNuMy9FYnZaMTc5d2ViVlpNN21jaU95dkRQ?=
 =?utf-8?B?TWVQNkFBUExMcXR3SGdXQ3MzeVJISkVaY2JUcEI5VGttZlJHY3pETDBQek40?=
 =?utf-8?B?OTJtREF2ZjRZZ3A3SlpyOHAzbThza25JOHA1WGgrcVJjMGNsY3pKMU82TElp?=
 =?utf-8?B?endlZlYxSXlxbno2UjNZQ2twWUFTSy9YOWozNmhCUWl1cmRvZ3lPM3kvOHR4?=
 =?utf-8?B?ZUliR09DM0ZKNE81TE5oUnRWTHVQMkpHeHhqdWNZeU5DWVBkUll3aUEvVzE5?=
 =?utf-8?B?L3liajZiWmNJejl1dmU1UWw3VWZsTjlyM3orYXZicVJNbmZvbUNwRmpudkxH?=
 =?utf-8?B?WnBKcXR2MDhmZmlBWGVLbHF4eTVQRzB4SkQ5aVpUbHpjdnZTbVlYNS9KakpR?=
 =?utf-8?B?STJPUDVDeDA4MWwyN0VGR1gySDNFTGl2aVdvL2l1Q2lTQ1BRMlJDQ0s4TXFX?=
 =?utf-8?B?WFh3aXk3a0V2d2E1YU5lLzAwNUVKeHBoYkt2aVRleURtcjhsdTBFM0NzQjdQ?=
 =?utf-8?B?S0lkMEE2ZWNNVDd3T0d1Lzd4QTMzT2pBN3lUamlaWU5oNWhrd1MrZUs3OExF?=
 =?utf-8?B?QXF6TzNyZzcvY25URzlRcjgxVHIwakpSckc5QitlUHpwdTlZdEJqVHNPRXUy?=
 =?utf-8?B?VUlGdWZKbjBWbmxoQlNwOG5ydTM1LzFFMHBNR2NRVS82UVFiL2VwRTFvRTBT?=
 =?utf-8?B?aWFOVmhtYnlhU056RW1TMDZ3UWdKd01mQ08yZzUyeFUzTjN5WUhYTGp6OWcx?=
 =?utf-8?B?WHgwdFJsMEtaQm1Pd1RBa1NvaVh1YjBvd09Dc2h2V0h3OExqM2RWUWQ2Wkc0?=
 =?utf-8?B?RGhPZDNCbVA4RnBteEhmdTZWamREcS9ML2w1eDNLUWI2Mm8wcm1sU0VqbGI5?=
 =?utf-8?B?UnRHWnJjMW9zVmt0UjJ1T2JYM2RJdVlRdExjc1dEdnhucUlzOS9EdEdjeVIw?=
 =?utf-8?B?NS9HVThaTGl4aDhxaldoeWZZRHN0SUJ5c2hCcjVQbWhTbTZSNmRUaUsvS2xP?=
 =?utf-8?B?TXN5aXNZYjJKcnkyQjR3KzBXTUREak0vNXQxSjUvL2lDSFVqalpRVXFJSUIx?=
 =?utf-8?B?bGlMbVoyNHlYaEhwbzNpMlpLUm1mcjFlTXBDSWdNQUJBbVdBa1lZQTcwZWFz?=
 =?utf-8?B?UFZNa09lZGxFbzVDc0VFd2VHMUdKejJpMkZLTnNiMVowWW5TQnM1SFNjRElM?=
 =?utf-8?B?UVNabklBb2VFKzVrL01qck85M0R3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31795053CE27144192AD0847D874A661@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7DbgasglVbkW5qJ6etnQLreJoWqBgmQOe43tuTu7HSzGz9Xc0ftY1upOrl6CuZipHEIkfQy2u3A454nXRA+wDDDWeZiLp7a1NfczZZnQGljwTI8lK+rYbaoOL8s+BKQsKlMl2A29bxbmMC+xSC0/RSBWAqSsRxzaBwLmCljh7gkzWcIbN1trw6zRvgHyT0aUWGGBjYhTw/hybCVyyw+CfN05q1nbydhei5Qtc1x9uYJbXXAZMvb7MdoHSG6reB8TlieaegdpGZUdi39JgeATwRWzlaA4fhc4byn54A+3Fe8HVTX8ZWe3jnbE8UPp+Dz/nKttl5xjBU3LNO659b/KAVmAi2ENx0TYIlBPyxLm/5eW9Ex/1aPz5sfvsT4FGSMvXp3ltZEOwQ7FpSaWEWrQ1EXe6cKym3aVWuf9yG5xoEBgd9fvkjn3JAfitI790uEeUWJTzB9imn05tfPEd++RMLzLyuEjRqrYvFao2BfZyewJzg3xzYGorl4z92puHW24NccxTsK8Hw52VoZDZDdhliAEaK0CuhBdI6gqeFmPz+W+GQ2/XkMnPwWiT7ZDw5iHTS724LgMtfwvtPRhng7bDJk5Dk1SnV/gVSQpu1CABpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5795.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b50adf9-cf47-43ad-816a-08de13774334
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 03:33:28.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVe2maD+lwEBFs7Uzm+FRTKSysOIMcaX77e2XDujXK/ksyVn/jUpJy30SSmGFs2TFhiRLyNmxxoZWYyPOr5ihAJof4KNLbK8CkZdlJBTOVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510250029
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX34h2HjmDS3UK
 jg76z43BVfprSq1s7WVHgC5kCGDWJ2ToWb6FI4fMDFKq6s8+/eUs2WPqI78ret8wbf/BClBEtG2
 dv17oQIf+35keZD2TqZg8c3bt8D0C76SlzLD2aYJhVLvnmGSG79zrwuasyqrKj+lnfMBTS2XgiP
 OeN6cL4sY0Sctz5Ag7PCXBMQadLFU0Juh42ltgpmjhS0Svt8UxHLnKQHgVP7ajxzWkiqmrBxBSs
 f+OdvVXNB+RpOfQJwQC6w3qPHy06vj8QBwGlQaRv+ENXsQgz0MzDj+tq6yQdvIVFPdO3Vl/j1lb
 hhmTqGrlCAEiG6U9wSN/rfEpORKDceBJmkkjAB3klM/jD2wdsCRdhj+aD+s1EpizN/24jssJ4MH
 7nDaAZSlcu0QJCqSybp+hCdswHqqQNZHt/0JgPbpgnFbjt2aTl0=
X-Proofpoint-ORIG-GUID: a89qUqaE73EdgcM2AzlVuhNmVkmmSsw8
X-Authority-Analysis: v=2.4 cv=Aaa83nXG c=1 sm=1 tr=0 ts=68fc450b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AiHppB-aAAAA:8 a=yPCof4ZbAAAA:8
 a=-7ln6tzmnsDdlEDdog4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-GUID: a89qUqaE73EdgcM2AzlVuhNmVkmmSsw8

SGkgWWksDQpUaGFua3MgZm9yIHJldmlldyEgDQoNCj4gT24gT2N0IDI0LCAyMDI1LCBhdCA3OjA0
4oCvUE0sIFpoYW5nIFlpIDx5aS56aGFuZ0BodWF3ZWljbG91ZC5jb20+IHdyb3RlOg0KPiANCj4g
T24gMTAvMjUvMjAyNSAzOjM1IEFNLCBXZW5nYW5nIFdhbmcgd3JvdGU6DQo+PiBXaGVuIGpiZDJf
am91cm5hbF9hYm9ydCgpIGlzIGNhbGxlZCwgdGhlIHByb3ZpZGVkIGVycm9yIGNvZGUgaXMgc3Rv
cmVkDQo+PiBpbiB0aGUgam91cm5hbCBzdXBlcmJsb2NrLiBTb21lIGV4aXN0aW5nIGNhbGxzIGhh
cmQtY29kZSAtRUlPIGV2ZW4gd2hlbg0KPj4gdGhlIGFjdHVhbCBmYWlsdXJlIGlzIG5vdCBJL08g
cmVsYXRlZC4NCj4+IA0KPj4gVGhpcyBwYXRjaCB1cGRhdGVzIHRob3NlIGNhbGxzIHRvIHBhc3Mg
bW9yZSBhY2N1cmF0ZSBlcnJvciBjb2RlcywNCj4+IGFsbG93aW5nIHRoZSBzdXBlcmJsb2NrIHRv
IHJlY29yZCB0aGUgdHJ1ZSBjYXVzZSBvZiBmYWlsdXJlLiBUaGlzIGhlbHBzDQo+PiBpbXByb3Zl
IGRpYWdub3N0aWNzIGFuZCBkZWJ1Z2dpbmcgY2xhcml0eSB3aGVuIGFuYWx5emluZyBqb3VybmFs
IGFib3J0cy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogV2VuZ2FuZyBXYW5nIDx3ZW4uZ2FuZy53
YW5nQG9yYWNsZS5jb20+DQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCwgaXQgbWFrZXMg
c2Vuc2UgdG8gbWUuIEkgaGF2ZSBqdXN0IG9uZSBtaW5vcg0KPiBjb21tZW50IGJlbG93Lg0KPiAN
Cj4+IC0tLQ0KPj4gZnMvZXh0NC9zdXBlci5jICAgICAgIHwgIDQgKystLQ0KPj4gZnMvamJkMi9j
aGVja3BvaW50LmMgIHwgIDIgKy0NCj4+IGZzL2piZDIvam91cm5hbC5jICAgICB8IDE1ICsrKysr
KysrKy0tLS0tLQ0KPj4gZnMvamJkMi90cmFuc2FjdGlvbi5jIHwgIDUgKysrLS0NCj4+IDQgZmls
ZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9mcy9leHQ0L3N1cGVyLmMgYi9mcy9leHQ0L3N1cGVyLmMNCj4+IGluZGV4IDMz
ZTdjMDhjOTUyOS4uYmFmMTA5OGNhYzYzIDEwMDY0NA0KPj4gLS0tIGEvZnMvZXh0NC9zdXBlci5j
DQo+PiArKysgYi9mcy9leHQ0L3N1cGVyLmMNCj4+IEBAIC02OTgsNyArNjk4LDcgQEAgc3RhdGlj
IHZvaWQgZXh0NF9oYW5kbGVfZXJyb3Ioc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgYm9vbCBmb3Jj
ZV9ybywgaW50IGVycm9yLA0KPj4gV0FSTl9PTl9PTkNFKDEpOw0KPj4gDQo+PiBpZiAoIWNvbnRp
bnVlX2ZzICYmICFleHQ0X2VtZXJnZW5jeV9ybyhzYikgJiYgam91cm5hbCkNCj4+IC0gamJkMl9q
b3VybmFsX2Fib3J0KGpvdXJuYWwsIC1FSU8pOw0KPj4gKyBqYmQyX2pvdXJuYWxfYWJvcnQoam91
cm5hbCwgZXJyb3IpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl4NCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRoaXMgc2hvdWxkIGJlIC1lcnJvcg0KDQpZZXMsIG5p
Y2UgY2F0Y2ghDQoNClRoYW5rcywNCldlbmdhbmcNCg0KPiANCj4gVGhlIG90aGVycyBsb29rIGdv
b2QgdG8gbWUuDQo+IA0KPiBUaGFua3MsDQo+IFlpLg0KPiANCj4+IA0KPj4gaWYgKCFiZGV2X3Jl
YWRfb25seShzYi0+c19iZGV2KSkgew0KPj4gc2F2ZV9lcnJvcl9pbmZvKHNiLCBlcnJvciwgaW5v
LCBibG9jaywgZnVuYywgbGluZSk7DQo+PiBAQCAtNTg0Miw3ICs1ODQyLDcgQEAgc3RhdGljIGlu
dCBleHQ0X2pvdXJuYWxfYm1hcChqb3VybmFsX3QgKmpvdXJuYWwsIHNlY3Rvcl90ICpibG9jaykN
Cj4+IGV4dDRfbXNnKGpvdXJuYWwtPmpfaW5vZGUtPmlfc2IsIEtFUk5fQ1JJVCwNCj4+ICAiam91
cm5hbCBibWFwIGZhaWxlZDogYmxvY2sgJWxsdSByZXQgJWRcbiIsDQo+PiAgKmJsb2NrLCByZXQp
Ow0KPj4gLSBqYmQyX2pvdXJuYWxfYWJvcnQoam91cm5hbCwgcmV0ID8gcmV0IDogLUVJTyk7DQo+
PiArIGpiZDJfam91cm5hbF9hYm9ydChqb3VybmFsLCByZXQgPyByZXQgOiAtRUZTQ09SUlVQVEVE
KTsNCj4+IHJldHVybiByZXQ7DQo+PiB9DQo+PiAqYmxvY2sgPSBtYXAubV9wYmxrOw0KPj4gZGlm
ZiAtLWdpdCBhL2ZzL2piZDIvY2hlY2twb2ludC5jIGIvZnMvamJkMi9jaGVja3BvaW50LmMNCj4+
IGluZGV4IDJkMDcxOWJmNmQ4Ny4uZGU4OWM1YmVmNjA3IDEwMDY0NA0KPj4gLS0tIGEvZnMvamJk
Mi9jaGVja3BvaW50LmMNCj4+ICsrKyBiL2ZzL2piZDIvY2hlY2twb2ludC5jDQo+PiBAQCAtMTEz
LDcgKzExMyw3IEBAIF9fcmVsZWFzZXMoJmpvdXJuYWwtPmpfc3RhdGVfbG9jaykNCj4+ICAgICAg
ICAiam91cm5hbCBzcGFjZSBpbiAlc1xuIiwgX19mdW5jX18sDQo+PiAgICAgICAgam91cm5hbC0+
al9kZXZuYW1lKTsNCj4+IFdBUk5fT04oMSk7DQo+PiAtIGpiZDJfam91cm5hbF9hYm9ydChqb3Vy
bmFsLCAtRUlPKTsNCj4+ICsgamJkMl9qb3VybmFsX2Fib3J0KGpvdXJuYWwsIC1FTk9TUEMpOw0K
Pj4gfQ0KPj4gd3JpdGVfbG9jaygmam91cm5hbC0+al9zdGF0ZV9sb2NrKTsNCj4+IH0gZWxzZSB7
DQo+PiBkaWZmIC0tZ2l0IGEvZnMvamJkMi9qb3VybmFsLmMgYi9mcy9qYmQyL2pvdXJuYWwuYw0K
Pj4gaW5kZXggZDQ4MGI5NDExN2NkLi5kOTY1ZGMwYjlhNTkgMTAwNjQ0DQo+PiAtLS0gYS9mcy9q
YmQyL2pvdXJuYWwuYw0KPj4gKysrIGIvZnMvamJkMi9qb3VybmFsLmMNCj4+IEBAIC05MzcsOCAr
OTM3LDggQEAgaW50IGpiZDJfam91cm5hbF9ibWFwKGpvdXJuYWxfdCAqam91cm5hbCwgdW5zaWdu
ZWQgbG9uZyBibG9ja25yLA0KPj4gcHJpbnRrKEtFUk5fQUxFUlQgIiVzOiBqb3VybmFsIGJsb2Nr
IG5vdCBmb3VuZCAiDQo+PiAiYXQgb2Zmc2V0ICVsdSBvbiAlc1xuIiwNCj4+ICAgICAgICBfX2Z1
bmNfXywgYmxvY2tuciwgam91cm5hbC0+al9kZXZuYW1lKTsNCj4+ICsgamJkMl9qb3VybmFsX2Fi
b3J0KGpvdXJuYWwsIHJldCA/IHJldCA6IC1FRlNDT1JSVVBURUQpOw0KPj4gZXJyID0gLUVJTzsN
Cj4+IC0gamJkMl9qb3VybmFsX2Fib3J0KGpvdXJuYWwsIGVycik7DQo+PiB9IGVsc2Ugew0KPj4g
KnJldHAgPSBibG9jazsNCj4+IH0NCj4+IEBAIC0xODU4LDggKzE4NTgsOSBAQCBpbnQgamJkMl9q
b3VybmFsX3VwZGF0ZV9zYl9sb2dfdGFpbChqb3VybmFsX3QgKmpvdXJuYWwsIHRpZF90IHRhaWxf
dGlkLA0KPj4gDQo+PiBpZiAoaXNfam91cm5hbF9hYm9ydGVkKGpvdXJuYWwpKQ0KPj4gcmV0dXJu
IC1FSU87DQo+PiAtIGlmIChqYmQyX2NoZWNrX2ZzX2Rldl93cml0ZV9lcnJvcihqb3VybmFsKSkg
ew0KPj4gLSBqYmQyX2pvdXJuYWxfYWJvcnQoam91cm5hbCwgLUVJTyk7DQo+PiArIHJldCA9IGpi
ZDJfY2hlY2tfZnNfZGV2X3dyaXRlX2Vycm9yKGpvdXJuYWwpOw0KPj4gKyBpZiAocmV0KSB7DQo+
PiArIGpiZDJfam91cm5hbF9hYm9ydChqb3VybmFsLCByZXQpOw0KPj4gcmV0dXJuIC1FSU87DQo+
PiB9DQo+PiANCj4+IEBAIC0yMTU2LDkgKzIxNTcsMTEgQEAgaW50IGpiZDJfam91cm5hbF9kZXN0
cm95KGpvdXJuYWxfdCAqam91cm5hbCkNCj4+ICAqIGZhaWxlZCB0byB3cml0ZSBiYWNrIHRvIHRo
ZSBvcmlnaW5hbCBsb2NhdGlvbiwgb3RoZXJ3aXNlIHRoZQ0KPj4gICogZmlsZXN5c3RlbSBtYXkg
YmVjb21lIGluY29uc2lzdGVudC4NCj4+ICAqLw0KPj4gLSBpZiAoIWlzX2pvdXJuYWxfYWJvcnRl
ZChqb3VybmFsKSAmJg0KPj4gLSAgICAgamJkMl9jaGVja19mc19kZXZfd3JpdGVfZXJyb3Ioam91
cm5hbCkpDQo+PiAtIGpiZDJfam91cm5hbF9hYm9ydChqb3VybmFsLCAtRUlPKTsNCj4+ICsgaWYg
KCFpc19qb3VybmFsX2Fib3J0ZWQoam91cm5hbCkpIHsNCj4+ICsgaW50IHJldCA9IGpiZDJfY2hl
Y2tfZnNfZGV2X3dyaXRlX2Vycm9yKGpvdXJuYWwpOw0KPj4gKyBpZiAocmV0KQ0KPj4gKyBqYmQy
X2pvdXJuYWxfYWJvcnQoam91cm5hbCwgcmV0KTsNCj4+ICsgfQ0KPj4gDQo+PiBpZiAoam91cm5h
bC0+al9zYl9idWZmZXIpIHsNCj4+IGlmICghaXNfam91cm5hbF9hYm9ydGVkKGpvdXJuYWwpKSB7
DQo+PiBkaWZmIC0tZ2l0IGEvZnMvamJkMi90cmFuc2FjdGlvbi5jIGIvZnMvamJkMi90cmFuc2Fj
dGlvbi5jDQo+PiBpbmRleCAzZTUxMDU2NGRlNmUuLjQ0ZGZhYTllNzgzOSAxMDA2NDQNCj4+IC0t
LSBhL2ZzL2piZDIvdHJhbnNhY3Rpb24uYw0KPj4gKysrIGIvZnMvamJkMi90cmFuc2FjdGlvbi5j
DQo+PiBAQCAtMTIxOSw3ICsxMjE5LDggQEAgaW50IGpiZDJfam91cm5hbF9nZXRfd3JpdGVfYWNj
ZXNzKGhhbmRsZV90ICpoYW5kbGUsIHN0cnVjdCBidWZmZXJfaGVhZCAqYmgpDQo+PiByZXR1cm4g
LUVST0ZTOw0KPj4gDQo+PiBqb3VybmFsID0gaGFuZGxlLT5oX3RyYW5zYWN0aW9uLT50X2pvdXJu
YWw7DQo+PiAtIGlmIChqYmQyX2NoZWNrX2ZzX2Rldl93cml0ZV9lcnJvcihqb3VybmFsKSkgew0K
Pj4gKyByYyA9IGpiZDJfY2hlY2tfZnNfZGV2X3dyaXRlX2Vycm9yKGpvdXJuYWwpOw0KPj4gKyBp
ZiAocmMpIHsNCj4+IC8qDQo+PiAgKiBJZiB0aGUgZnMgZGV2IGhhcyB3cml0ZWJhY2sgZXJyb3Jz
LCBpdCBtYXkgaGF2ZSBmYWlsZWQNCj4+ICAqIHRvIGFzeW5jIHdyaXRlIG91dCBtZXRhZGF0YSBi
dWZmZXJzIGluIHRoZSBiYWNrZ3JvdW5kLg0KPj4gQEAgLTEyMjcsNyArMTIyOCw3IEBAIGludCBq
YmQyX2pvdXJuYWxfZ2V0X3dyaXRlX2FjY2VzcyhoYW5kbGVfdCAqaGFuZGxlLCBzdHJ1Y3QgYnVm
ZmVyX2hlYWQgKmJoKQ0KPj4gICogaXQgb3V0IGFnYWluLCB3aGljaCBtYXkgbGVhZCB0byBvbi1k
aXNrIGZpbGVzeXN0ZW0NCj4+ICAqIGluY29uc2lzdGVuY3kuIEFib3J0aW5nIGpvdXJuYWwgY2Fu
IGF2b2lkIGl0IGhhcHBlbi4NCj4+ICAqLw0KPj4gLSBqYmQyX2pvdXJuYWxfYWJvcnQoam91cm5h
bCwgLUVJTyk7DQo+PiArIGpiZDJfam91cm5hbF9hYm9ydChqb3VybmFsLCByYyk7DQo+PiByZXR1
cm4gLUVJTzsNCj4+IH0NCg0KDQo=

