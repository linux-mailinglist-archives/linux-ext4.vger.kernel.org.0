Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E9F403CC4
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 17:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352144AbhIHPqz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349643AbhIHPqy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Sep 2021 11:46:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAFFC061575;
        Wed,  8 Sep 2021 08:45:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u9so3971627wrg.8;
        Wed, 08 Sep 2021 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=02nKNTZz4THGLXDioBZTClADgZqVZV+M2gzGsJDR+PE=;
        b=Hh3dGOKDFOKWaG7ja2vAuArKHueEeutQh+i5S5Tbr18Je8z5/ByM7hA7gnVm+rl+r3
         jql33t2TnSVtaQS8ZJBmOtwFK+HCLpqxivoQJlD9iPfQh/huaZpVlxgjFDZBwS8FWNvt
         mthWvFI6g37b83XkUmW0LMjGXk0zdvgmXCy5NusZ2m7ybvonx7nc2wJtttGuZRi4TW8A
         jvSSJWcFGWmDIgUQpk7Sfm40pUJyrEsmk+QbIiPE4+GS8BkR4h+9q4FRAPeZ81nNdWbj
         U+gB124Y2Ld0vjCY2JSkhTX5ce531jEsP6l0YK9GgNAqp29Y/1+UcOhM1SyDgwRN3Wnw
         Yn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=02nKNTZz4THGLXDioBZTClADgZqVZV+M2gzGsJDR+PE=;
        b=cKvZwXow7BC0ODhcphMrsUVS4WnVpn1yNp+weOHkda9AKmlY5NTQWuEFdjiWa65Gv+
         tnl4QQ5ZzAi3LUpj4gG5HCbUvy3CtyjKlqnOHqq6e38hQOZ3IczzfF5lCCJyl1dzQjQo
         p7hC9F//OqhFtb0LRMyHw1AdfWBAir3mbvf5jXDQzdvPf6fevPJb83MUUVRybfrDsmnQ
         UBd/cV8rCV5l7rSVsHEEBLoOi00Dh9oa3LZlu8kTpe4zPSd7mGJdpyLlObzR+M4qXWVh
         YT/j1IFMOxMCGNK72kUJ/wzIHfg9673OLOvs0cxPLQIF3PnD8txQ8bINDm/6tuxg5+k8
         nKGA==
X-Gm-Message-State: AOAM533rmOxwK0sitMQqyBH2qyCxxRT0bT5wjjntv+CjLcjBW1opYD4H
        e2blMVmYmLp37C4LnRy2ffM=
X-Google-Smtp-Source: ABdhPJwRnB8jrEG1KuMGkMPUZ7im6sfqUGdrBP9RjNNqkOFa7xd84in8VlDd5LMb8g4ESCuig0WdXA==
X-Received: by 2002:a5d:6307:: with SMTP id i7mr4886037wru.395.1631115945512;
        Wed, 08 Sep 2021 08:45:45 -0700 (PDT)
Received: from [10.168.10.11] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id a203sm1349853wmd.42.2021.09.08.08.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 08:45:45 -0700 (PDT)
Subject: Re: [PATCH] filename.7: new manual page
To:     "Thaddeus H. Black" <thb@debian.org>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        linux-ext4@vger.kernel.org, debian-doc@lists.debian.org,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <YTX+PEtj60O/TdMh@b-tk.org>
 <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com> <YTjPHZEpjzn7Ufg/@b-tk.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <1543a191-66f9-3cb5-1903-277242e9204c@gmail.com>
Date:   Wed, 8 Sep 2021 17:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTjPHZEpjzn7Ufg/@b-tk.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Thaddeus,

On 9/8/21 4:56 PM, Thaddeus H. Black wrote:
>> You could move sections into subsections of DESCRIPTION, and the current
>> subsections into tagged paragraphs (.TP).
> 
> Question 1:  do you happen to know of a good example of an existing
> manual page that already does this?  If you did, then I could follow the
> example.  Otherwise, it might be tricky, for the existing subsections
> already have tagged paragraphs and other structure within them.
> Perhaps .RS/.RE could be used.  I am not sure.

I don't know of a page that does this, and some of them are a bit 
inconsistent, so I'd have to search through the source code of the pages 
to find one that is a perfect example.  So I'll write/draw a schema here:

You could do it like this:

.TP
	tag 1
.PP
		paragraph 1.1
.IP
		paragraph 1.2
.IP
		paragraph 1.3
.RS
.TP
		tag 1.4
.PP
			paragraph 1.4.1
.IP
			paragraph 1.4.2
.RS
.TP
			tag 1.4.3
.PP
				paragraph 1.4.3.1
.IP
				paragraph 1.4.3.2
.IP
				paragraph 1.4.3.3
.RE
.IP
			paragraph 1.4.4
.RE
.IP
		paragraph 1.5


Was it helpful?

Disclaimer:  I didn't test it; I'm talking from memory.
Disclaimer 2: indentation is just to show results; obviously, don't 
indent your input :)


> 
> I notice that bash(1) does not follow your advice but dash(1) does.
> However, dash(1) has no subsubsections.  In any event, a manual
> page *about* conventions, like filename(7), should *obey*
> conventions.  I just need to figure out how to obey with good style
> in this instance.
> 
> On the other hand, there is an alternative, though I do not say whether
> it is a better alternative.  The alternative would be to avoid
> subsubsections by using colons ':' in subsection titles, instead,
> approximately as follows.
> 
>      NAME
>      DESCRIPTION
>          Legal filenames
>          Legal filenames:  reserved characters
>          Legal filenames:  reserved names
>          Legal filenames:  long names
>          Legal filenames:  non-UTF-8 names
>          Conventional filenames
>          Conventional filenames:  the POSIX Portable Filename Character Set
>          Conventional filenames:  special semantics
>          Conventional filenames:  the full stop to introduce a format extension
>          Soft conventions
>          Soft convention:  low line versus hyphen-minus
>          Soft convention:  letter case
>          Locales and Unicode
>          Unconventional filenames
>      CONFORMING TO
>      SEE ALSO
> 
> Question 2:  within the constraints of established manual-page
> conventions, which alternative would you and Branden advise?

I think tagged paragraphs as subsubsections is much more common (and 
logically organized).

> 
>>> +The format-extension convention is all but universally recognized.
>>
>> Non-native English speakers may have trouble understanding "all but". Maybe
>> s/all but/not/?
> 
> When a reviewer like you informs me that (for whatever reason) he or she
> did not understand a sentence the first time he or she read it, this is
> valuable feedback; for if the reviewer did not understand it the first
> time, then other readers probably also will not understand it the first
> time.  The sentence ought to be rewritten to make reading the sentence
> twice unnecessary.
> 
> In the sentence in question, I did not mean "not" but rather "almost."

Then I got it very wrongly :).  I thought you meant more like "far from 
being universally recognized".

"almost" seems good to me.


> 
> Question 3:  in your opinion, would s/all but/almost/ make the sentence
> more readable?  If not, then another option would be s/all but/nearly/.

almost is good.

> 
> (For information, I have some time to work on the patch today but little
> time during the following two or three weeks.  Therefore, if I am slow
> to reply after today, this does not mean that I have forgotten!  If not
> today, then I will deliver PATCH v2 some time on or before Sept. 28.)
> 

Thanks,

Alex

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
