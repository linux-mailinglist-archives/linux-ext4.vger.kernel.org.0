Return-Path: <linux-ext4+bounces-4234-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7397CFD5
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B09028507D
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2024 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF5B676;
	Fri, 20 Sep 2024 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JkjHd2Hq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010002.outbound.protection.outlook.com [52.101.128.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927E10F2;
	Fri, 20 Sep 2024 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798500; cv=fail; b=kwz0LChdHkKGivMLMGyBPAC/H0NS6Ou8bJ3XI93GhkgrtAM6xjQqwuOdX8yF0vrROixci+uKnnptqHoonoWyONcaCamtEJ3vfNavWkDnRoY/i2tVpharMMT/2taVhswnp3i9Ksh4arpP13s3eBdNFnz6TbO1X1tKdFktAKFU6fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798500; c=relaxed/simple;
	bh=f+4s0swb9rmCNWrxSxfBvx/+I6kcMKUmz5DBiiNPFAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ti9sqsTSx68GTtcyL2GteJ7TO7JxIsEv1c2CsidoHmMXT/hjTYKQOaj8pXrL6iCnCOlY51PaQC9A5H1WRfOYFhsb3S4cYvyLLRAnMe7aa7bsUFLPBcsqhE/55KVl2PxOryUUZg65LBtl2yRhxpkPOtpCpvioPkimIxC6Usw15G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JkjHd2Hq; arc=fail smtp.client-ip=52.101.128.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scwflrGTJJR9ZesjoW6itLukvy/NSyEB3V0qHaxW95n3OaFDJ4I9JMZ+jZmrsX2EzreHQT0Lf8QBzInWOdoxJ7XNWPoAoGZJHFNJtgHwVjMtfM8ciZJBZ/GaWqPCEUx5v17kEgvTmIIFmLPJds7TC3kuB1pTU51SoSk5P6u0aRn9AcXdUVM+vjaO8DDAAbvES4mzxiKxymT3HBWtjKOmIXhNrEtr4KHW23exPT8QFrTdZDc8AFJB1oN3AzDt8vEkghhWUJFXnQZfYVDiavLh7/hxyJpbpEWaOuTa+J+JgvJj95RoveRQszgMWyhsMNPo7HaLB5+TR3W1PUdZ9Lx2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/geXDLf64QmyfCF/2jEFtNqeCcMI6s0BiR30PvKvlA=;
 b=v8Ro+LIqkNV0Opjyxr6j4vuqYvbIaP+ZqERlnLkt0BwK916nKgxC8Bi2p1BhXAo3b7QzTUwX3GnoQ4kgr2Qz81HR3g6j2c6CTDly2GeNEnRxiERKD6XtFsxhJnwGRLqjcLVjkJAluHEZvmqvPoDmSBJWjo+FI5wV9x5dh5+GVjQRxRzlW63zviFDQtQdjSqjgLYV6dW0xS2fmZbRaDeFhFyBz7gxyLQYdQIoyFhbibJnQBeF19fRBJ/t9nUocd0oPOeKzfd/07wMQJU0VbbXJ5Iy6zjcU4ycNCi2yfnE5uA5YMvuZDfbNDMaqoPowvc2sw9SbqpotBaaAMJj7H29yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/geXDLf64QmyfCF/2jEFtNqeCcMI6s0BiR30PvKvlA=;
 b=JkjHd2HqmKbsaomVzmLJ8a8veoe9toLTQONPXq70P9NnZfBTNbf2UMcYv8TuFNIYncA8EJ/9nzVuVgYi/gbEXkOMpuFVUVvNdHUgjmJS7OmlX5mfhfuioZYRsiQ5ltnYvZx/DT+peVJ43BhVA4xPAsEX0eF+TbWWNbyPY0X2Cc3twYVUwzUO7TLj+BhzJDtre6hKnGkI0l5SyTAwSPkj+0LMgo6y6bo2zheedGKg4ytx7mpuFK1b4DIA9XkCtBH0zMbqt7RCrhcxMBYiDhiUsxpCCpOBRxrGs1CfhdWdlc93txRp603hleDKHjBkBRMSXKHeOKyn7GR9VwpdhkCLmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4454.apcprd06.prod.outlook.com (2603:1096:301:8a::10)
 by TY0PR06MB5801.apcprd06.prod.outlook.com (2603:1096:400:27d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 02:14:53 +0000
Received: from PSAPR06MB4454.apcprd06.prod.outlook.com
 ([fe80::ca1f:8841:8cd3:1bb0]) by PSAPR06MB4454.apcprd06.prod.outlook.com
 ([fe80::ca1f:8841:8cd3:1bb0%3]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 02:14:52 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] ext4: Use ERR_CAST to return an error-valued pointer
Date: Fri, 20 Sep 2024 10:14:40 +0800
Message-Id: <20240920021440.1959243-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::12) To PSAPR06MB4454.apcprd06.prod.outlook.com
 (2603:1096:301:8a::10)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4454:EE_|TY0PR06MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab60fac-fd9f-4574-2a25-08dcd91a0304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rIpFpeyTPx21JPos+T9mZp5JPLI1KLIghgCfqrftq45OBEln4zNe24RdWZ+l?=
 =?us-ascii?Q?3rbu3ss/0LdJsCq/laR1t9sJ4NKmSMpPbDQIqjCQMQUII78qZM3yIA3TCfDR?=
 =?us-ascii?Q?X5ljLVQE7PtER3UoIxaZ3kap5ECOK1+Dgn449QSJGiQhDzClG4aF7ZqUf+0A?=
 =?us-ascii?Q?O8EGur0DrW6en1ZSJOgmGIe6+qz7H/7XnJYhUEzCT3zJqxMNoG1T1mtGvNyW?=
 =?us-ascii?Q?j6DSUySYegi7BQrnt0kJkwIPNWazQ05gV7F1v7FNAOuXrDv7qYoHO4LXikmR?=
 =?us-ascii?Q?Gc+fsZg1m2nxBQBh5G1spa+Nis4q3H4WqqeHLEkWaANTQ5iEZXk2HS+hWuVZ?=
 =?us-ascii?Q?6sCY++e4sTt1LGB88QuzLLHT2qNwZ4IBf1KXPoYjKZtKnUaahCnXkP2sRqnN?=
 =?us-ascii?Q?OKKGFaWLGShykxHdBIQxvCdAbVHhBSn8iLANhgSs6RgAcBzdRxmmr30qgjL/?=
 =?us-ascii?Q?ARaKY3jDuiOwbQ8641h7KWfI6wiRytKHY6MtL5JinR9y5l6t5KScS00TqRQB?=
 =?us-ascii?Q?w/altc9DW1w1DdNQqAcidhd/rN49+VMBk4c9WKxB1N05nwQi5ARDU4bNsaH+?=
 =?us-ascii?Q?4giUfmCr8kNq4opJOo8BMJwTI5OJtVHt4GEQRCBJHNzV5c3NaaolFaivh3Cr?=
 =?us-ascii?Q?V0ftYJH4Pgbc54pJ1W72OMuM3yEIBi5/qGkuVKrmIiPASeJ+yrbHmdSkYbWl?=
 =?us-ascii?Q?fmOhHAfapkM4q7SjxH6u7k6HOkkIyqr4qq05x1Uxl79O9kjmhO1KmP0ALsy1?=
 =?us-ascii?Q?33wXPLbbtQJCKGdIEcelvGE4MBGOl3aXGkZgPqzXHzrlCX98GKre93czjc4N?=
 =?us-ascii?Q?WdyUiaSNzZQc14/c86JUkBVuvBap0BP51+QlKgMP2n2oahf3KqYZSHyO4/J/?=
 =?us-ascii?Q?lzRNXUCM2ELq5mx7RllPdv3lfio8bAahX3YFlLJopcCaHkvR6a1EuJC8yu+O?=
 =?us-ascii?Q?qa3lkwYS08rr/8p5ZiTltLlkgG1GLGlWwWHdWgTA1S7kCi7x3SbSW4nbSU1b?=
 =?us-ascii?Q?gfiGjlHgwKB5RRpbnw3d4bDd6l4mFrRenBKEjqcbN/s5zFo5hG6GngCAruz+?=
 =?us-ascii?Q?0cMEeWY/3nkpo8m2v0RaMtnK4Iwoz0EOOltpg1X7Mf3oSwrcNp835FRjRdq4?=
 =?us-ascii?Q?smF7MfxhvhKWKhQmMdE0hx5DG45+TXX/W+7KMlNNX1B7EGynDI6NylvJqbp8?=
 =?us-ascii?Q?qhdlcmma1TcFHxqLzhKyAqknrwdFYJQTbC8xdPzQLC6CHOWLbWKaehsxwXPO?=
 =?us-ascii?Q?1J+bvxO6CoHoqXY3PpZaQmvqUUJkWKEW2zN0zXKekieJ01YmsXARU5bL8lJl?=
 =?us-ascii?Q?o+PquBEedNZAkQYvrSBvodhBBos7Qc/Smlk/bCmy+fiqtWxUrpRW2DwHU/Eh?=
 =?us-ascii?Q?xVtfK6qU+/1Y0ZoqQGYqh+AePV1TwzdTO53DjFPqWhY8mErOwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4454.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cTG/GbYzN+sbP4TmQ2nhi6sXY98sxzdViKYZOXgW8OJ5pyBAa6STA95ah+d/?=
 =?us-ascii?Q?nsLEpRG1TFtRc+BrRJQD66KwGpLMEN+Y7g6hZg6oYauFIRGbw6Lir1eUsfuY?=
 =?us-ascii?Q?CcfbKxRvWx4QzBQmjfO8ELDaGujKSrQlyiuNzPs4gq3FPIC7wZUrfDANJ8xS?=
 =?us-ascii?Q?5yR4hXd3Fu8LeagocGymI+l64FBrXCVEPh1u12aIum37VilX/PaWAQ4f/1TV?=
 =?us-ascii?Q?dp87PSm7hZtSKpFRd1MkGBRLLmpw7egQt+7PGeS8cXTFUPCjXuI5f1pkk0aZ?=
 =?us-ascii?Q?AeFtK/wTrSbENPTWEpbgKUpVAgElE5By0jSX535gUAHe6hQTBZX+8fPznerY?=
 =?us-ascii?Q?MaAI3zP8TCIN1IP/JAxH5yqE77xj7V1bny1mvjdJrRgAwK8P9H51IstP6uxR?=
 =?us-ascii?Q?CVd/mchMyo+Pr/gy4FL2Lr2YqhgeVdTA9FGQuzcPmoG1aSUfonb6XLAT6p+L?=
 =?us-ascii?Q?zqGtRO4KcBZSQcYOAO3iEqNxyGBaOusk4ePGwwu1QhC70nE3Z/7pVE4UEmeA?=
 =?us-ascii?Q?KRuC82T0gOmWtJ1sGV7jlWALnPjXLwJKfFQr2t8TJ6MmpREweA2vqyfaz1FZ?=
 =?us-ascii?Q?O+h1PFgHjJ5PwrkVT9W0muiOf3a2sZGd4OLTQ86YoIRQZebKKe+om8KR3Ro0?=
 =?us-ascii?Q?Vu8GR4J+j53a4muPDOUqP3HwdxkArogDld5kTnjDfGfG+LXO8N0sI0Ih21/M?=
 =?us-ascii?Q?3UmlWsgH1Usm+AZ9jeUxSfFcdPobiddt/PNwHwoA6i/zvQ8wasY3pJIaGPvR?=
 =?us-ascii?Q?BnI2mQ+xw2PwO17Y5IL5CMhe33k7drfe498KH0cnZC0lJYHbhrEUoSn4ZCE3?=
 =?us-ascii?Q?w0pafSIkv74Hc6+VqXc4jGnnk3FbKGf11rGDuZmOTZ1pHOxghGTA26lNFHet?=
 =?us-ascii?Q?eigw8jXVCbjAIqX4IiIMG0r8RACQolP+qe/qe1CfBog9B9gNKM1tv3Sw1eL6?=
 =?us-ascii?Q?NpyAvT2PeiVdiICJKXMr4AAGvWfDEcRxV+YoKTlPywzD/8S3kjg4Oa8Vi0Mi?=
 =?us-ascii?Q?rDACZo6SA2GdPEXLiWFjzsJrAmK1/r1FpEQV2yrzFqoaSBeaExk7/zOK7X9v?=
 =?us-ascii?Q?8d9nSko++PLiVgvc0i98GW2CCFcDZS2/3ue1Oleh5f8CWrtdNb1xdveHFelC?=
 =?us-ascii?Q?BNgr01Czjp9yob+4FYx3NgO6q1XRyhUuQ5+/H+9sTRTI6nZuv1Jv+WLo8yW3?=
 =?us-ascii?Q?s1Nh3JqRjBJH8G77h/PSEAufpf8hQ3XmDQNnosc/x1CSF/avq/vuVNeQ4IpP?=
 =?us-ascii?Q?kk6UqLFG+athz2AsnktOqxujch+EL3qFU8sej1z9H8SLPwZGjvkzl03463Rf?=
 =?us-ascii?Q?p04EcXhUztMyX/IPO8IX70YCVU86PHFLBzORnR0ckmusRxJ8hvs+FbxG27g3?=
 =?us-ascii?Q?r/ydtB+lgBlPgnCbtuApI9kADNbmaqKABZLftGa9J2C0yJY4mkLaLxQJL0Hh?=
 =?us-ascii?Q?y/2WuHVOIQHqwB10/3ze28HrFXQmqhw7EhHvHA8jaSglqspg+WHlhOfmn9P/?=
 =?us-ascii?Q?5DKlYtTdR8u2BhnznojaicTFBeknBhgmf9t5vTDw7AQ83rtdlWgdEue6tL5W?=
 =?us-ascii?Q?EIcUFIUOUCoLBEe3/WTYUoLkhee2nqnvMlbASav/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab60fac-fd9f-4574-2a25-08dcd91a0304
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4454.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 02:14:52.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNnZw+PU1Dq065H3PREMa3XSEHh2BQ8pZaGmroXxR0NmckhfSCAiXNtOucechULnI5c0I+nqvToG3TkYAigFxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5801

Instead of directly casting and returning an error-valued pointer,
use ERR_CAST to make the error handling more explicit and improve
code clarity.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 fs/ext4/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2..cb9db1e82099 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1747,7 +1747,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 #endif
 	frame = dx_probe(fname, dir, NULL, frames);
 	if (IS_ERR(frame))
-		return (struct buffer_head *) frame;
+		return ERR_CAST(frame);
 	do {
 		block = dx_get_block(frame->at);
 		bh = ext4_read_dirblock(dir, block, DIRENT_HTREE);
@@ -1952,7 +1952,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	if (IS_ERR(bh2)) {
 		brelse(*bh);
 		*bh = NULL;
-		return (struct ext4_dir_entry_2 *) bh2;
+		return ERR_CAST(bh2);
 	}
 
 	BUFFER_TRACE(*bh, "get_write_access");
-- 
2.34.1


