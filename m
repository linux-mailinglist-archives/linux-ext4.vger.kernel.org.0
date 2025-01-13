Return-Path: <linux-ext4+bounces-6060-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506EA0BC03
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 16:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E7D18827D4
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818B21C5D4C;
	Mon, 13 Jan 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="m6t+l8uL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B41C5D49
	for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782291; cv=fail; b=ZE7IdF8lSky/5rpQBhGU55LyHIhxO8jehHhVa9Jz8yAip+x1d4A1oWIpf5F6KwZLGB50lqWZ6aayRlpyF75QFZJS1xd2ENwLHUEnuwsTzFos6ljM/dkeK4Za8scHh9JetHIeu2gKamk0RYNLXg7u1TKjCGC8iGNjGaHpOTqLoOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782291; c=relaxed/simple;
	bh=8+23J3iqDX3pIwDvQN4jUZJIT+LJVRO3IJdIH1BxpdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjwxWNxMmK5wG31XBZ0jqQ6sqydICAGYMfVKzRxWDtukYqTEyNf8FEX5hZ42KoacM4nTOhIJ2hx9YGWVPA2KRvdjsy9S+P36cM9xG74wGqA8W2Y9lCzhz0CaNYPyuWZ08nSbxIBewLPv8XcVdbTrIZcUShvdVv3MEzAWaccwGzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=m6t+l8uL; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42]) by mx-outbound11-132.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 13 Jan 2025 15:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc3YRmlORziVPetTukupV9cDKLjgyusB8Mmohlnug7cRkTYNKHV2ZfVyh4ghYiptqbMoJy5LveisU87UcJGfsoLtJAR15Ve6+lGLjYi8uanWkReqwxq2d/1wQWAI4kdDV7OFvlg7NINwtyuEtZLSasdHOavCgD7fmCRiZck0stWRaxekFaxUAs31tBP9ndlM8y67TYpX1ziBX3TlzdnH4CLfLvE4WkKGNMjGeAHLZK83X90WCWB1iq2SySJKn1rlMzEaYEvlUupbIiXsXRgn3UD6nOddI8AUv9RiGVAr3WclGom+dc2MRGqDCgsrswB9KrJ66WmWEw3rLUb62WjyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnnN+L4y54h3B0ObKR8Iy336KrmejYuSd0r8jPkSFLk=;
 b=O2u7c3lu6OiCtOp8rZeI3qjhAeIr5QvgB2jTRC1n+meOmDkfWaEGfQq4yqX6eir1wuwngRgUna1+Dni76KWsmfXpT3t91XxRhcme53bUJDbDQzfBdCBEg1ErD62n5Xa758ZgVVkgLI1Cl+1Ib3tZ1kjTr9bmzIxervREW1SV6HVC3SmuYVmnOLvoxOCApyI76+tEywn+gGrKkxgvqUN1rv3Q/5aBSguRgzsLzfLnNvlpewG1Vft8qPAi+9t/A+zCN+iiaN2cyFinIC7hjxDMxMx4btEEVCzRhK9pJQzil3sQzEulVvAzTZVAUM419AtIyFtGoyYxwJQ6o9vfUXA6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnnN+L4y54h3B0ObKR8Iy336KrmejYuSd0r8jPkSFLk=;
 b=m6t+l8uLZjVZUUKtyag5zRDC1Ggwdwhs0wpo2A8BREVGKcLP4SttoGK6a/5czzbrv9TNII9Ce1/eHNyBdEk4P1b+FhGqe/5Emad/CYfYQMa6b6Gfy2Wk485wUPZ5fT/A2G9aIOJlF71XCn9yD2O47UrFhnYb+UfVBaLlxjULU7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM4PR19MB5835.namprd19.prod.outlook.com (2603:10b6:8:66::17) by
 SA3PR19MB7796.namprd19.prod.outlook.com (2603:10b6:806:2fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:31:14 +0000
Received: from DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::e82c:fd93:7fb8:12dc]) by DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::e82c:fd93:7fb8:12dc%3]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 15:31:14 +0000
Date: Mon, 13 Jan 2025 18:31:07 +0300
From: Alexey Zhuravlev <azhuravlev@ddn.com>
To: Li Dongyang <dongyangli@ddn.com>
Cc: <linux-ext4@vger.kernel.org>, Andreas Dilger <adilger@dilger.ca>, Jan
 Kara <jack@suse.cz>
Subject: Re: [PATCH] jbd2: use rhashtable for revoke records during replay
Message-ID: <20250113183107.7bfef7b6@x390.bzzz77.ru>
In-Reply-To: <20241104090550.256635-1-dongyangli@ddn.com>
References: <20241104090550.256635-1-dongyangli@ddn.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0001A04C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::499) To DM4PR19MB5835.namprd19.prod.outlook.com
 (2603:10b6:8:66::17)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR19MB5835:EE_|SA3PR19MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fa8de75-3b17-4e8a-0863-08dd33e75087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FtK2wPY0b0PLAmSAnNkgPdHzb9j1ZRoU1wENDng/hoTZjYYyS9ZoRJHBElTH?=
 =?us-ascii?Q?xd4wd+UxHhH67zi4rS6onRZWV8ju62eEIAXOSQ9zqZec95LU3N9OLSXzn/IL?=
 =?us-ascii?Q?gNFHyhKrBqSprV4LhbTgFRs32OU0LNjjNeWLhgvtWHIJs6zpZog0TIiydNYW?=
 =?us-ascii?Q?foU1Bdimvytuk40l5czF+sCQ+0mOfUWasR3POqxYeqrvxD/Iq3I4JxbjyZDh?=
 =?us-ascii?Q?82uBwwcWNWZ3HPk/NQI+GIJ+Se1O7jes77FXEe6lFaeFY581japByhxM5+XK?=
 =?us-ascii?Q?qnsz/Kr0qigCJR0P1U2YVCpF8KP5F3rYvjQGN1JOj8HU7OvfIsIxC7Tp37Q0?=
 =?us-ascii?Q?GoNKr9Ve5o6/+Si7u13QiLWsjFaLAMnUf1yVIsjG70AhRxf8+kGL/j3AsW1K?=
 =?us-ascii?Q?Qf826zNYBlwmcYXmCVwdTaTOWiUz06Nnj2OdNEyUqfmRhtotE7Fq2WKdAaIy?=
 =?us-ascii?Q?doGgbX89vvFtNfRogwf7vhbKUAuK3fEnnfkdxhAzJ9W/4uLMiMfnoeE6Lqxn?=
 =?us-ascii?Q?3nhhULqK02RxMvHLlBVJdqPo04PSVI9y0BRT+KFy+CNSwOerJ9gpyKl4CqRC?=
 =?us-ascii?Q?dpquW0vaKGf789ExGNvLD9Hga5mKadyQLgeYl46GqRKbdyRv4KtgNKIgAeKF?=
 =?us-ascii?Q?pllis+TgraQRZNUs1BQSysn/ZOclKEdhLgCHRWe6rZQq/HQlXky0lbKG5Ohq?=
 =?us-ascii?Q?XnOpNA2QLNhSRw3I7Ad2IUBvehUCwGpjpWSaMPRN7NMe1pxHyWLyulvVCeWJ?=
 =?us-ascii?Q?lWWi9Yq071swjsH21Bk/ipdxBoQfgppr4BEpaWPnYiAKm6jglGSf0xck4Y3z?=
 =?us-ascii?Q?egWzFYNbB4HX5yg7d7Ya4QRKyE8Poli6nulh6wZBvohDPTU+qWD5A045LrL4?=
 =?us-ascii?Q?jJ0raPvb46kS6cTYmJCHFagLGBe5SOYfr/G0yLnHI3m1jcRBBML5iREXxp2k?=
 =?us-ascii?Q?LeOMBXJ+yurFLq8Rx9wad27ygbrEIjqCZhP4c0DyONoY0P70JR5WXjhXYkAd?=
 =?us-ascii?Q?gXb1gLTj7lJFIxMiOybLUdLBdei9yHKbYfBZMwUgipLyzvCwEIUZmAZFGgY3?=
 =?us-ascii?Q?JRmv4XIDQXMfQiGG8AGxcLkPFKAurs1gc5MeU7mYNwn5F00j6Nj/9AmxHzhQ?=
 =?us-ascii?Q?sg+PwOwn88Qn4uy+ZTU2CuLRaLPNGwpdSshm8nfIN1R4qWJVUfaPSRNErulF?=
 =?us-ascii?Q?km/eZJ4ed45nWD1/leY6buaTvudCe/X2fjxueX58NGyD8HmdCid+wNztG31j?=
 =?us-ascii?Q?6YxjwYSJP6yi5v7yeJADHlz0HU+5R2T6eUg1ydZxpt4evwBFFa0WJVQKiYkN?=
 =?us-ascii?Q?joJ5RXP0x1Ogp2B2fx2PfIAKagTbg/82TvkOlVBwR+/tfrqDxO8X36s/9LJU?=
 =?us-ascii?Q?gqKeacmJuNvzSOSsKkMcc2AHOKG/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR19MB5835.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJwxra+Li9NgKjF0faOvh7cJX1oVjRUCRXPDzbu+99MDziMZtSyxaqLV7JG4?=
 =?us-ascii?Q?QkQglKgZBgV+0Z+NbDXs2Wv/V8e1+ZLToZfG/ratRr95JqM2KwmzEIfmCJv2?=
 =?us-ascii?Q?sPRZLyDftCn7C2HCHWuFuEFy0eNmxHmRgqTvxtsR5dJIaEqdCqTJ5BSK2v47?=
 =?us-ascii?Q?pfiZLkKhVDjv0XkjsCULYv/zBEyJA/9zerJgZ5BTt46uD4hzfv858XUGMTAm?=
 =?us-ascii?Q?0zmeP8PplytIjdZYC0p9CQksKIKLLgaOHZ/Q6mbKz+lVhyifjWNJWBRY0uc9?=
 =?us-ascii?Q?meAFzWxaemvvXdJHaopTdJtqoUkrFUkvGE7MfDauTJJvXwzUo78fv5K5kU+/?=
 =?us-ascii?Q?O2uqJskBMCq9XPAI4QzKm734ouHXNUEHIEy6hlpI+bkyM4UUoBK4TAZnqIim?=
 =?us-ascii?Q?wSb7PzNSxRwGlw+yLk6TuR8easLd4WsRzylXgQDcqPqyGaGn546tKQaUQshF?=
 =?us-ascii?Q?wjOgTWPRtTt5GFmTpOjyKJCqWRgmb4U1w7iPXYIqK09OOU1cJLjm6f9URA+b?=
 =?us-ascii?Q?XN4cseYyqHxmqn4EyNmnfg6VczZaz0DaCs1fyyw9QVQma/9GVNg5RZLVeYIm?=
 =?us-ascii?Q?kc8yuHvCveWb4UPnpoEqmMenK0Rqu7HzzKZ9tGJ9nCUG0IIp7tr3h1O02qU6?=
 =?us-ascii?Q?K8vOrY2F9XPqIbzEtf/s+ARO3+7lUV5Ve8BUty7VNqnFLZAIlwIlYDeUBhga?=
 =?us-ascii?Q?u5RwvXuEyGNEDzjqWFxU+ACD9vpSKUkfkh/GOWJX2UNnnfTSs3PvTwwZ3n9R?=
 =?us-ascii?Q?8FkVh3DjgI9scZchQ4Nb6TuNQ0j79IzYZOd7+4ipisrD0A2CyprpULoMiNb1?=
 =?us-ascii?Q?HsN8cZaAUl7f12LmPFomjBZCP+PWopw+DGXbdDqL9CS3mHJ+TqUyjLeez1xd?=
 =?us-ascii?Q?hchQ4MDBovP4Ez8cgHMlp4KkB6+zf6sdGzAyyDGw2xsrm3gWVOfFWEOyKscv?=
 =?us-ascii?Q?+mdp3/55QL52NuuZo52aPmDjSd4h0+L0dQsXhzg6t0Io1sQfE2dkXZeRteQT?=
 =?us-ascii?Q?9U8F8amQbBj9ZGIHEYXfCUWphxmS5H+rh7GsBOELAY7wh+eKBp+HW1+KlxBu?=
 =?us-ascii?Q?ygfh48FzXs0mumMGJFi8gl0rs7bDqPTaj2p7gqdOlEq91Gau62MP1MNzafAn?=
 =?us-ascii?Q?Oj8OJo/dcujDngSUEsQLjhmtEq38w9MWZn5EsfG7M5mlWFNDrXz0eom/owQJ?=
 =?us-ascii?Q?ag7eCYwyYLPki6I+SL3RBr2mGN+J0asWfrpXpB+Ig1T1qFUey6ikMLXjrr6X?=
 =?us-ascii?Q?xHs1Hq7n8o5OrKHCtffimBlE0YZPT5xPJDBIGX8Fmtp7M12bCSTCoXZIvHCb?=
 =?us-ascii?Q?r5oFNhj+n3IFN/zIR07HVJ9Js/dsM38uEPDuZJzWgREPU9s+NbLo+cl7Ip8J?=
 =?us-ascii?Q?vQzK4z7aRZE1E22zHiAk92Pi+/7XT/9TsrLadciSnijg3f3x76TFonNvPXTO?=
 =?us-ascii?Q?yTpMDLL07XgJTgyIL8phbfg4o266xR7ecU13IceRcRoGJQGhm6eM+Igse1Jx?=
 =?us-ascii?Q?rdjGug/y1yCbiW7MHtHfn3XbyiYhXfaR3JG4+IPj3JYeUnzRAy2vbHGaMQSh?=
 =?us-ascii?Q?PnhfqIvOKE2xvtfNOavbVq3C+R6O/LssyrbmOo4z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D6P4BOJlVsBJheXyJrxn2S16ISMXMKQUUBPvFDzZKbtfiNtwawusKDOOnjpVbeaMI/u7PasmcnMohwq3St9doPqu4XUIoShyMNV4a7pf+LhizZNMJKUSlexcAHMGVKbqMC5gJOvtyq2z7sObyQboeRQHR6ljA8dsWQ+XSTsX4kNvXAtaYRdHv1JQ4T4uv4l3MQ+EJTsnI558QuOyRLXxL2Zs9d+2AlQF35br9mhgtXU5tp99TOxEF+czANysgkuHOd2Rh1d3go7Bk246boQfuiV+GnvPXrV8YT3g018ga8PfUk0JLj4LLSIo7LpiA1vi48jYw0U3IGTyg0RMk5OOf6jneg2XiHMTMcvrnniOk/4Ki/w/pplLpWElBJ/lmq+9/dKrc+EmjUcp04FGwSNWa2l0WW5zl4CYNM+Ddjie1g2sZvMf0aiUGEmWMy/1WlittddypFZc0fQofNBk0+cY54xNNfreE7d+SpZ56I14fQXSvdJHQw5VGvtjsq9uj50zvY87fl6d5om89XAOgBqXslRpOsEKl3OK831Gb/o/tOgvnrB3uWTE1WBPkWicSJcjOgURw7ehQ0WsPr0HmS4IOUyJK4iob+6D/t9zbCTeQgrLUSbuwbQYKoRpWuSTxaFMIP7h1ftGpc1l8qSfvTuDMA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa8de75-3b17-4e8a-0863-08dd33e75087
X-MS-Exchange-CrossTenant-AuthSource: DM4PR19MB5835.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:31:14.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9AwJOnq5EY+OKyTZr7gKNHc5BN4AtqaYhr9NvMMi2kSXHeErDDJOyns2Z47bpG4EhtwL3RpMR8O3ROAVi0+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB7796
X-BESS-ID: 1736782278-102948-13443-4853-1
X-BESS-VER: 2019.1_20241219.1759
X-BESS-Apparent-Source-IP: 104.47.55.42
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpbmFkBGBlDMwiIxOTnF3NgkOT
	E5LTnV0iDVIM3UKNE8Jc0o2TjNME2pNhYA7+x510AAAAA=
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.261786 [from 
	cloudscan21-167.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status:1

Hi,

I benchmarked rhashtable based patch vs Jan's patch:

records		vanilla	rhashtable	JK patch
2.5M records	102s	29s		25s
5.0M records	317s	28s		30s
6.0M records	--	35s		44s

the tests were done using 4.18 kernel (I guess this doesn't matter much in this context), using an SSD.
time to mount after a crash (simulated with read-only device mapper) was measured.
unfortunately I wasn't able to reproduce with more records as my test node has just 32GB RAM,


thanks, Alex


On Mon, 4 Nov 2024 20:05:50 +1100
Li Dongyang <dongyangli@ddn.com> wrote:

> Resizable hashtable should improve journal replay time when
> we have million of revoke records.
> Notice that rhashtable is used during replay only,
> as removal with list_del() is less expensive and it's still used
> during regular processing.
> 
> before:
> 1048576 records - 95 seconds
> 2097152 records - 580 seconds
> 
> after:
> 1048576 records - 2 seconds
> 2097152 records - 3 seconds
> 4194304 records - 7 seconds
> 

