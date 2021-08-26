Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D63F8302
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 09:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbhHZHUB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 03:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhHZHUA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 03:20:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04104C061757;
        Thu, 26 Aug 2021 00:19:14 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id r13so1591705pff.7;
        Thu, 26 Aug 2021 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cfTbP5ybrHUjQ7XFW8ZJxXbueJDV7DVUr/15F0i3NDo=;
        b=qsPLTdx3TKdjAIHR1a3Lpi29cmO2138kSw6i/7eLSZ21Qz/yj3oaVRLQybvk64OltB
         OyFW+PGCeLztsy5DjLaxwE0F30yleyijeG2TQ3Bb7zArd4GNgAmUeOMSVVnDjuxVNJ/y
         AyPTf8PCMdlLWS29BABilWgNSxOSeIiZyH27e3VaxuiiV3dFm8Efq/24LZXsxhwIiZ9I
         dPYUi4LG9XplV5p1KEqZl2svhbbw3kKSCbfQv63kF83Joq4DmrRxz9DP9nczm0Q3q1AH
         j15mLXR8hy7IuN/cmVjNfaUeNhOulF5+T2HSXgsaPJcFJQBTI4X6VtzyMvL5D8xGlJ7j
         +FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cfTbP5ybrHUjQ7XFW8ZJxXbueJDV7DVUr/15F0i3NDo=;
        b=Ljy9sizGjCNlEe9E54rEIkBs3WWGAZQFcICPzyo9TEvPKcrkKQdJiDQhG51WjQjUpc
         8ziqbeZYYlO0aOuQZ2vPDpDvSV63nWZqcLdB/p788vubQjZUkQ+PJSROGfq7/+vCzm/k
         pZB3dnPYSeiG7B3UBAlPIN10qqZ4ZvSpWL7fWKNzSIVy2xqL6ez+lf8h5L3Yz++jxo8Z
         Z//oe7Ng6hWB3RIgfjrTBUkwgOkjzmo0q2vnQVQH4aOGQMf3aIedZo2sXCjLfLOdeHbw
         DBqws9Jv+5lzbrV/Hcwn4Y3kd2s2u1VIbO/FZ19BCf8cSX5/8yJ0EiwwaSKcePZ6RkfM
         y4Yw==
X-Gm-Message-State: AOAM532rkFYch4bO4WlYX0RdYNRoniATVoCU29WP2fvE7SV/K1jIE+n6
        LyCU2MhH17kWojngRl5BYkg=
X-Google-Smtp-Source: ABdhPJwjYkHzvWF/14P68/Pk5wQjZHR0hGFvjg4FXqdpP/TlcHUtLyTjUWVhyiwV+J6iR/rGPVPLWA==
X-Received: by 2002:a65:494e:: with SMTP id q14mr2163360pgs.314.1629962353519;
        Thu, 26 Aug 2021 00:19:13 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.86.159.245])
        by smtp.gmail.com with ESMTPSA id 6sm1772171pjz.8.2021.08.26.00.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 00:19:13 -0700 (PDT)
Subject: Re: [PATCH V3 2/5] ext4: add new helper interface
 ext4_try_to_trim_range()
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-3-jianchao.wan9@gmail.com> <YRVd8CCjhkpGJ/tb@mit.edu>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <43615c43-6837-dd84-c5d8-017596a59688@gmail.com>
Date:   Thu, 26 Aug 2021 15:19:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRVd8CCjhkpGJ/tb@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/8/13 1:44 AM, Theodore Ts'o wrote:
> On Sat, Jul 24, 2021 at 03:41:21PM +0800, Wang Jianchao wrote:
>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>
>> There is no functional change in this patch but just split the
>> codes, which serachs free block and does trim, into a new function
>> ext4_try_to_trim_range. This is preparing for the following async
>> backgroup discard.
>>
>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
>> ---
>>  fs/ext4/mballoc.c | 102 ++++++++++++++++++++++++++--------------------
>>  1 file changed, 57 insertions(+), 45 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 018d5d3c6eeb..e3844152a643 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -6218,6 +6218,54 @@ __acquires(bitlock)
>>  	return ret;
>>  }
>>  
>> +static int ext4_try_to_trim_range(struct super_block *sb,
>> +		struct ext4_buddy *e4b, ext4_grpblk_t start,
>> +		ext4_grpblk_t max, ext4_grpblk_t minblocks)
>> +{
>> +	ext4_grpblk_t next, count, free_count;
>> +	void *bitmap;
>> +	int ret = 0;
>> +
>> +	bitmap = e4b->bd_bitmap;
>> +	start = (e4b->bd_info->bb_first_free > start) ?
>> +		e4b->bd_info->bb_first_free : start;
>> +	count = 0;
>> +	free_count = 0;
>> +
>> +	while (start <= max) {
>> +		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>> +		if (start > max)
>> +			break;
>> +		next = mb_find_next_bit(bitmap, max + 1, start);
>> +
>> +		if ((next - start) >= minblocks) {
>> +			ret = ext4_trim_extent(sb, start, next - start, e4b);
>> +			if (ret && ret != -EOPNOTSUPP)
>> +				break;
>> +			ret = 0;
>> +			count += next - start;
>> +		}
> 
> "ret" is only used inside the if statement, so this might be better as:
> 
>> +		if ((next - start) >= minblocks) {
>> +			int ret = ext4_trim_extent(sb, start, next - start, e4b);
>> +
>> +			if (ret && ret != -EOPNOTSUPP)
>> +				break;
>> +			count += next - start;
>> +		}
> 
> ... and then drop the "int ret = 0" above.
> 
> Otherwise, looks good.
> 

OK, I'll do it in next version

Thanks so much
Jianchao
> 						- Ted
> 
