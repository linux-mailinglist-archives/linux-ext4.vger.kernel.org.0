Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7C05B1AC5
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 13:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIHLBF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 07:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIHLBA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 07:01:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69628BB932
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 04:00:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2889mj48005801;
        Thu, 8 Sep 2022 11:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=kS7lZznGlg/dZrAwDsVs1ljMea+XhX4l5LO40Bc0BrE=;
 b=kyW++UpT3YZvs1LKObqiXPysoRSCeHkehortIC+mDrM8/vcYrlXRTn/s549s+HwXZMKM
 ZwABz2NOZojljKqJ99id/W9IjReXjnRReDIeI9+koIRokyEV7IxrYZ2ckCOpCSqIA7H4
 nEZrY6+ZZdqUjHu6o4ZN9R1VZ70cYo9pRENrHMDrFn0+GFM/QULUsNL5hZoaIFkkbYzz
 EKyMvCOUVV6/FvQumuzjbePI1zrfuIN0N1XvZS/YCgkvwN44egD3AK6F5d8h7vE7j5Nb
 GYWEEVFeEdlLYRixt3ZWNnT8W3mVa8SrrA3cEpHMaR0PStzrvz9rc1oeFmdSsbDZlg2z tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbcb9pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 11:00:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288Awdvt009055;
        Thu, 8 Sep 2022 11:00:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc58cx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 11:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3KF4atL4UI+ha53eIBJNoA6htlKj7Z0Mbl9Cd9YRiw7CcBoT8jM6rEvPIud5ojznnReA+Hw6clW06kaDkzt3HDFUrHXBBtIBXwmVLQPVeQOE1yBB4ATQ722LTVUzyqKlWO40l7v/NGCDs1U9nxMIHldqlzW4yF76JMKai1LXVHMb4PlUgI1GdAqxHAU2Z+SOo1OmJz6FAn2IpN5PT7sdcR4a/0bBhGZ4kViPL+OPvVqmD0bP4URdliGj7hRA7LhdnwQQ7OmeYxJsCEkXFiwXPsAN7A6hp6dsxBwRu8PhUTFjy5LNsZNuhIbXokU24TCF0mAQIQ3KGnVO/APhANl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS7lZznGlg/dZrAwDsVs1ljMea+XhX4l5LO40Bc0BrE=;
 b=PaHQz1hsLa0u9Y0monE/c0PYhX6lxdEbZ5BDemPmwyiNa6hGz6xkmmblv931gesDWK86W++mzp+vjzOVM9e/wp7K7SyUWumfe+8T+S84S5TMNQvnZqb/Rs7Ct+iga7pP7LGn+uOPTXShwFYnDyhAmDwiIr82qXrHJDg7yacehBQwxwC7ulI5xWXiWo3XaGVGBu1Lq36N00+4lZnHwNUpvzIaqE0f4IqRD7xGyVXNKO5UivJHggNwEGzcPGTQB8DrGSUDr+cZe0ggXPPDTkKn7m5g6UOUiPIk/Eur0hHdPyU1AoiAivOoZoL/8vy3WWGTsY2V/PlykEHttOD/G5jTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS7lZznGlg/dZrAwDsVs1ljMea+XhX4l5LO40Bc0BrE=;
 b=UeAMc8zV0QDj9z86OVkfr2PIkDiTvOWVG64nUFDip8ffjE88FGAeR+AzbL0G4aUFzSpwnQLVIZ6pSbsy8GL+HgPl8lV505LPMsM//zaNhgIiOnN1591a8SNvv8iY6l5V9k8y9A9gbtzBoXbYHR9oN4kSsmUg5O1yKVt5IFjoKrA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4294.namprd10.prod.outlook.com
 (2603:10b6:610:a7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 11:00:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5588.018; Thu, 8 Sep 2022
 11:00:28 +0000
Date:   Thu, 8 Sep 2022 14:00:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jan Kara <jack@suse.cz>,
        Ted Tso <tytso@mit.edu>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5/5] ext4: Use buckets for cr 1 block scan instead of
 rbtree
Message-ID: <202209071206.u1iHKVzB-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906152920.25584-5-jack@suse.cz>
X-ClientProxiedBy: MR1P264CA0147.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c1f714-ee25-4b8a-b1db-08da9189549f
X-MS-TrafficTypeDiagnostic: CH2PR10MB4294:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWo4spJU0uf7WtnPbTMAmXGKHHPytjlsPFaRrFAkzErhggohPVQKftALzsx9ecyrdcz3IeGQpDZryrk6SxWO7faMSG/1pqoIRIj143I64UflLRH9DLiQ36vihTa5H7XBMCvh02OFMPXi0iVBDCS569CULOLxQf9LvO+tMV3l8awAVMpegZ3AES94S5MBHULu6HjPRof1+F8mF8C46hyVYZQD2zjSbNjIyZqoDjrqoTaXz5cf7psPMmrpPojmbGYzb03xYWGQNu544RBl6l8by/11GboxujjicF0q78XRPnkCXeljAStmPy8iI9w6WQ2Nb63mwlC0nhJSZlWRj139HLruSbG0xqYfqhmRoJhFnbZCgVkUlMfPi/ZVY+cffq5xXbpuJdkPiEoDsy1ymGAdogwkhbjCRY49zT6UL8HLaTLRg9mGFczn7zF1z9j2hM+kJxVOb2niCjtFeWz8qm9hs/+IS7WkzP8LZTzojpF1ku8KrkIrn19JSGN7d0hns+zfmzNlDhL648rDUPilx4k9r/JIDvpN817HXxiZ9RLfQMUrWJ21mu+F9tskp3jXqRrX4hmVK699qQoNdwBtx/rGSAHMvD2+xBZX4927tv6DkaHaPvjtkoFz3JmrS5F/pfLmC67tykH3rQIh05jKOz8LhxQ5o84y/uI0U4kefBrVtMXT+lPycsJt6UQUGj24ShtDiM4K0KVQzXCRPtUmDmeJlBLjLtjFmA3Mz+eIIbLBKrS2GK904uKm1b4V2pU0fJQ8a7cSvMp5UofnrIWgVNkLww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(346002)(376002)(366004)(38100700002)(66556008)(8676002)(4326008)(66946007)(110136005)(66476007)(54906003)(316002)(44832011)(5660300002)(7416002)(2906002)(8936002)(1076003)(41300700001)(9686003)(6512007)(83380400001)(966005)(6486002)(186003)(6506007)(478600001)(26005)(6666004)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LsMtJne8nX3+pqShR6lf9boVF94HgDPp8qnP56XOATY64EwixFpqrmDiPRz?=
 =?us-ascii?Q?5HXonazz9KQYpXOqDkfJO0ZslUrtkwgqbUHn5/NNxvkpmrOmmB7KN9aFPJ8G?=
 =?us-ascii?Q?/XCt7j773CbjU9tJZyTVi853/PGLolPukK47mpKkTCUVMXD1XKwHZ5+RylSA?=
 =?us-ascii?Q?oI5rSghR5+etoOyUWai2NtOpPzks3zZLMmlz+b3vM37YvFHSsuvgs3j8kJ20?=
 =?us-ascii?Q?k8uSZT8TBFtJ702Zcryt/vsotV5tmaf2LWoeo+LevbYsUYhd8LodPcsXVYlR?=
 =?us-ascii?Q?Tmo+gQq2uvoySnLd0R1qPdVwLfGdSQV3vhJOEpqfUVk8gvRX0oIw5SEbX1uH?=
 =?us-ascii?Q?1sVHqq/7V7ke26tRqyT3hbp8U4XB1e3EH+g4WQhexSGujFsfqybpOePBiMim?=
 =?us-ascii?Q?ZcF1Dg3NVUzJVmyKcSrQdNE1YLT4GJB1mn+/8VHzBd/UBppjM+Upo22Xx86d?=
 =?us-ascii?Q?QmCq/swi29Kp7d5Sb9qIX0yx64g+QobB6L2XNdjEEn9sonGa5gGEP9V9sRgY?=
 =?us-ascii?Q?2LNFC9DNNvWDYHUMG24eBmorGfok4gRZ/t0Nk3vOwxRKRECFcAtIumx0zgoT?=
 =?us-ascii?Q?1UfLjk41ldEiIKJ9WWnBfIUbUdYYN0+0w/q9ZQT4cga9tc5oyw0UuSSglWxA?=
 =?us-ascii?Q?g1Cj7j+mfQI3U9PEy4UYmDGbgfgjHnaolJANkbDFpFLwsNiS0BD5BBBiruEK?=
 =?us-ascii?Q?kaSs/GkSTYiZLUWPKBsF6pi3JjT6plw8nngvs2xkDPfTkdYjgH8PVul5EHsY?=
 =?us-ascii?Q?GzHeREOk6WkdMLWk2gapw06ceoxbfVkYoE7wFaCb3OD16KSqceUTg2Kb2/Pq?=
 =?us-ascii?Q?ByGzgxfL97+peZNKhJPy+yBpdmxPwOzSATfvOkhI7MvCjNTQGpI7H73QPdGe?=
 =?us-ascii?Q?vJLRSy4cp9HLQomJT72oPS3ftpvhEQ/cLeYOgF5hMcMSMOmZ57LTEy+xX6yt?=
 =?us-ascii?Q?YRaTdxhuIixmqAMnUCMmOdXzDsPx62N9ddpfoheS/OLutz+r+mz0rrbgCh65?=
 =?us-ascii?Q?aUoYPwiM5G96SKZbF2o+UyMNkzxQQkwoHEpLANHDNumqAYoNtyFXSlyiZ4vc?=
 =?us-ascii?Q?1AB/9fpVGJ2LflR7X1pNjkZlMNdevGhjhig2diiFAy1m3icKCt02A7hKHhUx?=
 =?us-ascii?Q?0ZUaxUddiS+f+fyskppMXfOO01qjsxrG7RD6ZH7H3zOjhyxqlustgwc/IwQm?=
 =?us-ascii?Q?hEkcQPvkWFwRqsnW3cx/N6xaVJEyJGpIvtZi69eEChseLRFpi5P2r4kgWUcT?=
 =?us-ascii?Q?LZH45pnurp8ZyCk9IHyDKvGP1TcfeYZWz4QFw533kkqvOf0wW+mx39SDDLzE?=
 =?us-ascii?Q?9rVwaSkOHhfo8OoR+jEdgdus4nDcMZTsiYQFvqbBVcNeg9jtLVp1B3VfLYhq?=
 =?us-ascii?Q?9y0yOwwkvZZdVixrFvHMoATgXd3qBd4ZTgUkn9LaVDa4/TN2qS1O+ZFQhSXA?=
 =?us-ascii?Q?rT6q2LE+Jlis3wVRmf9bOi2t96d2NUetIXLed1kYokU8rwAGMxXGR1jIOZsK?=
 =?us-ascii?Q?Fn2K8Esfu5LSqwBoaJd41peg3dHmCIhRbmY/WFrA0INYSyM0z2dO0mdQ9eoP?=
 =?us-ascii?Q?2YuKO1z5igUZWh/0tsLkZV8TX1H2amZP9sLexvb2P+JACXBRXDcOAqMK7p0u?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c1f714-ee25-4b8a-b1db-08da9189549f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 11:00:28.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/bVX1Z7+6BoYqEDqRp8bQGzkIgGLb0jjRBxiMNIZBNbpklei2kY5HLKNRR5fq3W/3enij0thR20Jq1WSw4ocZ0wjyZ7IUMg+k8CyeP7Akg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080040
X-Proofpoint-ORIG-GUID: JfFmq1ivyRq2DVmbrPCIXahFjaWrchxa
X-Proofpoint-GUID: JfFmq1ivyRq2DVmbrPCIXahFjaWrchxa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/ext4-Fix-performance-regression-with-mballoc/20220907-000945
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 53e99dcff61e1523ec1c3628b2d564ba15d32eb7
config: m68k-randconfig-m041-20220906 (https://download.01.org/0day-ci/archive/20220907/202209071206.u1iHKVzB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/ext4/mballoc.c:945 ext4_mb_choose_next_group_cr1() error: uninitialized symbol 'grp'.

vim +/grp +945 fs/ext4/mballoc.c

196e402adf2e4c Harshad Shirwadkar 2021-04-01  909  static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
196e402adf2e4c Harshad Shirwadkar 2021-04-01  910  		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
196e402adf2e4c Harshad Shirwadkar 2021-04-01  911  {
196e402adf2e4c Harshad Shirwadkar 2021-04-01  912  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
31b571b608cf66 Jan Kara           2022-09-06  913  	struct ext4_group_info *grp, *iter;
31b571b608cf66 Jan Kara           2022-09-06  914  	int i;
196e402adf2e4c Harshad Shirwadkar 2021-04-01  915  
196e402adf2e4c Harshad Shirwadkar 2021-04-01  916  	if (unlikely(ac->ac_flags & EXT4_MB_CR1_OPTIMIZED)) {
196e402adf2e4c Harshad Shirwadkar 2021-04-01  917  		if (sbi->s_mb_stats)
196e402adf2e4c Harshad Shirwadkar 2021-04-01  918  			atomic_inc(&sbi->s_bal_cr1_bad_suggestions);
31b571b608cf66 Jan Kara           2022-09-06  919  	}
31b571b608cf66 Jan Kara           2022-09-06  920  
31b571b608cf66 Jan Kara           2022-09-06  921  	for (i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
31b571b608cf66 Jan Kara           2022-09-06  922  	     i < MB_NUM_ORDERS(ac->ac_sb); i++) {
31b571b608cf66 Jan Kara           2022-09-06  923  		if (list_empty(&sbi->s_mb_avg_fragment_size[i]))
31b571b608cf66 Jan Kara           2022-09-06  924  			continue;
31b571b608cf66 Jan Kara           2022-09-06  925  		read_lock(&sbi->s_mb_avg_fragment_size_locks[i]);
31b571b608cf66 Jan Kara           2022-09-06  926  		if (list_empty(&sbi->s_mb_avg_fragment_size[i])) {
31b571b608cf66 Jan Kara           2022-09-06  927  			read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
31b571b608cf66 Jan Kara           2022-09-06  928  			continue;

Smatch worries that we can hit these two continues on every iteration.
Why not just initialize "grp = NULL;" at the start of the function?

31b571b608cf66 Jan Kara           2022-09-06  929  		}
31b571b608cf66 Jan Kara           2022-09-06  930  		grp = NULL;
31b571b608cf66 Jan Kara           2022-09-06  931  		list_for_each_entry(iter, &sbi->s_mb_avg_fragment_size[i],
31b571b608cf66 Jan Kara           2022-09-06  932  				    bb_avg_fragment_size_node) {
196e402adf2e4c Harshad Shirwadkar 2021-04-01  933  			if (sbi->s_mb_stats)
196e402adf2e4c Harshad Shirwadkar 2021-04-01  934  				atomic64_inc(&sbi->s_bal_cX_groups_considered[1]);
31b571b608cf66 Jan Kara           2022-09-06  935  			if (likely(ext4_mb_good_group(ac, iter->bb_group, 1))) {
31b571b608cf66 Jan Kara           2022-09-06  936  				grp = iter;
196e402adf2e4c Harshad Shirwadkar 2021-04-01  937  				break;
196e402adf2e4c Harshad Shirwadkar 2021-04-01  938  			}
196e402adf2e4c Harshad Shirwadkar 2021-04-01  939  		}
31b571b608cf66 Jan Kara           2022-09-06  940  		read_unlock(&sbi->s_mb_avg_fragment_size_locks[i]);
31b571b608cf66 Jan Kara           2022-09-06  941  		if (grp)
31b571b608cf66 Jan Kara           2022-09-06  942  			break;
196e402adf2e4c Harshad Shirwadkar 2021-04-01  943  	}
196e402adf2e4c Harshad Shirwadkar 2021-04-01  944  
31b571b608cf66 Jan Kara           2022-09-06 @945  	if (grp) {
196e402adf2e4c Harshad Shirwadkar 2021-04-01  946  		*group = grp->bb_group;
196e402adf2e4c Harshad Shirwadkar 2021-04-01  947  		ac->ac_flags |= EXT4_MB_CR1_OPTIMIZED;
196e402adf2e4c Harshad Shirwadkar 2021-04-01  948  	} else {
196e402adf2e4c Harshad Shirwadkar 2021-04-01  949  		*new_cr = 2;
196e402adf2e4c Harshad Shirwadkar 2021-04-01  950  	}
196e402adf2e4c Harshad Shirwadkar 2021-04-01  951  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

