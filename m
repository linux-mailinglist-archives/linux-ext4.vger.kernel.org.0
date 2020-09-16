Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0926CC90
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 22:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgIPUqF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 16:46:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbgIPRC2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 13:02:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GA24os009224;
        Wed, 16 Sep 2020 06:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W0O2aplnoHVK1yZFpboH+BO3XJLzTZnwg4iiqVkRHBM=;
 b=qVmGGrZGFT0IIgP6t7m5EHtBTA/R1An4ap15O/tg4U4LumD5bHMumN3Qu3XdeEAou3N9
 z0y+XOS2mOnwCtbTrTV+aroKVYHZgP7uGTzTjzaFX8IdFcFlnXtO3mfBPBdlEPqVehFM
 IUEZPegHZsS43KuV8DaZMbhJWTkoKECh31ZibJZvihqkaTaKkYCtCaNBPHKdSS+DP3ZT
 0gwRd50kmBSUKan5LKTATGWyOEsbWtxUsws6M6xbaaJliTMGJ/pt4uxjB1yXWcVRU+jG
 PEJ+fo2N/qPJb7geaKEUC4a7nQS0LipFgq0uLvdmSkgTE1NxI02msyy/QBziZRcw+Dgc Qw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33kfv61tmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 06:16:09 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GA6Po3003785;
        Wed, 16 Sep 2020 10:16:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 33k6esggu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 10:16:06 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08GAEUJ621168536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 10:14:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 944B5A4053;
        Wed, 16 Sep 2020 10:16:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 894E9A4040;
        Wed, 16 Sep 2020 10:16:03 +0000 (GMT)
Received: from [9.199.44.76] (unknown [9.199.44.76])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Sep 2020 10:16:03 +0000 (GMT)
Subject: Re: [PATCH v4] ext4: Fix dead loop in ext4_mb_new_blocks
To:     Ye Bin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org
References: <20200914104742.1745082-1-yebin10@huawei.com>
 <20200915121122.GN4863@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <397db70a-8592-2a7a-1b77-303925491bf2@linux.ibm.com>
Date:   Wed, 16 Sep 2020 15:46:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915121122.GN4863@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_02:2020-09-15,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=2
 clxscore=1015 mlxscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=717
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160070
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 9/15/20 5:41 PM, Jan Kara wrote:
> On Mon 14-09-20 18:47:42, Ye Bin wrote:
>> As we test disk offline/online with running fsstress, we find fsstress
>> process is keeping running state.
>> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
>> ....
>> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
>>
>> ext4_mb_new_blocks
>> repeat:
>>          ext4_mb_discard_preallocations_should_retry(sb, ac, &seq)
>>                  freed = ext4_mb_discard_preallocations
>>                          ext4_mb_discard_group_preallocations
>>                                  this_cpu_inc(discard_pa_seq);
>>                  ---> freed == 0
>>                  seq_retry = ext4_get_discard_pa_seq_sum
>>                          for_each_possible_cpu(__cpu)
>>                                  __seq += per_cpu(discard_pa_seq, __cpu);
>>                  if (seq_retry != *seq) {
>>                          *seq = seq_retry;
>>                          ret = true;
>>                  }
>>
>> As we see seq_retry is sum of discard_pa_seq every cpu, if
>> ext4_mb_discard_group_preallocations return zero discard_pa_seq in this
>> cpu maybe increase one, so condition "seq_retry != *seq" have always
>> been met.
>> Ritesh Harjani suggest to in ext4_mb_discard_group_preallocations function we
>> only increase discard_pa_seq when there is some PA to free.

@yebin,
Did you confirm by running your test case that this patch indeed fixes 
your reported issue.
With that confirmed, the patch does looks good to me. Feel free to add.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

>>
>> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> But as I mentioned in my previous reply I also think the attached patch
> also needs to be merged to avoid premature ENOSPC errors (which your change
> makes somewhat more likely). Ritesh do you agree?


Yes, agree that Jan's attached patch should help to avoid premature
ENOSPC errors. We should have his patch too on top of current patch.

@yebin
Should we have a v5 of then, with both patches included for merging?
