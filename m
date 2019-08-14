Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB378D29B
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfHNL6U (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Aug 2019 07:58:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbfHNL6T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Aug 2019 07:58:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EBvlUx119883
        for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2019 07:58:18 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucfw6cpna-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2019 07:58:18 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 14 Aug 2019 12:58:15 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Aug 2019 12:58:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7EBwBTG51511502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 11:58:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80DFFAE051;
        Wed, 14 Aug 2019 11:58:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78742AE045;
        Wed, 14 Aug 2019 11:58:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.57])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 11:58:10 +0000 (GMT)
From:   RITESH HARJANI <riteshh@linux.ibm.com>
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, aneesh.kumar@linux.ibm.com
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
 <20190813111004.GA12682@poseidon.bobrowski.net>
 <20190813122723.AE6264C040@d06av22.portsmouth.uk.ibm.com>
 <20190814094848.GA23465@poseidon.bobrowski.net>
Date:   Wed, 14 Aug 2019 17:28:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190814094848.GA23465@poseidon.bobrowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081411-0016-0000-0000-0000029EB4C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081411-0017-0000-0000-000032FECE87
Message-Id: <20190814115810.78742AE045@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140126
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 8/14/19 3:18 PM, Matthew Bobrowski wrote:
> On Tue, Aug 13, 2019 at 05:57:22PM +0530, RITESH HARJANI wrote:
>> On 8/13/19 4:40 PM, Matthew Bobrowski wrote:
>>> On Mon, Aug 12, 2019 at 11:01:50PM +0530, RITESH HARJANI wrote:
>>>> I was under the assumption that we need to maintain
>>>> ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) or
>>>> atomic_read(&EXT4_I(inode)->i_unwritten))
>>>> in case of non-AIO directIO or AIO directIO case as well (when we may
>>>> allocate unwritten extents),
>>>> to protect with some kind of race with other parts of code(maybe
>>>> truncate/bufferedIO/fallocate not sure?) which may call for
>>>> ext4_can_extents_be_merged()
>>>> to check if extents can be merged or not.
>>>>
>>>> Is it not the case?
>>>> Now that directIO code has no way of specifying that this inode has
>>>> unwritten extent, will it not race with any other path, where this info was
>>>> necessary (like
>>>> in above func ext4_can_extents_be_merged())?
>>> Ah yes, I was under the same assumption when reviewing the code
>>> initially and one of my first solutions was to also use this dynamic
>>> 'state' flag in the ->end_io() handler. But, I fell flat on my face as
>>> that deemed to be problematic... This is because there can be multiple
>>> direct IOs to unwritten extents against the same inode, so you cannot
>>> possibly get away with tracking them using this single inode flag. So,
>>> hence the reason why we drop using EXT4_STATE_DIO_UNWRITTEN and use
>>> IOMAP_DIO_UNWRITTEN instead in the ->end_io() handler, which tracks
>>> whether _this_ particular IO has an underlying unwritten extent.
>> Thanks for taking time to explain this.
>>
>> But what I meant was this (I may be wrong here since I haven't really looked
>> into it),
>> but for my understanding I would like to discuss this -
>>
>> So earlier with this flag(EXT4_STATE_DIO_UNWRITTEN) we were determining on
>> whether a newextent can be merged with ex1 in function
>> ext4_extents_can_be_merged. But now since we have removed that flag we have
>> no way of knowing that whether
>> this inode has any unwritten extents or not from any DIO path.
>> What I meant is isn't this removal of setting/unsetting of
>> flag(EXT4_STATE_DIO_UNWRITTEN)
>> changing the behavior of this func - ext4_extents_can_be_merged?
> Ah yes, I see. I believe that what you're saying is correct and I
> think we will need to account for this case. But, I haven't thought
> about how to do this just yet.

That's not a problem, we can surely discuss the possible approaches.


>> Also - could you please explain why this check returns 0 in the first place
>> (line 1762 - 1766 below)?
>>
>> 1733 int
>> 1734 ext4_can_extents_be_merged(struct inode *inode, struct ext4_extent
>> *ex1,
>> 1735                                 struct ext4_extent *ex2)
>> <...>
>>
>> 1762         if (ext4_ext_is_unwritten(ex1) &&
>> 1763             (ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) ||
>> 1764              atomic_read(&EXT4_I(inode)->i_unwritten) ||
>> 1765              (ext1_ee_len + ext2_ee_len > EXT_UNWRITTEN_MAX_LEN)))
>> 1766                 return 0;
> I cannot explain why, because I myself don't know exactly why in this
> particular case the extents cannot be merged. Perhaps `git blame` is
> our friend and we can direct that question accordingly, or someone
> else on this mailing list knows the answer. :-)

git blame didn't help much. But I think I may know what the above 
condition means.
So I think if there is an ongoing IO to an unwritten extent, we may 
sometimes first split that extent
to match the exact range of the IO, then write data to it and then 
convert that *exact range* to written extent.

So this means while there is an ongoing IO to any inode which has 
unwritten extents, we should not allow
any other extent to merge with extents of this inode.

Now one race which I could think of it is, when we are doing AIO DIO and 
in parallel doing fallocate to the end of the file.
But since we wait for inode_dio_wait in fallocate, so that should not 
race with any DIO paths.

I think, here we can wait to get answers from others to understand, if 
there is any race with any of the DIO paths on removing this state 
flag(EXT4_STATE_DIO_UNWRITTEN) & not
setting "i_unwritten". Whether it can race with any other path and if 
this state flag is necessary(in DIO cases also) for the correct 
functionality?


Regards
Ritesh

