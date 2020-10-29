Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8EF29F0C3
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgJ2QJD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 12:09:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgJ2QJD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 29 Oct 2020 12:09:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09TG2mxI069176;
        Thu, 29 Oct 2020 12:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fd2bK6kwpd1iIHb5OaJq2cGqkcTRhpfKXsKW4sN3csM=;
 b=eZw3Us42dPZmnIvgkkAU7BEOTwpC++9KserMLYMBLTvsVn7e4AIXYIBot7fCSuh9NB7j
 nEZB1hkOsLaTipAHL5eyMZpXjqCFXCcWCNm3WzSFCNQDl1SZ/icTHGxsbX53HOnjjz72
 +xj6+GeGBv6lXLcg4VN2f81K1tuj3rRiqFuuISvlsPLAow5g8BlFoTWYn9cRsPthe8Z/
 NB6yl0sWeIKMg+JXQbdmRQ3ZgiTkYlE5Q07pzW0UvOVXgFqIvCOgp8sHQWW3asbUDwt0
 jOcZPM1hybmGkNC7gXQ9fJu5Rl/Ne9yykzBUsBFrccU2nlUSsEvtjJMkAHU/APsG6FMR /Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34fyn4b3ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 12:08:41 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09TG7lWk001140;
        Thu, 29 Oct 2020 16:08:39 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 34fv15r4w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 16:08:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09TG8aKl23331238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 16:08:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5303A4060;
        Thu, 29 Oct 2020 16:08:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E5BDA4054;
        Thu, 29 Oct 2020 16:08:35 +0000 (GMT)
Received: from [9.199.33.247] (unknown [9.199.33.247])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Oct 2020 16:08:35 +0000 (GMT)
Subject: Re: [PATCH] ext4: do not use extent after put_bh
To:     yangerkun <yangerkun@huawei.com>, adilger@dilger.ca
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org
References: <20201028055617.2569255-1-yangerkun@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <93d5b1bf-0cf9-a483-ff5d-40a6a9c4b92b@linux.ibm.com>
Date:   Thu, 29 Oct 2020 21:38:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201028055617.2569255-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_08:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 malwarescore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011 mlxlogscore=957
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290111
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/28/20 11:26 AM, yangerkun wrote:
> ext4_ext_search_right will read more extent block and call put_bh after
> we get the information we need. However ret_ex will break this and may
> cause use-after-free once pagecache has been freed. Fix it by dup the
> extent we need.


It would be good if we have a test case to reproduce it. Do you?
Ideally it should go in fstests, if you have some way to forcefully
reproduce it/simulate it. Let me know, if needed, I can as well help to
get those into fstests.

-ritesh
