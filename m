Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06DE695113
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 20:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjBMTuv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 14:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBMTuu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 14:50:50 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC3E21283;
        Mon, 13 Feb 2023 11:50:29 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJiGJm019225;
        Mon, 13 Feb 2023 19:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=/gIUDWbEONJ0vH8xEx6l//82vdKBFfwdeQkiXV2B8e0=;
 b=le/AwV2BmE0R7qegnpniy+3XxTZqtMJOAKa8W4U8Jf6BGV/9PlfZXA5mzC417ZgZzCbp
 U8+x+VAe5GirSHHE1zjRaM+uS7In+UPPXcJRfH+YRpB+a64lJrs0ZGqmoVdSifgf97rI
 RH8q2qcxuYF4kKepAoqrC/YoUiUveKAfafRlAS+klrU95+frtg8jJDSGXT1nTf1p8t5K
 drmhqJsU2E/pTjkus5wrCysjqMjAO8yEGRm5QA9zF99kJiA4OS+zKDIDC58xIG9itKvb
 m7j949sk1e/AfjcU55T4PqMFjxneJN3JfTIgfMCtN8p1sL4K4aMl+R7cIoSMrjwu8WM4 iQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqumfg3m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:50:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DBqos4029819;
        Mon, 13 Feb 2023 19:50:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3np29fk3hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:50:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DJoHJa42271014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 19:50:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 187752004B;
        Mon, 13 Feb 2023 19:50:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8935B20040;
        Mon, 13 Feb 2023 19:50:15 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 19:50:15 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:20:12 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/21] ext4: remove dead check in mb_buddy_mark_free
Message-ID: <Y+qUdLKXgWFrWlck@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-14-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-14-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZrQDBmg2bkaSJrxIFXXFQnNvyMOFz1t3
X-Proofpoint-ORIG-GUID: ZrQDBmg2bkaSJrxIFXXFQnNvyMOFz1t3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=764
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:17AM +0800, Kemeng Shi wrote:
> We always adjust first to even number and adjust last to odd number, so
> first == last will never happen. Remove this dead check.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index bdabe0d81d4a..0fdbf16ac180 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1718,7 +1718,8 @@ static void mb_buddy_mark_free(struct ext4_buddy *e4b, int first, int last)
>  			break;
>  		order++;
>  
> -		if (first == last || !(buddy2 = mb_find_buddy(e4b, order, &max))) {
> +		buddy2 = mb_find_buddy(e4b, order, &max);
> +		if (!buddy2) {
>  			mb_clear_bits(buddy, first, last - first + 1);
>  			e4b->bd_info->bb_counters[order - 1] += last - first + 1;
>  			break;
> -- 
> 2.30.0
> 
Okay, so I checked the code and seems like you are right. There is can't be any
scenario where (first == last) after the calls to mb_buddy_adjust_border().

However, I'm a bit hesitant to give my Reviewed by since buddy algo is still a
bit confusing to me and I might be missing some weird edge case.  Maybe someone
can help double check this.
