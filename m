Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636E549E578
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jan 2022 16:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242809AbiA0PJ0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jan 2022 10:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbiA0PJY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jan 2022 10:09:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5539C061714
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jan 2022 07:09:23 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso2072194wme.5
        for <linux-ext4@vger.kernel.org>; Thu, 27 Jan 2022 07:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embecosm.com; s=google;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q9QBFDAqqouYlyr0jMPHy+6Jy7f8uGNXIPKhu60Tguw=;
        b=PzZN6clfrSgII+sbcIBG3+l4Gx/dbWaItSboXcwQmQPA+6VuJ1jv/b6e6wAs54Vmn7
         GFW7kLaakohm0G+nG+0THpC/Qo3m0zcLipVRl+f2eIkQW2W8wh+8DPoevLPuzOcC8WPi
         wMHeZx56fyoqxYzubkMIO7gl+1SScDV2HZ9m9dCYsm9slgy6Q3mvJ2ZmepqUEzjrmY36
         1xPrbRpMFbl6SNmJqIDoe0OrGZklgnoSB5SWtNvkc2c0OHk8qvv+Nwt2nfTVLNNE0Y0p
         crROOnex1OzaLHqzW+cTFqz+2/z9/sXZNNG5qt9pGDyTmM6W81qWjK70jzCwTB+TmeFP
         Hm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q9QBFDAqqouYlyr0jMPHy+6Jy7f8uGNXIPKhu60Tguw=;
        b=sb0ePhC/Uio+Yuy/VPSP1okzOwQQ0PEdF2rFsUzacovW/BLN+4qQ6Fou/g35odQVMi
         4V/QN2tzh6Vs1D/SufbamomIgEf/pIEwdAxSk1GcCyv+2nJU6LagVLxOy/hQcJWXzKE0
         nqWhX3YEi/vYqAKwzfbUXRBzCTI4983yxIItuQvGQKQRVTi/vXqT67e0aWePaQzC3B9e
         Y4cOIcAymnT8IUvPDLMj6AJEdUMEmmk6O+VkMZCTt1k+svjpGrf9GRyfyC7mtpPq5GRI
         EWrjU7mbMrbUWyr/UQJr6TMUsDfjd4yJMehWLxbMtbr4AkX4BY66OAy2l9mH0tcCW+eE
         Lt2Q==
X-Gm-Message-State: AOAM532miak7c8XZnSp6imrCeRB40ngbPvapjDsfJnYLfhLjTZs4zYTa
        T0dxNfpr7iY5GtLvCO2qIVvnsQ==
X-Google-Smtp-Source: ABdhPJyjzNwl503vJxXMQViNsp3qKDCzFACpd8m6jsk5JVfDyms+t6Lu+s2ksEvtPsddGf0gq06zwQ==
X-Received: by 2002:a05:600c:264d:: with SMTP id 13mr3594062wmy.85.1643296162557;
        Thu, 27 Jan 2022 07:09:22 -0800 (PST)
Received: from [192.168.88.236] (79-69-186-222.dynamic.dsl.as9105.com. [79.69.186.222])
        by smtp.gmail.com with ESMTPSA id 8sm6577922wmg.0.2022.01.27.07.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:09:22 -0800 (PST)
To:     Matthew Wilcox <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
 <20220127122039.45kxmnm3s7kflo6h@riteshh-domain>
 <YfKg3DQS0h2lPo3z@casper.infradead.org>
From:   Maxim Blinov <maxim.blinov@embecosm.com>
Subject: Re: Help! How to delete an 8094-byte PATH?
Message-ID: <a57e2fde-f430-952d-9878-d7a5307cb2db@embecosm.com>
Date:   Thu, 27 Jan 2022 15:09:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YfKg3DQS0h2lPo3z@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Matthew, Ritesh,

On 27/01/2022 13:40, Matthew Wilcox wrote:
> here's an idea:
> 
> while true; do
> 	mv confdir3/confdir3 tmpd; rmdir confdir3; mv tmpd confdir3;
> done
> 

Thankyou for all your comments - mv'ing a child directory "up" and
deleting *that* did the trick!

Infact I was complaining about this to some colleagues who kindly
pointed me to this thread [1] where someone has exactly the same issue.

Searching for `confdir3`, it turns out this issue is more googleable
than I initially realized - there's quite a few others who have bumped
into these weird path length limitations, in particular with docker
(there's another thing I forgot to mention - to be clear, I'm running
QEMU inside a docker container.)

Still it seems strange, since the QEMU VM disk image is a static file
within the docker file system, and there are no bind mounts going on in
the container.

[1]: https://github.com/moby/moby/issues/13451
