Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593645B1704
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiIHIaY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiIHIaX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:30:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472194C617
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:30:22 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2887fkqg013972;
        Thu, 8 Sep 2022 08:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+PmpHeSCe/w/YZD9Z9S+DUytMidEWOkGUD6M/XlkWJ4=;
 b=qoZ9YenKd+CBZBPlsirZ9lplg4di/b6yijvMC1DLowlV2ZWHwvK4qPPRCNzTmO+Qashm
 QA/xe+KYa8i9W4Tm7xDc/kpxR1YZ7Z7XuLVk0JKlToPRAvtWnzpDIp5u69kP6pzY1KZN
 ZI5NCTym/pbj8ghUeao5AB8kgHOJSzC/R4baZziqaBZ8wSrYBwiNEzwLPj9konpdMH5y
 qUToDxhPy6pMkAkQyZWIYNDr1ALKOmPAZjEyMQxCiCFvR0kFk0dXWkA3OFXk212fCmzz
 jEs46ZmYIHkfjOr7bdzfA90Sua+73EQESnXL2d4WKUnJpDVakEa21mQvbcu5ypEEP8DM Tg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfc7s9jga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:30:09 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2888KSNJ007320;
        Thu, 8 Sep 2022 08:30:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3jbx6hp9xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:30:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2888U42d38207988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 08:30:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B805A11C04A;
        Thu,  8 Sep 2022 08:30:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CCC611C05E;
        Thu,  8 Sep 2022 08:30:02 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.112.167])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Sep 2022 08:30:02 +0000 (GMT)
Date:   Thu, 8 Sep 2022 13:59:58 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 5/5] ext4: Use buckets for cr 1 block scan instead of
 rbtree
Message-ID: <YxmoBpQdRqh/e4ol@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220906150803.375-1-jack@suse.cz>
 <20220906152920.25584-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906152920.25584-5-jack@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OmoWm3wpEkT5gGvEUJpKAJRj5SiuECEO
X-Proofpoint-ORIG-GUID: OmoWm3wpEkT5gGvEUJpKAJRj5SiuECEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

On Tue, Sep 06, 2022 at 05:29:11PM +0200, Jan Kara wrote:
>  
>  ** snip **
>  /*
>   * Choose next group by traversing average fragment size tree. Updates *new_cr
Maybe we can change this to "average fragment size list of suitable
order"
> - * if cr lvel needs an update. Sets EXT4_MB_SEARCH_NEXT_LINEAR to indicate that
> - * the linear search should continue for one iteration since there's lock
> - * contention on the rb tree lock.
> + * if cr level needs an update. 
>   */
>  static void ext4_mb_choose_next_group_cr1(struct ext4_allocation_context *ac,
>  		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> -	int avg_fragment_size, best_so_far;
> -	struct rb_node *node, *found;
> -	struct ext4_group_info *grp;

Other than that, this patch along with the updated mb_structs_summary
proc file change looks good to me.

Regards,
Ojaswin
