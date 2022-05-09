Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A53151F482
	for <lists+linux-ext4@lfdr.de>; Mon,  9 May 2022 08:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiEIGbN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 May 2022 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiEIG16 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 May 2022 02:27:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2FC17EC2A;
        Sun,  8 May 2022 23:24:05 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24913ULR023542;
        Mon, 9 May 2022 06:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EUzciikRinO769+UPV9+5CaGF8IJ3vz6NtwLfqJarCs=;
 b=R0lntO0fsG6s5mi6rKgJO2Hnd9PMz1IPd57GnsFqu1uY8qDN8qHbvVomKp12dttiMA/q
 +UfgnDND4Xw8REPSsc0jQeBswH5LiIgPZSJ+j6KycC0T5N7tkfQUfImu8vm+9Tf/TTOw
 5N4plEZQRM9pdi9tk4wV78kyR7BgYvVPSdeZEHLMKOXExVBSWd8UV7fUSgeelByXHBmc
 T5Q8LKJcXc7DMmWTW9rFC1ksNECrU8WExj34a1XYmMnKrGDEq7xDqfVhINT9XSSaFvr4
 NPsWPrLy388G/zYNMYjWd6p8MOqbjbseSDAlcOhsD82QE+JNWwpiImqSijHcDghAARZ2 WA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fx256b9sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 06:22:57 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2496021N004374;
        Mon, 9 May 2022 06:22:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3fwg1hsjf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 06:22:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2496Mm3x52625870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 May 2022 06:22:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14D4C4203F;
        Mon,  9 May 2022 06:22:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1657142041;
        Mon,  9 May 2022 06:22:46 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.35.189])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  9 May 2022 06:22:45 +0000 (GMT)
Date:   Mon, 9 May 2022 11:52:42 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     riteshh@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <YnizMg+ALwVJYNLS@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220401055713.634842-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401055713.634842-1-ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wYsTgguTGl8YPMEWgt8VXt3DtmAafGiO
X-Proofpoint-ORIG-GUID: wYsTgguTGl8YPMEWgt8VXt3DtmAafGiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_01,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0 mlxlogscore=490
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Greetings,

Please do let me know if there are any reviews or comments on this patch.

Thank you,
Ojaswin

On Fri, Apr 01, 2022 at 11:27:13AM +0530, Ojaswin Mujoo wrote:
> A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> have a discard granularity as big as 42MB which makes it larger
> than the group size of ext4 FS with 1k BS. This causes the FITRIM
> IOCTL to fail on filesystems like ext4.
> 
> This case was not correctly handle by "_require_batched_discard" as
> it incorrectly interpreted the FITRIM failure as fs not supporting
> the IOCTL. This caused the tests like generic/260 to incorectly
> report "not run" instead of "failed" in case of large discard
> granularity.
> 
> Fix "_require_batched_discard" to use a more accurate method
> to determine if discard is supported.
> 
> [1] commit 173b6e383d2
>     ext4: avoid trim error on fs with small groups
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index e2d3d72a..97386342 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3858,7 +3858,13 @@ _require_batched_discard()
>  		exit 1
>  	fi
>  	_require_fstrim
> -	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
> +
> +	$FSTRIM_PROG $1 2>&1 | grep -q "not supported"
> +	RET=$?
> +	if [ "$RET" = "0" ]
> +	then
> +		_notrun "FITRIM not supported on $1"
> +	fi
>  }
>  
>  _require_dumpe2fs()
> -- 
> 2.27.0
> 
