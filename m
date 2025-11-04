Return-Path: <linux-ext4+bounces-11429-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33ECC2FC55
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 09:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD15189349D
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E983112D5;
	Tue,  4 Nov 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZQiMCjx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13062951A7;
	Tue,  4 Nov 2025 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243925; cv=fail; b=tOSSTTJ6SuFssL3k1DebirHyfh+i3jNinOOpxktgQkTuJD7/P3L09XiJIrA2sAEDh/uNBgTlpBzZte90tW6zK6Lw6urwIhxEK3X//4AliPZW3RGZC7PGFRzrGIUB+0ieceROcCB6Ta31KPkZA2nOh4zU3aKzjNGsEAAf6EzGPb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243925; c=relaxed/simple;
	bh=yiIY3Ja49P66kntoUomUFdrp2eXd0kUJhaEp/toOSEs=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=qByPe4MaQL1xCgwEANit7N7DeBU+Z06Yha8z/gv/2VTrDO9PkEmJX9lB+dflhCZuvoPMsaSjIXmlei0Le/lLSSFOW6iCwk9GRwaNg3B66ICHuLP8kphpqPTswJMSMCHzhtVPkxa9yFkTI4Ui0FzfSgeCgF3XtqJqQnvNwLvDYr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hZQiMCjx; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWvA5ZaEXxDPT421JED5HmbYlhToOSOhcokQhgYfHRctAWvW0d4BlnDSbL2ZZyRxs3oZ9M6u4W5hxKLlvS2ZgjGmcHtpBXwi8poI9Xkj1HWwwReH3oEr8q4r0H0cBqU3SkJzt5I5yZFiIHn9KTh11li0Ofk4QEyZ21A70ICd4nLpayGGo9S+skQ8JmzRLNYJAf95D8rnftk5+lN9zyYJrKrsb9WkGthHjA+H1oTnPmwCRxmL4ukRRtGPOXJc9Y8jLdUw6XCta5X/ff5WK6aG31e32yrWBH67gAZoiCYsy9XlCIUYjTvWMerOlLiNhhtk4W8pv6JnSrzmbQBXFhtlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuUmZ/DA2h9QDMOu69y/5zbkdRFRAqVO8ttKTxvAx/Y=;
 b=CyKew31/UF5qM0munkbCfmOpRGLeBj+4hBl3uH0Ym5ncZrKQwrUMdM1acFz11zzxnhENhoTNmtMxQGCIVVujtyLm8z6SPfgEThyRBDmxWHGy1lAxZpO3wUSbDwPzrLnLlcfdu5RxDuXwzihRX6vToMNU62uY3nNu5sMqbH6nhjZDm6iaRDojlncdU2bVNgRp4MRL16pLKd6xG+PIzX7K3+RGVVfQBah9GwDtRNh9x1iwJe+KobP1nd68DDCT1wwGy52mGTfdACJGgce15l6bH7el961py6xlL0A+4p5JOr5j4igA8ZtuyEaGIf+ZoiTClBLiLTCOVdLIgp9MNNaSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuUmZ/DA2h9QDMOu69y/5zbkdRFRAqVO8ttKTxvAx/Y=;
 b=hZQiMCjx4B7YHXJdsEEmfxQh3CIlAcdriKTNmIykZwi21jCvHfRvftHRxEeMMeQJshnoWydp0X9+O0o4KFMo60GLP6P67RLK2RQN8VCZwaYcBfGZlOE5iDhUbWMzRLsOJMgup0miy3XJhy03Q0T7jBCn9CJVRTjfk7sPpKK0uF+QdXE/llg8viNbkrcQ/hkAD9ERiCZ9bzc7SIbdZy+p8TCiMQWNf2VvTn3WATpc9FboouRM1lRhxyDW4ulkVzBmv2wQcF7LaDHHXRmPknex1EqhXhE3iiX2U4wh5JG6sUF8jXmMBfvBsXr5+EzeadQJAkeDAtOCFVmN0+sS0SysOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI2PR04MB10288.eurprd04.prod.outlook.com (2603:10a6:800:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 08:11:59 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 08:11:59 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 04 Nov 2025 16:12:24 +0800
Subject: [PATCH] ext4: clear i_state_flags when alloc inode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-ext4-v1-1-73691a0800f9@nxp.com>
X-B4-Tracking: v=1; b=H4sIAGe1CWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3dSKEhNd4zRLMxPzlOTUlBQDJaDSgqLUtMwKsDHRsbW1AIsBnQR
 WAAAA
X-Change-ID: 20251104-ext4-3f9647dcedd0
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Zhang Yi <yi.zhang@huawei.com>, 
 Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762243968; l=2196;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=yiIY3Ja49P66kntoUomUFdrp2eXd0kUJhaEp/toOSEs=;
 b=T8cPzbb7NJiJFN4GvWJl7J0H+hlIaGDOgYUne9cSDtxvuO4/r9jMbSGHGP4StD/NOHWdR1K4Q
 SqzacWMWGzaAM5Uj9bmJrYDtxImu+YVlNskY+pNszbo89LphhR6c2Lc
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI2PR04MB10288:EE_
X-MS-Office365-Filtering-Correlation-Id: 62fe3587-9426-475c-0b7d-08de1b79d398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm5OYkRYSDJSM2xER3luSU9kZGV0Y2l6bk5rWU1sWlpMenYzeEttaXdvOHgv?=
 =?utf-8?B?cmtpWWlOUGpSWkNhdGRuVUg3QmNsN2xzbG9oYmRtZ0tRRDRIQkNEendSV09o?=
 =?utf-8?B?b2s3MC9rUW5oRzgxQnJpQ29MQ2h2SzNGem5WM0RBK3pQU3RaRFU0NFR3eGlV?=
 =?utf-8?B?K3hFTWFFNWlpb25jSkVPbFhvdXo1Rnh1NG9sZzNVRGZDenJGdnJGSUtTRisr?=
 =?utf-8?B?bFdFNCt0czY2aDJYREw3N0pEV1lxcGZ0MUdqc2lpNHlUMG93czY1Qm1tRzdW?=
 =?utf-8?B?Tk1uSFp2aXlwRzc3Uno4NTc5ZThaR21BVS9wRjRWZGhoaWVtSEFZV29ndjJi?=
 =?utf-8?B?Y25WM2RkelNRQm9iVHd2d2xoRk8vcDE4cExKUGgxcW0yZ2VGcTVHSTZaKzVH?=
 =?utf-8?B?bFBCQ0FvVVExOVY4enJWNFpqdWdFTTFVeDhoVXJhanhWM1hqZElzVEtDYjhJ?=
 =?utf-8?B?Z1VpMWplSUQxTHk0RmFoQWNnOUtVSkZRanR6R3VrZXh2dWpkcEkyUEU2MlFT?=
 =?utf-8?B?ZjFsZlBvbytBUHlINk9GdmpLWllUVk1xeThLbi93dHBNMW8wWVhuZS9tZ2dw?=
 =?utf-8?B?UFdKWXBHTVE4L04yMkg3ejEzOGpWT2ZXQk9pdGVjRFhGQ1MrSzZyTzJCdi9t?=
 =?utf-8?B?TGZnQzdpemFIVy84ZjYxdmIyS1ZYWE9sdGJVWHJxOTVONndpV1VPSVpFUlNO?=
 =?utf-8?B?SXdmcVN6YkdxZS9kdUhITWE0NEFJc2dacDBMNWx4NnFnb1lPN1VuTm5KSkNF?=
 =?utf-8?B?dzk3ZFU5Tk5JcE5TTksxNEJwOGxQS3hJZlJqYkdHR1ptcUEvbmFFWTRCbFZS?=
 =?utf-8?B?am5yRFpOdktjZjhzTDJVS1hIdXZzYk5WdHFjZ3I1ZUFaUk1zS1BWdmhaQ0xt?=
 =?utf-8?B?ODB6b1NzL01VdWFrK2R1UHlmMW1VYktzbjVhbjZ5bUZmMVVQb3JYaDlSYmpz?=
 =?utf-8?B?STl6L1pZUlpGbmpyL3E5ZUN4SlErSmN0akRhWEk0ZzZSeGdwam5mUm5zc0tS?=
 =?utf-8?B?bmhyei9DdXZlejd4NHlKVVV1cXdiOW9NRzRFeDc2dzZCbXNoN1pBb0Y2Tk1P?=
 =?utf-8?B?QTVhMWZCR3I5VWFHYWtkdFNVM0tNUm5QcWpaTXJkUVk0YVE2cTlMK245b1pK?=
 =?utf-8?B?Y2xBWGJWUFZoOFNMOEE0YXhVS1JCOXJCT21rVlJCZld1a29wSEIrVkdrZkdz?=
 =?utf-8?B?RndoZEdPaVJ5L1RSQldnSGFPRDR4Y1NYS1ZRUzNPaFBsb3ZwNU0yYTRrRWdB?=
 =?utf-8?B?S1hwVlhEK21PZjlKRUJHeG9BRG5Qa1N0TXlxL0ZnV2FjZi9vSGFremcyZ21F?=
 =?utf-8?B?czFpalFzWFEwQWMrdGNVaVI2YWgwbHdBRExWV0ZXZGhvc2k0YUQ0eldpaDRk?=
 =?utf-8?B?WkZzMy9DMDA4d2Zteit4U0VVbnR0UjY1U21OeXRKZ0Nmelk2VTBQNG81bFVC?=
 =?utf-8?B?ZGNNeTRTSkd2SEdwa29VS2pVRENNcXZrNGFIbFg1UUxsbkVzRFJqRU1PY2hn?=
 =?utf-8?B?QkNJWmZKQmY5eUVXOWpEcjRzYjNnSDdNQ3cxUlRZdkZZdldYRCtUK0dRL0ZI?=
 =?utf-8?B?aWRNZkt1NUpLNDdIeXJZa2ZNU1oySTh4bUFMSGJrc3lvY2l1VnlzNlpYd002?=
 =?utf-8?B?cEhTait3eWhqVm14QUtzN1p4bHlRUXNmN21WVUU0Vk5hQXViV3cvbHhqZ2c2?=
 =?utf-8?B?NllFVHJCR1ZycmJmaXpQeFNMaXV2V2ZCQXY4a3ZqYm1nOVNSMExlMDFFWFlW?=
 =?utf-8?B?S3B6dys0ak0rSFAyZWVKdEoydXVKaCtoemg3blRiSnM1QVZWcFlpdG5HZVZQ?=
 =?utf-8?B?aWF5YXBwOEEvOVFyd0NzdlZKNDVjR3RiRHNLZTg0VjdzZWFDZGIrcldIYVcr?=
 =?utf-8?B?NENkenh3OHlhUU5xU2haRDg4QUNPdkt6bXp5UTV0Zm04SExCcXlmVnNEdnY0?=
 =?utf-8?B?TkFVUlVhaFhQRUlhTEM3ekpaVGpsNER5cEVsTGd6REI1UE1VcXNiWmdIazJZ?=
 =?utf-8?B?c2VZMzhFKzNLbXNYNGFtUmVvOU1IVkFtNEJEUFlxbk9RUE1WRy9Ec2E2bWNp?=
 =?utf-8?Q?dc7z0R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjAwL2lhTUFYV3liYWNUcThFcUNxczI1UitCSldkRDNNUStGM3lUaTEwREJm?=
 =?utf-8?B?ZEpiY0dxMW05UXlKNW1MQTNvdjNwcGY2RGQzdnQ2amMyZEI3TjdSQ0wrcmFh?=
 =?utf-8?B?M2dEbkpmN0NnVjNabFg3YWMvS21uMDZHS3ZTbVV5UWowTVY1UlM4RHRaa1Qv?=
 =?utf-8?B?bmovQUZxV25ieEwwbXpNZ1lHM1Q3OTErNllhZnVRRjlNYWhXcGMyR0VESDhK?=
 =?utf-8?B?V0FQRGR0bEVLbkZlbnc3Vm1TM0E4UnpyTk1xdk1lZkFoME9EZXdjc2ZUaWVl?=
 =?utf-8?B?bWdDWXRJVG0xR2Vxc3dGNWcreUNweVp3RkprRkxNRGFYV1hLTElESk5PSmtU?=
 =?utf-8?B?RGJaS2R3UFRIY21YWVFicERvc1I4MkpCZkQrSElLKy9TL1dLNUpxTzVFWjFM?=
 =?utf-8?B?T21LRmY5aHpqYnhlTFUyUGlkekVmRHJsK2JqRng5MnFKSWdMRlFZQTRHdVJi?=
 =?utf-8?B?Q1JyR0VRdzM0S3Q2VkswQmxtY0VJNDZKalBadGlmN2hRaDh3RnVacWVaRWQ0?=
 =?utf-8?B?VDRBUFdLczhkWXJjUmpCWUtVRmZqZGtDRzkzVkV6VVBad0NYL1dDVkUyUll6?=
 =?utf-8?B?MWNPK1JGL1VobHhDRUVVZjUxZ1VDR21nVjc0SXV0d2dKbjA1K0VjUFl4MFNB?=
 =?utf-8?B?aXpBb1FHUlpBaC8vOFp6UUlYTk1kK2ZTejNBNmVDSktpb2VZdmZ1RjJoZnk3?=
 =?utf-8?B?YVVTSEY4dHJLcDBzV3BkTmNqWDFLSUJMbWpUU3pjWHBDOGw1OWhSMFFyZVgy?=
 =?utf-8?B?L0tPaVB3UDhoNklVSVNpM0dLckNwaFU5MkEwcWR4MjVhdDhabUx0Q216YlQv?=
 =?utf-8?B?Szk1Y3hWYURpQ0dtQm9idXoxcTdNVGtYVDFhZFhCbThlRHY3TkV0Wk1BUVpr?=
 =?utf-8?B?WEc0QVIxRW4vQ2NpUFBPeUtwTHUzOE10eXQ5K3djOTVnZzl4UlRCcU05WUpC?=
 =?utf-8?B?YzJUZ1duclhhdko0VW5CaFE3M0E3RzJ6UnZjUzRIWWpTUHVBK1pvano5MjVI?=
 =?utf-8?B?bUs1OG1EM0ZrbGFuMlIxTExsQmN3bkNleTA4eWxIaXRXdW5jTFZEbUJES2Vi?=
 =?utf-8?B?WXhNTC9KWHZHajI5UVdJcGQySE15VStjdHM5UUo4aEU5UTY5SjdoeUFBeWZ3?=
 =?utf-8?B?TUg4UFlyTEdnNlFjNTVydDI5S3BuNTRLY243QnJ1djQzVFNnZmRJTGJGSjlP?=
 =?utf-8?B?bnl5K2tBcWF6RlA2clk3N0xQbU9TVTBkZGxyQW5jbEl4QkJDTXE3SEFLY2o3?=
 =?utf-8?B?T0ZQWndYcEpTZG9PTHhSVXJqd2w4eURJSE9WRWhoVDY2dy9DdXkrSmlWeHlh?=
 =?utf-8?B?Qm1OSjdjdERkeUV0Qi9YdklzYTVXZWR6d3FyVWVCMjRJb2ppMEVCRzRlQmhO?=
 =?utf-8?B?SktON2FOaEpIbS9UalBGSW5FRTdBeTZDVlF5bG5QeWEvck9ET0w2clZ4TWhY?=
 =?utf-8?B?UE5ZRTFRK1pOell3VStwUk53L2ViNUh0ZEgxOGhHUE8xS1c1eXNZYmg1ZnRo?=
 =?utf-8?B?YTU4UXcrbXEvSk1MTndFZmorZDM0TVNEVVB5NGFjMmtGU1hkSVMvUTdBL3J6?=
 =?utf-8?B?TCtoL3p5bitkNmo3VDQ2U1h5SjRMSGpBcmJNSDhUWm50a3YvZzd5WFgzak1F?=
 =?utf-8?B?dStMUG5CWHpYTXZ1bk9kQUprN3JGbkZjM2hpNm5ZcFd6Ry9nSStiYXZhblVF?=
 =?utf-8?B?M0VKbjcvQUppTHhiWTJFWmhqbHUvU0oydWNlSFJLeWZ0Z1VackZKSXJQR3Jo?=
 =?utf-8?B?dVJWOG5hZzV2Z0pNazVQdzkraG5Zc1h5NVdTSUNObXNmYkxnYlBFTFdyS0U0?=
 =?utf-8?B?VmI5eVFVRzFZRjMvWUdXY1EyZXlXNnRNbHNDV1JkTGZZdytmZDBYaXNnMnJu?=
 =?utf-8?B?OXpDYjY4cGtoSXRmdFA0dnZPZ2JySE1sSGVsM3M3WVl6elNlSzhTTnF3MHAw?=
 =?utf-8?B?aFJTVHZVdlhFejgyYkdGWS93UnBVdmRZaFdtVHArMXVZdENVK0w5QklTZWhv?=
 =?utf-8?B?Y0xGTVA2NDJQaEtoTnRydllhYzNlT2NDdncyNWxpT09MSGtYTk00T2xyQzIx?=
 =?utf-8?B?YmxNdjVQZHpBdlZRYlNCNk14WlZ0dzZEZ2IzS2wvRGdUMDIzTmRHUWNRcWxa?=
 =?utf-8?Q?sbzhy7YZn53dgSK1CQ9MTiPS5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fe3587-9426-475c-0b7d-08de1b79d398
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:11:59.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfQ5I6aHHTdBW3aIQYHWAVkHgnzVLciIpUEWJW6MgMEUMGfw41rlE3HqvrNX1JWKxlmRhbqA32duUHh9hFe16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10288

i_state_flags used on 32-bit archs, need to clear this flag when
alloc inode.
Find this issue when umount ext4, sometimes track the inode as orphan
accidently, cause ext4 mesg dump.

Fixes: acf943e9768e ("ext4: fix checks for orphan inodes")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 fs/ext4/ialloc.c | 1 -
 fs/ext4/inode.c  | 1 -
 fs/ext4/super.c  | 1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index ba4fd9aba1c14de56b89ebbeb4597f7becf947ff..b20a1bf866abedf3a768ee8a147f108ea09ecb01 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1293,7 +1293,6 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		ei->i_csum_seed = ext4_chksum(csum, (__u8 *)&gen, sizeof(gen));
 	}
 
-	ext4_clear_state_flags(ei); /* Only relevant on 32-bit archs */
 	ext4_set_inode_state(inode, EXT4_STATE_NEW);
 
 	ei->i_extra_isize = sbi->s_want_extra_isize;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a163c087137314c541ec10c011488c5392fb7011..bf6786d373ff57c32d5a84cfd73ea8a33cb68b16 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5285,7 +5285,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	ei->i_projid = make_kprojid(&init_user_ns, i_projid);
 	set_nlink(inode, le16_to_cpu(raw_inode->i_links_count));
 
-	ext4_clear_state_flags(ei);	/* Only relevant on 32-bit archs */
 	ei->i_inline_off = 0;
 	ei->i_dir_start_lookup = 0;
 	ei->i_dtime = le32_to_cpu(raw_inode->i_dtime);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529c357d291f40269863398753dc650..3dcc9410c09a55d5dce2dbff388a97bf4f133818 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1396,6 +1396,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 
 	inode_set_iversion(&ei->vfs_inode, 1);
 	ei->i_flags = 0;
+	ext4_clear_state_flags(ei);	/* Only relevant on 32-bit archs */
 	spin_lock_init(&ei->i_raw_lock);
 	ei->i_prealloc_node = RB_ROOT;
 	atomic_set(&ei->i_prealloc_active, 0);

---
base-commit: 9823120909776bbca58a3c55ef1f27d49283c1f3
change-id: 20251104-ext4-3f9647dcedd0

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


