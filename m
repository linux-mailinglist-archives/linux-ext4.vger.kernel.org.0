Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933BD489521
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiAJJYO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jan 2022 04:24:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53150 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242821AbiAJJYM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Jan 2022 04:24:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A92mUM030604;
        Mon, 10 Jan 2022 09:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=Aheh/BQAlk7jIgRzFR2M28oJ7XGo2KuOfDJ29lXfx0M=;
 b=InAK5f8oKkwMxZE6qwr3QyoeuEgc1gJ5z7lzadpX/D4PVaZNB7OCZ+laO8iNcLt8lY6Y
 bVaI1HTIf2CM2PFPdv95h3LxRb1E4zZpg17ykzn1no2Ru803g23dKY2XZUm0Z6ychWlh
 0De4dGto5AWNqe9UFeuSO9UMxaPlYCPjDmamWNbTMOkM/4Ude0UgCpQ6eSMAKknqdTP3
 ewymTEfJoLJ6ZudgQwsBPQSsboSjTkldLN89uK6y33yNYdHKkCTF78GbodIYjkocgTje
 +GXCE3zqWuuRn2I8ZV0UNhT/caU3WBcnOnkPTxggJ79EQ1kp2io1waCNOL9+dbeT0TBg YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3df27tajn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 09:23:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20A9C49R032723;
        Mon, 10 Jan 2022 09:23:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3deyqv1rj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 09:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLbYe07wfWI0GoO8+dpAXhwIX5zQXvFVEZOax8HGz5EAS4HKohYd9R0r85C7QRhD2EJ/NE+piSPnnmDBxM03FDQ0L+QYGIP9kdB7Gt8yRNvl7NCG5gil4OfgnpokUNBmhf5UGTmtuDd+xIWzin0bmTwmPT3cZkCVjROQA8LrGinQcUq+Qgy+BP2c0R+VTJKcGS1tcKvSck0HkWTgId25yBaz6eZ6l2QJCk1q1CBSWtyBSXXhih3f3pO+M7VvwQCoClEBJJaNgUzQ6zPnlKOdRR+TBPU+oqzaUqH4DXl4eMB1Adp/1rCfoa8xQpT6fTDgA/zOULJOKR3cf7Vai3b/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aheh/BQAlk7jIgRzFR2M28oJ7XGo2KuOfDJ29lXfx0M=;
 b=RwRKrbqNBUcUMhKGeOYftmXwwUlyEQwnOkC78xQKi3mu/dahl3xDZAJHQPGgdD9jLXmVQXXbDzLdUu5xysapW+hqV+oisOD18C6vlTLuE4RPZ9w4STnk+J1mud0V+x+kS+UdadrpHvxbCadcFlAAxNyRhNcz4HwQ9DLhuH0yOmeh6JBGcnV/kKlp49+RqHbATgRZv+EQRBxj5WzwZhH6DDza3kuZzyAkjm2I4LkUAcD1yepWC/oIdRSSelAAej8XyPq+Bern7vwdAKAzXI2zrY1TQ0NMQFLvuPP2xWhZitzLMhdrVLf3WQd4dv+IjYQ+DgAqDe9auY+K5UdWL4ow8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aheh/BQAlk7jIgRzFR2M28oJ7XGo2KuOfDJ29lXfx0M=;
 b=GgK5gEapNrOD7MsHG4ixmSfQgrTDkUX/2JlpPKZyqEVpqF5FMmu4Iv/2zfOasItTguRk0H0YR6o3RucdsGPc0YH8f462CtnIeSLbQw96gIhS7gvr0lBpPYjK6hQfPdYoOqqtc0U0Ay5DC0khB8epvPjUYQdknhZohVILZV5SnY8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5850.namprd10.prod.outlook.com
 (2603:10b6:303:19c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:23:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 09:23:33 +0000
Date:   Mon, 10 Jan 2022 12:23:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Xin Yin <yinxin.x@bytedance.com>,
        harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>
Subject: Re: [PATCH 1/2] ext4: fast commit may not fallback for ineligible
 commit
Message-ID: <202201091544.W5HHEXAp-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107121215.1912-2-yinxin.x@bytedance.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af62466-4468-4500-bd12-08d9d41adf6d
X-MS-TrafficTypeDiagnostic: MW5PR10MB5850:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5850EECD737631D3040301F88E509@MW5PR10MB5850.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klN3XjpAfImIZ8MLmSNgWdaTNmuut7LuykmPgdueZ58GVUFf7ErxkG5nDxy7llqA8gVl7lTs2sXTBhh+jddG9dRUi2LtUK9JPLKT/XuS5SJqcrkPUKa/bFfgOz2Eo/TqigJFKOuM2eW0nKx0n5JaV8A+3fo8rC57Mv+e6z7NgtoY5yA/D51dgNPBL6tDaSGDy9q+i4qnUdQbuA1uoZ5ry96bpnX37xpin4ZY/ieWt+wWyoo9EovXEx0jEadiTDmN+mdIa2F6rCLEuUEKhSc10ofC7/RuRKN2pmYnhVObO0hau9qYmbQJ0MX23IdFNya3zGIVKXdHW2+oGW9Lcaxkwj5oYR7+3nrC0gEQpOD83J9Ce2iiTHE0BVVErKyKro68+nlYihXmZHyX/uavoxcGBJDpAXIa+hhBl8pBP/IZW2HnboQsIaj/9fzgHgY6sXgOTSXeLl0knDUa3nRXL0piduxN6aEIIXKQm4CI+qQvk4ymBooO3tjI1ElEEwlfhkpcn08U9GdQaBV0PD4PL1z04/+ea7AD0kLgJDO+b45cZtVtPkpWGOoYj+XF4P0Mmo6YNO9oajF8DWCDQ3ZrlqYFegKWRtJHIJuobOp8RUraORjROaYP/7TRKKpL9ylAhedtMe8lGwnB2mqWQsNQu1yxr0iJoVqKhGyRgeZ1DGTxFKNQxret4ycYUTFOjoBhpEsHPAvP9uEorG+t3JeXCzqRszPI+YWLJyH0qxWjsthML8ZH0GgkCQaSNqMvdhgw87H4E7Ze+9xXTunQNmsivwLIK5R0Aqoo2h95aCwEgq1A54SBR53508HabqEXWOUWH8ZVq3wKD0uEUrvayD3yL+DRbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(38100700002)(52116002)(186003)(6506007)(66556008)(66476007)(8676002)(4326008)(5660300002)(316002)(30864003)(8936002)(38350700002)(966005)(44832011)(6486002)(26005)(508600001)(1076003)(66946007)(4001150100001)(2906002)(86362001)(6666004)(9686003)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zz4eZ9FpxClD4EIRWGU8PAjWlmhMgDhxhboa/5o2dw7ffivltl/bZtN0Z7tj?=
 =?us-ascii?Q?GlsKSzTVJU0VJ0ppMRbS7DTzbjBMu67eFtA+63sKhNRz+OEET8r8Sg1TrYa6?=
 =?us-ascii?Q?Rvhiq35wXRWbwcPb6Na+Ab9MUJh9GaHz6VA6W9OdX2RSnqamy7zO+xsanxcv?=
 =?us-ascii?Q?LghXCILqbKtVI3ie3oM7/nrhI2qtB5c+Ny3GUqzLD2835WdYLpxcBBrWTemA?=
 =?us-ascii?Q?r9oRER5EXdp4kYaI6zMF04Om55FsEY5y06MQLcuW1bk+Bi6FbGFZjX7d9bGZ?=
 =?us-ascii?Q?ws0hdCQ93hp0Grx60PjGr2fB1EeYTVtXJZ2LEGMOmgrqtU0Em6/Fb30+PGzA?=
 =?us-ascii?Q?AmDPSY7db5hSJUcKXVHi+qpUh8+GZNfBUg7aUrNsZDqIpfbZaQ+pisPhOKot?=
 =?us-ascii?Q?misrkXPBz4KRDCdQnazVSdL/Jnwgyuy670OZbevi/pA6V7pqVkAjHFai+o72?=
 =?us-ascii?Q?IC3VabADWmK3RjBTGrk1UGT5JkXy2FqSkHThsaEMK3Y94M/LS/jX5nNzshrG?=
 =?us-ascii?Q?LTxIo3R+2J7Nml998a5eT1gnqnXwaenzVY/yDHTLIsLmqlep/yAonGDuF3sU?=
 =?us-ascii?Q?5khxFHBf5kfQ33cQTRkkORvQBRNWsNe31HwYFowz5f0m5/npeX3fNlDPKX+K?=
 =?us-ascii?Q?xxlrCnYHocvexjwHTRw7a5BWa++Y8MrKvsVrxpvrjmSHEMQnT36gvJxrVobC?=
 =?us-ascii?Q?rCHQVh8FjJOUgh34j81b+JBKGhbhG5gdPJh5L5G8eEhG8KJSxIfdWw1BLzeF?=
 =?us-ascii?Q?HGLyMAuc3X7PyCQXmCbxvvSgC9OY5A4XhL8RDXm61LgjNgAAwXyrVrvizlvO?=
 =?us-ascii?Q?4RXmPlmN/xp5pgXuK0IsUUKibcWIsCbq3HReLPD6LUaQ2X0sYPJhHy0EDHBb?=
 =?us-ascii?Q?x4MJFQYdquJNsZpj7N9FmEQTYxJPwWlxrjS2BiAnGKE0VFqS0W9Q4XgWHjb/?=
 =?us-ascii?Q?N0dU+pMwCGsQbSi5JW50KXiUPrEYP/K6CDyO5F+F1jDE0AnQ246rkX1dVCd8?=
 =?us-ascii?Q?O56OCQs6oL3gSa/Fj+X4QAgaiQIq29jrVb52avuVJ//vXedi/F82fbspsKgm?=
 =?us-ascii?Q?ayrX3pJkWFtjRaRfgUTUVLaJzr/S4+uIhRAURL3xEACNrU7t8gMp2TBzSckQ?=
 =?us-ascii?Q?40chBjZssV23vUsfxydxp8wUGFVY48rnp3dLQ+Hm2uThWS8G2qkZQj18PyDM?=
 =?us-ascii?Q?daKTpMDgV/U/UWYIw4gPxgk2mYKVHhD/iqqS2jpt4JXhOZzc6yWbuhq9lLMi?=
 =?us-ascii?Q?iwhqxx/qz2N1u0JyWcylW4HI/h0V07aFzZoXouoJwdxVOyWtApLDI1uyFmd+?=
 =?us-ascii?Q?5GNJ27LyBzyz2yq5ivt/3XY9XJ2foBXUQBqlPOREA9HeknK9KPdXYFD0EL/r?=
 =?us-ascii?Q?MGPjIPJ9Rl7rU48LlA+Fwxvu2lqka66U/D/zLg/rgOLAOStz0K4A0JGCFS7P?=
 =?us-ascii?Q?0AYOepbO8JTtdvEhuaVcG3wGLRAqnU96sKEdFK0nxYL9kxf9H5W6Sn8SX2J2?=
 =?us-ascii?Q?6HxsCn+JXOU4mNBrRrZtsQScxoDsCEabndAhzBK1x6lFnirQcdXXF8/kXdFp?=
 =?us-ascii?Q?Jd0ng76m8/jPSId9pIah1KUVHyzlskQCxvv8oXOQ313I/qmPNxqQGOEFKSMZ?=
 =?us-ascii?Q?K8La3WbYaCqCRG4Nor9EXnsu6xytSbZ13vkHieL6VctwGECxsGL48H4hrBkG?=
 =?us-ascii?Q?BQiQDXiEdy2W9wma7dvhSKMxR7o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af62466-4468-4500-bd12-08d9d41adf6d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:23:33.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoa6Ii5O+7ZwR3ZnvAF0SIEqFw5gQPAhrPzewMu4TSo8rFcjtXMFyupfrCbUM5pc1N846IOuZ2aF5dKCicPAPs2R4jVjKIehS/3DWU/DAaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10222 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100065
X-Proofpoint-GUID: QCw2IM3wo9kaU5Lfraz-E1Uco6O1l7Oc
X-Proofpoint-ORIG-GUID: QCw2IM3wo9kaU5Lfraz-E1Uco6O1l7Oc
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Xin,

url:    https://github.com/0day-ci/linux/commits/Xin-Yin/ext4-fix-issues-when-fast-commit-work-with-jbd/20220107-201314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: x86_64-randconfig-m001-20220107 (https://download.01.org/0day-ci/archive/20220109/202201091544.W5HHEXAp-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/ext4/inode.c:340 ext4_evict_inode() error: uninitialized symbol 'handle'.

vim +/handle +340 fs/ext4/inode.c

0930fcc1ee2f0a Al Viro            2010-06-07  167  void ext4_evict_inode(struct inode *inode)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  168  {
ac27a0ec112a08 Dave Kleikamp      2006-10-11  169  	handle_t *handle;
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  170  	int err;
65db869c754e7c Jan Kara           2019-11-05  171  	/*
65db869c754e7c Jan Kara           2019-11-05  172  	 * Credits for final inode cleanup and freeing:
65db869c754e7c Jan Kara           2019-11-05  173  	 * sb + inode (ext4_orphan_del()), block bitmap, group descriptor
65db869c754e7c Jan Kara           2019-11-05  174  	 * (xattr block freeing), bitmap, group descriptor (inode freeing)
65db869c754e7c Jan Kara           2019-11-05  175  	 */
65db869c754e7c Jan Kara           2019-11-05  176  	int extra_credits = 6;
0421a189bc8cde Tahsin Erdogan     2017-06-22  177  	struct ext4_xattr_inode_array *ea_inode_array = NULL;
46e294efc355c4 Jan Kara           2020-11-27  178  	bool freeze_protected = false;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  179  
7ff9c073dd4d72 Theodore Ts'o      2010-11-08  180  	trace_ext4_evict_inode(inode);
2581fdc810889f Jiaying Zhang      2011-08-13  181  
0930fcc1ee2f0a Al Viro            2010-06-07  182  	if (inode->i_nlink) {
2d859db3e4a82a Jan Kara           2011-07-26  183  		/*
2d859db3e4a82a Jan Kara           2011-07-26  184  		 * When journalling data dirty buffers are tracked only in the
2d859db3e4a82a Jan Kara           2011-07-26  185  		 * journal. So although mm thinks everything is clean and
2d859db3e4a82a Jan Kara           2011-07-26  186  		 * ready for reaping the inode might still have some pages to
2d859db3e4a82a Jan Kara           2011-07-26  187  		 * write in the running transaction or waiting to be
2d859db3e4a82a Jan Kara           2011-07-26  188  		 * checkpointed. Thus calling jbd2_journal_invalidatepage()
2d859db3e4a82a Jan Kara           2011-07-26  189  		 * (via truncate_inode_pages()) to discard these buffers can
2d859db3e4a82a Jan Kara           2011-07-26  190  		 * cause data loss. Also even if we did not discard these
2d859db3e4a82a Jan Kara           2011-07-26  191  		 * buffers, we would have no way to find them after the inode
2d859db3e4a82a Jan Kara           2011-07-26  192  		 * is reaped and thus user could see stale data if he tries to
2d859db3e4a82a Jan Kara           2011-07-26  193  		 * read them before the transaction is checkpointed. So be
2d859db3e4a82a Jan Kara           2011-07-26  194  		 * careful and force everything to disk here... We use
2d859db3e4a82a Jan Kara           2011-07-26  195  		 * ei->i_datasync_tid to store the newest transaction
2d859db3e4a82a Jan Kara           2011-07-26  196  		 * containing inode's data.
2d859db3e4a82a Jan Kara           2011-07-26  197  		 *
2d859db3e4a82a Jan Kara           2011-07-26  198  		 * Note that directories do not have this problem because they
2d859db3e4a82a Jan Kara           2011-07-26  199  		 * don't use page cache.
2d859db3e4a82a Jan Kara           2011-07-26  200  		 */
6a7fd522a7c94c Vegard Nossum      2016-07-04  201  		if (inode->i_ino != EXT4_JOURNAL_INO &&
6a7fd522a7c94c Vegard Nossum      2016-07-04  202  		    ext4_should_journal_data(inode) &&
3abb1a0fc2871f Jan Kara           2017-06-22  203  		    (S_ISLNK(inode->i_mode) || S_ISREG(inode->i_mode)) &&
3abb1a0fc2871f Jan Kara           2017-06-22  204  		    inode->i_data.nrpages) {
2d859db3e4a82a Jan Kara           2011-07-26  205  			journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
2d859db3e4a82a Jan Kara           2011-07-26  206  			tid_t commit_tid = EXT4_I(inode)->i_datasync_tid;
2d859db3e4a82a Jan Kara           2011-07-26  207  
d76a3a77113db0 Theodore Ts'o      2013-04-03  208  			jbd2_complete_transaction(journal, commit_tid);
2d859db3e4a82a Jan Kara           2011-07-26  209  			filemap_write_and_wait(&inode->i_data);
2d859db3e4a82a Jan Kara           2011-07-26  210  		}
91b0abe36a7b2b Johannes Weiner    2014-04-03  211  		truncate_inode_pages_final(&inode->i_data);
5dc23bdd5f846e Jan Kara           2013-06-04  212  
0930fcc1ee2f0a Al Viro            2010-06-07  213  		goto no_delete;

Assume we hit this goto

0930fcc1ee2f0a Al Viro            2010-06-07  214  	}
0930fcc1ee2f0a Al Viro            2010-06-07  215  
e2bfb088fac03c Theodore Ts'o      2014-10-05  216  	if (is_bad_inode(inode))
e2bfb088fac03c Theodore Ts'o      2014-10-05  217  		goto no_delete;
871a293155a245 Christoph Hellwig  2010-03-03  218  	dquot_initialize(inode);
907f4554e2521c Christoph Hellwig  2010-03-03  219  
678aaf481496b0 Jan Kara           2008-07-11  220  	if (ext4_should_order_data(inode))
678aaf481496b0 Jan Kara           2008-07-11  221  		ext4_begin_ordered_truncate(inode, 0);
91b0abe36a7b2b Johannes Weiner    2014-04-03  222  	truncate_inode_pages_final(&inode->i_data);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  223  
ceff86fddae874 Jan Kara           2020-04-21  224  	/*
ceff86fddae874 Jan Kara           2020-04-21  225  	 * For inodes with journalled data, transaction commit could have
ceff86fddae874 Jan Kara           2020-04-21  226  	 * dirtied the inode. Flush worker is ignoring it because of I_FREEING
ceff86fddae874 Jan Kara           2020-04-21  227  	 * flag but we still need to remove the inode from the writeback lists.
ceff86fddae874 Jan Kara           2020-04-21  228  	 */
ceff86fddae874 Jan Kara           2020-04-21  229  	if (!list_empty_careful(&inode->i_io_list)) {
ceff86fddae874 Jan Kara           2020-04-21  230  		WARN_ON_ONCE(!ext4_should_journal_data(inode));
ceff86fddae874 Jan Kara           2020-04-21  231  		inode_io_list_del(inode);
ceff86fddae874 Jan Kara           2020-04-21  232  	}
ceff86fddae874 Jan Kara           2020-04-21  233  
8e8ad8a57c75f3 Jan Kara           2012-06-12  234  	/*
8e8ad8a57c75f3 Jan Kara           2012-06-12  235  	 * Protect us against freezing - iput() caller didn't have to have any
46e294efc355c4 Jan Kara           2020-11-27  236  	 * protection against it. When we are in a running transaction though,
46e294efc355c4 Jan Kara           2020-11-27  237  	 * we are already protected against freezing and we cannot grab further
46e294efc355c4 Jan Kara           2020-11-27  238  	 * protection due to lock ordering constraints.
8e8ad8a57c75f3 Jan Kara           2012-06-12  239  	 */
46e294efc355c4 Jan Kara           2020-11-27  240  	if (!ext4_journal_current_handle()) {
8e8ad8a57c75f3 Jan Kara           2012-06-12  241  		sb_start_intwrite(inode->i_sb);
46e294efc355c4 Jan Kara           2020-11-27  242  		freeze_protected = true;
46e294efc355c4 Jan Kara           2020-11-27  243  	}
e50e5129f384ae Andreas Dilger     2017-06-21  244  
30a7eb970c3aae Tahsin Erdogan     2017-06-22  245  	if (!IS_NOQUOTA(inode))
30a7eb970c3aae Tahsin Erdogan     2017-06-22  246  		extra_credits += EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb);
30a7eb970c3aae Tahsin Erdogan     2017-06-22  247  
65db869c754e7c Jan Kara           2019-11-05  248  	/*
65db869c754e7c Jan Kara           2019-11-05  249  	 * Block bitmap, group descriptor, and inode are accounted in both
65db869c754e7c Jan Kara           2019-11-05  250  	 * ext4_blocks_for_truncate() and extra_credits. So subtract 3.
65db869c754e7c Jan Kara           2019-11-05  251  	 */
30a7eb970c3aae Tahsin Erdogan     2017-06-22  252  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE,
65db869c754e7c Jan Kara           2019-11-05  253  			 ext4_blocks_for_truncate(inode) + extra_credits - 3);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  254  	if (IS_ERR(handle)) {
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  255  		ext4_std_error(inode->i_sb, PTR_ERR(handle));
ac27a0ec112a08 Dave Kleikamp      2006-10-11  256  		/*
ac27a0ec112a08 Dave Kleikamp      2006-10-11  257  		 * If we're going to skip the normal cleanup, we still need to
ac27a0ec112a08 Dave Kleikamp      2006-10-11  258  		 * make sure that the in-core orphan linked list is properly
ac27a0ec112a08 Dave Kleikamp      2006-10-11  259  		 * cleaned up.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  260  		 */
617ba13b31fbf5 Mingming Cao       2006-10-11  261  		ext4_orphan_del(NULL, inode);
46e294efc355c4 Jan Kara           2020-11-27  262  		if (freeze_protected)
8e8ad8a57c75f3 Jan Kara           2012-06-12  263  			sb_end_intwrite(inode->i_sb);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  264  		goto no_delete;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  265  	}
30a7eb970c3aae Tahsin Erdogan     2017-06-22  266  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  267  	if (IS_SYNC(inode))
0390131ba84fd3 Frank Mayhar       2009-01-07  268  		ext4_handle_sync(handle);
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  269  
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  270  	/*
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  271  	 * Set inode->i_size to 0 before calling ext4_truncate(). We need
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  272  	 * special handling of symlinks here because i_size is used to
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  273  	 * determine whether ext4_inode_info->i_data contains symlink data or
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  274  	 * block mappings. Setting i_size to 0 will remove its fast symlink
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  275  	 * status. Erase i_data so that it becomes a valid empty block map.
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  276  	 */
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  277  	if (ext4_inode_is_fast_symlink(inode))
407cd7fb83c0eb Tahsin Erdogan     2017-07-04  278  		memset(EXT4_I(inode)->i_data, 0, sizeof(EXT4_I(inode)->i_data));
ac27a0ec112a08 Dave Kleikamp      2006-10-11  279  	inode->i_size = 0;
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  280  	err = ext4_mark_inode_dirty(handle, inode);
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  281  	if (err) {
12062dddda4509 Eric Sandeen       2010-02-15  282  		ext4_warning(inode->i_sb,
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  283  			     "couldn't mark inode dirty (err %d)", err);
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  284  		goto stop_handle;
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  285  	}
2c98eb5ea24976 Theodore Ts'o      2016-11-13  286  	if (inode->i_blocks) {
2c98eb5ea24976 Theodore Ts'o      2016-11-13  287  		err = ext4_truncate(inode);
2c98eb5ea24976 Theodore Ts'o      2016-11-13  288  		if (err) {
54d3adbc29f0c7 Theodore Ts'o      2020-03-28  289  			ext4_error_err(inode->i_sb, -err,
2c98eb5ea24976 Theodore Ts'o      2016-11-13  290  				       "couldn't truncate inode %lu (err %d)",
2c98eb5ea24976 Theodore Ts'o      2016-11-13  291  				       inode->i_ino, err);
2c98eb5ea24976 Theodore Ts'o      2016-11-13  292  			goto stop_handle;
2c98eb5ea24976 Theodore Ts'o      2016-11-13  293  		}
2c98eb5ea24976 Theodore Ts'o      2016-11-13  294  	}
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  295  
30a7eb970c3aae Tahsin Erdogan     2017-06-22  296  	/* Remove xattr references. */
30a7eb970c3aae Tahsin Erdogan     2017-06-22  297  	err = ext4_xattr_delete_inode(handle, inode, &ea_inode_array,
30a7eb970c3aae Tahsin Erdogan     2017-06-22  298  				      extra_credits);
30a7eb970c3aae Tahsin Erdogan     2017-06-22  299  	if (err) {
30a7eb970c3aae Tahsin Erdogan     2017-06-22  300  		ext4_warning(inode->i_sb, "xattr delete (err %d)", err);
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  301  stop_handle:
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  302  		ext4_journal_stop(handle);
4538821993f448 Theodore Ts'o      2010-07-29  303  		ext4_orphan_del(NULL, inode);
46e294efc355c4 Jan Kara           2020-11-27  304  		if (freeze_protected)
8e8ad8a57c75f3 Jan Kara           2012-06-12  305  			sb_end_intwrite(inode->i_sb);
30a7eb970c3aae Tahsin Erdogan     2017-06-22  306  		ext4_xattr_inode_array_free(ea_inode_array);
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  307  		goto no_delete;
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  308  	}
bc965ab3f2b4b7 Theodore Ts'o      2008-08-02  309  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  310  	/*
617ba13b31fbf5 Mingming Cao       2006-10-11  311  	 * Kill off the orphan record which ext4_truncate created.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  312  	 * AKPM: I think this can be inside the above `if'.
617ba13b31fbf5 Mingming Cao       2006-10-11  313  	 * Note that ext4_orphan_del() has to be able to cope with the
ac27a0ec112a08 Dave Kleikamp      2006-10-11  314  	 * deletion of a non-existent orphan - this is because we don't
617ba13b31fbf5 Mingming Cao       2006-10-11  315  	 * know if ext4_truncate() actually created an orphan record.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  316  	 * (Well, we could do this if we need to, but heck - it works)
ac27a0ec112a08 Dave Kleikamp      2006-10-11  317  	 */
617ba13b31fbf5 Mingming Cao       2006-10-11  318  	ext4_orphan_del(handle, inode);
5ffff834322281 Arnd Bergmann      2018-07-29  319  	EXT4_I(inode)->i_dtime	= (__u32)ktime_get_real_seconds();
ac27a0ec112a08 Dave Kleikamp      2006-10-11  320  
ac27a0ec112a08 Dave Kleikamp      2006-10-11  321  	/*
ac27a0ec112a08 Dave Kleikamp      2006-10-11  322  	 * One subtle ordering requirement: if anything has gone wrong
ac27a0ec112a08 Dave Kleikamp      2006-10-11  323  	 * (transaction abort, IO errors, whatever), then we can still
ac27a0ec112a08 Dave Kleikamp      2006-10-11  324  	 * do these next steps (the fs will already have been marked as
ac27a0ec112a08 Dave Kleikamp      2006-10-11  325  	 * having errors), but we can't free the inode if the mark_dirty
ac27a0ec112a08 Dave Kleikamp      2006-10-11  326  	 * fails.
ac27a0ec112a08 Dave Kleikamp      2006-10-11  327  	 */
617ba13b31fbf5 Mingming Cao       2006-10-11  328  	if (ext4_mark_inode_dirty(handle, inode))
ac27a0ec112a08 Dave Kleikamp      2006-10-11  329  		/* If that failed, just do the required in-core inode clear. */
0930fcc1ee2f0a Al Viro            2010-06-07  330  		ext4_clear_inode(inode);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  331  	else
617ba13b31fbf5 Mingming Cao       2006-10-11  332  		ext4_free_inode(handle, inode);
617ba13b31fbf5 Mingming Cao       2006-10-11  333  	ext4_journal_stop(handle);
46e294efc355c4 Jan Kara           2020-11-27  334  	if (freeze_protected)
8e8ad8a57c75f3 Jan Kara           2012-06-12  335  		sb_end_intwrite(inode->i_sb);
0421a189bc8cde Tahsin Erdogan     2017-06-22  336  	ext4_xattr_inode_array_free(ea_inode_array);
ac27a0ec112a08 Dave Kleikamp      2006-10-11  337  	return;
ac27a0ec112a08 Dave Kleikamp      2006-10-11  338  no_delete:
b21ebf143af219 Harshad Shirwadkar 2020-11-05  339  	if (!list_empty(&EXT4_I(inode)->i_fc_list))

It's not clear without more context where this ->i_fc_list list is
modified.

db40129f85538a Xin Yin            2022-01-07 @340  		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, handle);

"handle" might be uninitialized?

0930fcc1ee2f0a Al Viro            2010-06-07  341  	ext4_clear_inode(inode);	/* We must guarantee clearing of inode... */
9d0be50230b333 Theodore Ts'o      2010-01-01  342  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

