Return-Path: <linux-ext4+bounces-1522-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 277DB872F19
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 07:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD06B21292
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1566E5BAF4;
	Wed,  6 Mar 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ghmu0oQe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K7ksur/X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1741772F
	for <linux-ext4@vger.kernel.org>; Wed,  6 Mar 2024 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708142; cv=fail; b=SVbE2czrNUdqxPO/mrQ97StJd4nI56cWiXOfsHWJ+b+YcqoB85nDVQe9H1B3ZZq69zfDJjk1YQnRi8DgjuxzP9nSUCBgNQmbqjhwXtycLq9OVXeTC+Wr2uYSxr4MT1XGbu/6i3VjAZ3S5eaKDi4baewleQ8qElA9BQGnQPmqf1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708142; c=relaxed/simple;
	bh=MauuEvAyy9vNfXxyvPuAmCk0XNcXuld1y3InsKsru5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNkDkP0HpNA4H/DaDtc/UbKwBFX40Citbv0v+d5xId+Up7bw8iAhJuqQF4j1MddXNw+tVYLCBdsCMsSAt5NjES+YYhyE5shFweQv+BXYltW1IGpcb5FjNbfUG0aM6LIWhRcYo/GUWPj0+LYkGkX9smrjlvXPW8yYKXqYG2aNOPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ghmu0oQe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K7ksur/X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4261ESCv009166;
	Wed, 6 Mar 2024 06:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=e6ZW7iXv1NnOABAEgAb/M+teJGqs0oV85Wjx0WHfvNs=;
 b=Ghmu0oQeGZHFYhVeIxPWpqKYohmL60ueTubii5R/49kug0Qg8cJy0z7kVBYV0iWoTDqk
 WMaiiWQ7B0xIKFNVBZrgtzVPxBNKqVPVq7kimeXYiczTjIsyGX7b7K31/GR/X4j8ir4B
 LYa5/zByBHJsFipOomO/I9jphsu0vhn6vkf+FWdv56mYLsFi/5InK9en6RA2JNMhlfhZ
 oAGWCT55MJpaiNrrdHiGuwZPsZf5XdL0ELKGMPf09v4SaNJI49YcNnsLy1c8yzVqH80K
 sOThE5tA/i+io1NNJgKmZIMPjcoCN06gqeE3ZOJamr1AaV9+Btz8Wg3gCtUWHgSZhrOW iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cg8ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 06:55:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4266b9u5031891;
	Wed, 6 Mar 2024 06:55:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj93bm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 06:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2ss7rhiDyCkIIARPWSljVTBvD6/g5HgB7YC6eXWdRS1KSoDAW9yRC1z4dAAI/KPFvG1UdtCDmT8Zvs8H5npF5rKUiC4nxbeandB+8q6x09MQ8MA//vVj7JctBdnNekYRB7ThSpOXCtdNFJHiSzK3IUf6bja9GV8CTfXDtyBVzZSuekOdfnIC/jpTJiLdFzUHO935fNHboOD+zfp6uDGr9dlU/wAkdapeBDKtWiN7LMohwCRM+8f1UT+0XUTysqgeA/g532UZRL+9CKbwD+ARaEc8IbqZfFkHyTCiVH+D50U5prAl+Aj/XOSmkaLlYX3kuN7b5pt3T3O8w3XEpgscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6ZW7iXv1NnOABAEgAb/M+teJGqs0oV85Wjx0WHfvNs=;
 b=aTnrvZPjJD3PkFrBcfPLUkBg5PjkVmmH3fZhtwCeUbzfXOqFlv6z7ag+7y84u3Q2hLP4Zj+UDx++KuqK9//pI710kH9/4IvjaeuYnr+kftqcTtKuXopd23e9EfWp/L5EuVbXeMOHt1rwa9lLXzXnegbtJC57o/2MsEc7mZuuOPEJpHxfymDO9/8mA5K5KmAcrizYz0URKquNmGH1BnDRPqArC/fsVW2s8dc41DsU2D6UZ6YFfeUUsYcR8XQNxYy1SLHOwe442bqBDj1g78vm8v9ah1dbc9GRFTwWm1H26duIdnDcejgNpzOVTthl+FFxF+O8XM8VnKXrHplqx5syCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6ZW7iXv1NnOABAEgAb/M+teJGqs0oV85Wjx0WHfvNs=;
 b=K7ksur/XlVOZpC12aVi4O2sUHxg72ZFhdt/f9gcD1m6jkB0ZP+DuI3ah7uaKJhkQ4ZJ/PwTzENNBCrK3cYKMLIUDQAcnK0AGcnq3gHrVyrVPcXCgRaXlzcsJpWZUoqpA5SB5BkmvC3M7kpNZVdBgyjW1bQuTZL2F3Yq5TDSr36s=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 06:55:33 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::5f3c:2ca7:f67c:d071]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::5f3c:2ca7:f67c:d071%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 06:55:33 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>
CC: "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: RE: [PATCH] ext4: Enable meta_bg only when new desc blocks are needed
Thread-Topic: [PATCH] ext4: Enable meta_bg only when new desc blocks are
 needed
Thread-Index: AQHab3sgNnst4KeDY0eSTg2qglKft7EqP+cw
Date: Wed, 6 Mar 2024 06:55:33 +0000
Message-ID: 
 <DM6PR10MB434724909C97728F1618F589A0212@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240227131329.2608466-1-srivathsa.d.dara@oracle.com>
 <87o7bsovn6.fsf@doe.com>
In-Reply-To: <87o7bsovn6.fsf@doe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|IA1PR10MB6832:EE_
x-ms-office365-filtering-correlation-id: d1dbc81e-b601-484a-f0c5-08dc3daa6b53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5y4T0wAlIKwBhVSI946EL17IZcUwCq1yH6vGOO+4NSUPHBYSfKbu41HqVv1FgWrywmw+Cw7g3s89iA2TCOpYjH2sPa1j0OTJlt/GwTSmu6nAfBhT+6fm3MG5G/7Gvu6p/mjEpd7Y0kwbwvDb7/h/QredrCkRzD8QRbBMHAQs3Mz5hRXVDJcepfx/dGgiXAoU5hbDcAJobwZbWDihOvJCCR3jcOib/bbZxdUosFcAZ/HOXAx06YPQ9iX1hsX20vv4DSVpyXPvd2nN1kqqQcHIthZ4VTFQsEY5IyneJ5pSfcSidXWdjYIDaqOFcx+JAL1gaXpIF5piox+cSwYnVVXfSpxnw0c3NT6Aq5+ENtYCP4qaN+k6jSD/yg/mDtWhME83eKa7/Xpvzm9fQKZt1DpK/0RTA2jXhdlFw55yLJqcCj6axnexjmPXX/W+o3NMS1gZH9gtye7R9IHA00MI1Z3u36KAM5I8CgmDUHkEpSGa2CEBC81CKlpGPn2xojw/ZH/X13mNuBNTrki4u0veCK2foSJ+fmPOw3S1lHaHAwuTBqhF7HpIRciLCZQLMgCMIfEaza9eNIgOmbEUS6pCtsuSH/HoKmq+m3h47dvaySALoChlVUBcKFl/n6KWlrCqrU+r/4igF+qnFAKYnZYctlnKuWtc3S7hmRm+NdRXmiDgzMkj5+Y3SQ5buxVgt8AEtwKmi6rArRfiRPcR7gFzDUzh1W2fl4kWPY2dTK5TvHt2UH8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UuLuD1hMHpVcI73bP2oj5YFeKC+Z+MMQCQRtTZChKMPGzaSDOYrmBpZnQSlU?=
 =?us-ascii?Q?40rXvxPDg3v56QVMceghaPuc52gTvSBV2akvgLLbJdFYm2PJFWVyw3qqkp5M?=
 =?us-ascii?Q?kz/inFkUjxzpz7ByVqdRfflMt08TULJvvIabVuDARJVxds1/MJCmWsYPlXMw?=
 =?us-ascii?Q?5YAiAG0k1jMyGaF5Sm2lkCc93OeSGL6t2NMwbW+T9yIg2fPtV6QdknrBU564?=
 =?us-ascii?Q?0PUxGHPYQfiAmQc8lOo9hzNR2I9jIZEume4OCWcFitQpkc9Hb/Q1/Tb4gdTp?=
 =?us-ascii?Q?U7KJhTheKcErut3SIDslMu3An9dq7fo+aq8xlLeaR7qwZ+jvz0vrxPsxcaRd?=
 =?us-ascii?Q?UdXVIBWOaQ88LFXWz5P3c2VTo0wfREaMxmejEuIRhifjjgtw1MLyRx3uBfUn?=
 =?us-ascii?Q?Z2/G+4VCzzybTvW3RiEkMwQT/Ome5vhj9/MB4rog/9b3MdIqKSVrGz0GbPEx?=
 =?us-ascii?Q?YQscToSgloBy/+xxolT/hp0b5zF8Own3ZW4NupFFLlSMcK8iHpC/zaZRQEGA?=
 =?us-ascii?Q?OGh2P2rWRrDc5Rt4K2ZxrXY8zCCIQNdGBOWV3T5FnAYnbgJyUnnl0QRYj70c?=
 =?us-ascii?Q?BDM476oAix1ac/P2G2DLjuhJhdsCj0Qijknx6QIp1eZP2Xu3hY3TZrhGSboy?=
 =?us-ascii?Q?0CMVYoneQQkLRQa3fVAUKI+j6N2eW71OpIXLkQmMpi8gCReSP15jV3w0O8o7?=
 =?us-ascii?Q?gWK2GZEsVsUcFab7VHesTzthCjKMm/DCRHAeA154+CdgZNUKHMoqsN8WTVbm?=
 =?us-ascii?Q?K6dqXdqvf+hVXf9N8nGgmzhYzAzV8zFwTiP8jlMlnVzjIiYqkKJjreOaOObK?=
 =?us-ascii?Q?0Ig7rY+IdsE1z7hFdnmOtsmD+Yc3ssF5MepBeOYUJe7zoTUiK97MVRBzzU8d?=
 =?us-ascii?Q?Kji22hw1cEZEGsJdHKeekCYTmar0nTnCutJyW6tBNPUKYKV+x7WR4+Jdw1SA?=
 =?us-ascii?Q?LXBkP2jSPn5znnZ51o3hz5WZodYOUjcfpkOmkX4oWsl6K/x/GnnHKIar45sU?=
 =?us-ascii?Q?AlwHDoKnI35MZ6jNc48IZarRfGw0WpXy7tgsFGGSRnbOVNudJt078T4655rP?=
 =?us-ascii?Q?BlOjaEarLFrhBwxMP/XjyYtlNJCEeVvvkiAVVpRGvCqxdAQzxhj2SPdFfUEG?=
 =?us-ascii?Q?vnagK4Pfvrw1X+V1ce9rAHWU8okbprG6zo+AZZcFoeP534ii/yI6NwmtqcS5?=
 =?us-ascii?Q?b9XEvuK6aTvcEo32np4nE4undjxNsGHoVNsl1CTEGXRw54JUPveO+19RSedU?=
 =?us-ascii?Q?9gGp0v8fq9A0p91oZBmtmax6I66xyfYagOtcXWFcLWM+9xtZxHi6W9e/nbNB?=
 =?us-ascii?Q?oY+UhKjYXKHsCv8dkolkrbP7NIqglaWzpMByNDghHDckM2cIPnQ5GPLBDntS?=
 =?us-ascii?Q?2eb2vpdzMM/hSF1DIgACHOtmk7KiU69vclHzTMKEZeu8TSywyZtnh7gQgjgg?=
 =?us-ascii?Q?r880mVVM5Gqx0GOO6reFG7TW/Vl/ftdXy0dMIiRzFgi/vqr/DwENCF+4El5F?=
 =?us-ascii?Q?pImNjMBcgRv/l2MQ4vdaPlcxBIvi9jRNEwixqwKtEesvXpdtGmXF02PK4M6U?=
 =?us-ascii?Q?G69zRgZuubpG5cRCezQ6pXK/zx1TnZoa13A7uRbO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	A33S+Q16upj7ZuMd553eHMbyEfU/T+/lSo6yJB1Oeplv/+0mK8l/ogYsAaFvqMIcRR8qxaxYy6qif/1Mj2tDQBQFSgOIExaz7syStCsjbA22W6b7Uasec3tSMm8KSdkM99dkMODk7ZdQ8Bcq/rPEZeqwb+ViETgofLrdjV9ZnA+RFfmO4zDNHGCPyki8OnSuCogl5CFKfGIAZgiyznj66sJDfKNIa6Gzj+M9+TRpTYuoUlpUX8kIWEhYan8XSg1G0BPgedKMA+K67ysoFFRSzLH3fQ08qWWkAqMCX8pX/JlD//FAl8dBheTLlST5u0LSoYWeIZ3lK+6EtxbymSRYBrUUT4N5bSErt5ghrEx161+IYrw7Q46BzROwVfN3Qz2GQnAnRaDIQFU84a0Px6tR0PiYpf+N8Ugztud3dhthTEuB1IvUy8yCvUGqmH5XSEZ1dLMERb2w/E2TfBUetkrGm+No48wZzDV4nhhTEt92aEnhqgRmpEjUrKD5O/0a6Y02g/MTQ5y+ngQCMKdM94JrXSBo/StNlBTzz39kT0wbe8s5dJTgpqoHzLpRhuFwJuP+K1e1bmQqA5Lsc2QWwVNgw7OGzHuXplkEdYOthzuKPfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dbc81e-b601-484a-f0c5-08dc3daa6b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 06:55:33.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bO67Tjkx6A3dXZjr2l58BT5070j+ovhHyL3/QNnikm7/flyddy6+HJqsp0pGb/laVSjAc5zw2eJp1i6zXW2/x5EgyGOFv1qrE7NUpRIkDuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060054
X-Proofpoint-ORIG-GUID: 8YF_gLmtkVKMvSm1jKQoE7CvMx5PrtB8
X-Proofpoint-GUID: 8YF_gLmtkVKMvSm1jKQoE7CvMx5PrtB8

Hi Ritesh,

> -----Original Message-----
> From: Ritesh Harjani <ritesh.list@gmail.com>=20
> Sent: Wednesday, March 6, 2024 9:32 AM
> To: Srivathsa Dara <srivathsa.d.dara@oracle.com>; linux-ext4@vger.kernel.=
org
> Cc: tytso@mit.edu; adilger.kernel@dilger.ca; Rajesh Sivaramasubramaniom <=
rajesh.sivaramasubramaniom@oracle.com>; Junxiao Bi <junxiao.bi@oracle.com>
> Subject: Re: [PATCH] ext4: Enable meta_bg only when new desc blocks are n=
eeded
>=20
> Srivathsa Dara <srivathsa.d.dara@oracle.com> writes:
>=20
> > This patch addresses an issue observed when resize_inode is disabled
>=20
> Other than "meta_bg unwatedly getting enabled when not required", is ther=
e any other issue you observed?

Yes, we have seen an issue where a data block is being corrupted by group=20
descriptor block because of this. The following patch fixes that issue.

	ext4: fix corruption during on-line resize
	commit: 3a944549dd26ccaf1f898a4be952e75a42bf37dd
=09
>=20
> > and an online extension of a filesysyem is performed. When a=20
> > filesystem is expanded to a size that does not require a addition of a=
=20
> > new descriptor block, the meta_bg feature is being enabled even though=
=20
> > no part of the filesystem uses this layout.
> >
> > This patch ensures that the meta_bg feature is only enabled if any of=20
> > the added block groups utilize meta_bg layout.
>=20
> Make sense to me.=20
>=20
> >
> > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > ---
> >  fs/ext4/resize.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c index=20
> > 928700d57eb6..99b52f26e818 100644
> > --- a/fs/ext4/resize.c
> > +++ b/fs/ext4/resize.c
> > @@ -1996,7 +1996,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_f=
sblk_t n_blocks_count)
> >  		}
> >  	}
> > =20
> > -	if ((!resize_inode && !meta_bg) || n_blocks_count =3D=3D o_blocks_cou=
nt) {
> > +	if ((!resize_inode && !meta_bg && n_desc_blocks > o_desc_blocks) ||=20
> > +n_blocks_count =3D=3D o_blocks_count) {
>=20
> Beyond 80 chars line. You might want to fix that.

Sorry, I missed that, will send a V2.

>=20
> -ritesh
>=20
> >  		err =3D ext4_convert_meta_bg(sb, resize_inode);
> >  		if (err)
> >  			goto out;
> > --
> > 2.39.3

Thanks,
Srivathsa Dara

