Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A11695191
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 21:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjBMUPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 15:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjBMUPF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 15:15:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1953596;
        Mon, 13 Feb 2023 12:15:04 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DKDUxI027051;
        Mon, 13 Feb 2023 20:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=6/Zk3u+w5hzNg6S+Sv/5QXb+RTN+bmwB6vvGSyIVakU=;
 b=EP0qNvd1OAnBn1Jw3XAsHHkry1Bo+U1FmmhUELHqrsKZdeJohcLFKobIhA8pQEK7l0FR
 9Q5urludjZuwHBhOFw9zOLsE/PWAQFa1qX2hngk/GqwmKjHwEay2zI1vd2E7NHkXzqn5
 /VcbbTDX43S9tKPgJKBuYoyj40A7G1AoQ4uyeBntqPgSIsPiWHn0XommwckX2hX3tPfI
 TjiE2ziTe/SKOZ5WcOFJ68pEunOAW0ty+veo8jqkRAVHbm+9MN96Iifnf3VwEA+LpVjg
 MYqpP8ieQ0wZ2QxStis4MfIqNqHbvzniHMOmx8hQ27pIC7NFGUvrpb+cR6aRKU6S0xVN PQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqv2880ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 20:14:56 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31D8lIlG007609;
        Mon, 13 Feb 2023 20:14:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3np2n6aa38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 20:14:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DKEq4j47513972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 20:14:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C9E720043;
        Mon, 13 Feb 2023 20:14:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7342920040;
        Mon, 13 Feb 2023 20:14:50 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 20:14:50 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:44:47 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] ext4: get correct ext4_group_info in
 ext4_mb_prefetch_fini
Message-ID: <Y+qaN6fnlOX8EjtL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-5-shikemeng@huaweicloud.com>
 <Y+ngxf4fBbhPBHPk@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <51940a4e-b01d-cef8-af35-87788df483f1@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51940a4e-b01d-cef8-af35-87788df483f1@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rhN8jIH5oK3VMVGPTLXshpJ3lYhNMMPc
X-Proofpoint-GUID: rhN8jIH5oK3VMVGPTLXshpJ3lYhNMMPc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 13, 2023 at 08:27:32PM +0800, Kemeng Shi wrote:
> 
> 
> on 2/13/2023 3:03 PM, Ojaswin Mujoo wrote:
> > On Fri, Feb 10, 2023 at 03:48:08AM +0800, Kemeng Shi wrote:
> >> We always get ext4_group_desc with group + 1 and ext4_group_info with
> >> group to check if we need do initialize ext4_group_info for the group.
> >> Just get ext4_group_desc with group for ext4_group_info initialization
> >> check.
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >> ---
> >>  fs/ext4/mballoc.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> >> index 352ac9139fee..f24f80ecf318 100644
> >> --- a/fs/ext4/mballoc.c
> >> +++ b/fs/ext4/mballoc.c
> >> @@ -2570,13 +2570,13 @@ void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
> >>  			   unsigned int nr)
> >>  {
> >>  	while (nr-- > 0) {
> >> -		struct ext4_group_desc *gdp = ext4_get_group_desc(sb, group,
> >> -								  NULL);
> >> -		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
> >> +		struct ext4_group_desc *gdp;
> >> +		struct ext4_group_info *grp;
> >>  
> >>  		if (!group)
> >>  			group = ext4_get_groups_count(sb);
> >>  		group--;
> >> +		gdp = ext4_get_group_desc(sb, group, NULL);
> >>  		grp = ext4_get_group_info(sb, group);
> >>  
> >>  		if (EXT4_MB_GRP_NEED_INIT(grp) &&
> >> -- 
> >> 2.30.0
> >>
> > 
> > This is a duplicate of [1] :)
> > 
> > But I'm okay with this going in as that patchseries might take some time
> > to get merged. Feel free to add:
> > 
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 
> > 
> > [1] https://lore.kernel.org/r/85bbcb3774e38de65b737ef0000241ddbdda73aa.1674822311.git.ojaswin@linux.ibm.com
> > 
> Hi Ojaswin, Thank you so much to review my code. I 'm sorry that I didn't
> notice this patch is duplicated and I really appreciate that you allow this
> one to get merged first. I will add your sign to this patch in next version.
> Thanks!
Hi Kemeng,

So I'm not sure what the norm is when dealing with such duplicate
patches, but if you do plan to add the Signed-off-by then I'd just like
to point out that the patch I linked is mainly from Ritesh Harjani, so
you can pick his Signed-off-by rather than mine.

Thanks,
ojaswin
> 
> -- 
> Best wishes
> Kemeng Shi
> 
