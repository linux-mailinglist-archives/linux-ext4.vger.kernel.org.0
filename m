Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1354E36AC0F
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Apr 2021 08:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhDZGQb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Apr 2021 02:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDZGQb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Apr 2021 02:16:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE46C061574
        for <linux-ext4@vger.kernel.org>; Sun, 25 Apr 2021 23:15:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id h11so7218989pfn.0
        for <linux-ext4@vger.kernel.org>; Sun, 25 Apr 2021 23:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xBi8rWFCOuAu/mw5XW+KDcCvWed0QIWq8cUNK1fsQYQ=;
        b=pBtnqD2IxbM75q6awAod8WQt6BLVb/tQDGLPkaqrMA6atzOWAQN08w0/9gIlUb38Ys
         FQYjhnKDUav/oCW4ipOOcWeEGTYdwxFuOqzhRv7K0N1jZhvYcJJY2o08sxYAPATVVE6w
         /2W4UyGGvdKoX3gzamnu6fLGoKkLqjNA97xXgs+UebPvNNezkGNpjwunjxgL8LO+ctFE
         y/DJk0Hytk7WlFsiLQogDvav8li+2dnKT6RmygVdIiPUbVLvYCRD1RcZyA6MP2CBGoMI
         okKNwZVbI7dvCWRFtmjdQQ0pHO7ZIL5TLU5Tkua/ZFAmzjD4Ob2R16jglmsUkgcq2nPA
         PiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBi8rWFCOuAu/mw5XW+KDcCvWed0QIWq8cUNK1fsQYQ=;
        b=T42Yd/su2a+aokg0yKUhu3OF4348BWUp5mXcDqcpMdtqwFYRpfKIp0OUtek/UxQ+g4
         T5RRp+Y9RbXx/t2CO1gkUnEeO2sIeQm876A8ak2nQOiwTtJvxOTIIWfwxgnYFzAgOPl0
         Pn06/h99hwUE1/6UHR7pid3y12xlnOO8vS75x+SzOyQ5tRIK6B7WELPcZxbOPqgnssOc
         fa5kKcwAE578617RVawDmQptcbiMazEy8e0Uy6lxbky628qOb2BF7KfikonjdUSdQpMA
         VPx03NybmotU1C7g9jRVcSFYNzxE4gmKLrxugFhQxAfgyB5AdYhnbYhmqLkNV4oxfRzp
         6Ivw==
X-Gm-Message-State: AOAM533tMpjcUvrB2pOTR8hftn7fx0EoyvmJ39oV0vZrMpdwiAhWYu08
        AJFvZxFp4oH1IpzKXkM1lgaOvqKlYDQ=
X-Google-Smtp-Source: ABdhPJxWRiyK6UdldpjNChMAkjhmJSHgvdjC13tj1Fz3kNd06vPBDi1R6NsROejivfJDugQtZWbsow==
X-Received: by 2002:a63:531b:: with SMTP id h27mr15434207pgb.395.1619417747823;
        Sun, 25 Apr 2021 23:15:47 -0700 (PDT)
Received: from B-D1K7ML85-0059.local ([47.89.83.93])
        by smtp.gmail.com with ESMTPSA id e13sm9980505pfi.199.2021.04.25.23.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 23:15:47 -0700 (PDT)
Subject: Re: [PATCH] ext4: remove redundant check buffer_uptodate()
To:     riteshh <riteshh@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <1619407399-72280-1-git-send-email-joseph.qi@linux.alibaba.com>
 <20210426050545.m3fbtlwdf32lgqvu@riteshh-domain>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <4314943d-b39b-3f00-2b60-41756e6675f3@gmail.com>
Date:   Mon, 26 Apr 2021 14:15:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210426050545.m3fbtlwdf32lgqvu@riteshh-domain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/26/21 1:05 PM, riteshh wrote:
> On 21/04/26 11:23AM, Joseph Qi wrote:
>> Now set_buffer_uptodate() will test first and then set, so we don't have
>> to check buffer_uptodate() first, remove it to simplify code.
> 
> Maybe we can change below function as well then.
> No need to check same thing twice since set_buffer_uptodate() is already doing
> the check.
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index b258e8279266..856bd9981409 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3749,7 +3749,7 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>          * have to read the block because we may read the old data
>          * successfully.
>          */
> -       if (!buffer_uptodate(bh) && buffer_write_io_error(bh))
> +       if (buffer_write_io_error(bh))
>                 set_buffer_uptodate(bh);
>         return buffer_uptodate(bh);
>  }
> 
> With that pls feel free to add:
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 

Sure, will send v2 with above addressed.

Thanks,
Joseph
