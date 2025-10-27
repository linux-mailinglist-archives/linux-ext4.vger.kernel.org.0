Return-Path: <linux-ext4+bounces-11092-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7EFC0D933
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 13:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 371234F419A
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Oct 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A1E30F545;
	Mon, 27 Oct 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJb5QADi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GmSW692U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D923019CD;
	Mon, 27 Oct 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568181; cv=fail; b=KQdN9XocFqq2RUgQ22AaFHSGuT4n/rBT+w/llLjhBD930VE4MPDZTlItDT1VjL1nUa7ZIrDUETlNGm7abn9Muvf/ktLa2Om326AZuZrfISrVsnD2MOxaK62C+kB3XNPF70JP1jAkgvHFbZF1ukgw2Kvt6i632Hq0Hdgn4MhLdrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568181; c=relaxed/simple;
	bh=3YhIOkA1/Ov77PbhAEWTy4SXeqs2kNaqk+fFruNPnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHK9ZoGTH0RxhgchlABDlznMrx0nZWkponmYPxn/lPB8gBShyR9WPQl+LBj0B3IJSGf2l0vMSfZDMR3G5Xms+Si1vy4H3wnhxMNCge7rIf/UGEhZtd4jKsNncYtrDsd8mSY/wBZYB5J33dK8+f32L4c/QRqdJcdX+Eu3/nai914=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJb5QADi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GmSW692U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCCcwK023548;
	Mon, 27 Oct 2025 12:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ShFw7sK6iFqIIMiPSnfrnksmNtLHDon6V+HRut7xZiU=; b=
	kJb5QADimI7nLjwz6fN8/W4+3pIuxuT03FjH1unqrvrcU7GI85X5sjnuGzPhipHg
	Z9zsxTXQcgRs5xkKzjRfovaGmfilhQiQr7fnBTmzyBDjccuMrbwluUUpSeBSOqfQ
	ZAviC+01RvMqUzZym+1hhAo1a3fbDEvBESpSazsiJiJKKIJ/FrwFlQQT/Xl/OPkA
	MViAzVKxVNuZBK0ixf2nYMxPMxOpaSj7FjQJzVpjD74YCDqULnBekHRKvC2d7whZ
	0igUD503CJFXelax+fISv6okjagVMvuHvdjpa7JN4d152p5DPqT7TsaS9QYVCla4
	YiCwv+YW/8DqOx7Nn3vIWw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22x6rry4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RAj2Ak009057;
	Mon, 27 Oct 2025 12:29:14 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010060.outbound.protection.outlook.com [52.101.56.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0dyk01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVb+zmUC+vDX2N5YgLjzhGATAQ05POw3xpXbirDDU6eAJYW3dY7ZPI1kfMvZaYQ6TD5K9jGgbi6Bj9ptb5swfMXIVTJkHnBjw1qtX3Vd91CJ+TMuRYMdx8WWI0ZsYolgM3ZDOH7u++poovUeSdH5yWiJnvVnthce3aFSRJBAFDUF2tiLUVrua4k4KVqfpdRp1mAIWZtsS27+gzhYQ1wbcMlgSmkKwgidvel2NI6ZcODpfhZ+Q8cQP77kn3yjHbtWxJt/b+4VKfyO/+nHwHyAb1XMhxbgngzsvNJUxwP0ibYjpAmu9nWqf+OYf6ZwCb3X7Ils89VeRDQ76c6b/VekNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShFw7sK6iFqIIMiPSnfrnksmNtLHDon6V+HRut7xZiU=;
 b=Y8r7Z9EmOMPdj52xWr+awxAMurhs9LxVqSE8J0eCi4VD2ve8PbH1Br9+5HFbm/FdLrKggouC4j71GL0M+Gcrz8QvIv+bILct59AJF63yFlQbVJLLLx+VnGxISCfZjRLauM3HLOvJFuSOB54XJBDSq8S+mJToXOSvys4gCFtDu0g9EMl8av+ODYyUXkFZ1gh05JNgjVX/B9r8aiwTY+VgGlhBud44lSJLSOy9EszqV6toqCPTVLgCAW4JCc8wgnaMsolglXJ0COzmCqdfpZJAe7CbXMf1QgsFc272LQUakLrh8o0moqeRAyJDk23DrqEN6g37I6oErvtQq1wPRNf+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShFw7sK6iFqIIMiPSnfrnksmNtLHDon6V+HRut7xZiU=;
 b=GmSW692UEZQcpl5TvAGlpoywCrYFLp63e0qNbN7XnSa7jTRFuIfe4yCY5vQPdHQG66t64Z4tz55+uYDdOzapOJf/xUSC3P45Ypwu4HrPw+yt5bZTbXQLNCYpQP1yPUGrj5/r8byemH1X3dki1fLT/ceVPeLYXlqSG7OLJTX+pYw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6371.namprd10.prod.outlook.com (2603:10b6:303:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 12:29:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:29:11 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@linux.com, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V3 3/7] mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
Date: Mon, 27 Oct 2025 21:28:43 +0900
Message-ID: <20251027122847.320924-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027122847.320924-1-harry.yoo@oracle.com>
References: <20251027122847.320924-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0072.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbde1da-548d-451f-b446-08de15546e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bo9zrB9GWPeOmHD+0K45CNVV4DP9ambZSHLyznn+7EbLZ/vyQJ8OASoYIe1r?=
 =?us-ascii?Q?dEsKtCiwoGCaDY3ugGBZ286fYD3/xJdphsnIH+SV42knD+D5GmIB+B7jZxhr?=
 =?us-ascii?Q?bK7eFg1paz5vACAbAuPbJnjTTdcDaoxJStUwFqqL7cGUbyfA/GYwCFbCUlJd?=
 =?us-ascii?Q?cSuJADwQvT+rcTv++wqVaPtdJ3FZGtbPHN6vSZrmkS/w0z5x2xy2BjLViYRd?=
 =?us-ascii?Q?xLzbRq8zpshVPLGZgewcmTru4NWMeoUXVwHPcyU99wfjoVtc2aoQhqZ+xrsk?=
 =?us-ascii?Q?Uyztd5NVpDecKCSoDedd7+knPqwHyl+Va1VcuHmnq7/Pps70GdBAOEa6KKxV?=
 =?us-ascii?Q?swbQGFlz8Wi7R4KBF0rgSTftLtHVPK3DFWyfPF32cS7ykYZOUqKwAmUmLimK?=
 =?us-ascii?Q?4767LfMjRjgcZomU/SedTri6X1Qs9an2BuhYTluD1pDAWDKih+xjshSmqBwk?=
 =?us-ascii?Q?BgRtRKF4q1/0H/IvJKInTIZf2jcF4akQV2Sw02uICYVr2km1wOnw2vkxXN/N?=
 =?us-ascii?Q?aq1L0LwYsYUQLEaZLg6pMhzJbpFFUI1mK5chUg28GBBMLjM9d8x12IviSofI?=
 =?us-ascii?Q?E04qe6dlAlPB094l704XV4iuuKO20oX90V0TfDFQyfvGwszmbXw7dF+mBCM8?=
 =?us-ascii?Q?x/I5tSLdvzPMxeS7JsLifEyLA68DMX4UfyScQA3z0er5Nl3VNW8a0VkoY0b8?=
 =?us-ascii?Q?nzc57/dQbrJJMP8m7IlyR27WFvJ1F9k+oRicHvUr7RHS9D+YJIZOQwu+HOUT?=
 =?us-ascii?Q?A9FdKW6ZiYECtJOo8jFMDwTGRcdKzJ4WAOkLCoRPIehM6R1GEyKMHBPl/tgc?=
 =?us-ascii?Q?8xDXlQXJmF/14DMkf5sbTvBSmynvUXrtw0T7ZYgO8ByVui/m4tvjBLlkxAEk?=
 =?us-ascii?Q?OW9HiUQHTSPRzJCNSzO+4lQF7uwAn9kvvyluWdjVArkF2i3teYdTjLJkvdQl?=
 =?us-ascii?Q?L4+d0gaFCUfdNbZJacba3zCKc+u7hpcYIxsEDgF7ypPd1lIsCxaEfZNaKV1n?=
 =?us-ascii?Q?tCnESR0ERYqNKYH50/d32l90rJrLK/suHBGlHrAwDuetCYrxXScgn8G6V1xC?=
 =?us-ascii?Q?Pxc2CrWdqwgkqavL353z4ftg72L9FLVQdJUS6VC0xuZkVltF+OK5lmxpkdun?=
 =?us-ascii?Q?LMH8yPuxm7RbdlH98NMFvDj5xtyS7oYsLifY4KcASfpJkEFjYYZ4WSgpdrU+?=
 =?us-ascii?Q?3MqLy61CuT46OLHPjjjM3iz3bv8UcHoCSFJlPTiqVNqi7+caKs2Heud1wQgy?=
 =?us-ascii?Q?hzyGGw4YuzepU9j53vfi5NWdD96fIWZ7CDkKaEojkRGslyL8KfAi+34+tOXg?=
 =?us-ascii?Q?JNJr+mGbU/1i8git5FEH/37s2lDrbuFuu+uZHEsBfXaneVLpxCtP0VZvciPU?=
 =?us-ascii?Q?w5bSODglhAj18MRp8wa+A01quV+GwBJ4pkM6+3iwlE3DHvjR5oWQNxkwbpfF?=
 =?us-ascii?Q?jhRQhsM5MKLRVWQajs465TFPYvCT+u9Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u6eHLIhnAd8IkGiEZ3Xjlq7hQLql17rhsof1UePvwEsURbqo5+HWEv68O4bI?=
 =?us-ascii?Q?q0frMTcMVYGb/acnSHuiq67NGujDLsv5L/obhBQyU/FwAVVDtawQhn6N/I+w?=
 =?us-ascii?Q?c4Vxcifv29mxut90NdvXakjClI/KcVGpX/Z32bSB4P6gS05hU/gA+E74aDgq?=
 =?us-ascii?Q?LMOfnPs8K3354YV8JpuLJ/5AR4lvBV9LDHe6vt4mACE1V4P7jVQFHXS+bgcw?=
 =?us-ascii?Q?vYB28F0li+C2DdFbyY7YOFLNWhIUxJzC0WgBogBVqTKbAHqB/iZ4ErFeSPue?=
 =?us-ascii?Q?ix7Id/qK4bw5ogUy2GTUjkEskh7a2XOtb5cPQjk/UjeJaL0pYcSGzlTxzdsI?=
 =?us-ascii?Q?h63muN4EmJvsnFW3376x/b8DUlssErDc/t1OEU71fJy4EEkvO82kdUQPL/bH?=
 =?us-ascii?Q?IffIyuu5T1Olc3bF8Tz1eSAIrMEgLehvvwPXhrMc3njsuwEHLDMqLy9NmDR0?=
 =?us-ascii?Q?37bE/y0/MMRkNHvRuRLvLgQsjel70WNlXoLi+pnWWRLhRMqnLY+bTfg/e7E7?=
 =?us-ascii?Q?MNmdcn1Uft3xBEr55g7qzrM0vzWw5T6JujWeQ/nqPWIX9WVqVQ/TMHcKGd4p?=
 =?us-ascii?Q?sE/M1SvBIxjrzJ8hPGqDr2XnMLiBXg17LL+gvyEqyWMcdqfkrblMvHRpwJVO?=
 =?us-ascii?Q?BRgHnBwo5xbzly/m+Aa4+5brDDxS0FlQeE07cck56EOwGf4SNXBx2W3VW/7O?=
 =?us-ascii?Q?XyQzUeVig/GBdWctObW1VRbhzZdVnJVtaNkqGq8ZBGzp5YoN13R7ZHQYqVSt?=
 =?us-ascii?Q?TKbfirsp2MkxizvRdbK8Lwf5wK4Sn8uoT7Aa5mdxEslla/CynZ7iH1zMOQ/g?=
 =?us-ascii?Q?L2RGhobMZtlI+s3qkyCQWBne3d8EB/bSkJZF1kT3lMeM8p0EFdsvYAG3Z022?=
 =?us-ascii?Q?k7/IRPGwHvEgse9fpv2iyoj+mhFQZcUfb7KGo2o46J2Hx0dYAf28Y5SCg7zl?=
 =?us-ascii?Q?O4FzMxCn3JBzexgSVgN28dLo9YLb96oqFw2o41VY6LOCBKyYdUpQnURleIVx?=
 =?us-ascii?Q?xENkUP6ge3u6BeC8m2qWMKYUvT7zcBKx1xWklixnxccubpK+f39ki/SU3fGc?=
 =?us-ascii?Q?fQ+oLhxsQCAg/yRYryCT7m6KsC2ZFQbHlkqbRFpxU9abswMFl/dZaQWmg1iD?=
 =?us-ascii?Q?ZgYJ1EI0mIncy6D8Hih6JdwtIClrRiQeEcX5GkzlbqTOqggNOJZC8/RLEt0Q?=
 =?us-ascii?Q?dSVgqp1GcC7OWcFRaN3ndHzm2kA5afzelXBjCuJDnxRm6ZUtyDm2VbghmLiy?=
 =?us-ascii?Q?nFZs0Ti2JDhb+rmkhIO5uum8ref5Lg3pJ4rYHXRDwkTK22i1gKboeXQoBSGx?=
 =?us-ascii?Q?uTB5JfqYQLwIPo6XATjjY4icVu7YRWnFjky1g7Mv4MV/DL/xZUnYpTIfa7cX?=
 =?us-ascii?Q?CJVw8wN9sqa8ZVF1mlSjHwmxHdWrmWQ76ohq/ZU8063ajRQNm75Yuk5mxZeW?=
 =?us-ascii?Q?qb89BCcWYCD5pQ0t58V3hRf0OotIKkgRytiVDaPob3XETbjGE3tGJVkXfaUB?=
 =?us-ascii?Q?omSm1L3gjMXZ59neJJZ9F6PtZvvRSbEhKMwk+kCHg9wEN6CgaTnU1cJMGhKi?=
 =?us-ascii?Q?5LDLhZ7nKXst98UQvu8Gn9cVPPNTovI53eep/oQm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mHeZTuTTqDHiHdkwjTcmuiIKx1nYejzjaR0+GHqUKH+9bRrHkDTizlVHHdHQzV3dC8zyuRi1geAhK8h/zBifkbbbAIe+F324pbhCVpdRnSCjZMMrcEwuFceMrArkSP42onnF2i+cxDyk0jp78/00hQQ+iz/TzqG2Ukqiu6ULTCAcl6+CcSmZ5UN4ivnOy7HZ6qyRIuGIBTHNv6qiBJFDZMF1Utgc0i88gmT9deJpeDXhuulJsK1nhy4Y3hzZZBnwd42lpm6JHNYGBDMzphU0hIPHj5+kYZxR47rEw2e1DifdOmjo/+d5A8+sgqHBccnOwD2LN3fLPl9JNDYjDX1vsxlP/bAwtNZzG2zjY6Crxqyv4KIWMAWm7hDijIZWfK66U3Nw4u5C9RfNw68agmUZoDNv4M5YaeuGRRiiMOrvDDZSrcd64R1cvLFiuBf8itgFck2d0PT+NlJZh6lA2Y5Ejo93h3OyWxAJiQSf1gOLgWfD6OLtDlJhYdOq7HaFQYZ7rVQ99e0ZVUZfNvbjJcopNFH5g61wSzk6Bvg1sy8IhGfo1wh1HmMJzlNm/rMFIZQth0v9QKW8M+aAj0pmsnR2quyt5G6Y8zTFR41PiDTMeLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbde1da-548d-451f-b446-08de15546e7e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 12:29:11.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nntm5UAj66WWZWiIOSvlqlQ4fa7LHy3mn/G/VpCFmBP6HBA8h3GoZjtYxpHjZv6mmoLB9UUu69raa16nZUv40w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510270116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfXwHDbay9/5ROo
 /AwpOUGKrYopa8f+Jau3ggkCYqTSQZocsDj+5Lkmj2Fk8RRxWQg2D0ETQw6O22GvNDeMonGUO3E
 ld0VdLTkMHwrydwqFIpf9UewR4RJB2NPMMYocyMps+qhrisnv/OUsf2+5jWU2G2ezmMNlG4Tzvi
 19ylc6vD3xl6fY/9KeJw+zgF5yo5fURzR8FE8zKVuKzpwvc/E/+Fv5GzJFrHiEf1QGqd9V8MkKp
 x8okTWkfpzc24OVAuyKARcz6MzMAQ5b1522nNGyqPXPXXrpVzATP+L9NtGrhJg0/tNf2WQ3JJI/
 Ts+wzVEBt8z6w0tX+f/xkouRW+LWuM3um2axARdCt7oNLqWa1jycCsFGYjScitGvXHyDEq8O9zt
 Gt0Q24oqBu+i/EA/H6zyaRwY+fde5zgbK1wFhJj+PSCwBYTBGvc=
X-Proofpoint-GUID: rbfaOXgWpR_r-S3t5V5t3W2HPoFX5uiz
X-Proofpoint-ORIG-GUID: rbfaOXgWpR_r-S3t5V5t3W2HPoFX5uiz
X-Authority-Analysis: v=2.4 cv=dbiNHHXe c=1 sm=1 tr=0 ts=68ff659a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=hqUfzwhSJLVLa33He1QA:9 cc=ntf awl=host:12091

Currently, the slab allocator assumes that slab->obj_exts is a pointer
to an array of struct slabobj_ext objects. However, to support storage
methods where struct slabobj_ext is embedded within objects, the slab
allocator should not make this assumption. Instead of directly
dereferencing the slabobj_exts array, abstract access to
struct slabobj_ext via helper functions.

Introduce a new API slabobj_ext metadata access:

  slab_obj_ext(slab, obj_exts, index) - returns the pointer to
  struct slabobj_ext element at the given index.

Directly dereferencing the return value of slab_obj_exts() is no longer
allowed. Instead, slab_obj_ext() must always be used to access
individual struct slabobj_ext objects.

Convert all users to use these APIs.
No functional changes intended.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 23 ++++++++++++++++-------
 mm/slab.h       | 43 ++++++++++++++++++++++++++++++++++++------
 mm/slub.c       | 50 ++++++++++++++++++++++++++++---------------------
 3 files changed, 82 insertions(+), 34 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..2a9dc246e802 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2566,7 +2566,8 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 	 * slab->obj_exts.
 	 */
 	if (folio_test_slab(folio)) {
-		struct slabobj_ext *obj_exts;
+		unsigned long obj_exts;
+		struct slabobj_ext *obj_ext;
 		struct slab *slab;
 		unsigned int off;
 
@@ -2576,8 +2577,9 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 			return NULL;
 
 		off = obj_to_index(slab->slab_cache, slab, p);
-		if (obj_exts[off].objcg)
-			return obj_cgroup_memcg(obj_exts[off].objcg);
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		if (obj_ext->objcg)
+			return obj_cgroup_memcg(obj_ext->objcg);
 
 		return NULL;
 	}
@@ -3168,6 +3170,9 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	}
 
 	for (i = 0; i < size; i++) {
+		unsigned long obj_exts;
+		struct slabobj_ext *obj_ext;
+
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
@@ -3190,29 +3195,33 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 					slab_pgdat(slab), cache_vmstat_idx(s)))
 			return false;
 
+		obj_exts = slab_obj_exts(slab);
 		off = obj_to_index(s, slab, p[i]);
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
-		slab_obj_exts(slab)[off].objcg = objcg;
+		obj_ext->objcg = objcg;
 	}
 
 	return true;
 }
 
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts)
+			    void **p, int objects, unsigned long obj_exts)
 {
 	size_t obj_size = obj_full_size(s);
 
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
+		struct slabobj_ext *obj_ext;
 		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
-		objcg = obj_exts[off].objcg;
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		objcg = obj_ext->objcg;
 		if (!objcg)
 			continue;
 
-		obj_exts[off].objcg = NULL;
+		obj_ext->objcg = NULL;
 		refill_obj_stock(objcg, obj_size, true, -obj_size,
 				 slab_pgdat(slab), cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
diff --git a/mm/slab.h b/mm/slab.h
index d63cc9b5e313..df2c987d950d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -528,10 +528,12 @@ static inline bool slab_in_kunit_test(void) { return false; }
  * associated with a slab.
  * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object extension vector associated with the slab,
- * or NULL if no such vector has been associated yet.
+ * Returns the address of the object extension vector associated with the slab,
+ * or zero if no such vector has been associated yet.
+ * Do not dereference the return value directly; use slab_obj_ext() to access
+ * its elements.
  */
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
 {
 	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
@@ -544,7 +546,30 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 #endif
-	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
+
+	return obj_exts & ~OBJEXTS_FLAGS_MASK;
+}
+
+/*
+ * slab_obj_ext - get the pointer to the slab object extension metadata
+ * associated with an object in a slab.
+ * @slab: a pointer to the slab struct
+ * @obj_exts: a pointer to the object extension vector
+ * @index: an index of the object
+ *
+ * Returns a pointer to the object extension associated with the object.
+ */
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned long obj_exts,
+					       unsigned int index)
+{
+	struct slabobj_ext *obj_ext;
+
+	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
+	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
+
+	obj_ext = (struct slabobj_ext *)obj_exts;
+	return &obj_ext[index];
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -552,7 +577,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 #else /* CONFIG_SLAB_OBJ_EXT */
 
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
+{
+	return false;
+}
+
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned int index)
 {
 	return NULL;
 }
@@ -569,7 +600,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts);
+			    void **p, int objects, unsigned long obj_exts);
 #endif
 
 void kvfree_rcu_cb(struct rcu_head *head);
diff --git a/mm/slub.c b/mm/slub.c
index 64705cb3734f..ae73403f8c29 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2031,7 +2031,7 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long slab_exts;
 	struct slab *obj_exts_slab;
 
 	obj_exts_slab = virt_to_slab(obj_exts);
@@ -2039,9 +2039,12 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	if (slab_exts) {
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
+		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
+						       slab_exts, offs);
+
 		/* codetag should be NULL */
-		WARN_ON(slab_exts[offs].ref.ct);
-		set_codetag_empty(&slab_exts[offs].ref);
+		WARN_ON(ext->ref.ct);
+		set_codetag_empty(&ext->ref);
 	}
 }
 
@@ -2159,7 +2162,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 static inline void free_slab_obj_exts(struct slab *slab)
 {
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
 
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts)
@@ -2172,11 +2175,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
 	 * the extension for obj_exts is expected to be NULL.
 	 */
-	mark_objexts_empty(obj_exts);
+	mark_objexts_empty((struct slabobj_ext *)obj_exts);
 	if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
-		kfree_nolock(obj_exts);
+		kfree_nolock((void *)obj_exts);
 	else
-		kfree(obj_exts);
+		kfree((void *)obj_exts);
 	slab->obj_exts = 0;
 }
 
@@ -2201,9 +2204,10 @@ static inline void free_slab_obj_exts(struct slab *slab)
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
 static inline struct slabobj_ext *
-prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
 	struct slab *slab;
+	unsigned long obj_exts;
 
 	if (!p)
 		return NULL;
@@ -2215,30 +2219,32 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 		return NULL;
 
 	slab = virt_to_slab(p);
-	if (!slab_obj_exts(slab) &&
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
 		return NULL;
 	}
 
-	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+	obj_exts = slab_obj_exts(slab);
+	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
 __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	struct slabobj_ext *obj_exts;
+	struct slabobj_ext *obj_ext;
 
-	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
+	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_exts))
-		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+	if (likely(obj_ext))
+		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
 }
 
 static inline void
@@ -2253,8 +2259,8 @@ static noinline void
 __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			       int objects)
 {
-	struct slabobj_ext *obj_exts;
 	int i;
+	unsigned long obj_exts;
 
 	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
 	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
@@ -2267,7 +2273,7 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
-		alloc_tag_sub(&obj_exts[off].ref, s->size);
+		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
 }
 
@@ -2326,7 +2332,7 @@ static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			  int objects)
 {
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
 
 	if (!memcg_kmem_online())
 		return;
@@ -2341,7 +2347,8 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 static __fastpath_inline
 bool memcg_slab_post_charge(void *p, gfp_t flags)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long obj_exts;
+	struct slabobj_ext *obj_ext;
 	struct kmem_cache *s;
 	struct folio *folio;
 	struct slab *slab;
@@ -2381,10 +2388,11 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 		return true;
 
 	/* Ignore already charged objects. */
-	slab_exts = slab_obj_exts(slab);
-	if (slab_exts) {
+	obj_exts = slab_obj_exts(slab);
+	if (obj_exts) {
 		off = obj_to_index(s, slab, p);
-		if (unlikely(slab_exts[off].objcg))
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		if (unlikely(obj_ext->objcg))
 			return true;
 	}
 
-- 
2.43.0


