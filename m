Return-Path: <linux-ext4+bounces-4935-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A09BAF12
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09EC2813BF
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E318B483;
	Mon,  4 Nov 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="eSHaqzH8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15293187FEC
	for <linux-ext4@vger.kernel.org>; Mon,  4 Nov 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711169; cv=fail; b=X1hfjlU53ls1yKZFSlVglxr/L6nPmSnkHFwn2D1ooqoyEg2zW60TS/rI3tcoLAPeAMuFas20YTtj9EOYHG1cpqNNMuyM6GmuYZdlWvdV+izaUU8tZA/bK+ld1eVVt4dw+qV4cnyxYkQji5TBJtRWh8QAFJqLvf77JAsa5//kNL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711169; c=relaxed/simple;
	bh=oD3KORyyfg8RmVCLWH9RW6E052IFUr/C8twX4jpWUus=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AOsX/EclhQ7QYl5BHnx4JvTU/ry7VGzwPNJiMcU5wp7+TLwlSmfI07M312sx3/aX3osd+fglUWekJ+Z0dYRMVpx+6QdiTv1VJ9acFLituuZSza0lsuts0xoFIOxkV+mwr+d40cTbF+xnB/JrHUBJhfKHDrmE9VYkmsBFDbiDPzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=eSHaqzH8; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47]) by mx-outbound40-114.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 04 Nov 2024 09:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOU7IHkwscbvAZaW9d305Q6t0B47CkAttGu8o/Evjocs5qgrJUbbnrzpq1CtxLM3ZmL78eK/kTqIgtWabMq9TE74l/Vp9aaz+CJI/H1ARugyYR0QSqvHNwmUSHp9JUw+dPoFYfJf5tb9DRPyxhI2DU7wCDmCAKFtwkXhHkNzjP98AOxEAMtHPvtIlymeVXy4Ef56DIgMIQ8/BUDieycS4aSBE3ozECVFHmhm56biwjEEhEOH/2T1LI8BPUJVEbxlHvron4D17eTilKjHZlBZR4ZHQJIKwn0XRntvca7dFxZTQDmLwiIONhDyFOk5C4cORrnl53NqchMJISNe5IP+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRBqXmjK5h8XRkx+AEmQnWl7LIFNr1m0GqLpLLqBxyA=;
 b=nThnxWs7NSV9wUxzY6usV0QsrWGYkoukVtXKG6djyBe3dYkFDnCJ6SNegL1FQulhj8fKu+mtYa1I1JIYrAYpmXsAq29pxtl9a5qqi0vUcuinMkeTArg7irIuN23pVadwOM1Fk6B3ZNmNWFA31QaK6+JJVPwGxjURxz6RLnVT6OLHOV3Qgafa56H6xXkShlJjYzPiNUjB+NzwGB4x8W8CApNwJVWUXqrMOAr8GPGLlWBoJh5pO//YtsvtYhq8PkhRKjAQ6b85fpRKwgV9guXSBGCV+kMyZ+42kCBGa6g6znApMM4FUjNaP2/qwIYHSjuZp/qLNulDo0T30As35YUpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRBqXmjK5h8XRkx+AEmQnWl7LIFNr1m0GqLpLLqBxyA=;
 b=eSHaqzH8rFWtB4widliIh53OYAmS5ul6RbVn6hlEHj7ZW/oaTwkxLRq7lYhtmhYZtvz1FKJ7C5GSAWWnEdkYFEyq2ngzIVJfHRqhF1WFofJb1wY24hmPG52Sk0z0nsJNQe0YMguMB8gNrWog0oHZqlUe9Mqq0hGDPOCy48SRF2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 DS7PR19MB4517.namprd19.prod.outlook.com (2603:10b6:5:2c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Mon, 4 Nov 2024 09:06:00 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::5e92:ca89:62d3:f4ef]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::5e92:ca89:62d3:f4ef%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 09:05:55 +0000
From: Li Dongyang <dongyangli@ddn.com>
To: linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger@dilger.ca>,
	Alex Zhuravlev <bzzz@whamcloud.com>
Subject: [PATCH] jbd2: use rhashtable for revoke records during replay
Date: Mon,  4 Nov 2024 20:05:50 +1100
Message-ID: <20241104090550.256635-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:10:e::26) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|DS7PR19MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ee405f-9ad9-4dc8-64e6-08dcfcafe38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p683hhAy6GYzX560yB3eNYQEdaTbuz65amx+5JGjZJKycBdU3NBo70mxMyrz?=
 =?us-ascii?Q?3NK0w92MY1oIlNhNHSr1PwcE/rLRisXxJ9OK4iPA48FKK3aWTwz92QALtxMm?=
 =?us-ascii?Q?tuoPeS6dob2cJkSaneCjf55lAlTqbhpVvUvTFQBwrWiL+49H/7CqSUetwT/o?=
 =?us-ascii?Q?nX/rVGx1XgjtRWcY/+fPq+4lyEYw/iU/dYBnN2jEm6KzIXPr6zZXNqt45CkT?=
 =?us-ascii?Q?yrLnAztQwFO/9HskaTzmhtzYQuqXG2h6KYuQAj2Eb48atB3/rqOwYxYu6mb0?=
 =?us-ascii?Q?ArM5b9Rcm0NoRSTEXWB9PDlTjbsw2lqwiAoP2O0giVjNmS/A+UYy/I4frCWJ?=
 =?us-ascii?Q?VFU7sqIojSXvboJ+jWkoAfO6Qybn4q9t0pMCcGC0HfPr5FadWF9N0zcyPVS/?=
 =?us-ascii?Q?UYeMsNIREjODVPvMcFXODnPskB81Ha9pBVOu8F1WpR/trOQdx5o/apOslbCw?=
 =?us-ascii?Q?9N7Vj1caCTG6m4tUAgDergJQ0DC5UXac403w/Z0FUqk8vTMcMfkmZMH+3oFg?=
 =?us-ascii?Q?HTAGsAj6dvNctUD/oKIgg3Et9qEYrYz5mBvk0cand7GUJIpnxIRIa8ucJb0U?=
 =?us-ascii?Q?Z16l/on8CvSmbqQg0gUyC1kCOYnaCSW0Jc/kl8qX9lr69ccyaTrifN5seAaI?=
 =?us-ascii?Q?QqRDFwTkHecWBXFUxKs7R1Pf656G0EpH9Oq1wLpXrAdEO150nUGK30XWbUh7?=
 =?us-ascii?Q?GGgSLkFRmsPEuQH1iv0cFhpGAAQ1FDYJAf3lJQt+tkeGvT53/354fj1ytlZs?=
 =?us-ascii?Q?k5BdgYOJyufy11QAIhTPJpCpeZ6dFH7Xx/OAldZGCWsnD3jSrJzYV+KCYVqx?=
 =?us-ascii?Q?oDPcurMrQx3Ay+2QwDVi+k79guUWzznEYDfWnXac/YIyRmQYGNeP2wAQnYcX?=
 =?us-ascii?Q?vxPfJz9lgruNUhrxOI/cNZSKzIkBPCbdDzSdyourPfQldpH6EGqpuPDof8uD?=
 =?us-ascii?Q?PWnZkWnUqTacQ2aE8D/DizctLBXQ8yHPpSfZNE4XKvA7sylvkcXBN1IYUnof?=
 =?us-ascii?Q?u9cg70T2wygXRRaXghZ/lj91QZjjKO8XmmH63bsOZIY4rst7Py3kctBW1D2J?=
 =?us-ascii?Q?7JJsHYapFzWlz5YP1+FhfqzLS/yp7EHKzdH6CKAgNLmegnbyz7c5H0gSKFFg?=
 =?us-ascii?Q?lWiwCiCzk3KKIEbT7sUKzs2Lv7BqrTw7VMaV0tKkZlDRmouopGd+nH/l8YyV?=
 =?us-ascii?Q?w3aE5Zonz10ExZ5p2mEecWekB1uOmdh5WH1FOLCNHKtnBfDZBGXp6U2W9G03?=
 =?us-ascii?Q?Rh/JZS4zs6VUBOI6aMr6K4tGYaeU3UcLpKeG9gTAxBgWJdb7AW4Fcimz1YBc?=
 =?us-ascii?Q?6Gw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8jhHSuku9uQHC/kwoFa2LH//KHj2iDs+vSrDaxDJ1kUiLtlfzSqJYeQy+g6M?=
 =?us-ascii?Q?Hg4/f1pO8LBdf9viujWJg7z7rZZ0e3f9AX9VGELOfAd+BbCy+NcSYcQJ08hR?=
 =?us-ascii?Q?QOiXa138LPxV7RYi5oSCCwUb6hjhbPnRs5XAe6lYM9hW2wqg5fuUOy0Y0Ga/?=
 =?us-ascii?Q?FZdZ/UjleS5hxjK9j5Z4I0DHcQJQD5WShpbJY9VxP+ePDicFhchgHyWQnI7y?=
 =?us-ascii?Q?TxP+d5GYmPpDfCMENh9KVAHjBE/ya62AgO39tWQ47/Hva2SS2VIpXUlGiFzj?=
 =?us-ascii?Q?EJjrG/FAwN1QxgWPEnCqkBOFNAw/HX+V7K8hLTcYli6DV98Om5k03I1XDkZW?=
 =?us-ascii?Q?HhBkKo13e/8u/zRbStZzDKXoamwZkb6Qid1M+huFMC3/JFxEQ516h6x9l1Cu?=
 =?us-ascii?Q?TjQ8rN4jZH57SBRT/Lr1eYQhiErYFd+sWXF81ihGNzVP9JxDnUK3xieg6+rU?=
 =?us-ascii?Q?BRI9Ec9dsKAOvzoga4mAu1m8DJixE7vHOqEhyeVNx0Xdz28oRDoXVNxvdjHo?=
 =?us-ascii?Q?1ePO856JJ/YiJcBG5EeVTZrFwejbBdm0EkRfloL7yWQsxLI8SsOPhR05+6s+?=
 =?us-ascii?Q?rr+WbDU8yWv3/cei+yITxN3QL2qv5qc/B3yjzjt33JB+pBnNKovrCHNSkM4D?=
 =?us-ascii?Q?J3jrBhH1inRKJP4nkdl2heZgi82oynLdwI422yaI0ZlKV+d0pJYlxKwKfVwV?=
 =?us-ascii?Q?3TrCYwSxb8MZdU3uU72mk4SypiLRL5unY4ForJ7GOOoYzCOKdFSiEC3LtLX9?=
 =?us-ascii?Q?NxzfIcRO6IjLaucu9uZeSB9csI/PuDGvEPhdXYNjlauIIX1cCTspWQZHkoEi?=
 =?us-ascii?Q?oklhEOd7DVcx+nw9hAvWdDPhcqXu8iEWXRLlQS/dqgbuMKmVcXKrJNfsi8cR?=
 =?us-ascii?Q?/o8KgXF9tDlSafl12Bf5V8qow8UgpCqpaH9WVpSh9LllKrmPfnmtItJiWzLh?=
 =?us-ascii?Q?0NgMGKogdOdGVuaFR3lHlMk1gaKuzp29e5ewWIWdh5KrXO902ont+91+9bvX?=
 =?us-ascii?Q?mr/i8/bq05//gkLjZ/0CGuMIOtE98Hyuyq4aUKFAqaaaBsf7OEuhhnfm+8wL?=
 =?us-ascii?Q?RiUxNzpcMJj/6PaM1yUYXj1Fn1aR8eGUiJxCxA7Wzwgt8bz3DUXIjSE6/W82?=
 =?us-ascii?Q?I9I4mcuXMn5Lh/FnP2mGB5PVPRAxx8SgSok0LKAdJerhxS3wRAvIEFyOCdsi?=
 =?us-ascii?Q?11XFjFGPIT3pZhGQwpy/DRuRAi10a0FXAGyTtiqQk/QGLGW2FREqujr9gISY?=
 =?us-ascii?Q?kpgaWlm/koWYJrQNtnm45Vh9dBjWt6UGo78aEyO6b+yziXzx6qvxPR2ppO/Z?=
 =?us-ascii?Q?VQBhYuql9ad0HS05xnhFg3RBg+/6m+o1psrt+a1TSzj3wiM2rh1olokjUBba?=
 =?us-ascii?Q?YhR8pUVPYhIvPKwEMRTLoptVNn3QN8kAIk3vaXp5xZTR1GhRx6x62Wj+CTZH?=
 =?us-ascii?Q?NYH1c1TuRvkZOwvqsx63TMFpdCVY7poZqI96GA1jotFNstNXIRrLjETgC8R4?=
 =?us-ascii?Q?YjYhhEOBfCywfQmApnFeOmx/h72QVat0T1q7O6AJnfROBT6ZQQGjLJGpWpK3?=
 =?us-ascii?Q?3bYXBDJbHM6QhGQd+T0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1/7HMkc3awnfkF0Yh4YASJDji3puJXpRsvNgliobUmhAypINQD79NlVuH0HL5jf59ZuQ3ZHde/h0mvev7Wujw4u7ISZYKsJq8WWExwcWjs0j/j9wbOyGZ4gUDkx+PzoEFc6YNQ5x6xrS/1F/AKzjdpd73UZJuBDisE6hgxZ/3O5zJeAU0vH/zguqY23squnnhKlowsNZ9TuF6FeN2l/xxVdGzQQgh6fTdyv/CaaOiXXOjpI3sY+6JyyGM/0DMWAmbwcOdg+RDoDenQfjRahcU6UxdA8SGZarlVUuT3KIqs4b6FnL3nudI1s8HS8H6ThNM/2GyPR3nT321pH+WOtzjmS0K83QjuuJdnXrajlui9I0we+tHno2JqkzZELYlfV9UNaePTHc+4WhP64jzh02behXiPeLh2MmdkUXEb+D7MO8AeXr+qA9uL5e5vLcb2okRVgjlts2BQyMpZOtUYD0pM06tIzHUJIqQKQxhKgBtNcQHjDL2fgGbETFccbA1jbctSGXJUTZnu9HBQjtZoiyT8fGdfFrZ6zWWP0cPQOFUWpSYtdVMf4JXU/LaXda2CVWDMuNaq4cNLKK1yeFXWn6+yxbcgNbZtIaHw36cD9FPp8h7r1BGsFL73CvbwS7HQ7Dy+Wc7OlO/vtHKNNoTzREjg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ee405f-9ad9-4dc8-64e6-08dcfcafe38e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 09:05:55.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khdJ90nY/wfO2tLGncbMjfrnn8M5KRmljgGHqVu3PlqmsHI1VFfn0iQjC33b9o7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4517
X-BESS-ID: 1730711164-110354-12650-77697-1
X-BESS-VER: 2019.1_20241018.1852
X-BESS-Apparent-Source-IP: 104.47.70.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqZmFpZAVgZQ0DzNLDUpOdEy0c
	TAwDLRyNwyLS0lOTUxLc0kNdnM3MxIqTYWANhZqVtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.260190 [from 
	cloudscan15-230.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Resizable hashtable should improve journal replay time when
we have million of revoke records.
Notice that rhashtable is used during replay only,
as removal with list_del() is less expensive and it's still used
during regular processing.

before:
1048576 records - 95 seconds
2097152 records - 580 seconds

after:
1048576 records - 2 seconds
2097152 records - 3 seconds
4194304 records - 7 seconds

Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 fs/jbd2/recovery.c   |  4 +++
 fs/jbd2/revoke.c     | 65 +++++++++++++++++++++++++++++++-------------
 include/linux/jbd2.h |  6 ++++
 3 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 667f67342c52..d9287439171c 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -294,6 +294,10 @@ int jbd2_journal_recover(journal_t *journal)
 	memset(&info, 0, sizeof(info));
 	sb = journal->j_superblock;
 
+	err = jbd2_journal_init_recovery_revoke(journal);
+	if (err)
+		return err;
+
 	/*
 	 * The journal superblock's s_start field (the current log head)
 	 * is always zero if, and only if, the journal was cleanly
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..d6e96099e9c9 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -90,6 +90,7 @@
 #include <linux/bio.h>
 #include <linux/log2.h>
 #include <linux/hash.h>
+#include <linux/rhashtable.h>
 #endif
 
 static struct kmem_cache *jbd2_revoke_record_cache;
@@ -101,7 +102,10 @@ static struct kmem_cache *jbd2_revoke_table_cache;
 
 struct jbd2_revoke_record_s
 {
-	struct list_head  hash;
+	union {
+		struct list_head  hash;
+		struct rhash_head linkage;
+	};
 	tid_t		  sequence;	/* Used for recovery only */
 	unsigned long long	  blocknr;
 };
@@ -680,13 +684,22 @@ static void flush_descriptor(journal_t *journal,
  * single block.
  */
 
+static const struct rhashtable_params revoke_rhashtable_params = {
+	.key_len     = sizeof(unsigned long long),
+	.key_offset  = offsetof(struct jbd2_revoke_record_s, blocknr),
+	.head_offset = offsetof(struct jbd2_revoke_record_s, linkage),
+};
+
 int jbd2_journal_set_revoke(journal_t *journal,
 		       unsigned long long blocknr,
 		       tid_t sequence)
 {
 	struct jbd2_revoke_record_s *record;
+	gfp_t gfp_mask = GFP_NOFS;
+	int err;
 
-	record = find_revoke_record(journal, blocknr);
+	record = rhashtable_lookup(&journal->j_revoke_rhtable, &blocknr,
+				   revoke_rhashtable_params);
 	if (record) {
 		/* If we have multiple occurrences, only record the
 		 * latest sequence number in the hashed record */
@@ -694,7 +707,22 @@ int jbd2_journal_set_revoke(journal_t *journal,
 			record->sequence = sequence;
 		return 0;
 	}
-	return insert_revoke_hash(journal, blocknr, sequence);
+
+	if (journal_oom_retry)
+		gfp_mask |= __GFP_NOFAIL;
+	record = kmem_cache_alloc(jbd2_revoke_record_cache, gfp_mask);
+	if (!record)
+		return -ENOMEM;
+
+	record->sequence = sequence;
+	record->blocknr = blocknr;
+	err = rhashtable_lookup_insert_fast(&journal->j_revoke_rhtable,
+					    &record->linkage,
+					    revoke_rhashtable_params);
+	if (err)
+		kmem_cache_free(jbd2_revoke_record_cache, record);
+
+	return err;
 }
 
 /*
@@ -710,7 +738,8 @@ int jbd2_journal_test_revoke(journal_t *journal,
 {
 	struct jbd2_revoke_record_s *record;
 
-	record = find_revoke_record(journal, blocknr);
+	record = rhashtable_lookup(&journal->j_revoke_rhtable, &blocknr,
+				   revoke_rhashtable_params);
 	if (!record)
 		return 0;
 	if (tid_gt(sequence, record->sequence))
@@ -718,6 +747,17 @@ int jbd2_journal_test_revoke(journal_t *journal,
 	return 1;
 }
 
+int jbd2_journal_init_recovery_revoke(journal_t *journal)
+{
+	return rhashtable_init(&journal->j_revoke_rhtable,
+			       &revoke_rhashtable_params);
+}
+
+static void jbd2_revoke_record_free(void *ptr, void *arg)
+{
+	kmem_cache_free(jbd2_revoke_record_cache, ptr);
+}
+
 /*
  * Finally, once recovery is over, we need to clear the revoke table so
  * that it can be reused by the running filesystem.
@@ -725,19 +765,6 @@ int jbd2_journal_test_revoke(journal_t *journal,
 
 void jbd2_journal_clear_revoke(journal_t *journal)
 {
-	int i;
-	struct list_head *hash_list;
-	struct jbd2_revoke_record_s *record;
-	struct jbd2_revoke_table_s *revoke;
-
-	revoke = journal->j_revoke;
-
-	for (i = 0; i < revoke->hash_size; i++) {
-		hash_list = &revoke->hash_table[i];
-		while (!list_empty(hash_list)) {
-			record = (struct jbd2_revoke_record_s*) hash_list->next;
-			list_del(&record->hash);
-			kmem_cache_free(jbd2_revoke_record_cache, record);
-		}
-	}
+	rhashtable_free_and_destroy(&journal->j_revoke_rhtable,
+				    jbd2_revoke_record_free, NULL);
 }
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 8aef9bb6ad57..34e8a4ba9c2e 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1122,6 +1122,11 @@ struct journal_s
 	 */
 	struct jbd2_revoke_table_s *j_revoke_table[2];
 
+	/**
+	 * @j_revoke_rhtable:	rhashtable for revoke records during recovery
+	 */
+	struct rhashtable	j_revoke_rhtable;
+
 	/**
 	 * @j_wbuf: Array of bhs for jbd2_journal_commit_transaction.
 	 */
@@ -1644,6 +1649,7 @@ extern void	   jbd2_journal_write_revoke_records(transaction_t *transaction,
 /* Recovery revoke support */
 extern int	jbd2_journal_set_revoke(journal_t *, unsigned long long, tid_t);
 extern int	jbd2_journal_test_revoke(journal_t *, unsigned long long, tid_t);
+extern int	jbd2_journal_init_recovery_revoke(journal_t *);
 extern void	jbd2_journal_clear_revoke(journal_t *);
 extern void	jbd2_journal_switch_revoke_table(journal_t *journal);
 extern void	jbd2_clear_buffer_revoked_flags(journal_t *journal);
-- 
2.47.0


