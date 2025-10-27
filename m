Return-Path: <linux-ext4+bounces-11091-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F4C0D8CA
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BEF19A473A
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EC830E0EA;
	Mon, 27 Oct 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SpdgK84Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QthBmGjD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E213019CD;
	Mon, 27 Oct 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568172; cv=fail; b=HTIv7XwisQZiBq2zKZ9kNT/fkOWYWiiv4n0c/yqfmQj6s2Z6Rde5V1wuwKg4SKyMqqKuVhx/yCU5vI3JQS61o3CMHldXTHz7fg43ozKtSBHDrgdCrzqCSHRJaM+UN22hvpY1ErptZfAEhAuJFjpSXw8eGH2lpwolKrL9CwUa+cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568172; c=relaxed/simple;
	bh=X5VwdLPqLl1KEDwBDbSBIVSvAr0fNIOLoPegtgaY99g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMJtDd7IZoT72WBAQVnV8AhzQXd2YuT+gILIozEsobwQF6H74D7E7UlUIgwD/6iTt27gvVq6wQxkAOjtevSXpwZxVGmeuMzwifxrqNZ+sZsfwriefQzcBpI4zHsY6dbrGdYUIiGBWoKZKx5iMscIPBVroSXqQdPLrwxtRdtnXMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SpdgK84Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QthBmGjD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCCY9d018909;
	Mon, 27 Oct 2025 12:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vYiQu729VWdgVPdwqe9GOhPcci/Po+8FXRfkTjo8K+Y=; b=
	SpdgK84Q0I6Vsh4r0sSFAd8FvxKRSFojuCgxdVkTXiCxXgZc9MMWlNw66s6onbb9
	5OFNOnouEYFojXrXm/PELRhFSSI5riQ74PDWOeILGO+qFVhPWOv+5ZovGD8skNPD
	ymMaqd3L9SkVBHZmvvlDSWhYltrg4YONYpi5srzbx13rlmx0SqIhdu8cEK9IycRO
	PxcdVoap42JkTMZblOcWw9XuTQQcl0whdisPNwYbfo7QBPLSnYxH6D+S/X9gxTDP
	64eCH4Kv2XTHxqbZTJMYs31A4t6DJKXWQtizWT3V6knhVURzupwjOjwqTgOViZKs
	w/ue8Kuf0/HVV2cR6AK9fg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4ykbba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RAYL9t035006;
	Mon, 27 Oct 2025 12:29:07 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pe4dk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVjL3Fo89N4U/Jywl6YERVo3h9wTLH5HRZ0m6gERfl0F31K2UR+FUIKxA8U16Fir8BUfAtdd/YIuEqTkWWtcoPYR0ficxWlHO64plOgw91x4kBdlCRo8yOfIIhHDcp2qcqFXIgk2o1baZD3gC43WEg7isX5pTvarmF3zVYzigtny/RXuqGdML3GQOHhKOwmogMK11Hnb3MwgeBJm9A1UgbTXJXgxyt1bCQInPtDf2uht0Y1WAnXs36kdhtxbgthq6dUHidvkL47muL9EsvMgQCsdlmiEic9y6taAZGGw7fuBWmZSabR+HT3GP5quRhjF9KsK7dEDRxWGJVouj1leGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYiQu729VWdgVPdwqe9GOhPcci/Po+8FXRfkTjo8K+Y=;
 b=Aa3f9RWNhfnIweWKuBKyYP27rFZ+QBqCzuk3e6+u90IhPz30GO4rSNuB6JmHILmrFGqnxbfctvxwF6fKrQH7P3NKxHTd77kXTYcNbCx0nv1P0otmnj0pil3Z9GAGgFT/e5q3OxppdcpF+5sZE0vzPzWUTinC5bVy6jOXnTtAPm5q0HDm52+9Dr4EFjAaTt2Gf3NbqShEXuER6i4iCFKG3gs5PLA7/4QaJDqIdo17TTpsVlq+G+BY8ffZRvWbodOH990te7PY/fY+D+dR9M9YyiklCmuWqiQaj/q/R44DLuFTvM58jooBZy75rBOVizeSFLrAfkgsI7/jvuFTMKHaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYiQu729VWdgVPdwqe9GOhPcci/Po+8FXRfkTjo8K+Y=;
 b=QthBmGjDV5cO5QJxJdzz2fpa2FZ/Ahwvdkx2RTH2O136fJ3OGZHUbSe03ZIx0ponw2Ye82XNk/mpCBKyzTWlr1dBg4b/mX02D0C0wuThPSrftBlBGRihT/PPgtqdSL3L6R02iZmxUmnCDloDV3/c38hGvEkBZsck8Sa35rW9mK4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:29:03 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:29:03 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 1/7] mm/slab: allow specifying freepointer offset when using constructor
Date: Mon, 27 Oct 2025 21:28:41 +0900
Message-ID: <20251027122847.320924-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027122847.320924-1-harry.yoo@oracle.com>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0162.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dde2137-9397-4269-c973-08de155469ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uH1ZSz5TBdBQBJVmN+kk6IJGB1Y1w9d+LabMcGvbX7N3KmCxCLnElWecwnCy?=
 =?us-ascii?Q?ztFvyS+vzikHUc5VaGD9RX65lhSfYIkcSe1Y+01jtDPlNJr9SMWqTl8lqnPt?=
 =?us-ascii?Q?oN62lnb6L3jDcHYAHyF4GkSHg1AgplET87BfWBC/GR2KZQWLhopc4x4OL2u3?=
 =?us-ascii?Q?kJF4GSfhTnbW4aee5GNs8kNdaQMT8M+J2+cxW6g4RrVbDrNywVFG0pVTM5LX?=
 =?us-ascii?Q?sirY7lwDF0ax+MD3i0kYdl9yRy+NTrhB0Zk8Qwgm/cfis8Za1+IQPzFQG846?=
 =?us-ascii?Q?kQiEN3JoGq7078KUlTZ8cgQuH42LrAvBlzKwAKXX/62DpEU+ph2SvUlRYRej?=
 =?us-ascii?Q?IrKO9Y4Tc9oZRcibveGMETYNcSkpGGoYgG/dF3AFYHWqL9AJo/aiGEjNvsn6?=
 =?us-ascii?Q?yiXxtd7WQgfO5j3M2IGpIqAJMPrt5VttOKmfO0o/GKevtIiPPvMeooP+97+9?=
 =?us-ascii?Q?yCM+zec9VSnfiiftku8kgXue+6GKLJj+0Pw2l9MO80OSScopGettMeYBg1Ri?=
 =?us-ascii?Q?d9qqmcWaCM+JkeBABnIuQvXyW44pzC+o8QqoboMbF743PYqvaN3RpvBDdk4C?=
 =?us-ascii?Q?P7+MNLJ6XmDQDADwa3J5VlNjSJdo5S8dhwcOes7HxKp1V/lU+GI3hpzu3+Pf?=
 =?us-ascii?Q?nTDVdKV7wgE8utkD/VmX3/QgXZjZclcQOr9LeqAoPdDjOaQbPxP8zkoIEDj3?=
 =?us-ascii?Q?ulFnhWeeJ/lz8hE3hqPf2NC19hZ8uveK+h66pj9xalJfGKAZt/DGf2oqTweF?=
 =?us-ascii?Q?qmPz0YI3n2Hr3KLcz1mR/tSekhsfG5+WHt2dBBGJV6+Vbc+cyZXZ0WhtSi9q?=
 =?us-ascii?Q?InNLMOTkEjBSps/bWnfOaPWkiUHtK+i6GsrMNNLbNKNZlE7QUGtBAQQijs3o?=
 =?us-ascii?Q?fwTQ+6/ZKoGC5YI1U/13f88182oDHXv8H9bmqqvdH09raodoiLus552IGuRV?=
 =?us-ascii?Q?R6sVVwJ/8b3URtKzaFvexO4yDa9WwlviLaLkUSFTXGFY65aW3+eGPoQ0tqyE?=
 =?us-ascii?Q?zODsNWS7qLMQMEJmH3h9j617+CbcBd4G0ghQWhfUoANTryfHF7fNcW/HnOMS?=
 =?us-ascii?Q?jKoAtkjiPJFwCC/ZZ9LCkGuDVhz85eRpESMfTlC7htoUIdRjgf64KLZfAeZj?=
 =?us-ascii?Q?MSv8Z7xUwuQmx3R9n9kgw12zZA3pDw2DLFuSn2MO892YYtbcVTfdNPyG36NM?=
 =?us-ascii?Q?159F36QFKPyAEMzMOfTxPMGZ2+Jrsd0On5klP5Ds4HEthhSpcIYL03aG2xeF?=
 =?us-ascii?Q?132Ps/et08jGRqQv2GAebmPKCYwm+iq7+CYrt3i4qjB4hq7yt5DIeF7HSkB1?=
 =?us-ascii?Q?mUzMaCX+mu9gb0vErxgZ/GlPeB37FS4dPDnBjSXz1MFoUUdh2rpyKjW0np/A?=
 =?us-ascii?Q?NeSuWf/0MQ1MnK8T9jvTQzecwRbgqYb95l04kVEr896m3qAkdG8NMru/ZAXN?=
 =?us-ascii?Q?PTNeZUPO9Z2WUwhh3wxL4Ll4c2QGOH43?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iKkuE5V39bYen0T9qKpG49W6RIiwQAT1Igt3sHQkcPqWnqgSyt4NVBdSjFpj?=
 =?us-ascii?Q?sYtfoEOyFeo/hi3ypN866KICLNn1IBtR2diH7JiM4YFalG8+do6BPuQzWU2w?=
 =?us-ascii?Q?SS0GrYRTPvflv2xQHOTASrfkR2KPrvUR8xpHh9NBgEC5+OCdSLLYx9gX3qvT?=
 =?us-ascii?Q?r0QpzE/OyX7UacJpw6sk0a5v/XYZ+IFR+tWvv5A0jsTxtYgZbqr4+GDGObAC?=
 =?us-ascii?Q?HPu6ZKWCmg6rbf2OAF+Q0dD7smAFdjPK07nS/bllqEWkTixH8PgKT1h1pq36?=
 =?us-ascii?Q?WtC6Fr+GJRXGKWJfIeCA+QQKn/jO1NDcUUz19iRc/7UeCoX0/ipRV7b8Q54E?=
 =?us-ascii?Q?gFXliHQroevfVXzngOKggxCqacLPnKCxTrUzb23CUbfDyHRu4jZm9qQdM7Hv?=
 =?us-ascii?Q?JG+MKSNeMhvgfUvjNMdeH/RJBFityQdwyV48T1GqGF/7w0IuQBaPTCXaUWrS?=
 =?us-ascii?Q?ppswD7GVLyIYn2JVhN7CUoTbzucA8bI8sd4q4E27ytSMyLjp7Ic7ZcSXjO+E?=
 =?us-ascii?Q?cfqe/a/nhIs/r9su8akKoWbytxyo9iEB8gQiopzMNkndM437/MtddP/n760l?=
 =?us-ascii?Q?lVjO+OW3dgDD1yMq8yMt7mc0cvLG8TCxZ2fuuC6n1je7R5b++Uq8qQde5R+F?=
 =?us-ascii?Q?hEGBWrLHDB6PaNhk6H1U4q0yzR/FLwgn5+iuzJOtlIa772FM1QhbCRg+uunX?=
 =?us-ascii?Q?cRSLLXR/d1EYCnwWs9BzKvXolrgWNS0xi12rEzUUbVXuyQl21YunjOr+NLIQ?=
 =?us-ascii?Q?Jx3rO7hrfanUknAyxUMiAzTSFjhw9OErNdpajHMHooZ1VgottNGKIfD2v1yf?=
 =?us-ascii?Q?C8CikWy0Wni5fS9fJQ1OxPLD4bDpnCYM91Cl+vC+4zJP3gesOAqfTVIYOtlA?=
 =?us-ascii?Q?KoiiQ/qL++p3vKgU2GhwjOhsH6pD1plYfxP+Hp7vN55hyGOiOXlzh9uJUKIb?=
 =?us-ascii?Q?q2RiBjTI4yefbStu9F3AUSNHy/ls2BY2XJzy+eVh2YR+qopfUbgaOP5oThIv?=
 =?us-ascii?Q?gfRFRCdfB5Ysw4VvqJzi+3Vf9JaK+EbdmAaO3E+hjlo31MN9BZ6BP0wgNoEg?=
 =?us-ascii?Q?y5tskTjHCOGPDXZWZokLHXjq13+yrsZrUAbDbDyQCKB4vKl/fyOrK9axQ62n?=
 =?us-ascii?Q?cXvqAWaPQMK+xXPq/xBLNFHf1CnAVzD5gP2vBg1h2de40jAi6wrZhvBYCz9R?=
 =?us-ascii?Q?OA3plfNRHjFd3UZKU+8gXyIerqB8O8j7T6ErDtYc5EVdWAqvSNLhjT2ZuCYN?=
 =?us-ascii?Q?YeUTREer1us00EZcqT91jn+PYQpp+q9MRfP3WLGyI1H7U/vsHsOSV+eBnIPB?=
 =?us-ascii?Q?FzpA3+clhBc3q0N0UZ5f4aULI2jlBFG9OwmId38xqMhJKG2oUyzxvOio6mcB?=
 =?us-ascii?Q?S2hzx7fYmsIZjK7+TCaVBS7cFZv6LslNpqPHKrJAM68MIpTG0Hf3lMo7BlSW?=
 =?us-ascii?Q?LYy+IpifM61iOmikhMCo1AkYbuZStEcKS5qsYahRLWFt8AYs4exHqv96m0gR?=
 =?us-ascii?Q?NJ7II0cTti0sH0B3dncfqvIjgOrfAL25VsBVF7mUWCTC4N1yM+yLlKLjbdnB?=
 =?us-ascii?Q?Y8IngbApQcNuU8K8oZrFURUN6lMPYHRZGR7fhzNf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wjrGW7OyRZSChvK87/lwPz8sccbQIUDbQAx4Q/Elb1bsbWUI9XbTN87N2d0BmQAQonU2pZrCIgUxjBrE5Isjvo89vY219NUb/5fXos6IPOd6vDqwWZ2kWyshvp4CpHz+Lgq0wlRArw9OnmZLqjDM1uibsESv3T0MItVOffiIJKK2QVvnvePYyjfbC4QOpXQA6coMvSB+eXB2JoeD1BrJxIuPSIjaeSzXCyPE/Dm6IjjI6zBWXhYkOCErvDlzwNr1WefoxvP8pRx0h+MZ4pOwBkn/YwqTH5AgIcmu7yn3lGZWxMDS0DFR8pM1LVDF1CKmolqRWEZWS/13bVFebsLSGOvBzdp/l2zQq1tnwkrWJ/5+CLhTUeATeE8mNnEEIN24R6a2ddTqQRa+SaLjTl+H1AfZ7HqJqMyDUTm18LqvQkie/vCtzmVXWrq4N6qn7HTdvmLKnjH4YszBMtQ7AwKk10InWNMa8WrAyQiHhaEYzzMAJ4EtV5dW+I5MuRf1A2To2CVG3hw5S1cLX6mtMbd5UPsn2Dxv3ucQQXR/j5HfCM97OUHn8YR6b85Intd59p2Dmhz4zbvCAlrduyCXGrupcYGyyXsr0XhYfR8YlFx70Fs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dde2137-9397-4269-c973-08de155469ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:29:03.6813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CO6W1f8Tge28PMKA9Ng9rGFSm/OHLDHEMIMrTf9S8JnA1z4BuTHJooR0UoGXWS4DqPDSY+CXS9cXegBxSxw4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX5Sq94GolXK3q
 xDHW1cvAMm/N8xJLzrICXmh+x5t2AASn58shzxSE+5vITyrETSTisZBX9JKhG3fqC5ugZBJGM5Q
 fjT9pMmS54FFcvCuZf+7Sn6sMeW21k0gU+XaiFnS/mGbQnrVuO5PHQylsE0BsO75jkjxVcj3VHy
 UnTtOjOwQULcpET6Hh9O6oZp19LHekpsA+6jFMApeZPxKYQBTJ5Cj27xz8+LN/xOEBPBiyQ7AV/
 TZBuq153PHVZ7gk91ZszaITRC0jBMOlggZzac6p4P8BPT9k64caZSRTKXNU/HmR5PDz7giPJr2s
 eKboyBeVt6wrLJVdflNfahft2Yu2O6oiX/yJraHU+XfBldHAA7QIpyU8hFQk/5sFuNumJr0Vv8Z
 od0kNjlqFm6tJmAezgg+W7RJmG10LrUwsHr5czy8XM8QNNgznoU=
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=68ff6594 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=D2mUB9UZQcPxL8fauqAA:9 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: faqi5X-TH-ekahnfYM9OnNfT1A_94F5o
X-Proofpoint-GUID: faqi5X-TH-ekahnfYM9OnNfT1A_94F5o

When a slab cache has a constructor, the free pointer is placed after the
object because certain fields must not be overwritten even after the
object is freed.

However, some fields that the constructor does not care can safely be
overwritten. Allow specifying the free pointer offset within the object,
reducing the overall object size when some fields can be reused for the
free pointer.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slab_common.c | 2 +-
 mm/slub.c        | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 932d13ada36c..2c2ed2452271 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -231,7 +231,7 @@ static struct kmem_cache *create_cache(const char *name,
 	err = -EINVAL;
 	if (args->use_freeptr_offset &&
 	    (args->freeptr_offset >= object_size ||
-	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
+	     (!(flags & SLAB_TYPESAFE_BY_RCU) && !args->ctor) ||
 	     !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
 		goto out;
 
diff --git a/mm/slub.c b/mm/slub.c
index 462a39d57b3a..64705cb3734f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7781,7 +7781,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	s->inuse = size;
 
 	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
-	    (flags & SLAB_POISON) || s->ctor ||
+	    (flags & SLAB_POISON) ||
+	    (s->ctor && !args->use_freeptr_offset) ||
 	    ((flags & SLAB_RED_ZONE) &&
 	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
 		/*
@@ -7802,7 +7803,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
-	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_offset) {
+	} else if (((flags & SLAB_TYPESAFE_BY_RCU) || s->ctor) &&
+			args->use_freeptr_offset) {
 		s->offset = args->freeptr_offset;
 	} else {
 		/*
-- 
2.43.0


