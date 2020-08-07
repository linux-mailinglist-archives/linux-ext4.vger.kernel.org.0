Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927F223EA46
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHGJXV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 05:23:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29414 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgHGJXT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 05:23:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07794hFE059704;
        Fri, 7 Aug 2020 05:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=1g03ZrsAvU3imE8zwOJzFzX6Suq13FXKqdRyOgNIzuI=;
 b=FQ1PLt4hTiHEifRKRogJbBRU0tM++7lUxJhJhMy37d8wi5v2vJQGVWc5epptKaJAAKaf
 zFR0PfjkxG0sHFpDhgbLo8GzgHmBECLnvFRWLK8//U8yrG7a6DoXQ5ZPAwF+1oOusvtt
 oi/OfsdMBgiaWtTPFYvdjHE/5hfZmvZheldkYRajo0e+695gxhYSZBZK/4uf/T4xKGe6
 3kXAgbf80M0BB6pn0layHneR7SWuuW26yt6zZWMMtCpkpGhrfX6p2N6UJ+xtcagIzsAP
 6OTvE/hQNBGv8jQ2GvogUNB4RWAy189bTxa/wh5sxZdAu7aePV/hdXnbYelRSlY8DPB+ aA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rephmdet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 05:23:16 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0779F7Qc031564;
        Fri, 7 Aug 2020 09:23:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 32n018bykk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 09:23:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0779Lk4p61276644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Aug 2020 09:21:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C61464C04E;
        Fri,  7 Aug 2020 09:23:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3CF64C046;
        Fri,  7 Aug 2020 09:23:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.36.111])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Aug 2020 09:23:11 +0000 (GMT)
Subject: Re: [RFC 1/1] pmem: Add cond_resched() in bio_for_each_segment loop
 in pmem_make_request
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <0d96e2481f292de2cda8828b03d5121004308759.1596011292.git.riteshh@linux.ibm.com>
 <20200802230148.GA2114@dread.disaster.area>
 <20200803071405.64C0711C058@d06av25.portsmouth.uk.ibm.com>
 <20200803215144.GB2114@dread.disaster.area>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 7 Aug 2020 14:53:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200803215144.GB2114@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200807092311.B3CF64C046@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_05:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070064
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/4/20 3:21 AM, Dave Chinner wrote:
> On Mon, Aug 03, 2020 at 12:44:04PM +0530, Ritesh Harjani wrote:
>>
>>
>> On 8/3/20 4:31 AM, Dave Chinner wrote:
>>> On Wed, Jul 29, 2020 at 02:15:18PM +0530, Ritesh Harjani wrote:
>>>> For systems which do not have CONFIG_PREEMPT set and
>>>> if there is a heavy multi-threaded load/store operation happening
>>>> on pmem + sometimes along with device latencies, softlockup warnings like
>>>> this could trigger. This was seen on Power where pagesize is 64K.
>>>>
>>>> To avoid softlockup, this patch adds a cond_resched() in this path.
>>>>
>>>> <...>
>>>> watchdog: BUG: soft lockup - CPU#31 stuck for 22s!
>>>> <...>
>>>> CPU: 31 PID: 15627 <..> 5.3.18-20
>>>> <...>
>>>> NIP memcpy_power7+0x43c/0x7e0
>>>> LR memcpy_flushcache+0x28/0xa0
>>>>
>>>> Call Trace:
>>>> memcpy_power7+0x274/0x7e0 (unreliable)
>>>> memcpy_flushcache+0x28/0xa0
>>>> write_pmem+0xa0/0x100 [nd_pmem]
>>>> pmem_do_bvec+0x1f0/0x420 [nd_pmem]
>>>> pmem_make_request+0x14c/0x370 [nd_pmem]
>>>> generic_make_request+0x164/0x400
>>>> submit_bio+0x134/0x2e0
>>>> submit_bio_wait+0x70/0xc0
>>>> blkdev_issue_zeroout+0xf4/0x2a0
>>>> xfs_zero_extent+0x90/0xc0 [xfs]
>>>> xfs_bmapi_convert_unwritten+0x198/0x230 [xfs]
>>>> xfs_bmapi_write+0x284/0x630 [xfs]
>>>> xfs_iomap_write_direct+0x1f0/0x3e0 [xfs]
>>>> xfs_file_iomap_begin+0x344/0x690 [xfs]
>>>> dax_iomap_pmd_fault+0x488/0xc10
>>>> __xfs_filemap_fault+0x26c/0x2b0 [xfs]
>>>> __handle_mm_fault+0x794/0x1af0
>>>> handle_mm_fault+0x12c/0x220
>>>> __do_page_fault+0x290/0xe40
>>>> do_page_fault+0x38/0xc0
>>>> handle_page_fault+0x10/0x30
>>>>
>>>> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>>>> ---
>>>>    drivers/nvdimm/pmem.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>>>> index 2df6994acf83..fcf7af13897e 100644
>>>> --- a/drivers/nvdimm/pmem.c
>>>> +++ b/drivers/nvdimm/pmem.c
>>>> @@ -214,6 +214,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>>>>    			bio->bi_status = rc;
>>>>    			break;
>>>>    		}
>>>> +		cond_resched();
>>>
>>> There are already cond_resched() calls between submitted bios in
>>> blkdev_issue_zeroout() via both __blkdev_issue_zero_pages() and
>>> __blkdev_issue_write_zeroes(), so I'm kinda wondering where the
>>> problem is coming from here.
>>
>> This problem is coming from that bio call- submit_bio()
>>
>>>
>>> Just how big is the bio being issued here that it spins for 22s
>>> trying to copy it?
>>
>> It's 256 (due to BIO_MAX_PAGES) * 64KB (pagesize) = 16MB.
>> So this is definitely not an easy trigger as per tester was mainly seen
>> on a VM.
> 
> Right, so a memcpy() of 16MB of data in a single bio is taking >22s?
> 
> If so, then you can't solve this problem with cond_resched() - if
> something that should only take half a millisecond to run is taking
> 22s of CPU time, there are bigger problems occurring that need
> fixing.
> 
> i.e. if someone is running a workload that has effectively
> livelocked the hardware cache coherency protocol across the entire
> machine, then changing kernel code that requires memory bandwidth to
> be available is not going to fix the problem. All is does is shoot
> the messenger that tells you there is something going wrong.

Thanks Dave. Appreciate your inputs in this area.
Yes, agreed on the fact that we should not shoot the messenger itself.
Will look more into this.

-ritesh
