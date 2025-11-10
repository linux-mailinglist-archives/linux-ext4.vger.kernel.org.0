Return-Path: <linux-ext4+bounces-11731-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F073EC485DC
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74AF634ABF0
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417A2D8790;
	Mon, 10 Nov 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fAuZ8b4V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RfPbxGaF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC432D8783
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796044; cv=fail; b=dl/SXvkwM4zIXhS9+tBY4yAH3e1gEI1du3NNnbs1u0nxmV6qIA6ezSyTyykC0jNj2AoGaqsRBLOsoCNtkFsZA0/biKLw7NVfvnFe85Yg7sMZ5pkF9fkhXdiurd1zxcoAlHFlpL3AYTEwL/WT4y8omzCiB6DIT0neZtn5WVydPdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796044; c=relaxed/simple;
	bh=/6OQ+HIIKJhBd2kg2Uk/W5UCkUdl7nLVCpmJisRsc2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AbDiubPWenbdPxqQDUsYJxo4pk4QyLaSvz/JzX1yWTeMfC0qyZoUGaqETjFSUDv7hFc4seBVCHz+u0ykDwi+EmYOeU1kJxkQisNH7tBLE90GKtWBCf3O7h53Tiq1V1AdLIgZHQJU2UBGJNaotsZoo9tjMGEvA88JZGV5JuUx4Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fAuZ8b4V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RfPbxGaF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAH8HaZ005376;
	Mon, 10 Nov 2025 17:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/6OQ+HIIKJhBd2kg2Uk/W5UCkUdl7nLVCpmJisRsc2w=; b=
	fAuZ8b4VHHqsaqxtIHfu8dfweGcPeX6tt87TSuns+I8bBEZWw0n8m8fX4ibMxjMD
	GrC85MZApVSM0veRNOX1/Rw7SSsoLus4VKmN9qpyGKWMCTaBzu5iMwuI9FHZU+wg
	6CaJ8yR48cw19tsMkNN3hEz4yDxlS6WMemJ+XFZ3+mxa8fJHkDTQ1/RhQDl4K9Iq
	Mw7RJE1QCana5NkWEktBLNoq0DUkFW+SXjyuYKiu7KWwbzsdNO7VxG3guuus8UbP
	ncyC804oEuObbc0T2z/uhtSxeh+JaBD1dXjXrWoPSbYXLTmbmMeuybMTcFA2BcSU
	r7eVPxQdVPOCOY2N6xz2Ag==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abkwx83b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:33:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGBvB8009943;
	Mon, 10 Nov 2025 17:33:58 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaj7657-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:33:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxsQR+CqM3AfU8Vn1CS70TgfWQBSpzPtnG4I0YmL1SXuWUpAlF7kUIwI/wFdEhacKwQQTmWREw2HdIaE0CFYLsOAlYgOfQH9LSj9cCiXYh4EMsU/MYq7VNlpZh05I0fqHkfD8M3RscvtKQ9zRKhbDCHOmzxIlGcz5F/GkMofd8gPD2uYBtiT71VTZwmy29JwgY5PYlHty9WHMVfEWff0rRXYWav+xgxMUlqFNNtoTUTEhcmUltPSepUZSh8f0nKYOrAdBry0MSV0lbJey4MedzCGfkZ5HZxKPWDD033SM3MUFSUmRMJ1i5cMWwl2PMDecDFBvXxwtq7q9pR9IKgROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6OQ+HIIKJhBd2kg2Uk/W5UCkUdl7nLVCpmJisRsc2w=;
 b=xbapcLj6YT3VrTBj6z4yOsuGddXNkrmxm6EMzbuPlPMw0jGjOT3MIkJJu/UQwMD9sM8AIcOcwRI4czwjFpvdKwVjw884PKoQ3c2W5HZotGiRWasOPnFsgloMI7kReGPG8rUNxKvhXXtUcDDkDUbTBjGovStlMN5XacvyPcuEebmDKrKn+mPll7UWBWfZgLdz7wNzs1baEYrsSpPoqBH319YDJzuh5cy5akybhTQRTyaTF49d0TyWVtBOaeBfqb/RYN4rHTA9d6HpstjJOeGYPYbKWMPrXPrksRUgGG8WtXCkJ5G/Ekt+6AMTIPKrbCYU863h329aNogZhyn6hyusSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6OQ+HIIKJhBd2kg2Uk/W5UCkUdl7nLVCpmJisRsc2w=;
 b=RfPbxGaFfl7UKtuQ5xTF/qu572quNIRaTt8O23+LoPXaEO2I8Ym1BDqiAl8bBZiXov+nXQwUA0Eb0Z69Q92mg4hFZubZDZU5LqHcNqX4iCURlMKunoPsePFDLHhfLN8jzW3TBxkoPnaKzO2/RVVrwDw/wF2DGncKeCC1/ragQJQ=
Received: from PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15)
 by CH2PR10MB4165.namprd10.prod.outlook.com (2603:10b6:610:a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:33:55 +0000
Received: from PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27]) by PH0PR10MB5795.namprd10.prod.outlook.com
 ([fe80::69c5:1e7c:5ad:7a27%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:33:55 +0000
From: Wengang Wang <wen.gang.wang@oracle.com>
To: "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>
CC: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu"
	<tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
Subject: Re: [PATCH V2] jbd2: store more accurate errno in superblock when
 possible
Thread-Topic: [PATCH V2] jbd2: store more accurate errno in superblock when
 possible
Thread-Index: AQHcSqoH6Fi35sLkB0einF3mMw0tWLTgI+kAgAwXF4A=
Date: Mon, 10 Nov 2025 17:33:55 +0000
Message-ID: <8EAE903A-9C98-4DF5-A69A-5CCEBDB5E30F@oracle.com>
References: <20251031210501.7337-1-wen.gang.wang@oracle.com>
 <8d2dbd93-da25-4077-8070-dd2998820b41@huaweicloud.com>
In-Reply-To: <8d2dbd93-da25-4077-8070-dd2998820b41@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.100.1.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5795:EE_|CH2PR10MB4165:EE_
x-ms-office365-filtering-correlation-id: 5729686f-4424-43e0-6218-08de207f52b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0VYYVZOSDdSdjlWZ1lQcnQ5MFZTWUcwUUlZSWFiZnR6OFJoOHVtMXZmeHY2?=
 =?utf-8?B?VTlHY1IyNXU1YVZRczJ3Vzg2bzdLYUFqeG1MdWR5alFMZFRZMDdjMjFabXpP?=
 =?utf-8?B?U3lQdHd2Zkg0QWYyZ0tubTN6cXo4MDR0djkxUkpzTmlmdVB3alowZi84dWl2?=
 =?utf-8?B?VTEwVndjVnZaYlZ0SkVxVi9xSGR1L0F4ckxxaGwza2JTYWJ3KzQ4azhxM2E4?=
 =?utf-8?B?RnJZTW4rVUdOWWt3M2ZyTVJ6azRac254ODdaV1U1UkZYT08rVHllQjJKWVdF?=
 =?utf-8?B?ZUpxK1UwRjdpM2Q3ZmlWSXpTa1RLTjUxeVlDYU54U2h2K0NXbnFSYmR1OHlN?=
 =?utf-8?B?ZGpTckVhRmw1M2NJeW1zUWkwNHB0OW0xMURxdUhaaEl2MkJXbkZ6M3ptZlhy?=
 =?utf-8?B?TDR5aS9LYzVJZjZtVjA1cExzc2MxamtSYzRwRzdicy9wOHovbTJ3MFZ6MGlx?=
 =?utf-8?B?RzhJbmZGOFhFRDdremNtcnFmdUZOemNVWnM3cHdoNG1wZW1XM201b3BFTENt?=
 =?utf-8?B?RDc0aUIzL1VxcnFIeVBwOENQazFiSGNpZkhXd1F2QnVJeUFmNjEvSEdpM3ow?=
 =?utf-8?B?WS9vZEdWTnBzNncvUnF5QVRpOTFUczFtdkYzc3FuZGpFUjJRa01HTUpuWVIw?=
 =?utf-8?B?c1piU2lLTEl0RHl4RmxWU25NK2Q2UVowUGNya3lLTmd2R3NZSlVCS0VrVG1k?=
 =?utf-8?B?cThLa2V3L29tU3FjUGE4bGhPSGQ2dnJrZHZmakhwUzVCRnV4L2lmSEtCd0xV?=
 =?utf-8?B?RmJmc2dmQzVrZE4zMGgvem5hd01weXFEN2RsSjhDd3RCSmdaNnMyUUQ5ak54?=
 =?utf-8?B?eGpiMnNDY0V3aVlVNG9Va0V2MXB4UGozUWh1UlA5L1pNWENGSi9ZaXJkZXFw?=
 =?utf-8?B?VFFiNUdaNG9vL3E5MHVqRVBnVDU4SG55SGNKajAraGxNRlBCK3g3VWpJWWMw?=
 =?utf-8?B?enR1ZVN2NFlUK1hGcFNGUTVaWWdmb0h4QjNOcEdvUlI4ZndUN2ZxRlZ1b2xT?=
 =?utf-8?B?aFRGRDhPdUlxc0FhWm8rNjdwU0d5UVBEcWNSK09RRzh6a2VQKy84bHdnU3o4?=
 =?utf-8?B?aFptRXJncWJBZC9uQXJ0YmRUL2VTelhLQ2V4K2g2M1N0OGpMQmh0aFA2TXF5?=
 =?utf-8?B?c3NwYUhQb1FQUXE1ZXQ2SDBXUkZNU3J2ZWg2bTFKVENERXcvbVpyVC9hSkhr?=
 =?utf-8?B?eFRnZjVMT3lnRndMKy85ejJjVTBaNzFLeWZ6c2F5Ly9OUnViRzdBcC9STVl6?=
 =?utf-8?B?TzgrMkpKNVdYZ0sxa3ZNaWFxbUpGZ0lESkpaZTJsT0tvWURhL1NTRFh2ZHQz?=
 =?utf-8?B?dUQ1eTVySi8yTldqM1dHS2p4MXFZSnBWdDdRL2I2bTl5U24xdUoweTZod0hS?=
 =?utf-8?B?U3pJRHdPaWhlcjI0VnJhTEJLYXhMemliM3pMZndGY3BHeTBGaHZlRHZzd3Y2?=
 =?utf-8?B?QkxUWTZQbWlKeW14K3NTNGFNWjUraUJGcFJBQTRqUGZOWWxFMXkwZVRKT0VJ?=
 =?utf-8?B?cEVYMG1wZ1VmWGpXdS81eVFlaTFqZDZTK1dnTVhsSEFocnA2WFhuY2JEZW5Z?=
 =?utf-8?B?NzNjYnliUWhiUjZhclNLOHVINm5EaGFWbnFyeXk0VTBhQW1RTWhNN3U1aXNp?=
 =?utf-8?B?WStuNW9pbklxelYvMnpTVTFCN3RrTW55RHlHTEdIWjVYNkp4NDdvelFZS0tY?=
 =?utf-8?B?NlJzRVVnZ25kbS9mTVRHWmRIamNXcXphL0sxb3hXQ0RBbDcxbXZBY1NtNU5F?=
 =?utf-8?B?Qk1zeDVwRXVFVlpHU1U5UTduUVgzbEhJWXBtZWhmQ0l4WEY2K1c4eVZ1SGdI?=
 =?utf-8?B?RnhsSVIvTWIvcTBQU1hVUUp2Z1pvRGlxWk1YNXRLNG80ZzFzQURjWlNCeFRo?=
 =?utf-8?B?R21TcWs2ejkwekw1b1lmWmgzSHNzZlVyYW9HQ0VFd3h6L054b0xodTR1Y2Y3?=
 =?utf-8?B?aXNLWUJYZTFMZWZOd0ZsYnBNcXpSdkM4QytZOVZyd04wYkJFRFF6eitMSUE4?=
 =?utf-8?B?b3ZOcmFUcjB4RzYrMFBMRnB4UjEvVEhaY256K2U2ckdXMlRFTkFCOU84QlJv?=
 =?utf-8?Q?F7dURA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5795.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEtVT0JFZHppMXhOdzkzTGNtVXQ3N0dpNm9sYnpiL1piaUYyWjBjV1hEa3hT?=
 =?utf-8?B?N0tiY1hmQ29obnhyU3VVUDhOSHJjUTVYS0JkSnVqYjJHaWkrVmxYOTh3dk5t?=
 =?utf-8?B?V0s0bm0vdDg0MnpmMXJ5ZlFDNit4bkUxSXg4ZllxZEVXYm40K0RpL1ZSbFlY?=
 =?utf-8?B?TWZMM0lrOEw5d3paSWd1bUpLZTVCQTI5SDlPMFR6dkVBM3JtRWRtK1dRUW1S?=
 =?utf-8?B?UzV3dFg0Wk5jZGVXOVQ5L0dyeHFFaGxyL0JTaElHVWg3Qi8vMUhIU2Q3L3hS?=
 =?utf-8?B?SHc0b2tlSmcraTlYUWdiV0d0MVdKYTVnNjVqY0dsZ01wNjQxamF6bnhMb1A1?=
 =?utf-8?B?ejd0aVNHSEd2cktaYmdPNTJ0ZVpZWVZZQnpHV3RocDJBYUlOQlZBcUxRbkZB?=
 =?utf-8?B?dDdlMWx4WUdwczlsVk9iMCtsQm1INjhUVzZ0cXM2T3NNRjM4dU5ISGRodjdH?=
 =?utf-8?B?MWlxVGFLdThPZGQ2aSsvZFZiZTJCWElsb2I5Y3BqcWFqdk9Gb1JRNGlxV1h5?=
 =?utf-8?B?NjludXRPYmlsdFU4c1hNYnVIbmd1c3RKaU1JTTBzZDNBNURMaVFPdmVycFB0?=
 =?utf-8?B?bHVYMjI5TkxNckdqWWRlZHpkeis0YXh0eWJ4ZFc2U2M1bURoeDZJbEFpRVpS?=
 =?utf-8?B?VzZyS2tGbmNrV3hYcUp6RmUya2Q4Z01GdmhpZDZydi9NODVEM1RodnFjNGRh?=
 =?utf-8?B?b0MwN0hqN2lVdGdGQmVxak1qV3QxMzlhd2JNQnJESUNkenYxQjkrbkNoRnRP?=
 =?utf-8?B?MU1mVUt2dEhrMXhoVW9VaFExZXRqOTVGMGpFeWdpTnFSa1J5N2xjR3Q5QWFm?=
 =?utf-8?B?ZTk3MVhKQ0tVRjVrdXB3Y0ZocEs4ZGxHYkpmSHBUY1NjMnBTbG1lUGFYRThO?=
 =?utf-8?B?T0dZRmZ3S3RxQmZ6b2ZWbzhHM3dQUHhHV0dsRmIwSy9oNzRkZUZaUUFGSXpU?=
 =?utf-8?B?MjBpTUQxbGxWbWlKaCszaFNZaDlxd2V2Zi9LSXp3K1hFYytGcE5lMUw0NUxK?=
 =?utf-8?B?a1pkMjhxRzc4V1Rrcm5XeW0xSWVpNmVRVEQ1Mkt2T0VyZWxmQjZtVzVzc0d0?=
 =?utf-8?B?RE9MOWV5bTdqOEpZZ3dFRG5TSkJMc0JoanN4b0hPbVM1MWpvclpqdUxUeG1Y?=
 =?utf-8?B?YWpXL0RrdlN0amdPUCs5bUN1SGJuaDJTeDBHVWhlT3dsVU0vQTV2WDJLZWNv?=
 =?utf-8?B?Y1ZRTmJIbEk2RUk1VVJLZEJlM3JZTHowODZZR2lWSHRtb2dNNG1wRWV2YnZE?=
 =?utf-8?B?aTFvVHorZlNTWkliYkFpK2YzTGZOL21pQmdUYTRRVmc0dW4zUURtS0JuWVBj?=
 =?utf-8?B?MUNUQW1EYTQ4QW4wWC9Rbi95c3lMT3hLWGpBUHF5aG5ZaG9mZDFwNXF4Q2Zs?=
 =?utf-8?B?dkdpeEVmRkRPQXF2Um1Wa3pCaE5ZandqUUV1SFVQY3RFd21mMnRCT2NLVys0?=
 =?utf-8?B?Z3FGMEVMZzJZeWZnYUxyYVJmRFE2T1JxdXg3NmJCZEZTYldlZXZ0eUNHclBZ?=
 =?utf-8?B?UVpER1lSTTNOQ25rWkNpQjgyZjBZS1IwMUVXcXN6QnMyMHdKQ1lnMzJIK1hy?=
 =?utf-8?B?SWZxK0VXcVZNUzZ5NG4wVktndjVyWVUweWRQdmlEV2s4SnZXb3hZbEZsVEhw?=
 =?utf-8?B?Zzl2TDl1N0poZDV1UUpQUDhDVzJITzliT0RBL0dqdVBCMnQzL29xN2F5QmRm?=
 =?utf-8?B?WWdXK1lTRzN5SWdDWlJwOFlxdUhSK2tReitoZGhpOExCNFJzNkptNEFDUnc5?=
 =?utf-8?B?NGFRUEl2czlmT0Y0RmVvNGpYTTQxK0xrQ1hLdkN0L1FOWStZeVRLRS9jdldR?=
 =?utf-8?B?UUNhaUl0T2VLdURjNXhhODlBallkcXZFRm8wbUFtUTgzQzZrZEVqQ0laZE9Y?=
 =?utf-8?B?OEd1a0VDR2VYNGZjS0l3Z2p6NWF4TTFPeDdwdUJCOGU4bGt0akdaempqaHJm?=
 =?utf-8?B?OFJqOEZHbTc4dGVraGRva1pGT2xvZlpkL1NQRTM2V1RONmgrUGIxM1VHaDB1?=
 =?utf-8?B?TzhpUEFCSUR6cDBzUmh4UGJ6d3lVd1Jrc2NGNVlWNWxxRkN1OHdsMUNjNm1Z?=
 =?utf-8?B?MFlsWDJIVVhxT0cySTllYWgrRkMwYmNQS0M2aDk0R1V4OVhyYUF4SFBDTm84?=
 =?utf-8?B?dUFTd3FEaW1CZ1kwa1RzZDNwODlVSStiaHFBdmM0T1hiQjA0bDJqVVpRY0tS?=
 =?utf-8?B?TDRLeUhUYXlYWmZRNlM0MnQ3Z3lMZ2lmaVZrdkFPdjh2bXFwMUxXVHFZc0lp?=
 =?utf-8?B?L0kzVHUvc0krQVNsQ1VEdGZyWE5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA8CEAF331E9B6429B2BB67D71D0E641@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6IZu9Pu5WZomXlZSnmmtKduFhVHu6piCiEO0e7UH4FwC8TigyjPMPtuEWGtmV8rbwO0+4356W2pL1dtngC38ubUO28jnw18Ksu96E7yiKdmkMilEZbZefG58fINnXB8BITPEo9svaasdrN0KG+bf4hAzGRQyUukHrVtfCWLPJt7fk59t9wWHxVWZmP+dFWsU6UyUaBvlEzfTJzsT2z9uE7YMPW1rGiCFQb+3tvKAtUS7iXR5vkLVrYPyk5R+VgfTUaA3zpJNas4byXRKcxgHD+sgegpexYobQ8pMZZ59wDec18nh/MbZG7RyN+fWTRFHJgX8HLmunwcm8YXHYzLeMdOollQVomy6TsAnfxBeIvWLrARYu7gg91gO2QrMO7ksrF+i1P7YVxGbIQMaYCz69QKKGocXoyaeTSRLIzx38Vu7eQcec7c/P9hRGRf2G+M7ZZnFkN1Fv/mR/sxultKH3jMj80MMfrTMipaXmedwJEpVjvETb8n1fIX3b3fTjHqXMZVfdsBRsCbtHQLNcd52eSqpDls7CS/mE0/32HvdK5IMPBd4nTRXtMtVtm8CCkkk2mVcS44bHLpfJ7H60JpaCL1MLeN1LKN7vl4t6984i7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5795.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5729686f-4424-43e0-6218-08de207f52b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 17:33:55.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3BBw+L1J0B4tbqpgmrrPA9PIZRBkeTaIY0cvHeiHA99CdlmGBwvNeNpHyorYqXndDkCIliRTYxugqCyXP5IgRRrcnpZLrXf5+vWfyGP28g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100149
X-Authority-Analysis: v=2.4 cv=W8A1lBWk c=1 sm=1 tr=0 ts=69122206 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AiHppB-aAAAA:8 a=yPCof4ZbAAAA:8 a=i0EeH86SAAAA:8
 a=-7ln6tzmnsDdlEDdog4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12100
X-Proofpoint-ORIG-GUID: zMA2iRnW0Eh2X1TyjjLGvgrTp0897_n6
X-Proofpoint-GUID: zMA2iRnW0Eh2X1TyjjLGvgrTp0897_n6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MiBTYWx0ZWRfX3M9+XAdZIkvx
 wVR5oapL1B9o13pdnLkIsjAETNc7EfsLIqWbKZH9xAgFCdqRGh3hzi8qmKRZzIDNrkAgZAHjxfr
 8gSeyix0EY0z1C+h1tShL2hTJSz/K7TaRWvVNep7BEdVBDBi4YbYFqQtMCGT2wol6TTBV3jqxYu
 X6RjwB8YpkOtUULjfS6y15FFWHwj1bi9ZeNO5CnShq/8o4hWDAZzFHDelalDitDggfjP1qxMdht
 wy7bcgHQTyrkeRWx/dOmv0zy1nU0mAZodcJe37lfj1CurRiuODqkhqJcpjl+/n+Qv8OKw8dzC4a
 RmuTzPskzf6d0a9fzbM4XEQAfwKsHDdmm1sdVB1uPJtgN98Kd6e0CvnImMbayvNxG8JlKY4O2HU
 YgpknWUbj6x5dNNAZJ0GhmWLD8wI2dXM4Vfvodh5DwbnroG3Mjs=

SGkgVGhlb2RvcmUgYW5kIEFuZHJlYXMsDQoNCkRpZCB5b3UgZ2V0IGNoYW5jZSB0byBsb29rIGF0
IHRoaXMgcGF0Y2ggYW5kIGhhdmUgYW55IGNvbW1lbnQgb24gaXQ/DQoNCllvdXIgcmVwbHkgd2ls
bCBiZSBhcHByZWNpYXRlZCENCg0KVGhhbmtzLA0KV2VuZ2FuZw0KDQo+IE9uIE5vdiAyLCAyMDI1
LCBhdCA0OjU24oCvUE0sIFpoYW5nIFlpIDx5aS56aGFuZ0BodWF3ZWljbG91ZC5jb20+IHdyb3Rl
Og0KPiANCj4gT24gMTEvMS8yMDI1IDU6MDUgQU0sIFdlbmdhbmcgV2FuZyB3cm90ZToNCj4+IFdo
ZW4gamJkMl9qb3VybmFsX2Fib3J0KCkgaXMgY2FsbGVkLCB0aGUgcHJvdmlkZWQgZXJyb3IgY29k
ZSBpcyBzdG9yZWQNCj4+IGluIHRoZSBqb3VybmFsIHN1cGVyYmxvY2suIFNvbWUgZXhpc3Rpbmcg
Y2FsbHMgaGFyZC1jb2RlIC1FSU8gZXZlbiB3aGVuDQo+PiB0aGUgYWN0dWFsIGZhaWx1cmUgaXMg
bm90IEkvTyByZWxhdGVkLg0KPj4gDQo+PiBUaGlzIHBhdGNoIHVwZGF0ZXMgdGhvc2UgY2FsbHMg
dG8gcGFzcyBtb3JlIGFjY3VyYXRlIGVycm9yIGNvZGVzLA0KPj4gYWxsb3dpbmcgdGhlIHN1cGVy
YmxvY2sgdG8gcmVjb3JkIHRoZSB0cnVlIGNhdXNlIG9mIGZhaWx1cmUuIFRoaXMgaGVscHMNCj4+
IGltcHJvdmUgZGlhZ25vc3RpY3MgYW5kIGRlYnVnZ2luZyBjbGFyaXR5IHdoZW4gYW5hbHl6aW5n
IGpvdXJuYWwgYWJvcnRzLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBXZW5nYW5nIFdhbmcgPHdl
bi5nYW5nLndhbmdAb3JhY2xlLmNvbT4NCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuIEZlZWwgZnJl
ZSB0byBhZGQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogWmhhbmcgWWkgPHlpLnpoYW5nQGh1YXdlaS5j
b20+DQo+IA0KPj4gLS0tDQo+PiBmcy9leHQ0L3N1cGVyLmMgICAgICAgfCAgNCArKy0tDQo+PiBm
cy9qYmQyL2NoZWNrcG9pbnQuYyAgfCAgMiArLQ0KPj4gZnMvamJkMi9qb3VybmFsLmMgICAgIHwg
MTUgKysrKysrKysrLS0tLS0tDQo+PiBmcy9qYmQyL3RyYW5zYWN0aW9uLmMgfCAgNSArKystLQ0K
Pj4gNCBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+
IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL2V4dDQvc3VwZXIuYyBiL2ZzL2V4dDQvc3VwZXIuYw0KPj4g
aW5kZXggMzNlN2MwOGM5NTI5Li5iODJjZWU3MmY3ZTcgMTAwNjQ0DQo+PiAtLS0gYS9mcy9leHQ0
L3N1cGVyLmMNCj4+ICsrKyBiL2ZzL2V4dDQvc3VwZXIuYw0KPj4gQEAgLTY5OCw3ICs2OTgsNyBA
QCBzdGF0aWMgdm9pZCBleHQ0X2hhbmRsZV9lcnJvcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBi
b29sIGZvcmNlX3JvLCBpbnQgZXJyb3IsDQo+PiBXQVJOX09OX09OQ0UoMSk7DQo+PiANCj4+IGlm
ICghY29udGludWVfZnMgJiYgIWV4dDRfZW1lcmdlbmN5X3JvKHNiKSAmJiBqb3VybmFsKQ0KPj4g
LSBqYmQyX2pvdXJuYWxfYWJvcnQoam91cm5hbCwgLUVJTyk7DQo+PiArIGpiZDJfam91cm5hbF9h
Ym9ydChqb3VybmFsLCAtZXJyb3IpOw0KPj4gDQo+PiBpZiAoIWJkZXZfcmVhZF9vbmx5KHNiLT5z
X2JkZXYpKSB7DQo+PiBzYXZlX2Vycm9yX2luZm8oc2IsIGVycm9yLCBpbm8sIGJsb2NrLCBmdW5j
LCBsaW5lKTsNCj4+IEBAIC01ODQyLDcgKzU4NDIsNyBAQCBzdGF0aWMgaW50IGV4dDRfam91cm5h
bF9ibWFwKGpvdXJuYWxfdCAqam91cm5hbCwgc2VjdG9yX3QgKmJsb2NrKQ0KPj4gZXh0NF9tc2co
am91cm5hbC0+al9pbm9kZS0+aV9zYiwgS0VSTl9DUklULA0KPj4gImpvdXJuYWwgYm1hcCBmYWls
ZWQ6IGJsb2NrICVsbHUgcmV0ICVkXG4iLA0KPj4gKmJsb2NrLCByZXQpOw0KPj4gLSBqYmQyX2pv
dXJuYWxfYWJvcnQoam91cm5hbCwgcmV0ID8gcmV0IDogLUVJTyk7DQo+PiArIGpiZDJfam91cm5h
bF9hYm9ydChqb3VybmFsLCByZXQgPyByZXQgOiAtRUZTQ09SUlVQVEVEKTsNCj4+IHJldHVybiBy
ZXQ7DQo+PiB9DQo+PiAqYmxvY2sgPSBtYXAubV9wYmxrOw0KPj4gZGlmZiAtLWdpdCBhL2ZzL2pi
ZDIvY2hlY2twb2ludC5jIGIvZnMvamJkMi9jaGVja3BvaW50LmMNCj4+IGluZGV4IDJkMDcxOWJm
NmQ4Ny4uZGU4OWM1YmVmNjA3IDEwMDY0NA0KPj4gLS0tIGEvZnMvamJkMi9jaGVja3BvaW50LmMN
Cj4+ICsrKyBiL2ZzL2piZDIvY2hlY2twb2ludC5jDQo+PiBAQCAtMTEzLDcgKzExMyw3IEBAIF9f
cmVsZWFzZXMoJmpvdXJuYWwtPmpfc3RhdGVfbG9jaykNCj4+ICAgICAgICJqb3VybmFsIHNwYWNl
IGluICVzXG4iLCBfX2Z1bmNfXywNCj4+ICAgICAgIGpvdXJuYWwtPmpfZGV2bmFtZSk7DQo+PiBX
QVJOX09OKDEpOw0KPj4gLSBqYmQyX2pvdXJuYWxfYWJvcnQoam91cm5hbCwgLUVJTyk7DQo+PiAr
IGpiZDJfam91cm5hbF9hYm9ydChqb3VybmFsLCAtRU5PU1BDKTsNCj4+IH0NCj4+IHdyaXRlX2xv
Y2soJmpvdXJuYWwtPmpfc3RhdGVfbG9jayk7DQo+PiB9IGVsc2Ugew0KPj4gZGlmZiAtLWdpdCBh
L2ZzL2piZDIvam91cm5hbC5jIGIvZnMvamJkMi9qb3VybmFsLmMNCj4+IGluZGV4IGQ0ODBiOTQx
MTdjZC4uZDk2NWRjMGI5YTU5IDEwMDY0NA0KPj4gLS0tIGEvZnMvamJkMi9qb3VybmFsLmMNCj4+
ICsrKyBiL2ZzL2piZDIvam91cm5hbC5jDQo+PiBAQCAtOTM3LDggKzkzNyw4IEBAIGludCBqYmQy
X2pvdXJuYWxfYm1hcChqb3VybmFsX3QgKmpvdXJuYWwsIHVuc2lnbmVkIGxvbmcgYmxvY2tuciwN
Cj4+IHByaW50ayhLRVJOX0FMRVJUICIlczogam91cm5hbCBibG9jayBub3QgZm91bmQgIg0KPj4g
ImF0IG9mZnNldCAlbHUgb24gJXNcbiIsDQo+PiAgICAgICBfX2Z1bmNfXywgYmxvY2tuciwgam91
cm5hbC0+al9kZXZuYW1lKTsNCj4+ICsgamJkMl9qb3VybmFsX2Fib3J0KGpvdXJuYWwsIHJldCA/
IHJldCA6IC1FRlNDT1JSVVBURUQpOw0KPj4gZXJyID0gLUVJTzsNCj4+IC0gamJkMl9qb3VybmFs
X2Fib3J0KGpvdXJuYWwsIGVycik7DQo+PiB9IGVsc2Ugew0KPj4gKnJldHAgPSBibG9jazsNCj4+
IH0NCj4+IEBAIC0xODU4LDggKzE4NTgsOSBAQCBpbnQgamJkMl9qb3VybmFsX3VwZGF0ZV9zYl9s
b2dfdGFpbChqb3VybmFsX3QgKmpvdXJuYWwsIHRpZF90IHRhaWxfdGlkLA0KPj4gDQo+PiBpZiAo
aXNfam91cm5hbF9hYm9ydGVkKGpvdXJuYWwpKQ0KPj4gcmV0dXJuIC1FSU87DQo+PiAtIGlmIChq
YmQyX2NoZWNrX2ZzX2Rldl93cml0ZV9lcnJvcihqb3VybmFsKSkgew0KPj4gLSBqYmQyX2pvdXJu
YWxfYWJvcnQoam91cm5hbCwgLUVJTyk7DQo+PiArIHJldCA9IGpiZDJfY2hlY2tfZnNfZGV2X3dy
aXRlX2Vycm9yKGpvdXJuYWwpOw0KPj4gKyBpZiAocmV0KSB7DQo+PiArIGpiZDJfam91cm5hbF9h
Ym9ydChqb3VybmFsLCByZXQpOw0KPj4gcmV0dXJuIC1FSU87DQo+PiB9DQo+PiANCj4+IEBAIC0y
MTU2LDkgKzIxNTcsMTEgQEAgaW50IGpiZDJfam91cm5hbF9kZXN0cm95KGpvdXJuYWxfdCAqam91
cm5hbCkNCj4+ICogZmFpbGVkIHRvIHdyaXRlIGJhY2sgdG8gdGhlIG9yaWdpbmFsIGxvY2F0aW9u
LCBvdGhlcndpc2UgdGhlDQo+PiAqIGZpbGVzeXN0ZW0gbWF5IGJlY29tZSBpbmNvbnNpc3RlbnQu
DQo+PiAqLw0KPj4gLSBpZiAoIWlzX2pvdXJuYWxfYWJvcnRlZChqb3VybmFsKSAmJg0KPj4gLSAg
ICBqYmQyX2NoZWNrX2ZzX2Rldl93cml0ZV9lcnJvcihqb3VybmFsKSkNCj4+IC0gamJkMl9qb3Vy
bmFsX2Fib3J0KGpvdXJuYWwsIC1FSU8pOw0KPj4gKyBpZiAoIWlzX2pvdXJuYWxfYWJvcnRlZChq
b3VybmFsKSkgew0KPj4gKyBpbnQgcmV0ID0gamJkMl9jaGVja19mc19kZXZfd3JpdGVfZXJyb3Io
am91cm5hbCk7DQo+PiArIGlmIChyZXQpDQo+PiArIGpiZDJfam91cm5hbF9hYm9ydChqb3VybmFs
LCByZXQpOw0KPj4gKyB9DQo+PiANCj4+IGlmIChqb3VybmFsLT5qX3NiX2J1ZmZlcikgew0KPj4g
aWYgKCFpc19qb3VybmFsX2Fib3J0ZWQoam91cm5hbCkpIHsNCj4+IGRpZmYgLS1naXQgYS9mcy9q
YmQyL3RyYW5zYWN0aW9uLmMgYi9mcy9qYmQyL3RyYW5zYWN0aW9uLmMNCj4+IGluZGV4IDNlNTEw
NTY0ZGU2ZS4uNDRkZmFhOWU3ODM5IDEwMDY0NA0KPj4gLS0tIGEvZnMvamJkMi90cmFuc2FjdGlv
bi5jDQo+PiArKysgYi9mcy9qYmQyL3RyYW5zYWN0aW9uLmMNCj4+IEBAIC0xMjE5LDcgKzEyMTks
OCBAQCBpbnQgamJkMl9qb3VybmFsX2dldF93cml0ZV9hY2Nlc3MoaGFuZGxlX3QgKmhhbmRsZSwg
c3RydWN0IGJ1ZmZlcl9oZWFkICpiaCkNCj4+IHJldHVybiAtRVJPRlM7DQo+PiANCj4+IGpvdXJu
YWwgPSBoYW5kbGUtPmhfdHJhbnNhY3Rpb24tPnRfam91cm5hbDsNCj4+IC0gaWYgKGpiZDJfY2hl
Y2tfZnNfZGV2X3dyaXRlX2Vycm9yKGpvdXJuYWwpKSB7DQo+PiArIHJjID0gamJkMl9jaGVja19m
c19kZXZfd3JpdGVfZXJyb3Ioam91cm5hbCk7DQo+PiArIGlmIChyYykgew0KPj4gLyoNCj4+ICog
SWYgdGhlIGZzIGRldiBoYXMgd3JpdGViYWNrIGVycm9ycywgaXQgbWF5IGhhdmUgZmFpbGVkDQo+
PiAqIHRvIGFzeW5jIHdyaXRlIG91dCBtZXRhZGF0YSBidWZmZXJzIGluIHRoZSBiYWNrZ3JvdW5k
Lg0KPj4gQEAgLTEyMjcsNyArMTIyOCw3IEBAIGludCBqYmQyX2pvdXJuYWxfZ2V0X3dyaXRlX2Fj
Y2VzcyhoYW5kbGVfdCAqaGFuZGxlLCBzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoKQ0KPj4gKiBpdCBv
dXQgYWdhaW4sIHdoaWNoIG1heSBsZWFkIHRvIG9uLWRpc2sgZmlsZXN5c3RlbQ0KPj4gKiBpbmNv
bnNpc3RlbmN5LiBBYm9ydGluZyBqb3VybmFsIGNhbiBhdm9pZCBpdCBoYXBwZW4uDQo+PiAqLw0K
Pj4gLSBqYmQyX2pvdXJuYWxfYWJvcnQoam91cm5hbCwgLUVJTyk7DQo+PiArIGpiZDJfam91cm5h
bF9hYm9ydChqb3VybmFsLCByYyk7DQo+PiByZXR1cm4gLUVJTzsNCj4+IH0NCj4+IA0KPiANCg0K

