Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C509A6AC5F9
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Mar 2023 16:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCFPzZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Mar 2023 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCFPzY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Mar 2023 10:55:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8176241C7
        for <linux-ext4@vger.kernel.org>; Mon,  6 Mar 2023 07:55:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j11so21040276edq.4
        for <linux-ext4@vger.kernel.org>; Mon, 06 Mar 2023 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678118120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adag9rQRtIE0S5BofNs83BJKjEZLhts50SJ5zYyeNu8=;
        b=UxPPkft3fek+U78zTnGjaX4dWZrXv2YraRNUV7dVNLJkMa1xDp2vJ3EI5M6eO6QsMs
         rP2Bk4T90Bkc/ox2zZFw/o3LByPmI1zyMHILubAkmsLMJCU6stn2p65eBXRNZnpFljWW
         VKsLh2fsiNn0B2AeIG9l4443s+lAmdkDYDfNx42eybnc+chTFOFQRWlcPgXC3vCJ4wWC
         +7nzPVIPHlr7wN99BhLLZLejyf/3ee6db3Lqqtyspx0tDU+CPgHe57Z20/u9YR47wThT
         6OTrH+HttTt8uLyTBbnscLcFMzUq1nEb83PbcjiXfBh7552XFv3FzcABw+GfJGcXC4/l
         wdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678118120;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adag9rQRtIE0S5BofNs83BJKjEZLhts50SJ5zYyeNu8=;
        b=bL2Nkw9zHX1aYMqhngS5UaejgTPWyt37r7QypsGLPyxjoTQYRDY3wtotu+K0VQZJFL
         RF7AbYheShZiyKMG6ZLUJLTc2kb0lFBezp8+V8O6DPicpG+OpJuv/sJ1Gc4iUXXaNV2V
         JAY15Wm1HCSvmbfJH70AVkN9fNjOnR56bo9zY6psdK4aZ+suO7raDUrE/Ki8EcmpAlvO
         deGNjtHUqT29tGUs5OcIkycx95JpxAHiTKMWmt63UYrGB6iZ717gFUtlshnwKssXQECs
         BI2L56tTnnDjHPMgwFmFLCNLenPjqGJrUTbcH6TX7LmFtlvjhzZEgcevgL0c1xiygDEd
         XxLg==
X-Gm-Message-State: AO0yUKUDPAVQUpd8p/WTcXSHk7WYmbyxalSiHAm1owRFmSitVJub8/EK
        8g6i9oz2gpz2qoOD/ZL08A3CJw==
X-Google-Smtp-Source: AK7set+J30GUpx/Kjs4GPLXW8RC6PdpfVIblxjx9wJKOrJQS47XRBfrLaEvL2m9y14LoQmVBb1pS+g==
X-Received: by 2002:a17:906:546:b0:8b1:78bc:7508 with SMTP id k6-20020a170906054600b008b178bc7508mr10011612eja.20.1678118120075;
        Mon, 06 Mar 2023 07:55:20 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id d25-20020a1709064c5900b008b17de96f00sm4733761ejw.151.2023.03.06.07.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:55:19 -0800 (PST)
Message-ID: <110b2d4a-a33a-7002-1176-73dc85e1de27@linaro.org>
Date:   Mon, 6 Mar 2023 15:55:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] ext4: fsmap: Consolidate fsmap_head checks
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     tytso@mit.edu, darrick.wong@oracle.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com
References: <20230222131211.3898066-1-tudor.ambarus@linaro.org>
 <20230222131211.3898066-3-tudor.ambarus@linaro.org>
 <20230304025644.GA1637890@frogsfrogsfrogs>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230304025644.GA1637890@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Darrick,

Thanks for taking the time to review this patch.

On 3/4/23 02:56, Darrick J. Wong wrote:
> On Wed, Feb 22, 2023 at 01:12:10PM +0000, Tudor Ambarus wrote:
>> Sanity checks should be done the soonest possible to avoid superfluous
>> computations when user provides wrong data. Gather all the checks on
>> user provided data in a single method and call it immediately after
>> copying the data from user.
> 
> This patch changes the validation criteria, moves chunks of code around,

The validation criteria remains the same, there's no functional change
in the code.

> and constifies parameters all at once.  And all you say here is that
> you're moving validation code up in the sequence!

My apologies, I should have mentioned something about the
constification. I chose to do the validation over const data because
the data should not be changed at validation time, otherwise one may end
with nasty implications on the sequence of validation. The const change
deserved at least a comment if not a dedicated patch, I agree.

> 
> Also, how does moving callsites around improve things?  Do the fstests

You don't waste CPU cycles in case the validation fails later on in the
code. Every initialization that is done before the last validation check
is superfluous in case the validation fails. Also, having the validation 
scattered around copies of user data and in different methods is harder
to follow. What I did was to gather all validation checks in a single
method and call it the soonest possible. IMO this makes the code cleaner
and easier to understand.

> still pass?

Yes, please check the cover letter at:
https://lore.kernel.org/linux-ext4/20230222131211.3898066-1-tudor.ambarus@linaro.org/

All the available ext4 fsmap tests passed after this patch set. I tested
ext4/{027, 028, 029}.

> 
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>   fs/ext4/fsmap.c | 52 ++++++++++++++++++++++++++++++++++++-------------
>>   fs/ext4/fsmap.h |  3 +++
>>   fs/ext4/ioctl.c | 17 +++-------------
>>   3 files changed, 44 insertions(+), 28 deletions(-)
>>
>> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
>> index b5289378a761..a27d9f0967b7 100644
>> --- a/fs/ext4/fsmap.c
>> +++ b/fs/ext4/fsmap.c
>> @@ -9,6 +9,7 @@
>>   #include "fsmap.h"
>>   #include "mballoc.h"
>>   #include <linux/sort.h>
>> +#include <linux/string.h>
>>   #include <linux/list_sort.h>
>>   #include <trace/events/ext4.h>
>>   
>> @@ -571,7 +572,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
>>   
>>   /* Do we recognize the device? */
>>   static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
>> -					  struct ext4_fsmap *fm)
>> +					  const struct fsmap *fm)
>>   {
>>   	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
>>   	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
>> @@ -583,17 +584,19 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
>>   }
>>   
>>   /* Ensure that the low key is less than the high key. */
>> -static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
>> -				     struct ext4_fsmap *high_key)
>> +static bool ext4_getfsmap_check_keys(const struct fsmap *low_key,
>> +				     const struct fsmap *high_key)
>>   {
>> +	u64 l_fmr_phys = low_key->fmr_physical + low_key->fmr_length;
>> +
>>   	if (low_key->fmr_device > high_key->fmr_device)
>>   		return false;
>>   	if (low_key->fmr_device < high_key->fmr_device)
>>   		return true;
>>   
>> -	if (low_key->fmr_physical > high_key->fmr_physical)
>> +	if (l_fmr_phys > high_key->fmr_physical)
>>   		return false;
>> -	if (low_key->fmr_physical < high_key->fmr_physical)
>> +	if (l_fmr_phys < high_key->fmr_physical)
> 
> Why are you changing the comparison here?

So that I preserve the validation check that was done before this patch.

In the code there are 3 representations of the key on which we currently
do validations:
1/  the ones from struct fsmap_head head; -> contains the data copied
from the user
2/ the ones from struct ext4_fsmap_head xhead; -> ext4 internal
representation of the fsmap
3/ dkeys - local keys used to query the device. These are 2/ but with 
the low key bumped by fmr_length.

As you correctly identified below, ext4_getfsmap_check_keys() validated
dkeys[0] and fmh_keys[1], so a combination of 2/ and 3/, whereas now I 
use it to validate directly the data copied from user, thus the data 
from 1/. In order to do that and at the same time to preserve the logic, 
I had to introduce a local variable, l_fmr_phys, and bump the low key by
fmr_length.

As you see, now instead of scattering the checks on data from 1/, 2/ and 
3/, I do the checks only on the user provided data, thus 1/.
> 
>>   		return true;
>>   
>>   	if (low_key->fmr_owner > high_key->fmr_owner)
>> @@ -604,6 +607,36 @@ static bool ext4_getfsmap_check_keys(struct ext4_fsmap *low_key,
>>   	return false;
>>   }
>>   
>> +int ext4_fsmap_check_head(struct super_block *sb,
>> +			  const struct fsmap_head *head)
>> +{
>> +	const struct fsmap *l = &head->fmh_keys[0];
>> +	const struct fsmap *h = &head->fmh_keys[1];
>> +
>> +	if (memchr_inv(head->fmh_reserved, 0, sizeof(head->fmh_reserved)) ||
>> +	    memchr_inv(l->fmr_reserved, 0, sizeof(l->fmr_reserved)) ||
>> +	    memchr_inv(h->fmr_reserved, 0, sizeof(h->fmr_reserved)))
>> +		return -EINVAL;
>> +	/*
>> +	 * ext4 doesn't report file extents at all, so the only valid
>> +	 * file offsets are the magic ones (all zeroes or all ones).
>> +	 */
>> +	if (l->fmr_offset || (h->fmr_offset != 0 && h->fmr_offset != -1ULL))
>> +		return -EINVAL;
>> +
>> +	if (head->fmh_iflags & ~FMH_IF_VALID)
>> +		return -EINVAL;
>> +
>> +	if (!ext4_getfsmap_is_valid_device(sb, l) ||
>> +	    !ext4_getfsmap_is_valid_device(sb, h))
>> +		return -EINVAL;
>> +
>> +	if (!ext4_getfsmap_check_keys(l, h))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>>   #define EXT4_GETFSMAP_DEVS	2
>>   /*
>>    * Get filesystem's extents as described in head, and format for
>> @@ -635,12 +668,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>>   	int i;
>>   	int error = 0;
>>   
>> -	if (head->fmh_iflags & ~FMH_IF_VALID)
>> -		return -EINVAL;
>> -	if (!ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[0]) ||
>> -	    !ext4_getfsmap_is_valid_device(sb, &head->fmh_keys[1]))
>> -		return -EINVAL;
>> -
>>   	head->fmh_entries = 0;
>>   
>>   	/* Set up our device handlers. */
>> @@ -673,9 +700,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>>   	dkeys[0].fmr_length = 0;
>>   	memset(&dkeys[1], 0xFF, sizeof(struct ext4_fsmap));
>>   
>> -	if (!ext4_getfsmap_check_keys(dkeys, &head->fmh_keys[1]))
>> -		return -EINVAL;
> 
> And why is it ok to turn validation of dkeys[0] vs. fmh_keys[1] into a
> validation of fmh_keys[0..1] ?  I guess that's why check_keys now adds
> the low key physical offset and length?

Yes, you're correct. It's okay to validate directly on the data copied
from user because 2/ and 3/ are just copies of 1/.

> 
> But why not leave the key checks the where they are, since it's
> dkeys[0..1] that get passed around the implementations?
> 

I hope I made it clear at this point. Waiting for your reply.

Cheers,
ta
