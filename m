Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C52660CD
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 15:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIKNxV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 09:53:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgIKNVb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 11 Sep 2020 09:21:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BDDsLB057570;
        Fri, 11 Sep 2020 09:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7OGlk+3ozQ/F2RrURZxi1DsjzY/cMXGxo1nr6EuBBw4=;
 b=OTp6hEDTR5EbxW8PKFE5cd1+pU5wpTmscSJMqJqCn0hdmRa0PzsPcrees9anTqLzGq+s
 y2mlxRB9xFIqp3AOSX+5t2Xiv+RLDEJKq/OHI/S6s5+i/jkla22yPKvZZIPGHBKQ9xcJ
 oM4MsjZBBbtKpqo+2wQge3dy+4Hb0T/cVk+4RAVuF8fii4E9doYYYMGUnSAr1BUnj41z
 KhRWylnQOrsgQ1Oalg73kW3WkjBg5/fkuW23cT8nqrM65hV6qNjDtydG+5PGzR0PWIDh
 Quxz69dcmZFJHZO9xbMCmVBVPPiEE1MchMw7uR2hD7y6tFRNs/ZoHKkfAE8fSdjeEPpG QA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33g9ntrwwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 09:20:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BDCVke007887;
        Fri, 11 Sep 2020 13:20:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 33c2a821vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 13:20:27 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BDKOKd29884712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 13:20:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA01652052;
        Fri, 11 Sep 2020 13:20:23 +0000 (GMT)
Received: from [9.199.34.21] (unknown [9.199.34.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C0F6A52075;
        Fri, 11 Sep 2020 13:20:22 +0000 (GMT)
Subject: Re: [PATCH v3] ext4: Fix dead loop in ext4_mb_new_blocks
To:     Ye Bin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org
References: <20200910091252.525346-1-yebin10@huawei.com>
 <20200910161753.GB17362@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <0e48b9bb-f839-4b3b-dbce-45755618df97@linux.ibm.com>
Date:   Fri, 11 Sep 2020 18:50:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910161753.GB17362@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_04:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 suspectscore=2 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110102
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ye,

Please excuse if there is something horribly wrong with my email
formatting. Have yesterday received this laptop and still setting up
few things.

On 9/10/20 9:47 PM, Jan Kara wrote:
> On Thu 10-09-20 17:12:52, Ye Bin wrote:
>> As we test disk offline/online with running fsstress, we find fsstress
>> process is keeping running state.
>> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
>> ....
>> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
>>
>> ext4_mb_new_blocks
>> repeat:
>> 	ext4_mb_discard_preallocations_should_retry(sb, ac, &seq)
>> 		freed = ext4_mb_discard_preallocations
>> 			ext4_mb_discard_group_preallocations
>> 				this_cpu_inc(discard_pa_seq);
>> 		---> freed == 0
>> 		seq_retry = ext4_get_discard_pa_seq_sum
>> 			for_each_possible_cpu(__cpu)
>> 				__seq += per_cpu(discard_pa_seq, __cpu);
>> 		if (seq_retry != *seq) {
>> 			*seq = seq_retry;
>> 			ret = true;
>> 		}
>>
>> As we see seq_retry is sum of discard_pa_seq every cpu, if
>> ext4_mb_discard_group_preallocations return zero discard_pa_seq in this
>> cpu maybe increase one, so condition "seq_retry != *seq" have always
>> been met.
>> To Fix this problem, in ext4_mb_discard_group_preallocations function increase
>> discard_pa_seq only when it found preallocation to discard.
>>
>> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> 
> Thanks for the patch. One comment below.
> 
>> ---
>>   fs/ext4/mballoc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index f386fe62727d..fd55264dc3fe 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4191,7 +4191,6 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>>   	INIT_LIST_HEAD(&list);
>>   repeat:
>>   	ext4_lock_group(sb, group);
>> -	this_cpu_inc(discard_pa_seq);
>>   	list_for_each_entry_safe(pa, tmp,
>>   				&grp->bb_prealloc_list, pa_group_list) {
>>   		spin_lock(&pa->pa_lock);
>> @@ -4233,6 +4232,9 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>>   		goto out;
>>   	}
>>   
>> +	/* only increase when find reallocation to discard */
>> +	this_cpu_inc(discard_pa_seq);
>> +
> 
> This is a good place to increment the counter but I think you also need to
> handle the case:
> 
>          if (free < needed && busy) {
>                  busy = 0;
>                  ext4_unlock_group(sb, group);
>                  cond_resched();
>                  goto repeat;
>          }
> 
> We can unlock the group here after removing some preallocations and thus
> other processes checking discard_pa_seq could miss we did this. In fact I
> think the code is somewhat buggy here and we should also discard extents
> accumulated on "list" so far before unlocking the group. Ritesh?
> 

mmm, so even though this code is not discarding those buffers b4
unlocking, but it has still removed those from the grp->bb_prealloc_list
and added it to the local list. And since it will at some point get
scheduled and start operating from repeat: label so functionally wise
this should be ok. Am I missing anything?

Although I agree, that if we remove at least the current pa's before
unlocking the group may be a good idea, but we should also check
why was this done like this at the first place.


I agree with Jan, that we should increment discard_pa_seq once we 
actually have something
to discard. I should have written a comment here to explain why we did 
this here.
But I think commit msg should have all the history (since I have a habit 
of writing long commit msgs ;)

But IIRC, it was done since in case if there is a parallel thread which 
is discarding
all the preallocations so the current thread may return 0 since it 
checks the
list_empty(&grp->bb_prealloc_list) check in 
ext4_mb_discard_group_preallocations() and returns 0 directly.

And why the discard_pa_seq counter at other places may not help since we 
remove the pa nodes from
grp->bb_prealloc_list into a local list and then start operating on
that. So meanwhile some thread may comes and just checks that the list
is empty and return 0 while some other thread may start discarding from
it's local list.
So I guess the main problem was that in the current code we remove
the pa from grp->bb_prealloc_list and add it to local list. So if 
someone else comes
and checks that grp->bb_prealloc_list is empty then it will directly 
return 0.

So, maybe we could do something like this then?

repeat:
	ext4_lock_group(sb, group);
-	this_cpu_inc(discard_pa_seq);
list_for_each_entry_safe(pa, tmp,
				&grp->bb_prealloc_list, pa_group_list) {<...>

+		if (!free)
+			this_cpu_inc(discard_pa_seq);   // we should do this here before 
calling list_del(&pa->pa_group_list);

		/* we can trust pa_free ... */
		free += pa->pa_free;
		spin_unlock(&pa->pa_lock);

		list_del(&pa->pa_group_list);
		list_add(&pa->u.pa_tmp_list, &list);
	}

I have some test cases around this to test for cases which were
failing. Since in world of parallelism you can't be 100% certain of some
corner case (like this one you just reported).
But, I don't have my other box rite now where I kept all of those -
due to some technical issues. I think I should be able to get those by
next week, if not, I anyways will setup my current machine for testing
this.

-ritesh
