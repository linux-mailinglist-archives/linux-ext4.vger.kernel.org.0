Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611641C5F9F
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgEESH3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 14:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbgEESH3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 14:07:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72731C061A0F
        for <linux-ext4@vger.kernel.org>; Tue,  5 May 2020 11:07:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u127so3380177wmg.1
        for <linux-ext4@vger.kernel.org>; Tue, 05 May 2020 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fx7kZ2uSm1xU0XXkuL1rRzPHu6dl52TkjbxfxBH5rdU=;
        b=nyEhQ4UPzXvsPWOFh9tqB4Y/YGsJMDD8Cl06XYN4Bgsx6Xt4iiwYiAT/fuzjMCL+Ov
         RVvTDo4ZYRUuTaNLWywUbcHB1vx9EBSf/qRDaHbP+BNkFeqWmWcuEJDP0xp7MSY/jSPB
         Ll/oRABuNL0jfuZcyYupMgwjiUY8P6OzpgFwo9ptIZXjD+eZ0WW1K2VswmiTr6pDMIak
         gDXnWyDrrOmjtw+4DIpNYY0PLvSIr22mSJlK6Gifk5+DC75Hqk2ceIe0UrHzJq/S8et1
         Nh1OC4MbW96sUSzPR1gSJ7JGTpni267wJ7Q08CdqXI78TyFdqtuMudr61F+tG1gZYp8O
         ZQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fx7kZ2uSm1xU0XXkuL1rRzPHu6dl52TkjbxfxBH5rdU=;
        b=eP8JjN9RJWHH6bklfp0ESN28VSRp26ScXoa9h0VWjsCfMM+a0XQ8EAFH4d5Lw1rOaX
         sFszs9Eebxiy/pndw0UJOXK6sJ9Zi/6zrwrCn1Ez+25fecMYag/2poc0jFBmiSc/XDL9
         QooHdm22dbPPSj8SvH1F9ulO47+d5GBWgEDKRGg0nQus/FkqAvk8TA/s41sgUhzRSEEU
         dnfr4rRAXuSDyaRNqr1rQV9Pv5UZJPk1hgFonp2II6bYiEe93Hp/hCAn4Rs6roYIozrE
         ++rNFXlEJBC4ODAvIQW/xGBGsgzKynSpJRn49NcrSSwpQ1Gd9YLCtC2ZF3/apQMTfvXJ
         1c8Q==
X-Gm-Message-State: AGi0PuZ6Vlb/L5s0yjHJvl47bXryOIWoXJAjSAoE2veq9IQiuPDxsqLd
        gKRwsDF3PU+MbmuLCU6PrHxZEhfbDf0=
X-Google-Smtp-Source: APiQypKjfbAVilpBcMu4BJf5hfKFNURjwEtLDvIYm7LnV7YcGIBaBuTl45TRJbglcbVFUv4w1MCjQQ==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr3293wma.26.1588702046011;
        Tue, 05 May 2020 11:07:26 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id x13sm5238437wmc.5.2020.05.05.11.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 11:07:24 -0700 (PDT)
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
 <b518357b-4c79-910a-94dc-b6f0125309bc@jguk.org>
 <20200504195255.GC404484@mit.edu>
From:   Jonny Grant <jg@jguk.org>
Message-ID: <f1d8d13f-1605-a19c-e75c-1ecdb8c42fcf@jguk.org>
Date:   Tue, 5 May 2020 19:07:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504195255.GC404484@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 04/05/2020 20:52, Theodore Y. Ts'o wrote:
> On Mon, May 04, 2020 at 08:38:33AM +0100, Jonny Grant wrote:
>>>> I noticed that mkdir() returns EEXIST if a directory already exists.
>>>> strerror(EEXIST) text is "File exists"
>>>>
>>>> Can ext4_find_dest_de() be amended to return EISDIR if a directory already
>>>> exists? This will make the error message clearer.
>>>
>>> No; this will confuse potentially a large number of existing programs.
>>> Also, the current behavior is required by POSIx and the Single Unix
>>> Specification standards.
>>>
>>> 	https://pubs.opengroup.org/onlinepubs/009695399/
>>>
>> Is it likely POSIX would introduce this change? It's a shame we're still
>> constrained by old standards (SVr4, BSD), but it's fine if they can be
>> updated.
> 
> No, because it has the potential to break existing Unix/Linux/Posix-compliant
> programs.  There may very well be C programs doing the following....
> 
> 	   if (mkdir(filename) < 0) {
> 	   	if (errno != EEXIST) {
> 			perror(filename);
> 			exit(1);
> 		}
> 	}
> 
> For example, there may very well be implementations of "mkdir -p" that
> do precisely this.
> 
> If we change the error returned by the mkdir system call as you
> propose, it would break these innocent, unsuspecting programs.  That's
> not something which will be allowed, because it falls into the
> category of a Bad Thing.

Thank you for your reply.

What's an appropriate solution to this problem?

To achieve the desired output. when a directory exists.

$ mkdir test
$ mkdir: cannot create directory ‘test’: Is a directory

Cheers, Jonny
