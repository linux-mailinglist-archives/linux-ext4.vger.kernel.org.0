Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05F243748
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMJJA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 05:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMJI7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 05:08:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81922C061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 02:08:59 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so2481161pjb.4
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eCQXqsI/+Y3a8vPNcIZMjCCCoQ8W3fqck/Fd7FWzJ3o=;
        b=V6JAay5cGk4oCT0pWnvHYw3/28jmk6xAcIUc1HfoqGAn8p0On/DpeW8N2BpJbjP0Pa
         5h4XyymUoKUwHyLmdoDWnixB/FAAXFa8zMOVfZIYTt2+x0o3Q7ZtCMcQiQdeunIvIxBL
         4rtyd3h1mN9aSQcDcInR6spnfss5DlcBqDgQuN4oZ+3613jqbDTf7BECda7ExSh5oql4
         btAXJJGNzC6Hkntb9jv5Af433926DZfO9jHiTTqjeNM8+3X0TTjz7R++GoJHjPRXW/ja
         bGxJSCHeMSKQxqn8vH/y9l90Fe7LEAdFOamlKYuYTaP0SYEPEEPmhPRee6dmUdSDorr7
         uKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eCQXqsI/+Y3a8vPNcIZMjCCCoQ8W3fqck/Fd7FWzJ3o=;
        b=OlhuoHjj+EsVgJSPHkbbM2h89Jb5PsZSgT/snChdWxEo6lKxJaBHBaTSlvDbYM7kLm
         CXbFOjI/wCc7DJqmdiOC4pnIA5co03VyI9bCGK/wGfOctTOgysHpeQAYyHFwc+yoOiSY
         pqwnOaoUhu6NqGM3moe+t+NcrssNFB++DGweRIQIze2+B3GCAPzPLlugTnNb/4w2iB7l
         CJHBJhi0xzFNHzU54hiL8xrwEViQMikZd6D9WcimXd4Q8RHldY/V/N8gJUSLqcH/6IlU
         iDUvFAr1qLETy190AJEfz/BaH/aJYSylcM/mTJZ7raYT//Mq6P5RvCvzAmfKvovj3mgg
         rdlg==
X-Gm-Message-State: AOAM533n4DSikILfvyQdC8X1jMPz0bRR4MlIWx90IlRHI46MdQ/iA645
        xOC2oANMFbKVrOyHJjLY0YXv/MwB
X-Google-Smtp-Source: ABdhPJxfzzR7ecPSNA9CeD85yFPkD6qPLzzV+6kMBuADmXgSjyzA1UGY4IdkEqGFrlDFV0YTzYBzAw==
X-Received: by 2002:a17:90b:8c5:: with SMTP id ds5mr4061820pjb.110.1597309738927;
        Thu, 13 Aug 2020 02:08:58 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id b26sm5257701pff.54.2020.08.13.02.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 02:08:58 -0700 (PDT)
Subject: Re: [PATCH v2] ext4: delete invalid ac_b_extent backup inside
 ext4_mb_use_best_found()
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <0c77de22-c0d0-4c1b-645a-865bcd2edc0a@gmail.com>
 <B72B3282-4D45-41BB-8A39-66618C1CE69A@dilger.ca>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <099d2ffa-245d-c6d0-4515-db76d925a947@gmail.com>
Date:   Thu, 13 Aug 2020 17:08:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <B72B3282-4D45-41BB-8A39-66618C1CE69A@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Thank you very much for taking the time to review this patch. Due to poor thinking, there are some
problems with this patch. I think this patch can be ignored. Thank you again for your time.

thanks

Andreas Dilger wrote on 2020/8/13 16:44:
> On Aug 7, 2020, at 5:32 AM, brookxu <brookxu.cn@gmail.com> wrote:
>>
>> Delete invalid ac_b_extent backup inside ext4_mb_use_best_found(),
>> we have done this operation in ext4_mb_new_group_pa() and
>> ext4_mb_new_inode_pa().
> 
> I'm not sure I understand this patch completely.
> 
> The calls to ext4_mb_new_group_pa() and ext4_mb_new_inode_pa() are
> done from ext4_mb_new_preallocation(), which is called at the *end*
> of ext4_mb_use_best_found() (i.e. after the lines that are being
> deleted).
> 
> Maybe I'm confused by the description "we *have done* this operation"
> makes it seem like it was already done, but really it should be
> "we *will do* this operation in ..."?
> 
> That said, it would make more sense to keep the one line here in
> ext4_mb_use_best_found() and remove the two duplicate lines in
> ext4_mb_new_group_pa() and ext4_mb_new_inode_pa()?  In that case,
> the patch description would be more correct, like:
> 
>     Delete duplicate ac_b_extent backup in ext4_mb_new_group_pa()
>     and ext4_mb_new_inode_pa(), since we have done this operation
>     in ext4_mb_use_best_found() already.
> 
> Cheers, Andreas
> 
> PS: thank you for taking the time to look at this code and improve it.
> I know it is complex and hard to understand, but going through it like
> this and trimming off the bad bits makes it a bit easier to understand
> and maintain with each small patch.
> 
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 9b1c3ad..fb63e9f 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1704,10 +1704,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>> 	ac->ac_b_ex.fe_logical = ac->ac_g_ex.fe_logical;
>> 	ret = mb_mark_used(e4b, &ac->ac_b_ex);
>>
>> -	/* preallocation can change ac_b_ex, thus we store actually
>> -	 * allocated blocks for history */
>> -	ac->ac_f_ex = ac->ac_b_ex;
>> -
>> 	ac->ac_status = AC_STATUS_FOUND;
>> 	ac->ac_tail = ret & 0xffff;
>> 	ac->ac_buddy = ret >> 16;
>> @@ -1726,8 +1722,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>> 	/* store last allocated for subsequent stream allocation */
>> 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> 		spin_lock(&sbi->s_md_lock);
>> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
>> -		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
>> +		sbi->s_mb_last_group = ac->ac_b_ex.fe_group;
>> +		sbi->s_mb_last_start = ac->ac_b_ex.fe_start;
>> 		spin_unlock(&sbi->s_md_lock);
>> 	}
>> 	/*
>> --
>> 1.8.3.1
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 
