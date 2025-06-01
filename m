Return-Path: <linux-ext4+bounces-8253-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BDAC9E68
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EB03AB700
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082B1A76AE;
	Sun,  1 Jun 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NWh3iSq6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021094.outbound.protection.outlook.com [52.101.129.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8926AE4
	for <linux-ext4@vger.kernel.org>; Sun,  1 Jun 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748775753; cv=fail; b=agQyHcT/jYF9rnO+LYWncMNbqCpSnFTNLyLIm+SIOpedpxX9vmtJYiibePR3MzFk1LQalxhw80ejK+XBI0r5Unadfj28Skqkul8yVNRFYex0Ufikk7OpiugJuAQ4AOuDlzBXyaCyFlR7wBFKqz4KK53PWvgitZ1tsksbhx68iLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748775753; c=relaxed/simple;
	bh=0u3K3zJe/O7QLt1pz9LDUxGqiFoQcGuvERBdmOBCuvw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X5s5tdDKwCIjAPnM6HYIwZx9kaDmt/vA7J4ZoA+nj3+2UwLEp+vZjAri6STXQwWrM8cUB8WsX1BxdbCkMO5FRJ0X0YrC6KsX0sjLP9llPtxc3Nn9uS/m/e4bmd1Qmwvwnrxysfda3Nx4LmTmuXqkwMBcMchG7Mg2mwimmAqO45c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NWh3iSq6; arc=fail smtp.client-ip=52.101.129.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d++tuDn8/Bq7ktR3BdESHdvYhQK8eVV0hyq9XPpnz6NvWim4HgkGPG8HkOacbbHcD4eAec114TveLmZICiGPqQz6Ehxr6WqchcmYZ982rr931v8ODwi47e25Ogbbx9CxFq9iSim53lOb+IeEsvH/4oRSg5zfPcoufumIo9V9BRz87viyqQ6oS8yPizXMJebO18UJOKjDqSQHw3mAlAfb+gFjhHHm03YjDRSA2RDGK+kL1TvW/4Wa391l0hU+YRyOISyeP/U4ts4SXbhU9ubYPs2U/wGXMaAwkbIDUMnyyWINcyOOpdGBy4Sr5LfhBqG5WLDziyh8V/zEA22Nt6Ni4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGCAGATCSAIvdyGFq8J6QLyaWgptjBp8rGf5baZDIkI=;
 b=JCyzGvEiOx9txS7LMNbw9l0Ng4DwTFz5sbr8S5tLfFIFd3AdOOY77nsoi1OQ/iay8RigqBHNEp2L99EwvJwnmFKMyWqLrbcIbNEMgQ5kDPT/Vnzy8GKLqGPCzA4pPhIkQSitOeZrWzxtmjZjTk4hWNaJu+degBn4Gweu0i3cGK3sYcnMje2Dsk7bJxe+lXTX8oA7VTYcGp04ln8M23Bh/+GfmSnZb4MXlLcVmWXrYYl2W2ZiiOMNqFBeTR+QLqkou0aFGytnwg/E0s//t5NDuHBnCggXPXL/7D/N0hUo8dCLp/Pcc0q/FIvoGYvtVnblLMj8N9aPrzBA7o5KFaLaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGCAGATCSAIvdyGFq8J6QLyaWgptjBp8rGf5baZDIkI=;
 b=NWh3iSq636j95l0vODDV1bSEQewOn2sxK1s1hf4E2ABAWRp0GbCGUtVF1kopMlDg4+CfWxMpGE1a8JqbMC7c0mlVzQH1w6+UD8tbLzzCU9kKbc7UOZKJYTYG0MCRzGju265GwRFpntCOTKe4Hkgs0gL8+NVT1Fa3u/fr8XG0GkA=
Received: from TYZP153MB0627.APCP153.PROD.OUTLOOK.COM (2603:1096:400:25f::12)
 by SIAP153MB1197.APCP153.PROD.OUTLOOK.COM (2603:1096:4:28c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.7; Sun, 1 Jun 2025 11:02:07 +0000
Received: from TYZP153MB0627.APCP153.PROD.OUTLOOK.COM
 ([fe80::1625:a5f8:c796:ee1]) by TYZP153MB0627.APCP153.PROD.OUTLOOK.COM
 ([fe80::1625:a5f8:c796:ee1%5]) with mapi id 15.20.8813.014; Sun, 1 Jun 2025
 11:02:06 +0000
From: Mitta Sai Chaithanya <mittas@microsoft.com>
To: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC: Nilesh Awate <Nilesh.Awate@microsoft.com>, Ganesan Kalyanasundaram
	<ganesanka@microsoft.com>, Pawan Sharma <sharmapawan@microsoft.com>
Subject: EXT4/JBD2 Not Fully Released device after unmount of NVMe-oF Block
 Device
Thread-Topic: EXT4/JBD2 Not Fully Released device after unmount of NVMe-oF
 Block Device
Thread-Index: AQHb0VLES057MYZ87kOkGU14tXDGcg==
Date: Sun, 1 Jun 2025 11:02:05 +0000
Message-ID:
 <TYZP153MB06279836B028CF36EB7ED260D761A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-30T14:28:19.712Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
undefined: 2899116
drawingcanvaselements: []
composetype: newMail
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZP153MB0627:EE_|SIAP153MB1197:EE_
x-ms-office365-filtering-correlation-id: b2560f28-4352-4362-bbea-08dda0fbbf18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?lNuLFmsonpAzgxV2/+2GRUzWhYSqE7uXIFjjkoLJeD89vfOBJ3je49HC?=
 =?Windows-1252?Q?eSgPv3Pq14GpK8eT6UKoUa+RFpz4PAM9LEyLqvHvmx19OLMPQLS2N0oD?=
 =?Windows-1252?Q?vxRd98hEeG6QDTEKGssRYf+PveXJUwgqQIIBAZsKCyct7iA24hgHRfmL?=
 =?Windows-1252?Q?tmYJt7kfEZsN4yVEyak40IzEiMHC8CengeZVpSXN6cHNvM3p3b3UPZqw?=
 =?Windows-1252?Q?zeD6DKbvNK8fj5Vc3Vnm9doDunHa2j9yxaExOLqQ9nC7lu3R6RIFHvcK?=
 =?Windows-1252?Q?3pIcMTH+oIpSzo3c9Fe4WRmqFbe5MZEXv6vHQHASEACKmV0WDpnFdVi2?=
 =?Windows-1252?Q?ROjXIB4u5sIaSWFKHx4+cdw5CazBbveWYVwmCjR59a551YwJ4zoiO+g9?=
 =?Windows-1252?Q?9UYXoYExU5O/vA4usgSqqbTAM6rNmQQAqEoZY+HGQ/nuhkSruq9aLPoO?=
 =?Windows-1252?Q?UGfeVp60zLrcz3bG71WQXeniDneCYuPZbsQUpOyJoyxE570kD/jOfRM+?=
 =?Windows-1252?Q?+TPUJnSyxCdHQNdlemDJG1FDRdL3DC0pjv/p29hvmIEGv7cZgAn0cPyM?=
 =?Windows-1252?Q?l3Ep5e0xDAbAI4jtsfxYPudTYaK2PSb9QdJPu8YJRBOahbF3jdaoabYc?=
 =?Windows-1252?Q?y9zbFXikQKO3n26nVYCZgUpChSUyAPaE7hxuV0bbU2uW3u9/1/sgb1/C?=
 =?Windows-1252?Q?GgRAf3cDh/Oqd9HaiBX/7AWrOyWsx52JugAcFUMI873VcBQhmmDSHJEE?=
 =?Windows-1252?Q?mhleqPZ7ah97qPryb1X9LLx/atZ/kCVbEfv7FzHtHzEZuYVLOjEqjRr6?=
 =?Windows-1252?Q?ObV7vH1YnSa5ExKLlYIR8Uf1LE9l56Aie2DLXoPj//iPNw7hzuZlDRvM?=
 =?Windows-1252?Q?A5f5H8k6+dH9tFrmUnlkJQn79KUI5CP7n3iDUZDVB5RUTc33ONEUwlq+?=
 =?Windows-1252?Q?4reAs5OzT8D+HtNRElUXBTTxjOLlOCVCWOy+ZyiH3U0g5lb98wn0eTRb?=
 =?Windows-1252?Q?uAndDTUih7UGh8vqbzTj55XjEzc8XeQLoFo+q/vJ3POTxzr6ZeIO+LIc?=
 =?Windows-1252?Q?NwdIoXGsGIiXhNXPCBEDElVrFI9AaXAmw7xIVRk76eORd+TuC9JNOQW/?=
 =?Windows-1252?Q?4DpXTdLVNKTXAFbIWOMpQqNIrtrIOPKoU1J7CuuAiWj0W3S3vBvIIltC?=
 =?Windows-1252?Q?wlrOnZz4YPBbSnJcnWpusTsT9GzY6Lv6AJYhmDL/VucO4CIbvY593Vd3?=
 =?Windows-1252?Q?c6iTdHAJ5LKZDx8wMjInTLWgV7cgjgawOso3LTi2sKdSMcK4CMWRnYqp?=
 =?Windows-1252?Q?ao7bedZVaF/cHKEIctrlkSnsZTUvtbYZUczNZ58/DUrcT0QTMMthFaCS?=
 =?Windows-1252?Q?Gy67lr1Jb+/kvT6+d3J6ybcSvMpZfZ5F3RC9ZWEyKj0s7RYp91pzN68/?=
 =?Windows-1252?Q?uFiNE1a0/tckzdt0lhUkf2poDATbevsMXyTw4kZ8DSQ/kfWe54nRUxnQ?=
 =?Windows-1252?Q?rJK91Z1Oio/SHQwrNbxdBEruHQqbl0P24gNcmAhe6v7uiJcOmtlnQArI?=
 =?Windows-1252?Q?kmvH3/AWLYqjPZd7VRgmvwu90CYOUPk7ViLTTA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZP153MB0627.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?ga8aI9bvkVx/wWiV8G3Qfv6UgHKMYeK5qMmdo2sE05O5V8Ez2dbIyldv?=
 =?Windows-1252?Q?mnEcTOs4UaPK1ug3VSeoDJptd1wqtSJnbUQaivKL+9zdO0rYJtu+KhOX?=
 =?Windows-1252?Q?5J8q8KQ3avrj27O4kzx+D6DzOtcqIyevVPRDBT2xaUH0vEuhssha6pED?=
 =?Windows-1252?Q?IIMbMWynCj7avClnKw7tn4fb+Og1RZl2bwpQxJrpcIkYUCvkeS8dVRNZ?=
 =?Windows-1252?Q?IbliwVfk6NaE3KNaCy8OUeiS1r//fHmjIvDMvmUAh7WK8/xDWYNyf5Cw?=
 =?Windows-1252?Q?4m1T6hf8NyVkrJiELbmZ5PwgawpuTA0JcV2wOc0Sfi951eFN+WEhUkhl?=
 =?Windows-1252?Q?WpxqWmcMQmi3Es/riMhFMkuubFUSMfjUEFcF2nKooGwEOGlzMqUFsCUA?=
 =?Windows-1252?Q?TqZiVN+E5V1Ph5KPRomBKeh9gz3vMhJzcLZzd6VxA/eXp6j/eUQJpBDf?=
 =?Windows-1252?Q?m2aDLyZwIzCWtrCyeRdS5CHoRcxW9/Tw4TZtIzKbCTzguWXGyIWiVkg4?=
 =?Windows-1252?Q?1TT2PFqFAjeqxaJrLt8pQML5AIt6vtBTwcOn3SutLYOT0sOps2OvGIZN?=
 =?Windows-1252?Q?6ULELRFexm5cZkzLVjCz+IW4I4k3kf1V/z9Ju0Fa7+cyqscWkGR9Q8Nm?=
 =?Windows-1252?Q?HyG+JwK/JBrwdkvzyqFgjs3Wz7yxWcppegSjCelmcG0pRrW/nY22xkOG?=
 =?Windows-1252?Q?nVGBqa5qxTFRzspy2DEqbrt4+dMNS7JjBruRbUpL/5d7VgR4shqB3ac4?=
 =?Windows-1252?Q?6XN5j6r79kaedOWqS/voxJjKWII867OoOdPIkMfWNrqlCUkyi4mIg+OG?=
 =?Windows-1252?Q?S8CfjnwTdr27S88N7njb5kLNLzF9XYiVGPHTHBgY8BFays/DSbocHv88?=
 =?Windows-1252?Q?eRWLD8Sk0yU/BcZAMqviFsWEce3vX3ehcmxHaM3aLuul2JWxz4C+ED9x?=
 =?Windows-1252?Q?MqIRl+H3/zsxPaKg+9U3Yp9eTm5yPgNSH8xPYJViR9mhnrdEKl+Q2GM/?=
 =?Windows-1252?Q?T4XLXaerj1Y+3bwxK7j3LI8km3t8Aw7lS5UUbGfIxU++eU9425sbG50F?=
 =?Windows-1252?Q?d9kGuRf2Jjao929Nr3yf3+GVO1XYGJg3NRbOglXeMU630LxUg0A/ciD0?=
 =?Windows-1252?Q?BHquj6u2ihsKguOS4vR+4io0Spp16FbipUObgAWRhRajkeMUKo3PMvbK?=
 =?Windows-1252?Q?o2RL6KcFmgh2Y74I2MQrJlSy99Pdn5gT2lZTb7RUUdrBVt4fPxP1ljik?=
 =?Windows-1252?Q?gdf0rEmguPqrAXVJ6guYaWpxVz3z1ZjiGV4QHlucTAzBQj22T4YTcDZh?=
 =?Windows-1252?Q?ZCeAUxeOXRxF28fEetR92wbskYN2KOZKvQrKR+fwDCzXQiTYRgMmb0Ek?=
 =?Windows-1252?Q?psCj7/38HnwM4qBVgar+mmyUTACzsJpSX8MXOb14D/ydL57qiE+J61Cc?=
 =?Windows-1252?Q?fYY37A44m+4YfVVB4kWtI2zPx7guxhtmS/FMhCZttmUtbTO51j7/Bqn0?=
 =?Windows-1252?Q?6VfYqwFF20KL3qqFm59kstcVPJHveapSBjUqcUt1pW55jYQx4zjaPNss?=
 =?Windows-1252?Q?LESWrox8JO3kWrfUtvmnQYrr0YQ5MdRUBI27cdOee7gRgcIZdXWiZcBO?=
 =?Windows-1252?Q?1fnZQPi53M5I/TFv2InKdpCH?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZP153MB0627.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2560f28-4352-4362-bbea-08dda0fbbf18
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 11:02:05.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEvlrKnmOx7BhPXZWW5garMeZhdVoF3Pz0ftGv9n+4tgHo1F+LAxQa8Gz0kmZxRL+tsLb0E7Xkb+N1ydwdnnfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SIAP153MB1197

Hi Team,=0A=
           I'm encountering journal block device (JBD2) errors after unmoun=
ting a device and have been trying to trace the source of these errors. I'v=
e observed that these JBD2 errors only occur if the entries under /proc/fs/=
ext4/<device_name> or /proc/fs/jbd2/<device_name> still exist even after a =
successful unmount (the unmount command returns success).=0A=
=0A=
For context: the block device (/dev/nvme0n1) is connected over NVMe-oF TCP =
to a remote target. I'm confident that no I/O is stuck on the target side, =
as there are no related I/O errors or warnings in the kernel logs where the=
 target is connected.=0A=
=0A=
However, the /proc entries mentioned above remain even after a successful u=
nmount, and this seems to correlate with the journal-related errors.=0A=
=0A=
I'd like to understand how to debug this issue further to determine the roo=
t cause. Specifically, I=92m looking for guidance on what kernel-level refe=
rences or subsystems might still be holding on to the journal or device str=
uctures post-unmount, and how to trace or identify them effectively (or) is=
 this has fixed in latest versions of ext4?=0A=
=0A=
Proc entries exist even after unmount:=0A=
root@aks-nodepool1-44537149-vmss000002 [ / ]# ls /proc/fs/ext4/nvme0n1/=0A=
es_shrinker_info  fc_info  mb_groups  mb_stats  mb_structs_summary  options=
=0A=
root@aks-nodepool1-44537149-vmss000002 [ / ]# ls /proc/fs/jbd2/nvme0n1-8/=
=0A=
info=0A=
=0A=
=0A=
Active process associated with unmounted device:=0A=
root      636845  0.0  0.0      0     0 ?        S    08:43   0:03 [jbd2/nv=
me0n1-8]=0A=
root      636987  0.0  0.0      0     0 ?        I<   08:43   0:00 [dio/nvm=
e0n1]=0A=
root      699903  0.0  0.0      0     0 ?        I    09:18   0:01 [kworker=
/u16:1-nvme-wq]=0A=
root      761100  0.0  0.0      0     0 ?        I<   09:50   0:00 [kworker=
/1:1H-nvme_tcp_wq]=0A=
root      763896  0.0  0.0      0     0 ?        I<   09:52   0:00 [kworker=
/0:0H-nvme_tcp_wq]=0A=
root      779007  0.0  0.0      0     0 ?        I<   10:01   0:00 [kworker=
/0:1H-nvme_tcp_wq]=0A=
=0A=
=0A=
Stack trace of process (after unmount):=0A=
=0A=
root@aks-nodepool1-44537149-vmss000002 [ / ]# cat /proc/636845/stack=0A=
[<0>] kjournald2+0x219/0x270=0A=
[<0>] kthread+0x12a/0x150=0A=
[<0>] ret_from_fork+0x22/0x30=0A=
root@aks-nodepool1-44537149-vmss000002 [ / ]# cat /proc/636846/stack=0A=
[<0>] rescuer_thread+0x2db/0x3b0=0A=
[<0>] kthread+0x12a/0x150=0A=
[<0>] ret_from_fork+0x22/0x30=0A=
=0A=
=0A=
 [ / ]# cat /proc/636987/stack=0A=
[<0>] rescuer_thread+0x2db/0x3b0=0A=
[<0>] kthread+0x12a/0x150=0A=
[<0>] ret_from_fork+0x22/0x30=0A=
=0A=
 [ / ]# cat /proc/699903/stack=0A=
[<0>] worker_thread+0xcd/0x3d0=0A=
[<0>] kthread+0x12a/0x150=0A=
[<0>] ret_from_fork+0x22/0x30=0A=
=0A=
 [ / ]# cat /proc/761100/stack=0A=
[<0>] worker_thread+0xcd/0x3d0=0A=
[<0>] kthread+0x12a/0x150=0A=
[<0>] ret_from_fork+0x22/0x30=0A=
=0A=
 [ / ]# cat /proc/763896/stack=0A=
[<0>] worker_thread+0xcd/0x3d0=0A=
[<0>] kthread+0x12a/0x150=0A=
[<0>] ret_from_fork+0x22/0x30=0A=
=0A=
[ / ]# cat /proc/779007/stack=0A=
[<0>] worker_thread+0xcd/0x3d0=0A=
[<0>] kthread+0x12a/0x150=0A=
[<0>] ret_from_fork+0x22/0x30=0A=
=0A=
=0A=
Kernel Logs:=0A=
=0A=
2025-06-01T10:01:11.568304+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30452.346875] nvme nvme0: Failed reconnect attempt 6=0A=
2025-06-01T10:01:11.568330+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30452.346881] nvme nvme0: Reconnecting in 10 seconds...=0A=
2025-06-01T10:01:21.814134+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30462.596133] nvme nvme0: Connect command failed, error wo/DNR bit: 6=0A=
2025-06-01T10:01:21.814165+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30462.596186] nvme nvme0: failed to connect queue: 0 ret=3D6=0A=
2025-06-01T10:01:21.814174+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30462.596289] nvme nvme0: Failed reconnect attempt 7=0A=
2025-06-01T10:01:21.814176+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30462.596292] nvme nvme0: Reconnecting in 10 seconds...=0A=
2025-06-01T10:01:32.055063+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30472.836929] nvme nvme0: queue_size 128 > ctrl sqsize 64, clamping down=
=0A=
2025-06-01T10:01:32.055094+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30472.837002] nvme nvme0: creating 2 I/O queues.=0A=
2025-06-01T10:01:32.108286+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30472.886546] nvme nvme0: mapped 2/0/0 default/read/poll queues.=0A=
2025-06-01T10:01:32.108313+00:00 aks-nodepool1-44537149-vmss000002 kernel: =
[30472.887450] nvme nvme0: Successfully reconnected (8 attempt)=0A=
=0A=
High level information of ext4:=0A=
=0A=
root@aks-nodepool1-44537149-vmss000002 [ / ]# dumpe2fs /dev/nvme0n1=0A=
dumpe2fs 1.46.5 (30-Dec-2021)=0A=
Filesystem volume name:   <none>=0A=
Last mounted on:          /datadir=0A=
Filesystem UUID:          1a564b4d-8f34-4f71-8370-802a239e350a=0A=
Filesystem magic number:  0xEF53=0A=
Filesystem revision #:    1 (dynamic)=0A=
Filesystem features:      has_journal ext_attr resize_inode dir_index FEATU=
RE_C12 filetype needs_recovery extent 64bit flex_bg metadata_csum_seed spar=
se_super large_file huge_file dir_nlink extra_isize metadata_csum FEATURE_R=
16=0A=
Filesystem flags:         signed_directory_hash=0A=
Default mount options:    user_xattr acl=0A=
Filesystem state:         clean=0A=
Errors behavior:          Continue=0A=
Filesystem OS type:       Linux=0A=
Inode count:              655360=0A=
Block count:              2620155=0A=
Reserved block count:     131007=0A=
Overhead clusters:        66747=0A=
Free blocks:              454698=0A=
Free inodes:              655344=0A=
First block:              0=0A=
Block size:               4096=0A=
Fragment size:            4096=0A=
Group descriptor size:    64=0A=
Reserved GDT blocks:      1024=0A=
Blocks per group:         32768=0A=
Fragments per group:      32768=0A=
Inodes per group:         8192=0A=
Inode blocks per group:   512=0A=
RAID stripe width:        32=0A=
Flex block group size:    16=0A=
Filesystem created:       Sun Jun  1 08:36:28 2025=0A=
Last mount time:          Sun Jun  1 08:43:57 2025=0A=
Last write time:          Sun Jun  1 08:43:57 2025=0A=
Mount count:              4=0A=
Maximum mount count:      -1=0A=
Last checked:             Sun Jun  1 08:36:28 2025=0A=
Check interval:           0 (<none>)=0A=
Lifetime writes:          576 MB=0A=
Reserved blocks uid:      0 (user root)=0A=
Reserved blocks gid:      0 (group root)=0A=
First inode:              11=0A=
Inode size:               256=0A=
Required extra isize:     32=0A=
Desired extra isize:      32=0A=
Journal inode:            8=0A=
Default directory hash:   half_md4=0A=
Directory Hash Seed:      22fed392-1993-4796-a996-feab145379ba=0A=
Journal backup:           inode blocks=0A=
Checksum type:            crc32c=0A=
Checksum:                 0xea839b0c=0A=
Checksum seed:            0x8e742ce9=0A=
Journal features:         journal_64bit journal_checksum_v3=0A=
Total journal size:       64M=0A=
Total journal blocks:     16384=0A=
Max transaction length:   16384=0A=
Fast commit length:       0=0A=
Journal sequence:         0x000002a0=0A=
Journal start:            6816=0A=
Journal checksum type:    crc32c=0A=
Journal checksum:         0xa35736ab=0A=
=0A=
=0A=
Thanks & Regards,=0A=
Sai=

