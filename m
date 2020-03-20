Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41618D064
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 15:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgCTOX4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Mar 2020 10:23:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32949 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgCTOXp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Mar 2020 10:23:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id p6so6996007qkm.0
        for <linux-ext4@vger.kernel.org>; Fri, 20 Mar 2020 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+fZh5mNRoIP3/PNTapkxN1yeQArWRTIgoe3cXBf3JT0=;
        b=xUxS8YGwR3Zfpc1rTXnLlMM2oWbfu+gJ0nKd9OZa6alCOLEFNBHaUNhY/+jbQ3x6Jb
         0F5/qqRYsH6EJ7dzcknEtGWPIiBEyFUgErHS2JUnc/oEo/7xg0rRdWtjdgwa5R4WUcMe
         aVBr0d3sUViDCOL6eJbxTkdUOB62t+QMhE+8XLnI6I7yiM/79sYJTPenJ/mWlUUfvfyG
         xMC70kcBEdieLzXbeCp3gD5qh78mhby2Fu4n2ND5yp5ySooOF5vGl1E872JFbmZl5SAq
         fFnmjxGWSVkRDIyjvalb0DShaIHvNfn1vgVrfYk5QE5JaMHviFnnJtAhig5VYxIeoKJU
         Wz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+fZh5mNRoIP3/PNTapkxN1yeQArWRTIgoe3cXBf3JT0=;
        b=QTP19hRTMcr0C8//bdAsx0pOCK9OM57fwJwlfPZN/6ljJEsxpC+pzvPAJ5tOPckkpD
         7cqhO/zZLJDIXt9PQ0VVWW4YltBQZtLQ+kVCx2mnmEmUp7QNsrzbBBqAc+Qa4n3oC0Xg
         vjSDRP5yzGmVNZkPvJHWGKo7OtHkwiD63o/HVbyEWrphnASVH8kuJKog0F/n4BtdJyAy
         SnicJBhKG1GqFJFdc5PU0vIb3W8VZUwONbA+ligkLIlBnomClgehnUl/GzF1kHw8aAlb
         kzGqtCc/aEXLz0zEuW2dOU1gGwxGs8PBWsXwXYaIOE+9R+Lxvmz36GqjfOBv5HbvLXfR
         mg4Q==
X-Gm-Message-State: ANhLgQ1a7hLoeuUcBF7ctoIQHBfs5F42ofU5Gf4tVXmOzQgcp0u/2Y8n
        6KcX1Q2cOdv0IpO03GPRZ2ufxse4R7txlA==
X-Google-Smtp-Source: ADFU+vvORNZFIxutPmbqhADajII6yz3Pns2IyI8KGTafekY7YMWyCE8Avb0m2DkdS1l2wJW849kClw==
X-Received: by 2002:a37:a208:: with SMTP id l8mr7939521qke.302.1584714225006;
        Fri, 20 Mar 2020 07:23:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::1:7bd3])
        by smtp.gmail.com with ESMTPSA id d141sm4162926qke.68.2020.03.20.07.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 07:23:44 -0700 (PDT)
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
To:     Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, darrick.wong@oracle.com,
        willy@infradead.org, linux-btrfs@vger.kernel.org
References: <20200319150805.uaggnfue5xgaougx@fiona>
 <20200320140538.GA27895@infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <02209ec3-62b4-595f-b84e-2cd8838ac41b@toxicpanda.com>
Date:   Fri, 20 Mar 2020 10:23:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320140538.GA27895@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/20/20 10:05 AM, Christoph Hellwig wrote:
> I spent a fair amount of time looking over this change, and I am
> starting to feel very bad about it.  iomap_apply() has pretty clear
> semantics of either return an error, or return the bytes processed,
> and in general these semantics work just fine.
> 
> The thing that breaks this concept is the btrfs submit_bio hook,
> which allows the file system to keep state for each bio actually
> submitted.  But I think you can simply keep the length internally
> in btrfs - use the space in iomap->private as a counter of how
> much was allocated, pass the iomap to the submit_io hook, and
> update it there, and then deal with the rest in ->iomap_end.
> 
> That assumes ->iomap_end actually is the right place - can someone
> explain what the expected call site for __endio_write_update_ordered
> is?  It kinda sorta looks to me like something that would want to
> be called after I/O completion, not after I/O submission, but maybe
> I misunderstand the code.
> 

I'm not sure what you're looking at specifically wrt error handling, but I can 
explain __endio_write_update_ordered.

Btrfs has ordered extents to keep track of an extent that currently has IO being 
done on it.  Generally that IO takes multiple bio's, so we keep track of the 
outstanding size of the IO being done, and each bio completes and thus removes 
its size from the pending size.  If any one of those bios has an error we need 
to make sure we discard the whole ordered extent, as part of it won't be valid. 
Just a cursory look at the current code I assume that's what's confusing you, we 
call this when we have an error in the O_DIRECT code.  This is just so we get 
the proper cleanup for the ordered extent.  People will wait on the ordered 
extent to be completed, so if we've started an ordered extent and aren't able to 
complete the range we need to do __endio_write_update_ordered() so that the 
ordered extent is finished and we wakeup any waiters.

Does this help?  If I need to I can context switch into whatever you're looking 
at, but I'm going to avoid looking and hope I can just shout useful information 
in your direction ;).  Thanks,

Josef
