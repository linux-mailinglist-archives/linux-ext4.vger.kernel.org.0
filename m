Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74992DBA90
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLPFYg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:24:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgLPFYg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 00:24:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BG52HY3167692;
        Wed, 16 Dec 2020 00:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TGt1inerCKl0DQCqgMHqaOfyYd2g7Xwtx0jvCQPM65M=;
 b=V2wHU8zdSUF/NN5cHLDjjwYJoRkgcDRf6lStzP+1YVeTHozorlAhFxk1dZOsCUSneOa1
 vapnBagcyvdhCTfsZQPboc1ei553kl6WfOB+bo3aKdgp/Wim57oPhm/1yXquTpOzCqSm
 ovdInKww0gElscJ5VTQbiGkcDaCGgFkZwNtUFN6KE7Kotmkd8PRV1Xe3Sfa/geeB+7UX
 ROv/itl4q0WZglz76uwBsnN0zEhLLFnVN2DI5RVSjrXqwLdtyWjiIZQtSWuAedp3LBrF
 bQByicwgNbjTihYK6M3CSFkihlx+EsmbkitfzVEihMni+T0AqLRW9cVm1B/aji4rDGLQ jg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35fasehqgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:23:52 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BG5MeNw014533;
        Wed, 16 Dec 2020 05:23:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 35cng83xfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 05:23:50 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BG5NmC87405900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 05:23:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE9B4C050;
        Wed, 16 Dec 2020 05:23:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D5F4C058;
        Wed, 16 Dec 2020 05:23:46 +0000 (GMT)
Received: from [9.199.42.232] (unknown [9.199.42.232])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Dec 2020 05:23:46 +0000 (GMT)
Subject: Re: [PATCHv2 1/2] common/rc: Add whitelisted FS support in
 _require_scratch_swapfile()
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        anju@linux.vnet.ibm.com
References: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <3bd1f738-93b7-038d-6db9-7bf6a330b1ea@linux.ibm.com>
Date:   Wed, 16 Dec 2020 10:53:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_01:2020-12-15,2020-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160028
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 12/16/20 10:47 AM, Ritesh Harjani wrote:
> Filesystems e.g. ext4 and XFS supports swapon by default and an error
> returned with swapon should be treated as a failure. Hence
> add ext4/xfs as whitelisted fstype in _require_scratch_swapfile()
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> v1->v2: Addressed comments from Eryu @[1]
> [1]: https://patchwork.kernel.org/project/fstests/cover/cover.1604000570.git.riteshh@linux.ibm.com/
> 
>   common/rc | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 33b5b598a198..635b77a005c6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2380,6 +2380,7 @@ _format_swapfile() {
>   # Check that the filesystem supports swapfiles
>   _require_scratch_swapfile()
>   {
> +	local fstyp=$FSTYP
>   	_require_scratch
>   	_require_command "$MKSWAP_PROG" "mkswap"
> 
> @@ -2401,10 +2402,21 @@ _require_scratch_swapfile()
>   	# Minimum size for mkswap is 10 pages
>   	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> 
> -	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> -		_scratch_unmount
> -		_notrun "swapfiles are not supported"
> -	fi
> +	# For whitelisted fstyp swapon should not fail.
> +	case "$fstyp" in
> +	ext4|xfs)
> +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +			_scratch_unmount
> +			_fail "swapon failed for $fstyp"

@Eryu,
As of now I added _fail() if swapon failed for given whitelisting fstype.
Do you think this is alright, or should I just ignore the error in
case of such FS?



> +		fi
> +		;;
> +	*)
> +		if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
> +			_scratch_unmount
> +			_notrun "swapfiles are not supported"
> +		fi
> +		;;
> +	esac
> 
>   	swapoff "$SCRATCH_MNT/swap" >/dev/null 2>&1
>   	_scratch_unmount
> --
> 2.26.2
> 
