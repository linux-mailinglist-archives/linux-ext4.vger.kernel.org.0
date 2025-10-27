Return-Path: <linux-ext4+bounces-11097-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2EDC0D9BD
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEB8423C41
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B757302747;
	Mon, 27 Oct 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxmNXwYL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c/YLkJOh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A50301498;
	Mon, 27 Oct 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568248; cv=fail; b=XU6sWa3YtvAP6NQZ6AQiRACXmFIFJETpGJ8KWFDwes8lRON9ccPZ/vYlvrbJuc5fFZbLqWEykXpfC8fTZq+tgvQdUFcHNWIAWLmNNgW1uFEsOefT7K61MApIjUy5LVzyy0jV3XqFPmeb0CTDKZZWKgUysCIcssFhPyTyxQZoi2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568248; c=relaxed/simple;
	bh=tsV2VFKw2sueroXVohIgNTy0ySqOkjs/tDFjwIe9y24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qZbkhjTFj16YvPMwuSpsXK45BuW6PYPT8CF1mlvjUQ186ohcxFAXBlrM22D//1Z0aeI+egnAH33avi/Eb5em4m1+u7OiQMqSNNV7H4A0wp+I3NRRqhJmdJyPqbQifM57FD+/9Z/YDSohp6baVu/9lXPdQnepCDD62uCnQD2EWI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxmNXwYL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c/YLkJOh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCCIla012178;
	Mon, 27 Oct 2025 12:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0m1Cvx3v1Hk32sH4rLjJT2lNI6KmuM2zEMXCCY+qO4A=; b=
	kxmNXwYLReysKl2DaNB2RmFZbSDzVXZpQzNGkKT8qDIWvJ1S07HDLAXUg9EPT6Um
	z4QILTbdj0hEwMBG1+6O4Fh94REfe6Xa/t1U7xkVJ2chCNF1XD5xxC0ji5pcAYvo
	HkrqSIEbmXNBsGGkTUX84S0DJq1MK46dZVS40EeOQlEyCQLm207tewlF+IVHosvv
	FN36VBhmqOdxmZLKOza9GrShfsKU//+AEcAg4bxH1bK4hJkGUSi4yfSNcjRq3vCc
	z3rO8jYlQGdkOQUM5iV5/ToJYgFP75iqD9sCCxECTan4qyMM35IO7loola3SNH6z
	x7YVe27f1PVpk5NIZKKuvA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a232urrb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RAIonx039106;
	Mon, 27 Oct 2025 12:29:19 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n06r3cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSI6iMjuLcdpXq6fdWzz0erVfUz2vVi+gGqI1mfpr8RLdOF0QGdjm/ceGeO9zTt2G7Tu/z8BckpNGjVfhtAl8aHIno/15dj2xMS7baT9m56RE66PhcnYmVBQjNCJIdPxDTuFrzOZfdVB/pR9E0i6E8/BNnwwfxo4K1rZazD6yFiskZZt7v1SAsuFTVPSLP52spealow81mUOyrZxH+pDui0/rlOBeuPHCOHqvg/qAjDwyuBSCRaS9umJfMVmrpBDlxIjzpGfQgtTNpZeGPP5rvOzMWcEBY2Ic44LI5Ow8BWoC5WuKfiou1GZOUTOK5VttzBQv1c7SF5vRhYGtDa9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0m1Cvx3v1Hk32sH4rLjJT2lNI6KmuM2zEMXCCY+qO4A=;
 b=E9Dl/3899Ti2wdnX/Onm+y+/mAQH0hD29FfUPQE4Z4O3IIo7qrtePMRa9S4tV7X5BLatNd0kx+jjgoupa5GqfuQVLeXhqZbjmsq4UJ2tytXdqriT8OZ/ejAVHd2QWd7uppiCIz8Xx0S5DjBo7uw8+M9CaU0Xbhykl6HX5OxsAcy6WBN69Ph9fgLQPtxF1xt7kLxRdQ+B0zEWtUzJAr0m1AZskbIA01cr1aCN12H2YgHvzK/KA5YxZwldqcUnhNM+OGm/4VULoDVNImclFjIny+SW5fOcCne/Zz+C1ZJj9TMdRiOsM1EM9jvn99eqAdmA5NrS9p01/5g3gEJVS41JLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0m1Cvx3v1Hk32sH4rLjJT2lNI6KmuM2zEMXCCY+qO4A=;
 b=c/YLkJOhOLo3k8vvwQOG5vbFJcUqdyEohng4N3hxTPBZKgjyW/SV7zfiP8Y7PiyTrb/v1Y0iFzwQrqPSxRdjmcGGBChXunq63P5f0zfUPipMosDUuayHujvRRrRhuVAwf0TKY6YRZZXfnHflDiGBi5LXaZd3AW6gqDQn0fP9hyE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:29:15 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:29:15 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 4/7] mm/slab: use stride to access slabobj_ext
Date: Mon, 27 Oct 2025 21:28:44 +0900
Message-ID: <20251027122847.320924-5-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027122847.320924-1-harry.yoo@oracle.com>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0082.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f0039b-2463-4198-c8d3-08de155470fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSXVqZ8CRMb/UpzFwlHi5do2St/pDlIUirHQrPHH5Ft0qwSn3BalR3Hs3LaI?=
 =?us-ascii?Q?E3KPbJg5OgFnu9mhAVi1f90YKVLRE3NejOHMIePZvgUwLl9LlywcJ2mfBrGP?=
 =?us-ascii?Q?3Qp4jcWjkYpMvxwEyom+BVy4nXa/buva1eVBMbXYi3Wiw+4XfC0iNeA9Iep5?=
 =?us-ascii?Q?0axWFcWXlySi/5YSAUgLFImcGGc+/Od7eEIpgyFevk1GpUJPSMaVftMlQLxn?=
 =?us-ascii?Q?0i6HKdO/pAcitXmu3ubDtCbvVG4wVz28c382fLdBJIWGE3euh6W2fcrhLhRW?=
 =?us-ascii?Q?RHqdQyJZRs5E9t6s42UXF/gXZks/gBd5HHQJ7n24ssaZ6insykoI0JLZu5jM?=
 =?us-ascii?Q?naNEEx32N6FlFkHLuU/s7yCp5rr3lMS1USNzYo1Cu4ff0ukUvZxbwq2ToMPn?=
 =?us-ascii?Q?Q+B9nYrwe5bna1nlVJusW1jANAAmTYUIrPUeepvUsHcwwrdF48H4N+P+Gcm7?=
 =?us-ascii?Q?qWAqfxlAE/VyqhZIBZ5OfQfrX3TUhFN8QnLq9avsMst4Y2tOKMJ2E4vUKYlX?=
 =?us-ascii?Q?GQyEWfinUB0RZuitf/gDNsG4ftBUtilaZjivnkGIjk/UGe0tVk8JNbz/0g09?=
 =?us-ascii?Q?oTB92id9sK4Nk/9yaG6YNbZEGHX/ow5k6I03F7+wb+ry2yxOpJlHCxFGnDnA?=
 =?us-ascii?Q?vUFWvfUSyKwvUJpkbOSimK0ul3IohyuujI3OuRqOfXSLSULeUYU4GbxVdZek?=
 =?us-ascii?Q?kQVeaUc5MccXv7wKg1wgmGcc2wixYMF4nJ3cYN7VoSZwohvm9BXcfvzdI8nZ?=
 =?us-ascii?Q?7iRmY9xsXTzWlRjgXqYOO/4hSjSXoYNrZAfwyY1kpNRjy1F3p6ImhrEaZhWg?=
 =?us-ascii?Q?nfibQt5ZRyuz4IkChSijEiL2QaSmmC4ojKozpoIYBNEk6UMBrxMsCnfH7Top?=
 =?us-ascii?Q?O9LFXFbhkqJD+S4/Zeo15SCxAIHM3JuVS23MMJzbZTiGNYnIpmRuHUCmxJz5?=
 =?us-ascii?Q?YYatCh5dbADUmcwEm7i7Prq9AK0wZCtCshve8m3clraQrkZXOm1SdDOSJbmg?=
 =?us-ascii?Q?quHIY8KEV2/1M//2oPlRLK+gOqPLIwNmij+HVlwZkO/BMFThim7hl7nEPdoe?=
 =?us-ascii?Q?XejDRQDMHfIxKO0vfhz2CiDrmXlQnheCXJovd1/tyyXLole7wnEm5GdbtHbZ?=
 =?us-ascii?Q?tFGWbQ6jFKO88+3BC+cSy8MRL32sxgCR4KiLPj6x1VayemdKlnvgvshksZ32?=
 =?us-ascii?Q?IzzTJJzcSTABTS35VhxB4AMSh1ZSVeAx2+3BnsCdgfqVd8ELB/fVtZANZCqf?=
 =?us-ascii?Q?+ucyPmGKHV81CtkEHxJZKOBxDjmFcnZAzZNKIzbUFP9eswTtnZ4g2QrU8viB?=
 =?us-ascii?Q?uQ9vC9zYHXNRoUo+npwKOo4E8B78LZ24snBPobNGBlikD65ZXfNl6UkGFviW?=
 =?us-ascii?Q?ZyG5HqvtRIgGLTFRLMQRZ79zNWrkh4tx0DMR1NBz6sZv9gDeOauBO+uJCaaJ?=
 =?us-ascii?Q?iq4EBHYM6EqYR3SsBYxrncR9oOFs+yG2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bcXU57DRcBt9MlSbyEaWRPE4u+Dc8pz1VuFs26SqV/+CljlYgJgkQqxQFyQD?=
 =?us-ascii?Q?UA8sMmdlgvPdtPFIM7U31rj7Ty1AldejX7zwBk8ksrDeJ9B36vQU7KHqF4eH?=
 =?us-ascii?Q?OXUtfH0lEuaU+ytTU8Z4AE9fDRZLTGNG/jeEEP+cgQP44NYc6nCyOqs5+o0I?=
 =?us-ascii?Q?mGp1eKaR1SGKch4tS0GOcOV+aZtK52w8zwREaEbvyK1pLbpJvhqFMoiEARK2?=
 =?us-ascii?Q?uLd8JpA0nDXHFnJ6YP7gzaaa410HN8YMF9Eq/fiRg3qZ9b2lYD+RKKcz1iVk?=
 =?us-ascii?Q?rHNODmXNnzJ+il73+P9d8DfSeFgKWIvqCNbz8ZNVWDoJL0S5JHm8X+ApP0MC?=
 =?us-ascii?Q?FpAeC6ckh+2sW70vFhCgBcaODzd0DGJku0HnyWJgMQxvqyet0xiQ6cWW4/xp?=
 =?us-ascii?Q?fWC/RKud6llhRV2hFEO3mF3kOCt0kxtYOAeA4EnF1NwQJCJ5NWwcfqAQvs/f?=
 =?us-ascii?Q?Dp352PNn3Y/bairbxG0NBE+oqqYSCrm5BtScs8QTlu9vqj7RnJv/vxp2RFXs?=
 =?us-ascii?Q?HsljVjR6UQs3hdVYWb/Is2PbFGbDbKUZIX30ZW1mhxRVIcyJXAJMHzp7MJ7S?=
 =?us-ascii?Q?jZ1+Tr+t8tl8bxt5mEuXge1gQB4ekrfphiDADH947ljpfHz36bXYSXEBpb0/?=
 =?us-ascii?Q?JKhQNU6T8KjZLw1ZL+Q+Wbm45TGpygEBEwvceLj4yqO1iUlqHe26TRWrB9oH?=
 =?us-ascii?Q?Gzq76OJQXheTM2fz6jO3+DPWAB+mrqTbEm9wSFV9S9MkOD2+DiI8lTJhGbjK?=
 =?us-ascii?Q?/ew4rTLBtdTbCKriX82tCglYJsmC/pyBQXMMZfn56s6TARlOznut3HitbOAM?=
 =?us-ascii?Q?6AY6uFtudOVlFEWa0nRB9c1Qbhc4XRjiFsB/OKWMaMqV3DwcFrAh4yk3KDQv?=
 =?us-ascii?Q?rtSkF/BELMJgZg1e7T/ZmZgG+yEa5H5SOWVhU4ATvU4jMMmTHJUx59KsUmgz?=
 =?us-ascii?Q?JJnwrmBoQdEqzXRdUIoqTGrtYZqaU5kbNzrdxupOoyFFgLqUQ+4L7VBfa8Ep?=
 =?us-ascii?Q?BOsR92qfcNTedz+yXQIkxBJ1No+/Odw6iRdXnZ9Mi3XjswUF+koEPqd5C5TH?=
 =?us-ascii?Q?fTzCszCR523O59+698iSiUZYqnmDE4Ih8rjpU2rqWrR7Kiw1/EOzG2kK/z+q?=
 =?us-ascii?Q?i/6wvQT/VAK+Xc1Y4UG0Wq1GYEBD8uxufpXIFSFsD4vCmAO5ouNYlsmFYWN0?=
 =?us-ascii?Q?Sl3j6a4kYISh/ieydT7LL6JvQkb+qqTUFUyuVp8cgZh5wOrpanhT+HmSm2Z+?=
 =?us-ascii?Q?MnwEA0OT19MyI17aR4H2gc2D+GrCnXmLQ8JfsSeJS6ft9/iSAxZEjQTBSYQx?=
 =?us-ascii?Q?gEl42X/Ou5eHDSZF4tW199POBxZsETJYL9wZGgX6lYJ2TOVIT033dpzPnkQ1?=
 =?us-ascii?Q?yejS4QZqhxHuZhe1lyP+Gwnlee2alAWmH2JZZknUWmjHkY7bU5b5hlZn9K1w?=
 =?us-ascii?Q?MyHD+BmWp91522+cfJdS7H4eW29/TWuBB+znMo2knv31XQUr3zddtxbbwHMX?=
 =?us-ascii?Q?eA//Wl4FznTHqS5IX/byhq+ieRAHoMH4ztW8m0l9lGizKsv6xMHSnaJmISbX?=
 =?us-ascii?Q?l3y9vGaVuWjpe7nfIlCT3jYQ3WE8krK5qzVgMJtw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2yJOaKi7FJHH+kZ3voW0rLIFqGJNcN1OP85w49RrX/yd9u6mLLwWbtaRkgXB8B4xxTbS5pV0D5DL/Qj5msePheJm+PYZNT1A+PM6W9nhHVOVukacnVv7cQas/BUatd3FN+Jc3WArLK9Fdb0iqxWc1vvR8M//dGKEaQPlDP2Gpg+nydRs1HblyWwauNOFaYlqvccHRhsX1EE61E70Sv97w0gtIi0gcqtu+qhX68Xvv/i0TM4DmKDvvQ7ml2MPsDtNUlOgAXHBmihZQ5oIuhk8M/8dYRQkXZVsLgDzDal2s5jN8TKeeIu1LPhpKzj6wP/cGi3mw8DHqxWGa0RpCDS42MYtHKRwTPYVgeUE9O3JzJogoYiA0IIZMbzqGcTCdttISDh17ON6QpAM1AcNlVUSj/rerflGDD1mmkdhNHea7/c3+MMJS2BNuY3dUHNGR0NOUpU5ig9XAZfDeVt3gfhViHzdgwjqpZWh5j/+8GCjx13JO0UYsnM97hxJiTFeEpPFFt53m6WjE8XLKyeeCeATObJIVK9A70U353XmDIEGtupcO5KJYVJgvEpG11WIkODnENyz7Mr/eymY/m8GbokMZ/DGoOXGGbg7r9niNqpmPIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f0039b-2463-4198-c8d3-08de155470fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:29:15.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfgBzvjUkI/mzPb6RtznjmVE1Ig6DgziW2BlZT+9npzrivn2ifLi2PXaTwMtdjENgHGCK6+hGYgtC1bbY8E0oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=978 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfXzsqjtt4Fvecv
 dygErwK6mfATQ92zVrAgZOYSilQzMoKA7Xf9RSoPjnl2fpzuPJUJ/LOiGzfTBHqDn//1ThFWc7a
 +8fka8fIt/DKdqwgyYlBj1qQ5JLjV+eO04fgGRGKn6ZDP5aMA+0OZvCgrODKfvv57LY5d3OIFt+
 7leyOpezA+Msq5Wwi5IzGRWqdqUOrF3t3PymqmlK4NKV0gNTU3gfxfAfcI8vtkXJ+PItFWkM/pd
 YenWNZSKgz607MQtz7uA1sivCYub1OsuPk9J3eQVXJ+Z9RZ3aiyr2yGRmjzAg3hq3SbddfLPHlz
 1SsTvEd/r8DBeqdYnzo+k6dxxd6zJKEFubIH5ysgXZjjTFbn0skzOeSBvfCmI5GCijcKJ/3A+Ut
 nq6C7l1f2a9XdTs8ZJu5mcICnjVPqw==
X-Proofpoint-GUID: oZLO7FiE94awXUaXFY8jmiF-BsOtTlh7
X-Proofpoint-ORIG-GUID: oZLO7FiE94awXUaXFY8jmiF-BsOtTlh7
X-Authority-Analysis: v=2.4 cv=abVsXBot c=1 sm=1 tr=0 ts=68ff65a0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=k50sI94EmNSUYFzCiwMA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22

Use a configurable stride value when accessing slab object extension
metadata instead of assuming a fixed sizeof(struct slabobj_ext).

Store stride value in free bits of slab->counters field. This allows
for flexibility in cases where the extension is embedded within
slab objects.

Since these free bits exist only on 64-bit, any future optimizations
that need to change stride value cannot be enabled on 32-bit architectures.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slab.h | 37 +++++++++++++++++++++++++++++++++----
 mm/slub.c |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index df2c987d950d..22ee28cb55e1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -83,6 +83,14 @@ struct slab {
 							 * that the slab was corrupted
 							 */
 							unsigned frozen:1;
+#ifdef CONFIG_64BIT
+							/*
+							 * Some optimizations use free bits in 'counters' field
+							 * to save memory. In case ->stride field is not available,
+							 * such optimizations are disabled.
+							 */
+							unsigned short stride;
+#endif
 						};
 					};
 				};
@@ -550,6 +558,26 @@ static inline unsigned long slab_obj_exts(struct slab *slab)
 	return obj_exts & ~OBJEXTS_FLAGS_MASK;
 }
 
+#ifdef CONFIG_64BIT
+static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+{
+	slab->stride = stride;
+}
+static inline unsigned short slab_get_stride(struct slab *slab)
+{
+	return slab->stride;
+}
+#else
+static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+{
+	VM_WARN_ON_ONCE(stride != sizeof(struct slabobj_ext));
+}
+static inline unsigned short slab_get_stride(struct slab *slab)
+{
+	return sizeof(struct slabobj_ext);
+}
+#endif
+
 /*
  * slab_obj_ext - get the pointer to the slab object extension metadata
  * associated with an object in a slab.
@@ -563,13 +591,10 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
-	struct slabobj_ext *obj_ext;
-
 	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	obj_ext = (struct slabobj_ext *)obj_exts;
-	return &obj_ext[index];
+	return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -588,6 +613,10 @@ static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 	return NULL;
 }
 
+static inline void slab_set_stride(struct slab *slab, unsigned int stride) { }
+static inline unsigned int slab_get_stride(struct slab *slab) { return 0; }
+
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
diff --git a/mm/slub.c b/mm/slub.c
index ae73403f8c29..4383740a4d34 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2134,6 +2134,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #endif
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
+	slab_set_stride(slab, sizeof(struct slabobj_ext));
+
 	if (new_slab) {
 		/*
 		 * If the slab is brand new and nobody can yet access its
-- 
2.43.0


