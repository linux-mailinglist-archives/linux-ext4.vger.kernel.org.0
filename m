Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858744008F1
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Sep 2021 03:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbhIDBYT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 21:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbhIDBYQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 21:24:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B7C061575;
        Fri,  3 Sep 2021 18:23:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c17so757147pgc.0;
        Fri, 03 Sep 2021 18:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WAUchL1K8xTugSJMq/L+WthLaKkPMxmVeEzi7Gkydvg=;
        b=J+zjBJfT8aODlFyMGXOGVNZFnbutstsEatEUdIyWuQ6vpjXZWKJhFlpqfrdwkPjhlv
         RCLJJi7OW4NGti+X+9tTr1CSUV3zKvQbVs57yhIAeRloF2g5AcWbENRNEbnd+7d/8dHb
         TDoWOanTNsFlArxTOp7jPcW0gA1V+nAbqiS7vxwwlq42Mkz1xOd7Y+9/MK/5HdB6hF5g
         q6XYu+PaIMvhdstA7/UN1/Z52Pv2rNjLAHrAtrRb5EmsULYLgyVP2aN7D5XkjI1i6rrq
         OEcfUZ7lHeNHzw2Sb5pQjPEdyEqpavVb8+5wegolEsZqFwaVSgk1uvmy51lvHE6UXs9l
         eqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WAUchL1K8xTugSJMq/L+WthLaKkPMxmVeEzi7Gkydvg=;
        b=d27G08pgPjV5wnhMPM3Y3UUHXwwCE/7M6loFdPmJ7o5iUpDWZB5YoDNvadv/2faB5/
         NO8twq9BxcEuSGP+vf8A0V7FzgRcz7Ei6Wayvhb1B+wr+FuKgdpDqf2Wxan29VhYastz
         Tpp6N+5zpCKE0CdfhnWD4ZIzrIS9+nCv6/lDSMZyz1mFRcUU1M1bkxOaTcevG5xu5288
         7eFIWnzSw55Z2H3H2HhnaIMPE0XTOaO+jVZ5wjRNwCTujnwqZEXngYZGxLGzosycTwu0
         g75zg+2jSdgQU93PjRuUrUx32ZDmy+QhsW+afv2cnvp/YuBHA9Kgi8vv8PqmeN9/0vqI
         XxAw==
X-Gm-Message-State: AOAM5310+A1DRefwjplQSti2MgNLHrYphZ+NoOuRTsDEputYteLDdVwp
        gwzKIRJ/VXwGGjhgp7rr1xQ=
X-Google-Smtp-Source: ABdhPJz3iDIcgGgZxPlIFWnAYdOPcj0FdPd6SG3PzfE63/jcxe2EwUoWjxqbDZuYkfwyQLSFzZkukw==
X-Received: by 2002:a63:eb41:: with SMTP id b1mr1558809pgk.236.1630718595445;
        Fri, 03 Sep 2021 18:23:15 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n21sm509093pfo.61.2021.09.03.18.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 18:23:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] ext4: docs: switch away from list-table
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     jack@suse.cz, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Markus Heiser <markus.heiser@darmarIT.de>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20210902220854.198850-2-corbet@lwn.net>
 <b1909f4c-9e07-abd7-89ee-c2e551f9dc5b@gmail.com>
 <871r65zobl.fsf@meer.lwn.net>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <a93af4a2-9b9f-6430-bc3a-dfb2dbf7e56b@gmail.com>
Date:   Sat, 4 Sep 2021 10:23:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <871r65zobl.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 03 Sep 2021 09:11:26 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
> [Adding Mauro]
> 
>> On Thu,  2 Sep 2021 16:08:53 -0600, Jonathan Corbet wrote:
>>
>>> Commit 3a6541e97c03 (Add documentation about the orphan file feature) added
>>> a new document on orphan files, which is great.  But the use of
>>> "list-table" results in documents that are absolutely unreadable in their
>>> plain-text form.  Switch this file to the regular RST table format instead;
>>> the rendered (HTML) output is identical.
>>
>> In the "list tables" section of doc-guide/sphinx.rst, the first paragraph
>> starts with the sentence:
>>
>>     We recommend the use of list table formats.
>>
>> Yes, the disadvantage of list tables is mentioned later in the paragraph:
>>
>>     Compared to the ASCII-art they might not be as comfortable for readers
>>     of the text files.
>>
>> , but I still see list-table is meant as the preferred format.
> 
> Interesting...that is not at all my memory of the discussions we had at
> that time.  There was a lot of pushback against anything that makes the
> RST files less readable - still is, if certain people join the
> conversation.  Tables were one of the early flash points.  
> 
> Mauro, you added that text; do you remember things differently?  Do you
> feel we should retain that recommendation?

No, the text was first added by Markus Heiser [added to CC] in commit
0249a7644857 ("doc-rst: flat-table directive - initial implementation")
and have not updated ever since.

He might remember the circumstances, but 2016 was a long time ago,
I guess.

Or did the discussions take place after the list table support had been
added?

        Thanks, Akira (a newcomer to kerneldoc)

> 
> Thanks,
> 
> jon
> 
