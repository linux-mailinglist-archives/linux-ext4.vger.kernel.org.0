Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3623E73B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHGGYz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 02:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgHGGYy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 02:24:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF7C061574
        for <linux-ext4@vger.kernel.org>; Thu,  6 Aug 2020 23:24:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so411485pgc.8
        for <linux-ext4@vger.kernel.org>; Thu, 06 Aug 2020 23:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bFP16p2P8gD88iibmtB1BNRspRwrMlnrlXv5BxzbMJg=;
        b=LM5bLcWfZAZqYRx81m0fS4W/2DazgVJzAweUWFWqHedq/ocqo2hn4DBHN2gjQSJGiW
         WVe9Ao0YI4Sq/Nb7tQ+mGdXbojAYfAoBNVuKYldYIifiwq4fXsxj6ykNPOZyF3KXwgXc
         30UtWA3+hBCWEUQpWtLhapGwgVYuhWxd+L+4FNurH3g/i5//cFc4RJUpBycqDx1fO5Ty
         MODSWQk7/Krm82lmMqgz/oTi4Jvaa7FA6neEfb6Qp1KMuDUkaWg3ORZxS8QE7uPe09Mz
         0LXF6Z4p/NnTvzLiI1cRoKyAsg4jvrq82GQ2XlyrI6Ag3BEgmWE4CYUGsNPc84yZenmh
         1aTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFP16p2P8gD88iibmtB1BNRspRwrMlnrlXv5BxzbMJg=;
        b=FlGzbncT+A3q58sRsFlLVgVInvfYLxVr7dix+psho8W3WnFXMuYI94tSM0L+/eyjWo
         znKnqFEFd00dqwj7FFU12UBEcAAy3RMo1H15IsSVxFZSu0lE14BX6np0y0Jrmqi3cb/h
         5DxBcAd25Acg1MM9o8sDw3dOFvHpGbryvNyHRvlZetqcWCh1WUqYVZaoMtMmjY4TmYY3
         bQPK8FVWE3Y7v2soBVuT6oDCcPrt9+eSS/D7q3AOIPSSeoLLLt+3mbixkugCJL2TdISD
         /DiusstWwl1t5xzjiSx+S7XnEeceLXtmvCFbZQZnNoj/P0B4GzaDVX40qX4rkdVbr5Cn
         K6YA==
X-Gm-Message-State: AOAM531k6jM+Tc34FBhK2b5c+6hwa/zcGzoZsznahRYR6zxxbOvhmixL
        t/KoRN7d+e2FqPNq5w2Bia++duMyoKE=
X-Google-Smtp-Source: ABdhPJyFF5iJFFbfCWGaRR3QcZ+KQPaqvYTW7x9fxJWcW7cBKEpHM2mcX8QGgZXdA5E/+SQgtymgew==
X-Received: by 2002:a62:7705:: with SMTP id s5mr11325869pfc.52.1596781493943;
        Thu, 06 Aug 2020 23:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.44])
        by smtp.gmail.com with ESMTPSA id w130sm12288895pfd.104.2020.08.06.23.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 23:24:53 -0700 (PDT)
Subject: Re: [PATCH 1/2] ext4: rename journal_dev to s_journal_dev inside
 ext4_sb_info
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <74c2a122-5a6c-ac97-614a-043038d61623@gmail.com>
 <20200807050556.GT7657@mit.edu>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <8d9aba02-82a2-9361-1e5c-15999b30f686@gmail.com>
Date:   Fri, 7 Aug 2020 14:24:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807050556.GT7657@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry, it seems that I forgot to disable the HTML composent mode after
reinstalling thunderbird. Check whether the patch I re-send later is
normal. If it is normal, I re-send other patches. I am very sorry.

tytso@mit.edu wrote on 2020/8/7 13:05:
> On Wed, Jul 29, 2020 at 02:19:20PM +0800, brookxu wrote:
>> Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
>> the naming rules consistent with other variables, which is
>> convenient for code reading and writing.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> This patch series is badly white-space damaged.  Can you please resend
> it using a different e-mail client which doesn't mangle whitespace?
> 
> Please see:
> 
> https://www.kernel.org/doc/html/latest/process/email-clients.html
> 
> 						- Ted
> 
