Return-Path: <linux-ext4+bounces-1687-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951FD87FCC1
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 12:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA851F23481
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Mar 2024 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B47EF18;
	Tue, 19 Mar 2024 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h+VMSu4X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ovh+nBi9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759067EF1F
	for <linux-ext4@vger.kernel.org>; Tue, 19 Mar 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847519; cv=fail; b=NqpG6ObzzUNinXtSFzVSBaQxWrD6NyU9hcFzFOV33cCftYfMbgXtzEtlLlq202f70Lf3RafoTlLXU3TtDUj2OZ72RjhYRlq4/1TkoIudfxRPpoKvxfJovNfEGq5GmA2qdk/DHwgu2+6sp9GtQQR1xlXQZHNM6JcMS8M6RqkdiLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847519; c=relaxed/simple;
	bh=ul8n0mDUgBBYVeuTyGEldZNDPBoOx4OfWQEKt+p9gUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=immCxDIwLpflWGU5LqbqAwk2chxy5+/tAEzb3SEllh4H5oyq4+1Yn+ilqpyoJ6WmQ5tq0sdlAAqbiaPWCecgUr2vK8PcKk/etHF3DRYU5NByvq86u/CQGyjA+pQv3DigorDAXlZzJ6YP8/Tll42ysccFkRNDlDFs/3dhukZddYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h+VMSu4X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ovh+nBi9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAIWjh014212;
	Tue, 19 Mar 2024 11:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SAmoQyAM1V7SBs1uHxuxXSn8Gtv7H+E+NqNAiKChNfI=;
 b=h+VMSu4XVaTM8A4PIEyxAvMiyUVSHoLmk1L/8ygmtiqsxsskjDB/cgD5ZQ7ip5NCUUy4
 p/Ud2LHXvlCc3zaxntLH42IVgpXcGUMAjozuKp0bYWQBbmSqQXgQeL+UOO+72nBXTuOv
 ldIspJ1lg22873MlP1UY2yE0t48n8Pcs+mksO16+pgyuwwz54wO+qKx73eW3Sg/4RtnI
 cN8yOfclikPGZ7R3E53aWd7rjbOwswLC2uPcR5F5sb9VIzlYr24iD8/K2k+uIWU6+p9C
 gQesKc+itsdm22VJiCHmqe0ub/AfCOpJH323ckIT0PEDZH/K6nI3s6CsVBWDfjCqLGFJ yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww1udd97a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 11:25:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JB3NZc003679;
	Tue, 19 Mar 2024 11:25:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v63qd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 11:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEx8g0Pq7B7fTZlA10YZjqynMpLrMxeEzU7PhL/4SUVKxRoEYyMtAcF/32LAnmyRovaZVlyc0+C86mn3+sscquHXWg+sVnx2acQNpWuzrM1bGFMI/rbZAHiKg3KACjiXjrLatUFE4WQ0P4I1L0uqDiNPS5izsWlI9xQukRGjZlg3LWii9q0NXiVrtKE1FUhw0+3zGDzZ/volX168p+WTrrogEYo6fwV0zSbobyQJ7a5G06epuvHMrB0CV6WsBFj03VYW4uVJh35MALcTVMZytqhOSDQE68CGUt3Ns2Q6xXLR69GSrrLJsyfC/GxkUKPVIzQhjpIACigHIB191STygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAmoQyAM1V7SBs1uHxuxXSn8Gtv7H+E+NqNAiKChNfI=;
 b=NAQsAPSSCciHOdZ/7Ka8EA+oIoTPnFUt0JL20iv4aUk85GrBwpTHvZYPNffPN8PBLE02oW6e/zt5KuGbol6w/ZIgoguslsh8t1knI+ijqjvLdBol8foSp1mYFmSELxWIzUlHCiAURaDYb2M1ZCqFeyjLM1ZVo4+upwZQ3Cu47JiLDVJBKSnQ6Q2t8ZiwqxGb+ZeOu8yW9JKkvYpusO4SvlMn2nvusdh+9jMy5ka2pDoAUHLmM2kU0ovOYbqglJbH3oeKYrJJyOOUPB9lL3+iqAfElalEnD+NmliBehPG0BVWMvGyn8KxMB/pvrAQ78Aic+LFybyYnV7o7eU2ZJQXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAmoQyAM1V7SBs1uHxuxXSn8Gtv7H+E+NqNAiKChNfI=;
 b=Ovh+nBi9eqV1M4UVqSgdc0520Rp+TzE4UssbBJQDl2Mo7IJX0JnR2f+tjvZ9S/Y5ttU9O9pPrQ3d0dfPVcyBppyoLppaAvsEgyMRJlq4JEFIqfFXmxofExltluUwEVbeAwwnd0WZpMreV0Qk3abBoPbwNpiphhWIV5cHUsKr8Fo=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by MW5PR10MB5714.namprd10.prod.outlook.com (2603:10b6:303:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 11:25:10 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::5f3c:2ca7:f67c:d071]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::5f3c:2ca7:f67c:d071%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 11:25:09 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: Andreas Dilger <adilger@dilger.ca>
CC: Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o
	<tytso@mit.edu>,
        Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: RE: [External] : Re: [RESEND PATCH] e2fsprogs: misc/mke2fs.8.in:
 Correct valid cluster-size values
Thread-Topic: [External] : Re: [RESEND PATCH] e2fsprogs: misc/mke2fs.8.in:
 Correct valid cluster-size values
Thread-Index: AQHadyBCRLBfhfgGbEmuJj3RvbVnuLE+63sw
Date: Tue, 19 Mar 2024 11:25:09 +0000
Message-ID: 
 <DM6PR10MB4347C97E2645B45A66CA0D76A02C2@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240314093127.2100974-1-srivathsa.d.dara@oracle.com>
 <CE93B29C-6A50-46D2-95DA-956D1F6A4104@dilger.ca>
In-Reply-To: <CE93B29C-6A50-46D2-95DA-956D1F6A4104@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|MW5PR10MB5714:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 idph2D1ud2Wd7i0EUznixHnnQegkMpLFKUwV3u9wefFbFKooC8JGqQD8rgt1Vl0wAe/pHo1eGiNv+4edCj0opY8Jpj+s7WWSFB2OSTURSsJNCfMIQJlrFm/YOyfxHfOx9be4Xnsqq5CMcRZoSxvVpv+xoJ2K693k3JsHvTRLQb0R6mWH7vBwEeTTt8k5B2UGRLHeZXer1Rbr/UPekF6sYn0Y44SiSlAVzZummxmdI56aut1GtSJiUdxa0DgBMPpPlmqD3wJY935Kh4LaTWcP84DuhMlRBwAR3WQ/Tj3GeIpwLch5mGnhs8pnJpqESmCmILuqxPjU5hgX2/BkBCSSsu5z2olkcHwsL2ZpNIO1+ebw/ZM7oJtDeWXm1W1V0jKaBN3n/tJtSxrhnehHvcLQiOwdwJwuolnz0eqtNYNLWkx/2w5edqqzXAlOjtJ7SvW/sa1D5sR0SIzHPDHZ6fJrCmKPHWs0qNG9kUAMvwDEOIbgN5G2ZGMhcB7Vd57x7Iy9zyDjspijgkXaA1BgNyvJ1heDuwu/6iX5L4w9Cyvdq+mrsmeYxdX/VOqU8dW7UPBe4v2D3savV2JjpVAphcgYyCPAG7F1bff5AgX+ZEpOsFajx2vMmFQrFNmTVLOky0eJdgAVdqgtHIEJGWiFhLyfiIkBJykaQf13H/NXhJuu/Z0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?MoDQ490YNeeh7VeO///OzPy6RoTCnPReXiv6HNM+5i+hJY6K4TTMrsP0L8wY?=
 =?us-ascii?Q?STXIZuNOn1CwWHlc9uGbYW2zLyRsxAcZaG6Ec+NsCaEG7WJcmX/Pd9yteytF?=
 =?us-ascii?Q?GlshDkaFFZQPsxWMZvJgRWS+1q3LCFKpjMyjv1MQL3uzPpnAxej89k8ASiAQ?=
 =?us-ascii?Q?/Kf39VLYL82VwD900x4OT4Mqvcxh6uhRiVfwxsUkOMuKAIIELK5dt/NA/4f2?=
 =?us-ascii?Q?msQkTvK6HwVVU9JPmow1KzKH8RTfMbedzhSquBPdKz/0b1I10bqhflEouRDe?=
 =?us-ascii?Q?/M/ZfffFfcGYDEkG5sPWiWAoxvmvUXy35AixwwhpJywS4Zn0jGcDOeg5R/vM?=
 =?us-ascii?Q?snAJVSSIgmZaxwGaDlJodETTpd3WSEsNpottBI/ZP5G76ycjnFlLUb/un1Tv?=
 =?us-ascii?Q?IWfHFqGvdSYPlsWvFlTiYoaQss7FbIrzmytKYFRYZZs3bNIkRgkbzm55dXHf?=
 =?us-ascii?Q?8Z/EXJOanSvzC6P7aPxNo2GRNyMcrt3XRdCj5bZmt/MSYjRIOHIKKRuvvLf6?=
 =?us-ascii?Q?gyjxuH9ZDcorZ/PYDsVTmpIhaxHJ2gTh/2rgV5SCbFI4BP7S1ekXyRT0Cbmc?=
 =?us-ascii?Q?sLUU4IxXfTBPQjHj2PIkev80/El14iPWlC4l9rWWxAE+j2UOHNjNgJPMk8/c?=
 =?us-ascii?Q?TTi8eKaiukW52A3cgXoHHEr0hTPGMz3zI9f0mGw1f61zxHinqrzkaHJ6Ofoi?=
 =?us-ascii?Q?+MQWYaRCXY0f7x9v/y7niZ08eUNIr/lCM/Ft2Q5Qs+UBKI3inc9pQ1YANQea?=
 =?us-ascii?Q?G6axcLbbUES+aZxvTBQYBVjMHI7hWl45PfLjjyPQkeGNYd/TvQeKpu7eoky9?=
 =?us-ascii?Q?bYOXERSxcM4g8H2ZJL0UiFz8mZ9r+Y/zovLkH5T8UIvuGlTsNM4Ad6DoqRKr?=
 =?us-ascii?Q?1d+27oiS9m67mPXdTro4eOrfK1m900194RG61sRcoWmBwO7oGxWKEnK8L86d?=
 =?us-ascii?Q?Lu7BYQBG5ltwYyFRpYS5pIIXuJpGVDzIUnayvEefxzg+i5Puze3dvm1N0Z5Z?=
 =?us-ascii?Q?W1JilEo7WQ5mUn+L13Ao+qFQAKCDfXiLhrKWb7mAP59DviBqAPbk6m8TarZn?=
 =?us-ascii?Q?WrdcU3HLHhU8EHjYeYzNr8/TXCpQtj5767TrlLuCb7KaaXJD1s9NEfTMQ4PU?=
 =?us-ascii?Q?ly+X2vhHG+9VZ60iShpIWyfySksGqadjmtLNyL1ql86gfqalEpgO6ssa7DCx?=
 =?us-ascii?Q?IiEG3Xk6Wqy+0152kQ72Cv158xpi4d+e35HVQfE+CgwyCDJ1KSXrBASi/x2x?=
 =?us-ascii?Q?EekD0z7Ta9gyPwOpUsVGSConCuxcUaPAC7T4FxJ9Ot5gvV1g6GH+l+OVIuzC?=
 =?us-ascii?Q?US346ThGZyjKnSBfuarKWCspfLb3O2ueD1l2uwlshQLcKI3bM5U0UVkBs6mn?=
 =?us-ascii?Q?3iNd4qbBQcWEsZ4WryKdSvGpElX0jUBSy2Ec2Q9LMk4gbEdHgXgAhEKuk43e?=
 =?us-ascii?Q?KwzQ8p2SHVCS4hcaLV/4DN3iAb5/tDjsGeAp+w4iKFRSc7wOpdZ0VLy/r4ik?=
 =?us-ascii?Q?L8GVFBGjEopIOXcVO2VF4eOKnCM481E86jf4/nFbztg+r7H4LhBvSRRNR+QO?=
 =?us-ascii?Q?iGe/OrRPMHLhQdq08BHrFxp1Erx6F/vjDm+gSJqXVidQIsLzxz5EJJVUTxHo?=
 =?us-ascii?Q?iA=3D=3D?=
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
	PZJkJBaLxUq+txl97wpifnTyhbu09RP1vPTacRltMwI5Lq0pbrqZlQFPnOHsYFSiSGtF48kNW+KdWwHYC5/x1aa6xk9W1HWpANoCr+xH3SJzwS9MdyVuA4gQsveG2J6sSJyLHskYQmCK/LFzLiyih3JELX3kLiIIc/JJsG4XqgPW7livuFAZJkfTIXjSIAwaME+hBs4i+iEQeCQwbd9FxAI2XPk2P46Tseyw8wwIDoQ2J8gDPYWAGFCh63vzLP0tBb9AYULi1ykK2CNbtjMhIKtldvmFBkQrcupHlk/0SBxQUCsEzzhHcRYw3foAFVHGd9GDnqwBub+SdlySRDI7lS1UYPZmJwDwamAZ5qfWji1LEaR7p5QlXgNxgzqrtnP3xMvKMJRKPAPgSejQBR76Mjxq8DjbeyYDHHtD4D1uyIzkGuMUtj94sgfiT5YTPvIo4DODo5ZJYGsA7sNlGqnel48sh8C1IlHv6B19DFrPMKtQpIDhd4v8oUioQ5kGFPn22U3QHOQlp/lu6jyzZ3qk31SBnVJrEYrqSdSdW58V0wP33jVHYxxe83NryIwTxXDb4IsJqx3YeswpH/NwToCsjwGxXLZ3O4RDwmnuMsGE5II=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37425c8d-02a9-49f8-dd14-08dc48073c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 11:25:09.7301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lO4wbeNeFpTKiZ/K1KDY0VZhee9OnaYkWGdqf6zxPko0Ay8m62wNqOcpwf4PEtaLcx0nhWQAx2D2L1x9LlAZwlxkLVqMdqhSAWzTHc09NE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403190088
X-Proofpoint-GUID: n2FVGCiC2otEx8XV7dOw_0I78xi781Ts
X-Proofpoint-ORIG-GUID: n2FVGCiC2otEx8XV7dOw_0I78xi781Ts

>=20
>=20
> -----Original Message-----
> From: Andreas Dilger <adilger@dilger.ca>=20
> Sent: Saturday, March 16, 2024 3:02 AM
> To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>;=20
> 	Theodore Ts'o <tytso@mit.edu>; Rajesh Sivaramasubramaniom=20
> 	<rajesh.sivaramasubramaniom@oracle.com>;=20
> 	Junxiao Bi <junxiao.bi@oracle.com>
> Re: [RESEND PATCH] e2fsprogs: misc/mke2fs.8.in: Correct valid cluster-siz=
e values
>=20
> On Mar 14, 2024, at 3:31 AM, Srivathsa Dara <srivathsa.d.dara@oracle.com>=
 wrote:
> >=20
> > According to the mke2fs man page, the supported cluster-size values=20
> > for an ext4 filesystem are 2048 to 256M bytes. However, this is not=20
> > the case.
> >=20
> > When mkfs is run to create a filesystem with following specifications:
> > * 1k blocksize and cluster-size greater than 32M
> > * 2k blocksize and cluster-size greater than 64M
> > * 4k blocksize and cluster-size greater than 128M mkfs fails with=20
> > "Invalid argument passed to ext2 library while trying to create=20
> > journal" error. In general, when the cluster-size to blocksize ratio=20
> > is greater than 32k, mkfs fails with this error.
> >=20
> > Went through the code and found out that the function=20
> > `ext2fs_new_range()` is the source of this error. This is because when=
=20
> > the cluster-size to blocksize ratio exceeds 32k, the length argument=20
> > to the function `ext2fs_new_range()` results in 0. Hence, the error.
> >=20
> > This patch corrects the valid cluster-size values.
> > ---
> > misc/mke2fs.8.in | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in index=20
> > e6bfc6d6..b5b02144 100644
> > --- a/misc/mke2fs.8.in
> > +++ b/misc/mke2fs.8.in
> > @@ -230,9 +230,9 @@ test is used instead of a fast read-only test.
> > .TP
> > .B \-C " cluster-size"
> > Specify the size of cluster in bytes for filesystems using the=20
> > bigalloc -feature.  Valid cluster-size values are from 2048 to 256M=20
> > bytes per -cluster.  This can only be specified if the bigalloc=20
> > feature is -enabled.  (See the
> > +feature.  Valid cluster-size values are from 2048 to 128M bytes per=20
> > +cluster based on filesystem blocksize. This can only be specified if=20
> > +the bigalloc feature is enabled.  (See the
> > .B ext4 (5)
>=20
>=20
> This is an improvement, but doesn't really explain the details of the lim=
its.
> Instead of "based on filesystem blocksize." I think writing "between 2-32=
768=20
> times the filesystem blocksize." or similar would be more clear and expla=
in=20
> how the actual limits relate to the blocksize.

Hi, Andreas. Thank you for the comment. Here are the details:

The function ext2fs_new_range() is causing the error. This function gets=20
called while creating the journal inode.
The purpose of ext2fs_new_range() is to return atleast requested amount of=
=20
free memory.

Following is case, where the function returns successfully:

Breakpoint 5, ext2fs_new_range (fs=3Dfs@entry=3D0x555555779070,=20
flags=3Dflags@entry=3D0, goal=3D131072, len=3Dlen@entry=3D32768,
    map=3Dmap@entry=3D0x0, pblk=3Dpblk@entry=3D0x7fffffffd120, plen=3D0x7ff=
fffffd128)=20
at alloc.c:407
=20
If we observe we can see that the argument length is positive value (32768)=
,=20
hence the function allocates atleast requested amount of memory and returns=
=20
successfully.
=20
Now, lets look at the function arguments, when it is returning error:
=20
Breakpoint 5, ext2fs_new_range (fs=3Dfs@entry=3D0x555555779070,=20
flags=3Dflags@entry=3D0,
    goal=3D262144, len=3Dlen@entry=3D0, map=3Dmap@entry=3D0x0,=20
pblk=3Dpblk@entry=3D0x7fffffffd140,
    plen=3D0x7fffffffd148) at alloc.c:407
=20
The length argument is 0. Therefore, function is returning an error.
=20
The value of len argument is calculate based on the values of blocksize,=20
cluster_size.

Following are steps through which len value is calculated:

len =3D EXT_INIT_MAX_LEN & ~EXT2FS_CLUSTER_MASK(fs);

* EXT_INIT_MAX_LEN =3D 1 << 15
* EXT2FS_CLUSTER_MASK(fs) =3D ((1 << (fs)->cluster_ratio_bits) - 1)
* fs->cluster_ratio_bits =3D super->s_log_cluster_size - super->s_log_block=
_size;
* super->s_log_cluster_size =3D int_log2(cluster_size >> EXT2_MIN_CLUSTER_L=
OG_SIZE);
					where EXT2_MIN_CLUSTER_LOG_SIZE =3D 10
* super->s_log_block_size =3D int_log2(blocksize >> EXT2_MIN_BLOCK_LOG_SIZE=
)
				where EXT2_MIN_BLOCK_LOG_SIZE =3D  10

Following table which gives len value, for different combinations of=20
blocksize and clustersize:

A =3D blocksize
B =3D clustersize
C =3D s_log_block_size
D =3D s_log_cluster_size
E =3D D - C
F =3D ((1<<E)-1)
len =3D (32768 & ~F)

len is passed as argument to ext2fs_new_range().

Failure cases:
------------------------------------------
A   | B   | C   | D   | E   | F     | len
------------------------------------------
1k    64m   0     16    16    65535    0    =20

1k   128m   0     17    17    131071   0

1k   256m   0     18    18    262143   0

2k   128m   1     17    16    65535    0

2k   256m   1     18    17    131071   0

4k   256m   2     18    16    65535    0

successful cases:

1k   32m    0     15    15    32767   32768

2k   64m    1     16    15    32767   32768

4k   128m   2     17    15    32767   32768

=20
For successful cases, len is valid value (len>0), whereas for the
failed case length is zero. Hence, the error 'Invalid Argument'.

The conclusion is that mkfs.ext4 fails for all the cases, where
the ratio of cluster_size to blocksize is greaterthan or equal to 2^16.

>=20
> Cheers, Andreas

Thanks, Srivathsa

