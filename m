Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C282313B54D
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 23:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgANWZ6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 17:25:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728748AbgANWZ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Jan 2020 17:25:58 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EMH1O1088336
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 17:25:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfaw0hj61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jan 2020 17:25:56 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 14 Jan 2020 22:25:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Jan 2020 22:25:52 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00EMPpic49283302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 22:25:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17B05A404D;
        Tue, 14 Jan 2020 22:25:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BA08A4040;
        Tue, 14 Jan 2020 22:25:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.44.28])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jan 2020 22:25:50 +0000 (GMT)
Subject: Re: [RFC 2/2] ext4: Fix stale data read issue with DIO read &
 ext4_page_mkwrite path
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <1c2da3cf5e0d90e8650e81f07976629c7d87e8ca.1578907891.git.riteshh@linux.ibm.com>
 <20200114094741.GC6466@quack2.suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 15 Jan 2020 03:55:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200114094741.GC6466@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011422-0016-0000-0000-000002DD5961
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011422-0017-0000-0000-0000333FEA47
Message-Id: <20200114222550.3BA08A4040@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140171
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jan,

On 1/14/20 3:17 PM, Jan Kara wrote:
> On Mon 13-01-20 16:34:22, Ritesh Harjani wrote:
>> Currently there is a small race window where ext4 tries to allocate
>> a written block for mapped files and if DIO read is in progress, then
>> this may result into stale data read exposure problem.
>>
>> This patch fixes the mentioned issue by:
>> 1. For non-delalloc path, page_mkwrite will use unwritten blocks by
>>     default for extent based files.
>>
>> 2. For delalloc path, we check if DIO is in progress during writeback.
>>     If yes, then we use unwritten blocks method to avoid this race.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>> ---
>>   fs/ext4/inode.c | 45 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index d035acab5b2a..07f66782335b 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1529,6 +1529,7 @@ struct mpage_da_data {
>>   	struct ext4_map_blocks map;
>>   	struct ext4_io_submit io_submit;	/* IO submission data */
>>   	unsigned int do_map:1;
>> +	bool dio_in_progress:1;
>>   };
>>   
>>   static void mpage_release_unused_pages(struct mpage_da_data *mpd,
>> @@ -2359,7 +2360,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>>   			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
>>   			   EXT4_GET_BLOCKS_IO_SUBMIT;
>>   	dioread_nolock = ext4_should_dioread_nolock(inode);
>> -	if (dioread_nolock)
>> +	if (dioread_nolock || mpd->dio_in_progress)
>>   		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
>>   	if (map->m_flags & (1 << BH_Delay))
>>   		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
>> @@ -2367,7 +2368,8 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>>   	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
>>   	if (err < 0)
>>   		return err;
>> -	if (dioread_nolock && (map->m_flags & EXT4_MAP_UNWRITTEN)) {
>> +	if ((dioread_nolock || mpd->dio_in_progress) &&
>> +	    (map->m_flags & EXT4_MAP_UNWRITTEN)) {
>>   		if (!mpd->io_submit.io_end->handle &&
>>   		    ext4_handle_valid(handle)) {
>>   			mpd->io_submit.io_end->handle = handle->h_rsv_handle;
>> @@ -2626,6 +2628,7 @@ static int ext4_writepages(struct address_space *mapping,
>>   	bool done;
>>   	struct blk_plug plug;
>>   	bool give_up_on_write = false;
>> +	bool dio_in_progress = false;
>>   
>>   	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
>>   		return -EIO;
>> @@ -2680,15 +2683,6 @@ static int ext4_writepages(struct address_space *mapping,
>>   		ext4_journal_stop(handle);
>>   	}
>>   
>> -	if (ext4_should_dioread_nolock(inode)) {
>> -		/*
>> -		 * We may need to convert up to one extent per block in
>> -		 * the page and we may dirty the inode.
>> -		 */
>> -		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
>> -						PAGE_SIZE >> inode->i_blkbits);
>> -	}
>> -
>>   	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>>   		range_whole = 1;
>>   
>> @@ -2712,6 +2706,26 @@ static int ext4_writepages(struct address_space *mapping,
>>   	done = false;
>>   	blk_start_plug(&plug);
>>   
>> +	/*
>> +	 * If DIO is in progress, then we use unwritten blocks for allocation.
>> +	 * This is to avoid a small window of race (stale read) with
>> +	 * ext4_page_mkwrite path in delalloc case & with DIO read in parallel.
>> +	 *
>> +	 * Let's check for i_dio_count after we have tagged pages for writeback.
>> +	 */
>> +	smp_mb__before_atomic();
>> +	dio_in_progress = !!atomic_read(&inode->i_dio_count);
>> +	mpd.dio_in_progress = dio_in_progress;
> 
> Two problems here:
> 
> 1) smp_mb__before_atomic() does not work with atomic_read(). This kind of
> barrier works only with read-modify-write kinds of atomic operations like
> atomic_inc(). See Documentation/atomic_t.txt for more details.

Yes, I was not 100% sure on that part. But thanks for confirmation.


> 
> 2) Even if the barrier worked, this is still too early for the check.
> Consider the following race:
> 
> Task 1 - flusher		Task 2 - dio read	Task 3 - fault
> ext4_writepages()
>    atomic_read(&inode->i_dio_count) -> 0
>    ...
> 				iomap_dio_rw()
> 				  inode_dio_begin()
> 				  filemap_write_and_wait_range()
> 				  ...
> 							ext4_page_mkwrite()
> 							  fills hole at index I
>    ...
>    mpage_prepare_extent_to_map()
>      finds dirty page at index I - tagging
>      not in effect because this is WB_SYNC_NONE
>      writeback so we look for PAGECACHE_TAG_DIRTY
>      mpage_map_and_submit_extent()
>        - allocates block for page I
> 				  ext4_iomap_begin()
> 				    finds block under offset I
> 				  submit_bio()
> 				    - reads stale data

My bad. So a fault at hole may set the page dirty bit, while
ext4_writepages may be in progress. And if we check for i_dio_count very
early, then we still end up exposing stale data.

> 
> And what I wanted to use to stop this race is page lock / page writeback
> bit on page 'I' because filemap_write_and_wait_range() called from
> iomap_dio_rw() ends up waiting for both if the page is seen as dirty. For

Yes, agreed here. I guess earlier I was thinking of simplifying it
by checking for DIO early on so that we could use the same type of
extent type mapping (unwritten/written) for ext4_writepages.


> this to work, you need to check inode->i_dio_count after you hold the page
> locks for written range - i.e., after mpage_prepare_extent_to_map(). And

Yes, I am thinking we should add that check in 
mpage_map_and_submit_extent() before the do while{} loop.
I guess we should keep extent type mapping common for a given io_end
type, since we have to do unwritten to written handling at the end
of IO transfer.
This can be done if we check for DIO in progress early inside
mpage_map_and_submit_extent(), because by then, we already have the page
lock in place.

But let me also check more on this.

> that means you always have to have rsv_blocks set when starting a
> transaction because you don't know in advance whether you'll need them or
> not.

Yes. Thanks for pointing.


-ritesh

