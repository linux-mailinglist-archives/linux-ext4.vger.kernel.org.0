Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976D529D39E
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 22:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgJ1Vpe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:45:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbgJ1Vny (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S331XB143515;
        Tue, 27 Oct 2020 23:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RGq50YJra8Pb7fSvcsNloSoc07LWHTFNTt54VxHxUL8=;
 b=Be9YRtFkvCQdd6oINp8zRwRqyP4UkMearsBsw79J1iL782479TA5mafAq7ZwHqDCm2z7
 Pozml2LsV4+759qe3ssIsK7vOGA04TVNdKrDkPqRFm/URQX5LVUlbxANWawQTtj3HkKz
 Hy4pZWUlOXei4ufK4DCoDBeAtAhUhASA/a7k1IMwrrWrQ0QNovNpW+QJpc8uWP9uyOwD
 0A8FX2ScZTjYZ0/+4ccGlMh8Nrr+7rvHWFpPMREmtvbV231LMCrMzTZkDdLQF/KAZj1b
 0fL09tH82lloHOYUlJw9c07lo36SGKjzvmuLVobiRh6bMhLyyh/M5MWqLSCisSVYnG97 yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ec5uprfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 23:27:10 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09S347X2146835;
        Tue, 27 Oct 2020 23:27:09 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34ec5uprf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 23:27:09 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09S3NI7Y014988;
        Wed, 28 Oct 2020 03:27:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 34cbw8232j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 03:27:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09S3R5sl31981902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 03:27:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D73A4051;
        Wed, 28 Oct 2020 03:27:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49482A4055;
        Wed, 28 Oct 2020 03:27:04 +0000 (GMT)
Received: from [9.199.33.247] (unknown [9.199.33.247])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 03:27:04 +0000 (GMT)
Subject: Re: [PATCH] ext4: properly check for dirty state in
 ext4_inode_datasync_dirty()
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20201024140115.GA35973@xps-13-7390>
 <CAD+ocby3hA0GCm5Rf6T3UF+2UWgWoUjrz7=VzbeUMjX6Qx8D5g@mail.gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <da6697a0-4a23-ee68-fa2e-121b3d23c972@linux.ibm.com>
Date:   Wed, 28 Oct 2020 08:57:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAD+ocby3hA0GCm5Rf6T3UF+2UWgWoUjrz7=VzbeUMjX6Qx8D5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-27_17:2020-10-26,2020-10-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010280014
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 10/27/20 3:58 AM, harshad shirwadkar wrote:
> Thanks Andrea for catching and sending out a fix for this.
> 
> On Sat, Oct 24, 2020 at 7:01 AM Andrea Righi <andrea.righi@canonical.com> wrote:
>>
>> ext4_inode_datasync_dirty() needs to return 'true' if the inode is
>> dirty, 'false' otherwise, but the logic seems to be incorrectly changed
>> by commit aa75f4d3daae ("ext4: main fast-commit commit path").
>>
>> This introduces a problem with swap files that are always failing to be
>> activated, showing this error in dmesg:
>>
>>   [   34.406479] swapon: file is not committed
>>

Well, I too noticed this yesterday while I was testing xfstests -g swap.
Those tests were returning _notrun, hence that could be the reason why
it didn't get notice in XFSTESTing from Ted.

- I did notice that this code was introduced in v10 only.
This wasn't there in v9 though.


>> Simple test case to reproduce the problem:
>>
>>    # fallocate -l 8G swapfile
>>    # chmod 0600 swapfile
>>    # mkswap swapfile
>>    # swapon swapfile
>>
>> Fix the logic to return the proper state of the inode.
>>
>> Link: https://lore.kernel.org/lkml/20201024131333.GA32124@xps-13-7390
>> Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
>> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
>> ---
>>   fs/ext4/inode.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 03c2253005f0..a890a17ab7e1 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3308,8 +3308,8 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>>          if (journal) {
>>                  if (jbd2_transaction_committed(journal,
>>                                          EXT4_I(inode)->i_datasync_tid))
>> -                       return true;
>> -               return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) >=
>> +                       return false;
>> +               return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
>>                          EXT4_I(inode)->i_fc_committed_subtid;
> In addition, the above condition should only be checked if fast
> commits are enabled. So, in effect this overall condition will look
> like this:
> 
> if (journal) {
>      if (jbd2_transaction_committed(journal, EXT4_I(inode)->i_datasync_tid))
>          return false;
>      if (test_opt2(sb, JOURNAL_FAST_COMMIT))
>          return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
> EXT4_I(inode)->i_fc_committed_subtid;
>      return true;
> }

Yup - I too had made a similar patch. But then I also noticed that below
condition will always remain false. Since we never update
"i_fc_committed_subtid" other than at these 2 places
(one during init where we set it to 0 and other during ext4_fc_commit()
where we set it to sbi->s_fc_subtid).

<condition>
atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid < 
EXT4_I(inode)->i_fc_committed_subtid


Maybe I need more reading around this.

-ritesh





> 
> Thanks,
> Harshad
> 
>>          }
>>
>> --
>> 2.27.0
>>
