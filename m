Return-Path: <linux-ext4+bounces-2221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BDB8B44BA
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD611F22B48
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 07:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422941A8F;
	Sat, 27 Apr 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b="VQ0F6Yh5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7B4085C
	for <linux-ext4@vger.kernel.org>; Sat, 27 Apr 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202055; cv=fail; b=YXe0A1n1xK1Z+iDecn0uBZknw9HG2WjZ4iWko++yX1re8xazFSlTq/Bx9+n1DFBTsEIYFcYwYxW/AMLJQR4ZZIEsFfWr/cF+2HRugXyvxL2mOUhq7Jki87Tp4T1/lkyHXh0gg9EURi1JevFBXv8wL4bA9R1qj4YvoQyA1fUoxn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202055; c=relaxed/simple;
	bh=KMw5qHBrjI6OMbVb9HNekivTVfkBcMT1sKlMBZWSS5o=;
	h=Date:From:To:Subject:Message-ID:Content-Type:MIME-Version; b=UZGovLi8urrQ3NXi9Qm7ZqSIZJAPXknA8qmDZpfBswm07FnH/vy7kf8t1EGDCB8Wn52bsnbb1oYMQbit0KD8oW6esaFzV0BVVABKRKPPFJX5JNKxqJBXqtHwmFPFti0UtT1cQpIOINrvxHuvJ3xmL3M9Vs3s10XGo/z308FcUbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b=VQ0F6Yh5; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169]) by mx-outbound10-6.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sat, 27 Apr 2024 07:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h89Tv3yG9fwph6HP9JbKzUkyF1wXPIZso3/i6gSZNhcQd9R5+gSY85wtCN0M2Ie0byqkivWmR4DAkTznA+ghXNHwKwgpnrjbV7F7djNgYAVIi89hqJR16eVwmHqlMdDqJGKDmRBoCGqrg66CRAwFKAPZbp4N8LtAKTreGgNQLRFpowlgOd4rpXmEIfFUySgurtCKjbWL5Zmhcg7IS1eaVS68ajq7maRPNbpZkOvwK1PyzdKz3a+FF7iAfYSPac15yuMoSJdss6YmP3vk7ng+5URgjxdZyW1Zz+6HV67+QL43Q78NdeOvCNahsjZF3qik5YdpTrzEJtNAvQLq32Uy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWDLA3u+yoXVzUzNQOXlDJxWGXyXgNvBPw8g279/mgo=;
 b=VDrC0hPwQmhxuMGbAngENnNNRM3yld16NIKDaok06VKGetAgMuJMTgoUOX/m2ryDcr5oybBfA0qk5zpJ/Mm4o1j3C6V39g1/L0WcrgmhRo92EZrdl6LWiRrjK4QLe4L4lI4isTKSThQHxo4RcLP35dv6g+qVqhCqSjqzVczXZjhSxxc2Wj7AI+JbKGzbfc8vFuyX4Lj0qL2GjYFQLYP8s0Q9u+AS2Y4p4z/TL4YOXEGSN2aTggS0NcPyMy/LyqPmXovZ2U2/HREx71suNw3jmGEjD5EDb/FrtaGdpzulTtLnVZpOrjEsgqAFYMUEfRLu/aax0TDqrHmSb6uHdbYUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=whamcloud.com;
 dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWDLA3u+yoXVzUzNQOXlDJxWGXyXgNvBPw8g279/mgo=;
 b=VQ0F6Yh5NOxDV/IzqdWGJO4Gz9sNbXSTz1E+Tp0adnu/DxC7atfeNXKVIIwQLvmdbjHKSzY1u0XJH6PH7ltYErze3nuU81SYrI2FqIX3ESm20VTTMevvqogGCg5HMU0ymkQWq4CjrnwDcQGgvldzsydMdMKaREYn7bcN5oGZ440=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=whamcloud.com;
Received: from DM4PR19MB5835.namprd19.prod.outlook.com (2603:10b6:8:66::17) by
 DM4PR19MB5980.namprd19.prod.outlook.com (2603:10b6:8:6c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Sat, 27 Apr 2024 06:41:27 +0000
Received: from DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::bbd1:7a5b:d8c3:4a8]) by DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::bbd1:7a5b:d8c3:4a8%4]) with mapi id 15.20.7472.045; Sat, 27 Apr 2024
 06:41:27 +0000
Date: Sat, 27 Apr 2024 09:41:18 +0300
From: Alexey Zhuravlev <bzzz@whamcloud.com>
To: linux-ext4@vger.kernel.org
Subject: shrink extent tree when possible
Message-ID: <20240427094118.51194ffe@x390.bzzz77.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To DM4PR19MB5835.namprd19.prod.outlook.com
 (2603:10b6:8:66::17)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR19MB5835:EE_|DM4PR19MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d55e49-4369-4377-cba1-08dc6685105a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrAvOR7TbytUwBdhs7xVulprq3FAOkQmz1tYi2vhOUibFAJ6CLjpWM3Rponv?=
 =?us-ascii?Q?U1ypPaNUIZUjIPbw+hW5Po8B+QEAQnL0BNJVK8PImR7CySLfYZmLb6beHn5G?=
 =?us-ascii?Q?tYvvYDL4sALbRg90qFDx3LTVKhXkWwquLVG+0Yv6C6C8zYUuQx2aACKCUi+k?=
 =?us-ascii?Q?lSv1Rc9D6mpoQCHbO0bP+f2f5vW9jcR6ZufJ1fa+a3dV4arqhPOepHQM5esI?=
 =?us-ascii?Q?Xl7XO/khDLV0qjlqwTqw8b1l0w95+vV3JRzXSsa6qzTy5nWscamVRuHhEDn1?=
 =?us-ascii?Q?Mv2zbEIEkrs1JpJyKTw8qDmkFiFrn6lvXd0WLH7XKqTjZOy3L44VhOUfEDeS?=
 =?us-ascii?Q?mex1DfPf9Kw7PcKcMgTPVLYDKcZaRdHFKd3XnrcpWKA1fngWcXhZahfMdooN?=
 =?us-ascii?Q?wiDdpKV11M4ygssfURf1f6vIkDs7xE+92o92TxWWl7aeJzTifBRh634SG7Z+?=
 =?us-ascii?Q?mV8EVKAS8tXl7LvIGRc7b67pT08kCRfhOGcq0thFrTgC34NzMKHWnTgXTwDR?=
 =?us-ascii?Q?tTWWcd6FhexszoLv/oS4z6ECQKOZVbI/pcCI34fCYkdkBSwz0M24FqKnvzYM?=
 =?us-ascii?Q?RpDsnvtK0BIOAWINaNYcirhIjg7sXUmiNvEh8PirsI0AkRylSM4XvZO8yN4J?=
 =?us-ascii?Q?IUX6Fa9ZY3ZjPU4ZhkNdthZ4vsiuu6vizObcuzdl95Lr8DcAegFbH4tkmHqj?=
 =?us-ascii?Q?sAzzZtLexIuRPSRoJA17NWq7pu+B4zuqdiPF7jkqh1ovYZj/Rm7ovK7G6c3a?=
 =?us-ascii?Q?CSHm0R+7m+KIGEhIZATfAUzsSbTQRvcZH/dN+ZKwdMk+oq+nqe1zTYJ4rvJ2?=
 =?us-ascii?Q?5xzCaqOmnLLwdjHmjFJfP4kmpkZEYG5yQDHtMluNoQl++PbZQMuzB6MaCpHq?=
 =?us-ascii?Q?2slrKseAhmz1kyAsJ7hoQs/5PbslTiVVXVxgSX05kWt4XLBXkjBxHHHQRG/u?=
 =?us-ascii?Q?n5CskCn6Af/wHEQNW55RjYacdJJ1m6AfjHM7M1KWaNDdD2V3l8hP+Rry5+Xm?=
 =?us-ascii?Q?pYkIyg1QjO0TkB+qRdEdHsEn+BySUl+drVxFUzj0I+PRrrbTtUf8dqNqj6U4?=
 =?us-ascii?Q?Rh0vaBR9BvjP/p9X4pnzcB6zU6bRd95g0mRcVTtG0z0Jppib1O449my7pHKC?=
 =?us-ascii?Q?T/5gyPSZzJhRzqqPUOHcCE5I61AmBRTZro5VPZKUpRwZsnCZekNf+aNukV+U?=
 =?us-ascii?Q?XfWBPxS/xaGGSnHwbbEX8cd4FXCcKr2p69o2/rlAphyXoap8irfl+gXBADlp?=
 =?us-ascii?Q?oS51Mo1CMUUtkLX1hFdV/XgsaBWxjy++YstjUOjSag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR19MB5835.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPaJtVnQdxlmw8CBiq+tmcqnTdHiq/xjaISMAg5ROGn5JIs+Z6C8vIgV5STS?=
 =?us-ascii?Q?RCuEj22bh+Mqh3ETqxb2sm22DPVQib3eJp5Go4ObYPURJ5OVuD4qkE1Gu0OY?=
 =?us-ascii?Q?RimiDRb3dSXZ4BvxkKfL0sSMoDJnJudEdysGMxUlqO7ACz2Ffb25kTW3QZyM?=
 =?us-ascii?Q?JBPqydE5D+sEsNZVmzZhO2mQxbnLTi3oim1dnCaMvD9XSwbQ49aMJ6fgdi3Y?=
 =?us-ascii?Q?wXUcLPJ4LFAwg/CcGS6VQbGQL0kVm71cplKxNFt8jKQfj7to4lLzk4cSv8ZR?=
 =?us-ascii?Q?2YleG/9I7BKG7r0272dMPrl1g63J0ExesrJUoF2CHZS79ekPc29qhOpB5CQz?=
 =?us-ascii?Q?bTF+9+gHKtVPxgxdGzx8/qWpSr4xgPsSdYPy4eSD/yZGwCaEl0gfoht/dsMh?=
 =?us-ascii?Q?Uu+Bbkdt2cyabvZmu7ymH3wZbfDxa2gSY0GiT7ioOO+qhpzcMv+V9U65uS/t?=
 =?us-ascii?Q?6UBDGNGYs2Glge6im/XBavaQjpHgERlIk3+nd8p5BdtDXnjX/1PuS5vOUR1N?=
 =?us-ascii?Q?lpXLL3guaCzHAzGxPQKA3lNDSx7HrEmdhXEfBsVPinxt/ivfei1ppQ5ws1Fd?=
 =?us-ascii?Q?O9fXYKi4t+OsDmARpnFtaAlY5ukljDtDS+TFQkWFGar0vLjmlKueIsd4DPW5?=
 =?us-ascii?Q?UlSNCIj2pZjhD7BElgbdzHwlg5tQR83saf2XLCC7JxhUU1/QtnORRxDYJLly?=
 =?us-ascii?Q?pVK++MSxhpQ4sKDD0vNmKm8gHuiBc8teOIUxgfjCvNHKFxLNFqTjkK8tciOG?=
 =?us-ascii?Q?/TXxTHb6b3SXO5yclqHmOiDm7JJHIMb9gH01LvMFs2qPahZwiUwoM82pDAVq?=
 =?us-ascii?Q?ZVOMpQ69Si3Y0Xp4QtyyLxmpOXIwgKrDQyqILNCfI1/f0GNmFQrgMhj5v86m?=
 =?us-ascii?Q?YWtUF31N0cRyl3TG7hYMoxPdLJVe/g3CWmb8l0rus7idJugyc1FkrOrha/jY?=
 =?us-ascii?Q?o+RnPOhnv4KXw3OUFshj6yjWXF7SRUlhZajnvDrX2uxp3tDogtb9XXfSAzck?=
 =?us-ascii?Q?O+JcNbMdZ44HgV2hwOphFIg0xYBsb2/Gj4B+w6sfaC0iCPRGidbFCMNzV+lS?=
 =?us-ascii?Q?J/nozKJUv1yYqPM+ntj6PhQVP1Zb/fFAtB179Z1wu8i1YpPHHADvnfb44q+E?=
 =?us-ascii?Q?vIHIXxGhXVRyD2VYOYG2zsc0ZwnvHg4PNoRcL3ld/4WucZT78QD6hX6H0HFD?=
 =?us-ascii?Q?30jIiuVRfrvucRcfHNVtn7g7Jdmk1yfqtcIlChau0PdTEjGTQBqHNH69bURA?=
 =?us-ascii?Q?QzXOxkvkRcZvsCPV+fFeI/pNBaFoxLPerdTAk2kN6s5G7Lj42pF9OX/lSRr9?=
 =?us-ascii?Q?mJZO54ziGqt4poBif7TlPyMQGz23EjdCugIAvmKeO25jIMMQJvrYXu3nrOiK?=
 =?us-ascii?Q?tEoAJ460+JqXROlF7tePaNAsZoDkoVIV/gS6xh24eNbB/ZiFYdCCM4YSSIbL?=
 =?us-ascii?Q?/6r7g9JK7B1LSex5Ko/CyySQ7oLLF0zMff/ksMWdKA+g4nccLn/B8BMMX+TF?=
 =?us-ascii?Q?r0yMDbbL+auIghh77eHjBmjiFmXXy22YExTCU42V7bTmOLizMkfuatBoBX8p?=
 =?us-ascii?Q?uox6OZ2OcJLmI3kPei6e8VaBjaBnmGbLSck8Yprl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/tKsiwiDzey/9fsrMM9He1+H5ZNJGt8eC197Q5o9xi9EuEqVohbGIKxq3mkqXmhviqcWJ1X/IiK/HgLSCW2FiT930nvUnrZNFq5mTTj5upuP6AQZgIjrvM4ddBOaXrw/hcwobz4WMZqMEwrvFiEHPOgmmUTutHP/VvAomhH//pGT+EuJffEmT6cTGxlNo3bM7lvTMwjm8f0q8BPcBL7azLlyXFiX1RTiXSyJclKnMtUa9zO/HB+MF/L5GZzMW5u710VaRyXpV1Oil9sQs3n9HEc0sZzjPwtVASapWMIRlh0smCSTG83KMzQgNfAsj/WVNvpvaCkECtrX+n1jFn+VJ7LAo+UfUM7HCPt/cgz7m7hEB26/7lt7imLE2OQWrjFqcW1taoV2vnS06gGJFsdiYRUKMlz+cqeqIXKBzPqfHp9lfkjEHzWEUwW64EUOdCpTxZ9m2p8GnaJ/fmqUoY7Nz3qJ36R3lSZRUK9AfhGOlfyjyQNHD//OQY9zBLmv/4dsbtQ1s6wyIom2JEeII/68ioWQT7RmzMjSlK/L+zsQTNfPZWHRNYL7yADpM//PntDpR02rTwq3AfRNnbXO+jP2zBipgqtJ6QEItYVK92C2hcjxTKtNtTPFCaUg5Im8rSWhGFrSLND3hqygTiLwr7bcsNSIs5Vh1SZ4R/Nw4e1ULFA=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d55e49-4369-4377-cba1-08dc6685105a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR19MB5835.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 06:41:27.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8nMMkjC58q+C0vRE1gU5ONiL8C6WNZQumToDF0PN2Fx7bpIRASJS6XDRw8uNP0g0YD2I29IdHvvwsjc+hwHQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB5980
X-OriginatorOrg: whamcloud.com
X-BESS-ID: 1714202046-102566-11635-2766-1
X-BESS-VER: 2019.1_20240424.2033
X-BESS-Apparent-Source-IP: 104.47.73.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWxuZAVgZQ0NLCKMXMyMTUOM
	nI1NzS0swwzTA12cTMKDkxJdEwJclAqTYWAL+YjGVBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.255854 [from 
	cloudscan20-103.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1


Hi,

Please, consider for inclusion the patch attempting to shrink extent tree a=
fter successful extent merging.


Thanks, Alex

From 72a8dda0cb490fdb7fbcd0be2c19dbb3e2973b23 Mon Sep 17 00:00:00 2001
From: Alex Zhuravlev <bzzz@whamcloud.com>
Date: Thu, 25 Jan 2024 21:24:08 +0300
Subject: [PATCH 2/2] Shrink extent's tree if the next level is presented by=
 a single node and all entries can fit the root.

after successful extent merging a 1st level index can collapse enough to fi=
t the root.


Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
---
 fs/ext4/extents.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a2de6b863df1..d7ad0cd92dfe 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2025,10 +2025,31 @@ static int ext4_ext_merge_blocks(handle_t *handle,
 		}
 	}
=20
-	/*
-	 * TODO: given we've got two paths, it should be possible to
-	 * collapse those two blocks into the root one in some cases
-	 */
+	/* move the next level into the root if possible */
+	k =3D le16_to_cpu(path[1].p_hdr->eh_entries);
+	if (depth > 2 && le16_to_cpu(path[0].p_hdr->eh_entries =3D=3D 1) &&
+		path[1].p_hdr =3D=3D npath[1].p_hdr &&
+		k <=3D le16_to_cpu(path[0].p_hdr->eh_max)) {
+
+		next =3D ext4_idx_pblock(path[0].p_idx);
+
+		err =3D ext4_ext_get_access(handle, inode, path + 0);
+		if (err)
+			return err;
+		memcpy(EXT_FIRST_INDEX(path[0].p_hdr),
+			EXT_FIRST_INDEX(path[1].p_hdr),
+			k * sizeof(struct ext4_extent_idx));
+		path[0].p_hdr->eh_entries =3D cpu_to_le16(k);
+		le16_add_cpu(&path[0].p_hdr->eh_depth, -1);
+		err =3D ext4_ext_dirty(handle, inode, path + 0);
+		if (err)
+			return err;
+
+		ext4_free_blocks(handle, inode, NULL, next, 1,
+				EXT4_FREE_BLOCKS_METADATA |
+				EXT4_FREE_BLOCKS_FORGET);
+	}
+
 	return 1;
 }
=20
--=20
2.44.0


