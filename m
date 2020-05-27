Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9B1E506E
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 23:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgE0VZt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 17:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0VZs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 17:25:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310DC05BD1E
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 14:25:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j198so3113229wmj.0
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y8a5b+BEYGGMv1uyQedmu9enutxmbpDh6hI6K2o3PVQ=;
        b=PPWRUkvYu9FgJUIvDNsntQ7UloVhYCiYVNM1aQuqD7yLcQxGBdbOTemS5UIhQi3K5R
         gcrW9+RBmf5FRTaCn/bkqvpb2+BmvARpXc9lctdeXP8UVMwo1TsKXMmP/9oESqVnSt4k
         THBMA15dtIYiL06Fa92Q8D3D/83Mpc7KngZTdZTsn/8RooMe9x/Z4r3sd5IEW47J9jPP
         kWZr0pY9U0qTWPno1CLwwuyFRdJzBIUynxpMhJBQvAG5maUlJ+0djkw9PsWQ0O9H5WZr
         4dV5qkGxRiSfcZjvrTbp66J8dLgeCTZxWRY4CpGytNyi3moJ0tMprbSYpC/Rtph42cco
         0hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y8a5b+BEYGGMv1uyQedmu9enutxmbpDh6hI6K2o3PVQ=;
        b=dqYWanFFc+4jwUKBmCvweIcBxcLhG73dfZspy79JTKbsuSs+4glYboRryCzJVc4D5b
         LR6wGLKk+xbdYZuEr+ENITIP5jFPkQlnX6aDcoXmiPjVrvh2204UNQLg3+uNWDEwPcAK
         0fncMXeN0O9P9kkDDVbCAQ9YiNWeKMtMQ6XA2pU6TGKa55sBPrVkgE0q2vzgc/auJU7p
         LwsTMsOY9h+kkDOc5PSBq6wAC68BXtxvqm7bQGZEg6nfBBr0WkE1MkO9VvYJqRlBmb/T
         pEJAJQK5uzzqJ468RCQ01Z3itSpuyphsbsu7sHNid2Yj4ARAmImMJkQ3JNlommfS+RS5
         xs/g==
X-Gm-Message-State: AOAM533kVPSMSR/ZiVUfPIfdflJD6TJgvGvJqS4mn1kusRbs4Rto17IM
        RhBCf025dMnhl5T1J7U09cnXYTsCJn8=
X-Google-Smtp-Source: ABdhPJxrlGPFM8IwF9LcWm7yn3Q1mBEcT1T0pwN1hmkCJv/7bUz7ioXcGwBsLsksuC01KI7KR72d0Q==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr91780wma.174.1590614746153;
        Wed, 27 May 2020 14:25:46 -0700 (PDT)
Received: from [192.168.0.12] (cpc87281-slou4-2-0-cust47.17-4.cable.virginm.net. [92.236.12.48])
        by smtp.gmail.com with ESMTPSA id i15sm3851509wml.47.2020.05.27.14.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 14:25:44 -0700 (PDT)
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
From:   Jonny Grant <jg@jguk.org>
Message-ID: <e6e172ae-ba19-f303-3aa9-a388adba8cb0@jguk.org>
Date:   Wed, 27 May 2020 22:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504015122.GB404484@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
> 

Thank you
This is the POSIX mkdir():
https://pubs.opengroup.org/onlinepubs/009695399/functions/mkdir.html

How about adding an improved mkdir to POSIX and the Linux kernel? Let's call it mkdir2()

It has one more error, for EISDIR

[EEXIST]
The named file exists.

[EISDIR]
Directory with that name exists.




I'm tempted to suggest this new function mkdir2() returns 0 on success, or an error number directly number. That would 
do away with 'errno' for this as well.

Regards, Jonny
