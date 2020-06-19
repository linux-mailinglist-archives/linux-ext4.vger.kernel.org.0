Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE74200A79
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbgFSNmZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 09:42:25 -0400
Received: from sandeen.net ([63.231.237.45]:41304 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732663AbgFSNmZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Jun 2020 09:42:25 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 0EE39F8AD1;
        Fri, 19 Jun 2020 08:41:59 -0500 (CDT)
Subject: Re: [PATCH 1/1] ext4: fix potential negative array index in
 do_split()
To:     Lukas Czerner <lczerner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
 <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
 <20200619064122.vj346xptid5viogv@work> <20200619070854.z3dslhh7yebainhd@work>
From:   Eric Sandeen <sandeen@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <3a956d48-88b9-5c54-3d49-fc772db29258@sandeen.net>
Date:   Fri, 19 Jun 2020 08:42:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200619070854.z3dslhh7yebainhd@work>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 6/19/20 2:08 AM, Lukas Czerner wrote:
> On Fri, Jun 19, 2020 at 08:41:22AM +0200, Lukas Czerner wrote:
>> On Wed, Jun 17, 2020 at 02:19:04PM -0500, Eric Sandeen wrote:
>>> If for any reason a directory passed to do_split() does not have enough
>>> active entries to exceed half the size of the block, we can end up
>>> iterating over all "count" entries without finding a split point.
>>>
>>> In this case, count == move, and split will be zero, and we will
>>> attempt a negative index into map[].
>>>
>>> Guard against this by detecting this case, and falling back to
>>> split-to-half-of-count instead; in this case we will still have
>>> plenty of space (> half blocksize) in each split block.
>>>
>>> Fixes: ef2b02d3e617 ("ext34: ensure do_split leaves enough free space in both blocks")
>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>> ---
>>>
>>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>>> index a8aca4772aaa..8b60881f07ee 100644
>>> --- a/fs/ext4/namei.c
>>> +++ b/fs/ext4/namei.c
>>> @@ -1858,7 +1858,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>>>  			     blocksize, hinfo, map);
>>>  	map -= count;
>>>  	dx_sort_map(map, count);
>>> -	/* Split the existing block in the middle, size-wise */
>>> +	/* Ensure that neither split block is over half full */
>>>  	size = 0;
>>>  	move = 0;
>>>  	for (i = count-1; i >= 0; i--) {
>>> @@ -1868,8 +1868,18 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>>>  		size += map[i].size;
>>>  		move++;
>>>  	}
>>> -	/* map index at which we will split */
>>> -	split = count - move;
>>> +	/*
>>> +	 * map index at which we will split
>>> +	 *
>>> +	 * If the sum of active entries didn't exceed half the block size, just
>>> +	 * split it in half by count; each resulting block will have at least
>>> +	 * half the space free.
>>> +	 */
>>> +	if (i > 0)
>>> +		split = count - move;
>>> +	else
>>> +		split = count/2;
>>
>> Won't we have exactly the same problem as we did before your commit
>> ef2b02d3e617cb0400eedf2668f86215e1b0e6af ? Since we do not know how much
>> space we actually moved we might have not made enough space for the new
>> entry ?
>>
>> Also since we have the move == count when the problem appears then it's
>> clear that we never hit the condition
>>
>> 1865 →       →       /* is more than half of this entry in 2nd half of the block? */
>> 1866 →       →       if (size + map[i].size/2 > blocksize/2)
>> 1867 →       →       →       break;
>>
>> in the loop. This is surprising but it means the the entries must have
>> gaps between them that are small enough that we can't fit the entry
>> right in ? Should not we try to compact it before splitting, or is it
>> the case that this should have been done somewhere else ?
> 
> The other possibility is that map[i].size is not right and indeed there
> seems to be a bug in dx_make_map()
> 
> map_tail->size = le16_to_cpu(de->rec_len);
> 
> should be
> 
> map_tail->size = ext4_rec_len_from_disk(de->rec_len, blocksize));
> 
> right ? Otherwise with large enough records the size will be smaller
> than it really is.

well, those are the same thing unless (PAGE_SIZE >= 65536) so I don't
think that's the issue here.

static inline unsigned int
ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
{
        unsigned len = le16_to_cpu(dlen);

#if (PAGE_SIZE >= 65536)
...
#else
        return len;
#endif
}

Should be fixed for consistency, but seems to not be a root cause here.

> A quick look at fs/ext4/namei.c reveals couple of places there rec_len
> is used without the conversion and we should check whether it needs
> fixing.

...

