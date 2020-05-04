Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574631C33C4
	for <lists+linux-ext4@lfdr.de>; Mon,  4 May 2020 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEDHii (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgEDHii (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 03:38:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2BDC061A0E
        for <linux-ext4@vger.kernel.org>; Mon,  4 May 2020 00:38:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h9so9327055wrt.0
        for <linux-ext4@vger.kernel.org>; Mon, 04 May 2020 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2joa5tIJVPwICNpI03N6qHYqU7dZ+gjfpoSfovCLDc=;
        b=M7l40f3tgf2i73KcxtnTfBzN8vCbcqScmPlx7tu8XGIsoA8srM/iVtaBiTbMf7y4BN
         beHwMUayNrDWhFxPWorCEvZeJDhoDzTHfS5XsI0dJg/cjZIiHapf6hpuTcs2T9LFYDF2
         1V5hCoq3PlVuM3s3PWKISWJhIRb9lwruSdrxveohiL+32BW7ph0FwyI266GrhX/IkavH
         T0EJnemlJmfbrP0N0dcMZhudw7AAL8IMRzJME0hQTD28UJtj6ld2BnqJHOd1PUE8qBRd
         qTAsGr6EjdGRiKOmX7mAmDfsaod2NtF3ldjnOnT0aMvfLuu8mBvqhlghVq0KElnlzBP5
         SHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2joa5tIJVPwICNpI03N6qHYqU7dZ+gjfpoSfovCLDc=;
        b=Cz6XFZmfvVjVR8SRqNGBVcTBHiJozVgHAryEVqeY7L6IQir5mI+klX+WdnvzZub1ex
         WaSCEw0+6P52HRAbPro6Agj7fVu9cHesyfaKGpHyD3U+rSaOs5Tac6uEjvDtdWHGo8Fd
         z4vclcZ20cPkTg/Mo4lSXZtZH7fV0ErvSSENnubZmv3F0lsRz1rwon60kjS/b4x2su5p
         uEzpHiaNuMkA6Qp2gBIFNMMzCVx83XIQKPYiKkckBkHP0mJ6/sveO7iAf6UJCsA/3DWe
         gq9LeH+sLTel163TMcPbmTDKZZRes5QJ1ghihS2tfATPP2fr3LMntodXntF8adgEk9PJ
         DBDw==
X-Gm-Message-State: AGi0PuZA+UnB40S6/4yOWyVIv8yYAgOdrNZxg1rwbOcycFWfNk0wLXss
        xB212slp66lqUACLt4IihN0vdJPSz+M=
X-Google-Smtp-Source: APiQypL8DBle77R1AHxQqhElhvtEwMoxRuPwJzw7oKPMcZ3BtgHX7W/AkN5nxLrkrcFV5/sUMM9uVA==
X-Received: by 2002:adf:8401:: with SMTP id 1mr18336326wrf.241.1588577914983;
        Mon, 04 May 2020 00:38:34 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id 32sm15922893wrg.19.2020.05.04.00.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 00:38:33 -0700 (PDT)
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
From:   Jonny Grant <jg@jguk.org>
Message-ID: <b518357b-4c79-910a-94dc-b6f0125309bc@jguk.org>
Date:   Mon, 4 May 2020 08:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504015122.GB404484@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 04/05/2020 02:51, Theodore Y. Ts'o wrote:
> On Sun, May 03, 2020 at 02:00:25PM +0100, Jonny Grant wrote:
>> Hi
>>
>> I noticed that mkdir() returns EEXIST if a directory already exists.
>> strerror(EEXIST) text is "File exists"
>>
>> Can ext4_find_dest_de() be amended to return EISDIR if a directory already
>> exists? This will make the error message clearer.
> 
> No; this will confuse potentially a large number of existing programs.
> Also, the current behavior is required by POSIx and the Single Unix
> Specification standards.
> 
> 	https://pubs.opengroup.org/onlinepubs/009695399/
> 
> Regards,
> 
> 						- Ted

Hi,

Is it likely POSIX would introduce this change? It's a shame we're still 
constrained by old standards (SVr4, BSD), but it's fine if they can be 
updated.

As  developer, I can see it feels more confusing for users as it is. 
This issue shows up in various programs.

$ mkdir test
$ mkdir test
mkdir: cannot create directory ‘test’: File exists


I would expect it to be clear for users:

$ mkdir test
$ mkdir test
mkdir: cannot create directory ‘test’: Is a directory


The 'mkdir' team don't want to add a call to stat() to give a more 
appropriate error message.

Cheers, Jonny
