Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB1E29E272
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 03:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404360AbgJ2COe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 22:14:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726775AbgJ1Vfj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09SH6nXn028543;
        Wed, 28 Oct 2020 13:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QDGgvWxLF+me3qyIss5Dm7I984aY7/ySB19FztNeyf8=;
 b=P7N7qMoP9A5iC37fpbevKSKWxnRtKJCLKFPvicvLPmIKbvmlfEhyC6+LsavHWWjiiCMf
 NjgXQRVbKombAaGaJ1LqJZy7Vh7KrrY5DfRr4S/yJb8JZiVz5bmJs02Mwsu5U4QVjUF8
 coXztu0j+40DJlavV7OwjJs/OKJ0+3T746oj0mizNyo/PLK+EL3HOFiqysHNd67p+oUq
 sSagGxwqdvGEmjz4kwyAdCHFx7Rh5BANeT2s7mNkU1zSv1jliZ2eomjU5y9CBqQ7Zj5I
 PsrtTOmCDUHXBpXqmvVg9X96nFX4Y77KeWawtHA/juuEs+MLUFSg3UWjO4+MMVFGcms+ uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ew3jj8gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 13:26:43 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09SH73vk029774;
        Wed, 28 Oct 2020 13:26:42 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ew3jj8fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 13:26:42 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09SH3Isb029362;
        Wed, 28 Oct 2020 17:26:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34cbhh4r7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 17:26:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09SHQ6nZ37618048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 17:26:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8880CA4051;
        Wed, 28 Oct 2020 17:26:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 327F7A4040;
        Wed, 28 Oct 2020 17:26:05 +0000 (GMT)
Received: from [9.199.33.247] (unknown [9.199.33.247])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 17:26:04 +0000 (GMT)
Subject: Re: [PATCH] ext4: properly check for dirty state in
 ext4_inode_datasync_dirty()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20201024140115.GA35973@xps-13-7390>
 <CAD+ocby3hA0GCm5Rf6T3UF+2UWgWoUjrz7=VzbeUMjX6Qx8D5g@mail.gmail.com>
 <da6697a0-4a23-ee68-fa2e-121b3d23c972@linux.ibm.com>
 <20201028152930.GQ5691@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <0a81bf78-1ccc-d10a-67f0-f6d24119408c@linux.ibm.com>
Date:   Wed, 28 Oct 2020 22:56:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201028152930.GQ5691@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_08:2020-10-28,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280110
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/28/20 8:59 PM, Theodore Y. Ts'o wrote:
> On Wed, Oct 28, 2020 at 08:57:03AM +0530, Ritesh Harjani wrote:
>>
>> Well, I too noticed this yesterday while I was testing xfstests -g swap.
>> Those tests were returning _notrun, hence that could be the reason why
>> it didn't get notice in XFSTESTing from Ted.
> 
> Yeah, one of the things I discussed with Harshad is we really need a
> test that looks like generic/472, but which is in shared/NNN, and
> which unconditionally tries to use swapon for those file systems where
> swapfiles are expected to work.  This is actually the second
> regression caused by our breaking swapfile support (the other being
> the iomap bmap change), which escaped our testing because we didn't
> notice that generic/472 was skipped.

Yes, agreed this is second in a row.
So with fast-commit, swap tests returned _not_run, since
swapon syscall returned -EINVAL in _require_scratch_swapfile() itself.
This is due to some old commit in fstests to make swap tests work on
btrfs on both kernels (with and w/o support of swapon in btrfs), it
first checks in _require_scratch_swapfile() to see if swapon even works
or not. Hence it skips to run further if _require_scratch_swapfile()
fails.

Secondly with bmap to iomap interface, I guess it should pass
all tests except for case with fallocate files, which I think is
tests/generic/496. But here too it assumes that if 1st time it fails
with falloc then swapon may not be supported for that fs and hence does
_notrun.

I am actually working on this to make these swap tests return some
definitive pass or failure status. Will be sending some patches soon.
I could use your idea to add a test in shared/NNN for testing swap with
fallocate files for ext4 and xfs (for bmap to iomap ext4 regression
category of tests)

Thanks
-ritesh

