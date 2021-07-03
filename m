Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905E63BA8C8
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jul 2021 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGCNAw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Jul 2021 09:00:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32808 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhGCNAt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Jul 2021 09:00:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 163CuUrA014392;
        Sat, 3 Jul 2021 12:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=6hTePB5Vu/z0fw2YjaSChwZI2dE9ybqQ6VRv57V49lc=;
 b=eODE3vBJOjc3ZF9LGFkHvynbT7G0qtIkfpGCKInOS+ioKFoUbzY+pgKLh2lI2H6DUC1M
 zW2fVfD0nJaKxd8KKyqd5S6cDImrVjZFUwccEECiQ8fRq5E7/CGrUCDnHGNrRROiO3Ie
 WewTZFpFLBMi7fLFa52tUA292ZtWHxmYN3suhGAGI/3KzNPRqut1rjVJMZaA26BntDCp
 bWLjckjodtA+2tz/nFj9WZ7L42+byUs8KJCV887SKKxKCacN7pe/nf+vS8oju6HUlvuF
 /FL6fGO6Vo3an+l2KXOLEW1y0Slc07ToFK7KpQbofrKJWS3aWcS6rTIShCgnX4m+hRea Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39jfsc8bn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 12:58:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 163CuFJF072752;
        Sat, 3 Jul 2021 12:58:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 39jf7knted-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 03 Jul 2021 12:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3x9NS04P0WtkgsK3K3hzCbB+aCg7/T+vC/38c94PDqh242vHHseHg4aaTgNmu0stt0uBFqldOaoenyveJ7OjzSLKIfHvCnaUvH6Kx1u8GMYK7aNexgb47uzif6XRxnqOxvqxyHHWNIwzXg/8cXnBfJfzKRug66PlSHL5jWkqE69uZimAfSKQL6rzu1lm/wZOvivzjMOnBPFwHg2bKzWS1/3ai5o4eM2muZaETSixMp63C5O7CKR3hEq4eK4Fstn+HyTu9HHxgsH968E5L0Y6sf9If+3T90pjCZqJ5N1k9Vv2AtYUdP9iLr7JJtNrXegHvhD+rmpzecZzJsUWvnVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hTePB5Vu/z0fw2YjaSChwZI2dE9ybqQ6VRv57V49lc=;
 b=Koe9/KdV+OLEbuTaB/Mh9UyjRwtnXcq/RyBIF48hZGSwi04z5iccFLTxtM29TM2qW68dgvweS/AroUWS/z1lGTjFUw4OwuV0M5m/Ggu24C5FW9LLc1xmbBO3S3Xe8b6ayBWWgIlukAopyiDIql4Da+/VeOLseFCEGArYmLuDSc8ej/k1dPGeko+URx5p7YkaCDyt47Ou8ZPpyFxYCl/u/uTHvdmUsiH9bJtBpqKb2GdhYREsp50ZgM1vqjs3JLTwNTMKaiKPge/TS/Xh5EyxDQJjTUG09XVWehLUIsgfQZ8nLNEOBMbGTaTduUlGSCPaAZI+Ka1MK+bxdm43hTxpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hTePB5Vu/z0fw2YjaSChwZI2dE9ybqQ6VRv57V49lc=;
 b=nitY7UjZSYF3dGnIE8I1YY/X+OWkasBoRpH+tEiJbFJ5KlrOfWpT2n36U+jA2dPaEgz9edFvTxgLXDW0s4p5c0Cx+eeWqdlDFX8ZwWlva/nKgdsa4/DTFnDkBqCtR+31piDlPogG4yAFZ85MgoBWR4BpffFfLFP+WY9UukGXLig=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1902.namprd10.prod.outlook.com
 (2603:10b6:300:10d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Sat, 3 Jul
 2021 12:58:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.030; Sat, 3 Jul 2021
 12:58:03 +0000
Date:   Sat, 3 Jul 2021 15:57:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Theodore Ts'o <tytso@mit.edu>,
        Ye Bin <yebin10@huawei.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] ext4: possible use-after-free when remounting r/o a
 mmp-protected file system
Message-ID: <202107030757.qUhYYCXI-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e525c0bf7b18da426bb3d3dd63830a3f85218a9e.1625244710.git.tytso@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Sat, 3 Jul 2021 12:57:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa3dd9fa-82ce-4a40-b9e1-08d93e223180
X-MS-TrafficTypeDiagnostic: MWHPR10MB1902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB19021B5DEA9700E6577546898E1E9@MWHPR10MB1902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWKwEBFa5V04xLKljyUHObqq0m9fqCx51U9eDhm7b6Y+zuNyHS3a2WXr7EK9PB9fyczYJ5MJBQOpXIYIBMvyHepwGu6sglimyFl/rlJ28VvBPehLEILmgpgmpIEbzzbRzuqTiyVlqHQx5hf/ocz1OKC3VjhuElr+qX45CFfC3LN0Bf+4IVLyOFI73qtwjZrED8N0GtBof70QuWN8tOmEmVAaIdm4SJQ5/6ZFt1f0KAp2/YX8qVEar+2A+JwXG7JyzGHrQJCyvgTLLeJBrs2zzIw3wC1Qw+AWlCNWnzYiqIkI/Wr1z6ovpsblXGbzMcm5ALP7QcD3mM8h1JZUfMjzT/UtvQ3g9TF1KG6Yh2/q6hTppvCI422CUBGfAvz2dtukB5ubouc7lH7EnA2iR1Yz9OV+/PCQsIFiMB7AE+4z1eHL1UWnDvRkjcTyZuwYQWoxNs1aOEHS5NYbTAWJVss0X88bbow5FafjexgzT9EdbJX9tiB4qTPRTc4FWNwoC9SnWDGgGa9VS5VxNApbJ0U0pWX/9ZmxPsnhFmDQk50XXBscMB7VmEeUP18yXp9lJolw5/5Kz9iFT6QnTlLu61piPtsMriFld/FDHhZzxAtoSqewYQaaugkLZupZfGTx5jcBebCcs7f+5Oz5x8tDStYVC5WywaTdj3NoshQVwjNdGRsJGD+iDFQ8EAOmsSRXx1raWVGCjZND++9Rt/47IUCGHkG5mcasOHb2NoWBEeY2kDnqucu7gL46pjBFQUbk9I/kpac3I9alfIrfE7wi8yhOR/ypXyf4cpAWmDUrpD/gFRxQwlu8ELJWbQhaidk2DdEr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(4326008)(86362001)(6486002)(26005)(1076003)(110136005)(966005)(478600001)(16526019)(66556008)(5660300002)(8676002)(54906003)(8936002)(44832011)(66946007)(956004)(66476007)(316002)(186003)(38350700002)(38100700002)(6666004)(83380400001)(6496006)(52116002)(9686003)(36756003)(4001150100001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmk0w/EVYhYuDS477j/NZ1iGB1rj6git9ZooDS+/eG4zV0Jt3WoUl7sxs76r?=
 =?us-ascii?Q?861UuaPg2znnRo2KbDx3Au54gMrxc+kLuj5+XsW2kBDR5expvwp0pGxzmxmI?=
 =?us-ascii?Q?57EIJRz1P4V16u8lynVdA6+0n+eF0iHft5hUwt5FkxfxaRuW/766PAJ8Er0K?=
 =?us-ascii?Q?t/QNDPorQNJUuoKUYjdv9fSpA3GFWm4+3nKG/Rs3GsyAj+MSKG6Hact1ZCa/?=
 =?us-ascii?Q?6JC+vQnM6Q7MJiS5B679yZL47GP2hZfPh7VdvM5fE7YJjCr9Ph4GWLyJBgdX?=
 =?us-ascii?Q?9M7L68d6X5AfvXQdaH3WI/ew3XTIoy/pmC83+uyTlY2np09AkSs46jH63rUf?=
 =?us-ascii?Q?JbaOZumrPl13TkHxwdp2zcJQloIWpR3ovuNTONj3Qy5R5WIuTD0F6s74J1u2?=
 =?us-ascii?Q?Hb9kpZV37+F/+qP8pUhacd8Rnuk1oBG2RjmXvjxih6n5Cme+1+KGt9sIZkcs?=
 =?us-ascii?Q?TTHVYgyXVVty78sO9IrzY+v7H4bJEpC9jLbfHxl6PIk1APjY2hJ3zvoMUBCW?=
 =?us-ascii?Q?ydvX6+ggbrLdx7Ar8330SB06CxNOJUJItAJS1lsrE6nts55W6RikfqnlAUDy?=
 =?us-ascii?Q?x+8eA4Bn83kebmmnRHONPXNMF7rOMpSatBTqSspDczmCSQa+VbzGtdDhrhjB?=
 =?us-ascii?Q?w2wHXsBgU6RL6qzwa8W+76w4DAa67Q+6MCox3lkqv2DOvn3NnVORXkjPOCH9?=
 =?us-ascii?Q?XqDZvJlhwjnJC8QNcW7DwmE1Xo/SKPb2QTDGXgwK9jM3umWSUf6x5vrifOtK?=
 =?us-ascii?Q?yL7+ejEKncdAnnuhz4qLgdZ0/yGk77wucYM1TtWvTLP2KrzknFoJr7tNgFxX?=
 =?us-ascii?Q?lxYxBwvHkWCsh2xGvNgKDi3HuOSdlbBOPQ6BfuRwcFZ+/BBddqahOCB/FI1U?=
 =?us-ascii?Q?BrSPG8zGwqFOjJItZCUwVzGdv7va4PlvCOUZ9na1J5ZnKjFhbK6f8KbK1oUs?=
 =?us-ascii?Q?s42d4tL+U91YboasxqTsHmTW+qb+lPa4D5dh2OfBwyB8gWI+x1keM+4+zyuj?=
 =?us-ascii?Q?+UdefstxTcgMFBDa4/5525ypd/+1pXCzIYFo4wI5uJ1ZubyH3QHqXcmEO1v3?=
 =?us-ascii?Q?woY8K8hCqS5puSJSgVhNkLpU7uMLT3CDHaE+YVE1s701+BTqzzmKNEE0Eyu9?=
 =?us-ascii?Q?asJt813FSsrpoOkPB2D/LspHIS6xVdGx4pYi3EhCx7M4yBLcJ1/lsQXT4P+S?=
 =?us-ascii?Q?SxoUGSzI1IpFQmqNVfX70eP4awmVhYthSc1JsFzOgrAKbVaDj3qMB6HsjsRI?=
 =?us-ascii?Q?GLpOXJ5Rj+UeP0Sbb4TcoconihBhV8HQzcLdtRLUyGikRUOjXHM50ckwxLVS?=
 =?us-ascii?Q?3+zcrlhsP6lEgQPLDJ/2twy5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3dd9fa-82ce-4a40-b9e1-08d93e223180
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2021 12:58:03.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUFEAPVCu/bJ9Ht7slIqI19osY6oPRYynz1vCqO9o5rB8epIxC1E64VebqaryNeRpKhSnQqsz5fQWGRULqctXXmYwY7pgEBVFb++0oaGyfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1902
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10033 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107030083
X-Proofpoint-GUID: UR0Vi96zCVkEnFKF2cE9xcaJ0kKS1Vvk
X-Proofpoint-ORIG-GUID: UR0Vi96zCVkEnFKF2cE9xcaJ0kKS1Vvk
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore,

url:    https://github.com/0day-ci/linux/commits/Theodore-Ts-o/ext4-possible-use-after-free-when-remounting-r-o-a-mmp-protected-file-system/20210703-005856
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: i386-randconfig-m021-20210702 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/ext4/mmp.c:252 kmmpd() error: uninitialized symbol 'retval'.

vim +/retval +252 fs/ext4/mmp.c

c5e06d101aaf72 Johann Lombardi   2011-05-24  128  static int kmmpd(void *data)
c5e06d101aaf72 Johann Lombardi   2011-05-24  129  {
618f003199c618 Pavel Skripkin    2021-04-30  130  	struct super_block *sb = (struct super_block *) data;
c5e06d101aaf72 Johann Lombardi   2011-05-24  131  	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
618f003199c618 Pavel Skripkin    2021-04-30  132  	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
c5e06d101aaf72 Johann Lombardi   2011-05-24  133  	struct mmp_struct *mmp;
c5e06d101aaf72 Johann Lombardi   2011-05-24  134  	ext4_fsblk_t mmp_block;
c5e06d101aaf72 Johann Lombardi   2011-05-24  135  	u32 seq = 0;
c5e06d101aaf72 Johann Lombardi   2011-05-24  136  	unsigned long failed_writes = 0;
c5e06d101aaf72 Johann Lombardi   2011-05-24  137  	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
c5e06d101aaf72 Johann Lombardi   2011-05-24  138  	unsigned mmp_check_interval;
c5e06d101aaf72 Johann Lombardi   2011-05-24  139  	unsigned long last_update_time;
c5e06d101aaf72 Johann Lombardi   2011-05-24  140  	unsigned long diff;
c5e06d101aaf72 Johann Lombardi   2011-05-24  141  	int retval;
c5e06d101aaf72 Johann Lombardi   2011-05-24  142  
c5e06d101aaf72 Johann Lombardi   2011-05-24  143  	mmp_block = le64_to_cpu(es->s_mmp_block);
c5e06d101aaf72 Johann Lombardi   2011-05-24  144  	mmp = (struct mmp_struct *)(bh->b_data);
af123b3718592a Arnd Bergmann     2018-07-29  145  	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
c5e06d101aaf72 Johann Lombardi   2011-05-24  146  	/*
c5e06d101aaf72 Johann Lombardi   2011-05-24  147  	 * Start with the higher mmp_check_interval and reduce it if
c5e06d101aaf72 Johann Lombardi   2011-05-24  148  	 * the MMP block is being updated on time.
c5e06d101aaf72 Johann Lombardi   2011-05-24  149  	 */
c5e06d101aaf72 Johann Lombardi   2011-05-24  150  	mmp_check_interval = max(EXT4_MMP_CHECK_MULT * mmp_update_interval,
c5e06d101aaf72 Johann Lombardi   2011-05-24  151  				 EXT4_MMP_MIN_CHECK_INTERVAL);
c5e06d101aaf72 Johann Lombardi   2011-05-24  152  	mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
14c9ca0583eee8 Andreas Dilger    2020-01-26  153  	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
c5e06d101aaf72 Johann Lombardi   2011-05-24  154  	bdevname(bh->b_bdev, mmp->mmp_bdevname);
c5e06d101aaf72 Johann Lombardi   2011-05-24  155  
215fc6af739d2d Nikitas Angelinas 2011-10-18  156  	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
c5e06d101aaf72 Johann Lombardi   2011-05-24  157  	       sizeof(mmp->mmp_nodename));
c5e06d101aaf72 Johann Lombardi   2011-05-24  158  
c5e06d101aaf72 Johann Lombardi   2011-05-24  159  	while (!kthread_should_stop()) {
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  160  		if (!(le32_to_cpu(es->s_feature_incompat) &
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  161  		    EXT4_FEATURE_INCOMPAT_MMP)) {
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  162  			ext4_warning(sb, "kmmpd being stopped since MMP feature"
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  163  				     " has been disabled.");
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  164  			goto wait_to_exit;

Smatch complains about this goto.

37b4aa9eef5b3f Theodore Ts'o     2021-07-02  165  		}
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  166  		if (sb_rdonly(sb)) {
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  167  			schedule_timeout_interruptible(HZ);
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  168  			continue;
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  169  		}
c5e06d101aaf72 Johann Lombardi   2011-05-24  170  		if (++seq > EXT4_MMP_SEQ_MAX)
c5e06d101aaf72 Johann Lombardi   2011-05-24  171  			seq = 1;
c5e06d101aaf72 Johann Lombardi   2011-05-24  172  
c5e06d101aaf72 Johann Lombardi   2011-05-24  173  		mmp->mmp_seq = cpu_to_le32(seq);
af123b3718592a Arnd Bergmann     2018-07-29  174  		mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
c5e06d101aaf72 Johann Lombardi   2011-05-24  175  		last_update_time = jiffies;
c5e06d101aaf72 Johann Lombardi   2011-05-24  176  
5c359a47e7d999 Darrick J. Wong   2012-04-29  177  		retval = write_mmp_block(sb, bh);
c5e06d101aaf72 Johann Lombardi   2011-05-24  178  		/*
c5e06d101aaf72 Johann Lombardi   2011-05-24  179  		 * Don't spew too many error messages. Print one every
c5e06d101aaf72 Johann Lombardi   2011-05-24  180  		 * (s_mmp_update_interval * 60) seconds.
c5e06d101aaf72 Johann Lombardi   2011-05-24  181  		 */
bdfc230f33a9da Nikitas Angelinas 2011-10-18  182  		if (retval) {
878520ac45f9f6 Theodore Ts'o     2019-11-19  183  			if ((failed_writes % 60) == 0) {
54d3adbc29f0c7 Theodore Ts'o     2020-03-28  184  				ext4_error_err(sb, -retval,
54d3adbc29f0c7 Theodore Ts'o     2020-03-28  185  					       "Error writing to MMP block");
878520ac45f9f6 Theodore Ts'o     2019-11-19  186  			}
c5e06d101aaf72 Johann Lombardi   2011-05-24  187  			failed_writes++;
c5e06d101aaf72 Johann Lombardi   2011-05-24  188  		}
c5e06d101aaf72 Johann Lombardi   2011-05-24  189  
c5e06d101aaf72 Johann Lombardi   2011-05-24  190  		diff = jiffies - last_update_time;
c5e06d101aaf72 Johann Lombardi   2011-05-24  191  		if (diff < mmp_update_interval * HZ)
c5e06d101aaf72 Johann Lombardi   2011-05-24  192  			schedule_timeout_interruptible(mmp_update_interval *
c5e06d101aaf72 Johann Lombardi   2011-05-24  193  						       HZ - diff);
c5e06d101aaf72 Johann Lombardi   2011-05-24  194  
c5e06d101aaf72 Johann Lombardi   2011-05-24  195  		/*
c5e06d101aaf72 Johann Lombardi   2011-05-24  196  		 * We need to make sure that more than mmp_check_interval
c5e06d101aaf72 Johann Lombardi   2011-05-24  197  		 * seconds have not passed since writing. If that has happened
c5e06d101aaf72 Johann Lombardi   2011-05-24  198  		 * we need to check if the MMP block is as we left it.
c5e06d101aaf72 Johann Lombardi   2011-05-24  199  		 */
c5e06d101aaf72 Johann Lombardi   2011-05-24  200  		diff = jiffies - last_update_time;
c5e06d101aaf72 Johann Lombardi   2011-05-24  201  		if (diff > mmp_check_interval * HZ) {
c5e06d101aaf72 Johann Lombardi   2011-05-24  202  			struct buffer_head *bh_check = NULL;
c5e06d101aaf72 Johann Lombardi   2011-05-24  203  			struct mmp_struct *mmp_check;
c5e06d101aaf72 Johann Lombardi   2011-05-24  204  
c5e06d101aaf72 Johann Lombardi   2011-05-24  205  			retval = read_mmp_block(sb, &bh_check, mmp_block);
c5e06d101aaf72 Johann Lombardi   2011-05-24  206  			if (retval) {
54d3adbc29f0c7 Theodore Ts'o     2020-03-28  207  				ext4_error_err(sb, -retval,
54d3adbc29f0c7 Theodore Ts'o     2020-03-28  208  					       "error reading MMP data: %d",
c5e06d101aaf72 Johann Lombardi   2011-05-24  209  					       retval);
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  210  				goto wait_to_exit;
c5e06d101aaf72 Johann Lombardi   2011-05-24  211  			}
c5e06d101aaf72 Johann Lombardi   2011-05-24  212  
c5e06d101aaf72 Johann Lombardi   2011-05-24  213  			mmp_check = (struct mmp_struct *)(bh_check->b_data);
c5e06d101aaf72 Johann Lombardi   2011-05-24  214  			if (mmp->mmp_seq != mmp_check->mmp_seq ||
c5e06d101aaf72 Johann Lombardi   2011-05-24  215  			    memcmp(mmp->mmp_nodename, mmp_check->mmp_nodename,
c5e06d101aaf72 Johann Lombardi   2011-05-24  216  				   sizeof(mmp->mmp_nodename))) {
c5e06d101aaf72 Johann Lombardi   2011-05-24  217  				dump_mmp_msg(sb, mmp_check,
c5e06d101aaf72 Johann Lombardi   2011-05-24  218  					     "Error while updating MMP info. "
c5e06d101aaf72 Johann Lombardi   2011-05-24  219  					     "The filesystem seems to have been"
c5e06d101aaf72 Johann Lombardi   2011-05-24  220  					     " multiply mounted.");
54d3adbc29f0c7 Theodore Ts'o     2020-03-28  221  				ext4_error_err(sb, EBUSY, "abort");
0304688676bdfc vikram.jadhav07   2016-03-13  222  				put_bh(bh_check);
0304688676bdfc vikram.jadhav07   2016-03-13  223  				retval = -EBUSY;
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  224  				goto wait_to_exit;
c5e06d101aaf72 Johann Lombardi   2011-05-24  225  			}
c5e06d101aaf72 Johann Lombardi   2011-05-24  226  			put_bh(bh_check);
c5e06d101aaf72 Johann Lombardi   2011-05-24  227  		}
c5e06d101aaf72 Johann Lombardi   2011-05-24  228  
c5e06d101aaf72 Johann Lombardi   2011-05-24  229  		 /*
c5e06d101aaf72 Johann Lombardi   2011-05-24  230  		 * Adjust the mmp_check_interval depending on how much time
c5e06d101aaf72 Johann Lombardi   2011-05-24  231  		 * it took for the MMP block to be written.
c5e06d101aaf72 Johann Lombardi   2011-05-24  232  		 */
c5e06d101aaf72 Johann Lombardi   2011-05-24  233  		mmp_check_interval = max(min(EXT4_MMP_CHECK_MULT * diff / HZ,
c5e06d101aaf72 Johann Lombardi   2011-05-24  234  					     EXT4_MMP_MAX_CHECK_INTERVAL),
c5e06d101aaf72 Johann Lombardi   2011-05-24  235  					 EXT4_MMP_MIN_CHECK_INTERVAL);
c5e06d101aaf72 Johann Lombardi   2011-05-24  236  		mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
c5e06d101aaf72 Johann Lombardi   2011-05-24  237  	}
c5e06d101aaf72 Johann Lombardi   2011-05-24  238  
c5e06d101aaf72 Johann Lombardi   2011-05-24  239  	/*
c5e06d101aaf72 Johann Lombardi   2011-05-24  240  	 * Unmount seems to be clean.
c5e06d101aaf72 Johann Lombardi   2011-05-24  241  	 */
c5e06d101aaf72 Johann Lombardi   2011-05-24  242  	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
af123b3718592a Arnd Bergmann     2018-07-29  243  	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
c5e06d101aaf72 Johann Lombardi   2011-05-24  244  
5c359a47e7d999 Darrick J. Wong   2012-04-29  245  	retval = write_mmp_block(sb, bh);
c5e06d101aaf72 Johann Lombardi   2011-05-24  246  
0304688676bdfc vikram.jadhav07   2016-03-13  247  exit_thread:
c5e06d101aaf72 Johann Lombardi   2011-05-24  248  	return retval;
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  249  wait_to_exit:
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  250  	while (!kthread_should_stop())
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  251  		schedule();
37b4aa9eef5b3f Theodore Ts'o     2021-07-02 @252  	return retval;
37b4aa9eef5b3f Theodore Ts'o     2021-07-02  253  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

