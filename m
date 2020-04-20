Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D941B0221
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTHDS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 03:03:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbgDTHDR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 03:03:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K738xJ013942
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 03:03:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu5ex2p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 03:03:14 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 20 Apr 2020 08:02:28 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Apr 2020 08:02:25 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03K738Jk29032500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 07:03:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3B84C044;
        Mon, 20 Apr 2020 07:03:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C03794C046;
        Mon, 20 Apr 2020 07:03:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.243])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 07:03:06 +0000 (GMT)
Subject: Re: [PATCH] ext4: validate fiemap iomap begin offset and length value
To:     Murphy Zhou <jencce.kernel@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
 <20200419015654.F2061A4051@d06av23.portsmouth.uk.ibm.com>
 <20200419044224.GA311394@mit.edu> <20200419044612.GB311394@mit.edu>
 <20200419161928.6D6CC5204E@d06av21.portsmouth.uk.ibm.com>
 <20200420025721.ac5ighvy77fffnxf@xzhoux.usersys.redhat.com>
 <20200420041603.89D2C5204F@d06av21.portsmouth.uk.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 20 Apr 2020 12:33:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200420041603.89D2C5204F@d06av21.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042007-0016-0000-0000-00000307C362
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042007-0017-0000-0000-0000336BD374
Message-Id: <20200420070306.C03794C046@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_02:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200058
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/20/20 9:46 AM, Ritesh Harjani wrote:
> 
> 
> On 4/20/20 8:27 AM, Murphy Zhou wrote:
>> On Sun, Apr 19, 2020 at 09:49:27PM +0530, Ritesh Harjani wrote:
>>> Hello Ted,
>>>
>>> On 4/19/20 10:16 AM, Theodore Y. Ts'o wrote:
>>>
>>>> ext4_map_block() is returning EFSCORRUPTED when lblk is
>>>> EXT4_MAX_LOGICAL_BLOCK, which is why he's constraining lblk to
>>>> EXT4_MAX_LOGICAL_BLOCK.  I haven't looked into this more closely yet,
>>>
>>> Yes, I did mention about this case in point 2 in below link though.
>>> But maybe I was only focused on testing syzcaller reproducer, so
>>> couldn't test this reported case.
>>>
>>> https://www.spinics.net/lists/linux-ext4/msg71387.html
>>>
>>>
>>>> On Sun, Apr 19, 2020 at 12:42:24AM -0400, Theodore Y. Ts'o wrote:
>>>>> I think we need to take his patch, and make a simialr change to
>>>>> ext4_iomap_begin().   Ritesh, do you agree?
>>>>
>>>> For example...
>>>>
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index 2a4aae6acdcb..adce3339d697 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -3424,8 +3424,10 @@ static int ext4_iomap_begin(struct inode 
>>>> *inode, loff_t offset, loff_t length,
>>>>        int ret;
>>>>        struct ext4_map_blocks map;
>>>>        u8 blkbits = inode->i_blkbits;
>>>> +    ext4_lblk_t lblk = offset >> blkbits;
>>>> +    ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
>>>
>>> Why play with last_lblk but?
>>>
>>>
>>>
>>>> -    if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>>> +    if (lblk > EXT4_MAX_LOGICAL_BLOCK)
>>>>            return -EINVAL;
>>>>        if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
>>>> @@ -3434,9 +3436,15 @@ static int ext4_iomap_begin(struct inode 
>>>> *inode, loff_t offset, loff_t length,
>>>>        /*
>>>>         * Calculate the first and last logical blocks respectively.
>>>>         */
>>>> -    map.m_lblk = offset >> blkbits;
>>>> -    map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>>> -              EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>>>> +    if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
>>>> +        last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
>>>> +    if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
>>>> +        lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
>>>> +
>>>> +    map.m_lblk = lblk;
>>>> +    map.m_len = last_lblk - lblk + 1;
>>>> +    if (map.m_len == 0 )
>>>> +        map.m_len = 1;
>>>
>>> Not sure but with above changes map.m_len will never be
>>> 0. Right?
>>
>> Yes. If it's 0, in ext4_iomap_is_delalloc we will get an "end" that
>> is less then m_lblk, causing another WARN in ext4_es_find_extent_range.
> 
> Sorry lost you. Ok so what I meant above is.
> With your changes made in above code to truncate last_lblk
> and lblk, we may never end up in a situation where map.m_len will be 0.
> So the below check in your code, isn't it redundant?
> I wanted to double confirm this with you.
> 
> +    if (map.m_len == 0 )
> +        map.m_len = 1;
> 
> 
>>
>>>
>>> Ok, so the problem mainly is coming since ext4_map_blocks()
>>> is returning -EFSCORRUPTED in case if lblk >= EXT4_MAX_LOGICAL_BLOCK.
>>>
>>> So why change last_lblk?
>>
>> I guess because we need to make sure a sane length value. In the loop
>> in iomap_fiemap, start and length are not checked, assuming be checked
>> by caller. If length get overflowed, the start value for the next loop
>> can also be affected, which makes lblk last_lblk and m_len to go crazy.
> 
> Sorry I didn't it explain it right maybe. So if we are anyway changing
> lblk by truncating it and making sure map.m_len is not getting
> overflowed (as we did in my previous patch), then we need not play with
> last_lblk anyways.
> 
> And FWIW, instead of truncating lblk just so that ext4_map_blocks()
> doesn't WARN, we can as well just return -ENOENT for
> lblk >= EXT4_MAX_LOGICAL_BLOCK. ENOENT makes more sense to me,
> but please feel free to correct me here.
> 
> Thoughts?
> 
> Meanwhile, I will also play this change (-ENOENT) a bit to at least get
> few of the known test cases covered.
> 
> 
> Also I do had this question for ext4.
> EXT4_MAX_BLOCKS explaination says that's the max *number* of logical
> blocks in a file. So since it is the number of blocks, it is equivalent
> of length. Whereas the EXT4_MAX_LOGICAL_BLOCK says the max logical block
> of a file, which is equivalent of offset.
> Considering the logical offset starts from 0, so as Ted was saying
> having both values same doesn't make sense. Ideally maybe
> EXT4_MAX_LOGICAL_BLOCK should be 0xFFFFFFFFE.
> 
> But that may also require some careful checking of all bounds of length
> and offset across the code. So maybe we can revisit this later.
> /*
>   * Maximum number of logical blocks in a file; ext4_extent's ee_block is
>   * __le32.
>   */
> #define EXT_MAX_BLOCKS    0xffffffff
> 
> 
> /* Max logical block we can support */
> #define EXT4_MAX_LOGICAL_BLOCK        0xFFFFFFFF


After doing some more careful review of code to find out why we return 
-EFSCORRUPTED from ext4_map_blocks(). I think the reason maybe this:-

In case if we have a file with an extent at last logical block of file
(which ext4 can support i.e. 0xFFFFFFFE) of length 1. In that case
if some tries to call for ext4_map_blocks() for lblk of 0xFFFFFFFF
for length 1, then it will fall over below logic condition
in ext4_map_blocks (of course will happen if we comment out the
logic to return -EFSCORRUPTED from ext4_map_blocks).

4109         /* 
 
 

4110          * requested block isn't allocated yet; 

4111          * we couldn't try to create block if create flag is zero 

4112          */ 

4113         if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) { 

4114                 ext4_lblk_t hole_start, hole_len; 

4115 

4116                 hole_start = map->m_lblk; 

4117                 hole_len = ext4_ext_determine_hole(inode, path, 
&hole_start);
4118                 /* 

4119                  * put just found gap into cache to speed up 

4120                  * subsequent requests 

4121                  */ 

4122                 ext4_ext_put_gap_in_cache(inode, hole_start, 
hole_len);
4123 

4124                 /* Update hole_len to reflect hole size after 
map->m_lblk */
4125                 if (hole_start != map->m_lblk) 

4126                         hole_len -= map->m_lblk - hole_start; 

4127                 map->m_pblk = 0; 

4128                 map->m_len = min_t(unsigned int, map->m_len, 
hole_len);
4129 

4130                 goto out2; 

4131         }

In here we will try and determine the hole_start
and hole_len to put the gap in ext_status cache.

"Note that the path which is determined in above is the path
for the last extent found in the file."

So while trying to determine the hole_start and hole_len,
we go into ext4_ext_determine_hole() -> ext4_ext_next_allocated_block()
Now since there is no next allocated block, so in that case
that function returns EXT_MAX_BLOCKS.
And therefore we may hit the BUG_ON in below function.


2202         } else if (*lblk >= le32_to_cpu(ex->ee_block) 

2203                         + ext4_ext_get_actual_len(ex)) { 

2204                 ext4_lblk_t next; 

2205 

2206                 *lblk = le32_to_cpu(ex->ee_block) + 
ext4_ext_get_actual_len(ex);
2207                 next = ext4_ext_next_allocated_block(path); 
 
 

2208                 BUG_ON(next == *lblk);    ==> We may hit here. 

2209                 len = next - *lblk; 

2210         } else { 

2211                 BUG(); 

2212         } 

2213         return len;


Now looking at above, I think below code should be the right fix
for this issue. But pls help correct if you think otherwise.
We need not take the previous m_len overflow fix. Since the length
won't overflow with below change in (EXT4_MAX_LOGICAL_BLOCK).

For now, I have tested the 2 known reproducers with this patch alone.
Those were fine with this change.


diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..ad2dbf6e4924 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -722,7 +722,7 @@ enum {
  #define EXT4_MAX_BLOCK_FILE_PHYS       0xFFFFFFFF

  /* Max logical block we can support */
-#define EXT4_MAX_LOGICAL_BLOCK         0xFFFFFFFF
+#define EXT4_MAX_LOGICAL_BLOCK         0xFFFFFFFE

  /*
   * Structure of an inode on the disk
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9c7b1bad0cd6..e7c0ec58ec98 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3426,7 +3426,7 @@ static int ext4_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
         u8 blkbits = inode->i_blkbits;

         if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
-               return -EINVAL;
+               return -ENOENT;

         if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
                 return -ERANGE;
@@ -3526,7 +3526,7 @@ static int ext4_iomap_begin_report(struct inode 
*inode, loff_t offset,
         u8 blkbits = inode->i_blkbits;

         if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
-               return -EINVAL;
+               return -ENOENT;

         if (ext4_has_inline_data(inode)) {
                 ret = ext4_inline_data_iomap(inode, iomap);

-ritesh

>>
>> Thanks.
>>
>>> Shouldn't we just change the logic to return -ENOENT in case
>>> if (lblk >= EXT4_MAX_LOGICAL_BLOCK)? ENOENT can be handled by
>>> IOMAP APIs to abort the loop properly.
>>> This along with the map.m_len overlflow patch which I had submitted
>>> before. (since the overflow patch is anyway a valid fix which we anyways
>>> need).
>>>
>>> -ritesh
>>>
>>>
>>>>        if (flags & IOMAP_WRITE)
>>>>            ret = ext4_iomap_alloc(inode, &map, flags);
>>>> @@ -3524,8 +3532,10 @@ static int ext4_iomap_begin_report(struct 
>>>> inode *inode, loff_t offset,
>>>>        bool delalloc = false;
>>>>        struct ext4_map_blocks map;
>>>>        u8 blkbits = inode->i_blkbits;
>>>> +    ext4_lblk_t lblk = offset >> blkbits;
>>>> +    ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
>>>> -    if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>>> +    if (lblk > EXT4_MAX_LOGICAL_BLOCK)
>>>>            return -EINVAL;
>>>>        if (ext4_has_inline_data(inode)) {
>>>> @@ -3540,9 +3550,15 @@ static int ext4_iomap_begin_report(struct 
>>>> inode *inode, loff_t offset,
>>>>        /*
>>>>         * Calculate the first and last logical block respectively.
>>>>         */
>>>> -    map.m_lblk = offset >> blkbits;
>>>> -    map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>>> -              EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>>>> +    if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
>>>> +        last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
>>>> +    if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
>>>> +        lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
>>>> +
>>>> +    map.m_lblk = lblk;
>>>> +    map.m_len = last_lblk - lblk + 1;
>>>> +    if (map.m_len == 0 )
>>>> +        map.m_len = 1;
>>>>        /*
>>>>         * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
>>>>
>>>
>>
> 

