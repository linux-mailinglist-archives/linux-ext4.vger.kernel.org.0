Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3978E2EA95B
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Jan 2021 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbhAELCF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 06:02:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11240 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbhAELCD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 06:02:03 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 105AVu1N038618;
        Tue, 5 Jan 2021 06:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p15zEV4D+9XYfzCqfaNsH+8wxq6VnaBwWqF0rU+ciI4=;
 b=XbNtsGo8Kv4SQzajQLMR7i094c9kAgLbaCReqWihrI44V7OG/ubRO9wjyvmK8gN3fkek
 SbU4IvwekjZg2g0sXhkegLRMdNfGtp/KedcyJNIrWjHnkuHXmaFlKk5DKdIws8gA0+dX
 U6zfb60ZOBOJ/zJQ7lxkV3ffkNfjaFZGI+dBmaGMDnlS7MU8eQQyLAD+GGzHENPgp6FX
 LTB8V5fw/JnpY2ybUKUeDC8DHBmkT00KVkEah5NolfV7/5P/tUHIzpiomH1cSULK8kO/
 nTlvOHk3+2cCDerfaQGVxNqcBpvXXc6ZkRIAony8DoHeF/I0uyOfIONWV0HiG1S/RhG7 kQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35vp6s9324-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 06:01:16 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 105AwRLF003340;
        Tue, 5 Jan 2021 11:00:31 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 35tgf8assu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 11:00:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 105B0TvI48759162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 11:00:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B5B7A4066;
        Tue,  5 Jan 2021 11:00:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE854A407A;
        Tue,  5 Jan 2021 11:00:27 +0000 (GMT)
Received: from [9.199.32.130] (unknown [9.199.32.130])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jan 2021 11:00:27 +0000 (GMT)
Subject: Re: [PATCHv2 1/2] common/rc: Add whitelisted FS support in
 _require_scratch_swapfile()
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, anju@linux.vnet.ibm.com
References: <f161a49e6e3476d83c35b8e6a111644110ec4c8c.1608094988.git.riteshh@linux.ibm.com>
 <3bd1f738-93b7-038d-6db9-7bf6a330b1ea@linux.ibm.com>
 <20201220153906.GC3853@desktop> <20210104182545.GF6908@magnolia>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <24b16894-0ab5-b769-d05e-e55fa334706e@linux.ibm.com>
Date:   Tue, 5 Jan 2021 16:30:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210104182545.GF6908@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050061
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 1/4/21 11:55 PM, Darrick J. Wong wrote:
> On Sun, Dec 20, 2020 at 11:39:06PM +0800, Eryu Guan wrote:
>> On Wed, Dec 16, 2020 at 10:53:45AM +0530, Ritesh Harjani wrote:
>>>
>>>
>>> On 12/16/20 10:47 AM, Ritesh Harjani wrote:
>>>> Filesystems e.g. ext4 and XFS supports swapon by default and an error
>>>> returned with swapon should be treated as a failure. Hence
>>>> add ext4/xfs as whitelisted fstype in _require_scratch_swapfile()
>>>>
>>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>>> ---
>>>> v1->v2: Addressed comments from Eryu @[1]
>>>> [1]: https://patchwork.kernel.org/project/fstests/cover/cover.1604000570.git.riteshh@linux.ibm.com/
>>>>
>>>>    common/rc | 20 ++++++++++++++++----
>>>>    1 file changed, 16 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/common/rc b/common/rc
>>>> index 33b5b598a198..635b77a005c6 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -2380,6 +2380,7 @@ _format_swapfile() {
>>>>    # Check that the filesystem supports swapfiles
>>>>    _require_scratch_swapfile()
>>>>    {
>>>> +	local fstyp=$FSTYP
>>>>    	_require_scratch
>>>>    	_require_command "$MKSWAP_PROG" "mkswap"
>>>>
>>>> @@ -2401,10 +2402,21 @@ _require_scratch_swapfile()
>>>>    	# Minimum size for mkswap is 10 pages
>>>>    	_format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
>>>>
>>>> -	if ! swapon "$SCRATCH_MNT/swap" >/dev/null 2>&1; then
>>>> -		_scratch_unmount
>>>> -		_notrun "swapfiles are not supported"
>>>> -	fi
>>>> +	# For whitelisted fstyp swapon should not fail.
> 
> I would use a different phase than 'whitelisted', since that doesn't
> tell us why ext4 and xfs are special:
> 
> # ext* and xfs have supported all variants of swap files since their
> # introduction, so swapon should not fail.

Sounds ok to me.


> 
>>>> +	case "$fstyp" in
> 
> $FSTYP, not $fstyp

sure I will use $FSTYP directly and remove local fstyp variable.

> 
>>>> +	ext4|xfs)
> 
> I would also add a few more FSTYPs here, since at least ext2 and ext3
> supported swap files.  Are there other old fses that do?

Sure, agreed. I will add ext2 & ext3 too.

-ritesh
