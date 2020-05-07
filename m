Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4122B1C8815
	for <lists+linux-ext4@lfdr.de>; Thu,  7 May 2020 13:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgEGLZP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 May 2020 07:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgEGLZP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 May 2020 07:25:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89037C05BD43
        for <linux-ext4@vger.kernel.org>; Thu,  7 May 2020 04:25:14 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u127so6382797wmg.1
        for <linux-ext4@vger.kernel.org>; Thu, 07 May 2020 04:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2lpFxtp+PnPKH0y8KGqk8gyNuZcyJ9kI5/gYrrFmZ0=;
        b=kRf+95BRQgH/5Btuew4a4tTbwwgKoC/g15RPUlbtvjC3wX5Jk2Akk9dw8BDNSZgPQ/
         AQ7/lDEQqnZSGFg02nuS8KVl5FXDsKSa0bvGKmPi0xdi/NrirfJn4TB3UI2tgXdbWoey
         XPXyqE4pcx/3eB7y2fJDUdP5MLvocaESReeO1YL1o/ypSX+QnGwz2OumgYam8+9zCfon
         iD2xPCaWDL+VUvdj/bwWy6jWwkvIL5LnPXb84pbLTzyyAiuCmJd52d1vwBisb56BDsA0
         l/qiU/73fCrx4p9+ZFsy1NHxyr2K3h7PX0Xq9Cmt9txSKQgOZ+24gkzfDW5kJPmi9CvT
         sLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2lpFxtp+PnPKH0y8KGqk8gyNuZcyJ9kI5/gYrrFmZ0=;
        b=oacP5IbE97vCAM5kdmPsqxIKMGjhP1rWnAON73Jkcrg0hh718yJ2mKrc+WykWLf6Z4
         NEA+oJzhsy++kioFY/iw0qbSTp5TOuEK/RtvsQI6zOAz6nb01wpit/IrNcRkg/M7Uq9C
         p3fGXqK7WSlhem0SmmacMMBTzMZDxbg1t29Q3r8x0nxOdqTipdZlWv2FZ0jA1PyTz/JK
         1UwTtRfalFbfG8Uid+Usjx8h3tOZdP8Cl5sOz3W0ZTG7GJbV8T3lfZjVt0TV6Mx3GY0b
         1bkT0PVx/j+dkUbwnAYR+zQyA7kdS/3SZm7QG/PBTfGXI3SpwlZ/H5ZSSXaCeRVOyi+z
         A4dw==
X-Gm-Message-State: AGi0PuatgRkyrEY6EzJQswUxCpIgGniXmfZV4DBjiozg98fl3jcQL4ly
        L5NF1D7JTSmQM3DQ0qL93eyMOT5ApHw=
X-Google-Smtp-Source: APiQypLTp2J9VBvHpUcyiqBAtBtENXCER+U8wyM8JBGAl1hrtCt8ykMGqQfxWhJEh7x09SDmf9PoQg==
X-Received: by 2002:a05:600c:2196:: with SMTP id e22mr9623475wme.105.1588850711917;
        Thu, 07 May 2020 04:25:11 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id v131sm7909639wmb.19.2020.05.07.04.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 04:25:10 -0700 (PDT)
From:   Jonny Grant <jg@jguk.org>
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
 <b518357b-4c79-910a-94dc-b6f0125309bc@jguk.org>
 <20200504195255.GC404484@mit.edu>
 <f1d8d13f-1605-a19c-e75c-1ecdb8c42fcf@jguk.org>
 <1AB6A7B0-245F-4951-A2BC-E6EA1495D505@dilger.ca>
Message-ID: <636e24b3-b286-dc21-48b8-0097b8782a23@jguk.org>
Date:   Thu, 7 May 2020 12:25:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1AB6A7B0-245F-4951-A2BC-E6EA1495D505@dilger.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 05/05/2020 19:50, Andreas Dilger wrote:
> On May 5, 2020, at 12:07 PM, Jonny Grant <jg@jguk.org> wrote:
>> On 04/05/2020 20:52, Theodore Y. Ts'o wrote:
>>> On Mon, May 04, 2020 at 08:38:33AM +0100, Jonny Grant wrote:
>>>>>> I noticed that mkdir() returns EEXIST if a directory already exists.
>>>>>> strerror(EEXIST) text is "File exists"
>>>>>>
>>>>>> Can ext4_find_dest_de() be amended to return EISDIR if a directory already
>>>>>> exists? This will make the error message clearer.
>>>>>
>>>>> No; this will confuse potentially a large number of existing programs.
>>>>> Also, the current behavior is required by POSIX and the Single Unix
>>>>> Specification standards.
>>>>>
>>>>> 	https://pubs.opengroup.org/onlinepubs/009695399/
>>>>>
>>>> Is it likely POSIX would introduce this change? It's a shame we're still
>>>> constrained by old standards (SVr4, BSD), but it's fine if they can be
>>>> updated.
>>> No, because it has the potential to break existing Unix/Linux/Posix-compliant
>>> programs.  There may very well be C programs doing the following....
>>> 	   if (mkdir(filename) < 0) {
>>> 	   	if (errno != EEXIST) {
>>> 			perror(filename);
>>> 			exit(1);
>>> 		}
>>> 	}
>>> For example, there may very well be implementations of "mkdir -p" that
>>> do precisely this.
>>> If we change the error returned by the mkdir system call as you
>>> propose, it would break these innocent, unsuspecting programs.  That's
>>> not something which will be allowed, because it falls into the
>>> category of a Bad Thing.
>>
>> Thank you for your reply.
>>
>> What's an appropriate solution to this problem?
>>
>> To achieve the desired output. when a directory exists.
>>
>> $ mkdir test
>> $ mkdir: cannot create directory ‘test’: Is a directory
> 
> I don't think it is reasonable to change the EEXIST return code just
> to make you happy.  However, it may be within your purview to change
> the mkdir(1) code to improve the error message:
> 
> 	rc = mkdir(name, mode);
> 	if (rc < 0) {
> 		if (errno == EEXIST)
> 			errmsg = _("File or directory already exists");
>                  else
>                          errmsg = strerror(errno);
> 		fprintf(stderr, "%s: cannot create directory '%s': %s\n",
> 			progname, name, errmsg);
>          }
> 
> or whatever you want.  If you are really keen, you could try to change
> the string that strerror(EEXIST) provides to be more generic, but that
> may also break programs that parse the output of mkdir(1) for some reason.

I doubt glibc would ever agree to change strerror(EEXIST).


> I would *not* recommend to change this to stat() the target name to
> determine the file type just to print the error message, as that is just
> useless overhead, of which there is too much in GNU fileutils already.
> 
> On the flip side, what is the driver for making this change?  The existing
> error message has been OK for users for 40 years already?

It's a pet peeve, saw it in some logs from our software, wondered if the 
message could be clear as I knew there is the EISDIR errno.

I recall someone else mentioned adding another mode flag, O_ to allow 
the kernel to return EISDIR if it knows that, that would work, then 
programs could enable it in the future.

Cheers, Jonny
