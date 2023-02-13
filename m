Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F087695172
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 21:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBMUMS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 15:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBMUMR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 15:12:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0989ABDD8;
        Mon, 13 Feb 2023 12:12:17 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DJupMA001627;
        Mon, 13 Feb 2023 20:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XO/SlLKgjapjWsjCU1ZO5lGD6jqS45RT5CUFZWAtqmY=;
 b=AkLpzzeckgnRiXkdLDjxYjL6maLIuQBXo8f4iIcSQhsOxqiJAnamm0eSYFSSh6aDAasv
 LnQBp0I939O6ppJw5xRSg5blAzV+Hfm7gcwqWd3m+3FJI54nfawTrf30grqpYeg1ylwu
 NJlMiFtSrMjcun0w3nEiEj10O+agkjaYsFICk7NxGKMhFCnvPLmrLZk1FihlBW96v98L
 L1I5aSyNvOdJO3XcVyyCdpwV6I0Yv3lZ8DaXUWO8Jh40fv3LUcSNd8fjq4AXXQI5tmi0
 Z6v9/dAjKK4IIJ3us5WOw976ifRH66He0VFDUcBPE0708aqU+Kxc/S7UyXpUfHg5veW9 jw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqutcgakf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 20:12:08 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DBAshY012366;
        Mon, 13 Feb 2023 20:12:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3np2n6j9tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 20:12:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DKC3Qr23134792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 20:12:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06DEC20049;
        Mon, 13 Feb 2023 20:12:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 745BB20040;
        Mon, 13 Feb 2023 20:12:01 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.20.198])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 20:12:01 +0000 (GMT)
Date:   Tue, 14 Feb 2023 01:41:58 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/21] ext4: remove comment code
 ext4_discard_preallocations
Message-ID: <Y+qZjiaXqSndFJpl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-21-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-21-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 44gEd3R8mJFbgfE-OhHAN9ovQLpYueMV
X-Proofpoint-GUID: 44gEd3R8mJFbgfE-OhHAN9ovQLpYueMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=782
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:24AM +0800, Kemeng Shi wrote:
> Just remove comment code in ext4_discard_preallocations.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index dec716f331ac..5bc30cd5debf 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4925,7 +4925,6 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  	int err;
>  
>  	if (!S_ISREG(inode->i_mode)) {
> -		/*BUG_ON(!list_empty(&ei->i_prealloc_list));*/
>  		return;
>  	}
>  
> -- 
> 2.30.0
> 
Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 

