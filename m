Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A765899A8
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 11:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiHDJCW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiHDJCV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 05:02:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B02A42B
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 02:02:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2748O2bA007436;
        Thu, 4 Aug 2022 09:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=ZeW7yznn7cNEuP6Lr1gClHEjqCCWKmh3AfxfR31lifA=;
 b=tM+Tm+lCaN+K4fhAKZ5Rs3/LWAAwDGasSclR8nQInBJEpV5W5EASqxXO1XUq/B8P7eYD
 kk31ny4aKmiye2zDhDvJUgZxiC5l25qCVPRfB88z5iWnnFEvriK90Z4b8XPHhnbFQYP4
 bfTgEbzVPWi1xVgSR0KdQKoL+MHNICDmUpLb63/Hecte/pA2UiOM2LWisP786nIk8ZhN
 X4pmT4os2rSn80WvE6JPZjhmhF/iXktUxfRxGOIJfx+0NvcAp3oW7wO8kY+vEgTsXpLY
 oh3lEx4J55m33oKEH/96Y9P83Z6qYgP1S9O2w5DeX+lu7YASassb+C3YaHWDr+oXcPM3 dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2ve6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 09:02:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2747jCZH002984;
        Thu, 4 Aug 2022 09:02:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu343y01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 09:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8ALXP7cr1YVJCSDDYLpvjEhP+7YHq7YQYGc+6kslMvoFkfIk/iCXIExpZRAD0EiLluMuXox3zOYSvjkcRZtxv5ydMAvH9k/DegYeKWnTJ5cflha0eCSFl5/bZ0zgwBJ9IlUsT7bdknCnXXrc/CCDBk982prbLM4ir7n1bHGc+m2AiqCQMe2+zmkmNEKNTg+EKEGVgXNzsDmftNwJyvqckDXgEZcLko//9vV6Oz0hi8ODakbrqnUMF1NLE8s1G42Q6gLW8EMMbEQYzHpjweGEMFfybt8426c5BViziZSQ8beYfNFc13+z9npaSIT6HAgGbwhCBLHpiev+bS9c2HP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeW7yznn7cNEuP6Lr1gClHEjqCCWKmh3AfxfR31lifA=;
 b=mv1foAzpiJ2Mr3ZapiVm5ZDR/fBCO7riMeIqtNxOdOKO8REzFtQxow48sS9qqCkoT5ywKEwg1wl0+6mopbV1s6L99i6PifLGaJ/653/DyOG1ENjs352ii/AWEnWL45wJdgGoN5KIu7rXROKj3uKlw0w/cZYbcXfUweoHDZ7o48Ky9ZNt0fbPWwTom6OohxIrAidSzUbQllp2ASnTqELyco0oWK3OJu6F3X5/pj+CFNn0HiGZfMWsTwjsXP1hutSILAz5Sql7Jy7EMKrTGjvDMUOJe4GxRcwqNeshIDo358e4j5Ws8OkuCifIl678Brp86Bq3KQPmRSVKL5OgFaquGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeW7yznn7cNEuP6Lr1gClHEjqCCWKmh3AfxfR31lifA=;
 b=PnbggO+NvsWVOJO6sHvOmaxA79uUMAB8tfJS6JemQrJSZTJW5jq6xWef1d8UJv0nidCTezLk03zimVYBqOISHMM5dJwZT3zscr85vOD5YJ4+78O1gjBGshuid2byDi9kAg9r8DCY11xD+5v6sY492S2fVQ3aumjk3BaDL2mWTMM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1572.namprd10.prod.outlook.com
 (2603:10b6:404:3d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Thu, 4 Aug
 2022 09:02:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 09:02:12 +0000
Date:   Thu, 4 Aug 2022 12:02:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jack@suse.cz
Cc:     linux-ext4@vger.kernel.org
Subject: [bug report] ext4: fix race when reusing xattr blocks
Message-ID: <YuuLCwthRybOcRPi@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZRAP278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 767ec94f-7fd1-405e-1e10-08da75f804af
X-MS-TrafficTypeDiagnostic: BN6PR10MB1572:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjVIAomPAxzkZNlAdY2/epjjU+2L8gTjpOlIa95/PQcrAx7UM39glxMfpaVRvyRvYuMDxWievdc9V1dKScpxvYmfJk0cCpAuyBZVw6T8qh2Fe9YqUvRESW8quQ6tS+povA6U6NTVlapDHfj+wLmNP9F5a/00kJTeCk5w3chhRbOlKm06YUjpiq23NMrJmQ41TlulxGSmIAmf9257OVWhM+q/RqCHetEEZif0sJKCbxA4p8Y75frWT7oDVXrzUTP2krwyb09u/KCRvF3CD4d4fMkDE06dOw3IFvzYhv4hjDjpzl0CVyJAAZz/PrI+tW7zITisM6uUMWPywSa2HzV86+2vgOCu3B4dNq1DYtbzhDGQeRU0cm3AOtMnifu+8PhHLe4Vn4pM8kAYm71VlPrtcLkVzweOgzJUbmcDjiNxJtd5kjRAqHi/EdNlrbyGa8GBJ1rQI3XGXIHgqfkKo6qNTQMaWBiZmX6gLFxyxCrICigeiT+wYg7Mm8Oy0Y3xIw61srYwUzkPGBTcI9kBheEDIUbEOwzNqtDDeb/JQVblL9nVDKQTtvlYNG9LIpveHtgZC8HiWRKo49RMZUHYonW0NLVjsSyww4+kyLJ2Xy8HVaJG2AQ+Fqs4IcoH7CZwilxdLPr7xSEH+Hf6E/kOZiLoB+w0cY2HU3T8Slpz58tl6LC5p8FHaPWYgjDva/myhdd2h/g/W1vLngv5ds8Fe0Zghra7Qy9CZ5yvuEDM/63Q5RFdN6vkFheCknDO038uXKtbMKouq0KDtUo9ZSwk21dpnCoKMfn5bZgOLKrCcrFkuLfTWmIa2QdQUCqXsp7VEI5t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(136003)(396003)(39860400002)(376002)(8676002)(83380400001)(66946007)(4326008)(66556008)(186003)(66476007)(8936002)(30864003)(5660300002)(2906002)(44832011)(6506007)(6916009)(478600001)(52116002)(6666004)(6486002)(316002)(41300700001)(9686003)(26005)(6512007)(86362001)(38100700002)(38350700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woRwTauaY6Rl/sWLgJJepJBaDAZREE+IrUJD/Npfx+87x8Y5/Tac0uJ9eHGO?=
 =?us-ascii?Q?qg2IjpKZDoo3Xbk5xvdzRxIsjc7XsY30M9GqfNgyXh93hixs+6SAn31l7Bfg?=
 =?us-ascii?Q?/1T07A1OwpByFi4PJo3Uh0I5inG0nj8aVolsPH3/EGsMbeT4KwmhHjJ0Zwo8?=
 =?us-ascii?Q?o6uBs1qrcUSAqSz3uVSSolI29Fm5hNerWSJO2nUvsNO9aEJVd8DEKvkMSBCr?=
 =?us-ascii?Q?NHHDhN8+S/kPCoxcmQQmCFUgyIBwdk3s3IiRAPh92yB+wYHXf9KD7gogsSRb?=
 =?us-ascii?Q?XGDg8d0Pe/ULYdkeW1Z6phjdNqGvBxBQDhVKqyNCKm1X4TwZrwPN4zF4HGVb?=
 =?us-ascii?Q?Zccsh08nEMaeznRKMnVkL51XzYJGECIyRM+Dqndgo5XFZpvpYBSf6BUDHeND?=
 =?us-ascii?Q?ivlML5n5tzWsFcuWaMm+SgMCjL2uFxm+11hR7ftRA/wxw8+2rkZeqWI9uNJV?=
 =?us-ascii?Q?iJSnAkbvTMEnmOhkGj/K5JgjpDIM4U20+V8mCF662pib8JojCw2bjQ9elrpx?=
 =?us-ascii?Q?ikkOHtQ3206Vqw+jIJlBxJLbxrM7dRCA1xWC6Fdem/dEXzy1qKALMJ2wa/xW?=
 =?us-ascii?Q?nlcq121P7aStdv0pl3lGLcQkBzBCSej+p2aj+H0mFu/SdnNjkiOr7q+wurt9?=
 =?us-ascii?Q?gXV5z9GxcEDHh0LcI2WbpIlkur/UJqEUww6JV6Hi2xOdOV937tmNLY1Sn+Hm?=
 =?us-ascii?Q?yXyyTJoaIkWwXj7h/dr6Xdr/clWNEvRu4P/6aldAlRCq/P03TV+zds+cd1f+?=
 =?us-ascii?Q?IH74TVrvxzAN98rKVIcGNc1Z5QwoKcIavHD8FEAuT13ltKhMXKFr+a+RMQsp?=
 =?us-ascii?Q?BFgoa5AopSz58+8rOCVYlWzz8upLtYcvR9om8nfwyVCrLhpbyt/fmQReYnge?=
 =?us-ascii?Q?x2Sis1Q959NsvUHdMsaMmE+Fh+09UjnMEh4ekAUBbSbENOwlHDS4Xgk59AWG?=
 =?us-ascii?Q?aQ/+ghGdc+JvhtJ7RW+CQoFa/9bDN8qajb7vDK/mMNsD0/JNPRI2U1Sd7LmE?=
 =?us-ascii?Q?8oe8QlUlvTQuZbmys+CmHNIy8lSnmRyG9yHN8rsXZHTSPvHkWfyQIYhgM6iQ?=
 =?us-ascii?Q?v5ehTo0jNu8DzZz1/xb1U228dmS2h6lbrtuAW31j2rZRve7Dc9beOQxTOTQl?=
 =?us-ascii?Q?Nkk2j5EpRrS13WlGoax2EPahZ0a6IxbQujnBNKkKfDvJeO3XR0c7DPx5Zytd?=
 =?us-ascii?Q?9GfqSHqygSQaxOFR629jBiblPho8dhRXNIIj9o0a8Pfzk+zRYy2lswY33Twz?=
 =?us-ascii?Q?/AWD9z4njF9E8DAgRcO6m7ST/9ASvfZoo0Zc8v8umFc9HVBAP8uCSy6gecWA?=
 =?us-ascii?Q?ppFQ6dcTpBdnzQ5gV1bxsqhLmlAKfi2MJ1/NGxPfuLXVZCDTJ+mvNHXoNFdF?=
 =?us-ascii?Q?5nBESTlFnMMYKNLvt+YZMf4j4jaalrs+U6HZrjPLPyzkVVAV02QHspK3vW2o?=
 =?us-ascii?Q?8Of8kqdFaZMQ+qrSvPVAO+oY08C3q0uMopnWFAfbOnMQ+Z4oIbQYv7LjpqoN?=
 =?us-ascii?Q?GYE9N9Kd1ec2ZSDvXsPIYXdLX0W/MONfVDYGn/tHWzrgDhgyP8RhoJ34DO9x?=
 =?us-ascii?Q?J5NXD9OJ1oFQs0ziO3t26GQu2WUMecWyqjX5xJBmgcU5rlNvNUntbRtcF8sD?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767ec94f-7fd1-405e-1e10-08da75f804af
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 09:02:12.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOiI8KG6tRyrzmwv3RGYlf0FpHsc1TwHpJvCw6Hyp0shCjeCnkMt0H6F3HjfVN/DU5hroWBlQ7Sha2a6ZVjjTydLQGPml5XwL/p3TKO3z20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=689 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040038
X-Proofpoint-ORIG-GUID: mMzlXmTEjWvKkLfm4vfJHFMzcQZkOVvM
X-Proofpoint-GUID: mMzlXmTEjWvKkLfm4vfJHFMzcQZkOVvM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[ This code is above my pay grade.  The cache is refcounted so it might
not be freed.  But hopefully the patch is recent enough that the details
are still top of the head for you to review it quickly?  Hopefully, no
big deal if it's a false positive.  These reports are one time only.
-dan ]

Hello Jan Kara,

The patch 132991ed2882: "ext4: fix race when reusing xattr blocks"
from Jul 12, 2022, leads to the following Smatch static checker
warning:

	fs/ext4/xattr.c:2038 ext4_xattr_block_set()
	warn: 'ea_block_cache' was already freed.

fs/ext4/xattr.c
    1850 static int
    1851 ext4_xattr_block_set(handle_t *handle, struct inode *inode,
    1852                      struct ext4_xattr_info *i,
    1853                      struct ext4_xattr_block_find *bs)
    1854 {
    1855         struct super_block *sb = inode->i_sb;
    1856         struct buffer_head *new_bh = NULL;
    1857         struct ext4_xattr_search s_copy = bs->s;
    1858         struct ext4_xattr_search *s = &s_copy;
    1859         struct mb_cache_entry *ce = NULL;
    1860         int error = 0;
    1861         struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
    1862         struct inode *ea_inode = NULL, *tmp_inode;
    1863         size_t old_ea_inode_quota = 0;
    1864         unsigned int ea_ino;
    1865 
    1866 
    1867 #define header(x) ((struct ext4_xattr_header *)(x))
    1868 
    1869         if (s->base) {
    1870                 int offset = (char *)s->here - bs->bh->b_data;
    1871 
    1872                 BUFFER_TRACE(bs->bh, "get_write_access");
    1873                 error = ext4_journal_get_write_access(handle, sb, bs->bh,
    1874                                                       EXT4_JTR_NONE);
    1875                 if (error)
    1876                         goto cleanup;
    1877                 lock_buffer(bs->bh);
    1878 
    1879                 if (header(s->base)->h_refcount == cpu_to_le32(1)) {
    1880                         __u32 hash = le32_to_cpu(BHDR(bs->bh)->h_hash);
    1881 
    1882                         /*
    1883                          * This must happen under buffer lock for
    1884                          * ext4_xattr_block_set() to reliably detect modified
    1885                          * block
    1886                          */
    1887                         if (ea_block_cache) {
    1888                                 struct mb_cache_entry *oe;
    1889 
    1890                                 oe = mb_cache_entry_delete_or_get(ea_block_cache,
    1891                                         hash, bs->bh->b_blocknr);

"ea_block_cache" potentially freed here?

    1892                                 if (oe) {
    1893                                         /*
    1894                                          * Xattr block is getting reused. Leave
    1895                                          * it alone.
    1896                                          */
    1897                                         mb_cache_entry_put(ea_block_cache, oe);

Also here?

    1898                                         goto clone_block;
    1899                                 }
    1900                         }
    1901                         ea_bdebug(bs->bh, "modifying in-place");
    1902                         error = ext4_xattr_set_entry(i, s, handle, inode,
    1903                                                      true /* is_block */);
    1904                         ext4_xattr_block_csum_set(inode, bs->bh);
    1905                         unlock_buffer(bs->bh);
    1906                         if (error == -EFSCORRUPTED)
    1907                                 goto bad_block;
    1908                         if (!error)
    1909                                 error = ext4_handle_dirty_metadata(handle,
    1910                                                                    inode,
    1911                                                                    bs->bh);
    1912                         if (error)
    1913                                 goto cleanup;
    1914                         goto inserted;
    1915                 }
    1916 clone_block:
    1917                 unlock_buffer(bs->bh);
    1918                 ea_bdebug(bs->bh, "cloning");
    1919                 s->base = kmemdup(BHDR(bs->bh), bs->bh->b_size, GFP_NOFS);
    1920                 error = -ENOMEM;
    1921                 if (s->base == NULL)
    1922                         goto cleanup;
    1923                 s->first = ENTRY(header(s->base)+1);
    1924                 header(s->base)->h_refcount = cpu_to_le32(1);
    1925                 s->here = ENTRY(s->base + offset);
    1926                 s->end = s->base + bs->bh->b_size;
    1927 
    1928                 /*
    1929                  * If existing entry points to an xattr inode, we need
    1930                  * to prevent ext4_xattr_set_entry() from decrementing
    1931                  * ref count on it because the reference belongs to the
    1932                  * original block. In this case, make the entry look
    1933                  * like it has an empty value.
    1934                  */
    1935                 if (!s->not_found && s->here->e_value_inum) {
    1936                         ea_ino = le32_to_cpu(s->here->e_value_inum);
    1937                         error = ext4_xattr_inode_iget(inode, ea_ino,
    1938                                       le32_to_cpu(s->here->e_hash),
    1939                                       &tmp_inode);
    1940                         if (error)
    1941                                 goto cleanup;
    1942 
    1943                         if (!ext4_test_inode_state(tmp_inode,
    1944                                         EXT4_STATE_LUSTRE_EA_INODE)) {
    1945                                 /*
    1946                                  * Defer quota free call for previous
    1947                                  * inode until success is guaranteed.
    1948                                  */
    1949                                 old_ea_inode_quota = le32_to_cpu(
    1950                                                 s->here->e_value_size);
    1951                         }
    1952                         iput(tmp_inode);
    1953 
    1954                         s->here->e_value_inum = 0;
    1955                         s->here->e_value_size = 0;
    1956                 }
    1957         } else {
    1958                 /* Allocate a buffer where we construct the new block. */
    1959                 s->base = kzalloc(sb->s_blocksize, GFP_NOFS);
    1960                 error = -ENOMEM;
    1961                 if (s->base == NULL)
    1962                         goto cleanup;
    1963                 header(s->base)->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
    1964                 header(s->base)->h_blocks = cpu_to_le32(1);
    1965                 header(s->base)->h_refcount = cpu_to_le32(1);
    1966                 s->first = ENTRY(header(s->base)+1);
    1967                 s->here = ENTRY(header(s->base)+1);
    1968                 s->end = s->base + sb->s_blocksize;
    1969         }
    1970 
    1971         error = ext4_xattr_set_entry(i, s, handle, inode, true /* is_block */);
    1972         if (error == -EFSCORRUPTED)
    1973                 goto bad_block;
    1974         if (error)
    1975                 goto cleanup;
    1976 
    1977         if (i->value && s->here->e_value_inum) {
    1978                 /*
    1979                  * A ref count on ea_inode has been taken as part of the call to
    1980                  * ext4_xattr_set_entry() above. We would like to drop this
    1981                  * extra ref but we have to wait until the xattr block is
    1982                  * initialized and has its own ref count on the ea_inode.
    1983                  */
    1984                 ea_ino = le32_to_cpu(s->here->e_value_inum);
    1985                 error = ext4_xattr_inode_iget(inode, ea_ino,
    1986                                               le32_to_cpu(s->here->e_hash),
    1987                                               &ea_inode);
    1988                 if (error) {
    1989                         ea_inode = NULL;
    1990                         goto cleanup;
    1991                 }
    1992         }
    1993 
    1994 inserted:
    1995         if (!IS_LAST_ENTRY(s->first)) {
    1996                 new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
    1997                                                      &ce);
    1998                 if (new_bh) {
    1999                         /* We found an identical block in the cache. */
    2000                         if (new_bh == bs->bh)
    2001                                 ea_bdebug(new_bh, "keeping");
    2002                         else {
    2003                                 u32 ref;
    2004 
    2005                                 WARN_ON_ONCE(dquot_initialize_needed(inode));
    2006 
    2007                                 /* The old block is released after updating
    2008                                    the inode. */
    2009                                 error = dquot_alloc_block(inode,
    2010                                                 EXT4_C2B(EXT4_SB(sb), 1));
    2011                                 if (error)
    2012                                         goto cleanup;
    2013                                 BUFFER_TRACE(new_bh, "get_write_access");
    2014                                 error = ext4_journal_get_write_access(
    2015                                                 handle, sb, new_bh,
    2016                                                 EXT4_JTR_NONE);
    2017                                 if (error)
    2018                                         goto cleanup_dquot;
    2019                                 lock_buffer(new_bh);
    2020                                 /*
    2021                                  * We have to be careful about races with
    2022                                  * adding references to xattr block. Once we
    2023                                  * hold buffer lock xattr block's state is
    2024                                  * stable so we can check the additional
    2025                                  * reference fits.
    2026                                  */
    2027                                 ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
    2028                                 if (ref > EXT4_XATTR_REFCOUNT_MAX) {
    2029                                         /*
    2030                                          * Undo everything and check mbcache
    2031                                          * again.
    2032                                          */
    2033                                         unlock_buffer(new_bh);
    2034                                         dquot_free_block(inode,
    2035                                                          EXT4_C2B(EXT4_SB(sb),
    2036                                                                   1));
    2037                                         brelse(new_bh);
--> 2038                                         mb_cache_entry_put(ea_block_cache, ce);

Warning.

    2039                                         ce = NULL;
    2040                                         new_bh = NULL;
    2041                                         goto inserted;
    2042                                 }
    2043                                 BHDR(new_bh)->h_refcount = cpu_to_le32(ref);
    2044                                 if (ref == EXT4_XATTR_REFCOUNT_MAX)
    2045                                         ce->e_reusable = 0;
    2046                                 ea_bdebug(new_bh, "reusing; refcount now=%d",
    2047                                           ref);
    2048                                 ext4_xattr_block_csum_set(inode, new_bh);
    2049                                 unlock_buffer(new_bh);
    2050                                 error = ext4_handle_dirty_metadata(handle,
    2051                                                                    inode,
    2052                                                                    new_bh);
    2053                                 if (error)
    2054                                         goto cleanup_dquot;
    2055                         }
    2056                         mb_cache_entry_touch(ea_block_cache, ce);
    2057                         mb_cache_entry_put(ea_block_cache, ce);
    2058                         ce = NULL;
    2059                 } else if (bs->bh && s->base == bs->bh->b_data) {
    2060                         /* We were modifying this block in-place. */
    2061                         ea_bdebug(bs->bh, "keeping this block");
    2062                         ext4_xattr_block_cache_insert(ea_block_cache, bs->bh);
    2063                         new_bh = bs->bh;
    2064                         get_bh(new_bh);
    2065                 } else {
    2066                         /* We need to allocate a new block */
    2067                         ext4_fsblk_t goal, block;
    2068 
    2069                         WARN_ON_ONCE(dquot_initialize_needed(inode));
    2070 
    2071                         goal = ext4_group_first_block_no(sb,
    2072                                                 EXT4_I(inode)->i_block_group);
    2073 
    2074                         /* non-extent files can't have physical blocks past 2^32 */
    2075                         if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
    2076                                 goal = goal & EXT4_MAX_BLOCK_FILE_PHYS;
    2077 
    2078                         block = ext4_new_meta_blocks(handle, inode, goal, 0,
    2079                                                      NULL, &error);
    2080                         if (error)
    2081                                 goto cleanup;
    2082 
    2083                         if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
    2084                                 BUG_ON(block > EXT4_MAX_BLOCK_FILE_PHYS);
    2085 
    2086                         ea_idebug(inode, "creating block %llu",
    2087                                   (unsigned long long)block);
    2088 
    2089                         new_bh = sb_getblk(sb, block);
    2090                         if (unlikely(!new_bh)) {
    2091                                 error = -ENOMEM;
    2092 getblk_failed:
    2093                                 ext4_free_blocks(handle, inode, NULL, block, 1,
    2094                                                  EXT4_FREE_BLOCKS_METADATA);
    2095                                 goto cleanup;
    2096                         }
    2097                         error = ext4_xattr_inode_inc_ref_all(handle, inode,
    2098                                                       ENTRY(header(s->base)+1));
    2099                         if (error)
    2100                                 goto getblk_failed;
    2101                         if (ea_inode) {
    2102                                 /* Drop the extra ref on ea_inode. */
    2103                                 error = ext4_xattr_inode_dec_ref(handle,
    2104                                                                  ea_inode);
    2105                                 if (error)
    2106                                         ext4_warning_inode(ea_inode,
    2107                                                            "dec ref error=%d",
    2108                                                            error);
    2109                                 iput(ea_inode);
    2110                                 ea_inode = NULL;
    2111                         }
    2112 
    2113                         lock_buffer(new_bh);
    2114                         error = ext4_journal_get_create_access(handle, sb,
    2115                                                         new_bh, EXT4_JTR_NONE);
    2116                         if (error) {
    2117                                 unlock_buffer(new_bh);
    2118                                 error = -EIO;
    2119                                 goto getblk_failed;
    2120                         }
    2121                         memcpy(new_bh->b_data, s->base, new_bh->b_size);
    2122                         ext4_xattr_block_csum_set(inode, new_bh);
    2123                         set_buffer_uptodate(new_bh);
    2124                         unlock_buffer(new_bh);
    2125                         ext4_xattr_block_cache_insert(ea_block_cache, new_bh);
    2126                         error = ext4_handle_dirty_metadata(handle, inode,
    2127                                                            new_bh);
    2128                         if (error)
    2129                                 goto cleanup;
    2130                 }
    2131         }
    2132 
    2133         if (old_ea_inode_quota)
    2134                 ext4_xattr_inode_free_quota(inode, NULL, old_ea_inode_quota);
    2135 
    2136         /* Update the inode. */
    2137         EXT4_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
    2138 
    2139         /* Drop the previous xattr block. */
    2140         if (bs->bh && bs->bh != new_bh) {
    2141                 struct ext4_xattr_inode_array *ea_inode_array = NULL;
    2142 
    2143                 ext4_xattr_release_block(handle, inode, bs->bh,
    2144                                          &ea_inode_array,
    2145                                          0 /* extra_credits */);
    2146                 ext4_xattr_inode_array_free(ea_inode_array);
    2147         }
    2148         error = 0;
    2149 
    2150 cleanup:
    2151         if (ea_inode) {
    2152                 int error2;
    2153 
    2154                 error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
    2155                 if (error2)
    2156                         ext4_warning_inode(ea_inode, "dec ref error=%d",
    2157                                            error2);
    2158 
    2159                 /* If there was an error, revert the quota charge. */
    2160                 if (error)
    2161                         ext4_xattr_inode_free_quota(inode, ea_inode,
    2162                                                     i_size_read(ea_inode));
    2163                 iput(ea_inode);
    2164         }
    2165         if (ce)
    2166                 mb_cache_entry_put(ea_block_cache, ce);
    2167         brelse(new_bh);
    2168         if (!(bs->bh && s->base == bs->bh->b_data))
    2169                 kfree(s->base);
    2170 
    2171         return error;
    2172 
    2173 cleanup_dquot:
    2174         dquot_free_block(inode, EXT4_C2B(EXT4_SB(sb), 1));
    2175         goto cleanup;
    2176 
    2177 bad_block:
    2178         EXT4_ERROR_INODE(inode, "bad block %llu",
    2179                          EXT4_I(inode)->i_file_acl);
    2180         goto cleanup;
    2181 
    2182 #undef header
    2183 }

regards,
dan carpenter
