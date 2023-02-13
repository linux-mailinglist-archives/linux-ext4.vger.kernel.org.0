Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B986693EBF
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Feb 2023 08:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBMHJr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Feb 2023 02:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMHJq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Feb 2023 02:09:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00FC14F;
        Sun, 12 Feb 2023 23:09:44 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D4fcJM024221;
        Mon, 13 Feb 2023 07:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=1eBIzZVn5iybuavms+0+EaxEjm8yuEofJZPc4ioeerU=;
 b=LJJx2sCxeagG52G7zQVYecyKzGo1+b5w4h5Q2s1PI/FDYGkxJ7m8ajmikVgs+S5gUiam
 ZUKsm3Enr/e3uO58JRd5GFDYFrEL59B3Co4EZ3RFh34K9o+dw2fSgh63ctsJNzXFI3JD
 pVA4KBkBxgfD+3+LTsPGZNz1egObEe2VXoZtfFZFdXQUqoDMTrHt77+/vmKP1cVrPxUo
 jy2z1/l2Y/ZxUrKulHcR5aBC80p0YfLk8fjgrGTV6tatouJFdniEVOd0PwJLpr8joupV
 HunBako2WVDyAkinysFXf5sIgUxYg/5cGiS9P0uGXWpAax63Tuk5z7Z7WeF+Pg4JWUk2 jw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nq4xpu2t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:09:36 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31CFF7qM031293;
        Mon, 13 Feb 2023 07:09:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3np29f9pyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 07:09:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31D79Vof52691362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 07:09:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E6192004D;
        Mon, 13 Feb 2023 07:09:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 965A320049;
        Mon, 13 Feb 2023 07:09:29 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Feb 2023 07:09:29 +0000 (GMT)
Date:   Mon, 13 Feb 2023 12:39:27 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/21] ext4: correct start of used group pa for debug in
 ext4_mb_use_group_pa
Message-ID: <Y+niJypq6HNi2Jem@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
 <20230209194825.511043-7-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209194825.511043-7-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TIzD-fIHbtqDsZQ8WRef6UW-GywH2mCv
X-Proofpoint-GUID: TIzD-fIHbtqDsZQ8WRef6UW-GywH2mCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=966 impostorscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 10, 2023 at 03:48:10AM +0800, Kemeng Shi wrote:
> As we don't correct pa_lstart here, so there is no need to subtract
> pa_lstart with consumed len.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 2bffc93778d5..433337ac8da2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4319,7 +4319,7 @@ static void ext4_mb_use_group_pa(struct ext4_allocation_context *ac,
>  	 * Other CPUs are prevented from allocating from this pa by lg_mutex
>  	 */
>  	mb_debug(ac->ac_sb, "use %u/%u from group pa %p\n",
> -		 pa->pa_lstart-len, len, pa);
> +		 pa->pa_lstart, len, pa);
>  }
>  
>  /*
> -- 
> 2.30.0
> 
Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com> 

