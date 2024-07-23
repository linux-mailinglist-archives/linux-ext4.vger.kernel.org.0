Return-Path: <linux-ext4+bounces-3379-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E0493A1E3
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 15:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1894D1F237AD
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D0413775B;
	Tue, 23 Jul 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IUx9YEFF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wlRzB1Vt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2392D03B;
	Tue, 23 Jul 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742388; cv=fail; b=kqWfpb3dHFMLDdfrt8ETPtTR9+7axNkDZZE45cjF4fVICAJ4R9xVKqUtKMqQvT4f6qDFlaSOoJ9ezRvYvDTfkoGP4u6eKKpHoHiYgMBOzCDg8q+DIwbUTbaWfSUsSIOxLtLW2C4l57jI45SuP6NmG557A0CdaX2YOPIElMIB5/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742388; c=relaxed/simple;
	bh=huMh/r+QbWOjScOLV1P2XJ4lLdrAQSObU5IEXHPm+/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mgwwZBacCEGqRuD5jdR88+hcBS8jKhXwxv5vBwDFb9jUZEcpqtX6KrATEwyz+NOuxum2DqM70aF3c+FUFZ4aWW9qL0xUSGBFnRdfJLCO3rpBGgSEf4h83rfA6i0BmtgpRLe7XrbEuO0FlIMqeoCDbHpEqmAbDWcgNf6qDnQ4krY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IUx9YEFF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wlRzB1Vt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCGS0N019803;
	Tue, 23 Jul 2024 13:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=huMh/r+QbWOjScOLV1P2XJ4lLdrAQSObU5IEXHPm+
	/k=; b=IUx9YEFFVblbTHpvfceG2t1b2AteXwZ+xi3OOIGfj+n4Hh8NYPqcj1Kiz
	PVE/7kv6QDdczRQ0zLPs/uWJIprvJH5Rj10izYcT/F9o2ipv60hnBx2jd+ZcPuKE
	m1mqOI0Ak3A4zVJSYMKdRGPoTqWCNMAn9GgogbEgtYpAlGV6RMX8r11KY9dV8Vgg
	n0z73ZOEZ25TUD5TGVpc0T+mun4P/m5Nrpj6ZieSfWKqiNdFwxKkzGv3uoVR6KwM
	vfE/NhIkRUGt7ZuH6YtcfT3+WUiPe5dKr+F9WxsXjnf2iEL6b4T9ieltOhRLb/I1
	Lp+MLCVE5olX8VgWADVPPnFMsU5jg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0em3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:44:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDErWp034308;
	Tue, 23 Jul 2024 13:44:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27mjx5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6AEnz05yWtsFDyX4cdCe3WpnDTrap96TGS5p2a6StJc5WGDa4KKGmAacftBzoUQNHk+ASYxfwRwzX+nlfa4B2GjoNKoPmxL6bcvVxyPQOKv7o//jLEdXnNTGVJhVxYXWTPVnwmZZziE13F598xSSi8oweuX1zXvvPkXP2vPBCbRa2IA4/tMW5sxHbV+E2HNfY+9XjMyQBqqEmgi5VbpclrW3wbLCtRWEi+f8a5mAC5FiKhLiRDx19foaZyAshvtreaXqgMIJa0mZE8kCr13UKJ0LwELT8/TehkpPaiUTJ0MzW/BnqxCnhAOQQ+WG956LytXgc4cgbVctuFvukVWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huMh/r+QbWOjScOLV1P2XJ4lLdrAQSObU5IEXHPm+/k=;
 b=dLBFwGwHO3VO3POK30QrdWOvWWsM9sOy0YbRBpQuWOyz1XndtX64G+mMONfykh0R8s6E6C9Oud+7tm7AC0ZKLx6QmC8KISf/YbEzVt0s3G8PSY2jieM2eXMFiXSw52xTKAU0cVtvKGhjBEP1GVRJLUvqfHFRkhgUfgHMgV0iM30bGNpNpiPu6wLkx1x2jOiBtS54lHWgBYVv7nhHuaWu9LeCCbLchsV5u783tRxBKcNveN/Zazku9WKdZfp7QvNLVUoNKbd52deKClvzv7aWW1V9dv8kMOeL8eBeIQxFrhtOLhUZa9jo3Zo1yrnC9wPSra7xnp57ppWpY0ZUJE6b6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huMh/r+QbWOjScOLV1P2XJ4lLdrAQSObU5IEXHPm+/k=;
 b=wlRzB1VtJ/vpuZhvYpDL+0SQCRIlvOm5AL6bM1KzFMSRaDi8NpGNvvY6DvGtZNQfwllRNXi3PRd8LO+jkK6AV8AIf2NIOsK4qWMpyL5RtrABqbgvquzQ4EBqulDJRG3X/zLdXsORuMoPPTlqWB7iq53khPNqdkyBW7uJpnp5mYQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB8204.namprd10.prod.outlook.com (2603:10b6:408:291::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 13:44:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 13:44:10 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jan Kara <jack@suse.cz>
CC: Ajay Kaher <ajay.kaher@broadcom.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
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
Thread-Index: AQHawX+uwoYrLA2UOkeTCBaoZEb1HLIEGqyAgAAn5wCAAEcrgA==
Date: Tue, 23 Jul 2024 13:44:10 +0000
Message-ID: <2DC97A3F-6FEE-4509-ACD1-8216D5C217D5@oracle.com>
References: <20240618123422.213844892@linuxfoundation.org>
 <1721718387-9038-1-git-send-email-ajay.kaher@broadcom.com>
 <20240723092916.gtpvnifv2rizbyii@quack3>
In-Reply-To: <20240723092916.gtpvnifv2rizbyii@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV3PR10MB8204:EE_
x-ms-office365-filtering-correlation-id: 79c625a6-43ce-492f-e8cc-08dcab1d8826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXJDak9zdzQzTXJGM0hTMi9VUVBEYWhoWHN4WjRmdkJydCtVV3hvSCtZOE8v?=
 =?utf-8?B?Tzk3eTVlNWc5czZBQ2d4WUk2a0xMR0hvTThYK1V3Rll4R0xqM1RpSWF0aHR0?=
 =?utf-8?B?Q1BLdkZ5RUpERzVTdWd4NUFoYW9WcUhqejNLK1hpdFdoNDIzTHlnejh1dTFK?=
 =?utf-8?B?empxU3VJWTVqT2FYWVk4MUd3bnozMnZGeXFheTFNSVJBVHArZWc3RHAzUVY2?=
 =?utf-8?B?TjYzaVhUSzRHZDI4TkpxR3l6UGZ2b011UHJoM3czaWlJT3kwejZLOEd5Z2FF?=
 =?utf-8?B?bnRFSU56NHgyeWcyVVhLbGU1MlZBTTZtcTViU1ZLT0V6bXhmTFA4NHF2R29F?=
 =?utf-8?B?cU0yMHFDZEFpWm10MHZHQzdhMFkvRWxiUFNKa3YzUWNzOWpHTkptV0YrVUow?=
 =?utf-8?B?YWRSYW5ScFpMQ1h5VG9pclVDREVFNmpadnhkS2hWeGlqK0FHTnVyMnZIVnFx?=
 =?utf-8?B?aW4ycEwrUVpvNnMxL0RMa1Y2ZmwwSU03b2VCMlBpaWlLdFhhNFlZSjgzbXFM?=
 =?utf-8?B?YWJiQjlxZ2o2YjVmS2dITFhPNWdmcVRnUitrM0FrZjRIb2ExUXpJVlpmazZi?=
 =?utf-8?B?Ris0NkVhc1VKUWJnVFdhWUNwR2crU3V1YmltQUl6M21sK1JRYVkzVGFJSmR6?=
 =?utf-8?B?UDcxbExRWm0wV2FxOEFJRHFsWS9JL2UrQzhzN2IwUkJ2YXJZT1k3MldNcDZ6?=
 =?utf-8?B?WTdjOVFDUnRRTzNCc2Z0OXhpb0lxeTM0L0VPTVpnRDFFTVh5ZlhUalVGUEtv?=
 =?utf-8?B?WmtGcTlMTloxNnE5UExTZythRjY4cktwZk9FMFR4VlJUME04b1A0UmVmNHZU?=
 =?utf-8?B?bXRHTUsvUG5vNzh0aUFndHU0YUJxanpSQnREWVZDTmhBMHlNQ1ZFZXZXZDFN?=
 =?utf-8?B?enFIbFl6UkVrQWp1NmRCWkhIcFdFVkx3RFVNeEJaRVpxd0xKb2QyU2dLWVBw?=
 =?utf-8?B?Q2RLNFZJOUU5Zi9DNS8rSXcrVkJQakNBY2QwcUtEVTFsK3FURE9Ed2pKZ2dM?=
 =?utf-8?B?WTVUWFBxWWwwUmdqelUrWnpiZ3RRWThWc2p2SWl6N1U0L09zTFgrNHNaR3Ji?=
 =?utf-8?B?NE9ydXQ2aVB6UWRFWHEwNnZ1V1Z6SDlIYUIxQW5panFIeWkwSE10VEtOVXNq?=
 =?utf-8?B?em5KeHlZYkNpRzFuTlhobXhrbzBSYnIrTjBYN0dadXFnQkEzay9sODErUWFo?=
 =?utf-8?B?OGJLaG5GcDBjeDJnQy8wS05udGdTVStJTnVmTXU0TllJSVl5QWFVaHRZVTg1?=
 =?utf-8?B?cnViQjNBYUQ1U0pBem50QkNEN2dMTnpTOTJKODNsYXFiQkxtdmVkRzNwNTBw?=
 =?utf-8?B?TUI5cHZKQUVzemNnRTMvQWZ5Yi82SjJZaWthOEJzdkhIQUc5UTgwZUJNWGlm?=
 =?utf-8?B?MEpaODNNbTF1WEh1RlJyZGRlWGE5N3FkNFIzbWFBY2RsRlEzT21DVWNzdGQx?=
 =?utf-8?B?a1hQRFpzcCt5V2V6bjlKbTZpS3kxYkZGSUFIR3VxUTl1M3dzWVdnQ1BpS09G?=
 =?utf-8?B?VTUyOUFDbXVvS21nTWZ2eCtzQ3ZzM2xhdlBqbkMya3JOTkhtbzVobDRFNkJm?=
 =?utf-8?B?bjVMOE8wME5nSnBYS0d3Q2RmT3k5cWJ6VG13WVlVNGJkY3RYT2hXeHpBSHRr?=
 =?utf-8?B?RFZmbDlVU1V6WEg5Z211c0M0SWpwcnJJM0JlQnh5ajhxaDVhRU5BNWd2Y3E3?=
 =?utf-8?B?cGtiWXh3K01nbzk3ZWNnQVhyeTBKQ1k2THV3emh6blgxR2tKR3NKWFdTSjZa?=
 =?utf-8?B?dXQvWG1vK05DQkpGeEVVdU5pejJKQk9qbCtaSjJYOG1VSHQzeVJiTUxZTC8y?=
 =?utf-8?Q?ohaTnBuDbX/n6bWCyeAtWcYfHuBpADs9dNZUY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2dzUFpBY040NWJjTFZWZG1xNldLRkNUVjZTVW80N0tXWTliTFQ0S1BxdVFv?=
 =?utf-8?B?NTVFUGxNbEtIOFBzOVQ4NjBidzI5V3pXY04xR2JJUi9MVis0eDhhK2FYVzk2?=
 =?utf-8?B?YWJZZVk5dG0zbTM3aWdSYklDQ0RGVzI0SXpyd3RJWjNJUWd5ZHRtYWFENzVt?=
 =?utf-8?B?RE11U2Z6d2tZUUdmT3RETE00dXFZT0VieGhoQnFBUDV1RlFKNmRZaXBPNjZK?=
 =?utf-8?B?QkxmRi83T0psaWdTcjl6L3BiUzdTNWlNaWdlOHo4SlBFbjdpRFZ2V09HWFp1?=
 =?utf-8?B?ZlJiWHprbituaWp3Z3dWcUplNWpmbmU3dmpLZDA5dStQdGtkVkliV1ZPb3Fm?=
 =?utf-8?B?dWRHQ2JTTGJRU2tUVXNvSi9KY24waWx4QzB0NUUwMCtzbVpUS01KUTQ4YytZ?=
 =?utf-8?B?SjNNeWlPK1IrQytTNnh1bWxsT044Z2Y0K29sWU5iL282bS91RmNCdWFzSVBu?=
 =?utf-8?B?bmM3ckhLTmFVajhrQmE5czlEdTZGYllHZjhQUHBqc3VGbkVLNlV4Z01EbXJF?=
 =?utf-8?B?cUFDU0ZkNUprOUxMZDUweGI5b1Nnd0VSclFCNVRhMEVBc1hkU1RBUk1yUEh3?=
 =?utf-8?B?V0hUeTUxZUlnbFV0bW9jeEJZRG9WekVJNXlqVWVoblRWUWthUTJ5bHNKVUw1?=
 =?utf-8?B?VFE5cjB0ek0wNG1Jb3hacGdjaEhXcTlQOHB1R2M4c2dOWGcrYkU1Y0lncDVO?=
 =?utf-8?B?K2dBT2d4ZjFlUjV4bGJzZHNwVUh5MWtOMEJ3dTdrRitJZHlwalozNUFMTjMz?=
 =?utf-8?B?bHIwTjJtS2hRYURHWHZLUmhuYjhGLzR3UjF5UTFMdmU1N0l5Wmd0RnlKdUNI?=
 =?utf-8?B?VFJyak1ZM1g1WWpNV2l4bHAxQ2ttWGxQN3dGbURxNmZrZjVIemIrZmN3eW42?=
 =?utf-8?B?QWFCNUZmUXZZS1puVVh6czNEWmRkaHpOaUpRWEZPYmFoRnpFYlN0dkp2a3o0?=
 =?utf-8?B?VVRQMHl1eHBabm1raURtVkE4ZWNZN1FjakRQbkQ2cnNvSWlJUTZVTEU0ZU05?=
 =?utf-8?B?U0VJV2Qva1IyU055VVVUUmZsa093Wlc2bmhoRDNLcnUzSURZdmEvbnVUelJI?=
 =?utf-8?B?cStoSW1zRmlDa2I2S09NUDMxUTA3NUl2TGR2ejM4WVVhZGtHdmRtNGZxSUZT?=
 =?utf-8?B?NzhLT2h4TUw5V2kyQzBSSUoxOC9FU25iWlJxUDhtMVRVdTV2T0NqamIraElR?=
 =?utf-8?B?dkZUR1V3VG9kYVp3SVdVMHZ6ZTNpcnM1VzBXTFAwck5iZzZaMThXVlZuanJP?=
 =?utf-8?B?RHdRQktrQ3JxblR5Rnl4bk1CTStnS3dKVE1BcDVabTdrNFZDQSs5WjFuNTh1?=
 =?utf-8?B?cEVFelVwMTkzN3VOQ1FaOUQzUDR0YWxLSWJVVmsydGc3ZlpaZytXV1Z6cXRa?=
 =?utf-8?B?QTVWNmdoQmo2bnlpT1daMVNtSkxVL3BhTXcxazZocUlkQlRtclFxMnlCZU5V?=
 =?utf-8?B?Mlp1U2RqRnJISlJkOElwcnhyZllhajgwNFlPOU0xbnVnci9ZKysrbmFaNnNx?=
 =?utf-8?B?ZFFGRUx4dDE0eXE3c0RYbWtKbWVSK09LalVmcjVrZmVLcHcyUlRMeHRZM3NM?=
 =?utf-8?B?WmZwNU50N2lzRHp6bjQ0SXJESHYvbWltUkcrWlUzVDJueUxsc0FrV1hYYXFI?=
 =?utf-8?B?OCt5TzNCcHpnR1hzaW43OElhZFJkbTlBRVcrSDRIYWdXb2N6Nk5WZ3UzTmM5?=
 =?utf-8?B?SzJ6cVVOWHl0TGdRazBGS3N3MXJTYXFqakdTS05sUFBZbzdlcXVmT0tJZUZ4?=
 =?utf-8?B?V015Snh0a3Q3UTBsQ2NDN2lSN056bEJtN3JmNWUzaGk2N1k5Qmh0T3dsN3JT?=
 =?utf-8?B?ZjFuTVVDOEZrNEYwTE16dVMwWU1jby9tcGpCenErSDhWNXFNc3Z3T2tXUno4?=
 =?utf-8?B?UmpHdG5SNmhzZEEvS2JPZVpSaG85c3lJdjVPMEFLQkgyb1ljUVFmMGVLdGl3?=
 =?utf-8?B?M25OZC9yaW1ZY1llMi9ZUzkvK01ZUFpSaHFwcGp0eGFiaGdtcmZnZVJVVHkr?=
 =?utf-8?B?R2VrRWN1R1daam1hUnJhMFhuc2xTajU3am5nTUxjM2xIV1ZzeE90NHVsRXlH?=
 =?utf-8?B?aXBFaDQ3djBLQUVmRmQwdXhyK2VxWGNhOUp5RUx4bVcxczhKMmMxVEkyZVRq?=
 =?utf-8?B?N1lLVlIrTHhxTDFtb3l5dHIrV3BYQTFJOHBMVUFyMXBTYTZKUGdhbXJDakZ5?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B27A8070CE3FD449AA3F8FCE277A427@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IOCWI1V2gLOqBfxcx6r9yqZRA2mzt6OST0LGeiKrtMyAu6g3M6OtyiUjdAYR5VHwFt771pgpy9lhJF/DsdfjO8ZBP3C38ftSKGCkteVwb7ZeG3TylSVTwngCwJAAzM9SJONpz+OxAh2jnHbCH7rR36T/Zz/rbyBkPptZ/GZaqiqEl6ii43oRxOVVyuhRBwpDGqJTG2yz4J90IIvHV76i2hr7WvZSFyJnnemHUP94qe+EOIpmwxBcJ83LP5ZyqCT/8rCmJ7IZ8WcZm3bXnv42vpx+aure6mfg/XSaEGCZpV0ZmDRYCYn++bfdEhyTWFXwRiERB850DONxNKK/OQuVFe/yYL7J3e/IIXsfA/KBrwAvwFdZF+TOsaFkq51KCNu1W9Ostglc3wTFkZ5mSWnQTbjJ16/Y9NKBaxGUZ3L5mIHHEOScc4/MmWJ+GO3t6o8SAewVaAO9f9vsFReRpWlxYZQxsKwIrTU00pAPPIOP5I7UebIkCs3ASKZ91UWZnmz91tv7X4W6colVE+v2eSm2SIe7jugb7VkVUBT7sVeYuFZr+lnSqd3pbrmDjwVu9FlifgP5LQWwMlUVUZtE+63MjXwLmoZv6BUcs4nh8xUWTDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c625a6-43ce-492f-e8cc-08dcab1d8826
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 13:44:10.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuYIr6kuq/4UqBwTnMFHeAw8AiSr0dyhqgRkHsejbCDynDFYmy+eiFcGvQsMNaleLhC8yrJXIrvNOE/X4brVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230098
X-Proofpoint-GUID: tSEPxmePYrii2SGucuaLffhT_ws9XGgu
X-Proofpoint-ORIG-GUID: tSEPxmePYrii2SGucuaLffhT_ws9XGgu

DQoNCj4gT24gSnVsIDIzLCAyMDI0LCBhdCA1OjI54oCvQU0sIEphbiBLYXJhIDxqYWNrQHN1c2Uu
Y3o+IHdyb3RlOg0KPiANCj4gT24gVHVlIDIzLTA3LTI0IDEyOjM2OjI3LCBBamF5IEthaGVyIHdy
b3RlOg0KPj4+IFsgVXBzdHJlYW0gY29tbWl0IDk3MDliZDU0OGYxMWEwOTJkMTI0Njk4MTE4MDEz
ZjY2ZTE3NDBmOWIgXQ0KPj4+IA0KPj4+IFdpcmUgdXAgdGhlIEZBTl9GU19FUlJPUiBldmVudCBp
biB0aGUgZmFub3RpZnlfbWFyayBzeXNjYWxsLCBhbGxvd2luZw0KPj4+IHVzZXIgc3BhY2UgdG8g
cmVxdWVzdCB0aGUgbW9uaXRvcmluZyBvZiBGQU5fRlNfRVJST1IgZXZlbnRzLg0KPj4+IA0KPj4+
IFRoZXNlIGV2ZW50cyBhcmUgbGltaXRlZCB0byBmaWxlc3lzdGVtIG1hcmtzLCBzbyBjaGVjayBp
dCBpcyB0aGUNCj4+PiBjYXNlIGluIHRoZSBzeXNjYWxsIGhhbmRsZXIuDQo+PiANCj4+IEdyZWcs
DQo+PiANCj4+IFdpdGhvdXQgOTcwOWJkNTQ4ZjExIGluIHY1LjEwLnkgc2tpcHMgTFRQIGZhbm90
aWZ5MjIgdGVzdCBjYXNlLCBhczogDQo+PiBmYW5vdGlmeTIyLmM6MzEyOiBUQ09ORjogRkFOX0ZT
X0VSUk9SIG5vdCBzdXBwb3J0ZWQgaW4ga2VybmVsDQo+PiANCj4+IFdpdGggOTcwOWJkNTQ4ZjEx
IGluIHY1LjEwLjIyMCwgTFRQIGZhbm90aWZ5MjIgaXMgZmFpbGluZyBiZWNhdXNlIG9mDQo+PiB0
aW1lb3V0IGFzIG5vIG5vdGlmaWNhdGlvbi4gVG8gZml4IG5lZWQgdG8gbWVyZ2UgZm9sbG93aW5n
IHR3byB1cHN0cmVhbQ0KPj4gY29tbWl0IHRvIHY1LjEwOg0KPj4gDQo+PiAxMjRlN2M2MWRlYjI3
ZDc1OGRmNWVjMDUyMWMzNmNmMDhkNDE3ZjdhOg0KPj4gMDAwMS1leHQ0X2ZpeF9lcnJvcl9jb2Rl
X3NhdmVkX29uX3N1cGVyX2Jsb2NrX2R1cmluZ19maWxlX3N5c3RlbS5wYXRjaA0KPj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLzE3MjE3MTcyNDAtODc4Ni0xLWdpdC1zZW5kLWVtYWls
LWFqYXkua2FoZXJAYnJvYWRjb20uY29tL1QvI21mNzY5MzA0ODc2OTdkOGMxMzgzZWQ1ZDIxNjc4
ZmU1MDRlOGUyMzA1DQo+PiANCj4+IDlhMDg5YjIxZjc5YjQ3ZWVkMjQwZDRkYTdlYTBkMDQ5ZGU3
YzliNGQ6DQo+PiAwMDAxLWV4dDRfU2VuZF9ub3RpZmljYXRpb25zX29uX2Vycm9yLnBhdGNoDQo+
PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9zdGFibGUvMTcyMTcxNzI0MC04Nzg2LTEt
Z2l0LXNlbmQtZW1haWwtYWpheS5rYWhlckBicm9hZGNvbS5jb20vVC8jbWQxYmU5OGUwZWNhZmU0
ZjkyZDdiNjFjMDQ4ZTE1YmNmMjg2Y2JkNTMgDQo+IA0KPiBJIGtub3cgQ2h1Y2sgaGFzIGJlZW4g
YmFja3BvcnRpbmcgdGhlIGh1Z2UgcGlsZSBvZiBmc25vdGlmeSBjaGFuZ2VzIGZvcg0KPiBzdGFi
bGUgYW5kIGhlIHdhcyBydW5uaW5nIExUUCBzbyBJJ20gYSBiaXQgY3VyaW91cyBpZiBoZSBzYXcg
dGhlIGZhbm90aWZ5MjINCj4gZmFpbHVyZSBhcyB3ZWxsLg0KDQpGd2l3LCBJIGRpZG4ndCBzZWUg
YW55IG5ldyBmYWlsdXJlcyBmb3IgZWl0aGVyIDUuMTAueSBvciA1LjE1LnkuDQoNCg0KPiBUaGUg
cmVhc29uIGZvciB0aGUgdGVzdCBmYWlsdXJlIHNlZW1zIHRvIGJlIHRoYXQgdGhlDQo+IGNvbWJp
bmF0aW9uIG9mIGZlYXR1cmVzIG5vdyBwcmVzZW50IGluIHN0YWJsZSBoYXMgbmV2ZXIgYmVlbiB1
cHN0cmVhbSB3aGljaA0KPiBjb25mdXNlcyB0aGUgdGVzdC4gQXMgc3VjaCBJJ20gbm90IHN1cmUg
aWYgYmFja3BvcnRpbmcgbW9yZSBmZWF0dXJlcyB0bw0KPiBzdGFibGUgaXMgd2FycmFudGVkIGp1
c3QgdG8gZml4IGEgYnJva2VuIExUUCB0ZXN0Li4uIEJ1dCBnaXZlbiB0aGUgaHVnZQ0KPiBwaWxl
IENodWNrIGhhcyBiYWNrcG9ydGVkIGFscmVhZHkgSSdtIG5vdCBzdHJvbmdseSBvcHBvc2VkIHRv
IGJhY2twb3J0aW5nIGENCj4gZmV3IG1vcmUsIHRoZXJlJ3MganVzdCBhIHF1ZXN0aW9uIHdoZXJl
IGRvZXMgdGhpcyBzdG9wIDopDQo+IA0KPiBIb256YQ0KPiANCj4gLS0gDQo+IEphbiBLYXJhIDxq
YWNrQHN1c2UuY29tPg0KPiBTVVNFIExhYnMsIENSDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

